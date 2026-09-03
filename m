Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A76326C3BD
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2026 03:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788405906; cv=none; b=U7OmQES93a9VdM3J/F0NFmAODc9Kd27P0u/udEd27g1C0Ri26vCO0lnJ24rmUpo99QOOXhoA2C/vOtqH8HKMqhrTdVVrbRTnYmFY2hzwpRuQIMsVr3OXJ60C6FIGJ6/4Vi7973U+YjdKvLKoOfBQq7SsYMvgbJZGHcH79T/JVFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788405906; c=relaxed/simple;
	bh=85DynhXkr+hqotCALLziTC6eMfYHwSakefI7Y+Thsvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYKKK3Q0jh2EzEpFbTCeqEu0fsVu1sq+QxjWyEdWFzVW/trQ3lJLxku9b0DQQV1AfC6IDei0jNYR8TZ2UFZ1j3SlwnZS/JchohEhuT/4crzsFVHC+S/I06x3SD+iZbdOoVuE7Suyjs7mVBB+Cqa47+SPDD3X2gATJrnJoNJyfUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=NrYLu/l0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pm/KiiQv; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="NrYLu/l0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pm/KiiQv"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 609BFEC0244;
	Wed,  2 Sep 2026 23:25:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 02 Sep 2026 23:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1788405903;
	 x=1788492303; bh=ffp/q4O+ehQP4wOXC4Hjwke9m+zN+xkUyMSMNGMBba0=; b=
	NrYLu/l0CrqICXKi3zSTuHGiNRWL6cBHCRHMjKHNAUBWKvHGNizy9N0H8teU9A9z
	Jiw5wLOC728Thonp84pmJ7ecYbLyDCjk4CqzKWd7f5q2h8DZDxnk4LmOYXXe+aJt
	h+AalG4mj50m9CZBya4/lfzw/NcmYKIHRji0JbdaRodlZxyCK4VdDT36FkifVuSs
	2j0DAX4LIWzkIGI54TkN+99jElqJIZ7pSgViyzz1C0RxpJqesLXYSLaYss/esx3W
	LSjpvwIXVebRd2CI88FejNLlfMwsmN7o7Rk/ukJeqLuJ1K4ZzXosyzdW7dW63gfW
	x4rGUrz1vLifuS3BedkHew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1788405903; x=1788492303; bh=f
	fp/q4O+ehQP4wOXC4Hjwke9m+zN+xkUyMSMNGMBba0=; b=Pm/KiiQvr4wgAGBHr
	uuVBzZnOTj0xOsaIzpgR96kMvvPsJXnCPQJFtuAN9Dt2zU8RRaByZYaXOIqQsDFz
	+b0otXu2SQ7tyCoqxt0SsktO3MKk5pC9o6O9rscyurGfYbJUYGPBIHVQBDux3fTd
	45CbELQnW8RNEi3E5vBLLOkx8BE5G57z74YhuR7F9+6ZG6hRX7wYpp0+vQoilKVV
	e7Ici+lBDgObAcvcepxV4FL0zvbVXb3FTzU04XgKI+kBsBg2q4M/bmypiImqDcBj
	IYFl5vfv/vKKwF8n3+Jsxv38uDNiUcDkhDSm7mr85lF0SAz7FcnU6KDQZFIuPUZH
	tru5w==
X-ME-Sender: <xms:j-iYandqP8AyYHyzQ0RrPoJrs4iwnnm8xB84FHO8ooxdk9jUY7nONg>
    <xme:j-iYanSeqH4XdtBIJDXCBgcz7r00SHxVAaG8APYxiq8FFiGffPZj0smV1_HqTQxxc
    w0dHnCesj785DxiVFPhqSYXXqOOHy8w2B4yqg99iV4EFutaRw>
X-ME-Received: <xmr:j-iYagYL8oopaIqskIVdGgR5UzFKeFm3gIA8DIx5_pnABl6YxfaZ7Zt8ekwXc0zdlp08w6jalAcD_CHswxvHHwjWC7AOZ_Y>
X-ME-Proxy-Cause: dmFkZTFXt6cUefGPSewwwFqdKdDzyta/nNOStoIf8ygsd3d55Ylv2azk0WUcYGr/qWGe89
    /agY7xGpogS9PXkreI4nrnEfEmH4ukRCYLCLQ3ife4R0W6dMBF5Im/9SUb/nWmHvjbtfji
    C94zMCN8ZKwE6V7UAH/g5bDmuGJ60zEKAcm0MCk2H/yiC+xmz/8AzeGfH/ZAapoxNSHcuj
    2NAwOe/HPAaVDALEsfGdSX4FygHdBou8gRiZnt7cvbj+wi4KWShvSMjFP4ENhF65bJ2jDU
    hJYERCmXGNC3cGgAODpYVa2vdRDJp2cxqVzJcwEfZ6JwMc6xSMdbQ9cS0F1GoWnjdMdMFd
    vF2/WSKIMwLpA4+HohTUOfwcuySoSI4tKQ7h8/JjDiapwlRyovY/LiE4m/xJ7vbXmVJ+Hn
    Fkp8DSBcabGz4BztcQIr8IwHsNxbyX3VHO48fwst61N+RFjISvXMeBy6HKNkD6nLzHtweW
    d9+g9MEqT52PPFypWMfCD/1on7wsuglyXfj7GjH9Jvu0wuiHXMv8Ys6TNZImhwe37NuhWd
    wb7uN8qrkH6Im0bB+XSJwrC2Ocz+kyamNfBYLVRYnCZK1g4eo1i2wQDn5n28MpJFbDwZqO
    hLkhHk+8f+tnX1bg6sGb9eqmdmAzMZulAWXamTd1KuBn2+BiQxYfKc4jeo+Q
X-ME-Proxy: <xmx:j-iYaqcQ54on7zyG8b8PDz8DbjSFXjfRE1B4YhuWdcI468eBayfUog>
    <xmx:j-iYahLf2Hx2iZMkrnChpMd9Axy4621XAOvWfKAMzFePA2V1NdHYDg>
    <xmx:j-iYanJEQrZ-R_mUribit62Vmis3vVja_Kvf3taYh2-GF14zCbbu0Q>
    <xmx:j-iYagUfDEFeP2TLcASLwbghY3yNxDy2TnA3jcgPjcxniEun8-SR6w>
    <xmx:j-iYarDB16mQJ9iqY2Eak2qIwKDcoOtVJg6JbGkU0N6SwVlMZmoKkZI6>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 23:25:00 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH v3 1/6] VFS: fix various typos in documentation for start_creating start_removing etc
Date: Thu,  3 Sep 2026 13:01:31 +1000
Message-ID: <20260903032431.142777-2-neilb@ownmail.net>
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

