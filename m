Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795178899;
	b=KEV6U4b1PLTJwoU4mWMsfj1WWwg5nd7pExRXMA51PJOqzS3NidLwgWUWW1WjgLI7A8ng
	 S/u6f2AIayCgXFNgTKf9V8NGPhrZgSyc3Ys+5NEtgqyZh0tAT6Q25n/SrfvASuhvHCwPJ
	 Q53lZudqdiH1dhA/9Tg6AzI/xxCKU+UJA2rioGwKIZbltq/6dOi1xXOXShJP8XMFW2B7E
	 BYnP5CZncGWThOiUU5qEaUgUVKLrBnJqPSGgYcJ0kJoXMgECFHpEtYsPIxF60ZzSh/ut0
	 s/1Jcs6T82Q0Y551VhKkbiox6k+qBMebIUDizigDGT56cMWqYtHZmeV0+LlAhNBSUJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795178899;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=1D63QB71/TghLgtzvuEvuDkopznjceCiCu2ItkknAg4=;
	b=Kc9l9bUiFcfUkOWvVupWKTnyVQpRcXNOl2tz/m2c6FFXgQSggHfx0dAG7gdCkWEiyvNA
	 fYV09/s6dhyVuVmin0VBWffRx5QZlxi2jYP984TmQ1q53eeyhISp8Rkfl3Pu1vXUI5Yxb
	 t90vLBy3q+6jv4xoWRa8K42pHSEHhpwtoUcU1X0pL7ErlkQwhOzDer9GCdsiSAjofq/Kp
	 gJKLJDTtSxRPiKigvXFdLcKEa9bZZ6NYw4VI8DbRtIEGcQv3GRu+c0Ko3Av76lxJc+989
	 4SvkLrgARdNcP3bBaGUl8UhCuIfmCV/m6zpUSoLp/PXflAe2fvH1astJoMP02UwXhNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C72606A325
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 12:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6C72606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-55bf11583d9so920625b6e.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 04:48:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795178898; x=1795783698;
        h=content-type:cc:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1D63QB71/TghLgtzvuEvuDkopznjceCiCu2ItkknAg4=;
        b=UkmaXLAFdBCF1a/MiyK0YryHLp8dNzVQ759BFqwqpVfOg/1excbJB1nTmP0Y8qztMA
         fDpiPkywSibpWmCTnnqEw83F6B65dcj8JKmtEoyMaSVz1Da3yuqcyyLTTnt3JKeds+9C
         /SZLToAzryIkKaY9cb8nLMAWK0he0aaEInU7dvgSHjAqFKoDhDqvbQMKaYJVl77Hjtjt
         vkmAiT0OZGBP9PYB3mCriaOGH/fX87X0SY7zaGpbg2o8uHvDuAM2lscwqNVMqRBDbPpp
         +6EKUsmO958eMe+AQ8/FAHqn3Vcd/ID7XwDROdbrfdBGPCrGGRgnWOXmuvkOU/WKPJDG
         tTTg==
X-Forwarded-Encrypted: i=1; AL+hErFscjpr4z8RSsmEu6oxYqVytcTw/0SI+JmdUEyhYDVLRoSZd26CALqlulJcsuSn4ScQ2tifo4mw7Xaux6LJ@vger.kernel.org
X-Gm-Message-State: APuU4Z//itDjXOYGS+Poh0Yl66r2k4v+mQ0wT2zdYJdTRkahxKu96+7R
	urKn7NjjS57wOvcdJ3EOfcCtqezlCiy9WJ3vTcJJcaqT5N31egyFPxbJXH+G8g42V8fHM+kOmlR
	EaOo30SVutPRKnXDhzQ7o+6NV4Vf0hR+Ex1IbXdRIjqlf0DhVSoSEZLyiBj8=
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:6414:b0:4d6:9133:cfea with SMTP id
 5614622812f47-5797e590039mr3947059b6e.47.1795178897977; Fri, 20 Nov 2026
 04:48:17 -0800 (PST)
Date: Fri, 20 Nov 2026 04:48:17 -0800
In-Reply-To: <ed43cd15-5740-4f45-88a2-0a700962d7c3@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6b004191.c48d0c14.ca62.001a.GAE@google.com>
Subject: Re: [syzbot] [exfat?] WARNING in vfat_update_dotdot_de
From: syzbot <syzbot+b0aebd03565f5774f7f8@syzkaller.appspotmail.com>
To: krystianmkaniewski@gmail.com
Cc: hirofumi@mail.parknet.co.jp, krystianmkaniewski@gmail.com, 
	linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> On 9/14/26 18:38, syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    5225b8eec4c9 mailmap: update entry for Jens Axboe
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=11cd61f9580000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=5e4e3a0e188a497e
>> dashboard link: https://syzkaller.appspot.com/bug?extid=b0aebd03565f5774f7f8
>> compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b455f9580000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a1b615580000
>> 
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/fdabe739a017/disk-5225b8ee.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/ef60d7040756/vmlinux-5225b8ee.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/ccb7b942e430/bzImage-5225b8ee.xz
>> mounted in repro: https://storage.googleapis.com/syzbot-assets/be5074fab5f0/mount_0.gz
>>   fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=16cd61f9580000)
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+b0aebd03565f5774f7f8@syzkaller.appspotmail.com
>> 
>> loop0: rw=8912896, sector=102, nr_sectors = 1 limit=63
>> syz.0.17: attempt to access beyond end of device
>> loop0: rw=8912896, sector=103, nr_sectors = 1 limit=63
>> syz.0.17: attempt to access beyond end of device
>> loop0: rw=8390657, sector=98, nr_sectors = 1 limit=63
>> Buffer I/O error on dev loop0, logical block 98, lost sync page write
>> ------------[ cut here ]------------
>> !buffer_uptodate(bh)
>> WARNING: fs/buffer.c:991 at mark_buffer_dirty+0x299/0x410 fs/buffer.c:991, CPU#0: syz.0.17/6146
>> Modules linked in:
>> CPU: 0 UID: 0 PID: 6146 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/05/2026
>> RIP: 0010:mark_buffer_dirty+0x299/0x410 fs/buffer.c:991
>> Code: 4c 89 f7 e8 a9 01 d8 ff 49 8b 3e be 40 00 00 00 5b 41 5c 41 5e 41 5f 5d e9 74 52 fb ff e8 ef 00 68 ff eb 8c e8 e8 00 68 ff 90 <0f> 0b 90 e9 a5 fd ff ff e8 da 00 68 ff 90 0f 0b 90 e9 cf fd ff ff
>> RSP: 0018:ffffc90003b57858 EFLAGS: 00010293
>> RAX: ffffffff825fc9c8 RBX: ffff888076b98460 RCX: ffff888020348000
>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
>> RBP: dffffc0000000001 R08: ffff888076b98467 R09: 1ffff1100ed7308c
>> R10: dffffc0000000000 R11: ffffed100ed7308d R12: ffff88806768a434
>> R13: 0000000000000000 R14: ffff8880544440b0 R15: ffff88807688ba08
>> FS:  00007fa0804ca6c0(0000) GS:ffff888124cd2000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007ffdc870d998 CR3: 0000000035986000 CR4: 0000000000350ef0
>> Call Trace:
>>  <TASK>
>>  mmb_mark_buffer_dirty+0x2c/0x1f0 fs/buffer.c:624
>>  vfat_update_dotdot_de+0x90/0x1c0 fs/fat/namei_vfat.c:917
>>  vfat_rename_exchange fs/fat/namei_vfat.c:1140 [inline]
>>  vfat_rename2+0xe3e/0x1c90 fs/fat/namei_vfat.c:1171
>>  vfs_rename+0xbd9/0xef0 fs/namei.c:6208
>>  filename_renameat2+0x533/0x9a0 fs/namei.c:6326
>>  __do_sys_renameat2 fs/namei.c:6355 [inline]
>>  __se_sys_renameat2+0x5a/0x2c0 fs/namei.c:6350
>>  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>>  do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> RIP: 0033:0x7fa07f59e159
>> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
>> RSP: 002b:00007fa0804ca028 EFLAGS: 00000246 ORIG_RAX: 000000000000013c
>> RAX: ffffffffffffffda RBX: 00007fa07f826090 RCX: 00007fa07f59e159
>> RDX: ffffffffffffff9c RSI: 0000200000000480 RDI: ffffffffffffff9c
>> RBP: 00007fa07f63503b R08: 0000000000000002 R09: 0000000000000000
>> R10: 00002000000004c0 R11: 0000000000000246 R12: 0000000000000000
>> R13: 00007fa07f826128 R14: 00007fa07f826090 R15: 00007ffc6d0e6af8
>>  </TASK>
>> 
>> 
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>> 
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>> 
>> If the report is already addressed, let syzbot know by replying with:
>> #syz fix: exact-commit-title
>> 
>> If you want syzbot to run the reproducer, reply with:
>> #syz test: git://repo/address.git branch-or-commit-hash
>> If you attach or paste a git patch, syzbot will apply it before testing.
>> 
>> If you want to overwrite report's subsystems, reply with:
>> #syz set subsystems: new-subsystem
>> (See the list of subsystem names on the web dashboard)
>> 
>> If the report is a duplicate of another one, reply with:
>> #syz dup: exact-subject-of-another-report
>> 
>> If you want to undo deduplication, reply with:
>> #syz undup
>
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4

Patch testing via #syz test is temporarily disabled.
See https://github.com/google/syzkaller/issues/8122 for details.

>
> -- 
> Krystian Kaniewski
