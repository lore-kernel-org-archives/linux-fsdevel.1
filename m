Received: from mail-oa1-f79.google.com (mail-oa1-f79.google.com [209.85.160.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E2A2750ED
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 22:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783550667; cv=none; b=M08Y65ge5wYoABk1Dm1yYUcAGIjXpXXJxZiVE3knJxclZBbx61LogGycax5IE9i6eoqyrG8kODD/laFihsLSiebiw8/m3hbsQChMLcRgVhwaZC9jFBHVnq4sw8w/2meLQRKRXn4LaNhRoL661RSb0CwQ58bpoehiWbXEVyI3hwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783550667; c=relaxed/simple;
	bh=+iJUxoyxcSn1b31jFY0RZQ1RITEM00DMOeA1AJVuXU0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OoE2srbXSFJjjn4KeYVb6Wl3DKzsK2/gVH+l2oXqTKMseVUCOq3rDmQsKVO2+6pmZ9ugMWhe/zSCuCoJF5P4d8mR+dxA8oQ0U15lNQGuHqk2I+5Cpwxd/e4Gl4ZKIF1XNRqghXLpUWXTY5R/r06nGWCeqhnkOjnUOvxlXpTt3C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f79.google.com with SMTP id 586e51a60fabf-448d5182870so1427923fac.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 15:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783550665; x=1784155465;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=g5jGHLo8d7//+miyVPyO1k47Kcuev3vbYXR8vos0/m8=;
        b=QBRE4syjf0z4/39GFWVKGBI7fl0MmKZfUhO0ZeODw7j262317x+EAOYHuj5WNcVq+q
         bNXnR0R8XI52w/bgGXA2CdHa8u0cWK041V9O/tuO2aaeN6YbkTxqwL4LDsPp4gx/Y4R9
         RErlm5Oo1X1Ac0Oc5QyUsY0lBeTMYBrxjVPTDI9D1yOxZYNuhvDe87M13BBa+rDZSvuI
         o2Ig/1vUdrfdyUZyxS0xQtmxhr3Ev95j4ktWxRHeJDYBtO+8q48Udw8axE/Znb5pe/ZN
         /GAyuSjX0fOmfzZK80vBbhZcKxZgBHPYrfoSwQaRvToWeCVky1SHi+nphxh1/4I///gY
         kVpg==
X-Forwarded-Encrypted: i=1; AFNElJ8yZO0rwPltWjyn0aPjIhB3Dzxzp/mASXcbtXku7Up8PUfmZoqFlfECsuSntrKm/HGCIcjDw7aejQancf7f@vger.kernel.org
X-Gm-Message-State: AOJu0YyTP25bX0ZwyKIKR3Wpr7N5pMh63QB22ia0PlmwJdNS66iKrZeu
	WQkHEASs/ZmPYcf/mbdoo33FdAPEde9RYGy/6HtqRhCvD3zmUENQ49EWrGWcNoV0DtMCQE/tGMy
	fADNuDEr0SrV+XN9AeVL+nVTuXSrtGsiLwEIR6bunRUs+wzdgQG6EmSyGPVg=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:189b:b0:6a3:ba7:842d with SMTP id
 006d021491bc7-6a36d861660mr3064491eaf.11.1783550665114; Wed, 08 Jul 2026
 15:44:25 -0700 (PDT)
Date: Wed, 08 Jul 2026 15:44:25 -0700
In-Reply-To: <6a05437d.170a0220.196691.0003.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a4ed2c9.57639fcc.86d58.0017.GAE@google.com>
Subject: Re: [syzbot] [hfs?] WARNING in hfs_mdb_commit
From: syzbot <syzbot+c149ad75e9633be0c1ad@syzkaller.appspotmail.com>
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	slava@dubeyko.com, syzkaller-bugs@googlegroups.com, vdubeyko@redhat.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    0e35b9b6ec0f Merge tag 'mm-hotfixes-stable-2026-07-06-17-4..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=137e7d89580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20c9876b0f77b546
dashboard link: https://syzkaller.appspot.com/bug?extid=c149ad75e9633be0c1ad
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11c55d46580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=158f6739580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-0e35b9b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2a17ca6db8f5/vmlinux-0e35b9b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c885024dccba/bzImage-0e35b9b6.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6a4d05118745/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c149ad75e9633be0c1ad@syzkaller.appspotmail.com

------------[ cut here ]------------
!buffer_uptodate(bh)
WARNING: fs/buffer.c:1093 at mark_buffer_dirty+0x299/0x410 fs/buffer.c:1093, CPU#0: syz.1.1033/6784
Modules linked in:
CPU: 0 UID: 0 PID: 6784 Comm: syz.1.1033 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:mark_buffer_dirty+0x299/0x410 fs/buffer.c:1093
Code: 4c 89 f7 e8 f9 0d d9 ff 49 8b 3e be 40 00 00 00 5b 41 5c 41 5e 41 5f 5d e9 d4 5e fb ff e8 af e7 69 ff eb 8c e8 a8 e7 69 ff 90 <0f> 0b 90 e9 a5 fd ff ff e8 9a e7 69 ff 90 0f 0b 90 e9 cf fd ff ff
RSP: 0018:ffffc90005d379a8 EFLAGS: 00010293
RAX: ffffffff825c9ae8 RBX: ffff8880123aa700 RCX: ffff888034a30000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
RBP: 1ffff1100a45f401 R08: ffff8880123aa707 R09: 1ffff110024754e0
R10: dffffc0000000000 R11: ffffed10024754e1 R12: dffffc0000000000
R13: ffff8880522fa668 R14: ffff888045ba945b R15: ffff888045ba9400
FS:  000055556b366500(0000) GS:ffff88808c54e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31a63fff CR3: 0000000034b1d000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 hfs_mdb_commit+0x503/0x1160 fs/hfs/mdb.c:309
 hfs_sync_fs+0x1d/0x30 fs/hfs/super.c:38
 sync_filesystem+0x1cf/0x230 fs/sync.c:66
 fs_bdev_sync+0x2c/0x50 fs/super.c:1433
 blkdev_flushbuf block/ioctl.c:520 [inline]
 blkdev_common_ioctl+0x12e1/0x3250 block/ioctl.c:658
 blkdev_ioctl+0x528/0x740 block/ioctl.c:791
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1d9239de59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffd0ece148 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f1d92625fa0 RCX: 00007f1d9239de59
RDX: 0000000000000000 RSI: 0000000000001261 RDI: 0000000000000004
RBP: 00007f1d92433e6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f1d92625fac R14: 00007f1d92625fa0 R15: 00007f1d92625fa0
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
