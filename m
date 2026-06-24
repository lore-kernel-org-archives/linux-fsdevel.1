Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9597285CA4
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 11:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782300903; cv=none; b=ZeLS6lyXv3mLj0qJGgIk1q0lLkuzWAQJDwObrUxm6Jag0XmWEgiEIdvBdgffYt9dnhpAUDgod62XNFLf9jBgqJYcQ88oUsKgHKr2nn6Y69RBcKhq24RT4g5lSwfqxnE/aIeSYqZYzSjd5Diuf6n7xHDsnNOUBPJSWCbipQ8g2OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782300903; c=relaxed/simple;
	bh=KlDFNqvN9e8LADivYYDzOhGSGnhn8hFEWVI67gn19IU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=o6/L9QztxJ8qJ5T1F+lZnoycXEngtsDqoGWEwcH0QTeruf+A6NcGBhNkJmOjj5mlNHHEpDRuUA/jUs6wF+xnAVzQnJwZ/041jMwpBK3SoWIQxxX2OYJmdDRXvgYDfIKlNNev7aC9NBuM4Z0iV7cm3g1lRMZgHHU4N8RkGnfs7so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e92c443b82so764548a34.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 04:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782300902; x=1782905702;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XvE9Pm70gpmoaAxrFlJ/o8U3S+zB4RLe5NXVuDhnvvk=;
        b=IxijTbSG1V8HClx6Y/XI0Ly3fq0ZBw29bKyN2ZNIpyQFLGI/DCUx+Rv0+R4RoKHI/T
         EO+py0MXyN7Gt2ofITAaOD0VWAjlemHZ3fMGjw9VD6D4dT/hiuFVMmmJ+YLeyIWvqcMi
         dK2h1voin3KcK7rtJi/jwwKIKf7keB3PKx2mgTdMTt+kTahIbtJrA4dSO0l3ti/X9tPY
         iVQuphHvjzQwwbWn3iguVp9ReVCBygKGvfzVyEZdG26ngp97Kcst1wNnpqZQG4rb7JwA
         biiYW9gBQL54QV8XFjHBUUVKjxFXgV6tFbxRaj66qVEnCbI0Ve05YEGO82h07aCmi1cL
         UOdg==
X-Forwarded-Encrypted: i=1; AFNElJ+4qlaSWWK3+vK5VAhgutdwloFe8gm8c9DCU4aZwbWX4va+DkL1qGjXNSEBmlgzgjCtP4yuW8yC5a9ofhU8@vger.kernel.org
X-Gm-Message-State: AOJu0YxhPeHWChWgj++XWZcQyGVWIqR8faItgfplcF/bQBDGU4YEC60P
	zX4EEF8kaKoC4j9aNO277SEucULr9WTnUiL3+tsPVqlbLEq2NsAmQFahFm87jNa6XINNwcZpU2b
	pI9D//FAB0jW9LLhBHqD1IYMzNhLXtZETNX5Rfl96lLrJdBu+B8N4J1XJyA0=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:690a:b0:487:57d9:9d1c with SMTP id
 5614622812f47-49077298b49mr1819793b6e.14.1782300901672; Wed, 24 Jun 2026
 04:35:01 -0700 (PDT)
Date: Wed, 24 Jun 2026 04:35:01 -0700
In-Reply-To: <2961584.1782299080@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a3bc0e5.92e8a34c.2b91f1.0007.GAE@google.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Read in netfs_unbuffered_write
From: syzbot <syzbot+3c74b1f0c372e98efc32@syzkaller.appspotmail.com>
To: dhowells@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3c74b1f0c372e98efc32@syzkaller.appspotmail.com
Tested-by: syzbot+3c74b1f0c372e98efc32@syzkaller.appspotmail.com

Tested on:

commit:         8fde5d1d Merge tag 'acpi-7.1-rc6' of git://git.kernel...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=179edb7a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8118209836970b54
dashboard link: https://syzkaller.appspot.com/bug?extid=3c74b1f0c372e98efc32
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1557d766580000

Note: testing is done by a robot and is best-effort only.
