FROM jenkins/jenkins:lts

LABEL maintainer="support@punctiq.com" \
      org.opencontainers.image.title="Punctiq Jenkins" \
      org.opencontainers.image.version="1.0.0" \
      org.opencontainers.image.description="Jenkins LTS with plugins, Ansible, Terraform, and Git" \
      org.opencontainers.image.source="https://punctiq.com" \
      org.opencontainers.image.licenses="MIT"

ENV DEBIAN_FRONTEND=noninteractive

# === INSTALL PACKAGES ===
USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ansible \
      git \
      curl \
      unzip \
      gnupg \
      software-properties-common && \
    curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && \
    apt-get install -y terraform && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# === INSTALL PLUGINS ===
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

# === JCasC ===
COPY jenkins.yaml /usr/share/jenkins/ref/casc_configs/jenkins.yaml

# === Enable Configuration-as-Code ===
ENV CASC_JENKINS_CONFIG=/var/jenkins_home/casc_configs/jenkins.yaml

USER jenkins
