FROM archlinux:latest

RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm base-devel
RUN pacman -S --noconfirm \
    python \
    python-pip \
    neovim \
    python-neovim \
    xclip \
    npm \
    unzip \
    git \
    alacritty \
    bash-completion \
    less \
    lua \
    ncdu \
    htop \
    btop \
    ranger \
    ripgrep \
    fzf \
    cmake \
    tree \
    tmux \
    wget \
    neofetch
RUN npm install -g neovim

RUN pacman -S --noconfirm \
    python-scikit-learn=1.3.2-2 \
    python-opencv=4.8.1-4 \
    python-numpy=1.26.2-1

WORKDIR /root
RUN mkdir -p .config/nvim
RUN git clone https://github.com/yanglited/nvim.yang.git .config/nvim

WORKDIR /app
