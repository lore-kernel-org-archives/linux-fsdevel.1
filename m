Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A71372698
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 20:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783715558; cv=none; b=IrqzZdKyVwLD2RU/IdIux1Lxl3W4qsDyQezSZ6Oo1AHMkVAAriVHAW54Xrx+ernCi4OQXx3RAwPcY2K2bc8GDA3jmTP71AkSI+mROsDVZHgSER/+mkn4t8ocyn05jbdBbWi34drtSqvczDTmJqG4ZdyUhl2RxNDu/zGFXAalT5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783715558; c=relaxed/simple;
	bh=RYLo2BbrEsjcs7w93Ac5xGXfBILdF38ymn8e+22Ljvs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hBfnvHhmz7QS+4aaSa/EiiAJjCt5EFgNmrAWFp5zgsXmE2RUK61A+3fZeWw2Ty7es+mjlciiJo2YwnSOX/2CAP7f1zPqBAq6jH+uKpeUCARaiYY8p3LCbqx3C2nTsN+yMowS7wpIP10STMTiBwAVLnR+F/buFhLcBiZxLDBp1eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-49001defc4dso1743262b6e.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 13:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783715556; x=1784320356;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cp8o6lZQbh5zeH63aN4rnC6JHT90UGRWtoVhUpfP8xw=;
        b=q00eUFR+cdtvIA4g/2xMhdsoPoWWLwxy5Kc8+oukaQYf92P+FEn37q7Rwi/h8gx0XT
         Y2hy5VAz4x5AxubTThoseRx3j3qhA9j4y+Hm7HQHEk5Kt7BvwG2EACDQvxIUBMf7qaoL
         gi3j5qVY5QqYylj4ACJ1YkZml9tWjSRlrGmq/116fc7v4WrPCS+9mby5Xn/581bSkZCV
         w47aNj5veWU/iUSN5gs6o08Pzw2ceqxnRqkG9feOdZReY0a2Y5wijBrIeIPKTkEOJoO9
         Ts01Hq+uqGfKOSWLBtdU5Y2bsdz907cCF+ZsqwTqV//wbM377w2ZkUIIx4DpLVGI98ZU
         Dl+w==
X-Gm-Message-State: AOJu0YxZPcKrf/QeLmZpOLTIwNxc8lwoMllyh7zFE+LwjNYdnqLufPsH
	XTJJko74I0SbocLVwn05LCvMrhzL6xPuijwdz1e5gR50jmFINHO94pQ2LeizERxqiS7y0K9jaUZ
	N0alwEVDajhNekNCvPkCY91XY2yZTTrq7cTV8ojhPJ+PcDXX+H6nghT0mMg4=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:13c8:b0:4a3:d383:b3ea with SMTP id
 5614622812f47-4a42ae8c30amr561390b6e.27.1783715556726; Fri, 10 Jul 2026
 13:32:36 -0700 (PDT)
Date: Fri, 10 Jul 2026 13:32:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a5156e4.278cdcd2.e885.0007.GAE@google.com>
Subject: [syzbot] Monthly fs report (Jul 2026)
From: syzbot <syzbot+list9e8c6407f4b6e9038ba2@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello fs maintainers/developers,

This is a 31-day syzbot report for the fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fs

During the period, 2 new issues were detected and 2 were fixed.
In total, 42 issues are still open and 636 have already been fixed.
There are also 11 low-priority issues.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  8553    Yes   INFO: task hung in __iterate_supers
                   https://syzkaller.appspot.com/bug?extid=b10aefdd9ef275e9368d
<2>  3998    Yes   INFO: task hung in synchronize_rcu (4)
                   https://syzkaller.appspot.com/bug?extid=222aa26d0a5dbc2e84fe
<3>  2678    Yes   INFO: task hung in filename_create (4)
                   https://syzkaller.appspot.com/bug?extid=72c5cf124089bc318016
<4>  2024    Yes   INFO: task hung in user_get_super (2)
                   https://syzkaller.appspot.com/bug?extid=ba09f4a317431df6cddf
<5>  1998    Yes   INFO: task hung in lookup_slow (3)
                   https://syzkaller.appspot.com/bug?extid=7cfc6a4f6b025f710423
<6>  209     Yes   WARNING in path_openat
                   https://syzkaller.appspot.com/bug?extid=be8872fcb764bf9fea73
<7>  20      Yes   INFO: task hung in writeback_iter (3)
                   https://syzkaller.appspot.com/bug?extid=1e3ff4b07c16ca0f6fe2
<8>  6       No    possible deadlock in page_cache_ra_order
                   https://syzkaller.appspot.com/bug?extid=8bd419f88e25ab12cb75
<9>  2       Yes   INFO: rcu detected stall in __fsnotify_parent (3)
                   https://syzkaller.appspot.com/bug?extid=27ce6cc06c1311c152f5
<10> 102     No    INFO: rcu detected stall in blkdev_release (3)
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
