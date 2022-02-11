#!bin/bash

# force Xorg to use a specific config and run in background
Xvfb :0 &

# Sleep
sleep 0.5

# Check if wee have arguments
if [ $# -eq 0 ]; then
  echo "No arguments supplied"
  exit 1
fi

response=$($@)

doneat=$(date)

echo "::set-output name=doneat::$doneat::set-output name=mwb-response::$response"