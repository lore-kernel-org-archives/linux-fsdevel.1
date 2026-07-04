Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706AF3AF641
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Jul 2026 12:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783168353; cv=none; b=E/XHdup/RMat+Tah+GwRDKzsHVlqEeSRs8mBG+RIBHN2+DEqcwSw8n3naMLK1QTdkpJrefKvlCnAAQ4NpvkVs2lmejq/wcQBeBPauSpSYK9BNX3Nevd+rQ7kkOTrqCmnlz6CIQ3BgLRk25odTcO1rH2kXQtJqY/Uu7l+70emD8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783168353; c=relaxed/simple;
	bh=+Oi8Z/Dd12Cd/ksBi6JrHQoFTR4KHzPdG3QXcNF48CQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uLBtXvaxdzXOGS1DhTbBXTXf5mNGONTW+wShwBx2SV9LELcplARhUJrtDZ5gKYp0h7TZrOIn+Rap4uRJw6lN0J2WdE/lcgkFzcGm7iBUsmTKq7NipXXjGk8WmuwO86mZ9p8y0uQWhGRhQcwa48ma8b0y4RM6UTumW4PaJ01lBwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-48a4c610ebdso1848936b6e.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Jul 2026 05:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783168350; x=1783773150;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nTiSOgs8eVNzdpGCmfSoa+ewxhCFBf/h4dmqGpuOtjI=;
        b=rwVPDhMUMVYnZ7ZJVZzPDPKuI5A1DeWXFzpSeKXvbs3+tF/9eUYzr+WnoBIR8vOs+a
         Hvn4NbJvq+MkpSvOxQpm0fn5pfxs2Z+j0/V8XZQW33s5bcbONC48A1nd+gt6Njvp5vN4
         4aDKMem+vTI4x+TLkR/o2S6WrjKRBnUWIMRE61/P0nClueoVRvSV/H+QDpQJNG74WJm/
         syvRHOKjmitonmYStvsDFlLydfnfpKwKYrtD1bLczUfo1/MRsTy8CeSAnUsB3Bo6tpXS
         C24RZ2fgOnd8Z/cc0EqMcn3EmTrcHUBPe/pVyqoo+pAeHm8IT9AzItDbD/V9hYM36MYc
         fo/w==
X-Forwarded-Encrypted: i=1; AFNElJ/9hQNoSOe/q5cheDwy+G9hij6tZkJkaDPlohITHcpiYfoF9yJWQ3f0gMAyKmfux19PzyXGs4YqwI6r+CB9@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy+CxhuIILckdkhbh3vTDD/OgY5hgm4r/7vxnFDMpCLIFLHl6R
	KQVLf964+DEzeGocjftuRhznMSe3XyqXtSu19lEAv92SibyebLPTD9TgrGSIntUxL09KIPI2BAr
	82TKeZc7TsOlY+HqAzCgLXk+gj4n4tgY6GGfQl8vkDXpdSzhKkW5HwX4Kw2I=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4481:b0:494:e0fe:9a4 with SMTP id
 5614622812f47-499b7228b4fmr1984695b6e.14.1783168350239; Sat, 04 Jul 2026
 05:32:30 -0700 (PDT)
Date: Sat, 04 Jul 2026 05:32:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a48fd5e.34acba0d.1e07b.000b.GAE@google.com>
Subject: [syzbot] Monthly hfs report (Jul 2026)
From: syzbot <syzbot+list8fa9f0e9ff956f480f05@syzkaller.appspotmail.com>
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	slava@dubeyko.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 0 new issues were detected and 0 were fixed.
In total, 19 issues are still open and 40 have already been fixed.
There are also 3 low-priority issues.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  15637   Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<2>  10863   Yes   WARNING in hfs_bnode_create
                   https://syzkaller.appspot.com/bug?extid=a19ca73b21fe8bc69101
<3>  7965    Yes   possible deadlock in hfs_find_init (2)
                   https://syzkaller.appspot.com/bug?extid=e390d66dda462b51fde1
<4>  55      Yes   WARNING in hfs_find_init
                   https://syzkaller.appspot.com/bug?extid=6a141f31cc9495a3dcc1
<5>  21      Yes   INFO: task hung in hfs_mdb_commit (3)
                   https://syzkaller.appspot.com/bug?extid=6bdbdd12cf8cdbc66466
<6>  11      Yes   general protection fault in hfsplus_cat_write_inode
                   https://syzkaller.appspot.com/bug?extid=c0ba772a362e70937dfb
<7>  5771    Yes   possible deadlock in hfs_extend_file (3)
                   https://syzkaller.appspot.com/bug?extid=2a62f58f1a4951a549bb
<8>  1868    Yes   KMSAN: uninit-value in hfsplus_rename_cat
                   https://syzkaller.appspot.com/bug?extid=93f4402297a457fc6895
<9>  912     Yes   possible deadlock in hfsplus_file_extend (2)
                   https://syzkaller.appspot.com/bug?extid=4cba2fd444e9a16ae758
<10> 394     Yes   possible deadlock in hfsplus_block_free
                   https://syzkaller.appspot.com/bug?extid=8fae81a1f77bf28ef3b5

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
