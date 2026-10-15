Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62B83750BC
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074981; cv=none; b=dIW/MbpGtuVWr3oxSJDz29JAUHzPaqEsSIrP6Abn8bJl3zvUW7rCUNAS7dXCEeYqVa9jpP4nxcsDFEg9OcCaBMrs/WvxXxD8UrV3aCxukT4VE+D9c1bOkwA2Lf6bM6TQJJZjfWpr466EMFw/UjWxX+PJ3NLvwyp2ssxX8s9xw08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074981; c=relaxed/simple;
	bh=flP6He0Ga77jXAJA19zwET2moOf4JjSFR6677v3e138=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7UgOTAzHbIFgQD7EPqja9VFFf3CwwXL86hnlxv79rrr1/jJuO4Xs0nSHoMwbRRVXn2TmgsUdaTOJpd9oIuZCktYcdQuSaz/sBQrhkfXpmdlhDgxoNAhMzz9sCTnV+A5SQ/q9cj092BiH9hhCSTdLAm9vdTOOVooml8FF/+csQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWq0EhUl; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWq0EhUl"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c2afa22e1dcso781227366b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 07:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792074975; x=1792679775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FeG5uak1HhQw+QfAGSpI46bjQxyKY8oJfOR1jSTvTgc=;
        b=EWq0EhUlQsJ/U1tGT0rcXyMfBWoISRKsSKW2SC8zhNrmAL7NOfY6RJ78NfO60tA1sx
         x1KTEJWywc6c7MNRAzsKIaFf/D57N155MYawOB6HW0IMZ91nj6+4XpzjRVP9bhKMdmP/
         NiFP4gBgizB1iZD/31Om9/4GhxOElO7mTtT+QDXcUqZAshXnRdy2/eQLqQ5e/aJeBD+w
         pKUzaeexPdfc/7MSIT9jJIXT9yWP0tfHbKscS/tdvGXi+GcNVrK53dWbqLQ/7AbIUUfq
         iEAtHOn9yD2GsLTFhjk5j1m+yJE36cweeiZKxnowYjC3cLI3tJu0XNspvr/KkSpGMEOz
         G2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792074975; x=1792679775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FeG5uak1HhQw+QfAGSpI46bjQxyKY8oJfOR1jSTvTgc=;
        b=Yo8xUK8XnNa5dnEhWS0S/6kjFn9gbRdJdUqLqHa5jM/f/qeLm3uvHM4069+BRUnbbF
         JGzoeHjZWoiqa02qh7dUyTBCcK8rex4UlQNIBt4oI/lgnG6tcMc8fMLCDQ2EbzHg/56y
         CKBJQc7o0+PumNZIBgsXhE4bGd3RUJDHZsBkouCHHCha0iWk/t4UKHy9bw6MfSwezkIq
         Mf+98B4CaeK8cYDvDPtfi0s9u8nb6nB3sEVqusaGjofEL/uew+g95Xw4oAOCx1/zA+GT
         ie7fbH/w5rhOXb9v/fbn11hm52SfEnUGr+I+P+92Ua3QaFdocOBI7dm91WIgMUfIsnW9
         6Pkg==
X-Forwarded-Encrypted: i=1; AKwUvByQVYL4F0HDyHYEDu62fQwbJl/NmZSNMRJwtIdH4wMmcohx3ZtgrQUDpcMd1q0LdBbGWhSY1kASk/Y2T5U9@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/rfqzJgeVjWaIkKjhq6WqYa62ywxfDO2WgHwur2q2zifHvC0X
	RzyOmwu6y9SuSLLAt3l52GdWQ9iZBBppPScgS9gO1MCiI6/V1QffL8b3nWt0PAVf
