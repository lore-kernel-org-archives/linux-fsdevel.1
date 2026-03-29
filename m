Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745323822B8
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 05:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774848537; cv=none; b=SEx8+v+egNSjKs/cBsZeJKULP7u0NMC7ur3esAKhU3LuGLbJi2jN3lkX5Q7VglQ5Zpg6BOAJJiDcvhiQmf6eG+mtWGhcLswPY+QJI3Eh3fCaz8A8FMSwtiX4w/H/wqiUnJC4YuUI3C4YoJb9IWom1GqiqztMlPukS4iEFJ/TXRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774848537; c=relaxed/simple;
	bh=At6PVvuxUqEHHcU3K6OhPgAKD73B1CTuAjJYEdzwlSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MWNyWKOOZOx9XeNyszrtLKKON+Hyyv/hEjwh8g8cIbnYOtu0VI8NebRxMqTyUQPFi0LR7GJAXPUesGY5M3tlP0wf3ERVBri7sSvBBbwxaFZJjqLjHog8IbTI4vuGeanx7/BGUfCtH8SRfXe6of/VCUxzr3/pOvt4rYXNmUmX33Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=XJBWxd3S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RGgp3yOI; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="XJBWxd3S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RGgp3yOI"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 875787A02C9;
	Mon, 30 Mar 2026 01:28:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 30 Mar 2026 01:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1774848534;
	 x=1774934934; bh=JfDxxCQ1lhe7bLUMR3RudXyTHsd7xOxN159HLrpNnp4=; b=
	XJBWxd3SI8tqBd/YukIbt9hhMv2SPbHLeufRMghLTaX6079B1Vqxp+sXRw5Pew6Q
	LPIw6StOgDaOQlSXotmr38KGzwqNX4HG/Ls+yQSuE5GGT8imt4LLJ40TfOnGg6QK
	FAjvnR1EHByKESNmvR8JL09aNQzNf5Uuf2Yo+zWsDo1voinFx1VmdzSz35y3ZlJw
	wH77Xhb2pmgzogWtU+5n7/aSiYtJHDG3CPhvJy+1AZ44YwLPRehxoA8qeGGu4tgC
	wsszxo8/TU3Um7ATlW7T3JEo8UrSQkw/7XqNRdD+vcMEYJ29frhJjYkNCrybOAQ7
	GhhMkwby1de9g1M6suXfnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1774848534; x=1774934934; bh=J
	fDxxCQ1lhe7bLUMR3RudXyTHsd7xOxN159HLrpNnp4=; b=RGgp3yOIfXREt03og
	rEWSMtuqWata2NoMCbI+mkO3UpdpJrrNZM/RcxyHWUOvj64BDCyyF2fGbMmUMwAU
	0Emni6qK5J6r1z6bH6tjznb+3beUbv3aSi3bYzH+0ZBTwCbUFGpE3WbJlk24wiRv
	CiEaSPJSBlV+o9Fj3UQQRg/FfpBrGB9QRnxiPkRwO6dqA/au3zmurs1cq4ydvkH+
	gtCgO9Xc+grW9VRlnNJRvB4eaLB22k3BZOWoXgJomWq6fMsaRHVelua4qc1I8cHK
	o+2B6+GbuapAtD+ZhaBRvkCUxugZkhv1VbRYfmERfFYXQv4RYM1F+2etUFVyauIX
	6f2jA==
X-ME-Sender: <xms:FgrKaYVQgjiXOTt2XurvYj4Le6EI7IqyYCSPGN3kHzOqpQ_D5vAtiQ>
    <xme:FgrKaYAUBgPDj1DWjCyyjp2cv7yA-aq8UnmCJH2YqhBYHED2o_CkWefA0NO_f_lM8
    plFURlCDCKH90WVEhPs8WkgS5yc-6kapvC9LWpVpJ9dxld7PWI>
