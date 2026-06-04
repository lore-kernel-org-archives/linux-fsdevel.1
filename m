Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D34346E40
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2026 19:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780602429; cv=none; b=RI57OwZ7njgNv6Ba8MASnoMpLt5nfGYwYzUrJJqEASl8WE04sNqTPVglHbgGPpDvptVdGW4UIn+2W2LTSu0RXrmQ8BQbnyxnWQW/ASbelY7cxkVhB2smueK/Of+3hE3Xlmq402gtRLtbZZ5nqQFG7pbedTPUJn5IjaEJnxNG5mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780602429; c=relaxed/simple;
	bh=M+ZzsX5p85PGrfpITsWUg6sfDTAyZPfmyRgLp49+MxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9o8jkjoY4JvCnXNZzq9F34BhLAWZD9jekxa9prg4OfyAYXyahSm6UpYUxgGxHAYL93Q+yRNBsStxp9SV8sl01i4pbC6XLcBERv4lRBsucbAldKUDryUjhi+QXJhDKwGdZvXVMKBjax7bUSPMEbR/vvz0uBARPEeSgdSLTr6df8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gom5bWBo; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gom5bWBo"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-137d464c47eso1504930c88.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 12:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780602426; x=1781207226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mejW8PaA8z97cDibT5Pd0sISLOYkfEMXCte0NLxtt+o=;
        b=gom5bWBoeBuN+6hqN4cXjROXUamWGY30yBNYRdNz3Sn+JR441BdSa9fUp2c2R1FgvG
         cVqeQu4J+TSxse08FTuJfWEGr6X0FWpnCKh8RadmsYF7c0Mj+hVEqto1MAgl093/RsGc
         4zq2TKllOTjCuxuHBaikZoUfvGyjwGcSaC8H/F850cztnQrTuYFY+3BhSAgt0PjllSOf
         FEMTpOozrrUPyZP3GGKZJIYFI1iFu5rv1OLSkZWMNsFehZdSWfWjVrt1l50JJC+LAgf7
         0rpV4G5N6WaF+iK2KlR3UfqEiYZzsCGMKnVSSzbJeVl1fFGkgSFHTwA2ySUb4JR+Pwr1
         C9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780602426; x=1781207226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mejW8PaA8z97cDibT5Pd0sISLOYkfEMXCte0NLxtt+o=;
        b=tASaIq9ArhpHKSvwMVB7znuY2W3jKub8ysHHKJPWWY4H9MLHejbUpUsZmbMyVKNOqU
         XTr1msRnViaaEY9omUDn9WNwc5lGtG2dmDzpCIjjxJu10738tW6AkWM/GMga90Tujpjy
         tTvzddmJtrDb8RrfDVwLoOvQi4hx3FHiaQJ4u2U781mGyYmjcdITBYJYygkvPycdLx2Q
         6g0drlXRxF2BLWNg3Nact5rEuaW+uj9pefrk0E609FCMjsz/mJFeTJzOvyoL9wduk4Mo
         1Et430emeQXKKI8qPeIKL3aph/ZmPZoho9wwwOsfWQNEAXbsi/i9oJrpekPDI9Qv6UVP
         CVhg==
X-Forwarded-Encrypted: i=1; AFNElJ+FkDOocTFZWjIeg9q6Ds0pdFV2ZeTB8V2fHJ845d2Nnb8dqDozYmyaLRhk4GbCcZ0PPCrUC8HYQURTC1AW@vger.kernel.org
X-Gm-Message-State: AOJu0YymJCOtqNQ0k6F4n2aY08OrhPuxIswLIgYVd9guD/Op3Ajw2HhT
	YdSIGB9ERd1KOSTo5W4OhnuLOWCwT/sgo/woL9RcFdEGZE2tyhKPX4lT
X-Gm-Gg: Acq92OG78Qs390OcD55fgOSNcbRpYaNeygyOy0QucBzhY6pAY1ZVdnao8efQDYlAxAQ
	R4x/xB94ekivPUE0F5AbtbZan90hvvBGjLpjsqBbLS2RNG16SDDs1lXKzLzHod32GsGoKijFNzj
	IxsLhBE5yqshob1vH+g44pjK7TH6ZbKjgTEZfKvUnRrNl4T7kP/mgdylihKMZtbtz+FCCwpBGcB
	zXtMNXjrQvL59QacInLQysU7NZCH6/PPwgE1Lux3b+NLRoSYaTg1XuhsJkJjKaZ6829f/v39AfW
	BHyDx8qiFPQk2weYPXOXBGTMiBTI/lt3cXIdVoTjBuozNBgzCo93f1Fc/iTrnKXKYeIpYSI/+PP
	kxh9SjsRTlaIiqtdY0nLgBm4TKcayTGWkdp7rA4sDIJ/mxIZKIsvQuNdLpA3W5IrL67Qh5tojoG
	CIILNG+v+yuRoDtwyZLEy1C8xdAFUphA==
