Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAB826F288;
	Wed, 29 Apr 2026 14:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473858; cv=none; b=gfkAFPdrEqgWVr/bPZhyJfOG77Si4fwv8nv6F7HaUDi+iaecTx6RojqKjhn/TVwE8f0WNVavEvXjvX48jl3rtR0bjCTvzRjJbLKU+lnD9bEJW8+SMYj0V8iz5zMmpNXOx/MzUQamw+Z875rejrbK44uOPWg1qXMpm+Nyi8y3Ndg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473858; c=relaxed/simple;
	bh=R8al2JxuEggCMrLogMp0qlEZQI4s/GFgZwssLcdFFko=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uTPSWEi1F6kLIAgTu0LQ9pcoq7dhISLYM+k9OuRHDnwW/AgPCID8iTvLAyLE+zDhERpbg2LRsYhK1g9yAId6FBa68wDE3d0OWj6RegHbgdqzfoY483W8NWgAOlGhphcZGD97rnai0jNu2DCmDPfdSZZ5iDM2v2nOBLRrLXgnU8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaJZl3Hz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaJZl3Hz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3EEC19425;
	Wed, 29 Apr 2026 14:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473858;
	bh=R8al2JxuEggCMrLogMp0qlEZQI4s/GFgZwssLcdFFko=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=QaJZl3HzKtcTKaYZ10z1sXcc7CcwdUiddp3pIMMpJRtUc20RLoIgW1BNwaMvBJMsD
	 GdbJ3Fq4ZJ4jK2XiY9Nmfs740isY5oI34TFhZQBRpYIK72gQni4bTtOvePi9m5Emyg
	 Dp1gmOWMvTIBiCMmoRaWhiYkMlFBfMwq0UrsBgUVVA5+lqaQhqWdWotD/7uTQ59Rs5
	 wNQi4SJsO0j3goKUukH9+P6QqoAG79rP9mcWR3Tg3Z1yGXkc8klgjsgz/NCO0Ctmh0
	 M0AQRHcXeXEOjZCNM7kKzOLtyngiSqnOT2K4ZxprHPn5GrKzXZPF4r0r6qRkf+FTxT
	 XQeKh/o3xf8JQ==
Date: Wed, 29 Apr 2026 07:44:17 -0700
Subject: [PATCH 20/25] libfuse: add atomic write support
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747211925.4104686.10991092606385686467.stgit@frogsfrogsfrogs>
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

Add the single flag that we need to turn on atomic write support in
fuse.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h |    4 ++++
 include/fuse_kernel.h |    3 +++
 lib/fuse_lowlevel.c   |    2 ++
 3 files changed, 9 insertions(+)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index 2f0aff038c3ece..7c34dcf3b90754 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -545,6 +545,8 @@ struct fuse_loop_config_v1 {
  * FUSE_IOMAP_SUPPORT_FILEIO: basic file I/O functionality through iomap
  */
 #define FUSE_IOMAP_SUPPORT_FILEIO	(1ULL << 0)
+/* untorn writes through iomap */
+#define FUSE_IOMAP_SUPPORT_ATOMIC	(1ULL << 1)
 
 /**
  * Connection information, passed to the ->init() method
@@ -1239,6 +1241,8 @@ static inline bool fuse_iomap_need_write_allocate(unsigned int opflags,
 #define FUSE_IFLAG_EXCLUSIVE		(1U << 1)
 /* use iomap for this inode */
 #define FUSE_IFLAG_IOMAP		(1U << 2)
+/* enable untorn writes */
+#define FUSE_IFLAG_ATOMIC		(1U << 3)
 
 /* Which fields are set in fuse_iomap_config_out? */
 #define FUSE_IOMAP_CONFIG_SID		(1 << 0ULL)
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 1e7c9d8082cf23..71a6a92b4b4a65 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -248,6 +248,7 @@
  *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
  *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
  *  - add FUSE_NOTIFY_IOMAP_DEV_INVAL to invalidate iomap bdev ranges
+ *  - add FUSE_ATTR_ATOMIC for single-fsblock atomic write support
  */
 
 #ifndef _LINUX_FUSE_H
@@ -591,11 +592,13 @@ struct fuse_file_lock {
  * FUSE_ATTR_EXCLUSIVE: This file can only be modified by this mount, so the
  * kernel can use cached attributes more aggressively (e.g. ACL inheritance)
  * FUSE_ATTR_IOMAP: Use iomap for this inode
+ * FUSE_ATTR_ATOMIC: Enable untorn writes
  */
 #define FUSE_ATTR_SUBMOUNT      (1 << 0)
 #define FUSE_ATTR_DAX		(1 << 1)
 #define FUSE_ATTR_EXCLUSIVE	(1 << 2)
 #define FUSE_ATTR_IOMAP		(1 << 3)
+#define FUSE_ATTR_ATOMIC	(1 << 4)
 
 /**
  * Open flags
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 2d3e0b49c5a50f..6c300c39ece52c 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -168,6 +168,8 @@ static void convert_stat(const struct stat *stbuf, struct fuse_attr *attr,
 		attr->flags |= FUSE_ATTR_EXCLUSIVE;
 	if (iflags & FUSE_IFLAG_IOMAP)
 		attr->flags |= FUSE_ATTR_IOMAP;
+	if (iflags & FUSE_IFLAG_ATOMIC)
+		attr->flags |= FUSE_ATTR_ATOMIC;
 }
 
 static void convert_attr(const struct fuse_setattr_in *attr, struct stat *stbuf)

