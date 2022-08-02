#!/bin/bash

for i in `cat extensions.txt`
do
    echo "installing: ${i}..."
    code --install-extension ${i}
done