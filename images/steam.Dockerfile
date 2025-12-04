FROM --platform=linux/amd64 bughomenoise/gui-container:latest

RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm steam
