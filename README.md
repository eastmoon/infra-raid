# 軟體磁碟陣列範例與說明

軟體磁碟陣列是利用軟體模擬陣列運作，本範例需要利用 Vagrant + VirtualBox 啟動虛擬機後掛載動態儲存器，再依序執行。

+ fdisk：磁碟設定
+ mdadm：陣列設定
+ mkfs：格式化

已完成磁碟陣列設定。

## 文獻

+ [How to define multiple disks inside Vagrant using VirtualBox provider](https://sleeplessbeastie.eu/2021/05/10/how-to-define-multiple-disks-inside-vagrant-using-virtualbox-provider/)
+ [替 Linux 新增硬碟（磁碟分割、格式化與掛載）](https://blog.gtwang.org/linux/linux-add-format-mount-harddisk/)
+ [Soft RAID 在 Linux上的建置 - mdadm](https://hackmd.io/@cwhu/SkpHEAy9u)
