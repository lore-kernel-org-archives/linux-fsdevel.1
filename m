Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B74283FD4
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 05:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773121451; cv=pass; b=t8PLms52hsE+zODXBiUPCrJ7VipfG/3L2aMZE0pZG6UMwPCg/liWRAbovEnNNsM4o7eY0sPT7BqWQhn/Rx7FIUS8HAfOTUZ7hue2NkLIRHNF5Q9GI89m7+SXRHGTj4YGysaPzwJFP4FPVX+HYq0lRYcSHW5i13kJYtm9N0VX/tY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773121451; c=relaxed/simple;
	bh=sVqypKITDjFxCTIgTlS/7JwBN0JctN97tYxzFz2JU+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N2Gdu5PJ26qwftaGdKMGEXpn3k6kB3smCvy7RzIEQ8RrC8R2ZwMvLzqtPb+oCOAUeoOxE48LdpXsQAjNX58rLfY8PBiTf6oS9EOFJgyOCBc3P5JHke8BkVFr50HElGkvRzMRw4w0ySfbic+MyqVyRvtJG0xRyUIcli/xpx4Vg9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CO5EaTcv; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CO5EaTcv"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2aea41d4fbcso1979745ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2026 22:44:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773121449; cv=none;
        d=google.com; s=arc-20240605;
        b=UHLRO0Dx//Ba2t8KYLqWUa6cFlwkmS21e+dmAMmdb8JEJW9x2Nq51uoC4RRwvCitWt
         zt/O8Zd/UYHveOrlxg+jdxUKTpzELUkDOaN27CxXeWdoIMyEq96YJR7jzqZZ8N2y8Eir
         YkgbdQ9jV6tK7pvQRlNw3wctXathh/4zbKHKPEliaC3J/E1mGiASH/2t1UYqcK2KLKtz
         5ZLDwrTPfFkHyf+RfNZRE8yOOWYLn8aEL2VZkbTpaRbZKC/yRkUmrbo/Ibbo0EKs1OAm
         x6BwGme5m6kLlB57auf7ytFt9RUjkprud8JrarqoLGrUNpJxZtbiMdjISCAwSkztYNrJ
         jskg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F4m+A154BuHEiz14TltKpoOn1Z/cpCQPLeA8P1aKjZQ=;
        fh=j28NkJmG6ISWlwbBG102H5keesPz7TCUv1yR+dCYCMQ=;
        b=ITnErDwb2L6VQVC/o1EXbdsJn7q/MH28MWv5yTInHLU8zQKklaeBv16fy4zQn+IAPn
         D+PJlGKeFRH5Two7FPaBmYwqNYwQBeUZjA75/EOAYRzZP+zSXuGqnofTanwVakoZ5m9/
         3BLsIrtP6KaypdDDUDiYiptoMhDq7yey4Wz9vUZmnPCOxaBTiBJcWzQBWYi3GvdWCw60
         ukWjIHAMW/PTUcC9b0z7VcsR/X64hU/FW9EeGch/E8Cgvx1ArwTdKxPtu84TVmQ8zoPA
         bvvKDIbWIVw0FU60029cKRdVVW2rhA88mQFHoiOIIYLz7jMltkHBqTgTMikbtM54ZP8Y
         tzSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773121449; x=1773726249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4m+A154BuHEiz14TltKpoOn1Z/cpCQPLeA8P1aKjZQ=;
        b=CO5EaTcvd64j+tTnm817rJxSdk1X17foVsnb6ha7o/ZwYBgCG+QW1pEsszuExKXm0b
         Ke5kasK7JU97S8dvXem1hhhpwCSjp6B/HvQTefbS242jTaT/SABnYViycHYHszQBseGP
         /ixjHswTYJsVIF6XZ4+3+0BynRyj/F1f8gTLgFNpnBGgYYVHRe/HuOlpTA6bECgs7Xpc
         4GsFAD2Ytcv6P6bdSZHDcfDQClmfI06ppOZHxRavs1ww0PK98fhkOCJ7zk5mC8nv/cma
         eQRe9VJLz17ccqfPZr9PbQnGsvv7GOFSUTED2+gXs94xZCLHW1R/k296TStrXmVtD5an
         7ZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773121449; x=1773726249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F4m+A154BuHEiz14TltKpoOn1Z/cpCQPLeA8P1aKjZQ=;
        b=NX6lksrVeM7OtHrR1nEC2cu4MFJp7JcsAfszx7N1oDsLCRR5mDg3w9leamwu6Yt9Uq
         KKrN/0iHIhFrx0fUCY7Yl70o7XR2H93BexU/MRb8lc+SX8353ir4cFfOfGjgShqm9J2W
         4vUV30LgebKyHKFiiQqay0Dv0cF+D1sixSrlAFCsrH1zZdVa4Fw29k9svdaB5a1rBqeL
         nDckyi8TzLuuSXzucxuLSXT/eqPLv3qqOew3szbTlMxN1y1VIHNssFWJ287tgWq4IHmL
         tyP2tSua3T6J5QGE4Yx/8+bmSXb8xJdfh1tW8mYUfE+qpkqILCW/5YiYQflq4oAG1Wpc
         wLIw==
