Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FAC568FD0
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 17:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792087035; cv=none; b=mXju5jkmbzP/TJns3lEjmgj43uF2QhrPE45OL9Sq4J/OITDUZpi+1Rn5pZuRXLI5fzkB9ICtZhtMLruBl2pJwJgAV8IsbbAc0zRSKjYfF7OoWltpVJD2OKCvaQyMd1+A75NXwdLeGHVb7B2oG3D/iQ79hqxyVGvNDEwxAzRIf78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792087035; c=relaxed/simple;
	bh=Rvewqy63voh2KM3pnUX1AhozXB4DfzYFGfF8JiPjSKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P53GVEC2Pji2SeDXyTDWc8efhYO24d5VZsRAss7Am0O+BI5MnPgo/vlos3056JLZw2RLEHEMNK/ZSsJlUfPKzYBIiLxJVzODxEOFN2L97KJADsplYzwQBjjkU8pQ5I7dc/6JfAZ2l7M6/ni7Dy1KMuW75mHbhNOb7Lw9M0zgPcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvD0K3zw; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvD0K3zw"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a172eb31f0so49790965e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 10:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792087026; x=1792691826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2N7ZKdxtWSo3FIB7Chn8lN5wJYT/uoxLiCD25cL2kTs=;
        b=SvD0K3zwBxzeT3becAbiOlnE0kkXv92B4o2AAy+6mpQWa4njjtLS+4KLh0NPxptIhL
         WjaoPcgrIHHmhAhkbqsU4xegshak5FJtT2l5o/+XtRXoxvm2OT8OMnmLv+km8E1i5vod
         Tm7d4sc3oizQL2FIU/n2WzS+KIRQbzskUeA8m6pUX94/9qowExE9lFAaa8OOsXusgGqU
         MAzoYJ17NTYJ62fZ00lGU0qkhuH5zDifWwDzImpJx1bho6MCqTlQWGzFbRhgconaDvTl
         vG/R/FTWqSe5UmueidLOdCUIXJlj+4MXqHhQcMKoq+A4RGoFMV6qk83uzlnEWKz6U9jh
         Adcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792087026; x=1792691826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2N7ZKdxtWSo3FIB7Chn8lN5wJYT/uoxLiCD25cL2kTs=;
        b=EubBejseYh9PxQkn3IVYvnYrOtq21LLk2JWuqwmT0pRpqRfZHPhOp4CLh3gYO2Jx9G
         e6nFC31xpqgdfYkcsmi1eUwzjSyVdAy+U97rFiUJ0Wicbsb9PoSVsaYTIZa+qGSb/vcx
         YODsgqcxgqmeNrbAGK93lmX68ONJKLSUgdnoqWXmZcKQTRSNUvfcuh98dPtOJsmg+a/V
         L04r9ED+GyticCnRqnQpRNlZCdyWSVVx8WzvCm1toX0215XxZmJMnzWSORzciABZ0xZy
         mRTHLR86jci8dcg/MS5MvNwA2b+YMZaY4XOb09HwrCz/SdhAko4ld9mHbNpcrjKGrC2t
         ljOA==
X-Forwarded-Encrypted: i=1; AKwUvBxI+s0TA+u7oC0jDxEXdDtfoORKnqyIWpUQnaQfE1vNpu63XnI3Kt6c6Kg9uOx16qypmcByu9uYR/KL1+MU@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0tdilGHWj+1tt9pkuxptEEcI9Py5BiTZQOX2jtzeTffF0xORD
	4P7ohYLfcaLagIlI22nDMOkYg4k19DCCncPF4h000TZ/OxQuG7QqVNQz
X-Gm-Gg: AYBFou2mHs8mgE7O6jHBbO9zCsUv+Iu4dLwXr3bmHc6U8GlgKb+vMF/kr4yOUB4nj8N
	8MuEbTi5uf+XlW+lm192eDU5R3NI5MSy7atpYW7m44aovPuAET1l5O8S6pWIvvOhi0se27xOAzU
	rMT98ev2H/UmrpwJ0FFqu2qtCN7Kbmh/0eM+2hVjzLvFDrzYslrdVqwMzvbW4vDSnoqPgZ8cZwA
	xqrcaOd9dveGC0czfqCqxaLxMDLkMEFtt4TWxyKJhvNdFl8bH7CBrBFNuzG5xFzfbSgkmBmGpvB
	B1YvjudufBZO/yEd5lF//0oU/CWqObbt9CTa/Jyea96C9mRCzMF3rwDKFs+ftuw+JyyJQVsMDL0
	aykmHXieiuLa9nXInDquS+xIGlhlgdgBXSLbasPsWAPJMcRGQCEaVvdXp40iyFuSUAg/KuvIRN1
	d4jl4SKEH/l8iJQQoxPdxuyQQvCxevvhD1x+WM0VpQF2jUvT8O3w7afjPTD6LJTZztMCQonsees
	bLwJjA1ZgOO3pgAwiiI1ig=
