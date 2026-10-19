Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5BA17A305
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 00:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792368519; cv=none; b=J7wY3iKITc2ZlEL6csCkBITi19Akg2tj2Ar8bEAxS5p9wq6bfkH2mP+dAR0bJvk7bF/a5N17fEMz1Yd0TbGmb9h7aceMaO27GzzpEGTybDc0eJy5n1I63/LFBls3iS80QvngG1oze1dm9+xcfuO0O/UO24CILoHzrftrFVyjxCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792368519; c=relaxed/simple;
	bh=YA0lVy2Wmoo+h4IKtR0QnmO1zKn3rDlTMOuZa0s4bLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HOfoLaykzzaeBjMDV6TcdLwpzwc8DdK56pf9+eogjtlsmtjh5GJ9yeSkK/cs+kzWwEbIHmo04s7fnHQruV6zW6tjLoBu5S53MVmSuX8Ee1Hrz4RSANkmxHWbuQlOXgTGUUK9gdvuzmd086iFRyzYTwmifinn8lHtIg7HfY4IXAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=PNoSeUem; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z5Z9jGeb; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="PNoSeUem";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z5Z9jGeb"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 716EA7A0198
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 20:08:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 18 Oct 2026 20:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1792368516;
	 x=1792454916; bh=WbMapodgp6cAyGwmo2tuLQfqAry1Kp5GFDb1fMYZdHg=; b=
	PNoSeUemniarT+QKIz0uD5Egk0+e03oVaXflZh3fU7pVqAKswRfh+OEW8zLXqkpy
	4EXQ2uNh8ZBobJOt0sP08Ok4nEBEikgL4UxjAPqEcbIw9NAwDLSRhSWxXoVEfQT3
	9eA4vAQcMlpQskWZiTN2wy0vIzienLekyzY9aVzL5uKE2phCQP5S3T6Zxi9yutYe
	CnrVJ3NuvERohQglnY4k9hL6Ct9Ai7IRk2gzkGcVwx2E8xJwHQBjL4EiHr5Di/71
	zIhqMlF9sYeuURoq4kB+aKYQA2P0NrxyFAjHud0XnJTWC8AzFA3ucMsilZE2l+vT
	Jg9Gqbm08Ld/NfcmFY8tOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1792368516; x=1792454916; bh=W
	bMapodgp6cAyGwmo2tuLQfqAry1Kp5GFDb1fMYZdHg=; b=Z5Z9jGebW1k08H1/j
	gzpouhMZSA9s0xexzmMOZWboVTY3IDty1qBU8zgjKABKxn2ioxSKsMT15je/raNX
	vy6oKoDMhiBGbG5+1WM6aTh46jWD/G0bZcZUreszMZILts1mgHuMj/3Ei3wkifeQ
	xbdwYnOuX4T/M3OtTCuqVw/oSUyE9JAsPGqu7ihZWFVKWEHC9SHNpFxTRo0/etIx
	1IR5PNSWjPLFS+r0IOcneMUu/Xji0qVs2a6ja617e8DXZzYseLejmuSc+lfSe4kG
	qOu5diXbYzBwywxHTgS6IhYXcknb8Fn9Fenvi1gie8CuS4QR/vOWejkh7p1maZW7
	Un/5w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792368516; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:IYL766fWX3MRZJiE7Mdu8oqlH1SH3M9gR7ypMO42+8HvYN/
	I1cF+eheh9SesIiFat89Bd/G4TPRNWSfi5lRbhKahuH9AvFsWgRf8Zij1V+/qzFq
	KOR2g94F7+8Ckv8IpwwKmSshgef0sAdszGm122lvC1+Y5gpgG66d6R0+4R9ASScy
	yyBJ+V7fD3u0xl50JfVFj72EcMzfX6bP05b69Vis0zO690vSuPfBP4IVWH/nrz5y
	JY1T0Xdfu8NN0Jnqv8mNTNaO6u9eAbgoSnZwnAc1qu4OW+VZEc8nFZkGGAv/ccgq
	0GciquFQ6Dy+alA4Hui+sU/PnMzA4LRcHEk5NJw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:LSxF9vtGxI4SHViK7gsbUgKDrU7yCCZ1peVujC4yL9g=:YA0lVy2Wmoo+h4IKtR0QnmO1zKn3rDlTMOuZa0s4bLY=;
X-ME-Sender: <xms:hF_VanVO5ePzRImtRUv1Ij0ID0GXie49OFaYDkuUw8tAcN_mSbgE-g>
    <xme:hF_VaiJmrwlVt503bhykl-ut429Sb3SraG13o4neG5fOaQHybX4TN4Lsb8Eq-NqQi
    SRgrf4fGOuHhklRgD2nfZqaEHpeqO7XVjvybYkvNgnhGSgOXQ>
X-ME-Received: <xmr:hF_VanDd5t9JueleCorGiIIgDAlvdf_4mlJ2NP4TZTSqOqmv8SOVzekyUiQpdqc5Shqe0MT01ldZ--pC1c6g6yTLlXPMnA8>
X-ME-Proxy-Cause: dmFkZTGUH5LWBgILhWIyU/HBx3vd6lrUU4CI0St4YxZUHZyuLcSJHqfYf6ZDNS6oVUJvk6
    Z22Pz1ASWvcG0/qhvDaOdj6vlpYelQ5OxFwAlH3TEbhpwOHAxMLf0pAXf8LdwumasxuFj5
    6Zy7z5tyqurgWPnB7lT0tCDnb4G+bBwptV7YaCWVDW5QvCubGReIGdgEZ03HnRHUHeR8zx
    3yxwOfJniw2BlQkOJt967hJcnQ4cVWY9KZd+yLi496N6HnabCG8B9wYIBs9L/YO5n8I5si
    RPV3ygAa+zjbhmTS31u8ojgnX42RAnmVteH6V+s4ZIzbTXDffrgkjTDfGEi0puzO9cTYKo
    QECG/OHpWP6U38uMdxPRNklNgDS/gMXQ7qdDrxDg0h26X7s4JpAATp50qcgHLHaLtnLwRF
    8DZOCyZrhUgJnVuDEh4tTQmSa673I6sOwN8/Iw0rxTDRbHPg4/UQ/FAsFuHMFLGV5Y2s27
    4G9g2GyOW0dFnvDT/IBCCQuICqCKY8f1210oBj8WVFgXSqh8So8/HZ5DtDyHHLG+mQZG4g
    9vdrFMsxIfE7k3tYsN2MCsfCcpg3hMGcVQy1GIgRKgLeUa5D/pRBT2QM4wbj6lFdPlmJxs
    SnYcW3MFUsrGd24c2T5Udyu+BjyDuEsVpExzJ962rZNbtxuZwGCnf22cpqYA
X-ME-Proxy: <xmx:hF_VaieeCxE0dICoeVhfmPZR09ujT6Z3fJrWbA1snXbsJtCIbDqq1g>
    <xmx:hF_Vam2QfdEG1nnGpNlNILnjceySbJ35uaWG_iH0-J84G7hEHuJNvg>
    <xmx:hF_VapgiVr4jL0mqCO4VxwZ21Td3k1JivCMe-5a5lhsTRrttqFdrCw>
    <xmx:hF_VavlG6OrMYgNGO7F3Iylwl9n_uhN2Zr_m6EJLc6CnMVsJPs0SnQ>
    <xmx:hF_VaoH7i0q4yScWNQ7z9dLrsVmOZhuaEygb1yqd8aA0y8GYHXzhPRHl>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 Oct 2026 20:08:34 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Kent <raven@themaw.net>,
	Jake Edge <jake@lwn.net>
Subject: [PATCH v4 2/5] fsnotify: update children flags only when adding mask bits
Date: Mon, 19 Oct 2026 11:00:40 +1100
Message-ID: <20261019000810.1837917-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261019000810.1837917-1-neilb@ownmail.net>
References: <20261019000810.1837917-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