X-ME-Received: <xmr:FgrKaf7N7C2-3_UHjAYnQ8JXZQQYa6NSkIqLUCH8BbSftPc-I2TKjI7ZfJVUELTFIHdZNwCXwLJC3bb-7BrukQVxkVIRfj4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeekudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepsghrrghunhgvrh
    eskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:FgrKabzPOpQNUsVwICi-S0ApzUvPounu5Lmbib_XrX6df_yQSuHVGQ>
    <xmx:FgrKaeztDyBqivhI7oHA5Mxx9KDwmGIGIkIK-YKUr_YKH9HWBR7L4w>
    <xmx:FgrKabx_u3lnBdhgYPclRIJkczzvpVfsj57ZoDeW3djVm5kipCfHkQ>
    <xmx:FgrKaQYI_kc6Z0Bo_iCp8r0DOPvdh4-dnPgdpd4QE2Myw2UQZ-5C_A>
    <xmx:FgrKaTG9G54KcE7gx4Vp1XXm_JhcsgdfpoO0DueSGbrXTh8ud7JlXOtd>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 01:28:52 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/4] VFS: fix various typos in documentation for start_creating start_removing etc
Date: Mon, 30 Mar 2026 09:46:36 +1100
Message-ID: <20260329225603.2177730-2-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260329225603.2177730-1-neilb@ownmail.net>
References: <20260329225603.2177730-1-neilb@ownmail.net>
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
index d02aa57e4477..560b473e02d0 100644
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
@@ -1370,7 +1370,7 @@ lookup_one_qstr_excl() is no longer exported - use start_creating() or
 similar.
 ---
 
-** mandatory**
+**mandatory**
 
 lock_rename(), lock_rename_child(), unlock_rename() are no
 longer available.  Use start_renaming() or similar.
diff --git a/fs/namei.c b/fs/namei.c
index 77189335bbcc..6ffb8367b1cf 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2936,8 +2936,8 @@ struct dentry *start_dirop(struct dentry *parent, struct qstr *name,
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
@@ -3254,7 +3254,7 @@ EXPORT_SYMBOL(lookup_one_unlocked);
  * the i_rwsem itself if necessary.  If a fatal signal is pending or
  * delivered, it will return %-EINTR if the lock is needed.
  *
- * Returns: A dentry, possibly negative, or
+ * Returns: A positive dentry, or
  *	   - same errors as lookup_one_unlocked() or
  *	   - ERR_PTR(-EINTR) if a fatal signal is pending.
  */
@@ -3376,7 +3376,7 @@ struct dentry *lookup_noperm_positive_unlocked(struct qstr *name,
 EXPORT_SYMBOL(lookup_noperm_positive_unlocked);
 
 /**
- * start_creating - prepare to create a given name with permission checking
+ * start_creating - prepare to access or create a given name with permission checking
  * @idmap:  idmap of the mount
  * @parent: directory in which to prepare to create the name
  * @name:   the name to be created
@@ -3408,8 +3408,8 @@ EXPORT_SYMBOL(start_creating);
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
@@ -3435,7 +3435,7 @@ EXPORT_SYMBOL(start_removing);
  * @parent: directory in which to prepare to create the name
  * @name:   the name to be created
  *
- * Locks are taken and a lookup in performed prior to creating
+ * Locks are taken and a lookup is performed prior to creating
  * an object in a directory.  Permission checking (MAY_EXEC) is performed
  * against @idmap.
  *
@@ -3464,7 +3464,7 @@ EXPORT_SYMBOL(start_creating_killable);
  * @parent: directory in which to find the name
  * @name:   the name to be removed
  *
- * Locks are taken and a lookup in performed prior to removing
+ * Locks are taken and a lookup is performed prior to removing
  * an object from a directory.  Permission checking (MAY_EXEC) is performed
  * against @idmap.
  *
@@ -3494,7 +3494,7 @@ EXPORT_SYMBOL(start_removing_killable);
  * @parent: directory in which to prepare to create the name
  * @name:   the name to be created
  *
- * Locks are taken and a lookup in performed prior to creating
+ * Locks are taken and a lookup is performed prior to creating
  * an object in a directory.
  *
  * If the name already exists, a positive dentry is returned.
@@ -3517,7 +3517,7 @@ EXPORT_SYMBOL(start_creating_noperm);
  * @parent: directory in which to find the name
  * @name:   the name to be removed
  *
- * Locks are taken and a lookup in performed prior to removing
+ * Locks are taken and a lookup is performed prior to removing
  * an object from a directory.
  *
  * If the name doesn't exist, an error is returned.
@@ -3538,11 +3538,11 @@ struct dentry *start_removing_noperm(struct dentry *parent,
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
@@ -3575,7 +3575,7 @@ EXPORT_SYMBOL(start_creating_dentry);
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

