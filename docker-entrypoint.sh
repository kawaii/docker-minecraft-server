#!/usr/bin/env bash
set -euo pipefail

echo 'eula=true' > /opt/minecraft/eula.txt

exec "$@"
