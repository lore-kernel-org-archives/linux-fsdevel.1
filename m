Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4F03BD647
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 07:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784532176; cv=none; b=Jnx4byRGoohxX5xW3xSOORamjyIUQbemwS3SWut95+++lr8bY94jjgLHQZTcU2I5eueUFYQspdFtHRAscPPXrUfqLib+XC2nAWv5BE2zweGgtlNgcaLdU+3oHUDNmz+2KRPeZ/AT51/RE4860R7vX1rqACG5oiVjFutqkp7BgkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784532176; c=relaxed/simple;
	bh=B6Ck4tcZ+553hbfzb7ngKWwlSDjfayHx3mTtuH76Yvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RstDDRCneQkSxCApHBLhm+eNjpE9qG5g0JZ0R53NLQEdH+fo8Isffi3Ez7Okl0TkOs3kejDmXjdZoIRYdTCU7O1eW0jwNE4oqyNQRA+30QXV6OAf7U201NZPa22Ql7n4IncbMYjWVXthdQKftznXB5fFdX4wnFrPIiybqa9C/0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJBjAZVT; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJBjAZVT"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ca965de53baso3429467a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 00:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784532172; x=1785136972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5WeY2WU1XyNykLdBTFGvVVw8jQPcGyVoj+YOIRoHbN8=;
        b=nJBjAZVTWADg4JKylspaLEyQb+gE+8W09WRY0Xttfs+3YxGifhIGKh2CE5EIrIltkM
         BBYz2NgBLhK2zbdHTK9XVQuET7CS9Y4lAs+QBmHcJ4wCdYLo/W+u9mUNaQ9b8xrhQX8z
         GohLj91OyzdwGxZG0yC46Msu9WdmflGcUf2kBJOAnwbw4uhIFyH+CurshbHuXEmAqxjw
         Y/Gygbofckeap8wrsMCVBkixSkPwcbttLQ4GEBZR0WvfX9MwEUdOzblOv4DOD/ZX5WRj
         Ls8Y60Ix2Io0EaCDsC6Rb2XeqBfOgWNUFDbCIhAYJ8botakOHBqHoB4WwYmBR0eZksru
         zB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784532172; x=1785136972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5WeY2WU1XyNykLdBTFGvVVw8jQPcGyVoj+YOIRoHbN8=;
        b=qHNUt7qrgjjEcqoklS8R+IwfP5V0ZMNpF0+0pomTz6gQEp21S/bI1O3nEhqqUfMYSF
         C6hlAgFaadA25mfy8uo6Eo+/vaRN08TZd3D7LfbG+C/zxYSmzZYvpvuKAXzPOlKlDy2N
         MEd57SkUlQ32M2W3/56QgihSmoWgw0dBULYQivous3smtG+Ca2MtncH8bZrwwkn6mPGo
         JXA/qxICWyLY2l8TMzrafpk4IXUnevYbhSOS6sORjet9KWe3NcB3JhlEFxUOP2d0CH/c
         pgyRkPTPVxqzMtK5r/bqVY3nt73WxYPC93N7xHrDYAXFFsOd2gb2FfZLk8M4cMwQ5wto
         N8CQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro4kV1dvZ83/78pvJEVeeCWLJKzv4+qLC2O1WhJ5zdDXVx9PYJ98BXHDOJVNIRJJuyuK8CriTQfZnlI0nIc@vger.kernel.org
X-Gm-Message-State: AOJu0YxRMkkdJ5SAbFBV7RX7jkP1nD59ATaVmHnzDy5ybsFbZvxLqOYp
	uIB1ULOi+nLVx+JOLxAN0Cn/O+csHQ/kfz39E9xfKT15KDr8zuv1teeP
