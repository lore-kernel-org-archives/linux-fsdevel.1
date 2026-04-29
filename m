Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883C7318ED7;
	Wed, 29 Apr 2026 14:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472575; cv=none; b=DR+4Sa2BcE6lwmqTQHWTXhR+KP6uJqJJpN9Rpkhm3NabQxkpWWpMesfBy/nxX3TEmhEQn8G7XfxPL/8nicEAeaw+S6ReIQ+XQaK9uw3s9yihX43vS/3i3o3RXCGRZTZxtk44qMvNtoHuGNxKBUwqA7l/hNvUGF4Kzc+jn7+PmPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472575; c=relaxed/simple;
	bh=JYNx+hoHEqTlNkG8nYboxrdkeGkr/VZZuQ7CuhHx0Zc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oSgEXD2EXddgXCa7Tu3b7bSa0OORE46g0PliA9UKMg9YMVi2Q8Amc6XRvRwi6bCmGWfN138umVfiO+1VIp+lec7Eo4oirkqZJ5AiYlw8sHZ9UbZaeqHsAbyKNXAiYXqhVzKJBlKvH20q7tu3aOLaGvQmrBtQ5Mw89erp8z09hFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKeqrvLw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKeqrvLw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32ECAC19425;
	Wed, 29 Apr 2026 14:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472575;
	bh=JYNx+hoHEqTlNkG8nYboxrdkeGkr/VZZuQ7CuhHx0Zc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=bKeqrvLwCmiEQSE7h988sbaiWMUvLT8EVQ/dmsjsaMvYlTKKWOU66WLccIM+gb8Li
	 PIGZXiMm2WxuzO2bB8pXVpv5WjJ3xVISi+ZJc16uNv6CmAungHcGsrTIxXfjYKWu0K
	 mhGFmxCMwaICee/pJVK6MPcncSjp0onLB4vzyG/ruxA37jozcSmk6G1OIZuOh95Syb
	 517BKiRAjJqE+/sjGQ69FRoCmC1E/HFBgHK0lWBFWYU+Ij8M5K5J+P0/prfoQgUnIu
	 mQ499WoakLMSq3eJyUlKFvmQsCf9kMxSwfzLtTMyzhQMYR1uUgn83DL/968yeJlZkd
	 j4c99CdJaIV0Q==
Date: Wed, 29 Apr 2026 07:22:54 -0700
Subject: [PATCH 1/2] iomap: allow directio callers to supply _COMP_WORK
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu, brauner@kernel.org
Cc: hch@lst.de, fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 hch@lst.de
Message-ID: <177747204329.4101605.3843385829876468835.stgit@frogsfrogsfrogs>
In-Reply-To: <177747204299.4101605.7457046403791125680.stgit@frogsfrogsfrogs>
References: <177747204299.4101605.7457046403791125680.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Allow callers of iomap_dio_rw to specify the _COMP_WORK flag if they
require that all directio ioend completions occur in process context.
The upcoming fuse-iomap patchset needs this because fuse requests
(specifically FUSE_IOMAP_IOEND) cannot be sent from interrupt context.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/iomap.h |    3 +++
 fs/iomap/direct-io.c  |    7 ++++---
 2 files changed, 7 insertions(+), 3 deletions(-)


diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 2c5685adf3a97c..0de25b1af72d3f 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -590,6 +590,9 @@ struct iomap_dio_ops {
  */
 #define IOMAP_DIO_BOUNCE		(1 << 4)
 
+/* Run IO completions from process context */
+#define IOMAP_DIO_COMP_WORK		(1 << 5)
+
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		unsigned int dio_flags, void *private, size_t done_before);
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index b0a6549b38487b..71f43fa0cf26ea 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -19,8 +19,7 @@
  * Private flags for iomap_dio, must not overlap with the public ones in
  * iomap.h:
  */
-#define IOMAP_DIO_NO_INVALIDATE	(1U << 26)
-#define IOMAP_DIO_COMP_WORK	(1U << 27)
+#define IOMAP_DIO_NO_INVALIDATE	(1U << 27)
 #define IOMAP_DIO_WRITE_THROUGH	(1U << 28)
 #define IOMAP_DIO_NEED_SYNC	(1U << 29)
 #define IOMAP_DIO_WRITE		(1U << 30)
@@ -711,7 +710,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	dio->i_size = i_size_read(inode);
 	dio->dops = dops;
 	dio->error = 0;
-	dio->flags = dio_flags & (IOMAP_DIO_FSBLOCK_ALIGNED | IOMAP_DIO_BOUNCE);
+	dio->flags = dio_flags & (IOMAP_DIO_FSBLOCK_ALIGNED |
+				  IOMAP_DIO_BOUNCE |
+				  IOMAP_DIO_COMP_WORK);
 	dio->done_before = done_before;
 
 	dio->submit.iter = iter;

