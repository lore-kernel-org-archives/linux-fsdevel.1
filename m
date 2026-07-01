Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ADC345CCD
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 23:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782948713; cv=none; b=o4Tmx1wNiAy3KqFgbyBJMl/gbIirHb7fcBr7HeEanhO4MGyTO/ex/skpCDFHyIgTxYnLYHoE+pn9SXhgOVYpQe50Ycl6W7hh9PXmWF0J95rwabAgPOSyawWtiP2VdYQguajdzy2Kppb0qXKBhdJNk2t6c6YoEstHwEAePAdR7NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782948713; c=relaxed/simple;
	bh=v0muZptQmVI4kh2727N9/r0yfXE9xlG/qkT54/PTkXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jP6FCv7ahirKLtutP5N+Nfjng5gTyORX6/uHwyPsCMwjDX/TYHzBUZ+UnirxuiTltNbamoKVr+dh+5G/Bmm4e2Vprs3siYEIZr8mXfvR8wWFMwGIOyDvnVximlpfgKbN+SH+vJebsPCfggrdCcDTrYrkG0YeHGxuq4PZkrNUSWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=qRrYs7hR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nkb4oNpD; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="qRrYs7hR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nkb4oNpD"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id EE2861D00084;
	Wed,  1 Jul 2026 19:31:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 01 Jul 2026 19:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1782948710;
	 x=1783035110; bh=cFbx9W9sEBSytac5oMFRiUS+cnIbez7J+FGGXE94VlA=; b=
	qRrYs7hRDYPb4prcbdjGVE+ly/jzSOHiCuLGd3FtHFPXLhSvFfapdVKu8gPAU3a1
	S5700IgLAu48R9s9PyqYbg96R8dV1neLNnI2R3Cv0cWPHTopxXhOF6y6W9jGZNSj
	MhB11faqb6jEda/WvyofnhPqHOAAhZUwdZ9O6x5EbfXbJuj3N0PsO8sr8GG2cZxX
	1syPGaAumhCtFVCmIfFuXPZScwl5q6vLlzc8EEAJU8jcEPW5NdRWXWWQvMuagml/
	/gXnhO0znDIhyM/pEzIeUX0XYu2ee5ItdM3Aij3tw4un8eeDyJEi8SWdB1GO9Viy
	bs0FioGPOXp/ympJH5qX7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1782948710; x=1783035110; bh=c
	Fbx9W9sEBSytac5oMFRiUS+cnIbez7J+FGGXE94VlA=; b=Nkb4oNpDMTrPfwH42
	8gO0d+rAiFp18foETE95oP7xTfBbfBAS3a8XNNfrCfvEfN4kG6ul7CiMZ54UJgXE
	+WwOa2KVCW/mfdfCxO98LCBUM3+3uHz2ZskI8ZssbYPrVx46+N2rvX+MFaKno7BO
	fFWWYwRSwpl4hUrY8dm8W+7X9i52V22YiGsVNTtwP/LkM1ohQIEpWzwPRM79IYOW
	JbgUphXaroBhtVQ2X8APDkDA1zHuESuWFyu1+rmiZ1ADydYZ/bPFi+fnwUkIEZ/r
	Hwp4ttUTOkcStcigm9p9I95/Kt6cHwRu/wjNQK3kAntPn0Jf/aPhqWrL58Zgy5d/
	NRsNQ==
X-ME-Sender: <xms:ZqNFavRqlZdS1WN1ENGekFibdUaJXY36En-YzrdvdkhVG9DTnaHJIA>
    <xme:ZqNFasMPPEikS8sVze8HQgH2ZZR8thUS0SexrABqePEjubLL_RP32nCdKMELSvKmI
    j4lcRPm0LdR41rJgTE-VVhSVdSSE5a6vbwbM-OT578X8lE9yQ>
