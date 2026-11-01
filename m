Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793492672;
	b=ssD2PoWVlW2dCpJ5xkwoyFgpsrEFARzlUD2A2L2qAXAyLW3c1wQfJshHOwMFQAMcpRoV
	 vAwbnc+7BXCUGglW+KbpXaJ7OZpl8ikrCqkWeJ0xgUSsy/mQwF1Q1qgvxpPsvVsStmAVX
	 Ip30oIyGJJLSMlcbx4i1Tt15wUsmIwaTyOSbbyXRMn3Lvsd1a321dHq4ROovUPOn88MKI
	 YXd6p4M0DEV60HCB/p3CY7ZDRN5HW/0q/TmBEt5mR/TXzMKnILrHaFZA4xiPhn35I28PE
	 D9/xa3MKovjnO4FpHnp5r6Eh0erI40GSVYhtMOZW8nRQZWj/IVLspw2exANcEj1+ukg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793492672;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=MH1M6eFfGW0Z+XwFusM64ori/whPIcIiOb6x6N6fzJI=;
	b=E6hDsbel3yy11Ptbcm1njxZk7PK/irvPmtXlXH/14LOA1SLgNxUkc4bvhQUHhhqp39Im
	 4xMKEKD4mUJ6LAzvnZSOIwNlsQNU3i5znrau2PHI2D5Y8t5gxraLJCC4a5Kr2fzDMOVne
	 +12VcMwQ9ydN8SlLDDsflh8oW+uAGbhrWKBKtbt8NMswSn7hSia6JG4wI5yPqYnaY4i8C
	 nh9W6CnNtdl4yFlWQQM0eGLrd5CmjoivkeK0ilr0F3XhO+PkQA72QYCoQ+jWYmfCham62
	 wc45yqUr2ARPBGAXGzWuSOSic207ZC/sgByV9pR8pBgtgmQYE4tFdoVXfRRtCD9cBcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC13606A31A
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Nov 2026 00:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BC13606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4db3db8687fso3129192b6e.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 17:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793492671; x=1794097471;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MH1M6eFfGW0Z+XwFusM64ori/whPIcIiOb6x6N6fzJI=;
        b=nzkXSybRlv7mtYkFvlbWV6b6kbTV3KWrhJ9F6LKizOrY2dDNr8tW6yR5u6F3GN9Cr/
         Ddw9zX00q0x5YCDosLEjmXhC25+m+kuMizrRClnTh1seE/PAYqeVuKQNqEvE24sJS/zA
         w1b1UilQ7BLS50OIy3Zo4izfywoNZK3GqjQgcFHPeVPO6Rh8xVAb+Q5Cj/HWJf+/RF+h
         XWRJiEKv6BHpeicVnwi3PU79A/nGnsoLk818lsHxTSic23UDvPriya8kPZA9wbbhcOUM
         wOmlWG+hogfFicQYB9UYaSMNVDj83ToiEOnoBWt3/yXFa48q8MsK+eAaud/eTDaBCH2H
         sQcg==
X-Forwarded-Encrypted: i=1; AKwUvByjdtntELH2Bcj4trBPUHGqPRl8d73TsEuX4GP3mzi/bG4Gv50BynvH2T42NEkW4xIQTdwXVUoYN3iNxElH@vger.kernel.org
X-Gm-Message-State: AFq9FYKAF1tCU98g1fG11DTROVg7CKfxgh4dS96I3GviFKH7PU7pvr3b
	i7iD9QeCBX9RmAVLSUSui64qvlHtxKAvxxBJICl8pivbl6GKHIkfSDhxPwfJIQghLdERDiBetUY
	K0TDMWc4UtC1WXqvINIwuT3AN1enS3jXTIy/V3cuzaU20ADXI4sXElABMLjY=
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:88cb:b0:564:3fe1:2fad with SMTP id
 5614622812f47-5643fe14a80mr140828b6e.42.1793492671534; Sat, 31 Oct 2026
 17:24:31 -0700 (PDT)
Date: Sat, 31 Oct 2026 17:24:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ae686bf.64e51036.15cf6a.0004.GAE@google.com>
Subject: [syzbot] [driver-core?] [fs?] kernel BUG in sysfs_break_active_protection
From: syzbot <syzbot+dcad997ed2b5bd95cc5e@syzkaller.appspotmail.com>
To: dakr@kernel.org, driver-core@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7649ba73f9e7 Add linux-next specific files for 20261030
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=139805f1580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=82467d52d846ff27
dashboard link: https://syzkaller.appspot.com/bug?extid=dcad997ed2b5bd95cc5e
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a82cb1580000

AI-generated root cause summary:
In md_attr_store(), writing "clear" to array_state invokes
sysfs_break_active_protection() prior to acquiring all_mddevs_lock and
validating the device via mddev_get(). Since sysfs writes only hold kernfs
active references rather than a kobject reference, a concurrent deletion or
teardown of the mddev can drop the final reference on mddev->kobj, reducing
kobj->kref to zero before kernfs removal drains pending active accesses. Calling
sysfs_break_active_protection() then executes kobject_get() on the zero-refcount
object, triggering a refcount use-after-free saturation/BUG and potentially
corrupting memory or crashing the kernel.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=dcad997ed2b5bd95cc5e

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dcad997ed2b5bd95cc5e@syzkaller.appspotmail.com

refcount_t: addition on 0; use-after-free.
------------[ cut here ]------------
kernel BUG at lib/refcount.c:34!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 6056 Comm: syz-executor398 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/15/2026
RIP: 0010:refcount_warn_saturate+0xf0/0x110 lib/refcount.c:34
Code: 80 c1 03 38 c1 0f 8c 6a ff ff ff 4c 89 f7 e8 e7 44 51 fd e9 5d ff ff ff e8 dd 23 da fc 48 c7 c7 e0 a3 8c 8c e8 a1 d1 38 fc 90 <0f> 0b e8 c9 23 da fc 48 c7 c7 60 a4 8c 8c e8 8d d1 38 fc 90 0f 0b
RSP: 0018:ffffc90002e5fb78 EFLAGS: 00010246
RAX: 000000000000002a RBX: 0000000000000002 RCX: 4550039d880cf800
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff9014c84b R09: 1ffffffff2029909
R10: dffffc0000000000 R11: fffffbfff202990a R12: dffffc0000000000
R13: 1ffffffff22654c6 R14: ffff88807c40e128 R15: dffffc0000000000
FS:  00007f63dcdeb6c0(0000) GS:ffff88812350b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b9ba686138 CR3: 0000000074ef4000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __refcount_add include/linux/refcount.h:-1 [inline]
 __refcount_inc include/linux/refcount.h:366 [inline]
 refcount_inc include/linux/refcount.h:383 [inline]
 kref_get include/linux/kref.h:45 [inline]
 kobject_get+0xfa/0x120 lib/kobject.c:643
 sysfs_break_active_protection+0x28/0xa0 fs/sysfs/file.c:471
 md_attr_store+0x28f/0x640 drivers/md/md.c:6167
 kernfs_fop_write_iter+0x3a4/0x540 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_pwrite64 fs/read_write.c:1504 [inline]
 __do_sys_pwrite64 fs/read_write.c:1512 [inline]
 __se_sys_pwrite64 fs/read_write.c:1509 [inline]
 __x64_sys_pwrite64+0x210/0x2c0 fs/read_write.c:1509
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f63de64ba9e
Code: 08 0f 85 f5 e2 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 90 41 57 41 56 4d 89 c6 41 55 4d 89 cd 41 54 55 53 48 83 ec 08
RSP: 002b:00007f63dcdeb0f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
RAX: ffffffffffffffda RBX: 00007f63dcdeb6c0 RCX: 00007f63de64ba9e
RDX: 0000000000000005 RSI: 00007f63de69003a RDI: 0000000000000006
RBP: 0000000000000006 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f63de69003a
R13: 0000000000000003 R14: 00007f63de6c3100 R15: 00007f63de6c4b4c
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:refcount_warn_saturate+0xf0/0x110 lib/refcount.c:34
Code: 80 c1 03 38 c1 0f 8c 6a ff ff ff 4c 89 f7 e8 e7 44 51 fd e9 5d ff ff ff e8 dd 23 da fc 48 c7 c7 e0 a3 8c 8c e8 a1 d1 38 fc 90 <0f> 0b e8 c9 23 da fc 48 c7 c7 60 a4 8c 8c e8 8d d1 38 fc 90 0f 0b
RSP: 0018:ffffc90002e5fb78 EFLAGS: 00010246
RAX: 000000000000002a RBX: 0000000000000002 RCX: 4550039d880cf800
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff9014c84b R09: 1ffffffff2029909
R10: dffffc0000000000 R11: fffffbfff202990a R12: dffffc0000000000
R13: 1ffffffff22654c6 R14: ffff88807c40e128 R15: dffffc0000000000
FS:  00007f63dcdeb6c0(0000) GS:ffff88812350b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f94a870e7d0 CR3: 0000000074ef4000 CR4: 00000000003526f0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
