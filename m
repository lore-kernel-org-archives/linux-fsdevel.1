Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6749D3537D2
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 19:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774465252; cv=none; b=CIcnzJqwbIKFhqLT0hMjfjncyBEIkyTBdOwDOFKfIcE5jrKM02SAMXPv9Hf6omBou7/sKTzYcbTA1ppWrSgyB+a917ga32EjPbPUkvXvNM1X+IWXvpYia0gH7EDm6VwLc1+PR0AUFEqijVU2hSA0TqxGHhgx8kVW8FmEF1010xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774465252; c=relaxed/simple;
	bh=Enw/zzJVJMDXaMMGM31CM+5uyNb3Ul/5hZTe/vhutLk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WoU0YlKz4DujrBM8lPHpHVgfyAeFpZKyxZbkIWpaQMbOtab/JodK4RBo0O3Er7hHeFkV7p8poBpZVJ4tKks0k0KdGFNSLBAXmXK2VYdfbj5mDVJEzYncbEXD9B8Z0zNnBCgugOU6CooUwaE3cgccQKqi8SK9NWGTfWHjeGDrhZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=hZg5TDeu; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="hZg5TDeu"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2ad9516a653so806885ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 12:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1774465247; x=1775070047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiX7Q0UkWwVNRq6H0KnVBDZPehmpnW8I6Y9xdRC1GFE=;
        b=hZg5TDeuKiGoKitY+K1cikB+gNHs6boOYL0N+KIBA+8uLZS604FRjRhEDuXRl14pGX
         9+lP/J2UdVca8s1hbQwD2YhTrGLswAacjENQh5DdxNsubXo9unOo5dIFoeT5hX3LC/MS
         Sv2eKLNxMUwPgHfDVTGmeSgsBioI10q242kKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774465247; x=1775070047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QiX7Q0UkWwVNRq6H0KnVBDZPehmpnW8I6Y9xdRC1GFE=;
        b=AQOywFAdFGL79FfpcUUnLub9V3y7/JaHUswBn0UCbpGpSog2lORy3jo9a60mBoT6MD
         qMTvVD+hvZBtrFs61XIAliWtUfDk5XGymH4f9RQVWB4aphLvUkfrY/pzTjYmFT810sDZ
         SJftOMCf+bt7Xu99c1scC7oDQ67JXekge5au2wYqQmvDv0Bo9VbC7RqDPa5jWC/5xbFt
         d6BzgNO7IGW1xtRmv9Kr7eddq+eIKKGqtUQ1pZkQGAenaxreIdCVRSBY1rU7Aj9OSYad
         9fqg6g3Sd8DLGy3KCfoKsn/uFMESUPBsP7wh7CIwALkIxEyXYDZOlxD5bt9QLhaoLWA8
         NPFw==
X-Forwarded-Encrypted: i=1; AJvYcCV2ty2m3zJfsAHsq0+2+Vuqqel5dWMrHDrPJYqITVUTqWnyD+lSBuUyWAJS6pCX1OEsw9C1MB6yuKwx+YQO@vger.kernel.org
X-Gm-Message-State: AOJu0YyuT+EbIptvYsXtmjCq2fbIhqFaEuEJfH4uDm/aWAzEXv5dswhw
	gauumlx+xqjsfvIlVjhMVTm2VbUgqP36tEQG2wgXiUz4rfikq1CWLltf9yj5cl0GxIs=
X-Gm-Gg: ATEYQzy8W5jGoW/KQJoJ2ggFbCSR0thQSziNDLfKoun1y09taGSI7AxS5qWGeHewe6J
	o1av4tX5nmFYGgKQ4J6Y9cfkoy+6h/qVnbq1EvD/lTyP8xmHxgxXOa8SQDfoJC501t98sOApO2L
	8pj2XUWevO1dhOkqsBhuVOICKqEUJHYGSSrPPeOc7hBrO0DQnbsDxH4ihGpnFrEpGV2PzVEgm7+
	G0tpI8+Jxp8oe/MQX3r5So16+c86IF1+zJ6Fm9vmUZZbCiWnxzLKN6rYKvntavo8lkVD10KT5rm
	cH/mZvlvO19GPuxIJqpSUQeHCJOm3MT7z2EeivvJaSqDIlGYWctttrjHuP7xxnT6ZwSqucAc6of
	HDedJMvbDEa/6GmxHjqOJCr9bz4hN35CoFW6Cz2oO8KsBQrLTLSVX+8vUIH6czgbRuC2pzx3XDS
	Mfo86r+AxmXhTjbe97TgWQcYFYEG+hM1URMukNjk9u6FWTbtr1GpvqT7cjsIllcNrsG1bNn9Uur
	ScjyR+qzzF7Gaa4Mgci5w==
