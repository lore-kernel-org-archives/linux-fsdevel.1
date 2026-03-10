Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330FD2E06ED
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 05:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773121976; cv=pass; b=WHY7DAaC41NyDejI492Qfie5mXePs77PEqoi5L/v2A43epeXbqeXZrYpRBIHf8XnJHbCisVknkKPa0ckZ1zIVpEZLVntBjZRQe2Xh0HzuyBzWQxCOJzRAz6JgqFGbk14B+RD3StKEF3YVWaDEDLnyB8a+FO/asVcuEFvfloyupc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773121976; c=relaxed/simple;
	bh=L6yq92oW6F/cwkgawTfL2ogZ96uCRgAR/2OJelNfWB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+qazCYzKf4DiqN4GW/sO/kLfKa3mQKr8Jun8whzpBfGaTsyPSJj+Gs3vKbMPJbFqGfPQsC/+XfKH0WfLkljWXww1nxxqtJnxrnvjZg/qXzdKtjbrc+PDrB1rC9duU25Gkc/ltEHKflydaEkxEI5ipuJ5SAlr0lp45gW7obpINk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQGMdtn6; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQGMdtn6"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a8fba3f769so54297175ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2026 22:52:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773121974; cv=none;
        d=google.com; s=arc-20240605;
        b=KAaQvMu6It8ipbj1MNvemK/55VSTmYGNSGpfmdss6q2Yk7CyxE0Ggi90B4Um5vWiL2
         xxJMYM0yiPhhdFaY/R/qyR/rPFaVyswOWzgVXhWuqEXps2mpHj/oXtoy27bhfskENXf3
         F/QvZ1DUzrxPcE+nj6Y1PzyIdkNoJgUA+CzKo5opXCCVUUlH0oFhXvUttSpQ+IpVCzy3
         VYI7A9ZSqWxHU616AivpnR/kPz8kBYwdh28VXnIrf2nhan2QJVnhOseBbs4PZqxfPneB
         4ZWsOBsHnHf/LF0VsIUXhKIE2pZBITW1J27evmqzRsZTMECZ9YHUcMJudo2AlT/U1bKh
         N75A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rWuWX5pQC539N6Lsy4LCXeWqOeK6Es5QF07B/gN72P0=;
        fh=6/ntYK+Q5V3J5enFru3CXEUQclXShJGxxhbI3+HCPoc=;
        b=DBogUsv5kPDurBZnzPJgQqZdbRjXAEsZxRO1FKqBIZJ+MGEOtKA7xsDINgEcFHd2V8
         T4XzrAaYhY20/N59Y7cz4XZ4m9LQhaFhVsfMu3WSuoMYcXXKrnQ+36i2kFnFmm+hfoPT
         3NoeBcsjQ7lyZWp22Uxdi2fzcHYF1/VfQRelERjh45RgNHBnCtfxFIEMczQJ7OWjh/Yc
         IjhkPRDl7CSe2i5SQDJmZMlSt5YnYQfHRKJbqyWybEUlQg/BJjrnudwsW5pdd636oLtP
         pLmAC6TjP3E3VH2ccaMLhLaAq3rX5svranWiL4+EeENqLfD/NIp6znLsq3U+kLZUFCwa
         aeXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773121974; x=1773726774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWuWX5pQC539N6Lsy4LCXeWqOeK6Es5QF07B/gN72P0=;
        b=BQGMdtn6kDGOr1+yG0FZzIHoNHo+S8BYVEblhcXFvPQNtILEi4I3CGNylUnx0/DbpC
         Egps334lt9RuY6VrVHlJ8Tvst8DPPueOXfue6EfDB8UWCewNEhon/+Bha4hv8on7vft2
         UzBo/XMlZZ1uDT2rfuJpL1I4vxGYCT8Fcl0Q+KJmM4WVLPOQeUFX8XynfRRwAvfpfhtC
         2F7EImgmCElMaCG+xlSfJtK73DyZu16XAOSELzT4QYPBSTyIxm+rYohI+dJA9C+9BMz7
         U7gjh6mRTDswQB7mosTkeYWs6ImVPdAErRjyAp9AZ/N2WAAOHtk+Wo5xRwaggqF7LWnT
         jHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773121974; x=1773726774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rWuWX5pQC539N6Lsy4LCXeWqOeK6Es5QF07B/gN72P0=;
        b=Zc4G98aCXHYPRDN959RQdrvbV8KxSiUhu80mbb+05Gp5okBnbdxaRvSiqbSSK4Gidj
         mUu33Mzl9K4xwQcfj+7RmEA+AbfFdhVnuci4IpIiZP31bAsqrD64DK2STvZnZKZ0wvNb
         ev1cGtb50Df7uAiyNwx7+UANHzgDMo7+wIyyDFisCccr/NLoqLxpPWUe3IHkcJ3Iq3DO
         NbDaavCbM5ec2ov0i76wBWLIrBeHvLu8Y3Bn8/LOk5ZQCoCXngnQSh9fBiuoh1f6RRCE
         qv0+kBvQYmchMY0FfUgOJJVX+febnhJrtUdjdKZnxSgvZWzj3Q/1O2GGc8dso99C19a2
         wAKA==
