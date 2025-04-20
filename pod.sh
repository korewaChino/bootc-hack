#!/bin/bash

sudo podman run --privileged --pid=host --rm -it -v $PWD/testroot:/testroot --network host ghcr.io/korewachino/bootc-test:latest \
    bootc install to-filesystem /testroot