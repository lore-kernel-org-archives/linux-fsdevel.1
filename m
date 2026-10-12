Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B1C48A2C7
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 12:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791808421; cv=none; b=PN4uIz1Tk+EgFeT2MxQupkj9LzafxIe1gRklCyeu5OGb6SSjomtcw4w/wkG7deeIjV7A+GVKWSRX5UYJQUE9M86WNnmrO8HavnhiAxQb6+0Lerl5RF6z8FPwbRKgqtqjxXoSs2uUxZ/NOKrHmMmssZV4yLFJquDdA90HB9FSE8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791808421; c=relaxed/simple;
	bh=2VPiXw1q3kR54sFKHzIp1fFBiFplG0qbis1UdmRy8ow=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IRYWMooJR9mmxC6SL8BMKYMhEl/Qew5TlfgkTJlsbcfK52roLaNgdO1KpyhQaRDePaD8u43S7n/malxV3PlQiZXhfX7xg4m9LxYv2Z/C/K5iRZXBLLu/UUhbYeADp4lx3j+CROaujSQOW1VdUP/i6ZxPx2H29Hg2Q/yxRNY1xfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-82285c64cacso3035567a34.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 05:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791808419; x=1792413219;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZkkVxmXihGSE9ad18xf43HJ5yD+WjmR37orxM5dMJfg=;
        b=E7QSVk6CyIEKdjiXCl+LEVLgk7JemMLPPVxGT+tC0Dyrrcl7oFzw1VTccMBG8CEJec
         NGETuJr9Lk8diRFGox/85km9rY1cgGDHG1xXZ3pPv1Eanix3kyppOxJaNwbTfrkQKyV7
         LMOO+H0rt0VDsnW5qi14WV+gMwYxShhmrwPDZbzTNxFvIMxoWlTjJMot9bZtWwFXA8hs
         MSJzSV8pddegXoR05YszFOvHntDlJMAjgktVvFjMx4Wx0+ZWyTe/XcbRP4MJBF6JptrL
         nWJE/7coygZQD2YM5lCj27iqnnsanRdPPbB1ijnAnvUgWD/o7yBoKpiOeltTtTKjJoCq
         K3Eg==
X-Gm-Message-State: AFq9FYJctIBbxpllqdB2Azok8NFrZvWR3whUxfwdK7YPJ4Bu1wh+NULK
	Y9S+a/QdE/NfHt7n/OjFA5HFA5kYE9YSd3sIZhBEZXNbYX4GtNf/ZCvfAfXNCAXR0quMWjs1rk4
	EBn2hfynRI/DNBVR4P06uJN6JZiL9h668uW03S6cqe9FQPt9rSg0HLryOe2w=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:f8d:b0:4f4:f3c1:72c7 with SMTP id
 5614622812f47-50c58042ff6mr7524732b6e.61.1791808418853; Mon, 12 Oct 2026
 05:33:38 -0700 (PDT)
Date: Mon, 12 Oct 2026 05:33:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6accd3a2.0e5b5d80.2c029c.0575.GAE@google.com>
Subject: [syzbot] Monthly fs report (Oct 2026)
From: syzbot <syzbot+list927011c44246282e30bf@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello fs maintainers/developers,

This is a 31-day syzbot report for the fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fs

During the period, 2 new issues were detected and 1 were fixed.
In total, 46 issues are still open and 645 have already been fixed.
There are also 31 low-priority issues.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  11432   Yes   KASAN: use-after-free Read in hpfs_get_ea
                   https://syzkaller.appspot.com/bug?extid=fa88eb476e42878f2844
<2>  8798    Yes   INFO: task hung in __iterate_supers
                   https://syzkaller.appspot.com/bug?extid=b10aefdd9ef275e9368d
<3>  2037    Yes   INFO: task hung in user_get_super (2)
                   https://syzkaller.appspot.com/bug?extid=ba09f4a317431df6cddf
<4>  2004    Yes   INFO: task hung in lookup_slow (3)
                   https://syzkaller.appspot.com/bug?extid=7cfc6a4f6b025f710423
<5>  79      Yes   UBSAN: shift-out-of-bounds in befs_check_sb
                   https://syzkaller.appspot.com/bug?extid=fc26c366038b54261e53
<6>  28      Yes   KASAN: slab-use-after-free Read in lockref_get (2)
                   https://syzkaller.appspot.com/bug?extid=227dbc9afd022922d624
<7>  24      Yes   INFO: task hung in writeback_iter (3)
                   https://syzkaller.appspot.com/bug?extid=1e3ff4b07c16ca0f6fe2
<8>  9       Yes   INFO: rcu detected stall in kswapd (4)
                   https://syzkaller.appspot.com/bug?extid=f886305df0acc6fa097a
<9>  5       No    possible deadlock in uvcg_format_bma_controls_store
                   https://syzkaller.appspot.com/bug?extid=50560f9ba016e97e2023
<10> 43      Yes   KASAN: slab-use-after-free Read in filp_flush
                   https://syzkaller.appspot.com/bug?extid=df868600fe111c5ff79f

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
