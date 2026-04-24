Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8444E3D813E
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 17:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050317; cv=none; b=hxkE3xmXKX7h7aQrORvxoqEtg72KSxywFB6qJ1uf/6me3UJAo8rasymreali68gFowaK3jXJv3rvhZbKP2rupnkJo0B/L2sM7w/M6oH043doRsLg9zZvHjZSDbvkWGhrS1/EvkqpXFrLne6lQoWyf2NX9d+NM+ocDiiw5KQsJqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050317; c=relaxed/simple;
	bh=hXu6abQbBq1k+C3x6h2ZYlGBw6P5rC0pds9JYidf0Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ke16zoImNsvzCM8As2fEpOmqYFKx+dy5zjtxtEl5fs50EbkK9SQjZ8C542ZF9DjWyArHlY7TzxF/5+zb3IxzAxNWz4AxegD8gzpJzxJ7S9MLlaXh/TdXU4C2VsSmAZXdyCLFSP78MyBG44ppNt6UX6/70WHwXKhmC07W6E7TVI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfuaIezB; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfuaIezB"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6715006f4f7so12275076a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 10:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777050314; x=1777655114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=If/dUV9LmFOVwNzWJdH/qwgC2VqKoG5ERl8vi0A7sNM=;
        b=gfuaIezB2dZJnHySRfZsGGbrY3dd4aIjW1bn+eCEZTxnCIsKeDBDhBTWj5uPRFuw2M
         8ElPXogQ2y8Fgq0vvyPmXIbIgitn3ilpadYQs5NaxRt5Ofm0up2B0TRAvpzqPta+B4t8
         /yySjgr9rMnAfofUzry9pJK7JOjtlQTMhz2tkZDL3SO6H5yIA60IAowXMzZfCySy6z1C
         SyoKj77Lo+/KmK4qM1iuATG44EmipUvPU3v1K79LcmDDv3RmxKWFzSpdb0Dq935JIydT
         363aVIsq+ZvgiI552/+eSDzXgIzgIIXehzsDo2f8+bSf4beXevXHrUq/OecIBhgjWQso
         RAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777050314; x=1777655114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=If/dUV9LmFOVwNzWJdH/qwgC2VqKoG5ERl8vi0A7sNM=;
        b=Wn0lmDuLufKby3xtYPbJVHxLJD+3vLhQOolZ37HuE1d2FE6qCyDr5LF34sW3WZEEGe
         h3OKvtlLYkmW14AEa0uqHLOdOBUKDrP4KPlOYXFnS0MrwBKeRRuNw8orr8Lh7UhKkKQZ
         vpcm4JGeq5to9mo5IWiHPsYISrxtCheB2wnSU/rqgQc7Hb7wW+WIsHmbLe1ZVZwkyt2h
         ibRNDgliKBf0/y9slQLuEuLB0oORw0AaPWJOgSc/pb4d+ZiskQowEMtzcA0+KcanlMwq
         gi1vhM+UQtLrYpbE03M1+OcrnBt61hqdLF1nUROHjZmEJbeuKFQEeWwGgioHlAKEwQCm
         A0gA==
X-Forwarded-Encrypted: i=1; AFNElJ9p/uRzOqkwrgF8FW5X8HQC9+4V55S3fmB8D4mzzqjiGzYSgTv0LMgxcWzFDuXKoC/o0docE3SctmafJr1B@vger.kernel.org
X-Gm-Message-State: AOJu0YwyH3JYj7fMVEAJ+BhfIa0+e2IgJHBQvyNk+yfUfGuUqDkHv8FV
	7hTL9qvOWfNyBATz2tF3bhC8ihBKvhYeUfjDNgnlun/7Lj+Xe/D6zB97
X-Gm-Gg: AeBDiesiC3HPMYrgoBV3tM3s/HMtC6j9oY5C7D9p91owc4MewfKuyVlk6CLMyK+SHWN
	j5q9RmjD2rm8v4Ajy60mzPcijKwfTZ6idP4Ngnyez+64PIxj5kH4u+StMkpi18HosgNCrfWpYDh
	aaHJowZYD9ICzJJiSFGMGmW8lDmm8iwmHbbk2xvoL54a14Q2zlPl9DeIV7OFENZbFo0yeU3YYPn
	5HTk/xbRtARGSZUArz6uCASaV4cQ0uGFbIKmjwhaR6OFYeqCA1CCbK9zWlxPAa4KLBjsj0gkwXX
	iJEIdZznDc/gILiU6WuG/ZczKd9tWV5W2h4LFuGgflqBnYd8M1lAXmlLpwSlhAmXTFUaeczCFIL
	7SwTf3LrIJvlQ5b3DIGgO34orPCbHKOp3qJ9SyLq2lgKbxp7DW4luUkIlqzMYd34iMZQYmaUGpV
	YYB+jeI4dbwGK+QU3tyGo69X8utn4+NkciDz9dX1atAIET8YWyB3emPDpoPoMbqPvat08oq5+PU
	n0SsmuUTK2KIdoi1m4t8NAQuSXGU7V5oohzWvY=
