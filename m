Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794777014;
	b=ZkGSTRSauw89958anFHdNH+GAQTvpxo1eM7JS9/nCy1sKbKyy4xdG0CgXJll5TIbmeW4
	 2wTxht+fDuc5ETaJKiWEKrcyvCY0uWVwE9ZS4vmoSgvE1CoGsAxy3gOdzfAVV8BvSBDGZ
	 BxmUb310VYhKsxXjYNaekLf5zE7sRoTk1b+MMpNw/J7oQxHkUiHsm9u0zbk4TA9IK1RyL
	 Chotk73R6mTX7H8KClN3OVyxXnFRcJGC6zynhvnzijnsoJbsF5OEj/Qqjxh4P59yiSzEZ
	 5eewmU+49yexJwGRb3w+a+rDPIWkpI95+L3GFRKU6PcSNBUqPKPzfgtUSu8G1sOh5jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794777014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oQFSDg5cHBfrZhn/Xqr57kPvYhbLjr1otgLb7m0JLjg=;
	b=O6RNSZ0Ko4clszbAQX8pLXzgIjYsZ2hv7QrOtlrysQMu1JfxbvsfFUbHbH0MIfSWyu/6
	 aFibuW63Wx8Th73s7bbNSl2qrm7QVQQ+jg1Ueuuym27Mxuuk2nwkhDE2MHtLdiFs49vbV
	 3xi+4eFV8QeokepaVWzPPEwTB12RUiuYVLTi6CNrOwpR9sZwdz9oetj2BBiE30GpPwkog
	 PnWfUW7+Xeo8Dl8wZIH8IySoRSjGczl5JtLCxgO6RKeWft5wKV1jkGM//2g5X7dDzhn9v
	 NUxB4BZD+xI/dyyAPjwhrYkhZvEKY3vh/5tywTixSLJiBv2p27UJncT+0WqP5dMwkNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uzSCHJmS;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B809F606A32C
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 21:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B809F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uzSCHJmS
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a070755c8cso1439466b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 13:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794777013; x=1795381813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oQFSDg5cHBfrZhn/Xqr57kPvYhbLjr1otgLb7m0JLjg=;
        b=uzSCHJmSpT6rzm/HyErENUYElGk4p7T1CSvlyZl0mzgDMdAfIgkX0aLaP7TtwxAoax
         svNoHOEL8l/h/2pQyQ3ZlTMD1t3gIPMXJdpwVsG0ma/h9WoOV+2NvsA+/8kn3hjruQ21
         dcI7KWPlQYxkBH/J9CtXpJxzFSVkAZnoB8HYbbu0GH9r8fri9YsGfMcnkb+z1n+PRdr2
         JNaorixqYXZO4BmtjqqA4TTqv1d9DPC2z8Rjnv/eJAfqi0fTQT9TeTv/2UHJ5Mt1qyvv
         49Mv+rm1Y1qM7A4Tz9mbPuS8hdd7E0Qxrxzx/fIOiPX0tOTPMqRv53rYSqVX2qjMCO2a
         22Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794777013; x=1795381813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oQFSDg5cHBfrZhn/Xqr57kPvYhbLjr1otgLb7m0JLjg=;
        b=pkW9q46toq2vZ6+7sHsRvWoD8XRD1rcFfeqMljNstsyKv7NVj/iPJW7qKah9pbcVMY
         LVGUZfD8a4ViEvTgDikPhvfxrX+9mwhLizg2Oa7bGaAjMs2lC1VhfVK9Rh8SczJmLmPz
         teXeQrPAtjNhUE9YGkl3IuWPlYBxhJV1IwITvqQ1o9Bpz47tF7cBSbCvL2TXjRM+GRDO
         ilOvSJnzRaiQOJs5mADFFQMzSagSvo/1u0vjm3xQfGQaNG5etEYOBN32a3x59VG4T1uG
         Q1UhYw/VC8+yOHGZdjT+PO5PXMwS4/qy76C+OJ6KBd5lK2A9Qi8gxiBD1j4THlSdS/6/
         qfzg==
X-Forwarded-Encrypted: i=1; AL+hErGa8Blmh5rTO91Lbguy04EWeXv9RZhXTqsTBnjSzsnJHmZQH8WmZ580Mn957/E2S35UaWp+JYjQc/cW9+Lt@vger.kernel.org
X-Gm-Message-State: APuU4Z+A2Y472lK2xyFxS9QmwGAaZVHRRTUx0MgkxwCz+DL+FgcFjnF6
	QrNJnd4DgPSkCCAZMlGa1Rp+YQagZXe3ggKXZTBOHWjbtGO72H6jM0Kf
