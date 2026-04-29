Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F31F364950;
	Wed, 29 Apr 2026 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473874; cv=none; b=Twhh7wLgGulULcastR9Dd+grvvVKtLrhS2Lsxdk0VC2Nmxj7g6j3LwW2GtqOWdz7hpKrhidmLMgnsR7GJXT73bdgpf4o26fdpEpxX6BGamebuBEqPr9i1O+IGQeGU0PXZ25BgwEJ92nQrnJ6dZ58ToSF7ejzCsIaHhViWbLlprg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473874; c=relaxed/simple;
	bh=4NTQFAA2aK4ah9TNakukisrXIBVBfupqqhegdPKgS/A=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sCCjC0kYCJAsV/Px4MzbYJM7KoRicA/FfSpRbachbpZUDltpgKIzCVIak7b8UjsR1eJLmLFcsNOG1PDjs2Q2/cqNG7FsgpZHC/Rw7+PM1rcyg3h1SMFodKi2yZOOro1X5YpNQ62aHfF7WeEGMl0pJ6ni20WopdGLNjuAr/k8nd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CF9xnRik; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CF9xnRik"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E996C19425;
	Wed, 29 Apr 2026 14:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473874;
	bh=4NTQFAA2aK4ah9TNakukisrXIBVBfupqqhegdPKgS/A=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=CF9xnRikLNQwn83jumh1C/CyAjqbiDaoLU9VIgole1blnMqt+sy5Wg7HZHObLxrDp
	 kM/lxgOoHt0QaKnMUWIP8mpOKXfcW3RyCjuCqGyKzHFVh+JuyUdZiDkIdyyHurHtOo
	 CFX3c+5X33eTZNxXzCSSLj1GEtRiseiSSGMyTJOzp9rNAfFN7YFHi3c3WvW2gHn58K
	 xBVL2ubF7UPaeNRn1G+4bs/lOSmTsj6XTmKw0TKkgtE4wxVgm5xXZFQvMyj/WZFYjz
	 O6exkSDEUNGmcS+BNNySSxapmum79LNAjy2Y7laQq6ZGWGjZLy9cVpv6i3bHqJoHv9
	 /KJzestWLdNzQ==
Date: Wed, 29 Apr 2026 07:44:33 -0700
Subject: [PATCH 21/25] libfuse: allow disabling of fs memory reclaim and write
 throttling
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747211943.4104686.6656439532449935643.stgit@frogsfrogsfrogs>
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

Create a library function so that fuse-iomap servers can ask the kernel
to disable direct memory reclaim for filesystems and BDI write
throttling.

Disabling fs reclaim prevents livelocks where the fuse server can
allocate memory, fault into the kernel, and then the allocation tries to
initiate writeback by calling back into the same fuse server.

Disabling BDI write throttling means that writeback won't be throttled
by metadata writes to the filesystem.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_kernel.h   |    1 +
 include/fuse_lowlevel.h |   13 +++++++++++++
 lib/fuse_lowlevel.c     |    7 +++++++
 lib/fuse_versionscript  |    1 +
 4 files changed, 22 insertions(+)


diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 71a6a92b4b4a65..0779e3917a1e8f 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -1176,6 +1176,7 @@ struct fuse_iomap_support {
 #define FUSE_DEV_IOC_BACKING_CLOSE	_IOW(FUSE_DEV_IOC_MAGIC, 2, uint32_t)
 #define FUSE_DEV_IOC_IOMAP_SUPPORT	_IOR(FUSE_DEV_IOC_MAGIC, 99, \
 					     struct fuse_iomap_support)
+#define FUSE_DEV_IOC_SET_NOFS		_IOW(FUSE_DEV_IOC_MAGIC, 100, uint32_t)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index d17bde088d4992..bc720564d828cd 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -2712,6 +2712,19 @@ int fuse_req_get_payload(fuse_req_t req, char **payload, size_t *payload_sz,
  */
 uint64_t fuse_lowlevel_discover_iomap(int fd);
 
+/**
+ * Disable direct fs memory reclaim and BDI throttling for a fuse-iomap server.
+ * This prevents memory allocations for the fuse server from initiating
+ * pagecache writeback to the fuse server and only throttles writes to the
+ * fuse server's block devices.  The fuse connection must already be
+ * initialized with iomap enabled.
+ *
+ * @param se the session object
+ * @param val 1 to disable fs reclaim and throttling, 0 to enable them
+ * @return 0 on success, or negative errno on failure
+ */
+int fuse_lowlevel_disable_fsreclaim(struct fuse_session *se, int val);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 6c300c39ece52c..e4b9ce2e4d2f08 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -5210,3 +5210,10 @@ uint64_t fuse_lowlevel_discover_iomap(int fd)
 
 	return ios.flags;
 }
+
+int fuse_lowlevel_disable_fsreclaim(struct fuse_session *se, int val)
+{
+	int ret = ioctl(se->fd, FUSE_DEV_IOC_SET_NOFS, &val);
+
+	return ret ? -errno : 0;
+}
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index 7f14aadff9fe72..99dfe35eccc90a 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -267,6 +267,7 @@ FUSE_3.99 {
 		fuse_reply_iomap_config;
 		fuse_lowlevel_iomap_device_invalidate;
 		fuse_fs_iomap_device_invalidate;
+		fuse_lowlevel_disable_fsreclaim;
 } FUSE_3.19;
 
 # Local Variables:

