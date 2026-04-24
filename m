Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20B53CF66B
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 17:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050311; cv=none; b=Yl5l4jq1tQyMfPzTw9H3NoBcyLe5OGtTkhiN1Alai72QgWdsG3OP+Lr9EPW8+xnK7KRM7lwUibJzLfc78iDZWQihGZy6zO29Qxnp4bDd1I9aFJF7EBQJdNO7w3S6st4VMcsqRkf1lxizn5aAr45YNFktOeIj/HiDs9p4i0p8xPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050311; c=relaxed/simple;
	bh=eD6hXvyLlR5ODl5pcGyPOMmZSoeIDYMPiLRHCAW95CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJOI8iHE3EwHmymay2o3dhUD8Xf4O0Ygo7Za8iSSsou/y+e/f5ngzH3Q8z6nbfYE4556BaBD98saMEf/jO5l7NJKY6A4mmTPUUodMTbEyZuGqUGR7QYXGqekA86T32WIu9zl8p5f8adeJvsck68Sw9ckmeuufV2PzprYVfI0R6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4bW+n+N; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4bW+n+N"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-670ab084a39so12283042a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 10:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777050308; x=1777655108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAgz32e4hqVYh4ld+wzOijh+UAEjR1zg2Ib9i1oBFhY=;
        b=P4bW+n+NfYMqYY+OFcEDml+Cjtu5kSvb6dbiFM4qrIvWKKYbyansnM5gaDpu/MKEjP
         3qsNKWQLFXGwmhPTuAkUY/JhGmwz4Kh8lTjobMxN0dz5PkmL+m8JPgbf9FG+PooUNGDr
         TXdIWCznf+LztUzsn6elJV5dR6xSeqVvVKp+IzMihmsZATmKJCaJcVI9mJC17oGsMwo4
         67YdnlDxXkVN4g0Uiu5EJllCOaHn/NMWo0zHAVRJU/HGb77fk4hMOeCqDPpuDDNS3Hhi
         GA89aCcG7mVU+bkkybO21WkNpIbjBXyfhU3krmykkoKWYweepFl9DQklfcKJcdgjGgTg
         jEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777050308; x=1777655108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qAgz32e4hqVYh4ld+wzOijh+UAEjR1zg2Ib9i1oBFhY=;
        b=ODmSrCwhewGwYoDcYnAABjv6OzK3ioO60LmiKO3uJKAD8MNsMILGc+PCojp+Zlpy9l
         sl0sVbQ150OVs74Nf5K1xaXfYQBFYT+JuQOJN6fmJAg7MEAtG1CeAkdYe87TPDzyFpjm
         31Ctc3ICGmDmiV/omt2n8SiJRohGA0f2OWxgrB626zkYdXU2TV4A5hYrSkn8XDbU4gos
         KpApwCKC7/W+5Ii7mMAXQjr1doi8HBiFuBemSJ/ySEfJsawDY+QYZzL0XhnWhfBfcwSq
         ohJAKZ1/3m9Le/inpPkPs4FCTyA7mPVOt1Mr/Io6iFe3KMgxO3WO8xGJiRWqdkxyU0MV
         Mvsw==
X-Forwarded-Encrypted: i=1; AFNElJ/e4JFUXD/59yoNS5fyWAEkIy9Ad2yy1sWWKhUSVxv6sipm8XEU0wSawcKqMAJN2/U/m+KLDoMAJp8qULRY@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4VBH8YMDQAXf6RYGd6foQi7RSRNvcdtaFUE1YSYLm96dhvP0I
	UM/RokZ6odp/NlxRBynz6JLQDLjFKaCWjf7fFPg2mmo+LARS5MWZbF/D4MAYhfCXpH8=
X-Gm-Gg: AeBDiesxy9cptbyh0tYU7P30YXeMYyhfInCU72kaDI3lNDdGkGbA23UrWIkzpnGHsWN
	rcqH+cyBbQ7Wd6Any1ruNciPT3K5lo7h6zZI8UJIw2zqoA+NhHafxe5rP9HefVVY0R32u8y20Mz
	B6JB/DryNScWfHl3mb8PbX6BnY2HpAml9UvN0jL6ilFafXXXp8AlyZDnra84lwbDO2ff1zv+iy3
	10mNx0knMQQ1BakFWMonbRh7XHgGpAo+SY8CZAbPvGpAkOFTLM/C4EkL5k7+ArEU0oNLbQPHL7X
	yQFZEFQYxO7NljhxyJ2nLRtGb2jEBHBAmnJKBwBZoTSZydSlc6JIAxUdZqKdfrtvhvCKKSGFGIX
	uSU7Wl4K6tnfk5dzcXlctXrW0Om9VYStYe225k7JFQD3Y34cep1mylAsJ3j7QlmGY/eZz7eADTh
	6kgOVXR5DDU9wy/YTlDSs3y7xbzcPFhzKQBgti7Uw7oOmCzxvPpZzeaLndpXUX8aqLQ5tOgxZlS
	gjHM57wMg5rs2XdXLRUC3dGujSx5hL3sdq5Dic=