X-Gm-Gg: AYBFou1VK1i9a59hPzwTbdBScIeAYpEjSSPHiUvk2p6ySuyH1tRO/TJQwHmSmV0NuN1
	1a6GgIeREJDj0iiEyH8D4HcdV4di3XTdZwHYP4c9S6qYctM0MXwNCtRfb59YbaaL/srHm67k/QH
	md9LoHTlZkw0OKXvz2jm9La7HbzbIGcZknxx7v3QYblCo9nrMeuy07jHDc42FU34wyHaTzH+ni3
	1R9Oo4IAs3pI0ihokq10amYw3gEnGrFeOzvRjtsATqDgW5dlDLM2VZWUIFykIVGN07H1UUtox4M
	dBDwbK9gyCUormMIFKLh3VIL6nJCUCWrBZz0QwXGCJ1NJCUFIYDwklaDrjAZP5Gdg7kL+l5+X4F
	jrHfgfNPayuoj1qvGxvnnn8aZrjoWJaJCjmpqawtLJpO36FvifbhFHnkTD3eDOBM5dKsQouctEA
	2ykbFVQuMJoAR48e49PyaVR+6P6cHeq992COW2t1F6ZobcGTJp+HL3zuSu5WPkF/w/KyhFej2/q
	+PTlrW9Kk0YrtLlqtibbFapNNAXKzw4mmWGjhFuY6x4lO+W+U43iajM9Ba3DZEJ20FVbM5TbtKn
	RzmcLt6s4cAsizI3F9k1PjxtOUBvBvxAF4LLeYxNAZkSNTpIiQ==
X-Received: by 2002:a05:6a00:1990:b0:8b5:b3c9:ff71 with SMTP id d2e1a72fcca58-8beb374decemr7993433b3a.7.1794777013037;
        Sun, 15 Nov 2026 13:10:13 -0800 (PST)
Received: from localhost.localdomain ([112.170.44.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed1a6e7f5sm2892615b3a.25.2026.11.15.13.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 13:10:11 -0800 (PST)
From: Junyoung Jang <graypanda.inzag@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>
Cc: Junyoung Jang <graypanda.inzag@gmail.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Matt Bobrowski <matt@bobrowski.net>,
	Gwanhyun Lee <gwanhyunlee@gmail.com>,
	fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/3] inotify: zero-pad event names after an embedded NUL
Date: Mon, 16 Nov 2026 06:09:49 +0900
Message-ID: <20261115210952.2140036-3-graypanda.inzag@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261115210952.2140036-1-graypanda.inzag@gmail.com>
References: <20261115210952.2140036-1-graypanda.inzag@gmail.com>
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

inotify_handle_inode_event() allocates the variable-length event with
kmalloc() without zeroing the name buffer, sets event->name_len to
name->len, and copies name->name with strscpy().

If a dentry qstr contains an embedded NUL byte (for example, via a
crafted FUSE READDIRPLUS entry aliasing an open directory), strscpy()
stops at the first NUL while event->name_len still covers the trailing
bytes. copy_event_to_user() then copies event->name_len bytes to
userspace, leaking uninitialized slab memory from the tail of the
event allocation.

This mismatch dates back to
commit ce163918cd33 ("inotify_handle_event(): don't bother with strlen()"),
which replaced strlen(file_name->name) with file_name->len, and remained
in commit b8f2688258f8 ("inotify: Use strscpy() for event->name copies").

Switch to strscpy_pad() so any trailing bytes up to event->name_len + 1
are zeroed.

Fixes: ce163918cd33 ("inotify_handle_event(): don't bother with strlen()")
Cc: stable@vger.kernel.org
Co-developed-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
Signed-off-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>
---
 fs/notify/inotify/inotify_fsnotify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index 6e3af6452dcc..78eb1e92a14c 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -121,7 +121,7 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 	event->sync_cookie = cookie;
 	event->name_len = len;
 	if (len)
-		strscpy(event->name, name->name, event->name_len + 1);
+		strscpy_pad(event->name, name->name, event->name_len + 1);
 
 	ret = fsnotify_add_event(group, fsn_event, inotify_merge);
 	if (ret) {
-- 
2.43.0
