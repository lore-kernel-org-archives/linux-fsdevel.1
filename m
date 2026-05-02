Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FE728F948
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 May 2026 20:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777753943; cv=none; b=pxALXEzge+QFYzVxoIpEwabZPYisQpE8uAj1ZkkJuG2m18DpAnEM+kqJo3vAkr8HY+JHgC3q+DCHz9f8Fpvyt4RYOw3iKe/vLrzMEF0n+tlJ4n8NuwydS4xjds1xbcUu+Xn274PfiYFCu4bRyVYmt8ed0rQZDCCBwHI+aswzme8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777753943; c=relaxed/simple;
	bh=fzM5soebbLaVSgQFi42OpobkIwUFZ+ITtx0Ym9Iz/k8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FEjoCqTpbW7+oaWMEeaiFkHHX+X/eZnb9EwV0ZLz9/uYjd/grw/cl7iR9Dz97lsqqb1iFs9675B6vF3ZRHybVxOtBmHOuaxNZ8FJXON/cbyGOFCP4T6Uqd/7Py9yo+olLgUyzOiYl+pbQUxduJHEAJbwwjXSkA6V/psQWLBh9zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-6948eac3522so5071261eaf.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 May 2026 13:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777753941; x=1778358741;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pJ4hO4jhtyBNPLlNPf+EQQfmW6qosx1BBpRkZI7kIIw=;
        b=hwcttPCzoPxGiZcyyvuEL4qB+bfEDWqbdyrKWP9i6pib/c4Qu/ENJ/zJr2vYyCetle
         p1b8nHcKq+Ofz5I5WlD47pD/pWQLjCBFd0R7XmbziWBGnmcCt9Rfoo/PkIQY/eV1nJiA
         xTvcM04sFi+kba4/NvBh/5MTmH/W3xlNlV5IGIdbpHEaXSrGQsxxjY42y+e1IK3btNzp
         zHFc68/I7VW1gQZJv4xTDBeTHqNZ6LmjjbBNwEAFlASVSsWNMZHAuRErWkWC7FxtL8Ve
         Lx7xgh7zPghqXyz/HiHly+2SOYJMAFpvzefSS/BmpeYnpLQZO9SZJ6Owz2WoXJKubF8j
         93PQ==
X-Forwarded-Encrypted: i=1; AFNElJ/1oiGCA087SgNiT3iYrvkK4HfP3fVQnsCpsjkKo8qv4j6um1vQvFJgwLZWwJ1gs07cZYReQQUTz27JrYG6@vger.kernel.org
X-Gm-Message-State: AOJu0YycS2peAFTzFBwl5J5DGg84qNJhAEnFSw7uI/Jkvv1+EG//VedD
	hUhXb1cvfY0fvv/m4gLsfxrKdefVYlym19jNmhRvw3R79fEo7sMqoB9XLN+lvGH4T8P111SJogb
	PHAMxrZyZQCXr9tbmoLvcVCUHGmUmwL5xOqjvSAOLcvTqFrDLonWfx9eFXmQ=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2228:b0:694:9156:9b97 with SMTP id
 006d021491bc7-696979db841mr2117949eaf.22.1777753941155; Sat, 02 May 2026
 13:32:21 -0700 (PDT)
Date: Sat, 02 May 2026 13:32:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69f65f55.050a0220.312cd3.0025.GAE@google.com>
Subject: [syzbot] Monthly hfs report (May 2026)
From: syzbot <syzbot+list7f74c478019ad51454fb@syzkaller.appspotmail.com>
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	slava@dubeyko.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 3 new issues were detected and 0 were fixed.
In total, 24 issues are still open and 36 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 198436  Yes   kernel BUG in hfs_write_inode
                  https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
<2> 15599   Yes   possible deadlock in hfsplus_get_block
                  https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<3> 7793    Yes   possible deadlock in hfs_find_init (2)
                  https://syzkaller.appspot.com/bug?extid=e390d66dda462b51fde1
<4> 5413    Yes   possible deadlock in hfs_extend_file (3)
                  https://syzkaller.appspot.com/bug?extid=2a62f58f1a4951a549bb
<5> 1052    Yes   possible deadlock in hfsplus_find_init
                  https://syzkaller.appspot.com/bug?extid=f8ce6c197125ab9d72ce
<6> 911     Yes   possible deadlock in hfsplus_file_extend (2)
                  https://syzkaller.appspot.com/bug?extid=4cba2fd444e9a16ae758
<7> 99      Yes   INFO: task hung in deactivate_super (3)
                  https://syzkaller.appspot.com/bug?extid=cba6270878c89ed64a2d
<8> 43      Yes   INFO: task hung in hfsplus_find_init (3)
                  https://syzkaller.appspot.com/bug?extid=6f9eae7d87e0afb22029

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
