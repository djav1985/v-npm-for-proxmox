# v-npm-for-proxmox

Scripts for installing applications on Proxmox LXC containers or native Debian systems.

**_Tested with:_** _Proxmox 7.1+, Debian 11+_
**_Note:_** _Only Debian is currently supported_

## Proxmox LXC Container Creation

Creates a new LXC container on Proxmox and sets up an application to run inside it.

Run the following in a SSH connection or the Proxmox web shell:

```bash
bash -c "$(wget --no-cache -qO- https://raw.githubusercontent.com/djav1985/v-npm-for-proxmox/main/create.sh)"
```

### Command Line Arguments

| argument     | default        | description                           |
| ------------ | -------------- | ------------------------------------- |
| --app        | none           | application to install                |
| --id         | $nextid        | container id                          |
| --os-version | latest         | OS version to install                 |
| --bridge     | vmbr0          | bridge used for eth0                  |
| --cores      | 1              | number of cpu cores                   |
| --disksize   | 4              | size of disk in GB                    |
| --hostname   | value of --app | hostname of the container             |
| --memory     | 512            | amount of memory                      |
| --storage    | local-lvm      | storage location for container disk   |
| --templates  | local          | storage location for templates        |
| --swap       | 0              | amount of SWAP                        |
| --cleanup    | false          | Remove dev dependencies after install |

Example with custom parameters:

```bash
bash -c "$(wget --no-cache -qO- https://raw.githubusercontent.com/djav1985/v-npm-for-proxmox/main/create.sh)" -s --app nginx-proxy-manager --cleanup
```

### Console Access

There is no login required to access the console from the Proxmox web UI. If you are presented with a blank screen, press `CTRL + C` to generate a prompt.

## Native Debian Installation

Install an application on an existing Debian system without using Proxmox.

```bash
bash -c "$(wget --no-cache -qO- https://raw.githubusercontent.com/djav1985/v-npm-for-proxmox/main/install.sh)" -s --app nginx-proxy-manager
```

### Command Line Arguments

| argument  | default | description                           |
| --------- | ------- | ------------------------------------- |
| --app     | none    | application to install                |
| --cleanup | false   | Remove dev dependencies after install |

## Applications

### Nginx Proxy Manager

**_Note:_** _As [Nginx Proxy Manager](https://nginxproxymanager.com/) uses openresty, nginx will be removed from the OS as it will conflict with openresty_

- **Proxmox LXC**: Use the command in the "Proxmox LXC Container Creation" section above
- **Native Debian**: Use the command in the "Native Debian Installation" section above

After installation, Nginx Proxy Manager will be available at `http://YOUR_SERVER_IP:81`

## Thanks

- [whiskerz007](https://github.com/whiskerz007?tab=repositories)
