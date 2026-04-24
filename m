Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FEA33F5B6
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050313; cv=none; b=iqc9LsPXYQN/rXv9TqzgZFNLcR5GILlOYJmAX+a+MfuDE44hmj0GOsiNWrX9GQjC/7Z2QO/vHvEC8+k5ZqalCstb04YvCY6m1SqDkUV5fACQFr8rJ+2VgpNk/sjQAw50eLMfSsk5MZV1D7caobhYQYzzGfd+SrR/9gbIX5vkoVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050313; c=relaxed/simple;
	bh=mS2VQ/0HOOntzPq6tfUIDSzwkrTzRvjSpHAJ1VtRxgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=urhBcf/57QIZs9cfga4hoq3w3yaaG/EzdQpVNpdc/wejvkHNI/uobtqoG109NPFf7jrRZRp1mVcE5MNDbxMigDT0dZCJjXcNDwj7OWZxRok+IQ7oFzi5k8LJW2zmYrvLffK482xxTEImNMrlIk+WKbcwfl3RT/MFzuXQwf/wnj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oUymFc2s; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oUymFc2s"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b9c01854477so322937366b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 10:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777050309; x=1777655109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3MG8kVoXcknoSvVGFT7c71jpQhq1kdmvgRmbzYwc1cA=;
        b=oUymFc2shD+8zl/1jWzWyYTVbRpvWNKrwFhuGf/TjAdDcCWr5eziPDjM39i2eKzKhJ
         DxBG0THiBuXbad8iZ8AF+Bz3M/x9C1tyP1s8R2PACVIqdHkaghFPo7pWj+JoyVgqe2NF
         /eCif691fY0ScDEvwS2EcQVxmJAunuAMt3Od3Z+gezsOddEhpnkKl1YOLWAIqHqiJtQK
         M64tegAfNUpomQXXpJGUk066JuYyDAcVhTrg08N/Jc6I5nGeU35F/6VTlsABaBjbJxNm
         IYmYP+WZPOpjh/8EnyKqiQH/XcMyQI4yTrLz1Wbk5EcjAqfP9CWEumSWufBhaM8l5OfB
         RjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777050309; x=1777655109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3MG8kVoXcknoSvVGFT7c71jpQhq1kdmvgRmbzYwc1cA=;
        b=UqNTfzbRs0x7qxLpt2RgOJM1Ruc3l2nphx5hRhhIkgbgFtqvT4+YzdbEMFjhvzxh5/
         oshqiAq8ccJE8bvM5ljJ688A4PR0KFN5xTcsIC86xsuKdiyO6QopcgTuuHiM27IDXnOu
         Mswif39Uvz2zHvfwTT6lrC0Ge2QlcxFesLnr9nnx8oI6Wud/D3tIeohDwlW/bBGOC5EU
         iltNtSBbble7B6zm9yLPSWW/1/1shIc8VIy15wfRWXNv9KapThflbnvOQV/00OPiNerA
         I8DYmD0ysfC4EEYTQBxi5g/GYKcGJMDXN0B5YIVkRBV7V60wHMZeimOEozVX5Ry0sKxC
         Ta6Q==
X-Forwarded-Encrypted: i=1; AFNElJ9214h1OmBAimfHZqz8U+RUnR2QZZHvZNTkTsCZfJ9pcR9EXcK3SYj8OHn2fDsRwMXE2pZghInR4fXwyRn3@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ISt2lIJ6hrGczZdpl9z4F2jsgOTfZV20/kZTZcjoczbLfXap
	gbjfW1ndyvxHI3IVViy7/YI3FEpX6m1P1XVhqTbmhSOzcqfFUAyWIe99
X-Gm-Gg: AeBDievpkZ1bo/W+u3oj1HZFmFQMBdxXTRbLOI+Wrdk8INty+pNSbpd7sX6sN4E7Gri
	6s9Cvg8Vccs2jQlzzeHNHNXpNoZP/6ndz7E8OAmw1vXG+TY4u1viWRR9Kogp8QsyWdssferrpGX
	8PqxtWGBoPYwTEJHdnc4tIkHzMltiwZHTNWTllhZoVOpTLMY23Mo+52UgTEgitVGipJ8EQ9CmKN
	8lnHfgHfWIVLNrVdQ54siym1W0a2csZyYm5DrCAlB8U1MEvG+HJBrCL24HLbZ2hbQSe7eikf5fj
	HmckSKaXQz0YKjobZBsm4S8pZLZJQnnkI6j2pxE0bt6JUH8ngfCt6JZU+s97RrGqr2ETKnPwCOa
	TLP0Z7BPe661I9yhMAhzpKxyd9pTmC7zdURgskkYuQcdlDj4nd3MLgzCtMpdGgWG7qCFFPIEDUb
	p2edqeewAjdGK70n9hEirEOKYEgkZ8do/pY2PSTPFXDf5QjIKpm2w15G7/UqxB36pC3IafD69YF
	faPKs4P88ZGPFUDXZnwsygYcRi/1Lpbxv9qWgc=
