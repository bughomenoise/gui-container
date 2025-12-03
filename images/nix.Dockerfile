FROM nixos/nix:latest

RUN echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf

RUN nix-channel --update
RUN nix-env -iA nixpkgs.git
RUN nix-env -iA nixpkgs.vim
RUN nix-env -iA nixpkgs.curlFull
