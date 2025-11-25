# How to use
### requirements
- os: linux_x86-64.
- gpu: amd or intel or nvidia.
- rootless container *recommend podman.
- X11 socket *if you use wayland, enable Xwayland.
- pulseaudio socket *if you use pipewire, enable pipewire-pulse.

### examples
<details>
<summary>Firefox</summary>

```sh
# create directory for firefox
mkdir -p ~/{.mozilla,Downloads}

# create container (run first time)
podman run -it \
-e "XDG_RUNTIME_DIR=/tmp" \
-e "DISPLAY=${DISPLAY}" \
-v "/tmp/.X11-unix:/tmp/.X11-unix" \
-v "${XDG_RUNTIME_DIR}/pulse/native:/tmp/pulse/native" \
--device /dev/dri \
-v "${HOME}/.mozilla:/root/.mozilla" \
-v "${HOME}/Downloads:/root/Downloads" \
--name firefox \
docker.io/bughomenoise/gui-container:base firefox

# run after create container
podman start firefox &
```

</details>

<details>
<summary>Android-Studio</summary>

```sh
# create directory for android-studio
mkdir -p ~/{.gradle,Android,.android,AndroidStudioProjects}

# create container (run first time)
podman run -it \
-e "XDG_RUNTIME_DIR=/tmp" \
-e "DISPLAY=${DISPLAY}" \
-v "/tmp/.X11-unix:/tmp/.X11-unix" \
-v "${XDG_RUNTIME_DIR}/pulse/native:/tmp/pulse/native" \
--device /dev/dri \
-v "${HOME}/.gradle:/root/.gradle" \
-v "${HOME}/Android:/root/Android" \
-v "${HOME}/.android:/root/.android" \
-v "${HOME}/AndroidStudioProjects:/root/AndroidStudioProjects" \
--name android-studio \
docker.io/bughomenoise/gui-container:android-studio android-studio

# run after create container
podman start android-studio &
```

</details>
