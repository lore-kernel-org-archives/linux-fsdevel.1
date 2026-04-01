Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7AE199FAB
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 13:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775049326; cv=none; b=kzPB7nWYdutaI1oCrpyPfbRhveq+cFUEteQlm24jOmTcCknFRBEM8hVPthv1/Zb/07DPUmnMbOvk25y5yvg0P4/Zl1XAawQr2THsANLWXrr66Wf0e6x0NiThnDTZNvdUvNUwt6w/T9Gmh/7PZKExeO6Dk+DW7xRsN3QfL93D/J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775049326; c=relaxed/simple;
	bh=MtQvWYwYn9sm6PZqBtA8i1LaZIAtf/qj44QaxNvvX1A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Hypq7H+DOescm2t27qvMgqXkEjiPUH/X3Nz9IZEnTtJQiWP+R3baTQ+i0z0BkFuMff/FpV+e+bDpsSWqwjEYqi1oD5NDzApCimLzXdqPw8iSLKqkZrOXbTfGuX4Xl4HywpTp07criNR5jcaQq9EZ/UEmAd6Fx9GCiJ8WIDeFUaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-66308f16ea1so20769559eaf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2026 06:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775049324; x=1775654124;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZkrVCw3CPcQgQfNfYpa4bOcFVFSNfNyoqju1LGa33vI=;
        b=WliKK1vcYvsYWNxbhwrk9sr0wxmH488MBll6jJDavy9E8JJxWcBcch60tQ2k/AiO0t
         lOmWlRYgZ0A9FDHJIhTRmwkRe/S/6UlHta5T4AogS8G/XghpIk9547EyURmLA+I0uwr2
         9i5u8ZMBp+lwn+DSMjZXCTVD67cIew4AWcWTzsJdvA45rzAZAsBrVcHgpQS7eEQK5Tzs
         0pNdeQBPiWEIJIBhS5HNycokFdPPSfcXEXzmZeCFLTSAZQdD0Je8DEpkALRawjf0hcWI
         YR2qo83mCs9P5hdNNRCmaAyq2x5fmhmRweLv6EOfYBndn7AuLUvJJ5pRzNsD9UoM2soo
         0+dw==
X-Forwarded-Encrypted: i=1; AJvYcCUg5o/JCkMi1XdICYfujNvI2tlOBaav+QsUqBtqpqMRctluXj91yuvfs42BgcEHIYQyoigQNYcu+fNEDBEP@vger.kernel.org
X-Gm-Message-State: AOJu0YwB2rXHx2g9DKcXCLAk3c+dR6GbdKA2MpZF3khYHB7PJUFU5xTQ
	RpJAoPyzkzAb7V1527AlKVC1Nuu61CR63e7mcziWUYanWFKKuMsV6aCKdwTe6UMIvSyiU9ZEOEa
	8pcmJEggvCroyXI1mB3afl/xBziP1OsFIhznjZuvY8XZlaJMKXkZ+iuWoDq0=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:781a:b0:680:57b4:9056 with SMTP id
 006d021491bc7-68057b4aa04mr199841eaf.68.1775049323989; Wed, 01 Apr 2026
 06:15:23 -0700 (PDT)
Date: Wed, 01 Apr 2026 06:15:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69cd1a6b.050a0220.70c3a.0000.GAE@google.com>
Subject: [syzbot] Monthly hfs report (Apr 2026)
From: syzbot <syzbot+list1f6337b608152165f54d@syzkaller.appspotmail.com>
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	slava@dubeyko.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 0 new issues were detected and 0 were fixed.
In total, 22 issues are still open and 35 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  15471   Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<2>  9391    Yes   WARNING in hfs_bnode_create
                   https://syzkaller.appspot.com/bug?extid=a19ca73b21fe8bc69101
<3>  7349    Yes   possible deadlock in hfs_find_init (2)
                   https://syzkaller.appspot.com/bug?extid=e390d66dda462b51fde1
<4>  4856    Yes   possible deadlock in hfs_extend_file (3)
                   https://syzkaller.appspot.com/bug?extid=2a62f58f1a4951a549bb
<5>  1027    Yes   possible deadlock in hfsplus_find_init
                   https://syzkaller.appspot.com/bug?extid=f8ce6c197125ab9d72ce
<6>  1012    Yes   WARNING in mark_buffer_dirty (7)
                   https://syzkaller.appspot.com/bug?extid=2327bccb02eef9291c1c
<7>  891     Yes   possible deadlock in hfsplus_file_extend (2)
                   https://syzkaller.appspot.com/bug?extid=4cba2fd444e9a16ae758
<8>  428     Yes   possible deadlock in hfsplus_block_allocate
                   https://syzkaller.appspot.com/bug?extid=b6ccd31787585244a855
<9>  389     Yes   possible deadlock in hfsplus_block_free
                   https://syzkaller.appspot.com/bug?extid=8fae81a1f77bf28ef3b5
<10> 96      Yes   INFO: task hung in deactivate_super (3)
                   https://syzkaller.appspot.com/bug?extid=cba6270878c89ed64a2d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
