Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F112FA0C6;
	Sat, 29 Aug 2026 04:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787978469; cv=none; b=IozDo+XY71HQPVkGxiZhwG38O2ZjxkpUXcJaEzXUhXwbryE+g3F+hfJWdmbFaw+wIf6IysfTq5mAERw03QpbiLuxurrpmrnP6nD7U8wnSJ2+jIWZKsNlRmgQmFhOYPP+4y1uu20vKJudy1LbypR95wExawbDOiqxaTFb0knGIE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787978469; c=relaxed/simple;
	bh=2II95OXJXOkKiEoXYBuOZjT5qcX4TdXv1W0z3wcoh3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejQ3EijgxiWJVYjRRuVc3XM1P+5zeq10hK8hbJ28fLvA+nXlYSwJXCYCZ8O4t36cU9XwGnb5dj7Dq5SdnsvCfhXE4WoxdwTAhNPSjNITQccgZrFZH6aceNuj+1Z4qaubq7z6RD5UvLu9qw/BanEHE/ogTM0+i4T88SrDGdfB7P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kVG5OWwz; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kVG5OWwz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787978468; x=1819514468;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2II95OXJXOkKiEoXYBuOZjT5qcX4TdXv1W0z3wcoh3Y=;
  b=kVG5OWwzii6jHnaSCWS14n7gFw5YiQ9cNBY5jfiMbDWsvLWHiVu6Olem
   xXwnX0hHKxiBYp9+C6tb9T8os9FJidu5s0LL50xtkWFhC1AMXJeABRPk1
   d73np/1BgJjKgHWYqp04KuZ1syEdRBl86Q369Fd3AOCiDPyIvlEToIcQx
   h1IZCvQ9ZFn6Xj6qJJDVsbJWFNiiLdxGgazvyf07LMCr/ej5FFJgzdVQT
   iJ2kLFFDOrxo0k82b2od0NKcjhD0Al9IfIPL7uv8nUBGrycV48HghIuRy
   DcEiDs4XDcXYcevm0iRkRd5Q5jvpKpULAuzGPfXKkizkU5iXMy88DpzIY
   g==;
X-CSE-ConnectionGUID: /I6n95BeR02a57Dl6rLA/g==
X-CSE-MsgGUID: 2v+7rYWGQym/591BgLjfYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11889"; a="88683917"
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; 
   d="scan'208";a="88683917"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 21:41:08 -0700
X-CSE-ConnectionGUID: cQD99vGjTMO70sDaQBOW0g==
X-CSE-MsgGUID: 46PDy14TRb23Kckm0tcnRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; 
   d="scan'208";a="266533030"
Received: from pankris-x299-ud4-pro.bj.intel.com ([10.238.152.122])
  by orviesa006.jf.intel.com with ESMTP; 28 Aug 2026 21:41:05 -0700
From: Kris Pan <kris.pan@intel.com>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	hughd@google.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	arnd@arndb.de,
	max.kellermann@ionos.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kris Pan <kris.pan@intel.com>
Subject: [PATCH v2 1/2] fs: move splice_zeropage_into_pipe() and zero_pipe_buf_ops to fs/splice.c
Date: Sat, 29 Aug 2026 12:37:45 +0800
Message-ID: <20260829043746.2929210-2-kris.pan@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260829043746.2929210-1-kris.pan@intel.com>
References: <20260829043746.2929210-1-kris.pan@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The zero-page splice logic in mm/shmem.c (zero_pipe_buf_ops and
splice_zeropage_into_pipe()) is generally useful for any file that wants
to splice zero pages into a pipe, such as /dev/zero and /dev/full.

Move them to fs/splice.c next to the other pipe buffer operations and
declare them in include/linux/splice.h so they can be shared by other
callers without duplicating the boilerplate.

No functional change.

Signed-off-by: Kris Pan <kris.pan@intel.com>
---
 fs/splice.c            | 62 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/splice.h |  3 ++
 mm/shmem.c             | 45 ------------------------------
 3 files changed, 65 insertions(+), 45 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 9d8f63e2fd1ab..b6ea98cc62fd5 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -398,6 +398,68 @@ ssize_t copy_splice_read(struct file *in, loff_t *ppos,
 }
 EXPORT_SYMBOL(copy_splice_read);
 
