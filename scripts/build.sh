#!/bin/bash

docker build -t $1 --build-arg USER_ID=$(id -u ${USER}) --build-arg GROUP_ID=$(id -g ${USER}) $2 .

# docker build -t hitheory/vim:0.25 --squash --build-arg SSH_PRIVATE_KEY=(cat ~/.ssh/id_rsa)  .;