X-Gm-Gg: AfdE7ckyy9k03xaZy2iIFlfxP8nOErXbs4WQsNsaof9+5r76158RzVHYFxsf0mXj9px
	wh6LpBeusT0AXNubP2pCusCBPsgV3agX/rsfdhxa/QVm8YvSWDjj0AH9a0syDZXzn67u675Ff+E
	Aq7w4IDOIIlOfEHyf6aGsLm3V7Uw2EpZtjUc2QJaHTTCQBMz3RrUgKDoHex5bphzNehJMRJ8YUr
	isCm+SpnucNZ+rT9Fi3bf/3+HwOwabj11HocwiWRYFeV08WxAsuftVf8cQnOMg+mK7DXUr47nGX
	WHiLuNjO1ZNE8OQ0qp8qztj9m7qJT9rzehAIx8bdzY0monSwt/J7MrPP4XWxVCZ4i97BCcfeBEu
	uVCNFkdMfmSR9xuapkWVpomG1Ro8jqTf6rb+cevaTXRnzL4ksHJCpmww3Do7oo97XyrDlDdxFvE
	aeGVlvSWx8Br/y01WB0E6ccke2n0JcgCSWzRnBCTrJaJcnYVKwiDvyI81of4iTYLJ8nbKc3d0kO
	mI2pMEd/g+hyg+qxBYF7vaavH7w/ExIC0c5xYsdTUFYgCWteiBJGmepNBFZ5aw6hwseGHQZubwl
	6dqsqpWd/DmgyyM=
X-Received: by 2002:a05:6a00:10cd:b0:845:dfef:75b8 with SMTP id d2e1a72fcca58-84c29263072mr12458423b3a.15.1784532171867;
        Mon, 20 Jul 2026 00:22:51 -0700 (PDT)
Received: from cs-1047136853211-default.asia-southeast1-b.c.z168d0f9edf9bc766-tp.internal (43.173.126.34.bc.googleusercontent.com. [34.126.173.43])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb519de26a5sm4064176a12.22.2026.07.20.00.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 00:22:51 -0700 (PDT)
From: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>,
	io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
Subject: [PATCH 2/2] io_uring: add removexattr and listxattr support
Date: Mon, 20 Jul 2026 07:22:13 +0000
Message-ID: <20260720072213.2719-3-aditya.ansh182@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720072213.2719-1-aditya.ansh182@gmail.com>
References: <20260720072213.2719-1-aditya.ansh182@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the following four xattr operations to complete io_uring's
xattr feature parity:
- IORING_OP_REMOVEXATTR
- IORING_OP_FREMOVEXATTR
- IORING_OP_LISTXATTR
- IORING_OP_FLISTXATTR

The implementation invokes the newly exported non-static VFS helpers:
file_removexattr(), filename_removexattr(), file_listxattr(), and
filename_listxattr().

We reuse the existing 'struct io_xattr' and 'io_xattr_cleanup()' to
cleanly handle allocation/cleanup flow, with delayed filename handling,
proper variable scoping, and 100% style compliance.

Signed-off-by: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
---
 include/uapi/linux/io_uring.h       |   4 +
 io_uring/opdef.c                    |  34 +++++++
 io_uring/xattr.c                    | 151 ++++++++++++++++++++++++++++
 io_uring/xattr.h                    |  12 +++
 tools/include/uapi/linux/io_uring.h |  15 +++
 5 files changed, 216 insertions(+)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 909fb7aea638..528c394b71a5 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -318,6 +318,10 @@ enum io_uring_op {
 	IORING_OP_PIPE,
 	IORING_OP_NOP128,
 	IORING_OP_URING_CMD128,
+	IORING_OP_REMOVEXATTR,
+	IORING_OP_FREMOVEXATTR,
+	IORING_OP_LISTXATTR,
+	IORING_OP_FLISTXATTR,
 
 	/* this goes last, obviously */
 	IORING_OP_LAST,
diff --git a/io_uring/opdef.c b/io_uring/opdef.c
index 4e58eb1344ea..318f53a8a023 100644
--- a/io_uring/opdef.c
+++ b/io_uring/opdef.c
@@ -591,6 +591,24 @@ const struct io_issue_def io_issue_defs[] = {
 		.prep			= io_uring_cmd_prep,
 		.issue			= io_uring_cmd,
 	},
+	[IORING_OP_REMOVEXATTR] = {
+		.prep			= io_removexattr_prep,
+		.issue			= io_removexattr,
+	},
+	[IORING_OP_FREMOVEXATTR] = {
+		.needs_file		= 1,
+		.prep			= io_fremovexattr_prep,
+		.issue			= io_fremovexattr,
+	},
+	[IORING_OP_LISTXATTR] = {
+		.prep			= io_listxattr_prep,
+		.issue			= io_listxattr,
+	},
+	[IORING_OP_FLISTXATTR] = {
+		.needs_file		= 1,
+		.prep			= io_flistxattr_prep,
+		.issue			= io_flistxattr,
+	},
 };
 
 const struct io_cold_def io_cold_defs[] = {
@@ -849,6 +867,22 @@ const struct io_cold_def io_cold_defs[] = {
 		.sqe_copy		= io_uring_cmd_sqe_copy,
 		.cleanup		= io_uring_cmd_cleanup,
 	},
+	[IORING_OP_REMOVEXATTR] = {
+		.name			= "REMOVEXATTR",
+		.cleanup		= io_xattr_cleanup,
+	},
+	[IORING_OP_FREMOVEXATTR] = {
+		.name			= "FREMOVEXATTR",
+		.cleanup		= io_xattr_cleanup,
+	},
+	[IORING_OP_LISTXATTR] = {
+		.name			= "LISTXATTR",
+		.cleanup		= io_xattr_cleanup,
+	},
+	[IORING_OP_FLISTXATTR] = {
+		.name			= "FLISTXATTR",
+		.cleanup		= io_xattr_cleanup,
+	},
 };
 
 const char *io_uring_get_opcode(u8 opcode)
