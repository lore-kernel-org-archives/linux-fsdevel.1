Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795057210;
	b=ao/13p1lYU9lZCY9F/yBnIFv/sH9K7L5jT9a7Hd5ysSuiRf/wb4WK6LioW5ruBd5SLxA
	 YaRdK91J3b5KQMlrhSiMg+yZ01v+FZ59NtgpBRi04BBLNHwAWmnNK8CuizHenxqPktZZ7
	 k7BjzCffxAxovZI5O7h5dRPO5cpq+kIr4lCd0CY/1Q/oAxCkF7WB4taWt6zjrD/6iwe3x
	 sBwEBhwWbeHt8L4cLjiwBXflZIG8qThZjsNXPcgPt0hvsxbvzEgEEneoiazNaLEnRrPkk
	 bhTbkZhIk5ORXaXM98D4GiMOZraKU2dhXts6hjEGZzWN2nlvHkCwdnlGV7YdyxBJScg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795057210;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:Reply-To:MIME-Version:Content-Transfer-Encoding;
	bh=3ZPOEu7PzpIkV5PNiAIM5sgUC1LzPERhU0nzHPmqPx4=;
	b=NXTT2eVZK+Nv38LcGcfnEPT634J2kJ2iYND7Z/EWHpEU86r1S1hwBOeih2oYSHSjedWs
	 VtwWQB0KPzwdDQawT0GZYxItxvGp3x5rzChl0kcLn4dmlVtAEYrK8rFSbTxDOECYnHm8J
	 GUZhCh+o6xuhNLsOn2F92oP4+Qi+ONjgdffG8wgvKiy/p3neTYVGvPPn0tqOhvsDm5rvN
	 //+jnMMk36DidZOG37gcydPFf3ytLPoCttG5pYpIY55Zqyh+RnxeS3q6l9lE38tHtfLdX
	 FsMGphGZtMyae1O03GmtRdaRkjl1btsMNfFri7pxa2TxZtz6sI4bQ7yioIfXZ5NxNPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=o1jD2GVB;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=OvtoCdAc;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6988D60A2605
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 03:00:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6988D60A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=o1jD2GVB;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=OvtoCdAc
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 5CD18EC0327
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 22:00:08 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 18 Nov 2026 22:00:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1795057208;
	 x=1795143608; bh=3ZPOEu7PzpIkV5PNiAIM5sgUC1LzPERhU0nzHPmqPx4=; b=
	o1jD2GVBPS+bYAf1dPBmsQj1U4k8MrTu3xmo4qZXDe6fCZleqy1uJZMiLcTOlDb5
	69hbj33zb4RUUCZgDMs7MFW4EwaUuRdhGyQwWikd8o1AYVtxG87JnuHPGyP1BQRT
	dwZ4kjOwve0d0JO2Ii5PbLbD1wnLmikNV6C92g8CFmfmTwZrSlDCDZbrC5k/7TfM
	wC1F/M1QHqueCFQGeOf0a0eU7+u2qWmgTqfhbGJplCuyaR1Wg8Mn0lnBHXPYaZuk
	hxWR5xKyw/aokggPUg9lvBIQ1tZvOTHntR4OE+zLjiUsWqfsf0e6imDiBPzR5gU+
	v5R24mPFzKmPoJRkOP789A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795057208; x=1795143608; bh=3
	ZPOEu7PzpIkV5PNiAIM5sgUC1LzPERhU0nzHPmqPx4=; b=OvtoCdAcmiEukHr/0
	Nc8cwqWkmK/FJN+nyMO9KyS7L04CfGP/m98f/G9FnXLms9j4fqi8R8tBdECyjmQH
	+8Lph6b0VVEcUrZRNAVFFLLRG2PyfSUFuB/gjXQY5lyxSRmzC4r+A399sMchJ3hM
	xzqy6kXzNN/ssmrFtKEpIfWWVSmtz/t6PIMST7hwYQ4LX9TLpQPfVhhYUS7du3OI
	f6PnhPdC6Gkk8MStI628pDVT1R6sZIIpewQSOV1kwUuZNV61xbudPiLRCMc9tOsK
	AjSx9Vb4+NWiHhsa04VKZmVB48exETFw6aw8w37vuYcpG1SaRVLw+mLk9bQm72Gl
	zDiNA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795057208; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:KdlbLBF5Q/EO279+VJaIe4QKdK5cbSCqMel8yEETCLwQQKn
	0CSL4ENB1H+zArK0U4zzmIxZzaFw+iuiY783WUXDd8i3z6JmA+cidQ6pbWoKZoES
	tH2K/Doj+k5YFWSuQviyN6PiTL5AtyiW4Gjq8EGwYmz/YkZ6xF2InYnbG8Xbk67s
	Sb6gjD/TRCbsCI50SJJVMm0avNTWPFMNPnhbXx41fojK7E+8nQdRkUKQzZvO8H5Z
	dSQf+EEX/BtuAM/aRUzSrd5XVK5CnXo4QFKt9f2OEdrgCQa8xWSM7opGhOO1g7aQ
	X1JnhiRlOt5XPYVbBew12pLfuhpOECXJ1tRmG1A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:CFfG0M5HQji1r7gK+t4KABQ+bhAEB3gMqXh5UbYoAls=:HnRh9aF3ZDaT/6Tg0fppybwgaG2rsm/WExpwYf3T+S4=;
X-ME-Sender: <xms:N2b-agGgBef1vdvZxqt7j91JpQneZpA00IsMKx4mIBp1PxG-EuL1DQ>
    <xme:N2b-ar7mxfxwPQ9HXrQczjZMqswxdmP0zasGpzBOrWVjC8IvwrvCYGoSpCmalzEsJ
    cFJe2w_YRFoF_uU9Ko4-tJI8c6_IDKqlWvHKPLGIi47omLWCw>
X-ME-Received: <xmr:N2b-atzH128-eG0qzkSJ4i3EOIA44ADtWOe5U8EiYBFJY4W2d6iXkxH0xKyKXVwE7SvXKfu_W-Qm64a47ufsL2I9J2vXIQU>
X-ME-Proxy-Cause: dmFkZTGjL0o1QOXyK9X2ADiNAj3QeShgWWOAChQ8ZuS0aezgqsh+YXIxL6ELkwPJM37GZy
    ozKdIZncc0vfLq9yKLiTOVMC6qEkJx0MX3h2outDKO4iqI5zyLzd0SiFSrPzCa5cU8n/f/
    4tV5d7/VMQu+ZNiUrHBqG4a2WVJWvSjqriegRqA/48q5+YgIq4aCaxzU2ZB+dEnbAhFdkc
    Z8kC71J5QFlep0kz9dWFvPcrad0j4sgxrJSoHkDHfSLtmVogYWJWy0BqeoeSDXx4B2hGyh
    nzqpj+QZ1w3Yzvu9j/tKPC7aofbiqs0S+W71RvWrNsE8pxTPndIBhgzFnOP+TBU1pIj7OC
    UKicJS4CAMmOrIeS7Aew9ME5m4X01Wkz2aeHrNF6U5o3ok+j7/5LxXAlGuITujXsNUqSVD
    r2+W9lOh2sslQd1jFDl8Vd0wgT6kz7dD/1h+CJxde54lGiRSZ7HVHblL9qRcM7pMEoYKpC
    g9bjBEtCGSYdhIXA4N2qXekd1Ajx/NNg/y+0EmZbBHOIglp21tM1RiZPEbipxsYgaVjzZ4
    td6lGoFC6QE+0lUkwe+0fI0m/AoLtBbkemChJK4U+DG/PqzzlBtyELd+6kRlTqUJlaF2l2
    ZH4W88q7YN8UFF44oNhWhpWh5OUQGsGcajlN8vsZxk7euvA94yhmWeZ5dlbQ
X-ME-Proxy: <xmx:N2b-aiN2zJAuBBMaNTO46JWXkY8qzGZDFa_t_mI8N_r4lWMAkwsLrQ>
    <xmx:N2b-arnu9RyM3VnPnTbGOjd48DAtwvoLcnuVQ1UNs_27pgWt7EST-Q>
    <xmx:N2b-avSQXtumd5d0zkM6B-Se8-Y13KNCxIN1E7AlwJRq2-kzNcmV6A>
    <xmx:N2b-aiXsdV-p2jVTy5fFB3A2TO4hRIWQ40nA3YWDcnQ49f0w7yX8qg>
    <xmx:OGb-au19ReLc7S01G2DdUk5jEnGJbYgN1TkxbuAw7Oea5bRUDH-jul9->
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 22:00:04 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Kent <raven@themaw.net>,
	Jake Edge <jake@lwn.net>
Subject: [PATCH v5 2/5] fsnotify: update children flags only when adding mask bits
Date: Thu, 19 Nov 2026 13:57:02 +1100
Message-ID: <20261119025942.2848130-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261119025942.2848130-1-neilb@ownmail.net>
References: <20261119025942.2848130-1-neilb@ownmail.net>
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
index 63c9759fc3b0..1af57a842935 100644
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
index faf21564380d..8b866308a5f8 100644
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

