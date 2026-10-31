Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793589018;
	b=3gaUk+/GdfWdR5TQO25fVKAcqb1kAutOKNKp4mF+RrD+riITq7I1Rg1xw6ojmIAR4Coo
	 HomkTNpvZ4X2PKnEqRxy6YrpZy/o/RBg/xCZbq2lrGCXNc3Ky39SHqz9jTIZyHBzvpZzk
	 0uJRe9+7+5Jnr0xGtBy8eHjgk1tIiVzzNRO9u9VIRw+Q68kgEvVtyMvUhSbQxfc7Q1rp5
	 E4vGMkCxEJKCPS0lucDnAc4Zbx8k7IEdMMv/WeTsYwg15cFon9/dP3jRm59s2XTQEZse5
	 nsNKZZSfEVBRDkqhKzEelYfIBlOt9r93R9+Jt6/OBismlSeixv2wLm54OKR72AZbOCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793589018;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:X-OQ-MSGID:Date:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=iWb5wYhyScfSR++sA8B4O1T/vltG9PXR7zYJa2P/nhU=;
	b=A2YNWxmS6Kla/wO2Xn/qguivTANFoGLY0+szibAWBPKXn5vL6Z6mRV+wTk3rlF3xBILC
	 fiJg6N/FHh1h2wBk7lx9REQmOtN1IcpPwcP/uHyohSQV9thuJCZBqQGuz4tvHLGKSP9tI
	 uGbvrhWrHkw5POLFYGPJyqy7iGIk2UPm8RRRDaURWJBUFZMXo08ERVpQWE1yuF6rEe2fk
	 y9il0b1+4QRWfeht34dBq8KUzv75zhhTjgxUt2rjBK+xObxc0o/biJseVIbYDYY14xX7Y
	 RSm0iKMj2Ng0nD4Ff3iS/kSND8SEHzvsXVnND9M1t/bc+5Sog4YlBE+7smt3s2hTLbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=lsp0wptZ;
	arc=none smtp.remote-ip=162.62.57.210
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71103606A324;
	Mon,  2 Nov 2026 03:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71103606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=lsp0wptZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793589004; bh=iWb5wYhyScfSR++sA8B4O1T/vltG9PXR7zYJa2P/nhU=;
	h=From:To:Cc:Subject:Date;
	b=lsp0wptZ2mVVWPIEjumk7K9SbYCoTJU4RKkKm0ZUbRfYup5Rd/LslwADvMuLCZkO+
	 JeL+SsiHSC452NhxAFQPb/iByGOnpM589FHgmcTjGK+sv/lLygGoGA4JosE9I7f/pC
	 1iRMmd0gcDjh9vwdHwjJYsS6omTBecQdLxwsiaAA=
Received: from [172.18.4.77] ([111.31.227.58])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 28316E88; Mon, 02 Nov 2026 11:10:03 +0800
X-QQ-mid: xmsmtpt1793589003toc4k5i77
Message-ID: <tencent_EAB5D4A0EF9A112F271AD38CA80E1FA5A807@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9X+HFIBTraNruENJyTFijhQnt6tSKm/E84ZvfrCwILH3QcOioBCD
	 odLOfrsUtZLUHMzO7kDBKK8TAuyAMwINiVHrv2eHIhbnVNWDo2jUXfpQwR1tRU95bzXJW2N6o/VS
	 IQELJqJVIXQ15Q2Vf3mhKURq68NVAv2jU6QmLNyC+KqbLOJPGnVat+7Z9olL9Fm/bQ/7fCMsCF7x
	 ZYFKhG99LSSN5lXeLroGbVosjwW+Ib1FmCrJDIBXwYRqiLcgJGcrpcV6V0eSMWf2U24fiZms0kNY
	 lK/7Z3t2PaqbadUqL1CZVvnYm3wM7NtpZjsJneohkLlQyAUVgo7cX1Sj5XyOnGZX+PrMW0mf1uOU
	 am0j0F36B6k1bLMiC0O3CYFu4LipMOXuNZEA7CkX4POTImMukdVTIsBq9ywlqaUa2YbqlZp3YTtS
	 7TZHuuf8cxFBRGH3wBcrkzR0kcsOf6s7EwcEkuU3TzfHvSdXTBO7CZZoWpigOA0+RpMEHHdOgKJz
	 iov77dFskM7k8yVmsEPAV8sF2+AUYsHl++A2Ck3tkHkvlo3CXidr0iEPjIIlrmvHWPG+KYX7Hkxh
	 kbq8EHfPsJ+olOsPv9nCLi9LlMebXQVKPNnQWQ1fWW4JVaLwIdzsrhV4mWZA6NzpcvnH/Qy+6kv1
	 dI8NNlGpk4VzGwJm+qUyNEpI9qOBwasVCgtJKCUFDMWCBvS3hRV4zfssiB4tsJRTIdGKK2s7CR23
	 UIV3hatwDzezGMKPmwRC/8MvoYzwDtVCj8A4zv0aTFjMbFvdCjsxLHSsstvkOld4yqEMx0liQpfG
	 LtgScHQBm6PtkCwoGzj5Jyq3CI8tFwhWs3mMY3eBzs/5cZwDM6byw13fEglfEIY82wf2pDeoGRyk
	 RuPE1kBjNiE4mJ7k5ktAnAd92SsSFYFCEfd9Ax8T0H+s2brrs0X3YVbeBSAZIjZXZi3uy2kysIUR
	 BIoePKqN8yy5NT+kZK+/M8LSrVJOtLTikTnatZLQQ2OOgpNwFXrTCK1Dd0YZNCXK55BO4pfuooeI
	 iv0flwJE+YYah7TMkxQE56DERNR3VTeJypX2es1wC+7qKqDayChL34LBXMHInHtr88uM9sBTWXfi
	 pEBRQJ5/7eHcT1CZE=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Guikun Yang <yangguikun19@qq.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>
