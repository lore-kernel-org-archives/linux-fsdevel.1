Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7D435CB87;
	Wed, 29 Apr 2026 14:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473842; cv=none; b=MKsOzVOKaucOtnG00Zlbl9xpmpIX+EWiTe0xXrwWLdruoXKk8vaR9Kiv2ZfdRz5LMyL1mSBdvJLkUC+3BwO9uwE1H5SRqC7jrhOz2H2kWXdCwk8cqUC7Emusk7OqaZj76xVDrSG2nAVYI9O4vjcDcXTZc8IXalR97CUTHJKfDXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473842; c=relaxed/simple;
	bh=7NBz9IFwNqiA8p6vcGVQR+DVBpYqkWjz8NLSxgGNNxA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QthEus+R6gFP0Us8CCq9KJ4l2oZIt30JS3RW0tjfvJpHFYDX8zptTb4GIiLBC1sKln7kl4qMMPAui0DLoejjfKag9NYIkqmtLVPSV7eMuWp2H/Z9MQdfmoE+lKNTUSCguNHyg6lZ1PhPCkBHqmZMTSOTQLONCdc1kCuwZgF3BG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SC/tS6Ev; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SC/tS6Ev"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF3FC19425;
	Wed, 29 Apr 2026 14:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473842;
	bh=7NBz9IFwNqiA8p6vcGVQR+DVBpYqkWjz8NLSxgGNNxA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=SC/tS6EvdKoY6iQTuO30UChsSiuzdhV830yktTlTolt2SRKoKsxe/ZowJIVZ5OQyu
	 HNjqD4DGkBYkuLIwz6LzDiQgsDhITy0dh/4K1XoIqQmskf4J0LSlnqRLuBGK21nf13
	 mYxWUEs/eamrgKuyeJnZOOpMGWrkq0PYddwUFhGYLWBoPLd4VeVB40a2gKkcPr8baN
	 ST/Nt/AtIIoS6RfE8N2F8ASm+PPTqsE7Tfnizzk+vQdSR0lI4ewG86zn5ftPNtE+nT
	 ob+h/J0E8CoTXWB3toMnlqHryRq09nWPMh7oORicRp0VNs1GqDx06pTJN1+8YxdUBX
	 V+Nu+3iGdXWfw==
Date: Wed, 29 Apr 2026 07:44:01 -0700
Subject: [PATCH 19/25] libfuse: add upper-level API to invalidate parts of an
 iomap block device
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747211908.4104686.12939387012874574582.stgit@frogsfrogsfrogs>
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

Wire up the upper-level wrappers to
fuse_lowlevel_iomap_invalidate_device.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse.h         |   10 ++++++++++
 lib/fuse.c             |    9 +++++++++
 lib/fuse_versionscript |    1 +
 3 files changed, 20 insertions(+)


diff --git a/include/fuse.h b/include/fuse.h
index 8b6cd7e3cf9f84..d68feb7ccfa84c 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -1479,6 +1479,16 @@ int fuse_fs_iomap_device_add(int fd, unsigned int flags);
  */
 int fuse_fs_iomap_device_remove(int device_id);
 
+/**
+ * Invalidate any pagecache for the given iomap (block) device.
+ *
+ * @param device_id device index as returned by fuse_lowlevel_iomap_device_add
+ * @param offset starting offset of the range to invalidate
+ * @param length the length of the range to invalidate
+ * @return 0 on success, or negative errno on failure
+ */
+int fuse_fs_iomap_device_invalidate(int device_id, off_t offset, off_t length);
+
 /**
  * Decide if we can enable iomap mode for a particular file for an upper-level
  * fuse server.
diff --git a/lib/fuse.c b/lib/fuse.c
index 2d9a49c16c25ff..ddf9b4044b8952 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -2941,6 +2941,15 @@ int fuse_fs_iomap_device_remove(int device_id)
 	return fuse_lowlevel_iomap_device_remove(se, device_id);
 }
 
+int fuse_fs_iomap_device_invalidate(int device_id, off_t offset, off_t length)
+{
+	struct fuse_context *ctxt = fuse_get_context();
+	struct fuse_session *se = fuse_get_session(ctxt->fuse);
+
+	return fuse_lowlevel_iomap_device_invalidate(se, device_id, offset,
+						     length);
+}
+
 static int fuse_fs_iomap_ioend(struct fuse_fs *fs, const char *path,
 			       uint64_t nodeid, uint64_t attr_ino, off_t pos,
 			       uint64_t written, uint32_t ioendflags, int error,
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index 43bef1cd1c5076..7f14aadff9fe72 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -266,6 +266,7 @@ FUSE_3.99 {
 		fuse_service_discover_iomap;
 		fuse_reply_iomap_config;
 		fuse_lowlevel_iomap_device_invalidate;
+		fuse_fs_iomap_device_invalidate;
 } FUSE_3.19;
 
 # Local Variables:

