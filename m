Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657903E1CE1
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050320; cv=none; b=PhYixWNDbUiGllqRSQ8wh7XeznhMG5l4AexaxcKMOARFM6OXLVW+j/Veq7v5iOhb96FwcErB/2jlR055AFX2yjpXo8g50B99DdErBK01Qt9DDxYJpEG4yZYrKHhAikw+nQpD1iI8SHflBrHzzTO6wyRwKviGdoMOAvidbdXa7Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050320; c=relaxed/simple;
	bh=uJLo2H7ZvjbyXd6tGfUtjbpNjpTegWgays642zJGfqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t1pDIGYSKXonHLNrvl4v5TfeiUOp4yGaHdRbTVManDsUnqfTKUPXmb3RZ8DpmuQ/DWOZtXMHOG+KV1r1mESzytG1WAd+T8PgN2JoDg1saloScXAXFqsIG+u4Mif6BbmqGcGmabDppzqwW9aUFEsGKLS9EmPBcvvghDoyVo2EKM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVC87AK7; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVC87AK7"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b8f97c626aaso374971766b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 10:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777050316; x=1777655116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2l/LDPlN4ewYutt1+Z08sSdwKsUVl8wFhImg5zMdeL8=;
        b=LVC87AK7tRGpn3p5nJcv2y65XeWUmlec3CJbz3sJvzB6DskvnCn5b7WVfDuGMccAut
         IrF9af1Ya6OeYRyR5TfIkBWk03W6OZURqOczY7o3ILHALLtkY4L/WEf63U8ZZ0/Xc2uG
         fqSPb5aOsnu94gbxHjB/2tTdtfCr5EDgJC9e0mLJyZ6Bf45nNBieQfn0HJWfZdWoZxyv
         OsvdPUMa6M/sSKYYgwnytoRQ545OLOXQDKBKTqwV0OUnJA28SIvWw9AT6fiEhC1gSXQz
         IdnPXgB5FDoInq0bQ7KMkGxrNL3pNT7J3cnXDRXkjVZHK+T2995XkjotgtpEv8hvICpt
         gkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777050316; x=1777655116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2l/LDPlN4ewYutt1+Z08sSdwKsUVl8wFhImg5zMdeL8=;
        b=AtI9pwpJ2+s1AF9O6cqtUv7SOPCUmPKKofXPu9Hvt2WPiUFp94eNzt93+fPqZ4yy90
         8uQqmWXlpedjDedO8KMBYZPBIemlhgG9QqvtPAt5eAa4V2NXTwGaTG+FrHsnXZrb9Eiy
         kDv3wp/LaiHzh1mC4SoGlHepME41chsxJZDEmIUOaSNkIFULZmxSBeSBD84D2AbaApm0
         8aptXfIp3OZo7mO11LmuX3Z5kTUQI00KV1DZM+shGXPxULrKnMmUxXxWJ2baaQUSOlcA
         na3MH+YOFGkPfAbS8tUFxaVQxFxglgaTIXTWCwCOHR9oaU7AbwmtY1lhzV+wRAB41T9J
         k7hA==
X-Forwarded-Encrypted: i=1; AFNElJ+iV56ncnLxM3zZshrdczPb3Px6/x5wIJr5IttOSZ2qekqxJNrhxpNScvpuPuvenl+Fsez5ugGSxgvPDOIs@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmi3C2Kk5g1vDHzMIfP3tyrMGwCDEgtrYDfbpGAH9cPHgA+yqN
	d9mqaRL1cW7RBDEjxUGK/8yQDKGYuA4tkvILnTuyss0kEGRvEwBC5rzl
X-Gm-Gg: AeBDieuJTKjwVxUVQRmvfdZTj2vfvTRxpmya4TzlSdtv3uMdO6558BLQEK80NkQzFI/
	LYS0QauWzJA173vRCcVUG2JhJ1TVHppnmnfrvtcZKK1PvAwLmuoV+5gEIGR4k+FuRWfIyxtcFlE
	NF76Om9zSS2U1mD/kkbQD7nXTe+9YeaD7HZhYrD+alL2B6/yl7NF/PKSQymrmpnt0PA260hKmWQ
	ch2AfvSLJOqpUFBEPkI7Twh4I2n00pJlTWNj4V3b4NpfNMIWgj1pJlhT9Ji5lxHSY0/YaRHZXUf
	U6YBqtX/WUkakqSeVMUhNo9QJmNd4X/olKWDRwRwpIGqWp2PH3Mg3JhqIDNk8JsSezq48ga+McQ
	GbJJ/dZTRAcj5CzaCpw25ULSqV2Zq8ZwyN1UWB1DyZHunAJRQzpSh6Aae7JbMMYWSwnYpVVyd1m
	u0HPn2LDyzszndNKh/muyJuZ4ivEpyQIVz8LCFDl3CEYwcVsBlC/m+Srz7MjqDOMCP+7fzYb5gd
	3DCqMBQ0na1KUJVC1JkTW+jjJUJLp086j0MyOQXRFs+J4TVwQ==
X-Received: by 2002:a17:907:3d8e:b0:ba7:4cd9:ca12 with SMTP id a640c23a62f3a-ba74cd9eeecmr156749666b.13.1777050315094;
        Fri, 24 Apr 2026 10:05:15 -0700 (PDT)
