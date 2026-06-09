Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD37369D4E
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 20:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781037154; cv=none; b=pROyS6/YUsXrX0KQurWYQnEhFv4KJCPsbBV4WAoeVYe9xJ2HObcJT2Cu40VdopVtJr+0chdorT9N2WlOyHdArWGpH9J5HgxQOFaEewoZw2vzJO9uizgkOF5SuefIyWvqDRGrMgXKKGHbMffW4PypgV/N/vmTh6fjxQlPEuiYYvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781037154; c=relaxed/simple;
	bh=Zttoxw3yEMTGOwTCCzfixi8vOTG20dJlWZcMKhNe8Hk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=l17BMipDmhgR7boJK6i24njHojlDNlYQ6a5+ipW7kCuOgjpeHpwbNwpiFc5LBIyY1xgYnozAPxckb/zxx9+lRctsiS9JPTWq1JwyiVHwq3P8/QpqTrBd8ejnpuirf7ezW8Jn60hcSA842y8wsZXv2pRh+PIokkGch3Umm+Krv/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-69e3464b1afso8079369eaf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jun 2026 13:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781037152; x=1781641952;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hfs9MrIwuKMzAtGzAyw79v6p7VHy35hWr4CS/QMZpXc=;
        b=KyZUrDbStUBZuoUFEhGEk/TCaKpKOdKTq8yWSYizvoUafOFz6rTImxoASEuTh3mkk6
         SxqDsG7N4GK0UuL5oEVpx8/pJTsEi7xuNr23a1c4qKbzAValWlCiWzUKUM9EbMhqadao
         dJIeNseQsYIvmUGMg8ywpPBTgKxcqYp+UKw1hR0A7UpAimT9FHH9O9F7Z1XNw5RiiZwt
         u0k2RUbvxstWxZyMvSl6ynyfB3vzx1t7IEWAQPPfu52+pYHJFoY7lV6caFXHl5bYqraP
         u6k4NTBrldwuMwDzdueAlHse19Jqd+RUgk5KNj0aVdaxTO+RNDyv0PYxP2ykynFRieZ5
         NIfw==
X-Gm-Message-State: AOJu0YzjaJP2E7MohtimEvNrsU042B09ZKUIIqTxEgVoDBBWcP84IMJA
	YwNpon9pTExr6/vKPWRB3R/105jCaH9LCj5F43XTMRr9Ys+/XV2iyuiWWdwtT1sUJF2XYZgGaH2
	3i/08IZWEVy9lSLScJwes4N5dF/Qp4iE54jpn2qD6vSKUk1h59fKq9H/5Fh0=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:561c:b0:69e:8afe:e994 with SMTP id
 006d021491bc7-69e8afeff62mr4861338eaf.32.1781037152609; Tue, 09 Jun 2026
 13:32:32 -0700 (PDT)
Date: Tue, 09 Jun 2026 13:32:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a287860.39669fcc.33b062.009e.GAE@google.com>
Subject: [syzbot] Monthly fs report (Jun 2026)
From: syzbot <syzbot+list1bd93f1b2a6555c648f2@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello fs maintainers/developers,

This is a 31-day syzbot report for the fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fs

During the period, 4 new issues were detected and 0 were fixed.
In total, 45 issues are still open and 633 have already been fixed.
There are also 12 low-priority issues.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  7729    Yes   INFO: task hung in __iterate_supers
                   https://syzkaller.appspot.com/bug?extid=b10aefdd9ef275e9368d
<2>  3765    Yes   INFO: task hung in synchronize_rcu (4)
                   https://syzkaller.appspot.com/bug?extid=222aa26d0a5dbc2e84fe
<3>  2673    Yes   INFO: task hung in filename_create (4)
                   https://syzkaller.appspot.com/bug?extid=72c5cf124089bc318016
<4>  1652    Yes   INFO: task hung in user_get_super (2)
                   https://syzkaller.appspot.com/bug?extid=ba09f4a317431df6cddf
<5>  196     No    possible deadlock in kbd_event
                   https://syzkaller.appspot.com/bug?extid=781c8bb5e4d62cc883d3
<6>  79      Yes   UBSAN: shift-out-of-bounds in befs_check_sb
                   https://syzkaller.appspot.com/bug?extid=fc26c366038b54261e53
<7>  7522    Yes   possible deadlock in input_event (2)
                   https://syzkaller.appspot.com/bug?extid=d4c06e848a1c1f9f726f
<8>  4862    Yes   INFO: task hung in path_openat (7)
                   https://syzkaller.appspot.com/bug?extid=950a0cdaa2fdd14f5bdc
<9>  160     Yes   INFO: rcu detected stall in sys_clock_adjtime
                   https://syzkaller.appspot.com/bug?extid=25b7addb06e92c482190
<10> 101     No    INFO: rcu detected stall in blkdev_release (3)
                   https://syzkaller.appspot.com/bug?extid=07d6f9c5d7633ed4a5c8

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