X-Received: by 2002:a17:907:1c13:b0:ba7:d1e3:8b81 with SMTP id a640c23a62f3a-ba7d1e38c4amr1221458466b.48.1777050309077;
        Fri, 24 Apr 2026 10:05:09 -0700 (PDT)
Received: from localhost (2001-1c00-570d-ee00-4aab-734a-1928-df3f.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:4aab:734a:1928:df3f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6771dfcf628sm1781784a12.24.2026.04.24.10.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 10:05:08 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 03/10] fsnotify: separate the events bitmask macros by group type
Date: Fri, 24 Apr 2026 19:04:56 +0200
Message-ID: <20260424170503.2096847-4-amir73il@gmail.com>
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

Fork the macros ALL_FSNOTIFY_EVENTS and FANOTIFY_EVENTS to
*_EVENTS_ON_{FS,NS} and use them to determine the valid mask for
fanotify_mark() and the outgoing mask by the group type.

Use the fanotify_is_valid_mask() helepr to simplifies the check for
reporting mount events IFF group was initialized with FAN_REPORT_MNT
and IFF watching an mntns object.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      |  3 +-
 fs/notify/fanotify/fanotify_user.c | 68 ++++++++++++++++++++----------
 fs/notify/fsnotify.c               |  6 +--
 include/linux/fanotify.h           | 26 ++++++++----
 include/linux/fsnotify_backend.h   | 42 ++++++++++++------
 include/uapi/linux/fanotify.h      | 25 ++++++++---
 6 files changed, 113 insertions(+), 57 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index e768c25262e27..494bba49634e1 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -303,7 +303,7 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 				     struct inode *dir)
 {
 	__u32 marks_mask = 0, marks_ignore_mask = 0;
-	__u32 test_mask, user_mask = FANOTIFY_OUTGOING_EVENTS |
+	__u32 test_mask, user_mask = FANOTIFY_OUTGOING_FS_EVENTS |
 				     FANOTIFY_EVENT_FLAGS;
 	const struct path *path = fsnotify_data_path(data, data_type);
 	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
@@ -315,6 +315,7 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 		 __func__, iter_info->report_mask, event_mask, data, data_type);
 
 	if (fsnotify_is_ns_watcher(group)) {
+		user_mask = FANOTIFY_OUTGOING_NS_EVENTS;
 		if (data_type != FSNOTIFY_EVENT_MNT)
 			return 0;
 	} else if (WARN_ON_ONCE(!fsnotify_is_fs_watcher(group))) {
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 95e7c24c70249..7afb017d40f50 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -830,6 +830,19 @@ static int copy_info_records_to_user(struct fanotify_event *event,
 	return total_bytes;
 }
 
+static __u64 fanotify_event_mask(struct fsnotify_group *group,
+				 struct fanotify_event *event)
+{
+	switch (group->type) {
+	case FSNOTIFY_GROUP_TYPE_FS:
+		return event->mask & FANOTIFY_OUTGOING_FS_EVENTS;
+	case FSNOTIFY_GROUP_TYPE_NS:
+		return event->mask & FANOTIFY_OUTGOING_NS_EVENTS;
+	}
+
+	return 0;
+}
+
 static ssize_t copy_event_to_user(struct fsnotify_group *group,
 				  struct fanotify_event *event,
 				  char __user *buf, size_t count)
@@ -848,7 +861,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	metadata.metadata_len = FAN_EVENT_METADATA_LEN;
 	metadata.vers = FANOTIFY_METADATA_VERSION;
 	metadata.reserved = 0;
-	metadata.mask = event->mask & FANOTIFY_OUTGOING_EVENTS;
+	metadata.mask = fanotify_event_mask(group, event);
 	metadata.pid = pid_vnr(event->pid);
 	/*
 	 * For an unprivileged listener, event->pid can be used to identify the
@@ -1881,6 +1894,35 @@ static int fanotify_events_supported(struct fsnotify_group *group,
 	return 0;
 }
 
+static bool fanotify_is_valid_mask(struct fsnotify_group *group, int mark_type,
+				   __u64 mask)
+{
+	u32 valid_mask = 0;
+
+	/*
+	 * Event bits for different group type may be overloaded but event
+	 * flags are common to all group types.
+	 */
+	BUILD_BUG_ON(FANOTIFY_EVENTS_ON_FS & FANOTIFY_EVENT_FLAGS);
+	BUILD_BUG_ON(FANOTIFY_EVENTS_ON_NS & FANOTIFY_EVENT_FLAGS);
+
+	switch (group->type) {
+	case FSNOTIFY_GROUP_TYPE_FS:
+		valid_mask = FANOTIFY_EVENTS_ON_FS | FANOTIFY_EVENT_FLAGS;
+		if (!IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS))
+			valid_mask &= ~FANOTIFY_PERM_EVENTS;
+		break;
+	case FSNOTIFY_GROUP_TYPE_NS:
+		/* Only report mount events on mntns mark */
+		if (mark_type == FAN_MARK_MNTNS &&
+		    FAN_GROUP_FLAG(group, FAN_REPORT_MNT))
+			valid_mask = FANOTIFY_MOUNT_EVENTS;
+		break;
+	}
+
+	return !(mask & ~valid_mask);
+}
+
 static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 			    int dfd, const char  __user *pathname)
 {
@@ -1890,7 +1932,6 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	struct fan_fsid __fsid, *fsid = NULL;
 	struct user_namespace *user_ns = NULL;
 	struct mnt_namespace *mntns;
-	u32 valid_mask = FANOTIFY_EVENTS | FANOTIFY_EVENT_FLAGS;
 	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
 	unsigned int mark_cmd = flags & FANOTIFY_MARK_CMD_BITS;
 	unsigned int ignore = flags & FANOTIFY_MARK_IGNORE_BITS;
@@ -1945,13 +1986,6 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		return -EINVAL;
 	}
 
