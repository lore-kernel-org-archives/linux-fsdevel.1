Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80996386C0A
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 08:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772525190; cv=none; b=q2MvkEVjJkGQMIQKDxDayit0tTm0w+Fixa3Q327235OFnkBjDPmoZmnWbukU6JqagAjt1sBxUprZFZ/wSUnP5ZBPDv/OQE9JmSl+E1CVVX/paaLrLDYcemlra9dpAHeSZ60x6NgsYI5WIm8M99ckch18VrakBXTbK+IweEIhWCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772525190; c=relaxed/simple;
	bh=sHxlB3zCfQ91w9dUsT75JxLL8VrdvktIH1CmrgK03wQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RZ9/laIyWBz7stib8wtOT0SvXkSw7Dbu1nM75qPjj6iE4YBFV+fv4HJ/v7uoghn5dXAwwbxibCwMmnSVGjbIMs+WpDyRBCqdhBjiK0t2bJyRbqMWjzbaluxmOTfwDFelz1xXhhJXrc7/DqJLfz8j5V0fpYVVuKzoAakOLTu/4xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7d4d4db1523so27816489a34.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2026 00:06:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772525188; x=1773129988;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/d4LObrNVHsWNJkhsJ6Yu7SkS9ZlWkbbvw8wRBU8tBE=;
        b=VsbVBUMOnKXcLPEhiDQxMazkDvlxvlLBNr2wFCWHiYy9S6VHoigp6v9bo8PhaDjrCn
         XXEr+uEgi5yKn2HhkDU5azLnN6sR/9N7D3zjNI9Cul1YmHpo3kisEwXikxHH7DulB3R+
         txuYI/tuD2HGBnhQCHIN0QelrkJULsdJ62O3+bq4/kxW8RWkyLJzP0hW4vmF+GJfMUUv
         Isc+6fC5XiI2+BYSOFtyHwgkLDkexyNyCc9yx0XVgOcVOLjvmlBWa5870I/t4KocwGID
         DBU00L15QxTLiqUZ5h+40GYDmU8WTTdQ54Gug8dAswVKGmVGBeVwF2Nxr5NJFcz7c3w9
         eklA==
X-Forwarded-Encrypted: i=1; AJvYcCXf/fjzp7gFWGLIifj/grywCIRd/6u5vmGtkT4M8JR1mQRDpdeW4b/7ACNwa8pyj+Nd45F4j3Nv2NxWSW9c@vger.kernel.org
X-Gm-Message-State: AOJu0YwUbxxlEO5l7PvV6EcIXwQywAQYjyJYT/PPk+NAMyQtrxA5wGJk
	1MVPoCTKtVjjhQxzHMqmF4p8jMrf+qibuBkDMTa3r+s0pLUOE+SNpGs6D90wZKIb7py5QogQojq
	6Sv4GOnEZokwVktNx3aqxAI9ulrTyz/8HyiTJsYaBzyFxyojD5Jx52zWXVA8=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1794:b0:679:a650:cc0b with SMTP id
 006d021491bc7-679faf3393amr8859377eaf.51.1772525188343; Tue, 03 Mar 2026
 00:06:28 -0800 (PST)
Date: Tue, 03 Mar 2026 00:06:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a69684.050a0220.21ae90.0007.GAE@google.com>
Subject: [syzbot] Monthly hfs report (Mar 2026)
From: syzbot <syzbot+list619d5de2eff2c556826f@syzkaller.appspotmail.com>
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	slava@dubeyko.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 24 issues are still open and 35 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  15321   Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<2>  7285    Yes   WARNING in hfs_bnode_create
                   https://syzkaller.appspot.com/bug?extid=a19ca73b21fe8bc69101
<3>  6882    Yes   possible deadlock in hfs_find_init (2)
                   https://syzkaller.appspot.com/bug?extid=e390d66dda462b51fde1
<4>  3897    Yes   possible deadlock in hfs_extend_file (3)
                   https://syzkaller.appspot.com/bug?extid=2a62f58f1a4951a549bb
<5>  1851    Yes   KMSAN: uninit-value in hfsplus_rename_cat
                   https://syzkaller.appspot.com/bug?extid=93f4402297a457fc6895
<6>  998     Yes   possible deadlock in hfsplus_find_init
                   https://syzkaller.appspot.com/bug?extid=f8ce6c197125ab9d72ce
<7>  991     Yes   WARNING in mark_buffer_dirty (7)
                   https://syzkaller.appspot.com/bug?extid=2327bccb02eef9291c1c
<8>  837     Yes   possible deadlock in hfsplus_file_extend (2)
                   https://syzkaller.appspot.com/bug?extid=4cba2fd444e9a16ae758
<9>  471     Yes   KASAN: wild-memory-access Read in hfsplus_bnode_dump
                   https://syzkaller.appspot.com/bug?extid=f687659f3c2acfa34201
<10> 420     Yes   possible deadlock in hfsplus_block_allocate
                   https://syzkaller.appspot.com/bug?extid=b6ccd31787585244a855

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
