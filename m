Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792451551;
	b=fmmitLQJ7+box2sceYE8jVP0RsiUqka5slogxzqwyPjbZMi8v+qTZoxx5/5lTWJwc/M1
	 nybAZdbDfjy/O4rzaGxu7TY++ZhyAkZaL3lxsfiWsfJpyH0d/CGrqWh1RwXLJTlsl5WQl
	 pNL6qBGQggVj43Mkp0hMHXPGv6QtwZ9seHbN5+ps/CUXN/JPF7vDEOG5TGa32fU2y9wWk
	 JwrEsaCcCVfiuEw9FRR4sKuF/aJD1OkAVgl2oAegCOWtgV3njVgZdSTEDp+g43tNYQ/FW
	 WLgO88na73VKLmZD1INHToILmRvOODxcandAD2smZz182keRapkpNwvokhvqwRijDxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792451551;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=AWMwpb1c3GewdK0NA9FnsQ5ripekQjx/SitnL4ttYRE=;
	b=K/xJfkdxO6viaGwx+Zn2QRfWsh0Cr+T3nsrE3oj43BIOgFDHbanX1iJeD4uMrrH4UtYj
	 tIR3oYWRDG8ANWpJ+FXnvKO/E7WyDGnM4K5gQ59nRDAcUF2mNPsP/QCuPUSS2pYXEhY0d
	 QX6lVoVY6EuY/QlboGxBtqYmyCQSS3PUpshw7viIiU7CY1dnzvuPVacFqajSKONZzQcr/
	 9LpmBX7eEUugAWXRpDDfzRToz76iKB2wqYAptWUacMaU9KJXqkWBzkO29oJZz/QbnRnKf
	 Frcgb4Oh9+UQOimcX6QRAs7D+OvRqzOwaCnCh9l2cQ7zw/WjoFQX6F9YBx9hIAeM5iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.210.69
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C0B606A31A
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 23:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46C0B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-81447a16061so6020979a34.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 16:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792451550; x=1793056350;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AWMwpb1c3GewdK0NA9FnsQ5ripekQjx/SitnL4ttYRE=;
        b=TJZ/9jTJpEmoM2jbT67xLRYbW4moTXiOEbOnGz6oPzC0NdiSTCAiR1rr9Edcuk9DBA
         a0cts8L44w/IUve/SeR7d8T7Z3FBSZcCtf2qApdzKvpxCl2R4kQIAR2udpnMUzwTyvnz
         l8RimtucrKgpoHDftY7GNrzVkuiUsqtSxgrMYYuBPr5QfC9SQP41k3LAPLBlcwp8gJ/S
         nvZs7fHyBWLI/RaM/tmOeLPSMIUIPNSdh7tnzGbnaMh65421mVjbB1YhyPbSXeBmLjTR
         bq+88FY9JFrlmJe8K6xfs/QBX2Q7v5bHRNXOp/sP/vlu08Fqg625UYstfCE2irvJlumm
         /WAg==
X-Forwarded-Encrypted: i=1; AKwUvBzgfzhsgZrK9iX5iLSvTNBAWl+QfeOFn4oa9jV8SuX9QO1a7aFdKEf2Hcpj9nRPL8XY2OTj8jbSrb5FAbvq@vger.kernel.org
X-Gm-Message-State: AFq9FYI17ZE9aC1aYjxQd59OItiPVjKoSAcUrX+mj4RtdzkD/5ybRple
	BMOOIVnT8eAmYcv481LIzDc5WpsqnBCqTpwMVHPF46A/sennWIEXBGUsTWoX4Nw8kXFdcXcb8lp
	2x2JRfSVFoghO+7VauSPWlCVT3LP4NeqsMYMnk7teSXfYjux4fbQsV83Dg1g=
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1823:b0:4f3:e98f:fa1d with SMTP id
 5614622812f47-53cc5b5ba97mr9812625b6e.9.1792451550302; Mon, 19 Oct 2026
 16:12:30 -0700 (PDT)
Date: Mon, 19 Oct 2026 16:12:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ad6a3de.f84f00d0.6bdd.000e.GAE@google.com>
Subject: [syzbot] [jfs] WARNING in file_remove_privs_flags
From: syzbot <syzbot+11df51d643e254ef16bb@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, jfs-discussion@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    32c52ec87d62 x86/insn-eval: Fix shadowed segment index in ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1308b20d580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b38d39c45202f4fa
dashboard link: https://syzkaller.appspot.com/bug?extid=11df51d643e254ef16bb
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/77ec099385a8/disk-32c52ec8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f5adfb921648/vmlinux-32c52ec8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/65b38cab4ac2/bzImage-32c52ec8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+11df51d643e254ef16bb@syzkaller.appspotmail.com

------------[ cut here ]------------
d_inode(dentry) != file_inode(file)
WARNING: ./include/linux/fs.h:1363 at file_dentry include/linux/fs.h:1363 [inline], CPU#1: kworker/u8:2/48
WARNING: ./include/linux/fs.h:1363 at file_remove_privs_flags+0x556/0x610 fs/inode.c:2373, CPU#1: kworker/u8:2/48
Modules linked in:
CPU: 1 UID: 0 PID: 48 Comm: kworker/u8:2 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: loop0 loop_workfn
RIP: 0010:file_dentry include/linux/fs.h:1363 [inline]
RIP: 0010:file_remove_privs_flags+0x556/0x610 fs/inode.c:2373
Code: 00 75 4d 44 89 e8 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d e9 1b 61 13 09 cc e8 75 d0 7b ff e9 a5 fe ff ff e8 6b d0 7b ff 90 <0f> 0b 90 e9 b0 fb ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c d9
RSP: 0018:ffffc90000ba7480 EFLAGS: 00010293
RAX: ffffffff824b0995 RBX: ffff8880317652a0 RCX: ffff88801e689f40
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90000ba75d8 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff2164770 R12: 0000000000000000
R13: 1ffff110062eca54 R14: 1ffff11007ff35fc R15: 1ffff92000174e9c
FS:  0000000000000000(0000) GS:ffff888124abb000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc491220d8 CR3: 0000000043560000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 shmem_file_write_iter+0xaa/0x120 mm/shmem.c:3437
 lo_rw_aio+0xc78/0xf30 include/linux/percpu-rwsem.h:-1
 do_req_filebacked drivers/block/loop.c:430 [inline]
 loop_handle_cmd drivers/block/loop.c:1949 [inline]
 loop_process_work+0x638/0x11d0 drivers/block/loop.c:1984
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3560
 kthread+0x38b/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
