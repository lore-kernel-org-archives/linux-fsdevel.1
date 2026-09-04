Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D557052E057
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Sep 2026 20:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788554026; cv=none; b=uPzQbt2sZ+6EKJTgpeDoRASKxHdx7Qs0tmhgsK3nXwz9cqDFt5ldG/kWCeWbCL7nxDoiUPUKUSoILgq1hbNCCFJBax0IbHVkxH2pHwn+YylyxGOqhvbpQ+NjsDkL+S1PvxLP8nMoXpoq+WnY/I1vq7ocssTw5GI4x9ScPWHXyDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788554026; c=relaxed/simple;
	bh=2lgKoAGATmvtjNde1jqJwr6XELKEB5UFJEI+ZIYwAak=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=j7SkSK9ndOqg9S9EF7dX03+mci7qfylNs6EvWjK8xdUUh6STU9+UjyLBVpW+0zaTSROq5knSZ3dlOD+Fm0JIZ23Q+GZtfeu2S7Iid2hBbsfre0khkDO34siqMklZ5o9IG/abjH1Xeq0RJY0HSIZy4118bpASmXDsDAJBwEhOweE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-6b85fefb1eeso172954eaf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Sep 2026 13:33:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788554019; x=1789158819;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NqkA40rgpHQ5zwrpts5/RR6FlTo5JxJD6OfWwzfgQR4=;
        b=NrxNjaH6xpYT41rpeolf0U/KxYFCr1kQZ8p1SCD8K4rHx501WAj+LrLTPt48zrMkOA
         SSLmm7kdpR7X2bPn8m69XeaSHW8twxAv9X8xKsPMhs1AEcvRoItJfGvEzja1mOJu6FDQ
         4DJsotjVy3jciYi2W7AAoPqam1nAOWKxiJXu99JWZ+hGgLH5d2mhil3P8nCPX7iJsWJN
         DCtNC5tKnvcd0PkeZd6N7mnbF79Wq2E8DyxjoOrzbM3nj4x1hTYzR9RinOStWQSzGZ+9
         q23rCxaeMxRokdPFtYve4d3iQJvOQ2XSPtKfmDMKFs77YVvdUN8vgyfGRDbblf4DZwmX
         o6WQ==
X-Forwarded-Encrypted: i=1; AKwUvByfr3uD1ZyZ7prmLaZGF8knpb85f5HfAp1nZWunPBSl9/p5ibEnPhx0HBM3OIYgyZyIs2GQ9uKtsfttTs7M@vger.kernel.org
X-Gm-Message-State: AFuF++k921xD56xLhhaKhyzOiuF0VmvmTDsDAKfJl+f3sjKSeMGmcvBz
	I0ahnzOZajrI2Ia5JBP4efzhpy8Q9NiWmJfFWJu9E1xhuMDRmS5dN4M/SKXUqMDTpbIZnbl+/kI
	vWBDt6hI7VydG1BuDFyJHvV2/KOKaFvdaod7PqSWKUWxg7v5lZ2zv73R/ZVo=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1898:b0:6b6:962e:2e6b with SMTP id
 006d021491bc7-6b6fec78ad7mr8537481eaf.30.1788554019515; Fri, 04 Sep 2026
 13:33:39 -0700 (PDT)
Date: Fri, 04 Sep 2026 13:33:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a9b2b23.b5d4176b.238c3e.0006.GAE@google.com>
Subject: [syzbot] Monthly hfs report (Sep 2026)
From: syzbot <syzbot+liste020acfedc1c7fdaeb35@syzkaller.appspotmail.com>
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	slava@dubeyko.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 0 new issues were detected and 0 were fixed.
In total, 18 issues are still open and 42 have already been fixed.
There is also 1 low-priority issue.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  15709   Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<2>  11073   Yes   WARNING in hfs_bnode_create
                   https://syzkaller.appspot.com/bug?extid=a19ca73b21fe8bc69101
<3>  8068    Yes   possible deadlock in hfs_find_init (2)
                   https://syzkaller.appspot.com/bug?extid=e390d66dda462b51fde1
<4>  1078    Yes   possible deadlock in hfsplus_find_init
                   https://syzkaller.appspot.com/bug?extid=f8ce6c197125ab9d72ce
<5>  110     Yes   INFO: task hung in deactivate_super (3)
                   https://syzkaller.appspot.com/bug?extid=cba6270878c89ed64a2d
<6>  17      Yes   general protection fault in hfsplus_cat_write_inode
                   https://syzkaller.appspot.com/bug?extid=c0ba772a362e70937dfb
<7>  5960    Yes   possible deadlock in hfs_extend_file (3)
                   https://syzkaller.appspot.com/bug?extid=2a62f58f1a4951a549bb
<8>  1882    Yes   KMSAN: uninit-value in hfsplus_rename_cat
                   https://syzkaller.appspot.com/bug?extid=93f4402297a457fc6895
<9>  982     Yes   possible deadlock in hfsplus_file_extend (2)
                   https://syzkaller.appspot.com/bug?extid=4cba2fd444e9a16ae758
<10> 449     Yes   possible deadlock in hfsplus_block_allocate
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