Subject: [Bug report] ufs: fs_cgsize from the superblock indexes struct
 ufs_buffer_head.bh[8] unchecked - UBSAN out-of-bounds on the first allocation
 after remount-rw
X-OQ-MSGID: <c5-ufs-cgsize-ubsan-20261031@qq.com>
Date: Sat, 31 Oct 2026 20:30:00 +0800
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Christian Brauner, Jan Kara
Subject: [Bug report] ufs: fs_cgsize from the superblock indexes
 struct ufs_buffer_head.bh[8] unchecked - UBSAN out-of-bounds on the first
 allocation after remount-rw

Hi,

While testing on-disk field corruption in the UFS driver, we found that
the superblock's fs_cgsize field is copied into uspi->s_cgsize without any
range check, and is then used as a block count that indexes the fixed-size
bh[UFS_MAXFRAG] array. A crafted value writes up to 120 pointers past the
end of that array (UBSAN array-index-out-of-bounds), panicking the kernel
on the first allocation after a read-write remount.

The code, fs/ufs/super.c:

    uspi->s_cgsize = fs32_to_cpu(sb, usb1->fs_cgsize);   /* no validation */

fs/ufs/cylinder.c:

    UCPI_UBH(ucpi)->count = uspi->s_cgsize >> sb->s_blocksize_bits;
    ...
    UCPI_UBH(ucpi)->bh[0] = sbi->s_ucg[cgno];
    for (i = 1; i < UCPI_UBH(ucpi)->count; i++)
        UCPI_UBH(ucpi)->bh[i] = sb_bread(sb, UCPI_UBH(ucpi)->fragment + i);

struct ufs_buffer_head.bh has UFS_MAXFRAG = UFS_BSIZE / UFS_FSIZE = 8
entries. With ufstype=44bsd the fragment size is 512 and the block size
set by sb_set_blocksize() is also 512, so a normal s_cgsize of 2048 gives
count = 4. A crafted s_cgsize of 0x10000 gives count = 128, i.e. 120
stores past bh[7], overwriting the fields that follow the array in struct
ufs_cg_private_info.

Trigger: a hand-built UFS1 image (44BSD layout; there is no mkfs.ufs on
Linux) with fs_cgsize changed from 2048 to 0x10000, and cylinder group
blocks whose cs_nbfree/cs_nifree are zeroed so the allocator reaches
cg_found:

    mount -o ro -t ufs -o ufstype=44bsd /dev/vda /mnt   (succeeds)
    mount -o remount,rw /mnt
    mkdir /mnt/d1                                      (first allocation)

    UBSAN: array-index-out-of-bounds in fs/ufs/cylinder.c:50:21
    index 8 is out of range for type 'buffer_head *[8]'
    Call Trace:
     __ubsan_handle_out_of_bounds
     ufs_read_cylinder
     ufs_load_cylinder
     ufs_new_inode
     ufs_mkdir
    Kernel panic - not syncing: UBSAN: panic_on_warn set ...

Reproduced 3/3 on a self-built 7.3.0 kernel (CONFIG_UFS_FS=y,
CONFIG_UFS_FS_WRITE=y, CONFIG_UBSAN=y, CONFIG_UBSAN_BOUNDS=y) under
QEMU/KVM. A control image with fs_cgsize = 2048 runs the same sequence
without an out-of-bounds access (the mkdir then fails normally with
ENOSPC). The field and the missing bound are unchanged in current
mainline.

A natural fix is to validate s_cgsize when the superblock is read:
reject s_cgsize < s_fsize or (s_cgsize >> s_blocksize_bits) > UFS_MAXFRAG,
which also covers the zero case. Happy to test a patch.

We report this as a crafted-image robustness issue: the crash is a plain
UBSAN out-of-bounds violation reachable from a normal ro-mount,
remount-rw and a single mkdir.

The reproducer (image with the flipped field, a clean control image,
the run script, a guest init that mounts ro, remounts rw and mkdirs, and
the image builder with the field offsets) is available on request.

Kernel: self-built 7.3.0, CONFIG_UFS_FS=y, CONFIG_UFS_FS_WRITE=y,
CONFIG_UBSAN=y; QEMU/KVM x86_64, 1 vCPU.

Thanks,
Guikun Yang

