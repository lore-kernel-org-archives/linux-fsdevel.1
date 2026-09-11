Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96DE363C43
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 15:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141900; cv=pass; b=tgEuCObXWBX1F7iOIvZxSPvzubpsUTof0QFbdtKFdgIjz9jtlRb5w02anC5Urpuo3JwCUBSC5cN2OEoEpZJXKPP9p8r/YdUGTxY0SgcfzBHXoAe2ye7YfE0UnEkltHOb42MdOh9ev8XsSo4dl+MWwoCeZ+oGbLyytmW3KUbDUD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141900; c=relaxed/simple;
	bh=lnoFnSUg4XhHgwIwRRh0evPZGEBDZe40rq46R9uUe7Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=mzZUaf0URmWROxqazEt9tnoMcDScaoTDb2nBfovpabtzdcaU3yM/jENcQIFX8lGuO1fnGQJPuJrhDe1I+qxk9Edt1OW1nSEzyAsPZMOOHwmNGlKSbthL8YOvY87yqiaWXTcmAFouD07PiaPrYipUtVdT3Cn5vIP0cmtqdfcaFQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=eM3gfYog; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="eM3gfYog"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc147d86bebso1290415a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 08:51:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789141898; cv=none;
        d=google.com; s=arc-20260327;
        b=emD1+DvJ2BC+wyAOcA5EjzdeX0BewGbPMdim/MZ8qnG3JAL4olfcUIWmKssh6DGSrK
         2h3fCPh+43RxtEoM0M0oRIgzPweZY2sWn57fNQqbyCHL4rOkiu17Lyikzf+WKKQ6I9LT
         Fd+0m7ZBHNAmAz26AL6YZduQVoZx0ToZXZ1FjMTgVk+tJ7IGrw/dA9JnObQ34nU5jCzw
         FAC+RM2rm/pn3QZmxFioc/8ZPsYGWOFnf6NJR6Gm2F2Z90MvztKpzCivTci5Y4y+HOtL
         jpUlPvGnJ4mM+SZzMaPwa76Jej9MGp7DJfp99u5J2L193jAsbG1QjFAKBZAbhahB0ahP
         wdBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=zbSeo6CIdzS1t5Q3OPCYj0CPSvDQpaUOQ1GJQh/BXe0=;
        fh=w/TVITUCPErTTPAj5qJdgWi/r+s2Pox24tLdmP/8bW4=;
        b=rbnjZPEgx4c24s1OvbR3Hi09sJ6nbuiNFas0aKfzUrv5BxaL32yzFc0YGx8d7v3QYh
         OR4JJjcQvAofqk5QRAzysH76wG09aV4gEv2/YZeW+EeJfBiys2TPwjW3raE+V5MU+zfP
         rtTVP6YcGVDOxLrD7JseL65XuOSJTAfF9C1n7bZRtPQn9wX1EalrSiW+Vkj5f5pOj/0+
         QR+5airMf+6ZbIg3wbSaf9WaARYK3K4sIqxRg7VTtubTFsALBntU5gVUW4Kw1m36VHXR
         OUVR6sQZuk06L6IY6JdAzfQ82H1XZ54Ig5SQtrBARcW7xm8FoBxKIg27QIEsUge6G7kZ
         8L1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1789141898; x=1789746698; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zbSeo6CIdzS1t5Q3OPCYj0CPSvDQpaUOQ1GJQh/BXe0=;
        b=eM3gfYogaC5KH5WTWilSroTvFYZsMPj7H5GRtaAzNU+XjVB5f55Wkv58HrZRU2IGE+
         Vu5blc+q73gg0usnlzlfmUNoxKhrUwcPc+iYXv7Du24s3DEwX6Er45asy+w/H8z+KSbr
         4p+jFxq/ImLT/5Ox8xh7MCNUtLNTruWjszx2XLiRy0JHvGiifG5oCEGve7KLiCyvT5XJ
         Em8lt8JfiML5qIHKPSF4FHqUMdyHgOf0Crf6TdGlJ/ZmmgxdKzTf0CK1T4Rmv/ktiw0R
         3wj6Pktc6CehYfGJLm4TIgdb8ZlevthS/VI3nW0ps94eNhQHFMhhSytdde1PZTh6E5js
         zl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789141898; x=1789746698;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zbSeo6CIdzS1t5Q3OPCYj0CPSvDQpaUOQ1GJQh/BXe0=;
        b=WaUxlPVLSyF4inUneUPlvh9/x1nigjeiCzSADqxHBWc7U+5UI5dKfZ+1F2V6Jm1+PP
         RcKYvKUM4RU8Z75+/89hIQ+XyzC/eqqNszQeXhfb2diPiTny8iJOceES418ihezNpAsW
         lLlVOJVKyRCZkihhz585HMuOZuLhFP5kIfDBbOyVB0h3rGhjVLK6yIqwSdwGj0w9tkgu
         44zA3frgoknIlK0zHytDO38XZ9joeRSqOlfQ7weRsUsLHceEzSldw+EKifOvAqdKWvrN
         VdKIEzROHDgxb1gqFSMsMyyclVh6lB0VNqTrE6jKyeYgXBC2H+uoYdDwfGA4sKTd4iB5
         IPNA==
