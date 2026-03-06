Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECB7365A18
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772798001; cv=none; b=nxvW4l9QkEJQxM1yzhfrZOggme1dcSLvouWIwocsZVYZNPDK2t6DWLqBJd14XJt0K6Kk+sXmToceH5PlZK+UPvhp98/ePx4zB0KqWyrjz2mQwnD5xLrAL1l/IdjZyEw1bzoYCQuem8E+mcP/ETW3pr2y89Qv+vE/BpBxmzN9Tak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772798001; c=relaxed/simple;
	bh=m+C7ElA3bRPaH0W1UtP7FgRTLi7nAINy2AyJxyBcanQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZlY9nJWzOLrxyR/VSa4iJU4PAxKGoE2bY2HjtwwgNA4S/JUIpBw+gJEbeYDxQ9BIttsKcoCWySoDpfy+ipx7MIx26gjeQU+WaXTsGK7Yuriq1I56x1OQ9Hfd38NLg6B9WNoanyRdo2+4DXrpNzb4QkwxqpFmcEtmRGWg4W+7EPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-679dcf1f680so176771744eaf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Mar 2026 03:53:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772797999; x=1773402799;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=htYTekGI96RRzHG8EdGkIPequJxrAfxWaa5pkEEJZKY=;
        b=GR2WnmjnxCAVr7Y3kk/NPBLKiUH4Nwb8x9AZn/6uFu0JdvW2Cfe6Vw1TJ+1su4d8WJ
         3hZxppO+efrjAT3R0BkIHK39joOsSnf6ilcWuW6DGK/IkmiXvTD0DgOE0jzUtfabVVv+
         Lxvw/3P2ybC8WNFYFTZ8h9Y7ylB5iOeiI/w8fgu+jOgujrMxmsYTX+Cnr92pfnldPt8H
         wohS8UIf4eimDeoKTsrv0fiAmD5pgfsObs+622o7SicZ6RAK888bd12UXQCrw7nF2gTT
         iP4woONS4mFOlrgttk3BkmtE1sogcOvZlKmm6keYf9MkfDULSZYPoWJb8JSda5OecoCN
         nTiQ==
X-Gm-Message-State: AOJu0YwtmLQCHs3Kqst7h0E2CPu9mPl0Y2mnVylKUj0of0r6gkcMRo3D
	pDM5GWRo8oLmxuAaQzYbeY2g6B134GbgV3MQp8MJ2dwXffHMls370bE4SCajXqMOkwBuLxTSSa9
	ln01lHGGRF6jJYfxSdfyg0wbHMvgjb1M4jXh7QfTOEGgdRkw9cxN0caVF1eU=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:81d0:b0:65f:1012:69c5 with SMTP id
 006d021491bc7-67b9bd8f1f7mr1120617eaf.76.1772797999387; Fri, 06 Mar 2026
 03:53:19 -0800 (PST)
Date: Fri, 06 Mar 2026 03:53:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69aac02f.050a0220.13f275.001d.GAE@google.com>
Subject: [syzbot] Monthly fs report (Mar 2026)
From: syzbot <syzbot+list8af9c88e9e1bcf5eee09@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello fs maintainers/developers,

This is a 31-day syzbot report for the fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fs

During the period, 1 new issues were detected and 2 were fixed.
In total, 59 issues are still open and 631 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  19138   Yes   WARNING in path_noexec (2)
                   https://syzkaller.appspot.com/bug?extid=a9391462075ffb9f77c6
<2>  6953    Yes   WARNING in inc_nlink (3)
                   https://syzkaller.appspot.com/bug?extid=2b3af42c0644df1e4da9
<3>  6821    Yes   possible deadlock in input_event (2)
                   https://syzkaller.appspot.com/bug?extid=d4c06e848a1c1f9f726f
<4>  6409    Yes   INFO: task hung in __iterate_supers
                   https://syzkaller.appspot.com/bug?extid=b10aefdd9ef275e9368d
<5>  4748    Yes   INFO: task hung in path_openat (7)
                   https://syzkaller.appspot.com/bug?extid=950a0cdaa2fdd14f5bdc
<6>  2554    Yes   INFO: task hung in synchronize_rcu (4)
                   https://syzkaller.appspot.com/bug?extid=222aa26d0a5dbc2e84fe
<7>  2540    Yes   INFO: task hung in filename_create (4)
                   https://syzkaller.appspot.com/bug?extid=72c5cf124089bc318016
<8>  1956    Yes   INFO: task hung in lookup_slow (3)
                   https://syzkaller.appspot.com/bug?extid=7cfc6a4f6b025f710423
<9>  1683    Yes   kernel BUG in __filemap_add_folio
                   https://syzkaller.appspot.com/bug?extid=4d3cc33ef7a77041efa6
<10> 1310    Yes   INFO: task hung in user_get_super (2)
                   https://syzkaller.appspot.com/bug?extid=ba09f4a317431df6cddf

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
