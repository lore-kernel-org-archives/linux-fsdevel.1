Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D10175A7B
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 00:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782864738; cv=none; b=YrGs5ceqFTO0EV0IXuttGYdn1gk6qEFWDMn96Qx6IqXXaKpLWMue3IT1QvR1CiyLyf2Lc3MgYEyLAHEF4irNepbb4wyJVUzIJAxOX+Leas6BQ05c+hMkpDc+xMfT6PDavbP/m83r3pA7j2BOgBVbUxdffSaMKtOMDV6Xuqj+SbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782864738; c=relaxed/simple;
	bh=8T/d74ERA6AaCGM4cvzp+ExTmXzK0rpUXpvgoIg5y/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ujJi//O8Wh+Hl1U3ecrMQVAt2IjJUxHICwv8l2l88AhbEtW2A4oZBf51ENiD6iB4F0RESq0JCYLoPXPUfulcyQhcRdY2szf+95EjYrLVkeMXjCnL+9gYG/xflAv3sNMcQZ9KiwFcVaa/4dxGQtBdEMLwyRC4jOYL4ykJeIlWWnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGB8YJsF; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGB8YJsF"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4896ae35be9so59905b6e.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 17:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782864736; x=1783469536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmKA1vAG4G3zbLqRzYjs4WI66ubpxbJgQ7xE4kIKrFg=;
        b=XGB8YJsFAcOLjMAanJPQH/z/lgzJIdNJe4cldhDavZWo4mDEdV8Qi+cxay3xBnnET+
         KoKkJTjqsfMSl4HXAgM6NEINIDzR/V/OzXwzd/U/AvcIp1SvBna7o+uSGUclFoIdUX/U
         wncZ1NABcdwSnkfgEnzYOIsu2HaN+ww0hiId9hkUBCgaLeKgO8QFeT8biWTPNZyioeow
         yICQJ93yEEeVmUBEBTsN00JiiDP5ukl1Cm+mbgzvnom/HV/lWQlE+rfVGg+sM2ogrebK
         IZc8FnGv7mpCq3ADbn0jOCiUSiaWaGWYYJA/wynliv5jk+AHF5Fg6j5vVNa0pa/2cmSY
         VS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782864736; x=1783469536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wmKA1vAG4G3zbLqRzYjs4WI66ubpxbJgQ7xE4kIKrFg=;
        b=ZTvwnByMjeOhKSAU4FyHOr/kyRyeWzKwxcU/ic1cYj3ei8S56mVZ4ckFVxr1LccMvc
         c35j2m3HCxu/OyHvDX3/AFDjIAtyXVIGPBa5vdmtI7ydjLbJMLB6gPJFbHwjIbMWF+po
         ukFg3k5B+j1C9bUQJcWynqDw0E1sXv0TdqI2Os9HfvSrdaHtynt9qhEijEl/d2AJLWEl
         7pn92EE+aijfo0FGBOj7/NC5rL80uWrJIL20thdc82CKc8p42x2/3NZNyEIxe1q8/kIL
         FYgTI0YcLQJSgmHYxRlvBzY/9F2Ez3nMupSxT9qkaoqwL3T0rcF0t/lm9yvzBRyBWSRq
         iehg==
X-Forwarded-Encrypted: i=1; AFNElJ+JUIyw9KY+gsPWRVzrj17/tSD5583c4cQc0UPdXAmHxmHyrOq3nskfOTDjYyC091UBCvTkFMH2qi8xx1Fw@vger.kernel.org
X-Gm-Message-State: AOJu0YzRjeJHTakdqPDubcJYuJ9t/oEYPFAVsb/nt1Iht5uodhpDSfCI
	TYq4o5xM0OX1+3L9CTRMMbiTKslSvcWkrB1ksbrZsgAQHNumF2vIPY2R
X-Gm-Gg: AfdE7cmFSZ1txMMSyYJvzhLoQJd2Pocvk9syCDgXz5GreIq2RRhOuT1XVofXBwe079B
	n7LOjjtd7BUjE581Ge9nDvg+6WznPBhTKlDsq7JNVPGxOAajPI2+CGAKrFFflGyxgM8Pr42RqL2
	ZfssxOV0LxNhvpf1J0A3A9K+q9JsjLk1o5V18uG0BTEFgns3el+DZ8e2MP2Etu0dj7ry/4shS/a
	vm0KyX5ivKMaDOIeK6MjJk0k+1KSyca/pSFBayNcAz9gd+kmugAEQ91FKdvsyOSdycWmUU86ghV
	+A/6IemXZL4lOtSMl7F1ns+QjjUaMTm/mTijalM7BAmRmFH23JzFoGsvoY2f1MW/jCor26DlLCY
	NVnd6e9LqCYuGM9LyKkUT3c5O8xn9jAcHdi3pRS28ru7WyoeNrWzSb5+rBst7flxkg2S1Hj7IER
	5WA1Us1j0jV7mlB4Iqb9hSXa741hxq2hI+N0WLxyXsRWyC6w8YZHu+fpw9jSBdqQc=
X-Received: by 2002:a05:6808:4f0e:b0:489:5c86:ba9a with SMTP id 5614622812f47-495fd6520b5mr2332473b6e.19.1782864736060;
        Tue, 30 Jun 2026 17:12:16 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-49606ad46c4sm250409b6e.10.2026.06.30.17.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 17:12:14 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	hch@lst.de
