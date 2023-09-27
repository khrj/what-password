# what password

OS with chntpw pre-installed and utilities

# Contents

- chntpw
- lxqt desktop (with qterminal)
- gparted (with ntfs3g)
- firefox
- git
- nano

# Build

```sh
nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=iso.nix
```

# Run

```sh
qemu-system-x86_64 -enable-kvm -m 2048M -cdrom result/iso/nixos-*.iso
```