X-Gm-Message-State: AOJu0YyGKbtgyyvAwD6dcDBD+eXwZ/uP4vwU7i08FPuelKkL1Pi+u2xb
	FgHbV5yDOJOZf9swWXLb3XosC69icMyrvbhxh9AZlHvdmmOnMutivviouAALncODLLIbxJqjsX8
	DOgbm3VClohGsLZxKRZodftUZOy/C3yKZesEPXxkwNw==
X-Gm-Gg: ATEYQzxLu/LekDTAt8MY15YTEGeW+SD67vgfh75VN+7+WCnKRwxr4zSbDyVEu9IJoA1
	IdIZvjMLJ3L3d2Mckckk8pK06eCSXXXy5EE3R4LjFIPJnmzFdx6yNTdYUSkyk849qi/jA5RX1C0
	SS9QHqEA5VRMdvKwVCkrUTkr9O77WQ2oGq5oXwRtLebRjlbPXwyBAZsTe2uhVeMVlij63A/qXWd
	Vw/DT99FCaN4e316rD1l18G0+xv0/hSZIP5aVlfUliceUOe9vMcKSxrsUQZoa79ndg+A87+TUrN
	MxCfTOQ=
X-Received: by 2002:a17:902:ef09:b0:2ae:4fc8:3f5d with SMTP id
 d9443c01a7336-2ae8249bc2cmr146191535ad.48.1773121974263; Mon, 09 Mar 2026
 22:52:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP_j_b8n1dqBXh4x2Bi+0R8KfuKDK01Wbr79m-nT-4JbTHaruA@mail.gmail.com>
In-Reply-To: <CAP_j_b8n1dqBXh4x2Bi+0R8KfuKDK01Wbr79m-nT-4JbTHaruA@mail.gmail.com>
From: Hyungjung Joo <jhj140711@gmail.com>
Date: Tue, 10 Mar 2026 14:52:43 +0900
X-Gm-Features: AaiRm51PhCS1Ocfjl3Sdbnj9BwPobWWLvCaLn2fWlNVNOo0xuSY2n1_2L4QZVXg
Message-ID: <CAP_j_b9MFM6EpnoDAZihi7KKn8ShOocFxGH=i5BnRX49GxD53g@mail.gmail.com>
Subject: Re: [BUG] freevxfs: slab-out-of-bounds in vxfs_immed_read_folio+0x10f/0x280
 during read()
To: linux-fsdevel@vger.kernel.org, hch@infradead.org
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I am commenting additional information about report regard of
filesystem bug reproduced on current mainline with KASAN enabled.

Target file: fs/freevxfs/vxfs_immed.c
Subsystem: fs/freevxfs
Git head: 5ee8dbf54602dc340d6235b1d6aa17c0f283f48c
Kernel release: 7.0.0-rc2+

Root cause:
`vxfs_immed_read_folio()` in `fs/freevxfs/vxfs_immed.c` treats
immediate-data inodes as if they contained full folios: it computes
`src =3D vip->vii_immed.vi_immed + folio_pos(folio)` and unconditionally
copies `PAGE_SIZE` chunks into page cache. But
`fs/freevxfs/vxfs_inode.h` fixes `VXFS_NIMMED` at 96 bytes, and the
in-memory `vii_immed` storage is only that large. `dip2vip_cpy()` also
copies attacker-controlled on-disk `vdi_size` directly into
`inode->i_size` with no `VXFS_ORG_IMMED` clamp, so crafted images can
make the out-of-bounds read user-visible and request farther folios.

