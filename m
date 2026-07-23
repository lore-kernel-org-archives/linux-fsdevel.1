Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCA430C15B
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 01:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784771629; cv=none; b=ENYz0EqTOz+W+CkHF4S2j/YpJ2RvXJ3HJmFUVHUzGZx1ZcQp0LTVSxXzAyvDmzbTrxr1JhWrdY77zLMmH0+0ZAjkI0IrC6M2MuhLXsgQflGFxd2TC4ha6235dpfa20PqQGXKdv26GSoyhHjyS1Wp2ml3A9GB3wGeDfS5X4C05NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784771629; c=relaxed/simple;
	bh=cwAkL0voQMm+h+sAX4zVL7tWwWHNXCpAub6ClTCaXXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bIKoY8Yuyn/CKGKwTDIgcSGDlG81LO6P+ekEqdjbZ9jAosmXr95zaUxyLRTFNGwxumGsqs3elHumtWJDIZ82FyuMwNP2tmuq9wEBc6BbuRjdwvi33XJyCDbhdxGKww9jFT57s1g8Y9GWH2IQepcShJUZ8ks4TcIgBu1RwxRQeZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=I/XRy7r+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mCC97hNv; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="I/XRy7r+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mCC97hNv"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AFC4B7A00F3;
	Wed, 22 Jul 2026 21:53:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 22 Jul 2026 21:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1784771626;
	 x=1784858026; bh=5PEmLY9GAooHOVYX24JpRxsNC7Uvk5XD/vSmPzYA7/E=; b=
	I/XRy7r+JZYZhE/wlntgZYvkG6no6z5LJa19WzrZ7MLB6p5iON5kiwZqaStoBWt8
	MGkdCJN1aH2j5b7FMnk1LadsuCJiMXqXM+CowPnV0CMlX0+txRqhoBXAh+hSDevO
	YM0PuXO8dcJoTEiMEzbljutyPn2PyCgKwBI6vynZecGH1KrvM/YnJ8nuXWMZ0mBF
	jJUIS9C6NX6To8psXaIgilodMoGuLnYaq2FhWRkXrCDEuFMqGBvlbNWNnTwunFN1
	BFF4Pj+pt3UOI7Cz3DHqCRO7ysiWyxMulalvX1WLGxtbDzVuuyMuYQDP6mRPe5YP
	tBmP82yHPUjX3zDoN2FC3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1784771626; x=1784858026; bh=5
	PEmLY9GAooHOVYX24JpRxsNC7Uvk5XD/vSmPzYA7/E=; b=mCC97hNvE6STfP6py
	cYUP6OrxM4zu6AJ2+3YcGzJCQota3IjCnsuUn20v//meT7H7FgWw2geLfc2xMJas
	nQxy3d+5IVgezYkPoq44TqW0quUp0y9W2fNSejm6MWKk1RCXRmeJu9TKabpMnNHP
	p2Ef7fjISrCOwrco9IKwbIk9Wi6lUUgSdy1o9WxDwDF/zAFiUxulX/gI0WwrJfH3
	mY945u71lXChyNVuI26+M90CWy7wEe8kEv1z0G48Jwgoi9/Bt+UxdPTmEee1qCdC
	OLyNfWOA9YUUWX8NwEZZg0I1ZpB5kCpX815VKhuq4AENH9naxGwH0U5ud27niXU0
	fknTA==
X-ME-Sender: <xms:KnRhag302Yg03k9dBzD-Dp2u5AuxtmjSV95nyP3nMG1DDta45yiCeg>
    <xme:KnRhamjloqaBNJx1_i89e5h6oiAo1Mivp3sKU81AeG5CNcO9T1D3oUqK15l4tACx-
    df4BPu2UmaIXK-pIh6I3OdX8zaXn8WPXrqLDCa_a04hYk-X9A>
X-ME-Received: <xmr:KnRhasYwQoHjxwUL16kZ4ngOygKXy0LXJbQ-p7mgfnf7AvMXtIWNNwfzDPwNkhq5VF-i3FYRrZbJCI3UQRLbqKxDPThjC5k>
X-ME-Proxy-Cause: dmFkZTGUD+tPGyCW5iFcR0KrxwT+cZn62k5ytjt0erG1KFLmd6At/xakqoWadNZRdvD/kE
    T8PhQ41aVoROMnV9SHpgGDF5bTQO3blPoJ5NQjUEQTSYiqzM8mGasrZH+76MEDIgl/BWgB
    rcz7IPe1prk4KsRJvO6kMsFh8n7yCrOznerNC8utywwQY4xhid5pyZTkxKJKKqRMJwfM6X
    jX3lF5QKh5oD+7SknmT1NmdxzTw8ymOrwE/trvTPB/wsb88IeNi5VX1Dz/zBnYBFxNyZZN
    oOv4oIOf/5cw+sWm7iNOl3kisIz0fw2JDxi4d44ChOGaW3+70ngAXtXXKRVDM9G50KGVSX
    jBqthJ43I49wfi6fJoVZfxY3OHSgZRjNSfxYKKY8A8xA35r5qsw63p82b8UzDIYIeuWq3K
    89bggdZujgc4a/fNjF36ceuHanrBXAB3P3Z3hHmYGuPnGw6FLv82cErjHj/ZKgJ+6Gtn6L
    ysD98uNNpTkUlYA6Ys8312Cwm2lQjwDDLnXlbTWqMK8uoAGU8GV/OwCwBA/SuukYBG+Gkw
    lZmW2fCBInr3LrwrUANfpsjr1S66zrC9ZOvgCuIrX701hB8hGu9yoYzib3g+TeWHSAwdEp
    FdNOasAjXAKRYRYK4FJc109uYPLDOz5TRDI4gmif5PRBztnxqbEG8+oDEmzw
X-ME-Proxy: <xmx:KnRhauSOtUYIrL54b_weh9RUuGLGAFKotWS9sNGNePQPPvVa-H2QcA>
    <xmx:KnRhavRB8U4ntMD_--RbNQmCA3Rz126wW8laLriGtPrXO_5VwOfTMA>
    <xmx:KnRhaiR3i0jGnOiJmsaSEYDjh22QAx7w0rkAp9T9d13Gn5Gbs91FoA>
    <xmx:KnRhak7PsXKbxXdVTJsbsrvn7m-AErlhQ9kRrv1NqASHxxGaGQjM9A>
    <xmx:KnRhajkA0qHvetYET3Q6F2OEXe34k1-gwAGmf02T0Ff7B2xVCyds19iE>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jul 2026 21:53:44 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/4] VFS: fix various typos in documentation for start_creating start_removing etc
Date: Thu, 23 Jul 2026 11:49:46 +1000
Message-ID: <20260723015330.3093207-2-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260723015330.3093207-1-neilb@ownmail.net>
References: <20260723015330.3093207-1-neilb@ownmail.net>
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
 Documentation/filesystems/porting.rst | 10 ++++----
 fs/namei.c                            | 34 +++++++++++++--------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 60880eb0c49d..4e015f1bf1f8 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1203,16 +1203,16 @@ will fail-safe.
 
 ---
 
-** mandatory**
+**mandatory**
 
 lookup_one(), lookup_one_unlocked(), lookup_one_positive_unlocked() now
 take a qstr instead of a name and len.  These, not the "one_len"
 versions, should be used whenever accessing a filesystem from outside
-that filesysmtem, through a mount point - which will have a mnt_idmap.
+that filesystem, through a mount point - which will have a mnt_idmap.
 
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
index e4ef48583a3b..763a8444aabc 100644
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
@@ -3210,7 +3210,7 @@ EXPORT_SYMBOL(lookup_one);
 /**
  * lookup_one_unlocked - lookup single pathname component
  * @idmap:	idmap of the mount the lookup is performed from
- * @name:	qstr olding pathname component to lookup
+ * @name:	qstr holding pathname component to lookup
  * @base:	base directory to lookup from
  *
  * This can be used for in-kernel filesystem clients such as file servers.
@@ -3243,7 +3243,7 @@ EXPORT_SYMBOL(lookup_one_unlocked);
 /**
  * lookup_one_positive_killable - lookup single pathname component
  * @idmap:	idmap of the mount the lookup is performed from
- * @name:	qstr olding pathname component to lookup
+ * @name:	qstr holding pathname component to lookup
  * @base:	base directory to lookup from
  *
  * This helper will yield ERR_PTR(-ENOENT) on negatives. The helper returns
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

