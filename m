Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433C026F288;
	Wed, 29 Apr 2026 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777474015; cv=none; b=ejJPuXYzMVfnEFn9jvhaQ2q3C2eRMqw9rYt2tABzArJgv3GQLe4jnxlLsQELPvMM0OlQXjm10vlUA7Wwb+kpKVhwkUqGsI4cuQod4v6i0uVJ09BQLuYo/ZLaWEXvVp2o9INron51pWNPVwCRF7b2wy0qT2yZ5KDQbK8NDtGzqyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777474015; c=relaxed/simple;
	bh=TdxNCN13su6zH47cGiDTFL9SprUoOH+79j2OEq/pRbg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=us99vOnYcIKws9YDGXMnRUVlP6HMtzV34M/uoKc8tJrH6fbSbdlmDAr60MBiT+teAlbep+LkZ2upBTqf1sFCaKkXDFCt/PWad11Eqq7G9IPGhHYJrSLnh1S+oHmAQZmgCMCr+E8C2xFxmWcuEuaIrKWFavFmWl2pv/UPJjQogjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhPE1nEm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhPE1nEm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA946C19425;
	Wed, 29 Apr 2026 14:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777474014;
	bh=TdxNCN13su6zH47cGiDTFL9SprUoOH+79j2OEq/pRbg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=fhPE1nEmtGSBl28zOYfhlyZO1hH8oXUW0H0lxXh2EOvft/Obxk2WlrQbIb2Fnrbuu
	 vFfBFk20U0y5qfFWj4V/kMu7FR5RzNIB1yXyR9QD+fTNGKzgFH7SNV3TA6OyEFyolv
	 K/XsNnhYaFQU6uFLHCSL4tiwCNlUNlk35WfraVnKHrBkbQQ8m1z2C0SWJHuZoDZvg0
	 I4qz+USY8fnha3IvrplTecTCyfN2XTokFet75V0v4IQr80Z2UctDT7r1mfbcchPOZx
	 2hD7MKBtcDyg/ObjVXqVESRIHMvI60m34nbof3frM6fM4WYl1rUkyAgdlBxfOZKeYV
	 fLasGDVlNJVLw==
Date: Wed, 29 Apr 2026 07:46:54 -0700
Subject: [PATCH 2/3] libfuse: enable setting iomap block device block size
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747212675.4105892.7319286694642067493.stgit@frogsfrogsfrogs>
In-Reply-To: <177747212630.4105892.8288935565208062403.stgit@frogsfrogsfrogs>
References: <177747212630.4105892.8288935565208062403.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create a means for an unprivileged fuse server to set the block size of
a block device that it previously opened and associated with the fuse
connection.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_kernel.h   |    7 +++++++
 include/fuse_lowlevel.h |   12 ++++++++++++
 lib/fuse_lowlevel.c     |   12 ++++++++++++
 lib/fuse_versionscript  |    1 +
 4 files changed, 32 insertions(+)


diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 10a82bf818d2cc..3ed174567dc172 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -1180,6 +1180,11 @@ struct fuse_iomap_support {
 	uint64_t	padding;
 };
 
+struct fuse_iomap_backing_info {
+	uint32_t	backing_id;
+	uint32_t	blocksize;
+};
+
 /* Device ioctls: */
 #define FUSE_DEV_IOC_MAGIC		229
 #define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
@@ -1190,6 +1195,8 @@ struct fuse_iomap_support {
 					     struct fuse_iomap_support)
 #define FUSE_DEV_IOC_SET_NOFS		_IOW(FUSE_DEV_IOC_MAGIC, 100, uint32_t)
 #define FUSE_DEV_IOC_ADD_IOMAP		_IO(FUSE_DEV_IOC_MAGIC, 101)
+#define FUSE_DEV_IOC_IOMAP_SET_BLOCKSIZE _IOW(FUSE_DEV_IOC_MAGIC, 102, \
+					      struct fuse_iomap_backing_info)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index d09ea5ca1b8ad7..67c9bd4b2c6cee 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -2770,6 +2770,18 @@ int fuse_lowlevel_disable_fsreclaim(struct fuse_session *se, int val);
  */
 int fuse_lowlevel_add_iomap(int fd);
 
+/**
+ * Set the block size of an open block device that has been opened for use with
+ * iomap.
+ *
+ * @param se the session object
+ * @param dev_index device index returned by fuse_lowlevel_iomap_device_add
+ * @param blocksize block size in bytes
+ * @return 0 on success, or negative errno on failure
+ */
+int fuse_lowlevel_iomap_set_blocksize(struct fuse_session *se, int dev_index,
+				      unsigned int blocksize);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index fa8cf6f9837bed..d3e2d4c698a62b 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -5290,3 +5290,15 @@ int fuse_lowlevel_add_iomap(int fd)
 
 	return ret ? -errno : 0;
 }
+
+int fuse_lowlevel_iomap_set_blocksize(struct fuse_session *se, int dev_index,
+				      unsigned int blocksize)
+{
+	struct fuse_iomap_backing_info fbi = {
+		.backing_id = dev_index,
+		.blocksize = blocksize,
+	};
+	int ret = ioctl(se->fd, FUSE_DEV_IOC_IOMAP_SET_BLOCKSIZE, &fbi);
+
+	return ret ? -errno : 0;
+}
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index 347aad1c1c8b1d..9c9013c964488c 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -271,6 +271,7 @@ FUSE_3.99 {
 		fuse_loopdev_setup;
 		fuse_lowlevel_add_iomap;
 		fuse_service_configure_iomap;
+		fuse_lowlevel_iomap_set_blocksize;
 } FUSE_3.19;
 
 # Local Variables:

