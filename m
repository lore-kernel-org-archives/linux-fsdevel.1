Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F3A361DDC
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 06:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783922935; cv=none; b=Xpdd8THmfJrGXuMavaZ0sVIQjLMjVvi5Wy3uNGQ23ONU0j/O5y87Xt3xTokVdnOMBp5U+uNOklDN1zQHZLd3hDPmE5N9UHR7M75Rs6+8ofmeh5KVftT+7PAnBSSSsArXH2uB2zWlaWPdf7rzdyKQ8U3r+I3TGYXb5Q5kt/vgYBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783922935; c=relaxed/simple;
	bh=td5GR6kUYJaocprzw26pnEkmGbw0T4WNVQCP9yALRvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eom6pwWKpHZuR4qKa5AKWV4PYED2HF/uY/CXNyeugee5VYldsXG8zCU6p6WjEV3Hzxc0Wbaf7UjnPcWYuCm/EuOW4s/z8rzrMPtxeOA2drW1DN648MfkQtKMvVycS/NRtZju6dAJcjSTrvPiM+RCQw6wC2SAuzPIid/wM+Exufw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=BYCO9URr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gxFDLa0Q; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="BYCO9URr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gxFDLa0Q"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 801EA1D00074;
	Mon, 13 Jul 2026 02:08:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 13 Jul 2026 02:08:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1783922933;
	 x=1784009333; bh=PJngaM3HfC9CnzsO5rUDlwnghrNEP1nqkloXnSUon3k=; b=
	BYCO9URriHaUt62zzNxHsf7AQ6KgREBOBN3rXnlFVhBMw+IQRPprpyp9Vqn22WEC
	QEMkVcWVD+N15EwL3pu6dZeU/59hXogFRkFGYKAv7vy1VwOir/Mqz+23XcEMmih5
	6QrK3/4g80dBHWgRupsJR87ZAMc6I+mfraxdfvmj0vD4QzpNcefHwZu/S7YGipos
	mXKs2s+KQYHvrkhlH+2deW4vnaN439OSK1ib0hpCdlgpzFJDILiJ2sX88qtMxVsL
	6nizhTTBOhp84+8hTkB10/ni4TBGCEmNzDm5+f+xGtZnV4XYHf4nVtgrUyEUkxyk
	Ky5+/muivKdKkk0K1v3cZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783922933; x=1784009333; bh=P
	JngaM3HfC9CnzsO5rUDlwnghrNEP1nqkloXnSUon3k=; b=gxFDLa0Q9XB3BH/dr
	MtmcbNbEx8NlCkP2DMcYqYnTPAPfQZBzWWNzioUDSdvpL/ArW8bb6PntJdM5O3C7
	IF6NSMwk93QGFVNtnsVxT7tfCz8kN1KsFAbWs5p/FwOmplBInohLq9gtAh5HGdDk
	2/jy/OJWsffilvBYXdllkCKFW3AWzx8msTM4tYNHfhIW0Z2Z+pt2sXkA+9tpMrhs
	gO/RBYmCjvRPqD6bUrtKKJBzKixgt1uyxc/zq+oP37Vqds+oAnBEJMm409Qdoub2
	OPOBDGVvNSERcvg7HJ8AT1WsQ9dfBKultPtMYAvodM81K4WORLaRUZMRxNbucOdc
	Yon+A==
X-ME-Sender: <xms:9YBUarlWZWT3BdI8VJFWqWD7ltESAogcc4UaPo0d48OSzrIW6tK0IQ>
    <xme:9YBUanx8mC9CE-g8aDuO5fTtKj5R-REkIToyftiZOhsLEB85ZXdUDol3hjHDGAC0a
    gPvowJDv5qoThXCGMGlMDFW3tFdcTSQD7-5M4Nu7Go-zpENHMk>
X-ME-Received: <xmr:9YBUatOwTeS5QhYjFMyem7DuP51P7wYfxbGD7PqCEaqXOQzFTlKsvfYC6YW_JlwCnMZ9PcQRcLEq4anJNxwg9aBB8RZpwt8>
X-ME-Proxy-Cause: dmFkZTGJRsxLjx1MEUuqMzUVzH1g3NNJYslwJNWJ6IAZ0OREwQLsFBzBxsIJG7DHnJvgVu
    5Y4qLcUl4SonhqmAGPTWQtMxbfM5q8+0/3p8/v/vcYyQzpYAZ1Oo1UYnLESyg18Io2458w
    zQXESz+xZNNiwn5Sps6dmFWEr8MBxIYW1IsrgBHQWAX0gj+/RsrKqwEc1i6XPTwgPlk7t3
    G72XdtoVsY+wn1L+3hl6ZnwZB6BX676NATTBZaZWgNMHL0UkpnKT7kkp9qqBLgiAhB1nKq
    ssSMKOSvwEpTSFyxo+5m8qmJ8cVUYeMfgGizLYq2+pmxy9rLWlJSkJi6YrusSBRkZlsskw
    L6S/ZZ4C3F2sTZR7tyd9Sj6twqaj7j1zEds28kgmdr6nB7/cMQse8oZtqm44xqdQ07CAi4
    eRA2tL49NZAMPaa8IUYgZovRBVGM9gbDNXs9MlhEEfoUpYg83htVT8AzxrUaoISFVNeKUT
    NQcGROFKWWvyVpdlqa55HI2LORT9ZBbDObxv0ocdW/pfErpN811/qhEi5wv8kxFLWVPqNp
    JvwPGHk61S5gQQxhXYbA+eTKXKufJM7No1reLKv2WN9v0Lhjb7pRQuvsKh3pKYQ+KB3mB/
    mlvym6Rub18Qx21+NbcsvorrTm9/raiec2D6QZ1ZKJbTfoNLui8O5pDWs0IQ
X-ME-Proxy: <xmx:9YBUajod5_VOY56lvT8LBQb_fsoN3mv4aMpQ7VXQcKYYXBbWy0FFGw>
    <xmx:9YBUamHo5N2p98KzmyE2rzimLzTBnMdIpLbvFjSip9Ovz9Es9rnY-A>
    <xmx:9YBUagqHl17_P7FOfKMUGFk1AXpopqG8MEr2MMhCjvtLwSUsP1VXzw>
    <xmx:9YBUanZKhfkrb9zfkUHZmEfQQmwyW4gLm7qkes1EsHNaY3S_ZqxYsQ>
    <xmx:9YBUaoy-ZzbciP_CNVsZtZ649AjmKDPMBC0Cl5020Pbmdw2krzf7bbBO>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 02:08:51 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v3 2/3] VFS: move delegated_inode retry loop into lookup_open()
Date: Mon, 13 Jul 2026 16:05:06 +1000
Message-ID: <20260713060814.2849-3-neilb@ownmail.net>
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

By moving this retry into lookup_open() we no longer need to pass around
the delegated_inode pointer.

Various variable assignments need to be moved out of the declaration
block so that they can be repeated after the "goto retry".

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 55404fe0e269..cb33a01d16eb 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4397,17 +4397,23 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
  * An error code is returned on failure.
  */
 static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
-				  const struct open_flags *op,
-				  struct delegated_inode *delegated_inode)
+				  const struct open_flags *op)
 {
+	struct delegated_inode delegated_inode = { };
 	struct mnt_idmap *idmap;
 	struct dentry *dir = nd->path.dentry;
 	struct inode *dir_inode = dir->d_inode;
-	int open_flag = op->open_flag;
+	int open_flag;
 	struct dentry *dentry;
-	int error, create_error = 0;
-	umode_t mode = op->mode;
-	bool got_write = false;
+	int error, create_error;
+	umode_t mode;
+	bool got_write;
+
+retry:
+	open_flag = op->open_flag;
+	got_write = false;
+	mode = op->mode;
+	create_error = 0;
 
 	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
 		got_write = !mnt_want_write(nd->path.mnt);
@@ -4505,7 +4511,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	/* Negative dentry, just create the file */
 	if (!dentry->d_inode && (open_flag & O_CREAT)) {
 		/* but break the directory lease first! */
-		error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, delegated_inode);
+		error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, &delegated_inode);
 		if (error)
 			goto out_dput;
 
@@ -4539,6 +4545,15 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	if (got_write)
 		mnt_drop_write(nd->path.mnt);
 
+	if (is_delegated(&delegated_inode)) {
+		/* Must have come through out_dput: dentry is an ERR_PTR() */
+		error = break_deleg_wait(&delegated_inode);
+
+		if (!error)
+			goto retry;
+		dentry = ERR_PTR(error);
+	}
+
 	return dentry;
 
 out_dput:
@@ -4586,7 +4601,6 @@ static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_flag)
 static const char *open_last_lookups(struct nameidata *nd,
 		   struct file *file, const struct open_flags *op)
 {
-	struct delegated_inode delegated_inode = { };
 	int open_flag = op->open_flag;
 	struct dentry *dentry;
 	const char *res;
@@ -4616,19 +4630,10 @@ static const char *open_last_lookups(struct nameidata *nd,
 				return ERR_PTR(-ECHILD);
 		}
 	}
-retry:
-	dentry = lookup_open(nd, file, op, &delegated_inode);
-
-	if (IS_ERR(dentry)) {
-		if (is_delegated(&delegated_inode)) {
-			int error = break_deleg_wait(&delegated_inode);
 
-			if (!error)
-				goto retry;
-			return ERR_PTR(error);
-		}
+	dentry = lookup_open(nd, file, op);
+	if (IS_ERR(dentry))
 		return ERR_CAST(dentry);
-	}
 
 	if (file->f_mode & (FMODE_OPENED | FMODE_CREATED)) {
 		dput(nd->path.dentry);
-- 
2.50.0.107.gf914562f5916.dirty

