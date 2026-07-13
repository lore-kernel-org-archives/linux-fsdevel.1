Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C08364EB8
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 06:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783922931; cv=none; b=csLRvZGqOLxjhwvL6Foas7hg9dvgq8Nb3sxx8kyC8+fJoqXwKnW7AKisFrBEvZ+dD3ordez+yN29KUD7iqDp0hDhMxnNyF4PFI5d9S8VY0ZYmfmBiKgdvgVQ8+NGHbI9GVixYsBP2H2+KfVsFdsMCFNY4IAlxbSdUkbB5+eJCQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783922931; c=relaxed/simple;
	bh=bI7Fu7+m4Y4paeZeRm+9DvalA4qZf1f/fYVH/Aaw6n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjRnXGVWDJvhPZh78SCraRlHRCvZwpbrxD0clH2fSiQ5+zqNfeRT6GB4jNquGvlwjvjBKLWvk7gQEfm7Os03ch/nffgI1t1KXsW3K4+QpVOnR1DQdQaWzO7d85ttomYMnw9LBPgdKEwGaJkqqHoNDnV2Z1Obj2ptsr3XCGrX0/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=nrNxlrOU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NsTFM479; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="nrNxlrOU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NsTFM479"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 044AD1D00081;
	Mon, 13 Jul 2026 02:08:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 13 Jul 2026 02:08:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1783922928;
	 x=1784009328; bh=40XiNEdAzh1eFu4Ly1xdPF5oTxAkThXBFBTECpiedog=; b=
	nrNxlrOUnxXx9z7LizEgh6EUJacm9vV/QfveLsFLMbnPH5gziCgXSnKQUh0c8g2t
	eXfKMSAUSJ7l6nG/YtZ+GAGB17msNiROVaFxVJKU8V0Lx4j/YFxNTm5ExRWnxHG4
	ICQKasIsQUubKFei95hdoi8qYu3Hh2Cyba6eRmf0gwKmY/7Xgu9OCxj0UdXN+Fyx
	Sw0ASqNcY76sIb7nCxOd21UzCG4Jh8eBenxUYlcvp2vNZ+Wv7NLKZImj1T0CB1sC
	cGRf4HtCNMdH+/rl5SJJ76Gb55LDJf7xVtyHhDkZdLCpnp9uQxVwR5YnaOzfI0n1
	lfn06INDm4jQqJJtw9+h7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783922928; x=1784009328; bh=4
	0XiNEdAzh1eFu4Ly1xdPF5oTxAkThXBFBTECpiedog=; b=NsTFM4791fAJ+vFHW
	SyTk+Rhue93VTEziQd+8PdBRnDGEC03vogb6fLoBpWGHaQyTsHDd5WbEdbB5Mvsk
	TtSpl5z7aBj6YCTuPFM9s16xan0x1EFlC4aMcGg8sEhGNSzc99dLFkDZZ72KpKqK
	zlm1vvAfYXUhR1Lc1VwJMwqiluCbcgaRZs+5LyYkCnPTSC8kwsI7Rbn9lTE0xXrj
	yHBv9X8aEydHbff67JiNN5297PVJgvt5trfUj+KlBq9PcevkSMolVwTeD0pl0fea
	qMv7dpdkSgMvE7WiiaSBUllBGAj3NgjN834duEPmDFpUKCUKEi5Uu/6hwJsCPkRi
	AW80Q==
X-ME-Sender: <xms:8IBUai0EfIuHClQzrJrquagjmIe2FfO34vu6FZwfj3JO5weBoYYjOw>
    <xme:8IBUauCOBrNV_B-LKJT2N1dazTBDBwEGp3SlDq8FgAlAWrmxL5TLEE4bYiiJKBMbd
    75ea8Ks49FaFC-2PtXVv06WPniyYpMB3t0TcOo5NN-I0IAP6v0>
