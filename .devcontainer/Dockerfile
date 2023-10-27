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
