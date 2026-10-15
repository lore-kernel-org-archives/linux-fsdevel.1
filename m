Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD3F30D3FE
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 14:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074979; cv=none; b=Y7uaLdsCuqWbCoIpqV6KYRZxbY0/h1rHJk5bZOWaYBCf8FGGJivogZsG9ruQlk5NIQEiFK3qaHHmvL9EadTG8xkrutejcOkFRBdGRDpD2fjQOReMYrURmr8vcRN4HV7jTRzKfuWgbzFUcy/+8/EgBT3U/Rf9ZoAHIH3nCD/At8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074979; c=relaxed/simple;
	bh=QpfE0WLOENmPGyRKULoEOjXorM0nSe/kycvbzUNucVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=br3cRk08ApH+cRK0ePNFsWHB29to3pmJYQWmNzAOxwn/drxFGk7p+L2xsQoJhdfHqM814UC08BEGWYWn93IlpOZ0kOtfyR2K3CT4atkkrlndcoqnkvCBDxjuj/6JqRT+w9M5QM0pvY/g/RhYJ3B3SIiw5e0ivrhDjm+XegFnXNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oZxiwaQL; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZxiwaQL"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2e4df2e26fso734236766b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 07:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792074969; x=1792679769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6PuhYgD9BT3SeHZeBzmweyiW/4dTC9SsB2Xn0mH6ocA=;
        b=oZxiwaQL4e0HY5mZZSfyt4tDY/ngCWEZUNQ/gQMvSOsYUgmiHy3INAH39UFFdCr6d7
         EirC1Fqtv/5CZsbu+SWGT91p7wQB6SglWN8Are4fxiA5e//mCp/4fIuZCpd7cKa3CA1O
         fQ1ytTVj9vYLYNG+hWBPi4w5ePe7Tn+xUnTWvbh4dtrG+dBDmni93wOdvVIbcsHdHJnK
         9JlZuvLSddAfBofy/HSmnCY3tXdEGpnng4hjcAWR4pAag6mztsOolM5M3CprskcCpNGM
         ecjdbyfC90VttTxkCFbm4CY3n7rJDlWVXPQsVyAv8Jy8CTB7hZVZmLnwMbOeaCwEX1QA
         SZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792074969; x=1792679769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6PuhYgD9BT3SeHZeBzmweyiW/4dTC9SsB2Xn0mH6ocA=;
        b=d2Th+c4RYqrroujIalwhy799WUGnqdGrYlrKwpcwzJjvbhuSYfgRXVwoe2gUicCbuE
         V2QhzAj0qtGWET9xR4V9pH2VfLzRkWlXz5V6h0hUUet2y0EgjhsbfUw9LCmt70SCZ4xG
         s4kNe5OAJMi4iuVIxGzkHCT4EUdtGTMedLfq9P31oRU3KYCxAhaOwIcK5pahzRCZglmM
         ONhawaZx296cpsUznk4kFdTcEbMpPYlDkqwhx7rjEflrfMNyRqDBgpFVDSrVeI1GXiVs
         jZRDZJKaHs0uEv3f76xd0kRWK3pwlMEqe3kj8t2PPpPuqADvzQFCjTEntl+LbaJ8knRQ
         pTdA==
X-Forwarded-Encrypted: i=1; AKwUvBxcgre0r06jlYKjAWmy6rJjkQBmfG5J97fZkeSFbyK/0TXqdTB6qaVZBR+FUSwJ00ypeA2flg38b4G5DIQs@vger.kernel.org
X-Gm-Message-State: AFq9FYIGHuUGHR7UQcYydvE2/cRKRG3yDoJRx09Z67cYnqHGNx0cDPnn
	flgBmK5uwa5Wq06RWl4p7nBumsYVDOLexec6g8/Z9YrcNv1LNxMcWqoEktP7J2xc
X-Gm-Gg: AYBFou0XEcJhurRcUoqp6/XOyg2rXulDVYfPUJakfWQ7Eg44v5uNlvfYKrpjYU7654r
	cIOE52BXz2H418je1rFxs7UcCJtaFOwriAX3Kxv+1KKflsmiTxw4uYiE4WtISgGsnC3SFXSzL+d
	8DI9r0etqdHSQrphMcfzkYs7VqtOLLQ4xU+ciZjmRf9XzDqBaRlsOSa0CfMi8J+dyMrePAtONSy
	p8g6Mgu0+n2lmpJkMpVYTEFk+H+g+rxv+MpWMzjmF2m2fOYtTQP0oO9D9f78I7rYAVqT5ImW8vw
	FmWpuZna3TPlHsiXo0OurpVBrWzL9toAnlHwTn5AO4qhl+E7+Lmt8K1l5Rs4wNagIRryHy2KElm
	CwpNmhZJOK79Huromtezx63g226wPPerzta5LDLoat5n0VjJxmxNHmtWf/ziOPsFP/iXHPw+k4x
	usUvHyURveQ1LWq4GS8eSewWfIvpTrsN+iDJd/nPkvfyzjerMkm9qY+FTF8wQv0UuxiNFJU7X9d
	CygEkb2Wmclq1TuizLmOSjZtB8Lakm16vI/
