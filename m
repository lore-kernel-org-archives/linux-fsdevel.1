Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793437187;
	b=B+p3AJzIPJPz/a5YTcJM1MF//TCLBpCA1X4yrHdyBove9SGz5LCULd3jSELe9YYibVrF
	 SgycoGKezCEDLcivEAamAAAouoMAN7LvCeAj+nqFwMU6rkIjUg2mkGguZNpGch6cvL7uX
	 onLa5xVr/avuI/YuS5euDf72eGLgW1swscy2baVg8FjZNHI/cW4bQ/aAUpM6RmFZFAWtz
	 zW0XWWxLSk7oI3vmTu8AL5J56CVugtWiP1ulaYClRIzMX7KD8puDUlhuDI6bhtMYDJXzq
	 58Wll9Pg44W954ZQw9iZgfkZVY2quaJlTl+4KQ3fRCGI8i6NUTBFisfMq/exi9RPbuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793437187;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=ZSLE5/DCeed2E3fh+d6OIsBXtvzSdC0fzCtMY5JqQv0=;
	b=OkilKKmOpcV7BnrMukWLeOrrRDU+s5HVDLV9SjuWXPTKR7AnvAnZyeWYJBqu3cR/En1P
	 9N+Hb0DawYxCTKoDfstrxh8n3VlIrdI6M3j8ji9VNSQ+W2a3p9dKxZFt/fS3+vrS6rrTn
	 Kzcj7aFdA3cVcFeWOg5n2SBd7E9OKOx5eqJe6Fg9Ia0finm3e5JJNkr1YJ7odQr53Ku2r
	 YGVKSFz9jTqipnSDQksKX6OBuQylyvqKh6SU5qdqnzx+cJCO3P0Pyk7udq5f7sHIgpiDt
	 +yzKXYRlux/75DjJQX4lN86hIRJTnI97IvDQazUI7bQtCKIGXwxmTJjl2C7tIDOuAfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.160.72
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8368A606A31D
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 08:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8368A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-46a5954cdfcso1544095fac.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 01:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793437185; x=1794041985;
        h=content-type:cc:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZSLE5/DCeed2E3fh+d6OIsBXtvzSdC0fzCtMY5JqQv0=;
        b=L7ti7qIEApXSNVKx97NEX12MUgMzh3uOYzbuOSWKeWcKOBi0nuh4zIjT2/OZll1/Tb
         aoXUvy0hHt/4yZ3aVv3kZFmVp0I0Bf3JoaDg2Nrce9nGYqPPEWkz6K1i8wxmu2XwjIN2
         PZhpJK+EWHsXLGBVIdK7N6H0pbwdAbp6FGXE3PetGgOdZjikPx3nNbS2EDJ86VYpEn4i
         SoqGDZppphkA3WmH7iBuOcsUklK7wCXI/6bD3ZmWBnncaB49jFq8nD9FVKB86iOn00Nu
         V80CMtPd86l5Wl6sewANNvTZ/yypzQ8Wco+LlBt8l/lXIe3gUcTDCnS29c6+oq1yrW+5
         yNlw==
X-Forwarded-Encrypted: i=1; AKwUvBzLzvoTXdnsfbcjIqrspEcAxalJC5rcKq2LN1z9d1Qy7tWC1oaWHfYQP7D4fE1L5buHPFnanaDadY6Vag5f@vger.kernel.org
X-Gm-Message-State: AFq9FYLB5Fth/M+k839A/8GQBZ08ipFQDVJl0aV7im9ER8ujTjUkW74x
	nwuElMU/71GdJP/zPNw2vzWuy2LG9WM2i8zqancBug/CEL+ATgpNwN4os3sns74IKNK9RSdq2ZM
	AA44YmTVDqZV7lOqtXT5+BIeKkXQO/Hoo5I854HC+NivuTjNgG5OjO4zQHNA=
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1b2c:b0:536:611a:7fd9 with SMTP id
 5614622812f47-5640d927810mr3068275b6e.7.1793437185453; Sat, 31 Oct 2026
 01:59:45 -0700 (PDT)
Date: Sat, 31 Oct 2026 01:59:45 -0700
In-Reply-To: <20261030042903.4160506-1-hengyul@cs.unc.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ae5ae01.78e51036.124520.0002.GAE@google.com>
Subject: [syzbot ci] Re: hfs: fall back to buffered I/O for direct writes past phys_size
From: syzbot ci <syzbot+cid81af4ef4a45835b@syzkaller.appspotmail.com>
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, hengyul@cs.unc.edu, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	slava@dubeyko.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] hfs: fall back to buffered I/O for direct writes past phys_size
https://lore.kernel.org/all/20261030042903.4160506-1-hengyul@cs.unc.edu
* [PATCH 1/2] hfs: fall back to buffered I/O for direct writes past phys_size
* [PATCH 2/2] hfs: remove the dead grow path from hfs_file_truncate()

and found the following issue:
WARNING in hfs_file_truncate

Full report is available here:
https://ci.syzbot.org/series/f8323fc4-a62a-40ea-9106-bff8391323a3

***

WARNING in hfs_file_truncate

tree:      axboe
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/axboe/linux.git
base:      a804c5742bff224d4cb4d25dd383554d598be32b
arch:      amd64
compiler:  Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
config:    https://ci.syzbot.org/builds/734131df-1170-4dc7-a0ec-85ffb659aeec/config
syz repro: https://ci.syzbot.org/findings/95638e3e-6c06-4f46-a68b-e468dc287d1e/syz_repro

------------[ cut here ]------------
inode->i_size > HFS_I(inode)->phys_size
WARNING: fs/hfs/extent.c:494 at hfs_file_truncate+0x7cf/0xa50 fs/hfs/extent.c:494, CPU#1: syz.2.19/5839
Modules linked in:
CPU: 1 UID: 0 PID: 5839 Comm: syz.2.19 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:hfs_file_truncate+0x7cf/0xa50 fs/hfs/extent.c:494
Code: 8b 05 ed eb db 11 48 3b 84 24 20 01 00 00 75 1f 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d e9 88 09 33 09 cc e8 02 10 0b ff 90 <0f> 0b 90 eb 9b e8 67 00 30 09 44 89 e9 80 e1 07 80 c1 03 38 c1 0f
RSP: 0018:ffffc900034afaa0 EFLAGS: 00010293
RAX: ffffffff82bca45e RBX: 1ffff92000695f68 RCX: ffff88810ca50000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000852
RBP: ffffc900034afc08 R08: ffffc900034afb97 R09: 0000000000000000
R10: ffffc900034afb60 R11: fffff52000695f73 R12: 0000000000000000
R13: ffff88816b59b100 R14: dffffc0000000000 R15: 0000000000000852
FS:  00007f4cc5ac36c0(0000) GS:ffff8882a7c97000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000560c8ef2a008 CR3: 00000001bd922000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 hfs_inode_setattr+0x4d0/0x730 fs/hfs/inode.c:698
 notify_change+0xbba/0xea0 fs/attr.c:556
 do_truncate+0x1c2/0x250 fs/open.c:68
 do_ftruncate+0x4d4/0x580 fs/open.c:194
 ksys_ftruncate fs/open.c:206 [inline]
 __do_sys_ftruncate fs/open.c:211 [inline]
 __se_sys_ftruncate fs/open.c:209 [inline]
 __x64_sys_ftruncate+0x8f/0xe0 fs/open.c:209
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4cc4b9f559
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4cc5ac3028 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
RAX: ffffffffffffffda RBX: 00007f4cc4e25fa0 RCX: 00007f4cc4b9f559
RDX: 0000000000000000 RSI: 0000000000000852 RDI: 0000000000000004
RBP: 00007f4cc4c36b20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f4cc4e26038 R14: 00007f4cc4e25fa0 R15: 00007ffcf07cc2c8
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a fix for this bug, please reply with `#syz test`
(on a separate line) and attach the patch to the email.

Notes:
- The patch will be applied on top of the tested series (as an
  incremental fix).
- To test a new version of the whole series, please send it directly
  to syzbot@lists.linux.dev.
- Arguments like custom git repos and branches are not supported.
