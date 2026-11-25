Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795565461;
	b=lxcrOtUv43iHS9CZ1NYWA/YP9MP2G/Y+nlZSQDHhJURyCuKJkXjGIjhTT0CWAyY/2Ldv
	 OoNzfDr8gVszirK2amY2KK+gAajV5vlqYSNHdTmhDkysZ/8XWWJF8TasCiccEXedBvfkl
	 RyMwuDByXuA26En0xQXlcN5IlcdShI1gqL1ZHkZF7cG2m1hxHItFkwPbQf/d5bpLoL9g+
	 fI5OaXyROp6ZQi35CkIhESD0qT4HRNp0xm/04Z+2/CmUqkgYcmLT1Wu5DFuCBwmtrcCwJ
	 m86mqUi8WICLkxIUDmymUUFG7aHmlEaVZaH3r4XMQ2cZX4GkTNCmSgvP7V7hTI4riyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795565461;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:Reply-To:MIME-Version:Content-Transfer-Encoding;
	bh=uioSYn87Nwu964MRdhy17kxRhlbaWB4jHTofR0aGax8=;
	b=rP9YZq+DS9/lifNP2ndR3Hy3ZRfeN7sXufulM7W+2CGR3AmeJQrT5Hk6Z0CfM4zDYB99
	 DezUAVizJrvtHzLF6xN6fFmIaLGR38pETjdiarlA4k5Rv25qUH1UD0O3d+xLXbXPnX+lb
	 0T78vw3il9iXdPEOJ3qY2SSrPODTSKXxAc5icLI6eWKQx/lVoiqolhf6GTdi430ZV0Y3o
	 /SVCA3uGtpOrGkNKNl5xOM4UfcRsCfWg4ARxEHbfeq7a/aAc5pUXet7crm2NZNlclI/wE
	 VOPhH7YL0Pv08Q5zzPW7E4wSJrreySdtnBVTGGbWCwhPV4lNxvPSWyWhmuBZp0vlbPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=Aj8+NvNO;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=t37PigzO;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49976606A33E
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 00:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49976606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=Aj8+NvNO;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=t37PigzO
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7142B1400341
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 19:11:00 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 24 Nov 2026 19:11:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1795565460;
	 x=1795651860; bh=uioSYn87Nwu964MRdhy17kxRhlbaWB4jHTofR0aGax8=; b=
	Aj8+NvNOompNykhbrQ+h+f3kK/njylV/+YVFd+uzFDOjICK1XsOafyRsSJLcJ26y
	doqtq7HVP2JH+TXcC9kBeLXwOXJsaMFswqzuyre1Xu/WcLWqygleYh0nrmSf41eF
	O9JiVnXTrugMteJAC/etJhlVdgETRuQ9Hsq21aIG4Fs/LANmruOdp17ttvfg48nE
	YyXIJPP4PcPqhXgKbkNsM7H74HruOimzxoRNrKOYH/ARRFXzaPYuqvHdAd0Y+L1x
	iw5yA0YC4TIpY3Xzqz1FSs8wkBHfVhrCVe8jigm7eqzUhT3U3Duf/pf0qBNgdSfQ
	38e08prGTTTDUVysYoJguA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795565460; x=1795651860; bh=u
	ioSYn87Nwu964MRdhy17kxRhlbaWB4jHTofR0aGax8=; b=t37PigzO2mJmWBtWb
	NHF7RZYV7iOO8YOcKd0Pj4RC/Riv5BE8W6RMdX0rok4Aw8JE2bD9UmRszmHjTNp7
	tPtmnjvpAkZxMzFbrmpN1LH37zoVRYSKJ5cnhUHkvS/bUXT5tmSLvuCnGE0u3L8N
	6AIAfWdwyED4VZx/jg7eIByuzYf72U7g/bgbti0/R0mFrTphqPF4lFcPzdL+vJWh
	3xafA5aRx+/o38fXSVGUMAIZgXoIpCjas0rFNRuG5eI0cYsx93cqTZZCEav5EUs5
	KtqQ2RBzJRQUjz3faHr6IQbAqBUcf2T4TeZkX86K3mFhsuBzkPloMSkcpRIzRSuc
	UZBbw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795565460; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:h68vdbixlN08c0AjqnjVIVgDJa6YbgLN4KKY+UG68PsKJxg
	fHNrYxp1jUeJQQPD8GWJvYicImKd6kxqdjaBx8J6RUFV8w9bbOw6rCEdOjKr0zXB
	byl2fzsNvgfg+XpllJkw+9ZgpS9XUg2NQ0zXeJNNkMsSicWTdtJM3vZCaqfHYr3L
	KRvIeTLnr296eVYKN6VjJl5SnEHcR32/AkKrFakWCMwmrYZtO21vPHRA/PB8UFYu
	DAAqO4YMQrykX/68JriV7S7jR3RdjErDXcrZOcSudidOQQtItLiOtwU1/mmp9E50
	ElQdAo2yodVgDZPZ812xBg9uf99TcxrvvUzLVGA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:CrhfUEZGKUUWytQVoo24ghuDvGQdq/GibXNfq/pP7yc=:X7ukKsjJIXFMuI91IoiiiZnSkK0ICIzo6l15py9eUig=;
X-ME-Sender: <xms:lCcGay5iY4ZkmRIhy_84m3CnH_lk7hEF9fxv582H_ckCsDZ6w58mPQ>
    <xme:lCcGa4z2C3AHb583tdjHvLUgJpZ277i299eLw-DfRoTJewHujvWE08xsCTCLmh4G3
    d-fTTzH7aoyaBlFYbKySvSDhTPqeK4iaLqqFz0-Ks04jK7TG70>
X-ME-Received: <xmr:lCcGaxN3NjNXhFg9THya4mqOu7e44bmSfimD5XknrCSnnLo9015Bx57PpbzuQRx4DnirkttcX8gSY3pYVepjs1bDkA38RwY>
X-ME-Proxy-Cause: dmFkZTFtvvtjo3TiqnwievywHT6UMcqs4LNW0jtUBl4WBqV/m7gd8GJpLHqrSgN8SWLSUZ
    VJzM9Mehgr8GzWto4KXYhuPfb2KYnCUl5uLncNNiprl4L2/H+RTJ/fuYTB9lhxGbbLKMYD
    M/6CxXIb3E/XyzdymtH1FBzd5e8L2Po01VMPRPLL5C3Io0AwFZ8dbU3XydszypkkZokBqR
    /jGhZrNqXiUxGkRCo3/x2DTJGeMaThLWGacM5+cfNvEWgcAm40zlBt5kA6JjfFB6gF3nMg
    YcWsKjzsifnV88vQpUOFazoiPMwVgCfmSGKauqcf58vaHaqH0uQcfMVcybu2xlmAKlOrrd
    c8oiC6QV+0dihQEaZZo8hG0Y/Wu8Yab8LwE3qWIGPB21bA+NY2hF7lUDocczSlMZwzzlvQ
    nJnMkXCrjkgqg+Eci0FT79RYIg6g9I7ypUYFU77NdZMdlmbkre9MWu2GK5TnLQ7sqH8m6J
    SSdXxk8qUjSlzkPMwaOmFLTSF7BH4ha+GDHm97kgfTI4CcM70Gn5dDzA3a8G/aEBaHmbo+
    SuYTLUwOiMYWA8cgStRCMQ0Tykv8z+IefprrESIT+SONtMfppZNbWCgrY3HUNYYHQg01JZ
    dLs0qA7eBo2NqpzyrDghgFqO8AnDdtKIV35TY6PM86mV4ck5p/J6oARm7Qfg
X-ME-Proxy: <xmx:lCcGa-n0L36YFDOQckVsr3tds2ePcQaOZc84pD9XG6uZ3EOdoi7ECA>
    <xmx:lCcGa2RT4rZ56HQ-5LFIPMWv2DxOB9xTZ6SKfk_Hi2dEvakUT87FgA>
    <xmx:lCcGa9VVgJakMEAJSLPBlICowceiDeyZvNJ_cCyABO1OAwxf6I7ZYA>
    <xmx:lCcGa6LQ6a8uiJGeB0s8xxWtPMnYVLIe9YBQ8FJsHaFdm59k8ehZEg>
    <xmx:lCcGayusiZpw-w9gJefXEjY11gmUo7qanN7oC01VGE6-rHO6HbMm6qyE>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 19:10:57 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Kent <raven@themaw.net>,
	Jake Edge <jake@lwn.net>
Subject: [PATCH v7 2/5] fsnotify: update children flags only when parent starts watching children
Date: Wed, 25 Nov 2026 11:03:39 +1100
Message-ID: <20261125000836.3984402-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261125000836.3984402-1-neilb@ownmail.net>
References: <20261125000836.3984402-1-neilb@ownmail.net>
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
caller has committed to doing so.

Also avoid the update children walk with mark spinlock held.  This was
only done by dnotify and can be easily avoided.

Note there is still a race that this patch does not attempt to address.
If some other caller has committed to updating PARENT_WATCHED, it may
not complete that task until after this thread returns to user-space, so
some notifications might be missed.  Before this patch, PARENT_WATCHED
might not get set at all in the case of a race.  With this patch it
will be set, but possibly not before a syscall completes.

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