X-Forwarded-Encrypted: i=1; AKwUvByZtKK8TzYaFHyfDbl4zqFjJ3nQVYocYeBvVikrYtw5OhXpvyl22vK9C8bVC64t4TeKmxkDiVn/uegGToPy@vger.kernel.org
X-Gm-Message-State: AFuF++kscTVdGMlvHFdvd8YCmaWnGIbc7/YfKWbhB2N5XwZmEymeOwRl
	9RlNHVUa/8RxDbKnt2qSBcNYCgscpwqZCzMPanL7QubV3zQzcFFg5XJEoPglM6PknbAtkDpxZ2h
	Yk2oNH5h7w8+l00b8G8KM/+mO2vdbELEfEfjO1tyD1bDJugLnY2giJKeZ8hT/3A==
X-Gm-Gg: AYBFou0/L6bA9T7ljzSiaxpiqUFv5vMw9m6/9w8i2eYqHuQJM6Rcx4PJYtgRWQ1DIR6
	fN/ZDOCZV/UGPwf9xqkm4g8jeOq58eWrYTrf+xBWbPJKazyLkz+FSpJqbjJtSid8wbZWoiod2d3
	c9R15mNyKiRiAVVftzphdtEu8MY/Juwpna4mAk7JS8PGjKUbYsOjd2+KjMr1uhnt6+vZ6USkktk
	JrQBtR2MLdtW3FGVfUQJUZku2ajXtlyrxs0s2Fk1WwfF39jfjnma1UJFH8oHGAZ4Ds9pUDSD2z6
	xBRcti3XxyINCzeKmbWCsMyrdEAIOVoMxrB2vk7p68qw6fvFTQRWbWj5xpA/SgP/zqUCcFi1vnD
	kkeAR7geeT3Db9objT1doq7/HVCkzggsKeYGb+nmk3WzSCIimsulxeAJtLDHliS/Q/qkAbQzQHz
	o=
X-Received: by 2002:a05:6a21:6803:b0:3c4:2cd3:f0bb with SMTP id
 adf61e73a8af0-3dad272064amr11450396637.10.1789141896604; Fri, 11 Sep 2026
 08:51:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Farhad Alemi <farhad.alemi@berkeley.edu>
Date: Fri, 11 Sep 2026 08:51:25 -0700
X-Gm-Features: AcwNN1WQCI8_33oS5pPimYF054_tctSGmM79AD1885EJXsgw10bbv5_XNqOt5vU
Message-ID: <CA+0ovChM9=2RkQngMbBhyqiHn-f6bECUvocDvzbZm8AohRiVYg@mail.gmail.com>
Subject: [BUG] WARNING in thaw_super_locked
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000033d95b065b370f39"

--00000000000033d95b065b370f39
Content-Type: text/plain; charset="UTF-8"

Hello,

We are reporting the following crash (reproducer attached):
Linux version 7.3.0-rc2 50d05c7c76c96b90462f24debacca971d2e86713
Build Config: UpstreamAppArmorKASAN (KASAN + UBSAN, panic_on_warn=1)

[   50.331769][ T9500] sb->s_writers.freeze_kcount == 0
[   50.331782][ T9500] WARNING: fs/super.c:2172 at
thaw_super_locked+0x437/0x960, CPU#1: repro/9500
[   50.337664][ T9500] Modules linked in:
[   50.338411][ T9500] CPU: 1 UID: 0 PID: 9500 Comm: repro Not tainted
7.3.0-rc2-00099-g50d05c7c76c9 #1 PREEMPT(full)
[   50.340359][ T9500] Hardware name: QEMU Standard PC (Q35 + ICH9,
2009), BIOS 1.17.0-debian-1.17.0-1ubuntu1 04/01/2014
[   50.342404][ T9500] RIP: 0010:thaw_super_locked+0x437/0x960
[   50.342962][ T9500] Code: ff 90 0f 0b 90 41 bf ea ff ff ff e9 7f 02
00 00 e8 be 5c 7b ff 90 0f 0b 90 41 bf ea ff ff ff e9 6b 02 00 00 e8
aa 5c 7b ff 90 <0f> 0b 90 41 bf ea ff ff ff e9 57 02 00 00 e8 96 5c 7b
ff 90 0f 0b
[   50.344752][ T9500] RSP: 0018:ffffc90008eafa68 EFLAGS: 00010293
[   50.345341][ T9500] RAX: ffffffff824c3fd6 RBX: ffff88810a876000
RCX: ffff88802a25cc80
[   50.346063][ T9500] RDX: 0000000000000000 RSI: 0000000000000000
RDI: 0000000000000000
[   50.346777][ T9500] RBP: ffff88810a876378 R08: ffff88810a87608f
R09: 1ffff1102150ec11
[   50.347500][ T9500] R10: dffffc0000000000 R11: ffffed102150ec12
R12: 0000000000000001
[   50.348223][ T9500] R13: 0000000000000000 R14: ffff88810a87637c
R15: 0000000000000001
[   50.348941][ T9500] FS:  00000000028c2400(0000)
GS:ffff8881da588000(0000) knlGS:0000000000000000
[   50.349778][ T9500] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   50.350384][ T9500] CR2: 000055c32878aae0 CR3: 000000010adda000
CR4: 0000000000752ef0
[   50.351219][ T9500] PKRU: 55555554
[   50.351570][ T9500] Call Trace:
[   50.351913][ T9500]  <TASK>
[   50.352195][ T9500]  filesystems_thaw_callback+0x1b8/0x2f0
[   50.352713][ T9500]  __iterate_supers+0x2ce/0x420
[   50.353193][ T9500]  ? __pfx_filesystems_thaw_callback+0x10/0x10
[   50.353784][ T9500]  ? __pfx___iterate_supers+0x10/0x10
[   50.354334][ T9500]  ? schedule+0x16e/0x2b0
[   50.354806][ T9500]  pm_suspend+0x58c/0x760
[   50.355245][ T9500]  state_store+0x206/0x290
[   50.355693][ T9500]  ? __pfx_sysfs_kf_write+0x10/0x10
[   50.356209][ T9500]  kernfs_fop_write_iter+0x3af/0x540
[   50.356698][ T9500]  vfs_write+0x61d/0xb90
[   50.357098][ T9500]  ? __pfx_vfs_write+0x10/0x10
[   50.357544][ T9500]  ? do_sys_openat2+0x14e/0x200
[   50.357997][ T9500]  ? kmem_cache_free+0x182/0x650
[   50.358460][ T9500]  ksys_write+0x150/0x270
[   50.358866][ T9500]  ? __pfx_ksys_write+0x10/0x10
[   50.359604][ T9500]  do_syscall_64+0x155/0x510
[   50.360070][ T9500]  ? trace_irq_disable+0x3b/0x140
[   50.360560][ T9500]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   50.361196][ T9500]  ? clear_bhb_loop+0x30/0x80
[   50.361655][ T9500]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   50.362218][ T9500] RIP: 0033:0x42e806
[   50.362588][ T9500] Code: 47 ba 04 00 00 00 48 c7 c0 f0 ff ff ff 64
89 10 48 c7 c2 ff ff ff ff c9 48 89 d0 c3 0f 1f 84 00 00 00 00 00 48
8b 45 10 0f 05 <48> 89 c2 48 3d 00 f0 ff ff 77 0f c9 48 89 d0 c3 66 2e
0f 1f 84 00
[   50.364338][ T9500] RSP: 002b:00007ffec5fbaa00 EFLAGS: 00000202
ORIG_RAX: 0000000000000001
[   50.365096][ T9500] RAX: ffffffffffffffda RBX: 0000000000000001
RCX: 000000000042e806
[   50.365817][ T9500] RDX: 0000000000000003 RSI: 00000000004880f9
RDI: 0000000000000004
[   50.366529][ T9500] RBP: 00007ffec5fbaa10 R08: 0000000000000000
R09: 0000000000000000
[   50.367283][ T9500] R10: 0000000000000000 R11: 0000000000000202
R12: 00007ffec5fbaba8
[   50.368042][ T9500] R13: 00007ffec5fbabb8 R14: 0000000000000002
R15: 00000000004af120
[   50.368775][ T9500]  </TASK>
[   50.369071][ T9500] Kernel panic - not syncing: kernel: panic_on_warn set ...
[   50.369727][ T9500] CPU: 1 UID: 0 PID: 9500 Comm: repro Not tainted
7.3.0-rc2-00099-g50d05c7c76c9 #1 PREEMPT(full)
[   50.370770][ T9500] Hardware name: QEMU Standard PC (Q35 + ICH9,
2009), BIOS 1.17.0-debian-1.17.0-1ubuntu1 04/01/2014
[   50.371772][ T9500] Call Trace:
[   50.372100][ T9500]  <TASK>
[   50.372373][ T9500]  vpanic+0x56d/0xa60
[   50.372745][ T9500]  ? __pfx__printk+0x10/0x10
[   50.373177][ T9500]  ? __pfx_vpanic+0x10/0x10
[   50.373593][ T9500]  ? is_bpf_text_address+0x292/0x2b0
[   50.374086][ T9500]  ? is_bpf_text_address+0x26/0x2b0
[   50.374586][ T9500]  panic+0xc5/0xd0
[   50.374938][ T9500]  ? __pfx_panic+0x10/0x10
[   50.375357][ T9500]  __warn+0x315/0x4c0
[   50.375725][ T9500]  ? thaw_super_locked+0x437/0x960
[   50.376198][ T9500]  ? thaw_super_locked+0x437/0x960
[   50.376687][ T9500]  __report_bug+0x273/0x580
[   50.377135][ T9500]  ? thaw_super_locked+0x437/0x960
[   50.377628][ T9500]  ? __pfx___report_bug+0x10/0x10
[   50.378137][ T9500]  ? thaw_super_locked+0x437/0x960
[   50.378604][ T9500]  report_bug+0x16b/0x220
[   50.379010][ T9500]  ? thaw_super_locked+0x437/0x960
[   50.379479][ T9500]  ? thaw_super_locked+0x439/0x960
[   50.379951][ T9500]  handle_bug+0x9c/0x200
[   50.380350][ T9500]  exc_invalid_op+0x1a/0x50
[   50.380870][ T9500]  asm_exc_invalid_op+0x1a/0x20
[   50.381338][ T9500] RIP: 0010:thaw_super_locked+0x437/0x960
[   50.381890][ T9500] Code: ff 90 0f 0b 90 41 bf ea ff ff ff e9 7f 02
00 00 e8 be 5c 7b ff 90 0f 0b 90 41 bf ea ff ff ff e9 6b 02 00 00 e8
aa 5c 7b ff 90 <0f> 0b 90 41 bf ea ff ff ff e9 57 02 00 00 e8 96 5c 7b
ff 90 0f 0b
[   50.383638][ T9500] RSP: 0018:ffffc90008eafa68 EFLAGS: 00010293
[   50.384194][ T9500] RAX: ffffffff824c3fd6 RBX: ffff88810a876000
RCX: ffff88802a25cc80
[   50.384929][ T9500] RDX: 0000000000000000 RSI: 0000000000000000
RDI: 0000000000000000
[   50.385692][ T9500] RBP: ffff88810a876378 R08: ffff88810a87608f
R09: 1ffff1102150ec11
[   50.386447][ T9500] R10: dffffc0000000000 R11: ffffed102150ec12
R12: 0000000000000001
[   50.387164][ T9500] R13: 0000000000000000 R14: ffff88810a87637c
R15: 0000000000000001
[   50.387916][ T9500]  ? thaw_super_locked+0x436/0x960
[   50.388413][ T9500]  ? thaw_super_locked+0x436/0x960
[   50.388920][ T9500]  filesystems_thaw_callback+0x1b8/0x2f0
[   50.389463][ T9500]  __iterate_supers+0x2ce/0x420
[   50.389916][ T9500]  ? __pfx_filesystems_thaw_callback+0x10/0x10
[   50.390474][ T9500]  ? __pfx___iterate_supers+0x10/0x10
[   50.391077][ T9500]  ? schedule+0x16e/0x2b0
[   50.391503][ T9500]  pm_suspend+0x58c/0x760
[   50.391933][ T9500]  state_store+0x206/0x290
[   50.392346][ T9500]  ? __pfx_sysfs_kf_write+0x10/0x10
[   50.393100][ T9500]  kernfs_fop_write_iter+0x3af/0x540
[   50.393612][ T9500]  vfs_write+0x61d/0xb90
[   50.394039][ T9500]  ? __pfx_vfs_write+0x10/0x10
[   50.394494][ T9500]  ? do_sys_openat2+0x14e/0x200
[   50.394946][ T9500]  ? kmem_cache_free+0x182/0x650
[   50.395406][ T9500]  ksys_write+0x150/0x270
[   50.395808][ T9500]  ? __pfx_ksys_write+0x10/0x10
[   50.396264][ T9500]  do_syscall_64+0x155/0x510
[   50.396691][ T9500]  ? trace_irq_disable+0x3b/0x140
[   50.397157][ T9500]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   50.397706][ T9500]  ? clear_bhb_loop+0x30/0x80
[   50.398141][ T9500]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   50.398702][ T9500] RIP: 0033:0x42e806
[   50.399085][ T9500] Code: 47 ba 04 00 00 00 48 c7 c0 f0 ff ff ff 64
89 10 48 c7 c2 ff ff ff ff c9 48 89 d0 c3 0f 1f 84 00 00 00 00 00 48
8b 45 10 0f 05 <48> 89 c2 48 3d 00 f0 ff ff 77 0f c9 48 89 d0 c3 66 2e
0f 1f 84 00
[   50.400946][ T9500] RSP: 002b:00007ffec5fbaa00 EFLAGS: 00000202
ORIG_RAX: 0000000000000001
[   50.401732][ T9500] RAX: ffffffffffffffda RBX: 0000000000000001
RCX: 000000000042e806
[   50.402465][ T9500] RDX: 0000000000000003 RSI: 00000000004880f9
RDI: 0000000000000004
[   50.403178][ T9500] RBP: 00007ffec5fbaa10 R08: 0000000000000000
R09: 0000000000000000
[   50.403894][ T9500] R10: 0000000000000000 R11: 0000000000000202
R12: 00007ffec5fbaba8
[   50.404618][ T9500] R13: 00007ffec5fbabb8 R14: 0000000000000002
R15: 00000000004af120
[   50.405337][ T9500]  </TASK>
[   50.405933][ T9500] Kernel Offset: disabled
[   50.406477][ T9500] Rebooting in 86400 seconds..

Regards,

--00000000000033d95b065b370f39
Content-Type: application/octet-stream; name="reproducer.c"
Content-Disposition: attachment; filename="reproducer.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mtx4uqx20>
X-Attachment-Id: f_mtx4uqx20

LyoKICogMjQ1LXdhcm5pbmctaW4tdGhhdy1zdXBlci1sb2NrZWQKICovCiNkZWZpbmUgX0dOVV9T
T1VSQ0UKI2luY2x1ZGUgPGZjbnRsLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN0
cmluZy5oPgojaW5jbHVkZSA8c3lzL2lvY3RsLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KCiNpZm5k
ZWYgRklGUkVFWkUKI2RlZmluZSBGSUZSRUVaRSAweEMwMDQ1ODc3CiNlbmRpZgoKc3RhdGljIHZv
aWQgd3JpdGVfcG93ZXJfYXR0cmlidXRlKGNvbnN0IGNoYXIgKnBhdGgsIGNvbnN0IGNoYXIgKnZh
bHVlKQp7CglpbnQgYXR0cmlidXRlX2ZkID0gb3BlbihwYXRoLCBPX1dST05MWSk7CgoJaWYgKGF0
dHJpYnV0ZV9mZCA8IDApCgkJZXhpdCgxKTsKCWlmICh3cml0ZShhdHRyaWJ1dGVfZmQsIHZhbHVl
LCBzdHJsZW4odmFsdWUpKSA8IDApCgkJZXhpdCgxKTsKCWNsb3NlKGF0dHJpYnV0ZV9mZCk7Cn0K
CmludCBtYWluKHZvaWQpCnsKCWludCB2aWN0aW1fbW91bnRfZmQ7CgoJaWYgKHN5c3RlbSgiZGQg
aWY9L2Rldi96ZXJvIG9mPS92YXIvdG1wL3ZpY3RpbS5pbWcgYnM9MU0gY291bnQ9NjQgc3RhdHVz
PW5vbmUgJiYgIgoJCSAgICJta2ZzLmV4dDQgLXEgLUYgLU8gXmhhc19qb3VybmFsIC92YXIvdG1w
L3ZpY3RpbS5pbWcgJiYgIgoJCSAgICJta2RpciAtcCAvbW50L3ZpY3RpbSAmJiAiCgkJICAgIm1v
dW50IC1vIGxvb3AgL3Zhci90bXAvdmljdGltLmltZyAvbW50L3ZpY3RpbSIpICE9IDApCgkJcmV0
dXJuIDE7CgoJdmljdGltX21vdW50X2ZkID0gb3BlbigiL21udC92aWN0aW0iLCBPX1JET05MWSB8
IE9fRElSRUNUT1JZKTsKCWlmICh2aWN0aW1fbW91bnRfZmQgPCAwKQoJCXJldHVybiAxOwoKCWlm
IChpb2N0bCh2aWN0aW1fbW91bnRfZmQsIEZJRlJFRVpFLCAwKSA8IDApCgkJcmV0dXJuIDE7CgoJ
d3JpdGVfcG93ZXJfYXR0cmlidXRlKCIvc3lzL3Bvd2VyL3BtX3Rlc3QiLCAiZnJlZXplciIpOwoK
CXdyaXRlX3Bvd2VyX2F0dHJpYnV0ZSgiL3N5cy9wb3dlci9zdGF0ZSIsICJtZW0iKTsKCXJldHVy
biAwOwp9Cg==
--00000000000033d95b065b370f39--
