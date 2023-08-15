#!/bin/bash
set -e

# 顯示硬碟掛載資訊
df -h
# 顯示現有的硬碟目錄
lsblk
# 搜尋再 /dev 目錄下的硬碟
ls /dev/[sh]d*
# 顯示單一硬碟的詳細資訊
sudo fdisk -l /dev/sdc
# 設定分割表 ( Partition )，使用 fdisk 互動介面
# 輸入 n e [enter] [enter] [enter] w
# sudo fdisk /dev/sdc

# 軟體磁碟陣列設定
# https://hackmd.io/@cwhu/SkpHEAy9u
