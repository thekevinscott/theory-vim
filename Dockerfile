FROM ubuntu:latest
MAINTAINER docker@thekevinscott.com

ARG USERNAME
ARG USER_ID
ARG GROUP_ID

RUN groupadd -g ${GROUP_ID} ${USERNAME} &&\
    useradd -l -u ${USER_ID} -g ${USERNAME} ${USERNAME} &&\
    install -d -m 0755 -o ${USERNAME} -g ${USERNAME} /home/${USERNAME}

######### System files #########
RUN apt-get update -y && \
    apt-get install -y \
    software-properties-common \
    curl \
    git \
    build-essential \
    patch \
    ruby-dev \
    zlib1g-dev \
    liblzma-dev \
    golang-go
RUN apt-get -yqq install ssh

######### Neovim #########
RUN apt-add-repository -y ppa:neovim-ppa/stable && \
    apt-add-repository -y ppa:longsleep/golang-backports && \
    apt-get update -y && \
    apt-get install -y \
    neovim

######### Node and NPM #########
RUN apt-get install -y npm
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -y
RUN apt-get install -y yarn
RUN npm install --global eslint prettier typescript typescript-language-server dockerfile-language-server-nodejs
RUN npm install --global textlint textlint-rule-preset-ja-technical-writing textlint-rule-spellcheck-tech-word

######### Python #########
# RUN add-apt-repository ppa:deadsnakes/ppa && \
#     apt-get update -y && \
#     apt-get install python3.8 && \
#     apt-get install python3.8-dev && \
#     apt-get install python3.8-distutils && \

RUN add-apt-repository ppa:jonathonf/python-3.6 && \
    apt-get update -y && \
    apt-get install -y \
    python-dev \
    python-pip \
    python3.6-dev \
    python3-pip
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.5 1
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 2
RUN pip3 install --upgrade pip
RUN pip3 install \
    neovim \
    flake8 \
    autopep8 \
    python-language-server \
    neovim-remote \
    virtualenv \
    virtualenvwrapper

######### Configuration #########
RUN apt-get install -y less
USER ${USERNAME}
WORKDIR /src
RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN mkdir -p ~/.config/nvim/plugged
COPY init.vim /home/${USERNAME}/.config/nvim/init.vim
RUN nvim +PlugInstall +qall

ENTRYPOINT ["nvim"]
