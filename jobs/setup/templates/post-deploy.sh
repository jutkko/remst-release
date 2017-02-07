#!/bin/bash -e

[ -z "$DEBUG" ] || set -x

PATH=/var/vcap/jobs/setup/bin:$PATH

add-to-path