Reproducer
C reproducer: intentionally omitted from public mail (If request, I'll prov=
ide)
KASAN full log: https://pastebin.com/raw/7cKt3mZz
Kernel config: https://pastebin.com/raw/jwdm95yw

Key config options:
- CONFIG_KASAN=3Dy
- CONFIG_KASAN_GENERIC=3Dy
- CONFIG_KASAN_MULTI_SHOT=3Dy
- CONFIG_DEBUG_KERNEL=3Dy
- CONFIG_FRAME_POINTER=3Dy
- CONFIG_VXFS_FS=3Dy
- CONFIG_BLK_DEV_LOOP=3Dy

Brief KASAN call trace:
[   68.788266][  T142] BUG: KASAN: slab-out-of-bounds in
vxfs_immed_read_folio+0x10f/0x280
[   68.788449][  T142] Read of size 4096 at addr ff11000006bef098 by
task poc-bin/142
[   68.788952][  T142] Call Trace:
[   68.789023][  T142]  dump_stack_lvl+0x95/0x100
[   68.789067][  T142]  print_address_description.constprop.0+0x2c/0x3c0
[   68.789119][  T142]  print_report+0xb4/0x280
[   68.789176][  T142]  kasan_report+0xcf/0x140
[   68.789233][  T142]  kasan_check_range+0x3b/0x200
[   68.789253][  T142]  __asan_memcpy+0x24/0x80
[   68.789273][  T142]  vxfs_immed_read_folio+0x10f/0x280
[   68.789303][  T142]  read_pages+0x85c/0xd40
[   68.789402][  T142]  page_cache_ra_unbounded+0x45b/0xac0
[   68.789451][  T142]  do_page_cache_ra+0xdf/0x140
[   68.789511][  T142]  filemap_get_pages+0x307/0xc80
[   68.789611][  T142]  filemap_read+0x319/0xb40

Reproducibility notes:
- observed crash: slab-out-of-bounds in
vxfs_immed_read_folio+0x10f/0x280 during read()
- rootfs mode: busybox
- guest /init runs the case-specific trigger binary automatically

If you need anything else, please let me know.
Thank you.

Best regards,
Hyungjung Joo, jhj140711@gmail.com

