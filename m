Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B02637BE6C
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 14:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074975; cv=none; b=U2FpvepeD0htN/9v1ipj4NX9Q5x9AmMewVmV8NonQwEC7YZLk7skaeSwdfjHjjZdFkM4EFE96k9VGhD9LvAwFa0hdpuMU22aHoGPqS85GvlcTyq30jaY8QD8ubtODe7S8o6wgnhrknMECPhgKECxNv/MFyfF1dMIRiOGcU6SDwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074975; c=relaxed/simple;
	bh=p0wZ1j2MVLqf/E6vkkA27ctNjz7searjhUhMghoETwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dMJCSstrplgfJYQM4Sx4VQ/VrGgvCIYloPKBYoKvqj00ARVoRcsk0qHNN3QAqYBibo91x97dbkM/7aQWoXElJfxm3P8+Oee1bPEpr+GyiSMyc9D8Dn6EhcT0Gt9IWAjTdQ4v6sRdHhCm1L6vnk53tcb8tze/QJ38K+Lv2m/P2Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFd0DfSU; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFd0DfSU"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6af8620a7d2so6407743a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 07:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792074965; x=1792679765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cJHg5eMUhxh59zw/KnoAYp8KKErNrvbWNTgRE+BLUko=;
        b=XFd0DfSUxEurzlX2O+h+/h2e+esNEUdgTLNTLfGQSJemaEboH9ZhZQIAIAkPmIoNP+
         qpGcI23xbjcAa9zzXeDW8axVA7NhxWBUpKpvNHgU1d6YzlHmjxfK+wfAr2oi4czocDXi
         +x33UNPn1gOdFkg/qyP5mKAHXG72IlIhZUex/WZr9zvsRppvHP+Dj/sq82rSTyfCFU/c
         Cse3+eKzs7IJ01/15XwFexvg+3H4U6TD5XUNS5TS/KrbBNWTnzcUqK1GtsqThNMqAlGm
         jVu2Rvr6YuX6FvHtVUjEw5WBfzAZIeE21wMPtvCVY9GDkVJHGmCNuvIPNn2/Cttw+ot0
         bMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792074965; x=1792679765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cJHg5eMUhxh59zw/KnoAYp8KKErNrvbWNTgRE+BLUko=;
        b=BEPG41Ot3JvR1P5TiXhYRxF+GWSg2S4tLNwz+bf5n0+HLEQP1bIJ2J7X6nDicuq5q2
         I4sifDoROGcK0GSwmhqM288uhjjwISRuhn0ANosXVNpxLuS4zCi0mVcMUKmbsrgeg0uU
         k7aSifAttabgbYsHKp9x+C3qhtm326tyz+SfYwBo5gQCRHM5hbtdOa3Mk219OOYovoi/
         NIY2Kh07JdFM4q2H1DOrf2qY48GsdyASwaNK+A0hjobBSd/k1t4qIN6xRFipMcd1O9F/
         //PJ2i4T8NNV00SljgnDV0/80s1GHuwqNqZ+qof5YETufVITFxFvdRhIKSjT0tTUKYrs
         AZ7Q==
X-Forwarded-Encrypted: i=1; AKwUvBzSnxxRWvejGJZyRGvC51gk46J8//admrx29uCRxuXhcUODVRyNkYsZzFkV0BBGsdHng9Z+B33Ef1nO4Jyg@vger.kernel.org
X-Gm-Message-State: AFq9FYL5GV8NQII4u8QygGswXXjQmVrfA8K6clgGwnqSX9ssRaKY6Yrl
	Abmzzjtx4NWcDT8Vc54D3QiTN348OPGEEjjWC2qjdGFbEd9su9Di1CJA
