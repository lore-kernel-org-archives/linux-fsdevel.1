Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641073D6474
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 06:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773122480; cv=pass; b=gIf2K0xbcrxAfBMXhUwFKuVnlwegArgY5hf8l2d1uICVVBwhGqZiZZWR1dAMVkxmRloNk8hu27ggIPYkT2A7SD6gxo7ogVL03tJcWHiyQkQvhQatQ1T05YIHKN9UGYbWcmtRt0PvdIHdNxD6AwRXEBwKiqSfVJFQthh95zQ2CUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773122480; c=relaxed/simple;
	bh=GCx/mQP2X+17EHtht+LIroWXhen1E0/wXQB2l6Amh6g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=p3KrLatnfopRG9dBNwo3mIlOs1SWT9VJjb0mw9BIG7acYUMtyjM/61q7eMkhz1TbCoi4khJUkvNpdBoymNID+LzB1PNN0hXPv+jUg76J3R5qA7a0DY0FQ1vHmRRHFP/5q8IsyjJp3B1l4/dTMLfa7wTeeQlrI/itQW5un9L31q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFC/Glq7; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFC/Glq7"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so4293216a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2026 23:01:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773122474; cv=none;
        d=google.com; s=arc-20240605;
        b=iPjwk+1Z0jNJ6Jkz6YdcHT4VuYwE01ElEnmRpwZ4oWYE45eXkxdj8JcxBJaX5oSk8X
         OqHmjSDDWCkpiygZxG/CVMluL00Ctz4DuRwC2tXQgEetR+zC1gTh6KcA/L47hSDTpPSP
         vPacVRrtnHDj0+VmAhZUThQYI+kWozRQyFs8LNRBh5D8JAZA1kxXv2hPm+0M6gijqopy
         wZpQKpePXTVwakje2jVD+gWsk2uWnKrCPjwdQYLbozBTFnlfc/ZQLLBpB7J7dgHXz7pU
         9K/FbMLZCiZXXhlOxlD8k9rYYS4mnIoB5L5pSP2zHeTv304qTN+LRwmzYCrNwERwUATz
         W+Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=VhIUGBCyjJfiXk4yyFm8TRhyK85/OVCt5yhCECaikfc=;
        fh=X0Yomd/8Lry7raFQ1oOdTobqO7ArenNkpGJ+KyAWHg4=;
        b=IgcOishS/FeNeTIM0jadmtNvZ17umrthOzOdq2ptU+axetkZDr37CsTj3Sx0eOJpBy
         RHi8Ns+97CtVarL5TrqPec5kOvO0ETtKi7T90Ij1vBx7wgTmIa++PInyztDKwSuVHtcF
         BGQxlRdMzU47ddfOMN0/4nKECSX9iMcIk1NKHwBJqBqGj0OPHRQRyoV7JgQ7S13dd2gi
         oaIrmB/Y2ozyQeXXcnYPFIVVehQK7RL0LjeDfzZKoZCCzh9YDqorY0s6g6eO5fbEWWqQ
         sbNVaplFDNBB/bc2yM9OfUdnPzMfHSNvbTU/DZBAuRVryVxY2WucnUIPVaXzvBzu3AKB
         /BBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773122474; x=1773727274; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VhIUGBCyjJfiXk4yyFm8TRhyK85/OVCt5yhCECaikfc=;
        b=GFC/Glq7aRigxUws4S1GCfbsKJ/k1qj7Eru+84OvEu45It4gQOBCJlxMQbw69F+GIf
         ZDDAifUlkFVfsYOPDAPwq3ZUuMLTzHQ/MEATfIyVzw68FbBzjRUaOVO/puM5DL0/cCwW
         k87wYH3Mn1QTEol9tz9Hx8khO14BCc43Ia0fMCMGniD8xHmLDV9YM4y0cjx+CFu/dGMQ
         XN91shIm0RJ8LxvGsHuDgypBFprycopgaLDM/1OmaOcb9duUSN0elnB16l5AGQiu5Oke
         BYsVqa/LjjeQtp2/7ZpqFMHaI3l3zQBE4hH+rfs+6AIPLa+eJfVZIArZL2s5uTCF02Hk
         uiLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773122474; x=1773727274;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VhIUGBCyjJfiXk4yyFm8TRhyK85/OVCt5yhCECaikfc=;
        b=taNwI1rvnnVPRemsV1uC8/SCUJpqlwWb6uNgv1NNHALtSt1LAsXiCfaJStekFQj67+
         NUBfDJlmyrFTS19e17eCnyIqlsSDBdxpNYVF2eK2rBWA3+PJYpfo5XsSh5x0GAHJrXoB
         qwB5coVchGCGrsbB280NBccgU5ZcHFgsA/qor3ehgmENml2Fc+9kutOQNb9LIrhuF0p9
         i/RNF/yy5U8jUeJHicNpkPqmH+m8Sj8fbhbyFeln2DUHgT9P5R99y3Rs8+wIb3XezWlN
         SXPFkxCnO2eSOBNDv+O5EpYUfnirEhg0zpSVeT0ZbORZcmkZUzPRe/vgw3ndN/Dxhf5v
         HrSA==
X-Gm-Message-State: AOJu0YzCH2RP3kqp9OSGfjZDYv4P2pbKiYQW6pNA8fH4HHl67FZzZaNC
	SMfzX4Sz1XkcLMWojm6zjXU3Pj7hs6rocN+oMN6Sx0Rk4ypwgfA1h/Ou2ypKYENJ3zdRE30kRzU
	0bQoXJSJY/UzxhKvMF+UWlrOtLJarUGhlW1prhNL0/Q==
X-Gm-Gg: ATEYQzyN7PBr05YjLTRRAQR0SXm5CwDzyxUnWNwZu6/qh4yJtlrURuMzfG/EuP2ZRgc
	hR7h0BaQp1FsDPhmHanh7/CmuFrooIvybHbMwRI1rVknZUg5NaDDTTLJDqIIOiNlPdiytDLHcVS
	wkiYIHEGf+lITY/l1Sckmnu/RfoB6dk5VfoH6A88ntYKDB9wQPl2X71maN2FMl+rroqShc+EjeL
	AGGGb0cL4tnZ0NrY+LuZFug7D6qCK9sUPuZDyY0qBED4OSozFJmqv5m9ZXYsjtMsUniVTyWzxFe
	lCw/8zA=
X-Received: by 2002:a05:6a20:a125:b0:398:82bb:87bf with SMTP id
 adf61e73a8af0-39882bbacc8mr7765908637.19.1773122474266; Mon, 09 Mar 2026
 23:01:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hyungjung Joo <jhj140711@gmail.com>
Date: Tue, 10 Mar 2026 15:01:01 +0900
X-Gm-Features: AaiRm52rina2D6_FLM3Zfmq52_KCBNtZvtcADPJkijpE-CEAOzXJg1FjwU9jTtw
Message-ID: <CAP_j_b86D9BPz9Fn3R0B71FG=Ad=oQZ5BwXCecYds1grdAqfEw@mail.gmail.com>
Subject: [BUG] bfs: mount-time null-ptr-deref in range [0x28-0x2f] in bfs_move_block()
To: linux-fsdevel@vger.kernel.org, aivazian.tigran@gmail.com
Cc: linux-kernel@vger.kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	jack@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

I am reporting a filesystem bug reproduced on the current mainline
with KASAN enabled.

Target file: fs/bfs/file.c
Subsystem: fs/bfs
Git head: 5ee8dbf54602dc340d6235b1d6aa17c0f283f48c
Kernel release: 7.0.0-rc2+

Root cause:
`bfs_get_block()` relocates a non-last file to `where =
info->si_lf_eblk + 1` and only bounds-checks the intended new extent
with `where + block < info->si_blocks`. `bfs_move_blocks()` then
copies each source disk block `i` to `where + i` instead of `where +
(i - start)`, so it treats the absolute source block number as a
relative offset. For a one-block file whose `i_sblock` is greater than
1, appending one block after another file has advanced `si_lf_eblk`
near the end makes the real destination exceed the device.
`bfs_move_block()` blindly dereferences `sb_getblk(sb, to)` via
`memcpy(new->b_data, ...)`, producing a NULL dereference on a
filesystem-sized backing device.

Reproducer
C reproducer: https://pastebin.com/raw/awqH6UQb
KASAN full log: https://pastebin.com/raw/qsa54J7j
Kernel config: https://pastebin.com/raw/YrrmUMzr

Key config options:
- CONFIG_KASAN=y
- CONFIG_KASAN_GENERIC=y
- CONFIG_KASAN_MULTI_SHOT=y
- CONFIG_DEBUG_KERNEL=y
- CONFIG_FRAME_POINTER=y
- CONFIG_BFS_FS=y
- CONFIG_BLK_DEV_LOOP=y

Brief KASAN call trace:
[   63.935062][  T143] Oops: general protection fault, probably for
non-canonical address 0xdffffc0000000005: 0000 [#1] SMP
DEBUG_PAGEALLOC KASAN NOPTI
[   63.935560][  T143] KASAN: null-ptr-deref in range
[0x0000000000000028-0x000000000000002f]
[   63.936151][  T143] RIP: 0010:bfs_move_block+0x16e/0x280
[   63.937255][  T143] Call Trace:
[   63.937255][  T143]  bfs_get_block+0x205/0xd00
[   63.937255][  T143]  __block_write_begin_int+0x3bd/0xbc0
[   63.937255][  T143]  block_write_begin+0x85/0x240
[   63.937255][  T143]  bfs_write_begin+0x30/0x100
[   63.937255][  T143]  generic_perform_write+0x374/0x800
[   63.937255][  T143]  generic_file_write_iter+0xd7/0x340
[   63.937255][  T143]  vfs_write+0x9c9/0xfc0
[   63.937255][  T143]  __x64_sys_pwrite64+0x19f/0x200
[   63.937255][  T143]  do_syscall_64+0x141/0xf40
[   63.937255][  T143]  entry_SYSCALL_64_after_hwframe+0x77/0x7f

Reproducibility notes:
- observed crash: mount-time null-ptr-deref in range
[0x0000000000000028-0x000000000000002f] in bfs_move_block()
- rootfs mode: busybox
- guest /init runs the case-specific trigger binary automatically

If you need anything else, please let me know.
Thank you.

Best regards,
Hyungjung Joo, jhj140711@gmail.com
