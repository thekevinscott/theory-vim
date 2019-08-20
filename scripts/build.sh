#!/bin/bash

docker build -t $1 --build-arg USER_ID=$(id -u ${USER}) --build-arg GROUP_ID=$(id -g ${USER}) --build-arg USERNAME=$USER $2 .