X-Gm-Gg: AYBFou1locsJ0/0NxZZGiKw+ok7kFqPWjl+HepI4r7Ng5hS/L+zK9mztwjv4XwzU5Ip
	0IU2V5KhIpK9YdCRR3RhyxiISy3WDw5Mg82ex4sNOwwfEj04odcyX1mL2bYp14SRzxdORsiqbB2
	8wUQ5gv3RAs04r5fY8BrvxL7bXDtT4z20/B4WVF6XA9uNh/dZ44/gibtas4BeK2fPjFEAFY+7Vp
	7JPXe2lhxia6/QexUvsqmcPF+Y3EapHnP20tckMOg5A4cmI56yFbQF8Ukb4pSEeLTc931gex/JK
	0Rh4JVZCCfUkEwvRJRWRUPjziNpTwU9XtuTm4vaOiCf3wOKEcSTEltbRQIi+lTLVKS4KNLfhwSQ
	KEoRIwmKGGiUc6IRvTSdFTjv9G4xua5TPTKDFM70jHU/vdbJqhYhNwNIkgVOUaBozkv+Tk7B8GR
	QstV4T0i4ZODXK1FQeUixoA278F6XY0AmBvospp0Ds8H3R4kP9kF1baFNGzUn+ZuVmin/DT4U1e
	Kld8xAsJQKOtm7VMUjcMAQRSA==
X-Received: by 2002:a17:906:9fc5:b0:c3f:e414:d35a with SMTP id a640c23a62f3a-c3fe4241d5fmr84006966b.26.1792074974770;
        Thu, 15 Oct 2026 07:36:14 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3ed963cf98sm132721166b.13.2026.10.15.07.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:36:14 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 10/14] fanotify: introduce FAN_REPORT_MNTID
Date: Thu, 15 Oct 2026 16:35:56 +0200
Message-ID: <20261015143601.2095784-11-amir73il@gmail.com>
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

This fanotify_init() flag is similar to FAN_REPORT_MNT, but instead of
enabling the legacy FAN_MNT_* events, it enabled the new FAN_NS_MNT_*
events which also report the watcher type bits in event->mask.

FAN_REPORT_MNT and FAN_REPORT_MNTID are mutually exclusive and therefore
the group accepts either the legacy FAN_MNT_* events or the new
FAN_NS_MNT_* events in fanotify_mark().

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 21 ++++++++++++++-------
 include/linux/fanotify.h           |  9 +++++++--
 include/uapi/linux/fanotify.h      |  3 ++-
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 76bb2574c8239..57cae2b3c96f8 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -852,6 +852,9 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	metadata.vers = FANOTIFY_METADATA_VERSION;
 	metadata.reserved = 0;
 	metadata.mask = fanotify_group_outgoing_events(group, event->mask);
+	/* Report watcher type part of the event mask */
+	if (FAN_GROUP_FLAG(group, FANOTIFY_REPORT_TYPE))
+		metadata.mask |= (u64)group->type << FAN_EVENT_TYPE_SHIFT;
 	metadata.pid = pid_vnr(event->pid);
 	/*
 	 * For an unprivileged listener, event->pid can be used to identify the
@@ -1669,6 +1672,9 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 			return -EINVAL;
 		if (flags & (FANOTIFY_FID_BITS | FAN_REPORT_FD_ERROR))
 			return -EINVAL;
+		/* The old and new mount event modes are mutually exclusive */
+		if ((flags & FAN_REPORT_MNT) && (flags & FAN_REPORT_MNTID))
+			return -EINVAL;
 	}
 
 	if (event_f_flags & ~FANOTIFY_INIT_ALL_EVENT_F_BITS)
