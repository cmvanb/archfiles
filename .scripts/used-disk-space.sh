#!/usr/bin/env bash

for file in $(ls);
do
    du -sh ${file}
done

