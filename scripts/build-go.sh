#!/bin/bash
cd ./src/host_daemon
echo "building host daemon"
go build -o passthrough_host_daemon
cd ../