Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270AB37DAA9
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 14:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074983; cv=none; b=aqBszpMW5RCH8ePgnDso2owNPyFtOuNaC8bHxuyg8XkKSrB3iAzZJ76HVJgv5KfMoC7hjisX7WpuGkB+o1Q9H7Dm5ig+nc6DJ+kX0NdEe6jso4JkKiVSsVH50LtiavOIU3QZG5ZVzESUV9i/27aJgpIVq+BeYbsvQcNbUsnUMrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074983; c=relaxed/simple;
	bh=ardP/U5Z+EZf73QfezCBvz01p5kkfOQOWqvF9ihcogw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S7o8zc9/tvVfeB0Ro/sLIEhbHgWv5ViElDN2jNwEOYkFUeK3vavQbDeN37H2zhNm5OEWr6VEViVykObKmXLHvgnHHu35YQfvueaK9wIA79cu2h5wT6RLmr0kgA87hncIeyenXwEJ4h6cfS7uCzwtp4kndvTz90b00Vf0TGdJMP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEZIX6JU; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEZIX6JU"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2dcbcc546fso663549666b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 07:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792074978; x=1792679778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=piln5HuWAhcV7nzHLUUHy6422XKwoVQo6jrzQrJu+e8=;
        b=cEZIX6JUuw6ko2W41VBiBIyz7c9TKjJomVHnBlPenueNGlTlhv4fIjXLMc1rmyzFSD
         OCr+p+SvNF+zXlGgKpKt6SswrLUz1PVPtH/8jVqNhNm/9YkX4wG4gvUnBf7Hxix+mmKd
         O5I0AHOsrNz1gtPHhayak26VXEJux5kSjo3jBwZ4r3gmtFgSnFXAF6otXEcJoFTQZL5l
         M69KUXg+T+xX//gg78+XrWDYeoMza66aorOxg6ToFZeUQNa7M1Z0tlIO1H04+fClaHVN
         VNd9SQuWevesck1ReO6J1/vgjYi2snMa7GUs8Ai0+/2k3WKm/zHVIU43P+SpTtPe6vfP
         kkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792074978; x=1792679778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=piln5HuWAhcV7nzHLUUHy6422XKwoVQo6jrzQrJu+e8=;
        b=iR34mQVBquoGSStSiJNJS6qyptq9PqS3FCY+E1cD4POKzPuhrLQTEGZGx4EBEAM8vL
         YwMNkBXCzEj9k/F4JHhRwjxskC1NWQRAzGzhbyq8o0KjvltohSU5rcA4wdNKvoiJgY/M
         FLgj6vT91CBBUbvlzG3EjdmIjr9SLldmZZfGtW/0SUj8/k4EulTf8J6AjTvkQ4xR5xDE
         3fyWeYzvtWNm/v4G2J0v2gNkwEyH0PVZc86FSaxBBibknF9Yu6d5kj2AcwP13F7B/Bjk
         AOqWnGcsR4GyrRHRVAIejXe462mIoawmw4l8BsdWtygBCtRREM0aDgjIEE4x5WywuO5t
         LGQw==
X-Forwarded-Encrypted: i=1; AKwUvByXXTCuNTv/ahKtRuEyDqafK3r1Icm0CFGjFmhBFSWwWzBP1CxeqQET6daUo0pWhzTz4fd246y+26IlU9R4@vger.kernel.org
X-Gm-Message-State: AFq9FYL7ADIsViW3XLEOkFpK0zAVAcyeNq8oOYwoJquP7ZJSlzsvZI2S
	YqEd+5XvVMoBSjvBIumBoT1u/rTXnCH68987Zal0bCUlD9AN8SGuLJRbOVnJ/w0A
X-Gm-Gg: AYBFou2KfQxGkgCIUcbv1q5s+ZqdIWiHU0mWu2xVn8TBx6nJX3pyF72o2Ais9KHjJeO
	vMtjpM4iqLXBveWvTt0uiZpK/sfP9s77NzFWYKmgu91DNtsn3KhzNXYLyzTtaCDw8RNAeG/Rwm8
	xhMJK2UBWTMfei6WjjalMcUIuJJLsuW7+k0pZgm+PCBswQw1rTWdWH+pGC1kXAyqvCY7M9RR8sO
	gbMGRXhvUXXGPTtoh6sWmIyffhElwEHyqEv2eaFyXHi3d6qN0YroH+tEZcEHFUa8fgeh+nyu/hk
	8NOXgsGV0NBxbndjbEX8rxXNN4lzA48CYImMQg1+aPulU0ykMA/RQkRb10c0RzD5e5PbFakpdKz
	/jHGcaDyz3RSwl9DSYhUfuP1qjUOMyw98W8edCrkJp8nizNJfNtOBqyCe/9umU90MgU7Ke9n026
	/XjwpDL6soSV/lox+9W9pfZnDriRdweJJRaCyc0Iu4EKaPSVdXth3CoJz0sKfEhsWMJX0ifRKct
	8d7pyA7vqYlRH4tugLmZL9Yn8o=
X-Received: by 2002:a17:906:7948:b0:c2e:7fe7:288e with SMTP id a640c23a62f3a-c31aa082a00mr1704235466b.32.1792074977961;
        Thu, 15 Oct 2026 07:36:17 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3edab0ee85sm133342466b.80.2026.10.15.07.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:36:17 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 13/14] selftests/fanotify: update the uapi tools header copy
Date: Thu, 15 Oct 2026 16:35:59 +0200
Message-ID: <20261015143601.2095784-14-amir73il@gmail.com>
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

Sync the "strong typed" event definitions.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 tools/include/uapi/linux/fanotify.h | 100 +++++++++++++++++++---------
 1 file changed, 67 insertions(+), 33 deletions(-)

