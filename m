Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C120F5CDF1
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 04:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780461145; cv=none; b=EfE/GUD4PFM4T1fCL5rkOB/6n25iFX+u2a5bA2LK/tOENwiG7bJKYA7iX3Eoxht4kCBmTA1qJikdlCZ/aBZTNs+8PfT1oPrx9zRHGEklk/IWTFX7IAh+2fn8d9nizN0Y8g9zgdVZCHFHE2DjvXBzDqJaHzeDXjjb5uDPRt8KTrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780461145; c=relaxed/simple;
	bh=XI7TmO2QDQdhsuYeMfTRcxA9S2o+sWuxB+0gxSaMkGA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RuNmF14MUBy0cOB0Kmt9hyo/mPwsXf4k5Dcq+DPMKED6QcA/O54+tshhYHQu9x1JBj1aF6dhLcRNHkMZq5QN9S3mkoSI72ByUeVQxasB7fb2JzUQIT9EKMnvtUo9UXNDiySjbBA/SpAEHq09mEqA52GUCkL4v9WOWx1dySRQork=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e6b581e60cso3639073a34.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jun 2026 21:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780461143; x=1781065943;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mS/h0dnltyibn1xsFjI7xN0bPZXbx+0tcM0Fv7wMtko=;
        b=Dtwi0FuBLoZKuJjLATJU27qT22s0xPWT2gvYibMxyZVeuZ+y0lJV5zrlEL5vNEB8bS
         AahUA8THOSMg9H+6+U+C7rbSfMjjGTfKI6SpBMWR/xSDDBaUfsISAiETfAOrWFDP+UUS
         BIZai7fuPZ6GoLOhGaVbV3ahMqFezmHGVXvyFPzKKFzXOZq9ApET2oQt/KcAm2pq3xrD
         Tzwp6RnY+bc7RoDPdlC0fA3/hmSjeSEqz8ppFgvTuVyaM1eVsDacez76xdlwdLFXWkMf
         63DG5RFXHFpEOUtFDyDaoJzEOJQTruOYUmHxHgsSb+lNCT+V8MekA7RMUwjiAIR1Kq+B
         wkDg==
X-Forwarded-Encrypted: i=1; AFNElJ9R1/CVLn78zNf6whJB1CbopI0v0XXq5fv39dZ1dgvjrtyZw+LO1Cbh+kCwlAPcTYSVJlAWIISbeXlLjK9p@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3brhTPzfwUxIYOUHvWh9ciMjp+gfRk53c/nIq9LJULjnjfQOA
	AkQe1/9j5jwbd5Y0EuRvJvykDwC63fihJ67M3BKr89dXfzdb5musKIXIOTlOX+G+NA5Yv7Xzl3T
	YDoFotwpnfkqDceipwJm15YAPGpBsrqf9XDOW+HIXGxR8DSJlH0q+Jpbydrs=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:134b:b0:696:6440:9e2a with SMTP id
 006d021491bc7-69e47f6daddmr1104033eaf.29.1780461142983; Tue, 02 Jun 2026
 21:32:22 -0700 (PDT)
Date: Tue, 02 Jun 2026 21:32:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a1fae56.3b158e77.2846f8.084c.GAE@google.com>
Subject: [syzbot] Monthly hfs report (Jun 2026)
From: syzbot <syzbot+list9a363b42b767af0beb33@syzkaller.appspotmail.com>
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	slava@dubeyko.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 0 new issues were detected and 0 were fixed.
In total, 24 issues are still open and 36 have already been fixed.
There are also 3 low-priority issues.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  206798  Yes   kernel BUG in hfs_write_inode
                   https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
<2>  15619   Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<3>  10716   Yes   WARNING in hfs_bnode_create
                   https://syzkaller.appspot.com/bug?extid=a19ca73b21fe8bc69101
<4>  7926    Yes   possible deadlock in hfs_find_init (2)
                   https://syzkaller.appspot.com/bug?extid=e390d66dda462b51fde1
<5>  146     Yes   general protection fault in __hfsplus_setxattr
                   https://syzkaller.appspot.com/bug?extid=bc70a12e438dadba4fb4
<6>  104     Yes   INFO: task hung in deactivate_super (3)
                   https://syzkaller.appspot.com/bug?extid=cba6270878c89ed64a2d
<7>  5706    Yes   possible deadlock in hfs_extend_file (3)
                   https://syzkaller.appspot.com/bug?extid=2a62f58f1a4951a549bb
<8>  1857    Yes   KMSAN: uninit-value in hfsplus_rename_cat
                   https://syzkaller.appspot.com/bug?extid=93f4402297a457fc6895
<9>  433     Yes   possible deadlock in hfsplus_block_allocate
                   https://syzkaller.appspot.com/bug?extid=b6ccd31787585244a855
<10> 6       Yes   memory leak in __hfs_bnode_create
                   https://syzkaller.appspot.com/bug?extid=98547b0428b6a6a3467c

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
