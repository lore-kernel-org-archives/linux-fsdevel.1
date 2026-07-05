Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7008366051
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Jul 2026 23:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783295716; cv=none; b=Vnd8IN77U5STYYYmzIjxzIRYehvaTx3YKXpQvjVy86DKpIPpZaN85c771dfxXdymtvDA2yT1ktjJa0S/MK5EToUowKu8Bw3XzdNkFtcH3Unwudt5mvxCZcnZGvVYwAFbWGTiGBnsotIybgqWyHlk7HApd5o19w0ucagXrCedyLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783295716; c=relaxed/simple;
	bh=td5GR6kUYJaocprzw26pnEkmGbw0T4WNVQCP9yALRvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZewffcSExnWWxzhOATKqE+ewS9mk6ue724N1oRIEr2yabbk0Snpvcc99yE3b+ZhoULcwGlZYrRyJFXyHVZys+XRhN3B2xqIzZReRfDHU0qvZ5rkydbUrf84e5rTBVjP3HMYIs4XRm2itQm5oLfjVKTbwD8mDfFFmeXH1yo+qOxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=UqwWRlBg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kU4ymQLi; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="UqwWRlBg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kU4ymQLi"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1EA18140008D;
	Sun,  5 Jul 2026 19:55:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 05 Jul 2026 19:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1783295714;
	 x=1783382114; bh=PJngaM3HfC9CnzsO5rUDlwnghrNEP1nqkloXnSUon3k=; b=
	UqwWRlBgQiRtmqI+/PrIAeALWWM0g1thmeFRNkLOXzYRuT6IPYUhqxzTckVbFa0c
	IyVjReMSR2IYqS9UxvHdPEVvTaNYeXFSTmeVNX0ERwPOW2jJGfEBJpTDY1IoCLg5
	WpJjYvXcRbz1gblCuE8VFC/txcWp02yfaNXACcAzlwX6HjqNqwAE4mWKqTdLvSxB
	c/D9RBIEv4/tn9bv8vRyoa+A1DSHq/+vGU1z8+VTT1fg895FfJoOqCYontW+BttQ
	dlKF5iW4O6m5rQAUlM+yvR8OAEHBFXGeEWld+jF1tMcztFRp3TXt5WHEOpTXYcem
	hrip2BNg+oXYpzN12jQE6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783295714; x=1783382114; bh=P
	JngaM3HfC9CnzsO5rUDlwnghrNEP1nqkloXnSUon3k=; b=kU4ymQLiSZOsP5TMq
	aBfJ3EmY+OPNGcJQDhSsv2L0K6kjyBWlnw6HZuvwsqiAFGZL2AYVWAc8eedUrvxf
	4KadpWxjPzDHaENfKTd9USCLBuyEIuF0IgH5XhmGNeasytAnhi2JLX7z0EfESK0r
	79dotBoJY4jnDvApbAUXfYYANSNqdICQeq5BujuV8oBj12EWV9mZ3ni3L8gh2cQd
	Y0zghHm+rvGIYPdgiVIYXwrw4j372ngubOwg8xPcF3gqHr1JFy8m0Dkk0tEzu8Eq
	+dt5ksfKUsGtK0fdTgjB/mBjbk6ONNlnZiJ84r/xfHomHCy2jICyRDqO46VCpt10
	XWPMQ==
X-ME-Sender: <xms:4e5Kapvbr-3WI3VBzQAqHLQAeqDZEz7gMK5tTPxauenY0Qrm6SDlyA>
    <xme:4e5KarYcDhSMzN9fFEDlVPl6mQKwM78ZUXX5dFw60RYEeT-B6Gcgk76N-k8NgrQV7
    GPBVGFb78-4pBaTkOykGZWzsGyjjpYBL9YVBtOTC8cyRd4-dA>
X-ME-Received: <xmr:4e5KaoUFz9kQu0jH2_tH6BGZTwy8FhzNS9mem5F-3Rd2kJe8KVCGECDMZAegFT3IDwwGq3I-IKqrMLt1PFJRIig8IJ6T4AA>
X-ME-Proxy-Cause: dmFkZTFZ3maL1kaqyYDflRj18K22YAVuctYMrHJEVN4CkEC78AUR2GrbcaifqTD10giemB
    nYQqDBG0n/gPyR9Uu6xwfGQ+JrlWQ2X0dcNMm3SaAyi0YnSRIUEglkxmzzGvmhekjd6Qvm
    6v7kEC8yrgG87M0/DkhGBE1kjVyjTyUQLddKs7Z1hui9RbON+VZllJ2WPvP0eFVPrsWhf+
    njduKt6BNVD8a/G+LJPLl9GjtEFt8Lwecz/BUfDIvhi8rQTN36ukRdbVxFSrgDvrWB6Oku
    Tjd/5VZue+KJ+uhGJj/fvcdcqIFifKn2fMJBZa8ETbN7OcoPeHfYFuJKnAPx0aMwjiJwJv
    uWwY8KMD1FWLXe/pfikdQDHcv1ymKINJYBmnPXczrETDevbKAiGoXn/xO02KeOk40VC7mi
    eLd9PfRBTkDgGKA4ScHeqnzBu5Pr8VYwgB7QdfmRHv9ALPSQFlzh/fmKOg9mZ/vFoiiDCg
    MO13vHBf3fYXRXQ/qN1FkJH7Kw7gisUtcLmfCIyECVCTZlFs/cJIZtHGi7o8i3Ru0M7+Fh
    3MhU83DLS9jrfbaGU233xQxnt8IY1UOnRGhmuJ9e4ELY2sPzvH5FIq+Qx6RnDeQyhh6vCh
    sgfJQUhF7hgai8V+UpNZhAQBlsCfY+Z0plt7Htbx52MKf8+XX7Sw6aRnyR2A
X-ME-Proxy: <xmx:4e5KagQZKCDlruXryAwI9kTDVIxHWEH0g_8nqmNhGBufCbX6MlQPsA>
    <xmx:4e5KamOZ_4ffg5PyDNDZ_lgSOcmGtS7IHQfcW94QtTYXJwqQkAnimw>
    <xmx:4e5KauSw1LBenNwd9z66UcQZ572Bc5x2seSHRxA1s4INkMR13qt8eg>
    <xmx:4e5Kakj4IZJ11sSdTp7VQEpyKseabbnGY5e2c3wVh8VvijbxGsW5xA>
    <xmx:4u5KalaUWm0ZPeuXaJfE34Mpdg7ZiQskAPVivlTIlJFVAj3tEugNHACf>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 19:55:12 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 2/3] VFS: move delegated_inode retry loop into lookup_open()
Date: Mon,  6 Jul 2026 09:46:01 +1000
Message-ID: <20260705235447.1322365-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260705235447.1322365-1-neilb@ownmail.net>
References: <20260705235447.1322365-1-neilb@ownmail.net>
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

