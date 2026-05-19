Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5465D49219F
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 11:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188670; cv=none; b=bAwqYDDU4Mdk1D4F4iDz+fIAInJfUt2skawkW5zMbIjFpbrcJKhKTS+WqyCgWDVNMySsalbxdCYvNeRrCAvKQZ3Q7bLL/44363XwJc7Tf3KwXWKVR4HGyEd/S/qT+v9ShzdHOe72oNln9e1JOpOkD8nBaDn2vcYV8TW3ZwyOgn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188670; c=relaxed/simple;
	bh=qDrD2ZddrAheagdk3eIgrfALWmcsf4CIV39O7dRnNk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mhK0DtGo6FSaAzMSq45+WEu8OttwSofWQYdRR6ZcUq+2zYsFExiE1Ajh1QpzlvATPRLm1TQA3owvlpHrDZOUTf2LJKBq6fhhxBxkgmuYTfeYHxFyVSDegBmP7AG3h2ImrN1lxFo7LNIb8ob7127dzPJP55tnGc2mUcRPMcmowuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYnobYIx; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYnobYIx"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7bdc947aaa3so26614547b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 04:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779188667; x=1779793467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+1n624ktIAXNe/+aIK+Qahfn51hvIzEeSL35mTG/Bo=;
        b=hYnobYIxc3S/ERDv29tAajOaM2F80ioGvZ9PK4JJZ0K9k8hNTk4pGnN0d2FmM77ZHb
         rehKx0QtoEovUfXjlJNNxQhgBzjM5iotRDqStmVL7AsOOIgreSdD+gIB9qBtgojp0sJd
         cP6xPpmEXGwv3i9m5fT/yFwKuAEts1oNhgqpE9+hhjAU0CnHB7sNSoRvAaiepnb9VEhA
         RCHhwgSIEkOqP9TtisW2Lp3b6h2HD+Y6KQF1xAbRCSpjP2l1F3lljmmHgvTvACQv5VtM
         qVz4fPpkVHC2D59Hpksv4gb/BqlwJS64O2vN47oe+W2qqfA85sUw35JrGfQtFJSY3kF6
         uAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779188667; x=1779793467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d+1n624ktIAXNe/+aIK+Qahfn51hvIzEeSL35mTG/Bo=;
        b=h71n+o2xWoqq6n9EX4qux3Y0nMLoJWqz2t74dJi5PGkV49ByXeeVR/D8llxsBgt452
         KYEyJl5lI0xFPS9AKir83zPaUMez/pkCGZtprNgK9lFrMcsjTHjcfI9U7TWtgD7KJN60
         hiS4ZGfxPtpOAY0yNR7asAQpvp+PDCuQB+75hGjqjjTD8NX0hAUV7Q16+R9fQkEKoC8Y
         SjJqeT9fMi/ZL5VUcsMHHfwNH860un+JWbruTVXe9bg83Yk77AlARrXCMqBsN8c8VnZh
         8UK77AqQDR3pHWMWHbzSYfsur8DjbvyPrPZyjVWSwC9aIbTe66u7l8Gb9D8wMl/Ie2J1
         l/KA==
X-Forwarded-Encrypted: i=1; AFNElJ8pcaN1aVT+RIZOayP/HadKghEL/WshqroiQm1eWiHdf+PHtMVa0wyVSmLmciiVj4LklHA0Xf+bNzRjamEn@vger.kernel.org
X-Gm-Message-State: AOJu0YwDghKfladt9/b/+oquVrXvghSjJ0v1q/Bx14VAwwDQJ45MOAyn
	FDZvzxIiOrv2kVVlDTNj4fL3SmZKvotmZflhWD5+b7XPvt/LMqMrAJFC0vXktaj3
X-Gm-Gg: Acq92OFUkrQ0jiW5v+N+wGA1gXd0VS1Y1Bo3z46T+WqsyJzj8ARkF9b4VMEewLkRgJg
	cQ3wy5tB8Itkn9uLDr+TCZYzOeykQU7aSazFs5x/El9EKqQjgs8NE1tW0z82VpomZHnn+SayChF
	F7GbyKz52vvLJ2cn1CN1xBArihiW8viegCE5NvUpusn3Q7VMMVOVIPJ4HtZMsW5es74CO+y1KL9
	opM47MYzyWlNYSEdP0B5oy5cbSlalfTLDSuWOwgrqYAWlW0qi41pq/a8yDOGl6CjQZuDcsJKWDS
	o6d9C6Bv7rhFOGQJ18HtElHLmKOhskzfOGuEw2N3xNWbE39/mgRjbOSdJ448B2xB1E1l2r6s0ib
	vVfgYvSAzyrObYy0FE8gk+jn62Dd5osxvR21aqEnraOM9kNz9gQrtyoyF3FiXIxauMMwTC6lkdx
	uYMv/fq2StD25WDLGvYgYujL8NO8h6S/fz0L1MiHQuyojFN/GYfwrYMG1XNUgLjLaeeHVykFC9P
	wz5WGhQUDMRY16e7iCEMZtg9Jz7xvo=
X-Received: by 2002:a05:690c:f15:b0:79f:3715:1980 with SMTP id 00721157ae682-7c95a37c674mr220804827b3.12.1779188667319;
        Tue, 19 May 2026 04:04:27 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9bc0ccf7sm35206827b3.25.2026.05.19.04.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 04:04:26 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>
Cc: ZhengYuan Huang <gality369@gmail.com>,
	ocfs2-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] ocfs2: reject non-inline dinodes with i_size and zero i_clusters
