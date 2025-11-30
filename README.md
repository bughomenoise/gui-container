# What is This?
- just archlinux container pre-install graphic & audio packages.
---

### Why
- just limit resource.
---

### Requirements
- os: linux_x86-64.
- gpu: amd or intel or nvidia.
- rootless container *recommend podman.
- X11 socket *if you use wayland, enable Xwayland.
- pulseaudio socket *if you use pipewire, enable pipewire-pulse.
---

### Examples

<details>
<summary>Run GUI App</summary>

```sh
export GUI_CONTAINER_NAME_TMP="<container_name>"
export GUI_CONTAINER_HOME_TMP=$HOME/.gui-container/home/$GUI_CONTAINER_NAME_TMP
mkdir -p $GUI_CONTAINER_HOME_TMP

# create container (run first time)
podman run -it --userns=keep-id \
-e "XDG_RUNTIME_DIR=/tmp" \
-e "DISPLAY=${DISPLAY}" \
-v "/tmp/.X11-unix:/tmp/.X11-unix" \
-v "${XDG_RUNTIME_DIR}/pulse/native:/tmp/pulse/native" \
--device /dev/dri \
-v "${GUI_CONTAINER_HOME_TMP}:${HOME}:U" \
-e "HOME=${HOME}" \
--name $GUI_CONTAINER_NAME_TMP \
docker.io/bughomenoise/gui-container:latest "<gui_app_command>"

# run after create container
podman start <container_name>
```

</details>

<details>
<summary>Install Package With Dockerfile</summary>

##### Create Dockerfile
```Dockerfile
FROM --platform=linux/amd64 docker.io/bughomenoise/gui-container:latest

# archlinux package
RUN pacman -Sy --noconfirm <archlinux_package_name>

# AUR
RUN sudo -u arch -- paru -Sy --noconfirm <aur_package_name>
```

##### Build Image
```sh
podman build -t <tag_name> -f <dockerfile_path>
```

</details>

<details>
<summary>Install Package After Create Container</summary>

```sh
# exec into container with arch user
podman exec --user arch -it <container_name> bash 

## then install package inside container

# archlinux package
sudo pacman -Sy <archlinux_package_name>

# AUR
paru -Sy <aur_package_name>
```

</details>
