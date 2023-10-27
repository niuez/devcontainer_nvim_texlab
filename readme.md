# devcontainer\_nvim\_texlab

devcontainerでneovimを使う試みとして、LaTeX環境を作成してみた。

## 準備

- [devcontainer cli](https://github.com/devcontainers/cli)
- nvimのバイナリをnvim volumeに突っ込む(後述)
    - TODO: いい感じのスクリプトを書いてくれよ

## 実行

```
devcontainer up --workspace-folder .
devcontainer exec --workspace-folder . bash
```

あとは`latexmk -pvc`でいいかんじに

## Dockerfile

- texlive日本語環境をpull
- git
- [texlab(language server)](https://github.com/latex-lsp/texlab)
    - アーキテクチャを適宜設定
- locale設定

```dockerfile
FROM paperist/texlive-ja:latest

RUN apt-get update && apt-get install -y \
    git \
    locales \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/latex-lsp/texlab/releases/download/v5.10.1/texlab-aarch64-linux.tar.gz -O texlab.tar.gz \
  && tar xvf texlab.tar.gz \
  && mkdir /texlab \
  && mv texlab /texlab

ENV PATH="/texlab:${PATH}"

RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG="en_US.UTF-8" \
    LANGUAGE="en_US:en" \
    LC_ALL="en_US.UTF-8"

CMD ["bash"]
```

## docker-compose.yml

- '.devcontainer/nvim'にnvimの設定ファイル
- 'nvim' volume: 後述

```yml
version: "3"
services:
  ubuntu-texlive-ja:
    build: .
    command: sleep infinity
    volumes:
      - ../:/workdir
      - ./.latexmkrc:/root/.latexmkrc
      - ./nvim:/root/.config/nvim
      - nvim:/nvim
    environment:
      SHELL: "/bin/bash"
volumes:
  nvim:
    name: nvim
```

## nvim volume

ここにnvimのバイナリを入れておく
    - `x86_64`なら、https://github.com/neovim/neovim/releases
    - `aarch64`なら、https://github.com/matsuu/neovim-aarch64-appimage/releases

入れ方(例): bashで入って中で作業する

```sh
devcontainer exec --workspace-folder . bash
cd /nvim
wget <tar.gz file>
tar xvf <tar.gz file>
...
```

### 背景

VSCodeの`Open Folder in Container`の機能は、VSCodeのサーバーを`vscode` volumeに突っ込んでおくことで永続化している。毎回環境にneovimをインストールするスクリプトをdockerfileに書くのは、ちょっと違う気がしてこのような手法を取りました。
