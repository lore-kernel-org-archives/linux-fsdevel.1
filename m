Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2D33A7F7A
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 21:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782508419; cv=none; b=U2QYfomdkjUkzKQyAbdtzLF5qCJJc0Bw5tManQwafwedg77Ytz4AFGWrpseDeNlJlM/mShXdxfzIg3wYccQXs0aPnfvsp6z9fVwRH/lN8BDVo/UY1ODkZx6UTsU9J7W2SrLYAkHZUmadWWqYH/pxJ0cGktV8jNWLX2n+7445YdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782508419; c=relaxed/simple;
	bh=bPib/RDr0CxnXKWlNP4gTRDtiJoJIUz27/LnTWVxFjs=;
	h=Message-ID:Date:Subject:To:Cc:Content-Type:MIME-Version:From; b=eopBYlePdDBUKvHBBhHviNkOJuJOToV6/7G3Gs2kjnnY55JW0nSR4fIXvlRtpfxNu5v3hWft3kPrPha2PS64obKBTS1YMSIzpR41/XJei3kJ4k/082nf58Hj8VRF1K2TH9ipXSJdUWRmTiID5hPh2qIwKyfZhD6upCoDrptXNWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7+WZKX0; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7+WZKX0"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-73536bbf21cso67518137.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 14:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782508417; x=1783113217; darn=vger.kernel.org;
        h=from:mime-version:content-transfer-encoding:content-type:cc:to
         :subject:date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i39cy/BX4UegoOmffDYmQbgIGizc1AhH9VWiXyD8JXQ=;
        b=Z7+WZKX0hjJwBLc18mvcP9V/ISAuvfmxJiFizndasf1y1z3hj9inYWKGZ1uumcxb6r
         8H7U2V4T6K3AAu9doWjmc8syBypzR+J5OJelFEJvkCVRBjhS9Slh1lMo4MIa3MPFGmZS
         LefbKfg/2jOnSQveynTTBdux34SCYakgDypwLM6sHMamboGp8zma0/ZJgYe2FbpUb/Eo
         x0VecTlCxjHtMJ5vqmoEL7Uo7z+pSlOHZvCo6u41oxJss/MFZE/HdcBN1n0OIlVmIFQE
         18A0tR6mfv2zneHF7r++SDebslnuWocaKXT7pwAKZ0p/pdKdX/zzqCfbFBFB8Gh0FGEe
         sshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782508417; x=1783113217;
        h=from:mime-version:content-transfer-encoding:content-type:cc:to
         :subject:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=i39cy/BX4UegoOmffDYmQbgIGizc1AhH9VWiXyD8JXQ=;
        b=tOHcDBXRGClpT9jszHMplaYNjop6OhhIu7nne2/vXhMfsETz0vQHxlQIw3nqeU0CtJ
         6atO1w07xioeP9ENxz8GzoAsn889YKAKvvNxkhDohnoGi6G3lK8kG/WQKYXB7wSgKJxp
         go9PWYuX3weCioxqNFIa0/NSSoW6PkquN7PuBtRNsUMRrTXdGvyWspcBLDb8ktKpMC7m
         l4adUuC3U/4FecbxZMfmvvm/LNzQ9Xco+rjbpEXj48U84lU7ZxzNhT04r16CpzTUuj3R
         1Iy4HbhyQ8MelbCRRxVT2ppnGx3MNgjbR8BvujF/9BEfHCtxQdPsmz6dwKKJm3oDzzJu
         n4TA==
X-Forwarded-Encrypted: i=1; AHgh+Rpv15+eLoZku5nWHSIoH0BJIIKrfYLJPCkJ6PB+2P8tjZSllvZ5yRQRxmA4uHAwVnxSAKQky3HANOozXja3@vger.kernel.org
X-Gm-Message-State: AOJu0YxpMrj5A6v0Vbvkp5COjkTLKpdsJYGpCg8bACwVJipZE8wklHyn
	wXjMTUoQ2HQoHcoxbUmDWYy/ISwepVpj2YJrmhydtBj/I5/t6mWLlAywSJcQvmye
X-Gm-Gg: AfdE7clET31o302kB5WqQFMp7KIDo8wcrueyMGySUtvqXrd9zZa5c0934ssYsO0g0gs
	/o+TTfJ65b6qF7x6DJJtr6RDQjRHMMv7CKwRvuDWAZX0QcgQTwdxU4bjUfxZgb23XG96+YJEdl4
	8tq+fxawK8Gy0jwiqz/xkGguD4bZYlLgI6hSO54gEwUyD+SzszDnYfsyiEO6Y1P5sJhvykcw7Mh
	doyS0L4V7FuIKLiZ5FiGMPRihyUYIDvGhQbe/ve2dMeW173XJhN1VnHAY0WEe3Aj2kriPrjbBmF
	6ACJCT6YHWgQTaIFjjrpUU+zzM8S4VX1ucMipOHal9MdsTSeOph1ldeHzfvXJ+CFx7qtC3mMSaZ
	TrvXJ0fwHoDOyORdLLR4k3TP8bv9Ma9H6NyMmbujelc7xOLpDSQE6pUXnU/FTrQD62pyUvXWRAh
	jW4RxKLai5ci9nQAUEugsa78uKWrm9v7mWG9T3iS5wB5rD6gXPnRyZU6v2VOdazxPj/eDAkJOFi
	XNkvhBid9XU
X-Received: by 2002:a05:6102:5110:b0:631:bcfa:39d2 with SMTP id ada2fe7eead31-73436bf020cmr1686749137.6.1782508416558;
        Fri, 26 Jun 2026 14:13:36 -0700 (PDT)
Received: from [192.168.10.115] ([132.170.207.48])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-73566a9de46sm1862932137.4.2026.06.26.14.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 14:13:36 -0700 (PDT)
Message-ID: <6a3eeb80.c68533e6.3320fc.f244@mx.google.com>
Date: Fri, 26 Jun 2026 14:13:36 -0700 (PDT)
Subject: kernel BUG at hfs_write_inode [verbose debug info unavailable]
To: slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: syzkaller@googlegroups.com, contact@pgazz.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: sanan.hasanou@gmail.com

Good day, dear maintainers,

We found a bug using a modified version of syzkaller.

Kernel Branch: 7.0-rc1
Kernel Config: <https://drive.google.com/open?id=173DLEAEPKPhhR1TcqofdnkLpdoK7PMFl>
Reproducer: <https://drive.google.com/open?id=1CqxzPCkagwu-C1x-19rSi9hAPdorJFHY>
Thank you!

Best regards,
Sanan Hasanov

