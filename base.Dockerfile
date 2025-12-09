FROM --platform=linux/amd64 archlinux:multilib-devel

RUN systemd-machine-id-setup

RUN touch /etc/default/locale
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN locale-gen

#video
RUN pacman -Sy --noconfirm libva-mesa-driver mesa
RUN pacman -S --noconfirm vulkan-intel lib32-vulkan-intel
RUN pacman -S --noconfirm vulkan-radeon lib32-vulkan-radeon
RUN pacman -S --noconfirm vulkan-nouveau lib32-vulkan-nouveau
RUN pacman -S --noconfirm xorg-server xorg-xinit

#audio
RUN pacman -S --noconfirm pipewire pipewire-alsa pipewire-jack pipewire-pulse

#font
RUN pacman -S --noconfirm fontconfig noto-fonts gnu-free-fonts ttf-liberation

#lib
RUN pacman -S --noconfirm libxkbfile libbsd

#create user
ARG username="avoid-user"
RUN useradd -m -u 9999 -G wheel,users,kvm,render,video,audio ${username}
RUN echo "${username} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN echo "root ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN passwd -d ${username}

#aur
ARG paru_path="/home/${username}/paru"
RUN pacman -S --noconfirm --needed git base-devel
RUN sudo -u ${username} -- git clone https://aur.archlinux.org/paru-bin.git ${paru_path}
RUN cd ${paru_path} && sudo -u ${username} -- makepkg -si --noconfirm
RUN rm -rf ${paru_path}


#app
RUN pacman -S --noconfirm vim curl
RUN sudo -u ${username} -- paru -Sy --noconfirm librewolf-bin
RUN sudo -u ${username} -- paru -S --noconfirm ungoogled-chromium-bin

#upgrade
RUN pacman -Syu --noconfirm
RUN sudo -u ${username} -- paru -Syu --noconfirm
