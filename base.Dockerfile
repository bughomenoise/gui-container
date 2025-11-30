FROM --platform=linux/amd64 archlinux:latest

RUN pacman -Sy --noconfirm

#video
RUN pacman -S --noconfirm libva-mesa-driver mesa
RUN pacman -S --noconfirm intel-media-driver libva-intel-driver vulkan-intel xf86-video-intel
RUN pacman -S --noconfirm vulkan-radeon xf86-video-amdgpu
RUN pacman -S --noconfirm vulkan-nouveau xf86-video-nouveau
RUN pacman -S --noconfirm xorg-server xorg-xinit

#audio
RUN pacman -S --noconfirm pipewire pipewire-alsa pipewire-pulse

#aur
RUN pacman -S --noconfirm --needed git base-devel
ARG username="arch"
ARG paru_path="/home/${username}/paru"
RUN echo "${username} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN useradd -m -G wheel,users,kvm,render,video,audio ${username} && passwd -d ${username}
RUN sudo -u ${username} -- git clone https://aur.archlinux.org/paru-bin.git ${paru_path}
RUN cd ${paru_path} && sudo -u arch -- makepkg -si --noconfirm
RUN rm -rf ${paru_path}

#font
RUN pacman -S --noconfirm fontconfig noto-fonts gnu-free-fonts ttf-liberation

#lib
RUN pacman -S --noconfirm libxkbfile libbsd

#app
RUN pacman -S --noconfirm firefox chromium vim wget
