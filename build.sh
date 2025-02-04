#!/usr/bin/env bash

set -e

container_name="localhost/bootc-test"

sudo podman build -f Containerfile -t "$container_name"

sudo rm -rf output/*
sudo podman run \
    --rm \
    -it \
    --privileged \
    --pull=newer \
    --security-opt label=type:unconfined_t \
    -v ./output:/output \
    -v /var/lib/containers/storage:/var/lib/containers/storage \
    quay.io/centos-bootc/bootc-image-builder:latest \
    --type qcow2 \
    --local \
    "$container_name"
