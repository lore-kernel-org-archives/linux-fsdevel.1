Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786F83BB13D
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 08:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624138; cv=none; b=nsN1Wt8vF1SY5XhmENoCqB+6m5etHdwGnUaYxjoSAcVpuj7I1XoiKri2A0GcrJYpToucCEe6E/YD1pYgA28fcQpQk6tjowKP8B9z0xu83PiEsrFyzYqN22QPMaOC5oeD+bVNNGoqZNMCCbM5G/Tnwew68bH3JSJbTpev3kdP3vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624138; c=relaxed/simple;
	bh=AHoE8B0vKzWqpdJAHDaftEMLzrqBA9eXmvJ0WGKiDF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBXEuzoC22zZ0waMRWURhNBq9gp/4b33IYv3o3HOcihfmPUK+yqWd2zyDpt8/ByyxOWgpdhXri20Ql6un8tHK82epCEsF+8hFPgh2PVxz8pUKKbfOO3CR1LyfEoskCNqdAdPBHLLOS1vb9dQliktTew7Wt7usSYegaIvskyb62I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QP+40urf; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QP+40urf"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cf50c6f235so30630365ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 01:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784624137; x=1785228937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HrK5Y+cUu3sn93vpsDCo0Tjc6K/8b9DvciXsUp54rDw=;
        b=QP+40urfPdUY49NZGf6Kuf2Xe+QAVOviffBp3Ddmf0NunylXdkKyzHKUmYR1MOQidd
         9E70IzMVuQo2bOWRzFXJK3Ykc3JvAMY+wQ4xHwBFEpHAtkXkNHV6O8GNNvnzXaKhmKSw
         xRMB96KNPwkvP6m0obKkbtuIiGh3XL9C4IaKKVpQFq6Cz9GrJYdFd+LflpiBMaPp/YyZ
         0bfmDYftTULDlgrcLXQIl5Us1Ei2MTIFycahbQ+4m4knzGxMLrz/5ese11GElNKN8gcJ
         ZuIA3ybK1v5PgE310J9qPB00KkWO3kU6gn/0MqZLVqiZ12Jtgm35akSWi51viuTE6GS2
         O1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784624137; x=1785228937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HrK5Y+cUu3sn93vpsDCo0Tjc6K/8b9DvciXsUp54rDw=;
        b=eR8IWIAba6CINWqo9x+0MbSu0If9qnQEGa30CzsGYD12fjrIybTqaQF8FMDcExxG+Y
         ZNli02liAUhugNGfBmRa1gVXT6CeUaNZaAafEjpr53Vo0FX6AZS+2zrrGmtHURUZv58Z
         erAQcsnGaxQ9m8oQOBsMpfmruaLolGafU8unBNO2jHj+9wai2MHeMy2O3e8S3WqfFtIH
         fbibKpk66oNkK0D+uKP+70DDwRgAEqskzGyCqI0H9NtSIrF98qIZAjPQd7QdPDA+rUbI
         LIhczr+ZRno9TfskbVLbsaF9gGTDSpe7jdhVKT55X10TVZBkhIXwWhOsVAsDXsHGFkRx
         rdmQ==
X-Forwarded-Encrypted: i=1; AHgh+RpRvO5MWBKfwUfsurR4ff/ohNRwr8JiyICFsXSqlPJUNeNYRktnD1aAiQm5IlBqVpyfx976l+vY5JwIk7HC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1wTIxdMjX/PzPylRJa+Jx4mPkzCPgQA8T+sTc3frsD1ORHzCh
	UIMbTSeHjDvhCJ8G+QLFwjwSYDPFQWgbwFqJ5gs/m9ZeQslJI7VpgP30
X-Gm-Gg: AfdE7clqNU3MG4qh+x63yQZqJD1qiThR4sZVFSwVHdGdD+Gz4LZYiVFW8QGuboGg0Lq
	AFz3Lm8MAAGhCXctkS4Q9K46MqCZ+Dup4ms5ODDjbz7eZRpv2HTqiOan9HB+tdp/hmH3qX0ITA1
	leJwjilo/JnvuNz9bV6PcpDI0pUczan5HEhjJTxMZei+r49M2q75aIi0F1YX1dEee0DprzZ7cqh
	ffHvVPsuAFBKAiACQkSZ6EZRGDBaz/hmjAim+vxoFK/Z/f8GjlhpKbnKzjEGOEelC6GWKeaQl1P
	UMnFecRGo1LP85+NDbQ1B/Fy/A8zXxxzEVG3SMGPYVdoIL+w8ZrZ1nqsMW+r6bkfia/farwtLzX
	LKZgmFJ/SYe5NMItsgDgVri2LrrxA0Ekof0pz/ZERqMAy+yGSaZR2ZvqlCxwKlM7SqQWDLsHjUO
	QsdhJPXrGJhsUumM8Kr1G0S1wZlL13OHrKEXYzARs8ECBWS9bNpf+qQ3SsyXhjHnrv6ruyq6VMY
	o203O1XK4qWB7LiSFkm8eJWPF1LxrBRQmCR06GOOmDy5ceBCYJbLRN9WH0cZZRMvpeatXMqzzmg
	o8cD6aVvv0+J3ijYlXec
X-Received: by 2002:a05:6a21:6b83:b0:3c3:8222:b8c9 with SMTP id adf61e73a8af0-3c3ada39a49mr19476672637.67.1784624136841;
        Tue, 21 Jul 2026 01:55:36 -0700 (PDT)
Received: from cs-1047136853211-default.asia-southeast1-b.c.z168d0f9edf9bc766-tp.internal (8.99.126.34.bc.googleusercontent.com. [34.126.99.8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429cf22b3sm45463137eec.0.2026.07.21.01.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 01:55:36 -0700 (PDT)
From: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>,
	io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
Subject: [PATCH v2 2/2] io_uring: add fremovexattr and flistxattr support
Date: Tue, 21 Jul 2026 08:54:58 +0000
Message-ID: <20260721085458.2716-3-aditya.ansh182@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721085458.2716-1-aditya.ansh182@gmail.com>
References: <20260721085458.2716-1-aditya.ansh182@gmail.com>
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

