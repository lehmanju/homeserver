# Homeserver Ignition Configuration
This is a Fedora CoreOS setup for my homeserver.

## Files
- `files/config` contains configuration files used by services
- `files/containers` contains Podman quadlet files
- `boot.ipxe` boot FCOS and installs it using `homeserver.bu` (ip addr has to be changed)
- `secrets` contains secret values to be replaced in configuration files (see Makefile)

## Build and install
- Setup your server and network to support ipxe booting from your machine at `http://<your_machine>:8000/boot.ipxe`. Make sure your IPXE supports *https*. If you chainload, compile `ipxe.efi` with [crypto](https://ipxe.org/crypto).
- Set correct IP address for your local machine in `boot.ipxe`
- Set FCOS version in `boot.ipxe`
- Adjust `homeserver.bu`. I have a preexisting raid/lvm device that gets mounted at boot.
- Run `make serve` to compile all config files with its secrets. It opens a local http server that FCOS uses to get the ignition file.
- Boot your server from ipxe.
- Once the server finished installing, kill your local http server.
- `make clean` to remove your build directory.