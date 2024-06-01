
#!/bin/bash
nix-shell -p libcap go gcc
bash ./scripts/build.sh