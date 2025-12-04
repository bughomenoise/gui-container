FROM --platform=linux/amd64 bughomenoise/gui-container:latest

RUN sudo -u arch -- paru -Syu --noconfirm
RUN sudo -u arch -- paru -Sy --noconfirm bun-bin


