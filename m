Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BF237C119
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 14:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074974; cv=none; b=ToMF/u60mGY22nTmFJbVWzXgeOvPJGcl3eu1Dc1ybwss03MCI5b7kLWdIG1udEJjHHxnc0vf7oLmD0V9k0q68IKHV2FPFGGFIIlsKmpr58xcYJDg3L5AFz4T21uHQ9fWuSt4jZcMuW0fjw/YDHMSZkA4D3a3sGYm/gF4bo+R668=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074974; c=relaxed/simple;
	bh=rg23894WPQLkFfP6+h8aNrMivkaj6GY5tnsXcnbShqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCtcAz/fv+rzmNDBCi3jqAmQkkWI3BRI2epUm/1gmrUMPh5tkK+i8eYe+Qg5P2jLQtxipMtYbsOL2TOK87DiZOyoS8Ne4i8/aeRTZjs42fR/WyogMBkXm/zjZcpIWQXhT6ShNwPcyg/evNjyLJEXXK82m43J/D7B3Lt3Y8N4KDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cscGWoES; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cscGWoES"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c2e43f3d1fdso333112766b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 07:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792074970; x=1792679770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aS8O+9F3WQHCN+M3Yr7u/JoD8caaFJYkp7p7oNxSLXg=;
        b=cscGWoESnDt5s/6xVY3wM4UzQfl9gwg55FT+9tdqs8h5jTsGsqqykNnH2DURCXHAas
         BC7QhsOWzwhfO1xbrjrmjz2kysL8jggQtFP0Q1264389pohRVyo942gLwQljd1Hf7NSg
         VDNl0eZ6kN489D58B6aZkN5UIFxpRfuhDQesBXcsCdKhwpoplZHEIMQrZ7rZeGDdAr4v
         si0WPBRSal5v71Ch6gSbk+0tsEL1G2Pn93qXZdTPZozEgyHO1oZk/PF3NAFGuyqKyapm
         UgZrvdiFdOUPs5zAcmPbfuzOuljmWvR/IzWkgVcE4hFmQKv48fDsBgQHV7wtzoiOV7me
         rV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792074970; x=1792679770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aS8O+9F3WQHCN+M3Yr7u/JoD8caaFJYkp7p7oNxSLXg=;
        b=MdN201AWJu++LIIQwVbLTqWOqkcrGWN0ckYkpoIjYiVUIvISMX5YZoLyMdyW46VZIW
         6BgUHLVbyTKxZHuCFg6SQgXbcCKXUgmzHokG8TVML9ZfaLXC5uCZnHm3/gCZrKReetpJ
         r0A5xuiWij7hNgAf2U75bwD1uIPsGhiG87Bogm0RFCaNzLnNQHZJsiecGHS5QLlVky5B
         e9WJpzdaCGfWCahVBRbdnpAmJJ/TUYD0s90f+Mv2sd6vU0l1INARBDrwrPpFj/GEENZe
         hn010e2vPQ9nLIu5RhU5RYdOS51vwW+mOAoEpZgDdXZE6n2o54nkV4Dn5lwRPqwIs1BG
         6hZg==
X-Forwarded-Encrypted: i=1; AKwUvBxDfre6duoHIQO2RKMSCdJ1JNvDx04hcWsaxZNrBP6ZSuJhtm5k98+fiFnAIOM2Xx5I8gjiSV9W98lJyCil@vger.kernel.org
X-Gm-Message-State: AFq9FYKFhnbqQPokJ8V8ojo13qhzxNh6HNgp0sUlTj94WC98YbjKRfM6
	3ydYPF1wmp4qLzCadEy5uqknVGGs5Cq9Op5rq2qdzQSp5bYnYlfyIneYfO8xitun
