Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC1348EC8B
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Oct 2026 12:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791461101; cv=none; b=kmD3EovkYg77gdCgljK7xbiSVxCOA2z/eu3WeQoC91Qh1Kl5gE++x/oxFHjj9FLuPXKqZY6r6Ra1Cqz4EIB3Mw4zdTo4V5ii8J4LrBskaGgSxqPY1zMzHWeHdvV2nk5C9NvL/0fGwa8ahjrjEkFmMriPm+tFSDjq+8fEmP16DPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791461101; c=relaxed/simple;
	bh=SqoFMWek5L2AYDuAdulDx3T6hXl+omsbKzxx3PKhTz8=;
	h=Date:Message-Id:References:To:Content-Type:Cc:Subject:
	 Mime-Version:In-Reply-To:From; b=PHyWsjjmzpY8I2NdYIx79BREnsFVR0HnkpVSgWhoQBQ9jE+ms1RYCdA3Kw4+GiRg75Wd7i/tuy9QKcOJsezsWETIv9xraR1woaMefw+s7x215VeUkK2ScI5M8z5TcLDYfNgra1zonXtTmaqFnZQLlWoA6m9FQ9C3mNXSC0Vk+5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=pAmzh8Xf; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="pAmzh8Xf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1791460980; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=2dIBWWhdr4Ivn6SlDhoE9NR8/QzOV2fPo2kXiyccMjc=;
 b=pAmzh8XfYG8ZnYj6GUlWk5BYx/qm/1t/ireD/f6IBiYUUnaxVxb4vG4heIgASm0uK6JRzq
 r2CZncaCrPjEVHpqZx9TAcflYjWj9wpUURkcK6JHnZUG4hqOEGMAIVyj/1OUvScZlnxetx
 qxs/d0FNC6yHwy4xaPyLLGF+4VO9ihYUBJkSKOOhBgGtoCfdjen8Nk7GzXjY4dWhrMNeD5
 SYfoYygA7ncG+LKDHneG60BlZk587ixfHd2/qR/5XkxBTfaEzE+Nqp1qsDFSHQSkQ1Ygnb
 BQrThRYApNt4KVFJzSksQ+/hz0guO+X0wQch3OcQbFdM4QKEaa0M1fCrbyKMzQ==
X-Lms-Return-Path: <lba+26ac78672+1c3b03+vger.kernel.org+zhujia.zj@bytedance.com>
Date: Thu,  8 Oct 2026 20:02:38 +0800
Message-Id: <3ec4d10ebe03054d8b45a12c1cf484f9176877a4.1791452174.git.zhujia.zj@bytedance.com>
References: <cover.1791452174.git.zhujia.zj@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Original-From: Jia Zhu <zhujia.zj@bytedance.com>
To: "Jan Kara" <jack@suse.cz>
Content-Type: text/plain; charset=UTF-8
Cc: "Jia Zhu" <zhujia.zj@bytedance.com>, <amir73il@gmail.com>, 
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] inotify: drop fsnotify SRCU protection during event delivery
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <cover.1791452174.git.zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.20.1
From: "Jia Zhu" <zhujia.zj@bytedance.com>

Inotify event allocation can enter reclaim while holding the global
fsnotify_mark_srcu read lock. This delays mark reclamation and can stall
close or task exit in unrelated groups with marks awaiting destruction.

Share the user-wait pinning implementation to pin iterator marks and drop
SRCU around inotify event delivery. Preserve the all-or-nothing behavior
of the existing fanotify user-wait interface.

Inotify watches on a directory and its child are independent. Skip marks
that can no longer be pinned and clear their report bits, so removing one
watch does not suppress delivery to the surviving watch. Keep all remaining
iterator heads pinned, including those belonging to other groups, until
SRCU is reacquired. If no reportable marks remain, roll back the pins and
return with SRCU still held.

This lets unrelated mark reclamation proceed while a callback sleeps.
Teardown still waits for pinned marks before flushing the group's event
queue.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/notify/fsnotify.c             | 15 ++++++++++++---
 fs/notify/inotify/inotify_user.c |  3 ++-
 fs/notify/mark.c                 | 26 ++++++++++++++++++++++----
 include/linux/fsnotify_backend.h |  2 ++
 4 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 7e2f330fd2837..78d040399cbe7 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -341,7 +341,8 @@ static int send_to_group(__u32 mask, const void *data, int data_type,
 	__u32 marks_ignore_mask = 0;
 	bool is_dir = mask & FS_ISDIR;
 	struct fsnotify_mark *mark;
-	int type;
+	int type, ret;
+	bool pin_events;
 
 	if (!iter_info->report_mask)
 		return 0;
@@ -375,8 +376,16 @@ static int send_to_group(__u32 mask, const void *data, int data_type,
 						file_name, cookie, iter_info);
 	}
 
