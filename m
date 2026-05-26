Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F4D313534
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 08:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779785187; cv=pass; b=KRPtJ9RwyI+i4L1Rvm0C5aBCOmtvjKTDAg3gmMnlHOtHL+8UUbiBC/9KqOzllBUvccvCHqn7FmWwh8WrwoYmUjXWPlGF5wuicD9kZ47Fijp3CCWql79coVANgPJLHstqENcZqcWCUzQsyqXlVUCbERni1IwbjCkwWHhgn1CqoEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779785187; c=relaxed/simple;
	bh=8JGHjZH0+0acLPNgzx+ZiGs+JxwKHEBLP+ZtC2egg9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bK3BrVbejIHpqOfZRC7VgynGTDpdzgXsFBJglfjLd9ZNEj4qKBD5Mf5eKexZv5lGjQSlMwJrO5FGgMdPudff3hHUXKK2AntJpfvrJq+bTTbE2XQ0nWRjhahHdKsPPVI9ELPV4Vj31/3GnOOREgWo4P5fZ6xjCTqgENs67YQub+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=efVzBKvE; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="efVzBKvE"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-516d0119e4aso43715951cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 01:46:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779785184; cv=none;
        d=google.com; s=arc-20240605;
        b=EpXcjIlSuTSHESvReGNxRRIq+/jNNLPJ+J07iSNFRRkaXxBS0CQpvwpLc73nsAk9kg
         FmRnR8M4YAPmkyy9LZsrfu4EV8iBgV/0W3lqKU5X3n78ULu79RL4fkKHs7HDj1pI+2aD
         NB/P16aOYJ3kqaFJXVVcMp/iFyrEMCoWUEi1u5aljBrItJNGpwQZBa4plPnJMm+tpFY4
         ZJy2HfIywNVC8UUO+To3gLqY3Ao2qkIs7epy3c8NNyArYSDpiG9zSr35UKWn3SpLqv3P
         doPhOxLAp4J6OXQKXWVLeAOGVP5mRmNd0fnTVwy+wGbK91NTstB7ZfDXRtvo0Timau5D
         aing==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+Sm7AdbBwz89HswDM1U3a+4O4uaDOPsFPs5dz3aFbf8=;
        fh=vtAALHs8kUgWdGZGwdBud5R8rpg/h4l9HkU2WuhahVo=;
        b=M8NDooyL/i8UJ6DK1qSBdYQg3/iZGI+uAtTATA7pBgLOP1GIQYb1KRz3ooyC6eAESR
         eCzr0ZlGNWRE0hgbLh0kWfd1CyafGl9pww5Nl/JksY1mF6BJrv+LzS7ozVduvwPlrsdD
         b8np9hhK46JikUgrDO2qQPPs4cLMEGaKtQJKuGL4fMz2NGdKDoROSGs7BJldgJymJGC8
         +VHuAtmIEfRIOzn9FACW1Jj4PmielSLXJajZ2bCppJU287HEntXR/qS7ClVf8WCwixSx
         sUFDiohfZq6qfdHQJVeVSE12vb8pPr8D/1FV47TUbR+EmI2Oz+tGayA/dbA7NS2EYWMj
         aZ+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1779785184; x=1780389984; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+Sm7AdbBwz89HswDM1U3a+4O4uaDOPsFPs5dz3aFbf8=;
        b=efVzBKvELuWfFlN+EUuEFDI6Y2s+IGuhCglblV/LB5cYkO+oW+SROlbSOCLDUxj+2Y
         vBiCZEZMOBBBGtodDkHk1jkrUeJ3qh+KyvPZ/cgZENdUoYwvxuRGvGIVM0jPQqR4KUWF
         1B9ovKjvtRAulWKBFtV0ubyZnp/uBw1d/nt5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779785184; x=1780389984;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Sm7AdbBwz89HswDM1U3a+4O4uaDOPsFPs5dz3aFbf8=;
        b=lcoe6Np2KE4q/UBW9Lk8aeJNjrJwrPik+DsSV/JKgwOQlDhQj3EP5x11TmBAhNwGB7
         3GHQIWGHcgyWFIqgRPfGX5HkScIVYhWyjGGgecQ82JDDlpRkGl9gEOnDQVKv0xBTBHIA
         Ec2miAGw3I+RLG1bOfO/3qvmSUG4G3AbcmTFxHatjKkEOUF9HzlT7gknkI98l1ILczir
         GZYxKOYlzuEzqgLN0eyJ7yOBiTXQkSlneIsTN9klbjG4IwDbZ9o1Cx8iO4XR+KnWoo0y
         GWSBLTJIQCxna5yOoi2nwLV9zM2HQ/zcJ/vrfvQ52fAY6PItv07g3acB7uy27Fe4FfJK
         bqcQ==
