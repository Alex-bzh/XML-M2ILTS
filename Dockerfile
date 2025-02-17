FROM ubuntu:latest

# Installer les utilitaires nécessaires
RUN apt-get update && apt-get install -y \
    libxml2-utils \
    xsltproc \
    wget \
    openjdk-17-jre \
    git \
    && apt-get clean

# Installer saxon-lint
RUN mkdir -p ~/lib && cd ~/lib && \
    git clone https://github.com/sputnick-dev/saxon-lint.git && \
    chmod +x ~/lib/saxon-lint/saxon-lint.pl && \
    echo 'export PATH=$PATH:~/lib/saxon-lint' >> ~/.bashrc && \
    echo "alias saxon-lint='saxon-lint.pl'" >> ~/.bashrc

CMD ["/bin/bash"]
