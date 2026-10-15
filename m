Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800DB377EAC
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 14:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074972; cv=none; b=g0zUVWTxT0gOF/w1IAO1STlE2EKz0/WGkIdxiD6eQTDLuRX4qpWU/ZXZ4RdQ4YdfNRCPvSpe112Opd6+o31LIhc0IjT4N63QtF0nN65hZr9AQI9CRtFQZA4Uclf6zYqWZshgETwUQ4JTOJvgAHgRiUiIUWTx2jh7U85lhyGlJqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074972; c=relaxed/simple;
	bh=ouvFd2SKdo8jTHmh8iHy92grzjr2X2wWQrbp6pACKtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HtTFCWmW6BbIxRC889H5t/UFS6UA3cNR3AD8zCJNt4JM1Ctk5f1q7fe82feO0/TsBy6TUxauHx+eZnqZi0rJ1erhIqqxUL1pKrxkwGxR9sMfjEj9oA3PtqiwKIUg8LspQYQ0RGWaXrz2UkarEQ5pyjw5FFlkY0d8jY44xsNnUMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYQ+CN2O; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYQ+CN2O"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b1ab2ad719so816946a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 07:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792074967; x=1792679767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lbowkm13XP1soFzi+cPEEoCbBfhwa992ALrPHWXR1TU=;
        b=RYQ+CN2O3mkaWBp99i+sXAOgU4ffBuOCWHLNv5TknvkrjVXx2Bm40JIGot5yce5aUP
         Z0zGQtvmcUz24keYmymq3KTU1KSZE18xFvcW0Az/u6SctTGEYkyDt4hOKw6nwAmCrWL8
         zyyBFibI52qTyiP742y3pAmcQUqMZS8IeD9+H8vGTFCWUa4ZYJjtjxOiyP5D4gzEg2Xl
         URlhJLXBOoaGcSI10j+Mx0zCxjdukzYKaqbuIROCHcJh+bh76yRf5BurdhTdrWvt35CG
         c+1e2HTVjaOGI07gzPSlyiNxssCnEhUjfRPyRKnzBcCe1ryE4DWzA1yWzdRvrQvxn9uj
         8+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792074967; x=1792679767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lbowkm13XP1soFzi+cPEEoCbBfhwa992ALrPHWXR1TU=;
        b=WXLHU1e4XPj2Kafj5nfJ0nQVnrKcDJSrIO3Dl5k6v3uWgBPXim88w0egNNP70bTVih
         XNc6C98PDEwtZ8x9fquDLJZ+XfvqxHm4Yrd9YCDA4bc9qRGcOmlSE57nO45BwD3cJNWz
         duaohUxAnGaZvaHFNPTHitsuBkd2hg2igE6KlgypcvVdcPFAgCUuUlA5+LjCe4+z+blY
         qY0QrvBR93sxM+ehG6LNGJiGYtaCbor+69k1eqLUrSqUiKZY3pPX5uV43wJhh6SCNuJ7
         OHgqo071jlgkmSKWtkH2+6vBG5E0CkEGZaT8Sto6RjwCRSlpJ5q5h0lAZ+l7Dkt3vBfz
         dDbg==
X-Forwarded-Encrypted: i=1; AKwUvBwLO28DZyu5u9KN2z0EixoYuozJFIrHq8UoDneWN10CuFIenPuUB8SJWcmQyf8OVPSQ0Z/GkG9gv1dUmxmN@vger.kernel.org
X-Gm-Message-State: AFq9FYLJYxOpe1gaQEA4rmt/ADj/dY2hewv6lcCp10cdBq+1WqsOzx7w
	bbaaWQe8nEsF/Pmuz57Dy6gub14/taxttXJxmwcMVuYHCbS0c7tauPg3Hg8oM/Dc
X-Gm-Gg: AYBFou1Ndzpuht1FqOzDuzj906DWfTvoYMfGevnb3bnGC2UCxxXx6XRz/papDAoMeyb
	7ZKweaEnR1/js0SA298iLiBGWP/Qqg5NxUu+/AJOb0+o6Vfbia++RIVW67mY4ulIYuWF3q4wXBA
	9DZ4Zljt66mB11KLig4zzAwNF58tr3Tp1PtMiysrO3kG+erY4OPX/ItcJ1nKcXMhl2XrS1CbC87
	c9evWah+bHBFHV+Nep1VJeMXpHbdcdQDYjXLdHZ1hY+7ljNKMbdKNoIrXYBJnJTEF9hcNiYftsW
	i8jgZ6vMMv73oPhfR+VmLikg19Xy21lGoMp7Qap/yZ82Bdz2Of9n2UKHEa1RDp/wcv8FWzu4Qum
	IKPyBB+WDN2ScoBuHwvZzm4U0JPhfyBUad6PwJoWon59rSu7nK124vLH+NtYPPxplAPiMr4WZXN
	vh4BNeEy0y26gmxjsQdL/S0E8LH4zQI2VlJwnzj8ygGfehdzLRjHZIHoEERNk+57JMpBBWc0s/n
	eqvZNkdmZTxxmq6T1V9ncKzlQ==
