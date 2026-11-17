Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794923529;
	b=r+kUy5mEjPvFRNVONPe+G4e/fTdObbu+9idIlHhlV9225NV4Iw+zQOasFSPLQWqVRYBh
	 WSMbUaWfchX6PuMR7KX15hK/SahHiCYNjXWgSf3xweZuSEAiXdsFbXr3BRmYzTM/vnTtY
	 saZv73kz1+QvbyjdI8zU26IaLE/teWoqm5Vb1AR0xZ+FWlOCEuKfUcU/r81zBOcP/ssoX
	 87xzGQBIKajSK4FzwmALIkJI6d6J7l/qK810iqP9m9XVaKfdYIjG9mDG7De9e6oO2kmMF
	 bhmH+W+YXdiqes2oTeKCZJDmkEArjdBmk0uMEbdbPfcSuyHLa0r4kGVdPKffFHETCwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923529;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1CXHuD+7M4E0rte/HpFih0lklRzK6u8QUeFUsQ4kAjQ=;
	b=hRK3FvJaoEG25rnx4xSCr8tUvN8ADIyN3n1WeC1jWY9VkyzHzbm0wyYdzh1xO5TDHNV3
	 +CvLgauR1EOLgWO0jw7tE2vtZzjo9m0Q3YdWhuAqECPsg1rHBy8r/NxwqvCHtAz4LSFrz
	 QmMrmJpLefsKz8y8NqpcVM6LUlDLorJTCuekgMjUvyMPu9lgr7W4Yc8sD4Pc8epWSDGZa
	 /jEmMobdQaJtkXk8IHNUVstN7ssl5esjHTT3/PkG+wY7LL0gBkctvY2dzTmzSqwGjZmmR
	 Fbz0NlYPA8WiAL84oe+eMaQQiNPd7ntPzCUh6nTznE4uO6lutkR5nJ2G/h+m5gwoUYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZnPHt3le;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CE3606A331
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 13:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1CE3606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZnPHt3le
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cdb2e0062bbso2084744a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 05:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794923528; x=1795528328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1CXHuD+7M4E0rte/HpFih0lklRzK6u8QUeFUsQ4kAjQ=;
        b=ZnPHt3leoE3b+zyVtoFqkH78raa5oo30XzURJHdxuTrZhm1A8S03JBHg4cA7pLp3vm
         go2dWcsQh2NfhfYlVKcD7ba08u0oFlN0PvE6NX4pIJmWe0pENj0S9o88FftCXjN6tSTb
         awrZ4QxC6HLt8OY51Upno5f3DuSdzCOfiA8PGyXQtwoFKELK8qAvjyrUVFRJqOTnkscJ
         9gihPWZTriH7M1kMMgS6njXBlBpMmqSomEJVKsXpEjaOGlr4znjiXPfLJkvL+mwDe5SY
         BLLTE+H+b1hPD795MLqStC25u/0iYPysQaCSVdZEI7PBDuqWjqpVWZSyHBmTnP7rzMw4
         l0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794923528; x=1795528328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1CXHuD+7M4E0rte/HpFih0lklRzK6u8QUeFUsQ4kAjQ=;
        b=sqKD7v9k/5qLFM8nzT+gCIOsv+4OYYzPEyza5U/oVIdt8zFQbtQpcBl42Iy0gY3E3l
         LBdg9quL7N+ysE2XlmTVUbeyQJarxOYiVwhdQ9BKtiz2EXkDuPGJUs288jvcEgpm6k3a
         Cm0dQHDIul2fpzh6k5JSk4Wf3Xv4ATPAUau5GA5psd138Qhkda/3gVS++uhPLHz3Ulya
         /7d1aJ4WrDjwjqttsZi6g3ct/R7RXgcMrnX+Pi5nBF1Gr7gGfkPNmr8Pg5sH8HOrDs+Q
         qfuZSsVZ9f7xaYPCQrQ5p7JorgBO1PhPaDbAjIb9cU5gewSbxv5LhvalMl//DaklWAP1
         PcEw==
X-Forwarded-Encrypted: i=1; AL+hErHSBCMeMAV/qMJOxIfjzMZw3Hyo36pOKYxQSk/QreZ+On4EqoAPoT0venM1hBjf5gs/sRlzW1gOEiiMP8YE@vger.kernel.org
X-Gm-Message-State: APuU4Z9ie4/d4KnL9JJ/gv79hXFvaBJlM7z7gkQ58fa/2yV8AN4vuGgA
	P70130++61chRE8sImnKoFNMFNI6Wh2OB9Rhq0gAYP5HJ/08VVM+QwDg
