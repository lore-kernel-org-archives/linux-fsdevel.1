Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53561481FAE
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 10:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630164; cv=none; b=RFwMHtddQA9sMWw8UzukXVDWDnIHYkbb56sfJXYGQ3vslx5KmS/HxYysV9lJZVaapD+2bK/k4W1ZdWknvcLJEXL+RdJ9DQVc/fvLZIUQyQi4A1xz9W6JKO26/Fbg4kNQlb82eBf8XnhWG7cFZISiMl5FIIfKO4x/nAvZWH+iD/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630164; c=relaxed/simple;
	bh=AHoE8B0vKzWqpdJAHDaftEMLzrqBA9eXmvJ0WGKiDF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6rxBy9ffTRNsBvmWXdXyv1Jabbo7MbWbwHMJZv1Bb/2MioExrTSNs/hUI/To6FVjy391iJD8stptABevQo6o0f7dqzP3hmnxSbJUEQvYp4qBxT8UEvDJQkwzj5tBloJUIGjroS+U12P7XaGzYVTU3PlB+xBq/apfbJb7WYQtYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rhxK76fw; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhxK76fw"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cca0c5799eso88426225ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 03:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784630162; x=1785234962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HrK5Y+cUu3sn93vpsDCo0Tjc6K/8b9DvciXsUp54rDw=;
        b=rhxK76fwYSV+kxNzS+Y8rrTNMtBI7+fVKKGjWlwv+4mdFoOAMJg35idY/lqUoM5e6s
         XdiPzmCV73jqsWZc0WEpZxmEgneSpdgk6WdG5i799MEkNUOiPV49h3XYEnIcGbGWGSnD
         3b9vlxPoqghQWnNXpXfcdPoXpKDpgIwH4IOF5RW9NUQOkYcQyhSL1S91Mmlcdqf7zWdr
         Rx0H054Ij1pEWrh5jcRBhHK4W0nRhnUa8AOmt4KF8lQf/mgBjzESp2LISBZP6fRTw2z+
         9wALTJd1cUdzSetiH6sL8QktzpVmm9cWZJnOoBRmPZBF6t6CsFy0/H6nBCqKmEAHb1MS
         RXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784630162; x=1785234962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HrK5Y+cUu3sn93vpsDCo0Tjc6K/8b9DvciXsUp54rDw=;
        b=ciQaGJp0ASS0i/V5XMn8zUHVVDSHM2BG8+RfeWCds5vM3JJSjy1Bh9rdQKliUh2u7f
         mKReEDY84zmb+wlmkPoqCtWLrCDPqvxRj2mm9J2CZvUC/j7d7P0Q6zqJqjXsyopkccnw
         tvHf7LfNI3t2la5Gs+vLiJJmHEPQTdR6oINQP8PBLbQrgv+/aOrqfjCqnowy8ndLmS8U
         a080l6wu25mQ57Zezj1BcdYFmdrEuF/CHVLcsVH9M1h+3s3/ClCrTOQ9uoT8jvqhgLaW
         ODCYFP6+sR3poDDgfFjeHvBDKNyXR54izRI1H2xNnsPd/e6+c5mGZexuyDylXI1g5o8o
         waxA==
X-Forwarded-Encrypted: i=1; AHgh+RozpMf+03F7Q/a/xlBHufPa3zYpr00w3oRN4xmDR4+PzkEqdrwy0zCnFXnNptHH6wrfgL4sXnbSrpWs0OIi@vger.kernel.org
X-Gm-Message-State: AOJu0YwO5kPwL8NhAoi8pOvs/dzHiuM5TaRW+Ag8VKKtc/JokhIk1l7z
	sDH4SgExuKS+Td51eo79SinqlbGJQvqvQfdDmtI51XFf5l9+4+DHYqP9
X-Gm-Gg: AfdE7clVYQSjivGnBEDQHcu2ekl83t/UnqDBcp/hib6zLfAXtKF7zF6E/3e/xKGgcqW
	/KaDsxfPSh30uG66506zuo8WF3RlsXW1rs+jMGmNbvImJiZOZ1+OmjwGI9FyX8MVeTqNBQTWLhY
	zotUfYXIrEIgy+PUunNEPhbM1n+mGjZu46bsoDMmwE1+I3bA5kTzLpYCvmvFDOu3SxfkJqjhsKR
	QMFPjRhZ9O9yTM2L8wm6vo+bt7RyZZYMzOemOLBhliJtuIwGcMWJSHE8t5vvR1DZp4KwsM3tjWG
	hqvs4hyS/0QxqkKupttxZcYLhtwNCISNa1elL5tjCYy1bMBW/inkmTmErE48oIrDDRKy5j88Vir
	Tik8x7NY77hBkMDt0AhCTmOXXPntIaOv7WkuTxW2A6J6+hWV9UOw2msyuHeeS4SGoOqxX11wXsj
	1nHXeFslWDZz8Ikbc4TpNlWkou/18T6peMzhCnt+Z0me8l1z536Q29/LT/Ss070AsQn2uoghOZ8
	CsXL9eS6qgeGwYSNFljORIIfeoGUTIZ4Q2EcHqbNRMYb2B1PwI4ZNOKI5kjC9UppFNz2xen3Okg
	PNL7ymh9OiUMVwk=