X-Received: by 2002:a17:907:9801:b0:c29:4fcb:2886 with SMTP id a640c23a62f3a-c31a9fd831emr1787652566b.39.1792074968699;
        Thu, 15 Oct 2026 07:36:08 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3ed6be6f15sm134824866b.10.2026.10.15.07.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:36:08 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 05/14] fsnotify: do not report mount events with fsnotify()
Date: Thu, 15 Oct 2026 16:35:51 +0200
Message-ID: <20261015143601.2095784-6-amir73il@gmail.com>
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

fsnotify() is now used to report events to both filesystem watchers and
namespace watchers, but those two distinct event categories can never
be sent to the same group.

Split out send_to_namespace_groups(), which only looks for interested
mntns object marks, from fsnotify(), which only looks for interested
filesystem object marks, and let fsnotify_mnt() call it.

The intention is that send_to_namespace_groups() will also be used to
report namespace events to watchers of a userns object.

Gate the common code that is checking filesystem events with a filesystem
group type check.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fsnotify.c | 92 +++++++++++++++++++++++++++++++-------------
 1 file changed, 66 insertions(+), 26 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index a919a1e9bb192..b26560a017862 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -333,7 +333,8 @@ static int fsnotify_handle_event(struct fsnotify_group *group, __u32 mask,
 
 static int send_to_group(__u32 mask, const void *data, int data_type,
 			 struct inode *dir, const struct qstr *file_name,
-			 u32 cookie, struct fsnotify_iter_info *iter_info)
+			 u32 cookie, struct fsnotify_iter_info *iter_info,
+			 enum fsnotify_group_type group_type)
 {
 	struct fsnotify_group *group = NULL;
 	__u32 test_mask = (mask & ALL_FSNOTIFY_EVENTS);
@@ -347,7 +348,7 @@ static int send_to_group(__u32 mask, const void *data, int data_type,
 		return 0;
 
 	/* clear ignored on inode modification */
-	if (mask & FS_MODIFY) {
+	if (group_type == FSNOTIFY_GROUP_TYPE_FILESYSTEM && mask & FS_MODIFY) {
 		fsnotify_foreach_iter_mark_type(iter_info, mark, type) {
 			if (!(mark->flags &
 			      FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY))
@@ -363,9 +364,12 @@ static int send_to_group(__u32 mask, const void *data, int data_type,
 			fsnotify_effective_ignore_mask(mark, is_dir, type);
 	}
 
-	pr_debug("%s: group=%p mask=%x marks_mask=%x marks_ignore_mask=%x data=%p data_type=%d dir=%p cookie=%d\n",
-		 __func__, group, mask, marks_mask, marks_ignore_mask,
-		 data, data_type, dir, cookie);
+	pr_debug("%s: group=%p type=%d mask=%x marks_mask=%x marks_ignore_mask=%x data=%p data_type=%d dir=%p cookie=%d\n",
+		 __func__, group, group_type, mask, marks_mask,
+		 marks_ignore_mask, data, data_type, dir, cookie);
+
+	if (WARN_ON_ONCE(group->type != group_type))
+		return 0;
 
 	if (!(test_mask & marks_mask & ~marks_ignore_mask))
 		return 0;
@@ -472,6 +476,26 @@ static void fsnotify_iter_next(struct fsnotify_iter_info *iter_info)
 	}
 }
 
+static int send_to_groups(__u32 mask, const void *data, int data_type,
+			  struct inode *dir, const struct qstr *file_name,
+			  u32 cookie, struct fsnotify_iter_info *iter_info,
+			  enum fsnotify_group_type group_type)
+{
+	int ret;
+
+	while (fsnotify_iter_select_report_types(iter_info)) {
+		ret = send_to_group(mask, data, data_type, dir, file_name,
+				    cookie, iter_info, group_type);
+
+		if (ret && group_type == FSNOTIFY_GROUP_TYPE_FILESYSTEM &&
+		    (mask & ALL_FSNOTIFY_PERM_EVENTS))
+			return ret;
+
+		fsnotify_iter_next(iter_info);
+	}
+	return 0;
+}
+
 /*
  * fsnotify - This is the main call to fsnotify.
  *
@@ -497,7 +521,6 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 {
 	const struct path *path = fsnotify_data_path(data, data_type);
 	struct super_block *sb = fsnotify_data_sb(data, data_type);
-	const struct fsnotify_mnt *mnt_data = fsnotify_data_mnt(data, data_type);
 	struct fsnotify_sb_info *sbinfo = sb ? fsnotify_sb_info(sb) : NULL;
 	struct fsnotify_iter_info iter_info = {};
 	struct mount *mnt = NULL;
@@ -540,8 +563,7 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 	if ((!sbinfo || !sbinfo->sb_marks) &&
 	    (!mnt || !mnt->mnt_fsnotify_marks) &&
 	    (!inode || !inode->i_fsnotify_marks) &&
-	    (!inode2 || !inode2->i_fsnotify_marks) &&
-	    (!mnt_data || !mnt_data->ns->n_fsnotify_marks))
+	    (!inode2 || !inode2->i_fsnotify_marks))
 		return 0;
 
 	if (sb)
@@ -552,8 +574,6 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 		marks_mask |= READ_ONCE(inode->i_fsnotify_mask);
 	if (inode2)
 		marks_mask |= READ_ONCE(inode2->i_fsnotify_mask);
-	if (mnt_data)
-		marks_mask |= READ_ONCE(mnt_data->ns->n_fsnotify_mask);
 
 	/*
 	 * If this is a modify event we may need to clear some ignore masks.
@@ -561,7 +581,7 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 	 * event in its mask.
 	 * Otherwise, return if none of the marks care about this type of event.
 	 */
-	test_mask = (mask & ALL_FSNOTIFY_EVENTS);
+	test_mask = (mask & FSNOTIFY_EVENTS_ON_FILESYSTEM);
 	if (!(test_mask & marks_mask))
 		return 0;
 
@@ -583,27 +603,16 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 		iter_info.marks[inode2_type] =
 			fsnotify_first_mark(&inode2->i_fsnotify_marks);
 	}
-	if (mnt_data) {
-		iter_info.marks[FSNOTIFY_ITER_TYPE_MNTNS] =
-			fsnotify_first_mark(&mnt_data->ns->n_fsnotify_marks);
-	}
 
 	/*
 	 * We need to merge inode/vfsmount/sb mark lists so that e.g. inode mark
 	 * ignore masks are properly reflected for mount/sb mark notifications.
 	 * That's why this traversal is so complicated...
 	 */
-	while (fsnotify_iter_select_report_types(&iter_info)) {
-		ret = send_to_group(mask, data, data_type, dir, file_name,
-				    cookie, &iter_info);
-
-		if (ret && (mask & ALL_FSNOTIFY_PERM_EVENTS))
-			goto out;
+	ret = send_to_groups(mask, data, data_type, dir, file_name,
+			     cookie, &iter_info,
+			     FSNOTIFY_GROUP_TYPE_FILESYSTEM);
 
-		fsnotify_iter_next(&iter_info);
-	}
-	ret = 0;
-out:
 	srcu_read_unlock(&fsnotify_mark_srcu, iter_info.srcu_idx);
 
 	return ret;
@@ -696,6 +705,37 @@ int fsnotify_open_perm_and_set_mode(struct file *file)
 }
 #endif
 
+static int send_to_namespace_groups(__u32 mask, const void *data,
+				    int data_type)
+{
+	const struct fsnotify_mnt *mnt_data =
+		fsnotify_data_mnt(data, data_type);
+	struct fsnotify_iter_info iter_info = {};
+	__u32 test_mask, marks_mask = 0;
+	int ret;
+
+	if (mnt_data)
+		marks_mask |= READ_ONCE(mnt_data->ns->n_fsnotify_mask);
+
+	test_mask = mask & FSNOTIFY_EVENTS_ON_NAMESPACE;
+	if (!(test_mask & marks_mask))
+		return 0;
+
+	iter_info.srcu_idx = srcu_read_lock(&fsnotify_mark_srcu);
+
+	if (mnt_data) {
+		iter_info.marks[FSNOTIFY_ITER_TYPE_MNTNS] =
+			fsnotify_first_mark(&mnt_data->ns->n_fsnotify_marks);
+	}
+
+	ret = send_to_groups(mask, data, data_type, NULL, NULL, 0, &iter_info,
+			     FSNOTIFY_GROUP_TYPE_NAMESPACE);
+
+	srcu_read_unlock(&fsnotify_mark_srcu, iter_info.srcu_idx);
+
+	return ret;
+}
+
 void fsnotify_mnt(__u32 mask, struct mnt_namespace *ns, struct vfsmount *mnt)
 {
 	struct fsnotify_mnt data = {
@@ -713,7 +753,7 @@ void fsnotify_mnt(__u32 mask, struct mnt_namespace *ns, struct vfsmount *mnt)
 	if (!ns->n_fsnotify_marks)
 		return;
 
-	fsnotify(mask, &data, FSNOTIFY_EVENT_MNT, NULL, NULL, NULL, 0);
+	send_to_namespace_groups(mask, &data, FSNOTIFY_EVENT_MNT);
 }
 
 static __init int fsnotify_init(void)
-- 
2.55.0

