1. Configure your Linux Kernel with the EFI stub

2. Build with the proper options for your toolchain. This is my command line
```
gmake CROSS_COMPILE=aarch64-elf- KCFLAGS="-fno-plt -fno-pic" LD=aarch64-elf-ld MAKE=gmake LDFLAGS_vmlinux="--verbose --no-relax --emit-relocs -static --no-dynamic-linker" 
```

3. Move this to your hypervisor boot location
```
cp arch/arm64/boot/Image $HOME/source/toyvm/test-kernel
```

4. Boot with a command line like this
```
./build/Release/toyvm -k test-kernel -d debian-rootfs-aarch64.img 'root=/dev/vda1 console=hvc0 nosplash'
```

5. Enjoy
```
sedwards@SEDWARDS-M-73M9 toyvm % ./build/Release/toyvm -k test-kernel -d debian-rootfs-aarch64.img 'root=/dev/vda1 console=hvc0 nosplash' 
[    0.089424] loop: module loaded
[    0.089582] virtio_blk virtio2: 1/0/0 default/read/poll queues
[    0.089906] virtio_blk virtio2: [vda] 20971520 512-byte logical blocks (10.7 GB/10.0 GiB)
[    0.091037]  vda: vda1
[    0.091468] tun: Universal TUN/TAP device driver, 1.6
[    0.092033] thunder_xcv, ver 1.0
[    0.092091] thunder_bgx, ver 1.0
[    0.092239] nicpf, ver 1.0
[    0.092302] hns3: Hisilicon Ethernet Network Driver for Hip08 Family - version
[    0.092420] hns3: Copyright (c) 2017 Huawei Corporation.
[    0.092504] hclge is initializing
[    0.092584] e1000: Intel(R) PRO/1000 Network Driver
[    0.092652] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    0.092749] e1000e: Intel(R) PRO/1000 Network Driver
[    0.092848] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    0.092916] igb: Intel(R) Gigabit Ethernet Network Driver
[    0.092975] igb: Copyright (c) 2007-2014 Intel Corporation.
[    0.093023] igbvf: Intel(R) Gigabit Virtual Function Network Driver
[    0.093096] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    0.093171] sky2: driver version 1.30
[    0.093384] VFIO - User Level meta-driver version: 0.3
[    0.093492] usbcore: registered new interface driver usb-storage
[    0.093745] rtc-pl031 20050000.pl031: registered as rtc0
[    0.093826] rtc-pl031 20050000.pl031: setting system clock to 2024-11-02T21:55:30 UTC (1730584530)
[    0.093990] i2c_dev: i2c /dev entries driver
[    0.094151] sdhci: Secure Digital Host Controller Interface driver
[    0.094258] sdhci: Copyright(c) Pierre Ossman
[    0.094334] Synopsys Designware Multimedia Card Interface Driver
[    0.094400] sdhci-pltfm: SDHCI platform and OF driver helper
[    0.094514] usbcore: registered new interface driver usbhid
[    0.094548] usbhid: USB HID core driver
[    0.094672] NET: Registered PF_PACKET protocol family
[    0.094758] 9pnet: Installing 9P2000 support
[    0.094859] Key type dns_resolver registered
[    0.095704] registered taskstats version 1
[    0.095787] Loading compiled-in X.509 certificates
[    0.096579] Demotion targets for Node 0: null
[    0.096858] input: gpio-keys as /devices/platform/gpio-keys/input/input0
[    0.097000] clk: Disabling unused clocks
[    0.097029] PM: genpd: Disabling unused power domains
[    0.098524] EXT4-fs (vda1): INFO: recovery required on readonly filesystem
[    0.098590] EXT4-fs (vda1): write access will be enabled during recovery
[    0.114815] EXT4-fs (vda1): recovery complete
[    0.124642] EXT4-fs (vda1): mounted filesystem d4ca15cf-e47c-43cf-b67c-d7493f341e39 ro with ordered data mode. Quota mode: none.
[    0.124742] VFS: Mounted root (ext4 filesystem) readonly on device 254:1.
[    0.125087] devtmpfs: mounted
[    0.125256] Freeing unused kernel memory: 960K
[    0.125352] Run /sbin/init as init process
[    0.164708] systemd[1]: systemd 252.6-1 running in system mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD -BPF_FRAMEWORK -XKBCOMMON +UTMP +SYSVINIT default-hierarchy=unified)
[    0.165003] systemd[1]: Detected virtualization vm-other.
[    0.165131] systemd[1]: Detected architecture arm64.

Welcome to Debian GNU/Linux 12 (bookworm)!

[    0.166127] systemd[1]: Hostname set to <debian-vm-aarch64>.
[    0.221419] systemd[1]: Queued start job for default target graphical.target.
[    0.242001] systemd[1]: Created slice system-getty.slice - Slice /system/getty.
[  OK  ] Created slice system-getty.slice - Slice /system/getty.
[    0.242356] systemd[1]: Created slice system-modprobe.slice - Slice /system/modprobe.
[  OK  ] Created slice system-modpr…lice - Slice /system/modprobe.
[    0.242701] systemd[1]: Created slice system-serial\x2dgetty.slice - Slice /system/serial-getty.
[  OK  ] Created slice system-seria… - Slice /system/serial-getty.
[    0.242898] systemd[1]: Started systemd-ask-password-console.path - Dispatch Password Requests to Console Directory Watch.
[  OK  ] Started systemd-ask-passwo…quests to Console Directory Watch.
[    0.243089] systemd[1]: Started systemd-ask-password-wall.path - Forward Password Requests to Wall Directory Watch.
[  OK  ] Started systemd-ask-passwo… Requests to Wall Directory Watch.
[    0.243527] systemd[1]: Set up automount proc-sys-fs-binfmt_misc.automount - Arbitrary Executable File Formats File System Automount Point.
[  OK  ] Set up automount proc-sys-…rmats File System Automount Point.
[    0.243788] systemd[1]: Reached target cryptsetup.target - Local Encrypted Volumes.
[  OK  ] Reached target cryptsetup.…get - Local Encrypted Volumes.
[    0.244004] systemd[1]: Reached target integritysetup.target - Local Integrity Protected Volumes.
[  OK  ] Reached target integrityse…Local Integrity Protected Volumes.
[    0.244245] systemd[1]: Reached target paths.target - Path Units.
[  OK  ] Reached target paths.target - Path Units.
[    0.244435] systemd[1]: Reached target remote-fs.target - Remote File Systems.
[  OK  ] Reached target remote-fs.target - Remote File Systems.
[    0.244662] systemd[1]: Reached target slices.target - Slice Units.
[  OK  ] Reached target slices.target - Slice Units.
[    0.244896] systemd[1]: Reached target swap.target - Swaps.
[  OK  ] Reached target swap.target - Swaps.
[    0.245101] systemd[1]: Reached target veritysetup.target - Local Verity Protected Volumes.
[  OK  ] Reached target veritysetup… - Local Verity Protected Volumes.
[    0.245387] systemd[1]: Listening on systemd-fsckd.socket - fsck to fsckd communication Socket.
[  OK  ] Listening on systemd-fsckd…sck to fsckd communication Socket.
[    0.245573] systemd[1]: Listening on systemd-initctl.socket - initctl Compatibility Named Pipe.
[  OK  ] Listening on systemd-initc… initctl Compatibility Named Pipe.
[    0.245806] systemd[1]: Listening on systemd-journald-audit.socket - Journal Audit Socket.
[  OK  ] Listening on systemd-journ…socket - Journal Audit Socket.
[    0.246038] systemd[1]: Listening on systemd-journald-dev-log.socket - Journal Socket (/dev/log).
[  OK  ] Listening on systemd-journ…t - Journal Socket (/dev/log).
[    0.246290] systemd[1]: Listening on systemd-journald.socket - Journal Socket.
[  OK  ] Listening on systemd-journald.socket - Journal Socket.
[    0.246542] systemd[1]: Listening on systemd-udevd-control.socket - udev Control Socket.
[  OK  ] Listening on systemd-udevd….socket - udev Control Socket.
[    0.246756] systemd[1]: Listening on systemd-udevd-kernel.socket - udev Kernel Socket.
[  OK  ] Listening on systemd-udevd…l.socket - udev Kernel Socket.
[    0.246930] systemd[1]: Reached target sockets.target - Socket Units.
[  OK  ] Reached target sockets.target - Socket Units.
[    0.247136] systemd[1]: dev-hugepages.mount - Huge Pages File System was skipped because of an unmet condition check (ConditionPathExists=/sys/kernel/mm/hugepages).
[    0.247607] systemd[1]: Mounting dev-mqueue.mount - POSIX Message Queue File System...
         Mounting dev-mqueue.mount…OSIX Message Queue File System...
[    0.248184] systemd[1]: Mounting sys-kernel-debug.mount - Kernel Debug File System...
         Mounting sys-kernel-debug.… - Kernel Debug File System...
[    0.248910] systemd[1]: sys-kernel-tracing.mount - Kernel Trace File System was skipped because of an unmet condition check (ConditionPathExists=/sys/kernel/tracing).
[    0.249128] systemd[1]: kmod-static-nodes.service - Create List of Static Device Nodes was skipped because of an unmet condition check (ConditionFileNotEmpty=/lib/modules/6.12.0-rc5-gb13c1f9efd08-dirty/modules.devname).
[    0.249838] systemd[1]: Starting modprobe@configfs.service - Load Kernel Module configfs...
         Starting modprobe@configfs…m - Load Kernel Module configfs...
[    0.251075] systemd[1]: Starting modprobe@dm_mod.service - Load Kernel Module dm_mod...
         Starting modprobe@dm_mod.s…[0m - Load Kernel Module dm_mod...
[    0.251632] systemd[1]: Starting modprobe@efi_pstore.service - Load Kernel Module efi_pstore...
         Starting modprobe@efi_psto…- Load Kernel Module efi_pstore...
[    0.252630] systemd[1]: Starting modprobe@fuse.service - Load Kernel Module fuse...
         Starting modprobe@fuse.ser…e - Load Kernel Module fuse...
[    0.253333] systemd[1]: Starting modprobe@loop.service - Load Kernel Module loop...
         Starting modprobe@loop.ser…e - Load Kernel Module loop...
[    0.253872] systemd[1]: Starting systemd-fsck-root.service - File System Check on Root Device...
         Starting systemd-fsck-root…ile System Check on Root Device...
[    0.254673] systemd[1]: Starting systemd-journald.service - Journal Service...
         Starting systemd-journald.service - Journal Service...
[    0.257831] systemd[1]: Starting systemd-modules-load.service - Load Kernel Modules...
         Starting systemd-modules-l…rvice - Load Kernel Modules...
[    0.258602] systemd[1]: Starting systemd-udev-trigger.service - Coldplug All udev Devices...
         Starting systemd-udev-trig…[0m - Coldplug All udev Devices...
[    0.259994] systemd[1]: Mounted dev-mqueue.mount - POSIX Message Queue File System.
[  OK  ] Mounted dev-mqueue.mount…OSIX Message Queue File System.
[    0.260138] systemd[1]: Mounted sys-kernel-debug.mount - Kernel Debug File System.
[  OK  ] Mounted sys-kernel-debug.m…nt - Kernel Debug File System.
[    0.261119] systemd[1]: modprobe@configfs.service: Deactivated successfully.
[    0.261261] systemd[1]: Finished modprobe@configfs.service - Load Kernel Module configfs.
[  OK  ] Finished modprobe@configfs…[0m - Load Kernel Module configfs.
[    0.261924] systemd[1]: modprobe@dm_mod.service: Deactivated successfully.
[    0.263704] systemd[1]: Finished modprobe@dm_mod.service - Load Kernel Module dm_mod.
[  OK  ] Finished modprobe@dm_mod.s…e - Load Kernel Module dm_mod.
[    0.264104] systemd[1]: modprobe@efi_pstore.service: Deactivated successfully.
[    0.264405] systemd[1]: Finished modprobe@efi_pstore.service - Load Kernel Module efi_pstore.
[  OK  ] Finished modprobe@efi_psto…m - Load Kernel Module efi_pstore.
[    0.267391] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[    0.267555] systemd[1]: Finished modprobe@fuse.service - Load Kernel Module fuse.
[  OK  ] Finished modprobe@fuse.service - Load Kernel Module fuse.
[    0.267947] systemd[1]: modprobe@loop.service: Deactivated successfully.
[    0.268170] systemd[1]: Finished modprobe@loop.service - Load Kernel Module loop.
[  OK  ] Finished modprobe@loop.service - Load Kernel Module loop.
[    0.268468] systemd[1]: Finished systemd-modules-load.service - Load Kernel Modules.
[  OK  ] Finished systemd-modules-l…service - Load Kernel Modules.
[    0.268798] systemd[1]: sys-fs-fuse-connections.mount - FUSE Control File System was skipped because of an unmet condition check (ConditionPathExists=/sys/fs/fuse/connections).
[    0.269357] systemd[1]: Mounting sys-kernel-config.mount - Kernel Configuration File System...
         Mounting sys-kernel-config…ernel Configuration File System...
[    0.271115] systemd[1]: Started systemd-fsckd.service - File System Check Daemon to report status.
[  OK  ] Started systemd-fsckd.serv…tem Check Daemon to report status.
[    0.271925] systemd[1]: systemd-repart.service - Repartition Root Disk was skipped because no trigger condition checks were met.
[    0.272675] systemd[1]: Starting systemd-sysctl.service - Apply Kernel Variables...
         Starting systemd-sysctl.se…ce - Apply Kernel Variables...
[    0.278750] systemd[1]: Started systemd-journald.service - Journal Service.
[  OK  ] Started systemd-journald.service - Journal Service.
[  OK  ] Mounted sys-kernel-config.… Kernel Configuration File System.
[  OK  ] Finished systemd-sysctl.service - Apply Kernel Variables.
[  OK  ] Finished systemd-fsck-root… File System Check on Root Device.
         Starting systemd-remount-f…nt Root and Kernel File Systems...
[  OK  ] Finished systemd-udev-trig…e - Coldplug All udev Devices.
         Starting ifupdown-pre.serv…ynchronize boot up for ifupdown...
[    0.309001] EXT4-fs (vda1): re-mounted d4ca15cf-e47c-43cf-b67c-d7493f341e39 r/w. Quota mode: none.
[  OK  ] Finished systemd-remount-f…ount Root and Kernel File Systems.
         Starting systemd-journal-f…h Journal to Persistent Storage...
         Starting systemd-random-se…ice - Load/Save Random Seed...
         Starting systemd-sysusers.…rvice - Create System Users...
[    0.320572] systemd-journald[78]: Received client request to flush runtime journal.
[    0.324738] systemd-journald[78]: File /var/log/journal/3043d4d697b74bad8351a818c1baf6f1/system.journal corrupted or uncleanly shut down, renaming and replacing.
[  OK  ] Finished systemd-sysusers.service - Create System Users.
         Starting systemd-tmpfiles-…ate Static Device Nodes in /dev...
[  OK  ] Finished systemd-tmpfiles-…reate Static Device Nodes in /dev.
[  OK  ] Reached target local-fs-pr…reparation for Local File Systems.
[  OK  ] Reached target local-fs.target - Local File Systems.
         Starting systemd-udevd.ser…ger for Device Events and Files...
[  OK  ] Finished systemd-journal-f…ush Journal to Persistent Storage.
         Starting systemd-tmpfiles-… Volatile Files and Directories...
[  OK  ] Finished systemd-tmpfiles-…te Volatile Files and Directories.
         Starting systemd-update-ut…rd System Boot/Shutdown in UTMP...
[  OK  ] Finished systemd-update-ut…cord System Boot/Shutdown in UTMP.
[  OK  ] Started systemd-udevd.serv…nager for Device Events and Files.
[  OK  ] Reached target sysinit.target - System Initialization.
[  OK  ] Started apt-daily.timer - Daily apt download activities.
[  OK  ] Started apt-daily-upgrade.… apt upgrade and clean activities.
[  OK  ] Started dpkg-db-backup.tim… Daily dpkg database backup timer.
[  OK  ] Started e2scrub_all.timer…tadata Check for All Filesystems.
[  OK  ] Started fstrim.timer - Discard unused blocks once a week.
[  OK  ] Started logrotate.timer - Daily rotation of log files.
[  OK  ] Started systemd-tmpfiles-c… Cleanup of Temporary Directories.
[  OK  ] Reached target timers.target - Timer Units.
[  OK  ] Reached target basic.target - Basic System.
[  OK  ] Started cron.service -…kground program processing daemon.
         Starting e2scrub_reap.serv…e ext4 Metadata Check Snapshots...
         Starting getty-static.serv…us and logind are not available...
         Starting logrotate.service - Rotate log files...
[  OK  ] Found device dev-hvc0.device - /dev/hvc0.
[  OK  ] Finished logrotate.service - Rotate log files.
[    0.432284] virtio_net virtio0 enp0s1: renamed from eth0
[  OK  ] Finished e2scrub_reap.serv…ine ext4 Metadata Check Snapshots.
[  OK  ] Finished getty-static.serv…dbus and logind are not available.
[  OK  ] Finished ifupdown-pre.serv… synchronize boot up for ifupdown.
         Starting networking.service - Raise network interfaces...
[    2.652827] random: crng init done
[  OK  ] Finished systemd-random-se…rvice - Load/Save Random Seed.
[  OK  ] Finished networking.service - Raise network interfaces.
[  OK  ] Reached target network.target - Network.
         Starting systemd-user-sess…vice - Permit User Sessions...
[  OK  ] Finished systemd-user-sess…ervice - Permit User Sessions.
[  OK  ] Started getty@tty1.service - Getty on tty1.
[  OK  ] Started getty@tty2.service - Getty on tty2.
[  OK  ] Started getty@tty3.service - Getty on tty3.
[  OK  ] Started getty@tty4.service - Getty on tty4.
[  OK  ] Started getty@tty5.service - Getty on tty5.
[  OK  ] Started getty@tty6.service - Getty on tty6.
[  OK  ] Started serial-getty@hvc0.service - Serial Getty on hvc0.
[  OK  ] Reached target getty.target - Login Prompts.
[  OK  ] Reached target multi-user.target - Multi-User System.
[  OK  ] Reached target graphical.target - Graphical Interface.
         Starting systemd-update-ut… Record Runlevel Change in UTMP...
[  OK  ] Finished systemd-update-ut… - Record Runlevel Change in UTMP.

Debian GNU/Linux 12 debian-vm-aarch64 hvc0

debian-vm-aarch64 login: root
Password: 
Linux debian-vm-aarch64 6.12.0-rc5-gb13c1f9efd08-dirty #56 SMP PREEMPT Sat Nov  2 14:20:25 PDT 2024 aarch64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Wed Sep 25 03:22:08 UTC 2024 on hvc0
root@debian-vm-aarch64:~# exit

```

Everything else below is my collection of notes, that you don't need.

if linker scripts if you have errors

KCFLAGS="-fno-plt -fno-pic"

LDFLAGS_vmlinux="--no-relax"
LDFLAGS_vmlinux="--emit-relocs"


 --no-rosegment to Disable RELRO: Disabling RELRO at the linker level may help if you do not need RELRO protection for your kernel build. Add --no-rosegment to LDFLAGS_vmlinux:

LDFLAGS_vmlinux="--no-rosegment"

if linker scripts if you have errors
 Linker script to modiy arch/arm64/kernel/vmlinux.lds
.data.rel : { *(.data.rel) }
.data.rel.local : { *(.data.rel.local) }
.data.rel.ro.local : { *(.data.rel.ro.local) }

gmake CROSS_COMPILE=aarch64-elf- KCFLAGS="-fPIC" LD=aarch64-elf-ld.bfd
gmake CROSS_COMPILE=aarch64-elf- KCFLAGS="-mcmodel=small -fpie" LD=aarch64-elf-ld.bfd MAKE=gmake LDFLAGS_vmlinux="--verbose"
gmake CROSS_COMPILE=aarch64-elf- KCFLAGS="-mcmodel=small -fpie" LD=/opt/homebrew/Cellar/llvm@18/18.1.8/bin/ld.lld LDFLAGS_vmlinux="--verbose"



aarch64-elf-objcopy -O binary vmlinux vmlinux.bin
aarch64-elf-objcopy -I binary -O pe-aarch64 vmlinux.bin vmlinuz-efi

arch64-elf-objcopy -O pe-aarch64 vmlinux vmlinuz-efi
2. Use llvm-objcopy as an Alternative:
If objcopy from binutils encounters issues, llvm-objcopy (available via LLVM tools) might handle the conversion better:

bash
Copy code
/opt/homebrew/Cellar/llvm@18/18.1.8/bin/llvm-objcopy -O pe-aarch64 vmlinux vmlinuz-efi
3. Strip Unneeded Sections Before Conversion:
Remove sections not needed for booting, which might simplify the conversion:

bash
Copy code
aarch64-elf-objcopy --strip-debug --strip-unneeded vmlinux temp-vmlinux
aarch64-elf-objcopy -O pe-aarch64 temp-vmlinux vmlinuz-efi
4. Convert to Binary First, then to PE-COFF:
Sometimes converting the ELF file to raw binary format and then back to PE-COFF helps:

bash
Copy code
aarch64-elf-objcopy -O binary vmlinux vmlinux.bin
aarch64-elf-objcopy -I binary -O pe-aarch64 vmlinux.bin vmlinuz-efi



m1n1 supports running payloads by simple concatenation:

```shell
$ cat build/m1n1.macho Image.gz build/dtb/apple-j274.dtb initramfs.cpio.gz > m1n1-payload.macho
$ cat build/m1n1.bin Image.gz build/dtb/apple-j274.dtb initramfs.cpio.gz > m1n1-payload.bin
```

Supported payload file formats:

* Kernel images (or compatible). Must be compressed or last payload.
* Devicetree blobs (FDT). May be uncompressed or compressed.
* Initramfs cpio images. Must be compressed.

Supported compression formats:

* gzip
* xz