-	if (IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS))
-		valid_mask |= FANOTIFY_PERM_EVENTS;
-
-	if (mask & ~valid_mask)
-		return -EINVAL;
-
-
 	/* We don't allow FAN_MARK_IGNORE & FAN_MARK_IGNORED_MASK together */
 	if (ignore == (FAN_MARK_IGNORE | FAN_MARK_IGNORED_MASK))
 		return -EINVAL;
@@ -1974,22 +2008,10 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		return -EINVAL;
 	group = fd_file(f)->private_data;
 
-	if (group->type != group_type)
+	if (group->type != group_type ||
+	    !fanotify_is_valid_mask(group, mark_type, mask))
 		return -EINVAL;
 
-	/* Only report mount events on mnt namespace */
-	if (FAN_GROUP_FLAG(group, FAN_REPORT_MNT)) {
-		if (mask & ~FANOTIFY_MOUNT_EVENTS)
-			return -EINVAL;
-		if (mark_type != FAN_MARK_MNTNS)
-			return -EINVAL;
-	} else {
-		if (mask & FANOTIFY_MOUNT_EVENTS)
-			return -EINVAL;
-		if (mark_type == FAN_MARK_MNTNS)
-			return -EINVAL;
-	}
-
 	/*
 	 * A user is allowed to setup sb/mount/mntns marks only if it is
 	 * capable in the user ns where the group was created.
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index b646a861a84c6..429ce614233ce 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -149,7 +149,7 @@ static inline __u32 fsnotify_object_watched(struct inode *inode, __u32 mnt_mask,
 	__u32 marks_mask = READ_ONCE(inode->i_fsnotify_mask) | mnt_mask |
 			   READ_ONCE(inode->i_sb->s_fsnotify_mask);
 
-	return mask & marks_mask & ALL_FSNOTIFY_EVENTS;
+	return mask & marks_mask & FSNOTIFY_EVENTS_ON_FS;
 }
 
 /* Report pre-content event with optional range info */
@@ -219,7 +219,7 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 	 * events can provide an undesirable side-channel for information
 	 * exfiltration.
 	 */
-	parent_interested = mask & p_mask & ALL_FSNOTIFY_EVENTS &&
+	parent_interested = mask & p_mask & FSNOTIFY_EVENTS_ON_FS &&
 			    !(data_type == FSNOTIFY_EVENT_PATH &&
 			      d_is_special(dentry) &&
 			      (mask & (FS_ACCESS | FS_MODIFY)));