2026=EB=85=84 3=EC=9B=94 8=EC=9D=BC (=EC=9D=BC) PM 5:47, =EC=A3=BC=ED=98=95=
=EC=A0=95 <jhj140711@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hello,
>
> I am reporting a filesystem bug reproduced on current mainline with
> KASAN enabled.
>
> Target file: fs/freevxfs/vxfs_immed.c
> Subsystem: fs/freevxfs
> Git head: 5ee8dbf54602dc340d6235b1d6aa17c0f283f48c
> Kernel release: 7.0.0-rc2+
> Case ID: case-20260307T231103Z-fae2
>
> Root cause:
> `vxfs_immed_read_folio()` in `fs/freevxfs/vxfs_immed.c` treats
> immediate-data inodes as if they contained full folios: it computes
> `src =3D vip->vii_immed.vi_immed + folio_pos(folio)` and unconditionally
> copies `PAGE_SIZE` chunks into page cache. But
> `fs/freevxfs/vxfs_inode.h` fixes `VXFS_NIMMED` at 96 bytes, and the
> in-memory `vii_immed` storage is only that large. `dip2vip_cpy()` also
> copies attacker-controlled on-disk `vdi_size` directly into
> `inode->i_size` with no `VXFS_ORG_IMMED` clamp, so crafted images can
> make the out-of-bounds read user-visible and request farther folios.
>
> Observed crash: slab-out-of-bounds in
> vxfs_immed_read_folio+0x10f/0x280 during read()
>
> KASAN excerpt:
> [   65.544683][    T1] Testing CPA: again
> [   65.586489][    T1] debug: unmapping init [mem
> 0xffffffffb6127000-0xffffffffb61fffff]
> [   65.587399][    T1] debug: unmapping init [mem
> 0xffffffffb8362000-0xffffffffb83fffff]
> [   67.526716][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages=
 found.
> [   67.529487][    T1] rodata_test: all tests were successful
> [   67.530930][    T1] Run /init as init process
> [kaudit] guest init start
> [kaudit] guest init start
> + mkdir -p /proc
> [   68.106626][  T143] mkdir (143) used greatest stack depth: 8 bytes lef=
t
> + mount -t proc proc /proc
> + '[' -w /proc/sys/kernel/panic_on_warn ]
> + echo 1
> + '[' -w /proc/sys/kernel/panic_on_oops ]
> + echo 1
> + exec /poc/poc-bin
> [   68.695530][  T142] loop0: detected capacity change from 0 to 64
> mounting /tmp/vxfs-immed-oob.img via /dev/loop0
> page0 trigger on /mnt/vxfs-poc/poc
> [   68.787776][  T142]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   68.788266][  T142] BUG: KASAN: slab-out-of-bounds in
> vxfs_immed_read_folio+0x10f/0x280
> [   68.788449][  T142] Read of size 4096 at addr ff11000006bef098 by
> task poc-bin/142
> [   68.788570][  T142]
> [   68.788761][  T142] CPU: 0 UID: 0 PID: 142 Comm: poc-bin Tainted: G
>        W       T   7.0.0-rc2+ #15 PREEMPT(lazy)
> 6e12b13d3c2183834abd1baad25d91178d82fdff
> [   68.788885][  T142] Tainted: [W]=3DWARN, [T]=3DRANDSTRUCT
> [   68.788897][  T142] Hardware name: QEMU Standard PC (i440FX + PIIX,
> 1996), BIOS 1.15.0-1 04/01/2014
> [   68.788952][  T142] Call Trace:
> [   68.788983][  T142]  <TASK>
> [   68.789023][  T142]  dump_stack_lvl+0x95/0x100
> [   68.789067][  T142]  print_address_description.constprop.0+0x2c/0x3c0
> [   68.789097][  T142]  ? vxfs_immed_read_folio+0x10f/0x280
> [   68.789119][  T142]  print_report+0xb4/0x280
> [   68.789140][  T142]  ? kasan_addr_to_slab+0x27/0x80
> [   68.789160][  T142]  ? vxfs_immed_read_folio+0x10f/0x280
> [   68.789176][  T142]  kasan_report+0xcf/0x140
> [   68.789200][  T142]  ? vxfs_immed_read_folio+0x10f/0x280
> [   68.789233][  T142]  kasan_check_range+0x3b/0x200
> [   68.789253][  T142]  __asan_memcpy+0x24/0x80
> [   68.789273][  T142]  vxfs_immed_read_folio+0x10f/0x280
> [   68.789303][  T142]  read_pages+0x85c/0xd40
> [   68.789325][  T142]  ? __folio_batch_add_and_move+0x4dd/0xb40
> [   68.789358][  T142]  ? __pfx_read_pages+0x40/0x40
> [   68.789402][  T142]  page_cache_ra_unbounded+0x45b/0xac0
> [   68.789451][  T142]  do_page_cache_ra+0xdf/0x140
> [   68.789511][  T142]  filemap_get_pages+0x307/0xc80
> [   68.789557][  T142]  ? __pfx_filemap_get_pages+0x40/0x40
> [   68.789611][  T142]  filemap_read+0x319/0xb40
> [   68.789663][  T142]  ? __pfx_filemap_read+0x40/0x40
> [   68.789743][  T142]  ? rw_verify_area+0x370/0x580
> [   68.789812][  T142]  vfs_read+0x76e/0xd40
> [   68.789849][  T142]  ? __pfx_vfs_read+0x40/0x40
> [   68.789907][  T142]  __x64_sys_pread64+0x19f/0x200
> [   68.789929][  T142]  ? __pfx___x64_sys_pread64+0x40/0x40
> [   68.789954][  T142]  ? do_syscall_64+0xa7/0xf40
> [   68.789984][  T142]  do_syscall_64+0x141/0xf40
> [   68.790042][  T142]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   68.790109][  T142] RIP: 0033:0x4483aa
> [   68.790300][  T142] Code: 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00
> 00 90 f3 0f 1e fa 49 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 11
> 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 5e c3 0f 1f 44 00 00 48 83 ec 28
> 48 89 54 24
> [   68.790324][  T142] RSP: 002b:00007ffffe4f32e8 EFLAGS: 00000246
> ORIG_RAX: 0000000000000011
> [   68.790372][  T142] RAX: ffffffffffffffda RBX: 0000000000000004
> RCX: 00000000004483aa
> [   68.790387][  T142] RDX: 0000000000000020 RSI: 00007ffffe4f32f0
> RDI: 0000000000000003
> [   68.790399][  T142] RBP: 0000000000000003 R08: 0000000000000000
> R09: 0000000000000000
> [   68.790410][  T142] R10: 0000000000000000 R11: 0000000000000246
> R12: 0000000000499102
> [   68.790422][  T142] R13: 0000000000000000 R14: 00007ffffe4f32f0
> R15: 0000000000000000
> [   68.790492][  T142]  </TASK>
> [   68.790541][  T142]
> [   68.793900][  T142] Allocated by task 142 on cpu 0 at 68.780092s:
> [   68.794124][  T142]  kasan_save_stack+0x29/0x80
> [   68.794308][  T142]  kasan_save_track+0x17/0x80
> [   68.794402][  T142]  __kasan_slab_alloc+0x97/0xc0
> [   68.794502][  T142]  kmem_cache_alloc_lru_noprof+0x264/0x7c0
> [   68.794600][  T142]  vxfs_alloc_inode+0x23/0x80
> [   68.794694][  T142]  alloc_inode+0x73/0x240
> [   68.794782][  T142]  iget_locked+0x18e/0x640
> [   68.794879][  T142]  vxfs_iget+0x1e/0x540
> [   68.794965][  T142]  vxfs_lookup+0x200/0x280
> [   68.795053][  T142]  lookup_open.isra.0+0x59d/0x1240
> [   68.795147][  T142]  open_last_lookups+0xc5a/0x1880
> [   68.795242][  T142]  path_openat+0x144/0x5c0
> [   68.795330][  T142]  do_file_open+0x1db/0x440
> [   68.795420][  T142]  do_sys_openat2+0xcf/0x1c0
> [   68.795916][  T142]  __x64_sys_openat+0x127/0x200
> [   68.796011][  T142]  do_syscall_64+0x141/0xf40
> [   68.796108][  T142]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   68.796228][  T142]
> [   68.796342][  T142] The buggy address belongs to the object at
> ff11000006beeb58
> [   68.796342][  T142]  which belongs to the cache vxfs_inode of size 144=
0
> [   68.796657][  T142] The buggy address is located 1344 bytes inside of
> [   68.796657][  T142]  allocated 1440-byte region [ff11000006beeb58,
> ff11000006bef0f8)
> [   68.796813][  T142]
> [   68.796928][  T142] The buggy address belongs to the physical page:
> [   68.797412][  T142] page: refcount:0 mapcount:0
> mapping:0000000000000000 index:0xff11000006bec008 pfn:0x6bec
> [   68.797731][  T142] head: order:2 mapcount:0 entire_mapcount:0
> nr_pages_mapped:-1 pincount:0
> [   68.797929][  T142] flags:
> 0xfffffc0000240(workingset|head|node=3D0|zone=3D1|lastcpupid=3D0x1fffff)
> [   68.798284][  T142] page_type: f5(slab)
> [   68.798611][  T142] raw: 000fffffc0000240 ff110000056656c0
> ff11000005fc86d0 ff11000005fc86d0
> [   68.798740][  T142] raw: ff11000006bec008 00000008000a0005
> 00000000f5000000 0000000000000000
> [   68.798903][  T142] head: 000fffffc0000240 ff110000056656c0
> ff11000005fc86d0 ff11000005fc86d0
> [   68.799014][  T142] head: ff11000006bec008 00000008000a0005
> 00000000f5000000 0000000000000000
> [   68.799123][  T142] head: 000fffffc0000002 ffd40000001afb01
> ffd40000ffffffff 00000000ffffffff