X-Forwarded-Encrypted: i=1; AFNElJ+OYFeOzU+8piJlRxYB+gOe0zRsYt0U0PxTiLRJMteI4g3BGHd55evzeRxqORbkWsHMjBKnfIqau0U1PEmi@vger.kernel.org
X-Gm-Message-State: AOJu0YxjJi+EKAUABDu1i2HDb9WicPV1XQj1SxdhxcT27OimjP3e6C2a
	Dnjae0k+2XU3jrXFR0T7notiLT3xmoK56JO/rMs85KPnG1rqkb6bP+EmIl8MGSeQkop1tDTjsQb
	lPC4a6jIhvseDU5PVDefGaoF1X8edngSohKB9h1qcPQ==
X-Gm-Gg: Acq92OEHSKsMqO1ZN3fnv4AEf7PqY7CyrxJP4UJS9Ntida1hAJrbvE+67DgS5l9nS0G
	L2cIbXL1CO4ogQFDb8lgdMtUXtwiTRxCMtJg3LwsSVOUh3iNqoWqGT6f9uB7QZWeS1wXlT1xyoE
	W5mmsUtVwdtoJFsJ151YtGH0Bpw+qEFpb/qIhEQRrrCV6bUQHwVCfAMngzKxcsRKVc6iFXeK9y6
	cv7r0K7Raeuz1YgP1VAQqM//aIhi8O8p+lndnbjsNqu7K5/qUH8etUn1MhT12PCRomgS79QdRF1
	0X8B8seCUzQjvOnVupKbGSCgKp/vRBJdfKNMgMK9MurKDAMT+DD16TCiTt73
X-Received: by 2002:a05:622a:1a96:b0:516:3183:c20f with SMTP id
 d75a77b69052e-516d5864945mr188188911cf.20.1779785183718; Tue, 26 May 2026
 01:46:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177945382308.2991556.1256192774754909984.b4-ty@b4> <5386153f-9112-4971-98fc-de90d7aae2c6@oracle.com>
In-Reply-To: <5386153f-9112-4971-98fc-de90d7aae2c6@oracle.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 26 May 2026 10:46:12 +0200
X-Gm-Features: AVHnY4IqbMVtwyrUXhgBbVSdtrrlrZmTIKsKCBn7O4rzlywtF9IJtI5xqfn6ILQ
Message-ID: <CAJfpegu3PawBxwOPEO-+at-B9zRTJOzY+z4qeV7xOwOQb3Fr7w@mail.gmail.com>
Subject: Re: [PATCH 1/3] tmpfs: simplify constructing "security.foo" xattr names
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Calum Mackay <calum.mackay@oracle.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>, linux-mm@kvack.org, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>, Chuck Lever <cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"

[Cc: Greg KH]

On Mon, 25 May 2026 at 05:59, Calum Mackay <calum.mackay@oracle.com> wrote:
>
> hi Christian, Miklos,
>
> https://lore.kernel.org/all/177945382308.2991556.1256192774754909984.b4-ty@b4/
>
> > Date: Fri, 22 May 2026 14:43:43 +0200> On Tue, 19 May 2026 10:13:21 +0200, Miklos Szeredi wrote:
> >> tmpfs: simplify constructing "security.foo" xattr names
> >
> > Thanks, this looks great!
> >
> > ---
> >
> > Applied to the vfs-7.2.misc branch of the vfs/vfs.git tree.
> > Patches in the vfs-7.2.misc branch should appear in linux-next soon.
> >
> > Please report any outstanding bugs that were missed during review in a
> > new review to the original patch series allowing us to drop it.
> >
> > It's encouraged to provide Acked-bys and Reviewed-bys even though the
> > patch has now been applied. If possible patch trailers will be updated.
> >
> > Note that commit hashes shown below are subject to change due to rebase,
> > trailer updates or similar. If in doubt, please check the listed branch.
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> > branch: vfs-7.2.misc
> >
> > [1/3] tmpfs: simplify constructing "security.foo" xattr names
> >       https://git.kernel.org/vfs/vfs/c/aba5853b137b
> > [2/3] simple_xattr: change interface to pass struct simple_xattrs **
> >       https://git.kernel.org/vfs/vfs/c/1cd9d2387c05
> > [3/3] simpe_xattr: use per-sb cache
> >       https://git.kernel.org/vfs/vfs/c/12e9e3cd03b5
>
>
> I have been doing some testing of Chuck's nfsd-testing tree, which
> includes some vfs changes.
>
> The test systems are reliably crashing, in what looks like it might
> possibly be something related to these three patches.

