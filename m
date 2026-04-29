Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A9B351C06;
	Wed, 29 Apr 2026 14:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473827; cv=none; b=OTYeYfORrQMKT+HUzk83RWfOmPlkLUqHghbswzAQd0TvkEAPAkYASMTa1iTzhJUM83QMNRJpWyKc4HVN4JGqINiAs2U83dxYIARPUsWPZNfNwIBIHZYP8zcWDI4whkNtp7l/PSC34mIw+sqzYrBMJkS+eOzXzjYNGpyOBx1xWL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473827; c=relaxed/simple;
	bh=K8em16ADwjifQoeFtWsUsWfUCIfk5C1IBI9xDgFYHvo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SzCM/6MKIEM6GGVdSRNs/0jqJ/cTUXtLuT4CezhOIQMjUSRMV//PKaPoL40xiDd2Rrei7nxHIuARlhorkEajh+vsxXcqSR4k88EvlKMI5wBQjRcLuFNTh0BNT2C1oysHZNQX4ODa8otPa4A68QjYDKvioEQFRJe5SJ3HCFckVcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmcKTRMf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmcKTRMf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8A3C19425;
	Wed, 29 Apr 2026 14:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473826;
	bh=K8em16ADwjifQoeFtWsUsWfUCIfk5C1IBI9xDgFYHvo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=gmcKTRMft9dGXaGIHpKtLGMk2JdTdyiZRe6BlLBVoV52c5g+1ucOHOEP+vUu9KhAM
	 r5m1XVFlWt9jXRFGTMfxWvH2pJUB0GDWvyhyh7/G7SZPRC8dp/KyJeyhF186Neo3jg
	 TZfHrM7yYltPIzuUnoy9DN/rs5ntajdCuhJAA++fa0fDP64UBBbZvSU9vBd+N8eJ3O
	 alg5L8zsqeXJMbTFhfaBUt8/klvDNYIq1BxRWjX/or5HXT+ng8hWOnow0aZQ9zFgTw
	 y38SnyFD1bW1EiIVnEEYLjxG9eC0DwrF4M0hq7+4OafI5+7baGPN8GdVXlstRhY+9o
	 6wfuxPmbzo0Cw==
Date: Wed, 29 Apr 2026 07:43:46 -0700
Subject: [PATCH 18/25] libfuse: add low level code to invalidate iomap block
 device ranges
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747211890.4104686.8472428655930002394.stgit@frogsfrogsfrogs>
In-Reply-To: <177747211463.4104686.1151865355399948078.stgit@frogsfrogsfrogs>
References: <177747211463.4104686.1151865355399948078.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Make it easier to invalidate the page cache for a block device that is
being used in conjunction with iomap.  This allows a fuse server to kill
all cached data for a block that is being freed, so that block reuse
doesn't result in file corruption.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_kernel.h   |   15 +++++++++++++++
 include/fuse_lowlevel.h |   16 ++++++++++++++++
 lib/fuse_lowlevel.c     |   22 ++++++++++++++++++++++
 lib/fuse_versionscript  |    1 +
 4 files changed, 54 insertions(+)


diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 897d996a0ce60d..1e7c9d8082cf23 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -247,6 +247,7 @@
  *  - add FUSE_ATTR_EXCLUSIVE to enable exclusive mode for specific inodes
  *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
  *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
+ *  - add FUSE_NOTIFY_IOMAP_DEV_INVAL to invalidate iomap bdev ranges
  */
 
 #ifndef _LINUX_FUSE_H
@@ -701,6 +702,7 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_RESEND = 7,
 	FUSE_NOTIFY_INC_EPOCH = 8,
 	FUSE_NOTIFY_PRUNE = 9,
+	FUSE_NOTIFY_IOMAP_DEV_INVAL = 99,
 };
 
 /* The read buffer is required to be at least 8k, but may be much larger */
@@ -1421,4 +1423,17 @@ struct fuse_iomap_config_out {
 	int64_t s_maxbytes;	/* max file size */
 };
 
+struct fuse_range {
+	uint64_t offset;
+	uint64_t length;
+};
+
+struct fuse_iomap_dev_inval_out {
+	uint32_t dev;		/* device cookie */
+	uint32_t reserved;	/* zero */
+
+	/* range of bdev pagecache to invalidate, in bytes */
+	struct fuse_range range;
+};
+
 #endif /* _LINUX_FUSE_H */
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index e97c3df16fb466..d17bde088d4992 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -2210,6 +2210,22 @@ int fuse_lowlevel_iomap_device_add(struct fuse_session *se, int fd,
  */
 int fuse_lowlevel_iomap_device_remove(struct fuse_session *se, int device_id);
 
+/*
+ * Invalidate the page cache of a block device opened for use with iomap.
+ *
+ * Added in FUSE protocol version 7.99. If the kernel does not support
+ * this (or a newer) version, the function will return -ENOSYS and do
+ * nothing.
+ *
+ * @param se the session object
+ * @param dev device cookie returned by fuse_lowlevel_iomap_add_device
+ * @param offset start of the range to invalidate, in bytes
+ * @param length the length of the range to invalidate, in bytes
+ * @return 0 on success, or negative errno on failure
+ */
+int fuse_lowlevel_iomap_device_invalidate(struct fuse_session *se, int dev,
+					  off_t offset, off_t length);
+
 /* ----------------------------------------------------------- *
  * Utility functions					       *
  * ----------------------------------------------------------- */
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 4750b39ab99137..2d3e0b49c5a50f 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -3693,6 +3693,28 @@ int fuse_lowlevel_notify_store(struct fuse_session *se, fuse_ino_t ino,
 	return res;
 }
 
+int fuse_lowlevel_iomap_device_invalidate(struct fuse_session *se, int dev,
+					  off_t offset, off_t length)
+{
+	struct fuse_iomap_dev_inval_out arg = {
+		.dev = dev,
+		.range.offset = offset,
+		.range.length = length,
+	};
+	struct iovec iov[2];
+
+	if (!se)
+		return -EINVAL;
+
+	if (!(se->conn.want_ext & FUSE_CAP_IOMAP))
+		return -ENOSYS;
+
+	iov[1].iov_base = &arg;
+	iov[1].iov_len = sizeof(arg);
+
+	return send_notify_iov(se, FUSE_NOTIFY_IOMAP_DEV_INVAL, iov, 2);
+}
+
 struct fuse_retrieve_req {
 	struct fuse_notify_req nreq;
 	void *cookie;
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index f1e5cc63da18ee..43bef1cd1c5076 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -265,6 +265,7 @@ FUSE_3.99 {
 		fuse_lowlevel_discover_iomap;
 		fuse_service_discover_iomap;
 		fuse_reply_iomap_config;
+		fuse_lowlevel_iomap_device_invalidate;
 } FUSE_3.19;
 
 # Local Variables:

