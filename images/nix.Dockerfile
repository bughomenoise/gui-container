FROM nixos/nix:latest

RUN echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf

RUN nix-channel --update
RUN nix-env -i vim
RUN nix-env -i curlFull