Cc: djwong@kernel.org,
	willy@infradead.org,
	hsiangkao@linux.alibaba.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 16/18] iomap: remove ->iomap_begin()/->iomap_end() legacy path
Date: Tue, 30 Jun 2026 17:09:31 -0700
Message-ID: <20260701000949.1666714-17-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260701000949.1666714-1-joannelkoong@gmail.com>
References: <20260701000949.1666714-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With all in-tree filesystems implementing ->iomap_next(), drop the
->iomap_begin()/->iomap_end() path.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/iter.c       | 87 +++++--------------------------------------
 include/linux/iomap.h |  4 +-
 2 files changed, 11 insertions(+), 80 deletions(-)

diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index 1062e4e34c38..466c491bdef6 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -39,81 +39,6 @@ static inline void iomap_iter_done(struct iomap_iter *iter)
 		trace_iomap_iter_srcmap(iter->inode, &iter->srcmap);
 }
 
-static int iomap_iter_legacy(struct iomap_iter *iter, const struct iomap_ops *ops)
-{
-	bool stale = iter->iomap.flags & IOMAP_F_STALE;
-	ssize_t advanced;
-	u64 olen;
-	int ret;
-
-	trace_iomap_iter(iter, ops, _RET_IP_);
-
-	if (!iter->iomap.length)
-		goto begin;
-
-	/*
-	 * Calculate how far the iter was advanced and the original length bytes
-	 * for ->iomap_end().
-	 */
-	advanced = iter->pos - iter->iter_start_pos;
-	olen = iter->len + advanced;
-
-	if (ops->iomap_end) {
-		ret = ops->iomap_end(iter->inode, iter->iter_start_pos,
-				iomap_length_trim(iter, iter->iter_start_pos,
-						  olen),
-				advanced, iter->flags, &iter->iomap);
-		if (ret < 0 && !advanced)
-			return ret;
-	}
-
-	/* detect old return semantics where this would advance */
-	if (WARN_ON_ONCE(iter->status > 0))
-		iter->status = -EIO;
-
-	/*
-	 * Use iter->len to determine whether to continue onto the next mapping.
-	 * Explicitly terminate on error status or if the current iter has not
-	 * advanced at all (i.e. no work was done for some reason) unless the
-	 * mapping has been marked stale and needs to be reprocessed.
-	 */
-	if (iter->status < 0)
-		ret = iter->status;
-	else if (iter->len == 0 || (!advanced && !stale))
-		ret = 0;
-	else
-		ret = 1;
-	iomap_iter_clean_fbatch(iter);
-	iter->status = 0;
-	if (ret <= 0)
-		return ret;
-
-	memset(&iter->iomap, 0, sizeof(iter->iomap));
-	memset(&iter->srcmap, 0, sizeof(iter->srcmap));
-
-begin:
-	ret = ops->iomap_begin(iter->inode, iter->pos, iter->len, iter->flags,
-			       &iter->iomap, &iter->srcmap);
-	if (ret < 0)
-		return ret;
-	iomap_iter_done(iter);
-	return 1;
-}
-
-static int iomap_iter_next(struct iomap_iter *iter, const struct iomap_ops *ops)
-{
-	int ret;
-
-	trace_iomap_iter(iter, ops, _RET_IP_);
-
-	ret = ops->iomap_next(iter, &iter->iomap, &iter->srcmap);
-	iter->status = 0;
-	if (ret > 0)
-		iomap_iter_done(iter);
-
-	return ret;
-}
-
 /**
  * iomap_iter - iterate over a ranges in a file
  * @iter: iteration structue
@@ -131,10 +56,16 @@ static int iomap_iter_next(struct iomap_iter *iter, const struct iomap_ops *ops)
  */
 int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 {
-	if (ops->iomap_next)
-		return iomap_iter_next(iter, ops);
+	int ret;
+
+	trace_iomap_iter(iter, ops, _RET_IP_);
 
-	return iomap_iter_legacy(iter, ops);
+	ret = ops->iomap_next(iter, &iter->iomap, &iter->srcmap);
+	iter->status = 0;
+	if (ret > 0)
+		iomap_iter_done(iter);
+
+	return ret;
 }
 
 /**
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 8a78f47c557b..52d6f585b941 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -194,7 +194,7 @@ struct iomap_write_ops {
 };
 
 /*
- * Flags for iomap_begin / iomap_end.  No flag implies a read.
+ * Flags for iomap_next.  No flag implies a read.
  */
 #define IOMAP_WRITE		(1 << 0) /* writing, must allocate blocks */
 #define IOMAP_ZERO		(1 << 1) /* zeroing operation, may skip holes */
@@ -254,7 +254,7 @@ struct iomap_ops {
  *	incremental iter advance.
  * @status: Status of the most recent iteration. Zero on success or a negative
  *	errno on error.
- * @flags: Zero or more of the iomap_begin flags above.
+ * @flags: Zero or more of the iomap_next flags above.
  * @iomap: Map describing the I/O iteration
  * @srcmap: Source map for COW operations
  */
-- 
2.52.0

