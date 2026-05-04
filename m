Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881EE322B7D
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 May 2026 20:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777927866; cv=none; b=GdhmTWRQTqBebi5OJn3b9ToEzkoQkuCydKo7x551oNKFR2Xnndkc9i904MujMcK3Owpb4BebsjWg6ykkaigQcjRbz6jmxNm5hCkiIpMi3SS+z071aOnrQcIlSfDyoyiIT63ftHesepfsgCzfe/sFCyJW2peOdGqpvBzrwE4E7D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777927866; c=relaxed/simple;
	bh=bxWWR4VPDW5qg1KudL2JQqP2ZeWsXcqywzLzmbWXB3o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=j2cVxo8L+FSIt6OQVi6Cfs5G9JLSpOW15GLp/A94czW7T5znrBIFjpQ+OTGKMbAxQGXDqvjP1q8KWfx45jJkhYHS7i9oT44uT1t3qhSI5SpN5YGLOo/h5YWOYxUp5y2SV2i8EpJu3EIYOVYEBfom7yjT3gO+3G616WxlBvuXU6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-694867ca29cso9346953eaf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 May 2026 13:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777927862; x=1778532662;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bCjj8G05TtBZLOd7zrH44gm7HPyOQ+hR+PG268x3BGk=;
        b=ZudSCFG96EVc0+I4aGy4yXK84nQYEoX5fOLccuRZRvTSlnZo5tBcMKB17xRfdlIXWj
         AqO9h4hX+Oc+y0K+gRaq08HRS1atqdZ1lKVZyDKeLKYN/NSCVu+BHM8jkX4bnzzpbMG5
         tW5XYEM3pe3tQ3TJsqWe0cTw9SHJiGyIZsnE4vHrn+9SWQpTCp/ERRwsSWuiOJaevDwy
         WdQS4cG/HnjrqripA7zktS+ZKENloP7mVC0fpZZTwUS8kpjkT5d9UuR1bMoI9WMfh65h
         ELvCIQ9DrZdooY6wLRF0at9te4ch8pZ05rI0oRcoFBqutObEj3Sxhg96S2w1WTg03UZK
         bTdQ==
X-Forwarded-Encrypted: i=1; AFNElJ8/tM2x9dzq5JqakdNk9aVjAYnTI2KAkYZVpBOqgV6quhgWLbYR4huRRJMLSAlqpWA3J4lDDmGgW9Co6hnR@vger.kernel.org
X-Gm-Message-State: AOJu0YzK/QhEMmdxAS6QzFoWlUVlecy7rx7J06upiwvUFqOmoCHBUsSY
	V+BFUfdd2Nvf/nJRkFHNIj7R+bYdTos5bQzWwyR6LqTV69WHSJ7kL4CmkLdXc8QaXOFLifGZhFX
	42R9LEg1NQQYMYeZl9LRMp4sn2ajsMEpTxGTP/ctPmB0VRK4f5xeC3ni33Lo=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:60f:b0:696:8c3f:d7d8 with SMTP id
 006d021491bc7-6998d225e63mr109559eaf.37.1777927861903; Mon, 04 May 2026
 13:51:01 -0700 (PDT)
Date: Mon, 04 May 2026 13:51:01 -0700
In-Reply-To: <2956b248-c79f-4eae-8bfc-81178b5899af@dev.snart.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69f906b5.050a0220.892e9.00d7.GAE@google.com>
Subject: Re: [syzbot] [mm?] [exfat?] [f2fs?] memory leak in __kfree_rcu_sheaf
From: syzbot <syzbot+cae7809e9dc1459e4e63@syzkaller.appspotmail.com>
To: dxdt@dev.snart.me, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel panic: !!! sbi at ADDR used after freeing !!!

F2FS-fs (loop1): f2fs_record_error_work()
Kernel panic - not syncing: !!! sbi at ffff888129322000 used after freeing !!!
CPU: 1 UID: 0 PID: 6598 Comm: kworker/1:5 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Workqueue: events f2fs_record_error_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x97/0xe0 lib/dump_stack.c:120
 vpanic+0x383/0x6d0 kernel/panic.c:650
 panic+0x6e/0x70 kernel/panic.c:787
 f2fs_record_error_work.cold+0x14/0x14 fs/f2fs/super.c:4747
 process_one_work+0x277/0x5b0 kernel/workqueue.c:3302
 process_scheduled_works kernel/workqueue.c:3385 [inline]
 worker_thread+0x255/0x4a0 kernel/workqueue.c:3466
 kthread+0x14e/0x1a0 kernel/kthread.c:436
 ret_from_fork+0x219/0x490 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Kernel Offset: disabled


Tested on:

commit:         6d35786d Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17a63a36580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9645c21cfd1d3e8f
dashboard link: https://syzkaller.appspot.com/bug?extid=cae7809e9dc1459e4e63
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=172b8ad2580000