X-Gm-Message-State: AOJu0YycDzjNNwgInIIdxAdZPEbGhpeSqEj4dGms9trKizETyJq5Ap5P
	Ql6Si4V4FNSKHc76ob+Hu4oGG+4mpWBQB9cGSrDVdS0U3Y2LNBnndFNCck8rp/Q3XE+F8anNnRk
	uJoA4C5e0TIcmd1OXte9k2sksaYA8P+p0s5jjn3w=
X-Gm-Gg: ATEYQzyf8juNe+tHYmTGUJxd2mTYigeDi87JxlFR1aSf41D2PZj7Q5/nEcwYwlQPtJ6
	tVFP2dUVEWI5FZSHBHDVlQHpxRKHUN2/m+aOkWNRlCtSAFv0a4VmkozGY77CQ1ZOIvXN4+vKV8X
	fn9wrbA22NrEz0BxxIyl8PZ7HxFtL+NtaFYjHeBjCVJElvvA/9Shdw4m7aEqA4UKMjcYQDd0z3+
	g+t8l4xNRwQL1CjzlVOTK5DAiSiMYTMf70XqdARxgDhY3VnLK0MC6Jcq7eZVgMoUUyMHa7we9ZZ
	fB3J9q8=
X-Received: by 2002:a17:903:ac4:b0:2ae:7ee0:ab3 with SMTP id
 d9443c01a7336-2ae82458457mr141151585ad.38.1773121448747; Mon, 09 Mar 2026
 22:44:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP_j_b8JGqP2_=5bZ2Jepv1tBBb08wcjY5tJ5f=QAtDj+QdZoQ@mail.gmail.com>
In-Reply-To: <CAP_j_b8JGqP2_=5bZ2Jepv1tBBb08wcjY5tJ5f=QAtDj+QdZoQ@mail.gmail.com>
From: Hyungjung Joo <jhj140711@gmail.com>
Date: Tue, 10 Mar 2026 14:43:57 +0900
X-Gm-Features: AaiRm52xl5Y0D_70fJOlceITlkkHDicQmnoGonc31uCDoOfJrex7-4Duyku4cwM
Message-ID: <CAP_j_b8YXvZT_r80zDX-Q0VZAXQ-03vqmFHhuPJZrROfEMTgDg@mail.gmail.com>
Subject: Re: [BUG] adfs: mount-time null-ptr-deref in range [0x10-0x17] in adfs_read_map()
To: linux-fsdevel@vger.kernel.org, brauner@kernel.org
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	kees@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I am commenting on additional information that reported a filesystem
bug reproduced on the current mainline with
KASAN enabled.

Target file: fs/adfs/map.c
Subsystem: fs/adfs
Git head: 5ee8dbf54602dc340d6235b1d6aa17c0f283f48c
Kernel release: 7.0.0-rc2+

Root cause:
The boot-block mount path accepts a disc record with `nzones=3D=3D0`
because `adfs_validate_bblk()` only gates on `adfs_checkbblk()` and
`adfs_checkdiscrecord()`, and `adfs_checkdiscrecord()` never enforces
a nonzero zone count. `adfs_read_map()` then computes `nzones =3D
dr->nzones | dr->nzones_high << 8`, calls `kmalloc_objs(*dm, nzones)`
with zero, gets a `ZERO_SIZE_PTR` rather than `NULL`, and immediately
passes it to `adfs_map_layout()`, which writes `dm[0]` and later
`dm[nzones - 1]`, causing a mount-time kernel null/low-address
dereference.

Reproducer
C reproducer: https://pastebin.com/raw/CX7gindX
KASAN full log: https://pastebin.com/raw/f9daNJxv
Kernel config: https://pastebin.com/raw/r9FAJk2b