X-ME-Received: <xmr:8IBUamdd4WrB-fYvU80Xc2IFgjAZKi_nCx-zqIjQLweuIXMN7xAhHKcgUt8-Ym4LIoOk0zugIB5a5x07q-cox9NnfqzKQDs>
X-ME-Proxy-Cause: dmFkZTGJRsxLjx1MEUuqMzUVzH1g3NNJYslwJNWJ6IAZ0OREwQLsFBzBxsIJG7DHnJvgVu
    5Y4qLcUl4SonhqmAGPTWQtMxbfM5q8+0/3p8/v/vcYyQzpYAZ1Oo1UYnLESyg18Io2458w
    zQXESz+xZNNiwn5Sps6dmFWEr8MBxIYW1IsrgBHQWAX0gj+/RsrKqwEc1i6XPTwgPlk7t3
    G72XdtoVsY+wn1L+3hl6ZnwZB6BX676NATTBZaZWgNMHL0UkpnKT7kkp9qqBLgiAhB1nKq
    ssSMKOSvwEpTSFyxo+5m8qmJ8cVUYeMfgGizLYq2+pmxy9rLWlJSkJi6YrusSBRkZlssAp
    eK7p87nL7+dyHByf+6Ki54TbZoSEBg1Si5wv0tKPr3AKECG3O9tTJ0NTLGFTEed4QsHlGw
    m8+8/0pcTXdn7rRynCaaXB+IwGkbYflxFriKlxV7m5In+0XeFWzFMYzOExNFsmn929v7TK
    4q9uvR3HRdUoXGZsRM0WOZKJpn3Y16h0mNeW7QGKAb1nponsnXvFCWzdlxgcSKrVIWdNAx
    /Sfkp/yiJ8wsvIeqtiNAHAMegVWMaQE1XM2KloYyipcSVpJYl/V5Mrw32JwpHrXg8sRNhW
    D3oyxjrIFZBS2NE/9qDjYeCa8TrohXUD2azvj0Zm/7wPP8d7I4JlnjD0nlpw
X-ME-Proxy: <xmx:8IBUaj6QRGCHAFMPGYRpZvmZQzyimMvYy4eYSq-vxF_mG80MeNKiyQ>
    <xmx:8IBUahV5tJzrKwWNlciLoHZQaaHWFiUvXI-vQqEeBZuGSYz_MBzhoQ>
    <xmx:8IBUaq7b6ZbKuU1FKNCfJmaOaYpqULz77VpFPQ3K-1QF6SH_toe8sA>
    <xmx:8IBUakqszivnfkaMSsFIUnRh9BJH6iYD2rtKQrUE-a057uxdhryEDA>
    <xmx:8IBUajXWgA450M2z5OPd9LlWqhYl4_AUww4kieiJPPALB7csBOummmtO>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 02:08:46 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v3 1/3] VFS: move mnt_want_write() and locking into lookup_open()
Date: Mon, 13 Jul 2026 16:05:05 +1000
Message-ID: <20260713060814.2849-2-neilb@ownmail.net>
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

The mnt_want_write() call and the parent inode locking in
open_last_lookups() are only needed for lookup_open().  So we can move
them and all the got_write handling into lookup_open().

Note that we need to also check create_error when determining whether to
unlock shared or not, as O_CREAT can be cleared, but create_error is
only set of O_CREAT was set.

The fsnotify calls come too as they must be in the locked region.

Also use the existing dir_inode uniformly for dir->d_inode.

This is a step towards exporting an better "open/create" interface to nfsd.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c | 77 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 36 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 7ead3db55be2..55404fe0e269 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4398,7 +4398,7 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
  */
 static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 				  const struct open_flags *op,
-				  bool got_write, struct delegated_inode *delegated_inode)
+				  struct delegated_inode *delegated_inode)
 {
 	struct mnt_idmap *idmap;
 	struct dentry *dir = nd->path.dentry;
@@ -4407,9 +4407,25 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	struct dentry *dentry;
 	int error, create_error = 0;
 	umode_t mode = op->mode;
+	bool got_write = false;
 
-	if (unlikely(IS_DEADDIR(dir_inode)))
-		return ERR_PTR(-ENOENT);
+	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
+		got_write = !mnt_want_write(nd->path.mnt);
+		/*
+		 * do _not_ fail yet - we might not need that or fail with
+		 * a different error; let lookup_open() decide; we'll be
+		 * dropping this one anyway.
+		 */
+	}
+	if (open_flag & O_CREAT)
+		inode_lock(dir_inode);
+	else
+		inode_lock_shared(dir_inode);
+
+	if (unlikely(IS_DEADDIR(dir_inode))) {
+		dentry = ERR_PTR(-ENOENT);
+		goto out;
+	}
 
 	file->f_mode &= ~FMODE_CREATED;
 	dentry = d_lookup(dir, &nd->last);
