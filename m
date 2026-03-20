Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BBB3D1714
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 18:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774031330; cv=none; b=Ws9bQnyHtqzN11OyhyRRLEeQj7pXdV9vKQ0oHrbuN4soAgHhIENUaVpQjqfaTbLbTCz8pHC5uaat8Yk4YCLXpPtaE4aIJ6vQOPIBOOdbtBZThN+8N1YjIKXzBrGPyX+nG5TDwGRUkzr5sFA10cJ5Ndhf5OuT4eve9fpKOLE0hB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774031330; c=relaxed/simple;
	bh=e6uFso//p8qaOAdADHsXr6ic1HKsjuzB5FtDwz9+lr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kaLGJRFYrcLleszo4l0EfF5F074ry2rb1mjChlIevawlX7fZxh607VNq9nbp9FyFNzEUYya49+oNVrugf2kMfnSapnXItHT8yCw2T18y7ZWIA9Md/cdyKuOgU04hVxOG6eUymdkkdtS/XgC83w35RghHCQO9ZDuN9n7aEViABk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hU8UavWt; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hU8UavWt"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4870206f73bso3854535e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 11:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774031327; x=1774636127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uFmW2bFmgN7WPgqI0jnwG2Kk3ABy0kT+2hA6jZGPzM=;
        b=hU8UavWtG19lhVcg8vzMADPXFdo4IexAc/X8THWy2aAvGae9idnCYp7poMNQPntCLR
         ySmI96zcowZwABK5stP2ZlcveigkEi2qOrT8aQBzrh92qPP3YITya5DVDGFi3zdfKb4J
         0NOeueKibC2TxqdUugdDF836DAWOjAWFlHC9Q2/Jaj+Cxm9orh0oj4keWCBYTk7bXDzz
         5DVtlK0dnv0g1gvwLfKJ9Vijwh1cBUeyP86UJ12fFMRELGi5kinjnqwxB6c1BxBbdx81
         reExkGRDaLAoqbuqYw+eCJwBVTezD7PUcO2j8M/zt9Hidyf7TcQtgo0342XCmB3E9Xb5
         pz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774031327; x=1774636127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5uFmW2bFmgN7WPgqI0jnwG2Kk3ABy0kT+2hA6jZGPzM=;
        b=p2dqxGtsNMtlKN/QwScAbVJdFTwS/zjbf2+7D7Fy+b9bSaO1j0B24YNfYTk2WcBpxO
         pqPj8es1KlCWSpjuWaiJzfud8Pf0xzbhf1Rv9jsMZF55hgucISKgBmlaIxsrFw9PXYtQ
         Cg7BfCsFaSOxy0jEv5Ei732jR/+BfW4e7WQ8ETbAp9pKs3eOhdNsQHQCssgW9WT68FfJ
         QoZXZLSmjwdLb4MV30BmxHLQOwjpOYHal1vC7qnuJJOOzH/N6Oudr1ZxzoSh/Pv2+HeW
         X542xAkgCH9JjryGuKQ2b5i4rwCa4mznRQ8OpSqGwPVyATG4YynabtKWS0NpeKBhH289
         pRiA==
X-Forwarded-Encrypted: i=1; AJvYcCUAz3izrORjWp21hygN3OnoCny19OsvuYIDIibxkN29VMJfHUhW6Pmn41L6i9SSHFXYai8o0Htwz6qna+xR@vger.kernel.org
X-Gm-Message-State: AOJu0YxBX9CgaXchy65KC5vRJexKZTCsTuFYQyW50ZDYvliZuw/E0ItY
	fHDPxFYBZkaJeWdzzFSk4KMetLuefea7x3Usf9q5BQnjrxtNnqnxuQd8
X-Gm-Gg: ATEYQzzOKC1k3mew6HZxB9ZkD8g6bpDU8cS4j4JHE7uqMH3j8Sg8iQJtdklR6fHl34a
	jxv6qc36mNcZ/KEVimTsMZtSUEFIFLNT8S0KoaDjjcH/uJ/tyCNTZ4AIJ3UuiBmbZHxFJknKy4T
	eTVRfJJvFlSTrATgCcNs2b2Vnu5i7osyE1twB/B0sCsxDEj1PWWwEnU5/j2gJqgKKqCYfqKQvGk
	GXl47YwcnY5B/RxRiCxSW5ocNxGFE9CcVNR9rMFm5uKyrTWtKXUm8A+t9JBFvbHYOpjZIoOAwZL
	UTdtn8on6N6QS97TbUdnSfvvXwRU7goeoplQ+/Ecs4m0vrzDLC8n9ErEDIk9SQw8Xer4GXEIYFH
	ncrlg3xJgHthbqtnSga0ADD8z4TNJivs58o3I6yUNSCsIWROdnL+WBSNS3O+fTAvso5GycSvqvp
	ybFCHmh41BvDjEVOUYJ6Pd2p78ZsWB1dFxL9xGvY06GaYJL+kem8tGBjSCjA==
