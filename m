Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048F03E715C
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 19:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776368959; cv=none; b=dJqlQqLP9iogZeu4J02UnTS7QmzqZy2eMxIaqubLpeH4Ld60rNQzaoU9pYjL1KHxGSKpuLbdhGuo0BTpXnRoJLkzq843upiEzzGXn6yP2ETlkW8gQNVPrsI2zyfyD7JaSYlQlBW7YaXORvn/fR2RbZunlP4GHXpfLfK6BXgYxeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776368959; c=relaxed/simple;
	bh=EZDmy/Q5WTnnUdPkvbeycSnW69xIn+nZLYXDZRXI/hk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BYCKxeBShygltt+56sqa5bD9Lmc01IAuW5F8U2noV+apOpaQoJuZpQBZIe94f/Qq1fqqNv3OiMyWYWvq0ddUD4KA83dNtJnPIlw6gxXARA4znSLqYQLth8w/BcOOP/wK6IbJRH5w7gSTIxQ2wg21l1c5D+DkWs4pn48q7LivboQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=n4x3hkfe; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="n4x3hkfe"
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G8oUJV3317622
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 12:49:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=LrfzjclRjplsww11pSxSpgNlY16z4h3plagR2pBTcp4=; b=n4x3hkfe135L
	vB48tOxAi57707nAp3fLyE9JOSS6A5l+y7emrrZTtd+2IgE9RorCfI0ecqKHHn1b
	qdXqxoJEmxMZIwltt4fAkbno+rkZRdSLI3N/0cfvU38Z04UKpXnEdzjU4aKLE48X
	eU6NZK2bM6KEfTITM8+yWktqr89uLiEtK/wTHmP0XUB3Rdryh8lnuu4dC7c/p/CB
	uU3AOjN0mh3rWNB0Kg9a4R5vlPuOfvudq47EMxU6rtXYuBcuxSiRaSCApqC+pHpJ
	89rFbhT+C6IA7IJKPnrNV0N4E1Ul+Nz0LH+6fdMx18Qa6k2iyyc+fDe0o/KAbYcR
	70D0lgKGwg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dh84wfp23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 12:49:06 -0700 (PDT)
Received: from twshared124602.16.frc2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Thu, 16 Apr 2026 19:49:05 +0000
Received: by devvm13301.ncg0.facebook.com (Postfix, from userid 202792)
	id B201C2C51C255; Thu, 16 Apr 2026 12:49:00 -0700 (PDT)
From: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
To: <ibrahimjirdeh@meta.com>
CC: <jack@suse.cz>, <amir73il@gmail.com>, <josef@toxicpanda.com>,
        <lesha@meta.com>, <linux-fsdevel@vger.kernel.org>, <sargun@meta.com>
Subject: [PATCH v3 2/2] fanotify: introduce restartable permission events
Date: Thu, 16 Apr 2026 12:48:44 -0700
Message-ID: <20260416194844.3874004-3-ibrahimjirdeh@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260416194844.3874004-1-ibrahimjirdeh@meta.com>
References: <20260416194844.3874004-1-ibrahimjirdeh@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDE4OCBTYWx0ZWRfX6L00cdbA+6fo
 4LB8iKYR916NTOcXci90mKyp/mNr5BR2eXj9h/r/qmjKgaN8NFyfZ38SBgB1KLFJMaH0kCni1Jd
 ckr0wHrM/THM7flmM+0Owrm9MlyB6llDnhvVAN+SXU6QTu1mUr1oL1boC/JxJB3hRYieC5hxHVe
 RX8/96tbmTBLnpQ+zKAF+EbF6WBQ24qSU2xn04vj71z/ardm4wFmG8E7mD3+6sQTaAgzpLwDSxx
 egVw42/J5wIL7NUNqTkWWgwMGp30UZKmDCuJgMTnAF782Fpp67cyN9D5PYNlKz6iflugj/IbFwh
 sVRMKkzHUouneYrkCmG4SvysOXeR9GyHliPM5ofOZiiyAn5H8fi82koxGH/0bqLglBqU5ZJuDCW
 /ERt5Er0RemL3Hpd8mqIKT0nrjFfo+2lNFKUgp03AYCe4AkSqkBDv/Dy8Ad3Qzuspo0RPVZkVvO
 rB/UDunwmfOnauTLy9A==
