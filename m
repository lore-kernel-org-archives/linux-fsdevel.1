Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030B3F9C0
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 05:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773121715; cv=pass; b=hoGKVAZqrA4thNMzwHALz5VQ0+A1P/DgWfD9MTIflgSkK+Eq9oXx89OH2cTz1yWS4f/jLQRmcik1r6CoTEKtjCkiRZBIzSAeImVgDQiZrRIhLTNulEerGrQxwcnaAF/aPtmSKzt1wuiCsHoPDJnaF9+ZRcaNKpkaK12vlFFnFE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773121715; c=relaxed/simple;
	bh=5V1JSUM17dsnuBih53TcUOLCH2glXxPloRZr5Fq6hds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nyacttqBlYSNZvb1oU3s2iAxwDbMjhUtEOPbirBYnKxVtaHN4MEB/zpifigFlKgpfrp84z8pO6SIQSznjmXuA5Cvo/RJi4hlQr9uordqJJgpy6dwFncsxu6oDgaiiscg3JxHfAHywjQbYQp5wDzSu0s/kjOaeZ1hslri25bXfEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxK09w/a; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxK09w/a"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35982fd8910so4085034a91.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2026 22:48:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773121713; cv=none;
        d=google.com; s=arc-20240605;
        b=GpjMRlbgmEJqNgdVw8KV0PPy8OU8CoOF/+EcGX86RUUI51OmFf204kvTGUxWSurG2v
         zykXjOdS06KAQyDKwYBcNvkz4thCpWQ5BW6wu9b8Mhjf3Z7Fy4OVofhN18Pxy7vBl4H7
         ddHxa4IhoVzyXEKEvpDJrcIkPOghD1MyacEYUmQ83fZORrf8JuOVJzFK3vLlv4sLNg5m
         Fq036oo9CEjRsVYywQkBu1LNcVhTM08t+TKFN3jjCtKWuiVZx6t1pxwzAyOpQAiJ5n8K
         /Mbn8+llLHBSrW1AdkgjysKV4NdqqFVgsf8iZLdzR0GEKDOmF8R/obN9ll03WbWaQZud
         VEmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PqBv/0I5udJiuuSVrFYkdfQ795tdK0+rD9uHf3PTFPk=;
        fh=8LdsQE98hEZTZxElDtTD+xzNE2r3mdGJODJPj1aFIeQ=;
        b=aBDVuh1KAkAex+04OrZZSulrWpZV4+FQnU6ud5pTbjUnMGU2b60ZhwySAHiUTVL9mw
         z8OrbzM3hgdFap2N4lhl54CaEhJw/7MEwE91X2X3sii1WgbFynDXCpTcPda7h8hmLXVb
         MEJIDgcnFgeVlph9nCWfOtLd1HCnQ2QdzgsyIQM0xtAID4Mc9HSsqCtTwg40fQq5Ap1a
         ve1ikSYGuVnDtTNaCy2oEnBL5Tos2HIL8cJ3t+5xLYd4O0ewUyfLVHHnS+zQ+S2rCIuq
         UK7lIoCZZDSfw3OM1HvrZs/1/hfUCQjcAGHgW0KCnyloYZvxL20r+jf3aLBe0yheP3vS
         AdEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773121713; x=1773726513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PqBv/0I5udJiuuSVrFYkdfQ795tdK0+rD9uHf3PTFPk=;
        b=BxK09w/aux96C1cF2pQ0KvkGzeEZGFgrtsMoHezFCSXgL71di6O8hWyMJZ55NmgxJF
         nrEVm5eS2o1GKrd9A0NoOczPbnqxXN0aGZGSTAjfmsafHy5Kn9s6migpZy6BozySaCDs
         I80GwvGGrIsnaRxCciCf/V+EuKsseMn8H4EZyLPqcH8mZt/lCmYopMGKA32WeMCKlk7w
         bo/Zw6Gr84VGObAFU5Gxha69f62hFNf6n4C6ILxGfst2061bcXEJxQ9YkQ7metnCAt3K
         ffuW8GI6WgVdc2+u/h3ecs0HKD7W+I6XdBswEk20JulDhjYQfeqpc+8jbynxXpepv0gW
         KPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773121713; x=1773726513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PqBv/0I5udJiuuSVrFYkdfQ795tdK0+rD9uHf3PTFPk=;
        b=lT/3r42v91bbZDzcStPdFGTIoWsP1joEWd4/yp6OoFAxfp2FnHtY+kjI5EBi/JJqHz
         A5YQ9zV8azd6aTXcrklx9DFHgA/7Jk+Lo0MWURjVlMBYR+4DaoURJiLvJBEApyDI4UJM
         A7QPchfxfZBBD714ETytcj2OshSVtl+B4Cu52D1PthZf/SaopMn7eW24lRbBKzkKoeHs
         Y0JSVsamfhk8L79c+W1CJqI71ZUus8WyyEJewqAgSism7eSFKFsrO9Cl2rsb/yUkXhiQ
         TbBEGZRCA8sRBtyioJnmQ6b615dZCXIEriTzudQQuX+3zoPeDIjy5EG6gjlFM6pLPQre
         cpBQ==
