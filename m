Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171AA86334
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 06:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783922940; cv=none; b=IAGVnadODaTrGUhgQ5K80vlekSKC+vQCJLLusKR9ob0mL1gwbbNoQyie01gqDmXa9Fc6YGK3ka2YntLZJZVeqth9ddoET+jokZpZXWRsON5ulM6QT8/0Vi49LNqHtzIDSeOQua5HJEGiTbpT1gtr/si6k8osohjDkJGWF41CTTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783922940; c=relaxed/simple;
	bh=J+rCs5ymYJcaQX1tMasTgb8f72PS+0Tz+OMg5FIdiOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hYzYSwDwWPuwt3V/0OBbhJzFnJvIjmI3TRGppGk8Wi6D34QZAzSPynJj8oaWDV5/tpetdpjV+WPQUbzPh9tsOJq7ov74+68SNFOwAOhQCelk7t8T3ycx/avfj5Jxnxe53d6P1Kn5uibEzp99zHIk7PRizFhh1okfFJLomzgAg/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=V6j4Ak6M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C1u/dK5H; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="V6j4Ak6M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C1u/dK5H"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 1AC011D00077;
	Mon, 13 Jul 2026 02:08:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 13 Jul 2026 02:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1783922937;
	 x=1784009337; bh=fu5NHV3BzTrJ2i43ee75MeMsL8QzEtroASsfgOGSLbk=; b=
	V6j4Ak6M9ggBvnHjOK1zDWmxMFl70TE/EHDX2yO1ghuNoF4SySSuP0j9u4A8BMfu
	xHV4mdRDMo+7VACsbrGargYa3xZz5yKqpMfLOE/GuDBWRQeXz4RcvHSSBPQHk/3I
	lmw6K+/lufSNYIOnynYDsm7Vjsduau+2zx9xT08zJr9ACed28iDWKpqdC+NBLW+1
	4bor6CHCQIX1TZkyE8wwN+/3GWlQqD4YeTQ/NyIte4bSKF2WOUJl+fEtNhk1GJi5
	JEjSH3wVOrfrxotg0cE5+b/4TIOK6RY9iG0XSLFcjyMwDfdg/vh4smStiBuSLPwU
	4c1GgQK+tUUKYSVHSz3f/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783922937; x=1784009337; bh=f
	u5NHV3BzTrJ2i43ee75MeMsL8QzEtroASsfgOGSLbk=; b=C1u/dK5H8dF9kLhqg
	Rv/xkRiASWWd5QiVkkZTYM6Pg2hL1wTR9CIw7aht8Fz7AHCHmvw2U6aSxU2a23bj
	TGbIhufmPT1eyUdE68bym+Z1oqcywPq5A0s61JsdZFVWcSoK+VI3xUpjFmfdqicU
	f7JBjkVULqKmzVgkYWxY5Q+D8GobYAPfO9TqwbjUprgvj2bvzjhDicyGVkrDOgis
	GdeG8wLExuYdVX1aK4qFhnAmh3hvCegS6kKSsdFeSJBvVg49BudfkXTHNgb6CXpJ
	4RUg30TGHBlsFy8prRIpfpvw6QnQPEjeinPauRdWWoHZkAwOmZuXQLY2peKV/JcF
	byqog==
X-ME-Sender: <xms:-YBUanHCdX4GVGOApfBKGONgPDb702GVPNDxWOFM-14_MvYtEde0Xw>
    <xme:-YBUatSp_eYmqE4U7q2ITjItkkJ6WmgdJdw8I1MC9YoX1LGbSLZ24ZDvpADBJU3WX
    9bRp7zOYwepxEqdsWGpJKaNaD31ORgqhJzpWNzGmW-ERyvP-A>
X-ME-Received: <xmr:-YBUaksPP_5mDpD1EGTPuC1vQ3D44k3oWlGykqA4RX2FriMfncU2CxATD649xwlTraS6y1Md3LzI3EGBInPAhi8p-fDERcA>
X-ME-Proxy-Cause: dmFkZTGJRsxLjx1MEUuqMzUVzH1g3NNJYslwJNWJ6IAZ0OREwQLsFBzBxsIJG7DHnJvgVu
    5Y4qLcUl4SonhqmAGPTWQtMxbfM5q8+0/3p8/v/vcYyQzpYAZ1Oo1UYnLESyg18Io2458w
    zQXESz+xZNNiwn5Sps6dmFWEr8MBxIYW1IsrgBHQWAX0gj+/RsrKqwEc1i6XPTwgPlk7t3
    G72XdtoVsY+wn1L+3hl6ZnwZB6BX676NATTBZaZWgNMHL0UkpnKT7kkp9qqBLgiAhB1nKq
    ssSMKOSvwEpTSFyxo+5m8qmJ8cVUYeMfgGizLYq2+pmxy9rLWlJSkJi6YrusSBRkZlssQB
    kA6uGRRwSNxta6PyJOyzRaqRxHZtOWwB8mRrrIVHsbgoVGBmKLvT47ASj87nsMqhmJ//Fr
    r/WStGbWQyvbMCW5kWzhsc2DJVTjj719fl4h+4CkVTjR1eUHl8OUmwe5A6ukTWYzb4CdVo
    nSRu/RSI6Jp8hLl+CbJoRiGLdd+6DOALZ/6KK8JJvmTieKZyVTOo/JeOt6Y6/dTMd0URM9
    VNDBGyF9TOcRqh1yWQ7Ssir3NVHXzuroqHeq91ci3jZkKu8FVJYt4+i524qRwbA6xrkhO3
    an7scGxe5ZhbSyk/NZq2W8D3cBpGm9djZqhNmdqlHa3P+XafBG5DjY4LKWUQ
X-ME-Proxy: <xmx:-YBUalImLANqHoZAfJji0ZY_KMMRZ-_4N2vGtizcgN1FpxgCLd2Vzg>
    <xmx:-YBUaplXlbwwSauoVbVZOqvAlyKokey_AVeaBlTC_TOEFFw4Ejng7g>
    <xmx:-YBUauIxQ8sFlIuda40O7fd_6zeDnp4vEW2By38gkb9Yo21nZ7DXOQ>
    <xmx:-YBUam4YO0lY8QNEWdSRz5gFc1d3Grugwau5XtVm-6SYZ-6zt-kz2Q>
    <xmx:-YBUaqSfNy52I1y-8M0wXZ0t9UuARPQ2S4umErWnlZxfJ4j-ZwceuJjg>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 02:08:56 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v3 3/3] VFS: add vfs_lookup_open() for nfsd
Date: Mon, 13 Jul 2026 16:05:07 +1000
Message-ID: <20260713060814.2849-4-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260713060814.2849-1-neilb@ownmail.net>
References: <20260713060814.2849-1-neilb@ownmail.net>
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

If a non-regular file is found, an O_PATH file is returned.  This allows
the caller to see what was found and to return an appropriate error
code.  However if ->atomic_open was used, it may return an error rather
then provide a dentry.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c            | 89 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/namei.h |  3 ++
 2 files changed, 92 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index cb33a01d16eb..2143f759443a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4562,6 +4562,95 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
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
+ * In some cases, related errors are repurposed to so that the caller can
+ * determine the file of file found from the error.
+ * -EISDIR : a directory was found
+ * -ELOOP  : a symlink was found
+ * -ENODEV : a block or character device special file was found
+ * -EFTYPE : any other non-regular file was found, such as FIFO or SOCK.
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
+	op.mode = S_IFREG | mode;
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