X-Proofpoint-ORIG-GUID: NYlkLCK-bBWYq5riQ1bu9dT6N3EsyGmo
X-Proofpoint-GUID: NYlkLCK-bBWYq5riQ1bu9dT6N3EsyGmo
X-Authority-Analysis: v=2.4 cv=cf7iaHDM c=1 sm=1 tr=0 ts=69e13d32 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=jCddH8ec0KUNCymVuxII:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=pGLkceISAAAA:8
 a=6fnVDA5GkX1-olgWN0MA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01

This adds support for restarting permission events. The main goal of
the change is to provide better handling for pending events for lazy
file loading use cases which may back fanotify events by a long-lived
daemon. For prior discussion of approaches see [1][2].

In terms of implementation, we add a new control-fd/queue-fd api.
Control fd returned by fanotify_init keeps fanotify group alive and
supports operations like fanotify_mark as well as a new ioctl
FAN_IOC_OPEN_QUEUE_FD to open a queue fd. Queue fd is used
for reading events and writing back responses. Upon release of
queue fd, pending permission events are reinserted back into
notification queue for reprocessing.

Control-fd/queue-fd api is guarded by FAN_RESTARTABLE_EVENTS flag.
In addition FAN_RESTARTABLE_EVENTS can only be used in conjunction
with FAN_CLASS_CONTENT or FAN_CLASS_PRE_CONTENT, and only permission
events can be added to the mark mask if a group is initialized with
FAN_RESTARTABLE_EVENTS.

[1] https://lore.kernel.org/linux-fsdevel/6za2mngeqslmqjg3icoubz37hbbxi6b=
i44canfsg2aajgkialt@c3ujlrjzkppr
[2] https://lore.kernel.org/linux-fsdevel/20250623192503.2673076-1-ibrahi=
mjirdeh@meta.com

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxhN6ok6BCBGbxeUt9ULq6g=3D=
qL6=3D_2_QGi8MqTHv5ZN7Vg@mail.gmail.com
Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
---
 fs/notify/fanotify/fanotify.c       |   1 +
 fs/notify/fanotify/fanotify.h       |   4 +
 fs/notify/fanotify/fanotify_user.c  | 123 ++++++++++++++++++++++++++--
 include/linux/fanotify.h            |   1 +
 include/linux/fsnotify_backend.h    |   3 +
 include/uapi/linux/fanotify.h       |   7 ++
 tools/include/uapi/linux/fanotify.h |   7 ++
 7 files changed, 140 insertions(+), 6 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.=
