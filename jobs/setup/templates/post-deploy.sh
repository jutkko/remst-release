#!/bin/bash -e

[ -z "$DEBUG" ] || set -x

PATH=$PATH:/var/vcap/jobs/setup/bin

add-to-path
