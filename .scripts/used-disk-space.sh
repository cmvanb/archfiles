#!/bin/sh

for file in $(ls);
do
    du -sh ${file}
done