X-Gm-Gg: AYBFou2U1/UonPv3TN7MWhxFT3wSgOX+bPiTUWYJqykCnheSVSNuIcKJmw7lFv9G+RL
	4uNBUGeqgBvTK2C3T1wos/r7B5Za4HnfNqJN3nvn1jpENaEpy3uvGzQh0nFYnnHZudFYagM2vDF
	s//teaLFuNVTaFNvToR7XCnoktdec+Zu4bNTNkCcVmTCmGEYQhX7xb9H1jBM9KSbKzdojZ9S1Af
	z6A/THtSZlFrFPVt78hYQoZq4nI5oWpLgvbuT5YCKKY1di0poJl94Gp5QohuZQZPjduafRAFXCM
	hCNPjUAQUbrtYtdOZNQW/3pTLKczFS1mQjGZ2eRT/q6VMjQWZLgSea8MC/QaWnZGz2C6wI5T4c8
	SrF+t9raGFInBgRvHZ3aTJ87iSw7vK3yhCMdCBptiS3ajYjw3wBH+j78JzA47ffRtUEBlw5Inb9
	aRbHaNEZawTfiCbToUKXlfJPyxII+UvYuyzLju3pwmb+JibD4OJESBOHVcuVUY5l367n+0ez5ga
	mBvU3Neki2OI5vr6cmnw7Tp
X-Received: by 2002:a17:907:3d0d:b0:c2d:ca32:217a with SMTP id a640c23a62f3a-c31aa07c3a1mr1793865966b.33.1792074969765;
        Thu, 15 Oct 2026 07:36:09 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3ed963d7casm131482266b.24.2026.10.15.07.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:36:09 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 06/14] fanotify: gate filesystem event classification by group type
Date: Thu, 15 Oct 2026 16:35:52 +0200
Message-ID: <20261015143601.2095784-7-amir73il@gmail.com>
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

fanotify decides on how to allocate events based on the event mask.
The event mask bits that correspond to filesystem watchers are only
meaningful in the context of filesystem group type.

Hence, before checking if event is a specific filesystem event (e.g.
FS_RENAME) need to first check the group type is filesystem.

Separate fanotify_alloc_event() into an allocator per group type, so
that all the filesystem event checks inside
fanotify_alloc_filesystem_watcher_event() are already properly gated.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c | 88 ++++++++++++++++++++++++-----------
 1 file changed, 60 insertions(+), 28 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 9dc39b16a41a7..35b87a7cc6129 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -745,14 +745,14 @@ static struct fanotify_event *fanotify_alloc_error_event(
 	return &fee->fae;
 }
 
