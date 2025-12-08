# What is This?
- just archlinux container pre-install graphic & audio packages.
---

### Why
- just limit resources.
---

### Requirements
- os: linux_x86-64.
- gpu: amd or intel or nvidia.
- rootless container *recommend podman.
- X11 socket *if you use wayland, enable Xwayland.
- pulseaudio socket *if you use pipewire, enable pipewire-pulse.
---

### How to use

```sh
git clone github.com/bughomenoise/gui-container
cd gui-container

# sh create.sh <container-name> <image_name> <gui_app_command> <podman_extra_flag>
sh create.sh librewolf-gui docker.io/bughomenoise/gui-container:latest librewolf --cap-drop ALL

# run with command
podman start <container_name>
```


<details>
<summary>Install Package With Dockerfile</summary>

##### Create Dockerfile
```Dockerfile
FROM --platform=linux/amd64 docker.io/bughomenoise/gui-container:latest

# archlinux package
RUN pacman -Sy --noconfirm <archlinux_package_name>

# AUR
RUN sudo -u avoid-user -- paru -Sy --noconfirm <aur_package_name>
```

##### Build Image
```sh
podman build -t <tag_name> -f <dockerfile_path>
```

</details>

<details>
<summary>Install Package After Create Container</summary>

```sh
# exec into container with "avoid-user" user or uid "9999"
podman exec --user avoid-user -it <container_name> bash 

## then install package inside container

# archlinux package
sudo pacman -Sy <archlinux_package_name>

# AUR
paru -Sy <aur_package_name>
```

</details>