X-Received: by 2002:a05:600c:12d6:b0:487:1c2:6a4f with SMTP id 5b1f17b1804b1-48701c26bdamr24091855e9.31.1774031326986;
        Fri, 20 Mar 2026 11:28:46 -0700 (PDT)
Received: from ddp-thinkpad.tail20b0d.ts.net ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe7e2665sm92433725e9.6.2026.03.20.11.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 11:28:46 -0700 (PDT)
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
Subject: [PATCH v2 2/2] io_uring: Add IORING_OP_DUP
Date: Fri, 20 Mar 2026 18:23:41 +0000
Message-ID: <20260320182341.780295-3-daniele.di.proietto@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320182341.780295-1-daniele.di.proietto@gmail.com>
References: <20260320182341.780295-1-daniele.di.proietto@gmail.com>
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
 fs/file.c                     | 102 ++++++++++++-------
 fs/internal.h                 |   5 +
 include/uapi/linux/io_uring.h |  17 ++++
 io_uring/opdef.c              |   8 ++
 io_uring/openclose.c          | 180 ++++++++++++++++++++++++++++++++++
 io_uring/openclose.h          |   4 +
 6 files changed, 279 insertions(+), 37 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 384c83ce768d..64d712ef89b5 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -285,9 +285,8 @@ static int expand_fdtable(struct files_struct *files, unsigned int nr)
  * Return <0 error code on error; 0 on success.
  * The files->file_lock should be held on entry, and will be held on exit.
  */
-static int expand_files(struct files_struct *files, unsigned int nr)
-	__releases(files->file_lock)
-	__acquires(files->file_lock)
+int expand_files(struct files_struct *files, unsigned int nr)
+	__releases(files->file_lock) __acquires(files->file_lock)
 {
 	struct fdtable *fdt;
 	int error;
@@ -1291,13 +1290,33 @@ bool get_close_on_exec(unsigned int fd)
 	return res;
 }
 
