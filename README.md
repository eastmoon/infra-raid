# 軟體磁碟陣列 (Software RAID)

軟體磁碟陣列是利用軟體模擬陣列運作，本範例需要利用 Vagrant + VirtualBox 啟動虛擬機後掛載動態儲存器，再依序執行。

+ fdisk：磁碟設定 ( 使用 extended )
+ mdadm：陣列設定
+ mkfs：格式化

已完成磁碟陣列設定。

# LVM ( Logical Volume Manager )

LVM 不同於 RAID 0 的串接，其架構是將檔案系統分成多個 PE 區塊，並透過 LVM 架構逐步擴大 VG、LV，最終達到動態擴大硬碟容量的方式。
原則上 LVM 可以輕易動態擴大硬碟，但若硬碟有任何異常，容易導致整個磁區異常。

+ fdisk：磁碟設定 ( 使用 primary )
    - ```sudo fdisk /dev/sdc```
+ pv
    - ```sudo pvcreate /dev/sdc1```，設定 ```/dev/sdc1``` 加入 PV 中
    - ```sudo pvscan```，檢測 PV 狀態
    - ```sudo vgextend demovg /dev/sdd1```，增加一個新的 ```/dev/sdd1``` 至 demovg
+ vg
    - ```sudo vgcreate -s 16M demovg /dev/sdc1```，將 PV ```/dev/sdc1``` 加入 VG ```demovg```，其中每個  PE 大小為 16M
    - ```sudo vgscan```，檢測 vg 狀態
    - ```sudo vgdisplay demovg```，顯示 demovg 的詳細狀態
+ lv
    - ```sudo lvcreate -n lvml -L 500M demovg```，以 VG ```demovg``` 設為 LV ```lvml```，其容量為 500M，此容量大小會依據 PE 尺寸計算
    - ```sudo lvscan```，檢測 lv 狀態
    - ```sudo lvdisplay /dev/demovg/lvml```，顯示 ```/dev/demovg/lvml``` 的詳細狀態
    - ```sudo lvresize -l +32 /dev/demovg/lvml```，增加 32 個 PE 區塊以調整 LV 尺寸，可用範圍參考 ```vgdisplay```
+ 掛載
    - ```sudo mkfs.xfs /dev/demovg/lvml```，以 xfs 格式化 lvml
    - mount
        + ```sudo mkdir /data```，建立掛載目錄
        + ```sudo mount /dev/demovg/lvml /data```，將 lvml 掛在 data 目錄
    - ```sudo xfs_growfs /dev/demovg/lvml```，在 lvsize 後使用 xfs_growfs 來重新格式化
## 文獻

+ [進階檔案系統管理](https://linux.vbird.org/linux_basic_train/centos8/unit14.php)
+ [How to define multiple disks inside Vagrant using VirtualBox provider](https://sleeplessbeastie.eu/2021/05/10/how-to-define-multiple-disks-inside-vagrant-using-virtualbox-provider/)
+ [替 Linux 新增硬碟（磁碟分割、格式化與掛載）](https://blog.gtwang.org/linux/linux-add-format-mount-harddisk/)
+ [Soft RAID 在 Linux上的建置 - mdadm](https://hackmd.io/@cwhu/SkpHEAy9u)
+ [Linux LVM (建立、擴充、移除LVM磁區) 操作筆記](https://sc8log.blogspot.com/2017/03/linux-lvm-lvm.html)
