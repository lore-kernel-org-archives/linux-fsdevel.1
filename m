Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA80375F82
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 14:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074972; cv=none; b=PA+NKWMkUPqpFAcCsc2U0JvbfNHO6qmO49QOwI8l4YZO8cr+4m9uXoXUksCM1IXRJ4QjnGB5cpsdPSwhSJ7GKG4qzLdbF42rjqge3661u83w+OftbNuj4tc5UNLKhnqtnrrM2NPX3eiHVz5F01GKAxeefzNV5StEYK1GGW3FvCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074972; c=relaxed/simple;
	bh=YJNzH2ikD/1xbqPZhhjtbV4YlL070/Iyef3jsRQce4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVux3imubRp/YCGKjJxG9MqjhlZXu5MzvfMQmrLg627958eYqWjeZxk/RA4qO7+0dB7eoqmwauFAKc4EVmNz1TsSVkHLrQkBqylTQJXGDl69Jp6QfnSrlo/JsVjfPbhA1h4txn9AvB/C9Txy/TyuskM1Wq0PeTv5MPwZQy7fffU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULJ5dhop; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULJ5dhop"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c3f8d72d7ceso102430266b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 07:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792074967; x=1792679767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y8r85aSw59D9OPUiHKq7ZxZ8CKhnUU/ugFPiUw87wXg=;
        b=ULJ5dhopdubBZoRDVecn3xkSpAERA1Tz1TkaA4dAH3PJLohQsEAQgQzZakvYtO+xTN
         bhVfzUt/vsVyJVE7n2bpiQG7U42/30RMxJ+vpLAYlYXIZV1uYhajsP3FxgJX1YFaDeAD
         198hf9ky+jbdG0cfGgPdsJ58sfet6qw/Hu4XKYgjgkxjDeSMb0QbjEvo42E+idfMyRwI
         3EoxkYQGaxeTpccv6t2qtzJlY3amrgNkHIf6A3j0ZmxEQe7ApWh8hDiVk/g3k8eEhaCF
         e72nVDlirVcuKpVXurSIVCRelhYms9ecc2aORtY7tStxGUR5v7j/xIBA3Mv8EjNnMD7k
         ETKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792074967; x=1792679767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y8r85aSw59D9OPUiHKq7ZxZ8CKhnUU/ugFPiUw87wXg=;
        b=WG/XFwYatDlu/QIrlrBu+NrqvVnRxOxCbTtVJv7CncOgf575rwZ7AAtjEx1lnyDzf9
         r0Z5A9rbu4UU2R2Ztr9ltMKRGeVwO/oyGl0MNHxoo+S8pXoO7eJOKsnKdod1vnDMTZpN
         1beGnjU6cB9NZtc6oSq3iv/vmO4qXIzLvWTUCbzQ97Wz3LI/uwP8/GDPFG7mUfUCBrXN
         Hfb3farQrLN/cOGg/P1C6JrWe8BmYthyUa917FU2j218rI/meVWkXKYla9m70zOPJWaz
         5krDlLvL87zR8PRFPRuBte9hCdU4W5/A10DK4vZw80/METHYJ2QL5/ut9XsOKPjmjY0s
         sLUw==
X-Forwarded-Encrypted: i=1; AKwUvBxFCdULo9jhLk3kgNw8nni94UFM6w51C6VRGMwwr9GP68gLSWeFB+Z387bbqFfDp6gUOByAsyEXJI6YpcEZ@vger.kernel.org
X-Gm-Message-State: AFq9FYLeJrKIt5HlF7badbZdwmENlvc+NFug/kCdl34y4hp/STgXgEto
	RhSZ7eliY/4f4ZlSDKmbdzh154fTJbaIy+58d9TkPeUbdjYg5ddSbI7W
X-Gm-Gg: AYBFou3cMvf0Gy7CmVFpk5UTzv9ynft1EUhmz79MjR8WyvXTst9nh8ox0AW/A9yvxhU
	g7iBpyeBJUHvRJz75pYHSdnVtPXnUVA8NABty21xBHFcDOymrzC/t2E+hSLM/aXJgck1Gd9YD5U
	5l5C4dk24/xyfHVpSzrNdL73fHycuFHYGiayGaLgWgEB+RRse23hyAIp82vGnD/WC4kZ6tOTwKc
	jsk0DWurPQ5KaAWWEjBonhV66bQZc1dp6EeINDOhAIa1igml4Yg/iMMnoi6yESxO5s0Skug1mZj
	DQu6fv2jWN69YWhe1mTylPAHa4QFmlJbnyRnvlj3Er5eknnattNEQNCjVY1b6qEuecVqqRzvKO1
	O7OfohTq5Qz2I9ryfEryCotRmZDBXRzJyQhdrmDJY0MxvHPD6iQ5vaHlIPOT8okXOzXIOefD//R
	8LqBBz6GOiJR0OAAKiwkZFG8T1sUnwlS7q5tYHAHfaIuD1iEsEHRKUtQUTMETToBmqSVMctDTyy
	Lp7TT6gKQbquEyGW7qayq0mnauX2karyfAn
