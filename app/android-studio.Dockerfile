FROM --platform=linux/amd64 bughomenoise/gui-container:base

#app
RUN sudo -u arch -- paru -Sy --noconfirm android-studio jdk-openjdk
