Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF263CBE7E
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 12:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783080263; cv=none; b=jMs1eHrscguUmsrDT7CcaDcfObdkKKcKYZXxo87dpDbCdTw51vVTVIK9vnXSpYqRv+eHur8zO8h3CHghLxMf2riGCmf4FRALpQN5H17p7duW4T73MT/v8EQMeGwCeA1gcHaxNpbuInNITo1KnNOcravlMNoPRhIoSzHmNJA4gFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783080263; c=relaxed/simple;
	bh=QlsMN+fY8c6k4XTTEBoLepR9Efknvt7O3WLkFg0eETs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NgpaKopVReBEcD96Bw4P6EhUv8cvvEC2pVMtusn4pIWawi0baaHPcweGvd90FsjghOy2o2TF1RYnvHdlHuHMxQuyFedfmJk9jQz7O9u++lvcYDA0olJczJr/xi637CEAlL14QeVmjUZx4KrWyRxSNIU1VJeMUsakiY7/Jbr+HSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-486055c1c6fso215318b6e.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Jul 2026 05:04:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783080261; x=1783685061;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sBoo6Qu7g78CGhjMlbzPkYbY+qlYhO31/85/0Odx4IU=;
        b=DQXce55WQcn35cHZQ/W/nvhO93kEI26Vgk4KvVObbPDvm35/WNWVdwf6NgGOwB7kvm
         e0IodjeF8khZDO9NfSplNf+CqgV4ezitLhm1ARDo/lkUzshCp+N3i/h0rS/bcq+UsIjQ
         u4AZ7IVYgYTa9VAyLS7ORqDGpSgBIYM/LlYSYFw1dhM8sdXMjrfIyB5WxIn65VkzGYFK
         6gos7X2HbwMBJQHXvuUAUIXSt3E0kxRJ20WuDbtwrNbvvvGZdcIVT0LWu0Z1AKBzPkWk
         zrzKaiyyvJNr99HhWEgWXGWhXl8xrl34aSyTg3U3+Zg0M/l3Sq1f9n87HdT0ULT6I58K
         ZOxA==
X-Forwarded-Encrypted: i=1; AFNElJ9Wd4MU1sYqJAziv3vjo0vt9vhEEVIZFukOh10av7n/bmeKuxGG/IuhYCN1SmGzcuMLB9ayhyxskiK9UoaW@vger.kernel.org
X-Gm-Message-State: AOJu0YzrJcA3c/UkaIuyQgx6GmvOivu0shZMC8nYf/zlwTAqQ0rnoZur
	7hfIp3WBTfjKC4iSopB4wi+3fyoYA1f7tTotSurnXjA8gipdO/JgS7jQG4nAUEBqnCcU+MuPB7y
	Tml6vdkiyuBXXwWuW6wfwofLrvPsaVamS2kRYZ7cCTw+ExvLHYEU1XBYwZ3c=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1791:b0:496:9b5:4eda with SMTP id
 5614622812f47-4960ef365bbmr8886165b6e.29.1783080261208; Fri, 03 Jul 2026
 05:04:21 -0700 (PDT)
Date: Fri, 03 Jul 2026 05:04:21 -0700
In-Reply-To: <6a05437d.170a0220.196691.0003.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a47a545.9dc7bc9d.3d5df4.0008.GAE@google.com>
Subject: Re: [syzbot] [hfs?] WARNING in hfs_mdb_commit
From: syzbot <syzbot+c149ad75e9633be0c1ad@syzkaller.appspotmail.com>
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	slava@dubeyko.com, syzkaller-bugs@googlegroups.com, vdubeyko@redhat.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    87320be9f0d2 Merge tag 'net-7.2-rc2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17bdeae0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20c9876b0f77b546
dashboard link: https://syzkaller.appspot.com/bug?extid=c149ad75e9633be0c1ad
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16c24946580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-87320be9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/754cbc66bcb5/vmlinux-87320be9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a1cc14711cba/bzImage-87320be9.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/60587e205076/mount_3.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c149ad75e9633be0c1ad@syzkaller.appspotmail.com

------------[ cut here ]------------
!buffer_uptodate(bh)
WARNING: fs/buffer.c:1093 at mark_buffer_dirty+0x299/0x410 fs/buffer.c:1093, CPU#0: syz-executor/5454
Modules linked in:
CPU: 0 UID: 0 PID: 5454 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:mark_buffer_dirty+0x299/0x410 fs/buffer.c:1093
Code: 4c 89 f7 e8 c9 11 d9 ff 49 8b 3e be 40 00 00 00 5b 41 5c 41 5e 41 5f 5d e9 d4 5e fb ff e8 9f f3 69 ff eb 8c e8 98 f3 69 ff 90 <0f> 0b 90 e9 a5 fd ff ff e8 8a f3 69 ff 90 0f 0b 90 e9 cf fd ff ff
RSP: 0018:ffffc90001c0fbf0 EFLAGS: 00010293
RAX: ffffffff825c8e78 RBX: ffff88804501cd20 RCX: ffff88803ab40000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
RBP: 1ffff11006780c01 R08: ffff88804501cd27 R09: 1ffff11008a039a4
R10: dffffc0000000000 R11: ffffed1008a039a5 R12: dffffc0000000000
R13: ffff888033c06668 R14: ffff888013711c0b R15: ffff8880136da492
FS:  0000555586ef3500(0000) GS:ffff88808c54e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f16db930000 CR3: 00000000484b1000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 hfs_mdb_commit+0x860/0x1160 fs/hfs/mdb.c:328
 hfs_sync_fs+0x1d/0x30 fs/hfs/super.c:38
 sync_filesystem+0xee/0x230 fs/sync.c:56
 generic_shutdown_super+0x77/0x2d0 fs/super.c:626
 kill_block_super+0x44/0x90 fs/super.c:1665
 hfs_kill_super+0x41/0x50 fs/hfs/super.c:441
 deactivate_locked_super+0xbc/0x130 fs/super.c:477
 cleanup_mnt+0x3d3/0x460 fs/namespace.c:1317
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:70 [inline]
 exit_to_user_mode_loop+0x1fa/0x730 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 do_syscall_64+0x353/0x580 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f74cbb9f097
Code: a2 c7 05 5c 26 25 00 00 00 00 00 eb 96 e8 e1 12 00 00 90 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 e8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007fff335c8fc8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007f74cbc332ca RCX: 00007f74cbb9f097
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007fff335c9080
RBP: 00007fff335c9080 R08: 00007fff335ca080 R09: 00000000ffffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff335ca110
R13: 00007f74cbc332ca R14: 000000000001edf7 R15: 00007fff335ca150
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
