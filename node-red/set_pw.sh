#!/bin/bash
pw=$(docker run --rm -it \
  --entrypoint node \
  nodered/node-red:latest-12-minimal \
  -e "console.log(require('bcryptjs').hashSync(process.argv[1], 8));"  "${2}")
echo ADMIN_AUTH=${1}:$pw