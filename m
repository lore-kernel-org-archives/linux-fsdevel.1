Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795472074;
	b=KtCDxL9uLPVUMsAPygBMMUg2GzJi42HKf8Y1PXo5ofFKnWO6BnjzrM+xeuXV0WN5OPu8
	 42120ydRv33YNlOSlqMRgvnzM74GEvta9aHXG+9FUmoJQd11Gt7xdUjRRO7oaKK8aVoZm
	 O5Sge5/X8WTa/dgcRxbtJtfZ7s79b399VXYY99mQfhBcULCaY6o6/GatzSZEhfz4kVVG+
	 ihNl9bnBN+6b0Kc9o7cmn2XbETokDi3lG+3puEYc8iPDfGFRboulgBb4xeWXuJXt0FVu6
	 6h5PvMQgPxUqrYxhGJQS6vG8Au1dmo/bK8nGq3ZN4UCbq3ziV4UtqdeNCVc2uOicCMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472074;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:Reply-To:MIME-Version:Content-Transfer-Encoding;
	bh=42om6Y70rQcnt3ze48xL9o2Gjr086Mu5+0uRk0+C9Rc=;
	b=vYc48UAqlDawGvbFCyHxZDSPV8IGgXl/t/6ykAb7DgejsnD1NfspRD/7VNlYHoL7mHrD
	 s6FBIaMnRYu0RleM4eB2A8bw1PDqtJcdE8CEOKFRr/iQ4raakwsBEKL0fHP7BHBsE5zv5
	 dzo1xdZYC2GN6E/TJS10TMrbIAi7lTEAEHVsjEUNsehsXiqJVXBd9Vm7BZUnvH1qGSAxC
	 IdVU3lVL8s0DWsMaZcz7AXY2jBRYscpDLrZyUdY2kUkUtZbkKYtE4AI3iLlGmJpCLy0On
	 i8c5d8oDVIVB7Z62BCCh9cX+zoulLn54m+Xku+V7yy/Ze+iaXiqt9+Vw5ZZuULARsrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=VsYKmgpl;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Q6nxBho7;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D4A606A685
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 22:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3D4A606A685
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=VsYKmgpl;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Q6nxBho7
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 187CDEC205E
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 17:14:33 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 23 Nov 2026 17:14:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1795472073;
	 x=1795558473; bh=42om6Y70rQcnt3ze48xL9o2Gjr086Mu5+0uRk0+C9Rc=; b=
	VsYKmgpl5yCQFNO0gHJrqJl9kORJdePbif2lcQUPuo4fmWbxF4UlogWOy90tsnt/
	L13sh28QefyaUsUk/3b9oUc0HBX3D/wW3x+jRwgKkEeE47/eOyj525nFgy8hd0NQ
	TGcr08qCjhSb01UdaOjcb0mq6d+mahpjmJcObzD/LWiA7akpsh8cPfcGxgtkd04T
	PHcgA79hULz2IVLqJXqsDmsUUfRq6hAweLhsm2nreBtZAfrGBN/rDUaC1zK5xguF
	0kAo45/BSSpYYSjFXGhDIAoMwdr9M6EPpxgaIbAP9MCddvid3cOVSdSZfEuS1tNx
	NoVUPLiMpnrkHA98rRgAfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795472073; x=1795558473; bh=4
	2om6Y70rQcnt3ze48xL9o2Gjr086Mu5+0uRk0+C9Rc=; b=Q6nxBho7p9CZ22Rv4
	CHedHTDirxRKfYECdNkkfGQjstT8jVnT395Dc+GkHIu/XU69+zuxgWBAmH/e4Nmy
	A/d8fkoEEzHJu7M1Pq1uZdrilHNrKHPHFCE7kikXQYee1OwFGqPfvMmN/XrIULT+
	ENFU7TbICB5Moem5OfwopTCd3tKF4QyoVZCY2mxorFHT6AYOfQK7gt8U7M8CnP0A
	JCSkDAlD33Xmonmrz5/mxAf2EJZMsmZW5eg+WbziBt5/x5PnostiLoY/5hGg+U+p
	RoyLHgI3eKp4cjl2pfARbgvCWZLacKABMYrcpYmo3facCER8w5wNnn7wuBx7VIDz
	gj2qg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795472073; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:X1vNUFOnJUPtiq4NzkLzpVLl3vqlrByHMOFx0MYgRbfiTRw
	U35ecZJYz9GkkKmAFWI3nPZSsDgqg8HtlqLhKZSA0gFkh79ZFIaKl5ezOAiQ3/Il
	TWSJYStAdySop5Hwah75AW9QCGMVDwFCjNIsYh5F/dMlHaJ33eeNss2PW8RIP95Q
	uj6ZHHz5N2sqrnRffMYyWM6JxJ9Uxyy3gdhJ+AXddNX6w2vzImR2QMm1bM8Wd9Nf
	BbwS0ODMrNUT1M5em6OnnAHcR2gRpJ5QlHREVSiOKuaORAqq+xKZTpGmb8Rc8Bm4
	aPAbWvC7jKH7b2TuHh2PzlO1afcRxFt7qoh0Beg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:rVNfre0O9q7oijKz/Xq8BPk+CvhWzhwNKkfIWIjFH7c=:7oKgIYDOUhFNjrHZ3iJYa5XQ9yyWBMmY4pGX9LfnjQY=;
