Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794653192;
	b=rzSFNkIl6Melrq4J8BRWzEy+XaUy6mEjL47JPrSm+RZxW9U7Ojm1UOJa5kxLHZ4AXNO5
	 dy0mVjrTynSCJXIogo/9AGsGEivtHEhIZ+wOoj8zRptyOsnwAKCrpP+m1AepyRzytdIl2
	 J40cdKPJOBrUlpSkPsaPryNr2dbynsvgIrfLxRZcCzp4YRbF3jbny3CVGf6839G0Xr+fn
	 dREj0iRGxJA28RJyKJfCi+xAvrZar4E29fVRK+O4qnPSqTaGUDBUPdLQruC8bS9ypXlyH
	 pi0+aXxl9bNb//kS7dRJKl95JkiiwJgEs5Y4eJQXVBPJfbGHGcSzL0AXkOWC+LZo8JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794653192;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BXrUhRGEqRiEVKCb5fpntove8ZFq2YMexNeI4JURA+A=;
	b=kUHuuEQt+agaJokQzfYKehNr5Pe4LCxv5LpDZFQihc+fts3LsluaxSlUiu3oOkHtKuGG
	 QJT62ag8aRMq82rfL79lCoyDxOz7Xc5pKJs4ZwGN1LtLBYhv+21GBWIasM3ukj4VG155d
	 C1j+gjQMU4rwXNjkAr0UrHfAoXJu0zJqUWgRa2Pv+BZlF9GjG2lAKfzSsjUufcr+Boluo
	 m7dPNZ0yi7nMDTHbS1x3HQiag6azaNo6cwWH/o15H1g8sF/LfC3eqs63tRMkk32SAXqaz
	 7XemWuPE8k3X9tO2N1HT0h+ry0bdzoaCFSArtOxoUOzsdyDO7MDS683XmtqcyPfBQNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IfU99Qqs;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C21B606A333
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 10:46:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C21B606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IfU99Qqs
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso10751065e9.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 02:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794653190; x=1795257990; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BXrUhRGEqRiEVKCb5fpntove8ZFq2YMexNeI4JURA+A=;
        b=IfU99QqsLimfFIj/tpqViHRfnDQAgeXQJsdqQHIT5fnuZAvJ0qusAcx9NDmSRauERi
         bL2/i+CU/gizAdHVDEsHElIaOXdp/sgWV8vjZmhAJhziosurOg6QxBPbEawTv0epcJ4D
         NMcXT8Q/CtUDSsop8vFqb5GRkALQYFC4L1Z5KaHrA3sZAWv/s2olfJOabW9S3HwP2Mbg
         HJtDDT4rt4BqVH/WVaMnsH5ItkWasNi0czkgXUZi58sCasFJDdsIklzomPerdkp/SKBs
         C49UgN4qvdcOV5yw1EW01qiovQyiR4nKx/ScYhNiQYlXa1T2wFSbjQjLA3shKz1wmYuO
         aRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794653190; x=1795257990;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BXrUhRGEqRiEVKCb5fpntove8ZFq2YMexNeI4JURA+A=;
        b=pS8q5p/nuFJrJoW9ZVNKSLCVKJw5sebbSJh8/csRVA6RAXJoLYKc16SZlmPicv4/P+
         i/ZiPwU+/qyfLTH/s7X6myr+0mOLWtYuBQBu0pRoRozalAh+mxkrkTd5MlTvPDXj+yHS
         RCbZGGfosL6usXFm1K3f+Su+ESOZLjNQIAV/WBCfuJcr/ISXAEFm7UiMWxrrVOO0uHzv
         YV1BV5W4Lx1Rji6Fmvmv42H3dijwR+FkaiRH+k0rYNXC3WRy/kO6zycURyOoEup2feqd
         Bjz1RGfYwl0udAtlRh7GnpDpXMnQm0sL6lSjoV5GMC4N/7DDYFhkD604Nl4BZuvTV0PH
         RIpw==
X-Forwarded-Encrypted: i=1; AL+hErGz3xksbdt6vN045bkRad7r7UiB3YkT2CUIru1rxmkbCRcJxp1VaXdoVs4IIEIzMSpG2yXJUDizQann+8xy@vger.kernel.org
X-Gm-Message-State: APuU4Z8TdZTcdif3Jx1LU3qpGQaYnVQYwzpPahrCRcW1H176/Q8/ynv1
	UErxLoVgYh7TS4Qk4WjqCOKfE4v5VTxfh7TXGVT+W3eCE4b9d6axgdBy
X-Gm-Gg: AYBFou3Gd2xc1nqOFYQcbPq+3K6ccs23zEuHazufaJncOMSeRNutSWh20j6b2ruxogV
	hBAHLLQO/CoZJ7fyUhTyFBfyNsQafAuM5bBcPZ3EXO5AfN4oTtcUHZL5t+clzt51AQ3rs58Ip5/
	+RYGLCjRnyrfJBU8lQW01DV1Q5BWaZRZiUIaf+eCr2ehSIhy0ip5IId1naDjPZSKJLmk2RbYDWI
	AOaecgeZTncCoPAweiQX1ZN7LWQingCYUB6jUOU4d3uBdNb88BsvtCBUpT3U90CGJy3CcinzeLx
	52tRbNpDoG/QoifaofYX3Vo3G5xRdLXekKpFdpvLIjnO5JIdD99QDZA+ROXuvIv5rEQPALCjfsk
	+yGp6dKnnmxI2C/W7eRIkgdzuhCxGJyFlMjyacwo+CwG8/CdV6CvUCicb5QXqDRWnwO3AVMFLoQ
	eMCCjvRJ4OeAmURKGG8aEg7nRcVpzePh+ao0IzfAVyQarlYPn3H5/wNgxw5YnsvUV8FLh/Kdn2w
	QK0kP23QjjLfGdfX816/M811TwUx4JEnwG7if3TgIAWuhwYYaqYx5eamz99K8zxcF7jCr6v346s
	ZPeS6FaMNweu3GdDGpnovM39SWElajv3yiBHOskBIZ8Mh4Xq3IVvyJ4Kr27fsTu0CFYdPU3LUuK
	gLYJn8wC/GsJwQkFSOtBRUVBN
X-Received: by 2002:a05:600c:6096:b0:4bb:5de1:e923 with SMTP id 5b1f17b1804b1-4bb5de1f26dmr62906435e9.4.1794653190135;
        Sat, 14 Nov 2026 02:46:30 -0800 (PST)
Received: from meven-thinkpad.home (2a01cb088745e00090de407b41070a01.ipv6.abo.wanadoo.fr. [2a01:cb08:8745:e000:90de:407b:4107:a01])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb609cc1b2sm45447055e9.11.2026.11.14.02.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 02:46:29 -0800 (PST)
From: =?UTF-8?q?M=C3=A9ven=20Car?= <meven29@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	=?UTF-8?q?M=C3=A9ven=20Car?= <meven@kde.org>
Subject: [RFC PATCH v3 2/2] io_uring: add support for utimensat
Date: Sat, 14 Nov 2026 11:46:21 +0100
Message-ID: <20261114104621.1186744-3-meven29@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261114104621.1186744-1-meven29@gmail.com>
References: <20261114104621.1186744-1-meven29@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Méven Car <meven@kde.org>

A program that copies many files sets the times of every copy after
its last write. On NFS and SMB each of those calls is a round trip to
the server, and with io_uring it is one of the steps of the copy that
still have to leave the ring and run one file at a time.

