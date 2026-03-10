Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D7B38DF9
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 06:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773124148; cv=none; b=taWOnh/SjmjY/ulUGzKJIKKyOAMZoMkyJKDaML82GaRQvlERJgxl6a2ARsvZqyYIJl8fWgcX9hTENNd6WfHWqM4mflKXhZp7y8dehdEij61fp21SxLQD8UszKP5c72T/tGfdxWaU7afEaM0f+fTBg5d0Ig52UfMKmwpTjJLGlsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773124148; c=relaxed/simple;
	bh=xJmLtUHjcYA82Pi+Pz8Vaeh6rRUPZJe420L1X3Mo+g0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hAGFZ1niGdbm5oRy9txs41x58PGWOR+uUSKG2fBr1gbpmjiKdc/pPux9F9D5XisQCuusaSO8shm9BA89RIptdSshEcMaaGVOeBDQAWN/HqzkuCdlRI5wE6S3tzOlOFtaT17VCd3iE9gv/EXRWrISRPJYu+oXJe3i64PzfIvW21w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-67bb6081a0dso23226429eaf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2026 23:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773124146; x=1773728946;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rh1FFgXJWrBr2+Z9D9TX5buPNtwittF7cccRXqbBfsk=;
        b=rackEEoq27bTYDVrcPLCa2YPbnR/nPnR+OVC9j/muXw/pR2NOdWzuumFh2SliD1JFX
         eHmitG0fE6W4/GAzAnqpBUQ0T9iJ9iBiAt/gHaWXLMK6vRnjDTwM2KSjkeTqBH6qVkbi
         jB/G8vLOcKvEk4GuEJDMOJLpIGYecQZA/6ZD2KU15I78wCLUp9ikq3hzAbCtNxuyXfe6
         XtVsAycvAiArPV4HOsHaigpS/3P27u2EEdi4kh3p+g93Q+kNkmgILEK+eKHuV5pFA76h
         DXQei6bl9/fFrK5KBFxbQjA1DBoL9Ve2rnJtf2xb5MAp9D3XCXuO+i8IqOb5ew944Iar
         NJUA==
X-Forwarded-Encrypted: i=1; AJvYcCUWffU5SX46fC7lhT9bRFAT7Vu6+vSd72f30gU0bU/gO3lqKFb6m/9e5CSu5CVXBJC9Z2bLbVar0WzsH2A9@vger.kernel.org
X-Gm-Message-State: AOJu0YxJyvEBrYUAZlo6dXAsELWk1Mzuap8XpODfhu+5MsB4T/UbvOFH
	1iLmjqfF8SjEh+mMSrXkGb8BRblZosj0lrYLiHGGZqFWzOmx0pqe0ddGEAychyBoid/Pi1hVefo
	lPuBqYPYCpLmFT/DDyv1LG3hVjLWPG7K502OYxn/3hEUMSu3x2vxwb6dzOas=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1ca1:b0:67b:b89e:22af with SMTP id
 006d021491bc7-67bb89e23dbmr2349238eaf.51.1773124146144; Mon, 09 Mar 2026
 23:29:06 -0700 (PDT)
Date: Mon, 09 Mar 2026 23:29:06 -0700
In-Reply-To: <aa-1-Y3v3D1hzPvL@hyeyoo>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69afba32.a00a0220.d013.0002.GAE@google.com>
Subject: Re: [syzbot] [mm?] [f2fs?] [exfat?] memory leak in __kfree_rcu_sheaf
From: syzbot <syzbot+cae7809e9dc1459e4e63@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, catalin.marinas@arm.com, chao@kernel.org, 
	hao.li@linux.dev, harry.yoo@oracle.com, jaegeuk@kernel.org, jannh@google.com, 
	liam.howlett@oracle.com, linkinjeon@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	pfalcato@suse.de, sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, 
	vbabka@kernel.org, vbabka@suse.cz, wangqing7171@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
memory leak in copy_process

BUG: memory leak
unreferenced object 0xffff888101799d80 (size 184):
  comm "kthreadd", pid 2, jiffies 4294948049
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    0a 21 00 00 00 00 00 00 58 78 fd 01 81 88 ff ff  .!......Xx......
  backtrace (crc e9f8bd9):
    kmemleak_alloc_recursive include/linux/kmemleak.h:45 [inline]
    slab_post_alloc_hook mm/slub.c:4552 [inline]
    slab_alloc_node mm/slub.c:4874 [inline]
    kmem_cache_alloc_noprof+0x372/0x480 mm/slub.c:4881
    alloc_pid+0xe4/0x850 kernel/pid.c:189
    copy_process+0x1a97/0x28c0 kernel/fork.c:2239
    kernel_clone+0xac/0x6e0 kernel/fork.c:2654
    kernel_thread+0x80/0xb0 kernel/fork.c:2715
    create_kthread kernel/kthread.c:459 [inline]
    kthreadd+0x186/0x250 kernel/kthread.c:817
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff88810b0d7b40 (size 184):
  comm "kthreadd", pid 2, jiffies 4294948049
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc ddb1bc35):
    kmemleak_alloc_recursive include/linux/kmemleak.h:45 [inline]
    slab_post_alloc_hook mm/slub.c:4552 [inline]
    slab_alloc_node mm/slub.c:4874 [inline]
    kmem_cache_alloc_noprof+0x372/0x480 mm/slub.c:4881
    prepare_creds+0x22/0x600 kernel/cred.c:185
    copy_creds+0x44/0x290 kernel/cred.c:286
    copy_process+0x7a7/0x28c0 kernel/fork.c:2084
    kernel_clone+0xac/0x6e0 kernel/fork.c:2654
    kernel_thread+0x80/0xb0 kernel/fork.c:2715
    create_kthread kernel/kthread.c:459 [inline]
    kthreadd+0x186/0x250 kernel/kthread.c:817
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff88810b91e4a0 (size 32):
  comm "kthreadd", pid 2, jiffies 4294948049
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    f8 6e 0a 00 81 88 ff ff 00 00 00 00 00 00 00 00  .n..............
  backtrace (crc 13ba6aa5):
    kmemleak_alloc_recursive include/linux/kmemleak.h:45 [inline]
    slab_post_alloc_hook mm/slub.c:4552 [inline]
    slab_alloc_node mm/slub.c:4874 [inline]
    __do_kmalloc_node mm/slub.c:5267 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5280
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    lsm_blob_alloc+0x4d/0x80 security/security.c:192
    lsm_cred_alloc security/security.c:209 [inline]
    security_prepare_creds+0x2d/0x290 security/security.c:2763
    prepare_creds+0x395/0x600 kernel/cred.c:215
    copy_creds+0x44/0x290 kernel/cred.c:286
    copy_process+0x7a7/0x28c0 kernel/fork.c:2084
    kernel_clone+0xac/0x6e0 kernel/fork.c:2654
    kernel_thread+0x80/0xb0 kernel/fork.c:2715
    create_kthread kernel/kthread.c:459 [inline]
    kthreadd+0x186/0x250 kernel/kthread.c:817
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


Tested on:

commit:         1f318b96 Linux 7.0-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1224694a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c6ad6fefffa76b1
dashboard link: https://syzkaller.appspot.com/bug?extid=cae7809e9dc1459e4e63
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=110faf5a580000

