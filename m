Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00D3346E43
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050313; cv=none; b=OMBfPNWP9K+u1mDwr/2F4/S8tr4G1b23o8Ow09x5McniB6iUeNr9KuT39SDcYyChEnVLnVZfLM4z67txZT16QPz8fWSVDB72jtvqGt7gaBegohCk4W3FFUAVgbPtEdWGDIdffw4Koda/uD6/c1pRP9Z4yGs1I+MBDcvgXxGd2Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050313; c=relaxed/simple;
	bh=jPE0/thaNeTpoqSAg/TGz1NIWQLKBpJMIaEWf2eISWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sw5klTwuq97RhraBCVybIc6RT9Dx6z4CTLFkLDPHQ9dyZqHnPYyyxuSaTPC1vRd7GuqQ0k8KtxJL98hL1OCStCTUksRks4/hJ9MA5GuLfpa8Udfbk69qeN1RIo3gxqxCYAIHlpBCpbRlm4BDCP0O9d8ly0b6HixyZCxm8dqftWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETu3QXRd; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETu3QXRd"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ba699316b42so982529666b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 10:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777050310; x=1777655110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtbGv1Z8baCF6hC2ufIrf1v2uYn8orTGiVXpjL93NsY=;
        b=ETu3QXRd1z9JvmIDvuOIwzMpQUvj8Jpu6Ey+PL2fk+BPXpdcIC7u4x1Y9nUs2h2o1N
         YvHxCY91xdaSQE72mPpySupLE7nZP/9AQzMJWs46PxTDSz3dwkuSv2cjBo2BFfCj3Gy/
         rlTrWN61oWgYH8NrwXCPb0Ab5rGGR+Mol1GPI9fGM9LSQ+RjZ+g+eyCnE5vdB+tV394W
         DKmuviyoaWloFrZFeZiT4E8dea/7twjfhag1pDJfUYJdjm/9ZLuH+NjDbp2u/bxJY9S8
         plgCN6Si010N7STmB6OvP0+bspApQNiWojhkM+YVxkVIXnJmdczZPdtpZT8siPuuFeob
         K4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777050310; x=1777655110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KtbGv1Z8baCF6hC2ufIrf1v2uYn8orTGiVXpjL93NsY=;
        b=qXq2d+lMHt3FKz521x1k2PsGJel5Sq4svclGLnAymJ+6hb8kOcWz0yAV6ss2jNi7CY
         riHDO54BFLfwm8f/yoZHocS1pukh5FbDtNMt5jAEBMqBFTLEY3CRSotT+18L4CpVcboR
         3WLgmzti2hNqgwV+xuAOFauA5IrN5zIb/egeYqVdntsZG6lHEGN4u7Bkl/zGKy120MF4
         UW8TEjCKptIEUarQUcWrmexhWwaiSIpI9dHhHeV789Iq+xeTdiHk0NQokJwYy/PSqAoS
         TOQkuanxYuOESr8oR0JMsoU2reMuXwPE2LV3PHySK6fzY8oSVNE8uKuT7aPGz5R0C/U4
         2OhA==
X-Forwarded-Encrypted: i=1; AFNElJ8fWzujMO6ImRJuJxZ4Ujz2mLv747xE9cgZfymALltiYiGog0QKs+9W4IZgqTygok4tw7CCR9wJzBqJmy11@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ttEJPdJWGgHuUaVVpnhSXDkr6HG77yiT0yUA394lFw6ZoTc0
	TI41NnBLTte5TyUMcGHa+e8UOUo4vdPQVcEKySYVl7R3L2U1Z66j9tZN
X-Gm-Gg: AeBDieukGFLqaZ+GcrFm22jPQnZHbNzAAG6hXd7P31Mo8P45OqvQ4IwJzUqIQHil/0I
	d8a4Io7g0/gyia4EqXU/8XRaTynuifdHTBiWN+jpxlnd85gDHLRpqr1Z9TMbrm8ln3sWFoHVbu+
	C97b+NIXp730DyzWCvnX2Qa0+YqIaGfYNwFVi8wgmKnkpxs+pNzTX/SEJi//m2dkBcNwDJleP3F
	iym2PzQLeR1BEV43Ay0fwiygRfEZjX5pIcb7xHcpB4pMYauI07/6E8sVROu0C1Cpt3IlkbK7jRN
	B6GoMSdkwBts7BaLSfiB53ttil+22XBu84StFpsLYZEQDMVFErCianwmsiiL02GDC8yVzy6g+6T
	CTZ5qcHo8o2x0fMp+U2jTcAAsBek8Il2SIW395bJQkJExNIk4Xc06UEsWwLPSaLtZIunQSpHomE
	siNPrUb0IYb5R4WbcWPMNoVrfP5RFZffWc7nCA9To7rpZMvIDFEP6zHjv7v1no6w9+VmmQpK3rp
	bhHNEF/7F5HwnsiXJckTbjIs+yy09jXDSWe2WI=