X-ME-Sender: <xms:yLoEa1wxaikFFUCXt_sJF1qQKAUM-MhkTtpcilNJvS7OyFR8n9gsdg>
    <xme:yLoEa32ME4ZebYWZ6fxxL5fnHUSS4nzH3HBXeqsdLpUOp84fdaQ9cLiCx5ie6ZUNA
    sbBdXcMjKUNQ4gidYeBsnA252Srsjq62Nk2miRI5JTimgL2-wF4>
X-ME-Received: <xmr:yLoEay_05BYWcjnd5GK1yWe0KI49EmB6asj3xDm95S-JlwdD7SUIpppE0_-Uqxpqmw5-Xzvw3sy03URv3WvTdBgWmXCE93w>
X-ME-Proxy-Cause: dmFkZTGttFfPwKsmFjKQRzL9pxFUG6QuC0CVDfqpysvgThy8eJxKJL7hWOg3EE86ufAGZQ
    6nnc8U4KhBAHlFOJnKSjCF/WIuMaZFNPa8szZixMnsFylovzrjHp3WhRptClIGFtdpoJKl
    xhgu0M+oVCmLMh6tXx/ugYpmDN1p4mPZw6qI8Qjq9VVjVX+lE8HNkhOv7c9eZLA92DNNsS
    16z3Qo61bIoVUtIj/KYV5uWb/+6EgCVZzfYa0XmhF3ERxddT9CRxrU/B4Gwf3E6u3P848m
    igz4DPi2oe6J9lrl7/rIxlmyDAycZB8s+s7uRN3a1dT1eAkapzcFhk8X/l/XTTpJNFZcrb
    tuu2kOcCpA+d0OUf2dF2Bxm9CXs7d8Z7QdKDQOPvteeCevc+WXyTYfR8n1EkdiPxlU4bnw
    PktH/WuYKifOevcYF/O2zrAkmMsutTXbCglhZ90ry+0ZsWRZIWKJzRrM4LcCqg60qQZE/c
    xOmIFOjdMFIvhga8svAVXFGdrzvMXhvfCItE6r9BtmJviCB0l/I1Ze9XQnCVusJAAm64tX
    dzBffMRIOppC+76xZ7wyyRTHY7x3uEOQNaECgGKF2oJTa7gHBXhZFY7mcc0G6pUpLNVxoi
    obodw34mfEp5/nNPk5bF8dAtSNNGN9S5Dd9+gETBhmkxCsEuPNU4HZURetpg
X-ME-Proxy: <xmx:yLoEa3rnvl3G69DZK8_STxucvpTIHSqANwkIq93UUdHfNIVo9NvZ8A>
    <xmx:yLoEa8RaOCBZG2J15RVo52p3BonPrmos41tHS9K0AOhdg8irL5woDQ>
    <xmx:yLoEa6Nz3A9or9A2AGH6kdCuFYTnunMS-_BPsjw2Wqu7OjLaweQ-ZA>
    <xmx:yLoEa6iqDI573LPGr8ISi9kprjDSWzn74rat4ZIwWUvkDrvIYEaW6g>
    <xmx:yboEa0DA5Xf_d1T5O3xFqcO7A3dt9QBXSEtvMjnlaZlrQcxuquSDK_7H>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 17:14:30 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Kent <raven@themaw.net>,
	Jake Edge <jake@lwn.net>
Subject: [PATCH v6 2/5] fsnotify: update children flags only when parent starts watching children
Date: Tue, 24 Nov 2026 09:12:39 +1100
Message-ID: <20261123221410.3328780-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261123221410.3328780-1-neilb@ownmail.net>
References: <20261123221410.3328780-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

We only need to set the PARENT_WATCHED flag on children when the parent
inode starts watching children.  When the parent stops watching, false
positive PARENT_WATCHED flags are cleared lazily in __fsnotify_parent().

The recalc that observes the parent starting to watch children is not
necessarily the recalc of the mark that added the watch.  It may be the
recalc of a concurrent remover in another group, or a recalc in a context
that cannot walk the children, such as dnotify event handling.

Record the need to update children flags in a connector flag when the
recalc observes the transition and let callers that are allowed to walk
the children consume the flag via fsnotify_conn_set_children_dentry_flags()
after mask recalc.  This way, the caller that added the watch is
guaranteed to either update the children flags or find that another
caller has already done so.

Also avoid the update children walk with mark spinlock held.  This was
only done by dnotify and can be easily avoided.

Fixes: 172e422ffea20 ("fsnotify: clear PARENT_WATCHED flags lazily")
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/notify/dnotify/dnotify.c        |  6 +++
 fs/notify/fanotify/fanotify_user.c |  4 +-
 fs/notify/inotify/inotify_user.c   |  2 +-
 fs/notify/mark.c                   | 86 +++++++++++++++++++++---------
 include/linux/fsnotify_backend.h   |  6 +++
 5 files changed, 77 insertions(+), 27 deletions(-)

diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
index 9fb73bafd41d..0afd2b039333 100644
--- a/fs/notify/dnotify/dnotify.c
+++ b/fs/notify/dnotify/dnotify.c
@@ -181,6 +181,11 @@ void dnotify_flush(struct file *filp, fl_owner_t id)
 	}
 
 	spin_unlock(&fsn_mark->lock);
+	/*
+	 * We only remove mask bits here, but our recalc may be the first to
+	 * observe another group starting to watch children.
+	 */
+	fsnotify_conn_set_children_dentry_flags(fsn_mark->connector);
 
 	/* nothing else could have found us thanks to the dnotify_groups
 	   mark_mutex */
@@ -380,6 +385,7 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned int arg)
 	dnotify_recalc_inode_mask(fsn_mark);
 out:
 	spin_unlock(&fsn_mark->lock);
+	fsnotify_conn_set_children_dentry_flags(fsn_mark->connector);
 
 	if (destroy)
 		fsnotify_detach_mark(fsn_mark);
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 63c9759fc3b0..c064b0070c51 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1264,7 +1264,7 @@ static int fanotify_remove_mark(struct fsnotify_group *group,
 	removed = fanotify_mark_remove_from_mask(fsn_mark, mask, flags,
 						 umask, &destroy_mark);
 	if (removed & fsnotify_conn_mask(fsn_mark->connector))
-		fsnotify_recalc_mask(fsn_mark->connector);
+		fsnotify_recalc_mask_and_update_children(fsn_mark->connector);
 	if (destroy_mark)
 		fsnotify_detach_mark(fsn_mark);
 	fsnotify_group_unlock(group);
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
index cb07f42d3422..1658fbef61df 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -238,21 +238,37 @@ static struct inode *fsnotify_update_iref(struct fsnotify_mark_connector *conn,
 	return inode;
 }
 
+static bool fsnotify_conn_watches_children(
+					struct fsnotify_mark_connector *conn)
+{
+	if (conn->type != FSNOTIFY_OBJ_TYPE_INODE)
+		return false;
+
+	return fsnotify_inode_watches_children(fsnotify_conn_inode(conn));
+}
+
 /*
  * Calculate mask of events for a list of marks.
  *
+ * If the connector started watching children, flag it so that the next call
+ * to fsnotify_conn_set_children_dentry_flags() updates the children dentry
+ * flags.  The caller that observes the transition may not be allowed to walk
+ * the children, so the update may be done by another caller.
+ *
  * Return true if any of the attached marks want to hold an inode reference.
  */
 static bool __fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 {
 	u32 new_mask = 0;
 	bool want_iref = false;
+	bool watched_children;
 	struct fsnotify_mark *mark;
 
 	assert_spin_locked(&conn->lock);
 	/* We can get detached connector here when inode is getting unlinked. */
 	if (!fsnotify_valid_obj_type(conn->type))
 		return NULL;
+	watched_children = fsnotify_conn_watches_children(conn);
 	hlist_for_each_entry(mark, &conn->list, obj_list) {
 		if (!(mark->flags & FSNOTIFY_MARK_FLAG_ATTACHED))
 			continue;
@@ -267,6 +283,13 @@ static bool __fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 	 */
 	WRITE_ONCE(*fsnotify_conn_mask_p(conn), new_mask);
 
+	if (fsnotify_conn_watches_children(conn) != watched_children) {
+		if (watched_children)
+			conn->flags &= ~FSNOTIFY_CONN_FLAG_UPDATE_CHILDREN;
+		else
+			conn->flags |= FSNOTIFY_CONN_FLAG_UPDATE_CHILDREN;
+	}
+
 	return want_iref;
 }
 
@@ -298,22 +321,30 @@ static void *fsnotify_recalc_mask_clear_iref(struct fsnotify_mark_connector *con
 	return fsnotify_update_iref(conn, want_iref);
 }
 
-static bool fsnotify_conn_watches_children(
+/*
+ * Update children dentry PARENT_WATCHED flags if the connector started
+ * watching children since the last update.  When parent stops watching, we
+ * clear false positive PARENT_WATCHED flags lazily in __fsnotify_parent().
+ *
+ * The caller must make sure connector and connector->obj cannot disappear
+ * under us.  This is achieved by holding mark->group->mark_mutex for a
+ * mark on this list.  mark->lock must not be held by the caller.
+ */
+void fsnotify_conn_set_children_dentry_flags(
 					struct fsnotify_mark_connector *conn)
 {
-	if (conn->type != FSNOTIFY_OBJ_TYPE_INODE)
-		return false;
-
-	return fsnotify_inode_watches_children(fsnotify_conn_inode(conn));
-}
+	bool update_children;
 
-static void fsnotify_conn_set_children_dentry_flags(
-					struct fsnotify_mark_connector *conn)
-{
-	if (conn->type != FSNOTIFY_OBJ_TYPE_INODE)
+	if (!conn || conn->type != FSNOTIFY_OBJ_TYPE_INODE)
 		return;
 
-	fsnotify_set_children_dentry_flags(fsnotify_conn_inode(conn));
+	spin_lock(&conn->lock);
+	update_children = conn->flags & FSNOTIFY_CONN_FLAG_UPDATE_CHILDREN;
+	conn->flags &= ~FSNOTIFY_CONN_FLAG_UPDATE_CHILDREN;
+	spin_unlock(&conn->lock);
+
+	if (update_children)
+		fsnotify_set_children_dentry_flags(fsnotify_conn_inode(conn));
 }
 
 /*
@@ -321,26 +352,33 @@ static void fsnotify_conn_set_children_dentry_flags(
  * connector and connector->obj cannot disappear under us.  Callers achieve
  * this by holding a mark->lock or mark->group->mark_mutex for a mark on this
  * list.
+ *
+ * Callers that may sleep should use fsnotify_recalc_mask_and_update_children()
+ * or call fsnotify_conn_set_children_dentry_flags() after dropping mark->lock.
  */
 void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 {
-	bool update_children;
-
 	if (!conn)
 		return;
 
 	spin_lock(&conn->lock);
-	update_children = !fsnotify_conn_watches_children(conn);
 	fsnotify_recalc_mask_set_iref(conn);
-	update_children &= fsnotify_conn_watches_children(conn);
 	spin_unlock(&conn->lock);
-	/*
-	 * Set children's PARENT_WATCHED flags only if parent started watching.
-	 * When parent stops watching, we clear false positive PARENT_WATCHED
-	 * flags lazily in __fsnotify_parent().
-	 */
-	if (update_children)
-		fsnotify_conn_set_children_dentry_flags(conn);
+}
+
+/*
+ * Recalculate mask and update children dentry PARENT_WATCHED flags if the
+ * connector started watching children.
+ *
+ * The caller must make sure connector and connector->obj cannot disappear
+ * under us.  This is achieved by holding mark->group->mark_mutex for a
+ * mark on this list.  mark->lock must not be held by the caller.
+ */
+void fsnotify_recalc_mask_and_update_children(
+					struct fsnotify_mark_connector *conn)
+{
+	fsnotify_recalc_mask(conn);
+	fsnotify_conn_set_children_dentry_flags(conn);
 }
 
 /**
@@ -368,7 +406,7 @@ void fsnotify_modify_mark_mask(struct fsnotify_mark *mark, u32 set, u32 clear)
 	spin_unlock(&mark->lock);
 
 	if (recalc)
-		fsnotify_recalc_mask(mark->connector);
+		fsnotify_recalc_mask_and_update_children(mark->connector);
 }
 EXPORT_SYMBOL_GPL(fsnotify_modify_mark_mask);
 
@@ -1007,7 +1045,7 @@ int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
 	if (ret)
 		goto err;
 
-	fsnotify_recalc_mask(mark->connector);
+	fsnotify_recalc_mask_and_update_children(mark->connector);
 
 	return ret;
 err:
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index faf21564380d..052d8674ad89 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -567,6 +567,7 @@ struct fsnotify_mark_connector {
 #define FSNOTIFY_CONN_FLAG_IS_WATCHED	0x01
 #define FSNOTIFY_CONN_FLAG_HAS_IREF	0x02
 #define FSNOTIFY_CONN_FLAG_DESTROYING	0x04
+#define FSNOTIFY_CONN_FLAG_UPDATE_CHILDREN	0x08
 	unsigned short flags;	/* flags [lock] */
 	union {
 		/* Object pointer [lock] */
@@ -888,6 +889,11 @@ static inline __u32 fsnotify_calc_mask(struct fsnotify_mark *mark)
 extern __u32 fsnotify_conn_mask(struct fsnotify_mark_connector *conn);
 /* Calculate mask of events for a list of marks */
 extern void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn);
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