X-Received: by 2002:a17:903:1b43:b0:2aa:d671:e613 with SMTP id d9443c01a7336-2b0b0aac1c7mr55208405ad.38.1774465246593;
        Wed, 25 Mar 2026 12:00:46 -0700 (PDT)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc79f7dbsm6483485ad.25.2026.03.25.12.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 12:00:46 -0700 (PDT)
From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: manfred@colorfullife.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	rstoyanov@fedoraproject.org,
	ptikhomirov@virtuozzo.com,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
Subject: [RFC PATCH 1/3] mqueue: uapi: add struct mq_peek_attr and F_MQ_PEEK
Date: Thu, 26 Mar 2026 00:30:23 +0530
Message-Id: <20260325190025.40312-2-ssrane_b23@ee.vjti.ac.in>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325190025.40312-1-ssrane_b23@ee.vjti.ac.in>
References: <20260325190025.40312-1-ssrane_b23@ee.vjti.ac.in>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the user-visible interface for non-destructive POSIX message queue
inspection via fcntl(2).

POSIX message queues have no way to inspect queued messages without
consuming them: mq_receive() always dequeues the message it returns.
This makes it impossible for checkpoint/restore tools such as CRIU to
save and replay message queue contents without destroying the queue
state in the process.

struct mq_peek_attr describes the request: the caller specifies an
index into the queue in receive order (0 = next message that
mq_receive() would return, i.e. highest priority, FIFO within same
priority) and a buffer to receive the payload.  On return, msg_prio is
filled with the message priority and the return value is the number of
bytes copied.

F_MQ_PEEK = F_LINUX_SPECIFIC_BASE + 17 is the new fcntl command that
accepts a pointer to struct mq_peek_attr.

Link: https://github.com/checkpoint-restore/criu/issues/2285
Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
---
 include/uapi/linux/fcntl.h  |  6 ++++++
 include/uapi/linux/mqueue.h | 21 +++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index aadfbf6e0cb3..ea34f87de0fb 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -84,6 +84,12 @@
 #define F_GETDELEG		(F_LINUX_SPECIFIC_BASE + 15)
 #define F_SETDELEG		(F_LINUX_SPECIFIC_BASE + 16)
 
+/*
+ * Peek at a POSIX message queue message by index without consuming it.
+ * Argument is a pointer to struct mq_peek_attr (see <linux/mqueue.h>).
+ */
+#define F_MQ_PEEK		(F_LINUX_SPECIFIC_BASE + 17)
+
 /* Argument structure for F_GETDELEG and F_SETDELEG */
 struct delegation {
 	__u32	d_flags;	/* Must be 0 */
diff --git a/include/uapi/linux/mqueue.h b/include/uapi/linux/mqueue.h
index b516b66840ad..7133b84c70d1 100644
--- a/include/uapi/linux/mqueue.h
+++ b/include/uapi/linux/mqueue.h
@@ -53,4 +53,25 @@ struct mq_attr {
 
 #define NOTIFY_COOKIE_LEN	32
 
+/*
+ * Argument structure for fcntl(F_MQ_PEEK).
+ *
+ * Peek at a POSIX message queue message by index without removing it.
+ * @offset:   Index in receive order (0 = highest priority, next to dequeue).
+ *            FIFO ordering is preserved within the same priority level.
+ * @msg_prio: Output: priority of the message at @offset.
+ * @buf_len:  Size of the caller-provided buffer at @buf.
+ * @buf:      Output: message payload is written here; truncated to @buf_len
+ *            bytes if the message is larger.
+ *
+ * Returns the number of bytes copied on success, -ENOMSG if @offset is
+ * >= mq_curmsgs, or a negative error code on failure.
+ */
+struct mq_peek_attr {
+	__s32		 offset;
+	__u32		 msg_prio;
+	__kernel_size_t  buf_len;
+	char __user	*buf;
+};
+
 #endif
-- 
2.34.1