X-Received: by 2002:a17:907:c9a2:b0:b9c:ed9:50c8 with SMTP id a640c23a62f3a-ba41a91e1b9mr1240859466b.26.1777050307746;
        Fri, 24 Apr 2026 10:05:07 -0700 (PDT)
Received: from localhost (2001-1c00-570d-ee00-4aab-734a-1928-df3f.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:4aab:734a:1928:df3f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba4555398f8sm796303766b.59.2026.04.24.10.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 10:05:07 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 02/10] fsnotify: introduce fsnotify group types
Date: Fri, 24 Apr 2026 19:04:55 +0200
Message-ID: <20260424170503.2096847-3-amir73il@gmail.com>
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

Currently an fanotify group can subscribe to events FAN_MNT_ATTACH/DETACH
only on mark type FAN_MARK_MNTNS and IFF the group was initialized with
FAN_REPORT_MNT.

Hence, mount events can not be mixed on the same group with filesystem
events and mntns marks cannot be mixed with filesystem type marks.

Define a new property for an fsnotify group called fsnotify_group_type
which describes the category of events and mark types and use a distinct
category FSNOTIFY_GROUP_TYPE_NS for the mount event groups.

Create helpers fsnotify_is_{fs,ns}_watcher() and the macro
FANOTIFY_NS_INIT_FLAGS and use them to generalize some code that was
checking the FAN_REPORT_MNT flag.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      |  4 ++-
 fs/notify/fanotify/fanotify_user.c | 40 ++++++++++++++++++++++--------
 fs/notify/group.c                  | 10 +++++---
 include/linux/fanotify.h           |  8 ++++--
 include/linux/fsnotify_backend.h   | 24 ++++++++++++++++++
 5 files changed, 68 insertions(+), 18 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 38290b9c07f7b..e768c25262e27 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -314,9 +314,11 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 	pr_debug("%s: report_mask=%x mask=%x data=%p data_type=%d\n",
 		 __func__, iter_info->report_mask, event_mask, data, data_type);
 
