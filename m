Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDEC285CA2
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2026 04:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786422749; cv=none; b=Kgs78z+/NxxuwUqL7v1P1/rfmfeyxzTpCkhlhEIqL9CwqatUNBgaWZE+ZPLbpVCH0w/XXRM9cbnxuPytRPaE/MW4ZawOEmbmorAaoNcDjDWuCGVb68icOhMxMhEO/I4wX5DIEqdoaloouU21SrnJ782R7aNeTskW/L1b+3ci7ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786422749; c=relaxed/simple;
	bh=7tsF3bhriRgTLVc7XkHR3UDy7okFEmbuWfjaey39zpY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mf+TzezSIFfZzzAOu/RiGrBEA+aVI9+4dDi+uBdrFHx+SW3NMW823N7mntgXggLi3oL3+WLExIXpxlc779216fs/6UdkC6198nv9YuxobRg1BjGHP6MNjWTV4YXpAdSDCeMoZPPcSF+o/6JXK/c0Db++Kyx6Ri/2Yiwz1EiIe+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4a45997664aso476642b6e.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 21:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786422747; x=1787027547;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Emz8++jbQppo3JzvJo1XWhlrDgRtz8rlCIN7+DNlLgk=;
        b=c8e7ABYLi3HH6VtbsAlVlAMKRvYflhDZacb848bXhpbdSJUXZzpED1DpvEi5cyuMgZ
         7LSeJi2lTpjZYksJxBba9rzdo2RTm5wFLRQpcqckFM4RHjP+6EqJC1vUjqYVdz2+Bxe6
         93OwIpw7Adi2JoWN7U6zB0dtzjTdQJiOUc1fsA1YfUUnBZi/gHmDSMyvjtHN9uVw4ZZu
         +XYMmQ0txFR+TfJt172LcTu+q7bq2njvrk+ai5KzC/GHz9HowWM6ZiTuQaBIrExdZK6X
         RnQvgAW9XTbTH5CzZZ8bCtAMQeMY9RhJ0MG81EM+UDHuaBYVUtZjPnDDzOQx7K/7EMwJ
         zs4A==
X-Gm-Message-State: AOJu0Ywac8JuM4qHFxzV03a4xisivuDrJa2F8/8GfjN1Na3tr0e8YUpR
	FUs+/+LhIbU5Ba/Awly9Qp0enDw+KjanBMDgmzlzkxnrBZVrX+tnPxPd3qCqAqTRGBq5BUmRTcq
	J0kzqIuxeRgGsuUwsguer/1hQR5THBzzhzc+cW00xdMhmyVJuGMcXOjEcbns=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a13:b0:48b:5dcb:85ab with SMTP id
 5614622812f47-4b1fd6a797fmr393807b6e.8.1786422746987; Mon, 10 Aug 2026
 21:32:26 -0700 (PDT)
Date: Mon, 10 Aug 2026 21:32:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7aa5da.9c11d2ce.289b96.00fc.GAE@google.com>
Subject: [syzbot] Monthly fs report (Aug 2026)
From: syzbot <syzbot+list94bce93db358929bf37c@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello fs maintainers/developers,

This is a 31-day syzbot report for the fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fs

During the period, 13 new issues were detected and 0 were fixed.
In total, 51 issues are still open and 636 have already been fixed.
There are also 20 low-priority issues.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  8671    Yes   INFO: task hung in __iterate_supers
                   https://syzkaller.appspot.com/bug?extid=b10aefdd9ef275e9368d
<2>  4270    Yes   INFO: task hung in synchronize_rcu (4)
                   https://syzkaller.appspot.com/bug?extid=222aa26d0a5dbc2e84fe
<3>  2681    Yes   INFO: task hung in filename_create (4)
                   https://syzkaller.appspot.com/bug?extid=72c5cf124089bc318016
<4>  2029    Yes   INFO: task hung in user_get_super (2)
                   https://syzkaller.appspot.com/bug?extid=ba09f4a317431df6cddf
<5>  1999    Yes   INFO: task hung in lookup_slow (3)
                   https://syzkaller.appspot.com/bug?extid=7cfc6a4f6b025f710423
<6>  212     Yes   WARNING in path_openat
                   https://syzkaller.appspot.com/bug?extid=be8872fcb764bf9fea73
<7>  16      Yes   VFS: Close: file count is zero (use-after-free) (2)
                   https://syzkaller.appspot.com/bug?extid=592c653b056459925299
<8>  16      Yes   general protection fault in __simple_recursive_removal (2)
                   https://syzkaller.appspot.com/bug?extid=cc460646984184ad435a
<9>  13      Yes   KASAN: slab-use-after-free Read in lockref_get (2)
                   https://syzkaller.appspot.com/bug?extid=227dbc9afd022922d624
<10> 11      Yes   KASAN: use-after-free Read in hpfs_count_dnodes
                   https://syzkaller.appspot.com/bug?extid=7d1563afac6cb196a444

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
