Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78EA361657
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074977; cv=none; b=In+1OiQoQmxjuusi7dZNArk76tJat0TQ1Sx38exQHga5+LYXu1QdJ77225AOpY1oWKycV2qPZM77OkSK9xVcL/ebYavDjJw71+SzRR9YKKA3oOuYFA3Hcfx3hLdrCsEDO+J2LRoVbGw++Z5biKBU5R5M/9+sQ7qSrV+EecETpnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074977; c=relaxed/simple;
	bh=vaz/NJFvb6Ga4nylm2z2PeoHEw2M8WYVKPfPF0e7Ftk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7Crcx+mZkw4Ue1ft2dSI1SBGlRdXPZAPODibB12fKVkNn6jJdiZXZHtMGPNlET0MnHICjqiujYtwdkcq5jaHqVWOll72WwCJic7zi7fkCaBfnrts2SDY3iLNivTrWTrN6DFU0X+uckO0ATPTjxii9heTNhLzRPAIDchLixoNZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdqcicQR; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdqcicQR"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c2afa22e1dcso781216066b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 07:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792074971; x=1792679771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P6g34UThOsuYP0v6M3LnrM9aPXtcg2KGUQk7kbZQ3n4=;
        b=NdqcicQRfAPfxlNvJ0iY1yb5OhDmrc50rHhoD2l0adKBKSvXjccW30qRdE7h+kEHXb
         AMPEicG9w72vbDsI0yNlCA3H/tTwnNUTgIBiJK9ToZ4Pa87iMGvQPkPKfTm5mvSKE8Q7
         l0s7AfwUvDC+O9yOThGx1t9BFI+nMfaFmqp+38llnUi1CpBXvcgZDaDORtyRu0HXpz4N
         XVq9vT+MasEDib5bb/hemQD2N/5RrxMwLbL+YDcIYNAFYAw9bNByEKzz8rYLCTGIuXrh
         uFoaOLQ1rZLhQu/9bFCJCzkKp0g0G5m3HU3mJlvhcAwkfvIlHC20rM6yInWDjxfa1yMT
         sWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792074971; x=1792679771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P6g34UThOsuYP0v6M3LnrM9aPXtcg2KGUQk7kbZQ3n4=;
        b=fcayzcNA7dhy9xAl63fMEQ5S6+/FCAhmlBHkaxoztUIRoUD6moc9JMsKGH0HSMG/KA
         7PENerAFMn9f6hLB8xdWkawmcdlnfYvjDr1X5tupJRwzhcsGDYoQAXspceXl53pFnoid
         mmKzBcIOq7f40nzzX69QwBGj6y28ABh6713Rk/Cpr+YSMWrxq4gkSuqsB9CehrtFFI5b
         Hs+Ql+IN2FTFbHDf7htQfevwTpcu6R51B2Ly+cUDj1IXjBYDYHKgHwDKt6YEroAc7gD+
         Vl1ttVoEuO3RmoUJLvHia4JYgLxhceFy9uXkLk6I+sgx3gII/wVvfy14AhMH6MdvOyb6
         twmA==
X-Forwarded-Encrypted: i=1; AKwUvBxKQ2UmRhEubbGFEL3nlTBh6xrhcC9zlD+JJDarL4v9DivU92hKEUa6OtBzQAVYHFjqFx1g0weIPWQSCWm/@vger.kernel.org
X-Gm-Message-State: AFq9FYIGmOGBWqupNl8ksyR7lli4zb1/Kikqjq2bba05bO1ggXcdY+mg
	OtDeDvr2hxxRsto9Zp3aMNq/7guSNOLbergZkmd1lODfoSVKC5Y2GPk9jKAgsieX
