FROM ubuntu:latest

# Installer les utilitaires nécessaires
RUN apt-get update && apt-get install -y \
    libxml2-utils \
    xsltproc \
    wget \
    openjdk-17-jre \
    && apt-get clean

# Télécharger Saxon-HE
RUN wget -O /usr/local/bin/saxon.jar \
    https://github.com/Saxonica/Saxon-HE/raw/main/Java/SaxonHE12-4J/saxon-he-12.4.jar

# Créer un script pour exécuter Saxon plus facilement
RUN echo '#!/bin/sh\njava -jar /usr/local/bin/saxon.jar "$@"' > /usr/local/bin/saxon-lint && \
    chmod +x /usr/local/bin/saxon-lint

CMD ["/bin/bash"]