IORING_OP_UTIMENSAT behaves like utimensat(2). sqe->fd is the directory
fd, sqe->addr the path, sqe->addr2 a pointer to two struct
__kernel_timespec, and sqe->utimes_flags takes AT_SYMLINK_NOFOLLOW and
AT_EMPTY_PATH. An addr2 of zero sets both times to the current time, as
a NULL times argument does. The times and the path are copied at
submission.

As with utimensat(2), a NULL path sets the times of the file that
sqe->fd refers to, without a lookup, and takes no flags. Two UTIME_OMIT
times complete with 0 without a lookup.

Like the other path ops, the request is issued from io-wq, apart from
the no-op, because the lookup and notify_change() can sleep. A fixed
file is not accepted as the directory fd. A failed request fails the
rest of its link.

Signed-off-by: Méven Car <meven@kde.org>
---
 include/uapi/linux/io_uring.h |  2 +
 io_uring/fs.c                 | 97 +++++++++++++++++++++++++++++++++++
 io_uring/fs.h                 |  4 ++
 io_uring/opdef.c              |  8 +++
 4 files changed, 111 insertions(+)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index b42b66b424a7..6a98c9282e0b 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -76,6 +76,7 @@ struct io_uring_sqe {
 		__u32		install_fd_flags;
 		__u32		nop_flags;
 		__u32		pipe_flags;
+		__u32		utimes_flags;
 	};
 	__u64	user_data;	/* data to be passed back at completion time */
 	/* pack this to avoid bogus arm OABI complaints */
@@ -319,6 +320,7 @@ enum io_uring_op {
 	IORING_OP_PIPE,
 	IORING_OP_NOP128,
 	IORING_OP_URING_CMD128,
+	IORING_OP_UTIMENSAT,
 
 	/* this goes last, obviously */
 	IORING_OP_LAST,
diff --git a/io_uring/fs.c b/io_uring/fs.c
index 26ea841a22e7..71164bddd958 100644
--- a/io_uring/fs.c
+++ b/io_uring/fs.c
@@ -304,3 +304,100 @@ void io_link_cleanup(struct io_kiocb *req)
 	dismiss_delayed_filename(&sl->oldpath);
 	dismiss_delayed_filename(&sl->newpath);
 }