X-Gm-Gg: AYBFou3YWjxwP7Y56kBx5bGiHZBbbEiK2rTY/OyQ7dj3TB+C35WuTctTgbB01Fn20Sw
	XjS2NCM5v4082NBRALhURBN8+Oq/aMAnWj1YVfI+XzQbIQvGdZms2vXH7PJ3LTTAn5mr8PfQ0J1
	XIQj9Zkc7v8wGFmg35em5B5Ij4CVa3g23vb5a3vkSpy8/TdgPPTXajHN10k2yvWn/Vhdxmxs7ZI
	lZGjMPuZO4tD1UpDgcSVJfQjnv9ROFknjovKjHGT18H5wd5imI7Uw4eiRfZ7/l0GgtH7P/voTSp
	w7AWGfthH+OYbn05VQspB2rheuZ36JrwECK233KQPlMIHFSCQL2u9DMAKfLScp97IcEY5bX5bKM
	YDs2scdxfJVgbeo/UOoaMgufyjklWVQT+pa6xvvVF/cES1XWdIQrL2ijHAVsQA1lZkNW1OD1yX2
	X9Ow7RDGnZ+xFz/y0YllCUndREYZjfGK88otomdhUk751p6TggJyY06iDDyMHicQNbPoK0jeRSD
	lnRMD1Mw50ZaH6eWgrxGOBe3/OSwC1zZts=
X-Received: by 2002:a05:6402:42c3:b0:6af:d968:dd18 with SMTP id 4fb4d7f45d1cf-6b17c2c7419mr14854361a12.39.1792074965025;
        Thu, 15 Oct 2026 07:36:05 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b3873ed660sm110157a12.1.2026.10.15.07.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:36:04 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 02/14] fsnotify: introduce fsnotify group types
Date: Thu, 15 Oct 2026 16:35:48 +0200
Message-ID: <20261015143601.2095784-3-amir73il@gmail.com>
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

Currently an fanotify group can subscribe to events FAN_MNT_ATTACH/DETACH
only on mark type FAN_MARK_MNTNS and IFF the group was initialized with
FAN_REPORT_MNT.

Hence, mount events can not be mixed on the same group with filesystem
events and mntns marks cannot be mixed with filesystem type marks.

Define a new property for an fsnotify group called fsnotify_group_type
which describes the category of events and mark types and use a distinct
category FSNOTIFY_GROUP_TYPE_NAMESPACE for the mount event groups.

Create helpers fsnotify_is_{filesystem,namespace}_watcher() and the macro
FANOTIFY_NAMESPACE_INIT_FLAGS and use them to generalize some code that was
checking the FAN_REPORT_MNT flag.  FAN_REPORT_MNT is both a namespace group
type selector and an information mode that controls the event metadata.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      |  4 +++-
 fs/notify/fanotify/fanotify_user.c | 37 ++++++++++++++++++++++--------
 fs/notify/group.c                  | 11 +++++----
 include/linux/fanotify.h           | 10 ++++++--
 include/linux/fsnotify_backend.h   | 26 +++++++++++++++++++++
 5 files changed, 72 insertions(+), 16 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 71b3a2361929c..bfaec0a4fc2f4 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -312,9 +312,11 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 	pr_debug("%s: report_mask=%x mask=%x data=%p data_type=%d\n",
 		 __func__, iter_info->report_mask, event_mask, data, data_type);
 
-	if (FAN_GROUP_FLAG(group, FAN_REPORT_MNT)) {
+	if (fsnotify_is_namespace_watcher(group)) {
 		if (data_type != FSNOTIFY_EVENT_MNT)
 			return 0;
+	} else if (WARN_ON_ONCE(!fsnotify_is_filesystem_watcher(group))) {
+		return 0;
 	} else if (!fid_mode) {
 		/* Do we have path to open a file descriptor? */
 		if (!path)
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 22c6424c334a0..6bad0f1a17eb2 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1582,8 +1582,10 @@ static struct hlist_head *fanotify_alloc_merge_hash(void)
 DEFINE_CLASS(fsnotify_group,
 	     struct fsnotify_group *,
 	     if (!IS_ERR_OR_NULL(_T)) fsnotify_destroy_group(_T),
-	     fsnotify_alloc_group(ops, flags),
-	     const struct fsnotify_ops *ops, int flags)
+	     __fsnotify_alloc_group(ops, type, flags, gfp),
+	     const struct fsnotify_ops *ops,
+	     enum fsnotify_group_type type,
+	     int flags, gfp_t gfp)
 
 /* fanotify syscalls */
 SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
@@ -1593,6 +1595,10 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	unsigned int fid_mode = flags & FANOTIFY_FID_BITS;
 	unsigned int class = flags & FANOTIFY_CLASS_BITS;
 	unsigned int internal_flags = 0;
+	/* A group is either for watching filesystems or namespaces */
+	enum fsnotify_group_type type =
+		(flags & FANOTIFY_NAMESPACE_INIT_FLAGS) ?
+		FSNOTIFY_GROUP_TYPE_NAMESPACE : FSNOTIFY_GROUP_TYPE_FILESYSTEM;
 
 	pr_debug("%s: flags=%x event_f_flags=%x\n",
 		 __func__, flags, event_f_flags);
@@ -1604,7 +1610,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	 * queue/marks.
 	 */
 	if (((flags & FANOTIFY_ADMIN_INIT_FLAGS) ||
-	     !(flags & (FANOTIFY_FID_BITS | FAN_REPORT_MNT))) &&
+	     !(flags & (FANOTIFY_FID_BITS | FANOTIFY_NAMESPACE_INIT_FLAGS))) &&
 	    !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
@@ -1624,8 +1630,11 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 #endif
 		return -EINVAL;
 
-	/* Don't allow mixing mnt events with inode events for now */
-	if (flags & FAN_REPORT_MNT) {
+	/*
+	 * Namespace watchers do not support priority classes and do not
+	 * support reporting file info event extensions.
+	 */
+	if (type == FSNOTIFY_GROUP_TYPE_NAMESPACE) {
 		if (class != FAN_CLASS_NOTIF)
 			return -EINVAL;
 		if (flags & (FANOTIFY_FID_BITS | FAN_REPORT_FD_ERROR))
@@ -1669,8 +1678,9 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	if (flags & FAN_NONBLOCK)
 		f_flags |= O_NONBLOCK;
 
-	CLASS(fsnotify_group, group)(&fanotify_fsnotify_ops,
-				     FSNOTIFY_GROUP_FLAG_USER);
+	CLASS(fsnotify_group, group)(&fanotify_fsnotify_ops, type,
+				     FSNOTIFY_GROUP_FLAG_USER,
+				     GFP_KERNEL_ACCOUNT);
 	/* fsnotify_alloc_group takes a ref.  Dropped in fanotify_release */
 	if (IS_ERR(group))
 		return PTR_ERR(group);
@@ -1873,6 +1883,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
 	unsigned int mark_cmd = flags & FANOTIFY_MARK_CMD_BITS;
 	unsigned int ignore = flags & FANOTIFY_MARK_IGNORE_BITS;
+	enum fsnotify_group_type mark_group_type;
 	unsigned int obj_type, fid_mode;
 	void *obj = NULL;
 	u32 umask = 0;
@@ -1891,15 +1902,19 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	switch (mark_type) {
 	case FAN_MARK_INODE:
 		obj_type = FSNOTIFY_OBJ_TYPE_INODE;
+		mark_group_type = FSNOTIFY_GROUP_TYPE_FILESYSTEM;
 		break;
 	case FAN_MARK_MOUNT:
 		obj_type = FSNOTIFY_OBJ_TYPE_VFSMOUNT;
+		mark_group_type = FSNOTIFY_GROUP_TYPE_FILESYSTEM;
 		break;
 	case FAN_MARK_FILESYSTEM:
 		obj_type = FSNOTIFY_OBJ_TYPE_SB;
+		mark_group_type = FSNOTIFY_GROUP_TYPE_FILESYSTEM;
 		break;
 	case FAN_MARK_MNTNS:
 		obj_type = FSNOTIFY_OBJ_TYPE_MNTNS;
+		mark_group_type = FSNOTIFY_GROUP_TYPE_NAMESPACE;
 		break;
 	default:
 		return -EINVAL;
@@ -1948,6 +1963,9 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		return -EINVAL;
 	group = fd_file(f)->private_data;
 
+	if (group->type != mark_group_type)
+		return -EINVAL;
+
 	/* Only report mount events on mnt namespace */
 	if (FAN_GROUP_FLAG(group, FAN_REPORT_MNT)) {
 		if (mask & ~FANOTIFY_MOUNT_EVENTS)
@@ -1993,14 +2011,15 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
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
+	if (fsnotify_is_filesystem_watcher(group) &&
+	    mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_EVENT_FLAGS) &&
 	    (!fid_mode || mark_type == FAN_MARK_MOUNT))
 		return -EINVAL;
 
diff --git a/fs/notify/group.c b/fs/notify/group.c
index cf445e270ba6a..071d34051da95 100644
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
@@ -148,7 +150,8 @@ struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops,
 	gfp_t gfp = (flags & FSNOTIFY_GROUP_FLAG_USER) ?
 		    GFP_KERNEL_ACCOUNT : GFP_KERNEL;
 
-	return __fsnotify_alloc_group(ops, flags, gfp);
+	return __fsnotify_alloc_group(ops, FSNOTIFY_GROUP_TYPE_FILESYSTEM,
+				      flags, gfp);
 }
 EXPORT_SYMBOL_GPL(fsnotify_alloc_group);
 
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 879cff5eccd4e..ddfcfd37b231c 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -25,7 +25,12 @@
 
 #define FANOTIFY_FID_BITS	(FAN_REPORT_DFID_NAME_TARGET)
 
-#define FANOTIFY_INFO_MODES	(FANOTIFY_FID_BITS | FAN_REPORT_PIDFD | FAN_REPORT_MNT)
+/* fanotify_init() flags related to information reported with events */
+#define FANOTIFY_INFO_MODES	(FANOTIFY_FID_BITS | FAN_REPORT_PIDFD | \
+				 FAN_REPORT_MNT)
+
+/* fanotify_init() flags that create a namespace watcher */
+#define FANOTIFY_NAMESPACE_INIT_FLAGS	(FAN_REPORT_MNT)
 
 /*
  * fanotify_init() flags that require CAP_SYS_ADMIN.
@@ -47,7 +52,8 @@
  * so one of the flags for reporting file handles is required.
  */
 #define FANOTIFY_USER_INIT_FLAGS	(FAN_CLASS_NOTIF | \
-					 FANOTIFY_FID_BITS | FAN_REPORT_MNT | \
+					 FANOTIFY_FID_BITS | \
+					 FANOTIFY_NAMESPACE_INIT_FLAGS | \
 					 FAN_CLOEXEC | FAN_NONBLOCK)
 
 #define FANOTIFY_INIT_FLAGS	(FANOTIFY_ADMIN_INIT_FLAGS | \
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index ad310de907819..68c001ae55071 100644
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
+	FSNOTIFY_GROUP_TYPE_FILESYSTEM = 0,
+	FSNOTIFY_GROUP_TYPE_NAMESPACE,
+};
+
 /*
  * A group is a "thing" that wants to receive notification about filesystem
  * events.  The mask holds the subset of event types this group cares about.
@@ -230,6 +239,7 @@ struct fsnotify_group {
 	unsigned int q_len;			/* events on the queue */
 	unsigned int max_events;		/* maximum events allowed on the list */
 	enum fsnotify_group_prio priority;	/* priority for sending events */
+	enum fsnotify_group_type type;		/* type of watched objects */
 	bool shutdown;		/* group is being shut down, don't queue more events */
 
 #define FSNOTIFY_GROUP_FLAG_USER	0x01 /* user allocated group */
@@ -280,6 +290,18 @@ struct fsnotify_group {
 	};
 };
 
+static inline bool fsnotify_is_filesystem_watcher(
+					const struct fsnotify_group *group)
+{
+	return group->type == FSNOTIFY_GROUP_TYPE_FILESYSTEM;
+}
+
+static inline bool fsnotify_is_namespace_watcher(
+					const struct fsnotify_group *group)
+{
+	return group->type == FSNOTIFY_GROUP_TYPE_NAMESPACE;
+}
+
 /*
  * These helpers are used to prevent deadlock when reclaiming inodes with
  * evictable marks of the same group that is allocating a new mark.
@@ -727,6 +749,10 @@ static inline void fsnotify_update_flags(struct dentry *dentry)
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
2.55.0