X-Received: by 2002:a05:7301:188b:b0:2c5:c532:1fe1 with SMTP id 5a478bee46e88-30761d0ad83mr1687234eec.3.1780602426335;
        Thu, 04 Jun 2026 12:47:06 -0700 (PDT)
Received: from anonyme ([2605:52c0:2:2f27:be24:11ff:fe89:6f0f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df9bbd4sm5159499eec.30.2026.06.04.12.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 12:47:05 -0700 (PDT)
From: AnonymeMeow <anonymemeow@gmail.com>
To: amir73il@gmail.com
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AnonymeMeow <anonymemeow@gmail.com>
Subject: [DRAFT][PATCH] fanotify: lift pidfd reporting restrictions
Date: Fri,  5 Jun 2026 03:46:50 +0800
Message-ID: <20260604194650.2826-1-anonymemeow@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CAOQ4uxgudh_W2Gcs5qqGce8yO6503yjrGzEwbjTKkT+DLAqufA@mail.gmail.com>
References: <CAOQ4uxgudh_W2Gcs5qqGce8yO6503yjrGzEwbjTKkT+DLAqufA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FAN_REPORT_PIDFD and FAN_REPORT_TID flags used to be mutually
exclusive because by the time the pidfd support was introduced to
fanotify, pidfds could only be created for thread group leaders. Now
that the pidfd API supports thread-specific pidfds via PIDFD_THREAD,
this restriction can be lifted.

Fanotify used to refuse to report pidfds for reaped tasks by applying a
pid_has_task() check before calling pidfd_prepare(). This prevented
userspace from obtaining information about the task.

Register the event pid with pidfs when creating the fanotify event if
pidfd reporting was requested, so pidfd_prepare() can later create a
pidfd for the reaped task.

Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>
---

On 2026-06-03 12:00 +0200, Amir Goldstein wrote:
> 
> Thanks for noticing the oddity and explaining the options.
> 
> We could fail the event in case on ENOMEM because the system
> is likely is a bad shape anyway and other events are likely to fail
> allocation themselves, so I am not objecting to your patch as is,

The existing behavior of fanotify is that, for groups with unlimited
event queues, event allocation is performed with __GFP_NOFAIL and
therefore must not fail. For groups with limited queues, event allocation
uses __GFP_RETRY_MAYFAIL, which avoids entering the OOM path.

Currently, pidfs_register_pid() uses hardcoded GFP_KERNEL. For non-costly
allocations(pid attr falls into this category, am I right?), this is
almost no-fail, but it will not avoid the OOM path. That means it can
bypass fanotify's OOM-killer avoidance mitigation for limited queues
and potentially trigger the OOM killer in the monitoring memcg under
memory pressure, breaking the intended security isolation, as sashiko
mentioned. In the meanwhile, GFP_KERNEL does not guarantee no-fail in
all corner cases, so for unlimited queues, it can still cause events
to be dropped under memory pressure, this is also reported by sashiko.

Since this patch set is meant to be a functional enhancement, I think
dropping events from an unlimited queue is not acceptable and can be
a regression.

The cleanest solution I can come up with is something like this patch.
(I squashed the commits so that sashiko can apply the patch correctly)
It adds a pidfs registration helper that takes a gfp_t argument, and
fanotify registers the pid before allocating the event. With an unlimited
queue, both pid registration and event allocation are no-fail, the
existing behavior is preserved. With a limited queue, if pid registration
fails with ENOMEM, fanotify simply returns NULL and drops the event,
just like it would do if event allocation itself failed with
__GFP_RETRY_MAYFAIL.

This also avoids having to destroy an already allocated event on pid
registration failure. Since the pid reference is only taken when
assigning the event->pid field, there is no extra put_pid() path needed
either. And this guarantees that whenever event allocation succeeds,
the pid has already been registered with pidfs, so userspace can
reliably get a pidfd later. The API semantics are no longer ambiguous.

I also originally thought pidfs_register_pid() did not need to run in
the target memcg because it does not explicitly use __GFP_ACCOUNT.
However, pidfs_attr_cachep is created with SLAB_ACCOUNT, so the
registration should also happen inside the set_active_memcg() scope.
This version does that.

But I don't know whether this amount of churn is justified for a
relatively small feature enhancement. For the next revision, I am
still inclined to send the simpler best-effort registration approach,
unless reviewers think this stricter version is preferable.

In the best-effort version, fanotify would allocate the event first
and then try to register the pid with pidfs using the existing
GFP_KERNEL flag. If registration fails, the event is still queued.
This does mean that pidfd creation at read time is not guarenteed to
succeed if the task has already been reaped, and it also means the
registration allocation may enter the OOM path even though the event
allocation used __GFP_RETRY_MAYFAIL. But I think accepting that very
small corner cases may be preferable if it avoids most of the
additional code churn.

With Best Regards,
Anonymemeow

> 
> but I am slightly leaning towards the semantically ambiguous API.
> 
> I don't think that we are going to change the man page to say that
> FAN_REPORT_PIDFD is guaranteed to return a pidfd, maybe we just
> add a NOTE about increased likelihood of getting a pidfd since kernel XXX
> and mention the known cases of pid namespace and ENOMEM.
> 
> Thanks,
> Amir.
> 

---
 fs/notify/fanotify/fanotify.c      | 17 +++++++++------
 fs/notify/fanotify/fanotify_user.c | 33 +++++++-----------------------
 fs/pidfs.c                         | 23 +++++++++++++++++----
 include/linux/pidfs.h              |  3 +++
 4 files changed, 40 insertions(+), 36 deletions(-)

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
index ae904451dfc0..b604e3da58ad 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -19,6 +19,7 @@
 #include <linux/memcontrol.h>
 #include <linux/statfs.h>
 #include <linux/exportfs.h>
+#include <linux/pidfd.h>
 
 #include <asm/ioctls.h>
 
@@ -903,25 +904,13 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 		metadata.fd = fd >= 0 ? fd : FAN_NOFD;
 
 	if (pidfd_mode) {
-		/*
-		 * Complain if the FAN_REPORT_PIDFD and FAN_REPORT_TID mutual
-		 * exclusion is ever lifted. At the time of incoporating pidfd
-		 * support within fanotify, the pidfd API only supported the
-		 * creation of pidfds for thread-group leaders.
-		 */
-		WARN_ON_ONCE(FAN_GROUP_FLAG(group, FAN_REPORT_TID));
+		unsigned int pidfd_flags = PIDFD_STALE;
 
-		/*
-		 * The PIDTYPE_TGID check for an event->pid is performed
-		 * preemptively in an attempt to catch out cases where the event
-		 * listener reads events after the event generating process has
-		 * already terminated.  Depending on flag FAN_REPORT_FD_ERROR,
-		 * report either -ESRCH or FAN_NOPIDFD to the event listener in
-		 * those cases with all other pidfd creation errors reported as
-		 * the error code itself or as FAN_EPIDFD.
-		 */
-		if (metadata.pid && pid_has_task(event->pid, PIDTYPE_TGID))
-			pidfd = pidfd_prepare(event->pid, 0, &pidfd_file);
+		if (FAN_GROUP_FLAG(group, FAN_REPORT_TID))
+			pidfd_flags |= PIDFD_THREAD;
+
+		if (metadata.pid)
+			pidfd = pidfd_prepare(event->pid, pidfd_flags, &pidfd_file);
 
 		if (!FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR) && pidfd < 0)
 			pidfd = pidfd == -ESRCH ? FAN_NOPIDFD : FAN_EPIDFD;
@@ -1628,14 +1617,6 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 #endif
 		return -EINVAL;
 
-	/*
-	 * A pidfd can only be returned for a thread-group leader; thus
-	 * FAN_REPORT_PIDFD and FAN_REPORT_TID need to remain mutually
-	 * exclusive.
-	 */
-	if ((flags & FAN_REPORT_PIDFD) && (flags & FAN_REPORT_TID))
-		return -EINVAL;
-
 	/* Don't allow mixing mnt events with inode events for now */
 	if (flags & FAN_REPORT_MNT) {
 		if (class != FAN_CLASS_NOTIF)
diff --git a/fs/pidfs.c b/fs/pidfs.c
index 1cce4f34a051..e9f6113efc5b 100644
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
 
@@ -1031,6 +1033,19 @@ int pidfs_register_pid(struct pid *pid)
 	return 0;
 }
 
+/**
+ * pidfs_register_pid - register a struct pid in pidfs
+ * @pid: pid to pin
+ *
+ * Register a struct pid in pidfs.
+ *
+ * Return: On success zero, on error a negative error code is returned.
+ */
+int pidfs_register_pid(struct pid *pid)
+{
+	return pidfs_register_pid_gfp(pid, GFP_KERNEL);
+}
+
 static struct dentry *pidfs_stash_dentry(struct dentry **stashed,
 					 struct dentry *dentry)
 {
diff --git a/include/linux/pidfs.h b/include/linux/pidfs.h
index 416bdff4d6ce..8054f49bc139 100644
--- a/include/linux/pidfs.h
+++ b/include/linux/pidfs.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_PID_FS_H
 #define _LINUX_PID_FS_H
 
+#include <linux/types.h>
+
 struct coredump_params;
 
 struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags);
@@ -14,6 +16,7 @@ void pidfs_exit(struct task_struct *tsk);
 void pidfs_coredump(const struct coredump_params *cprm);
 #endif
 extern const struct dentry_operations pidfs_dentry_operations;
+int pidfs_register_pid_gfp(struct pid *pid, gfp_t gfp);
 int pidfs_register_pid(struct pid *pid);
 void pidfs_free_pid(struct pid *pid);
 
-- 
2.54.0