Received: from localhost (2001-1c00-570d-ee00-4aab-734a-1928-df3f.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:4aab:734a:1928:df3f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba44e5749d9sm810021766b.0.2026.04.24.10.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 10:05:14 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 08/10] fanotify: add support for watching the namespaces tree
Date: Fri, 24 Apr 2026 19:05:01 +0200
Message-ID: <20260424170503.2096847-9-amir73il@gmail.com>
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

Introduce FAN_MARK_USERNS type to mark a user namespace object
from nsfs path.

Support two events FAN_NS_CREATE and FAN_NS_DELETE to report creation
and tear down of namespaces owned by the marked userns.

Introduce FAN_REPORT_NSID to report the self and owner nsid of
the created or torn down namespace.

An fanotify group initialized with flags FAN_REPORT_MNT and
FAN_REPORT_NSID, may add marks on both userns and mntns objects
to mix mount and namespace events, but the same group cannot also
request filesystem events.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 33 +++++++++++++++-
 fs/notify/fanotify/fanotify.h      | 19 ++++++++++
 fs/notify/fanotify/fanotify_user.c | 61 ++++++++++++++++++++++++++++--
 fs/notify/fdinfo.c                 |  9 ++++-
 fs/notify/fsnotify.c               | 30 +++++++++++++++
 fs/notify/fsnotify.h               | 12 ++++++
 fs/notify/mark.c                   |  7 ++++
 fs/nsfs.c                          | 21 ++++++++++
 include/linux/fanotify.h           | 10 +++--
 include/linux/fsnotify.h           |  5 +++
 include/linux/fsnotify_backend.h   | 33 ++++++++++++++++
 include/linux/proc_fs.h            |  2 +
 include/linux/user_namespace.h     |  6 +++
 include/uapi/linux/fanotify.h      | 12 ++++++
 kernel/nscommon.c                  | 47 +++++++++++++++++++++++
 kernel/user_namespace.c            |  2 +
 16 files changed, 299 insertions(+), 10 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 987092c38789b..b3add9ccea4cf 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -168,6 +168,8 @@ static bool fanotify_should_merge(struct fanotify_event *old,
 						  FANOTIFY_EE(new));
 	case FANOTIFY_EVENT_TYPE_MNT:
 		return false;
+	case FANOTIFY_EVENT_TYPE_NS:
+		return false;
 	default:
 		WARN_ON_ONCE(1);
 	}
@@ -316,7 +318,8 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 
 	if (fsnotify_is_ns_watcher(group)) {
 		user_mask = FANOTIFY_OUTGOING_NS_EVENTS;
-		if (data_type != FSNOTIFY_EVENT_MNT)
+		if (data_type != FSNOTIFY_EVENT_MNT &&
+		    data_type != FSNOTIFY_EVENT_NS)
 			return 0;
 	} else if (WARN_ON_ONCE(!fsnotify_is_fs_watcher(group))) {
 		return 0;
@@ -585,6 +588,23 @@ static struct fanotify_event *fanotify_alloc_mnt_event(u64 mnt_id, gfp_t gfp)
 	return &pevent->fae;
 }
 
+static struct fanotify_event *fanotify_alloc_userns_event(
+					const struct fsnotify_ns *ns_data,
+					gfp_t gfp)
+{
+	struct fanotify_ns_event *pevent;
+
+	pevent = kmem_cache_alloc(fanotify_ns_event_cachep, gfp);
+	if (!pevent)
+		return NULL;
+
+	pevent->fae.type = FANOTIFY_EVENT_TYPE_NS;
+	pevent->self_nsid = ns_data->self_nsid;
+	pevent->owner_nsid = ns_data->owner_nsid;
+
+	return &pevent->fae;
+}
+
 static struct fanotify_event *fanotify_alloc_perm_event(const void *data,
 							int data_type,
 							gfp_t gfp)
