Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C622A3F7873
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 14:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774621863; cv=none; b=X7Omdi86FB9E0UvszvqrlyXao5vRAlPJBqeZvV3MNF0Mn0YGmmmSZshyLf/PpaFPMPixr56AQyOteLeer3l285Toxh42tsTlNeUT5ZJJ9JqKComktASvqN8d2VuMGRV7TJcYNUJdKKmQwc0lMDT1X1bK8MjWW6Hj3s9FRqeOgtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774621863; c=relaxed/simple;
	bh=hb2kCAtOGYErvga5GtRdD65pvqvnMzSKqKeJXFYHRS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VreKNiClPbK/LGPa0zCsG4crBUwEkqmTGmZxsg1MFeqOiw0nCpuAg8MJNIw9QCdQdguxtipEuN6nQ/3ltciNo7Vbg9YO0CCX59iI0DluRUhNrBmMNVbnz7aXymzUpooc3IUfp3n4zi/yxiKwaZVi6KsYX1i5foh+EgVt9YHWx+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P3Asx84J; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MoSPxE7A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P3Asx84J";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MoSPxE7A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774621860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2qMrpYjqjfVtAPtBTQRCod360yDzI4dxcJEpY8FD7l0=;
	b=P3Asx84JlizayL8t7xu8AhnadfYqEuVbBz0uecV/Rw/r0HawsDAE9IqbjFNGdAP4Y6pD+e
	R1FWmR+RsqHdb3d/sg15C2l1Rhkn2Lffe/BithUwdPzlWJngglC0eDeR2fixHMkEVjHh6K
	CkVWUoJlGU0P7yGh7k38CvEzTrlfWdA=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-DvLs3xPgOW2SYHAxNRy2Pg-1; Fri, 27 Mar 2026 10:30:59 -0400
X-MC-Unique: DvLs3xPgOW2SYHAxNRy2Pg-1
X-Mimecast-MFC-AGG-ID: DvLs3xPgOW2SYHAxNRy2Pg_1774621859
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-679c51b2d6cso5533334eaf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 07:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774621859; x=1775226659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qMrpYjqjfVtAPtBTQRCod360yDzI4dxcJEpY8FD7l0=;
        b=MoSPxE7AyMGZdzfoWz0Y0UBMFGST71zqY506YoFvTX0jfz6v0yYuXgJvhmwsIUknGr
         7WNmJtYCoOPCwoYADLz2jz/XjX4juHg512xm7phBOxq31zBuBIPb/Et7dpxTCZWf+t1X
         DBRtKaaNv+0zAok8OnkUdbgHK38Q2HiiORAiP+9rwDkoN8hKfnI7QSmNTC6z9VAYkf3/
         WRjsW+wymWDgAgZ051sNv2eNOHaSuEv08oOVH3L2pSFFMj9H+HRytfAUYzDMpfczqOrh
         GprzMkWU1N4odi6/yJgYLZYsS2vkeo03yxklrHDRd5MqsNCvLIQ85AClpIbOc8k6206m
         cGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774621859; x=1775226659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2qMrpYjqjfVtAPtBTQRCod360yDzI4dxcJEpY8FD7l0=;
        b=Y+83Q2CIN6CYHdoT4SmgpqW5NSLzkJ5WRXEpAH3zod7GRWC6BiXF46u10oIT6l9hUA
         4yH/rB35Qt8hO1v+LixDyaPcBaOhCfznujU+TYxoz8G4K2V5aDY0hZzro5ER6NfV1vOE
         mMpNACH7jMcwJ0B7mGVlsVEpOX0VAaxKJcxMP6yGuaCoT0m8uyJhV+A1UHbW2X3qzsXP
         sBFf5hvjvtstD/igVgncYoHSZn0GYhfmF/zcC1+V4U1kDJrU7VJISDJghBiTZmHCOzI1
         aM71hT88AYTfxCJfqLjHs2U2pxnO/7E92SqLvy7L4iZNELb3blYf+liHu0hSqiwtgv40
         anBA==
X-Forwarded-Encrypted: i=1; AJvYcCUHt11hcZuUWJ9do3s92lMCaFEV4T3ZTKEoANXqxiVQo/goSxM672vIba2eCkHjQbvbOL21UYZue3qmnmkc@vger.kernel.org
X-Gm-Message-State: AOJu0YxfWn70VZWmZisbDwUNBTqMmgwdK+w3Jo5R0aSRL91OB15621AY
	ngQSm8Pz8U6h2SAKcz0w5aTbwYXCw5l+4vSr4qpTzsajiPhHelIz5tfMRs+IDpsflKU4vWmfACC
	3CYjarEqIKvLSzQKVdmW00GmdD1VJqgXEnO/+c8aEIXmKMDzSEFB8JYOFUFJoaMk5joc=
