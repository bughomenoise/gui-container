FROM --platform=linux/amd64 bughomenoise/gui-container:latest

#LANG
RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm jdk-openjdk

#IDE
RUN sudo -u arch -- paru -Syu --noconfirm
RUN sudo -u arch -- paru -S --noconfirm android-studio
