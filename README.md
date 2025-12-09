# What is This?
- just archlinux container pre-install graphic & audio packages.
---

### Why
- just limit resources.
---

### Requirements
- os: linux_x86-64.
- gpu: amd or intel or nvidia.
- git.
- podman rootless container.
- X11 socket *if you use wayland, enable Xwayland.
- pulseaudio socket *if you use pipewire, enable pipewire-pulse.

> [!WARNING]  
> don't run with `USER: avoid-user`, `UID: 9999` might be fs_owner bug.
---

### How to use

```sh
git clone github.com/bughomenoise/gui-container
cd gui-container

### add completion ###
source ./completion # Optional.

### create container ###
# this command create.
# 1.container home directory # ~/.gui-contaner/<container-name>.
# 2.desktop entry file # ~/.local/share/applications.
# 3.podman container.
# ./gui-container create <image_name> <gui_app_command> <container-name> <podman_extra_flag>
./gui-container docker.io/bughomenoise/gui-container:latest librewolf librewolf-desktop --cap-drop ALL

### run with command (also run with app luncher) ###
# podman start <container_name>
podman start librewolf-desktop

### delete ###
# (this command not just delete container it delete 1.container, 2.container directory, 3.desktop entry file).
# ./gui-container delete <container_name>
./gui-container delete librewolf-desktop

### update image ###
# podman delete <container_name>
podman delete librewolf-desktop
# recreate use same <container_name> (you can change image* or change extra-flag) *image should support.
./gui-container docker.io/bughomenoise/gui-container:latest librewolf librewolf-desktop --cap-drop ALL

```


<details>
<summary>Custom Dockerfile</summary>

##### Create Dockerfile
```Dockerfile
FROM --platform=linux/amd64 docker.io/bughomenoise/gui-container:latest

# install archlinux package.
RUN pacman -Sy --noconfirm <archlinux_package_name>

# install AUR package.
RUN sudo -u avoid-user -- paru -Sy --noconfirm <aur_package_name>
```

##### Build Image
```sh
podman build -t <tag_name> -f <dockerfile_path>
```

</details>

<details>
<summary>Install Package</summary>

```sh
# exec into container with "avoid-user" user or uid "9999".
podman exec --user avoid-user -it <container_name> bash 

## then install package inside container.

# install archlinux package.
sudo pacman -Sy <archlinux_package_name>

# install AUR package.
paru -Sy <aur_package_name>
```

</details>
