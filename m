Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3D723EAB7;
	Wed, 29 Apr 2026 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777474171; cv=none; b=Rwp0H4hhT5xoFIGPwG6y493yZLGjPK3B1UrHPRRzeXDyn2Cs5PTI42WTsQ1I7SJA6au1ME5Up37QyQc28p/ePwECd7xTI46Kj3qWn/WKvR6/wVn3xZR97fMWRDadNKEXtD+KFLckg2K+MwzwqWUACKUne0dWiPvvNLbGqa3+ssw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777474171; c=relaxed/simple;
	bh=Lze0ZWN3GgTg0tStvKqM+3UWIGHDAZ6uAXyxZZyGsK0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HFzDCEAzAhLdx6yiK/5I1f5Ui6XX6z33WpEsQ8n+4dqBXuY7ltfnz+uCFc+x+OKLKTt7k9RSqO05VnXXi6Ig5AYYlrWXvo8a4NL1qrq3ZCfnhEr9cM5SJV0wg8Emztzfj+hQ1f5OppvBYu5QQ6P0MvYk7rMT2IK6pZbifP/vwa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGqyHWyi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGqyHWyi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32D2C19425;
	Wed, 29 Apr 2026 14:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777474171;
	bh=Lze0ZWN3GgTg0tStvKqM+3UWIGHDAZ6uAXyxZZyGsK0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=VGqyHWyi4lKuVNvYDMh76PAhjcrwQMzp2dbva0tTFxPO/o/OB79urAshx9VST/r6I
	 YABWG4lBNkRsqdJkvY2i2pip/4jNtLyyV5Wz2bNrKDbNo+Oi4jm5kIUECbZJBu4IgT
	 YOKbXOnwvVwlvTY+hhX7WXpecoQr4Huhdopi/VKDD01JXjcP9o8KBnKl73KPUf8r36
	 BzBHtyU6+h2C2lZkrzt7vKF8TE1K9EuVTDReKehwFTgRHZ26gO32/MmZ1SJQFW3EKm
	 1uXybFlzM7pDwbnfgFtogl8uUXYizgqg5rvB3DgswhjRC8v7BxUO9H7x/kd+hRohrJ
	 3MlOkCbI5oPOQ==
Date: Wed, 29 Apr 2026 07:49:30 -0700
Subject: [PATCH 2/9] libfuse: add upper-level iomap cache management
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747213282.4106384.9379656306051445909.stgit@frogsfrogsfrogs>
In-Reply-To: <177747213211.4106384.5167047581302637277.stgit@frogsfrogsfrogs>
References: <177747213211.4106384.5167047581302637277.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Make it so that upper-level fuse servers can use the iomap cache too.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse.h         |   31 +++++++++++++++++++++++++++++++
 lib/fuse.c             |   30 ++++++++++++++++++++++++++++++
 lib/fuse_versionscript |    2 ++
 3 files changed, 63 insertions(+)


diff --git a/include/fuse.h b/include/fuse.h
index 2717e654e92071..54803803beb5cb 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -1522,6 +1522,37 @@ bool fuse_fs_can_enable_iomap(const struct stat *stbuf);
  */
 bool fuse_fs_can_enable_iomapx(const struct statx *statxbuf);
 
+/*
+ * Upsert some file mapping information into the kernel.  This is necessary
+ * for filesystems that require coordination of mapping state changes between
+ * buffered writes and writeback, and desirable for better performance
+ * elsewhere.
+ *
+ * @param nodeid the inode number
+ * @param attr_ino inode number as told by fuse_attr::ino
+ * @param read mapping information for file reads
+ * @param write mapping information for file writes
+ * @return zero for success, -errno for failure
+ */
+int fuse_fs_iomap_upsert(uint64_t nodeid, uint64_t attr_ino,
+			 const struct fuse_file_iomap *read,
+			 const struct fuse_file_iomap *write);
+
+/**
+ * Invalidate some file mapping information in the kernel.
+ *
+ * @param nodeid the inode number
+ * @param attr_ino inode number as told by fuse_attr::ino
+ * @param read_off start of the range of read mappings to invalidate
+ * @param read_len length of the range of read mappings to invalidate
+ * @param write_off start of the range of write mappings to invalidate
+ * @param write_len length of the range of write mappings to invalidate
+ * @return zero for success, -errno for failure
+ */
+int fuse_fs_iomap_inval(uint64_t nodeid, uint64_t attr_ino, loff_t read_off,
+			uint64_t read_len, loff_t write_off,
+			uint64_t write_len);
+
 int fuse_notify_poll(struct fuse_pollhandle *ph);
 
 /**
diff --git a/lib/fuse.c b/lib/fuse.c
index b43a336d7530bb..9ca3ed7d92bfde 100644
--- a/lib/fuse.c
+++ b/lib/fuse.c
@@ -3021,6 +3021,36 @@ static int fuse_fs_shutdownfs(struct fuse_fs *fs, const char *path,
 	return fs->op.shutdownfs(path, flags);
 }
 
+int fuse_fs_iomap_upsert(uint64_t nodeid, uint64_t attr_ino,
+			 const struct fuse_file_iomap *read,
+			 const struct fuse_file_iomap *write)
+{
+	struct fuse_context *ctxt = fuse_get_context();
+	struct fuse_session *se = fuse_get_session(ctxt->fuse);
+
+	return fuse_lowlevel_iomap_upsert_mappings(se, nodeid, attr_ino, read,
+						   write);
+}
+
+int fuse_fs_iomap_inval(uint64_t nodeid, uint64_t attr_ino,
+			loff_t read_off, uint64_t read_len,
+			loff_t write_off, uint64_t write_len)
+{
+	struct fuse_context *ctxt = fuse_get_context();
+	struct fuse_session *se = fuse_get_session(ctxt->fuse);
+	struct fuse_file_range read = {
+		.offset = read_off,
+		.length = read_len,
+	};
+	struct fuse_file_range write = {
+		.offset = write_off,
+		.length = write_len,
+	};
+
+	return fuse_lowlevel_iomap_inval_mappings(se, nodeid, attr_ino, &read,
+						  &write);
+}
+
 static void fuse_lib_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
 			     int valid, struct fuse_file_info *fi)
 {
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index 41e0193708e57d..f5a2fcb3621d90 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -274,6 +274,8 @@ FUSE_3.99 {
 		fuse_lowlevel_iomap_set_blocksize;
 		fuse_lowlevel_iomap_upsert_mappings;
 		fuse_lowlevel_iomap_inval_mappings;
+		fuse_fs_iomap_upsert;
+		fuse_fs_iomap_inval;
 } FUSE_3.19;
 
 # Local Variables:

