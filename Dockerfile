FROM ubuntu:20.04
MAINTAINER docker@thekevinscott.com
ENV DEBIAN_FRONTEND noninteractive

ARG USERNAME
ARG USER_ID
ARG GROUP_ID

# RUN groupadd -g ${GROUP_ID} ${USERNAME} &&\
#     useradd -l -u ${USER_ID} -g ${USERNAME} ${USERNAME} &&\
#     install -d -m 0755 -o ${USERNAME} -g ${USERNAME} /home/${USERNAME}



######### System files #########
RUN apt-get update && \
    apt-get install -y \
    software-properties-common \
    curl \
    git \
    less \
    build-essential \
    patch \
    ruby-dev \
    zlib1g-dev \
    liblzma-dev \
    golang-go \
    wget \
    zip \
    ssh \
    libsm6 \
    libxext6 \
    libxrender-dev \
    unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
# RUN apt-get -yqq install ssh

######### Neovim #########
# RUN apt-add-repository -y ppa:neovim-ppa/stable && \
#     apt-add-repository -y ppa:longsleep/golang-backports
# RUN apt-get update && \
#     apt-get install -y \
#     neovim
RUN apt-get update && apt-get install -y python3-neovim

######### Node and NPM #########
RUN apt-get install -y nodejs npm && \
    curl -o- -L https://yarnpkg.com/install.sh | bash && \
    npm install --global \
    n \
    eslint \
    prettier \
    typescript \
    typescript-language-server \
    dockerfile-language-server-nodejs \
    textlint \
    textlint-rule-preset-ja-technical-writing \
    textlint-rule-spellcheck-tech-word && \
    n 12.18.3

######### Python #########
RUN apt-get install -y python3-pip && \
    pip3 install \
    neovim \
    flake8 \
    autopep8 \
    python-language-server \
    neovim-remote \
    virtualenv \
    virtualenvwrapper

######### User Permissions #########
RUN mkdir /src && \
    mkdir -p /home/vim-user/.config/nvim && \
    groupadd -g ${GROUP_ID} vim-group && \
    useradd -l -u ${USER_ID} -g vim-group vim-user && \
    install -d -m 0755 -o vim-user -g vim-group /home/vim-user && \
    chown --changes --silent --no-dereference --recursive \
          --from=0:0 ${USER_ID}:${GROUP_ID} /src /home/vim-user

USER vim-user

######### Configuration #########
WORKDIR /src
COPY init.vim /home/vim-user/.config/nvim/init.vim
RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
    mkdir -p ~/.config/nvim/plugged && \
    nvim --headless +PlugInstall +qall

ENTRYPOINT ["nvim"]
