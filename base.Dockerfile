FROM --platform=linux/amd64 archlinux:multilib-devel

RUN touch /etc/default/locale
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN locale-gen

#create user
RUN echo 'root ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
ARG username="guicontainer"
RUN useradd -m -u 9999 -G wheel ${username}
RUN echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
RUN passwd -d ${username}

#package manager
RUN pacman -Syyu --noconfirm
ARG i_flag="-Sy --noconfirm --needed"
ARG pacman_i="pacman ${i_flag}"
ARG aur_path="/home/${username}/aur-install"
ARG aur_cmd="yay"
ARG aur_i="sudo -u ${username} -- ${aur_cmd} ${i_flag}"
RUN ${pacman_i} git base-devel
RUN sudo -u ${username} -- git clone https://aur.archlinux.org/${aur_cmd}.git ${aur_path}
RUN cd ${aur_path} && sudo -u ${username} -- makepkg -si --noconfirm
RUN rm -rf ${aur_path}
RUN sudo -u ${username} -- ${aur_cmd} -Syu --noconfirm

#theme
RUN ${pacman_i} materia-gtk-theme
ARG gtk3d="/etc/gtk-3.0"
ARG gtk3f="${gtk3d}/settings.ini"
RUN mkdir -p ${gtk3d};
RUN echo "[Settings]" > ${gtk3f};
RUN echo "gtk-theme-name = Materia-dark" >> ${gtk3f};
RUN echo "gtk-application-prefer-dark-theme = true" >> ${gtk3f}

#video
RUN ${pacman_i} libva-mesa-driver mesa lib32-mesa mesa-utils opencl-mesa lib32-opencl-mesa
RUN ${pacman_i} vulkan-radeon lib32-vulkan-radeon
RUN ${pacman_i} xorg-server xorg-xinit libxkbcommon libxkbcommon-x11 lib32-libxkbcommon lib32-libxkbcommon-x11 wayland
## xe fixed
RUN ${pacman_i} intel-media-driver

#audio
RUN ${pacman_i} pulseaudio

#font
RUN ${pacman_i} fontconfig noto-fonts gnu-free-fonts ttf-liberation

#lib
RUN ${pacman_i} libxkbfile libbsd

#app
RUN ${pacman_i} curl vi helix openssh firefox chromium cloudflared steam bitwarden obs-studio blender	wezterm fish zsh
RUN ${aur_i} librewolf-bin herdr-bin pi-bin claude-code antigravity-cli 
