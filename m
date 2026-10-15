Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E11443AAB
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 19:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792094346; cv=none; b=svuZA7+/MdwsDBma7pjmkJNj1o2vwKfiRVaYbeZr/fXq/LAJLYUMklYxxxgf5FH+yiECz3Lfp4U669Ik0+3/p+pBh2NZicnn8jji3MH3OdfxViUo/IkoU1BVhEuVanHf58b0TVpKjZgKXJ4PMD3fPQ1tn99Z+GzSOgHezVZjFsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792094346; c=relaxed/simple;
	bh=zRl3M5+NZnWam32sifa4b8p4IXF4ZgP71+EKCiBjHJk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Xh7lnjR6bRJ/I2nCiZtFfWd/SebsxcPY+nm4NhNeZ8S1IROxGrfqY/MVRD+8nMBxoEYsWts2qRJmiE2jdcFPk7CYeRyGEU1rLaMV3sZUe6nN72jXJNMT3Nh3gmB3a1XZR0pVTNyFXlGgiO9JDACbUK8J2jMkR+200jLmwwUstbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-5384e381fbbso27220b6e.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 12:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792094344; x=1792699144;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1DpsPenNOO4Sv1KfdrpXrKoQ6gMPJpWLHJ+7NF4IPzc=;
        b=Y5HZI0msEGX2WhHIpsocOY2WOE8wDmMYrQPdTrfEM7uaiMggP0k/kWTtPCigbnzWIP
         Lobaio8+W1JN9JmgpTRvNeqFeBGRweWY+OHEeQmn+ui55XAcM3y2ZYux0cG1uoHMSZb0
         Om1tZ9G9zWgmDOWEZk9RAlOzxo8t/OKTb3AB4GkWxV3kY1ojr+6U8F3iBnxAlz7Pjs+H
         kxMJd7ctum2faXHHcOE8/5MN+Xd+8jHGPrDvb3m/bdr1jNLvhRmuwqwysT4CZS0I+FvU
         lCV2qbETgBbV6feOHwpQ0FfIlQlCO1VFX6V41jUg1IWFBC7V+hOvAoRN9V+oSrXbqOwv
         I/0Q==
X-Forwarded-Encrypted: i=1; AKwUvBx1G3l6J518PO2PNiLAXg0qGIquVm5VrhLTHgAwzI6ElmgWSV5I+8qrMf3nKnSSlZNVSkNqH152xmjXNiAl@vger.kernel.org
X-Gm-Message-State: AFq9FYLMyve+nEkU1mY9eJj8TOXm/OFynKNqQqeslTI9woQ1BsSdmlV6
	TKYuUTuc3KGWIRYXGXgIGWYO2yPwiYYijY6M+BvbZx7U+p7v4Kx+GDrgNuPdmMzfOvTp9X7ySXz
	yoGflnuNsHqf+KP/JWIRORx6pM44swmnjoJ2R0N71gaqdP1ij6pad9tmfIiU=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a19:b0:4f5:1e05:c976 with SMTP id
 5614622812f47-50c50f31768mr17992861b6e.27.1792094343884; Thu, 15 Oct 2026
 12:59:03 -0700 (PDT)
Date: Thu, 15 Oct 2026 12:59:03 -0700
In-Reply-To: <6a69447e.6bd615f2.c0aa.0000.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ad13087.7514cce4.1ece07.00c7.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING: refcount bug in config_item_get
From: syzbot <syzbot+35790eb7861f8fc57382@syzkaller.appspotmail.com>
To: a.hindborg@kernel.org, jeffinphilip14@gmail.com, joshua.crofts1@gmail.com, 
	leitao@debian.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	vasilisalmpanis@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit f06c2d26d1999d37e93299db0ecead04ca7d0b9f
Author: Vasileios Almpanis <vasilisalmpanis@gmail.com>
Date:   Thu Jul 30 09:30:25 2026 +0000

    configfs: unhash the dentry before dropping the item in rmdir

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13ad160d580000
start commit:   2f1baf1fc892 Merge tag 'trace-v7.2-rc7' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=158601bb8cb292dd
dashboard link: https://syzkaller.appspot.com/bug?extid=35790eb7861f8fc57382
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f75279580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a7869e580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: configfs: unhash the dentry before dropping the item in rmdir

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
