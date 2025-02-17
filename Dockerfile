FROM ubuntu:latest

# Installer les utilitaires nécessaires
RUN apt-get update && apt-get install -y \
    libxml2-utils \
    xsltproc \
    wget \
    openjdk-17-jre \
    && apt-get clean

# Télécharger Saxon-HE depuis la source officielle
RUN wget -O /usr/local/bin/saxon.zip \
    https://www.saxonica.com/download/SaxonHE12-4J.zip && \
    unzip /usr/local/bin/saxon.zip -d /usr/local/bin/ && \
    mv /usr/local/bin/SaxonHE12-4J/saxon-he-12.4.jar /usr/local/bin/saxon.jar && \
    rm -rf /usr/local/bin/SaxonHE12-4J /usr/local/bin/saxon.zip

# Créer un script pour exécuter Saxon plus facilement
RUN echo '#!/bin/sh\njava -jar /usr/local/bin/saxon.jar "$@"' > /usr/local/bin/saxon-lint && \
    chmod +x /usr/local/bin/saxon-lint

CMD ["/bin/bash"]