-static struct fanotify_event *fanotify_alloc_event(
+static struct fanotify_event *fanotify_alloc_filesystem_watcher_event(
 				struct fsnotify_group *group,
 				u32 mask, const void *data, int data_type,
 				struct inode *dir, const struct qstr *file_name,
-				__kernel_fsid_t *fsid, u32 match_mask)
+				__kernel_fsid_t *fsid, u32 match_mask,
+				unsigned int *hash, gfp_t gfp)
 {
 	struct fanotify_event *event = NULL;
-	gfp_t gfp = GFP_KERNEL_ACCOUNT;
 	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
 	struct inode *id = fanotify_fid_inode(mask, data, data_type, dir,
 					      fid_mode);
@@ -760,14 +760,10 @@ static struct fanotify_event *fanotify_alloc_event(
 	const struct path *path = fsnotify_data_path(data, data_type);
 	struct fs_error_report *fs_error =
 		fsnotify_data_error_report(data, data_type);
-	u64 mnt_id = fsnotify_data_mnt_id(data, data_type);
-	struct mem_cgroup *old_memcg;
 	struct dentry *moved = NULL;
 	struct inode *child = NULL;
 	bool name_event = false;
-	unsigned int hash = 0;
 	bool ondir = mask & FAN_ONDIR;
-	struct pid *pid;
 
 	if ((fid_mode & FAN_REPORT_DIR_FID) && dirid) {
 		/*
@@ -832,6 +828,54 @@ static struct fanotify_event *fanotify_alloc_event(
 		}
 	}
 
+	if (IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS) &&
+	    mask & FANOTIFY_PERM_EVENTS) {
+		event = fanotify_alloc_perm_event(data, data_type, gfp);
+	} else if (fs_error) {
+		event = fanotify_alloc_error_event(group, fsid, fs_error,
+						   hash);
+	} else if (name_event && (file_name || moved || child)) {
+		event = fanotify_alloc_name_event(dirid, fsid, file_name, child,
+						  moved, hash, gfp);
+	} else if (fid_mode) {
+		event = fanotify_alloc_fid_event(id, fsid, hash, gfp);
+	} else if (path) {
+		event = fanotify_alloc_path_event(path, hash, gfp);
+	} else {
+		WARN_ON_ONCE(1);
+	}
+
+	return event;
+}
+
+static struct fanotify_event *fanotify_alloc_namespace_watcher_event(
+				struct fsnotify_group *group, u64 mask,
+				const void *data, int data_type, gfp_t gfp)
+{
+	u64 mnt_id = fsnotify_data_mnt_id(data, data_type);
+	struct fanotify_event *event = NULL;
+
+	if (mnt_id)
+		event = fanotify_alloc_mnt_event(mnt_id, gfp);
+	else
+		WARN_ON_ONCE(1);
+
+	return event;
+}
+
+static struct fanotify_event *fanotify_alloc_event(
+				struct fsnotify_group *group, u64 mask,
+				const void *data, int data_type,
+				struct inode *dir, const struct qstr *name,
+				__kernel_fsid_t *fsid, u32 match_mask)
+{
+	struct fanotify_event *event = NULL;
+	gfp_t gfp = GFP_KERNEL_ACCOUNT;
+	struct mem_cgroup *old_memcg;
+	unsigned int hash = 0;
+	bool ondir = mask & FAN_ONDIR;
+	struct pid *pid;
+
 	/*
 	 * For queues with unlimited length lost events are not expected and
 	 * can possibly have security implications. Avoid losing events when
@@ -855,25 +899,13 @@ static struct fanotify_event *fanotify_alloc_event(
 	    pidfs_register_pid_gfp(pid, gfp))
 		goto out;
 
-	if (IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS) &&
-	    mask & FANOTIFY_PERM_EVENTS) {
-		event = fanotify_alloc_perm_event(data, data_type, gfp);
-	} else if (fs_error) {
-		event = fanotify_alloc_error_event(group, fsid, fs_error,
-						   &hash);
-	} else if (name_event && (file_name || moved || child)) {
-		event = fanotify_alloc_name_event(dirid, fsid, file_name, child,
-						  moved, &hash, gfp);
-	} else if (fid_mode) {
-		event = fanotify_alloc_fid_event(id, fsid, &hash, gfp);
-	} else if (path) {
-		event = fanotify_alloc_path_event(path, &hash, gfp);
-	} else if (mnt_id) {
-		event = fanotify_alloc_mnt_event(mnt_id, gfp);
-	} else {
-		WARN_ON_ONCE(1);
-	}
-
+	if (fsnotify_is_namespace_watcher(group))
+		event = fanotify_alloc_namespace_watcher_event(group, mask,
+							data, data_type, gfp);
+	else
+		event = fanotify_alloc_filesystem_watcher_event(group, mask,
+						data, data_type, dir, name,
+						fsid, match_mask, &hash, gfp);
 	if (!event)
 		goto out;
 
@@ -975,8 +1007,8 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	if (!mask)
 		return 0;
 
-	pr_debug("%s: group=%p mask=%x report_mask=%x\n", __func__,
-		 group, mask, match_mask);
+	pr_debug("%s: group=%p type=%d mask=%x report_mask=%x\n", __func__,
+		 group, group->type, mask, match_mask);
 
 	if (is_perm_event) {
 		/*
-- 
2.55.0

