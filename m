Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E651282F31
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Mar 2026 23:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774135361; cv=none; b=cslLNcTxFud9ChJfmetj/AuJjgLsNAQUOlXtOe1sMsqYxXDo431Kyz1Y/bmKK5txphJHhyXu52bgWSH+0KhpAdXH/t8sRnX2VEVOkVd3JFIyByexL6uNkLChFcYAi6QWlaQ4u4p17dBgycCdXrQMfqcPYDndIzhQlNEGFo5tIPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774135361; c=relaxed/simple;
	bh=+RkS1R4yg/o24fmGmdAL8yVoMJtCpik+cMew9HRv3Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Endqv4HKtHDIvP/ZMGXdTbE8Vw6Vyf/NWE7jmdHSJx25dR/FXgl2rG9boZPa5WQmS7NKV93+7rJSF18e+VorMruDGVWGkj9tuBDNsoIm08npnMfmJGVJKQn9tULQFZQcXUVlXNbid1T4JQNZS2dxRx3x8P4TTLyalvPGsCDMDzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDVuVrgb; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDVuVrgb"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43b41b545d9so3725749f8f.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Mar 2026 16:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774135358; x=1774740158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwKZT9Z25S6E5hv2QONWp1kCppLkFiKumHns+JrmTEY=;
        b=iDVuVrgbimMxz4YOiDXLt0yWhGnwxUNrWUqZhWBggGTMMSkUWP830e7xORqxV5xmwW
         /2w/zgI3I1PaKowzOdpdaSGMwacESRaV68HI7MnJDk1b4oNwEO78qkxD+CZNvzCqc5Wc
         3dds21gLsJtXT9jwF/o+c+w01hHn0QzZQ+f/zdooGrH8X/KgvipYo5BGDhbax5n6syPK
         wgc5MdfzsAnp++EbNaTGa+SFq0XTzQgpqXUqY4ACadGeXfGiM21jyeTjmIi3B7IRdHZ9
         dkPDTqRbOWsxb050CIWwsyC5TQAboO8SA4rbE8uKpiG4HyRPVNO35n132nx0TzDJ/1F1
         22Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774135358; x=1774740158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AwKZT9Z25S6E5hv2QONWp1kCppLkFiKumHns+JrmTEY=;
        b=kuoi0WlUhS6a2BxIcudO3lK1YSRmo53/QWlNn12nQFKST1YUqGIyRUSFyW96H2P9jy
         4EKDrrVFKiunwa1cWF33JlaH4SBntFABcuUf6sPwCMG/bwbQzPQs5eKHY8JP4URHMogU
         i4aouA1M88oAgatVz2sgtBNEFx6ZPRb7G7tvRh7H7ZuRHCVeRqVvCgK9ES7GBf+FlsqT
         6HYgNhTs7mrs8dVBCEzS9qAlhEW0DqlqtItlGNJ+psBwLtj+fd+T4r6cEYkt5rotWJSb
         feZYZ2uzqb7LftVI3nTcH8r+FWOZ2i2ItDr3D2g9RYfn+gib5bOlA+Q352jPFBZyH3sC
         DHIg==
X-Forwarded-Encrypted: i=1; AJvYcCX4Q6LQUDZK+9pDpiIUIDKPVwwh3AtfRUAobR0XfwCzzPCl+Fiizdh+ytpoWrP8Kh8PtNK8D1DtXFIY/Pab@vger.kernel.org
X-Gm-Message-State: AOJu0YxTNa0ePP7Mx2O42Ab2A+zSsze1j4KGAZlHkcraMPvMP7C18AIj
	9tdaKHGrOepHAcaaVVxXc75j/LS4RQla1DCPwQUxcPxvAUsgr98ssYa4
X-Gm-Gg: ATEYQzy/CfUsYGyyNSozzE9MDW8uXyWrn/p8FXUAxjyWNpJ+vom8AbaVEIx4KqKIFBn
	vv8zXsYWGpFOkh3aTcUIB6wNnB0s6Q9YR15c1GglC47ojLc0gpM/0DEDD3qxjgZ5QkZsZ3sGN1W
	RQhTlbrrcF/V/8v+NsaiO8lM/RwrxLsH2ht4NnVdP+rXcxnY30BkiooOhm+mX1xEDweygbF7vtN
	Juri3xHaY119sDrYl5SD/jxVx1MvfP7bX/0of09SbyIrtzSpJK8pxci2M6BoCndgxKF4VaW1yEg
	NomuG7C9mlbxh6wodOiWqfYA/oKiU+XEQqN0j1xf8GaWNcgdznKHPM/MJnIH15xWT9q/K9lsbkw
	P0+/SGmYIX76J5TbUjTA2nSq3V5a1pGkjfbZtPavAFmRm4m5a/uLGcm0Cwbky/lM7HG3A+toymt
	ASDls23JL4HWfvP4Ko6F93dj+vMY0GwmJ6tiqs3HW2VTeM43yVe88PRDh3XYc=
