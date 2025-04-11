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
```

For SSH connection
```
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

For remote tunnels
```shell
curl -Lk 'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' --output vscode_cli.tar.gz
# or specific version like https://update.code.visualstudio.com/1.97.2/cli-alpine-x64/stable
tar -xf vscode_cli.tar.gz
./code tunnel
```
