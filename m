Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C1131B839
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Feb 2026 22:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770070012; cv=none; b=oFrArtnNgjku42UGiI4v8bf8okkS8mvcWTiDqWvUhO6s32lheEZ4VjhY9or9IR6wZMYbsHYu3npTGOTsDCbnZ3UuNXimuyvj+BXkjjqozl2t4BQD4AdTAmcEdxjgLCmNeUfa50KAm3WtRl11mWU1zx8bcQtzozUwVEwh/F1gqxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770070012; c=relaxed/simple;
	bh=fvA0PrASi0IEQdDf3f1fGp12n+7yWLtrlVdlPB6P9Bs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DOl/N0aaN129qtbhvB2oqZd6bxoYZ68Gye7W3ye9d4fZsZ/qLPIzJ1bKaWI3VcRV2p4YKcZfwc6OXs9TWHSpML+fe48WTQTOixxisoFH7VLAjW5OuYFK6mn1LmopsFDfgm3O1ZjpXByH6ZVuRIcMb3wUY04VY1oRWoX36okjsRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8220bd582ddso2884570b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Feb 2026 14:06:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770070011; x=1770674811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9lgtSUZzde++Bz8uhOIABUkDKpLi6HbwbfVMl9KEQwY=;
        b=stnUlxUffEaPQ8g2+t+cyiDEzYNuFSvHV5xuHecf720N189U24WRiW+gE6N+Xb9w49
         HhPZ1JYaJshqkTCldIDciFJfBArBcC11k4QzoYGJRdYwhSaR2QbsdOtPxaQYv6B4z2Z0
         6/jVy4ykYR4lKgIglmKre/GZSQffNHoa95RH7dFMf1Km+mdiEs/tvTTJ525On2Ai2WOa
         4vN8FS+NTgPR3F6vRos0G/i/WqyXk00TOR894vhoymXvmOpEkcCGUXiP8nk6Eu/teLy8
         /HlujZMCStKgEAUqBJ3D5gmHgHL/OvsLtlbCUbYrmPc5XzMgJl602yKj/mnxFZPNrFh3
         /x3g==
X-Gm-Message-State: AOJu0YzoSGVXf8qPAKkgC1Ek/cwVrfij2VbHJxzlYtp8JAFcocEeY+5R
	dDPCoLAHfERT5lJQ9/8oiCiQwMj3i9m0rOuEud4SwBDmwp75NeBqubQi
X-Gm-Gg: AZuq6aLYaEe6Z050NfXpPRZ2Ng5a5vrwAg/CoucHrWFzuzuTlFKJi13atpTtpe1qZfG
	D/Ecn3XJfC+IY6wtt8yHd7CBj/LFkS67tbT3F+r7Z8+KmBlBQitTo9KBjmuML6fvB+vi+UREzEV
	xvANVbm2jmLergS2G4h2i9F0OLOJM+yQUa45Ou+wCCmqeBaARWtlC0UWf3DwMTaFaL8QR1GT+78
	+dZyjPOI/qP2XEMqU38N6f58sNBvNCETOsI3LvHtpax1QkQN3Bcn0MhYNmq7IFIaU1rupa+5/Wi
	bQz3cbluY2xQ3ipLbzTuvXxpi5ap28dofvisnBtb4K4BGvxI5zv782E3DGcworzKzjXHQkXjCb5
	Z8H9Yq/6aHALeSLW72vo1XZX81VW/7xZuPh85QM2Kt0poGsLxZKVqtKhqd7fGW7dwAy6yl61EDV
	hlfzK29nn/tNAUAnlXJozot2ZzJA==
X-Received: by 2002:a05:6a00:8f0c:b0:81f:5ec1:8bd2 with SMTP id d2e1a72fcca58-823aab6f87dmr11472886b3a.54.1770070010681;
        Mon, 02 Feb 2026 14:06:50 -0800 (PST)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b6b277sm21019732b3a.29.2026.02.02.14.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 14:06:50 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hch@lst.de,
	tytso@mit.edu,
	willy@infradead.org,
	jack@suse.cz,
	djwong@kernel.org,
	josef@toxicpanda.com,
	sandeen@sandeen.net,
	rgoldwyn@suse.com,
	xiang@kernel.org,
	dsterba@suse.com,
	pali@kernel.org,
	ebiggers@kernel.org,
	neil@brown.name,
	amir73il@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com,
	jay.sim@lge.com,
	gunho.lee@lge.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v6 03/16] fs: add generic FS_IOC_SHUTDOWN definitions
Date: Tue,  3 Feb 2026 07:01:49 +0900
Message-Id: <20260202220202.10907-4-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260202220202.10907-1-linkinjeon@kernel.org>
References: <20260202220202.10907-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, several filesystems (e.g., xfs, ext4, btrfs) implement
a "shutdown" or "going down" ioctl to simulate filesystem force a shutdown.
While they often use the same underlying numeric value, the definition is
duplicated across filesystem headers or private definitions.

This patch adds generic definitions for FS_IOC_SHUTDOWN in uapi/linux/fs.h.
This allows new filesystems (like ntfs) to implement this feature using
a standard VFS definition and paves the way for existing filesystems
to unify their definitions later.

The flag names are standardized as FS_SHUTDOWN_* to be consistent with
the ioctl name, replacing the historical GOING_DOWN naming convention.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 include/uapi/linux/fs.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 66ca526cf786..32e24778c9e5 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -656,4 +656,16 @@ struct procmap_query {
 	__u64 build_id_addr;		/* in */
 };
 
+/*
+ * Shutdown the filesystem.
+ */
+#define FS_IOC_SHUTDOWN _IOR('X', 125, __u32)
+
+/*
+ * Flags for FS_IOC_SHUTDOWN
+ */
+#define FS_SHUTDOWN_FLAGS_DEFAULT	0x0
+#define FS_SHUTDOWN_FLAGS_LOGFLUSH	0x1	/* flush log but not data*/
+#define FS_SHUTDOWN_FLAGS_NOLOGFLUSH	0x2	/* don't flush log nor data */
+
 #endif /* _UAPI_LINUX_FS_H */
-- 
2.25.1

