Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7274908C5
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2026 22:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789598409; cv=none; b=tp8Et3NKz1j2t8RKT9xxSolgd2TmqXyen7mEPL2FMpIkToqTOMzzCyRYh1r2cQJ5zpoLeSPI6I5v/R6bcnDi+K02bWwvOEeJknfYHmbZSm4b1t9x8WcwS+naDDyaR6YWwdREFdgj0GadGs4lqcPY96LcTjUj6WGi0l3RcDUIIO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789598409; c=relaxed/simple;
	bh=aY0C3UZNWISVo+SEYdMA+dpLR2TC50hIsVNTH/1tMWI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QIEW3jgM/fY3Q119uX9I7ECqRzllqS2F2T6w69eyCkfkHSk/ITlsMAsVNsSf+uYFopTgcrXGUrOHvvT70evE5NgBvWc5vEPSTP7FH2cqJc60Cujxdvsze7XUzoIo1OW0HwjEj85qgwzz5Y3UVXKYWwMOh1/RVqsS1GCma0ybuhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4b5bfffcc2dso172126b6e.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2026 15:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789598402; x=1790203202;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eWbhpWk71ccWdwuOVmq402NHgmE8BaqjoYuvIsrzF3g=;
        b=gDrAuyuSjM3cI+L7wKHK6gWPCm8yjSwv1/JkhiDUVfqZqB7rdk9D35NDNYAGTbR3B+
         dslatxyVoXn/5KmjhRwbd7FBO2hSsBAaXIqqtWY05PoMpab9eiUJKc0dm8iXVd6CSJdH
         6qtfz0l5wB2nUbyzv5Svi/Bh67qo1n2ibp12UtxgO03re27WYM2uPeh1CTkrKQEC5mX8
         S+Hz0pIZqu7d38syeipEib1bv3D0ummu0ptL7n5wyv1w7To224P7JMt/v0xRmDRfQyLx
         HkHsMVIU1Ltexp2+qBC1ZUzstpoLZhxzdbQ7/cKc9CJ2QLGinrDJi6IUKAWaapbO4f4Q
         Miag==
X-Forwarded-Encrypted: i=1; AKwUvBxqFbG05hhAaEQtAUgCwVSe6TeAktWwW3ODsHHDVVmGwW231syJwAeoXUyGEbCT2pLuMmB6xLpQfzhNl1b6@vger.kernel.org
X-Gm-Message-State: AFuF++nM4fh+zMWZBE5hVQEW5xDlooU/81tAyfjvyR33cJETpN0W0PSu
	67XNtkyexSzn9VysRStuPn11gvuKlBUnjIt53ZmHB462DXAb1nsDh/rKAB57rhzUMUNPJKc0gm9
	qUU7lpKWJzWMUvg29ogWGELOB8XzI4JR90de9VTX6HUL40ZmpCJPijPDYCwg=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:5087:b0:4b8:4703:db8b with SMTP id
 5614622812f47-4cb69b976f2mr1049869b6e.20.1789598402258; Wed, 16 Sep 2026
 15:40:02 -0700 (PDT)
Date: Wed, 16 Sep 2026 15:40:02 -0700
In-Reply-To: <6a1b9770.fd5edf16.2e7427.0008.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aab1ac2.71f81b7d.278072.0000.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in page_cache_ra_order
From: syzbot <syzbot+8bd419f88e25ab12cb75@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, almaz.alexandrovich@paragon-software.com, 
	gality369@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit d62cf685d12e95cc0a4122c43cd9f0eb8bba0b4c
Author: ZhengYuan Huang <gality369@gmail.com>
Date:   Mon Apr 27 07:26:50 2026 +0000

    fs/ntfs3: hold ni_lock across readdir metadata walk

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1540dbf9580000
start commit:   704340f1cd0d Merge tag 'x86_urgent_for_7.3-rc4' of git://g..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1740dbf9580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1340dbf9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b454dc6b1b7acd30
dashboard link: https://syzkaller.appspot.com/bug?extid=8bd419f88e25ab12cb75
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=154788c9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=134788c9580000

Reported-by: syzbot+8bd419f88e25ab12cb75@syzkaller.appspotmail.com
Fixes: d62cf685d12e ("fs/ntfs3: hold ni_lock across readdir metadata walk")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
