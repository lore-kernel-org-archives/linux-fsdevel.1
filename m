Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6003C14F70
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 02:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782356016; cv=none; b=fJFRPmywzFpSMo3UrIj8RNbcc2hhXltmXNY9fR03YN2TCjewjF7zRoNCF7FJenKL6sUL+CDpa7y10r1dxqkNSGgNPKSBgbPYNLtSx11sEOkXy4tarw0dc53BW9rnY6MwgF7Cgi+m2Txkk5ilWrkDOHojpH3azcqDvYI0ZtH6GmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782356016; c=relaxed/simple;
	bh=vE+ayCFKFJgL9HTzaxTWh14mGeDix41HXqLlUqJgyO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zobi/5OdK3XHexxoVyeS8WappPayZXSzDoMlOH1So3bb3y6zmi7eDl3pRv6aE219Mprj512sueutOvPYLA3BWA7+c2djhWJ0YqbK6Ip/GS64GrpzeLlfqVvWNxJC0+iOV9uDUWxkC2zINGm9QxtiKTD4JfpBTzRjGoZcpU7dsUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNt0bJJR; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNt0bJJR"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-491bc1d4e6bso433710b6e.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 19:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782356014; x=1782960814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Zbueh2ityAHZA4U7D8Z3VOgjl2yU1rjJ4PT7HHYhQ0=;
        b=MNt0bJJRMXUG6djC668emj+1Tz6+Jee0gCxibWG8fC27zkGfnaPk4VcaYfFeivCdSe
         gPtZRgz0LlhNDPpObfwGPdQUkC+naNowmXYUMf2C5AGIJvzyvKQBrO1PdUcNJB6Hoa+h
         HiACZVFlGnxj+nuvIcjKBpD2wdPbTfk3yjaYbZPswZdV3hH6cvhLzPxIyB2mvB0bND05
         iYpsB2KaXl0FkNmI3KL0kEHHiqo+H/2YVdiMn8ZoQsi6DuEY/6IW8HA6T5AcG9oAeKLN
         DctLTRZ8oBTiDWMpS/FXC0uKzPgbWMglqIy9hRqB8Vl9TJ4xKqPPI8QnGFLGhJQ+U2qE
         N4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782356014; x=1782960814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Zbueh2ityAHZA4U7D8Z3VOgjl2yU1rjJ4PT7HHYhQ0=;
        b=E2NSH9LGos6k8KL7eHMjii4NGcn+T3DXIseM+/iGTdocr/7y6V3SGWtUqnSRYumJbZ
         PeHbO4b40azCk88cmkv4g79GaALFl0v38BsrFb5aonkRqxzpGiozC9LA0+0Ot5uvSbiY
         tbnyF5gXjs4kTNszts6BmY97WdawMIhEeiKJ82ASK8Rtw0w8ZC1UuwgWTKqUHPrb6LGh
         nTY4FpwslvJOILzcSDYX5V7Kn6rzhSPTioqrBvJtl97ju0tjNlCRdBzyoPvC11pE9Bht
         JfoULW3UnWLC4MBOiVp+VKEYYd/dad3NwoPx9z6m2Dv/iTDRIJ3xbd7Tv90r4V1gAbNw
         lLUA==
X-Gm-Message-State: AOJu0YzlF1faHICQWVpEO/u2oF+775UK0586ox5fnlJK5K1VeU1vFh6+
	3qdAdrPeo66XJN1pXSokaZ7LrLTXQNoTokbhurJENWSQrSYWg3D1+Fc6
X-Gm-Gg: AfdE7cmswcKANsnAJVptD7FxHxtfFPEUKG28xJOXfhQG1X3TmWtcx0KeTIFwZieRsO1
	GrCx51IzI+O4N0nIiveTPRCvDdNr6Vzu8bEPJtjgQCP9Hd8iYglny/2AUhSxZxeuP0oQTv1iuC2
	iy+daqG47rD8RayhHPxzEEOmOMlumon+bXW7dA2gKWUjjgyzpJLj28im+EGSiI1NUDrTeX+2siI
	4vMnhwj4raz/TBhOKfz5YHBxbuDGWhWKEsj5QRLDoAhV0AHudjepyehKpu39Uj6/kzdDUUo60x/
	s7lRPkbeCz6+vi6JkxYjWa6TGEJFzrMNbJrWWL3ChO2VdKzctQWW8nG10S9n5JzUqT0C91+aKho
	DZX5GYNxhyw1tXcM3dGzbpCP/54muRHBEHvUgKVzqFCdz/WRSaPuXeduniP9b5rYmutLMbzXr+n
	bEZr1zgQWti4xfmWy0jmw2Oe8BYHgttnYubkHKOUr43S6lhV+agqjG6Z7V1NfWg3ogS5oa2sbIo
	z8=
