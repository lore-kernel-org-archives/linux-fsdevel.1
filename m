Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C494C29E113
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 05:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776920723; cv=none; b=DiHMWRdItEjYlXB2cRO23yqczMUJG6Q+sDsRb4dQ15amg9QHzopMI39qqDONtiAzqrMZjHWoxCde0PR2/q8qwjzmCrTP1eUo1Rc+5q2g4KJrGgCV4p8/Dt/BrDdW46cMw6LmMhfHjYjyOj3Q3ht8aeHRQ5RCOAF97MniNriL6BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776920723; c=relaxed/simple;
	bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=duI4+Ueq7smj2cFTqCXTLcN+3a+EsXTRInq0E+e19bLGOpIQ5V8gAyqcP/oO7lwCPShwcaqtYJ5XXVtV7mN8XeTCDO3WTq72F3k4+MXMcz32OoVAXejS1Rip0uevK5VvzxOZ4s3ar7JAy2QePCcHR7sQlMVra8tkS+0cMNDvJ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-6946e873672so1431011eaf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 22:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776920721; x=1777525521;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
        b=tJJL0mSg59MIE6Vm6I9C21gO9kw7hGA5EYwa++kjppkL08bygF4vXD8unidfeoutuk
         5dTDFD93808mSQivzwtJ6R73/ZuKxMGinagZdyZmqIIhs98cDEI7epUaF4TgTXZwGEpE
         gq7uXr96xYgZAJVSGD0IhdzqQp5T0dkaZ81RbWaUlp6remjZpBR/hoJmJRzHZcSmFI6y
         Y9bS2kfcPDZp0bNix7aJTH3ojZbWnChApN5Kafi3Yg7unM5TMoWfY+lVbeMwaflYn3kb
         nWgHcp72OlllApaEvDerDy8c5T7PrSRFhh5r5urHCAVCVjI5HxZgy0id2gh8ScJKSUay
         gD9Q==
X-Forwarded-Encrypted: i=1; AFNElJ9YloY13+clu5n3a6hY6mWMQzyM2bukl6X+x/yxchU83BJEWbWlANJSYbrs8qvOxjX/AT65hboyXUq9ouW4@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw8CvfXwuayf8gYrr6PfeHmOFrmClA26Bj428N394krvkrgrIm
	rWaFics7dT08rYBTRmF4KuslSasAIWrg4OLPA/0FUsHZYAM0ikS+fJ0APgsS7hW7dW92tC80TWv
	97BrnYujCtAnbL85Iu4Z4BWxeEPTKThEQ9XpTbspSowjFnEQihDPNnxmAfX0=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:ee09:0:b0:696:1cf0:22 with SMTP id 006d021491bc7-6961cf00103mr161763eaf.38.1776920720911;
 Wed, 22 Apr 2026 22:05:20 -0700 (PDT)
Date: Wed, 22 Apr 2026 22:05:20 -0700
In-Reply-To: <699fd494.050a0220.2fcbed.0000.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69e9a890.a00a0220.17a17.0037.GAE@google.com>
Subject: Re: [moderation] KCSAN: data-race in filemap_read /
 filemap_splice_read (3)
From: syzbot <syzbot+6880f676b265dbd42d63@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, akpm@linux-foundation.org, 
	almaz.alexandrovich@paragon-software.com, baolin.wang@linux.alibaba.com, 
	hughd@google.com, jack@suse.cz, jiayuan.chen@linux.dev, 
	jiayuan.chen@shopee.com, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, ntfs3@lists.linux.dev, 
	rostedt@goodmis.org, syzkaller-upstream-moderation@googlegroups.com, 
	tytso@mit.edu, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Auto-closing this bug as obsolete.
Crashes did not happen for a while, no reproducer and no activity.
