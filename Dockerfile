FROM ubuntu:latest

# Installer les utilitaires nécessaires
RUN apt-get update && apt-get install -y \
    libxml2-utils \
    xsltproc \
    wget \
    openjdk-17-jre \
    git \
    make \
    && apt-get clean

# Télécharger et installer saxon-lint
RUN git clone https://github.com/sputnick-dev/saxon-lint.git /opt/saxon-lint && \
    cd /opt/saxon-lint && make && make install

CMD ["/bin/bash"]
