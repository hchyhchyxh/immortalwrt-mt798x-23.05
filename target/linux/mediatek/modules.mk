define KernelPackage/ata-ahci-mtk
  TITLE:=Mediatek AHCI Serial ATA support
  KCONFIG:=CONFIG_AHCI_MTK
  FILES:= \
	$(LINUX_DIR)/drivers/ata/ahci_mtk.ko \
	$(LINUX_DIR)/drivers/ata/libahci_platform.ko
  AUTOLOAD:=$(call AutoLoad,40,libahci libahci_platform ahci_mtk,1)
  $(call AddDepends/ata)
  DEPENDS+=@(TARGET_mediatek_mt7622||TARGET_mediatek_mt7623)
endef

define KernelPackage/ata-ahci-mtk/description
 Mediatek AHCI Serial ATA host controllers
endef

$(eval $(call KernelPackage,ata-ahci-mtk))

define KernelPackage/btmtkuart
  SUBMENU:=Other modules
  TITLE:=MediaTek HCI UART driver
  DEPENDS:=@TARGET_mediatek_mt7622 +kmod-bluetooth +mt7622bt-firmware
  KCONFIG:=CONFIG_BT_MTKUART
  FILES:= \
	$(LINUX_DIR)/drivers/bluetooth/btmtkuart.ko
  AUTOLOAD:=$(call AutoProbe,btmtkuart)
endef

$(eval $(call KernelPackage,btmtkuart))

define KernelPackage/sdhci-mtk
  SUBMENU:=Other modules
  TITLE:=Mediatek SDHCI driver
  DEPENDS:=@TARGET_mediatek_mt7622 +kmod-sdhci
  KCONFIG:=CONFIG_MMC_MTK 
  FILES:= \
	$(LINUX_DIR)/drivers/mmc/host/mtk-sd.ko
  AUTOLOAD:=$(call AutoProbe,mtk-sd,1)
endef

$(eval $(call KernelPackage,sdhci-mtk))

define KernelPackage/mediatek_hnat
  SUBMENU:=Network Devices
  TITLE:=Mediatek HNAT module
  DEPENDS:=@TARGET_mediatek +kmod-nf-conntrack +wireless-tools +@KERNEL_WIRELESS_EXT
  AUTOLOAD:=$(call AutoLoad,20,mtkhnat)
  MODPARAMS.mtkhnat:=ppe_cnt=2
  KCONFIG:= \
	CONFIG_BRIDGE_NETFILTER=y \
	CONFIG_NETFILTER_FAMILY_BRIDGE=y \
	CONFIG_NET_MEDIATEK_HNAT
  FILES:= \
        $(LINUX_DIR)/drivers/net/ethernet/mediatek/mtk_hnat/mtkhnat.ko
endef

define KernelPackage/mediatek_hnat/description
  Kernel modules for MediaTek HW NAT offloading
endef

$(eval $(call KernelPackage,mediatek_hnat))
