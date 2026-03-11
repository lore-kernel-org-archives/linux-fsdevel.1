Received: from mail.3xo.fr (mail.3xo.fr [212.129.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0076D35E92D
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 19:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.129.21.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773258825; cv=none; b=LcLFX5HdSEmCDMgfgVWayL7rnwxbFTMyGpEPSKfxYRL0cTGu9HY4YFmqsckj4q8I4/ZxZYcqYZjCSFJ6/gzpvbLogSUUU3yX5h8Tm/2fznJM1ODCdj3nNfYcgxK55M2pDwmqpp20kWty0RbUq4SXSKOxzmZI+7xEwnBCKsTZ1aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773258825; c=relaxed/simple;
	bh=Plh9eBkik+xH8Jcn6jrzj4A0MEupx1H/O0WCJ0hWcF0=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type; b=qnEUCuNvkr2CfNHAnAg0J8qNovqrnaneLbZ7iHwCdHecZhikWeNUZkwiiFo58a7HX1fxptCG+x/keScAUaIpspjvZ3E/Uf9lbDBUPvn/rCmQu8BCiYyZRmXvRZUxGsdvvhnIFbpBqXhHBuh7PsQHGOcZpVo0riLOGpYmYyhcb/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=3xo.fr; spf=pass smtp.mailfrom=3xo.fr; dkim=pass (2048-bit key) header.d=3xo.fr header.i=@3xo.fr header.b=lvUC8Xr+; arc=none smtp.client-ip=212.129.21.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=3xo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3xo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3xo.fr header.i=@3xo.fr header.b="lvUC8Xr+"
Received: from localhost (mail.3xo.fr [212.129.21.66])
	by mail.3xo.fr (Postfix) with ESMTP id 3C7C2233;
	Wed, 11 Mar 2026 20:47:16 +0100 (CET)
X-Virus-Scanned: Debian amavis at nxo2.3xo.fr
Received: from mail.3xo.fr ([212.129.21.66])
 by localhost (mail.3xo.fr [212.129.21.66]) (amavis, port 10024) with ESMTP
 id 41WE1Yi_UxwE; Wed, 11 Mar 2026 20:47:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.3xo.fr 19515232
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3xo.fr; s=3xo;
	t=1773258434; bh=wHd1gpBPijuuZoudxOhH1OPXnP0f/tAuqzHXgEQoLpc=;
	h=Date:From:To:Cc:Subject:From;
	b=lvUC8Xr+vCdTUTceqUolfEwhYNa1eT9lPCjWxzDM9sYvzp4LIAYQgQEP9bi5qgfHR
	 RK93F3Jkc/QVtcP1NVtomELHpYeqXztDzHYv2MtBtVSxptKBifu1PsOLT6672rTLBx
	 HUn0B9i5diD65iglpL+c91bpv9NmQFbQG6oTzCJgi362J2iBg1ka3jaTFDm0Gbq3uG
	 iOFNPDjGwUSoQSI+/k/KhR1iSYh/ZLvk5biBRE46JikTaTQUnXNRMxqkbUJ84MvUf7
	 W9ZGI6RsHzEdHGbwOhK0NuIZZ5rEvJ0I+HW5fPlRufc5wH167AtJ23iZJUJBhY4Soe
	 F2LJXc0WueDBg==
Received: from mail.3xo.fr (mail.3xo.fr [212.129.21.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.3xo.fr (Postfix) with ESMTPSA id 19515232;
	Wed, 11 Mar 2026 20:47:14 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 11 Mar 2026 20:47:13 +0100
From: Nicolas Baranger <nicolas.baranger@3xo.fr>
To: Linux Fsdevel <linux-fsdevel@vger.kernel.org>
Cc: lvm-devel@redhat.com, linux-lvm@vger.kernel.org
Subject: LVM-on-LUKS boot failure when vgextend adds unused PV to root VG
Message-ID: <e92a891e9413c8102ce67e3489c6ce8d@3xo.fr>
X-Sender: nicolas.baranger@3xo.fr
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I've discovered a reproducible boot failure with LVM-on-LUKS root 
filesystems where vgextend adds a new encrypted PV to the root VG but no 
extents are allocated yet. This happens consistently on Debian 13 
(trixie) with kernel 6.12.73+deb13-amd64 (2026-02-17).

if you take a disk and create a partition which is not using all the 
space and on this partition you create a luks encrypted LVM pv you add 
to a vg as the only pv and in this vg you have an lv which hold the root 
filesystem (or usr filesystem), system is able to boot after :
update-initramfs -u
update-grub

Now if you create a second partition on the drive, you luks encrypt it 
and pvcreate the luks opened /dev/mapper/newdisk_crypt entry, system is 
able to boot after :
update-initramfs -u
update-grub

But if now you add this luks pv to the same vg and you extend one of the 
lv which hold root fs or usr fs (even if you don't extend the filesystem 
on the lv), system is able to boot after :
update-initramfs -u
update-grub

BUT NOW if you only add this luks pv to the same vg and you DON'T extend 
one of the lv which hold root fs or usr fs (you only keep free space in 
the vg and don't use the new pv at all, system will NEVER be able to 
boot , even after issuing in a rescue mode chroot :
update-initramfs -u
update-grub

It's because the new encrypted PV is simply ignored like an used drive 
by update-initramfs so system will never be able to boot , I explane: 
unlocking the first pv is not sufficient for initramfs do at boot : 
vgchange -ay and so the /dev/mapper is never populated with LVM lv which 
are in the vg and system failed to boot saying 'cannot find root 
filesystem' !

My thinking is that the initramfs-tools cryptsetup hook only processes 
crypttab entries for PVs with active extents, ignoring VG metadata that 
lists the new PV as required. LVM2 then rejects partial VG activation 
during early boot.


This seems like an initramfs-tools packaging gap: the cryptsetup hook 
should scan VG metadata on all crypttab devices during update-initramfs, 
not just "active" PVs. Alternatively, LVM2 vgchange --sysinit could 
ignore missing PVs when no extents reference them.

Can kernel/LVM2 devs confirm if vgchange -ay behavior changed recently? 
Or should initramfs generators parse pvdisplay/vgdisplay output to 
include all VG PV crypttab entries?



Here is the output after extending vgnvme/lvroot volume (and not 
filesystem) to be able to boot

/etc/crypttab

nvme0n1p3_crypt UUID=a230cf8d-f528-4384-a60a-e7ecc7776dbf none 
luks,discard,x-initrd.attach
nvme0n1p4_crypt UUID=0162ced1-c5a3-4d68-9b69-3319a9dd6946 none 
luks,discard,x-initrd.attach


/etc/fstab
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
/dev/mapper/vgnvme-lvroot /               btrfs   
defaults,subvol=@rootfs 0       0
# /boot was on /dev/nvme0n1p2 during installation
UUID=fdb7df70-1136-4401-b6c9-f5d9d4992ff3 /boot           ext4    
defaults        0       2
# /boot/efi was on /dev/nvme0n1p1 during installation
UUID=C146-1EE5  /boot/efi       vfat    umask=0077      0       1
/dev/mapper/vgnvme-lvnba /home/nba       btrfs   defaults        0       
0
/dev/mapper/vgnvme-lvusr /usr            btrfs   defaults        0       
0
/dev/mapper/vgnvme-lvvar /var            btrfs   defaults        0       
0
/dev/mapper/vgnvme-lvswap none            swap    sw              0      
  0
/dev/mapper/vgbuild-lvbuild /usr/src/build	btrfs 	defaults        0      
  0
/dev/sr0        /media/cdrom0   udf,iso9660 user,noauto     0       0


vgdisplay -v vgnvme

   --- Volume group ---
   VG Name               vgnvme
   System ID
   Format                lvm2
   Metadata Areas        2
   Metadata Sequence No  15
   VG Access             read/write
   VG Status             resizable
   MAX LV                0
   Cur LV                5
   Open LV               5
   Max PV                0
   Cur PV                2
   Act PV                2
   VG Size               29,96 GiB
   PE Size               4,00 MiB
   Total PE              7670
   Alloc PE / Size       7353 / 28,72 GiB
   Free  PE / Size       317 / <1,24 GiB
   VG UUID               QjmVbM-98cA-deAr-diFB-3fKh-TKVy-ftB533

   --- Logical volume ---
   LV Path                /dev/vgnvme/lvroot
   LV Name                lvroot
   VG Name                vgnvme
   LV UUID                s0IMxU-PVwz-N5Sn-Bjt8-5a3o-Zpxt-Q0aR2p
   LV Write Access        read/write
   LV Creation host, time deb-nba0, 2025-10-24 14:38:27 +0200
   LV Status              available
   # open                 1
   LV Size                6,00 GiB
   Current LE             1536
   Segments               3
   Allocation             inherit
   Read ahead sectors     auto
   - currently set to     256
   Block device           254:3

   --- Logical volume ---
   LV Path                /dev/vgnvme/lvswap
   LV Name                lvswap
   VG Name                vgnvme
   LV UUID                lmptPn-8oMi-Wjzg-4n5T-Vcnh-1zta-RMYeA3
   LV Write Access        read/write
   LV Creation host, time deb-nba0, 2025-10-24 14:38:45 +0200
   LV Status              available
   # open                 1
   LV Size                4,00 GiB
   Current LE             1024
   Segments               1
   Allocation             inherit
   Read ahead sectors     auto
   - currently set to     256
   Block device           254:4

   --- Logical volume ---
   LV Path                /dev/vgnvme/lvusr
   LV Name                lvusr
   VG Name                vgnvme
   LV UUID                6otcEG-o6QF-Ph7B-3P2V-y023-Xo1d-Zl3XOM
   LV Write Access        read/write
   LV Creation host, time deb-nba0, 2025-10-24 14:39:11 +0200
   LV Status              available
   # open                 1
   LV Size                11,00 GiB
   Current LE             2816
   Segments               2
   Allocation             inherit
   Read ahead sectors     auto
   - currently set to     256
   Block device           254:5

   --- Logical volume ---
   LV Path                /dev/vgnvme/lvvar
   LV Name                lvvar
   VG Name                vgnvme
   LV UUID                DlnMKs-cK5w-ns7k-Xd6F-Y3HX-mCCM-TKEDZ1
   LV Write Access        read/write
   LV Creation host, time deb-nba0, 2025-10-24 14:40:06 +0200
   LV Status              available
   # open                 1
   LV Size                4,72 GiB
   Current LE             1209
   Segments               2
   Allocation             inherit
   Read ahead sectors     auto
   - currently set to     256
   Block device           254:6

   --- Logical volume ---
   LV Path                /dev/vgnvme/lvnba
   LV Name                lvnba
   VG Name                vgnvme
   LV UUID                rWYm5R-8sBg-9PcC-r43n-aQum-Ua2S-IY0KbU
   LV Write Access        read/write
   LV Creation host, time deb-nba0, 2025-10-24 14:40:54 +0200
   LV Status              available
   # open                 1
   LV Size                3,00 GiB
   Current LE             768
   Segments               1
   Allocation             inherit
   Read ahead sectors     auto
   - currently set to     256
   Block device           254:7

   --- Physical volumes ---
   PV Name               /dev/mapper/nvme0n1p3_crypt
   PV UUID               DR12FN-Kb1R-SaWt-k8tu-hCJx-L4L3-ECuQGs
   PV Status             allocatable
   Total PE / Free PE    7163 / 0

   PV Name               /dev/mapper/nvme0n1p4_crypt
   PV UUID               tXE5nq-fBS9-lRjy-dV16-j5dG-kste-389QoN
   PV Status             allocatable
   Total PE / Free PE    507 / 317


pvdisplay


   --- Physical volume ---
   PV Name               /dev/mapper/nvme0n1p3_crypt
   VG Name               vgnvme
   PV Size               27,98 GiB / not usable 4,00 MiB
   Allocatable           yes (but full)
   PE Size               4,00 MiB
   Total PE              7163
   Free PE               0
   Allocated PE          7163
   PV UUID               DR12FN-Kb1R-SaWt-k8tu-hCJx-L4L3-ECuQGs

   --- Physical volume ---
   PV Name               /dev/mapper/nvme0n1p4_crypt
   VG Name               vgnvme
   PV Size               1,98 GiB / not usable 4,00 MiB
   Allocatable           yes
   PE Size               4,00 MiB
   Total PE              507
   Free PE               317
   Allocated PE          190
   PV UUID               tXE5nq-fBS9-lRjy-dV16-j5dG-kste-389QoN



Let me know if you need more informations,
Thanks for looking

Kind regards
Nicolas Baranger
