Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F009F2475D0;
	Wed, 29 Apr 2026 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473984; cv=none; b=JwKO8U/a/6B/uA6RgSkcv16P+gjnXvFcx60N2rQriPLJAZJoW/gSNljYOzJ8zZAeesMOIumbVYQzGcCzo2v83Wyom3vbu/nL65q6fSWZlaCNC4mFB9O+k5JbO8sq14QgShG0eLgZI3QzxT1M3evPG4WYIhve0ptjdQFwa3W5W18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473984; c=relaxed/simple;
	bh=qjVkPPD6ygvFazVhDH+wpF2d7JoVdYs03/8388ls1SU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hT7lKz4NojT+qH40l4xd/G+krbnTJaJzMUdv7LfC+3QlsXNvs+Xxry4LVGbnuBZVVAaR5QlLUG2YnK9+Ky6TJKkWT5ykJRDr3q3QqwnzoWMan287RYah7hFZy3PQNGWlf6GMidzFiMWQqIcLp4lC/Y0/ASoEqiqcSnzbkhNIsio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXUvgNmX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXUvgNmX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94614C19425;
	Wed, 29 Apr 2026 14:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473983;
	bh=qjVkPPD6ygvFazVhDH+wpF2d7JoVdYs03/8388ls1SU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=IXUvgNmXhRShuh+hsQf/ZNNuWjmxlQ9wWLgnMZ3xpNAS2njYSLHmeuDWOjCkhrwnP
	 lohKNhCFT4UAuGPRvQt30AwpzXf9lVLzYoR0ZlBQkoaXx21rGVpSt+sTk1r2JLi94u
	 UHtKOrK/UUGaErkIgAzc+0jt07nLY/v33K8Msyjtdq9KdZ7aV2Q1uG4YMhDTnFjvD7
	 235jdSJsJHQgO9xNu99ZZ4awARgnKEGD1Ut4YbhRTeEoXJHkssJv+VsDjZI54spmpq
	 i/xM1Pq9s3JidrA1TgmECDCrGPYYXhsOWswBl7msoc8AgAl9k29cnkPYcMHVxLiJlN
	 WkS9A3YyNHz7A==
Date: Wed, 29 Apr 2026 07:46:23 -0700
Subject: [PATCH 2/2] libfuse: set sync, immutable,
 and append when loading files
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747212482.4105754.5533086424377472478.stgit@frogsfrogsfrogs>
In-Reply-To: <177747212442.4105754.7242835990761551019.stgit@frogsfrogsfrogs>
References: <177747212442.4105754.7242835990761551019.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add these three fuse_attr::flags bits so that servers can mark a file as
immutable or append-only and have the kernel advertise and enforce that.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h |    6 ++++++
 include/fuse_kernel.h |    8 ++++++++
 lib/fuse_lowlevel.c   |    6 ++++++
 3 files changed, 20 insertions(+)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index 0df70d6064b457..7b209b217b310e 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -1248,6 +1248,12 @@ static inline bool fuse_iomap_need_write_allocate(unsigned int opflags,
 #define FUSE_IFLAG_IOMAP		(1U << 2)
 /* enable untorn writes */
 #define FUSE_IFLAG_ATOMIC		(1U << 3)
+/* file writes are synchronous */
+#define FUSE_IFLAG_SYNC			(1U << 4)
+/* file is immutable */
+#define FUSE_IFLAG_IMMUTABLE		(1U << 5)
+/* file is append only */
+#define FUSE_IFLAG_APPEND		(1U << 6)
 
 /* Which fields are set in fuse_iomap_config_out? */
 #define FUSE_IOMAP_CONFIG_SID		(1 << 0ULL)
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index ff21973e1c88f7..bee825a6d17ad5 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -249,6 +249,8 @@
  *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
  *  - add FUSE_NOTIFY_IOMAP_DEV_INVAL to invalidate iomap bdev ranges
  *  - add FUSE_ATTR_ATOMIC for single-fsblock atomic write support
+ *  - add FUSE_ATTR_{SYNC,IMMUTABLE,APPEND} for VFS enforcement of file
+ *    attributes
  */
 
 #ifndef _LINUX_FUSE_H
@@ -593,12 +595,18 @@ struct fuse_file_lock {
  * kernel can use cached attributes more aggressively (e.g. ACL inheritance)
  * FUSE_ATTR_IOMAP: Use iomap for this inode
  * FUSE_ATTR_ATOMIC: Enable untorn writes
+ * FUSE_ATTR_SYNC: File writes are always synchronous
+ * FUSE_ATTR_IMMUTABLE: File is immutable
+ * FUSE_ATTR_APPEND: File is append-only
  */
 #define FUSE_ATTR_SUBMOUNT      (1 << 0)
 #define FUSE_ATTR_DAX		(1 << 1)
 #define FUSE_ATTR_EXCLUSIVE	(1 << 2)
 #define FUSE_ATTR_IOMAP		(1 << 3)
 #define FUSE_ATTR_ATOMIC	(1 << 4)
+#define FUSE_ATTR_SYNC		(1 << 5)
+#define FUSE_ATTR_IMMUTABLE	(1 << 6)
+#define FUSE_ATTR_APPEND	(1 << 7)
 
 /**
  * Open flags
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 9aa7730db39ac6..00eaf511aaccc0 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -170,6 +170,12 @@ static void convert_stat(const struct stat *stbuf, struct fuse_attr *attr,
 		attr->flags |= FUSE_ATTR_IOMAP;
 	if (iflags & FUSE_IFLAG_ATOMIC)
 		attr->flags |= FUSE_ATTR_ATOMIC;
+	if (iflags & FUSE_IFLAG_SYNC)
+		attr->flags |= FUSE_ATTR_SYNC;
+	if (iflags & FUSE_IFLAG_IMMUTABLE)
+		attr->flags |= FUSE_ATTR_IMMUTABLE;
+	if (iflags & FUSE_IFLAG_APPEND)
+		attr->flags |= FUSE_ATTR_APPEND;
 }
 
 static void convert_attr(const struct fuse_setattr_in *attr, struct stat *stbuf)

