FROM --platform=linux/amd64 archlinux:multilib-devel

RUN systemd-machine-id-setup

RUN touch /etc/default/locale
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN locale-gen

RUN pacman -Syu --noconfirm

#create user
RUN echo "root ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
ARG username="guicontainer"
RUN useradd -m -u 9999 -G wheel ${username}
RUN echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN passwd -d ${username}

#aur
ARG aur_path="/home/${username}/aur-install"
ARG aur_cmd="yay"
RUN pacman -S --noconfirm --needed git base-devel
RUN sudo -u ${username} -- git clone https://aur.archlinux.org/${aur_cmd}.git ${aur_path}
RUN cd ${aur_path} && sudo -u ${username} -- makepkg -si --noconfirm
RUN rm -rf ${aur_path}

RUN sudo -u ${username} -- ${aur_cmd} -Syu --noconfirm

#video
RUN pacman -S --noconfirm libva-mesa-driver mesa lib32-mesa
RUN pacman -S --noconfirm vulkan-intel lib32-vulkan-intel
RUN pacman -S --noconfirm vulkan-radeon lib32-vulkan-radeon
RUN pacman -S --noconfirm vulkan-nouveau lib32-vulkan-nouveau
RUN pacman -S --noconfirm xorg-server xorg-xinit

#audio
RUN pacman -S --noconfirm pulseaudio

#font
RUN pacman -S --noconfirm fontconfig noto-fonts gnu-free-fonts ttf-liberation

#lib
RUN pacman -S --noconfirm libxkbfile libbsd

#app
RUN pacman -S --noconfirm firefox neovim curl
RUN sudo -u ${username} -- ${aur_cmd} -S --noconfirm librewolf-bin