c
index bfe884d624e7..b22474e095cd 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -1015,6 +1015,7 @@ static int fanotify_handle_event(struct fsnotify_gr=
oup *group, u32 mask,
=20
 static void fanotify_free_group_priv(struct fsnotify_group *group)
 {
+	mutex_destroy(&group->fanotify_data.queue_mutex);
 	put_user_ns(group->user_ns);
 	kfree(group->fanotify_data.merge_hash);
 	if (group->fanotify_data.ucounts)
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.=
h
index 39e60218df7c..dd64af8313a9 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -552,3 +552,7 @@ static inline u32 fanotify_get_response_errno(int res=
)
 {
 	return (res >> FAN_ERRNO_SHIFT) & FAN_ERRNO_MASK;
 }
+
+extern const struct file_operations fanotify_fops;
+extern const struct file_operations fanotify_control_fops;
+extern const struct file_operations fanotify_queue_fops;
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
index 787e57a00466..b4610c49daab 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1018,6 +1018,15 @@ static ssize_t fanotify_read(struct file *file, ch=
ar __user *buf,
 			if (file->f_flags & O_NONBLOCK)
 				break;
=20
+			/*
+			 * With FAN_RESTARTABLE_EVENTS, queue fd may
+			 * outlive control fd. Return EOF if group
+			 * is shut down.
+			 */
+			ret =3D 0;
+			if (group->shutdown)
+				break;
+
 			ret =3D -ERESTARTSYS;
 			if (signal_pending(current))
 				break;
@@ -1101,6 +1110,7 @@ static ssize_t fanotify_write(struct file *file, co=
nst char __user *buf, size_t
  */
 static void fanotify_restart_pending_events(struct fsnotify_group *group=
)
 {
+	mutex_lock(&group->fanotify_data.queue_mutex);
 	spin_lock(&group->notification_lock);
 	while (!list_empty(&group->fanotify_data.access_list)) {
 		struct fanotify_perm_event *event;
@@ -1121,10 +1131,21 @@ static void fanotify_restart_pending_events(struc=
t fsnotify_group *group)
 		}
 	}
 	spin_unlock(&group->notification_lock);
+	group->fanotify_data.queue_opened =3D false;
+	mutex_unlock(&group->fanotify_data.queue_mutex);
=20
 	wake_up(&group->notification_waitq);
 }
=20
+static int fanotify_queue_release(struct inode *ignored, struct file *fi=
le)
+{
+	struct fsnotify_group *group =3D file->private_data;
+
+	fanotify_restart_pending_events(group);
+	fsnotify_put_group(group);
+	return 0;
+}
+
 static int fanotify_release(struct inode *ignored, struct file *file)
 {
 	struct fsnotify_group *group =3D file->private_data;
@@ -1182,6 +1203,44 @@ static int fanotify_release(struct inode *ignored,=
 struct file *file)
 	return 0;
 }
=20
+static int fanotify_open_queue_fd(struct file *file)
+{
+	struct fsnotify_group *group =3D file->private_data;
+	int f_flags, fd;
+	struct file *queue_file;
+
+	if (!FAN_GROUP_FLAG(group, FAN_RESTARTABLE_EVENTS))
+		return -EINVAL;
+
+	guard(mutex)(&group->fanotify_data.queue_mutex);
+
+	if (group->fanotify_data.queue_opened)
+		return -EBUSY;
+
+	f_flags =3D O_RDWR;
+	if (group->fanotify_data.flags & FAN_CLOEXEC)
+		f_flags |=3D O_CLOEXEC;
+	if (group->fanotify_data.flags & FAN_NONBLOCK)
+		f_flags |=3D O_NONBLOCK;
+
+	fd =3D get_unused_fd_flags(f_flags);
+	if (fd < 0)
+		return fd;
+
+	queue_file =3D anon_inode_getfile_fmode("[fanotify-queue]",
+					      &fanotify_queue_fops, group,
+					      f_flags, FMODE_NONOTIFY);
+	if (IS_ERR(queue_file)) {
+		put_unused_fd(fd);
+		return PTR_ERR(queue_file);
+	}
+	fsnotify_get_group(group);
+	fd_install(fd, queue_file);
+	group->fanotify_data.queue_opened =3D true;
+
+	return fd;
+}
+
 static long fanotify_ioctl(struct file *file, unsigned int cmd, unsigned=
 long arg)
 {
 	struct fsnotify_group *group;
@@ -1207,7 +1266,21 @@ static long fanotify_ioctl(struct file *file, unsi=
gned int cmd, unsigned long ar
 	return ret;
 }
=20
-static const struct file_operations fanotify_fops =3D {
+static long fanotify_control_ioctl(struct file *file, unsigned int cmd,
+				   unsigned long arg)
+{
+	int ret =3D -ENOTTY;
+
+	switch (cmd) {
+	case FAN_IOC_OPEN_QUEUE_FD:
+		ret =3D fanotify_open_queue_fd(file);
+		break;
+	}
+
+	return ret;
+}
+
+const struct file_operations fanotify_fops =3D {
 	.show_fdinfo	=3D fanotify_show_fdinfo,
 	.poll		=3D fanotify_poll,
 	.read		=3D fanotify_read,
@@ -1219,6 +1292,23 @@ static const struct file_operations fanotify_fops =
=3D {
 	.llseek		=3D noop_llseek,
 };
=20
+const struct file_operations fanotify_control_fops =3D {
+	.show_fdinfo	=3D fanotify_show_fdinfo,
+	.release	=3D fanotify_release,
+	.unlocked_ioctl	=3D fanotify_control_ioctl,
+	.llseek		=3D noop_llseek,
+};
+
+const struct file_operations fanotify_queue_fops =3D {
+	.poll		=3D fanotify_poll,
+	.read		=3D fanotify_read,
+	.write		=3D fanotify_write,
+	.release	=3D fanotify_queue_release,
+	.unlocked_ioctl	=3D fanotify_ioctl,
+	.compat_ioctl	=3D compat_ptr_ioctl,
+	.llseek		=3D noop_llseek,
+};
+
 static int fanotify_find_path(int dfd, const char __user *filename,
 			      struct path *path, unsigned int flags, __u64 mask,
 			      unsigned int obj_type)
@@ -1640,6 +1730,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags,=
 unsigned int, event_f_flags)
 	int f_flags, fd;
 	unsigned int fid_mode =3D flags & FANOTIFY_FID_BITS;
 	unsigned int class =3D flags & FANOTIFY_CLASS_BITS;
+	unsigned int restartable_events =3D flags & FAN_RESTARTABLE_EVENTS;
 	unsigned int internal_flags =3D 0;
=20
 	pr_debug("%s: flags=3D%x event_f_flags=3D%x\n",
@@ -1718,10 +1809,17 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flag=
s, unsigned int, event_f_flags)
 	    (!(fid_mode & FAN_REPORT_NAME) || !(fid_mode & FAN_REPORT_FID)))
 		return -EINVAL;
=20
-	f_flags =3D O_RDWR;
+	/*
+	 * FAN_RESTARTABLE_EVENTS requires FAN_CLASS_CONTENT or
+	 * FAN_CLASS_PRE_CONTENT
+	 */
+	if (restartable_events && class =3D=3D FAN_CLASS_NOTIF)
+		return -EINVAL;
+
+	f_flags =3D restartable_events ? O_RDONLY : O_RDWR;
 	if (flags & FAN_CLOEXEC)
 		f_flags |=3D O_CLOEXEC;
-	if (flags & FAN_NONBLOCK)
+	if (!restartable_events && (flags & FAN_NONBLOCK))
 		f_flags |=3D O_NONBLOCK;
=20
 	CLASS(fsnotify_group, group)(&fanotify_fsnotify_ops,
@@ -1754,6 +1852,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags,=
 unsigned int, event_f_flags)
 	init_waitqueue_head(&group->fanotify_data.access_waitq);
 	INIT_LIST_HEAD(&group->fanotify_data.access_list);
 	INIT_LIST_HEAD(&group->fanotify_data.perm_grp_list);
+	mutex_init(&group->fanotify_data.queue_mutex);
 	switch (class) {
 	case FAN_CLASS_NOTIF:
 		group->priority =3D FSNOTIFY_PRIO_NORMAL;
@@ -1781,7 +1880,9 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags,=
 unsigned int, event_f_flags)
 	}
=20
 	fd =3D FD_ADD(f_flags,
-		    anon_inode_getfile_fmode("[fanotify]", &fanotify_fops,
+		    anon_inode_getfile_fmode("[fanotify]",
+					     (restartable_events ? &fanotify_control_fops :
+					     &fanotify_fops),
 					     group, f_flags, FMODE_NONOTIFY));
 	if (fd >=3D 0)
 		retain_and_null_ptr(group);
@@ -1999,7 +2100,8 @@ static int do_fanotify_mark(int fanotify_fd, unsign=
ed int flags, __u64 mask,
 		return -EBADF;
=20
 	/* verify that this is indeed an fanotify instance */
-	if (unlikely(fd_file(f)->f_op !=3D &fanotify_fops))
+	if (unlikely(fd_file(f)->f_op !=3D &fanotify_fops &&
+		fd_file(f)->f_op !=3D &fanotify_control_fops))
 		return -EINVAL;
 	group =3D fd_file(f)->private_data;
=20
@@ -2035,6 +2137,15 @@ static int do_fanotify_mark(int fanotify_fd, unsig=
ned int flags, __u64 mask,
 		 group->priority =3D=3D FSNOTIFY_PRIO_CONTENT)
 		return -EINVAL;
=20
+	/*
+	 * With FAN_RESTARTABLE_EVENTS, a user is only allowed to setup
+	 * permission events and modify event flags.
+	 */
+	if (FAN_GROUP_FLAG(group, FAN_RESTARTABLE_EVENTS) &&
+	    (mask & ~(FANOTIFY_FD_EVENTS | FANOTIFY_MOUNT_EVENTS |
+		      FANOTIFY_EVENT_FLAGS)))
+		return -EINVAL;
+
 	if (mask & FAN_FS_ERROR &&
 	    mark_type !=3D FAN_MARK_FILESYSTEM)
 		return -EINVAL;
@@ -2224,7 +2335,7 @@ static int __init fanotify_user_setup(void)
 				     FANOTIFY_DEFAULT_MAX_USER_MARKS);
=20
 	BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAGS);
-	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) !=3D 14);
+	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) !=3D 15);
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) !=3D 11);
=20
 	fanotify_mark_cache =3D KMEM_CACHE(fanotify_mark,
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 879cff5eccd4..38854a1d6485 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -37,6 +37,7 @@
 					 FAN_REPORT_TID | \
 					 FAN_REPORT_PIDFD | \
 					 FAN_REPORT_FD_ERROR | \
+					 FAN_RESTARTABLE_EVENTS | \
 					 FAN_UNLIMITED_QUEUE | \
 					 FAN_UNLIMITED_MARKS)
=20
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_ba=
ckend.h
index 0d954ea7b179..f1167d728a47 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -275,6 +275,9 @@ struct fsnotify_group {
 			mempool_t error_events_pool;
 			/* chained on perm_group_list */
 			struct list_head perm_grp_list;
+			/* protects queue fd open/release */
+			struct mutex queue_mutex;
+			bool queue_opened;
 		} fanotify_data;
 #endif /* CONFIG_FANOTIFY */
 	};
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.=
h
index e710967c7c26..a838582e113d 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -68,6 +68,8 @@
 #define FAN_REPORT_FD_ERROR	0x00002000	/* event->fd can report error */
 #define FAN_REPORT_MNT		0x00004000	/* Report mount events */
=20
+#define FAN_RESTARTABLE_EVENTS	0x00010000	/* enable control-fd/queue-fd =
api */
+
 /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
 #define FAN_REPORT_DFID_NAME	(FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
 /* Convenience macro - FAN_REPORT_TARGET_FID requires all other FID flag=
s */
@@ -271,4 +273,9 @@ struct fanotify_response_info_audit_rule {
 				(long)(meta)->event_len >=3D (long)FAN_EVENT_METADATA_LEN && \
 				(long)(meta)->event_len <=3D (long)(len))
=20
+/* fanotify ioctls */
+
+/* Open a queue fd used in control-fd api to read and respond to events =
*/
+#define FAN_IOC_OPEN_QUEUE_FD	_IO('F', 0xF0)
+
 #endif /* _UAPI_LINUX_FANOTIFY_H */
diff --git a/tools/include/uapi/linux/fanotify.h b/tools/include/uapi/lin=
ux/fanotify.h
index e710967c7c26..a838582e113d 100644
--- a/tools/include/uapi/linux/fanotify.h
+++ b/tools/include/uapi/linux/fanotify.h
@@ -68,6 +68,8 @@
 #define FAN_REPORT_FD_ERROR	0x00002000	/* event->fd can report error */
 #define FAN_REPORT_MNT		0x00004000	/* Report mount events */
=20
+#define FAN_RESTARTABLE_EVENTS	0x00010000	/* enable control-fd/queue-fd =
api */
+
 /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
 #define FAN_REPORT_DFID_NAME	(FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
 /* Convenience macro - FAN_REPORT_TARGET_FID requires all other FID flag=
s */
@@ -271,4 +273,9 @@ struct fanotify_response_info_audit_rule {
 				(long)(meta)->event_len >=3D (long)FAN_EVENT_METADATA_LEN && \
 				(long)(meta)->event_len <=3D (long)(len))
=20
+/* fanotify ioctls */
+
+/* Open a queue fd used in control-fd api to read and respond to events =
*/
+#define FAN_IOC_OPEN_QUEUE_FD	_IO('F', 0xF0)
+
 #endif /* _UAPI_LINUX_FANOTIFY_H */
--=20
2.52.0

