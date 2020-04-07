#!/bin/bash

daml new tmp_proj
mv tmp_proj/* playground_project
rm -r tmp_proj