X-Gm-Gg: AYBFou2xqvIMTiKZJFwz5QO1bQ2lpGSb7W4HLxvTRaKsT0jDgCOm5wraEcBlU9dVLSl
	ChMzl2/65d1ByNhw1D0jdS57YR0uMPhNPtLsl/jmyQgKwga5XGV9mbfCLakQR4910HN/NluYOGv
	S3SvDoXe3UykH9/5Nz+AZJgNlCew+sgdeyBrOGJ7i9imtTd8RrfzRtmhQ6cAsqjcenVFN8MsxP1
	Eez1OEOK99+S87uTn1HpziASY7oiF/hWz3KjwkPjw9MYPscENnjHK9d+xI4KQ0fuI28jWpEUhdU
	RTa/Y5cd7sF39Uzh1tUflXfChO48LRjU/c6AyUFWMyULOwzAcZt5lenxpfR679azZeqxHAOtmIh
	496PbnanaPIf5z0R35Ma1+N5ngsit9cE77Lls2CoRvKdaYveH9HAxWLNIzSumnMlqyS3oleZTYT
	C1YjZOPAwQsGRK5+TiGoqMYGKRpZXoyiWM4rkP/+nVZFkjlfyKTRzVLYUA4PpvuwyuYvLtj26bX
	/gYPBAL57ujH9g+GqYE6RWj
X-Received: by 2002:a17:906:478d:b0:c3f:dce3:20cc with SMTP id a640c23a62f3a-c3fdce3385amr95173766b.19.1792074970765;
        Thu, 15 Oct 2026 07:36:10 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3eda62d2ebsm133371066b.74.2026.10.15.07.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:36:10 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 07/14] fanotify: define event mask constants as 64bit
Date: Thu, 15 Oct 2026 16:35:53 +0200
Message-ID: <20261015143601.2095784-8-amir73il@gmail.com>
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

The fanotoify_mark() syscall takes a u64 mask argument, but all the
constants are defined as int values.

Define the constants unsigned long and use bits 32..29 to define their
target group type.

All of the legacy event constant values are unchanged because they are
defined with the filesystem watcher group type (0).

The FAN_MNT_* constants need special attention - they belong to the
namespace watcher group type, but the type bits do not match.
This will be handled by a followup patch.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c | 53 ++++++++++++++-------------
 include/uapi/linux/fanotify.h | 68 ++++++++++++++++++++---------------
 2 files changed, 68 insertions(+), 53 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 35b87a7cc6129..7d6fd2a9d5938 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -963,6 +963,10 @@ static void fanotify_insert_event(struct fsnotify_group *group,
 	hlist_add_head(&event->merge_list, hlist);
 }
 
+#define ASSERT_FS_EVENT(fan_mask, fsn_mask) \
+	BUILD_BUG_ON((u32)(fan_mask) != (fsn_mask) || \
+		     FAN_EVENT_TYPE(fan_mask) != FSNOTIFY_GROUP_TYPE_FILESYSTEM)
+
 static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 				 const void *data, int data_type,
 				 struct inode *dir,
@@ -977,30 +981,31 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	bool is_perm_event = fsnotify_is_filesystem_watcher(group) &&
 			     (mask & FANOTIFY_PERM_EVENTS);
 