X-Received: by 2002:a05:6a21:e097:b0:3c3:7762:5d51 with SMTP id adf61e73a8af0-3c3ad9ecc4fmr19421868637.62.1784630162578;
        Tue, 21 Jul 2026 03:36:02 -0700 (PDT)
Received: from cs-1047136853211-default.asia-southeast1-a.c.z168d0f9edf9bc766-tp.internal (114.107.87.34.bc.googleusercontent.com. [34.87.107.114])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a20c158sm49922929eec.29.2026.07.21.03.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 03:36:02 -0700 (PDT)
From: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>,
	io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
Subject: [PATCH v3 2/2] io_uring: add fremovexattr and flistxattr support
Date: Tue, 21 Jul 2026 10:35:14 +0000
Message-ID: <20260721103514.2716-3-aditya.ansh182@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721103514.2716-1-aditya.ansh182@gmail.com>
References: <20260721103514.2716-1-aditya.ansh182@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for IORING_OP_FREMOVEXATTR and IORING_OP_FLISTXATTR. This
enables xattr listing and removal operations to be executed in an
asynchronous fashion.

Signed-off-by: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
---
 include/uapi/linux/io_uring.h       |  2 +
 io_uring/opdef.c                    | 18 +++++++
 io_uring/xattr.c                    | 74 +++++++++++++++++++++++++++++
 io_uring/xattr.h                    |  6 +++
 tools/include/uapi/linux/io_uring.h | 13 +++++
 5 files changed, 113 insertions(+)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 909fb7aea638..805f1e31f492 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -318,6 +318,8 @@ enum io_uring_op {
 	IORING_OP_PIPE,
 	IORING_OP_NOP128,
 	IORING_OP_URING_CMD128,
+	IORING_OP_FREMOVEXATTR,
+	IORING_OP_FLISTXATTR,
 
 	/* this goes last, obviously */
 	IORING_OP_LAST,
diff --git a/io_uring/opdef.c b/io_uring/opdef.c
index 4e58eb1344ea..25d9229d8fc0 100644
--- a/io_uring/opdef.c
+++ b/io_uring/opdef.c
@@ -591,6 +591,16 @@ const struct io_issue_def io_issue_defs[] = {
 		.prep			= io_uring_cmd_prep,
 		.issue			= io_uring_cmd,
 	},
+	[IORING_OP_FREMOVEXATTR] = {
+		.needs_file		= 1,
+		.prep			= io_fremovexattr_prep,
+		.issue			= io_fremovexattr,
+	},
+	[IORING_OP_FLISTXATTR] = {
+		.needs_file		= 1,
+		.prep			= io_flistxattr_prep,
+		.issue			= io_flistxattr,
+	},
 };
 
 const struct io_cold_def io_cold_defs[] = {
@@ -849,6 +859,14 @@ const struct io_cold_def io_cold_defs[] = {
 		.sqe_copy		= io_uring_cmd_sqe_copy,
 		.cleanup		= io_uring_cmd_cleanup,
 	},
+	[IORING_OP_FREMOVEXATTR] = {
+		.name			= "FREMOVEXATTR",
+		.cleanup		= io_xattr_cleanup,
+	},
+	[IORING_OP_FLISTXATTR] = {
+		.name			= "FLISTXATTR",
+		.cleanup		= io_xattr_cleanup,
+	},
 };
 
 const char *io_uring_get_opcode(u8 opcode)
diff --git a/io_uring/xattr.c b/io_uring/xattr.c
index 5303df3f247f..9b410f91ef43 100644
--- a/io_uring/xattr.c
+++ b/io_uring/xattr.c
@@ -195,3 +195,77 @@ int io_setxattr(struct io_kiocb *req, unsigned int issue_flags)
 	io_xattr_finish(req, ret);
 	return IOU_COMPLETE;
 }
+
+int io_fremovexattr_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
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
+int io_flistxattr_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
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
diff --git a/io_uring/xattr.h b/io_uring/xattr.h
index 9b459d2ae90c..d2487b49a5d2 100644
--- a/io_uring/xattr.h
+++ b/io_uring/xattr.h
@@ -13,3 +13,9 @@ int io_fgetxattr(struct io_kiocb *req, unsigned int issue_flags);
 
 int io_getxattr_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
 int io_getxattr(struct io_kiocb *req, unsigned int issue_flags);
+
+int io_fremovexattr_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
+int io_fremovexattr(struct io_kiocb *req, unsigned int issue_flags);
+
+int io_flistxattr_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
+int io_flistxattr(struct io_kiocb *req, unsigned int issue_flags);
diff --git a/tools/include/uapi/linux/io_uring.h b/tools/include/uapi/linux/io_uring.h
index f1c16f817742..79bf7c22009d 100644
--- a/tools/include/uapi/linux/io_uring.h
+++ b/tools/include/uapi/linux/io_uring.h
@@ -253,6 +253,19 @@ enum io_uring_op {
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
+	IORING_OP_FREMOVEXATTR,
+	IORING_OP_FLISTXATTR,
 
 	/* this goes last, obviously */
 	IORING_OP_LAST,
-- 
2.47.3

