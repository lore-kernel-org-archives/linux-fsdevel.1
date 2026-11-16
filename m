Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794836352;
	b=lFxmnJM8scPVv52d+iYEVJhkpHmSKSJZzOkJVxt5G6YCrzTjQzac1UERSVjI0SYN1b7K
	 RLeR52kCjzzcRzA7L6SOYFI13rSW11KQHFTj2xCIJ1lBq6LJZkowBF1go7w1LxI4soTy2
	 nIWjm/4jxooPtDdGOM8m0l91Cx6nHQwVaDLjQ+cxeqWl1epUXvkIHhi3SnR99jdhN2bqG
	 5WI+LRqVE4ZBJ1jxtTwy/bvCepxuPFPst9KAK1wIqPViWXN+2chROph4Bi6ThwsLi4SNv
	 iH9hhc7QRm2aMXq7PoivRIIU5YelkABQ7zslSn/9uTP3JDB99GmvBR2SYwEGsuixSGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794836352;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0RCY8SlJF1fUzfPYkjMVeM8fsGJwzoRlEM+dvS8w5/M=;
	b=ZimLjLlrTDmr+qU9X1Wv+qVngA+n+A8ipty3PzfHZh7+uAL07QJHfjq1bwHMy9TC7rlC
	 6kBTz3OMuFRuRWV/hhiyru6c32scsLk7mQXjFT/Px31ABfT3o7BDoaUilfP2dGmz/K7tF
	 fkxd1q0GXe6sdm+VawUM96WM6YOeJ/utFF3I8ytUg+qsvqTX6CU19QyjRpMpYz86+ZmH0
	 vRuBUOyqvjJ7MNFOL/lLY0BqhzD6YI6dq5KtbY1SCkecUCGDmd9gPv28E3GuZ8+jku+Af
	 gcQg6LCpgWC5lHlgnOpLds+qh+XXN59LCSgGqSY9wNB8++i6BN2voqJrDCEozBDeNbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tuyte0XH;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262F2606A899
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 13:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 262F2606A899
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tuyte0XH
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c505186727fso93085666b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 05:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794836349; x=1795441149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0RCY8SlJF1fUzfPYkjMVeM8fsGJwzoRlEM+dvS8w5/M=;
        b=tuyte0XHN9vejcqK4l0//VkSntgcv4oWwWa0+sUtmOsAc0uHuCz+B4sf8XJCEQ6lHt
         F6yBmnGoSO4NP/5dfth7qg0DEgKkhdqXx18qjFXlQY91q9VNCaUQewRO+y8vhGd2cj2c
         vjmZB+Pyqu7ss+Z5WvUDDHZMlwoLK1q3FS2dJkkPUlsYs6LBLt10f0raz9lgtflmdL4I
         ALvIZLXPWkEifTnl46MvaDyQMGiuvjHlty1EKX+42GDpiPRYqkKuFKOcceVEWJzmA0tw
         P/4dGFSBL0fP+wJAZlzcN+HfOW7BoGOwZXy7urGRN1aJV8LeLPVi37aepSTtD+UVcVOH
         wbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794836349; x=1795441149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0RCY8SlJF1fUzfPYkjMVeM8fsGJwzoRlEM+dvS8w5/M=;
        b=LnQyqCtJ+2rIfgyZtNlz7BU2pJBX9ikehf4tZqcH+q3dPLMtX6WPgHVNOXW2UjEIsD
         cu0v2/wOvMtAJfMs6U93hwq63weBoNaUuADp+/mb5e6Peb//xelmg55gEiNjiRClReNA
         bLSoNB4sVpJryWDMNdx/l6cobJ9M7qKcvtK21o0EXJNGORFoP/HUHj03zwK9v4mpAhp0
         9BDxB2NaD+ApmozlHgKDQ/LhBovLmYyN4TEuyOqG40ltZuSODBIMNh8oiGXXFAAMaY9n
         UspInnaWFEm9ssu4/3R404jQxhyNcV/bFm61mWboPqoWQVJBDjlQLBMFyNB9gTHDD/ep
         Q3yA==
X-Forwarded-Encrypted: i=1; AL+hErE6m/uwjlgAnCoJrk27JLptOCCasNcdmYPKdYBXre22TgMyM2ViGLA9PcnZtlrClxETNARJxrEUsEa2iNbj@vger.kernel.org
X-Gm-Message-State: APuU4Z/0aZhSASXJ9odIS0QNZ1OEA8QZHX4gehwvW/onOWwrGV2RrK7U
	ZDqQG1HXpWtLvPZx+3zYdsUVxm9ZXk8EyEGNZAT4hix/CJAW/A15Brw7