@@ -4417,7 +4433,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		if (!dentry) {
 			dentry = d_alloc_parallel(dir, &nd->last);
 			if (IS_ERR(dentry))
-				return dentry;
+				goto out;
 		}
 		if (d_in_lookup(dentry))
 			break;
@@ -4433,7 +4449,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	}
 	if (dentry->d_inode) {
 		/* Cached positive dentry: will open in f_op->open */
-		return dentry;
+		goto out;
 	}
 
 	if (open_flag & O_CREAT)
@@ -4454,7 +4470,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	if (open_flag & O_CREAT) {
 		if (open_flag & O_EXCL)
 			open_flag &= ~O_TRUNC;
-		mode = vfs_prepare_mode(idmap, dir->d_inode, mode, mode, mode);
+		mode = vfs_prepare_mode(idmap, dir_inode, mode, mode, mode);
 		if (likely(got_write))
 			create_error = may_o_create(idmap, &nd->path,
 						    dentry, mode);
@@ -4469,7 +4485,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		dentry = atomic_open(&nd->path, dentry, file, open_flag, mode);
 		if (unlikely(create_error) && dentry == ERR_PTR(-ENOENT))
 			dentry = ERR_PTR(create_error);
-		return dentry;
+		goto out;
 	}
 
 	if (d_in_lookup(dentry)) {
@@ -4508,11 +4524,27 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		error = create_error;
 		goto out_dput;
 	}
+out:
+	if (!IS_ERR(dentry)) {
+		if (file->f_mode & FMODE_CREATED)
+			fsnotify_create(dir_inode, dentry);
+		if (file->f_mode & FMODE_OPENED)
+			fsnotify_open(file);
+	}
+	if ((open_flag & O_CREAT) || create_error)
+		inode_unlock(dir_inode);
+	else
+		inode_unlock_shared(dir_inode);
+
+	if (got_write)
+		mnt_drop_write(nd->path.mnt);
+
 	return dentry;
 
 out_dput:
 	dput(dentry);
-	return ERR_PTR(error);
+	dentry = ERR_PTR(error);
+	goto out;
 }
 
 static inline bool trailing_slashes(struct nameidata *nd)
@@ -4555,9 +4587,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 		   struct file *file, const struct open_flags *op)
 {
 	struct delegated_inode delegated_inode = { };
-	struct dentry *dir = nd->path.dentry;
 	int open_flag = op->open_flag;
-	bool got_write = false;
 	struct dentry *dentry;
 	const char *res;
 
@@ -4587,32 +4617,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 		}
 	}
 retry:
-	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
-		got_write = !mnt_want_write(nd->path.mnt);
-		/*
-		 * do _not_ fail yet - we might not need that or fail with
-		 * a different error; let lookup_open() decide; we'll be
-		 * dropping this one anyway.
-		 */
-	}
-	if (open_flag & O_CREAT)
-		inode_lock(dir->d_inode);
-	else
-		inode_lock_shared(dir->d_inode);
-	dentry = lookup_open(nd, file, op, got_write, &delegated_inode);
-	if (!IS_ERR(dentry)) {
-		if (file->f_mode & FMODE_CREATED)
-			fsnotify_create(dir->d_inode, dentry);
-		if (file->f_mode & FMODE_OPENED)
-			fsnotify_open(file);
-	}
-	if (open_flag & O_CREAT)
-		inode_unlock(dir->d_inode);
-	else
-		inode_unlock_shared(dir->d_inode);
-
-	if (got_write)
-		mnt_drop_write(nd->path.mnt);
+	dentry = lookup_open(nd, file, op, &delegated_inode);
 
 	if (IS_ERR(dentry)) {
 		if (is_delegated(&delegated_inode)) {
-- 
2.50.0.107.gf914562f5916.dirty