X-Received: by 2002:a17:907:9810:b0:c2e:3b23:1468 with SMTP id a640c23a62f3a-c31aa0185ddmr1906273566b.48.1792074966169;
        Thu, 15 Oct 2026 07:36:06 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3ed95478efsm135109766b.27.2026.10.15.07.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:36:05 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 03/14] fsnotify: separate the events bitmask macros by group type
Date: Thu, 15 Oct 2026 16:35:49 +0200
Message-ID: <20261015143601.2095784-4-amir73il@gmail.com>
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

Fork the macros ALL_FSNOTIFY_EVENTS and FANOTIFY_EVENTS to
*_EVENTS_ON_{FILESYSTEM,NAMESPACE} and use them to determine the valid
mask for fanotify_mark() and the outgoing mask by the group type.

Use fanotify_group_outgoing_events() for both the group event mask and
the mask copied to userspace.  Rename fsnotify_object_watched() to
fsnotify_filesystem_object_watched(), because its callers only deal
with filesystem events.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      |  7 ++--
 fs/notify/fanotify/fanotify.h      | 14 ++++++++
 fs/notify/fanotify/fanotify_user.c | 56 ++++++++++++++++++------------
 fs/notify/fsnotify.c               | 14 ++++----
 include/linux/fanotify.h           | 28 +++++++++------
 include/linux/fsnotify_backend.h   | 48 ++++++++++++++++---------
 include/uapi/linux/fanotify.h      | 24 +++++++++----
 7 files changed, 124 insertions(+), 67 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index bfaec0a4fc2f4..81ba1347ef73f 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -300,9 +300,10 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 				     const void *data, int data_type,
 				     struct inode *dir)
 {
-	__u32 marks_mask = 0, marks_ignore_mask = 0;
-	__u32 test_mask, user_mask = FANOTIFY_OUTGOING_EVENTS |
-				     FANOTIFY_EVENT_FLAGS;
+	u32 marks_mask = 0, marks_ignore_mask = 0;
+	u32 test_mask, user_mask =
+		fanotify_group_outgoing_events(group, ALL_FSNOTIFY_BITS) |
+		FANOTIFY_EVENT_FLAGS;
 	const struct path *path = fsnotify_data_path(data, data_type);
 	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
 	struct fsnotify_mark *mark;
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 87ba788574bff..4e7c11a276746 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -558,3 +558,17 @@ static inline u32 fanotify_get_response_errno(int res)
 {
 	return (res >> FAN_ERRNO_SHIFT) & FAN_ERRNO_MASK;
 }
+
+/* Bits of @mask that this that this group can report to userspace */
+static inline u32 fanotify_group_outgoing_events(struct fsnotify_group *group,
+						 u32 mask)
+{
+	switch (group->type) {
+	case FSNOTIFY_GROUP_TYPE_FILESYSTEM:
+		return mask & FANOTIFY_OUTGOING_FILESYSTEM_EVENTS;
+	case FSNOTIFY_GROUP_TYPE_NAMESPACE:
+		return mask & FANOTIFY_OUTGOING_NAMESPACE_EVENTS;
+	default:
+		return 0;
+	}
+}
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 6bad0f1a17eb2..d7092c85d532d 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -851,7 +851,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	metadata.metadata_len = FAN_EVENT_METADATA_LEN;
 	metadata.vers = FANOTIFY_METADATA_VERSION;
 	metadata.reserved = 0;
-	metadata.mask = event->mask & FANOTIFY_OUTGOING_EVENTS;
+	metadata.mask = fanotify_group_outgoing_events(group, event->mask);
 	metadata.pid = pid_vnr(event->pid);
 	/*
 	 * For an unprivileged listener, event->pid can be used to identify the
@@ -1870,6 +1870,36 @@ static int fanotify_events_supported(struct fsnotify_group *group,
 	return 0;
 }
 
+static bool fanotify_is_valid_mask(struct fsnotify_group *group, int mark_type,
+				   u64 mask)
+{
+	u32 valid_mask = 0;
+
+	/*
+	 * Event bits for different group type may be overloaded but event
+	 * flags are common to all group types.
+	 */
+	BUILD_BUG_ON(FANOTIFY_EVENTS_ON_FILESYSTEM & FANOTIFY_EVENT_FLAGS);
+	BUILD_BUG_ON(FANOTIFY_EVENTS_ON_NAMESPACE & FANOTIFY_EVENT_FLAGS);
+
+	switch (group->type) {
+	case FSNOTIFY_GROUP_TYPE_FILESYSTEM:
+		valid_mask = FANOTIFY_EVENTS_ON_FILESYSTEM |
+			     FANOTIFY_EVENT_FLAGS;
+		if (!IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS))
+			valid_mask &= ~FANOTIFY_PERM_EVENTS;
+		break;
+	case FSNOTIFY_GROUP_TYPE_NAMESPACE:
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
@@ -1879,7 +1909,6 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	struct fan_fsid __fsid, *fsid = NULL;
 	struct user_namespace *user_ns = NULL;
 	struct mnt_namespace *mntns;
-	u32 valid_mask = FANOTIFY_EVENTS | FANOTIFY_EVENT_FLAGS;
 	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
 	unsigned int mark_cmd = flags & FANOTIFY_MARK_CMD_BITS;
 	unsigned int ignore = flags & FANOTIFY_MARK_IGNORE_BITS;
@@ -1934,13 +1963,6 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
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
@@ -1963,22 +1985,10 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		return -EINVAL;
 	group = fd_file(f)->private_data;
 
-	if (group->type != mark_group_type)
+	if (group->type != mark_group_type ||
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
index 7e2f330fd2837..a919a1e9bb192 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -146,13 +146,13 @@ static bool fsnotify_event_needs_parent(struct inode *inode, __u32 mnt_mask,
 }
 
 /* Are there any inode/mount/sb objects that watch for these events? */
-static inline __u32 fsnotify_object_watched(struct inode *inode, __u32 mnt_mask,
-					    __u32 mask)
+static inline u32 fsnotify_filesystem_object_watched(struct inode *inode,
+						     u32 mnt_mask, u32 mask)
 {
 	__u32 marks_mask = READ_ONCE(inode->i_fsnotify_mask) | mnt_mask |
 			   READ_ONCE(inode->i_sb->s_fsnotify_mask);
 
-	return mask & marks_mask & ALL_FSNOTIFY_EVENTS;
+	return mask & marks_mask & FSNOTIFY_EVENTS_ON_FILESYSTEM;
 }
 
 /* Report pre-content event with optional range info */
@@ -199,7 +199,7 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 
 	/* Optimize the likely case of nobody watching this path */
 	if (likely(!parent_watched &&
-		   !fsnotify_object_watched(inode, mnt_mask, mask)))
+		   !fsnotify_filesystem_object_watched(inode, mnt_mask, mask)))
 		return 0;
 
 	parent = NULL;
