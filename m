Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76065383993
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074977; cv=none; b=HNTCF7XU7sdkwdfpNPwtsqgyaGGyhSDDPeGGrOP3Wn0p34ksZ5Ou0praqPB+8FBP3dEjbw1+fjTmFmDrdKkoBBZNQwXZG/8pEn27wj8GhOtLTefLiRI6it3QFQ+iGC2VFRdkM0wRTK9DCgUuNJ09YBRqvmK3qG18fv9IwBrin4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074977; c=relaxed/simple;
	bh=ecLE1W9bCP4XiO9Sic6lPv51sDiyGjHaUKzW5xUJnYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LvnU+sxLl1IEIM7Vs1Tor/bj89lJGWPNthaOyDBx/5fl7RG+4YNF8XbxrrSfRWOJ0UPjPNZlFW16xuJPzsUM4Wb7zfnTAJzieLMjPvnye7zTaBCJzXkro6vIBY5Bzrp/jjR4nAhA2Z8JvT06TJwwzcZsqZ3moVkbgRtlouyaZNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0Omqaur; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0Omqaur"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b167ffd132so8646296a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 07:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792074972; x=1792679772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JZPOKb4PA3vVn4R4xwqE9p7p19yU9Yeu0bZm3Rj3Y7M=;
        b=N0OmqaurpVWS+uvwOakFz2nbOsKOuiZItB/dwLYkfiGGFHlUG+uJBYhxsm1XWygzZ1
         Xm5TEcnEqWkG91zMbtc9mmn04Xl+9uuQ9hqoTQKDWNYuyehCJ/15r/lzhPRWAVa38mRm
         OL1OL+Ln7h5dsaESIqg8ahQiQ3kJ6IOX3Q5/fyhzFVaDPcet2pDmae2QviCL8iDBLXGf
         /8nYwZ/n+aR5rTqNfQnf8Lm9cBbN+emrIgi02e9/wtfOuKAWoIUF1AE/VGdO17vPrYFU
         a+q0DGooZnEKy+mNcPKaqm671+CUNRsgzwAkNftTlfCgPNGIe1qHxyhOYCAD9+ihm5Fj
         6pRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792074972; x=1792679772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JZPOKb4PA3vVn4R4xwqE9p7p19yU9Yeu0bZm3Rj3Y7M=;
        b=O5wC5OfSmOAUAm+xQAjYz7PQE20yf4HhHcbQLV6P30CCjd/qtFQT7jCxibZYtHq86O
         vpvjGLjyoIuBJt4beKmppf0Vf1GsMnUFMz4vfgDb+2Eat+cgSNF9PrSp/sc35BcGPXHd
         RL+7QJEYqq2KuPvta8DeZoOgbJFJWO2bOjRUckkhSfli1HQYSyzAKjmmRGCwC1NzswV8
         GxrBSIuJoamRWp4kJ26SYSYFFR8RR2ccvjCRO4shLC+sL3V4eNGiqXoQPZOh454U6g8x
         KH3SgMqpb+5iFIFao+OKy9+crJBw022Llz6TOhqwAc/7pPlzWeCc6jFYtv97AC4uF6g2
         xw7w==
X-Forwarded-Encrypted: i=1; AKwUvBy8ebvqWOYl0aGa2sov2ODXtO2U5b/qGoM00uCV5Ds4culjf7hQpBkx95m/XeDiXMntH2n+AJfWF4zWVPzy@vger.kernel.org
X-Gm-Message-State: AFq9FYJHFi2tjDLYxj8rON1ZwZR1jPdHPS1EFN3B2VKfqhUdGlZ2x45l
	N8sbnM7xuJHvwvd8xRi75rzIXdqYjXWNPQUzHH0FdKlLY8Nmt5x6PRre
X-Gm-Gg: AYBFou3ZNdhbIUJf6EHJ5LarC0DcBMYidBr8nvxmvXCdvh6RNO+5vl6NBMdkvmg+frh
	RDKVBUks6pbGISQyXwqTiVvIC2fUb3GtbIYVCdTN7qXkei90luOh5pH9HnIVIVz0k+Qk296Ogdn
	k5K82ctJyIfE3g9i50YNtfWPG9AADQktsUz73rTyGSEps0hdUcL2RhwVQHueml1XROh+XPlXvjz
	9OWpcp7CRzFOXEsBr9Ch2IOOgBvn7YR8qnVtiGuuBkyJrPBNQN5uTutNI6BIsN86Q5LPdaRhkGk
	bh0panGJy9lZ0NzxeX3eOLHct02GOetqRXbQ0fkBxhBQUZAlvT1wsO75M3/DAQvlUiZ8LsrPVte
	So+I1Q9ajvKqfSXhzy5XYE8BDuqbqp5ZUXOJN69PT2VSGU2lywPCLqc/VoJIpfncYTq27kuMUBb
	4D+huu8abY40/SmMvFsBmjST2NpmY3B4L4M9Tx73JKvupy2E3KMFBBPnEZuRt1Bbfkg8INNi/be
	dOaGqwlXsC0T0AiVPJTAO7w5g==
X-Received: by 2002:a17:907:9686:b0:c1f:983f:d8a with SMTP id a640c23a62f3a-c31aa017261mr1947812266b.24.1792074972206;
        Thu, 15 Oct 2026 07:36:12 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3ed963e421sm135179466b.29.2026.10.15.07.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:36:11 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 08/14] fanotify: define new FAN_NS_MNT_* constants
Date: Thu, 15 Oct 2026 16:35:54 +0200
Message-ID: <20261015143601.2095784-9-amir73il@gmail.com>
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

The FAN_MNT_* event constants belong to the namespace watcher group type,
but the type bits do not match.

We preserve these legacy FAN_MNT_* constants - they can never be mixed
with any other event in the mask in upstream kernel anyway, so there is
no real risk of confusion for applications that only watch mount events.

We define a new set of FAN_NS_MNT_* constants, which are defined with the
namespace watcher group type.  These could be allowed together with
other namespace events in future kernels, so they are intended to be
used by new applications that are going to watch namespace trees and
mount trees with the same fanotify group.

At the fsnotify u32 mask level, there is no difference between the two
uapi flavors. Rename the fsnotify event constants to FSN_MNT_*, to
clarify that they are not filesystem watcher event types.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 13 +++++++++++--
 fs/notify/fanotify/fanotify_user.c |  2 +-
 include/linux/fanotify.h           |  2 +-
 include/linux/fsnotify.h           |  6 +++---
 include/linux/fsnotify_backend.h   |  8 ++++----
 include/trace/misc/fsnotify.h      |  4 ++--
 include/uapi/linux/fanotify.h      |  6 +++++-
 7 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 7d6fd2a9d5938..c4c84f90b3df5 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -966,6 +966,9 @@ static void fanotify_insert_event(struct fsnotify_group *group,
 #define ASSERT_FS_EVENT(fan_mask, fsn_mask) \
 	BUILD_BUG_ON((u32)(fan_mask) != (fsn_mask) || \
 		     FAN_EVENT_TYPE(fan_mask) != FSNOTIFY_GROUP_TYPE_FILESYSTEM)
+#define ASSERT_NAMESPACE_EVENT(fan_mask, fsn_mask) \
+	BUILD_BUG_ON((u32)(fan_mask) != (fsn_mask) || \
+		     FAN_EVENT_TYPE(fan_mask) != FSNOTIFY_GROUP_TYPE_NAMESPACE)
 
 static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 				 const void *data, int data_type,
@@ -1004,8 +1007,14 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	ASSERT_FS_EVENT(FAN_FS_ERROR, FS_ERROR);
 	ASSERT_FS_EVENT(FAN_RENAME, FS_RENAME);
 	ASSERT_FS_EVENT(FAN_PRE_ACCESS, FS_PRE_ACCESS);
-
-	BUILD_BUG_ON(HWEIGHT64(ALL_FANOTIFY_EVENT_BITS) != 24);
+	/* Assert backward compat mount events */
+	ASSERT_FS_EVENT(FAN_MNT_ATTACH, FSN_MNT_ATTACH);
+	ASSERT_FS_EVENT(FAN_MNT_DETACH, FSN_MNT_DETACH);
+	/* Assert "strong typed" events for namespace watcher */
+	ASSERT_NAMESPACE_EVENT(FAN_NS_MNT_ATTACH, FSN_MNT_ATTACH);
+	ASSERT_NAMESPACE_EVENT(FAN_NS_MNT_DETACH, FSN_MNT_DETACH);
+
+	BUILD_BUG_ON(HWEIGHT64(ALL_FANOTIFY_EVENT_BITS) != 25);
 
 	mask = fanotify_group_event_mask(group, iter_info, &match_mask,
 					 mask, data, data_type, dir);
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index a669f233cf6e3..e8a8fc2ad52c8 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1873,7 +1873,7 @@ static int fanotify_events_supported(struct fsnotify_group *group,
 static bool fanotify_is_valid_mask(struct fsnotify_group *group, int mark_type,
 				   u64 mask)
 {
-	u32 valid_mask = 0;
+	u64 valid_mask = 0;
 
 	/*
 	 * Event bits for different group type may be overloaded but event
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 83ac9c98ab698..8679f63fd7c97 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -122,7 +122,7 @@
 					 FANOTIFY_ERROR_EVENTS)
 
 /* Mount tree monitoring events */
-#define FANOTIFY_MOUNT_EVENTS	(FAN_MNT_ATTACH | FAN_MNT_DETACH)
+#define FANOTIFY_MOUNT_EVENTS	(FAN_NS_MNT_ATTACH | FAN_NS_MNT_DETACH)
 
 /* Events that user can request to be notified on namespace watchers */
 #define FANOTIFY_EVENTS_ON_NAMESPACE	(FANOTIFY_MOUNT_EVENTS)
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index bda798bc67bc5..4a1d7bb4b228a 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -501,17 +501,17 @@ static inline void fsnotify_change(struct dentry *dentry, unsigned int ia_valid)
 
 static inline void fsnotify_mnt_attach(struct mnt_namespace *ns, struct vfsmount *mnt)
 {
-	fsnotify_mnt(FS_MNT_ATTACH, ns, mnt);
+	fsnotify_mnt(FSN_MNT_ATTACH, ns, mnt);
 }
 
 static inline void fsnotify_mnt_detach(struct mnt_namespace *ns, struct vfsmount *mnt)
 {
-	fsnotify_mnt(FS_MNT_DETACH, ns, mnt);
+	fsnotify_mnt(FSN_MNT_DETACH, ns, mnt);
 }
 
 static inline void fsnotify_mnt_move(struct mnt_namespace *ns, struct vfsmount *mnt)
 {
-	fsnotify_mnt(FS_MNT_MOVE, ns, mnt);
+	fsnotify_mnt(FSN_MNT_MOVE, ns, mnt);
 }
 
 #endif	/* _LINUX_FS_NOTIFY_H */
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 15f7abd77c065..689b6c0a7b88b 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -79,9 +79,9 @@
  *
  * NOTE: These values may overload filesystem events, but not event flags
  */
-#define FS_MNT_ATTACH		0x01000000	/* Mount was attached */
-#define FS_MNT_DETACH		0x02000000	/* Mount was detached */
-#define FS_MNT_MOVE		(FS_MNT_ATTACH | FS_MNT_DETACH)
+#define FSN_MNT_ATTACH		0x01000000	/* Mount was attached */
+#define FSN_MNT_DETACH		0x02000000	/* Mount was detached */
+#define FSN_MNT_MOVE		(FSN_MNT_ATTACH | FSN_MNT_DETACH)
 
 
 /*
@@ -126,7 +126,7 @@
 				       FS_IN_IGNORED | FS_ERROR)
 
 /* Mount tree monitoring events */
-#define FSNOTIFY_MNT_EVENTS (FS_MNT_ATTACH | FS_MNT_DETACH)
+#define FSNOTIFY_MNT_EVENTS (FSN_MNT_ATTACH | FSN_MNT_DETACH)
 
 /* Events that can be reported to backends on namespace watchers */
 #define FSNOTIFY_EVENTS_ON_NAMESPACE (FSNOTIFY_MNT_EVENTS | FS_Q_OVERFLOW)
diff --git a/include/trace/misc/fsnotify.h b/include/trace/misc/fsnotify.h
index a201e1bd6d8ca..5c6ee3a7f4b55 100644
--- a/include/trace/misc/fsnotify.h
+++ b/include/trace/misc/fsnotify.h
@@ -27,8 +27,8 @@
 		{ FS_ACCESS_PERM,	"ACCESS_PERM" }, \
 		{ FS_OPEN_EXEC_PERM,	"OPEN_EXEC_PERM" }, \
 		{ FS_PRE_ACCESS,	"PRE_ACCESS" }, \
-		{ FS_MNT_ATTACH,	"MNT_ATTACH" }, \
-		{ FS_MNT_DETACH,	"MNT_DETACH" }, \
+		{ FSN_MNT_ATTACH,	"MNT_ATTACH" }, \
+		{ FSN_MNT_DETACH,	"MNT_DETACH" }, \
 		{ FS_EVENT_ON_CHILD,	"EVENT_ON_CHILD" }, \
 		{ FS_RENAME,		"RENAME" }, \
 		{ FS_DN_MULTISHOT,	"DN_MULTISHOT" }, \
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index b5377a7cd991a..b399dd3887299 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -56,10 +56,14 @@
 /*
  * Events that user-space can request when watching namespaces
  *
- * NOTE: These values may overload filesystem events, but not event flags
+ * NOTE: Lower 32bit values may overload filesystem events, but not event flags
  */
+/* Backward compat mount events - cannot be mixed with other events */
 #define FAN_MNT_ATTACH		0x0001000000ULL	/* Mount was attached */
 #define FAN_MNT_DETACH		0x0002000000ULL	/* Mount was detached */
+/* "Strong typed" mount events - may be mixed with other namespace events */
+#define FAN_NS_MNT_ATTACH	0x0101000000ULL	/* Mount was attached */
+#define FAN_NS_MNT_DETACH	0x0102000000ULL	/* Mount was detached */
 
 /* flags used for fanotify_init() */
 #define FAN_CLOEXEC		0x00000001
-- 
2.55.0