X-Gm-Gg: AZFdTZeLeBMB4kmN49RLextu6RqS7vMV8bq+kvpF+LtGAkSSi7XP7Ra9Upn4EA91xPR
	+tgJ7ZSu55OJO395wUfUF0uuaAmLiPx1UgCeALMJyQfyt0TfZEf+ZFn2aLQGAId7oCiAkr07dxh
	1eX/44fyB3zrweYBS6vCgDWAEFjfBt2sH/LRw9kTNWG5vZVFBvk1P/iE+XgJKUZCHvz8c9Df60f
	pL1+uYkWUUXYCHK7bXZ8TL3R3JwGA3Ju9pCps+daDHhp4mR+WsCSfW3gIcAP+AsEvE1yNwy60ZM
	uSftiqIA2o5rMbsRskTH85WdOEihZesX15El9gEm158hH+XoX9dCizUnJxJI3MHJCt71sxBDk71
	YWcAAjncyTTMaSki3t+/s6/ucFzKtoXnsXhuFdCxzjwRIpXICjy1nQlWarciL6J27/LpVCplpHy
	uKUfLrBZx8Y0EiwNh+N2h6db9Fecj4pIk55JRkXWLO4g9Dcabf4+xgGOTNgm9FcheIlt1zGKDCw
	33vwYiWJFmQsEZYzzmZyyFfevYVDDiP8xTVUCGwaavtsu7J/lrhvv/LlDYTa8WIMNcoGjXF2FHj
	PAKx+7E+IbSQG4nGOn7q6t0vWYPo0bbTim/yddSMc11yHv5ChA==
X-Received: by 2002:a17:903:38c7:b0:2e7:ff72:203f with SMTP id d9443c01a7336-2ee0dd9cbfdmr134501055ad.61.1794923528140;
        Tue, 17 Nov 2026 05:52:08 -0800 (PST)
Received: from localhost.localdomain ([112.170.44.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2efd7a586c1sm15937035ad.43.2026.11.17.05.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 05:52:07 -0800 (PST)
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
Subject: [PATCH v2 1/3] fuse: skip dcache instantiation for readdirplus names with embedded NUL
Date: Tue, 17 Nov 2026 22:51:35 +0900
Message-ID: <20261117135146.3174252-2-graypanda.inzag@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117135146.3174252-1-graypanda.inzag@gmail.com>
References: <20261117135146.3174252-1-graypanda.inzag@gmail.com>
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

FUSE READDIRPLUS can pass a length-bearing qstr with an embedded NUL to
d_splice_alias().  Unlike verify_dirent_name() in fs/readdir.c, this
path can create a dentry whose d_name.len extends past the NUL.

For such a name, strscpy() in inotify_handle_inode_event() and the
fanotify name-copy helpers stop early.  The kmalloc() and kvmalloc()
event-name buffers retain uninitialized bytes within the recorded name
length, which copy_event_to_user() and copy_fid_info_to_user() can expose.

Some FUSE servers include a terminating NUL in namelen.  Follow
nfs_prime_dcache() in commit 78d04af4995a1 ("NFS: nfs_prime_dcache must
validate the filename") by skipping dcache instantiation without
failing getdents().  Return -EIO from fuse_direntplus_link() so
parse_dirplusfile() sends FUSE_FORGET for the unused lookup reference
and continues readdir.

Fixes: 0b05b18381ee ("fuse: implement NFS-like readdirplus support")
Cc: stable@vger.kernel.org
Co-developed-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
Signed-off-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>
---
Changes in v2:
- Keep FUSE READDIR and READDIRPLUS getdents() behavior unchanged.
- Skip dcache instantiation only in fuse_direntplus_link(), following
  Amir Goldstein's NFS precedent; forget the unused lookup reference.

 fs/fuse/readdir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 1f6cf565477f..6b2468b575d9 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -191,6 +191,8 @@ static int fuse_direntplus_link(struct file *file,
 		return -EIO;
 	if (fuse_invalid_attr(&o->attr))
 		return -EIO;
+	if (memchr(name.name, '\0', name.len))
+		return -EIO;
 
 	fc = get_fuse_conn(dir);
 	epoch = atomic_read(&fc->epoch);
