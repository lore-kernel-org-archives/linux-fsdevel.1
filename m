Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ED833F8BC;
	Thu, 30 Apr 2026 03:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777518558; cv=none; b=rDMrp7KpLBN9jhE+55MLMpr2mxs3jZbYuF6SZJ5SLloIzqayvXBI8Lx0ooH5NiSpK5egiM7AKyR6FBRoU/+QvwNMjsun+immezi+dtp3MAsSbn51DOT9KWXKjpg6cSwQUHYNCbUFazwUp8kvJ97372nGU014Yar8OoXo+EPUvtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777518558; c=relaxed/simple;
	bh=DELTMxF9kP8S3D0HUlogd9b5wHyCedqPjH1ZMIOOcJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSfCKTVKiI/Y22O5PNfSFl9qh7wYAGtwQ9QWSgi8oF7xuG6XIwbmhbMZSEoCOP1zRBqTYH0iYb1HDYzMQ9WEAkrM6zjQCmwqSD36Y0FBs4rdS1MMCAK+OosPP2Wak5WKrHw84/vPaQwsFXu3bflaLMRjdO923+54XOFztyX9Cr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=mA9cLTcZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CKt9daO/; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="mA9cLTcZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CKt9daO/"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id DF81A1D00113;
	Wed, 29 Apr 2026 23:09:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 29 Apr 2026 23:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1777518555;
	 x=1777604955; bh=/9kQHGI58tF58bk2NGiFwIvwHRvIsc6zHHG5MNu+tic=; b=
	mA9cLTcZJqFExX9klI457lYJdeqyEBK/E3wY20Xvh+IIkNIh+XC01umfK5+tEbSv
	nyV7d9ObIhzaaSyEoGISPa/1Oyk/ASrYaeCD2k807/FUWfm3wqepDNHpT2LCIf2N
	NWARDOIdUV/nAe2Tk21plhFDiD67Z6XZHtr/+Gfe1N2fsxcVIOp9s+lR9ymxHKUJ
	voOhbAILlZJU5iqAviBt5WFoX9Zkfurh5Q8k1/ZBzkGn8xaStxpMB8d52yeW7nsK
	vymhh5iKBZ6EvoRIMXBhmbEZcS9UHSis+u4rl02WPtRJywsu9IYMOBuT/jTFhvoM
	LlxR3bPdTtRZnOVdxwDEtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777518555; x=1777604955; bh=/
	9kQHGI58tF58bk2NGiFwIvwHRvIsc6zHHG5MNu+tic=; b=CKt9daO/oWsYi7H40
	ldtSbGFHNsvW0tJOCVW6o+DFf8Oa8TzfmSnoQhyGpYe2daFc4vWPool6pRemtvFJ
	GHnOiPJv5OoRTEHaafTXlGZplu0di041Sg7Yo4C3/FfLOqpqQPJpWZl3VsKLANAr
	yadrmz8KLXK1nnGdjHneF5QF9HJibEj5J37ghByaOuUvhxoXYg61t61D1ufhChFV
	JRRqkksgOixsndjSxmUT3/KE4tVJYH6dWcNjGGpn5BpQvCVTH/gzkxKEYDP5TDqw
	hQPG3EsNxl5bhIZVr5p+VKR19Nm5V5nbOpYJkUPoT4EaCewzCDYSArhLs00hrMnr
	zGSYQ==
X-ME-Sender: <xms:28fyaVztvK_jYjX5vf0wxW6qrSH6mmREAsiud2dlsWjyeXlxUXv_IQ>
    <xme:28fyaX2YNVxrxabH1-kq1G8U3jAUeNEolcW-2aVpyKR4u6SqczTiOQxeRxrgmQ2RX
    aLZeQzGgQbn_DHWkqD6TtDjYjHV5ONTHO4tzOSPFB_KWDla1w>