Calum, thanks for the report.

Relevant part of call trace is:

kernfs_new_node
  __kernfs_new_node
    security_kernfs_init_security
      selinux_kernfs_init_security
        kernfs_xattr_set
          kernfs_root

Since __parent is assigned after security_kernfs_init_security() gets
called, kernfs_root() will return NULL.

Greg, any idea about dealing with this?

Thanks,
Miklos


>
> I reverted the three patches, and the crashes stopped.
>
>
> best wishes,
> calum.
>
>
>
> [    9.215122] BUG: kernel NULL pointer dereference, address:
> 00000000000000e0
> [    9.218829] #PF: supervisor read access in kernel mode
> [    9.221484] #PF: error_code(0x0000) - not-present page
> [    9.224201] PGD 0 P4D 0
> [    9.225557] Oops: Oops: 0000 [#1] SMP NOPTI
> [    9.227773] CPU: 0 UID: 0 PID: 1 Comm: systemd Not tainted
> 7.1.0-rc4.master.20260524.el10.rc1.x86_64 #1 PREEMPT(lazy)
> [    9.233281] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.6.4 02/27/2023
> [    9.237483] RIP: 0010:simple_xattr_set+0x27/0x8b0
> [    9.239951] Code: 90 90 90 0f 1f 40 d6 0f 1f 44 00 00 55 48 89 e5 41
> 57 41 56 49 89 d6 41 55 49 89 f5 4c 89 c6 41 54 53 48 83 e4 f0 48 83 ec
> 40 <4c> 8b 27 44 89 4c 24 3c 4c 89 6c 24 20 48 89 54 24 28 4d 85 e4 0f
> [    9.249572] RSP: 0018:ffffd1334001fa20 EFLAGS: 00010282
> [    9.252362] RAX: ffff89974107e460 RBX: ffffffff856b2f80 RCX:
> ffff899758b0ef60
> [    9.256059] RDX: ffffffff856b2f80 RSI: 000000000000001e RDI:
> 00000000000000e0
> [    9.259712] RBP: ffffd1334001fa90 R08: 000000000000001e R09:
> 0000000000000001
> [    9.263416] R10: ffff89974107e460 R11: 0030733a745f7075 R12:
> 000000000000001e
> [    9.267138] R13: ffff89974107e498 R14: ffffffff856b2f80 R15:
> ffff8997443c5440
> [    9.270772] FS:  00007fc098c74500(0000) GS:ffff899ae8a58000(0000)
> knlGS:0000000000000000
> [    9.274906] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    9.277976] CR2: 00000000000000e0 CR3: 00000001013d1000 CR4:
> 00000000003506f0
> [    9.281668] Call Trace:
> [    9.282985]  <TASK>
> [    9.284145]  ? srso_return_thunk+0x5/0x5f
> [    9.286188]  ? srso_return_thunk+0x5/0x5f
> [    9.288277]  ? ktime_get_real_ts64+0xce/0x140
> [    9.290614]  ? srso_return_thunk+0x5/0x5f
> [    9.292776]  kernfs_xattr_set+0x63/0xb0
> [    9.294829]  selinux_kernfs_init_security+0x13b/0x270
> [    9.297496]  security_kernfs_init_security+0x36/0xc0
> [    9.300105]  __kernfs_new_node+0x182/0x290
> [    9.302421]  ? srso_return_thunk+0x5/0x5f
> [    9.304597]  ? srso_return_thunk+0x5/0x5f
> [    9.306645]  ? pcpu_alloc_noprof+0x481/0x990
> [    9.308854]  kernfs_new_node+0x80/0xc0
> [    9.310876]  kernfs_create_dir_ns+0x2b/0xa0
> [    9.313103]  cgroup_create+0x116/0x380
> [    9.315123]  cgroup_mkdir+0x7c/0x1a0
> [    9.317051]  kernfs_iop_mkdir+0x75/0xf0
> [    9.319014]  vfs_mkdir+0xc2/0x240
> [    9.320809]  filename_mkdirat+0x1cc/0x220
> [    9.322932]  __x64_sys_mkdir+0x2f/0x50
> [    9.324938]  do_syscall_64+0xe8/0x5e0
> [    9.326895]  ? srso_return_thunk+0x5/0x5f
> [    9.329104]  ? count_memcg_events+0xdf/0x190
> [    9.331392]  ? srso_return_thunk+0x5/0x5f
> [    9.333556]  ? handle_mm_fault+0x24a/0x350
> [    9.335741]  ? srso_return_thunk+0x5/0x5f
> [    9.337894]  ? do_user_addr_fault+0x221/0x680
> [    9.340194]  ? srso_return_thunk+0x5/0x5f
> [    9.342653]  ? arch_exit_to_user_mode_prepare.isra.0+0x9/0xe0
> [    9.345955]  ? srso_return_thunk+0x5/0x5f
> [    9.348377]  ? srso_return_thunk+0x5/0x5f
> [    9.350793]  ? do_syscall_64+0x9d/0x5e0
> [    9.353123]  ? srso_return_thunk+0x5/0x5f
> [    9.355707]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [    9.358689] RIP: 0033:0x7fc09832076b
> [    9.360891] Code: 0f 1e fa 48 89 f2 b9 00 01 00 00 48 89 fe bf 9c ff
> ff ff e9 a7 ca ff ff 0f 1f 80 00 00 00 00 f3 0f 1e fa b8 53 00 00 00 0f
> 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 71 56 0d 00 f7 d8
> [    9.371018] RSP: 002b:00007ffd34f0af28 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000053
> [    9.375220] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
> 00007fc09832076b
> [    9.379178] RDX: 0000000000000000 RSI: 00000000000001ed RDI:
> 00005609edb55790
> [    9.383159] RBP: 00007ffd34f0af60 R08: 0000000000000000 R09:
> 0000000000000000
> [    9.387102] R10: 0000000000000000 R11: 0000000000000246 R12:
> 00005609edaeea70
> [    9.391136] R13: 0000000000001fad R14: 00007fc098754472 R15:
> 00005609edb481d0
> [    9.395140]  </TASK>
> [    9.396605] Modules linked in: vsock_loopback
> vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock
> vmw_vmci xfs nvme_tcp nvme_fabrics nvme_core nvme_keyring nvme_auth
> sd_mod ata_generic pata_acpi ata_piix virtio_net net_failover failover
> libata virtio_scsi serio_raw btrfs libblake2b zstd_compress raid6_pq xor
> sunrpc dm_mirror dm_region_hash dm_log be2iscsi bnx2i cnic uio cxgb4i
> cxgb4 tls cxgb3i cxgb3 mdio libcxgbi libcxgb qla4xxx iscsi_tcp
> libiscsi_tcp libiscsi scsi_transport_iscsi iscsi_ibft iscsi_boot_sysfs
> dm_multipath dm_mod qemu_fw_cfg virtio_pci virtio_pci_legacy_dev
> virtio_pci_modern_dev
> [    9.424581] CR2: 00000000000000e0
> [    9.426635] ---[ end trace 0000000000000000 ]---
> [    9.429400] RIP: 0010:simple_xattr_set+0x27/0x8b0
> [    9.432229] Code: 90 90 90 0f 1f 40 d6 0f 1f 44 00 00 55 48 89 e5 41
> 57 41 56 49 89 d6 41 55 49 89 f5 4c 89 c6 41 54 53 48 83 e4 f0 48 83 ec
> 40 <4c> 8b 27 44 89 4c 24 3c 4c 89 6c 24 20 48 89 54 24 28 4d 85 e4 0f
> [    9.442394] RSP: 0018:ffffd1334001fa20 EFLAGS: 00010282
> [    9.445458] RAX: ffff89974107e460 RBX: ffffffff856b2f80 RCX:
> ffff899758b0ef60
> [    9.449465] RDX: ffffffff856b2f80 RSI: 000000000000001e RDI:
> 00000000000000e0
> [    9.453436] RBP: ffffd1334001fa90 R08: 000000000000001e R09:
> 0000000000000001
> [    9.457506] R10: ffff89974107e460 R11: 0030733a745f7075 R12:
> 000000000000001e
> [    9.461589] R13: ffff89974107e498 R14: ffffffff856b2f80 R15:
> ffff8997443c5440
> [    9.465681] FS:  00007fc098c74500(0000) GS:ffff899ae8a58000(0000)
> knlGS:0000000000000000
> [    9.470290] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    9.473702] CR2: 00000000000000e0 CR3: 00000001013d1000 CR4:
> 00000000003506f0
> [    9.477743] Kernel panic - not syncing: Fatal exception
> [    9.481889] Kernel Offset: 0x2a00000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [    9.487771] ---[ end Kernel panic - not syncing: Fatal exception ]---
>
