# Nginx Proxy Manager install script

**_Note:_** _As [Nginx Proxy Manager](https://nginxproxymanager.com/) uses openresty, nginx will be removed from the OS as it will conflict with openresty_

## Usage

To create a Proxmox container please follow the main [README](https://github.com/djav1985/v-npm-for-proxmox)

```sh
sh -c "$(wget --no-cache -qO- https://raw.githubusercontent.com/djav1985/v-npm-for-proxmox/main/install.sh)" -s --app nginx-proxy-manager --cleanup
```

Run the command above to install or update [Nginx Proxy Manager](https://nginxproxymanager.com/)

**_Note:_** _Only Debian (11+) is currently supported_

### Command line arguments

| argument  | default | description                           |
| --------- | ------- | ------------------------------------- |
| --app     | none    | application to install                |
| --cleanup | false   | Remove dev dependencies after install |
