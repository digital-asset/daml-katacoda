#!/bin/bash

cd $HOME
echo "installing fabric" >> $HOME/.test
curl -sSL https://bit.ly/2ysbOFE | bash -s -- 2.1.0 -s
echo "finished installing fabric" >> $HOME/.test