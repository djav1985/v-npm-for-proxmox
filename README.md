# Proxmox LXC Container Scripts

Scripts to automate creation and management of LXC containers on Proxmox VE with pre-configured applications.

## Create Proxmox LXC Container

To create a new LXC container on Proxmox and setup an app to run inside of it, run the following in a SSH connection or the Proxmox web shell:

**_Tested with:_** _proxmox 7.1+, debian 11+_

```bash
bash -c "$(wget --no-cache -qO- https://raw.githubusercontent.com/djav1985/v-npm-for-proxmox/main/create.sh)"
```

### Command line arguments

| argument     | default        | description                           |
| ------------ | -------------- | ------------------------------------- |
| --app        | none           | application to install                |
| --id         | $nextid        | container id                          |
| --os         | debian         | OS distribution to install            |
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

you can set these parameters by appending ` -- <parameter> <value>` like:

```bash
bash -c "$(wget --no-cache -qO- https://raw.githubusercontent.com/djav1985/v-npm-for-proxmox/main/create.sh)" -s --app nginx-proxy-manager --cleanup
```

### Console

There is no login required to access the console from the Proxmox web UI. If you are presented with a blank screen, press `CTRL + C` to generate a prompt.

## Alternative Usage

If you are not using proxmox or want to install a app on a existing install, you can run the setup script itself.

**_Note:_** _Only Debian (11+) is currently supported_

```sh
sh -c "$(wget --no-cache -qO- https://raw.githubusercontent.com/djav1985/v-npm-for-proxmox/main/install.sh)" -s --app nginx-proxy-manager
```

### Command line arguments

| argument  | default | description                           |
| --------- | ------- | ------------------------------------- |
| --app     | none    | application to install                |
| --cleanup | false   | Remove dev dependencies after install |

## Applications

### Nginx Proxy Manager

**_Note:_** _As [Nginx Proxy Manager](https://nginxproxymanager.com/) uses openresty, nginx will be removed from the OS as it will conflict with openresty_

To install Nginx Proxy Manager on an existing system:

```sh
sh -c "$(wget --no-cache -qO- https://raw.githubusercontent.com/djav1985/v-npm-for-proxmox/main/install.sh)" -s --app nginx-proxy-manager --cleanup
```

## Thanks

- [whiskerz007](https://github.com/whiskerz007?tab=repositories)
