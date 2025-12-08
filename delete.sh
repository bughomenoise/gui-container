#!/bin/sh


rm "${HOME}/.local/share/applications/gui-container_${1}.desktop" &&
podman rm "$1"