+
+/* Internal flags, above the AT_ flags of the SQE */
+#define IO_UTIMENSAT_NOOP	BIT(30)	/* both times UTIME_OMIT */
+#define IO_UTIMENSAT_NO_PATH	BIT(31)	/* NULL path: the dfd itself */
+
+struct io_utimensat {
+	struct file			*file;
+	int				dfd;
+	unsigned int			flags;
+	struct delayed_filename		filename;
+	/* NULL sets both times to the current time */
+	struct timespec64		*times;
+	struct timespec64		ts[2];
+};
+
+int io_utimensat_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+{
+	struct io_utimensat *ut = io_kiocb_to_cmd(req, struct io_utimensat);
+	struct __kernel_timespec __user *uts;
+	const char __user *fname;
+	int err;
+
+	if (sqe->len || sqe->buf_index || sqe->splice_fd_in || sqe->addr3 ||
+	    sqe->__pad2[0])
+		return -EINVAL;
+	if (unlikely(req->flags & REQ_F_FIXED_FILE))
+		return -EBADF;
+
+	ut->dfd = READ_ONCE(sqe->fd);
+	ut->flags = READ_ONCE(sqe->utimes_flags);
+	if (ut->flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH))
+		return -EINVAL;
+
+	uts = u64_to_user_ptr(READ_ONCE(sqe->addr2));
+	ut->times = NULL;
+	if (uts) {
+		if (get_timespec64(&ut->ts[0], &uts[0]) ||
+		    get_timespec64(&ut->ts[1], &uts[1]))
+			return -EFAULT;
+		ut->times = ut->ts;
+		if (ut->ts[0].tv_nsec == UTIME_OMIT &&
+		    ut->ts[1].tv_nsec == UTIME_OMIT) {
+			ut->flags |= IO_UTIMENSAT_NOOP;
+			return 0;
+		}
+	}
+
+	fname = u64_to_user_ptr(READ_ONCE(sqe->addr));
+	if (!fname) {
+		if (ut->dfd == AT_FDCWD)
+			return -EFAULT;
+		if (ut->flags)
+			return -EINVAL;
+		ut->flags |= IO_UTIMENSAT_NO_PATH;
+		goto out;
+	}
+	err = delayed_getname_uflags(&ut->filename, fname, ut->flags);
+	if (unlikely(err))
+		return err;
+	req->flags |= REQ_F_NEED_CLEANUP;
+out:
+	req->flags |= REQ_F_FORCE_ASYNC;
+	return 0;
+}
+
+int io_utimensat(struct io_kiocb *req, unsigned int issue_flags)
+{
+	struct io_utimensat *ut = io_kiocb_to_cmd(req, struct io_utimensat);
+	int ret = 0;
+
+	WARN_ON_ONCE((issue_flags & IO_URING_F_NONBLOCK) &&
+		     !(ut->flags & IO_UTIMENSAT_NOOP));
+
+	if (ut->flags & IO_UTIMENSAT_NO_PATH) {
+		CLASS(fd, f)(ut->dfd);
+
+		ret = -EBADF;
+		if (!fd_empty(f))
+			ret = vfs_utimes(&fd_file(f)->f_path, ut->times);
+	} else if (!(ut->flags & IO_UTIMENSAT_NOOP)) {
+		CLASS(filename_complete_delayed, name)(&ut->filename);
+		ret = filename_utimensat(ut->dfd, name, ut->times, ut->flags);
+	}
+
+	req->flags &= ~REQ_F_NEED_CLEANUP;
+	if (ret < 0)
+		req_set_fail(req);
+	io_req_set_res(req, ret, 0);
+	return IOU_COMPLETE;
+}
+
+void io_utimensat_cleanup(struct io_kiocb *req)
+{
+	struct io_utimensat *ut = io_kiocb_to_cmd(req, struct io_utimensat);
+
+	dismiss_delayed_filename(&ut->filename);
+}
diff --git a/io_uring/fs.h b/io_uring/fs.h
index 0bb5efe3d6bb..2812dc3b4b2f 100644
--- a/io_uring/fs.h
+++ b/io_uring/fs.h
@@ -18,3 +18,7 @@ int io_symlinkat(struct io_kiocb *req, unsigned int issue_flags);
 int io_linkat_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
 int io_linkat(struct io_kiocb *req, unsigned int issue_flags);
 void io_link_cleanup(struct io_kiocb *req);
+
+int io_utimensat_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
+int io_utimensat(struct io_kiocb *req, unsigned int issue_flags);
+void io_utimensat_cleanup(struct io_kiocb *req);
diff --git a/io_uring/opdef.c b/io_uring/opdef.c
index cf3aa2242cd7..383a9b9d1df4 100644
--- a/io_uring/opdef.c
+++ b/io_uring/opdef.c
@@ -591,6 +591,10 @@ const struct io_issue_def io_issue_defs[] = {
 		.prep			= io_uring_cmd_prep,
 		.issue			= io_uring_cmd,
 	},
+	[IORING_OP_UTIMENSAT] = {
+		.prep			= io_utimensat_prep,
+		.issue			= io_utimensat,
+	},
 };
 
 const struct io_cold_def io_cold_defs[] = {
@@ -849,6 +853,10 @@ const struct io_cold_def io_cold_defs[] = {
 		.sqe_copy		= io_uring_cmd_sqe_copy,
 		.cleanup		= io_uring_cmd_cleanup,
 	},
+	[IORING_OP_UTIMENSAT] = {
+		.name			= "UTIMENSAT",
+		.cleanup		= io_utimensat_cleanup,
+	},
 };
 
 const char *io_uring_get_opcode(u8 opcode)
-- 
2.56.1