X-Gm-Gg: ATEYQzx2qouxs/G7qHHKwa1QuuP8/6DXG50uW0ILU7Zb6y3S2kX01wSPjGkIeC02jj2
	/PnoJUUrHbYxLXylV2aSlazqqsY9hCdSKpjfjv9iakd2K09/sEkgtuZavYhnZcmchC0P4w4RHSR
	8BqvLnuvo8WcotnMBQTY+LXuyh5bGdUIO/A8HT47M92GEvHflfv1XvjI55M3eX8IjSMvmGw1sMJ
	97rx7l2367UmYjgxJkbf8Ki80oN99ldNtah/8+33AR5yHIk/s+ADmNyP/9KnRhdRs03IDEypM8a
	deCaSRpIP4xjt3+Al+wl9O7e6xpjSuQ2KFgiui9Td7brvlAVSJZ1nB1Ii+K5PRC3l/BVcRWzemx
	8eird3KzN/oEMnxcRFW76xh1nvr162E5xhdqcPVU6G4+XRyx8RxZnowo=
X-Received: by 2002:a05:6820:1513:b0:67d:ea53:b9c8 with SMTP id 006d021491bc7-67e1860d569mr1399661eaf.18.1774621858489;
        Fri, 27 Mar 2026 07:30:58 -0700 (PDT)
X-Received: by 2002:a05:6820:1513:b0:67d:ea53:b9c8 with SMTP id 006d021491bc7-67e1860d569mr1399626eaf.18.1774621858030;
        Fri, 27 Mar 2026 07:30:58 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e502081sm515168585a.36.2026.03.27.07.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 07:30:57 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [PATCH 03/10] ceph: add client reset state and request gating
Date: Fri, 27 Mar 2026 14:30:39 +0000
Message-Id: <20260327143045.1393612-4-amarkuze@redhat.com>
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

Add the client-side reset state tracking and the wait path used to block
new metadata requests and new lock acquisitions while a reset is in
progress. This wires the reset state into client init and shutdown so
blocked callers are released cleanly when the mount is torn down.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/locks.c      | 14 ++++++++
 fs/ceph/mds_client.c | 79 ++++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/mds_client.h | 28 ++++++++++++++++
 3 files changed, 121 insertions(+)

diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index 2f21574dfb99..e6f0c565e9d6 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -281,6 +281,13 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 		return err;
 	}
 
+	/* Wait for reset to complete before acquiring new locks */
+	if (op == CEPH_MDS_OP_SETFILELOCK && !lock_is_unlock(fl)) {
+		err = ceph_mdsc_wait_for_reset(mdsc);
+		if (err)
+			return err;
+	}
+
 	if (lock_is_read(fl))
 		lock_cmd = CEPH_LOCK_SHARED;
 	else if (lock_is_write(fl))
@@ -340,6 +347,13 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 		return err;
 	}
 
+	/* Wait for reset to complete before acquiring new locks */
+	if (!lock_is_unlock(fl)) {
+		err = ceph_mdsc_wait_for_reset(mdsc);
+		if (err)
+			return err;
+	}
+
 	if (IS_SETLKW(cmd))
 		wait = 1;
 
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index d70c0b669b75..0dd9a529850a 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3742,12 +3742,69 @@ static void kick_requests(struct ceph_mds_client *mdsc, int mds)
 	}
 }
 