@@ -266,7 +266,7 @@ static int fsnotify_handle_inode_event(struct fsnotify_group *group,
 		return 0;
 
 	/* Check interest of this mark in case event was sent with two marks */
-	if (!(mask & inode_mark->mask & ALL_FSNOTIFY_EVENTS))
+	if (!(mask & inode_mark->mask & FSNOTIFY_EVENTS_ON_FS))
 		return 0;
 
 	return ops->handle_inode_event(inode_mark, mask, inode, dir, name, cookie);
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 1a09400b843b5..224303a0c31e1 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -113,27 +113,35 @@
 /* Events that can only be reported with data type FSNOTIFY_EVENT_ERROR */
 #define FANOTIFY_ERROR_EVENTS	(FAN_FS_ERROR)
 
+/* Events that user can request to be notified on filesystem watchers */
+#define FANOTIFY_EVENTS_ON_FS	(FANOTIFY_PATH_EVENTS | \
+				 FANOTIFY_PERM_EVENTS | \
+				 FANOTIFY_INODE_EVENTS | \
+				 FANOTIFY_ERROR_EVENTS)
+
+/* Mount tree monitoring events */
 #define FANOTIFY_MOUNT_EVENTS	(FAN_MNT_ATTACH | FAN_MNT_DETACH)
 
-/* Events that user can request to be notified on */
-#define FANOTIFY_EVENTS		(FANOTIFY_PATH_EVENTS | \
-				 FANOTIFY_INODE_EVENTS | \
-				 FANOTIFY_ERROR_EVENTS | \
-				 FANOTIFY_MOUNT_EVENTS)
+/* Events that user can request to be notified on namepsace watchers */
+#define FANOTIFY_EVENTS_ON_NS	(FANOTIFY_MOUNT_EVENTS)
 
 /* Extra flags that may be reported with event or control handling of events */
 #define FANOTIFY_EVENT_FLAGS	(FAN_EVENT_ON_CHILD | FAN_ONDIR)
 
-/* Events that may be reported to user */
-#define FANOTIFY_OUTGOING_EVENTS	(FANOTIFY_EVENTS | \
-					 FANOTIFY_PERM_EVENTS | \
+/* Events that may be reported to user on filesystem watchers */
+#define FANOTIFY_OUTGOING_FS_EVENTS	(FANOTIFY_EVENTS_ON_FS | \
 					 FAN_Q_OVERFLOW | FAN_ONDIR)
 
+/* Events that may be reported to user on namepsace watchers */
+#define FANOTIFY_OUTGOING_NS_EVENTS	(FANOTIFY_EVENTS_ON_NS | \
+					 FAN_Q_OVERFLOW)
+
 /* Events and flags relevant only for directories */
 #define FANOTIFY_DIRONLY_EVENT_BITS	(FANOTIFY_DIRENT_EVENTS | \
 					 FAN_EVENT_ON_CHILD | FAN_ONDIR)
 
-#define ALL_FANOTIFY_EVENT_BITS		(FANOTIFY_OUTGOING_EVENTS | \
+#define ALL_FANOTIFY_EVENT_BITS		(FANOTIFY_OUTGOING_FS_EVENTS | \
+					 FANOTIFY_OUTGOING_NS_EVENTS | \
 					 FANOTIFY_EVENT_FLAGS)
 
 /* These masks check for invalid bits in permission responses. */
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 698fc75b0b6d4..8f2821735f068 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -59,22 +59,30 @@
 
 #define FS_PRE_ACCESS		0x00100000	/* Pre-content access hook */
 
-#define FS_MNT_ATTACH		0x01000000	/* Mount was attached */
-#define FS_MNT_DETACH		0x02000000	/* Mount was detached */
-#define FS_MNT_MOVE		(FS_MNT_ATTACH | FS_MNT_DETACH)
+#define FS_RENAME		0x10000000	/* File was renamed */
+
+#define FS_MOVE			(FS_MOVED_FROM | FS_MOVED_TO)
 
 /*
- * Set on inode mark that cares about things that happen to its children.
- * Always set for dnotify and inotify.
+ * Filter flags for watching filesystems
+ *
+ * NOTE: The ON_CHILD flag is set on inode mark that cares about things that
+ * happen to its children.  Always set for dnotify and inotify.
  * Set on inode/sb/mount marks that care about parent/name info.
  */
 #define FS_EVENT_ON_CHILD	0x08000000
-
-#define FS_RENAME		0x10000000	/* File was renamed */
 #define FS_DN_MULTISHOT		0x20000000	/* dnotify multishot */
 #define FS_ISDIR		0x40000000	/* event occurred against dir */
 