X-Received: by 2002:aa7:c907:0:b0:678:459a:774 with SMTP id 4fb4d7f45d1cf-678459a0cdcmr3139760a12.11.1777050313667;
        Fri, 24 Apr 2026 10:05:13 -0700 (PDT)
Received: from localhost (2001-1c00-570d-ee00-4aab-734a-1928-df3f.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:4aab:734a:1928:df3f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-672c4d69708sm5067352a12.28.2026.04.24.10.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 10:05:12 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 07/10] fanotify: gate fs events checks in fanotify_mark() by group type
Date: Fri, 24 Apr 2026 19:05:00 +0200
Message-ID: <20260424170503.2096847-8-amir73il@gmail.com>
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

fanotify_mark() has plenty of checks on the event mask.
The event mask bits that correspond to filesystem watchers are only
meaningful in the context of filesystem group type.

Hence, before checking if event is a specific event (e.g. FAN_FS_ERROR)
need to check that the group type as well (e.g. filesystem).

Add helpers fanotify_test_{fs,ns}_watcher_event() and use them instead
of checking the event mask directly.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.h      | 16 ++++++++++--
 fs/notify/fanotify/fanotify_user.c | 39 ++++++++++++++++++------------
 2 files changed, 38 insertions(+), 17 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 13e3787ddd558..56bbee15b7ee3 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -458,12 +458,24 @@ FANOTIFY_PERM(struct fanotify_event *event)
 	return container_of(event, struct fanotify_perm_event, fae);
 }
 
+static inline bool fanotify_test_fs_watcher_event(struct fsnotify_group *group,
+						  u32 mask, u32 test_mask)
+{
+	return fsnotify_is_fs_watcher(group) && (mask & test_mask);
+}
+
+static inline bool fanotify_test_ns_watcher_event(struct fsnotify_group *group,
+						  u32 mask, u32 test_mask)
+{
+	return fsnotify_is_ns_watcher(group) && (mask & test_mask);
+}
+
 static inline bool fanotify_is_fs_perm_event(struct fsnotify_group *group,
 					     u32 mask)
 {
 	return IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS) &&
