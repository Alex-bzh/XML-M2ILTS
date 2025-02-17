FROM ubuntu:latest

ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

# Installer les utilitaires nécessaires
RUN apt-get update && apt-get install -y \
    default-jre \
    default-jdk \
    libxml2 \
    libxml2-dev \
    libxml-libxml-perl \
    libwww-perl \
    liblwp-protocol-https-perl \
    perl \
    xsltproc \
    git \
    wget \
    && apt-get clean

RUN python3 -m pip install --no-cache-dir notebook jupyterlab


# Installer saxon-lint
RUN mkdir -p ~/lib && cd ~/lib && \
    git clone https://github.com/sputnick-dev/saxon-lint.git && \
    chmod +x ~/lib/saxon-lint/saxon-lint.pl && \
    echo 'export PATH=$PATH:~/lib/saxon-lint' >> ~/.bashrc && \
    echo "alias saxon-lint='saxon-lint.pl'" >> ~/.bashrc

CMD ["/bin/bash"]
