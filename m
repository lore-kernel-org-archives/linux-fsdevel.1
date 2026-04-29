Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADB034D4E2;
	Wed, 29 Apr 2026 14:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473701; cv=none; b=ca3uMGzyWuEM79Eth7wTDbRbXpaIKRLv90fYSZ3eMmZrZtJsW1Qd/CahwZK5B9hQ7loJKuocCr9fuICrSybv0o559CTRixk8HF1mQH3qcSxjg/QX2DVIaTbSqZD6sOiq9NiWZ8htqSGG7dcAS47sjL5ZyVmrWT6Brmzj6KZyzdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473701; c=relaxed/simple;
	bh=8x+Tz756DTGpiPjp4JPfi8ZS/CpGF3JdFRnD0GKHaOk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLlR84Q0XYNWbsHFcwpBTCyGDsoqyVGqE+ac9mb2yszzxBKdyoljTK35nTNyLscYl3Kaun57ZgCGBYOFv8YoTIsQpZKVghQfV2ZnKzjqxpVwzwmvPs7KKtM3p3qDXZPa6XyCK9a0LXdnwS84grdG0o23nkiZUddWmAKun4YQhpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMUWBMk4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMUWBMk4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845DCC19425;
	Wed, 29 Apr 2026 14:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473701;
	bh=8x+Tz756DTGpiPjp4JPfi8ZS/CpGF3JdFRnD0GKHaOk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=VMUWBMk4/3nMPu4fWfdkiT8Uo2tR2FTwRBhKwda54OQEE8HBpfL0YVDTwz5pancOs
	 t7cVW2+MVfUwyniDEuMdE3U8IyQoc8NZbaeo8wlpAvqcMjWeLqlkstirUEA40InOkO
	 i+18d86GeSOkMSbZ0LmvU+rwtshWustzWTaYn5UA1SbanPTgwYSGKnJhZuS0drU1rz
	 0RlSA6QBJiXtYCl40dtf5pJV79nrEWKClfj5g+8U/hDA5Wy8Po6Rki8NnESBwiBu+W
	 oN1DEhkMC6Hzu+wMZzY6iPWM5d0rVWFMWDoTLsZvdUVemK2vYEBufsQ2lU0dNffmsJ
	 BLMDFJdSDJQCQ==
Date: Wed, 29 Apr 2026 07:41:41 -0700
Subject: [PATCH 10/25] libfuse: add a reply function to send FUSE_ATTR_* to
 the kernel
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747211746.4104686.2893802900458379866.stgit@frogsfrogsfrogs>
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

Create new fuse_reply_{attr,create,entry}_iflags functions so that we
can send FUSE_ATTR_* flags to the kernel when instantiating an inode.
Servers are expected to send FUSE_IFLAG_* values, which will be
translated into what the kernel can understand.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h   |    3 ++
 include/fuse_lowlevel.h |   83 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/fuse_lowlevel.c     |   64 ++++++++++++++++++++++++++++--------
 lib/fuse_versionscript  |    4 ++
 4 files changed, 139 insertions(+), 15 deletions(-)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index 865bcc6f5543d8..5a5f69a6e23e5e 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -1226,6 +1226,9 @@ static inline bool fuse_iomap_need_write_allocate(unsigned int opflags,
 /* is pagecache writeback */
 #define FUSE_IOMAP_IOEND_WRITEBACK	(1U << 5)
 
+/* enable fsdax */
+#define FUSE_IFLAG_DAX			(1U << 0)
+
 /* ----------------------------------------------------------- *
  * Compatibility stuff					       *
  * ----------------------------------------------------------- */
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index f55682f81e86f4..6d80713fe8bf88 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -242,6 +242,7 @@ struct fuse_lowlevel_ops {
 	 *
 	 * Valid replies:
 	 *   fuse_reply_entry
+	 *   fuse_reply_entry_iflags
 	 *   fuse_reply_err
 	 *
 	 * @param req request handle
@@ -301,6 +302,7 @@ struct fuse_lowlevel_ops {
 	 *
 	 * Valid replies:
 	 *   fuse_reply_attr
+	 *   fuse_reply_attr_iflags
 	 *   fuse_reply_err
 	 *
 	 * @param req request handle
@@ -336,6 +338,7 @@ struct fuse_lowlevel_ops {
 	 *
 	 * Valid replies:
 	 *   fuse_reply_attr
+	 *   fuse_reply_attr_iflags
 	 *   fuse_reply_err
 	 *
 	 * @param req request handle
@@ -367,6 +370,7 @@ struct fuse_lowlevel_ops {
 	 *
 	 * Valid replies:
 	 *   fuse_reply_entry
+	 *   fuse_reply_entry_iflags
 	 *   fuse_reply_err
 	 *
 	 * @param req request handle
@@ -383,6 +387,7 @@ struct fuse_lowlevel_ops {
 	 *
 	 * Valid replies:
 	 *   fuse_reply_entry
+	 *   fuse_reply_entry_iflags
 	 *   fuse_reply_err
 	 *
 	 * @param req request handle
@@ -432,6 +437,7 @@ struct fuse_lowlevel_ops {
 	 *
 	 * Valid replies:
 	 *   fuse_reply_entry
+	 *   fuse_reply_entry_iflags
 	 *   fuse_reply_err
 	 *
 	 * @param req request handle
@@ -480,6 +486,7 @@ struct fuse_lowlevel_ops {
 	 *
 	 * Valid replies:
 	 *   fuse_reply_entry
+	 *   fuse_reply_entry_iflags
 	 *   fuse_reply_err
 	 *
 	 * @param req request handle
@@ -971,6 +978,7 @@ struct fuse_lowlevel_ops {
 	 *
 	 * Valid replies:
 	 *   fuse_reply_create
+	 *   fuse_reply_create_iflags
 	 *   fuse_reply_err
 	 *
 	 * @param req request handle
@@ -1316,6 +1324,7 @@ struct fuse_lowlevel_ops {
 	 *
 	 * Valid replies:
 	 *   fuse_reply_create
+	 *   fuse_reply_create_iflags
 	 *   fuse_reply_err
 	 *
 	 * @param req request handle
@@ -1468,6 +1477,23 @@ void fuse_reply_none(fuse_req_t req);
  */
 int fuse_reply_entry(fuse_req_t req, const struct fuse_entry_param *e);
 
+/**
+ * Reply with a directory entry and FUSE_IFLAG_*
+ *
+ * Possible requests:
+ *   lookup, mknod, mkdir, symlink, link
+ *
+ * Side effects:
+ *   increments the lookup count on success
+ *
+ * @param req request handle
+ * @param e the entry parameters
+ * @param iflags	FUSE_IFLAG_*
+ * @return zero for success, -errno for failure to send reply
+ */
+int fuse_reply_entry_iflags(fuse_req_t req, const struct fuse_entry_param *e,
+			    unsigned int iflags);
+
 /**
  * Reply with a directory entry and open parameters
  *
@@ -1489,6 +1515,29 @@ int fuse_reply_entry(fuse_req_t req, const struct fuse_entry_param *e);
 int fuse_reply_create(fuse_req_t req, const struct fuse_entry_param *e,
 		      const struct fuse_file_info *fi);
 
+/**
+ * Reply with a directory entry, open parameters and FUSE_IFLAG_*
+ *
+ * currently the following members of 'fi' are used:
+ *   fh, direct_io, keep_cache, cache_readdir, nonseekable, noflush,
+ *   parallel_direct_writes
+ *
+ * Possible requests:
+ *   create
+ *
+ * Side effects:
+ *   increments the lookup count on success
+ *
+ * @param req request handle
+ * @param e the entry parameters
+ * @param iflags	FUSE_IFLAG_*
+ * @param fi file information
+ * @return zero for success, -errno for failure to send reply
+ */
+int fuse_reply_create_iflags(fuse_req_t req, const struct fuse_entry_param *e,
+			     unsigned int iflags,
+			     const struct fuse_file_info *fi);
+
 /**
  * Reply with attributes
  *
@@ -1503,6 +1552,21 @@ int fuse_reply_create(fuse_req_t req, const struct fuse_entry_param *e,
 int fuse_reply_attr(fuse_req_t req, const struct stat *attr,
 		    double attr_timeout);
 
+/**
+ * Reply with attributes and FUSE_IFLAG_* flags
+ *
+ * Possible requests:
+ *   getattr, setattr
+ *
+ * @param req request handle
+ * @param attr the attributes
+ * @param attr_timeout	validity timeout (in seconds) for the attributes
+ * @param iflags	set of FUSE_IFLAG_* flags
+ * @return zero for success, -errno for failure to send reply
+ */
+int fuse_reply_attr_iflags(fuse_req_t req, const struct stat *attr,
+			   unsigned int iflags, double attr_timeout);
+
 /**
  * Reply with the contents of a symbolic link
  *
@@ -1730,6 +1794,25 @@ size_t fuse_add_direntry_plus(fuse_req_t req, char *buf, size_t bufsize,
 			      const char *name,
 			      const struct fuse_entry_param *e, off_t off);
 
+/**
+ * Add a directory entry and FUSE_IFLAG_* to the buffer with the attributes
+ *
+ * See documentation of `fuse_add_direntry_plus()` for more details.
+ *
+ * @param req request handle
+ * @param buf the point where the new entry will be added to the buffer
+ * @param bufsize remaining size of the buffer
+ * @param name the name of the entry
+ * @param iflags	FUSE_IFLAG_*
+ * @param e the directory entry
+ * @param off the offset of the next entry
+ * @return the space needed for the entry
+ */
+size_t fuse_add_direntry_plus_iflags(fuse_req_t req, char *buf, size_t bufsize,
+				     const char *name, unsigned int iflags,
+				     const struct fuse_entry_param *e,
+				     off_t off);
+
 /**
  * Reply to ask for data fetch and output buffer preparation.  ioctl
  * will be retried with the specified input data fetched and output
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 8d706aa4b92f88..2dbdef695009f8 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -142,7 +142,8 @@ static void trace_request_reply(uint64_t unique, unsigned int len,
 }
 #endif
 
-static void convert_stat(const struct stat *stbuf, struct fuse_attr *attr)
+static void convert_stat(const struct stat *stbuf, struct fuse_attr *attr,
+			 unsigned int iflags)
 {
 	attr->ino	= stbuf->st_ino;
 	attr->mode	= stbuf->st_mode;
@@ -159,6 +160,10 @@ static void convert_stat(const struct stat *stbuf, struct fuse_attr *attr)
 	attr->atimensec = ST_ATIM_NSEC(stbuf);
 	attr->mtimensec = ST_MTIM_NSEC(stbuf);
 	attr->ctimensec = ST_CTIM_NSEC(stbuf);
+
+	attr->flags	= 0;
+	if (iflags & FUSE_IFLAG_DAX)
+		attr->flags |= FUSE_ATTR_DAX;
 }
 
 static void convert_attr(const struct fuse_setattr_in *attr, struct stat *stbuf)
@@ -476,7 +481,8 @@ static unsigned int calc_timeout_nsec(double t)
 }
 
 static void fill_entry(struct fuse_entry_out *arg,
-		       const struct fuse_entry_param *e)
+		       const struct fuse_entry_param *e,
+		       unsigned int iflags)
 {
 	arg->nodeid = e->ino;
 	arg->generation = e->generation;
@@ -484,14 +490,15 @@ static void fill_entry(struct fuse_entry_out *arg,
 	arg->entry_valid_nsec = calc_timeout_nsec(e->entry_timeout);
 	arg->attr_valid = calc_timeout_sec(e->attr_timeout);
 	arg->attr_valid_nsec = calc_timeout_nsec(e->attr_timeout);
-	convert_stat(&e->attr, &arg->attr);
+	convert_stat(&e->attr, &arg->attr, iflags);
 }
 
 /* `buf` is allowed to be empty so that the proper size may be
    allocated by the caller */
-size_t fuse_add_direntry_plus(fuse_req_t req, char *buf, size_t bufsize,
-			      const char *name,
-			      const struct fuse_entry_param *e, off_t off)
+size_t fuse_add_direntry_plus_iflags(fuse_req_t req, char *buf, size_t bufsize,
+				     const char *name, unsigned int iflags,
+				     const struct fuse_entry_param *e,
+				     off_t off)
 {
 	(void)req;
 	size_t namelen;
@@ -506,7 +513,7 @@ size_t fuse_add_direntry_plus(fuse_req_t req, char *buf, size_t bufsize,
 
 	struct fuse_direntplus *dp = (struct fuse_direntplus *) buf;
 	memset(&dp->entry_out, 0, sizeof(dp->entry_out));
-	fill_entry(&dp->entry_out, e);
+	fill_entry(&dp->entry_out, e, iflags);
 
 	struct fuse_dirent *dirent = &dp->dirent;
 	dirent->ino = e->attr.st_ino;
@@ -519,6 +526,14 @@ size_t fuse_add_direntry_plus(fuse_req_t req, char *buf, size_t bufsize,
 	return entlen_padded;
 }
 
+size_t fuse_add_direntry_plus(fuse_req_t req, char *buf, size_t bufsize,
+			      const char *name,
+			      const struct fuse_entry_param *e, off_t off)
+{
+	return fuse_add_direntry_plus_iflags(req, buf, bufsize, name, 0, e,
+					     off);
+}
+
 static void fill_open(struct fuse_open_out *arg,
 		      const struct fuse_file_info *f)
 {
@@ -541,7 +556,8 @@ static void fill_open(struct fuse_open_out *arg,
 		arg->open_flags |= FOPEN_PARALLEL_DIRECT_WRITES;
 }
 
-int fuse_reply_entry(fuse_req_t req, const struct fuse_entry_param *e)
+int fuse_reply_entry_iflags(fuse_req_t req, const struct fuse_entry_param *e,
+			    unsigned int iflags)
 {
 	struct fuse_entry_out arg;
 	size_t size = req->se->conn.proto_minor < 9 ?
@@ -553,12 +569,18 @@ int fuse_reply_entry(fuse_req_t req, const struct fuse_entry_param *e)
 		return fuse_reply_err(req, ENOENT);
 
 	memset(&arg, 0, sizeof(arg));
-	fill_entry(&arg, e);
+	fill_entry(&arg, e, iflags);
 	return send_reply_ok(req, &arg, size);
 }
 
-int fuse_reply_create(fuse_req_t req, const struct fuse_entry_param *e,
-		      const struct fuse_file_info *f)
+int fuse_reply_entry(fuse_req_t req, const struct fuse_entry_param *e)
+{
+	return fuse_reply_entry_iflags(req, e, 0);
+}
+
+int fuse_reply_create_iflags(fuse_req_t req, const struct fuse_entry_param *e,
+			     unsigned int iflags,
+			     const struct fuse_file_info *f)
 {
 	alignas(uint64_t) char buf[sizeof(struct fuse_entry_out) + sizeof(struct fuse_open_out)];
 	size_t entrysize = req->se->conn.proto_minor < 9 ?
@@ -569,7 +591,7 @@ int fuse_reply_create(fuse_req_t req, const struct fuse_entry_param *e,
 	int error;
 
 	memset(buf, 0, sizeof(buf));
-	fill_entry(earg, e);
+	fill_entry(earg, e, iflags);
 	fill_open(oarg, f);
 	error = send_reply_ok(req, buf,
 			     entrysize + sizeof(struct fuse_open_out));
@@ -578,8 +600,14 @@ int fuse_reply_create(fuse_req_t req, const struct fuse_entry_param *e,
 	return error;
 }
 
-int fuse_reply_attr(fuse_req_t req, const struct stat *attr,
-		    double attr_timeout)
+int fuse_reply_create(fuse_req_t req, const struct fuse_entry_param *e,
+		      const struct fuse_file_info *f)
+{
+	return fuse_reply_create_iflags(req, e, 0, f);
+}
+
+int fuse_reply_attr_iflags(fuse_req_t req, const struct stat *attr,
+			   unsigned int iflags, double attr_timeout)
 {
 	struct fuse_attr_out arg;
 	size_t size = req->se->conn.proto_minor < 9 ?
@@ -588,11 +616,17 @@ int fuse_reply_attr(fuse_req_t req, const struct stat *attr,
 	memset(&arg, 0, sizeof(arg));
 	arg.attr_valid = calc_timeout_sec(attr_timeout);
 	arg.attr_valid_nsec = calc_timeout_nsec(attr_timeout);
-	convert_stat(attr, &arg.attr);
+	convert_stat(attr, &arg.attr, iflags);
 
 	return send_reply_ok(req, &arg, size);
 }
 
+int fuse_reply_attr(fuse_req_t req, const struct stat *attr,
+		    double attr_timeout)
+{
+	return fuse_reply_attr_iflags(req, attr, 0, attr_timeout);
+}
+
 int fuse_reply_readlink(fuse_req_t req, const char *linkname)
 {
 	return send_reply_ok(req, linkname, strlen(linkname));
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index 06fcc6dcaa11be..01c11ba1794231 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -256,6 +256,10 @@ FUSE_3.99 {
 		fuse_lowlevel_iomap_device_remove;
 		fuse_fs_iomap_device_add;
 		fuse_fs_iomap_device_remove;
+		fuse_reply_attr_iflags;
+		fuse_reply_create_iflags;
+		fuse_reply_entry_iflags;
+		fuse_add_direntry_plus_iflags;
 } FUSE_3.19;
 
 # Local Variables:

