Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B3035AC12
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 12:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779796889; cv=pass; b=OeU4adodesyTRSxtxsMKblm7lk/oIWGVk1dGYlKHd3sd/HL3WwURPIn5Sv/2JOFIlm7pNs80UQfBdVPxicW3A4peajJZ39Uq8Alcfb0qTdJ95KsdNSOuHhIwwSBffu1CkpLCfYdFrSbrHAyaZSJldPpQK7JxS6U96R6Ld/Xbcjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779796889; c=relaxed/simple;
	bh=N5c7ArmXYDKWgyVh4b5GR2THkmWh7+mGuMGrh/XYuyk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bmN//BL3NXklJZjA1fRJOW9+xwL1ZLbkPvevsxLdLzmUnqWTwmSMmP1PUHsrjr6GzfO108oAiuBBsW++R9HL8SvEyTbpIYACHV1Gh5IXCnyKpU4Nvz6Ln+qoRC7A4QnsiEhtRLK1P+RHGZYBM/5G8d9rCC8uajXaRHCsRrMoHAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvvCN2kl; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvvCN2kl"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-65c396d3b36so10173930d50.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 05:01:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779796883; cv=none;
        d=google.com; s=arc-20240605;
        b=fzVxH21E1Z2cZnnfwinRsWSCmG/LC6IaanE00xwU60sSmv6GSvShSEwS/K9HPr4Eng
         km+56qhMvmNXtJnTfZzhUlRq68c/8sBtFzznBfY2GnUcTQ9aOiz+zND9bAzYMwaN4EGa
         Ice+30mkxnW7h8KcPq1IVDs5Ldme1ND3bKJGhxSSC9zpD93e+StCy4C344Jz967E5yce
         w3N8rAlFEZAdwp2r3YhowWcbTFm2ttdOvJlnzlC810tIPTepuU0OU3/izbUoazEqBzKD
         PHY5tWRKyw+GXory/M/VD/3HiYFaABOStTHcYl3YvynqaqyKB2sDGbkNXOCyBZiMNwR2
         IY5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=w/qF9Y2yN8vAfbh3RrIPFK5LawrzDHFyp5ALmuYhln4=;
        fh=AT/5zm/v4PFC6eAMzveP4TNK/C3Uyc6HQUVQ2yYtOvM=;
        b=jEqhSa9RkKeVm859c2PfpR0PpKHn41XreVXc3+ASbDMrFW3FPYMP2C9tvvvPrnonh2
         0CTDMbrqi879MqXRBIS26IasUmncpY5xu6kcJ9dy47CbjC5wDrZZs5IS+/cVwt+VnJo4
         wywb6tpM/lxSH5Rr+WAXicAmDH2pX0xVA8E4fGVzDkE/gn7xnti9YhrXbkzYrMvRJ9Ir
         Kwg68642roLbfW9nd4yldkMkBSVwmOnUYCo3rBV78pcEweDTvIupme+WcTiA0aKySbDH
         bwwxp/w62Zxm+JZCjo1ZBb9AnfOKvr9wOHhBnRSoe0t41hkdfKpcB+Ae4GMZkdNnmSqp
         hOaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779796883; x=1780401683; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w/qF9Y2yN8vAfbh3RrIPFK5LawrzDHFyp5ALmuYhln4=;
        b=KvvCN2klEEv2ltb2sFNYg84BCRVCHRYMoVXqaLKqYNRqewzcFPZ4IEfYD4CTrTjUbJ
         wFuq49VfbYbbs53xKFsv3j7EBMNlmP33LnwBgc0J/W2ErtCHCq/PV7asVtckmD7VNwo4
         kXKPc0TxKj4AT5TiR3JZcL9lWVZzzrAYFDKhEq1e8r62xMXafrwqTjRSI8J7wpE4iult
         zmW9D/rzZX1r1GkGvfhN3mufhYlwZI/lDJIuuHpDHbhJEHspt+xi0zHJvmD4AnEsKxh4
         0Z3MTuO93jPT9wL/SCxaAwesRbeFJ/f7SDCPq3VOWmb7bZK9DF92meY4dXQ4bsg5jyt+
         bsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779796883; x=1780401683;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w/qF9Y2yN8vAfbh3RrIPFK5LawrzDHFyp5ALmuYhln4=;
        b=hAkvk4AFPjY6EKZAFJyIV2Ub5z75IoDT3TgL4/yRGeQyZswMN0a8D8O2+Byv6Uv1Y0
         FU1+4KjD2fhU8y4VMdves3HJNOWRX+/YFq/i0HyV6XyNA6ytbleEE9Gy3XtwSYiMWNTs
         GoiU2ddCUDJfs6HDPEpRYxvZixw+Jn3uH4LO1y54G8KKbO/ct2nor+fbLRCfXN2jPxVD
         owQNNN5AX2gj49bd/UE1BCoheCQBkHjafhuqZlwEDyZl9FkCxlGA3qcXAWKejR5AxLgq
         UQ9mENvLfLRQAe4vHdWIMa+1MnNphJJLyJdjIhFW0SvNIrPGE9LFYRXRuNmtCgu84gxd
         pRYw==
X-Gm-Message-State: AOJu0YwBsNG2aI+IooK5gWDtxh0ZiHUnBnGkNFnZ5nJkyJpFpn/k8UM2
	gklNn4TZNcocMQHlYwoMYOzNlIuqe9gJJKMwznJ2qrQQGBZYtcj2HtEsMKLqgMr6+QsWgyr/gTy
	3Oug9GUoYJDTMZve1tsEd7JJccOsf6YC30+hm
X-Gm-Gg: Acq92OFGisYaz+MnT04qVcnk5PtJu9lAg4uSUN4jh0YNYZScIDMb0QcnzVqsmjXiIfC
	knWtyAl0qiCEahwNPiE//rjNZJUhbd/uUvLwm+LnvVnA20neTirVlEZi2a0IL4R0ZrBgqrECTy8
	odExqj+QuygdjQi/C0lX82O926h2gez87sWK1d9kTTDjXcnIDhMnVHEKnMsw8pMniWOJH6C64xt
	6+hAY3bXhCJIdk5+n8P4Hz6q46cHD65GFYDgRarvaE1SYlVQ3/wPEtv66/YZxrCmU48AK3n+mk0
	spry0oRSyEpb5Fa/50gW6i2tsCP3wfmLkKDTmddHmAyrOUpTsj6q
X-Received: by 2002:a05:690e:440b:b0:654:a000:94c0 with SMTP id
 956f58d0204a3-65ec9639cc6mr13512457d50.5.1779796882512; Tue, 26 May 2026
 05:01:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Tue, 26 May 2026 13:01:11 +0100
X-Gm-Features: AVHnY4IecFYuqDLGqiirwU4wwgprvlSe6_3qGLkAaXavpqxYHrR0vACTJJsPcAQ
Message-ID: <CAMw=ZnSaVSzn1RGtiNRG+iNj8M1e12rZtA98i4jL8jYP5UyzWg@mail.gmail.com>
Subject: Occasional 'WARNING: mm/backing-dev.c:636 at cgwb_release_workfn'
 when running mdadm
To: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc: Mike Rapoport <rppt@kernel.org>, Christian Brauner <christian@brauner.io>, regressions@lists.linux.dev, 
	Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

Hi, I've been told to report this here.

In our CI test that runs some mdadm commands we occasionally (maybe 1
in 100 runs, not reproducible manually) see the following kernel warn:

[ 15.769393] TEST-64-UDEV-STORAGE.sh[245]: + mdadm -v --stop /dev/md/mdparity
[ 15.786033] ------------[ cut here ]------------
[ 15.788632] !list_empty(&wb->b_attached)
[ 15.788634] WARNING: mm/backing-dev.c:636 at
cgwb_release_workfn+0x142/0x1f0, CPU#0: kworker/0:1/11
[ 15.789235] Modules linked in: raid456 async_raid6_recov async_memcpy
async_pq async_xor async_tx raid1 intel_rapl_msr intel_rapl_common
kvm_amd ccp kvm joydev iTCO_wdt irqbypass mousedev intel_pmc_bxt
ghash_clmulni_intel vfat i2c_i801 fat aesni_intel psmouse i2c_smbus
intel_agp lpc_ich pcspkr i2c_mux virtio_balloon intel_gtt serio_raw
mac_hid tun md_mod dm_mod qemu_fw_cfg vsock_loopback
vmw_vsock_virtio_transport vmw_vsock_virtio_transport_common vsock
virtio_rng
[ 15.790846] CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1 Not tainted
7.0.10-arch1-1 #1 PREEMPT(full)
b38726df0ec1c5aec6f05d4eab858505a5944d02
[ 15.791457] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
Arch Linux 1.17.0-2-2 04/01/2014
[ 15.791842] Workqueue: cgwb_release cgwb_release_workfn
[ 15.792166] RIP: 0010:cgwb_release_workfn+0x142/0x1f0
[ 15.792411] Code: f6 43 d8 01 75 2c 48 83 c4 08 48 89 df 48 c7 c6 00
b2 a8 ba 5b 5d e9 0d 5d dc ff e8 f8 fd ff ff 48 8d 43 b8 48 39 43 b8
74 d6 <0f> 0b f6 43 d8 01 74 d4 0f 0b eb d0 48 89 04 24 e8 69 e6 db ff
48
[ 15.793129] RSP: 0018:ffffccd280063e50 EFLAGS: 00010293
[ 15.793401] RAX: ffff89eecbae4eb8 RBX: ffff89eecbae4f00 RCX: 0000000000000008
[ 15.795755] RDX: ffff89eecbae4d80 RSI: 0000000000000202 RDI: ffff89eecae8a040
[ 15.796172] RBP: ffff89eecae8a000 R08: 0000000000000001 R09: ffffccd28018e010
[ 15.796560] R10: 0000000000000001 R11: fefefefefefefeff R12: ffff89ef3bc322c0
[ 15.796889] R13: ffff89eec083c405 R14: 0000000000000000 R15: ffff89eecbae4f00
[ 15.797298] FS: 0000000000000000(0000) GS:ffff89ef7e367000(0000)
knlGS:0000000000000000
[ 15.797637] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 15.797961] CR2: 000055cd8ab1d960 CR3: 0000000109878004 CR4: 0000000000370ef0
[ 15.798319] Call Trace:
[ 15.798454] <TASK>
[ 15.798572] process_one_work+0x19c/0x3a0
[ 15.798732] worker_thread+0x1b1/0x310
[ 15.798896] ? __pfx_worker_thread+0x10/0x10
[ 15.799164] kthread+0xe1/0x120
[ 15.799330] ? __pfx_kthread+0x10/0x10
[ 15.799536] ret_from_fork+0x2bc/0x350
[ 15.799713] ? __pfx_kthread+0x10/0x10
[ 15.800486] ret_from_fork_asm+0x1a/0x30
[ 15.800666] </TASK>
[ 15.800795] Kernel panic - not syncing: kernel: panic_on_warn set ...
[ 15.801089] CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1 Not tainted
7.0.10-arch1-1 #1 PREEMPT(full)
b38726df0ec1c5aec6f05d4eab858505a5944d02
[ 15.801553] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
Arch Linux 1.17.0-2-2 04/01/2014
[ 15.801863] Workqueue: cgwb_release cgwb_release_workfn
[ 15.802060] Call Trace:
[ 15.802161] <TASK>
[ 15.802264] dump_stack_lvl+0x5d/0x80
[ 15.802440] vpanic+0x20a/0x410
[ 15.802568] ? cgwb_release_workfn+0x142/0x1f0
[ 15.802761] panic+0x6b/0x70
[ 15.802905] check_panic_on_warn.cold+0xf/0x1e
[ 15.803082] __warn.cold+0xa7/0x10c
[ 15.803204] ? cgwb_release_workfn+0x142/0x1f0
[ 15.803361] __report_bug+0x93/0x110
[ 15.803492] ? cgwb_release_workfn+0x142/0x1f0
[ 15.803681] ? cgwb_release_workfn+0x142/0x1f0
[ 15.804541] report_bug+0x29/0x70
[ 15.804701] handle_bug+0x167/0x360
[ 15.804862] ? cgwb_release_workfn+0x142/0x1f0
[ 15.805096] exc_invalid_op+0x1d/0x90
[ 15.805255] asm_exc_invalid_op+0x1a/0x20
[ 15.805449] RIP: 0010:cgwb_release_workfn+0x142/0x1f0
[ 15.806398] Code: f6 43 d8 01 75 2c 48 83 c4 08 48 89 df 48 c7 c6 00
b2 a8 ba 5b 5d e9 0d 5d dc ff e8 f8 fd ff ff 48 8d 43 b8 48 39 43 b8
74 d6 <0f> 0b f6 43 d8 01 74 d4 0f 0b eb d0 48 89 04 24 e8 69 e6 db ff
48
[ 15.807217] RSP: 0018:ffffccd280063e50 EFLAGS: 00010293
[ 15.808511] RAX: ffff89eecbae4eb8 RBX: ffff89eecbae4f00 RCX: 0000000000000008
[ 15.808785] RDX: ffff89eecbae4d80 RSI: 0000000000000202 RDI: ffff89eecae8a040
[ 15.809056] RBP: ffff89eecae8a000 R08: 0000000000000001 R09: ffffccd28018e010
[ 15.809397] R10: 0000000000000001 R11: fefefefefefefeff R12: ffff89ef3bc322c0
[ 15.809687] R13: ffff89eec083c405 R14: 0000000000000000 R15: ffff89eecbae4f00
[ 15.809978] process_one_work+0x19c/0x3a0
[ 15.810154] worker_thread+0x1b1/0x310
[ 15.810325] ? __pfx_worker_thread+0x10/0x10
[ 15.812450] kthread+0xe1/0x120
[ 15.812594] ? __pfx_kthread+0x10/0x10
[ 15.812738] ret_from_fork+0x2bc/0x350
[ 15.812878] ? __pfx_kthread+0x10/0x10
[ 15.813026] ret_from_fork_asm+0x1a/0x30
[ 15.813179] </TASK>
[ 15.813607] Kernel Offset: 0x39400000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)

I don't have hard data for when it started, but I don't think I've
seen it for more than a couple of months tops. This one was on 7.0.10
on Arch, but I think I've seen it on Rawhide too.

The test script that triggers it:
https://github.com/systemd/systemd/blob/d096763827718083918244eb3b7796bf27876d56/test/units/TEST-64-UDEV-STORAGE.sh#L1191

Is this a known issue? Thanks

-- 
Kind regards,
Luca Boccassi
