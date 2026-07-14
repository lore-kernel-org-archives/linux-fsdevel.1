Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B9F349CCD
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 23:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784070366; cv=none; b=qgcExS1zA932m9H2dWaca0jUzt+OBhvTbN5jRvKIskTgFyLwiuCHb7ZE6cleYOFETb3JrSghjhS0gnu25QizzFzOvGZIIVtITZd5qziD4CtM3LPeKIWLrJN2lljGsTJlVfeAWq9pQOf91WcyBiCcZaOHSUnFisq1TTF/T9UySA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784070366; c=relaxed/simple;
	bh=tO4M3Kd/rUQcDAnyFxhscnZTEglOfWDTAkXn7ejRtWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+O3+Tb/go5nhtVNjYTkiSl7p5WCCZvmfzw6WgybMT8IBZOwMeZl3m0uNYQeHisI3jk4AFHNRIAzlDibnMup5SjU4Gbh16N+UZLVofR1qTifVkeYciBRZRYdf1MADdQpY4R+3p3u24PHeIBvVyvaaInPhJ1Ab28BZV8G9U/nzXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=EhLU+XGg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BMgOKmN7; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="EhLU+XGg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BMgOKmN7"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 131851D0017D;
	Tue, 14 Jul 2026 19:06:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 14 Jul 2026 19:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1784070359;
	 x=1784156759; bh=h5TIyx/yA5zTPSWPy0CUYiNBJ7M5ghKYv4VFXQDTyek=; b=
	EhLU+XGgu6VPMNZ6ade21FIt5M4qGamKwXtgRvC2IxK2hW9p6dFDsJSGBnIO7C9b
	fBzqx8UE6CVMsfOc05s5LQCY1beEdB2YELLvhzzza9Xy849mBjsCf5XmZv1DrEeG
	fyMeGwBZOMrN1ASx42Tud5Ndiuwq77JzINhBDgIHQCpICKeJg0G3iDWgrzwc+b36
	QoNG4rBQHGXfn8NmLdHQUNx8PFiuhRC/7aq2lT9JWgdCe6XVjKFn11EaOExdX2FX
	D7X/GDdU9s/AQnJUZGhoW1fbG3nNzSPal8bdNHZqhYgUbgcEf9BzpBobafbS1SR0
	y3Rwcqr5npbNf7c35cYcKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1784070359; x=1784156759; bh=h
	5TIyx/yA5zTPSWPy0CUYiNBJ7M5ghKYv4VFXQDTyek=; b=BMgOKmN7+20J5qLh9
	YBNOtOk5659Q7TQWZYwXu6FP9CovwoFvlYOGRMuAZaU6lM0jydXkxJODvdu+6psi
	PYMRz1v1lmPt6VbfCOQle7K6piJYxUUHXwnKs45mhDCAxnq035tdarXMMHolp3Ec
	0b8UBXhcxdfX0eW06Vk7DQELHNaGjzSPLqM9/TotGuJHDDgIb7hfq0AZyk5r7N9d
	4I01AuaVBrdNtI06e1fucb7VLEnVvS9lp65bYdSClGZB8DRfHiKBGz4cie37GZuL
	xCz5JUk7yVKAvjBAe3yOR4cjCDb3hKDasIaOTC9Icnei9l5ii0a5xrR2f22SMgQu
	rbjGA==
X-ME-Sender: <xms:18BWaqL21nJUWVXWyWSqXJL0BEpkdDsiOoZicmTuQbw0ZqbHppPD6Q>
    <xme:18BWarHocOR-HYmSTv2lZWmXzMtagtkVpgr4EdYuMoS6lIgvgJ3dLRrMk5hzPRADP
    fzdkKVeIMMl_WCGPATBz28pGNhpyFgJNmkipCXIq95ob0Q30-Y>
