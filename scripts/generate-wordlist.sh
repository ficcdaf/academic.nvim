#!/bin/env bash

curl https://raw.githubusercontent.com/emareg/acamedic/refs/heads/master/en-Academic.aff >en-Academic.aff
curl https://raw.githubusercontent.com/emareg/acamedic/refs/heads/master/en-Academic.dic >en-Academic.dic
unmunch en-Academic.dic en-Academic.aff >en-academic
rm en-Academic*
