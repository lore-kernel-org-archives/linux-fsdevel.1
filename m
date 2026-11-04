Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793790383;
	b=gGXCt+JgwniQxe1j5wGF/2WoW6Wzsa5OUhxOxB3CLfIdcyhewvy5kH4o1xtSHFxrp8Iq
	 Dk1NjVBhq2ARHEKxA12vafmaZZaPB54KdQhEjgyT5EsC1158B96Q5JcMtPHIWCHF7E1jo
	 P0xEbZwd7JySiXnmqW6V6F03vg5wsK8f05wAsCf5Mmcp4EXoSLaG1SkyoLLvH4Rxh/1ui
	 d2ArrYQ0wqjXG9GWaD1TqqACevTZHvNs1ulhC/1lUJ/hZ3bwxQodK79bsULZoppldXaYC
	 RsY0wVD8iu87PGhP4v5yto6glUw+7lmbAKicfGoSJiF/32CjobLPK8Yj5XmsNBOlmHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793790383;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5pLpVK+i/8Imxqr3Xov4ssSifbUYKBHJ4bTvS4h1ZT4=;
	b=YKmS4HfvTczuzp0eobxF9FZc0A6ikhiSd4LtFKJ8K03lGnw5WliXZ1phqo+4HCRgAQ6Y
	 XKNk/FdTM5IRyBMJDNw5zDWNlC1lZuNXTZELXSmifAn36RxHNBly8i6AFiiWPmvZisMr9
	 EyhBGPffyXufvo8o520KdfMY9KB3n338rJJWBe9hky4N1GvSiG1xPo7AMauKKu/GvTdIK
	 IL9rW551bA17/rqkHVWXQaO7cjt8fcGKsXPXywYJwXotEzIafjeW7ZEhshYzX2GiCoOZQ
	 3LvyXC47pFunGehXDKXvmrVcxnQvGyVXKz1PiVn1TgGD2lcaLGlKtivJfLgvX1RghpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xbWDpvvk;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A36B606A31B
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 11:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A36B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xbWDpvvk
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48df4f540ebso283734f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 03:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793790382; x=1794395182; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5pLpVK+i/8Imxqr3Xov4ssSifbUYKBHJ4bTvS4h1ZT4=;
        b=xbWDpvvkAjRBrQLpoCWyOC6RQdm5E1CjKhkzCmj+pIUwdo/ky2nuOmNjV9QXcvJAr6
         yVBzax/EGMUyru/A43+ICtnHQDoJ0QfDcwN4VOZ/yC2cChyHXBE4NNpIWk5PTrSzF8lj
         BRgCtqdw/1KE3693zhoI5CX7gwmulqiIBjhofNCgTlveYeSKAGrJ1AFIFMvIJIVwPgyh
         lgmRdRQawbfBb0sD5vJqsKfZS9tWmHbv13LSmKUiCNhie4XfXEcPsASTtw5z9pPB/NUf
         NRhkoV6OXFR4CuJX8jR/8utCd0iouN4gmoMiDVwJ+ht5kTtJYX9aDQw2AjpA3QOpg7XZ
         gGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793790382; x=1794395182;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5pLpVK+i/8Imxqr3Xov4ssSifbUYKBHJ4bTvS4h1ZT4=;
        b=GFFbXLYyCt4NCzTrbxDNwK7FRaI/xFprfHBC+Q+2UiICcSp+bSJTfEk3rX4uCc+szN
         gWzI3qe65b1JcOWq3TVwevf9js6jWY3VO2DnSoCT97FPLYF9DIpvkNjKyIuzYifahUiq
         4qF+glp+oa/AP87e29EKzYxS2xmpUW+MSplQImMDCy0P+yXIo1VfFaaO3UHJ5LPkV/Mf
         /KsmqbdlI5eCo9u2696Crud9koYVAvRR6zzNuolG+QZCJMKz3Xq6FrHaDYyHOeQpNXP3
         44mK3kAE5fzWHjI3bVpOdWaeCsJH88upuRSrkV3su+oP8AwrVEWpZIkDDJGi6b7OuF76
         qSiA==
X-Forwarded-Encrypted: i=1; AKwUvBzKo4L51wNZwT/F9xQRU9maOG1BmsTvwfM1Sse3BiCyF7OqbjWC9EmqHacunkEX0snztwb09TO6Kh779iga@vger.kernel.org
X-Gm-Message-State: APuU4Z+nLu3DhaVKBBt/RTwx4OZL8Xeeum4M6yZh8bWZsEsDcGGDL1rp
	TuqojF6/zY9qfg2clqlWDDmiZNrx3HE/jYn1nfNLSx/oFZgWj3AreZw2
X-Gm-Gg: AYBFou3qsDLhLWw1PNFelYNEB0+B6ErO/IlrYrgV4W9/W/oktnI5s4PgHxQpUZLg+7z
	NRmdQ999Ri98xbg6q4H4IiPjvz+S68wobPTXCwHGOrslV17nwucWjd642UEIqgI2aJeBo+6DgIy
	DU4UnyfNQ/404MdaCEm0YfHeimZvo0AVORpqieG94pjpXu8p8yhutmYN1oB3RMWJ5OJqTt80NlX
	ktfkESHswbWxGdhSotIxqaSWNe8k2Kb2krKCrq5yhCErtWvG5GjGo1AnZAjxLijziCiw+5nyxuN
	HF6Mi0qjbqdA4XBuVL5Uu3wE221AEbniEYQO+x/9hXj+gAJUkEtpRYzBSSMqa1ZCKoOoAULWISV
	WWWXgyVw1oGwihJHR5xfLD5DodBUsP337bYZ8zpWzdQENCZPJUMEfL95zxOwQEv0Ca84c/ZEpOp
	Y2muw4P4jBxqBpiwIEYuorDRget2HFzRvqC+5NsXUzvSz+6fJ5KZpMBpq0XLqzqtn//q1npi8ob
	3/NniQWl/IN6+UBIYCvmo0qoNAPJFe6C7i1SRixOgvlNGpJAvQ/sVnrh6aGFtolxibdmU7wPbvu
	D/XBXJSQLCMrv3dg8Exgje831ZdI+PPu430VVEtSYYtw/h+hnGJOI/IRi5fMr2HORq60BzIu9T7
	P17fKwqfdQh+HW3IydFLAopA2
X-Received: by 2002:a05:6000:24c5:b0:48e:d7c:4bc8 with SMTP id ffacd0b85a97d-48e6e2bdddbmr38014500f8f.7.1793790381656;
        Wed, 04 Nov 2026 03:06:21 -0800 (PST)
Received: from meven-thinkpad.home (2a01cb088745e00090de407b41070a01.ipv6.abo.wanadoo.fr. [2a01:cb08:8745:e000:90de:407b:4107:a01])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed92a753sm3704835f8f.45.2026.11.04.03.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 03:06:21 -0800 (PST)
From: =?UTF-8?q?M=C3=A9ven=20Car?= <meven29@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?M=C3=A9ven=20Car?= <meven@kde.org>
Subject: [RFC PATCH v2 2/3] io_uring: add support for utimensat
Date: Wed,  4 Nov 2026 12:06:03 +0100
Message-ID: <20261104110604.126717-3-meven29@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104110604.126717-1-meven29@gmail.com>
References: <20261104110604.126717-1-meven29@gmail.com>
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
2.56.0