-	return fsnotify_handle_event(group, mask, data, data_type, dir,
-				     file_name, cookie, iter_info);
+	pin_events = group->flags & FSNOTIFY_GROUP_PIN_EVENTS;
+	if (pin_events && !fsnotify_prepare_inode_event(iter_info))
+		return 0;
+
+	ret = fsnotify_handle_event(group, mask, data, data_type, dir,
+				    file_name, cookie, iter_info);
+
+	if (pin_events)
+		fsnotify_finish_user_wait(iter_info);
+	return ret;
 }
 
 static struct fsnotify_mark *fsnotify_first_mark(struct fsnotify_mark_connector *const *connp)
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 5f19c24ec187f..5955e4ae0816e 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -644,7 +644,8 @@ static struct fsnotify_group *inotify_new_group(unsigned int max_events)
 	struct inotify_event_info *oevent;
 
 	group = fsnotify_alloc_group(&inotify_fsnotify_ops,
-				     FSNOTIFY_GROUP_USER);
+				     FSNOTIFY_GROUP_USER |
+				     FSNOTIFY_GROUP_PIN_EVENTS);
 	if (IS_ERR(group))
 		return group;
 
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index b2640d836a712..d0deae0c1ce3a 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -553,7 +553,8 @@ static void fsnotify_put_mark_wake(struct fsnotify_mark *mark)
 	}
 }
 
-bool fsnotify_prepare_user_wait(struct fsnotify_iter_info *iter_info)
+static bool fsnotify_prepare_wait(struct fsnotify_iter_info *iter_info,
+				  bool report_partial)
 	__releases(&fsnotify_mark_srcu)
 {
 	int type;
@@ -564,15 +565,19 @@ bool fsnotify_prepare_user_wait(struct fsnotify_iter_info *iter_info)
 		/* This can fail if mark is being removed */
 		while (mark && !fsnotify_get_mark_safe(mark)) {
 			if (mark->group == iter_info->current_group) {
-				__release(&fsnotify_mark_srcu);
-				goto fail;
+				if (!report_partial)
+					goto fail;
+				/* The next cursor may belong to another group. */
+				iter_info->report_mask &= ~(1U << type);
 			}
-			/* This is a mark in an unrelated group, skip */
 			mark = fsnotify_next_mark(mark);
 			iter_info->marks[type] = mark;
 		}
 	}
 
+	if (report_partial && !iter_info->report_mask)
+		goto fail;
+
 	/*
 	 * Now that all marks are pinned by refcount in the inode / vfsmount / etc
 	 * lists, we can drop SRCU lock, and safely resume the list iteration
@@ -583,11 +588,24 @@ bool fsnotify_prepare_user_wait(struct fsnotify_iter_info *iter_info)
 	return true;
 
 fail:
+	__release(&fsnotify_mark_srcu);
 	for (type--; type >= 0; type--)
 		fsnotify_put_mark_wake(iter_info->marks[type]);
 	return false;
 }
 
+bool fsnotify_prepare_user_wait(struct fsnotify_iter_info *iter_info)
+	__releases(&fsnotify_mark_srcu)
+{
+	return fsnotify_prepare_wait(iter_info, false);
+}
+
+bool fsnotify_prepare_inode_event(struct fsnotify_iter_info *iter_info)
+	__releases(&fsnotify_mark_srcu)
+{
+	return fsnotify_prepare_wait(iter_info, true);
+}
+
 void fsnotify_finish_user_wait(struct fsnotify_iter_info *iter_info)
 	__acquires(&fsnotify_mark_srcu)
 {
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 618eed4d6d724..b3132e98a0c3f 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -234,6 +234,7 @@ struct fsnotify_group {
 
 #define FSNOTIFY_GROUP_USER	0x01 /* user allocated group */
 #define FSNOTIFY_GROUP_DUPS	0x02 /* allow multiple marks per object */
+#define FSNOTIFY_GROUP_PIN_EVENTS 0x04 /* pin marks during events */
 	int flags;
 	unsigned int owner_flags;	/* stored flags of mark_mutex owner */
 
@@ -938,6 +939,7 @@ extern void fsnotify_put_mark(struct fsnotify_mark *mark);
 struct fsnotify_mark *fsnotify_next_mark(struct fsnotify_mark *mark);
 extern void fsnotify_finish_user_wait(struct fsnotify_iter_info *iter_info);
 extern bool fsnotify_prepare_user_wait(struct fsnotify_iter_info *iter_info);
+bool fsnotify_prepare_inode_event(struct fsnotify_iter_info *iter_info);
 extern void fsnotify_modify_mark_mask(struct fsnotify_mark *mark, u32 set, u32 clear);
 
 static inline void fsnotify_init_event(struct fsnotify_event *event)
-- 
2.20.1