X-ME-Received: <xmr:ZqNFaoX7auFUlmIgs7tQAuub-EvDXX2WOqKl9o67s1d-RCrEJaA718g3sW6t3EQk4TP66s_mv8B_aqiM-7sEfCc4dFQbC9E>
X-ME-Proxy-Cause: dmFkZTGpK8J8MTfiaDCXl0p9GeFI2ap7QNdqKZHmzjFdgXfPq6j8BSC3DPmNzQNdNO0FGG
    boVGPa83aYnUNHEG0aYkF8TcsyorwzTWgkxD7xWbZHXsW9fO/Sp86DKldN01mowwjt89vy
    iiGEqxyh3NQ4w98H65wqskYtPzGLN/cmvTNyGlrxX46iJWgOJVpmZu00BN9OL2fTWUmTTG
    nrTXcvhJxzaOLk5EDW9EEpLJ862hp8WB4v//ZRLMtpojOTQhjHxR0zKdrB8v0yoUPrGme4
    YnF4K0aN6bSv51FzNNpRVK1bciTQ5st13FlXjbGEDk+VZTI4rgCPP5aRVk+Xdfyt/nAlr4
    /TuZWXy59CrqfW+vvGyL3jcTVUSeB/o21whVl7/pas57ODMyE+jgQCh200NMc8w/VAZ5cR
    EwQDbBL8FYAsUwJRqjfTgn5jVMtJl4Xg9pB9TDZw/ux+i9Bn1RSxi5cBOLMvtQSYvzh7Fu
    AbnQQLZr7SSlAaBKFNUROzvNoDpFtTmSMSmqwmvRu5nigaQUWnM1lpFVjC06i3D+45wg/g
    74E2jAOOQwejCKQ7wfM+9Z651+CFg6qSGahWb+xSZdX58DNpNsVUTSmJrj5Jq2wNOBgwak
    LSGyVlfMdOaKP1vCkSzhaAPHb1pCSvjRAIawbWkD6wruqUAmB7yTAoSEpWbw
X-ME-Proxy: <xmx:ZqNFajd8T2jVW_YDujrYGYvyXuj5jleMCQ2f4WPtkeouVmyIhUbeQA>
    <xmx:ZqNFakvgN6sKX5PFQkMK31kGf5VoqFVeQOLQNVl-C-_ogT7Id56dYQ>
    <xmx:ZqNFai8ME28Oyq5JHCMy9M2WcmRAGZfFu71lCMeOgVLbEp7LUdFRLA>
    <xmx:ZqNFav0meJqerBDA1AFdlIujRXCr1g2fIR2gfQjc0lUSJMMGBQ1o1A>
    <xmx:ZqNFarC1fblGqu3-vQ2RGFyQYhrfg9P0HRwKM3Ny_4CkphGxjSDlZVaG>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 19:31:48 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/4] VFS: fix various typos in documentation for start_creating start_removing etc
Date: Thu,  2 Jul 2026 09:29:01 +1000
Message-ID: <20260701233128.3356519-2-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260701233128.3356519-1-neilb@ownmail.net>
References: <20260701233128.3356519-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

Various typos fixes.
start_creating_dentry() now documented as *creating*, not *removing* the
entry.
Unwanted spaces in Documentation/filesystems/porting.rst removed.

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/porting.rst |  8 +++----
 fs/namei.c                            | 30 +++++++++++++--------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 02522fbfd968..7ed299060a41 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1203,7 +1203,7 @@ will fail-safe.
 
 ---
 
-** mandatory**
+**mandatory**
 
 lookup_one(), lookup_one_unlocked(), lookup_one_positive_unlocked() now
 take a qstr instead of a name and len.  These, not the "one_len"
@@ -1212,7 +1212,7 @@ that filesysmtem, through a mount point - which will have a mnt_idmap.
 
 ---
 
-** mandatory**
+**mandatory**
 
 Functions try_lookup_one_len(), lookup_one_len(),
 lookup_one_len_unlocked() and lookup_positive_unlocked() have been
@@ -1229,7 +1229,7 @@ already been performed such as after vfs_path_parent_lookup()
 
 ---
 
-** mandatory**
+**mandatory**
 
 d_hash_and_lookup() is no longer exported or available outside the VFS.
 Use try_lookup_noperm() instead.  This adds name validation and takes
@@ -1370,7 +1370,7 @@ similar.
 
 ---
 
-** mandatory**
+**mandatory**
 
 lock_rename(), lock_rename_child(), unlock_rename() are no
 longer available.  Use start_renaming() or similar.
diff --git a/fs/namei.c b/fs/namei.c
index 10504b1032d9..ad85136cd44f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2946,8 +2946,8 @@ struct dentry *start_dirop(struct dentry *parent, struct qstr *name,
  * end_dirop - signal completion of a dirop
  * @de: the dentry which was returned by start_dirop or similar.
  *
- * If the de is an error, nothing happens. Otherwise any lock taken to
- * protect the dentry is dropped and the dentry itself is release (dput()).
+ * If the @de is an error, nothing happens. Otherwise any lock taken to
+ * protect the dentry is dropped and the dentry itself is released (dput()).
  */
 void end_dirop(struct dentry *de)
 {
@@ -3259,7 +3259,7 @@ EXPORT_SYMBOL(lookup_one_unlocked);
  * the i_rwsem itself if necessary.  If a fatal signal is pending or
  * delivered, it will return %-EINTR if the lock is needed.
  *
- * Returns: A dentry, possibly negative, or
+ * Returns: A positive dentry, or
  *	   - same errors as lookup_one_unlocked() or
  *	   - ERR_PTR(-EINTR) if a fatal signal is pending.
  */
@@ -3381,7 +3381,7 @@ struct dentry *lookup_noperm_positive_unlocked(struct qstr *name,
 EXPORT_SYMBOL(lookup_noperm_positive_unlocked);
 
 /**
- * start_creating - prepare to create a given name with permission checking
+ * start_creating - prepare to access or create a given name with permission checking
  * @idmap:  idmap of the mount
  * @parent: directory in which to prepare to create the name
  * @name:   the name to be created
@@ -3413,8 +3413,8 @@ EXPORT_SYMBOL(start_creating);
  * @parent: directory in which to find the name
  * @name:   the name to be removed
  *
- * Locks are taken and a lookup in performed prior to removing
- * an object from a directory.  Permission checking (MAY_EXEC) is performed
+ * Locks are taken and a lookup is performed prior to removing an object
+ * from a directory.  Permission checking (MAY_EXEC) is performed
  * against @idmap.
  *
  * If the name doesn't exist, an error is returned.
@@ -3440,7 +3440,7 @@ EXPORT_SYMBOL(start_removing);
  * @parent: directory in which to prepare to create the name
  * @name:   the name to be created
  *
- * Locks are taken and a lookup in performed prior to creating
+ * Locks are taken and a lookup is performed prior to creating
  * an object in a directory.  Permission checking (MAY_EXEC) is performed
  * against @idmap.
  *
@@ -3469,7 +3469,7 @@ EXPORT_SYMBOL(start_creating_killable);
  * @parent: directory in which to find the name
  * @name:   the name to be removed
  *
- * Locks are taken and a lookup in performed prior to removing
+ * Locks are taken and a lookup is performed prior to removing
  * an object from a directory.  Permission checking (MAY_EXEC) is performed
  * against @idmap.
  *
@@ -3499,7 +3499,7 @@ EXPORT_SYMBOL(start_removing_killable);
  * @parent: directory in which to prepare to create the name
  * @name:   the name to be created
  *
- * Locks are taken and a lookup in performed prior to creating
+ * Locks are taken and a lookup is performed prior to creating
  * an object in a directory.
  *
  * If the name already exists, a positive dentry is returned.
@@ -3522,7 +3522,7 @@ EXPORT_SYMBOL(start_creating_noperm);
  * @parent: directory in which to find the name
  * @name:   the name to be removed
  *
- * Locks are taken and a lookup in performed prior to removing
+ * Locks are taken and a lookup is performed prior to removing
  * an object from a directory.
  *
  * If the name doesn't exist, an error is returned.
@@ -3543,11 +3543,11 @@ struct dentry *start_removing_noperm(struct dentry *parent,
 EXPORT_SYMBOL(start_removing_noperm);
 
 /**
- * start_creating_dentry - prepare to create a given dentry
- * @parent: directory from which dentry should be removed
- * @child:  the dentry to be removed
+ * start_creating_dentry - prepare to access or create a given dentry
+ * @parent: directory of dentry
+ * @child:  the dentry to be prepared
  *
- * A lock is taken to protect the dentry again other dirops and
+ * A lock is taken to protect the dentry against other dirops and
  * the validity of the dentry is checked: correct parent and still hashed.
  *
  * If the dentry is valid and negative a reference is taken and
@@ -3580,7 +3580,7 @@ EXPORT_SYMBOL(start_creating_dentry);
  * @parent: directory from which dentry should be removed
  * @child:  the dentry to be removed
  *
- * A lock is taken to protect the dentry again other dirops and
+ * A lock is taken to protect the dentry against other dirops and
  * the validity of the dentry is checked: correct parent and still hashed.
  *
  * If the dentry is valid and positive, a reference is taken and
-- 
2.50.0.107.gf914562f5916.dirty

