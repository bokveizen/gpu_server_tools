# Remote Tunnel

## VSCode

```shell
curl -Lk 'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' --output vscode_cli.tar.gz
# or specific version like https://update.code.visualstudio.com/1.97.2/cli-alpine-x64/stable
tar -xf vscode_cli.tar.gz
./code tunnel
```

## Cursor

```shell
curl -Lk 'https://api2.cursor.sh/updates/download-latest?os=cli-alpine-x64' --output cursor_cli.tar.gz
tar -xf cursor_cli.tar.gz
./cursor tunnel
```

- Follow the [instructions](https://code.visualstudio.com/docs/remote/tunnels) and login on GitHub
- On your local machine, open VS Code or Cursor -> `Remote-tunnels: Connect to Tunnel` -> GitHub Login -> Choose the tunnel name -> Left side-bar `Remote Explorer` -> `Dev Containers` -> Access your container
