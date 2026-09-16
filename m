Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E9149362C
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2026 21:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789595534; cv=none; b=sAqU2/NNBtdJTzyxve73lsh+TzuC6rOV8imdhvYRbTUIIws4Pp9dQh8U1JwKhz0WmZwcA5FkezSkFP2MWL9Kgs9+q0OrV1MZtttOevZSzCoFx6i+qBlOXwF/i/MIiEGcnAqTHgUqFOdCJMrfpDvnMHh5W50vbPND1VZnOfQzIzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789595534; c=relaxed/simple;
	bh=ZMxQf8RZ+U7jVt0gI4uDmJSeU0wx5e3K+4UKflrYXNI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Pr6EHv5vSy/6uT5icHz5IlMP9sgKmrSQEjZD6V1Fpqs1nC0EBHz1z0wuSQ3sKKy5regfPyOftLmvK1p0l1CzS5wNZ9n3IHuT5SZHSm9vcmacyCNrhL13PyOzbI8A+OveBxmC2aClav0YIWS9E+/KkQVGfGvyrgqVNpS2kMlB6W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4be498aca30so234237b6e.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2026 14:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789595522; x=1790200322;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zFc4CLn8Ksn0EWC/9yT5PyB5de0IgZnza8mZSbtO8B8=;
        b=GzA4mjYElCNpRBV75PE6wO6VeQZTjkDsc+XZLQteBwOZ1iMowSJvuHnFUuI35zRusm
         xYfZCqvnBrzXeOuWBTBPXWIv4FGfOlwgWhWidv2QuWDzYoHOK/on5p65eB3diM3mvFLH
         v9d1eh4mtfKXBvuZgaXqAXQZFqQJgfPFIke+d2ItcfVvOf1OX7iJ089SgkHStJ/cmxds
         Og/wg653KjzruO9EnkDfHSxDHXfLGSL8nknsYd6jpQbyL3QMURLGHHlJfj2JwPdMsBLj
         RTmuquG9MBoMO/9mhtI2zG5oF4NcgdRs4DXUmMPz5/q3XusCdm1LdUDuarFrp/1lJEKr
         D8tQ==
X-Forwarded-Encrypted: i=1; AKwUvByMhZgshe0h/7XTywBIq1P1tNYN/6EWZ1zXp9bJuVX6xgLyFzvM+uL/PUR3rZtNklViFRrrjCnP6gJtoylR@vger.kernel.org
X-Gm-Message-State: AFuF++nCdgX/RZ5rlzGnp7kJShgbBufqWJnRg/gf7J6165PlQAI55t7W
	GM+L+FWLvTgg8wCoo9YRVE2K1QBLhg2sxxeyXMQooI0U7/5V1LlQc4GRTBLULwHtWS5JJFA/sY+
	eh0V9mZ+fpFYoI+rsgxME+10OLY8el2Y+Wgehq4jTqMxcdKEgL0B0Xgqjxdg=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1795:b0:4c3:9892:96fe with SMTP id
 5614622812f47-4ca499ce7edmr6641854b6e.3.1789595522515; Wed, 16 Sep 2026
 14:52:02 -0700 (PDT)
Date: Wed, 16 Sep 2026 14:52:02 -0700
In-Reply-To: <CAE2Bdm3NuEHshrG6K2boKAnCQUvT5SX79cP9nPgS2s1afzY1hg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aab0f82.e91c2013.3bdb06.0009.GAE@google.com>
Subject: Re: [syzbot] [fs?] possible deadlock in ovl_create_object (2)
From: syzbot <syzbot+7cab6a19619f1b8efc00@syzkaller.appspotmail.com>
To: dakr@kernel.org, driver-core@lists.linux.dev, gregkh@linuxfoundation.org, 
	iam@thechris.in, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: ODEBUG bug in lookup_object_or_alloc

ODEBUG: object ffffc90007cdf850 is on stack ffffc90007cd8000, but NOT annotated.
------------[ cut here ]------------
1
WARNING: lib/debugobjects.c:672 at debug_object_is_on_stack lib/debugobjects.c:672 [inline], CPU#0: syz-executor162/6029
WARNING: lib/debugobjects.c:672 at lookup_object_or_alloc.part.0.cold+0x19/0x40 lib/debugobjects.c:705, CPU#0: syz-executor162/6029
Modules linked in:
CPU: 0 UID: 0 PID: 6029 Comm: syz-executor162 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:debug_object_is_on_stack lib/debugobjects.c:672 [inline]
RIP: 0010:lookup_object_or_alloc.part.0.cold+0x19/0x40 lib/debugobjects.c:705
Code: c4 60 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 83 c5 01 89 2d a0 1f 7d 1a 4c 89 e6 48 c7 c7 c0 39 62 8c e8 21 ae eb ff 90 <0f> 0b 90 e9 82 31 fe 03 83 c5 01 89 2d 7f 1f 7d 1a 49 39 c4 73 da
RSP: 0018:ffffc90007cdf6c0 EFLAGS: 00010082
RAX: 0000000000000050 RBX: ffff88802cb1d738 RCX: 0000000000000000
RDX: 0000000000000050 RSI: ffffffff81ea1339 RDI: fffff52000f9bec9
RBP: 0000000000000001 R08: 0000000000000007 R09: 0000000000000000
R10: 8000000000000001 R11: 0000000000000001 R12: ffffc90007cdf850
R13: ffff888034204b00 R14: 0000000000000000 R15: 0000000000000000
FS:  00005555811b5400(0000) GS:ffff8880d5b57000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555811b8778 CR3: 000000002bbd8000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 lookup_object_or_alloc lib/debugobjects.c:682 [inline]
 __debug_object_init+0x2a9/0x3d0 lib/debugobjects.c:798
 __init_work+0x51/0x60 kernel/workqueue.c:697
 block2mtd_setup_defer+0xd7/0x1d0 drivers/mtd/devices/block2mtd.c:504
 block2mtd_setup+0x9c/0x1e0 drivers/mtd/devices/block2mtd.c:529
 param_attr_store+0x199/0x300 kernel/params.c:591
 module_attr_store+0x58/0x80 kernel/params.c:906
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 iter_file_splice_write+0x830/0x10b0 fs/splice.c:736
 do_splice_from fs/splice.c:936 [inline]
 do_splice+0x109c/0x1fa0 fs/splice.c:1349
 __do_splice+0x33b/0x370 fs/splice.c:1431
 __do_sys_splice fs/splice.c:1634 [inline]
 __se_sys_splice fs/splice.c:1616 [inline]
 __x64_sys_splice+0x187/0x250 fs/splice.c:1616
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa1c31b3437
Code: 48 89 fa 4c 89 df e8 98 1d 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007ffce5a2ac20 EFLAGS: 00000202 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 00005555811b5400 RCX: 00007fa1c31b3437
RDX: 0000000000000005 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007fa1c31ec0fe R08: 0000000000000026 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00005555811b7770
R13: 0000000000000026 R14: 00007ffce5a2aca0 R15: 0000000000000002
 </TASK>


Tested on:

commit:         238650ef Merge tag 'powerpc-7.3-4' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=143de115580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5c3949d762a91f
dashboard link: https://syzkaller.appspot.com/bug?extid=7cab6a19619f1b8efc00
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17ade115580000

