Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF2A38E8A0
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 04:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789101209; cv=none; b=eOwSshWGcGUDXaNiRUnHaH/6UJVxqrCg8zoti++T1IWGCzMMQsasYBoiNpzo6xVa8QL4zWCPgwBsTbTuMDtAk5x+DhqfxzEb01tv7tlc9igeiKb5IPaD+KEBbgE0s4eIrnO9SeqRAhpZmfYwvdM7hPtxxwSSRts1h2vIjBNEBIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789101209; c=relaxed/simple;
	bh=4hae50G/GGes/tVB10gTLmxoYhfL9TMXZA2h74iP+fQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jhEE8qtfDuaatTXpb9BP1TnRiOE5+7wCSyDuHTSapWEXJy6FT3NLE3Zt2TaEVsS5XEdlSr47YRxvpsnGVSczSGgMc1MUWJpFHUjR1FuL4LUCcG3Ine5NXLv/C7eJTQIGG9gGt65Dc0/jaSVQRGTEdLd1oLZuWebTIfRWxTliyL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e9e741693bso697430a34.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 21:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789101206; x=1789706006;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6dO9gVKfm4Ow8M7jqqsIrxuLQ6G6JdftOX0vSPc1Lb4=;
        b=etrguqMrKdVJFTp1LbH85puMHWgJyazijAtQcgC1jvGLfQWCVfVLvnuyN9Db5FDS2A
         X7yqfkYnKQr87jJA4t+gjIJIuC2vgeekbuhZJB+OnoB6i4f1iifECQs5Wf8EKZYVKpbT
         cLOdBYYIEwOUdr1BY5ssQ8WmU8K81EfNG5q3gKHOD5uQj7dclYfPxBd8YzHpvrlyyy0N
         lI6rtZ7SlK4dfoNnkGZEGl31fZnnNALTMbvy8a4R28BTJWr+Qxh69v0aMscLJ48t4Jvu
         N5IBa2+MBflYUuZu40tC3WTSUXiBgmCzrn0W/ucEJIgOiwgPQur8zjyvsrBgOKETeJL4
         iADg==
X-Gm-Message-State: AFuF++lK21DCTfijA5LwdkKaGOpEc9hM1iF/g7JbeayQwU7vAwBB3HBl
	ah6toTkn1Qjycebk0DP5cVoY3lC0f43ZImWNwB2sTUD5lwSF86wAEPzmYe2W/snTlH2nXroPaVH
	b8u5VOBV07EqadSuYGFv7kVvMkEmBNiI1mKZdt6PllmT236CAdFuZlPggYJk=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:c309:b0:6b1:2f12:6c0c with SMTP id
 006d021491bc7-6c0be3483b3mr2084207eaf.34.1789101206494; Thu, 10 Sep 2026
 21:33:26 -0700 (PDT)
Date: Thu, 10 Sep 2026 21:33:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aa38496.6e6c5f9e.28f11f.003f.GAE@google.com>
Subject: [syzbot] Monthly fs report (Sep 2026)
From: syzbot <syzbot+listec583fa4257875d46833@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello fs maintainers/developers,

This is a 31-day syzbot report for the fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fs

During the period, 3 new issues were detected and 3 were fixed.
In total, 46 issues are still open and 642 have already been fixed.
There are also 30 low-priority issues.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  10972   Yes   KASAN: use-after-free Read in hpfs_get_ea
                   https://syzkaller.appspot.com/bug?extid=fa88eb476e42878f2844
<2>  8730    Yes   INFO: task hung in __iterate_supers
                   https://syzkaller.appspot.com/bug?extid=b10aefdd9ef275e9368d
<3>  2032    Yes   INFO: task hung in user_get_super (2)
                   https://syzkaller.appspot.com/bug?extid=ba09f4a317431df6cddf
<4>  2002    Yes   INFO: task hung in lookup_slow (3)
                   https://syzkaller.appspot.com/bug?extid=7cfc6a4f6b025f710423
<5>  33      Yes   general protection fault in __simple_recursive_removal (2)
                   https://syzkaller.appspot.com/bug?extid=cc460646984184ad435a
<6>  26      Yes   KASAN: slab-use-after-free Read in lockref_get (2)
                   https://syzkaller.appspot.com/bug?extid=227dbc9afd022922d624
<7>  25      Yes   INFO: rcu detected stall in sys_close (7)
                   https://syzkaller.appspot.com/bug?extid=393022c13d02e1f680e3
<8>  25      Yes   VFS: Close: file count is zero (use-after-free) (2)
                   https://syzkaller.appspot.com/bug?extid=592c653b056459925299
<9>  22      Yes   INFO: task hung in writeback_iter (3)
                   https://syzkaller.appspot.com/bug?extid=1e3ff4b07c16ca0f6fe2
<10> 22      No    possible deadlock in uvcg_mjpeg_bma_controls_show
                   https://syzkaller.appspot.com/bug?extid=2b082cefcfb1439289ef

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