X-ME-Received: <xmr:18BWamRhhwzJOGwJkA1kllLAFfoCq1Z8yqRwCrfHt1PguFp2AV3uifb5awqYuKlrQwnoiUXz65kiUyt-p9SmicS0HggxzK0>
X-ME-Proxy-Cause: dmFkZTFqP8WqiBJdtOa2hcfBQxjE9popyOicxtbV07MXFh/bu9T+iEb2GHQ65Mn/QQr6QH
    VQSYmX1hcI4+EPJF+4tELj1f8pNYv0yrtyuRNWSAxG6472jQ9vH1SIFCLLeHuKq84JDVso
    5gFlonpuTM9JPncfNbTnC0dZn7dRXqYWsCF/yjOenBrnyElgDGgIg9iMtAJBKckf9J54rP
    kYnLPoo6axfaUIlHHQTbAeqL4tm6cS5eJADIZJBMqpcFqOg+CkTfEBm6Dsdkxm+mtA8YJX
    RK0EBEXfyh75YXIksEDCCbePN3vRU0gGblpCiV2Js8UQlHNDX8+d6yP6Stqa1cFQM56vI+
    vJEv5AYBsNBPV6anicoYWymSUS588Xh9cmb0v7wm6rCw5ZUlfNk2OcPJJOfAaH6bpa0+S3
    9V2RORO6i72xRwHo8dsw8UygD0SXXrAPGYQkZE79cC/+DcNuchRo7xOO3hhmNk+RJjSM5W
    RMEI2hblMLMpbTw2KqG00rIXB4K3xsOehH6zgMZ4ILe4V2Tsl6XjJd/H0pOpKRvyWo1jUZ
    UvCWxIlxA+sD7gr+5Z8HuWOFKHhTivIzfrqh4nZpVnxQYGaP77rsEQjMzIFFWzH5o4N/R4
    /SRMUTw6sfuWjzjUREV0GDJZ3wAxNRle/Tyv5X4IP+czHNxzc0CBO8+ynE0Q
X-ME-Proxy: <xmx:18BWaveQxW5J_m4U3XKT1lxX-TqFI0AVry78HE7GinAYSnWhrgQsng>
    <xmx:18BWatr908jsB8BzJ9vzLxPC8s9J3w_QjySpnyZmq-MivGO1kpx4Xg>
    <xmx:18BWao9hOu1C7_wNSHs5ZUpnQPDEPILOWqARCyrqtOFP7KR9eExPCw>
    <xmx:18BWahfTy81HwSqL8u4xFMscDa9lhWZHyIUlPJg8-ALOljSzFhBwhA>
    <xmx:18BWakm3xD9sDmRxE8YVzIW8XJtrprFOAYmcE4uPahy3h4DY6S_le8u7>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 19:05:57 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v4 3/3] VFS: add vfs_lookup_open() for nfsd
Date: Wed, 15 Jul 2026 09:04:14 +1000
Message-ID: <20260714230534.776886-4-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260714230534.776886-1-neilb@ownmail.net>
References: <20260714230534.776886-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

vfs_lookup_open() is a limited version of lookup_open() which is
exported for nfsd to use - to replace dentry_create().

It is limited in that no filename is given (thus no auditing) and no
LOOKUP_ flags are passed.  A few "intent" LOOKUP flags are deduced from
the open flags.

If a non-regular file is found and appropriate error is returned and no
file is opened.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c            | 96 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/namei.h |  3 ++
 2 files changed, 99 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index cb33a01d16eb..630f93608224 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4562,6 +4562,102 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	goto out;
 }
 
+/**
+ * vfs_lookup_open - open and possibly create a regular file
+ * @parent: directory to contain file
+ * @last: final component of file name
+ * @open_flag: O_flags
+ * @mode: initial permissions for file
+ *
+ * Open a file after lookup and/or create.  This provides similar
+ * functionality open_last_lookups() for non-VFS users, particularly
+ * nfsd.
+ * It uses ->atomic_open or ->lookup / ->create / ->open as appropriate.
+ *
+ * If the fs object found is not a regular file then an error is returned.
+ * In some cases, related errors are repurposed so that the caller can
+ * determine the type of file found from the error.
+ * -EISDIR : a directory was found
+ * -ELOOP  : a symlink was found
+ * -ENODEV : a block or character device special file was found
+ * -EFTYPE : any other non-regular file was found, such as FIFO or SOCK.
+ *           or ->atomic_open responded to __O_REGULAR.
+ *
+ * Returns: the opened struct file, or an error.
+ */
+struct file *vfs_lookup_open(struct path *parent, struct qstr *last,
+			     int open_flag, umode_t mode)
+{
+	struct file *file __free(fput) = NULL;
+	struct nameidata nd = {};
+	struct open_flags op = {};
+	struct dentry *dentry;
+	int error = 0;
+
+	WARN_ONCE(mode & ~S_IALLUGO, "mode must only have permission bits");
+	WARN_ONCE(open_flag & ~(O_ACCMODE|O_CREAT|O_EXCL|O_TRUNC|__O_REGULAR),
+		  "open_flag has unsupported flags");
+
+	mode |= S_IFREG;
+	open_flag |= __O_REGULAR;
+
+	error = lookup_noperm_common(last, parent->dentry);
+	if (error)
+		return ERR_PTR(error);
+
+	file = alloc_empty_file(open_flag, current_cred());
+	if (IS_ERR(file))
+		return file;
+
+	nd.path = *parent;
+	nd.last = *last;
+	nd.flags = LOOKUP_OPEN;
+	if (open_flag & O_CREAT) {
+		nd.flags |= LOOKUP_CREATE;
+		if (open_flag & O_EXCL)
+			nd.flags |= LOOKUP_EXCL;
+	}
+	op.open_flag = open_flag;
+	op.mode = mode;
+	dentry = lookup_open(&nd, file, &op);
+
+	if (IS_ERR(dentry))
+		return ERR_CAST(dentry);
+
+	if (d_really_is_negative(dentry)) {
+		error = -ENOENT;
+	} else if (!(file->f_mode & FMODE_CREATED) && (open_flag & O_EXCL)) {
+		error = -EEXIST;
+	} else if ((dentry->d_inode->i_mode & S_IFMT) != S_IFREG) {
+		switch (dentry->d_inode->i_mode & S_IFMT) {
+		case S_IFDIR:
+			error = -EISDIR;
+			break;
+		case S_IFLNK:
+			error = -ELOOP;
+			break;
+		case S_IFBLK:
+		case S_IFCHR:
+			error = -ENODEV;
+			break;
+		case S_IFIFO:
+		case S_IFSOCK:
+		default:
+			error = -EFTYPE;
+			break;
+		}
+	} else if (!(file->f_mode & FMODE_OPENED)) {
+		nd.path.dentry = dentry;
+		error = vfs_open(&nd.path, file);
+	}
+	dput(dentry);
+
+	if (error)
+		return ERR_PTR(error);
+	return no_free_ptr(file);
+}
+EXPORT_SYMBOL_FOR_MODULES(vfs_lookup_open, "nfsd");
+
 static inline bool trailing_slashes(struct nameidata *nd)
 {
 	return (bool)nd->last.name[nd->last.len];
diff --git a/include/linux/namei.h b/include/linux/namei.h
index ebe6e29f7e93..86d657b24fc6 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -97,6 +97,9 @@ struct dentry *start_creating_dentry(struct dentry *parent,
 struct dentry *start_removing_dentry(struct dentry *parent,
 				     struct dentry *child);
 
+struct file *vfs_lookup_open(struct path *parent, struct qstr *last,
+			     int open_flag, umode_t mode);
+
 /* end_creating - finish action started with start_creating
  * @child: dentry returned by start_creating() or vfs_mkdir()
  *
-- 
2.50.0.107.gf914562f5916.dirty

