Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0211A682F
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Jun 2026 00:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780792457; cv=none; b=lLGfxNXABxj7IkDk0yQxUKA1RcePm5VFImqqNET6aDDk+3pVedJJ9FP1ZM2m1+7+Zj0jrDT7JwKTnEHIc0m5dllLYWCwRKCmLDSMQCUH+H2YolX7tHUDGooS1cCr64V44iqz4G+JCV4mxzPitU6sop/ABK2Q4nJ6Gw6NqTjuQoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780792457; c=relaxed/simple;
	bh=5gxaVxo3xM8fukkjl9cAMluFaofUCDDCFLEg6biKk6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3yudmT/ueiWHDhsWx4hKLGJfuFC5ZIKhrOk+kutlOSzOzRnJTZ54Aou28g7Azec97J/yNEkjtSeSejcnnBCMczf271zKgcgZm3Q1kAhwtT9MtTqAvQqL5uD0lzEKy7xVGsYod4kqxFGFhm/AfbXYz486F4/OLZlXX689Jfc58M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSm5KO3Z; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSm5KO3Z"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-137d464c47eso2610930c88.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Jun 2026 17:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780792452; x=1781397252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yb52RRXQv7KcVlnarae14d7zbBmk629IfEhtSbYPJos=;
        b=iSm5KO3Z+/ADfxk3HB/dE/Uook5dNzj07Sulr5s16CGuUcsiIy3MOqYRkNEyFsjCTK
         QnF1EafbPn5w749hq/I9kUBsDRWlWELQazkp3gSN61bVH91GLTblFUX5+wQ2afrJcEoD
         aICL/6PqexjRUg/yAF6M2gLRM/+6TH7cCnLWnwOd07EH7cOMYa7roOibwDPhcm8Ye58c
         Mg0ddoHy7LP4QD4qeu8KO8Vu+J1rUkVrSV3ZXOvP3aqJYlxGlK3YJVw97FzRFS+bfXtj
         1gplWkwxIl0ChkD59P2lvUvQlFns8avIMZHTWEN8XVNb6E6e2hzpOdgFWCFqIc7vYBkA
         yzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780792452; x=1781397252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yb52RRXQv7KcVlnarae14d7zbBmk629IfEhtSbYPJos=;
        b=bP129IWQTbddJ30AvDVqhmFFvcgboWqFGD4rxlCSHChd5LWH8YHP+5FK1H9gmhzZCm
         27fscUAUHJsDqY1CVhD1PgGj2sic9nHfudk5DB8zlC1mXhc94LPIH9b9RE0i3XbwKWdX
         +m+o1J4xGftbRLT8EAp2H58AOr8gwmrqTzyTNnN49GJr0dk7Rh/hDTPG4FiWF5kpboDC
         YbCqpJcJQzTGWSSvcQ52BxGZ0n4JGhLZy/+y2ACcs6pi26SHh2OZXKdUipBlNzz5N/lH
         S+zHvUSrcroliBYjRf7rQ3V0bhSx2yXc2Q8MnAkTviPEH5rt+KpquLCofiD4rfT3cP3y
         9QZg==
X-Forwarded-Encrypted: i=1; AFNElJ/nbD1mQfHuvLfa0fjeIgzpj9qKif9pSOKNv3VhDb44Tkk3U7B09VR0zkdKrTGauckYHeclZT45koPHZzKR@vger.kernel.org
X-Gm-Message-State: AOJu0YykxXDxFGqIgjGQzI4L3l/c9+Nu0dZHSxtusIWPXrC1pdyUGYA1
	GM+G26Jqns5/OVQznySKwPICWNZyiagR9wUALiO/24xBIkxPa89i2zAceojaYO8Q
