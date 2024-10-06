#!/bin/bash
# {{ ansible_managed }}

set -euo pipefail

if grep -q "^caddy .* \*\*CONFIGURE\*\*$"; then
    caddy upgrade
fi