X-Gm-Message-State: AOJu0YzIJcvbWzG1hjXgNtd8oo5fuhlhBSO6e9jyBmltl2x8spFhJl7O
	ImIW2n34497v3VkNVGuCa5Gjf1J2xmRWiAtix8VL7JGc7AkdhrgRCws/mgtg+iSj9B7b47p4ayi
	ddUx73U6Z+ZFG/IxDEgrRJ+aLl+TozTkYZIbWlwXwRw==
X-Gm-Gg: ATEYQzyu6CWyw6ZiEIfKkE1eaGcEjYW0a3rv3SQpTxEQ7v2c53k5VfyUIwX+CKf0tLm
	98dUnN8YTMWFjHJ8QRKppMqdXLTm+m26nCFZPZEWZ3MeMYrtA6uK2L7aaurH1Lyjzr8r+J9BKRo
	2fNtxQZlQ6eVZW+qBeiSNx+nZevA2cpeScgPFhyKUQemhx7H8H10Zbm6jWx4b7DT4T3TBpV1d3n
	6iTEKL2oKTCFsrQD6D1CDyPWReZHOl20I29QNrpFUuNZ2soQJjFkjTjFlJKnGYmj9X4hogL3+MI
	PV+N+xQ=
X-Received: by 2002:a17:90b:4c52:b0:343:d70e:bef0 with SMTP id
 98e67ed59e1d1-359be2ee864mr12534397a91.21.1773121712994; Mon, 09 Mar 2026
 22:48:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP_j_b-z_LowEExS-yAKsCPdzjRjr-md=57ETosyUHopMV=_jg@mail.gmail.com>
In-Reply-To: <CAP_j_b-z_LowEExS-yAKsCPdzjRjr-md=57ETosyUHopMV=_jg@mail.gmail.com>
From: Hyungjung Joo <jhj140711@gmail.com>
Date: Tue, 10 Mar 2026 14:48:21 +0900
X-Gm-Features: AaiRm51SQI7XVcEaAvoS0V-3Mb2rCBhari2RXPv0lyoBwR5l_ZWEAFHgWx2UmJg
Message-ID: <CAP_j_b8H61CSno7gTNDfXgkRFB9YDBLu6bNPjOM3JJJJSzrkHg@mail.gmail.com>
Subject: Re: [BUG] adfs: use-after-free in _find_next_bit+0xe2/0x140 during getdents64()
To: linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, kees@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I am commenting on additional information that reported a filesystem
bug reproduced on current mainline with
KASAN enabled.

Target file: fs/adfs/map.c
Subsystem: fs/adfs
Git head: 5ee8dbf54602dc340d6235b1d6aa17c0f283f48c
Kernel release: 7.0.0-rc2+

Root cause:
`fs/adfs/super.c:324-335` accepts a DR0 image whenever the disc record
passes the shallow `adfs_checkdiscrecord()` checks and `nzones=3D=3D1`.
`fs/adfs/map.c:356-385` then reads exactly one map sector from block
0, but `adfs_map_layout()` overwrites `dm[0].dm_endbit` with `512 +
(adfs_disc_size(dr) >> dr->log2bpmb)` for the one-zone case
(`fs/adfs/map.c:329-331`) and never checks that this fits inside the
single loaded buffer (`sb->s_blocksize * 8` bits). Later map walkers
trust that oversized bound while reading `dm->dm_bh->b_data`,
producing a live-buffer out-of-bounds read during post-mount map
traversal. For this one-zone path, `disc_size/log2bpmb` is the
decisive inflator; `zone_spare` is not required for the final
`dm_endbit` overwrite.

Reproducer
C reproducer: intentionally omitted from public mail (Not inlining PoC
because the case text indicates direct privilege-escalation risk
beyond a pure KASAN trigger.)
KASAN full log: https://pastebin.com/raw/jgGUJ3ai
Kernel config: https://pastebin.com/raw/rKFNfL51

Key config options:
- CONFIG_KASAN=3Dy
- CONFIG_KASAN_GENERIC=3Dy
- CONFIG_KASAN_MULTI_SHOT=3Dy
- CONFIG_DEBUG_KERNEL=3Dy
- CONFIG_FRAME_POINTER=3Dy
- CONFIG_ADFS_FS=3Dy
- CONFIG_BLK_DEV_LOOP=3Dy

Brief KASAN call trace:
[   84.944056][  T167] BUG: KASAN: use-after-free in _find_next_bit+0xe2/0x=
140
[   84.944056][  T167] Read of size 8 at addr ff1100005b909000 by task
poc-bin/167
[   84.944056][  T167] Call Trace:
[   84.944056][  T167]  dump_stack_lvl+0x95/0x100
[   84.944056][  T167]  print_address_description.constprop.0+0x2c/0x3c0
[   84.944056][  T167]  print_report+0xb4/0x280
[   84.944056][  T167]  kasan_report+0x9b/0x100
[   84.944056][  T167]  _find_next_bit+0xe2/0x140
[   84.944056][  T167]  scan_map+0x2ac/0x4c0
[   84.944056][  T167]  adfs_map_lookup+0x12e/0x340
[   84.944056][  T167]  adfs_dir_read_buffers+0x282/0x5c0
[   84.944056][  T167]  adfs_f_read+0x76/0x3c0
[   84.944056][  T167]  adfs_dir_read_inode+0x15f/0x2c0
[   84.944056][  T167]  adfs_iterate+0x127/0x480
[   84.944056][  T167]  iterate_dir+0x238/0xa80

Reproducibility notes:
- observed crash: use-after-free in _find_next_bit+0xe2/0x140 during
getdents64()
- rootfs mode: busybox
- guest /init runs the case-specific trigger binary automatically

If you need anything else, please let me know.
Thank you.

Best regards,
Hyungjung Joo, jhj140711@gmail.com

