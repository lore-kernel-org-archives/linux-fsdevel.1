Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F1736DA00
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 17:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050316; cv=none; b=okYVSpMvk3yV1PdF5nz+OP93rzMyTDY0wUYGd7E0yiB7SXO2p+fqDVPHZ+lAWMAi+xuLcSlt1z4Cfe4Sxb1Dx74omlZX5XGPlMK18W0Sqk4+YZHGERYhi+/uvh+R497BN56CdvcN+df/PCrOPu3s3Uw7RwdRBkstkm5MsPCwIk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050316; c=relaxed/simple;
	bh=cvYHCNRybH4BxEjt4Hif6iiEaC5lJu4jLdQk6AhSYQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SiREAJVZ1ymHCmeoGrf4K78grUrd9vmKolOIeKkV01Oh7pKdOUm+AGjaIwc1U6wO6wDGZddbePMAjFQrVb2O2O7kj1LIAxhkZJY9IwTVD4DpTck3ozoP0W4KAS9Jzr18W0jsEMhQ6IXEhAsoiNwab+IvBfEXoGolXQcGgq1+jvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNHntiOJ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNHntiOJ"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-672645dbfeaso8868628a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 10:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777050313; x=1777655113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nv6eAIQDEG1IdwaVQkjQNHdfiBh4q5/amZ4aDVwKZJo=;
        b=hNHntiOJ0WI7SaJpYBmrM5aFxnMeDGr7JWypk7emfuY4JqUPnx9lD9mEfliiVu14I4
         r2L8mwKLWvRPGp6JsInA+DJoKgOe277/gen7aMiuu0YQ2w+Rvy3OdSDel3WEGxhoI88Y
         XqP2ISx7xLlZ86pDi7YDf5J6woNN0mV71NJE79Y+sXyyd/7w24+saZJO0nVSOn/oaWiO
         aixB7rJnqzuTryvGBB9UwJD842raO7ERtrgtxZ2sxfNltQpbOzEgNczOenySDLw34Lgy
         q35BWs05X1sg5J9dfI3dP1UmcqFMC9Hz/arT2u+qrpICQUkvqTndbQ1a6so17ZpIGB9T
         //Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777050313; x=1777655113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nv6eAIQDEG1IdwaVQkjQNHdfiBh4q5/amZ4aDVwKZJo=;
        b=qrzxErREoV3FpuOxW8SVbvu07j7j6J3yJwlHb9wTSRRExG9hk3KMNblR0BgqbtgD3u
         98TkDqBmDlJQPPjN2gMForDk/W/qOGBTPrLKHUSKu2bKQ4ols1U+670TFuupgo4yxkg+
         wNJ1ywce+rrISd6MzCzLBuYI8krbt3+l0Uf5PSkDX1HhtAD2cvZQ82NKsEwaAPAefoV/
         nq/ImLtj2BDXgWJ4JMBYYTI4jXE7u2+JjGzPYeMaBxWJcFFxJ5M+FUIhiPJcV7ZuwzAT
         5ondFLBmZHXpB5xdIU5vINt9weL8yCETEvyjlhyuBePGo18wY5fUrqAfJtYSwTJGbrtO
         h4gQ==
X-Forwarded-Encrypted: i=1; AFNElJ/FEpWbiYnI6AsBTC6cZ4/sp4Xxxsj6wvyKuofQ63MYoyOHA9FpISgI/GQr3fW4pGQWCjkHdJYBcagGxQKh@vger.kernel.org
X-Gm-Message-State: AOJu0YwpvGZXTVZeehpoxbJRgjVhEqplEQlgkITERObfSZcDLjgjJwdc
	gG7Omv4E0hzE1JfIWyP+O8nW1RRoByeGAxlPwkOeuR7yKt9i4eytVWUQCqfjnc3rWrU=
X-Gm-Gg: AeBDietrVSAbbwV5Lm5I1qQ7mkfAydKJwPZq2CcnPkr+cYmIWRwMZxqK+ENV/y7HLFH
	aMQMd0FqVwgUEe41pU9UwapvMUPrib719LnrZ/J500rfJoKByiXbJoa863WyUuPqRuGSbXhUhwU
	8pTzSWtGDD4vE/XCdU3E8SAz39ip6HzgWvCRVWSKLGZm4StZX5zYV1T+aJx8SSP8jFmAHfKRMwN
	fZUHQXQER2WfAsUOfcKKYtgntHideqpqt+Zca+8e3BBQrGqq1W6OJDO1lZ/AGZPuxevgnhGACy2
	OXQSUZl/s0cdl8bbRzZ6SK7VgBGBdUZxLctll4UYz08S/ck2L+lJYo1BrNUAYtVvS/0IFMm5Utf
	l27QiXKs8StryXvuncmJrxTOVQmgqmOV5T1frAAdsfkLZIMnaGKCT+5Ii40dg09DMANx+SUIYFm
	OlCa0iWHbGELiYXglyrwq+6X4GByM/vvG7Ea0gDIRTmgr+TbIZeSBYDfnFk0+aPvLJwQREYA6K4
	eniPzFChe6nyHjkXFOjV3GKUt5H4xfeuPwUJ0E=
X-Received: by 2002:a17:907:3f16:b0:b9d:6d06:b78a with SMTP id a640c23a62f3a-ba418985765mr1485116766b.17.1777050312418;
        Fri, 24 Apr 2026 10:05:12 -0700 (PDT)
Received: from localhost (2001-1c00-570d-ee00-4aab-734a-1928-df3f.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:4aab:734a:1928:df3f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba45553e9e4sm815655866b.60.2026.04.24.10.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 10:05:11 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 06/10] fanotify: gate fs event classification by group type
Date: Fri, 24 Apr 2026 19:04:59 +0200
Message-ID: <20260424170503.2096847-7-amir73il@gmail.com>
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

