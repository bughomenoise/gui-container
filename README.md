# What is This?
- just archlinux container pre-install graphic & audio packages.
---

### Why
- just limit resources.
---

### Requirements
- git.
- os: linux_x86-64.
- user: need subuid, subgid
- gpu: amd or intel or nvidia.
- podman rootless container.
- X11 socket.
- pulse socket.

> [!WARNING]  
> "gui-container create-container" command automatic add --shm-size=512m flag!
---

### How to use

##### Create Dockerfile
```Dockerfile
FROM platform=linux/amd64 docker.io/bughomenoise/guicontainer:latest

# install archlinux package.
RUN pacman -Sy noconfirm <archlinux_package_name>

# install AUR package.
RUN sudo -u avoiduser -- paru Sy noconfirm <aur_package_name>
```

##### Build Image
```sh
podman build -t <tag_name> -f <dockerfile_path>
```

```sh
git clone github.com/bughomenoise/gui-container
cd gui-container


### add completion ###
source ./completion

### create container ###
# this command create.
# 1.container-home-directory # ~/.gui-contaner/<container-name>.
# 2.podman container.
./gui-container create-container <image_name> <gui_app_command> <container-name> <podman_extra_flag_***optional***>

### run with command (also run with app luncher) ###
# podman start <container_name>
podman start librewolf-desktop


### delete container-home-directory ###
./gui-container delete-home <container_name>

### delete entry ###
./gui-container delete-entry <container_name>

### delete container ###
podman rm <container_name>

```

<details>
<summary>Install Package</summary>

```sh
# exec into container.
podman exec -it <container_name> bash 

## then install package inside container.

# install archlinux package.
sudo pacman -Sy <archlinux_package_name>

# install AUR package.
yay -Sy <aur_package_name>
```

</details>
