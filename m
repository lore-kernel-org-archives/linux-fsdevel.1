Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCEF1E25F9;
	Wed, 29 Apr 2026 14:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777474077; cv=none; b=iXRq0x+o5XEUqYXerGE26RwTqAMIUzs7FAb8+jiFLLCrtsalpeBhW2mk0OXlPHPpvaINsK9WPi1CQxOcfU3EJbeDFbEJv+b8+ckwHySpee8YvkEjMT/BelzAMrzpzTlY3JUfdxi1lByv7KcI4Gft2C04IiXoKZFc9t/tmlOAL+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777474077; c=relaxed/simple;
	bh=4Lms4kYYydf84jyygKCmjTAKKSofL69ucOlAhyzzaiQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=csINEm4XID1mUvxJImhk+04uGBRF24NrFqq3G4YIKDe1flAVFE+jPsllg9s/jU+oywPizAGsqjhClA9EMjptw8iK8El4AiRHtSVzCgdjqLpvMwviuB207uUQGwWUIjwYW2JqVNeKHEI69w14ETSNd15rj1mLg9war3TWfUBl4UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqJLLOVY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqJLLOVY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9CFC19425;
	Wed, 29 Apr 2026 14:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777474077;
	bh=4Lms4kYYydf84jyygKCmjTAKKSofL69ucOlAhyzzaiQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=FqJLLOVYKqKCw2XyKhbRKKQzesOwp2iS4v4AODG08z3ScLWFy6t2q5QP5lQ0V4JPv
	 znCGzzS6jsC+NNSOh2aY7NYMUQatFMD4E5CYzv2MLIuPbNW+jUV2UN6Yi79i7AHxrw
	 tbq+PxqtFFOtMwA9SZu9WsGTq9yBlheZG7agdlkD9Z/zdl3ebRf8e4Y9SaUzK4+Umn
	 S7frmycsMq9IcJ+luS3z+11oXuLQuSVbfGIx/o3GG0+UVrgtTKWrcgBjGkIDmX0Dvn
	 CqsA1pLIL0q5oD9+bXar41Mf1B+JspM3FOINqE+8v3KxEt4L5S8gb2j9Mjcm6Zc09H
	 fBoBbwInDWAnA==
Date: Wed, 29 Apr 2026 07:47:56 -0700
Subject: [PATCH 3/7] example/iomap_ll: implement atomic writes
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, john@groves.net,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747212932.4106066.9622633974847233518.stgit@frogsfrogsfrogs>
In-Reply-To: <177747212852.4106066.65045387245092140.stgit@frogsfrogsfrogs>
References: <177747212852.4106066.65045387245092140.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

If the block device supports atomic writes, we will too.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 example/single_file.h |    2 ++
 example/iomap_ll.c    |    5 +++++
 example/single_file.c |   40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)


diff --git a/example/single_file.h b/example/single_file.h
index 38e147ee24d331..76f2cd6eb80529 100644
--- a/example/single_file.h
+++ b/example/single_file.h
@@ -59,6 +59,7 @@ struct single_file {
 	bool require_bdev;
 	bool uses_iomap;
 
+	int awu_min, awu_max;
 	unsigned int blocksize;
 
 	struct timespec atime;
@@ -132,6 +133,7 @@ int single_file_configure(const char *device, mode_t expected_fmt,
 			  const struct single_file_ops *fops);
 int single_file_configure_simple(const char *filename,
 				 const struct single_file_ops *fops);
+void single_file_configure_atomic_write(void);
 void single_file_close(void);
 
 ssize_t single_file_pwrite(const char *buf, size_t count, off_t pos);
diff --git a/example/iomap_ll.c b/example/iomap_ll.c
index 0388400af2efd0..9824172be4afa4 100644
--- a/example/iomap_ll.c
+++ b/example/iomap_ll.c
@@ -135,6 +135,8 @@ static int iomap_iomap_config_devices(void)
 		return ret;
 	}
 
+	single_file_configure_atomic_write();
+
 	ret = ioctl(single_file.backing_fd, BLKBSZSET, &blocksize);
 	if (ret) {
 		printf("%s: cannot set block size %u: %s\n",
@@ -338,6 +340,9 @@ static void iomap_ll_iomap_begin(fuse_req_t req, fuse_ino_t ino,
 		goto out_unlock;
 	}
 
+	if (opflags & FUSE_IOMAP_OP_ATOMIC)
+		read.flags |= FUSE_IOMAP_F_ATOMIC_BIO;
+
 	if (ll.debug)
 		fprintf(stderr,
 			"%s: offset 0x%llx length 0x%llx type %u dev %u addr 0x%llx flags 0x%x\n",
diff --git a/example/single_file.c b/example/single_file.c
index 5af17e539c566c..401bdf7afae6c8 100644
--- a/example/single_file.c
+++ b/example/single_file.c
@@ -34,6 +34,7 @@
 #define USE_SINGLE_FILE_HL_API
 #include "single_file.h"
 
+#define max(x, y) ((x) > (y) ? (x) : (y))
 #define min(x, y) ((x) < (y) ? (x) : (y))
 
 #if __has_attribute(__fallthrough__)
@@ -223,6 +224,8 @@ static bool sf_stat(fuse_ino_t ino, struct single_file_stat *llstat)
 			llstat->iflags |= FUSE_IFLAG_SYNC;
 		if (single_file.ro)
 			llstat->iflags |= FUSE_IFLAG_IMMUTABLE;
+		if (single_file.awu_min > 0 && single_file.awu_max > 0)
+			llstat->iflags |= FUSE_IFLAG_ATOMIC;
 	}
 
 	return true;
@@ -288,6 +291,15 @@ static bool sf_statx(fuse_ino_t ino, int statx_mask, struct statx *stx)
 		stx->stx_ctime.tv_nsec = single_file.ctime.tv_nsec;
 		stx->stx_btime.tv_sec = startup_time.tv_sec;
 		stx->stx_btime.tv_nsec = startup_time.tv_nsec;
+
+#ifdef STATX_WRITE_ATOMIC
+		if (single_file.awu_min > 0 && single_file.awu_max > 0) {
+			stx->stx_mask |= STATX_WRITE_ATOMIC;
+			stx->stx_atomic_write_unit_min = single_file.awu_min;
+			stx->stx_atomic_write_unit_max = single_file.awu_max;
+			stx->stx_atomic_write_segments_max = 1;
+		}
+#endif
 	} else {
 		return false;
 	}
@@ -1095,6 +1107,34 @@ int single_file_configure_simple(const char *filename,
 	return 0;
 }
 
+#ifdef STATX_WRITE_ATOMIC
+void single_file_configure_atomic_write(void)
+{
+	struct statx devx;
+	unsigned int awu_min, awu_max;
+	int ret;
+
+	ret = statx(single_file.backing_fd, "", AT_EMPTY_PATH, STATX_WRITE_ATOMIC, &devx);
+	if (ret)
+		return;
+	if (!(devx.stx_mask & STATX_WRITE_ATOMIC))
+		return;
+
+	awu_min = max(single_file.blocksize, devx.stx_atomic_write_unit_min);
+	awu_max = min(single_file.blocksize, devx.stx_atomic_write_unit_max);
+	if (awu_min > awu_max)
+		return;
+
+	single_file.awu_min = awu_min;
+	single_file.awu_max = awu_max;
+}
+#else
+void single_file_configure_atomic_write(void)
+{
+	single_file.awu_min = single_file.awu_max = 0;
+}
+#endif
+
 void single_file_close(void)
 {
 	close(single_file.backing_fd);

