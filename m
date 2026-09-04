Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC74D426438;
	Fri,  4 Sep 2026 21:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788558828; cv=none; b=ZHf2+8MfZ65ZsVU1veypAm701dB4BUNXODGyplWW9BJGHFLxqJkNBk5yycgYjZnI10P9AfPzbdkSamEbNzS8BYZyQnKi7kLwJ0jFEnYmQi6zDVdxXa0+AZ3YwyQlJcq8vJkQLF3WRbmM/yhUeZpAeBzLWb0deFL21QENWR63Cgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788558828; c=relaxed/simple;
	bh=DKn3mH6e5UW5ZKmdIoCgZcupxdHkXvCEbmNshn0Ohwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J7upI9b8khvARBXO4X5tHPH+obd1TDq09U6svZODDyNmpTpPJQ0AAKWHJy02ZSRbBgYgFvPRHv62ggxASnpkajrb/879YOr8/Jcmd9kNN6v8pUsrZ9TyW4iOiFKizp9uMXi5wTp6YmdlPpZkv9aowkVhdKutFyRYBWn98vb5Nro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=O/PUQwGC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ShGahM1R; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="O/PUQwGC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ShGahM1R"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0AF471400156;
	Fri,  4 Sep 2026 17:53:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 04 Sep 2026 17:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1788558826;
	 x=1788645226; bh=x76cWHKe6pufS6Tmmh9Hg+tYaejNmWztL1qC220hXPo=; b=
	O/PUQwGCcCBQMAHLIb08w2AdXwZhTJUorguAwS3+iJrgFPZrWmxhtCFh3gQW51Pc
	DRMaWfTllRofe7pzTDlIGLM08elnW6BJiQMdCBniV0rOcNnpq0NCluh+fIixbSer
	DVs58A2w05yz/qxhPWJwrgvSE1YWOzzplyyKuybGGtRJebJMPRagKtUt3KjjuqlT
	8XQIwIImcYU1ww42P5pae3S8PLNdLPrUkautSfwfBalyZd3mKseGoMq4JFh6XVpR
	IEuBDsDk8LdHzA2PQ0H2+MfxGtNQoDDDXFBKH5rK/M7JCIIizN4hr5D9InM7/0NZ
	kNGFsgMj47x1dcrYkfXWKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1788558826; x=1788645226; bh=x
	76cWHKe6pufS6Tmmh9Hg+tYaejNmWztL1qC220hXPo=; b=ShGahM1RL2AY4v70k
	x+xAB4QCU2bGDAyZEored5cX/qxzTfOy1caRdMRDQ4qWAvM4JW93XUtAGrhR/gMJ
	O1p24JB7Js5+bG5a6MI7Ck4hiF1EwBPdA/bilro2u/0h/nUvGxYOMZYCpHaqcwOk
	m0or0LpJuFKVOF8X8oVQg2mztgEfLVUme+KO33Cp5njfrvnK95kmraBQ67xTcoES
	brpEk1g8uhZE5CSdTZxF7b6ke8WbeF0mNzQINI6weiiUOQeYD81dF+HH0v2dKrId
	T/AY0S9Apqo1mhFi72p8fz2BaecFdZzeXbb1BDFYsA8u76typeRJRtQjPOtgU+Zf
	Y9ogg==
X-ME-Sender: <xms:6T2banTAL_Eal74wJhgF8wltVTV3x8_DgQSAHcY-B3Rb5sln5gEcjQ>
    <xme:6T2barUJ4c2tj6Avvt9iIY8Ekl1ZMbxqeVCBvtpJ9scQZuW6ERz84nJvPRdbMwIb8
    8wgcs30k4U0QkkGhbJc9ZsO9pvljL3p8IGHasxBihyjlZ43DOQ>
X-ME-Received: <xmr:6T2bageVg0ciscCOYIfiJB5Z2bJNqCBMC0KlpfMoyYWfN5LCptem1631iKWCiFx1crooCK94xZQqRESoughMQEZqlp5Of_4>
X-ME-Proxy-Cause: dmFkZTFiAOSj3LUvbMyTizwFG8S0Z77/oyH2J2g/uycK/oy+xjfWiF27uJMr9H7g3QAOe/
    XYsAVApeSvodxh0nJXqm+2ih0Zs0UFQnZPCwAsQgYJh4bKlGJCxAFvJ28DiVFZcSJ1v4SN
    eyofj/RHn+C6wmmzYsHzdQWXaMLzQ5qjTmyCk6u6FNaJzHTyX3mRZJWbQlLecUBL+8R9uF
    oXPgTkabZ8M+0wwMRuzFqlmpEXjU77OKNTiGAEqZPKyJRGqwLIf4volXBc3DcquHRoaijA
    Ked+eKVy/8jzE5J4p8iliYop7ExvhRi8QZDkpUnJW3mwzA4SzmVm5+ia17mBgI6SpbQspn
    KOe1ipPvDb1dZcGdAxFpFgmtv2gIpIjaL+xSGRg8zmijYpytkhaOM24PfPWocRKSaqDsQE
    DSNdCbjO/5pyusvzxyzKyH21CrHy1U3KZ35FyuLclBUYC0vupR6nRRD6zTQC4sgILITPmH
    UqaZHbzj0H6wJ3ksSKCLZOvAcJlKsMofbRL1mJfPFYajkGiQTZBqpMyAm4yNw1orJbRluU
    whmjuIcisBYvApjNIiSqOhwTBeBltl83AbNKrA17/sG88V8ypgQFGDIIMfazC4JRT4o+w7
    PzMIJ65MYyczH7KFBjNWmnQGKhocuDnom5ZBYfgjEPpe3PWA3SVF9FQSt7iA