@@ -222,7 +222,7 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 	 * events can provide an undesirable side-channel for information
 	 * exfiltration.
 	 */
-	parent_interested = mask & p_mask & ALL_FSNOTIFY_EVENTS &&
+	parent_interested = mask & p_mask & FSNOTIFY_EVENTS_ON_FILESYSTEM &&
 			    !(data_type == FSNOTIFY_EVENT_PATH &&
 			      d_is_special(dentry) &&
 			      (mask & (FS_ACCESS | FS_MODIFY)));
@@ -269,7 +269,7 @@ static int fsnotify_handle_inode_event(struct fsnotify_group *group,
 		return 0;
 
 	/* Check interest of this mark in case event was sent with two marks */
-	if (!(mask & inode_mark->mask & ALL_FSNOTIFY_EVENTS))
+	if (!(mask & inode_mark->mask & FSNOTIFY_EVENTS_ON_FILESYSTEM))
 		return 0;
 
 	return ops->handle_inode_event(inode_mark, mask, inode, dir, name, cookie);
@@ -643,7 +643,7 @@ int fsnotify_open_perm_and_set_mode(struct file *file)
 	 * watching for permission events on *this* file.
 	 */
 	mnt_mask = READ_ONCE(real_mount(file->f_path.mnt)->mnt_fsnotify_mask);
-	p_mask = fsnotify_object_watched(d_inode(dentry), mnt_mask,
+	p_mask = fsnotify_filesystem_object_watched(d_inode(dentry), mnt_mask,
 					 ALL_FSNOTIFY_PERM_EVENTS);
 	if (dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED) {
 		parent = dget_parent(dentry);
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index ddfcfd37b231c..83ac9c98ab698 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -115,27 +115,35 @@
 /* Events that can only be reported with data type FSNOTIFY_EVENT_ERROR */
 #define FANOTIFY_ERROR_EVENTS	(FAN_FS_ERROR)
 
+/* Events that user can request to be notified on filesystem watchers */
+#define FANOTIFY_EVENTS_ON_FILESYSTEM	(FANOTIFY_PATH_EVENTS | \
+					 FANOTIFY_PERM_EVENTS | \
+					 FANOTIFY_INODE_EVENTS | \
+					 FANOTIFY_ERROR_EVENTS)
+
+/* Mount tree monitoring events */
 #define FANOTIFY_MOUNT_EVENTS	(FAN_MNT_ATTACH | FAN_MNT_DETACH)
 
-/* Events that user can request to be notified on */
-#define FANOTIFY_EVENTS		(FANOTIFY_PATH_EVENTS | \
-				 FANOTIFY_INODE_EVENTS | \
-				 FANOTIFY_ERROR_EVENTS | \
-				 FANOTIFY_MOUNT_EVENTS)
+/* Events that user can request to be notified on namespace watchers */
+#define FANOTIFY_EVENTS_ON_NAMESPACE	(FANOTIFY_MOUNT_EVENTS)
 
 /* Extra flags that may be reported with event or control handling of events */
 #define FANOTIFY_EVENT_FLAGS	(FAN_EVENT_ON_CHILD | FAN_ONDIR)
 
-/* Events that may be reported to user */
-#define FANOTIFY_OUTGOING_EVENTS	(FANOTIFY_EVENTS | \
-					 FANOTIFY_PERM_EVENTS | \
-					 FAN_Q_OVERFLOW | FAN_ONDIR)
+/* Events that may be reported to user on filesystem watchers */
+#define FANOTIFY_OUTGOING_FILESYSTEM_EVENTS (FANOTIFY_EVENTS_ON_FILESYSTEM | \
+					     FAN_Q_OVERFLOW | FAN_ONDIR)
+
+/* Events that may be reported to user on namespace watchers */
+#define FANOTIFY_OUTGOING_NAMESPACE_EVENTS (FANOTIFY_EVENTS_ON_NAMESPACE | \
+					    FAN_Q_OVERFLOW)
 
 /* Events and flags relevant only for directories */
 #define FANOTIFY_DIRONLY_EVENT_BITS	(FANOTIFY_DIRENT_EVENTS | \
 					 FAN_EVENT_ON_CHILD | FAN_ONDIR)
 
-#define ALL_FANOTIFY_EVENT_BITS		(FANOTIFY_OUTGOING_EVENTS | \
+#define ALL_FANOTIFY_EVENT_BITS		(FANOTIFY_OUTGOING_FILESYSTEM_EVENTS | \
+					 FANOTIFY_OUTGOING_NAMESPACE_EVENTS | \
 					 FANOTIFY_EVENT_FLAGS)
 
 /* These masks check for invalid bits in permission responses. */
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 68c001ae55071..3bcdec669e8eb 100644
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
@@ -113,13 +118,22 @@
  */
 #define FS_EVENTS_POSS_TO_PARENT (FS_EVENTS_POSS_ON_CHILD)
 
+/* Events that can be reported to backends on filesystem watchers */
+#define FSNOTIFY_EVENTS_ON_FILESYSTEM (ALL_FSNOTIFY_DIRENT_EVENTS | \
+				       FS_EVENTS_POSS_ON_CHILD | \
+				       FS_DELETE_SELF | FS_MOVE_SELF | \
+				       FS_UNMOUNT | FS_Q_OVERFLOW | \
+				       FS_IN_IGNORED | FS_ERROR)
+
+/* Mount tree monitoring events */
+#define FSNOTIFY_MNT_EVENTS (FS_MNT_ATTACH | FS_MNT_DETACH)
+
+/* Events that can be reported to backends on namespace watchers */
+#define FSNOTIFY_EVENTS_ON_NAMESPACE (FSNOTIFY_MNT_EVENTS | FS_Q_OVERFLOW)
+
 /* Events that can be reported to backends */
-#define ALL_FSNOTIFY_EVENTS (ALL_FSNOTIFY_DIRENT_EVENTS | \
-			     FSNOTIFY_MNT_EVENTS | \
-			     FS_EVENTS_POSS_ON_CHILD | \
-			     FS_DELETE_SELF | FS_MOVE_SELF | \
-			     FS_UNMOUNT | FS_Q_OVERFLOW | FS_IN_IGNORED | \
-			     FS_ERROR)
+#define ALL_FSNOTIFY_EVENTS (FSNOTIFY_EVENTS_ON_FILESYSTEM | \
+			     FSNOTIFY_EVENTS_ON_NAMESPACE)
 
 /* Extra flags that may be reported with event or control handling of events */
 #define ALL_FSNOTIFY_FLAGS  (FS_ISDIR | FS_EVENT_ON_CHILD | FS_DN_MULTISHOT)
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index e710967c7c263..f91d4fe8fd65a 100644
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
@@ -28,19 +30,27 @@
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
 /* flags used for fanotify_init() */
 #define FAN_CLOEXEC		0x00000001
 #define FAN_NONBLOCK		0x00000002
-- 
2.55.0