diff --git a/io_uring/xattr.c b/io_uring/xattr.c
index 5303df3f247f..614996455ce9 100644
--- a/io_uring/xattr.c
+++ b/io_uring/xattr.c
@@ -195,3 +195,154 @@ int io_setxattr(struct io_kiocb *req, unsigned int issue_flags)
 	io_xattr_finish(req, ret);
 	return IOU_COMPLETE;
 }
+
+static int __io_removexattr_prep(struct io_kiocb *req,
+				 const struct io_uring_sqe *sqe)
+{
+	struct io_xattr *ix = io_kiocb_to_cmd(req, struct io_xattr);
+	const char __user *name;
+	int ret;
+
+	INIT_DELAYED_FILENAME(&ix->filename);
+	name = u64_to_user_ptr(READ_ONCE(sqe->addr));
+
+	if (READ_ONCE(sqe->addr2) || READ_ONCE(sqe->len) || READ_ONCE(sqe->xattr_flags))
+		return -EINVAL;
+
+	ix->ctx.kname = kmalloc_obj(*ix->ctx.kname);
+	if (!ix->ctx.kname)
+		return -ENOMEM;
+
+	ret = import_xattr_name(ix->ctx.kname, name);
+	if (ret) {
+		kfree(ix->ctx.kname);
+		return ret;
+	}
+
+	req->flags |= REQ_F_NEED_CLEANUP;
+	req->flags |= REQ_F_FORCE_ASYNC;
+	return 0;
+}
+
+int io_fremovexattr_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+{
+	return __io_removexattr_prep(req, sqe);
+}
+
+int io_removexattr_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+{
+	struct io_xattr *ix = io_kiocb_to_cmd(req, struct io_xattr);
+	const char __user *path;
+	int ret;
+
+	if (unlikely(req->flags & REQ_F_FIXED_FILE))
+		return -EBADF;
+
+	ret = __io_removexattr_prep(req, sqe);
+	if (ret)
+		return ret;
+
+	path = u64_to_user_ptr(READ_ONCE(sqe->addr3));
+
+	return delayed_getname(&ix->filename, path);
+}
+
+int io_fremovexattr(struct io_kiocb *req, unsigned int issue_flags)
+{
+	struct io_xattr *ix = io_kiocb_to_cmd(req, struct io_xattr);
+	int ret;
+
+	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
+
+	ret = file_removexattr(req->file, ix->ctx.kname);
+	io_xattr_finish(req, ret);
+	return IOU_COMPLETE;
+}
+
+int io_removexattr(struct io_kiocb *req, unsigned int issue_flags)
+{
+	struct io_xattr *ix = io_kiocb_to_cmd(req, struct io_xattr);
+	int ret;
+
+	CLASS(filename_complete_delayed, name)(&ix->filename);
+
+	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
+
+	ret = filename_removexattr(AT_FDCWD, name, LOOKUP_FOLLOW, ix->ctx.kname);
+	io_xattr_finish(req, ret);
+	return IOU_COMPLETE;
+}
+
+static int __io_listxattr_prep(struct io_kiocb *req,
+			       const struct io_uring_sqe *sqe)
+{
+	struct io_xattr *ix = io_kiocb_to_cmd(req, struct io_xattr);
+
+	INIT_DELAYED_FILENAME(&ix->filename);
+	ix->ctx.kname = NULL;
+	ix->ctx.kvalue = NULL;
+
+	if (READ_ONCE(sqe->addr))
+		return -EINVAL;
+
+	ix->ctx.value = u64_to_user_ptr(READ_ONCE(sqe->addr2));
+	ix->ctx.size = READ_ONCE(sqe->len);
+	ix->ctx.flags = READ_ONCE(sqe->xattr_flags);
+
+	if (ix->ctx.flags)
+		return -EINVAL;
+
+	req->flags |= REQ_F_NEED_CLEANUP;
+	req->flags |= REQ_F_FORCE_ASYNC;
+	return 0;
+}
+
+int io_flistxattr_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+{
+	return __io_listxattr_prep(req, sqe);
+}
+
+int io_listxattr_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+{
+	struct io_xattr *ix = io_kiocb_to_cmd(req, struct io_xattr);
+	const char __user *path;
+	int ret;
+
+	if (unlikely(req->flags & REQ_F_FIXED_FILE))
+		return -EBADF;
+
+	ret = __io_listxattr_prep(req, sqe);
+	if (ret)
+		return ret;
+
+	path = u64_to_user_ptr(READ_ONCE(sqe->addr3));
+
+	return delayed_getname(&ix->filename, path);
+}
+
+int io_flistxattr(struct io_kiocb *req, unsigned int issue_flags)
+{
+	struct io_xattr *ix = io_kiocb_to_cmd(req, struct io_xattr);
+	int ret;
+
+	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
+
+	ret = file_listxattr(req->file, ix->ctx.value, ix->ctx.size);
+	io_xattr_finish(req, ret);
+	return IOU_COMPLETE;
+}
+
+int io_listxattr(struct io_kiocb *req, unsigned int issue_flags)
+{
+	struct io_xattr *ix = io_kiocb_to_cmd(req, struct io_xattr);
+	int ret;
+
+	CLASS(filename_complete_delayed, name)(&ix->filename);
+
+	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
+
+	ret = filename_listxattr(AT_FDCWD, name, LOOKUP_FOLLOW,
+				 ix->ctx.value, ix->ctx.size);
+	io_xattr_finish(req, ret);
+	return IOU_COMPLETE;
+}
diff --git a/io_uring/xattr.h b/io_uring/xattr.h
index 9b459d2ae90c..c3845d00fecc 100644
--- a/io_uring/xattr.h
+++ b/io_uring/xattr.h
@@ -13,3 +13,15 @@ int io_fgetxattr(struct io_kiocb *req, unsigned int issue_flags);
 
 int io_getxattr_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
 int io_getxattr(struct io_kiocb *req, unsigned int issue_flags);