X-ME-Received: <xmr:28fyaS8QLOp1OOMWz1Y4kgQmM8Vv_shOkshjzFM0D-uqeMlbAoRYPAciWorPAJGEWplhS1X_ZY_Z622QZgsrqE8vBoqkeUM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekiedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehtohhrvhgrlhgu
    sheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepjhhlrgihth
    honheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:28fyaXrTLQaW8JuoWlxizYASug4rkynTcVyA0VmJ7ceg5HCZpdk_hQ>
    <xmx:28fyacTWeg9b3QWPD2mcp8EhsCpTOGYEg-0CBJgk3NdVyIAnOmO75w>
    <xmx:28fyaaM_k_qi4A35tv9SWHadBJTnxIwsOyE6dsj__vEH0MlkPS9Y8A>
    <xmx:28fyaaiGKclPE6lYz3cq9_i8je1ifForyxsjrQ8q2lX_oSiTAr7GqA>
    <xmx:28fyaS4eD3ISCmGDlxbjbMgLqiubouVd3548xIXbzbu5t5EJxv1tFViv>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Apr 2026 23:09:13 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/7] VFS: fix various typos in documentation for start_creating start_removing etc
Date: Thu, 30 Apr 2026 11:56:54 +1000
Message-ID: <20260430020137.3305302-2-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260430020137.3305302-1-neilb@ownmail.net>
References: <20260430020137.3305302-1-neilb@ownmail.net>
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
index fdf074429cd3..bfdff4608028 100644
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
@@ -1371,7 +1371,7 @@ similar.
 
 ---
 
-** mandatory**
+**mandatory**
 
 lock_rename(), lock_rename_child(), unlock_rename() are no
 longer available.  Use start_renaming() or similar.
diff --git a/fs/namei.c b/fs/namei.c
index c7fac83c9a85..65e60536a6d1 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2942,8 +2942,8 @@ struct dentry *start_dirop(struct dentry *parent, struct qstr *name,
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
@@ -3260,7 +3260,7 @@ EXPORT_SYMBOL(lookup_one_unlocked);
  * the i_rwsem itself if necessary.  If a fatal signal is pending or
  * delivered, it will return %-EINTR if the lock is needed.
  *
- * Returns: A dentry, possibly negative, or
+ * Returns: A positive dentry, or
  *	   - same errors as lookup_one_unlocked() or
  *	   - ERR_PTR(-EINTR) if a fatal signal is pending.
  */
@@ -3382,7 +3382,7 @@ struct dentry *lookup_noperm_positive_unlocked(struct qstr *name,
 EXPORT_SYMBOL(lookup_noperm_positive_unlocked);
 
 /**
- * start_creating - prepare to create a given name with permission checking
+ * start_creating - prepare to access or create a given name with permission checking
  * @idmap:  idmap of the mount
  * @parent: directory in which to prepare to create the name
  * @name:   the name to be created
@@ -3414,8 +3414,8 @@ EXPORT_SYMBOL(start_creating);
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
@@ -3441,7 +3441,7 @@ EXPORT_SYMBOL(start_removing);
  * @parent: directory in which to prepare to create the name
  * @name:   the name to be created
  *
- * Locks are taken and a lookup in performed prior to creating
+ * Locks are taken and a lookup is performed prior to creating
  * an object in a directory.  Permission checking (MAY_EXEC) is performed
  * against @idmap.
  *
@@ -3470,7 +3470,7 @@ EXPORT_SYMBOL(start_creating_killable);
  * @parent: directory in which to find the name
  * @name:   the name to be removed
  *
- * Locks are taken and a lookup in performed prior to removing
+ * Locks are taken and a lookup is performed prior to removing
  * an object from a directory.  Permission checking (MAY_EXEC) is performed
  * against @idmap.
  *
@@ -3500,7 +3500,7 @@ EXPORT_SYMBOL(start_removing_killable);
  * @parent: directory in which to prepare to create the name
  * @name:   the name to be created
  *
- * Locks are taken and a lookup in performed prior to creating
+ * Locks are taken and a lookup is performed prior to creating
  * an object in a directory.
  *
  * If the name already exists, a positive dentry is returned.
@@ -3523,7 +3523,7 @@ EXPORT_SYMBOL(start_creating_noperm);
  * @parent: directory in which to find the name
  * @name:   the name to be removed
  *
- * Locks are taken and a lookup in performed prior to removing
+ * Locks are taken and a lookup is performed prior to removing
  * an object from a directory.
  *
  * If the name doesn't exist, an error is returned.
@@ -3544,11 +3544,11 @@ struct dentry *start_removing_noperm(struct dentry *parent,
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
@@ -3581,7 +3581,7 @@ EXPORT_SYMBOL(start_creating_dentry);
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