X-ME-Proxy: <xmx:6T2banJz6yxALd14LSB2dNOWj-jZEnjFHWCKTm5BvuOkP9f1vq0_tg>
    <xmx:6T2balzDkHTHinIuX9iJ86v8h78pxi-XjDYD-Xbmb8eW8pj8UhhVdQ>
    <xmx:6T2baluMmaMw6udDqpFi-qQNnFSSubIa5XMhzYh9aBORyp_sGP5fbA>
    <xmx:6T2bagCBZbP9N-acMRBI5Fxyui62z_BsMplIGSgf5bCxQCc7NN5vaA>
    <xmx:6j2bav7jsOENub4LfkfCkyQZCRm8rii2I3LnuzmTAc6czwH3HSiJEL8I>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 17:53:43 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/7] VFS: Add LOOKUP_SHARED flag.
Date: Sat,  5 Sep 2026 07:48:14 +1000
Message-ID: <20260904215142.1060510-6-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260904215142.1060510-1-neilb@ownmail.net>
References: <20260904215142.1060510-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

Some ->lookup handlers will need to drop and retake the parent lock, so
they can safely use d_alloc_parallel().

->lookup can be called with the parent lock either exclusive or shared.

A new flag, LOOKUP_SHARED, tells ->lookup how the parent is locked.

This is rather ugly, but will be gone soon after we move
d_alloc_parallel() out of the directory lock as ->lookup() will *always*
called with a shared lock on the parent.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c            | 20 +++++++++++---------
 include/linux/namei.h |  3 ++-
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 8d8d2af185f1..e978a75eb8a1 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1933,7 +1933,7 @@ static noinline struct dentry *lookup_slow(const struct qstr *name,
 	struct inode *inode = dir->d_inode;
 	struct dentry *res;
 	inode_lock_shared(inode);
-	res = __lookup_slow(name, dir, flags);
+	res = __lookup_slow(name, dir, flags | LOOKUP_SHARED);
 	inode_unlock_shared(inode);
 	return res;
 }
@@ -1947,7 +1947,7 @@ static struct dentry *lookup_slow_killable(const struct qstr *name,
 
 	if (inode_lock_shared_killable(inode))
 		return ERR_PTR(-EINTR);
-	res = __lookup_slow(name, dir, flags);
+	res = __lookup_slow(name, dir, flags | LOOKUP_SHARED);
 	inode_unlock_shared(inode);
 	return res;
 }
@@ -4440,12 +4440,14 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	int error, create_error;
 	umode_t mode;
 	bool got_write;
+	unsigned int shared_flag;
 
 retry:
 	open_flag = op->open_flag;
 	got_write = false;
 	mode = op->mode;
 	create_error = 0;
+	shared_flag = (open_flag & O_CREAT) ? 0 : LOOKUP_SHARED;
 
 	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
 		got_write = !mnt_want_write(nd->path.mnt);
@@ -4454,10 +4456,10 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		 * a different error; we'll be dropping this one anyway.
 		 */
 	}
-	if (open_flag & O_CREAT)
-		inode_lock(dir_inode);
-	else
+	if (shared_flag)
 		inode_lock_shared(dir_inode);
+	else
+		inode_lock(dir_inode);
 
 	if (unlikely(IS_DEADDIR(dir_inode))) {
 		dentry = ERR_PTR(-ENOENT);
@@ -4526,7 +4528,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 
 	if (d_in_lookup(dentry)) {
 		struct dentry *res = dir_inode->i_op->lookup(dir_inode, dentry,
-							     nd->flags);
+							     nd->flags | shared_flag);
 		d_lookup_done(dentry);
 		if (unlikely(res)) {
 			if (IS_ERR(res)) {
@@ -4574,10 +4576,10 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		if (file->f_mode & FMODE_OPENED)
 			fsnotify_open(file);
 	}
-	if ((open_flag & O_CREAT) || create_error)
-		inode_unlock(dir_inode);
-	else
+	if (shared_flag)
 		inode_unlock_shared(dir_inode);
+	else
+		inode_unlock(dir_inode);
 
 	if (got_write)
 		mnt_drop_write(nd->path.mnt);
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 86d657b24fc6..65f0f5712885 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -32,8 +32,9 @@ enum { MAX_NESTED_LINKS = 8 };
 #define LOOKUP_CREATE		BIT(17)	/* ... in object creation */
 #define LOOKUP_EXCL		BIT(18)	/* ... in target must not exist */
 #define LOOKUP_RENAME_TARGET	BIT(19)	/* ... in destination of rename() */
+#define LOOKUP_SHARED		BIT(20) /* Parent lock is held shared */
 
-/* 4 spare bits for intent */
+/* 3 spare bits for intent */
 
 /* Scoping flags for lookup. */
 #define LOOKUP_NO_SYMLINKS	BIT(24) /* No symlink crossing. */
-- 
2.50.0.107.gf914562f5916.dirty