+
+int io_fremovexattr_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
+int io_fremovexattr(struct io_kiocb *req, unsigned int issue_flags);
+
+int io_removexattr_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
+int io_removexattr(struct io_kiocb *req, unsigned int issue_flags);
+
+int io_flistxattr_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
+int io_flistxattr(struct io_kiocb *req, unsigned int issue_flags);
+
+int io_listxattr_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
+int io_listxattr(struct io_kiocb *req, unsigned int issue_flags);
diff --git a/tools/include/uapi/linux/io_uring.h b/tools/include/uapi/linux/io_uring.h
index f1c16f817742..7b083c1b14d2 100644
--- a/tools/include/uapi/linux/io_uring.h
+++ b/tools/include/uapi/linux/io_uring.h
@@ -253,6 +253,21 @@ enum io_uring_op {
 	IORING_OP_FUTEX_WAIT,
 	IORING_OP_FUTEX_WAKE,
 	IORING_OP_FUTEX_WAITV,
+	IORING_OP_FIXED_FD_INSTALL,
+	IORING_OP_FTRUNCATE,
+	IORING_OP_BIND,
+	IORING_OP_LISTEN,
+	IORING_OP_RECV_ZC,
+	IORING_OP_EPOLL_WAIT,
+	IORING_OP_READV_FIXED,
+	IORING_OP_WRITEV_FIXED,
+	IORING_OP_PIPE,
+	IORING_OP_NOP128,
+	IORING_OP_URING_CMD128,
+	IORING_OP_REMOVEXATTR,
+	IORING_OP_FREMOVEXATTR,
+	IORING_OP_LISTXATTR,
+	IORING_OP_FLISTXATTR,
 
 	/* this goes last, obviously */
 	IORING_OP_LAST,
-- 
2.47.3

