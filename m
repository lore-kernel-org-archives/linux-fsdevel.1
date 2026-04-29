Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29EE2D8DD6;
	Wed, 29 Apr 2026 14:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473654; cv=none; b=htmuHpFhj2nd19/C1sJHymphPd+VLG8Ce8qGzmqiGe1JPmSklWnjYHArwTzA7RM+QRz2CNSvMYVkkxw1yxMjWss3HW01MYnkYArwm3yxqk5Q+Xi6LRV8K/kc/o5P7IKuO74y0JOC5JDWs6KxnKej4F8Bg3MPezV6JEHDOU6qVCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473654; c=relaxed/simple;
	bh=ldRf+51VUAc1KpG2QYrwS4EMbRQXur4qcUy2iMEhBaQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HGEacejvZ7Q+jOz1rFE/LHJi3b6NJPXSXsHRnQKWKLi/23EvnZWzrkqTPlS8IasoRCbhTtgckRbnLDsYkopqLpGlpXrt57q8OC4qNCmo2lqLDcd65rF5QMX1jO4NGedFbZ1t8pe0+gG0nalC/plOAKbufePjssDwsfiUBSmQq5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uz7Xl49p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uz7Xl49p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22B5C19425;
	Wed, 29 Apr 2026 14:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473654;
	bh=ldRf+51VUAc1KpG2QYrwS4EMbRQXur4qcUy2iMEhBaQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Uz7Xl49pN1teMqp14QtfgsJxS6y5SKfGbDHpQHPb+Ij50N9TP8ZCDlWlNORyxTeJ1
	 iqGwZwtzfo01Hq7ZdSLsvoWtbudsh+B9Wklwr6SImmFNT+eVbJPvNemNgqolGa8k4D
	 G5m02n+Si+R9FiRC0ySMXMYdDAMcRAjxOCTAsHlCmE+iNfSNSfjfOAb0kzEBuVj1m8
	 MTbTf0KO2yBymui7IIHQH74zL1LX/0EFlSYp4nNq+3CPyxl//6353JW+BNTtvlT0MV
	 urw/h9ebtVa8UrRo3HQyJIq2gYV8YShyCFLvSuaW+N3+dJBdtvvg6BuZX+aL2sOyeX
	 /IP34itNql3HQ==
Date: Wed, 29 Apr 2026 07:40:54 -0700
Subject: [PATCH 07/25] libfuse: add upper-level iomap add device function
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747211692.4104686.7492811139421869064.stgit@frogsfrogsfrogs>
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

Make it so that the upper level fuse library can add iomap devices too.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse.h         |   19 +++++++++++++++++++
 lib/fuse.c             |   16 ++++++++++++++++
 lib/fuse_versionscript |    2 ++
 3 files changed, 37 insertions(+)


diff --git a/include/fuse.h b/include/fuse.h
index 58d7538aee795c..8e79103f45404d 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -1437,6 +1437,25 @@ void fuse_fs_init(struct fuse_fs *fs, struct fuse_conn_info *conn,
 		struct fuse_config *cfg);
 void fuse_fs_destroy(struct fuse_fs *fs);
 
+/**
+ * Attach an open file descriptor to a fuse+iomap mount.  Currently must be
+ * a block device.
+ *
+ * @param fd file descriptor of an open block device
+ * @param flags behavior flags for the operation; none defined so far
+ * @return positive nonzero device id on success, or negative errno on failure
+ */
+int fuse_fs_iomap_device_add(int fd, unsigned int flags);
+
+/**
+ * Detach an open file from a fuse+iomap mount.  Must be a device id returned
+ * by fuse_lowlevel_iomap_device_add.
+ *
+ * @param device_id device index as returned by fuse_lowlevel_iomap_device_add
+ * @return 0 on success, or negative errno on failure
+ */
+int fuse_fs_iomap_device_remove(int device_id);
+
 int fuse_notify_poll(struct fuse_pollhandle *ph);
 
 /**
diff --git a/lib/fuse.c b/lib/fuse.c
index c8089baaf6628c..8f012710c994d5 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -2856,6 +2856,22 @@ static int fuse_fs_iomap_end(struct fuse_fs *fs, const char *path,
 				written, iomap);
 }
 
+int fuse_fs_iomap_device_add(int fd, unsigned int flags)
+{
+	struct fuse_context *ctxt = fuse_get_context();
+	struct fuse_session *se = fuse_get_session(ctxt->fuse);
+
+	return fuse_lowlevel_iomap_device_add(se, fd, flags);
+}
+
+int fuse_fs_iomap_device_remove(int device_id)
+{
+	struct fuse_context *ctxt = fuse_get_context();
+	struct fuse_session *se = fuse_get_session(ctxt->fuse);
+
+	return fuse_lowlevel_iomap_device_remove(se, device_id);
+}
+
 static void fuse_lib_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
 			     int valid, struct fuse_file_info *fi)
 {
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index e32dcb17551e9e..918b714e2e9166 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -253,6 +253,8 @@ FUSE_3.99 {
 		fuse_reply_iomap_begin;
 		fuse_lowlevel_iomap_device_add;
 		fuse_lowlevel_iomap_device_remove;
+		fuse_fs_iomap_device_add;
+		fuse_fs_iomap_device_remove;
 } FUSE_3.19;
 
 # Local Variables:

