Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B082438488;
	Fri,  4 Sep 2026 21:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788558806; cv=none; b=faNznEsV10UuAx4CMzWZS9/FWD3xHxLFcdWryKFGErACTxOHbsBGLEUujYX/wkZt9K3CWETlsksTgQVRf3kKuK9naVBheLRcEyrPr94TFU1PBcRsa9SqDBSXzft55uPgpJEtGm0VKD0jvfc0Milq2SyETZfzjUTSW5iQvpZYZSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788558806; c=relaxed/simple;
	bh=85DynhXkr+hqotCALLziTC6eMfYHwSakefI7Y+Thsvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPZniU0j8mvWR1JaF22Ne7MQKFe15tRpZQ+V1qvkp4/SlC5LoCYFfTiT7BD1lEE/D8JWBwsvjWqIYuVgTOVCE9c0qXoqshsS0v5jW85fdlbD6oLRbs2SNuSdcnz9+iPgYI8Ws5zFWx7N2P8uAvCinhkn+9CcDz/zvlrczT8n+ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=DndfaxsM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qtDp5doh; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="DndfaxsM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qtDp5doh"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 3948DEC0177;
	Fri,  4 Sep 2026 17:53:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 04 Sep 2026 17:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1788558804;
	 x=1788645204; bh=ffp/q4O+ehQP4wOXC4Hjwke9m+zN+xkUyMSMNGMBba0=; b=
	DndfaxsM8+Mak7SRlUux3CVNkD792tmLf5QIhtbbOAacnRz/MH0ySA4rUaa+DLvP
	aFM9G6SZPTC6xcllnM1mhfaRAogPuzW2UEC7oppzRvPEoVPVsmh2wOV2lSMEFbRv
	v503CoMYG9jCGkRwrIf9ItQvBAH1TrW5EYUOb7KyFuN9Y76F9P6e9QQfUwtOXD9z
	/BwwjOVzECZM5OscuTpgsVHdzarH0CDslmY+pQvVfY9fkovRw+teR4pAoj5aluYS
	4/SppNYTUZUnWeGSR7tR6WqkdQnrwT/H667le2FksehKj/XQMDOaiV7wF11Q6H0i
	H4gLivimQSlOYereLbKj8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1788558804; x=1788645204; bh=f
	fp/q4O+ehQP4wOXC4Hjwke9m+zN+xkUyMSMNGMBba0=; b=qtDp5dohMqgPlf8mg
	IWvGvFHoLFr4jfyp2wrXmMCOJ0H/FEt0TmvmtNEFESRAr1n0zHa5Z5Mr+o6sAjBo
	8+XccYfk7uvzGw/qgR1KeG4c5MO+46asFrMjWvLZgyuWzeNbHr584TGPRqDjeEy3
	28lbQpdtnJzBIaZj3eWEFS5Cl6ZdQmw0T8NVkN2/LKUXafN9jt1+jxFhOGEUJpcm
	LBJUde8T9WsPIWpXwA/4ESexVH1LKe9w40HDNqsHVE3o7I3hF3uLeLsYxcFjX6g1
	UmLsw2lqVHd60AFlsHowxFi8w5g/WWfjPRagPcvbSW8odq3NuRavYNMVGdwk+nvn
	cRPeA==
X-ME-Sender: <xms:0z2barV7gKFHpwJORatASGxk26MsKRzp-TPzbdXU0UlLkF4UJlis8A>
    <xme:0z2bamIqaWY0Wn-8tqWwLcLx5hTxDTWu9fWrtCYZayLPMGX8WGjKGM6xeEr9RK2pQ
    qwaEN2xi_NknqpIwQM1ELyeu8T-aM5Qjlz28nR9uEqOtK9ek8g>
X-ME-Received: <xmr:0z2barDsUKztomkUBt0RvcCh-W7OspUjD1yp3BVfeC7wmNX-5S5qNdEcYOYk-pN7jye_R8HqUIOQuuZYOlcwoqXpVWdIU8k>
X-ME-Proxy-Cause: dmFkZTFDVljjZPAYZ1l/aqq4nrL+3Kba1UGdgNzRbLHxNyZsBntb6givVbdJfo5BU3j95t
    +UQU7WjR6Go54RULzYYdNoUTzLStmDkBzIg7iAUMGGPyun7cXaJ/tB+RDeFqAMJs98sAqA
    8UTNhC/OQM/aHTCEgRGMWo/qNqW4Cm4ZpbUAGc1yB/wYZCmyUFIFjHNO+nBl6KHnpd3kh5
    kJGEMNZuUD6j2jJVpJ5tURud5waXhGOgIEZWqqHFhojd6ln7NIlrB7SgqCD/laD7h+xaRU
    I5R2WpSXAH/sDdSGVPXGsuUa9Zu1lOQJK4tOelP1k+iwmt4tCWllwcYTI4lONAt5xo76MI
    uZ9x4KzI43xEJtyuhOyf/J/QGWj8/7Ngd2otOnD2SkxwuROzkZWYzXH5yCiZNgCthKVZ4I
    +QgwLYBADSgcVsZPAcCrL1kVChscRFNeuO1GxarzyUkhRiPluOHUHJd0vSZ0DHmcx4ssQJ
    BXQCZQsK0OykZrB1BTFGrOeOkDTmnkdUOP1SX+ibISCyh8RKEEcHP2DVkIN21kJpD4TGYt
    IdpCeZ5Jv3NstDsDxwks1pjxXBogDxiXL7YwsYMVocFDdDk/I/Cf/Ra9Uw4OjIJnQGr8zR
    FqDAamx4TBkj+4Pi7989yKwLDFzi02sPSEbtpS7WtvJji0iEYHd+YhfZcibg
X-ME-Proxy: <xmx:0z2bamec5_KIsQPK5qMOW-He83wvp2wBj0JUyxIoyRFoxMXRYE5gdA>
    <xmx:1D2baq1RloWrZC2bXFRQMrX_ohuTo3sjUxfMndNUFBxCGHpkyoz4VQ>
    <xmx:1D2batjqf1HAs_keeUx5hrU2gFoX9JvBHlpBWbD4l3NkEjwINcN-Lw>
    <xmx:1D2bajkKnDgKKAkBy0i0iPvMXk09oFaScPxqx4aV0XULBP_650M6Kw>
    <xmx:1D2bas9gFRVbHe2RtUBReWULZNmPs1on-5WZGTllUHpD6-H7SjBMU3ni>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 17:53:21 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/7] VFS: fix various typos in documentation for start_creating start_removing etc
Date: Sat,  5 Sep 2026 07:48:10 +1000
Message-ID: <20260904215142.1060510-2-neilb@ownmail.net>
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
index 20a6534ea3ef..8d8d2af185f1 100644
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

base-commit: 89a312991dc6e638a36adc43ccb91dbc25504c04
-- 
2.50.0.107.gf914562f5916.dirty