2026=EB=85=84 3=EC=9B=94 8=EC=9D=BC (=EC=9D=BC) PM 5:46, =EC=A3=BC=ED=98=95=
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
> Case ID: case-20260306T142346Z-211f
>
> Root cause:
> `fs/adfs/super.c:324-335` accepts a DR0 image whenever the disc record
> passes the shallow `adfs_checkdiscrecord()` checks and `nzones=3D=3D1`.
> `fs/adfs/map.c:356-385` then reads exactly one map sector from block
> 0, but `adfs_map_layout()` overwrites `dm[0].dm_endbit` with `512 +
> (adfs_disc_size(dr) >> dr->log2bpmb)` for the one-zone case
> (`fs/adfs/map.c:329-331`) and never checks that this fits inside the
> single loaded buffer (`sb->s_blocksize * 8` bits). Later map walkers
> trust that oversized bound while reading `dm->dm_bh->b_data`,
> producing a live-buffer out-of-bounds read during post-mount map
> traversal. For this one-zone path, `disc_size/log2bpmb` is the
> decisive inflator; `zone_spare` is not required for the final
> `dm_endbit` overwrite.
>
> Observed crash: use-after-free in _find_next_bit+0xe2/0x140 during getden=
ts64()
>
> KASAN excerpt:
> [   83.536813][  T158] ADFS-fs error (device loop0):
> adfs_dir_read_buffers: dir 000200 failed read at offset 0, mapped
> block 0x00013d02
> getdents64: Input/output error
> [   83.202718][  T142] sh (142): drop_caches: 3
> [   83.497412][  T158] kobject: 'loop0' (ff11000001433798): kobject_ueven=
t_env
> [   83.497586][  T158] kobject: 'loop0' (ff11000001433798):
> kobject_uevent_env: uevent_suppress caused the event to drop!
> [   83.499843][  T158] loop0: detected capacity change from 0 to 8
> [   83.500351][  T158] kobject: 'loop0' (ff11000001433798): kobject_ueven=
t_env
> [   83.500422][  T158] kobject: 'loop0' (ff11000001433798):
> kobject_uevent_env: uevent_suppress caused the event to drop!
> [   83.500473][  T158] kobject: 'loop0' (ff11000001433798): kobject_ueven=
t_env
> [   83.501083][  T158] kobject: 'loop0' (ff11000001433798):
> fill_kobj_path: path =3D '/devices/virtual/block/loop0'
> [   83.536813][  T158] ADFS-fs error (device loop0):
> adfs_dir_read_buffers: dir 000200 failed read at offset 0, mapped
> block 0x00013d02
> [   83.589296][  T158] kobject: 'loop0' (ff11000001433798): kobject_ueven=
t_env
> [   83.591287][  T158] kobject: 'loop0' (ff11000001433798):
> fill_kobj_path: path =3D '/devices/virtual/block/loop0'
> [   83.591744][  T158] kobject: 'loop0' (ff11000001433798): kobject_ueven=
t_env
> [   83.592497][  T158] kobject: 'loop0' (ff11000001433798):
> fill_kobj_path: path =3D '/devices/virtual/block/loop0'
> [*] attempt 3/128
> [   84.603537][  T142] sh (142): drop_caches: 3
> image=3D/tmp/adfs-dmendbit.img disc_size=3D1073741824 dm_endbit=3D2097664
> bits (262208 bytes max)
> [   84.901503][  T167] loop0: detected capacity change from 0 to 8
> [   84.943773][  T167]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   84.944056][  T167] BUG: KASAN: use-after-free in _find_next_bit+0xe2/=
0x140
> [   84.944056][  T167] Read of size 8 at addr ff1100005b909000 by task
> poc-bin/167
> [   84.944056][  T167]
> [   84.944056][  T167] CPU: 0 UID: 0 PID: 167 Comm: poc-bin Tainted: G
>        W       T   7.0.0-rc2+ #5 PREEMPT(lazy)
> ccfb407f8ed1d19667324f70fc2e5f4a9b6173f6
> [   84.944056][  T167] Tainted: [W]=3DWARN, [T]=3DRANDSTRUCT
> [   84.944056][  T167] Hardware name: QEMU Standard PC (i440FX + PIIX,
> 1996), BIOS 1.15.0-1 04/01/2014
> [   84.944056][  T167] Call Trace:
> [   84.944056][  T167]  <TASK>
> [   84.944056][  T167]  dump_stack_lvl+0x95/0x100
> [   84.944056][  T167]  print_address_description.constprop.0+0x2c/0x3c0
> [   84.944056][  T167]  ? _find_next_bit+0xe2/0x140
> [   84.944056][  T167]  print_report+0xb4/0x280
> [   84.944056][  T167]  ? kasan_addr_to_slab+0x27/0x80
> [   84.944056][  T167]  ? kasan_complete_mode_report_info+0xa3/0xc0
> [   84.944056][  T167]  kasan_report+0x9b/0x100
> [   84.944056][  T167]  ? _find_next_bit+0xe2/0x140
> [   84.944056][  T167]  _find_next_bit+0xe2/0x140
> [   84.944056][  T167]  ? find_held_lock+0x32/0xc0
> [   84.944056][  T167]  scan_map+0x2ac/0x4c0
> [   84.944056][  T167]  ? adfs_map_lookup+0x11d/0x340
> [   84.944056][  T167]  adfs_map_lookup+0x12e/0x340
> [   84.944056][  T167]  adfs_dir_read_buffers+0x282/0x5c0
> [   84.944056][  T167]  adfs_f_read+0x76/0x3c0
> [   84.944056][  T167]  ? __down_read_trylock+0x1de/0x480
> [   84.944056][  T167]  adfs_dir_read_inode+0x15f/0x2c0
> [   84.944056][  T167]  adfs_iterate+0x127/0x480
> [   84.944056][  T167]  ? __pfx_adfs_iterate+0x40/0x40
> [   84.944056][  T167]  ? iterate_dir+0x152/0xa80
> [   84.944056][  T167]  ? down_read_killable+0x116/0x380
> [   84.944056][  T167]  ? __pfx_down_read_killable+0x40/0x40
> [   84.944056][  T167]  ? selinux_file_permission+0x3c2/0x500
> [   84.944056][  T167]  iterate_dir+0x238/0xa80
> [   84.944056][  T167]  ? fdget_pos+0x24e/0x340
> [   84.944056][  T167]  __x64_sys_getdents64+0x132/0x240
> [   84.944056][  T167]  ? __pfx___x64_sys_getdents64+0x40/0x40
> [   84.944056][  T167]  ? __pfx_filldir64+0x40/0x40
> [   84.944056][  T167]  do_syscall_64+0x141/0xf40
> [   84.944056][  T167]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   84.944056][  T167] RIP: 0033:0x448dcd
> [   84.944056][  T167] Code: 02 b8 ff ff ff ff eb b8 0f 1f 44 00 00 f3
> 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
> 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8
> 64 89 01 48
> [   84.944056][  T167] RSP: 002b:00007fff97d52248 EFLAGS: 00000246
> ORIG_RAX: 00000000000000d9
> [   84.944056][  T167] RAX: ffffffffffffffda RBX: 0000000000000005
> RCX: 0000000000448dcd
> [   84.944056][  T167] RDX: 0000000000002000 RSI: 00007fff97d52390
> RDI: 0000000000000003
> [   84.944056][  T167] RBP: 0000000000000003 R08: 00007fff97d520e0
> R09: 0000000000000000
> [   84.944056][  T167] R10: 00000000004b04dd R11: 0000000000000246
> R12: 000000000049900f
> [   84.944056][  T167] R13: 00007fff97d52390 R14: 000000000049907f
> R15: 00007fff97d52350
> [   84.944056][  T167]  </TASK>
> [   84.944056][  T167]
> [   84.944056][  T167] The buggy address belongs to the physical page:
> [   84.944056][  T167] page: refcount:0 mapcount:0
> mapping:0000000000000000 index:0x215 pfn:0x5b909
> [   84.944056][  T167] flags: 0xfffffc0000000(node=3D0|zone=3D1|lastcpupi=
d=3D0x1fffff)
> [   84.944056][  T167] raw: 000fffffc0000000 ffd40000016e5148
> ffd40000016e3e88 0000000000000000
> [   84.944056][  T167] raw: 0000000000000215 0000000000000000
> 00000000ffffffff 0000000000000000
> [   84.944056][  T167] page dumped because: kasan: bad access detected
> [   84.944056][  T167]
> [   84.944056][  T167] Memory state around the buggy address:
> [   84.944056][  T167]  ff1100005b908f00: 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00
> [   84.944056][  T167]  ff1100005b908f80: 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00
> [   84.944056][  T167] >ff1100005b909000: ff ff ff ff ff ff ff ff ff
> ff ff ff ff ff ff ff
> [   84.944056][  T167]                    ^
> [   84.944056][  T167]  ff1100005b909080: ff ff ff ff ff ff ff ff ff
> ff ff ff ff ff ff ff
> [   84.944056][  T167]  ff1100005b909100: ff ff ff ff ff ff ff ff ff
> ff ff ff ff ff ff ff
> [   84.944056][  T167]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   84.957085][  T167] Disabling lock debugging due to kernel taint
> [   84.957940][  T167] BUG: unable to handle page fault for address:
> ff1100005b909000
> [   84.958241][  T167] #PF: supervisor read access in kernel mode
> [   84.958369][  T167] #PF: error_code(0x0000) - not-present page
> [   84.958604][  T167] PGD 6b201067 P4D 6b202067 PUD 6b205067 PMD
> 7f831067 PTE 800fffffa46f6020
> [   84.959193][  T167] Oops: Oops: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NO=
PTI
> [   84.959358][  T167] CPU: 0 UID: 0 PID: 167 Comm: poc-bin Tainted: G
>    B   W       T   7.0.0-rc2+ #5 PREEMPT(lazy)
> ccfb407f8ed1d19667324f70fc2e5f4a9b6173f6
> [   84.959559][  T167] Tainted: [B]=3DBAD_PAGE, [W]=3DWARN, [T]=3DRANDSTR=
UCT
> [   84.959692][  T167] Hardware name: QEMU Standard PC (i440FX + PIIX,
> 1996), BIOS 1.15.0-1 04/01/2014
> [   84.959835][  T167] RIP: 0010:_find_next_bit+0xa3/0x140
> [   84.959990][  T167] Code: df 4a 8d 6c 2d 08 eb 14 48 83 c3 01 48 83
> c5 08 48 89 da 48 c1 e2 06 48 39 d0 76 2a 48 89 ea 48 c1 ea 03 42 80
> 3c 22 00 75 33 <48> 8b 55 00 48 85 d2 74 d5 48 c1 e3 06 f3 48 0f bc d2
> 48 01 d3 48
> [   84.960216][  T167] RSP: 0018:ffa00000014e78c8 EFLAGS: 00000246
> [   84.960354][  T167] RAX: 0000000000200200 RBX: 0000000000000200
> RCX: 0000000000000000
> [   84.960499][  T167] RDX: 0000000000000000 RSI: 0000000000000000
> RDI: 0000000000000000
> [   84.960645][  T167] RBP: ff1100005b909000 R08: 0000000000000000
> R09: 0000000000000000
> [   84.960781][  T167] R10: 0000000000000000 R11: 0000000000000000
> R12: dffffc0000000000
> [   84.960914][  T167] R13: 0000000000000040 R14: dffffc0000000000
> R15: ff1100005b908000
