FROM ubuntu:latest

MAINTAINER docker@thekevinscott.com

RUN apt-get update -y && \
    apt-get install -y software-properties-common && \
    apt-add-repository -y ppa:neovim-ppa/stable && \
    apt-add-repository -y ppa:longsleep/golang-backports && \
    apt-get update -y && \
    apt-get install -y \
    curl \
    git \
    neovim \
    python-dev \
    python-pip \
    python3-dev \
    python3-pip \
    build-essential \
    patch \
    ruby-dev \
    zlib1g-dev \
    liblzma-dev \
    golang-go \
    nodejs \
    npm

RUN pip3 install --upgrade pip neovim flake8 autopep8 python-language-server neovim-remote && \
    gem install --no-document etc json rubocop solargraph && \
    npm install --global eslint prettier typescript typescript-language-server dockerfile-language-server-nodejs && \
    go get golang.org/x/lint/golint && \
    go get golang.org/x/tools/cmd/gopls

RUN npm install --global textlint textlint-rule-preset-ja-technical-writing textlint-rule-spellcheck-tech-word

RUN curl -fLo /root/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

RUN cd /root \
&& git clone https://github.com/thekevinscott/theory-vim.git \
&& git checkout aa99c5a43b88608683d7f45814c9610490238b3f \
&& mv theory-vim/.config .config

RUN nvim +PlugInstall +qall

WORKDIR /src

ENTRYPOINT ["nvim"]