@@ -866,6 +886,7 @@ static struct fanotify_event *fanotify_alloc_ns_watcher_event(
 				struct fsnotify_group *group, u64 mask,
 				const void *data, int data_type)
 {
+	const struct fsnotify_ns *ns_data = fsnotify_data_ns(data, data_type);
 	u64 mnt_id = fsnotify_data_mnt_id(data, data_type);
 	struct mem_cgroup *old_memcg;
 	struct fanotify_event *event = NULL;
@@ -880,6 +901,8 @@ static struct fanotify_event *fanotify_alloc_ns_watcher_event(
 
 	if (mnt_id) {
 		event = fanotify_alloc_mnt_event(mnt_id, gfp);
+	} else if (ns_data) {
+		event = fanotify_alloc_userns_event(ns_data, gfp);
 	} else {
 		WARN_ON_ONCE(1);
 	}
@@ -1110,6 +1133,11 @@ static void fanotify_free_mnt_event(struct fanotify_event *event)
 	kmem_cache_free(fanotify_mnt_event_cachep, FANOTIFY_ME(event));
 }
 
+static void fanotify_free_ns_event(struct fanotify_event *event)
+{
+	kmem_cache_free(fanotify_ns_event_cachep, FANOTIFY_NSE(event));
+}
+
 static void fanotify_free_event(struct fsnotify_group *group,
 				struct fsnotify_event *fsn_event)
 {
@@ -1139,6 +1167,9 @@ static void fanotify_free_event(struct fsnotify_group *group,
 	case FANOTIFY_EVENT_TYPE_MNT:
 		fanotify_free_mnt_event(event);
 		break;
+	case FANOTIFY_EVENT_TYPE_NS:
+		fanotify_free_ns_event(event);
+		break;
 	default:
 		WARN_ON_ONCE(1);
 	}
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 56bbee15b7ee3..c6c5145101908 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -11,6 +11,7 @@ extern struct kmem_cache *fanotify_fid_event_cachep;
 extern struct kmem_cache *fanotify_path_event_cachep;
 extern struct kmem_cache *fanotify_perm_event_cachep;
 extern struct kmem_cache *fanotify_mnt_event_cachep;
+extern struct kmem_cache *fanotify_ns_event_cachep;
 
 /* Possible states of the permission event */
 enum {
@@ -246,6 +247,7 @@ enum fanotify_event_type {
 	FANOTIFY_EVENT_TYPE_OVERFLOW, /* struct fanotify_event */
 	FANOTIFY_EVENT_TYPE_FS_ERROR, /* struct fanotify_error_event */
 	FANOTIFY_EVENT_TYPE_MNT,
+	FANOTIFY_EVENT_TYPE_NS,
 	__FANOTIFY_EVENT_TYPE_NUM
 };
 
@@ -417,6 +419,12 @@ struct fanotify_mnt_event {
 	u64 mnt_id;
 };
 
+struct fanotify_ns_event {
+	struct fanotify_event fae;
+	u64 self_nsid;
+	u64 owner_nsid;
+};
+
 static inline struct fanotify_path_event *
 FANOTIFY_PE(struct fanotify_event *event)
 {
@@ -429,6 +437,12 @@ FANOTIFY_ME(struct fanotify_event *event)
 	return container_of(event, struct fanotify_mnt_event, fae);
 }
 
+static inline struct fanotify_ns_event *
+FANOTIFY_NSE(struct fanotify_event *event)
+{
+	return container_of(event, struct fanotify_ns_event, fae);
+}
+
 /*
  * Structure for permission fanotify events. It gets allocated and freed in
  * fanotify_handle_event() since we wait there for user response. When the
@@ -511,6 +525,11 @@ static inline bool fanotify_is_mnt_event(struct fanotify_event *event)
 	return event->type == FANOTIFY_EVENT_TYPE_MNT;
 }
 
+static inline bool fanotify_is_ns_event(const struct fanotify_event *event)
+{
+	return event->type == FANOTIFY_EVENT_TYPE_NS;
+}
+
 static inline const struct path *fanotify_event_path(struct fanotify_event *event)
 {
 	if (event->type == FANOTIFY_EVENT_TYPE_PATH)
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 4c1767b3c1a06..b3f75aaed74ce 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -19,6 +19,7 @@
 #include <linux/memcontrol.h>
 #include <linux/statfs.h>
 #include <linux/exportfs.h>
+#include <linux/proc_fs.h>
 
 #include <asm/ioctls.h>
 
@@ -208,6 +209,7 @@ struct kmem_cache *fanotify_fid_event_cachep __ro_after_init;
 struct kmem_cache *fanotify_path_event_cachep __ro_after_init;
 struct kmem_cache *fanotify_perm_event_cachep __ro_after_init;
 struct kmem_cache *fanotify_mnt_event_cachep __ro_after_init;
+struct kmem_cache *fanotify_ns_event_cachep __ro_after_init;
 
 #define FANOTIFY_EVENT_ALIGN 4
 #define FANOTIFY_FID_INFO_HDR_LEN \
@@ -220,6 +222,8 @@ struct kmem_cache *fanotify_mnt_event_cachep __ro_after_init;
 	(sizeof(struct fanotify_event_info_range))
 #define FANOTIFY_MNT_INFO_LEN \
 	(sizeof(struct fanotify_event_info_mnt))
+#define FANOTIFY_NS_INFO_LEN \
+	(sizeof(struct fanotify_event_info_ns))
 
 static int fanotify_fid_info_len(int fh_len, int name_len)
 {
@@ -277,6 +281,8 @@ static size_t fanotify_event_len(unsigned int info_mode,
 	}
 	if (fanotify_is_mnt_event(event))
 		event_len += FANOTIFY_MNT_INFO_LEN;
+	if (fanotify_is_ns_event(event))
+		event_len += FANOTIFY_NS_INFO_LEN;
 
 	if (info_mode & FAN_REPORT_PIDFD)
 		event_len += FANOTIFY_PIDFD_INFO_LEN;
@@ -523,6 +529,26 @@ static size_t copy_mnt_info_to_user(struct fanotify_event *event,
 	return info.hdr.len;
 }
 
+static size_t copy_ns_info_to_user(struct fanotify_event *event,
+				   char __user *buf, int count)
+{
+	struct fanotify_event_info_ns info = { };
+
+	info.hdr.info_type = FAN_EVENT_INFO_TYPE_NS;
+	info.hdr.len = sizeof(info);
+
+	if (WARN_ON(count < info.hdr.len))
+		return -EFAULT;
+
+	info.self_nsid  = FANOTIFY_NSE(event)->self_nsid;
+	info.owner_nsid = FANOTIFY_NSE(event)->owner_nsid;
+
+	if (copy_to_user(buf, &info, sizeof(info)))
+		return -EFAULT;
+
+	return info.hdr.len;
+}
+
 static size_t copy_error_info_to_user(struct fanotify_event *event,
 				      char __user *buf, int count)
 {
@@ -827,6 +853,15 @@ static int copy_info_records_to_user(struct fanotify_event *event,
 		total_bytes += ret;
 	}
 
+	if (fanotify_is_ns_event(event)) {
+		ret = copy_ns_info_to_user(event, buf, count);
+		if (ret < 0)
+			return ret;
+		buf += ret;
+		count -= ret;
+		total_bytes += ret;
+	}
+
 	return total_bytes;
 }
 
@@ -1918,10 +1953,17 @@ static bool fanotify_is_valid_mask(struct fsnotify_group *group, int mark_type,
 			valid_mask &= ~FANOTIFY_PERM_EVENTS;
 		break;
 	case FSNOTIFY_GROUP_TYPE_NS:
-		/* Only report mount events on mntns mark */
+		/*
+		 * Only report mount events on mntns mark
+		 * Only report ns events on userns mark
+		 */
 		if (mark_type == FAN_MARK_MNTNS &&
-		    FAN_GROUP_FLAG(group, FAN_REPORT_MNT))
+		    FAN_GROUP_FLAG(group, FAN_REPORT_MNT)) {
 			valid_mask = FANOTIFY_MOUNT_EVENTS;
+		} else if (mark_type == FAN_MARK_USERNS &&
+			   FAN_GROUP_FLAG(group, FAN_REPORT_NSID)) {
+			valid_mask = FANOTIFY_NS_EVENTS;
+		}
 		break;
 	}
 
@@ -1973,6 +2015,10 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		obj_type = FSNOTIFY_OBJ_TYPE_MNTNS;
 		group_type = FSNOTIFY_GROUP_TYPE_NS;
 		break;
+	case FAN_MARK_USERNS:
+		obj_type = FSNOTIFY_OBJ_TYPE_USERNS;
+		group_type = FSNOTIFY_GROUP_TYPE_NS;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -2136,6 +2182,12 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 			goto path_put_and_out;
 		user_ns = mntns->user_ns;
 		obj = mntns;
+	} else if (obj_type == FSNOTIFY_OBJ_TYPE_USERNS) {
+		ret = -EINVAL;
+		user_ns = userns_from_dentry(path.dentry);
+		if (!user_ns)
+			goto path_put_and_out;
+		obj = user_ns;
 	}
 
 	ret = -EPERM;
