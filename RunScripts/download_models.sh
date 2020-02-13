#!/bin/bash
# Copyright 2019 The TensorFlow Authors. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ==============================================================================

set -ex

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODELS_URL="https://storage.googleapis.com/download.tensorflow.org/models/tflite/text_classification/text_classification.tflite"
DOWNLOADS_DIR=$(mktemp -d)

cd $SCRIPT_DIR

download_and_extract() {
  local usage="Usage: download_and_extract URL DIR"
  local url="${1:?${usage}}"
  local dir="${2:?${usage}}"
  echo "downloading ${url}" >&2
  mkdir -p "${dir}"

  curl -L ${url} > ${dir}/text_classification.tflite
}

if [ -f ../TextClassification/Model/mobilenet_quant_v1_224.tflite ]
then
echo "File exists. Exiting..."
exit 0
fi

download_and_extract "${MODELS_URL}" "${DOWNLOADS_DIR}/models"

file ${DOWNLOADS_DIR}/models

cp ${DOWNLOADS_DIR}/models/* ../TextClassification/Model
