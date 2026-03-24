Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB173D903A
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 09:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774343287; cv=none; b=MIkhGcCiIG9J2I73oQctA6+zKvJRPdEXdqQJiwRueNThg1dig56E6Wah+9eN0mHZEOkVJ10PiquIixKqWtU7I9wZ+7t2EsAhVXTf9BlDFEL8VcOxbBE7+KmFSMCLPMK+LLO6xqDMquQ5hN9Ud6tTYo38py+YZyA+/xIG5RNgtJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774343287; c=relaxed/simple;
	bh=XfnVTlM9gagPGdo343BrwDXNn/m73+sX1WAkeTm3Kf8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LOnoReTkBzGhC+WNMWWCZGpaQMNR9Q8IaS/bDttgbpjQGbi52FrgqZwsDxBGjHn1OcttUmrmjDd6fvC0rvXFNzTHNMkPYElwokH6Xs1puy3AK4NDvnbFhOA7mAYZnB7YPQ3zyT24fYsV7jaIPqVA059YVsUKTtVNvlU9bWV2X98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-67df0afe23dso22380239eaf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 02:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774343283; x=1774948083;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftg+ZGhajQhEQJTdhRvF5oJi5h6jhqQW9ccLWUuvztM=;
        b=b2on+EqPtn+DnZth95j4XoU5Zcdun//90OpBCLaed7dPYEGaAA2Qu37HdVvvU3x8Wp
         J9X+JNJg30Ss+OVA25kzZmM+m146e4JSCZQpuC/ZtqSsQotAf8L4Q7DY5Pqg9P5ZgLjd
         CCYnPNi1DU8vMJjLe5FH+fdJp3p6pIGDXwlb+sJAyr782vqYG2zHyUsWHDErvNbEojcH
         dLKZ3bvU4Jm32x30Xb0RMk4NE4gkd4zA8DqFBtSZRGwHYEMgnhdfGTjTSR8DnwkrH+Cd
         GgfiGyTNrRJJqx+Aiee2kU6bRsFeq5H2kDIatnKfP8Tybrh8iyH2QdrHrYS/Np3c+too
         q95g==
X-Forwarded-Encrypted: i=1; AJvYcCXWRfKtl0MYOAXKTIL99CdkmvzHAFnHkc/SHppIjgzFB0iTGNO20Ni+iHRgCjuDQcCaSgLqzmtFlp0WdpXh@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm0QcVV7OMNRHVqGrd2PGBgXhHrzzhIQv2GVG5N5rPhEYUCQdi
	1s5xucfZC1LXPZJafmIX73D+noY4/yTIIeiURuGCsHEodi8Ha12fvP2j6tc9Q7WLCzaVJY442xn
	EXtyiKeJ1FCmSP4FzGeg9EMwWyw/yFWCiaKZbTL0Nam1B612CNCVmWdQHDSw=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2012:b0:67d:ee3c:9acd with SMTP id
 006d021491bc7-67dee3c9d35mr4342637eaf.5.1774343283653; Tue, 24 Mar 2026
 02:08:03 -0700 (PDT)
Date: Tue, 24 Mar 2026 02:08:03 -0700
In-Reply-To: <20260324-grauhaarig-gedeutet-f7cb2f86e1a6@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69c25473.a70a0220.3cae05.000a.GAE@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in __umount_mnt
From: syzbot <syzbot+e4470cc28308f2081ec8@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+e4470cc28308f2081ec8@syzkaller.appspotmail.com
Tested-by: syzbot+e4470cc28308f2081ec8@syzkaller.appspotmail.com

Tested on:

commit:         14594a14 mount: always duplicate mount
git tree:       https://github.com/brauner/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17e5aa06580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d485346661badf84
dashboard link: https://syzkaller.appspot.com/bug?extid=e4470cc28308f2081ec8
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
