#!/bin/bash

./scripts/build.sh $1 $2
docker tag $1 $1
docker push $1