fanotify decides on how to allocate events based on the event mask.
The event mask bits that correspond to filesystem watchers are only
meaningful in the context of filesystem group type.

Hence, before checking if event is a specific fs event (e.g. FS_RENAME)
need to first check the group type is filesystem.

Separate fanotify_alloc_event() into an allocator per group type, so
that all the fs events check inside fanotify_alloc_fs_watcher_event()
are already properly gated.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c | 73 ++++++++++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 15 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 80116026d3ae0..987092c38789b 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -744,11 +744,12 @@ static struct fanotify_event *fanotify_alloc_error_event(
 	return &fee->fae;
 }
 
-static struct fanotify_event *fanotify_alloc_event(
+static struct fanotify_event *fanotify_alloc_fs_watcher_event(
 				struct fsnotify_group *group,
 				u32 mask, const void *data, int data_type,
 				struct inode *dir, const struct qstr *file_name,
-				__kernel_fsid_t *fsid, u32 match_mask)
+				__kernel_fsid_t *fsid, u32 match_mask,
+				unsigned int *hash)
 {
 	struct fanotify_event *event = NULL;
 	gfp_t gfp = GFP_KERNEL_ACCOUNT;
@@ -759,14 +760,11 @@ static struct fanotify_event *fanotify_alloc_event(
 	const struct path *path = fsnotify_data_path(data, data_type);
 	struct fs_error_report *fs_error =
 		fsnotify_data_error_report(data, data_type);
-	u64 mnt_id = fsnotify_data_mnt_id(data, data_type);
 	struct mem_cgroup *old_memcg;
 	struct dentry *moved = NULL;
 	struct inode *child = NULL;
 	bool name_event = false;
-	unsigned int hash = 0;
 	bool ondir = mask & FAN_ONDIR;
-	struct pid *pid;
 
 	if ((fid_mode & FAN_REPORT_DIR_FID) && dirid) {
 		/*
@@ -848,22 +846,69 @@ static struct fanotify_event *fanotify_alloc_event(
 	if (fanotify_is_fs_perm_event(group, mask)) {
 		event = fanotify_alloc_perm_event(data, data_type, gfp);
 	} else if (fs_error) {
-		event = fanotify_alloc_error_event(group, fsid, fs_error, &hash);
+		event = fanotify_alloc_error_event(group, fsid, fs_error, hash);
 	} else if (name_event && (file_name || moved || child)) {
 		event = fanotify_alloc_name_event(dirid, fsid, file_name, child,
-						  moved, &hash, gfp);
+						  moved, hash, gfp);
 	} else if (fid_mode) {
-		event = fanotify_alloc_fid_event(id, fsid, &hash, gfp);
+		event = fanotify_alloc_fid_event(id, fsid, hash, gfp);
 	} else if (path) {
-		event = fanotify_alloc_path_event(path, &hash, gfp);
-	} else if (mnt_id) {
+		event = fanotify_alloc_path_event(path, hash, gfp);
+	} else {
+		WARN_ON_ONCE(1);
+	}
+
+	set_active_memcg(old_memcg);
+	return event;
+}
+
+static struct fanotify_event *fanotify_alloc_ns_watcher_event(
+				struct fsnotify_group *group, u64 mask,
+				const void *data, int data_type)
+{
+	u64 mnt_id = fsnotify_data_mnt_id(data, data_type);
+	struct mem_cgroup *old_memcg;
+	struct fanotify_event *event = NULL;
+	gfp_t gfp = GFP_KERNEL_ACCOUNT;
+
+	if (group->max_events == UINT_MAX)
+		gfp |= __GFP_NOFAIL;
+	else
+		gfp |= __GFP_RETRY_MAYFAIL;
+
+	old_memcg = set_active_memcg(group->memcg);
+
+	if (mnt_id) {
 		event = fanotify_alloc_mnt_event(mnt_id, gfp);
 	} else {
 		WARN_ON_ONCE(1);
 	}
 
+	set_active_memcg(old_memcg);
+	return event;
+}
+
+static struct fanotify_event *fanotify_alloc_event(
+				struct fsnotify_group *group, u64 mask,
+				const void *data, int data_type,
+				struct inode *dir, const struct qstr *name,
+				__kernel_fsid_t *fsid, u32 match_mask)
+{
+	struct fanotify_event *event;
+	unsigned int hash = 0;
+	bool ondir = mask & FAN_ONDIR;
+	struct pid *pid;
+
+	if (fsnotify_is_ns_watcher(group)) {
+		event = fanotify_alloc_ns_watcher_event(group, mask, data,
+							data_type);
+	} else {
+		event = fanotify_alloc_fs_watcher_event(group, mask, data,
+						data_type, dir, name, fsid,
+						match_mask, &hash);
+	}
 	if (!event)
-		goto out;
+		return NULL;
 
 	if (FAN_GROUP_FLAG(group, FAN_REPORT_TID))
 		pid = get_pid(task_pid(current));
@@ -875,8 +920,6 @@ static struct fanotify_event *fanotify_alloc_event(
 	fanotify_init_event(event, hash, mask);
 	event->pid = pid;
 
-out:
-	set_active_memcg(old_memcg);
 	return event;
 }
 
@@ -966,8 +1009,8 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	if (!mask)
 		return 0;
 
-	pr_debug("%s: group=%p mask=%x report_mask=%x\n", __func__,
-		 group, mask, match_mask);
+	pr_debug("%s: group=%p type=%d mask=%x report_mask=%x\n", __func__,
+		 group, group->type, mask, match_mask);
 
 	bool is_perm = fanotify_is_fs_perm_event(group, mask);
 	if (is_perm) {
-- 
2.54.0

