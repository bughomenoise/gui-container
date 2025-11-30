FROM --platform=linux/amd64 docker.io/bughomenoise/gui-container:latest

#LANG
RUN pacman -Sy --noconfirm jdk-openjdk
RUN pacman -Sy --noconfirm rustup
RUN pacman -Sy --noconfirm npm
RUN pacman -Sy --noconfirm go
RUN pacman -Sy --noconfirm python
RUN sudo -u arch -- paru -Sy --noconfirm bun-bin


#IDE
RUN sudo -u arch -- paru -Sy --noconfirm android-studio
RUN sudo -u arch -- paru -Sy --noconfirm visual-studio-code-bin
RUN sudo -u arch -- paru -Sy --noconfirm antigravity
RUN sudo -u arch -- paru -Sy --noconfirm zed