@@ -2239,8 +2291,8 @@ static int __init fanotify_user_setup(void)
 				     FANOTIFY_DEFAULT_MAX_USER_MARKS);
 
 	BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAGS);
-	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 14);
-	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 11);
+	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 15);
+	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 12);
 
 	fanotify_mark_cache = KMEM_CACHE(fanotify_mark,
 					 SLAB_PANIC|SLAB_ACCOUNT);
@@ -2253,6 +2305,7 @@ static int __init fanotify_user_setup(void)
 			KMEM_CACHE(fanotify_perm_event, SLAB_PANIC);
 	}
 	fanotify_mnt_event_cachep = KMEM_CACHE(fanotify_mnt_event, SLAB_PANIC);
+	fanotify_ns_event_cachep = KMEM_CACHE(fanotify_ns_event, SLAB_PANIC);
 
 	fanotify_max_queued_events = FANOTIFY_DEFAULT_MAX_EVENTS;
 	init_user_ns.ucount_max[UCOUNT_FANOTIFY_GROUPS] =
diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index 0f731eddeb8be..fa05253f19e19 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -130,8 +130,13 @@ static void fanotify_fdinfo(struct seq_file *m, struct fsnotify_mark *mark)
 	} else if (mark->connector->type == FSNOTIFY_OBJ_TYPE_MNTNS) {
 		struct mnt_namespace *mnt_ns = fsnotify_conn_mntns(mark->connector);
 
-		seq_printf(m, "fanotify mnt_ns:%u mflags:%x mask:%x ignored_mask:%x\n",
-			   mnt_ns->ns.inum, mflags, mark->mask, mark->ignore_mask);
+		seq_printf(m, "fanotify mnt_ns_id:%llu mflags:%x mask:%x ignored_mask:%x\n",
+			   mnt_ns->ns.ns_id, mflags, mark->mask, mark->ignore_mask);
+	} else if (mark->connector->type == FSNOTIFY_OBJ_TYPE_USERNS) {
+		struct user_namespace *userns = fsnotify_conn_userns(mark->connector);
+
+		seq_printf(m, "fanotify user_ns_id:%llu mflags:%x mask:%x ignored_mask:%x\n",
+			   userns->ns.ns_id, mflags, mark->mask, mark->ignore_mask);
 	}
 }
 
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index db79f51d8109c..9ffa96e6e7f4d 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -33,6 +33,11 @@ void __fsnotify_mntns_delete(struct mnt_namespace *mntns)
 	fsnotify_clear_marks_by_mntns(mntns);
 }
 
