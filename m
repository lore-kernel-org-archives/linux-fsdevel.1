Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FEE3537F1
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2026 03:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788405927; cv=none; b=e22CriWRMWkcROuZvB5n08eRZpz3tR+CyqeVlwUi/Fi6omG+ZFD56lZp1MgkEVbzgp1TSSUZ/6k9VmRgShsopMVS8um2Em+zNiU3J/VAJFYQOfxezinQZa6gn6YEL+HABYcPww7nuGe9/yK19JEbh0cxR+JnFj5KfkhTjJ9TTco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788405927; c=relaxed/simple;
	bh=DKn3mH6e5UW5ZKmdIoCgZcupxdHkXvCEbmNshn0Ohwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hh/s3CtycidqNYCZWLHoW7B4ACIOkCOne/M3ivxZML1FoZiraLBzuftXhGm+u1SLQCTB7senWCFcMXH+SlbIOatuQyH+wjx1AoGMoUFqPsJ95angcQvrGzLZ+kUwdHe34xng7vl9VaTIkOmXWCADxnmmWVUs/weqD1rsftA2Xn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=H69YHxNv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nRxyx87r; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="H69YHxNv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nRxyx87r"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id DA2ABEC0242;
	Wed,  2 Sep 2026 23:25:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 02 Sep 2026 23:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1788405922;
	 x=1788492322; bh=x76cWHKe6pufS6Tmmh9Hg+tYaejNmWztL1qC220hXPo=; b=
	H69YHxNvIO3LPhrUwPdN9p9JsfuJrTo2qrAvaUtuo12delzEigkcTnsslBR8wxF2
	xbQBGA8WnpCUbjWZRPwrUm6VEUsBolFg309kesLD+r7SgkcEe4LI/HCREQ87lPPs
	7kRWQQaz+fq3lfMxjZGhWzT8+aTpGp2MVjx1Wh0+vtfJMJPf0H9b90Cpxbjjk/FC
	9GjtALhGAu8GXVsRMomEIYTSW9Zw/7ZxZxThKr2WWm422vRd+WtJRhSkK2lgJB9X
	fO+rRBu77mOqSFySLNzIRsSAykZ7hT0+XQVCcpmo0/g3x6vxN9E0N6z2BDJxoRBb
	otAgPouOv0bOz8ssEUhi9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1788405922; x=1788492322; bh=x
	76cWHKe6pufS6Tmmh9Hg+tYaejNmWztL1qC220hXPo=; b=nRxyx87rtjYW/xZpL
	dwuhqKD76ITdQf+qQmAjY18/G58XAQkuoOKrlksqfdyzvlk/tmLJAefj5zpoWCWl
	mfmh00BNYzXMDcCnBLaSawCn48jB34ZKC9qRh9qIiIUBmPQ8izxRdTVJetJJHf05
	e/KN3/0zoxl5DCLMVnkqX4uZR0oYJA6XgG99fntl5q2Sm/K2k70XvjUs9noltV38
	IdOPIsGKIZAXVeE/wznduHwddxhhyXQDILh7p+AE/7dHyQuHr6qF1eG7dcGe0Ilt
	5Kohov8BZTVWTwk8mXUNj6H+QSl3gBbcpRSYngpb6tQbmDZmnsHueROkXmoGGHdu
	7xMpQ==
X-ME-Sender: <xms:ouiYavtqFMUZGJVn6T_xPTx0tXt4Wv_yU67HVe50MaaocSQFS9LHuw>
    <xme:ouiYaqhugN0lt9IMY8KHTG4MXneBjk0oWHMuIcXpxst6LEwtGhKR9GvxXRsh8iutU
    bXuni5NvonnJ11qnI6BuHdWp47KlRIsSqqI7hFGvNjc8qGGGw>
X-ME-Received: <xmr:ouiYaipp1NmE1RKQLEQki7qahVb4_Erk8CG4TbEvxmIj9lWp8vT_ktbXpqzmMNWt98QZkTUqRya7ovwaNQC2jxpWXfln6Ao>
X-ME-Proxy-Cause: dmFkZTFXt6cUefGPSewwwFqdKdDzyta/nNOStoIf8ygsd3d55Ylv2azk0WUcYGr/qWGe89
    /agY7xGpogS9PXkreI4nrnEfEmH4ukRCYLCLQ3ife4R0W6dMBF5Im/9SUb/nWmHvjbtfji
    C94zMCN8ZKwE6V7UAH/g5bDmuGJ60zEKAcm0MCk2H/yiC+xmz/8AzeGfH/ZAapoxNSHcuj
    2NAwOe/HPAaVDALEsfGdSX4FygHdBou8gRiZnt7cvbj+wi4KWShvSMjFP4ENhF65bJ2jDU
    hJYERCmXGNC3cGgAODpYVa2vdRDJp2cxqVzJcwEfZ6JwMc6xSMdbQ9cS0F1GoWnjdMdMHN
    Dm8CnGuC+bJKNUVe9TCFYPaSn9IUQ8pFd3zZpdWDx1VPtLayN2iXiA1c/qBIXab0GFyhrJ
    QhjQZB6j7x5YPGI0ovm/nD/VVUltiBiYc5fWaOnYQrMM/ABD3Vw/wrzbkB8A4Z0Fh4s+Zx
    vPkhWIekTdZmHxYXLrJpmUaERrVXFpv4VTuu96e9PxAmam3DjAnK9s9J9h5T3a9SaIM8b2
    Lfs11OFjcr0jjOcVkl/18/ao3c+lTDrICP1qeG1/SlyOgCkmJctHHXYd/How7EdyGoa6q1
    be37sQH6pzR+znCiuMNkaNmavUPd8YbS5kxqhGXXgNgjEysoufZXYP8u9w8g
X-ME-Proxy: <xmx:ouiYavt9DYNwcrwCSEK-8pQI4wsk5gZUI5dR-Zng_1YkN7P8JO6cdQ>
    <xmx:ouiYatbj3kxFQl7MBSD4wbTnvp27clyDBOIfabAisMSDjkedXf_9Gw>
    <xmx:ouiYauZjyg0csEMl-ZCr4TshocNJfZ2wyL-5Ju5bqusXyCosu_eDdA>
    <xmx:ouiYamm7M2lG_QOjOC086Fq-Xe_0PaZFBtzaw-Bn4dKYju8F3ll9WA>
    <xmx:ouiYagRRCgPxcOXgra3G1XyoIwMvGiSZnMLmHNAXHsBL1vV7DMJyqkiT>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 23:25:20 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH v3 5/6] VFS: Add LOOKUP_SHARED flag.
Date: Thu,  3 Sep 2026 13:01:35 +1000
Message-ID: <20260903032431.142777-6-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260903032431.142777-1-neilb@ownmail.net>
References: <20260903032431.142777-1-neilb@ownmail.net>
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