X-Gm-Gg: AYBFou1b0cod72Vyan4ntSQnCw2czrWgOB60KH8StnzfzylMc17lVX5+E8wMM4BgpKn
	Ku4B4wt5iz2/57JJwfDnraTaJdYTYx81aj2lW60YjJxC3R10VBSg4ifNxtr5NJ7Tmm1RwSDmCch
	LGOvAuSmrzKWdze13++EmWj3WRXvKoMx9vKNiMUrf4cO/98umXJO95oETbM7UEIHuqLGTAejBuO
	Tyo6s642UNmnRbwNxq6AMTCmxf++5DYRBKy1zH4X5MJoU4kdrprciYcZGdAaaKrt6bIzt0vPD2l
	ic/2AkHWNcPyBTyT5wwQu6/lhPsVmr1dnnBtkTgoBd4/hIx4GE00Vf8/xTbje+wDjNEXBfw7OqB
	+JqRHiSJKi7WeqyZ42FCFWGFGK0sUAj5dF6GfDbzSLo9EEAC8poa++8cyTWA/g78fITwUAYos8Q
	Am9+rA8w6mDBcGH42LnIGOz/2bNETv3Xfo/xo0AYv5PMOqvN4VH4Tmw1iM+82K7Ardtc+vfbbbw
	PIUApum1BK4T5qGRXWoepYKHoD/LvpeLm86OP7aM7b5jtyVLIc4XdVpvqyHOcjX/BHZg7ZVlodc
	e+JwkVwltIfnkP2uH0DIlEQBvy5B9XVi+FMRm/wGGvK8mlDiX12Avz+FX/9RNImFL2sjEEqEYM3
	WTs4KBExi0Kxs1s/iEhLjGyVsNBHlGXXrc36ZeTwDUGn4ENaQ123WCNWJQmU3NgP7ACgP+SXifx
	bTfH2iMM/Tg3ev7wneJSkf6ouSSOzTz0mdhPcDjgfk/SYovs+AInQfpLBZWQlt/LwJ60lx7ogXo
	w==
X-Received: by 2002:a17:907:2d1e:b0:c4d:28c7:eb21 with SMTP id a640c23a62f3a-c50963967fcmr876042966b.29.1794836349492;
        Mon, 16 Nov 2026 05:39:09 -0800 (PST)
Received: from Ubuntu.tail0f733b.ts.net (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c50e9b2b5fasm61267066b.35.2026.11.16.05.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 05:39:09 -0800 (PST)
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ian Kent <raven@themaw.net>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	autofs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
Subject: [PATCH v4 2/2] PM: hibernate: refuse splice on /sys/power/resume
Date: Mon, 16 Nov 2026 14:39:03 +0100
Message-ID: <20261116133903.400202-3-krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116133903.400202-1-krystianmkaniewski@gmail.com>
References: <20261116133903.400202-1-krystianmkaniewski@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

resume_store() passes the written string to lookup_bdev() before it
tries to parse it as a device number, so the string is resolved as a
path relative to the current directory of the writer. The syzbot
reproducer writes a relative name from the root of an indirect autofs
mount. Autofs writes a mount request to its daemon pipe while kernfs
holds of->mutex. Together with a splice into a writable kernfs file,
which takes of->mutex inside a pipe mutex, lockdep reports

  Chain exists of:
    &pipe->mutex --> &of->mutex --> &sbi->pipe_mutex

A splice from the daemon pipe into /sys/power/resume deadlocks when
the written path triggers a mount request. Mark the attribute with
SYSFS_NO_SPLICE so that its opens refuse splice. Writable opens also
use lockdep classes of their own. Plain read() and write() keep their
behavior.

Fixes: 1e8c813b083c ("PM: hibernate: don't use early_lookup_bdev in resume_store")
Reported-by: syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=002fb7b2d0bc53bf7e75
Suggested-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/ec0c2add83f18d7a3c726d5d219dfe42@kernel.org
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
---
v4:
- Update the description for splice refusal on read-only opens.
- The code is unchanged, so Rafael's Acked-by is kept. With patch 1,
  read-only opens of the file now refuse splice as well.

v3:
- Use __ATTR_NO_SPLICE after the rename in patch 1. No other change,
  so Rafael's Acked-by was kept.

v2:
- New patch. Together with patch 1, this replaces the v1 autofs change.

 kernel/power/hibernate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index e365e440cd52..da5590ffe6cb 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -1316,7 +1316,8 @@ static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
 	return n;
 }
 
-power_attr(resume);
+static struct kobj_attribute resume_attr =
+	__ATTR_NO_SPLICE(resume, 0644, resume_show, resume_store);
 
 static ssize_t resume_offset_show(struct kobject *kobj,
 				  struct kobj_attribute *attr, char *buf)
-- 
2.53.0