@@ -1913,6 +1919,10 @@ static bool fanotify_is_valid_mask(struct fsnotify_group *group, int mark_type,
 	BUILD_BUG_ON(FANOTIFY_EVENTS_ON_FILESYSTEM & FANOTIFY_EVENT_FLAGS);
 	BUILD_BUG_ON(FANOTIFY_EVENTS_ON_NAMESPACE & FANOTIFY_EVENT_FLAGS);
 
+	/* Only allow high bits in mask when reporting them in event->mask */
+	if (!FAN_GROUP_FLAG(group, FANOTIFY_REPORT_TYPE) && fan_mask.type)
+		return false;
+
 	switch (group->type) {
 	case FSNOTIFY_GROUP_TYPE_FILESYSTEM:
 		valid_mask = FANOTIFY_EVENTS_ON_FILESYSTEM |
@@ -1923,10 +1933,11 @@ static bool fanotify_is_valid_mask(struct fsnotify_group *group, int mark_type,
 	case FSNOTIFY_GROUP_TYPE_NAMESPACE:
 		/* Only report mount events on mntns mark */
 		if (mark_type == FAN_MARK_MNTNS &&
-		    FAN_GROUP_FLAG(group, FAN_REPORT_MNT))
+		    FAN_GROUP_FLAG(group, FANOTIFY_MNT_MODES))
 			valid_mask = FANOTIFY_MOUNT_EVENTS;
 		/* Classify the legacy mount events as namespace events */
-		if (fan_mask.mask & (FAN_MNT_ATTACH | FAN_MNT_DETACH))
+		if (fan_mask.mask & (FAN_MNT_ATTACH | FAN_MNT_DETACH) &&
+		    FAN_GROUP_FLAG(group, FAN_REPORT_MNT))
 			fan_mask.type = FSNOTIFY_GROUP_TYPE_NAMESPACE;
 		break;
 	}
@@ -1963,10 +1974,6 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 __mask,
 	if (ret)
 		return ret;
 
-	/* we only use the lower 32 bits as of right now. */
-	if (fan_mask.type)
-		return -EINVAL;
-
 	if (flags & ~FANOTIFY_MARK_FLAGS)
 		return -EINVAL;
 
@@ -2251,7 +2258,7 @@ static int __init fanotify_user_setup(void)
 				     FANOTIFY_DEFAULT_MAX_USER_MARKS);
 
 	BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAGS);
-	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 14);
+	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 15);
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 11);
 
 	fanotify_mark_cache = KMEM_CACHE(fanotify_mark,
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 8679f63fd7c97..23c691031cce3 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -25,12 +25,17 @@
 
 #define FANOTIFY_FID_BITS	(FAN_REPORT_DFID_NAME_TARGET)
 
+#define FANOTIFY_MNT_MODES	(FAN_REPORT_MNT | FAN_REPORT_MNTID)
+
+/* fanotify_init() flags that report watcher type in event mask */
+#define FANOTIFY_REPORT_TYPE	(FAN_REPORT_MNTID)
+
 /* fanotify_init() flags related to information reported with events */
 #define FANOTIFY_INFO_MODES	(FANOTIFY_FID_BITS | FAN_REPORT_PIDFD | \
-				 FAN_REPORT_MNT)
+				 FANOTIFY_MNT_MODES)
 
 /* fanotify_init() flags that create a namespace watcher */
-#define FANOTIFY_NAMESPACE_INIT_FLAGS	(FAN_REPORT_MNT)
+#define FANOTIFY_NAMESPACE_INIT_FLAGS	(FANOTIFY_MNT_MODES)
 
 /*
  * fanotify_init() flags that require CAP_SYS_ADMIN.
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index b399dd3887299..0744b6770b43d 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -90,7 +90,8 @@
 #define FAN_REPORT_NAME		0x00000800	/* Report events with name */
 #define FAN_REPORT_TARGET_FID	0x00001000	/* Report dirent target id  */
 #define FAN_REPORT_FD_ERROR	0x00002000	/* event->fd can report error */
-#define FAN_REPORT_MNT		0x00004000	/* Report mount events */
+#define FAN_REPORT_MNT		0x00004000	/* Report FAN_MNT_ events */
+#define FAN_REPORT_MNTID	0x00008000	/* Report FAN_NS_MNT_ events */
 
 /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
 #define FAN_REPORT_DFID_NAME	(FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
-- 
2.55.0