Key config options:
- CONFIG_KASAN=3Dy
- CONFIG_KASAN_GENERIC=3Dy
- CONFIG_KASAN_MULTI_SHOT=3Dy
- CONFIG_DEBUG_KERNEL=3Dy
- CONFIG_FRAME_POINTER=3Dy
- CONFIG_ADFS_FS=3Dy
- CONFIG_BLK_DEV_LOOP=3Dy

Brief KASAN call trace:
[  158.823801][  T146] Oops: general protection fault, probably for
non-canonical address 0xdffffc0000000002: 0000 [#1] SMP
DEBUG_PAGEALLOC KASAN NOPTI
[  158.824306][  T146] KASAN: null-ptr-deref in range
[0x0000000000000010-0x0000000000000017]
[  158.824306][  T146] RIP: 0010:adfs_read_map+0x420/0xbc0
[  158.824306][  T146] Call Trace:
[  158.824306][  T146]  adfs_probe+0x3b7/0x540
[  158.824306][  T146]  adfs_fill_super+0x179/0x640
[  158.824306][  T146]  get_tree_bdev_flags+0x3aa/0x680
[  158.824306][  T146]  vfs_get_tree+0x98/0x380
[  158.824306][  T146]  fc_mount+0x1f/0x240
[  158.824306][  T146]  do_new_mount+0x3d6/0x700
[  158.824306][  T146]  path_mount+0x4bb/0x1500
[  158.824306][  T146]  __x64_sys_mount+0x2a8/0x340
[  158.824306][  T146]  do_syscall_64+0x141/0x940
[  158.824306][  T146]  entry_SYSCALL_64_after_hwframe+0x77/0x7f

Reproducibility notes:
- observed crash: mount-time null-ptr-deref in range
[0x0000000000000010-0x0000000000000017] in adfs_read_map()
- rootfs mode: busybox
- guest /init runs the case-specific trigger binary automatically

If you need anything else, please let me know.
Thank you.

Best regards,
Hyungjung Joo, jhj140711@gmail.com

2026=EB=85=84 3=EC=9B=94 8=EC=9D=BC (=EC=9D=BC) PM 5:44, =EC=A3=BC=ED=98=95=
=EC=A0=95 <jhj140711@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

>
> Hello,
>
> I am reporting a filesystem bug reproduced on current mainline with
> KASAN enabled.
>
> Target file: fs/adfs/map.c
> Subsystem: fs/adfs
> Git head: 5ee8dbf54602dc340d6235b1d6aa17c0f283f48c
> Kernel release: 7.0.0-rc2+
> Case ID: case-20260306T142346Z-30e0
>
> Root cause:
> The boot-block mount path accepts a disc record with `nzones=3D=3D0`
> because `adfs_validate_bblk()` only gates on `adfs_checkbblk()` and
> `adfs_checkdiscrecord()`, and `adfs_checkdiscrecord()` never enforces
> a nonzero zone count. `adfs_read_map()` then computes `nzones =3D
> dr->nzones | dr->nzones_high << 8`, calls `kmalloc_objs(*dm, nzones)`
> with zero, gets a `ZERO_SIZE_PTR` rather than `NULL`, and immediately
> passes it to `adfs_map_layout()`, which writes `dm[0]` and later
> `dm[nzones - 1]`, causing a mount-time kernel null/low-address
> dereference.
>
> Observed crash: mount-time null-ptr-deref in range
> [0x0000000000000010-0x0000000000000017] in adfs_read_map()
>
> KASAN excerpt:
> [  144.659016][    T1] CPA  protect  Rodata RO: 0xff1100007364e000 -
> 0xff1100007364efff PFN 7364e req 8000000000000123 prevent
> 0000000000000002
> [  144.659565][    T1] CPA  protect  Rodata RO: 0xffffffffab64f000 -
> 0xffffffffab64ffff PFN 7364f req 8000000000000123 prevent
> 0000000000000002
> [  144.660563][    T1] CPA  protect  Rodata RO: 0xff1100007364f000 -
> 0xff1100007364ffff PFN 7364f req 8000000000000123 prevent
> 0000000000000002
> [  144.668921][    T1] Testing CPA: again
> [  145.133922][    T1] debug: unmapping init [mem
> 0xffffffffa9396000-0xffffffffa93fffff]
> [  145.136886][    T1] debug: unmapping init [mem
> 0xffffffffab650000-0xffffffffab7fffff]
> [  157.130123][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages=
 found.
> [  157.132907][    T1] rodata_test: all tests were successful
> [  157.134666][    T1] Run /init as init process
> [kaudit] guest init start
> [kaudit] guest init start
> + '[' -x /poc/serial-mark ]
> + /poc/serial-mark '[kaudit] run.sh start\n'
> [kaudit] run.sh start\n[  158.284872][  T145] serial-mark (145) used
> greatest stack depth: 8 bytes left
> + echo '[kaudit] trigger command: /poc/poc-bin'
> [kaudit] trigger command: /poc/poc-bin
> + /poc/poc-bin
> [  158.729491][  T146] loop0: detected capacity change from 0 to 8
> mounting /tmp/adfs-nzones0.img via /dev/loop0; expect crash in adfs_map_l=
ayout()
> [  158.823801][  T146] Oops: general protection fault, probably for
> non-canonical address 0xdffffc0000000002: 0000 [#1] SMP
> DEBUG_PAGEALLOC KASAN NOPTI
> [  158.824306][  T146] KASAN: null-ptr-deref in range
> [0x0000000000000010-0x0000000000000017]
> [  158.824306][  T146] CPU: 0 UID: 0 PID: 146 Comm: poc-bin Tainted: G
>        W       T   7.0.0-rc2+ #4 PREEMPT(lazy)
> f57869d565a4551be95743026afd79a1bf2712c7
> [  158.824306][  T146] Tainted: [W]=3DWARN, [T]=3DRANDSTRUCT
> [  158.824306][  T146] Hardware name: QEMU Standard PC (i440FX + PIIX,
> 1996), BIOS 1.15.0-1 04/01/2014
> [  158.824306][  T146] RIP: 0010:adfs_read_map+0x420/0xbc0
> [  158.824306][  T146] Code: 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 7f 05
> 00 00 0f b7 45 0a 48 8b 54 24 10 41 29 c7 48 c1 ea 03 48 b8 00 00 00
> 00 00 fc ff df <80> 3c 02 00 44 89 7c 24 08 0f 85 12 07 00 00 48 8b 44
> 24 10 48 8d
> [  158.824306][  T146] RSP: 0018:ffa00000014a7658 EFLAGS: 00000202
> [  158.824306][  T146] RAX: dffffc0000000000 RBX: 0000000000000000
> RCX: 0000000000000000
> [  158.824306][  T146] RDX: 0000000000000002 RSI: 0000000000000000
> RDI: 0000000000000000
> [  158.824306][  T146] RBP: ff11000006345dc0 R08: 0000000000000000
> R09: 0000000000000000
> [  158.824306][  T146] R10: 0000000000000000 R11: 0000000000000000
> R12: ff11000004f04000
> [  158.824306][  T146] R13: ff11000006345dca R14: 0000000000000000
> R15: 0000000000002000
> [  158.824306][  T146] FS:  00000000004ce3c0(0000)
> GS:ff110000ab608000(0000) knlGS:0000000000000000
> [  158.824306][  T146] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  158.824306][  T146] CR2: 00000000004c91a0 CR3: 000000000b0af000
> CR4: 00000000007516f0
> [  158.824306][  T146] PKRU: 55555554
> [  158.824306][  T146] Call Trace:
> [  158.824306][  T146]  <TASK>
> [  158.824306][  T146]  adfs_probe+0x3b7/0x540
> [  158.824306][  T146]  ? __pfx_adfs_validate_bblk+0x40/0x40
> [  158.824306][  T146]  ? __pfx_adfs_probe+0x40/0x40
> [  158.824306][  T146]  ? shrinker_debugfs_rename+0x1bb/0x2c0
> [  158.824306][  T146]  adfs_fill_super+0x179/0x640
> [  158.824306][  T146]  ? __pfx_adfs_fill_super+0x40/0x40
> [  158.824306][  T146]  ? kfree_const+0x5a/0x80
> [  158.824306][  T146]  ? shrinker_debugfs_rename+0x1c0/0x2c0
> [  158.824306][  T146]  ? __pfx_shrinker_debugfs_rename+0x40/0x40
> [  158.824306][  T146]  ? __pfx_snprintf+0x40/0x40
> [  158.824306][  T146]  ? tracer_preempt_on+0x44/0x5c0
> [  158.824306][  T146]  ? _raw_spin_unlock+0x2d/0x80
> [  158.824306][  T146]  ? set_blocksize+0x384/0x480
> [  158.824306][  T146]  ? sb_set_blocksize+0x1b1/0x340
> [  158.824306][  T146]  ? setup_bdev_super+0x431/0x900
> [  158.824306][  T146]  ? __pfx_super_s_dev_set+0x40/0x40
> [  158.824306][  T146]  get_tree_bdev_flags+0x3aa/0x680
> [  158.824306][  T146]  ? __pfx_adfs_fill_super+0x40/0x40
> [  158.824306][  T146]  ? __pfx_get_tree_bdev_flags+0x40/0x40
> [  158.824306][  T146]  ? rcu_is_watching+0x12/0x100
> [  158.824306][  T146]  ? cap_capable+0x142/0x380
> [  158.824306][  T146]  vfs_get_tree+0x98/0x380
> [  158.824306][  T146]  fc_mount+0x1f/0x240
> [  158.824306][  T146]  do_new_mount+0x3d6/0x700
> [  158.824306][  T146]  ? __pfx_do_new_mount+0x40/0x40
> [  158.824306][  T146]  ? cap_capable+0x142/0x380
> [  158.824306][  T146]  ? bpf_lsm_capable+0xe/0x40
> [  158.824306][  T146]  ? security_capable+0x307/0x380
> [  158.824306][  T146]  path_mount+0x4bb/0x1500
> [  158.824306][  T146]  ? kmem_cache_free+0x169/0x7c0
> [  158.824306][  T146]  ? putname+0xb9/0x140
> [  158.824306][  T146]  ? __pfx_path_mount+0x40/0x40
> [  158.824306][  T146]  ? putname+0xb9/0x140
> [  158.824306][  T146]  __x64_sys_mount+0x2a8/0x340
> [  158.824306][  T146]  ? __pfx___x64_sys_mount+0x40/0x40
> [  158.824306][  T146]  ? tracer_hardirqs_on+0x3c9/0x5c0
> [  158.824306][  T146]  ? do_syscall_64+0xa7/0x940
> [  158.824306][  T146]  do_syscall_64+0x141/0x940
> [  158.824306][  T146]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [  158.824306][  T146] RIP: 0033:0x44a10e
> [  158.824306][  T146] Code: 48 c7 c0 ff ff ff ff eb aa e8 0e 06 00 00
> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa 49 89 ca b8 a5
> 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8
> 64 89 01 48
> [  158.824306][  T146] RSP: 002b:00007fffa4a988c8 EFLAGS: 00000202
> ORIG_RAX: 00000000000000a5
> [  158.824306][  T146] RAX: ffffffffffffffda RBX: 0000000000000000
> RCX: 000000000044a10e
> [  158.824306][  T146] RDX: 00000000004980f6 RSI: 000000000049802d
> RDI: 00007fffa4a98970
> [  158.824306][  T146] RBP: 0000000000000003 R08: 00000000004af4bd
> R09: 746365707865203b
> [  158.824306][  T146] R10: 0000000000000001 R11: 0000000000000202
> R12: 00007fffa4a98970
> [  158.824306][  T146] R13: 000000000049806e R14: 00007fffa4a988e0
> R15: 0000000000000004
> [  158.824306][  T146]  </TASK>
> [  158.824306][  T146] Modules linked in:
> [  158.854456][  T146] ---[ end trace 0000000000000000 ]---
> [  158.855680][  T146] RIP: 0010:adfs_read_map+0x420/0xbc0
> [  158.856500][  T146] Code: 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 7f 05
> 00 00 0f b7 45 0a 48 8b 54 24 10 41 29 c7 48 c1 ea 03 48 b8 00 00 00
> 00 00 fc ff df <80> 3c 02 00 44 89 7c 24 08 0f 85 12 07 00 00 48 8b 44
> 24 10 48 8d
> [  158.857115][  T146] RSP: 0018:ffa00000014a7658 EFLAGS: 00000202
> [  158.857587][  T146] RAX: dffffc0000000000 RBX: 0000000000000000
> RCX: 0000000000000000
> [  158.857962][  T146] RDX: 0000000000000002 RSI: 0000000000000000
> RDI: 0000000000000000
> [  158.858320][  T146] RBP: ff11000006345dc0 R08: 0000000000000000
> R09: 0000000000000000
> [  158.858701][  T146] R10: 0000000000000000 R11: 0000000000000000
> R12: ff11000004f04000
> [  158.859091][  T146] R13: ff11000006345dca R14: 0000000000000000
> R15: 0000000000002000
> [  158.859473][  T146] FS:  00000000004ce3c0(0000)
> GS:ff110000ab608000(0000) knlGS:0000000000000000
> [  158.859883][  T146] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  158.860567][  T146] CR2: 00000000004c91a0 CR3: 000000000b0af000
> CR4: 00000000007516f0
> [  158.860946][  T146] PKRU: 55555554