+/*
+ * Pipe buffer operations for splicing zero pages into a pipe, used to
+ * optimize reads from sparse holes in files and from zero devices such as
+ * /dev/zero and /dev/full.
+ */
+static bool zero_pipe_buf_get(struct pipe_inode_info *pipe,
+			      struct pipe_buffer *buf)
+{
+	return true;
+}
+
+static void zero_pipe_buf_release(struct pipe_inode_info *pipe,
+				  struct pipe_buffer *buf)
+{
+}
+
+static bool zero_pipe_buf_try_steal(struct pipe_inode_info *pipe,
+				    struct pipe_buffer *buf)
+{
+	return false;
+}
+
+const struct pipe_buf_operations zero_pipe_buf_ops = {
+	.release	= zero_pipe_buf_release,
+	.try_steal	= zero_pipe_buf_try_steal,
+	.get		= zero_pipe_buf_get,
+};
+
+/**
+ * splice_zeropage_into_pipe - splice a zero page into a pipe
+ * @pipe: pipe to splice into
+ * @fpos: file position
+ * @size: number of bytes to splice
+ *
+ * Splice at most one page of zeroes into the pipe.  The zero page is not
+ * refcounted, so @zero_pipe_buf_ops must be used to avoid taking a
+ * reference on it.
+ *
+ * Return: the number of bytes spliced.
+ */
+size_t splice_zeropage_into_pipe(struct pipe_inode_info *pipe,
+				 loff_t fpos, size_t size)
+{
+	size_t offset = fpos & ~PAGE_MASK;
+
+	size = min_t(size_t, size, PAGE_SIZE - offset);
+
+	if (!pipe_is_full(pipe)) {
+		struct pipe_buffer *buf = pipe_head_buf(pipe);
+
+		*buf = (struct pipe_buffer) {
+			.ops	= &zero_pipe_buf_ops,
+			.page	= ZERO_PAGE(0),
+			.offset	= offset,
+			.len	= size,
+		};
+		pipe->head++;
+	}
+
+	return size;
+}
+
 const struct pipe_buf_operations default_pipe_buf_ops = {
 	.release	= generic_pipe_buf_release,
 	.try_steal	= generic_pipe_buf_try_steal,
diff --git a/include/linux/splice.h b/include/linux/splice.h
index 9dec4861d09f6..f1d4aefa4ec2c 100644
--- a/include/linux/splice.h
+++ b/include/linux/splice.h
@@ -108,4 +108,7 @@ extern void splice_shrink_spd(struct splice_pipe_desc *);
 
 extern const struct pipe_buf_operations page_cache_pipe_buf_ops;
 extern const struct pipe_buf_operations default_pipe_buf_ops;
+extern const struct pipe_buf_operations zero_pipe_buf_ops;
+size_t splice_zeropage_into_pipe(struct pipe_inode_info *pipe, loff_t fpos,
+				 size_t size);
 #endif
diff --git a/mm/shmem.c b/mm/shmem.c
index 9001aaf3b7b94..39d8dfefbe9f5 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3427,51 +3427,6 @@ static ssize_t shmem_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	return ret;
 }
 
-static bool zero_pipe_buf_get(struct pipe_inode_info *pipe,
-			      struct pipe_buffer *buf)
-{
-	return true;
-}
-
-static void zero_pipe_buf_release(struct pipe_inode_info *pipe,
-				  struct pipe_buffer *buf)
-{
-}
-
-static bool zero_pipe_buf_try_steal(struct pipe_inode_info *pipe,
-				    struct pipe_buffer *buf)
-{
-	return false;
-}
-
-static const struct pipe_buf_operations zero_pipe_buf_ops = {
-	.release	= zero_pipe_buf_release,
-	.try_steal	= zero_pipe_buf_try_steal,
-	.get		= zero_pipe_buf_get,
-};
-
-static size_t splice_zeropage_into_pipe(struct pipe_inode_info *pipe,
-					loff_t fpos, size_t size)
-{
-	size_t offset = fpos & ~PAGE_MASK;
-
-	size = min_t(size_t, size, PAGE_SIZE - offset);
-
-	if (!pipe_is_full(pipe)) {
-		struct pipe_buffer *buf = pipe_head_buf(pipe);
-
-		*buf = (struct pipe_buffer) {
-			.ops	= &zero_pipe_buf_ops,
-			.page	= ZERO_PAGE(0),
-			.offset	= offset,
-			.len	= size,
-		};
-		pipe->head++;
-	}
-
-	return size;
-}
-
 static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
 				      struct pipe_inode_info *pipe,
 				      size_t len, unsigned int flags)
-- 
2.43.0

