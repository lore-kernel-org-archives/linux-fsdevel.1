Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EAB3C73F8
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 15:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773331006; cv=none; b=o4tZ/CGT67MeEWHjohRVDFnCoikVBPmEQ82t7kYIRgMRNlMr+V+7G+hIyqZyj5feGErLixsalb6l+DlxOKq1dEkLccjA2960BV4cfDQMlWBCSgCi+oTBFnc4RoEIk6DaDJ5jjSgPkXHlKEMVmUcfVVbDJrz5TF+CEo/wVQk059g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773331006; c=relaxed/simple;
	bh=HRZ6AcvAB0fRFWxNJ62vXWcV3BPUiygXH++ehzp9D6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhQaROL5+I7L82YHs7b6HW2l+NNbP2VAx3lvcGAZ0mr1iVFfBU8Ld0azHikKXPmlrbg9HXngwFmasNk5JbyNErbcdqOiHx8Fs2mCPVV+oiKWI8k0oD7o1pUbHwGnOisxKPLo4TjREYzkYvajXOeXTcKPasGyWr+gZCWyEaxLo6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKmoAVmY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKmoAVmY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64ACC2BC86;
	Thu, 12 Mar 2026 15:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773331005;
	bh=HRZ6AcvAB0fRFWxNJ62vXWcV3BPUiygXH++ehzp9D6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lKmoAVmYu+iv3XYcnRU4svZYfwliHQQ8J9y7K/shPUo3OLq3ptNgl8xjMXHZeGLcB
	 MXDfaQ2/9FYZQNgH7zotgSTh972rj9BplDlcqomqUQAEk7dC3SbtCEeOxQTsguYZ9o
	 5oiZGZRxSUe+aJj40MIJGFakbhr8lojsfkJLhETULpctB+rfOs1zpFqEpCVkOw5u6R
	 UKCTmqN6gll3L8qqloGuhVNo1NiEKP/Z8if33Ir09CmVIKdoUFGv7Y6+nMlqr10zLe
	 ZQpb7rHF+RMAsZyAzudnNC1/SgCKWPI5qjCRx4lL97xdoSIDx6iNeLYWbPyLl0FQ/K
	 kYcfWMdQ649BA==
Date: Thu, 12 Mar 2026 08:56:45 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Nicolas Baranger <nicolas.baranger@3xo.fr>
Cc: Linux Fsdevel <linux-fsdevel@vger.kernel.org>, lvm-devel@redhat.com,
	linux-lvm@vger.kernel.org
Subject: Re: LVM-on-LUKS boot failure when vgextend adds unused PV to root VG
Message-ID: <20260312155645.GC1742010@frogsfrogsfrogs>
References: <e92a891e9413c8102ce67e3489c6ce8d@3xo.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e92a891e9413c8102ce67e3489c6ce8d@3xo.fr>

On Wed, Mar 11, 2026 at 08:47:13PM +0100, Nicolas Baranger wrote:
> Hi,
> 
> I've discovered a reproducible boot failure with LVM-on-LUKS root
> filesystems where vgextend adds a new encrypted PV to the root VG but no
> extents are allocated yet. This happens consistently on Debian 13 (trixie)
> with kernel 6.12.73+deb13-amd64 (2026-02-17).
> 
> if you take a disk and create a partition which is not using all the space
> and on this partition you create a luks encrypted LVM pv you add to a vg as
> the only pv and in this vg you have an lv which hold the root filesystem (or
> usr filesystem), system is able to boot after :
> update-initramfs -u
> update-grub
> 
> Now if you create a second partition on the drive, you luks encrypt it and
> pvcreate the luks opened /dev/mapper/newdisk_crypt entry, system is able to
> boot after :
> update-initramfs -u
> update-grub
> 
> But if now you add this luks pv to the same vg and you extend one of the lv
> which hold root fs or usr fs (even if you don't extend the filesystem on the
> lv), system is able to boot after :
> update-initramfs -u
> update-grub
> 
> BUT NOW if you only add this luks pv to the same vg and you DON'T extend one
> of the lv which hold root fs or usr fs (you only keep free space in the vg
> and don't use the new pv at all, system will NEVER be able to boot , even
> after issuing in a rescue mode chroot :
> update-initramfs -u
> update-grub
> 
> It's because the new encrypted PV is simply ignored like an used drive by
> update-initramfs so system will never be able to boot , I explane: unlocking
> the first pv is not sufficient for initramfs do at boot : vgchange -ay and
> so the /dev/mapper is never populated with LVM lv which are in the vg and
> system failed to boot saying 'cannot find root filesystem' !
> 
> My thinking is that the initramfs-tools cryptsetup hook only processes
> crypttab entries for PVs with active extents, ignoring VG metadata that
> lists the new PV as required. LVM2 then rejects partial VG activation during
> early boot.
> 
> 
> This seems like an initramfs-tools packaging gap: the cryptsetup hook should
> scan VG metadata on all crypttab devices during update-initramfs, not just
> "active" PVs. Alternatively, LVM2 vgchange --sysinit could ignore missing
> PVs when no extents reference them.
> 
> Can kernel/LVM2 devs confirm if vgchange -ay behavior changed recently? Or
> should initramfs generators parse pvdisplay/vgdisplay output to include all
> VG PV crypttab entries?

IIIRC LVM has defaulted to ignoring partially present VGs for quite a
long time, so I think you're really asking if the initramfs scripts (or
dracut, or whatever Debian's transitioning towards) could add
--activationmode=partial.

--D
> 
> 
> 
> Here is the output after extending vgnvme/lvroot volume (and not filesystem)
> to be able to boot
> 
> /etc/crypttab
> 
> nvme0n1p3_crypt UUID=a230cf8d-f528-4384-a60a-e7ecc7776dbf none
> luks,discard,x-initrd.attach
> nvme0n1p4_crypt UUID=0162ced1-c5a3-4d68-9b69-3319a9dd6946 none
> luks,discard,x-initrd.attach
> 
> 
> /etc/fstab
> # <file system> <mount point>   <type>  <options>       <dump>  <pass>
> /dev/mapper/vgnvme-lvroot /               btrfs   defaults,subvol=@rootfs 0
> 0
> # /boot was on /dev/nvme0n1p2 during installation
> UUID=fdb7df70-1136-4401-b6c9-f5d9d4992ff3 /boot           ext4    defaults
> 0       2
> # /boot/efi was on /dev/nvme0n1p1 during installation
> UUID=C146-1EE5  /boot/efi       vfat    umask=0077      0       1
> /dev/mapper/vgnvme-lvnba /home/nba       btrfs   defaults        0       0
> /dev/mapper/vgnvme-lvusr /usr            btrfs   defaults        0       0
> /dev/mapper/vgnvme-lvvar /var            btrfs   defaults        0       0
> /dev/mapper/vgnvme-lvswap none            swap    sw              0       0
> /dev/mapper/vgbuild-lvbuild /usr/src/build	btrfs 	defaults        0       0
> /dev/sr0        /media/cdrom0   udf,iso9660 user,noauto     0       0
> 
> 
> vgdisplay -v vgnvme
> 
>   --- Volume group ---
>   VG Name               vgnvme
>   System ID
>   Format                lvm2
>   Metadata Areas        2
>   Metadata Sequence No  15
>   VG Access             read/write
>   VG Status             resizable
>   MAX LV                0
>   Cur LV                5
>   Open LV               5
>   Max PV                0
>   Cur PV                2
>   Act PV                2
>   VG Size               29,96 GiB
>   PE Size               4,00 MiB
>   Total PE              7670
>   Alloc PE / Size       7353 / 28,72 GiB
>   Free  PE / Size       317 / <1,24 GiB
>   VG UUID               QjmVbM-98cA-deAr-diFB-3fKh-TKVy-ftB533
> 
>   --- Logical volume ---
>   LV Path                /dev/vgnvme/lvroot
>   LV Name                lvroot
>   VG Name                vgnvme
>   LV UUID                s0IMxU-PVwz-N5Sn-Bjt8-5a3o-Zpxt-Q0aR2p
>   LV Write Access        read/write
>   LV Creation host, time deb-nba0, 2025-10-24 14:38:27 +0200
>   LV Status              available
>   # open                 1
>   LV Size                6,00 GiB
>   Current LE             1536
>   Segments               3
>   Allocation             inherit
>   Read ahead sectors     auto
>   - currently set to     256
>   Block device           254:3
> 
>   --- Logical volume ---
>   LV Path                /dev/vgnvme/lvswap
>   LV Name                lvswap
>   VG Name                vgnvme
>   LV UUID                lmptPn-8oMi-Wjzg-4n5T-Vcnh-1zta-RMYeA3
>   LV Write Access        read/write
>   LV Creation host, time deb-nba0, 2025-10-24 14:38:45 +0200
>   LV Status              available
>   # open                 1
>   LV Size                4,00 GiB
>   Current LE             1024
>   Segments               1
>   Allocation             inherit
>   Read ahead sectors     auto
>   - currently set to     256
>   Block device           254:4
> 
>   --- Logical volume ---
>   LV Path                /dev/vgnvme/lvusr
>   LV Name                lvusr
>   VG Name                vgnvme
>   LV UUID                6otcEG-o6QF-Ph7B-3P2V-y023-Xo1d-Zl3XOM
>   LV Write Access        read/write
>   LV Creation host, time deb-nba0, 2025-10-24 14:39:11 +0200
>   LV Status              available
>   # open                 1
>   LV Size                11,00 GiB
>   Current LE             2816
>   Segments               2
>   Allocation             inherit
>   Read ahead sectors     auto
>   - currently set to     256
>   Block device           254:5
> 
>   --- Logical volume ---
>   LV Path                /dev/vgnvme/lvvar
>   LV Name                lvvar
>   VG Name                vgnvme
>   LV UUID                DlnMKs-cK5w-ns7k-Xd6F-Y3HX-mCCM-TKEDZ1
>   LV Write Access        read/write
>   LV Creation host, time deb-nba0, 2025-10-24 14:40:06 +0200
>   LV Status              available
>   # open                 1
>   LV Size                4,72 GiB
>   Current LE             1209
>   Segments               2
>   Allocation             inherit
>   Read ahead sectors     auto
>   - currently set to     256
>   Block device           254:6
> 
>   --- Logical volume ---
>   LV Path                /dev/vgnvme/lvnba
>   LV Name                lvnba
>   VG Name                vgnvme
>   LV UUID                rWYm5R-8sBg-9PcC-r43n-aQum-Ua2S-IY0KbU
>   LV Write Access        read/write
>   LV Creation host, time deb-nba0, 2025-10-24 14:40:54 +0200
>   LV Status              available
>   # open                 1
>   LV Size                3,00 GiB
>   Current LE             768
>   Segments               1
>   Allocation             inherit
>   Read ahead sectors     auto
>   - currently set to     256
>   Block device           254:7
> 
>   --- Physical volumes ---
>   PV Name               /dev/mapper/nvme0n1p3_crypt
>   PV UUID               DR12FN-Kb1R-SaWt-k8tu-hCJx-L4L3-ECuQGs
>   PV Status             allocatable
>   Total PE / Free PE    7163 / 0
> 
>   PV Name               /dev/mapper/nvme0n1p4_crypt
>   PV UUID               tXE5nq-fBS9-lRjy-dV16-j5dG-kste-389QoN
>   PV Status             allocatable
>   Total PE / Free PE    507 / 317
> 
> 
> pvdisplay
> 
> 
>   --- Physical volume ---
>   PV Name               /dev/mapper/nvme0n1p3_crypt
>   VG Name               vgnvme
>   PV Size               27,98 GiB / not usable 4,00 MiB
>   Allocatable           yes (but full)
>   PE Size               4,00 MiB
>   Total PE              7163
>   Free PE               0
>   Allocated PE          7163
>   PV UUID               DR12FN-Kb1R-SaWt-k8tu-hCJx-L4L3-ECuQGs
> 
>   --- Physical volume ---
>   PV Name               /dev/mapper/nvme0n1p4_crypt
>   VG Name               vgnvme
>   PV Size               1,98 GiB / not usable 4,00 MiB
>   Allocatable           yes
>   PE Size               4,00 MiB
>   Total PE              507
>   Free PE               317
>   Allocated PE          190
>   PV UUID               tXE5nq-fBS9-lRjy-dV16-j5dG-kste-389QoN
> 
> 
> 
> Let me know if you need more informations,
> Thanks for looking
> 
> Kind regards
> Nicolas Baranger
> 