-	if (FAN_GROUP_FLAG(group, FAN_REPORT_MNT)) {
+	if (fsnotify_is_ns_watcher(group)) {
 		if (data_type != FSNOTIFY_EVENT_MNT)
 			return 0;
+	} else if (WARN_ON_ONCE(!fsnotify_is_fs_watcher(group))) {
+		return 0;
 	} else if (!fid_mode) {
 		/* Do we have path to open a file descriptor? */
 		if (!path)
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 49531a4fe71de..95e7c24c70249 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1586,8 +1586,11 @@ static struct hlist_head *fanotify_alloc_merge_hash(void)
 DEFINE_CLASS(fsnotify_group,
 	     struct fsnotify_group *,
 	     if (!IS_ERR_OR_NULL(_T)) fsnotify_destroy_group(_T),
-	     fsnotify_alloc_group(ops, flags),
-	     const struct fsnotify_ops *ops, int flags)
+	     __fsnotify_alloc_group(ops, type,
+				    FSNOTIFY_GROUP_FLAG_USER,
+				    GFP_KERNEL_ACCOUNT),
+	     const struct fsnotify_ops *ops,
+	     enum fsnotify_group_type type)
 
 /* fanotify syscalls */
 SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
@@ -1597,18 +1600,22 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	unsigned int fid_mode = flags & FANOTIFY_FID_BITS;
 	unsigned int class = flags & FANOTIFY_CLASS_BITS;
 	unsigned int internal_flags = 0;
+	/* A group is either for watching filesystems or namespaces */
+	enum fsnotify_group_type type = (flags & FANOTIFY_NS_INIT_FLAGS) ?
+					FSNOTIFY_GROUP_TYPE_NS :
+					FSNOTIFY_GROUP_TYPE_FS;
 
 	pr_debug("%s: flags=%x event_f_flags=%x\n",
 		 __func__, flags, event_f_flags);
 
 	/*
 	 * An unprivileged user can setup an fanotify group with limited
-	 * functionality - an unprivileged group is limited to notification
-	 * events with file handles or mount ids and it cannot use unlimited
+	 * functionality - an unprivileged group cannot receive filesystem
+	 * notification events with file descriptors and cannot use unlimited
 	 * queue/marks.
 	 */
 	if (((flags & FANOTIFY_ADMIN_INIT_FLAGS) ||
-	     !(flags & (FANOTIFY_FID_BITS | FAN_REPORT_MNT))) &&
+	     !(flags & (FANOTIFY_FID_BITS | FANOTIFY_NS_INIT_FLAGS))) &&
 	    !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
@@ -1636,8 +1643,11 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	if ((flags & FAN_REPORT_PIDFD) && (flags & FAN_REPORT_TID))
 		return -EINVAL;
 
-	/* Don't allow mixing mnt events with inode events for now */
-	if (flags & FAN_REPORT_MNT) {
+	/*
+	 * Namespace watchers do not support priority classes and do not
+	 * support reporting file info event extensions.
+	 */
+	if (type == FSNOTIFY_GROUP_TYPE_NS) {
 		if (class != FAN_CLASS_NOTIF)
 			return -EINVAL;
 		if (flags & (FANOTIFY_FID_BITS | FAN_REPORT_FD_ERROR))
@@ -1681,8 +1691,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	if (flags & FAN_NONBLOCK)
 		f_flags |= O_NONBLOCK;
 
-	CLASS(fsnotify_group, group)(&fanotify_fsnotify_ops,
-				     FSNOTIFY_GROUP_FLAG_USER);
+	CLASS(fsnotify_group, group)(&fanotify_fsnotify_ops, type);
 	/* fsnotify_alloc_group takes a ref.  Dropped in fanotify_release */
 	if (IS_ERR(group))
 		return PTR_ERR(group);
@@ -1885,6 +1894,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
 	unsigned int mark_cmd = flags & FANOTIFY_MARK_CMD_BITS;
 	unsigned int ignore = flags & FANOTIFY_MARK_IGNORE_BITS;
+	enum fsnotify_group_type group_type;
 	unsigned int obj_type, fid_mode;
 	void *obj = NULL;
 	u32 umask = 0;
@@ -1903,15 +1913,19 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	switch (mark_type) {
 	case FAN_MARK_INODE:
 		obj_type = FSNOTIFY_OBJ_TYPE_INODE;
+		group_type = FSNOTIFY_GROUP_TYPE_FS;
 		break;
 	case FAN_MARK_MOUNT:
 		obj_type = FSNOTIFY_OBJ_TYPE_VFSMOUNT;
+		group_type = FSNOTIFY_GROUP_TYPE_FS;
 		break;
 	case FAN_MARK_FILESYSTEM:
 		obj_type = FSNOTIFY_OBJ_TYPE_SB;
+		group_type = FSNOTIFY_GROUP_TYPE_FS;
 		break;
 	case FAN_MARK_MNTNS:
 		obj_type = FSNOTIFY_OBJ_TYPE_MNTNS;
+		group_type = FSNOTIFY_GROUP_TYPE_NS;
 		break;
 	default:
 		return -EINVAL;
@@ -1960,6 +1974,9 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		return -EINVAL;
 	group = fd_file(f)->private_data;
 
+	if (group->type != group_type)
+		return -EINVAL;
+
 	/* Only report mount events on mnt namespace */
 	if (FAN_GROUP_FLAG(group, FAN_REPORT_MNT)) {
 		if (mask & ~FANOTIFY_MOUNT_EVENTS)
@@ -2005,14 +2022,15 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		return -EINVAL;
 
 	/*
-	 * Events that do not carry enough information to report
+	 * Filesystem events that do not carry enough information to report
 	 * event->fd require a group that supports reporting fid.  Those
 	 * events are not supported on a mount mark, because they do not
 	 * carry enough information (i.e. path) to be filtered by mount
 	 * point.
 	 */
 	fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
-	if (mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_MOUNT_EVENTS|FANOTIFY_EVENT_FLAGS) &&
+	if (fsnotify_is_fs_watcher(group) &&
+	    mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_EVENT_FLAGS) &&
 	    (!fid_mode || mark_type == FAN_MARK_MOUNT))
 		return -EINVAL;
 
diff --git a/fs/notify/group.c b/fs/notify/group.c
index cf445e270ba6a..754d87e3a0189 100644
--- a/fs/notify/group.c
+++ b/fs/notify/group.c
@@ -111,9 +111,9 @@ void fsnotify_put_group(struct fsnotify_group *group)
 }
 EXPORT_SYMBOL_GPL(fsnotify_put_group);
 
-static struct fsnotify_group *__fsnotify_alloc_group(
-				const struct fsnotify_ops *ops,
-				int flags, gfp_t gfp)
+struct fsnotify_group *__fsnotify_alloc_group(const struct fsnotify_ops *ops,
+					      enum fsnotify_group_type type,
+					      int flags, gfp_t gfp)
 {
 	struct fsnotify_group *group;
 
@@ -135,9 +135,11 @@ static struct fsnotify_group *__fsnotify_alloc_group(
 
 	group->ops = ops;
 	group->flags = flags;
+	group->type = type;
 
 	return group;
 }
+EXPORT_SYMBOL_GPL(__fsnotify_alloc_group);
 
 /*
  * Create a new fsnotify_group and hold a reference for the group returned.
@@ -148,7 +150,7 @@ struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops,
 	gfp_t gfp = (flags & FSNOTIFY_GROUP_FLAG_USER) ?
 		    GFP_KERNEL_ACCOUNT : GFP_KERNEL;
 
-	return __fsnotify_alloc_group(ops, flags, gfp);
+	return __fsnotify_alloc_group(ops, FSNOTIFY_GROUP_TYPE_FS, flags, gfp);
 }
 EXPORT_SYMBOL_GPL(fsnotify_alloc_group);
 
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 879cff5eccd4e..1a09400b843b5 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -25,7 +25,10 @@
 
 #define FANOTIFY_FID_BITS	(FAN_REPORT_DFID_NAME_TARGET)
 
-#define FANOTIFY_INFO_MODES	(FANOTIFY_FID_BITS | FAN_REPORT_PIDFD | FAN_REPORT_MNT)
+#define FANOTIFY_INFO_MODES	(FANOTIFY_FID_BITS | FAN_REPORT_PIDFD)
+
+/* fanotify_init() flags to create a namepsace event watcher */
+#define FANOTIFY_NS_INIT_FLAGS	(FAN_REPORT_MNT)
 
 /*
  * fanotify_init() flags that require CAP_SYS_ADMIN.
@@ -47,7 +50,8 @@
  * so one of the flags for reporting file handles is required.
  */
 #define FANOTIFY_USER_INIT_FLAGS	(FAN_CLASS_NOTIF | \
-					 FANOTIFY_FID_BITS | FAN_REPORT_MNT | \
+					 FANOTIFY_FID_BITS | \
+					 FANOTIFY_NS_INIT_FLAGS | \
 					 FAN_CLOEXEC | FAN_NONBLOCK)
 
 #define FANOTIFY_INIT_FLAGS	(FANOTIFY_ADMIN_INIT_FLAGS | \
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 87524706792e7..698fc75b0b6d4 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -204,6 +204,15 @@ enum fsnotify_group_prio {
 	__FSNOTIFY_PRIO_NUM
 };
 
+/*
+ * Category of kernel objects watched by this group.
+ * Every category has its own mark types and event types.
+ */
+enum fsnotify_group_type {
+	FSNOTIFY_GROUP_TYPE_FS = 0,
+	FSNOTIFY_GROUP_TYPE_NS,
+};
+
 /*
  * A group is a "thing" that wants to receive notification about filesystem
  * events.  The mask holds the subset of event types this group cares about.
@@ -230,6 +239,7 @@ struct fsnotify_group {
 	unsigned int q_len;			/* events on the queue */
 	unsigned int max_events;		/* maximum events allowed on the list */
 	enum fsnotify_group_prio priority;	/* priority for sending events */
+	enum fsnotify_group_type type;		/* category of watched objects */
 	bool shutdown;		/* group is being shut down, don't queue more events */
 
 #define FSNOTIFY_GROUP_FLAG_USER	0x01 /* user allocated group */
@@ -280,6 +290,16 @@ struct fsnotify_group {
 	};
 };
 
+static inline bool fsnotify_is_fs_watcher(const struct fsnotify_group *group)
+{
+	return group->type == FSNOTIFY_GROUP_TYPE_FS;
+}
+
+static inline bool fsnotify_is_ns_watcher(const struct fsnotify_group *group)
+{
+	return group->type == FSNOTIFY_GROUP_TYPE_NS;
+}
+
 /*
  * These helpers are used to prevent deadlock when reclaiming inodes with
  * evictable marks of the same group that is allocating a new mark.
@@ -707,6 +727,10 @@ static inline void fsnotify_update_flags(struct dentry *dentry)
 /* called from fsnotify listeners, such as fanotify or dnotify */
 
 /* create a new group */
+extern struct fsnotify_group *__fsnotify_alloc_group(
+				const struct fsnotify_ops *ops,
+				enum fsnotify_group_type type,
+				int flags, gfp_t gfp);
 extern struct fsnotify_group *fsnotify_alloc_group(
 				const struct fsnotify_ops *ops,
 				int flags);
-- 
2.54.0

