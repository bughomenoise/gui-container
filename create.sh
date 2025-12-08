#!/bin/sh

mkdir -p ~/.local/share/applications;

PREFIX="gui-container_"
CONTAINER_NAME=$1;
CONTAINER_IMAGE=$2;
APP_START_COMMAND=$3;
EXTRA_FLAG="${@:4}";
CONTAINER_HOME="${HOME}/.gui-container/home/${CONTAINER_NAME}"
mkdir -p "${CONTAINER_HOME}/.xdg-runtime/pulse" &&
podman create --userns=keep-id \
-e "XDG_RUNTIME_DIR=${HOME}/.xdg-runtime" \
-e "DISPLAY=${DISPLAY}" \
-v "/tmp/.X11-unix:/tmp/.X11-unix" \
-v "${XDG_RUNTIME_DIR}/pulse/native:${HOME}/.xdg-runtime/pulse/native:U" \
--device /dev/dri \
-v "${CONTAINER_HOME}:${HOME}:U" \
-e "HOME=${HOME}" ${EXTRA_FLAG} \
--name "${CONTAINER_NAME}" \
"${CONTAINER_IMAGE}" "${APP_START_COMMAND}" &&
printf "[Desktop Entry]\nName=%s\nExec=podman start %s\nType=Application" "${CONTAINER_NAME} (GUI-CONTAINER)" "${CONTAINER_NAME}" \
> "${HOME}/.local/share/applications/${PREFIX}${CONTAINER_NAME}.desktop"