-#define FS_MOVE			(FS_MOVED_FROM | FS_MOVED_TO)
+/*
+ * Events that user-space can request when watching namespaces
+ *
+ * NOTE: These values may overload filesystem events, but not event flags
+ */
+#define FS_MNT_ATTACH		0x01000000	/* Mount was attached */
+#define FS_MNT_DETACH		0x02000000	/* Mount was detached */
+#define FS_MNT_MOVE		(FS_MNT_ATTACH | FS_MNT_DETACH)
+
 
 /*
  * Directory entry modification events - reported only to directory
@@ -84,9 +92,6 @@
  */
 #define ALL_FSNOTIFY_DIRENT_EVENTS (FS_CREATE | FS_DELETE | FS_MOVE | FS_RENAME)
 
-/* Mount namespace events */
-#define FSNOTIFY_MNT_EVENTS (FS_MNT_ATTACH | FS_MNT_DETACH)
-
 /* Content events can be used to inspect file content */
 #define FSNOTIFY_CONTENT_PERM_EVENTS (FS_OPEN_PERM | FS_OPEN_EXEC_PERM | \
 				      FS_ACCESS_PERM)
@@ -113,14 +118,23 @@
  */
 #define FS_EVENTS_POSS_TO_PARENT (FS_EVENTS_POSS_ON_CHILD)
 
-/* Events that can be reported to backends */
-#define ALL_FSNOTIFY_EVENTS (ALL_FSNOTIFY_DIRENT_EVENTS | \
-			     FSNOTIFY_MNT_EVENTS | \
+/* Events that can be reported to backends on filesystem watchers */
+#define FSNOTIFY_EVENTS_ON_FS (ALL_FSNOTIFY_DIRENT_EVENTS | \
 			     FS_EVENTS_POSS_ON_CHILD | \
 			     FS_DELETE_SELF | FS_MOVE_SELF | \
 			     FS_UNMOUNT | FS_Q_OVERFLOW | FS_IN_IGNORED | \
 			     FS_ERROR)
 
+/* Mount tree monitoring events */
+#define FSNOTIFY_MNT_EVENTS (FS_MNT_ATTACH | FS_MNT_DETACH)
+
+/* Events that can be reported to backends on namepsace watchers */
+#define FSNOTIFY_EVENTS_ON_NS (FSNOTIFY_MNT_EVENTS | \
+			       FS_Q_OVERFLOW)
+
+/* Events that can be reported to backends */
+#define ALL_FSNOTIFY_EVENTS (FSNOTIFY_EVENTS_ON_FS | FSNOTIFY_EVENTS_ON_NS)
+
 /* Extra flags that may be reported with event or control handling of events */
 #define ALL_FSNOTIFY_FLAGS  (FS_ISDIR | FS_EVENT_ON_CHILD | FS_DN_MULTISHOT)
 
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index e710967c7c263..cfcd193aee3e2 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -4,7 +4,9 @@
 
 #include <linux/types.h>
 
-/* the following events that user-space can register for */
+/*
+ * Events that user-space can request when watching filesystems
+ */
 #define FAN_ACCESS		0x00000001	/* File was accessed */
 #define FAN_MODIFY		0x00000002	/* File was modified */
 #define FAN_ATTRIB		0x00000004	/* Metadata changed */
@@ -28,19 +30,28 @@
 /* #define FAN_DIR_MODIFY	0x00080000 */	/* Deprecated (reserved) */
 
 #define FAN_PRE_ACCESS		0x00100000	/* Pre-content access hook */
-#define FAN_MNT_ATTACH		0x01000000	/* Mount was attached */
-#define FAN_MNT_DETACH		0x02000000	/* Mount was detached */
-
-#define FAN_EVENT_ON_CHILD	0x08000000	/* Interested in child events */
 
 #define FAN_RENAME		0x10000000	/* File was renamed */
 
-#define FAN_ONDIR		0x40000000	/* Event occurred against dir */
-
 /* helper events */
 #define FAN_CLOSE		(FAN_CLOSE_WRITE | FAN_CLOSE_NOWRITE) /* close */
 #define FAN_MOVE		(FAN_MOVED_FROM | FAN_MOVED_TO) /* moves */
 
+/*
+ * Filter flags for watching filesystems
+ */
+#define FAN_EVENT_ON_CHILD	0x08000000	/* Interested in child events */
+#define FAN_ONDIR		0x40000000	/* Event occurred against dir */
+
+/*
+ * Events that user-space can request when watching namespaces
+ *
+ * NOTE: These values may overload filesystem events, but not event flags
+ */
+#define FAN_MNT_ATTACH		0x01000000	/* Mount was attached */
+#define FAN_MNT_DETACH		0x02000000	/* Mount was detached */
+
+
 /* flags used for fanotify_init() */
 #define FAN_CLOEXEC		0x00000001
 #define FAN_NONBLOCK		0x00000002
-- 
2.54.0

