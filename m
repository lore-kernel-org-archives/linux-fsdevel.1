Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515637;
	b=L6HzeqVpFQwlkI9U9bFNrnHnjEY5vwskdO5nxWxeDlH8t/TpWs/BMPlaK5wEQDbR9BIX
	 wd7E39aVYzPqTWRbpkA0VTIEgDpelbg6hUSOcUxUrTmylRDIhRc1yC2/9xuksbWWYLvhk
	 V8sy3JtlQN9ti3IsCEHqc3ruCa+P+l+qJlSbL6j7WSl2uQfyxnm15n+/j/L9m9LxPI3fX
	 cr4PlP01cUb56B4xmnckqBWNoAXW7GbaGhsO2QrHTDX9ztORDFdkc8UljpM2lJc67i7M8
	 zjwd85CYApCS6gMdg4Ym6GiyJM4BI/DC/DZNdlrnGxRVVHcZtMWPxhKVko6nexKGlJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515637;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 MIME-Version:X-Received:Date:X-Google-Appengine-App-Id:
	 X-Google-Appengine-App-Id-Alias:Message-ID:Subject:From:To:
	 Content-Type;
	bh=gBrVAJTdCZD3/za9gWbaVLKgy+2UrOYir7j9/p3Gzwo=;
	b=vFOqtJLdOVGFRW6oDiBSsGQDx+il1uxdId65cOIuMPl22fHMUi5D6o0X/NIi89KGkvL4
	 XUnyVLHKDfeqS2ekVhi2Y2kb2kmuZFaH0HAd041msu+N3rIUpZZrIhJBb0YJ5/fNQys9N
	 hf3leat9nYS00tYMNlZMosVjpXmlDk7mU+gse6IVU+/0CSEOdzREgmH41+2zNRnq5QL4N
	 ar4Lo+wn66PKPdLDaNau6KP95v7z0Sd9FuN2UHx8zWFavhiNDdanZWaPJ9pj+aImw1cyp
	 IcUcq/lVEpiMXuLK+ogsOCZdagO6NLhkZlLp8uWytH4gjBTKt1NJkCHY9umzMRlDOcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC7F606A321
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 20:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DC7F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4c734afb8deso238816b6e.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 12:33:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794515636; x=1795120436;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gBrVAJTdCZD3/za9gWbaVLKgy+2UrOYir7j9/p3Gzwo=;
        b=hJINjrTECynHQ84hdKeWWDus/FS+6jzwC+0tGzqyW6o9Zkq2aP3wZhOHLj9417Iaze
         SAxteKwXl4Ou7QWD585oAtSGCDTUCS01jyPyKX/x17/X0ZyOX472YBOHGWj8RJGKowXE
         d1FNsiPF12VTSjuEdus7FW+xQMQP6V+WJuMN3g2Hhb/S8hYqGX4tswZOxXVZvDbQLKqE
         tRKK7ahp6bhdFj1nyhvjnOVO73g3zMz4qcfbBAgcWlcPxAFtHAT0Um+rrfYQi9Om3GBn
         7g93D7IFERaiz2iA7UzGoi8COZXvgHF5FhWVF5F3dQbjDYLk+F3Aoiq1nlIcBILc3v9b
         +06w==
X-Gm-Message-State: APuU4Z9NXDSk91r3fHTZq9HVlIfmg3lG11QZy32mwe2HtY6pMR5i70xO
	i6thcqfXzVdnUnmwZuOand/wYO8xavw6qe74jr9BVkfZDzA6t3U2tFy4DFggNEbgJEqAEYzw7yH
	HK25+XDvt8wrxmVbtSe5Ov/rjsbLBGGliGPQNISgdcCBDDOj7PPDmX3yyjs0=
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1645:b0:4d5:27da:a496 with SMTP id
 5614622812f47-56e65c55d18mr343213b6e.48.1794515636371; Thu, 12 Nov 2026
 12:33:56 -0800 (PST)
Date: Thu, 12 Nov 2026 12:33:56 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6af622b4.ff6dfe28.557e.0019.GAE@google.com>
Subject: [syzbot] Monthly fs report (Nov 2026)
From: syzbot <syzbot+list2e977b7855a334fac744@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello fs maintainers/developers,

This is a 31-day syzbot report for the fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fs

During the period, 2 new issues were detected and 2 were fixed.
In total, 42 issues are still open and 644 have already been fixed.
There are also 35 low-priority issues.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  12025   Yes   KASAN: use-after-free Read in hpfs_get_ea
                   https://syzkaller.appspot.com/bug?extid=fa88eb476e42878f2844
<2>  10568   Yes   VFS: Busy inodes after unmount (use-after-free) (4)
                   https://syzkaller.appspot.com/bug?extid=d569e274f46ca86f78fa
<3>  8841    Yes   INFO: task hung in __iterate_supers
                   https://syzkaller.appspot.com/bug?extid=b10aefdd9ef275e9368d
<4>  2045    Yes   INFO: task hung in user_get_super (2)
                   https://syzkaller.appspot.com/bug?extid=ba09f4a317431df6cddf
<5>  37      Yes   KASAN: slab-use-after-free Read in lockref_get (2)
                   https://syzkaller.appspot.com/bug?extid=227dbc9afd022922d624
<6>  28      Yes   INFO: rcu detected stall in sys_close (7)
                   https://syzkaller.appspot.com/bug?extid=393022c13d02e1f680e3
<7>  26      Yes   INFO: task hung in writeback_iter (3)
                   https://syzkaller.appspot.com/bug?extid=1e3ff4b07c16ca0f6fe2
<8>  11      Yes   KASAN: use-after-free Read in hpfs_bplus_lookup
                   https://syzkaller.appspot.com/bug?extid=8debf4b3f7c7391cd8eb
<9>  11      Yes   divide error in qnx6_mmi_fill_super
                   https://syzkaller.appspot.com/bug?extid=6a0633f11d3fb88860bf
<10> 10      Yes   INFO: rcu detected stall in kswapd (4)
                   https://syzkaller.appspot.com/bug?extid=f886305df0acc6fa097a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
