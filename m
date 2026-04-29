Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE593367F48;
	Wed, 29 Apr 2026 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473732; cv=none; b=Y5YKS4ibZQQ8vxkMW/jm9i2oDeEEqbX2qFXTOCKxA+oxiAsaYXrFLHS/GuzEeBPIOB/TVPgntigw3EwVH+wVky8/dNMPLhqVV/d5NCZBP+/YzQFQIBk8iAMYFpMeqg7d1CUcncvxIZ+q57/D7zBgVpt32AYWqaCQBJ8HLcEdJkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473732; c=relaxed/simple;
	bh=0ZfdscxOCRmzgGd+8gSYoB6hG592ZklPpUD3a/6Exd4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t/z8HAQtyy0TEg/JoGWueftaohJbKD83O9rG08hpOchxy5FWi/pNMUdKquOXI4uO8fOflAYgCtAXB8r7/VPyalVgnelaC6x1ZHCaKV0CMBj48Wh2dmyrMFx84XsWJxCRYlYF10yWOh3oGqdllixu3XeP1klpZjYoT3H9Ol98E/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvTTRFP5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvTTRFP5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CD7C19425;
	Wed, 29 Apr 2026 14:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473732;
	bh=0ZfdscxOCRmzgGd+8gSYoB6hG592ZklPpUD3a/6Exd4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=lvTTRFP5FCW38EDYWht94oz8ZUCC+uMHOSGyxTeOFiPIGJPn5QyoDsmNjWZaatcBF
	 Y1gR9ASkmG8+GtbwS/jH5gAMZDXamkDQafO4mIWgvlelZk3rgbTZzpAN6g6acOFMrN
	 M6mzQFa2fZABZs3jzbJBOa5pu1dU+etmlGpbmxteJDADvqgo67hIW97MkzhBwtZS85
	 xtNdrLkCa565DQbsXlQvyDt4k5gX7ix5HP8OTYno1h2a4YU4pWeK1NE5jEch0p2i2B
	 xhVAKMNeu9VRtnUab2NuOYEfHY17ERY7YW9qEUizrb1vt1JX1czX8mvDvYW+lPVXCE
	 qwnBSvFO6BPHg==
Date: Wed, 29 Apr 2026 07:42:12 -0700
Subject: [PATCH 12/25] libfuse: support enabling exclusive mode for files
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747211782.4104686.17292351332511323054.stgit@frogsfrogsfrogs>
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

Make it so that lowlevel fuse servers can ask for exclusive mode.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h |    2 ++
 include/fuse_kernel.h |    4 ++++
 lib/fuse_lowlevel.c   |    2 ++
 3 files changed, 8 insertions(+)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index 5a5f69a6e23e5e..08dfdd57fd4977 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -1228,6 +1228,8 @@ static inline bool fuse_iomap_need_write_allocate(unsigned int opflags,
 
 /* enable fsdax */
 #define FUSE_IFLAG_DAX			(1U << 0)
+/* exclusive attr mode */
+#define FUSE_IFLAG_EXCLUSIVE		(1U << 1)
 
 /* ----------------------------------------------------------- *
  * Compatibility stuff					       *
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 732085a1b900b0..9b0894899ca453 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -244,6 +244,7 @@
  *  7.99
  *  - XXX magic minor revision to make experimental code really obvious
  *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file operations
+ *  - add FUSE_ATTR_EXCLUSIVE to enable exclusive mode for specific inodes
  */
 
 #ifndef _LINUX_FUSE_H
@@ -584,9 +585,12 @@ struct fuse_file_lock {
  *
  * FUSE_ATTR_SUBMOUNT: Object is a submount root
  * FUSE_ATTR_DAX: Enable DAX for this file in per inode DAX mode
+ * FUSE_ATTR_EXCLUSIVE: This file can only be modified by this mount, so the
+ * kernel can use cached attributes more aggressively (e.g. ACL inheritance)
  */
 #define FUSE_ATTR_SUBMOUNT      (1 << 0)
 #define FUSE_ATTR_DAX		(1 << 1)
+#define FUSE_ATTR_EXCLUSIVE	(1 << 2)
 
 /**
  * Open flags
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 2dbdef695009f8..f033decf2def26 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -164,6 +164,8 @@ static void convert_stat(const struct stat *stbuf, struct fuse_attr *attr,
 	attr->flags	= 0;
 	if (iflags & FUSE_IFLAG_DAX)
 		attr->flags |= FUSE_ATTR_DAX;
+	if (iflags & FUSE_IFLAG_EXCLUSIVE)
+		attr->flags |= FUSE_ATTR_EXCLUSIVE;
 }
 
 static void convert_attr(const struct fuse_setattr_in *attr, struct stat *stbuf)