-		fsnotify_is_fs_watcher(group) &&
-		mask & FANOTIFY_PERM_EVENTS;
+		fanotify_test_fs_watcher_event(group, mask,
+					       FANOTIFY_PERM_EVENTS);
 }
 
 static inline bool fanotify_is_perm_event(struct fanotify_event *event)
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index c41c83d86518a..4c1767b3c1a06 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1509,7 +1509,9 @@ static int fanotify_may_update_existing_mark(struct fsnotify_mark *fsn_mark,
 
 	/* For now pre-content events are not generated for directories */
 	mask |= fsn_mark->mask;
-	if (mask & FANOTIFY_PRE_CONTENT_EVENTS && mask & FAN_ONDIR)
+	if (mask & FAN_ONDIR &&
+	    fanotify_test_fs_watcher_event(fsn_mark->group, mask,
+					   FANOTIFY_PRE_CONTENT_EVENTS))
 		return -EEXIST;
 
 	return 0;
@@ -1546,8 +1548,8 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 	 * Error events are pre-allocated per group, only if strictly
 	 * needed (i.e. FAN_FS_ERROR was requested).
 	 */
-	if (!(fan_flags & FANOTIFY_MARK_IGNORE_BITS) &&
-	    (mask & FAN_FS_ERROR)) {
+	if (fanotify_test_fs_watcher_event(group, mask, FAN_FS_ERROR) &&
+	    !(fan_flags & FANOTIFY_MARK_IGNORE_BITS)) {
 		ret = fanotify_group_init_error_pool(group);
 		if (ret)
 			goto out;
@@ -1562,7 +1564,8 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 
 	fsnotify_put_mark(fsn_mark);
 
-	if (!ret && (mask & FANOTIFY_PERM_EVENTS))
+	if (!ret && fanotify_test_fs_watcher_event(group, mask,
+						   FANOTIFY_PERM_EVENTS))
 		fanotify_perm_watchdog_group_add(group);
 
 	return ret;
@@ -1842,14 +1845,15 @@ static int fanotify_events_supported(struct fsnotify_group *group,
 	bool is_dir = d_is_dir(path->dentry);
 	/* Strict validation of events in non-dir inode mask with v5.17+ APIs */
 	bool strict_dir_events = FAN_GROUP_FLAG(group, FAN_REPORT_TARGET_FID) ||
-				 (mask & FAN_RENAME) ||
-				 (flags & FAN_MARK_IGNORE);
+		 fanotify_test_fs_watcher_event(group, mask, FAN_RENAME) ||
+		 (flags & FAN_MARK_IGNORE);
 
 	/*
 	 * Filesystems need to opt-into pre-content evnets (a.k.a HSM)
 	 * and they are only supported on regular files and directories.
 	 */
-	if (mask & FANOTIFY_PRE_CONTENT_EVENTS) {
+	if (fanotify_test_fs_watcher_event(group, mask,
+					   FANOTIFY_PRE_CONTENT_EVENTS)) {
 		if (!(path->mnt->mnt_sb->s_iflags & SB_I_ALLOW_HSM))
 			return -EOPNOTSUPP;
 		if (!is_dir && !d_is_reg(path->dentry))
@@ -1864,7 +1868,7 @@ static int fanotify_events_supported(struct fsnotify_group *group,
 	 * waits for fanotify permission event to be answered. Just disallow
 	 * permission events for such filesystems.
 	 */
-	if (mask & FANOTIFY_PERM_EVENTS &&
+	if (fanotify_test_fs_watcher_event(group, mask, FANOTIFY_PERM_EVENTS) &&
 	    path->mnt->mnt_sb->s_type->fs_flags & FS_DISALLOW_NOTIFY_PERM)
 		return -EINVAL;
 
@@ -1887,8 +1891,9 @@ static int fanotify_events_supported(struct fsnotify_group *group,
 	 * flags FAN_ONDIR and FAN_EVENT_ON_CHILD in mask of non-dir inode,
 	 * but because we always allowed it, error only when using new APIs.
 	 */
-	if (strict_dir_events && mark_type == FAN_MARK_INODE &&
-	    !is_dir && (mask & FANOTIFY_DIRONLY_EVENT_BITS))
+	if (strict_dir_events && mark_type == FAN_MARK_INODE && !is_dir &&
+	    fanotify_test_fs_watcher_event(group, mask,
+					   FANOTIFY_DIRONLY_EVENT_BITS))
 		return -ENOTDIR;
 
 	return 0;
@@ -2024,14 +2029,15 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	 * Permission events are not allowed for FAN_CLASS_NOTIF.
 	 * Pre-content permission events are not allowed for FAN_CLASS_CONTENT.
 	 */
-	if (mask & FANOTIFY_PERM_EVENTS &&
+	if (fanotify_test_fs_watcher_event(group, mask, FANOTIFY_PERM_EVENTS) &&
 	    group->priority == FSNOTIFY_PRIO_NORMAL)
 		return -EINVAL;
-	else if (mask & FANOTIFY_PRE_CONTENT_EVENTS &&
+	else if (fanotify_test_fs_watcher_event(group, mask,
+						FANOTIFY_PRE_CONTENT_EVENTS) &&
 		 group->priority == FSNOTIFY_PRIO_CONTENT)
 		return -EINVAL;
 
-	if (mask & FAN_FS_ERROR &&
+	if (fanotify_test_fs_watcher_event(group, mask, FAN_FS_ERROR) &&
 	    mark_type != FAN_MARK_FILESYSTEM)
 		return -EINVAL;
 
@@ -2061,11 +2067,14 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	 * new parent+name.  Reporting only old and new parent id is less
 	 * useful and was not implemented.
 	 */
-	if (mask & FAN_RENAME && !(fid_mode & FAN_REPORT_NAME))
+	if (fanotify_test_fs_watcher_event(group, mask, FAN_RENAME) &&
+	    !(fid_mode & FAN_REPORT_NAME))
 		return -EINVAL;
 
 	/* Pre-content events are not currently generated for directories. */
-	if (mask & FANOTIFY_PRE_CONTENT_EVENTS && mask & FAN_ONDIR)
+	if (mask & FAN_ONDIR &&
+	    fanotify_test_fs_watcher_event(group, mask,
+					   FANOTIFY_PRE_CONTENT_EVENTS))
 		return -EINVAL;
 
 	if (mark_cmd == FAN_MARK_FLUSH) {
-- 
2.54.0