Date: Tue, 19 May 2026 07:04:04 -0400
Message-ID: <20260519110404.1803902-4-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519110404.1803902-1-michael.bommarito@gmail.com>
References: <20260519110404.1803902-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On a volume mounted without OCFS2_FEATURE_INCOMPAT_SPARSE_ALLOC, a
non-inline regular file with non-zero i_size and zero i_clusters is
structurally malformed: the extent map declares no allocated clusters
yet the size header claims content exists.  Keep rejecting that shape,
but express it through a shared predicate so the same invariant is
available to normal inode reads and online filecheck.

The same zero-cluster shape is also malformed for non-inline directories.
ocfs2 directory growth allocates backing storage before advancing
i_size, and ocfs2_dir_foreach_blk_el() later walks until ctx->pos reaches
i_size_read(inode).  A forged directory dinode with a huge i_size and no
clusters would repeatedly fail on holes while advancing through the
claimed size.

Sparse regular files remain exempt: on sparse-alloc volumes, truncate can
legitimately grow i_size without allocating clusters.  System inodes and
inline-data dinodes also retain their separate storage rules.

Mirror the check in ocfs2_filecheck_validate_inode_block() as well.
filecheck reports through its own error namespace, so malformed
size/cluster state is logged as a filecheck invalid-inode result rather
than via ocfs2_error(), but it must not proceed into
ocfs2_populate_inode().

Fixes: b657c95c1108 ("ocfs2: Wrap inode block reads in a dedicated function.")
Cc: stable@vger.kernel.org
Link: https://sashiko.dev/#/patchset/20260517111015.3187935-1-michael.bommarito%40gmail.com
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
 fs/ocfs2/inode.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 992980ea98046..432eac01c1763 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -82,6 +82,24 @@ static bool ocfs2_dinode_has_unexpected_rdev(struct ocfs2_dinode *di)
 	return !S_ISCHR(mode) && !S_ISBLK(mode) && di->id1.dev1.i_rdev != 0;
 }
 
+static bool ocfs2_dinode_has_size_without_clusters(struct super_block *sb,
+						   struct ocfs2_dinode *di)
+{
+	umode_t mode = le16_to_cpu(di->i_mode);
+
+	if (le32_to_cpu(di->i_flags) & OCFS2_SYSTEM_FL)
+		return false;
+	if (le16_to_cpu(di->i_dyn_features) & OCFS2_INLINE_DATA_FL)
+		return false;
+	if (!le64_to_cpu(di->i_size) || le32_to_cpu(di->i_clusters))
+		return false;
+
+	if (S_ISDIR(mode))
+		return true;
+
+	return !ocfs2_sparse_alloc(OCFS2_SB(sb)) && S_ISREG(mode);
+}
+
 void ocfs2_set_inode_flags(struct inode *inode)
 {
 	unsigned int flags = OCFS2_I(inode)->ip_attr;
@@ -1563,6 +1581,33 @@ int ocfs2_validate_inode_block(struct super_block *sb,
 		goto bail;
 	}
 
+	/*
+	 * Non-inline directories must not have i_size without allocated
+	 * clusters: directory growth adds storage before advancing i_size,
+	 * and readdir walks i_size block-by-block.  A forged directory
+	 * with zero clusters and a huge i_size would repeatedly fault on
+	 * holes while advancing through the claimed size.
+	 *
+	 * Non-inline regular files have the same invariant on non-sparse
+	 * volumes.  Sparse regular files are different: truncate can
+	 * legitimately grow i_size without allocating clusters, so keep
+	 * the sparse-alloc carveout for S_IFREG only.  System inodes and
+	 * inline-data dinodes have their own storage rules.
+	 */
+	if (ocfs2_dinode_has_size_without_clusters(sb, di)) {
+		if (S_ISDIR(le16_to_cpu(di->i_mode)))
+			rc = ocfs2_error(sb,
+					 "Invalid dinode #%llu: directory i_size %llu with i_clusters 0 and no inline-data flag\n",
+					 (unsigned long long)bh->b_blocknr,
+					 (unsigned long long)le64_to_cpu(di->i_size));
+		else
+			rc = ocfs2_error(sb,
+					 "Invalid dinode #%llu: regular file i_size %llu with i_clusters 0 and no inline-data flag on non-sparse volume\n",
+					 (unsigned long long)bh->b_blocknr,
+					 (unsigned long long)le64_to_cpu(di->i_size));
+		goto bail;
+	}
+
 	if (le16_to_cpu(di->i_dyn_features) & OCFS2_INLINE_DATA_FL) {
 		struct ocfs2_inline_data *data = &di->id2.i_data;
 
@@ -1712,6 +1757,21 @@ static int ocfs2_filecheck_validate_inode_block(struct super_block *sb,
 		     le16_to_cpu(di->i_mode),
 		     (unsigned long long)le64_to_cpu(di->id1.dev1.i_rdev));
 		rc = -OCFS2_FILECHECK_ERR_INVALIDINO;
+		goto bail;
+	}
+
+	if (ocfs2_dinode_has_size_without_clusters(sb, di)) {
+		if (S_ISDIR(le16_to_cpu(di->i_mode)))
+			mlog(ML_ERROR,
+			     "Filecheck: invalid dinode #%llu: directory i_size %llu with i_clusters 0 and no inline-data flag\n",
+			     (unsigned long long)bh->b_blocknr,
+			     (unsigned long long)le64_to_cpu(di->i_size));
+		else
+			mlog(ML_ERROR,
+			     "Filecheck: invalid dinode #%llu: regular file i_size %llu with i_clusters 0 and no inline-data flag on non-sparse volume\n",
+			     (unsigned long long)bh->b_blocknr,
+			     (unsigned long long)le64_to_cpu(di->i_size));
+		rc = -OCFS2_FILECHECK_ERR_INVALIDINO;
 	}
 
 bail:
-- 
2.53.0
