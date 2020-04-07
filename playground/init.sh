#!/bin/bash
@Echo off

echo Initialising...

cd /tmp
daml new playground_project
mkdir -p /root/playground_project
mv playground_project/* /root/playground_project/
cd /root

echo Done!
