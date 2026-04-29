Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C2D19D093;
	Wed, 29 Apr 2026 14:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473670; cv=none; b=kESZA7cboCxiV4X1pNgHYgARur1Q8lXLgSrEbJs9Dt8LSdtJpnloMxpT7Fxso8AqTdQ7XzcsHzOFRPgxxmPtxoWImHc0qBX1fmt52rQySXqG24InjTqlFdovhcyncG9Cob5pJU0p/kRCKhQMlHv3sQ0RDK/5I9RZoo5PxZvHc2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473670; c=relaxed/simple;
	bh=j7fkLyONsoUOKEUIFwYsGJwLscjkGCKrfhjC1cvWamo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ljdfL8ynU0AT6vNAKvrm18cyxAYf049nUKx+lKKKwVuQAnFe1dcAyUJTFGzQpUqfEwx34DV9rQkZWt1B8eF60mpg0z1NHBsMzzqiOXpPENKYgeb85SduB3lX6KGcAG7sfhJd+afkxH3nHp//Qzabt2VIR+pJT8OvL8l279DG0Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWh7Qcla; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWh7Qcla"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3B4C19425;
	Wed, 29 Apr 2026 14:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473670;
	bh=j7fkLyONsoUOKEUIFwYsGJwLscjkGCKrfhjC1cvWamo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=dWh7Qclap7gKJXGvYgfYg/NiVV8Ql/L8l0/sky7oOM9j6fOkoqna155XUh9ZdSGmO
	 OUKkWasPNAc+GT7VbWDNG/SogCGP4vgXBZKM6+A5iy4vvHZwdMfi9GZAmm2gRSmo9V
	 UJel56quJAusr/pFnPnV5+mQQPBzjp+qPkBnCVvHlCu+ym3J3DPmdd+7seeVBScYfp
	 Qwx/XQG2t4Y03OFYHypP5a1BHVd6dhkCt/LkEFSqRic4pWVtLZW6R1rSF8aftgHVpv
	 CzLQVrdpjM1bUiIVwccj8cdPHAXNsutYqtGe/7dZP4u+4RVwxPcRFaxzW4N9/aUsJ+
	 0i7OSGiSz5oVQ==
Date: Wed, 29 Apr 2026 07:41:09 -0700
Subject: [PATCH 08/25] libfuse: add iomap ioend low level handler
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747211710.4104686.17386864965189876965.stgit@frogsfrogsfrogs>
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

Teach the low level library about the iomap ioend handler, which gets
called by the kernel when we finish a file write that isn't a pure
overwrite operation.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_common.h   |   13 +++++++++++++
 include/fuse_kernel.h   |   16 ++++++++++++++++
 include/fuse_lowlevel.h |   34 ++++++++++++++++++++++++++++++++++
 lib/fuse_lowlevel.c     |   32 ++++++++++++++++++++++++++++++++
 lib/fuse_versionscript  |    1 +
 5 files changed, 96 insertions(+)


diff --git a/include/fuse_common.h b/include/fuse_common.h
index d8b371b6641a6c..865bcc6f5543d8 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -1213,6 +1213,19 @@ static inline bool fuse_iomap_need_write_allocate(unsigned int opflags,
 		!(opflags & FUSE_IOMAP_OP_ZERO);
 }
 
+/* out of place write extent */
+#define FUSE_IOMAP_IOEND_SHARED		(1U << 0)
+/* unwritten extent */
+#define FUSE_IOMAP_IOEND_UNWRITTEN	(1U << 1)
+/* don't merge into previous ioend */
+#define FUSE_IOMAP_IOEND_BOUNDARY	(1U << 2)
+/* is direct I/O */
+#define FUSE_IOMAP_IOEND_DIRECT		(1U << 3)
+/* is append ioend */
+#define FUSE_IOMAP_IOEND_APPEND		(1U << 4)
+/* is pagecache writeback */
+#define FUSE_IOMAP_IOEND_WRITEBACK	(1U << 5)
+
 /* ----------------------------------------------------------- *
  * Compatibility stuff					       *
  * ----------------------------------------------------------- */
diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index e69f9675c4b57d..732085a1b900b0 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -670,6 +670,7 @@ enum fuse_opcode {
 	FUSE_STATX		= 52,
 	FUSE_COPY_FILE_RANGE_64	= 53,
 
+	FUSE_IOMAP_IOEND	= 4093,
 	FUSE_IOMAP_BEGIN	= 4094,
 	FUSE_IOMAP_END		= 4095,
 
@@ -1360,4 +1361,19 @@ struct fuse_iomap_end_in {
 	struct fuse_iomap_io	map;
 };
 
+struct fuse_iomap_ioend_in {
+	uint32_t flags;		/* FUSE_IOMAP_IOEND_* */
+	int32_t error;		/* negative errno or 0 */
+	uint64_t attr_ino;	/* matches fuse_attr:ino */
+	uint64_t pos;		/* file position, in bytes */
+	uint64_t new_addr;	/* disk offset of new mapping, in bytes */
+	uint64_t written;	/* bytes processed */
+	uint32_t dev;		/* device cookie */
+	uint32_t pad;		/* zero */
+};
+
+struct fuse_iomap_ioend_out {
+	uint64_t newsize;	/* new ondisk size */
+};
+
 #endif /* _LINUX_FUSE_H */
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index c0bbb6b658808d..f55682f81e86f4 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -1394,6 +1394,28 @@ struct fuse_lowlevel_ops {
 	void (*iomap_end)(fuse_req_t req, fuse_ino_t nodeid, uint64_t attr_ino,
 			  off_t pos, uint64_t count, uint32_t opflags,
 			  ssize_t written, const struct fuse_file_iomap *iomap);
+
+	/**
+	 * Complete an iomap IO operation
+	 *
+	 * Valid replies:
+	 *   fuse_reply_ioend
+	 *   fuse_reply_err
+	 *
+	 * @param req request handle
+	 * @param nodeid the inode number
+	 * @param attr_ino inode number as told by fuse_attr::ino
+	 * @param pos position in file, in bytes
+	 * @param written number of bytes processed, or a negative errno
+	 * @param flags mask of FUSE_IOMAP_IOEND_ flags specifying operation
+	 * @param error errno code of what went wrong
+	 * @param dev device cookie of new address
+	 * @param new_addr disk address of new mapping, in bytes
+	 */
+	void (*iomap_ioend)(fuse_req_t req, fuse_ino_t nodeid,
+			    uint64_t attr_ino, off_t pos, uint64_t written,
+			    uint32_t ioendflags, int error, uint32_t dev,
+			    uint64_t new_addr);
 };
 
 /**
@@ -1811,6 +1833,18 @@ void fuse_iomap_pure_overwrite(struct fuse_file_iomap *write,
 int fuse_reply_iomap_begin(fuse_req_t req, const struct fuse_file_iomap *read,
 			   const struct fuse_file_iomap *write);
 
+/**
+ * Reply to an ioend with the new ondisk size
+ *
+ * Possible requests:
+ *   iomap_ioend
+ *
+ * @param req request handle
+ * @param newsize new ondisk file size
+ * @return zero for success, or negative errno on failure
+ */
+int fuse_reply_iomap_ioend(fuse_req_t req, off_t newsize);
+
 /* ----------------------------------------------------------- *
  * Notification						       *
  * ----------------------------------------------------------- */
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 95ff8ca458480a..8d706aa4b92f88 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -2766,6 +2766,36 @@ static void do_iomap_end(fuse_req_t req, const fuse_ino_t nodeid,
 	_do_iomap_end(req, nodeid, inarg, NULL);
 }
 
+int fuse_reply_iomap_ioend(fuse_req_t req, off_t newsize)
+{
+	struct fuse_iomap_ioend_out arg = {
+		.newsize = newsize,
+	};
+
+	return send_reply_ok(req, &arg, sizeof(arg));
+}
+
+static void _do_iomap_ioend(fuse_req_t req, const fuse_ino_t nodeid,
+			    const void *op_in, const void *in_payload)
+{
+	const struct fuse_iomap_ioend_in *arg = op_in;
+	(void)in_payload;
+	(void)nodeid;
+
+	if (req->se->op.iomap_ioend)
+		req->se->op.iomap_ioend(req, nodeid, arg->attr_ino, arg->pos,
+					arg->written, arg->flags, arg->error,
+					arg->dev, arg->new_addr);
+	else
+		fuse_reply_err(req, ENOSYS);
+}
+
+static void do_iomap_ioend(fuse_req_t req, const fuse_ino_t nodeid,
+			   const void *inarg)
+{
+	_do_iomap_ioend(req, nodeid, inarg, NULL);
+}
+
 static bool want_flags_valid(uint64_t capable, uint64_t want)
 {
 	uint64_t unknown_flags = want & (~capable);
@@ -3761,6 +3791,7 @@ static struct {
 	[FUSE_STATX]	   = { do_statx,       "STATX"	     },
 	[FUSE_IOMAP_BEGIN] = { do_iomap_begin,	"IOMAP_BEGIN" },
 	[FUSE_IOMAP_END]   = { do_iomap_end,	"IOMAP_END" },
+	[FUSE_IOMAP_IOEND] = { do_iomap_ioend,	"IOMAP_IOEND" },
 	[CUSE_INIT]	   = { cuse_lowlevel_init, "CUSE_INIT"   },
 };
 
@@ -3820,6 +3851,7 @@ static struct {
 	[FUSE_STATX]		= { _do_statx,		"STATX" },
 	[FUSE_IOMAP_BEGIN]	= { _do_iomap_begin,	"IOMAP_BEGIN" },
 	[FUSE_IOMAP_END]	= { _do_iomap_end,	"IOMAP_END" },
+	[FUSE_IOMAP_IOEND]	= { _do_iomap_ioend,	"IOMAP_IOEND" },
 	[CUSE_INIT]		= { _cuse_lowlevel_init, "CUSE_INIT" },
 };
 
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index 918b714e2e9166..06fcc6dcaa11be 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -251,6 +251,7 @@ FUSE_3.99 {
 	global:
 		fuse_iomap_pure_overwrite;
 		fuse_reply_iomap_begin;
+		fuse_reply_iomap_ioend;
 		fuse_lowlevel_iomap_device_add;
 		fuse_lowlevel_iomap_device_remove;
 		fuse_fs_iomap_device_add;

