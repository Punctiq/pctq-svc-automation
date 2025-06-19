# 📘 Overview

This repository provides a production-grade Jenkins environment tailored for DevOps automation pipelines at Punctiq.  
It includes a custom Docker image based on `jenkins/jenkins:lts`, preconfigured with:

- Jenkins Configuration as Code (JCasC)
- Required plugins for CI/CD, Ansible, Terraform, and Git integrations
- Matrix-based security configuration (with no anonymous access)
- Optional Docker socket access for containerized agents

The setup is intended for internal CI/CD orchestration in secure environments, with support for dynamic job provisioning and credential injection.

---

# 📦 Project Structure

```
.
├── Dockerfile                # Jenkins LTS base image + Ansible, Terraform, Git
├── docker-compose.yml       # Production deployment using persistent volumes
├── plugins.txt              # Declarative plugin installation file
├── jenkins.yaml             # JCasC configuration for users and permissions
├── .env                     # Environment variables (admin user/pass/email)
├── Makefile                 # Automation for build/tag/run lifecycle
└── README.md                # You're here
```

---

# 🚀 Usage

## 🔧 Build the Docker image

```bash
make build
```

or manually:

```bash
docker build -t itcommunity/automation-svc:1.0.0 .
```

## ▶️ Run with Docker Compose

```bash
make up
```

or directly:

```bash
docker compose up -d
```

## 🔄 Restart

```bash
make restart
```

## 🧼 Cleanup

```bash
make down
make clean
```

---

# 🛠 Configuration

| File / Path                              | Description                                         |
|------------------------------------------|-----------------------------------------------------|
| `./jenkins.yaml`                         | Jenkins Configuration as Code (JCasC) definition    |
| `plugins.txt`                            | List of Jenkins plugins to install at build time    |
| `/var/jenkins_home` (via named volume)   | Jenkins home directory for data persistence         |
| `/var/run/docker.sock`                   | Enables Jenkins to launch Docker-based agents       |
| `.env`                                   | Admin credentials injected via environment variables |

### Environment Variables (via `.env`)

```ini
ADMIN_USER=admin
ADMIN_PASS=securepassword
ADMIN_EMAIL=admin@punctiq.com
```

---

# 🔖 Tagging & Versioning

We follow semantic versioning:

- `itcommunity/automation-svc:1.0.0` — stable version
- `itcommunity/automation-svc:prod` — alias for production
- `itcommunity/automation-svc:sha-<git-sha>` — Git-based immutable builds

Use `make tag` and `make push` to automate tagging and deployment:

```bash
make tag
make push
```

---

# 🔌 Preinstalled Plugins (via `plugins.txt`)

```txt
antisamy-markup-formatter
matrix-auth
script-security
credentials
ssh-credentials
git
workflow-aggregator
configuration-as-code
ansible
ssh-agent
publish-over-ssh
pipeline-stage-step
pipeline-input-step
pipeline-build-step
pipeline-milestone-step
pipeline-graph-analysis
pipeline-stage-view
pipeline-timeline
hidden-parameter
```

---

# 👥 Contributors

**Owner:** [Punctiq DevOps Team]  
**Maintainers:** [@alexandru-raul], [@devops-punctiq], [@infra-automation]

---

# 📄 License

[MIT License](https://opensource.org/licenses/MIT)