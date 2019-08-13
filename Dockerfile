FROM ubuntu:latest as intermediate

ARG USER_ID
ARG GROUP_ID

RUN groupadd -g ${GROUP_ID} thekevinscott &&\
    useradd -l -u ${USER_ID} -g thekevinscott thekevinscott &&\
    install -d -m 0755 -o thekevinscott -g thekevinscott /home/thekevinscott

RUN apt-get -yq update
RUN apt-get -yqq install ssh
RUN apt-get -y install git

ARG SSH_PRIVATE_KEY
RUN mkdir -p /root/.ssh
RUN echo "${SSH_PRIVATE_KEY}" > /root/.ssh/id_rsa
RUN chmod 400 /root/.ssh/id_rsa
RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

COPY init.vim /root/.config/nvim/init.vim
# RUN git clone git@github.com:thekevinscott/dotfiles.git \
# && mv dotfiles/dotfiles/.config /root/.config

RUN rm /root/.ssh/id_rsa

FROM ubuntu:latest

COPY --from=intermediate /root /root

MAINTAINER docker@thekevinscott.com

RUN apt-get update -y && \
    apt-get install -y software-properties-common && \
    apt-add-repository -y ppa:neovim-ppa/stable && \
    apt-add-repository -y ppa:longsleep/golang-backports && \
    apt-get update -y

RUN apt-get install -y \
    curl \
    git \
    neovim \
    build-essential \
    patch \
    ruby-dev \
    zlib1g-dev \
    liblzma-dev \
    golang-go

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
RUN pip3 install neovim flake8 autopep8 python-language-server neovim-remote

# RUN gem install --no-document etc json rubocop solargraph

RUN apt-get install -y \
    npm

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -y
RUN apt-get install -y yarn
RUN npm install --global eslint prettier typescript typescript-language-server dockerfile-language-server-nodejs
RUN go get golang.org/x/lint/golint && go get golang.org/x/tools/cmd/gopls

RUN npm install --global textlint textlint-rule-preset-ja-technical-writing textlint-rule-spellcheck-tech-word

RUN curl -fLo /root/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

RUN nvim +PlugInstall +qall

WORKDIR /src
RUN chown --changes --silent --no-dereference --recursive --from=33:33 ${USER_ID}:${GROUP_ID} /src

ENTRYPOINT ["nvim"]
