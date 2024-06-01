#!/bin/bash
bash ./scripts/copy-over.sh
sudo nixos-rebuild  --show-trace --install-bootloader boot