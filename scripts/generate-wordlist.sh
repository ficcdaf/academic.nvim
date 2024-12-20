#!/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
unmunch <(curl -s https://raw.githubusercontent.com/emareg/acamedic/refs/heads/master/en-Academic.dic) \
  <(curl -s https://raw.githubusercontent.com/emareg/acamedic/refs/heads/master/en-Academic.aff) \
  >"$SCRIPT_DIR/../words/en-academic"