X-Gm-Gg: Acq92OGQVDz1/FzLYtQQZuOCBIq8OfQwri/ldiuurEY0vfmJ+w/TH92d+ZFQBkYgIsf
	cpOs90MhG+k5Ti+E9BHDNLomT6v6aRoXN6jVdjmOJ/Qo7iBFU6BynCbsREdOsvk22dFXNGVhpS/
	wSiF+bkbCn9JZM8I6u7KyONYY92Cj2U8mvGG9pKzoeyaW39GFEl+uiix5OGsclRQK14TVYnV3WZ
	MkRJ4RL6nrOx/2abI0E9sJXKn8u4oSpZyHrh71eBboP0xnE7Eh/KtwLkY0GApwAJ22wpUC5928f
	7UdH8ZWWumRZIwbG4RZg79xjrG9Kw0UqeJemvhKCIjBDd1wOAnJTTbHpdnPu5KlPM0oNpYzqc9Z
	CKh66QJZ3zhYrO8FWg1GficOUWZxdxX47mse3pmUDTsSkbEmQkwvaPUHBk6Kg2Mx+sN2jSBIYUB
	TAUysPeUEb1IgSIIKuZKWTNX/Xuz5g98txmC+wUZyy
X-Received: by 2002:a05:7022:122:b0:12d:c9b6:bbe2 with SMTP id a92af1059eb24-13807d07321mr4311493c88.2.1780792452211;
        Sat, 06 Jun 2026 17:34:12 -0700 (PDT)
Received: from anonyme ([2605:52c0:2:2f27:be24:11ff:fe89:6f0f])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f716017esm13451383c88.15.2026.06.06.17.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 17:34:11 -0700 (PDT)
From: AnonymeMeow <anonymemeow@gmail.com>
To: jack@suse.cz
Cc: amir73il@gmail.com,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AnonymeMeow <anonymemeow@gmail.com>
Subject: [PATCH v5 2/2] fanotify: allow reporting pidfds for reaped tasks
Date: Sun,  7 Jun 2026 08:33:43 +0800
Message-ID: <20260607003343.425939-3-anonymemeow@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607003343.425939-1-anonymemeow@gmail.com>
References: <20260607003343.425939-1-anonymemeow@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fanotify used to refuse to report pidfds for reaped tasks by applying a
pid_has_task() check before calling pidfd_prepare(). This prevented
userspace from obtaining information about the task.

Register the event pid with pidfs when creating the fanotify event if
pidfd reporting was requested, so pidfd_prepare() can later create a
pidfd for the reaped task.

Suggested-by: Christian Brauner <brauner@kernel.org>
Link: https://lore.kernel.org/linux-fsdevel/20260528-schmuckvoll-heilen-garen-be77b4208671@brauner/

Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 17 +++++++++++------
 fs/notify/fanotify/fanotify_user.c | 18 +++++-------------
 fs/pidfs.c                         | 10 ++++++----
 include/linux/pidfs.h              | 18 +++++++++++++++++-
 4 files changed, 39 insertions(+), 24 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 38290b9c07f7..ece9523e775b 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -14,6 +14,7 @@
 #include <linux/sched/mm.h>
 #include <linux/statfs.h>
 #include <linux/stringhash.h>
+#include <linux/pidfs.h>
 
 #include "fanotify.h"
 
@@ -842,6 +843,15 @@ static struct fanotify_event *fanotify_alloc_event(
 	/* Whoever is interested in the event, pays for the allocation. */
 	old_memcg = set_active_memcg(group->memcg);
 
+	if (FAN_GROUP_FLAG(group, FAN_REPORT_TID))
+		pid = task_pid(current);
+	else
+		pid = task_tgid(current);
+
+	if (FAN_GROUP_FLAG(group, FAN_REPORT_PIDFD) &&
+	    pidfs_register_pid_gfp(pid, gfp))
+		goto out;
+
 	if (fanotify_is_perm_event(mask)) {
 		event = fanotify_alloc_perm_event(data, data_type, gfp);
 	} else if (fanotify_is_error_event(mask)) {
@@ -863,15 +873,10 @@ static struct fanotify_event *fanotify_alloc_event(
 	if (!event)
 		goto out;
 
-	if (FAN_GROUP_FLAG(group, FAN_REPORT_TID))
-		pid = get_pid(task_pid(current));
-	else
-		pid = get_pid(task_tgid(current));
-
 	/* Mix event info, FAN_ONDIR flag and pid into event merge key */
 	hash ^= hash_long((unsigned long)pid | ondir, FANOTIFY_EVENT_HASH_BITS);
 	fanotify_init_event(event, hash, mask);
-	event->pid = pid;
+	event->pid = get_pid(pid);
 
 out:
 	set_active_memcg(old_memcg);
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index ebdd48942029..b604e3da58ad 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -904,20 +904,12 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 		metadata.fd = fd >= 0 ? fd : FAN_NOFD;
 
 	if (pidfd_mode) {
-		unsigned int tid_mode = FAN_GROUP_FLAG(group, FAN_REPORT_TID);
-		enum pid_type pidtype = tid_mode ? PIDTYPE_PID : PIDTYPE_TGID;
-		unsigned int pidfd_flags = tid_mode ? PIDFD_THREAD : 0;
+		unsigned int pidfd_flags = PIDFD_STALE;
 
-		/*
-		 * The pid_has_task() check for an event->pid is performed
-		 * preemptively in an attempt to catch out cases where the event
-		 * listener reads events after the event generating task has
-		 * already terminated.  Depending on flag FAN_REPORT_FD_ERROR,
-		 * report either -ESRCH or FAN_NOPIDFD to the event listener in
-		 * those cases with all other pidfd creation errors reported as
-		 * the error code itself or as FAN_EPIDFD.
-		 */
-		if (metadata.pid && pid_has_task(event->pid, pidtype))
+		if (FAN_GROUP_FLAG(group, FAN_REPORT_TID))
+			pidfd_flags |= PIDFD_THREAD;
+
+		if (metadata.pid)
 			pidfd = pidfd_prepare(event->pid, pidfd_flags, &pidfd_file);
 
 		if (!FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR) && pidfd < 0)
diff --git a/fs/pidfs.c b/fs/pidfs.c
index 1cce4f34a051..15efecf5cb07 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -991,14 +991,16 @@ static void pidfs_put_data(void *data)
 }
 
 /**
- * pidfs_register_pid - register a struct pid in pidfs
+ * pidfs_register_pid_gfp - register a struct pid in pidfs with custom GFP
+ * flags
  * @pid: pid to pin
+ * @gfp: GFP flags for memory allocation
  *
- * Register a struct pid in pidfs.
+ * Register a struct pid in pidfs with custom GFP flags.
  *
  * Return: On success zero, on error a negative error code is returned.
  */
-int pidfs_register_pid(struct pid *pid)
+int pidfs_register_pid_gfp(struct pid *pid, gfp_t gfp)
 {
 	struct pidfs_attr *new_attr __free(kfree) = NULL;
 	struct pidfs_attr *attr;
@@ -1014,7 +1016,7 @@ int pidfs_register_pid(struct pid *pid)
 	if (attr)
 		return 0;
 
-	new_attr = kmem_cache_zalloc(pidfs_attr_cachep, GFP_KERNEL);
+	new_attr = kmem_cache_zalloc(pidfs_attr_cachep, gfp);
 	if (!new_attr)
 		return -ENOMEM;
 
diff --git a/include/linux/pidfs.h b/include/linux/pidfs.h
index 416bdff4d6ce..0abf7da9ab23 100644
--- a/include/linux/pidfs.h
+++ b/include/linux/pidfs.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_PID_FS_H
 #define _LINUX_PID_FS_H
 
+#include <linux/gfp_types.h>
+
 struct coredump_params;
 
 struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags);
@@ -14,7 +16,21 @@ void pidfs_exit(struct task_struct *tsk);
 void pidfs_coredump(const struct coredump_params *cprm);
 #endif
 extern const struct dentry_operations pidfs_dentry_operations;
-int pidfs_register_pid(struct pid *pid);
+int pidfs_register_pid_gfp(struct pid *pid, gfp_t gfp);
+
+/**
+ * pidfs_register_pid - register a struct pid in pidfs
+ * @pid: pid to pin
+ *
+ * Register a struct pid in pidfs.
+ *
+ * Return: On success zero, on error a negative error code is returned.
+ */
+static inline int pidfs_register_pid(struct pid *pid)
+{
+	return pidfs_register_pid_gfp(pid, GFP_KERNEL);
+}
+
 void pidfs_free_pid(struct pid *pid);
 
 #endif /* _LINUX_PID_FS_H */
-- 
2.54.0

