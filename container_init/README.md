# Container Initialization

Some useful steps for a clean new container:

```shell
sed -i 's/archive.ubuntu.com/kr.archive.ubuntu.com/g' /etc/apt/sources.list  # for South Korea
sed -i 's/security.ubuntu.com/kr.archive.ubuntu.com/g' /etc/apt/sources.list  # for South Korea

apt update
apt install -y build-essential

apt-get update
apt-get install -y vim
apt-get install -y htop
apt-get install -y git
apt-get install -y tmux
apt-get install -y curl
apt-get install -y wget
```

For GitHub CLI

```shell
(type -p wget >/dev/null || (apt update && apt install wget -y)) \
  && mkdir -p -m 755 /etc/apt/keyrings \
  && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
  && cat $out | tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
  && chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
  && mkdir -p -m 755 /etc/apt/sources.list.d \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
  | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
  && apt update \
  && apt install gh -y
gh auth login
```

For Codex

```shell
set -e

# Install basic dependencies when possible
if command -v apt-get >/dev/null 2>&1; then
  sudo apt-get update
  sudo apt-get install -y curl ca-certificates git
elif command -v dnf >/dev/null 2>&1; then
  sudo dnf install -y curl ca-certificates git
elif command -v yum >/dev/null 2>&1; then
  sudo yum install -y curl ca-certificates git
elif command -v pacman >/dev/null 2>&1; then
  sudo pacman -Sy --needed curl ca-certificates git
elif command -v zypper >/dev/null 2>&1; then
  sudo zypper install -y curl ca-certificates git
fi

# Install nvm
export NVM_DIR="$HOME/.nvm"

if [ ! -s "$NVM_DIR/nvm.sh" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
fi

# Load nvm in this shell
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Install latest Node.js LTS, which includes npm
nvm install --lts
nvm alias default 'lts/*'
nvm use default

# Install OpenAI Codex CLI
npm install -g @openai/codex@latest

# Verify
node -v
npm -v
codex --version
```


For SSH connection

```shell
apt-get install -y openssh-server
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config  # allow password for root login
service ssh restart
```

```shell
pip install ipykernel iprogress ipywidgets gpustat jupyterlab
echo -e '\n# conda initialize\n# !! Contents within this block are managed by 'conda init' !!\n__conda_setup="$('/path/to/conda' 'shell.bash' 'hook' 2> /dev/null)"\nif [ $? -eq 0 ]; then\n    eval "$__conda_setup"\nelse\n    if [ -f "/path/to/conda" ]; then\n        . "/path/to/conda"\n    else\n        export PATH="/path/to/conda:$PATH"\n    fi\nfi\nunset __conda_setup' >> ~/.bashrc; echo "export PATH=\"$PATH:/opt/conda/bin\"" >> ~/.bashrc; source ~/.bashrc;
```

Generate public key on local PC

```shell
ssh-keygen -t rsa
```

Copy the public key to the remote machine

```shell
mkdir -p ~/.ssh
touch ~/.ssh/authorized_keys
echo >> ~/.ssh/authorized_keys  # adds a line break
echo {YOUR SSH PUBLIC KEY} >> ~/.ssh/authorized_keys
echo >> ~/.ssh/authorized_keys  # adds a line break
```