diff --git a/tools/include/uapi/linux/fanotify.h b/tools/include/uapi/linux/fanotify.h
index e710967c7c263..75c3587eea5e9 100644
--- a/tools/include/uapi/linux/fanotify.h
+++ b/tools/include/uapi/linux/fanotify.h
@@ -4,43 +4,72 @@
 
 #include <linux/types.h>
 
-/* the following events that user-space can register for */
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
-#define FAN_MNT_ATTACH		0x01000000	/* Mount was attached */
-#define FAN_MNT_DETACH		0x02000000	/* Mount was detached */
-
-#define FAN_EVENT_ON_CHILD	0x08000000	/* Interested in child events */
-
-#define FAN_RENAME		0x10000000	/* File was renamed */
-
-#define FAN_ONDIR		0x40000000	/* Event occurred against dir */
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
+/* Match event mask to any event in @event_set of the same watcher type */
+#define FAN_EVENT_MASK_MATCH(mask, event_set)			\
+	(FAN_EVENT_TYPE(mask) == FAN_EVENT_TYPE(event_set) &&	\
+	 ((mask) & (event_set) & ~FAN_EVENT_TYPE_MASK))
+
+/*
+ * Events that user-space can request when watching filesystems
+ */
+#define FAN_ACCESS		0x0000000001UL	/* File was accessed */
+#define FAN_MODIFY		0x0000000002UL	/* File was modified */
+#define FAN_ATTRIB		0x0000000004UL	/* Metadata changed */
+#define FAN_CLOSE_WRITE		0x0000000008UL	/* Writable file closed */
+#define FAN_CLOSE_NOWRITE	0x0000000010UL	/* Unwritable file closed */
+#define FAN_OPEN		0x0000000020UL	/* File was opened */
+#define FAN_MOVED_FROM		0x0000000040UL	/* File was moved from X */
+#define FAN_MOVED_TO		0x0000000080UL	/* File was moved to Y */
+#define FAN_CREATE		0x0000000100UL	/* Subfile was created */
+#define FAN_DELETE		0x0000000200UL	/* Subfile was deleted */
+#define FAN_DELETE_SELF		0x0000000400UL	/* Self was deleted */
+#define FAN_MOVE_SELF		0x0000000800UL	/* Self was moved */
+#define FAN_OPEN_EXEC		0x0000001000UL	/* File was opened for exec */
+
+#define FAN_Q_OVERFLOW		0x0000004000UL	/* Event queued overflowed */
+#define FAN_FS_ERROR		0x0000008000UL	/* Filesystem error */
+
+#define FAN_OPEN_PERM		0x0000010000UL	/* File open in perm check */
+#define FAN_ACCESS_PERM		0x0000020000UL	/* File accessed in perm check */
+#define FAN_OPEN_EXEC_PERM	0x0000040000UL	/* File open/exec in perm check */
+/* #define FAN_DIR_MODIFY	0x0000080000UL *//* Deprecated (reserved) */
+
+#define FAN_PRE_ACCESS		0x0000100000UL	/* Pre-content access hook */
+
+#define FAN_RENAME		0x0010000000UL	/* File was renamed */
 
 /* helper events */
 #define FAN_CLOSE		(FAN_CLOSE_WRITE | FAN_CLOSE_NOWRITE) /* close */
 #define FAN_MOVE		(FAN_MOVED_FROM | FAN_MOVED_TO) /* moves */
 
+/*
+ * Filter flags for watching filesystems
+ */
+#define FAN_EVENT_ON_CHILD	0x0008000000UL	/* Interested in child events */
+#define FAN_ONDIR		0x0040000000UL	/* Event occurred against dir */
+
+/*
+ * Events that user-space can request when watching namespaces
+ *
+ * NOTE: Lower 32bit values may overload filesystem events, but not event flags
+ */
+/* Backward compat mount events - cannot be mixed with other events */
+#define FAN_MNT_ATTACH		0x0001000000UL	/* Mount was attached */
+#define FAN_MNT_DETACH		0x0002000000UL	/* Mount was detached */
+/* "Strong typed" mount events - may be mixed with other namespace events */
+#define FAN_NS_MNT_ATTACH	0x0101000000UL	/* Mount was attached */
+#define FAN_NS_MNT_DETACH	0x0102000000UL	/* Mount was detached */
+
 /* flags used for fanotify_init() */
 #define FAN_CLOEXEC		0x00000001
 #define FAN_NONBLOCK		0x00000002
@@ -66,7 +95,8 @@
 #define FAN_REPORT_NAME		0x00000800	/* Report events with name */
 #define FAN_REPORT_TARGET_FID	0x00001000	/* Report dirent target id  */
 #define FAN_REPORT_FD_ERROR	0x00002000	/* event->fd can report error */
-#define FAN_REPORT_MNT		0x00004000	/* Report mount events */
+#define FAN_REPORT_MNT		0x00004000	/* Report FAN_MNT_ events */
+#define FAN_REPORT_MNTID	0x00008000	/* Report FAN_NS_MNT_ events */
 
 /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
 #define FAN_REPORT_DFID_NAME	(FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
@@ -271,4 +301,8 @@ struct fanotify_response_info_audit_rule {
 				(long)(meta)->event_len >= (long)FAN_EVENT_METADATA_LEN && \
 				(long)(meta)->event_len <= (long)(len))
 
+/* Was one of the events in @event_set reported in the event? */
+#define FAN_EVENT_MATCH(meta, event_set)			\
+	FAN_EVENT_MASK_MATCH((meta)->mask, event_set)
+
 #endif /* _UAPI_LINUX_FANOTIFY_H */
-- 
2.55.0