X-Received: by 2002:a05:6000:22c7:b0:43b:4d25:959b with SMTP id ffacd0b85a97d-43b6423bc16mr12570651f8f.17.1774135357731;
        Sat, 21 Mar 2026 16:22:37 -0700 (PDT)
Received: from ddp-thinkpad.tail20b0d.ts.net ([95.141.20.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6425eeb4sm15609897f8f.0.2026.03.21.16.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 16:22:37 -0700 (PDT)
From: Daniele Di Proietto <daniele.di.proietto@gmail.com>
To: io-uring@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Daniele Di Proietto <daniele.di.proietto@gmail.com>
Subject: [PATCH v3 4/4] io_uring: Add IORING_OP_DUP
Date: Sat, 21 Mar 2026 23:21:42 +0000
Message-ID: <20260321232142.911280-5-daniele.di.proietto@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260321232142.911280-1-daniele.di.proietto@gmail.com>
References: <20260321232142.911280-1-daniele.di.proietto@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new operation is like dup3(). The source file can be a regular file
descriptor or a direct descriptor. The destination is a regular file
descriptor.

The direct descriptor variant is useful to move a descriptor to an fd
and close the existing fd with a single acquisition of the `struct
files_struct` `file_lock`. Combined with IORING_OP_ACCEPT or
IORING_OP_OPENAT2 with direct descriptors, it can reduce lock contention
for multithreaded applications.

Signed-off-by: Daniele Di Proietto <daniele.di.proietto@gmail.com>
---
 include/uapi/linux/io_uring.h |  17 ++++
 io_uring/opdef.c              |   8 ++
 io_uring/openclose.c          | 180 ++++++++++++++++++++++++++++++++++
 io_uring/openclose.h          |   4 +
 4 files changed, 209 insertions(+)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 1ff16141c8a5..1612aa2db846 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -74,6 +74,7 @@ struct io_uring_sqe {
 		__u32		install_fd_flags;
 		__u32		nop_flags;
 		__u32		pipe_flags;
+		__u32		dup_flags;
 	};
 	__u64	user_data;	/* data to be passed back at completion time */
 	/* pack this to avoid bogus arm OABI complaints */
@@ -90,6 +91,7 @@ struct io_uring_sqe {
 		__u32	file_index;
 		__u32	zcrx_ifq_idx;
 		__u32	optlen;
+		__s32	dup_new_fd;
 		struct {
 			__u16	addr_len;
 			__u16	__pad3[1];
@@ -316,6 +318,7 @@ enum io_uring_op {
 	IORING_OP_PIPE,
 	IORING_OP_NOP128,
 	IORING_OP_URING_CMD128,
+	IORING_OP_DUP,
 
 	/* this goes last, obviously */
 	IORING_OP_LAST,
@@ -475,6 +478,20 @@ enum io_uring_msg_ring_flags {
  */
 #define IORING_FIXED_FD_NO_CLOEXEC	(1U << 0)
 
+/*
+ * IORING_OP_DUP flags (sqe->dup_flags)
+ *
+ * IORING_DUP_NO_CLOEXEC	Don't mark the new fd as O_CLOEXEC. Only valid
+ *				if IORING_DUP_NEW_FIXED is not set.
+ * IORING_DUP_OLD_FIXED		sqe->fd (the source) is a fixed descriptor.
+ *				Otherwise it's a regular fd.
+ * IORING_DUP_NEW_FIXED		sqe->dup_new_fd (the destination) is a fixed
+ *				descriptor. Otherwise is a regular fd.
+ */
+#define IORING_DUP_NO_CLOEXEC	(1U << 0)
+#define IORING_DUP_OLD_FIXED	(1U << 1)
+#define IORING_DUP_NEW_FIXED	(1U << 2)
+
 /*
  * IORING_OP_NOP flags (sqe->nop_flags)
  *
diff --git a/io_uring/opdef.c b/io_uring/opdef.c
index 91a23baf415e..62fe566d2cad 100644
--- a/io_uring/opdef.c
+++ b/io_uring/opdef.c
@@ -599,6 +599,10 @@ const struct io_issue_def io_issue_defs[] = {
 		.prep			= io_uring_cmd_prep,
 		.issue			= io_uring_cmd,
 	},
+	[IORING_OP_DUP] = {
+		.prep			= io_dup_prep,
+		.issue			= io_dup,
+	},
 };
 
 const struct io_cold_def io_cold_defs[] = {
@@ -857,6 +861,10 @@ const struct io_cold_def io_cold_defs[] = {
 		.sqe_copy		= io_uring_cmd_sqe_copy,
 		.cleanup		= io_uring_cmd_cleanup,
 	},
+	[IORING_OP_DUP] = {
+		.name			= "DUP",
+		.cleanup		= io_dup_cleanup,
+	},
 };
 
 const char *io_uring_get_opcode(u8 opcode)
diff --git a/io_uring/openclose.c b/io_uring/openclose.c
index c71242915dad..b3e5ce9e827c 100644
--- a/io_uring/openclose.c
+++ b/io_uring/openclose.c
@@ -39,6 +39,14 @@ struct io_fixed_install {
 	unsigned int			o_flags;
 };
 
+struct io_dup {
+	struct file *file;
+	int old_fd;
+	int new_fd;
+	unsigned int flags;
+	struct io_rsrc_node *rsrc_node;
+};
+
 static bool io_openat_force_async(struct io_open *open)
 {
 	/*
@@ -446,3 +454,175 @@ int io_pipe(struct io_kiocb *req, unsigned int issue_flags)
 		fput(files[1]);
 	return ret;
 }
+
+void io_dup_cleanup(struct io_kiocb *req)
+{
+	struct io_dup *id = io_kiocb_to_cmd(req, struct io_dup);
+
+	if (id->rsrc_node)
+		io_put_rsrc_node(req->ctx, id->rsrc_node);
+	id->rsrc_node = NULL;
+}
+
+#define IORING_DUP_FLAGS \
+	(IORING_DUP_NO_CLOEXEC | IORING_DUP_OLD_FIXED | IORING_DUP_NEW_FIXED)
+
+int io_dup_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+{
+	struct io_dup *id;
+
+	if (sqe->off || sqe->addr || sqe->len || sqe->buf_index || sqe->addr3)
+		return -EINVAL;
+
+	id = io_kiocb_to_cmd(req, struct io_dup);
+	id->flags = READ_ONCE(sqe->dup_flags);
+	if (id->flags & ~IORING_DUP_FLAGS)
+		return -EINVAL;
+
+	if ((id->flags & IORING_DUP_NO_CLOEXEC) &&
+	    (id->flags & IORING_DUP_NEW_FIXED))
+		return -EINVAL;
+
+	id->old_fd = READ_ONCE(sqe->fd);
+	id->new_fd = READ_ONCE(sqe->dup_new_fd);
+
+	if (((id->flags & IORING_DUP_NEW_FIXED) == 0) ==
+		    ((id->flags & IORING_DUP_OLD_FIXED) == 0) &&
+	    id->old_fd == id->new_fd)
+		return -EINVAL;
+
+	id->rsrc_node = NULL;
+
+	/* ensure the task's creds are used when installing/receiving fds */
+	if (req->flags & REQ_F_CREDS)
+		return -EPERM;
+
+	return 0;
+}
+
+static struct file *io_dup_get_old_file_fixed(struct io_kiocb *req,
+					      unsigned int issue_flags,
+					      unsigned int file_slot)
+{
+	struct io_dup *id = io_kiocb_to_cmd(req, struct io_dup);
+	struct file *file = NULL;
+
+	if (!id->rsrc_node)
+		id->rsrc_node = io_file_get_fixed_node(req, file_slot, issue_flags);
+
+	if (id->rsrc_node) {
+		file = io_slot_file(id->rsrc_node);
+		req->flags |= REQ_F_NEED_CLEANUP;
+	}
+	return file;
+}
+
+static int io_dup_to_fixed(struct io_kiocb *req, unsigned int issue_flags,
+			   bool old_fixed, int old_fd, unsigned int file_slot)
+{
+	struct file *old_file = NULL;
+	int ret;
+
+	if (!old_fixed) {
+		old_file = io_file_get_normal(req, old_fd);
+		if (old_file && io_is_uring_fops(old_file)) {
+			fput(old_file);
+			old_file = NULL;
+		}
+	} else {
+		old_file = io_dup_get_old_file_fixed(req, issue_flags, old_fd);
+		if (old_file)
+			get_file(old_file);
+	}
+	if (!old_file)
+		return -EBADF;
+
+	if (file_slot != IORING_FILE_INDEX_ALLOC)
+		file_slot++;
+
+	ret = io_fixed_fd_install(req, issue_flags, old_file, file_slot);
+	if (file_slot == IORING_FILE_INDEX_ALLOC || ret < 0)
+		return ret;
+	return file_slot - 1;
+}
+
+static int io_dup_complete(struct io_kiocb *req, int ret)
+{
+	if (ret < 0)
+		req_set_fail(req);
+	io_req_set_res(req, ret, 0);
+	return IOU_COMPLETE;
+}
+
+static int io_dup_to_fd(struct io_kiocb *req, unsigned int issue_flags,
+			bool old_fixed, int old_fd, int new_fd, int o_flags)
+{
+	bool non_block = issue_flags & IO_URING_F_NONBLOCK;
+	struct files_struct *files = current->files;
+	struct file *old_file, *to_close = NULL;
+	int err;
+
+	if (new_fd >= rlimit(RLIMIT_NOFILE))
+		return -EBADF;
+
+	if (old_fixed)
+		old_file = io_dup_get_old_file_fixed(req, issue_flags, old_fd);
+
+	{
+		guard(spinlock)(&files->file_lock);
+
+		/* Do we need to expand? If so, be safe and punt to async */
+		if (new_fd >= files_fdtable(files)->max_fds && non_block)
+			return -EAGAIN;
+		err = expand_files(files, new_fd);
+		if (err < 0)
+			return io_dup_complete(req, err);
+
+		if (!old_fixed)
+			old_file = files_lookup_fd_locked(files, old_fd);
+
+		if (!old_file)
+			return io_dup_complete(req, -EBADF);
+
+		to_close = files_lookup_fd_locked(files, new_fd);
+		if (to_close) {
+			if (io_is_uring_fops(to_close))
+				return io_dup_complete(req, -EBADF);
+
+			/* if the file has a flush method, be safe and punt to async */
+			if (to_close->f_op->flush && non_block)
+				return -EAGAIN;
+		}
+		to_close = do_replace_fd_locked(files, old_file, new_fd, o_flags);
+		if (IS_ERR(to_close))
+			return io_dup_complete(req, PTR_ERR(to_close));
+	}
+
+	if (to_close)
+		filp_close(to_close, files);
+
+	return io_dup_complete(req, new_fd);
+}
+
+int io_dup(struct io_kiocb *req, unsigned int issue_flags)
+{
+	struct io_dup *id = io_kiocb_to_cmd(req, struct io_dup);
+	bool old_fixed = id->flags & IORING_DUP_OLD_FIXED;
+	bool new_fixed = id->flags & IORING_DUP_NEW_FIXED;
+	int ret, o_flags;
+
+	if (new_fixed) {
+		ret = io_dup_to_fixed(req, issue_flags, old_fixed, id->old_fd,
+				      id->new_fd);
+		if (ret < 0)
+			req_set_fail(req);
+		io_req_set_res(req, ret, 0);
+		return IOU_COMPLETE;
+	}
+
+	o_flags = O_CLOEXEC;
+	if (id->flags & IORING_DUP_NO_CLOEXEC)
+		o_flags = 0;
+	return io_dup_to_fd(req, issue_flags, old_fixed, id->old_fd, id->new_fd,
+			    o_flags);
+}
diff --git a/io_uring/openclose.h b/io_uring/openclose.h
index 566739920658..95d6a338ac66 100644
--- a/io_uring/openclose.h
+++ b/io_uring/openclose.h
@@ -21,3 +21,7 @@ int io_pipe(struct io_kiocb *req, unsigned int issue_flags);
 
 int io_install_fixed_fd_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
 int io_install_fixed_fd(struct io_kiocb *req, unsigned int issue_flags);
+
+void io_dup_cleanup(struct io_kiocb *req);
+int io_dup_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
+int io_dup(struct io_kiocb *req, unsigned int issue_flags);
-- 
2.43.0

