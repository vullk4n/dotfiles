### Arch Linux Install - Eu uso esse guia para meu próprio uso, não me responsabilizo por problemas.

### Layout do Teclado ABNT2:

```
loadkeys br-abnt2
```

### Separar as partições:

```
cfdisk
```

```
### Formatar as partições:

```
partição para o /home = linux home
partição root / = linux root
partição efi  = EFI
```

```
mkfs.vfat -F32 /dev/sda1 (EFI)
mkfs.ext4 /dev/sda2 (LINUX ROOT)
mkfs.ext4 /dev/sda3 (HOME)
```

### Montar partições:

```
OBS: Comece montando a sua partição root.

mount /dev/sdaX (Montar ROOT)
mount /dev/sdaX (Montar UEFI)
mount /dev/sdaX (Montar HOME)

Como eu uso:

mount /dev/sda2 /mnt (ROOT)
mkdir -p /mnt/boot/efi && mount /dev/sda1 /mnt/boot/efi (EFI)
mkdir /mnt/home && mount /dev/sda4 /mnt/home (HOME)
```

### Conectar ao WIFI:

```
clicar no botão de wi-fi/modo avião até aparecer "on" pelo iwctl. (não é em todos que acontece isto.)
```

```
iwctl
device list
station wlan0 connect <nomedarede>
*SENHA*
Sair ➜ CTRL+D
```

### Instalar sistema base:

```
pacstrap /mnt base wget neovim linux-firmware base-devel
```

### Gerar FSTAB:

```
genfstab -p /mnt >> /mnt/etc/fstab
```

### Entrar no chroot:

```
arch-chroot /mnt
```

```
# INTERNET

```
NetworkManager
pacman -S networkmanager -noconfirm
systemctl enable NetworkManager
```

### Setar o horário no sistema:

```
ln -sf /usr/share/zoneinfo/America/Fortaleza /etc/localtime
date
hwclock --systohc ( se a hora estiver certa)
```

### Mudando o idioma do SISTEMA:

```
nvim /etc/locale.gen
Descomenta a linha: #pt_BR.UTF-8 e #pt_BR ISO-8859-1
locale-gen
echo LANG=pt_BR.UTF-8 > /etc/locale.conf
export LANG=pt_BR.UTF-8
```

### Configurar o teclado para subir em PT-BR:

```
echo KEYMAP=br-abnt2 > /etc/vconsole.conf
```

### Colocar nome host:

```
echo vulkan > /etc/hostname ou echo nomedouser > /etc/hostname
```

### Baixar kernel:

```
pacman -S linux-zen linux-zen-headers --noconfirm ➜ Kernel focado em desempenho
```

### Configurar pacman.conf:

```
nvim /etc/pacman.conf
Descomentar linhas:
#multilib
#incluide

#EXTRA:
Descomentar as linhas:
UseSyslog, Color, CheckSpace, VerbosePkgLists e ParallelDownloads=5

#Easter egg:

Debaixo da linha VerbosePkgLists ➜ ILoveCandy
```

### Sincronizar repositórios:

```
pacman -Syy
```

### Senha root:

```
passwd
```

### Criar user:

```
Se você usa zsh você pode fazer assim:

pacman -S zsh --noconfirm

useradd -m -g users -s /bin/zsh seu_user
```

### Senha para o user:

```
passwd USER
```

### Editar arquivo sudo:

```
nvim /etc/sudoers

Embaixo da linha:

root ALL=(ALL)ALL

Você adiciona seu user:

user ALL=(ALL)ALL

### (***)

Debaixo de Read drop-in files from /etc/sudoers.d ➜ Defaults pwfeedback
```

### Baixar e instalar o GRUB:

```
# UEFI
pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Grub_Arch --recheck
```

```
### Caso tenha Dualboot:
pacman -S os-prober ntfs-3g --noconfirm
```

```
### Atualize o GRUB
grub-mkconfig -o /boot/grub/grub.cfg

CTRL + d
```

### ESCREVA REBOOT, E ESPERE A TELA FICAR PRETA, E TIRE O PENDRIVE.



# INSTALAÇÃO FINALIZADA DO ARCH LINUX #

### Notebooks via wifi usa o comando: (Requer NetworkManager instalado)

```
nmtui
```

### Grafic

```
sudo pacman -S xf86-video-amdgpu --noconfirm
sudo pacman -S xf86-video-intel --noconfirm
```

### Baixar alguns pacotes:

```
sudo pacman -S i3 kitty git curl wget ttf-nerd-fonts-symbols-mono ttf-jetbrains-mono xorg-xrandr xorg-server xorg-xinit xdg-user-dirs cmake python-sphinx --noconfirm && xdg-user-dirs-update

echo exec i3 > .xinitrc && startx
```

### Script i3-gaps

```
Se o teclado ficar diferente já no i3WM, dê o seguinte comando:

setxkbmap br
```

```
# FINALIZADO #
