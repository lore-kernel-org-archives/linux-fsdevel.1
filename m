Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8005935E94F;
	Wed, 29 Apr 2026 14:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473748; cv=none; b=GO3dNFIt2cHxihbEQMLzHEO/8uN81t2utTizLpK1jn2LAA+4bU7OV0Tx21/e3h6GXsr/gOdMlMDVAiG7MWteK8sNNS6eNnqYgzc1PnuGMBK5AegH9UYa1NAQm8iJMACfbTiB1wgebE3y4fst/xtCDgYsJjr3vKx/vanUjcjR3yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473748; c=relaxed/simple;
	bh=WsLttsLmUU6kkLdqlGqkAUaUAcocf7J0DAGv7+faUuU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pgk57BJV6pPFaQwwuObp4xMH5sWgJc3qvAQiTnWsao8OM1cW6voaoA6/ixxbfWfKM76rsSgeSD87nQaCwJ3hYt9RU9BzVmtbkrhCq3sowNi5wj7pxax1D+x/HqHmkxQcrjUXCwgscw4bDzqMN1CpfECN5DbLSVpyFHAsAoGKqjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Folnqt4I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Folnqt4I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9E5C19425;
	Wed, 29 Apr 2026 14:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473748;
	bh=WsLttsLmUU6kkLdqlGqkAUaUAcocf7J0DAGv7+faUuU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Folnqt4IOfcMf1jujdECSm5InDuckluvtKEHM1dCefYBtMyOBsEovYfbtMN7+Q1LT
	 fCrxSS4yh+kPU7GmfjNsfBxHVJRIKKAxFkeb7EIaNbM37JVaZLM0LDB2vonVMTATXG
	 0m0wASrjdHsmb7S0H3pRCcXk33M7u6T9Emiy2rZWdkoxhrRUm1d9RUCab2bXeboohh
	 Ye2jp4Mt99GSqIoxvbjeEjIlA8qMU86YooN3IjyTBsj5kWvCofSSjT0o1kQpgHv2hI
	 /OZ23xkY7lkEuRHDSydvpBstgufbYWtVthueAUBAU/p9k7ifQ0WGXDuCcavMeKcuzg
	 tXqu4M3+z3vdA==
Date: Wed, 29 Apr 2026 07:42:27 -0700
Subject: [PATCH 13/25] libfuse: support direct I/O through iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747211800.4104686.2461209558784935514.stgit@frogsfrogsfrogs>
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

Make it so that fuse servers can ask the kernel fuse driver to use iomap
to support direct IO.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h |    2 ++
 include/fuse_kernel.h |    3 +++
 lib/fuse_lowlevel.c   |    2 ++
 3 files changed, 7 insertions(+)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index 08dfdd57fd4977..6c03d845258d25 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -1230,6 +1230,8 @@ static inline bool fuse_iomap_need_write_allocate(unsigned int opflags,
 #define FUSE_IFLAG_DAX			(1U << 0)
 /* exclusive attr mode */
 #define FUSE_IFLAG_EXCLUSIVE		(1U << 1)
+/* use iomap for this inode */
+#define FUSE_IFLAG_IOMAP		(1U << 2)
 
 /* ----------------------------------------------------------- *
  * Compatibility stuff					       *
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 9b0894899ca453..6b1fcc44004dbf 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -245,6 +245,7 @@
  *  - XXX magic minor revision to make experimental code really obvious
  *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file operations
  *  - add FUSE_ATTR_EXCLUSIVE to enable exclusive mode for specific inodes
+ *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
  */
 
 #ifndef _LINUX_FUSE_H
@@ -587,10 +588,12 @@ struct fuse_file_lock {
  * FUSE_ATTR_DAX: Enable DAX for this file in per inode DAX mode
  * FUSE_ATTR_EXCLUSIVE: This file can only be modified by this mount, so the
  * kernel can use cached attributes more aggressively (e.g. ACL inheritance)
+ * FUSE_ATTR_IOMAP: Use iomap for this inode
  */
 #define FUSE_ATTR_SUBMOUNT      (1 << 0)
 #define FUSE_ATTR_DAX		(1 << 1)
 #define FUSE_ATTR_EXCLUSIVE	(1 << 2)
+#define FUSE_ATTR_IOMAP		(1 << 3)
 
 /**
  * Open flags
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index f033decf2def26..034c00fcbe07ca 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -166,6 +166,8 @@ static void convert_stat(const struct stat *stbuf, struct fuse_attr *attr,
 		attr->flags |= FUSE_ATTR_DAX;
 	if (iflags & FUSE_IFLAG_EXCLUSIVE)
 		attr->flags |= FUSE_ATTR_EXCLUSIVE;
+	if (iflags & FUSE_IFLAG_IOMAP)
+		attr->flags |= FUSE_ATTR_IOMAP;
 }
 
 static void convert_attr(const struct fuse_setattr_in *attr, struct stat *stbuf)

