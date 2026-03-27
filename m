Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CA43F787A
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774621872; cv=none; b=pLzZxtym923MZWDWzBvxGTqt4lbbyrz3AUgYm0+4ytj0N+KPMtKnemAdSgTcUUO6iAgUHWW/66AMtZNSPbqaWzEhx6LV9X+Atm9IVTJ91RjF2c3++yFdUy/Lq6RuvRSOtSqzQmH+fORKraf7yAaNu0Yryv2P+lskFWA4J8UfC6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774621872; c=relaxed/simple;
	bh=/ttNPNbuQ2CEZ7eM5OC3+OHXe+jaIax8k5R4iS3UIWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jS8dl5KXvN9tPmIVlzWhpC82EaUA1GxTQpM+i3pCQvIGYVFbp08tNoRTl6eMota9NYq2C6SXcF/4XjkYF80mfP8TCO16ZXeDzIUX4cXMAuH+JYlsp1pK8mI2P7ZkrzLK3UgXnLvpjMyTuJJb68wAynV0firfg+2oo3ud/EFF80s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ardZco8e; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fIHQ5vLZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ardZco8e";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fIHQ5vLZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774621870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Qrj1W4Ce5NzDY4IsgwcpP1cuY8hbH3L9WyiJQRf3TM=;
	b=ardZco8ei8QWup7cv41ENzmlOoUfnisbUFAJx5ICqdxq28lFgDdshP/jpfKA6AoiCcSMqv
	ftOISWhbd1F7B0vXXao69K6/4Ze35484Io6duEwb1x2wkNXOQ/wyp9tJfglvnXtEBJ1JNk
	H95A5TaBSFIo7EOeYq3ecuaBg6k237c=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-yY0b4SVbNwK2XZ6lvBC5jA-1; Fri, 27 Mar 2026 10:31:08 -0400
X-MC-Unique: yY0b4SVbNwK2XZ6lvBC5jA-1
X-Mimecast-MFC-AGG-ID: yY0b4SVbNwK2XZ6lvBC5jA_1774621867
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-67dece24dbcso6597194eaf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 07:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774621867; x=1775226667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Qrj1W4Ce5NzDY4IsgwcpP1cuY8hbH3L9WyiJQRf3TM=;
        b=fIHQ5vLZLQ76//+fa4rOTGVl0U775C5A92hyspywvL6Ue31I00PArev8Cu6XXi6OLW
         zoqgCeSfZgqMGLLX6kDfaTHu8KYiDCs8gATcy9c0hhIK1kT03JECeGeT0uivl5j9TOpL
         jZgf9N7xTnbSofwJraMNBqSiErS3G1jLuhmD0rYSXORfzlaAZErE6iYqu8bS71GWZpBd
         GW6LkGby5LuZrmrxUDDLduEi8NgG5Y6Dq5tW/uLsy+GmaVd21b31wRDYf0x18Nj3gLOf
         FfJqQHb6t/m8Z6Oq1SGx6p7Tf6bRIGX3JQNSs5alCGj/0GqtyBeY/29ViIDhNXd07SZ3
         90yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774621867; x=1775226667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Qrj1W4Ce5NzDY4IsgwcpP1cuY8hbH3L9WyiJQRf3TM=;
        b=UEGNREXVT3sm7uVhe2KiJcenp96AvGGlmpCHKZ26e8snXnWcTAF1jA3muFfn4HPD31
         iEtm6CG6G6ppClaSIA9Us3TTCCma7FUi6axnqPzHb4bICgjKRhReXxMImhViA5WTz6q1
         lC+D9BGBXAnqSGa3aMVJu4+kif1naetSLEfrcxLvA/AhT4fEaws3j0IpJzdkH+X9fyr7
         G3FTK0rZYN9FjsTlFIMHlUyKBxht9tO8sTQ0t5xSekNFvmhm6h/1HafE3c8DH2vNgNuH
         BbPOVHbnsYuhn/LBpmINMMmysMNrBagyNGfS6IfQyoOKWMERJs5bEErisBnzXu9VhpY2
         q8jw==
X-Forwarded-Encrypted: i=1; AJvYcCXyTOfADackQJs7rdM877KG37etx3QfxkHnqmH43DCw4exDUFHYvMtf+iVxlLaJsArE54gI9SwRRViNM6WW@vger.kernel.org
X-Gm-Message-State: AOJu0YyoIslY29QxeDTfKndEnH2jM4YawPYRx/DXETU3SuogWTTN9dw3
	BSxqTKetU5HJO6vj3NQewDJQ/ElPCy+Pd7xxLGEoAtS9gvyCQycNE2JCMHen/5FNxjB0DI4Idyl
	Xw0r6vbtXMfJ5FwPvAdDAkTW7pAijPFu2Qu2eUdNngr2Dirh3YW96hJwQ8uG6WxXzKDX0oKZmFR
	1qZw==
X-Gm-Gg: ATEYQzwQ/Lq+x/VeVEAGCKuJRCnGn1DtyKSz+vVjVP0Bavn17MCU9VvKOmtMOSv+GG+
	zJXuCp7hIVn/bvvmGA7/MF4c/uxB+HXNFPE1tNGdjxkQAqxhlt5F2+MFopMGA6FsT+OuK7llFIT
	MQlJ3qjII197ooRJT9r0MpJdfchPlFBZH4VyLVWXC8jqoyEW4+WbXT8QXIOeRWvnGWKBcA+Fb6p
	9AdgC1/n2L81GqWXD86tJK9+cZXDOI3LhHCgm++URW0xie+HOqHjitmg05enyOa85JovF3NAoLw
	i7GW2ugTmB2hKjGoaba85n16SYgCURg/APXKFXVQ2UpArHerjWXdEqsc60de2XdC+9K8QaAudZ3
	NGzTYTsSE7yZCCWemQSQCCIU+ebzXPtH2hHMirEwwbKxLcrLHhWE4N8E=
X-Received: by 2002:a4a:e90e:0:b0:67e:eb4:238f with SMTP id 006d021491bc7-67e186156ebmr1493431eaf.18.1774621867265;
        Fri, 27 Mar 2026 07:31:07 -0700 (PDT)
X-Received: by 2002:a4a:e90e:0:b0:67e:eb4:238f with SMTP id 006d021491bc7-67e186156ebmr1493407eaf.18.1774621866819;
        Fri, 27 Mar 2026 07:31:06 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e502081sm515168585a.36.2026.03.27.07.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 07:31:06 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [PATCH 08/10] ceph: drop reset reconnect bookkeeping after direct teardown switch
Date: Fri, 27 Mar 2026 14:30:44 +0000
Message-Id: <20260327143045.1393612-9-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260327143045.1393612-1-amarkuze@redhat.com>
References: <20260327143045.1393612-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once manual reset tears sessions down locally, it no longer tracks
per-reset reconnect completions. Remove the leftover generation and
pending-reconnect state and simplify peer-reset handling to match the
new teardown-based reset path.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/debugfs.c    |   4 --
 fs/ceph/mds_client.c | 165 ++++++++++++++++++++++++-------------------
 fs/ceph/mds_client.h |   6 --
 3 files changed, 91 insertions(+), 84 deletions(-)

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index 88969dc5dde5..0c26491dbbf8 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -378,7 +378,6 @@ static int reset_status_show(struct seq_file *s, void *p)
 	bool inject_error = false;
 	bool drain_timed_out = false;
 	int sessions_reset = 0;
-	int pending_reconnects = 0;
 	int blocked_requests = 0;
 	char reason[CEPH_CLIENT_RESET_REASON_LEN];
 
@@ -401,7 +400,6 @@ static int reset_status_show(struct seq_file *s, void *p)
 	strscpy(reason, st->last_reason, sizeof(reason));
 	spin_unlock(&st->lock);
 
-	pending_reconnects = atomic_read(&st->pending_reconnects);
 	blocked_requests = atomic_read(&st->blocked_requests);
 
 	seq_printf(s, "phase: %s\n", ceph_reset_phase_name(phase));
@@ -426,8 +424,6 @@ static int reset_status_show(struct seq_file *s, void *p)
 	seq_printf(s, "drain_timed_out: %s\n",
 		   drain_timed_out ? "yes" : "no");
 	seq_printf(s, "sessions_reset: %d\n", sessions_reset);
