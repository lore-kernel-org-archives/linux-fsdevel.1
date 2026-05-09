Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757E318A92F
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 May 2026 12:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778329954; cv=none; b=oxI1Kxqg7357S/46DGPAvCaBXsOdDQCt/b1prf8ppcSJnZj5cPf3JPcP8AOcgZ+/oMC+4fUWDZMQn8+bfovbEzdlUsptLkXfuFcNAjLZ4uAM3y0//t4NsnFe5stLkr9gcX3jw0JC7aNB5/IIStEfAFkiI3A9P1B3DJaIvfAAdkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778329954; c=relaxed/simple;
	bh=RO2hh1rnR5VuDsbrlb8qjDJCIioQzd2h4AJ4trizovI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WFcpgi+Qjll6yqxDtDmjyfE/Nth1ca6DrBYhLi2yV9k1e5vV3oNV9EhoebvyK2wXOXak3pvjgbCkPk9Rl/VLuzybKCI47g+ByYWxd7JLVnRxMxiiv7GicGq3jJIb/YhpQ10BKTcv9XExE/xF9GdK5ZO3snU5WsMlNysOlKTarSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-6948eac3522so4812154eaf.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 May 2026 05:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778329952; x=1778934752;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1HKktugfmkP+XVMIhptO8vSwmLYWh7bwU9PyWEJcOw0=;
        b=Ci4SdROLD0DhHZY2BEcPsbCEkPU0aMK/zfq4WFJQoXumoxd2tOzhevSevVrcy1G1GF
         MkA/Kb7O7KIod8rWdBdszr3YVCkkOk03LpUJkXfGV0f1qwuOBOKpDxME4ahXfNReNKhQ
         ulLbwpbSD3pBAFVUtWja/HDSv5zn0maVyvbPuWRFn/9HAp7sdwWCh6LWa7L84HNdjUvH
         EiAgDur9GD6bsX1eDAFXpP573rq9qjgKh32cISosqkpXN+aNJEd2uP5MD/QzOSlP+61j
         TLqr+EOMSgdJa2OJLGanPVuCFHigAl6gkcr/yRkyqgSdJoPUYNr4b4/u7aTAKkQWI2vj
         eNLw==
X-Gm-Message-State: AOJu0YzbSPb++bPbQYzfF58Uh/dah8/cq1ndWaiRK5XIo31qpVk+WYUa
	xuzNmV3vlUQdJeIDPW8JjbMm33SQ6cp1ryCL1vGI8ZiRkgBBgJvCBWEIUVaWUz5FSMcAfp71WwY
	zMPqXFX1dQotDsQXgZB94KpJwkkdjewvi5vaWQ5vwWqmrduP5RzVtzwkRLx8=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:55d7:20b0:68c:2ff9:522c with SMTP id
 006d021491bc7-69b25b179d6mr2464921eaf.2.1778329952548; Sat, 09 May 2026
 05:32:32 -0700 (PDT)
Date: Sat, 09 May 2026 05:32:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69ff2960.a00a0220.1c3806.0008.GAE@google.com>
Subject: [syzbot] Monthly fs report (May 2026)
From: syzbot <syzbot+listf8b7e670eff9fb74ff89@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello fs maintainers/developers,

This is a 31-day syzbot report for the fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fs

During the period, 1 new issues were detected and 0 were fixed.
In total, 53 issues are still open and 633 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  25470   Yes   WARNING in path_noexec (2)
                   https://syzkaller.appspot.com/bug?extid=a9391462075ffb9f77c6
<2>  7449    Yes   INFO: task hung in __iterate_supers
                   https://syzkaller.appspot.com/bug?extid=b10aefdd9ef275e9368d
<3>  7277    Yes   possible deadlock in input_event (2)
                   https://syzkaller.appspot.com/bug?extid=d4c06e848a1c1f9f726f
<4>  7009    Yes   WARNING in inc_nlink (3)
                   https://syzkaller.appspot.com/bug?extid=2b3af42c0644df1e4da9
<5>  4856    Yes   INFO: task hung in path_openat (7)
                   https://syzkaller.appspot.com/bug?extid=950a0cdaa2fdd14f5bdc
<6>  3335    Yes   INFO: task hung in synchronize_rcu (4)
                   https://syzkaller.appspot.com/bug?extid=222aa26d0a5dbc2e84fe
<7>  2672    Yes   INFO: task hung in filename_create (4)
                   https://syzkaller.appspot.com/bug?extid=72c5cf124089bc318016
<8>  1991    Yes   INFO: task hung in lookup_slow (3)
                   https://syzkaller.appspot.com/bug?extid=7cfc6a4f6b025f710423
<9>  1936    Yes   kernel BUG in __filemap_add_folio
                   https://syzkaller.appspot.com/bug?extid=4d3cc33ef7a77041efa6
<10> 1617    Yes   INFO: task hung in user_get_super (2)
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