------------[ cut here ]------------
Kernel BUG at hfs_write_inode+0x8b1/0x8c0 [verbose]
Oops: invalid opcode: 0000 [#1] SMP KASAN
CPU: 0 UID: 0 PID: 52148 Comm: kworker/u8:18 Tainted: G             L      7.0.0-rc1 #1 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: writeback wb_workfn (flush-7:7)
RIP: 0010:hfs_write_inode+0x8b1/0x8c0 fs/hfs/inode.c:474
Code: ff e9 c5 fd ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 61 fe ff ff 4c 89 f7 e8 4a 02 85 ff e9 54 fe ff ff e8 d0 d2 18 ff 90 <0f> 0b 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 0f 1f 44
RSP: 0018:ffffc900107e72c0 EFLAGS: 00010293
RAX: ffffffff82a97f00 RBX: ffff88805491a520 RCX: ffff88801ccc2700
RDX: 0000000000000000 RSI: ffffffff8eb6dc00 RDI: 0000000000000000
RBP: ffffc900107e7450 R08: ffff88801ccc2700 R09: 0000000000000003
R10: 0000000000000004 R11: 0000000000000000 R12: 1ffff920020fce5c
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff88805491a4e0
FS:  0000000000000000(0000) GS:ffff8880d98df000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f80878c4e78 CR3: 00000000476ce000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 write_inode fs/fs-writeback.c:1581 [inline]
 __writeback_single_inode+0x56f/0x870 fs/fs-writeback.c:1812
 writeback_sb_inodes+0x73b/0x1110 fs/fs-writeback.c:2040
 wb_writeback+0x3fa/0x690 fs/fs-writeback.c:2226
 wb_do_writeback fs/fs-writeback.c:2373 [inline]
 wb_workfn+0x3db/0xef0 fs/fs-writeback.c:2413
 process_one_work kernel/workqueue.c:3275 [inline]
 process_scheduled_works+0x811/0xf10 kernel/workqueue.c:3358
 worker_thread+0x9c1/0xeb0 kernel/workqueue.c:3439
 kthread+0x3c1/0x4d0 kernel/kthread.c:467
 ret_from_fork+0x608/0xc40 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:hfs_write_inode+0x8b1/0x8c0 fs/hfs/inode.c:474
Code: ff e9 c5 fd ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 61 fe ff ff 4c 89 f7 e8 4a 02 85 ff e9 54 fe ff ff e8 d0 d2 18 ff 90 <0f> 0b 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 0f 1f 44
RSP: 0018:ffffc900107e72c0 EFLAGS: 00010293
RAX: ffffffff82a97f00 RBX: ffff88805491a520 RCX: ffff88801ccc2700
RDX: 0000000000000000 RSI: ffffffff8eb6dc00 RDI: 0000000000000000
RBP: ffffc900107e7450 R08: ffff88801ccc2700 R09: 0000000000000003
R10: 0000000000000004 R11: 0000000000000000 R12: 1ffff920020fce5c
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff88805491a4e0
FS:  0000000000000000(0000) GS:ffff8880d99df000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdb2c2dff0 CR3: 000000003181d000 CR4: 00000000000006f0

<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>

Oops: invalid opcode: 0000 [#1] SMP KASAN
CPU: 0 UID: 0 PID: 52148 Comm: kworker/u8:18 Tainted: G             L      7.0.0-rc1 #1 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: writeback wb_workfn (flush-7:7)
RIP: 0010:hfs_write_inode+0x8b1/0x8c0
Code: ff e9 c5 fd ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 61 fe ff ff 4c 89 f7 e8 4a 02 85 ff e9 54 fe ff ff e8 d0 d2 18 ff 90 <0f> 0b 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 0f 1f 44
RSP: 0018:ffffc900107e72c0 EFLAGS: 00010293
RAX: ffffffff82a97f00 RBX: ffff88805491a520 RCX: ffff88801ccc2700
RDX: 0000000000000000 RSI: ffffffff8eb6dc00 RDI: 0000000000000000
RBP: ffffc900107e7450 R08: ffff88801ccc2700 R09: 0000000000000003
R10: 0000000000000004 R11: 0000000000000000 R12: 1ffff920020fce5c
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff88805491a4e0
FS:  0000000000000000(0000) GS:ffff8880d98df000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f80878c4e78 CR3: 00000000476ce000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 __writeback_single_inode+0x56f/0x870
 writeback_sb_inodes+0x73b/0x1110
 wb_writeback+0x3fa/0x690
 wb_workfn+0x3db/0xef0
 process_scheduled_works+0x811/0xf10
 worker_thread+0x9c1/0xeb0
 kthread+0x3c1/0x4d0
 ret_from_fork+0x608/0xc40
 ret_from_fork_asm+0x11/0x20
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:hfs_write_inode+0x8b1/0x8c0
Code: ff e9 c5 fd ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 61 fe ff ff 4c 89 f7 e8 4a 02 85 ff e9 54 fe ff ff e8 d0 d2 18 ff 90 <0f> 0b 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 0f 1f 44
RSP: 0018:ffffc900107e72c0 EFLAGS: 00010293
RAX: ffffffff82a97f00 RBX: ffff88805491a520 RCX: ffff88801ccc2700
RDX: 0000000000000000 RSI: ffffffff8eb6dc00 RDI: 0000000000000000
RBP: ffffc900107e7450 R08: ffff88801ccc2700 R09: 0000000000000003
R10: 0000000000000004 R11: 0000000000000000 R12: 1ffff920020fce5c
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff88805491a4e0
FS:  0000000000000000(0000) GS:ffff8880d99df000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdb2c2dff0 CR3: 000000003181d000 CR4: 00000000000006f0

<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>