+/*
+ * Wait for an active reset to complete.
+ * Returns 0 if reset completed successfully or no reset was active.
+ * Returns -ETIMEDOUT if we timed out waiting.
+ * Returns -ERESTARTSYS if interrupted by signal.
+ */
+int ceph_mdsc_wait_for_reset(struct ceph_mds_client *mdsc)
+{
+	struct ceph_client_reset_state *st = &mdsc->reset_state;
+	struct ceph_client *cl = mdsc->fsc->client;
+	long timeout = CEPH_CLIENT_RESET_WAIT_TIMEOUT_SEC * HZ;
+	int blocked_count;
+	int ret;
+
+	if (READ_ONCE(st->phase) == CEPH_CLIENT_RESET_IDLE)
+		return 0;
+
+	blocked_count = atomic_inc_return(&st->blocked_requests);
+	doutc(cl, "request blocked during reset, %d total blocked\n",
+	      blocked_count);
+
+	ret = wait_event_interruptible_timeout(st->blocked_wq,
+					       READ_ONCE(st->phase) ==
+					       CEPH_CLIENT_RESET_IDLE,
+					       timeout);
+
+	atomic_dec(&st->blocked_requests);
+
+	if (ret == 0) {
+		pr_warn_client(cl, "timed out waiting for reset to complete\n");
+		return -ETIMEDOUT;
+	}
+	if (ret < 0)
+		return ret;
+
+	spin_lock(&st->lock);
+	ret = st->last_errno;
+	spin_unlock(&st->lock);
+	return ret;
+}
+
 int ceph_mdsc_submit_request(struct ceph_mds_client *mdsc, struct inode *dir,
 			      struct ceph_mds_request *req)
 {
 	struct ceph_client *cl = mdsc->fsc->client;
 	int err = 0;
 
+	/*
+	 * If a reset is in progress, wait for it to complete.
+	 *
+	 * This is best-effort: a request can pass this check just
+	 * before the phase leaves IDLE and proceed concurrently with
+	 * reset. That is acceptable because such requests will either
+	 * complete normally or fail and be retried by the caller, and
+	 * adding lock serialization here would penalize every request
+	 * for a rare manual operation.
+	 */
+	err = ceph_mdsc_wait_for_reset(mdsc);
+	if (err) {
+		doutc(cl, "wait_for_reset failed: %d\n", err);
+		return err;
+	}
+
 	/* take CAP_PIN refs for r_inode, r_parent, r_old_dentry */
 	if (req->r_inode)
 		ceph_get_cap_refs(ceph_inode(req->r_inode), CEPH_CAP_PIN);
@@ -5628,6 +5685,19 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
 	INIT_LIST_HEAD(&mdsc->dentry_leases);
 	INIT_LIST_HEAD(&mdsc->dentry_dir_leases);
 
+	spin_lock_init(&mdsc->reset_state.lock);
+	mdsc->reset_state.trigger_count = 0;
+	mdsc->reset_state.success_count = 0;
+	mdsc->reset_state.failure_count = 0;
+	mdsc->reset_state.last_start = 0;
+	mdsc->reset_state.last_finish = 0;
+	mdsc->reset_state.last_errno = 0;
+	mdsc->reset_state.phase = CEPH_CLIENT_RESET_IDLE;
+	mdsc->reset_state.inject_error = false;
+	mdsc->reset_state.last_reason[0] = '\0';
+	init_waitqueue_head(&mdsc->reset_state.blocked_wq);
+	atomic_set(&mdsc->reset_state.blocked_requests, 0);
+
 	ceph_caps_init(mdsc);
 	ceph_adjust_caps_max_min(mdsc, fsc->mount_options);
 
@@ -6153,6 +6223,15 @@ void ceph_mdsc_destroy(struct ceph_fs_client *fsc)
 	/* flush out any connection work with references to us */
 	ceph_msgr_flush();
 
+	spin_lock(&mdsc->reset_state.lock);
+	if (mdsc->reset_state.phase != CEPH_CLIENT_RESET_IDLE) {
+		mdsc->reset_state.phase = CEPH_CLIENT_RESET_IDLE;
+		mdsc->reset_state.last_errno = -ESHUTDOWN;
+		mdsc->reset_state.failure_count++;
+	}
+	spin_unlock(&mdsc->reset_state.lock);
+	wake_up_all(&mdsc->reset_state.blocked_wq);
+
 	ceph_mdsc_stop(mdsc);
 
 	ceph_metric_destroy(&mdsc->metric);
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index e91a199d56fd..5cc22c109cfe 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -74,6 +74,32 @@ struct ceph_fs_client;
 struct ceph_cap;
 
 #define MDS_AUTH_UID_ANY -1
+#define CEPH_CLIENT_RESET_REASON_LEN	64
+#define CEPH_CLIENT_RESET_WAIT_TIMEOUT_SEC 120
+
+enum ceph_client_reset_phase {
+	CEPH_CLIENT_RESET_IDLE = 0,
+	CEPH_CLIENT_RESET_QUIESCING,
+	CEPH_CLIENT_RESET_DRAINING,
+	CEPH_CLIENT_RESET_TEARDOWN,
+};
+
+struct ceph_client_reset_state {
+	spinlock_t lock;
+	u64 trigger_count;
+	u64 success_count;
+	u64 failure_count;
+	unsigned long last_start;
+	unsigned long last_finish;
+	int last_errno;
+	enum ceph_client_reset_phase phase;
+	bool inject_error;
+	char last_reason[CEPH_CLIENT_RESET_REASON_LEN];
+
+	/* Request blocking during reset */
+	wait_queue_head_t blocked_wq;
+	atomic_t blocked_requests;
+};
 
 struct ceph_mds_cap_match {
 	s64 uid;  /* default to MDS_AUTH_UID_ANY */
@@ -536,6 +562,7 @@ struct ceph_mds_client {
 	struct list_head  dentry_dir_leases; /* lru list */
 
 	struct ceph_client_metric metric;
+	struct ceph_client_reset_state reset_state;
 
 	spinlock_t		snapid_map_lock;
 	struct rb_root		snapid_map_tree;
@@ -563,6 +590,7 @@ extern const char *ceph_session_state_name(int s);
 extern struct ceph_mds_session *
 ceph_get_mds_session(struct ceph_mds_session *s);
 extern void ceph_put_mds_session(struct ceph_mds_session *s);
+int ceph_mdsc_wait_for_reset(struct ceph_mds_client *mdsc);
 
 extern int ceph_mdsc_init(struct ceph_fs_client *fsc);
 extern void ceph_mdsc_close_sessions(struct ceph_mds_client *mdsc);
-- 
2.34.1