-	BUILD_BUG_ON(FAN_ACCESS != FS_ACCESS);
-	BUILD_BUG_ON(FAN_MODIFY != FS_MODIFY);
-	BUILD_BUG_ON(FAN_ATTRIB != FS_ATTRIB);
-	BUILD_BUG_ON(FAN_CLOSE_NOWRITE != FS_CLOSE_NOWRITE);
-	BUILD_BUG_ON(FAN_CLOSE_WRITE != FS_CLOSE_WRITE);
-	BUILD_BUG_ON(FAN_OPEN != FS_OPEN);
-	BUILD_BUG_ON(FAN_MOVED_TO != FS_MOVED_TO);
-	BUILD_BUG_ON(FAN_MOVED_FROM != FS_MOVED_FROM);
-	BUILD_BUG_ON(FAN_CREATE != FS_CREATE);
-	BUILD_BUG_ON(FAN_DELETE != FS_DELETE);
-	BUILD_BUG_ON(FAN_DELETE_SELF != FS_DELETE_SELF);
-	BUILD_BUG_ON(FAN_MOVE_SELF != FS_MOVE_SELF);
-	BUILD_BUG_ON(FAN_EVENT_ON_CHILD != FS_EVENT_ON_CHILD);
-	BUILD_BUG_ON(FAN_Q_OVERFLOW != FS_Q_OVERFLOW);
-	BUILD_BUG_ON(FAN_OPEN_PERM != FS_OPEN_PERM);
-	BUILD_BUG_ON(FAN_ACCESS_PERM != FS_ACCESS_PERM);
-	BUILD_BUG_ON(FAN_ONDIR != FS_ISDIR);
-	BUILD_BUG_ON(FAN_OPEN_EXEC != FS_OPEN_EXEC);
-	BUILD_BUG_ON(FAN_OPEN_EXEC_PERM != FS_OPEN_EXEC_PERM);
-	BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
-	BUILD_BUG_ON(FAN_RENAME != FS_RENAME);
-	BUILD_BUG_ON(FAN_PRE_ACCESS != FS_PRE_ACCESS);
-
-	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 24);
+	/* Assert "strong typed" events for filesystem watcher */
+	ASSERT_FS_EVENT(FAN_ACCESS, FS_ACCESS);
+	ASSERT_FS_EVENT(FAN_MODIFY, FS_MODIFY);
+	ASSERT_FS_EVENT(FAN_ATTRIB, FS_ATTRIB);
+	ASSERT_FS_EVENT(FAN_CLOSE_NOWRITE, FS_CLOSE_NOWRITE);
+	ASSERT_FS_EVENT(FAN_CLOSE_WRITE, FS_CLOSE_WRITE);
+	ASSERT_FS_EVENT(FAN_OPEN, FS_OPEN);
+	ASSERT_FS_EVENT(FAN_MOVED_TO, FS_MOVED_TO);
+	ASSERT_FS_EVENT(FAN_MOVED_FROM, FS_MOVED_FROM);
+	ASSERT_FS_EVENT(FAN_CREATE, FS_CREATE);
+	ASSERT_FS_EVENT(FAN_DELETE, FS_DELETE);
+	ASSERT_FS_EVENT(FAN_DELETE_SELF, FS_DELETE_SELF);
+	ASSERT_FS_EVENT(FAN_MOVE_SELF, FS_MOVE_SELF);
+	ASSERT_FS_EVENT(FAN_EVENT_ON_CHILD, FS_EVENT_ON_CHILD);
+	ASSERT_FS_EVENT(FAN_Q_OVERFLOW, FS_Q_OVERFLOW);
+	ASSERT_FS_EVENT(FAN_OPEN_PERM, FS_OPEN_PERM);
+	ASSERT_FS_EVENT(FAN_ACCESS_PERM, FS_ACCESS_PERM);
+	ASSERT_FS_EVENT(FAN_ONDIR, FS_ISDIR);
+	ASSERT_FS_EVENT(FAN_OPEN_EXEC, FS_OPEN_EXEC);
+	ASSERT_FS_EVENT(FAN_OPEN_EXEC_PERM, FS_OPEN_EXEC_PERM);
+	ASSERT_FS_EVENT(FAN_FS_ERROR, FS_ERROR);
+	ASSERT_FS_EVENT(FAN_RENAME, FS_RENAME);
+	ASSERT_FS_EVENT(FAN_PRE_ACCESS, FS_PRE_ACCESS);
+
+	BUILD_BUG_ON(HWEIGHT64(ALL_FANOTIFY_EVENT_BITS) != 24);
 
 	mask = fanotify_group_event_mask(group, iter_info, &match_mask,
 					 mask, data, data_type, dir);
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index f91d4fe8fd65a..b5377a7cd991a 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -4,34 +4,44 @@
 
 #include <linux/types.h>
 
+/*
+ * Bits 32..39 of the 64-bit event mask encodes the watcher type.
+ * Filesystem events have type 0, so legacy event constants are
+ * filesystem events.
+ */
+#define FAN_EVENT_TYPE_SHIFT	32
+#define FAN_EVENT_TYPE_MASK	(0xffULL << FAN_EVENT_TYPE_SHIFT)
+#define FAN_EVENT_TYPE(mask)	\
+	(((mask) & FAN_EVENT_TYPE_MASK) >> FAN_EVENT_TYPE_SHIFT)
+
 /*
  * Events that user-space can request when watching filesystems
  */
