Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F20337187F
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 08:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994608; cv=none; b=L/Tc6NTC0gknUiuWj3Ht+IbNCxcplaVYtYy5L25tozi1/NcRY33LJrSQ0qLfsntDKy/h8OI1AC1tzE67LaeRadXXypCoGjWfV8OmVjTl5LgEIGcMCFTpkYhKMB2ZM4smYDhLyY0Ca2OCMEkDkYMdxV8LFBj4YIIXVL5reRpmFN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994608; c=relaxed/simple;
	bh=bjrJ4S/FsINr/81pbIi6jj6PljV4RiGl0H45oSmv7pU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=FWQTwHSOLfFHn+8FfzxvNtjpKrZ6VzG0PzOHQhr8g+z85CiJN9DwYV/gkUsdp98QlXQCYKx/R/NxxUUg3/S0wO4JAWgVLFq/VKyBKO7CQ5BC+0qmkmFBkSvvvwKyKUa15eSNjW5u09R6EOix5XkmNqlnVjb9ylc5OmL9YxI8jiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7d7e9eefb7aso4941101a34.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 01:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773994606; x=1774599406;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GaqbpFLjq54QozbnajqIPY0nFpUhUrZICyVqRPZuQEY=;
        b=krj8osmox+LtLf9d+q4jl6lJvf6q7vhW65zjSDFWJD/CPhAuHpcNsidfH1WFLhE8NG
         aPLJWIj3nNISNhVlF2nyuCxmvBcdybn0hS/sY5w84A1A1+feHbZntKrCC280PNo7/shT
         Yc0IUZEZ5gKCMEXd/+GzamiY1RLRw4nCY+lexFKM2cICQhFrK+12OHGp91RLiwCnI2UE
         jEPL+iFQeEgCg9EKOC20PyAko/Ai1+/C2R2UKZC1rB8vfNEwGzpwM9KzxemqujDFZbmX
         JcXAuCsnX7xo/I0mipiGn+Jqw94GImblPOY1BUDX/BxKwghFc8m8TsXFoOEn/Fk6Dcoa
         lcqw==
X-Forwarded-Encrypted: i=1; AJvYcCV/OvcP37ulflhSNshQEglhGH8BHHeBjoaBvmja9LpDgCNpTFs3LPrZ+9cWb7q21nvniWwheCbcaxh8FFr0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1nxbmrai+WpasMxUZXCm+S+li1tq+DpCaAZlFkEbUHLIOfnlB
	vNIU5j16CQ38QKnfO5lzY5x+qG4/deXxX3htTPJ9p93RWfM+gMrPwspo21uIGa8J1jmcI6+5Ila
	7Q5dXs0bGfkxLBYryuSkGSquLUIvcQxNlrDDH0Pdfax2BvbrzIK1e1vQLQfI=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:228f:b0:67b:c536:c629 with SMTP id
 006d021491bc7-67c22bcc8e1mr1309137eaf.8.1773994606490; Fri, 20 Mar 2026
 01:16:46 -0700 (PDT)
Date: Fri, 20 Mar 2026 01:16:46 -0700
In-Reply-To: <20260319043553.301185-1-dxdt@dev.snart.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69bd026e.050a0220.3bf4de.0012.GAE@google.com>
Subject: [syzbot ci] Re: exfat: add limited FALLOC_FL_ZERO_RANGE support
From: syzbot ci <syzbot+ci684179a8afcfdab1@syzkaller.appspotmail.com>
To: dxdt@dev.snart.me, linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v0] exfat: add limited FALLOC_FL_ZERO_RANGE support
https://lore.kernel.org/all/20260319043553.301185-1-dxdt@dev.snart.me
* [PATCH v0 1/1] exfat: add limited FALLOC_FL_ZERO_RANGE support

and found the following issue:
WARNING: lock held when returning to user space in exfat_fallocate

Full report is available here:
https://ci.syzbot.org/series/a58a79c9-a4e7-40b7-a5d3-8d4da244a00c

***

WARNING: lock held when returning to user space in exfat_fallocate

tree:      linux-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next
base:      b5d083a3ed1e2798396d5e491432e887da8d4a06
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/6a43cfef-5b9a-4b39-a6b0-7d34bfb0f7b7/config
C repro:   https://ci.syzbot.org/findings/87d27fd2-e5b7-4174-8faf-3b746f7aa18d/c_repro
syz repro: https://ci.syzbot.org/findings/87d27fd2-e5b7-4174-8faf-3b746f7aa18d/syz_repro

exFAT-fs (loop0): failed to load upcase table (idx : 0x0000fd4f, chksum : 0x395e47cf, utbl_chksum : 0xe619d30d)
exFAT-fs (loop0): valid_size(150994954) is greater than size(10)
================================================
WARNING: lock held when returning to user space!
syzkaller #0 Not tainted
------------------------------------------------
syz.0.17/5982 is leaving the kernel with locks still held!
1 lock held by syz.0.17/5982:
 #0: ffff8881bc75c110 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:1028 [inline]
 #0: ffff8881bc75c110 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: exfat_fallocate+0x163/0x4e0 fs/exfat/file.c:131


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.