Since we only ever set the PARENT_WATCHED flag from
fsnotify_recalc_mask(), there is never a need to update children flags
when removing mark mask bits only when adding them.

Add a helper fsnotify_recalc_mask_and_update_children() to be called
in cases where updating children flags may be needed (i.e. add mark).

Also avoid update children walk with mark spinlock held.
This was only done by dnotify and can be easily avoided.

neilb: added update_children flag in fcntl_dirnotify() so we only
  do the update when needed.

Fixes: 172e422ffea20 ("fsnotify: clear PARENT_WATCHED flags lazily")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/notify/dnotify/dnotify.c        | 12 ++++++---
 fs/notify/fanotify/fanotify_user.c |  2 +-
 fs/notify/inotify/inotify_user.c   |  2 +-
 fs/notify/mark.c                   | 40 +++++++++++++++++++++---------
 include/linux/fsnotify_backend.h   |  7 +++++-
 5 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
index 9fb73bafd41d..ccd93928ea86 100644
--- a/fs/notify/dnotify/dnotify.c
+++ b/fs/notify/dnotify/dnotify.c
@@ -58,8 +58,9 @@ struct dnotify_mark {
  * the set of all those events.  After it updates what dnotify is interested in
  * it calls the fsnotify function so it can update the set of all events relevant
  * to this inode.
+ * Returns "true" if fsnotify_conn_set_children_dentry_flags() needs to be called.
  */
-static void dnotify_recalc_inode_mask(struct fsnotify_mark *fsn_mark)
+static bool dnotify_recalc_inode_mask(struct fsnotify_mark *fsn_mark)
 {
 	__u32 new_mask = 0;
 	struct dnotify_struct *dn;
@@ -72,10 +73,10 @@ static void dnotify_recalc_inode_mask(struct fsnotify_mark *fsn_mark)
 	for (dn = dn_mark->dn; dn != NULL; dn = dn->dn_next)
 		new_mask |= (dn->dn_mask & ~FS_DN_MULTISHOT);
 	if (fsn_mark->mask == new_mask)
-		return;
+		return false;
 	fsn_mark->mask = new_mask;
 
-	fsnotify_recalc_mask(fsn_mark->connector);
+	return fsnotify_recalc_mask(fsn_mark->connector);
 }
 
 /*
@@ -265,6 +266,7 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned int arg)
 	fl_owner_t id = current->files;
 	struct file *f = NULL;
 	int destroy = 0, error = 0;
+	bool update_children = false;
 	__u32 mask;
 
 	/* we use these to tell if we need to kfree */
@@ -377,9 +379,11 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned int arg)
 	else if (error == -EEXIST)
 		error = 0;
 
-	dnotify_recalc_inode_mask(fsn_mark);
+	update_children = dnotify_recalc_inode_mask(fsn_mark);
 out:
 	spin_unlock(&fsn_mark->lock);
+	if (update_children)
+		fsnotify_conn_set_children_dentry_flags(fsn_mark->connector);
 
 	if (destroy)
 		fsnotify_detach_mark(fsn_mark);
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index a32c6634d592..d7c03d25ffe1 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1538,7 +1538,7 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 
 	recalc = fanotify_mark_add_to_mask(fsn_mark, mask, fan_flags);
 	if (recalc)
