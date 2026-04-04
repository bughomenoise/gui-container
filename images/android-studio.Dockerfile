FROM docker.io/bughomenoise/gui-container

ARG username="guicontainer"
ARG aur_cmd="yay"

RUN sudo -u ${username} -- ${aur_cmd} -Syu --noconfirm

RUN sudo -u ${username} -- ${aur_cmd} -S --noconfirm android-studio