X-Received: by 2002:a05:6402:4003:b0:6b1:d148:6e82 with SMTP id 4fb4d7f45d1cf-6b1d14870e3mr9299104a12.5.1792074967310;
        Thu, 15 Oct 2026 07:36:07 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b203839d71sm2664698a12.13.2026.10.15.07.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:36:06 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 04/14] fanotify: test event->type instead of event mask when possible
Date: Thu, 15 Oct 2026 16:35:50 +0200
Message-ID: <20261015143601.2095784-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015143601.2095784-1-amir73il@gmail.com>
References: <20261015143601.2095784-1-amir73il@gmail.com>
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

Permission events are recognized by event->type once the event
exists.  Before that, a permission event is a filesystem watcher
whose mask contains FANOTIFY_PERM_EVENTS, so those bits can be
reused by namespace events.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 33 ++++++++++++++++--------------
 fs/notify/fanotify/fanotify.h      | 24 +++++++++++++---------
 fs/notify/fanotify/fanotify_user.c | 18 ++++++++--------
 include/linux/fsnotify_backend.h   |  5 -----
 4 files changed, 41 insertions(+), 39 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 81ba1347ef73f..9dc39b16a41a7 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -193,7 +193,7 @@ static int fanotify_merge(struct fsnotify_group *group,
 	 * the event structure we have created in fanotify_handle_event() is the
 	 * one we should check for permission response.
 	 */
-	if (fanotify_is_perm_event(new->mask))
+	if (fanotify_is_perm_event(new))
 		return 0;
 
 	hlist_for_each_entry(old, hlist, merge_list) {
@@ -202,7 +202,7 @@ static int fanotify_merge(struct fsnotify_group *group,
 		if (fanotify_should_merge(old, new)) {
 			old->mask |= new->mask;
 
-			if (fanotify_is_error_event(old->mask))
+			if (fanotify_is_error_event(old))
 				FANOTIFY_EE(old)->err_count++;
 
 			return 1;
@@ -712,11 +712,9 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *dir,
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
@@ -760,6 +758,8 @@ static struct fanotify_event *fanotify_alloc_event(
 					      fid_mode);
 	struct inode *dirid = fanotify_dfid_inode(mask, data, data_type, dir);
 	const struct path *path = fsnotify_data_path(data, data_type);
+	struct fs_error_report *fs_error =
+		fsnotify_data_error_report(data, data_type);
 	u64 mnt_id = fsnotify_data_mnt_id(data, data_type);
 	struct mem_cgroup *old_memcg;
 	struct dentry *moved = NULL;
@@ -855,11 +855,12 @@ static struct fanotify_event *fanotify_alloc_event(
 	    pidfs_register_pid_gfp(pid, gfp))
 		goto out;
 
-	if (fanotify_is_perm_event(mask)) {
+	if (IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS) &&
+	    mask & FANOTIFY_PERM_EVENTS) {
 		event = fanotify_alloc_perm_event(data, data_type, gfp);
-	} else if (fanotify_is_error_event(mask)) {
-		event = fanotify_alloc_error_event(group, fsid, data,
-						   data_type, &hash);
+	} else if (fs_error) {
+		event = fanotify_alloc_error_event(group, fsid, fs_error,
+						   &hash);
 	} else if (name_event && (file_name || moved || child)) {
 		event = fanotify_alloc_name_event(dirid, fsid, file_name, child,
 						  moved, &hash, gfp);
@@ -921,7 +922,7 @@ static void fanotify_insert_event(struct fsnotify_group *group,
 
 	assert_spin_locked(&group->notification_lock);
 
-	if (!fanotify_is_hashed_event(event->mask))
+	if (!fanotify_is_hashed_event(event))
 		return;
 
 	pr_debug("%s: group=%p event=%p bucket=%u\n", __func__,
@@ -941,6 +942,8 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	struct fsnotify_event *fsn_event;
 	__kernel_fsid_t fsid = {};
 	u32 match_mask = 0;
+	bool is_perm_event = fsnotify_is_filesystem_watcher(group) &&
+			     (mask & FANOTIFY_PERM_EVENTS);
 
 	BUILD_BUG_ON(FAN_ACCESS != FS_ACCESS);
 	BUILD_BUG_ON(FAN_MODIFY != FS_MODIFY);
@@ -975,7 +978,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	pr_debug("%s: group=%p mask=%x report_mask=%x\n", __func__,
 		 group, mask, match_mask);
 
-	if (fanotify_is_perm_event(mask)) {
+	if (is_perm_event) {
 		/*
 		 * fsnotify_prepare_user_wait() fails if we race with mark
 		 * deletion.  Just let the operation pass in that case.
@@ -995,7 +998,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 		 * We don't queue overflow events for permission events as
 		 * there the access is denied and so no event is in fact lost.
 		 */
-		if (!fanotify_is_perm_event(mask))
+		if (!is_perm_event)
 			fsnotify_queue_overflow(group);
 		goto finish;
 	}
@@ -1005,17 +1008,17 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 				    fanotify_insert_event);
 	if (ret) {
 		/* Permission events shouldn't be merged */
-		BUG_ON(ret == 1 && mask & FANOTIFY_PERM_EVENTS);
+		WARN_ON(ret == 1 && is_perm_event);
 		/* Our event wasn't used in the end. Free it. */
 		fsnotify_destroy_event(group, fsn_event);
 
 		ret = 0;
-	} else if (fanotify_is_perm_event(mask)) {
+	} else if (is_perm_event) {
 		ret = fanotify_get_response(group, FANOTIFY_PERM(event),
 					    iter_info);
 	}
 finish:
-	if (fanotify_is_perm_event(mask))
+	if (is_perm_event)
 		fsnotify_finish_user_wait(iter_info);
 
 	return ret;
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 4e7c11a276746..87325d44b1b15 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -462,10 +462,14 @@ FANOTIFY_PERM(struct fanotify_event *event)
 	return container_of(event, struct fanotify_perm_event, fae);
 }
 
-static inline bool fanotify_is_perm_event(u32 mask)
+static inline bool fanotify_is_perm_event(struct fanotify_event *event)
 {
-	return IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS) &&
-		mask & FANOTIFY_PERM_EVENTS;
+	return event->type == FANOTIFY_EVENT_TYPE_PATH_PERM;
+}
+
+static inline bool fsnotify_is_overflow_event(struct fanotify_event *event)
+{
+	return event->type == FANOTIFY_EVENT_TYPE_OVERFLOW;
 }
 
 static inline bool fanotify_event_has_access_range(struct fanotify_event *event)
@@ -481,14 +485,14 @@ static inline struct fanotify_event *FANOTIFY_E(struct fsnotify_event *fse)
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
@@ -511,10 +515,10 @@ static inline const struct path *fanotify_event_path(struct fanotify_event *even
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
index d7092c85d532d..a669f233cf6e3 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -263,7 +263,7 @@ static size_t fanotify_event_len(unsigned int info_mode,
 	int fh_len;
 	int dot_len = 0;
 
-	if (fanotify_is_error_event(event->mask))
+	if (fanotify_is_error_event(event))
 		event_len += FANOTIFY_ERROR_INFO_LEN;
 
 	if (fanotify_event_has_any_dir_fh(event)) {
@@ -281,7 +281,7 @@ static size_t fanotify_event_len(unsigned int info_mode,
 		fh_len = fanotify_event_object_fh_len(event);
 		event_len += fanotify_fid_info_len(fh_len, dot_len);
 	}
-	if (fanotify_is_mnt_event(event->mask))
+	if (fanotify_is_mnt_event(event))
 		event_len += FANOTIFY_MNT_INFO_LEN;
 
 	if (info_mode & FAN_REPORT_PIDFD)
@@ -344,9 +344,9 @@ static struct fanotify_event *get_one_event(struct fsnotify_group *group,
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
@@ -803,7 +803,7 @@ static int copy_info_records_to_user(struct fanotify_event *event,
 		total_bytes += ret;
 	}
 
-	if (fanotify_is_error_event(event->mask)) {
+	if (fanotify_is_error_event(event)) {
 		ret = copy_error_info_to_user(event, buf, count);
 		if (ret < 0)
 			return ret;
@@ -821,7 +821,7 @@ static int copy_info_records_to_user(struct fanotify_event *event,
 		total_bytes += ret;
 	}
 
-	if (fanotify_is_mnt_event(event->mask)) {
+	if (fanotify_is_mnt_event(event)) {
 		ret = copy_mnt_info_to_user(event, buf, count);
 		if (ret < 0)
 			return ret;
@@ -943,7 +943,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	if (pidfd_file)
 		fd_install(pidfd, pidfd_file);
 
-	if (fanotify_is_perm_event(event->mask))
+	if (fanotify_is_perm_event(event))
 		FANOTIFY_PERM(event)->fd = fd;
 
 	return metadata.event_len;
@@ -1026,7 +1026,7 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
 		 * Permission events get queued to wait for response.  Other
 		 * events can be destroyed now.
 		 */
-		if (!fanotify_is_perm_event(event->mask)) {
+		if (!fanotify_is_perm_event(event)) {
 			fsnotify_destroy_event(group, &event->fse);
 		} else {
 			if (ret <= 0 || FANOTIFY_PERM(event)->fd < 0) {
@@ -1123,7 +1123,7 @@ static int fanotify_release(struct inode *ignored, struct file *file)
 	while ((fsn_event = fsnotify_remove_first_event(group))) {
 		struct fanotify_event *event = FANOTIFY_E(fsn_event);
 
-		if (!(event->mask & FANOTIFY_PERM_EVENTS)) {
+		if (!fanotify_is_perm_event(event)) {
 			spin_unlock(&group->notification_lock);
 			fsnotify_destroy_event(group, fsn_event);
 		} else {
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 3bcdec669e8eb..15f7abd77c065 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -805,11 +805,6 @@ static inline void fsnotify_queue_overflow(struct fsnotify_group *group)
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
2.55.0