-		fsnotify_recalc_mask(fsn_mark->connector);
+		fsnotify_recalc_mask_and_update_children(fsn_mark->connector);
 
 out:
 	fsnotify_group_unlock(group);
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 5f19c24ec187..6018c2d717ac 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -562,7 +562,7 @@ static int inotify_update_existing_watch(struct fsnotify_group *group,
 	fsn_mark->flags |= inotify_arg_to_flags(arg);
 	spin_unlock(&fsn_mark->lock);
 
-	fsnotify_recalc_mask(fsn_mark->connector);
+	fsnotify_recalc_mask_and_update_children(fsn_mark->connector);
 
 	/* return the wd */
 	ret = i_mark->wd;
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index cb07f42d3422..d289843ea149 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -307,7 +307,7 @@ static bool fsnotify_conn_watches_children(
 	return fsnotify_inode_watches_children(fsnotify_conn_inode(conn));
 }
 
-static void fsnotify_conn_set_children_dentry_flags(
+void fsnotify_conn_set_children_dentry_flags(
 					struct fsnotify_mark_connector *conn)
 {
 	if (conn->type != FSNOTIFY_OBJ_TYPE_INODE)
@@ -321,25 +321,41 @@ static void fsnotify_conn_set_children_dentry_flags(
  * connector and connector->obj cannot disappear under us.  Callers achieve
  * this by holding a mark->lock or mark->group->mark_mutex for a mark on this
  * list.
+ *
+ * Returns true if the connector started watching children as a result of
+ * the mask recalculation.  Callers that may be adding watch bits should
+ * use fsnotify_recalc_mask_and_update_children() or call
+ * fsnotify_conn_set_children_dentry_flags() when safe to do so.
  */
-void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
+bool fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 {
 	bool update_children;
 
 	if (!conn)
-		return;
+		return false;
 
 	spin_lock(&conn->lock);
 	update_children = !fsnotify_conn_watches_children(conn);
 	fsnotify_recalc_mask_set_iref(conn);
 	update_children &= fsnotify_conn_watches_children(conn);
 	spin_unlock(&conn->lock);
-	/*
-	 * Set children's PARENT_WATCHED flags only if parent started watching.
-	 * When parent stops watching, we clear false positive PARENT_WATCHED
-	 * flags lazily in __fsnotify_parent().
-	 */
-	if (update_children)
+
+	return update_children;
+}
+
+/*
+ * Recalculate mask and update children dentry PARENT_WATCHED flags if the
+ * connector started watching children.  When parent stops watching, we
+ * clear false positive PARENT_WATCHED flags lazily in __fsnotify_parent().
+ *
+ * The caller must make sure connector and connector->obj cannot disappear
+ * under us.  This is achieved by holding mark->group->mark_mutex for a
+ * mark on this list.  mark->lock must not be held by the caller.
+ */
+void fsnotify_recalc_mask_and_update_children(
+					struct fsnotify_mark_connector *conn)
+{
+	if (fsnotify_recalc_mask(conn))
 		fsnotify_conn_set_children_dentry_flags(conn);
 }
 
@@ -367,8 +383,8 @@ void fsnotify_modify_mark_mask(struct fsnotify_mark *mark, u32 set, u32 clear)
 		recalc = true;
 	spin_unlock(&mark->lock);
 
-	if (recalc)
-		fsnotify_recalc_mask(mark->connector);
+	if (recalc && fsnotify_recalc_mask(mark->connector) && set)
+		fsnotify_conn_set_children_dentry_flags(mark->connector);
 }
 EXPORT_SYMBOL_GPL(fsnotify_modify_mark_mask);
 
@@ -1007,7 +1023,7 @@ int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
 	if (ret)
 		goto err;
 
-	fsnotify_recalc_mask(mark->connector);
+	fsnotify_recalc_mask_and_update_children(mark->connector);
 
 	return ret;
 err:
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index a6d5c1a89cff..e637bad698a5 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -887,7 +887,12 @@ static inline __u32 fsnotify_calc_mask(struct fsnotify_mark *mark)
 /* Get mask of events for a list of marks */
 extern __u32 fsnotify_conn_mask(struct fsnotify_mark_connector *conn);
 /* Calculate mask of events for a list of marks */
-extern void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn);
+extern bool fsnotify_recalc_mask(struct fsnotify_mark_connector *conn);
+/* Recalculate mask and update children dentry flags if needed */
+extern void fsnotify_recalc_mask_and_update_children(
+					struct fsnotify_mark_connector *conn);
+extern void fsnotify_conn_set_children_dentry_flags(
+					struct fsnotify_mark_connector *conn);
 extern void fsnotify_init_mark(struct fsnotify_mark *mark,
 			       struct fsnotify_group *group);
 /* Find mark belonging to given group in the list of marks */
-- 
2.50.0.107.gf914562f5916.dirty