X-Received: by 2002:a17:907:cb0a:b0:b9d:4301:be37 with SMTP id a640c23a62f3a-ba419077368mr1137174666b.5.1777050309963;
        Fri, 24 Apr 2026 10:05:09 -0700 (PDT)
Received: from localhost (2001-1c00-570d-ee00-4aab-734a-1928-df3f.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:4aab:734a:1928:df3f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba4520c93c7sm788534566b.27.2026.04.24.10.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 10:05:09 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 04/10] fanotify: test event->type instead of event mask when possible
Date: Fri, 24 Apr 2026 19:04:57 +0200
Message-ID: <20260424170503.2096847-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260424170503.2096847-1-amir73il@gmail.com>
References: <20260424170503.2096847-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fanotify_event already has a type field, so tests like
fanotify_is_mnt_event() should check the type and not the mask.

In fanotify_alloc_event() determine the mnt and fs_error event
types by data_type, which uniquely identifies those events.

The helper for classifying an fs permission event is renamed to
fanotify_is_fs_perm_event() and takes the group argument to verify
that this is a filesystem group type.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 30 +++++++++++++++---------------
 fs/notify/fanotify/fanotify.h      | 29 +++++++++++++++++++++--------
 fs/notify/fanotify/fanotify_user.c | 18 +++++++++---------
 include/linux/fsnotify_backend.h   |  5 -----
 4 files changed, 45 insertions(+), 37 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 494bba49634e1..80116026d3ae0 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -195,7 +195,7 @@ static int fanotify_merge(struct fsnotify_group *group,
 	 * the event structure we have created in fanotify_handle_event() is the
 	 * one we should check for permission response.
 	 */
-	if (fanotify_is_perm_event(new->mask))
+	if (fanotify_is_perm_event(new))
 		return 0;
 
 	hlist_for_each_entry(old, hlist, merge_list) {
@@ -204,7 +204,7 @@ static int fanotify_merge(struct fsnotify_group *group,
 		if (fanotify_should_merge(old, new)) {
 			old->mask |= new->mask;
 
-			if (fanotify_is_error_event(old->mask))
+			if (fanotify_is_error_event(old))
 				FANOTIFY_EE(old)->err_count++;
 
 			return 1;
@@ -711,11 +711,9 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *dir,
 static struct fanotify_event *fanotify_alloc_error_event(
 						struct fsnotify_group *group,
 						__kernel_fsid_t *fsid,
-						const void *data, int data_type,
+						struct fs_error_report *report,
 						unsigned int *hash)
 {
-	struct fs_error_report *report =
-			fsnotify_data_error_report(data, data_type);
 	struct inode *inode;
 	struct fanotify_error_event *fee;
 	int fh_len;
@@ -759,6 +757,8 @@ static struct fanotify_event *fanotify_alloc_event(
 					      fid_mode);
 	struct inode *dirid = fanotify_dfid_inode(mask, data, data_type, dir);
 	const struct path *path = fsnotify_data_path(data, data_type);
+	struct fs_error_report *fs_error =
+		fsnotify_data_error_report(data, data_type);
 	u64 mnt_id = fsnotify_data_mnt_id(data, data_type);
 	struct mem_cgroup *old_memcg;
 	struct dentry *moved = NULL;
@@ -845,11 +845,10 @@ static struct fanotify_event *fanotify_alloc_event(
 	/* Whoever is interested in the event, pays for the allocation. */
 	old_memcg = set_active_memcg(group->memcg);
 
-	if (fanotify_is_perm_event(mask)) {
+	if (fanotify_is_fs_perm_event(group, mask)) {
 		event = fanotify_alloc_perm_event(data, data_type, gfp);
-	} else if (fanotify_is_error_event(mask)) {
-		event = fanotify_alloc_error_event(group, fsid, data,
-						   data_type, &hash);
+	} else if (fs_error) {
+		event = fanotify_alloc_error_event(group, fsid, fs_error, &hash);
 	} else if (name_event && (file_name || moved || child)) {
 		event = fanotify_alloc_name_event(dirid, fsid, file_name, child,
 						  moved, &hash, gfp);
@@ -916,7 +915,7 @@ static void fanotify_insert_event(struct fsnotify_group *group,
 
 	assert_spin_locked(&group->notification_lock);
 
-	if (!fanotify_is_hashed_event(event->mask))
+	if (!fanotify_is_hashed_event(event))
 		return;
 
 	pr_debug("%s: group=%p event=%p bucket=%u\n", __func__,
@@ -970,7 +969,8 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	pr_debug("%s: group=%p mask=%x report_mask=%x\n", __func__,
 		 group, mask, match_mask);
 
-	if (fanotify_is_perm_event(mask)) {
+	bool is_perm = fanotify_is_fs_perm_event(group, mask);
+	if (is_perm) {
 		/*
 		 * fsnotify_prepare_user_wait() fails if we race with mark
 		 * deletion.  Just let the operation pass in that case.
@@ -990,7 +990,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 		 * We don't queue overflow events for permission events as
 		 * there the access is denied and so no event is in fact lost.
 		 */
-		if (!fanotify_is_perm_event(mask))
+		if (!is_perm)
 			fsnotify_queue_overflow(group);
 		goto finish;
 	}
@@ -1000,17 +1000,17 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 				    fanotify_insert_event);
 	if (ret) {
 		/* Permission events shouldn't be merged */
-		BUG_ON(ret == 1 && mask & FANOTIFY_PERM_EVENTS);
+		WARN_ON(ret == 1 && is_perm);
 		/* Our event wasn't used in the end. Free it. */
 		fsnotify_destroy_event(group, fsn_event);
 
 		ret = 0;
-	} else if (fanotify_is_perm_event(mask)) {
+	} else if (is_perm) {
 		ret = fanotify_get_response(group, FANOTIFY_PERM(event),
 					    iter_info);
 	}
 finish:
-	if (fanotify_is_perm_event(mask))
+	if (is_perm)
 		fsnotify_finish_user_wait(iter_info);
 
 	return ret;
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index a0619e7694d57..13e3787ddd558 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -265,6 +265,7 @@ struct fanotify_event {
 	struct pid *pid;
 };
 
+
 static inline void fanotify_init_event(struct fanotify_event *event,
 				       unsigned int hash, u32 mask)
 {
@@ -457,12 +458,24 @@ FANOTIFY_PERM(struct fanotify_event *event)
 	return container_of(event, struct fanotify_perm_event, fae);
 }
 
-static inline bool fanotify_is_perm_event(u32 mask)
+static inline bool fanotify_is_fs_perm_event(struct fsnotify_group *group,
+					     u32 mask)
 {
 	return IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS) &&
+		fsnotify_is_fs_watcher(group) &&
 		mask & FANOTIFY_PERM_EVENTS;
 }
 
+static inline bool fanotify_is_perm_event(struct fanotify_event *event)
+{
+	return event->type == FANOTIFY_EVENT_TYPE_PATH_PERM;
+}
+
+static inline bool fsnotify_is_overflow_event(struct fanotify_event *event)
+{
+	return event->type == FANOTIFY_EVENT_TYPE_OVERFLOW;
+}
+
 static inline bool fanotify_event_has_access_range(struct fanotify_event *event)
 {
 	if (!(event->mask & FANOTIFY_PRE_CONTENT_EVENTS))
@@ -476,14 +489,14 @@ static inline struct fanotify_event *FANOTIFY_E(struct fsnotify_event *fse)
 	return container_of(fse, struct fanotify_event, fse);
 }
 
-static inline bool fanotify_is_error_event(u32 mask)
+static inline bool fanotify_is_error_event(struct fanotify_event *event)
 {
-	return mask & FAN_FS_ERROR;
+	return event->type == FANOTIFY_EVENT_TYPE_FS_ERROR;
 }
 
-static inline bool fanotify_is_mnt_event(u32 mask)
+static inline bool fanotify_is_mnt_event(struct fanotify_event *event)
 {
-	return mask & (FAN_MNT_ATTACH | FAN_MNT_DETACH);
+	return event->type == FANOTIFY_EVENT_TYPE_MNT;
 }
 
 static inline const struct path *fanotify_event_path(struct fanotify_event *event)
@@ -506,10 +519,10 @@ static inline const struct path *fanotify_event_path(struct fanotify_event *even
 /*
  * Permission events and overflow event do not get merged - don't hash them.
  */
-static inline bool fanotify_is_hashed_event(u32 mask)
+static inline bool fanotify_is_hashed_event(struct fanotify_event *event)
 {
-	return !(fanotify_is_perm_event(mask) ||
-		 fsnotify_is_overflow_event(mask));
+	return !(fanotify_is_perm_event(event) ||
+		 fsnotify_is_overflow_event(event));
 }
 
 static inline unsigned int fanotify_event_hash_bucket(
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 7afb017d40f50..c41c83d86518a 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -257,7 +257,7 @@ static size_t fanotify_event_len(unsigned int info_mode,
 	int fh_len;
 	int dot_len = 0;
 
-	if (fanotify_is_error_event(event->mask))
+	if (fanotify_is_error_event(event))
 		event_len += FANOTIFY_ERROR_INFO_LEN;
 
 	if (fanotify_event_has_any_dir_fh(event)) {
@@ -275,7 +275,7 @@ static size_t fanotify_event_len(unsigned int info_mode,
 		fh_len = fanotify_event_object_fh_len(event);
 		event_len += fanotify_fid_info_len(fh_len, dot_len);
 	}
-	if (fanotify_is_mnt_event(event->mask))
+	if (fanotify_is_mnt_event(event))
 		event_len += FANOTIFY_MNT_INFO_LEN;
 
 	if (info_mode & FAN_REPORT_PIDFD)
@@ -338,9 +338,9 @@ static struct fanotify_event *get_one_event(struct fsnotify_group *group,
 	 * same event we peeked above.
 	 */
 	fsnotify_remove_first_event(group);
-	if (fanotify_is_perm_event(event->mask))
+	if (fanotify_is_perm_event(event))
 		FANOTIFY_PERM(event)->state = FAN_EVENT_REPORTED;
-	if (fanotify_is_hashed_event(event->mask))
+	if (fanotify_is_hashed_event(event))
 		fanotify_unhash_event(group, event);
 out:
 	spin_unlock(&group->notification_lock);
@@ -800,7 +800,7 @@ static int copy_info_records_to_user(struct fanotify_event *event,
 		total_bytes += ret;
 	}
 
-	if (fanotify_is_error_event(event->mask)) {
+	if (fanotify_is_error_event(event)) {
 		ret = copy_error_info_to_user(event, buf, count);
 		if (ret < 0)
 			return ret;
@@ -818,7 +818,7 @@ static int copy_info_records_to_user(struct fanotify_event *event,
 		total_bytes += ret;
 	}
 
-	if (fanotify_is_mnt_event(event->mask)) {
+	if (fanotify_is_mnt_event(event)) {
 		ret = copy_mnt_info_to_user(event, buf, count);
 		if (ret < 0)
 			return ret;
@@ -965,7 +965,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	if (pidfd_file)
 		fd_install(pidfd, pidfd_file);
 
-	if (fanotify_is_perm_event(event->mask))
+	if (fanotify_is_perm_event(event))
 		FANOTIFY_PERM(event)->fd = fd;
 
 	return metadata.event_len;
@@ -1048,7 +1048,7 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
 		 * Permission events get queued to wait for response.  Other
 		 * events can be destroyed now.
 		 */
-		if (!fanotify_is_perm_event(event->mask)) {
+		if (!fanotify_is_perm_event(event)) {
 			fsnotify_destroy_event(group, &event->fse);
 		} else {
 			if (ret <= 0 || FANOTIFY_PERM(event)->fd < 0) {
@@ -1145,7 +1145,7 @@ static int fanotify_release(struct inode *ignored, struct file *file)
 	while ((fsn_event = fsnotify_remove_first_event(group))) {
 		struct fanotify_event *event = FANOTIFY_E(fsn_event);
 
-		if (!(event->mask & FANOTIFY_PERM_EVENTS)) {
+		if (!fanotify_is_perm_event(event)) {
 			spin_unlock(&group->notification_lock);
 			fsnotify_destroy_event(group, fsn_event);
 		} else {
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 8f2821735f068..9ce08d03d041d 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -783,11 +783,6 @@ static inline void fsnotify_queue_overflow(struct fsnotify_group *group)
 	fsnotify_add_event(group, group->overflow_event, NULL);
 }
 
-static inline bool fsnotify_is_overflow_event(u32 mask)
-{
-	return mask & FS_Q_OVERFLOW;
-}
-
 static inline bool fsnotify_notify_queue_is_empty(struct fsnotify_group *group)
 {
 	assert_spin_locked(&group->notification_lock);
-- 
2.54.0

