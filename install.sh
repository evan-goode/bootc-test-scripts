#!/usr/bin/env bash

sudo virsh destroy bootc
sudo virsh undefine bootc

sudo cp output/qcow2/disk.qcow2 /var/lib/libvirt/images/bootc.qcow2

sudo virt-install \
    --name bootc \
    --cpu host \
    --vcpus 4 \
    --memory 4096 \
    --import --disk /var/lib/libvirt/images/bootc.qcow2,format=qcow2 \
    --os-variant centos-stream9