X-Received: by 2002:a05:6808:3c45:b0:487:5b1f:2bce with SMTP id 5614622812f47-4921972b9acmr816241b6e.36.1782356014389;
        Wed, 24 Jun 2026 19:53:34 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e94429e0cesm12884714a34.21.2026.06.24.19.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 19:53:33 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: hch@lst.de,
	willy@infradead.org,
	djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [RFC PATCH v1 3/3] xfs: example of devirtualizing buffered write iomap callbacks
Date: Wed, 24 Jun 2026 19:47:23 -0700
Message-ID: <20260625024723.1611000-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260625024723.1611000-1-joannelkoong@gmail.com>
References: <20260625024723.1611000-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an example of what removing the indirect call would look like.
With the inlined iomap_buffered_write_inline() that gets passed
xfs_buffered_write_iomap_begin() and xfs_buffered_write_iomap_end() as
constant callbacks, the compiler is able to call the callbacks directly
and drop the indirect call through struct iomap_ops:

before:
callq  iomap_file_buffered_write
R_X86_64_32S   xfs_buffered_write_iomap_ops

after (direct calls, R_X86_64_PLT32 == direct):
callq  ...  R_X86_64_PLT32  xfs_buffered_write_iomap_begin-0x4
callq  ...  R_X86_64_PLT32  xfs_buffered_write_iomap_end-0x4

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c |  3 ++-
 fs/iomap/iter.c        |  3 ++-
 fs/xfs/xfs_file.c      | 26 ++++++++++++++++++++---
 fs/xfs/xfs_iomap.c     |  4 ++--
 fs/xfs/xfs_iomap.h     |  7 +++++++
 include/linux/iomap.h  | 47 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 83 insertions(+), 7 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 5a107d59ae27..12aa42f6497e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1153,7 +1153,7 @@ static bool iomap_write_end(struct iomap_iter *iter, size_t len, size_t copied,
 	return __iomap_write_end(iter->inode, pos, len, copied, folio);
 }
 
-static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
+int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
 		const struct iomap_write_ops *write_ops)
 {
 	ssize_t total_written = 0;
@@ -1259,6 +1259,7 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
 
 	return total_written ? 0 : status;
 }
+EXPORT_SYMBOL_GPL(iomap_write_iter);
 
 ssize_t
 iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index 2d5469996a51..a3edb16d3488 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -25,7 +25,7 @@ int iomap_iter_advance(struct iomap_iter *iter, u64 count)
 	return 0;
 }
 
-static inline void iomap_iter_done(struct iomap_iter *iter)
+void iomap_iter_done(struct iomap_iter *iter)
 {
 	WARN_ON_ONCE(iter->iomap.offset > iter->pos);
 	WARN_ON_ONCE(iter->iomap.length == 0);
@@ -38,6 +38,7 @@ static inline void iomap_iter_done(struct iomap_iter *iter)
 	if (iter->srcmap.type != IOMAP_HOLE)
 		trace_iomap_iter_srcmap(iter->inode, &iter->srcmap);
 }
+EXPORT_SYMBOL_GPL(iomap_iter_done);
 
 static int iomap_iter_legacy(struct iomap_iter *iter, const struct iomap_ops *ops)
 {
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 845a97c9b063..49f5d7f495dd 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1038,6 +1038,7 @@ xfs_file_buffered_write(
 {
 	struct inode		*inode = iocb->ki_filp->f_mapping->host;
 	struct xfs_inode	*ip = XFS_I(inode);
+	struct iomap_iter	iter;
 	ssize_t			ret;
 	bool			cleared_space = false;
 	unsigned int		iolock;
@@ -1053,9 +1054,28 @@ xfs_file_buffered_write(
 		goto out;
 
 	trace_xfs_file_buffered_write(iocb, from);
-	ret = iomap_file_buffered_write(iocb, from,
-			&xfs_buffered_write_iomap_ops, &xfs_iomap_write_ops,
-			NULL);
+
+	/*
+	 * Call inlined iomap buffered write and pass constant begin/end
+	 * function pointers so the compiler can devirtualize them and avoid the
+	 * indirect call through struct iomap_ops.
+	 */
+	iter = (struct iomap_iter){
+		.inode		= inode,
+		.pos		= iocb->ki_pos,
+		.len		= iov_iter_count(from),
+		.flags		= IOMAP_WRITE,
+	};
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		iter.flags |= IOMAP_NOWAIT;
+	if (iocb->ki_flags & IOCB_DONTCACHE)
+		iter.flags |= IOMAP_DONTCACHE;
+
+	ret = iomap_buffered_write_inline(&iter, from,
+			xfs_buffered_write_iomap_begin,
+			xfs_buffered_write_iomap_end, &xfs_iomap_write_ops);
+	if (ret > 0)
+		iocb->ki_pos = iter.pos;
 
 	/*
 	 * If we hit a space limit, try to free up some lingering preallocated
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 3b212bfe04d7..23b1885a1123 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1773,7 +1773,7 @@ xfs_zoned_buffered_write_iomap_begin(
 	return error;
 }
 
-static int
+int
 xfs_buffered_write_iomap_begin(
 	struct inode		*inode,
 	loff_t			offset,
@@ -2124,7 +2124,7 @@ xfs_buffered_write_delalloc_punch(
 			offset, offset + length, iter->private);
 }
 
-static int
+int
 xfs_buffered_write_iomap_end(
 	struct inode		*inode,
 	loff_t			offset,
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index ebcce7d49446..42183e4c461b 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -19,6 +19,13 @@ int xfs_iomap_write_unwritten(struct xfs_inode *, xfs_off_t, xfs_off_t, bool);
 xfs_fileoff_t xfs_iomap_eof_align_last_fsb(struct xfs_inode *ip,
 		xfs_fileoff_t end_fsb);
 
+int xfs_buffered_write_iomap_begin(struct inode *inode, loff_t offset,
+		loff_t count, unsigned flags, struct iomap *iomap,
+		struct iomap *srcmap);
+int xfs_buffered_write_iomap_end(struct inode *inode, loff_t offset,
+		loff_t length, ssize_t written, unsigned flags,
+		struct iomap *iomap);
+
 u64 xfs_iomap_inode_sequence(struct xfs_inode *ip, u16 iomap_flags);
 int xfs_bmbt_to_iomap(struct xfs_inode *ip, struct iomap *iomap,
 		struct xfs_bmbt_irec *imap, unsigned int mapping_flags,
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 335a3858601c..60dc977dca55 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -367,6 +367,8 @@ static inline bool iomap_want_unshare_iter(const struct iomap_iter *iter)
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops,
 		const struct iomap_write_ops *write_ops, void *private);
+int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
+		const struct iomap_write_ops *write_ops);
 int iomap_fsverity_write(struct file *file, loff_t pos, size_t length,
 		const void *buf, const struct iomap_ops *ops,
 		const struct iomap_write_ops *write_ops);
@@ -689,4 +691,49 @@ static __always_inline int iomap_process(const struct iomap_iter *iter,
 	return ret < 0 ? ret : 1;
 }
 
+void iomap_iter_done(struct iomap_iter *iter);
+
+/*
+ * Inline version of the ->iomap_next call for performance-critical callers.
+ * When inlined at a call site that passes constant begin / end function
+ * pointers, the begin and end calls are called directly and avoid the indirect
+ * call through struct iomap_ops.
+ */
+static __always_inline int iomap_iter_inline(struct iomap_iter *iter,
+		iomap_begin_fn begin, iomap_end_fn end)
+{
+	int ret = iomap_process(iter, &iter->iomap, &iter->srcmap, begin, end);
+
+	if (ret > 0) {
+		iter->status = 0;
+		iomap_iter_done(iter);
+	}
+	return ret;
+}
+
+/*
+ * Inline buffered write loop for callers that can supply constant begin and end
+ * callbacks. This lets the compiler devirtualize the mapping calls and drop the
+ * indirect call through struct iomap_ops. The passed-in iter should be
+ * initialized by the caller. This will advance the iter by the number of bytes
+ * that get successfully written.
+ *
+ * This returns the number of bytes written or a negative error.
+ */
+static __always_inline ssize_t iomap_buffered_write_inline(
+		struct iomap_iter *iter, struct iov_iter *i,
+		iomap_begin_fn begin, iomap_end_fn end,
+		const struct iomap_write_ops *write_ops)
+{
+	loff_t start_pos = iter->pos;
+	ssize_t ret;
+
+	while ((ret = iomap_iter_inline(iter, begin, end)) > 0)
+		iter->status = iomap_write_iter(iter, i, write_ops);
+
+	if (iter->pos == start_pos)
+		return ret;
+	return iter->pos - start_pos;
+}
+
 #endif /* LINUX_IOMAP_H */
-- 
2.52.0

