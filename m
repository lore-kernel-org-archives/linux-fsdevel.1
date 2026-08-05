Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077FB35E1A2
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Aug 2026 00:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785888038; cv=none; b=OiszmQfnlrB92m22GMDru/etKyiyHPzbb3LrFk4tODtEqjySHNKUeb89Mkhb7MTd3gollJl0yANZZ2wWWt6r5u5DatG8GmlTjmSDSD9a7PmaImKWm+oF9upCLGf4JcOllb8rNfP3+4rCjpCSx8FPHRvbskt5Kx78wVb++xRAzpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785888038; c=relaxed/simple;
	bh=de2tnZ+iyA8YieRgtPNjnKTAzezy4RkTdSn8oZSsna4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Yq6URB3BIfgp6S6ZVadsqV0ahL5eKaLwLT29MUCGhoQxmQKena9lCo5zwQokASUVZ8T8uAq5PLDiZtibmI8Ze2updBMkI6GVD6XjH2PHRfZGF5KvhAzUfgC6Nye3ODFYEpgwq1uid9FWP7X2aAVSvl6V4TNbvQuwdbyI841hQQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4afa222912eso303451b6e.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 17:00:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785888036; x=1786492836;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Z7e1xPJk7jbtKlYZ42AM+47Dr2yEzSJGxvUXYO3zug=;
        b=dTWxFUw2j6qZaomiao5iuOgMafA9YNr8Ko7e73tm2mRyh4WlNW2pN9m6+E8lVCO074
         Rzkv2LuO+j+5FrOHUTezS1ch3F8o954qnFpc0W1niZMuSWD2yYjyonxq+2ElcWeEBTEu
         gI6ifadqhKbixsHciOOrb2IaS0GG2ancg+b2gbSuCWKMgSaHvusVYt6NypnVBL2gZ3m3
         XdiEDY3Jb7/YWR2lowWdcDVs7nmyv1NNAKlkdPgXpklmcUJ6LjoZPMonDgWUPShg2xNi
         p5wWQW3vCRdmYGASIJvDU65WkcdtCI4gb2gx4vBO2NTMpYgpZRepLwNJy4Rh2RHqQlGQ
         piOw==
X-Forwarded-Encrypted: i=1; AHgh+RqyAmEVsEkQBSOL45aBuNYRSbPNvIlzX/1ujN+/c9StzIWiRh0OoViIEbxXEEB3fcTAEKKtRp8W38HWgJjy@vger.kernel.org
X-Gm-Message-State: AOJu0YyrYMxjpq/cflx+9J4eCGmmLFz4pbLtrsZKNbKCltw+PRGa8EM6
	u+g+kL7BvUDVDa1EZHFbljjXuN0u8PdGr+/Tz6p2gKT9m3DnC+meUX3dhimZDqn/jesCUGYvlND
	Lp8XfCIfCrQ3/VfuOS9/xAw9d5TIjqiUUE7m3tGchkIVWcienSEaGnJoHfLU=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4cc9:b0:6aa:da04:b581 with SMTP id
 006d021491bc7-6ae96f2a816mr1581103eaf.27.1785888035720; Tue, 04 Aug 2026
 17:00:35 -0700 (PDT)
Date: Tue, 04 Aug 2026 17:00:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a727d23.40259c87.584f4.04d0.GAE@google.com>
Subject: [syzbot] Monthly hfs report (Aug 2026)
From: syzbot <syzbot+list8b2ddb67403d41193582@syzkaller.appspotmail.com>
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

Ref Crashes Repro Title
<1> 236948  Yes   kernel BUG in hfs_write_inode
                  https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
<2> 15655   Yes   possible deadlock in hfsplus_get_block
                  https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<3> 10916   Yes   WARNING in hfs_bnode_create
                  https://syzkaller.appspot.com/bug?extid=a19ca73b21fe8bc69101
<4> 8003    Yes   possible deadlock in hfs_find_init (2)
                  https://syzkaller.appspot.com/bug?extid=e390d66dda462b51fde1
<5> 5804    Yes   possible deadlock in hfs_extend_file (3)
                  https://syzkaller.appspot.com/bug?extid=2a62f58f1a4951a549bb
<6> 1876    Yes   KMSAN: uninit-value in hfsplus_rename_cat
                  https://syzkaller.appspot.com/bug?extid=93f4402297a457fc6895
<7> 434     Yes   possible deadlock in hfsplus_block_allocate
                  https://syzkaller.appspot.com/bug?extid=b6ccd31787585244a855
<8> 9       Yes   memory leak in __hfs_bnode_create
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
