#!/bin/bash

FILE=".version"
v=''
if [ -f $FILE ]; then
  while IFS= read -r line
  do
    v="$line"
  done < "$FILE"
fi

if [[ $# -eq 0 ]] ; then
  new_v="${v%.*}.$((${v##*.}+1))"
else
  new_v=$1
fi
echo "Building version $new_v"
echo $new_v > $FILE

  # --build-arg USERNAME=$USER $2 \


IMAGE_NAME='hitheory/theory-vim'
docker build \
  -t $IMAGE_NAME \
  --build-arg USER_ID=$(id -u ${USER}) \
  --build-arg GROUP_ID=$(id -g ${USER}) \
  . || exit 1;
docker tag $IMAGE_NAME $IMAGE_NAME:v$1 || exit 1;
docker tag $IMAGE_NAME $IMAGE_NAME:latest || exit 1;
docker push $IMAGE_NAME:v$1 || exit 1;
docker push $IMAGE_NAME:latest || exit 1;
echo "Built and tagged version $new_v"
