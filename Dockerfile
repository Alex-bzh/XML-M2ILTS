FROM debian:latest

# Installer les utilitaires nécessaires
RUN apt-get update && apt-get install -y \
    libxml2-utils \
    saxonhe \
    xsltproc \
    && apt-get clean

# Définir le shell interactif par défaut
CMD ["/bin/bash"]
