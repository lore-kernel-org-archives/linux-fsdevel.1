Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2691A364E84
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Oct 2026 04:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791261209; cv=none; b=pSH+q6/r26l5v4y7Yygg/Sq4R1dL8k4IDmRTmmhAMQEjo4P185+TVlsVTzElumgYHlQaE6eNhL7n/jGbs2E2uAyu7I1F0XjlrPfrKnQvfeTOYN5s5pjERn5vi9T+Y5Rd3Axk4PGqiF5TjC+wnJjsFONVIhLxpYqFl8E+HfXhnNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791261209; c=relaxed/simple;
	bh=5dZjNvC2sisZFJYerRW4F1x5Yqt2ig6k8HEg53/MMFM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HSd6Vf9vMsIglWfGoThvYrsMIttAKrBoQ2JoziofTdFVQSzxQkq5aHmgWGJ/3+Nc2C+XHZKaNA+VEQfjyRPNj4t8S9nR3LgAF0s7FFV+gh/D9osUL1jXO0kegCXzXEyfipMoh+HPHT0qTlhQLm9A1paflpjgck2todIK69lsygE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4c734afb8deso3698971b6e.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Oct 2026 21:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791261207; x=1791866007;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W+VsfkruupwF/tJ7Mo0eOSlqC1GfpHsM+YP8iOXXzMw=;
        b=Yfvntr1FlFkqSfTiGXNjyVEgaXQK/F5j4rOTJYXdmwN8WTjO3EO3KT/ZOTqHz9PHGf
         cnl05ItKZEg8gaujMRVSTS0POlxhOeTFc9GJhFooOKh4Zmecvy3t3D/Gf+7sycqiXG6T
         P2P+uRwKTmCdyzUoFgtdrdkuwDjOQuEDfZ14cSduurUQjZ5mfSAI4yUsSAz4u8yazufC
         lClU+NOqpdlB0Em4UCNTnrc9wADfB0kJhLkDf0W0pMOCTJyyVYloATebcPu+q1HETphJ
         G2R/YSNGtuLyuAV/BHh34OhDx8epjwI1HorhYVGO2wDIr+EpfnaxB7HPPfSKupVhaT3y
         9ljA==
X-Forwarded-Encrypted: i=1; AKwUvBz+OCiLirjZUBR7tXDfxCXazznpABbylXAbJcEqd6lBwipU3sblpI0VePuZoNy0MCxeqc1ruhmWJCnsafKu@vger.kernel.org
X-Gm-Message-State: AFuF++mGInU1p7usIzEfXdx857Fvbm6gY3AYtwsR8Ge86GduXexo2vVi
	jRXsZPHv7sYYlVdCpTV2F0zW5QhObyIBrUtzVFGw8LozhVUxVzRmOD0A4KVybZRqTIgAafFJvg3
	pREq3cOly3RhLqJBpqJHHCgL3CLjSyGAraH7glm5Ab800F8NgjiB9v9dPb3U=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1485:b0:4b9:e88f:89dd with SMTP id
 5614622812f47-4fb415cd589mr282733b6e.43.1791261207144; Mon, 05 Oct 2026
 21:33:27 -0700 (PDT)
Date: Mon, 05 Oct 2026 21:33:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ac47a17.598348e0.18b15.0008.GAE@google.com>
Subject: [syzbot] Monthly hfs report (Oct 2026)
From: syzbot <syzbot+list398bf1d226810d546c6e@syzkaller.appspotmail.com>
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

Ref Crashes Repro Title
<1> 15760   Yes   possible deadlock in hfsplus_get_block
                  https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<2> 11266   Yes   WARNING in hfs_bnode_create
                  https://syzkaller.appspot.com/bug?extid=a19ca73b21fe8bc69101
<3> 111     Yes   INFO: task hung in deactivate_super (3)
                  https://syzkaller.appspot.com/bug?extid=cba6270878c89ed64a2d
<4> 17      Yes   general protection fault in hfsplus_cat_write_inode
                  https://syzkaller.appspot.com/bug?extid=c0ba772a362e70937dfb
<5> 6037    Yes   possible deadlock in hfs_extend_file (3)
                  https://syzkaller.appspot.com/bug?extid=2a62f58f1a4951a549bb
<6> 1887    Yes   KMSAN: uninit-value in hfsplus_rename_cat
                  https://syzkaller.appspot.com/bug?extid=93f4402297a457fc6895
<7> 1059    Yes   possible deadlock in hfsplus_file_extend (2)
                  https://syzkaller.appspot.com/bug?extid=4cba2fd444e9a16ae758
<8> 428     Yes   possible deadlock in hfsplus_block_free
                  https://syzkaller.appspot.com/bug?extid=8fae81a1f77bf28ef3b5
<9> 19      Yes   memory leak in __hfs_bnode_create
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