-	/* pending_reconnects: always 0 for manual reset (MDS-reconnect only) */
-	seq_printf(s, "pending_reconnects: %d\n", pending_reconnects);
 	seq_printf(s, "blocked_requests: %d\n", blocked_requests);
 
 	return 0;
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 287cee71227b..8b86c577c127 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -62,7 +62,6 @@ struct ceph_reconnect_state {
 	struct ceph_pagelist *pagelist;
 	unsigned msg_version;
 	bool allow_multi;
-	bool from_reset;
 };
 
 static void __wake_requests(struct ceph_mds_client *mdsc,
@@ -70,8 +69,6 @@ static void __wake_requests(struct ceph_mds_client *mdsc,
 static void ceph_cap_release_work(struct work_struct *work);
 static void ceph_cap_reclaim_work(struct work_struct *work);
 static void ceph_mdsc_reset_workfn(struct work_struct *work);
-static void ceph_mdsc_reconnect_session_done(struct ceph_mds_client *mdsc,
-					     struct ceph_mds_session *session);
 
 static const struct ceph_connection_operations mds_con_ops;
 
@@ -4401,11 +4398,9 @@ static void handle_session(struct ceph_mds_session *session,
 
 	switch (op) {
 	case CEPH_SESSION_OPEN:
-		if (session->s_state == CEPH_MDS_SESSION_RECONNECTING) {
+		if (session->s_state == CEPH_MDS_SESSION_RECONNECTING)
 			pr_info_client(cl, "mds%d reconnect success\n",
 				       session->s_mds);
-			ceph_mdsc_reconnect_session_done(mdsc, session);
-		}
 
 		session->s_features = features;
 		if (session->s_state == CEPH_MDS_SESSION_OPEN) {
@@ -4438,11 +4433,9 @@ static void handle_session(struct ceph_mds_session *session,
 		break;
 
 	case CEPH_SESSION_CLOSE:
-		if (session->s_state == CEPH_MDS_SESSION_RECONNECTING) {
+		if (session->s_state == CEPH_MDS_SESSION_RECONNECTING)
 			pr_info_client(cl, "mds%d reconnect denied\n",
 				       session->s_mds);
-			ceph_mdsc_reconnect_session_done(mdsc, session);
-		}
 		session->s_state = CEPH_MDS_SESSION_CLOSED;
 		cleanup_session_requests(mdsc, session);
 		remove_session_caps(session);
@@ -4483,11 +4476,9 @@ static void handle_session(struct ceph_mds_session *session,
 	case CEPH_SESSION_REJECT:
 		WARN_ON(session->s_state != CEPH_MDS_SESSION_OPENING &&
 			session->s_state != CEPH_MDS_SESSION_RECONNECTING);
-		if (session->s_state == CEPH_MDS_SESSION_RECONNECTING) {
+		if (session->s_state == CEPH_MDS_SESSION_RECONNECTING)
 			pr_info_client(cl, "mds%d reconnect rejected\n",
 				       session->s_mds);
-			ceph_mdsc_reconnect_session_done(mdsc, session);
-		}
 		pr_info_client(cl, "mds%d rejected session\n",
 			       session->s_mds);
 		session->s_state = CEPH_MDS_SESSION_REJECTED;
@@ -4775,22 +4766,9 @@ static int reconnect_caps_cb(struct inode *inode, int mds, void *arg)
 		rec.v2.issued = cpu_to_le32(cap->issued);
 		rec.v2.snaprealm = cpu_to_le64(ci->i_snap_realm->ino);
 		rec.v2.pathbase = cpu_to_le64(path_info.vino.ino);
-		if (recon_state->from_reset) {
-			/*
-			 * Reset-initiated reconnect: always try to reclaim
-			 * locks. The MDS does best-effort; failures are
-			 * handled on future lock operations.
-			 */
-			rec.v2.flock_len = cpu_to_le32(1);
-		} else {
-			/*
-			 * Normal reconnect: skip lock reclaim if locks
-			 * were already known to be in error state.
-			 */
-			rec.v2.flock_len = cpu_to_le32(
-				test_bit(CEPH_I_ERROR_FILELOCK_BIT,
-					 &ci->i_ceph_flags) ? 0 : 1);
-		}
+		rec.v2.flock_len = cpu_to_le32(
+			test_bit(CEPH_I_ERROR_FILELOCK_BIT,
+				 &ci->i_ceph_flags) ? 0 : 1);
 	} else {
 		struct timespec64 ts;
 
@@ -4988,8 +4966,7 @@ static int encode_snap_realms(struct ceph_mds_client *mdsc,
  * This is a relatively heavyweight operation, but it's rare.
  */
 static int send_mds_reconnect(struct ceph_mds_client *mdsc,
-			      struct ceph_mds_session *session,
-			      bool from_reset)
+			      struct ceph_mds_session *session)
 {
 	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_msg *reply;
@@ -4997,7 +4974,6 @@ static int send_mds_reconnect(struct ceph_mds_client *mdsc,
 	int err = -ENOMEM;
 	struct ceph_reconnect_state recon_state = {
 		.session = session,
-		.from_reset = from_reset,
 	};
 	LIST_HEAD(dispose);
 
@@ -5181,40 +5157,6 @@ static int send_mds_reconnect(struct ceph_mds_client *mdsc,
 	return err;
 }
 
-/*
- * Called when a session completes reconnection (success or failure).
- * Only counts toward reset completion if this session's reconnect was
- * initiated by the currently active reset generation.  Late completions
- * from a prior (timed-out) reset are silently ignored.
- *
- * Caller must hold session->s_mutex to serialize s_reset_gen updates.
- */
-static void ceph_mdsc_reconnect_session_done(struct ceph_mds_client *mdsc,
-					     struct ceph_mds_session *session)
-{
-	struct ceph_client_reset_state *st = &mdsc->reset_state;
-	u64 active_gen;
-
-	lockdep_assert_held(&session->s_mutex);
-
-	if (!session->s_reset_gen)
-		return;
-
-	spin_lock(&st->lock);
-	active_gen = st->active_reset_gen;
-	spin_unlock(&st->lock);
-
-	if (session->s_reset_gen != active_gen) {
-		session->s_reset_gen = 0;
-		return;
-	}
-
-	session->s_reset_gen = 0;
-
-	if (atomic_dec_and_test(&st->pending_reconnects))
-		complete(&st->reconnect_done);
-}
-
 const char *ceph_reset_phase_name(enum ceph_client_reset_phase phase)
 {
 	switch (phase) {
@@ -5533,7 +5475,6 @@ int ceph_mdsc_schedule_reset(struct ceph_mds_client *mdsc,
 	}
 
 	st->phase = CEPH_CLIENT_RESET_QUIESCING;
-	st->active_reset_gen++;
 	st->last_start = jiffies;
 	st->last_errno = 0;
 	st->drain_timed_out = false;
@@ -5641,7 +5582,7 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 
 			mutex_unlock(&mdsc->mutex);
 			clear_bit(i, targets);
-			rc = send_mds_reconnect(mdsc, s, false);
+			rc = send_mds_reconnect(mdsc, s);
 			if (rc)
 				pr_err_client(cl,
 					      "mds%d reconnect failed: %d\n",
@@ -5709,7 +5650,7 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 		}
 		doutc(cl, "send reconnect to export target mds.%d\n", i);
 		mutex_unlock(&mdsc->mutex);
-		err = send_mds_reconnect(mdsc, s, false);
+		err = send_mds_reconnect(mdsc, s);
 		if (err)
 			pr_err_client(cl,
 				      "mds%d export target reconnect failed: %d\n",
@@ -6109,10 +6050,7 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
 	mdsc->reset_state.inject_error = false;
 	mdsc->reset_state.drain_timed_out = false;
 	mdsc->reset_state.sessions_reset = 0;
-	mdsc->reset_state.active_reset_gen = 0;
 	mdsc->reset_state.last_reason[0] = '\0';
-	atomic_set(&mdsc->reset_state.pending_reconnects, 0);
-	init_completion(&mdsc->reset_state.reconnect_done);
 	init_waitqueue_head(&mdsc->reset_state.blocked_wq);
 	atomic_set(&mdsc->reset_state.blocked_requests, 0);
 	INIT_WORK(&mdsc->reset_work, ceph_mdsc_reset_workfn);
@@ -6827,16 +6765,95 @@ static void mds_peer_reset(struct ceph_connection *con)
 {
 	struct ceph_mds_session *s = con->private;
 	struct ceph_mds_client *mdsc = s->s_mdsc;
+	int session_state;
 
 	pr_warn_client(mdsc->fsc->client, "mds%d closed our session\n",
 		       s->s_mds);
-	if (READ_ONCE(mdsc->fsc->mount_state) != CEPH_MOUNT_FENCE_IO &&
-	    ceph_mdsmap_get_state(mdsc->mdsmap, s->s_mds) >= CEPH_MDS_STATE_RECONNECT) {
-		int rc = send_mds_reconnect(mdsc, s, false);
+
+	if (READ_ONCE(mdsc->fsc->mount_state) == CEPH_MOUNT_FENCE_IO ||
+	    ceph_mdsmap_get_state(mdsc->mdsmap, s->s_mds) < CEPH_MDS_STATE_RECONNECT)
+		return;
+
+	if (ceph_mdsmap_get_state(mdsc->mdsmap, s->s_mds) == CEPH_MDS_STATE_RECONNECT) {
+		int rc = send_mds_reconnect(mdsc, s);
 		if (rc)
 			pr_err_client(mdsc->fsc->client,
 				      "mds%d reconnect failed: %d\n",
 				      s->s_mds, rc);
+		return;
+	}
+
+	/*
+	 * Snapshot session state under s->s_mutex, then release before
+	 * re-acquiring in the correct order: s->s_mutex -> mdsc->mutex
+	 * (consistent with check_new_map() and cleanup_session_requests(),
+	 * which achieve the same ordering via drop-and-reacquire).
+	 *
+	 * An ABA race (e.g. OPEN -> CLOSED -> OPEN) between the snapshot
+	 * and re-acquire is prevented by mdsc->mutex serialization of
+	 * session re-registration.
+	 */
+	mutex_lock(&s->s_mutex);
+	session_state = s->s_state;
+	mutex_unlock(&s->s_mutex);
+
+	switch (session_state) {
+	case CEPH_MDS_SESSION_RECONNECTING: {
+		int rc;
+
+		pr_info_client(mdsc->fsc->client,
+			       "mds%d reset during reconnect, restarting\n",
+			       s->s_mds);
+		rc = send_mds_reconnect(mdsc, s);
+		if (rc)
+			pr_err_client(mdsc->fsc->client,
+				      "mds%d reconnect restart failed: %d\n",
+				      s->s_mds, rc);
+		return;
+	}
+	case CEPH_MDS_SESSION_CLOSING:
+	case CEPH_MDS_SESSION_OPEN:
+	case CEPH_MDS_SESSION_HUNG:
+	case CEPH_MDS_SESSION_OPENING:
+		mutex_lock(&s->s_mutex);
+		mutex_lock(&mdsc->mutex);
+		if (s->s_state != session_state) {
+			pr_info_client(mdsc->fsc->client,
+				       "mds%d state changed to %s during peer reset\n",
+				       s->s_mds,
+				       ceph_session_state_name(s->s_state));
+			mutex_unlock(&mdsc->mutex);
+			mutex_unlock(&s->s_mutex);
+			return;
+		}
+
+		ceph_get_mds_session(s);
+		__unregister_session(mdsc, s);
+
+		s->s_state = CEPH_MDS_SESSION_CLOSED;
+		__wake_requests(mdsc, &s->s_waiting);
+		mutex_unlock(&mdsc->mutex);
+		mutex_unlock(&s->s_mutex);
+
+		mutex_lock(&s->s_mutex);
+		cleanup_session_requests(mdsc, s);
+		remove_session_caps(s);
+		mutex_unlock(&s->s_mutex);
+
+		wake_up_all(&mdsc->session_close_wq);
+
+		mutex_lock(&mdsc->mutex);
+		kick_requests(mdsc, s->s_mds);
+		mutex_unlock(&mdsc->mutex);
+
+		ceph_put_mds_session(s);
+		break;
+	default:
+		pr_warn_client(mdsc->fsc->client,
+			       "mds%d peer reset in unexpected state %s\n",
+			       s->s_mds,
+			       ceph_session_state_name(session_state));
+		break;
 	}
 }
 
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 87302755461c..07d79653c0a6 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -99,11 +99,6 @@ struct ceph_client_reset_state {
 	int sessions_reset;
 	char last_reason[CEPH_CLIENT_RESET_REASON_LEN];
 
-	/* Async reconnect completion (used by mds_peer_reset path) */
-	u64 active_reset_gen;
-	atomic_t pending_reconnects;
-	struct completion reconnect_done;
-
 	/* Request blocking during reset */
 	wait_queue_head_t blocked_wq;
 	atomic_t blocked_requests;
@@ -286,7 +281,6 @@ struct ceph_mds_session {
 	struct list_head  s_unsafe;   /* unsafe requests */
 	struct xarray	  s_delegated_inos;
 
-	u64		  s_reset_gen; /* generation of reset that initiated reconnect */
 };
 
 /*
-- 
2.34.1