-static int do_dup2(struct files_struct *files,
-	struct file *file, unsigned fd, unsigned flags)
-__releases(&files->file_lock)
+/**
+ * do_replace_fd_locked() - Installs a file on a specific fd number.
+ * @files: struct files_struct to install the file on.
+ * @file: struct file to be installed.
+ * @fd: number in the files table to replace
+ * @flags: the O_* flags to apply to the new fd entry
+ *
+ * Installs a @file on the specific @fd number on the @files table.
+ *
+ * The caller must makes sure that @fd fits inside the @files table, likely via
+ * expand_files().
+ *
+ * Requires holding @files->file_lock.
+ *
+ * This helper handles its own reference counting of the incoming
+ * struct file.
+ *
+ * Returns a preexisting file in @fd, if any, NULL, if none or an error.
+ */
+struct file *do_replace_fd_locked(struct files_struct *files, struct file *file,
+				  unsigned int fd, unsigned int flags)
 {
 	struct file *tofree;
 	struct fdtable *fdt;
 
+	lockdep_assert_held(&files->file_lock);
+
 	/*
 	 * dup2() is expected to close the file installed in the target fd slot
 	 * (if any). However, userspace hand-picking a fd may be racing against
@@ -1328,26 +1347,19 @@ __releases(&files->file_lock)
 	fd = array_index_nospec(fd, fdt->max_fds);
 	tofree = rcu_dereference_raw(fdt->fd[fd]);
 	if (!tofree && fd_is_open(fd, fdt))
-		goto Ebusy;
+		return ERR_PTR(-EBUSY);
 	get_file(file);
 	rcu_assign_pointer(fdt->fd[fd], file);
 	__set_open_fd(fd, fdt, flags & O_CLOEXEC);
-	spin_unlock(&files->file_lock);
-
-	if (tofree)
-		filp_close(tofree, files);
-
-	return fd;
 
-Ebusy:
-	spin_unlock(&files->file_lock);
-	return -EBUSY;
+	return tofree;
 }
 
 int replace_fd(unsigned fd, struct file *file, unsigned flags)
 {
-	int err;
 	struct files_struct *files = current->files;
+	struct file *tofree;
+	int err;
 
 	if (!file)
 		return close_fd(fd);
@@ -1359,9 +1371,14 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
 	err = expand_files(files, fd);
 	if (unlikely(err < 0))
 		goto out_unlock;
-	err = do_dup2(files, file, fd, flags);
-	if (err < 0)
-		return err;
+	tofree = do_replace_fd_locked(files, file, fd, flags);
+	spin_unlock(&files->file_lock);
+
+	if (IS_ERR(tofree))
+		return PTR_ERR(tofree);
+
+	if (tofree)
+		filp_close(tofree, files);
 	return 0;
 
 out_unlock:
@@ -1422,11 +1439,29 @@ int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags)
 	return new_fd;
 }
 
-static int ksys_dup3(unsigned int oldfd, unsigned int newfd, int flags)
+static struct file *do_dup3(struct files_struct *files, unsigned int oldfd,
+			    unsigned int newfd, int flags)
+	__releases(files->file_lock) __acquires(files->file_lock)
 {
-	int err = -EBADF;
 	struct file *file;
+	int err = 0;
+
+	err = expand_files(files, newfd);
+	file = files_lookup_fd_locked(files, oldfd);
+	if (unlikely(!file))
+		return ERR_PTR(-EBADF);
+	if (err < 0) {
+		if (err == -EMFILE)
+			err = -EBADF;
+		return ERR_PTR(err);
+	}
+	return do_replace_fd_locked(files, file, newfd, flags);
+}
+
+static int ksys_dup3(unsigned int oldfd, unsigned int newfd, int flags)
+{
 	struct files_struct *files = current->files;
+	struct file *to_free;
 
 	if ((flags & ~O_CLOEXEC) != 0)
 		return -EINVAL;
@@ -1438,22 +1473,15 @@ static int ksys_dup3(unsigned int oldfd, unsigned int newfd, int flags)
 		return -EBADF;
 
 	spin_lock(&files->file_lock);
-	err = expand_files(files, newfd);
-	file = files_lookup_fd_locked(files, oldfd);
-	if (unlikely(!file))
-		goto Ebadf;
-	if (unlikely(err < 0)) {
-		if (err == -EMFILE)
-			goto Ebadf;
-		goto out_unlock;
-	}
-	return do_dup2(files, file, newfd, flags);
-
-Ebadf:
-	err = -EBADF;
-out_unlock:
+	to_free = do_dup3(files, oldfd, newfd, flags);
 	spin_unlock(&files->file_lock);
-	return err;
+
+	if (IS_ERR(to_free))
+		return PTR_ERR(to_free);
+	if (to_free)
+		filp_close(to_free, files);
+
+	return newfd;
 }
 
 SYSCALL_DEFINE3(dup3, unsigned int, oldfd, unsigned int, newfd, int, flags)
diff --git a/fs/internal.h b/fs/internal.h
index cbc384a1aa09..c3d1eaf65328 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -197,6 +197,11 @@ extern struct file *do_file_open_root(const struct path *,
 extern struct open_how build_open_how(int flags, umode_t mode);
 extern int build_open_flags(const struct open_how *how, struct open_flags *op);
 struct file *file_close_fd_locked(struct files_struct *files, unsigned fd);
+struct file *do_replace_fd_locked(struct files_struct *files, struct file *file,
+				  unsigned int fd, unsigned int flags)
+	__must_hold(files->file_lock);
+int expand_files(struct files_struct *files, unsigned int nr)
+	__releases(files->file_lock) __acquires(files->file_lock);
 
 int do_ftruncate(struct file *file, loff_t length, int small);
 int do_sys_ftruncate(unsigned int fd, loff_t length, int small);
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
index c71242915dad..2658adbfd17a 100644
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
+}
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
+	if (id->flags & ~(IORING_DUP_NO_CLOEXEC | IORING_DUP_OLD_FIXED |
+			  IORING_DUP_NEW_FIXED))
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
+		id->rsrc_node =
+			io_file_get_fixed_node(req, file_slot, issue_flags);
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
+static int io_dup_to_fd(struct io_kiocb *req, unsigned int issue_flags,
+			bool old_fixed, int old_fd, int new_fd, int o_flags)
+{
+	struct file *old_file, *to_replace, *to_close = NULL;
+	bool non_block = issue_flags & IO_URING_F_NONBLOCK;
+	struct files_struct *files = current->files;
+	int ret;
+
+	if (new_fd >= rlimit(RLIMIT_NOFILE))
+		return -EBADF;
+
+	if (old_fixed)
+		old_file = io_dup_get_old_file_fixed(req, issue_flags, old_fd);
+
+	spin_lock(&files->file_lock);
+
+	/* Do we need to expand? If so, be safe and punt to async */
+	if (new_fd >= files_fdtable(files)->max_fds && non_block)
+		goto out_again;
+	ret = expand_files(files, new_fd);
+	if (ret < 0)
+		goto out_unlock;
+
+	if (!old_fixed)
+		old_file = files_lookup_fd_locked(files, old_fd);
+
+	ret = -EBADF;
+	if (!old_file)
+		goto out_unlock;
+
+	to_replace = files_lookup_fd_locked(files, new_fd);
+	if (to_replace) {
+		if (io_is_uring_fops(to_replace))
+			goto out_unlock;
+
+		/* if the file has a flush method, be safe and punt to async */
+		if (to_replace->f_op->flush && non_block)
+			goto out_again;
+	}
+	to_close = do_replace_fd_locked(files, old_file, new_fd, o_flags);
+	ret = new_fd;
+
+out_unlock:
+	spin_unlock(&files->file_lock);
+
+	if (IS_ERR(to_close))
+		ret = PTR_ERR(to_close);
+	else if (to_close)
+		filp_close(to_close, files);
+
+	if (ret < 0)
+		req_set_fail(req);
+	io_req_set_res(req, ret, 0);
+	return IOU_COMPLETE;
+
+out_again:
+	spin_unlock(&files->file_lock);
+	return -EAGAIN;
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