-#define FAN_ACCESS		0x00000001	/* File was accessed */
-#define FAN_MODIFY		0x00000002	/* File was modified */
-#define FAN_ATTRIB		0x00000004	/* Metadata changed */
-#define FAN_CLOSE_WRITE		0x00000008	/* Writable file closed */
-#define FAN_CLOSE_NOWRITE	0x00000010	/* Unwritable file closed */
-#define FAN_OPEN		0x00000020	/* File was opened */
-#define FAN_MOVED_FROM		0x00000040	/* File was moved from X */
-#define FAN_MOVED_TO		0x00000080	/* File was moved to Y */
-#define FAN_CREATE		0x00000100	/* Subfile was created */
-#define FAN_DELETE		0x00000200	/* Subfile was deleted */
-#define FAN_DELETE_SELF		0x00000400	/* Self was deleted */
-#define FAN_MOVE_SELF		0x00000800	/* Self was moved */
-#define FAN_OPEN_EXEC		0x00001000	/* File was opened for exec */
-
-#define FAN_Q_OVERFLOW		0x00004000	/* Event queued overflowed */
-#define FAN_FS_ERROR		0x00008000	/* Filesystem error */
-
-#define FAN_OPEN_PERM		0x00010000	/* File open in perm check */
-#define FAN_ACCESS_PERM		0x00020000	/* File accessed in perm check */
-#define FAN_OPEN_EXEC_PERM	0x00040000	/* File open/exec in perm check */
-/* #define FAN_DIR_MODIFY	0x00080000 */	/* Deprecated (reserved) */
-
-#define FAN_PRE_ACCESS		0x00100000	/* Pre-content access hook */
-
-#define FAN_RENAME		0x10000000	/* File was renamed */
+#define FAN_ACCESS		0x0000000001ULL	/* File was accessed */
+#define FAN_MODIFY		0x0000000002ULL	/* File was modified */
+#define FAN_ATTRIB		0x0000000004ULL	/* Metadata changed */
+#define FAN_CLOSE_WRITE		0x0000000008ULL	/* Writable file closed */
+#define FAN_CLOSE_NOWRITE	0x0000000010ULL	/* Unwritable file closed */
+#define FAN_OPEN		0x0000000020ULL	/* File was opened */
+#define FAN_MOVED_FROM		0x0000000040ULL	/* File was moved from X */
+#define FAN_MOVED_TO		0x0000000080ULL	/* File was moved to Y */
+#define FAN_CREATE		0x0000000100ULL	/* Subfile was created */
+#define FAN_DELETE		0x0000000200ULL	/* Subfile was deleted */
+#define FAN_DELETE_SELF		0x0000000400ULL	/* Self was deleted */
+#define FAN_MOVE_SELF		0x0000000800ULL	/* Self was moved */
+#define FAN_OPEN_EXEC		0x0000001000ULL	/* File was opened for exec */
+
+#define FAN_Q_OVERFLOW		0x0000004000ULL	/* Event queued overflowed */
+#define FAN_FS_ERROR		0x0000008000ULL	/* Filesystem error */
+
+#define FAN_OPEN_PERM		0x0000010000ULL	/* File open in perm check */
+#define FAN_ACCESS_PERM		0x0000020000ULL	/* File accessed in perm check */
+#define FAN_OPEN_EXEC_PERM	0x0000040000ULL	/* File open/exec in perm check */
+/* #define FAN_DIR_MODIFY	0x0000080000ULL  * Deprecated (reserved) */
+
+#define FAN_PRE_ACCESS		0x0000100000ULL	/* Pre-content access hook */
+
+#define FAN_RENAME		0x0010000000ULL	/* File was renamed */
 
 /* helper events */
 #define FAN_CLOSE		(FAN_CLOSE_WRITE | FAN_CLOSE_NOWRITE) /* close */
@@ -40,16 +50,16 @@
 /*
  * Filter flags for watching filesystems
  */
-#define FAN_EVENT_ON_CHILD	0x08000000	/* Interested in child events */
-#define FAN_ONDIR		0x40000000	/* Event occurred against dir */
+#define FAN_EVENT_ON_CHILD	0x0008000000ULL	/* Interested in child events */
+#define FAN_ONDIR		0x0040000000ULL	/* Event occurred against dir */
 
 /*
  * Events that user-space can request when watching namespaces
  *
  * NOTE: These values may overload filesystem events, but not event flags
  */
-#define FAN_MNT_ATTACH		0x01000000	/* Mount was attached */
-#define FAN_MNT_DETACH		0x02000000	/* Mount was detached */
+#define FAN_MNT_ATTACH		0x0001000000ULL	/* Mount was attached */
+#define FAN_MNT_DETACH		0x0002000000ULL	/* Mount was detached */
 
 /* flags used for fanotify_init() */
 #define FAN_CLOEXEC		0x00000001
-- 
2.55.0

