Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900EF38B14C
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773147103; cv=none; b=pUczkpyLXLI/XLTDJkfoCwI2cLE08pqDtjcfJZhfWN4LOroMMbBXDn6TMRgmM/nmF/1YV33kDKinjjiMdxcYo1fdYrQLMEbGpgx+nck5Vb16vB+Etq7OMh8q7CNqp020dFx0f/FYdnjoLPE6QwEw009s6B1Mx4qwlFxGV1oCPfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773147103; c=relaxed/simple;
	bh=wafJtbWuM02dpFWlk1FY1GQH4V6ZSUBF6EHEWYxC6hU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=L8yQkob1OYRreHqEisr7E63ri/hnIyPFEE4EPqBJj+mDLWcrbJ9tV9a8caGlre2vCaPExBxkNjRbmfdEaAj+YhT0rqZZ+qYb+z/G6f2WnHJ4qu65zCKG14KFKuuh2vUl8iNeqhPZN5I+LZvgTebPY1ZM4GGN4Ybt9tLXDvZVhWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-67bb6081a0dso26922971eaf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 05:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773147100; x=1773751900;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OshdSFBHq9GherBohmmJStIsm55YycRNXXb8a35WIC0=;
        b=kahqyE1KUDdfc29zyBzeUhPpEbandoNrrXJCOzXpOe+yN+IbrSpjcPHvTVN98YtE+F
         bUTcG22aB8FPXGWShHUmxsrb5kuGx/pPm6APMw4rQiAV9PhezOr3aob9zp+lzu8gTdx6
         v2vDeRmUQI9PU/CmF/zcPjD4FajvCpg+lU2AB3srIO3PUfJtGi6JcaTKCXu2IY5uSuDa
         cMF14+xlc87PeK6VN1xozvy/I0RKLuytQn6bZu4C2C9eVHixbXfZBNSNyQIrHHJgyazb
         y+E50VrWUO4aE6TEEA6nYA/VWIrGkIXLwIh5xrSUX007Agm0ws/6St/jIbomG1s4XzcB
         hY4w==
X-Forwarded-Encrypted: i=1; AJvYcCXwW0fHpprfnTi3CqWUDMKOICY9k35vi4YRtIJplBOS77dZrLzlo6MpKmrvsS2GuZuuNmAR0kffyejO6/fd@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/XOkZI7eYF5WsWb0nevEnSzYVJDkG1jkLAUWMIkzu+u5G5eem
	5sCOY0e9KFylhFeUiOXbDeejHjgrzOH9eNOnAqlA5MUfnxVNLj3u7V6CJYOldGOWpg8T/oo3ndt
	QxwdYePvXE7Ie6eQLgeN0J/YvzDfrjP+UiLE9wAJMG35E/mtThDz7Qqkunng=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:480c:b0:67b:a8f8:f69e with SMTP id
 006d021491bc7-67ba8f905d0mr5643788eaf.29.1773147100604; Tue, 10 Mar 2026
 05:51:40 -0700 (PDT)
Date: Tue, 10 Mar 2026 05:51:40 -0700
In-Reply-To: <abAT0q5bMfFYGT6V@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69b013dc.a70a0220.be77.0113.GAE@google.com>
Subject: Re: [syzbot] [fuse?] general protection fault in task_work_cancel
From: syzbot <syzbot+741e2278ef71fef03a10@syzkaller.appspotmail.com>
To: gnoack@google.com
Cc: gnoack@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	mic@digikod.net, miklos@szeredi.hu, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> On Sat, Mar 07, 2026 at 07:46:25PM -0800, syzbot wrote:
>> syzbot has found a reproducer for the following issue on:
>> 
>> HEAD commit:    4ae12d8bd9a8 Merge tag 'kbuild-fixes-7.0-2' of git://git.k..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=17dc475a580000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=779072223d02a312
>> dashboard link: https://syzkaller.appspot.com/bug?extid=741e2278ef71fef03a10
>> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=130b075a580000
>> 
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/010ac4052aed/disk-4ae12d8b.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/2aad8bef9031/vmlinux-4ae12d8b.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/fd350ec4896a/bzImage-4ae12d8b.xz
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+741e2278ef71fef03a10@syzkaller.appspotmail.com
>
> #syz dup: general protection fault in task_work_cancel_match
> #syz set subsystems: lsm

Command #1:
Can't dup bug to a bug in different reporting (upstream->moderation2).Please dup syzbot bugs only onto syzbot bugs for the same kernel/reporting.