X-Received: by 2002:a05:600c:8218:b0:49f:ffdc:939d with SMTP id 5b1f17b1804b1-4a18e49d9f5mr392948675e9.9.1792087026167;
        Thu, 15 Oct 2026 10:57:06 -0700 (PDT)
Received: from LAPTOP-AVI.taile24b5.ts.net ([2a06:c701:4778:c500:b8a0:279b:6918:c3ed])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd972aebsm96673775e9.1.2026.10.15.10.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 10:57:05 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH] fsnotify: preserve 64-bit pre-content ranges
Date: Thu, 15 Oct 2026 20:57:01 +0300
Message-ID: <20261015175701.3674449-1-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vfs_fallocate() and remap_verify_area() pass 64-bit lengths to
fsnotify_file_area_perm(), which truncates them to size_t on
32-bit systems.

Use 64 bit (unsigned) types throughout the entire pre-content
notification chain to keep the full range. The userspace range
field is already 64-bits.

Fixes: 9740d17162de ("fsnotify: pass optional file access range in pre-content event")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
Tested on a 32-bit x86 kernel in QEMU with ext4 and
FAN_CLASS_PRE_CONTENT / FAN_PRE_ACCESS with regular 
(4KB), boundary, near-boundary, and beyond boundary counts.

requested count    before   with the fix
          4096      4096           4096
    4294967295         0     4294967296
    4294967296         0     4294967296
    4294971392      4096     4294971392

diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 3710543dbf827..225919d7347bf 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -441,7 +441,7 @@ struct fanotify_perm_event {
 	struct fanotify_event fae;
 	struct path path;
 	loff_t pos;			/* FANOTIFY_NO_RANGE if unavailable */
-	size_t count;
+	u64 count;
 	u32 response;			/* userspace answer to the event */
 	unsigned short state;		/* state of the event */
 	unsigned short watchdog_cnt;	/* already scanned by watchdog? */
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 7e2f330fd2837..8657bb94dfa8b 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -157,7 +157,7 @@ static inline __u32 fsnotify_object_watched(struct inode *inode, __u32 mnt_mask,
 
 /* Report pre-content event with optional range info */
 int fsnotify_pre_content(const struct path *path, const loff_t *ppos,
-			 size_t count)
+			 u64 count)
 {
 	struct file_range range;
 
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index bda798bc67bc5..a4a29b3650080 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -135,7 +135,7 @@ int fsnotify_open_perm_and_set_mode(struct file *file);
  * fsnotify_file_area_perm - permission hook before access to file range
  */
 static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
-					  const loff_t *ppos, size_t count)
+					  const loff_t *ppos, u64 count)
 {
 	/*
 	 * filesystem may be modified in the context of permission events
@@ -213,7 +213,7 @@ static inline int fsnotify_open_perm_and_set_mode(struct file *file)
 }
 
 static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
-					  const loff_t *ppos, size_t count)
+					  const loff_t *ppos, u64 count)
 {
 	return 0;
 }
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 618eed4d6d724..a25ae4ed879c7 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -323,7 +323,7 @@ struct fs_error_report {
 struct file_range {
 	const struct path *path;
 	loff_t pos;
-	size_t count;
+	u64 count;
 };
 
 static inline const struct path *file_range_path(const struct file_range *range)
@@ -945,12 +945,12 @@ static inline void fsnotify_init_event(struct fsnotify_event *event)
 	INIT_LIST_HEAD(&event->list);
 }
 int fsnotify_pre_content(const struct path *path, const loff_t *ppos,
-			 size_t count);
+			 u64 count);
 
 #else
 
 static inline int fsnotify_pre_content(const struct path *path,
-				       const loff_t *ppos, size_t count)
+				       const loff_t *ppos, u64 count)
 {
 	return 0;
 }

base-commit: 045958acaa75205b31578cb22c4345e28dd2e4bf
-- 
2.43.0

