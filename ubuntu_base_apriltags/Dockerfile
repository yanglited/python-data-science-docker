FROM ubuntu:jammy as base

RUN apt-get update && \
    apt-get install -y \
    locales \
    build-essential \
    ffmpeg \
    libsm6 \
    libxext6 \
    ca-certificates \
    gnupg \
    git \
    wget \
    curl \
    cmake \
    ninja-build \
    ripgrep \
    gettext \
    unzip

RUN apt-get update && \
    apt-get install -y \
    python3.11 \
    python3.11-venv \
    python3.11-dev

RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1
RUN ln -s /usr/bin/python3 /usr/bin/python
RUN apt-get install -y python3-pip

# IDE: neovim related
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV TERM screen-256color
RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | \
    gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | \
    tee /etc/apt/sources.list.d/nodesource.list
RUN apt-get update && apt-get install nodejs -y
RUN git clone https://github.com/neovim/neovim.git
WORKDIR /neovim
RUN make CMAKE_BUILD_TYPE=Release
RUN make install
RUN git clone https://github.com/yanglited/nvim.yang /root/.config/nvim

FROM base as apriltag3_version
WORKDIR /apriltag3

COPY requirements.apriltag3.txt .
RUN  pip install --no-cache-dir -r requirements.apriltag3.txt

RUN git clone https://github.com/AprilRobotics/apriltag.git
RUN cd apriltag && \
    cmake -B build -DCMAKE_BUILD_TYPE=Release && \
    cmake --build build --target install
ENV LD_LIBRARY_PATH=/usr/local/lib/

WORKDIR /app


FROM base as pip_version
COPY requirements.pip_version.txt .
RUN  pip install --no-cache-dir -r requirements.pip_version.txt

WORKDIR /app