+void __fsnotify_userns_delete(struct user_namespace *userns)
+{
+	fsnotify_clear_marks_by_userns(userns);
+}
+
 void fsnotify_sb_delete(struct super_block *sb)
 {
 	struct fsnotify_sb_info *sbinfo = fsnotify_sb_info(sb);
@@ -702,12 +707,15 @@ int fsnotify_open_perm_and_set_mode(struct file *file)
 static int send_to_ns_groups(__u32 mask, const void *data, int data_type)
 {
 	const struct fsnotify_mnt *mnt_data = fsnotify_data_mnt(data, data_type);
+	const struct fsnotify_ns *ns_data = fsnotify_data_ns(data, data_type);
 	struct fsnotify_iter_info iter_info = {};
 	__u32 test_mask, marks_mask = 0;
 	int ret;
 
 	if (mnt_data)
 		marks_mask |= READ_ONCE(mnt_data->ns->n_fsnotify_mask);
+	if (ns_data)
+		marks_mask |= READ_ONCE(ns_data->userns->n_fsnotify_mask);
 
 	test_mask = mask & FSNOTIFY_EVENTS_ON_NS;
 	if (!(test_mask & marks_mask))
@@ -719,6 +727,10 @@ static int send_to_ns_groups(__u32 mask, const void *data, int data_type)
 		iter_info.marks[FSNOTIFY_ITER_TYPE_MNTNS] =
 			fsnotify_first_mark(&mnt_data->ns->n_fsnotify_marks);
 	}
+	if (ns_data) {
+		iter_info.marks[FSNOTIFY_ITER_TYPE_USERNS] =
+			fsnotify_first_mark(&ns_data->userns->n_fsnotify_marks);
+	}
 
 	ret = send_to_groups(mask, data, data_type, NULL, NULL, 0, &iter_info,
 			     FSNOTIFY_GROUP_TYPE_NS);
@@ -748,6 +760,24 @@ void fsnotify_mnt(__u32 mask, struct mnt_namespace *ns, struct vfsmount *mnt)
 	send_to_ns_groups(mask, &data, FSNOTIFY_EVENT_MNT);
 }
 
+void fsnotify_ns(__u32 mask, struct user_namespace *userns,
+		 u64 self_nsid, u64 owner_nsid)
+{
+	struct fsnotify_ns data = {
+		.userns = userns,
+		.self_nsid = self_nsid,
+		.owner_nsid = owner_nsid,
+	};
+
+	if (WARN_ON_ONCE(!userns))
+		return;
+
+	if (!READ_ONCE(userns->n_fsnotify_marks))
+		return;
+
+	send_to_ns_groups(mask, &data, FSNOTIFY_EVENT_NS);
+}
+
 static __init int fsnotify_init(void)
 {
 	int ret;
diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
index 58c7bb25e5718..557a5734a6841 100644
--- a/fs/notify/fsnotify.h
+++ b/fs/notify/fsnotify.h
@@ -6,6 +6,7 @@
 #include <linux/fsnotify.h>
 #include <linux/srcu.h>
 #include <linux/types.h>
+#include <linux/user_namespace.h>
 
 #include "../mount.h"
 
@@ -39,6 +40,12 @@ static inline struct mnt_namespace *fsnotify_conn_mntns(
 	return conn->obj;
 }
 
+static inline struct user_namespace *fsnotify_conn_userns(
+				struct fsnotify_mark_connector *conn)
+{
+	return conn->obj;
+}
+
 static inline struct super_block *fsnotify_object_sb(void *obj,
 			enum fsnotify_obj_type obj_type)
 {
@@ -103,6 +110,11 @@ static inline void fsnotify_clear_marks_by_mntns(struct mnt_namespace *mntns)
 	fsnotify_destroy_marks(&mntns->n_fsnotify_marks);
 }
 
+static inline void fsnotify_clear_marks_by_userns(struct user_namespace *userns)
+{
+	fsnotify_destroy_marks(&userns->n_fsnotify_marks);
+}
+
 /*
  * update the dentry->d_flags of all of inode's children to indicate if inode cares
  * about events that happen to its children.
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 961475090f088..76b01dba7b727 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -74,6 +74,7 @@
 #include <linux/atomic.h>
 
 #include <linux/fsnotify_backend.h>
+#include <linux/user_namespace.h>
 #include "fsnotify.h"
 
 #define FSNOTIFY_REAPER_DELAY	(1)	/* 1 jiffy */
@@ -110,6 +111,8 @@ static fsnotify_connp_t *fsnotify_object_connp(void *obj,
 		return fsnotify_sb_marks(obj);
 	case FSNOTIFY_OBJ_TYPE_MNTNS:
 		return &((struct mnt_namespace *)obj)->n_fsnotify_marks;
+	case FSNOTIFY_OBJ_TYPE_USERNS:
+		return &((struct user_namespace *)obj)->n_fsnotify_marks;
 	default:
 		return NULL;
 	}
@@ -125,6 +128,8 @@ static __u32 *fsnotify_conn_mask_p(struct fsnotify_mark_connector *conn)
 		return &fsnotify_conn_sb(conn)->s_fsnotify_mask;
 	else if (conn->type == FSNOTIFY_OBJ_TYPE_MNTNS)
 		return &fsnotify_conn_mntns(conn)->n_fsnotify_mask;
+	else if (conn->type == FSNOTIFY_OBJ_TYPE_USERNS)
+		return &fsnotify_conn_userns(conn)->n_fsnotify_mask;
 	return NULL;
 }
 
@@ -389,6 +394,8 @@ static void *fsnotify_detach_connector_from_object(
 		fsnotify_conn_sb(conn)->s_fsnotify_mask = 0;
 	} else if (conn->type == FSNOTIFY_OBJ_TYPE_MNTNS) {
 		fsnotify_conn_mntns(conn)->n_fsnotify_mask = 0;
+	} else if (conn->type == FSNOTIFY_OBJ_TYPE_USERNS) {
+		fsnotify_conn_userns(conn)->n_fsnotify_mask = 0;
 	}
 
 	rcu_assign_pointer(*connp, NULL);
diff --git a/fs/nsfs.c b/fs/nsfs.c
index 51e8c9430477b..b0c3ffe528b31 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -387,6 +387,27 @@ bool proc_ns_file(const struct file *file)
 	return file->f_op == &ns_file_operations;
 }
 
+/**
+ * userns_from_dentry() - Return the user_namespace referenced by an nsfs dentry.
+ * @dentry: dentry of an open nsfs file
+ *
+ * Returns the user_namespace if @dentry is an nsfs file for a user namespace,
+ * NULL otherwise.  The caller is responsible for ensuring the returned pointer
+ * remains valid (e.g. by holding a reference to the dentry).
+ */
+struct user_namespace *userns_from_dentry(struct dentry *dentry)
+{
+	struct inode *inode = d_inode(dentry);
+	struct ns_common *ns;
+
+	if (!inode || inode->i_sb->s_magic != NSFS_MAGIC)
+		return NULL;
+	ns = get_proc_ns(inode);
+	if (!ns || ns->ns_type != CLONE_NEWUSER)
+		return NULL;
+	return to_user_ns(ns);
+}
+
 /**
  * ns_match() - Returns true if current namespace matches dev/ino provided.
  * @ns: current namespace
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 224303a0c31e1..b1aa1e432e92a 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -28,7 +28,7 @@
 #define FANOTIFY_INFO_MODES	(FANOTIFY_FID_BITS | FAN_REPORT_PIDFD)
 
 /* fanotify_init() flags to create a namepsace event watcher */
-#define FANOTIFY_NS_INIT_FLAGS	(FAN_REPORT_MNT)
+#define FANOTIFY_NS_INIT_FLAGS	(FAN_REPORT_MNT | FAN_REPORT_NSID)
 
 /*
  * fanotify_init() flags that require CAP_SYS_ADMIN.
@@ -62,7 +62,8 @@
 #define FANOTIFY_INTERNAL_GROUP_FLAGS	(FANOTIFY_UNPRIV)
 
 #define FANOTIFY_MARK_TYPE_BITS	(FAN_MARK_INODE | FAN_MARK_MOUNT | \
-				 FAN_MARK_FILESYSTEM | FAN_MARK_MNTNS)
+				 FAN_MARK_FILESYSTEM | FAN_MARK_MNTNS | \
+				 FAN_MARK_USERNS)
 
 #define FANOTIFY_MARK_CMD_BITS	(FAN_MARK_ADD | FAN_MARK_REMOVE | \
 				 FAN_MARK_FLUSH)
@@ -122,8 +123,11 @@
 /* Mount tree monitoring events */
 #define FANOTIFY_MOUNT_EVENTS	(FAN_MNT_ATTACH | FAN_MNT_DETACH)
 
+/* Namespace tree monitoring events */
+#define FANOTIFY_NS_EVENTS	(FAN_NS_CREATE | FAN_NS_DELETE)
+
 /* Events that user can request to be notified on namepsace watchers */
-#define FANOTIFY_EVENTS_ON_NS	(FANOTIFY_MOUNT_EVENTS)
+#define FANOTIFY_EVENTS_ON_NS	(FANOTIFY_MOUNT_EVENTS | FANOTIFY_NS_EVENTS)
 
 /* Extra flags that may be reported with event or control handling of events */
 #define FANOTIFY_EVENT_FLAGS	(FAN_EVENT_ON_CHILD | FAN_ONDIR)
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 079c18bcdbde6..ddb13cd960214 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -300,6 +300,11 @@ static inline void fsnotify_mntns_delete(struct mnt_namespace *mntns)
 	__fsnotify_mntns_delete(mntns);
 }
 
+static inline void fsnotify_userns_delete(struct user_namespace *userns)
+{
+	__fsnotify_userns_delete(userns);
+}
+
 /*
  * fsnotify_inoderemove - an inode is going away
  */
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 9ce08d03d041d..019807844ca9c 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -79,6 +79,9 @@
  *
  * NOTE: These values may overload filesystem events, but not event flags
  */
+#define FS_NS_CREATE		0x00000100	/* Sub namespace was created */
+#define FS_NS_DELETE		0x00000200	/* Sub namespace was deleted */
+
 #define FS_MNT_ATTACH		0x01000000	/* Mount was attached */
 #define FS_MNT_DETACH		0x02000000	/* Mount was detached */
 #define FS_MNT_MOVE		(FS_MNT_ATTACH | FS_MNT_DETACH)
@@ -128,8 +131,12 @@
 /* Mount tree monitoring events */
 #define FSNOTIFY_MNT_EVENTS (FS_MNT_ATTACH | FS_MNT_DETACH)
 
+/* Namespace tree monitoring events */
+#define FSNOTIFY_NS_EVENTS (FS_NS_CREATE | FS_NS_DELETE)
+
 /* Events that can be reported to backends on namepsace watchers */
 #define FSNOTIFY_EVENTS_ON_NS (FSNOTIFY_MNT_EVENTS | \
+			       FSNOTIFY_NS_EVENTS | \
 			       FS_Q_OVERFLOW)
 
 /* Events that can be reported to backends */
@@ -344,6 +351,7 @@ enum fsnotify_data_type {
 	FSNOTIFY_EVENT_INODE,
 	FSNOTIFY_EVENT_DENTRY,
 	FSNOTIFY_EVENT_MNT,
+	FSNOTIFY_EVENT_NS,
 	FSNOTIFY_EVENT_ERROR,
 };
 
@@ -369,6 +377,12 @@ struct fsnotify_mnt {
 	u64 mnt_id;
 };
 
+struct fsnotify_ns {
+	const struct user_namespace *userns;
+	u64 self_nsid;
+	u64 owner_nsid;
+};
+
 static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
 {
 	switch (data_type) {
@@ -445,6 +459,17 @@ static inline const struct fsnotify_mnt *fsnotify_data_mnt(const void *data,
 	}
 }
 
+static inline const struct fsnotify_ns *fsnotify_data_ns(const void *data,
+							 int data_type)
+{
+	switch (data_type) {
+	case FSNOTIFY_EVENT_NS:
+		return data;
+	default:
+		return NULL;
+	}
+}
+
 static inline u64 fsnotify_data_mnt_id(const void *data, int data_type)
 {
 	const struct fsnotify_mnt *mnt_data = fsnotify_data_mnt(data, data_type);
@@ -490,6 +515,7 @@ enum fsnotify_iter_type {
 	FSNOTIFY_ITER_TYPE_PARENT,
 	FSNOTIFY_ITER_TYPE_INODE2,
 	FSNOTIFY_ITER_TYPE_MNTNS,
+	FSNOTIFY_ITER_TYPE_USERNS,
 	FSNOTIFY_ITER_TYPE_COUNT
 };
 
@@ -500,6 +526,7 @@ enum fsnotify_obj_type {
 	FSNOTIFY_OBJ_TYPE_VFSMOUNT,
 	FSNOTIFY_OBJ_TYPE_SB,
 	FSNOTIFY_OBJ_TYPE_MNTNS,
+	FSNOTIFY_OBJ_TYPE_USERNS,
 	FSNOTIFY_OBJ_TYPE_COUNT,
 	FSNOTIFY_OBJ_TYPE_DETACHED = FSNOTIFY_OBJ_TYPE_COUNT
 };
@@ -688,9 +715,12 @@ extern void __fsnotify_inode_delete(struct inode *inode);
 extern void __fsnotify_vfsmount_delete(struct vfsmount *mnt);
 extern void fsnotify_sb_delete(struct super_block *sb);
 extern void __fsnotify_mntns_delete(struct mnt_namespace *mntns);
+extern void __fsnotify_userns_delete(struct user_namespace *userns);
 extern void fsnotify_sb_free(struct super_block *sb);
 extern u32 fsnotify_get_cookie(void);
 extern void fsnotify_mnt(__u32 mask, struct mnt_namespace *ns, struct vfsmount *mnt);
+extern void fsnotify_ns(__u32 mask, struct user_namespace *userns,
+			u64 self_nsid, u64 owner_nsid);
 
 static inline __u32 fsnotify_parent_needed_mask(__u32 mask)
 {
@@ -992,6 +1022,9 @@ static inline void fsnotify_sb_delete(struct super_block *sb)
 static inline void __fsnotify_mntns_delete(struct mnt_namespace *mntns)
 {}
 
+static inline void __fsnotify_userns_delete(struct user_namespace *userns)
+{}
+
 static inline void fsnotify_sb_free(struct super_block *sb)
 {}
 
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 19d1c5e5f3350..3b7d2bc88ae6c 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -248,4 +248,6 @@ static inline struct pid_namespace *proc_pid_ns(struct super_block *sb)
 
 bool proc_ns_file(const struct file *file);
 
+struct user_namespace *userns_from_dentry(struct dentry *dentry);
+
 #endif /* _LINUX_PROC_FS_H */
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 9c3be157397e0..7ff8420495308 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -13,6 +13,8 @@
 #include <linux/sysctl.h>
 #include <linux/err.h>
 
+struct fsnotify_mark_connector;
+
 #define UID_GID_MAP_MAX_BASE_EXTENTS 5
 #define UID_GID_MAP_MAX_EXTENTS 340
 
@@ -86,6 +88,10 @@ struct user_namespace {
 	/* parent_could_setfcap: true if the creator if this ns had CAP_SETFCAP
 	 * in its effective capability set at the child ns creation time. */
 	bool			parent_could_setfcap;
+#ifdef CONFIG_FSNOTIFY
+	__u32 n_fsnotify_mask;
+	struct fsnotify_mark_connector __rcu *n_fsnotify_marks;
+#endif
 
 #ifdef CONFIG_KEYS
 	/* List of joinable keyrings in this namespace.  Modification access of
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index cfcd193aee3e2..8a12db80f9d80 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -48,6 +48,9 @@
  *
  * NOTE: These values may overload filesystem events, but not event flags
  */
+#define FAN_NS_CREATE		0x00000100	/* Sub namespace was created */
+#define FAN_NS_DELETE		0x00000200	/* Sub namespace was deleted */
+
 #define FAN_MNT_ATTACH		0x01000000	/* Mount was attached */
 #define FAN_MNT_DETACH		0x02000000	/* Mount was detached */
 
@@ -78,6 +81,7 @@
 #define FAN_REPORT_TARGET_FID	0x00001000	/* Report dirent target id  */
 #define FAN_REPORT_FD_ERROR	0x00002000	/* event->fd can report error */
 #define FAN_REPORT_MNT		0x00004000	/* Report mount events */
+#define FAN_REPORT_NSID		0x00008000	/* Report namespace events */
 
 /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
 #define FAN_REPORT_DFID_NAME	(FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
@@ -109,6 +113,7 @@
 #define FAN_MARK_MOUNT		0x00000010
 #define FAN_MARK_FILESYSTEM	0x00000100
 #define FAN_MARK_MNTNS		0x00000110
+#define FAN_MARK_USERNS		0x00001000
 
 /*
  * Convenience macro - FAN_MARK_IGNORE requires FAN_MARK_IGNORED_SURV_MODIFY
@@ -163,6 +168,7 @@ struct fanotify_event_metadata {
 #define FAN_EVENT_INFO_TYPE_ERROR	5
 #define FAN_EVENT_INFO_TYPE_RANGE	6
 #define FAN_EVENT_INFO_TYPE_MNT		7
+#define FAN_EVENT_INFO_TYPE_NS		8
 
 /* Special info types for FAN_RENAME */
 #define FAN_EVENT_INFO_TYPE_OLD_DFID_NAME	10
@@ -221,6 +227,12 @@ struct fanotify_event_info_mnt {
 	__u64 mnt_id;
 };
 
+struct fanotify_event_info_ns {
+	struct fanotify_event_info_header hdr;
+	__u64 self_nsid;	/* ns_id of the namespace */
+	__u64 owner_nsid;	/* ns_id of its owning user namespace */
+};
+
 /*
  * User space may need to record additional information about its decision.
  * The extra information type records what kind of information is included.
diff --git a/kernel/nscommon.c b/kernel/nscommon.c
index 3166c1fd844af..6317d1e830c58 100644
--- a/kernel/nscommon.c
+++ b/kernel/nscommon.c
@@ -6,6 +6,7 @@
 #include <linux/proc_ns.h>
 #include <linux/user_namespace.h>
 #include <linux/vfsdebug.h>
+#include <linux/fsnotify_backend.h>
 
 #ifdef CONFIG_DEBUG_VFS
 static void ns_debug(struct ns_common *ns, const struct proc_ns_operations *ops)
@@ -111,6 +112,44 @@ struct ns_common *__must_check ns_owner(struct ns_common *ns)
 	return to_ns_common(owner);
 }
 
+/*
+ * Return the owning user_namespace of @ns, including init_user_ns.
+ * Unlike ns_owner(), which returns NULL for namespaces owned by
+ * init_user_ns (to serve as a propagation terminator), this gives us
+ * the real owner for notification routing.
+ */
+static struct user_namespace *ns_direct_owner(struct ns_common *ns)
+{
+	if (unlikely(!ns->ops || !ns->ops->owner))
+		return NULL;
+	return ns->ops->owner(ns);
+}
+
+static void ns_common_notify(__u32 mask, struct ns_common *ns)
+{
+	struct user_namespace *owner_userns;
+
+	if (!IS_ENABLED(CONFIG_FSNOTIFY))
+		return;
+
+	owner_userns = ns_direct_owner(ns);
+	if (!owner_userns)
+		return;
+
+#ifdef CONFIG_FSNOTIFY
+	/*
+	 * READ_ONCE macro expansion does not understand that this code
+	 * is not reachable without CONFIG_FSNOTIFY.
+	 */
+	if (!READ_ONCE(owner_userns->n_fsnotify_marks))
+		return;
+#endif
+
+	/* Report child namespace events to owner userns watchers */
+	fsnotify_ns(mask, owner_userns, ns->ns_id,
+		    to_ns_common(owner_userns)->ns_id);
+}
+
 /*
  * The active reference count works by having each namespace that gets
  * created take a single active reference on its owning user namespace.
@@ -172,6 +211,8 @@ void __ns_ref_active_put(struct ns_common *ns)
 		return;
 	}
 
+	ns_common_notify(FS_NS_DELETE, ns);
+
 	VFS_WARN_ON_ONCE(is_ns_init_id(ns));
 	VFS_WARN_ON_ONCE(!__ns_ref_read(ns));
 
@@ -184,6 +225,8 @@ void __ns_ref_active_put(struct ns_common *ns)
 			VFS_WARN_ON_ONCE(__ns_ref_active_read(ns) < 0);
 			return;
 		}
+
+		ns_common_notify(FS_NS_DELETE, ns);
 	}
 }
 
@@ -293,6 +336,8 @@ void __ns_ref_active_get(struct ns_common *ns)
 	if (likely(prev))
 		return;
 
+	ns_common_notify(FS_NS_CREATE, ns);
+
 	/*
 	 * We did resurrect it. Walk the ownership hierarchy upwards
 	 * until we found an owning user namespace that is active.
@@ -307,6 +352,8 @@ void __ns_ref_active_get(struct ns_common *ns)
 		VFS_WARN_ON_ONCE(prev < 0);
 		if (likely(prev))
 			return;
+
+		ns_common_notify(FS_NS_CREATE, ns);
 	}
 }
 
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 0bed462e9b2a2..a7e8d1c33bfd5 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -22,6 +22,7 @@
 #include <linux/bsearch.h>
 #include <linux/sort.h>
 #include <linux/nstree.h>
+#include <linux/fsnotify.h>
 
 static struct kmem_cache *user_ns_cachep __ro_after_init;
 static DEFINE_MUTEX(userns_state_mutex);
@@ -221,6 +222,7 @@ static void free_user_ns(struct work_struct *work)
 		retire_userns_sysctls(ns);
 		key_free_user_ns(ns);
 		ns_common_free(ns);
+		fsnotify_userns_delete(ns);
 		/* Concurrent nstree traversal depends on a grace period. */
 		kfree_rcu(ns, ns.ns_rcu);
 		dec_user_namespaces(ucounts);
-- 
2.54.0

