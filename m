Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378723D75DE
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 17:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050314; cv=none; b=YLZw10uDCh4pbelnpUWGyBkb+BqvBd47B3WUngz23M5CJQ0CtQmwjsTCcen4/mleMbKt/1V56z1IaEzk6dkuPkUGrzRJKmTiBWGdOY+wCw1IxSBLWw2gbLsn+LawCye3uYnyOZcaRmlCVWCMinhaLcIh45oRyamKCmNzzka0TS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050314; c=relaxed/simple;
	bh=RRAHIGuOZmtQulinGjbgzjsPdNioY9rbozRyV2+mOjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Al0Ns8ozne7MYBiixQZw50jz7fxbYcDGrZBVZFekxqtoe26abougNyqnAmo1bGG6l636jsFWJTraQlHot0BKebjzlfUdtX+yurtV6D5IqcwzbTepJLpzp4OYWuQ3nyALAfSNTgC8D3eHSM7yspp9Uj6Qpw6QWxKlJuYarXr65B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elKy07S0; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elKy07S0"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-67845996252so4230960a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 10:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777050311; x=1777655111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2IjoyJdZhV7Z3NSgjwKFe6OdGtVR3eGK36r4qTm2fo=;
        b=elKy07S0LZ0M0ZGCI/fzzHt52xl3W3UKSt6+0eNTRRqyoHY044qU00Y6FPQ9xlLHmn
         3McodwvbS9cjw6DVaZAx5MHq7wWPfpbK8yY8cmJ4JDLVM7kiZdNEBUxgtWNXu6Sr18KX
         suXLMPaJX1nMFmuakKIQrcj1ng0b18wMGgb4tW/gNhFKtP1qVEpsww0GzqMYi8heExdG
         ut206iw8AT26LqgscYCND3oiV7wrQ2H6zqBFMAPfeGsKik1RLdbF+XAAo8pdYwffaBuW
         WmL+zPCm8H/R0mQ6ZhCRRiOcHCnF6H9D1Uj0OQnmUrSEUdWuPDKb2z6AagwRPKIS7iVr
         fw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777050311; x=1777655111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r2IjoyJdZhV7Z3NSgjwKFe6OdGtVR3eGK36r4qTm2fo=;
        b=CrCR6Dcd2wtb2UQ0GK4PpT2g2egmQ+6aCtSxcsdGvi99gKbBGbD5w6T4WbHggVfOOR
         R66JEIKcE0Xen7NzLd0OSoH+YpyR0MnNCc16Wfd6XMI87whHP9ps4NKfNIBn/rAsdJHr
         yYBsdDD9996fHhSYCleIaPhf+sNuFBYl7DIWvy6LMOfvcCa4kIUeTvUvdF0pqnOA9UGM
         V9098A6MAkd5IZIQQKFeNU4W4iFosVLZn+nbuZJECgdBtWrs2NGfWGiAPD8DDyukIFkt
         IoOylt3dUVQWgmfhlXV7EBXWvQQhy5lt+JW6HO1m4X2m6H9mZz0gEWyBKoQfabdeTju/
         9EWw==
X-Forwarded-Encrypted: i=1; AFNElJ+5QG/hR2kxZNz4ydYoYDe/J2k4Ro4EWIsAlY8VoZLUp6kDlyAieeC6PU3pBP41rPGYUGpJju1pvPoanlGp@vger.kernel.org
X-Gm-Message-State: AOJu0YzqnByEqdZWHGjsAqDIiWBFy2t4FDIneeFwDRgDl/Z9al6LCjqq
	oCt0Yc0Jy1QHOl79JY64ck6iCtzR+FR+IJ2S1X7REh+Pf9XYKussUxSivdoL2e2XZG8=
X-Gm-Gg: AeBDieskIagLWqCgkP9aiXbrgDms1VFJywgyCetqxgrSNXUNW2KL/xLO7D++Qx/HfYv
	RZ3UlAmFN+VQLGMvRFB1kpGG9maglL3TKzia/7hLYIOdsLr7cYAyeRxxvEBd2I3ujxUNpSKRSCX
	gG8o8m2gd0VVeah/k3KUGKzVNPWn8Osa/bHDcfJiN/Ac7HOCa1WF1h0uyZVzqmQuYePOEUelKCS
	tMrIMtqXGlhnw/4A4VxrwL/d6N/R9gXg2v26WG/CfLUgtMM3t8MeKrLOM7bdi1CN1SDxVidRdi4
	MVHtaXyxD0rv6agHzgK7kmDeuSrYS3A7fZrWwD5Hh2LiNO8QeLx8UyV9V/5lRNdUcpoG6+VtfTW
	1xQnIzNiMAugPhMWQuG3Gqc4igGzlZmONzyCsVVxHCdF+h/m1BDU/vttER7n1SBC/nzaxmxuLR6
	2cd+ZYIhmKJARxAzu4N9b/z23PK+tCMp31JMhczMkD0ek/qmr1fGAsUnciGPaH5Rwp3EhUuxSI/
	tz5zkRzTWFLX5tBwB6n/EBbViurpHQcHhyrmu0=
X-Received: by 2002:a17:907:3c90:b0:bac:7f7d:2bf8 with SMTP id a640c23a62f3a-bac7f7d3864mr467972766b.0.1777050311072;
        Fri, 24 Apr 2026 10:05:11 -0700 (PDT)
Received: from localhost (2001-1c00-570d-ee00-4aab-734a-1928-df3f.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:4aab:734a:1928:df3f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba538429115sm755122966b.15.2026.04.24.10.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 10:05:10 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 05/10] fsnotify: do not report mount events with fsnotify()
Date: Fri, 24 Apr 2026 19:04:58 +0200
Message-ID: <20260424170503.2096847-6-amir73il@gmail.com>
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

fsnotify() is now used to report events to both filesystem watchers and
(mnt) namepsace watchers, but those two distinct event categories can
never be sent to the same group.

Split out send_to_ns_groups() which only looks for interested mntns object
marks from fsnotify() which only looks for interested filesystem object
marks and let fsnotify_mnt() call send_to_ns_groups().

The intention is that send_to_ns_groups() will also be used to report
namespace events to watchers of userns object.

Gate the common code that is checking fs events with filesystem
group type check.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fsnotify.c | 87 +++++++++++++++++++++++++++++++-------------
 1 file changed, 62 insertions(+), 25 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 429ce614233ce..db79f51d8109c 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -330,7 +330,8 @@ static int fsnotify_handle_event(struct fsnotify_group *group, __u32 mask,
 
 static int send_to_group(__u32 mask, const void *data, int data_type,
 			 struct inode *dir, const struct qstr *file_name,
-			 u32 cookie, struct fsnotify_iter_info *iter_info)
+			 u32 cookie, struct fsnotify_iter_info *iter_info,
+			 enum fsnotify_group_type group_type)
 {
 	struct fsnotify_group *group = NULL;
 	__u32 test_mask = (mask & ALL_FSNOTIFY_EVENTS);
@@ -344,7 +345,7 @@ static int send_to_group(__u32 mask, const void *data, int data_type,
 		return 0;
 
 	/* clear ignored on inode modification */
-	if (mask & FS_MODIFY) {
+	if (group_type ==  FSNOTIFY_GROUP_TYPE_FS && mask & FS_MODIFY) {
 		fsnotify_foreach_iter_mark_type(iter_info, mark, type) {
 			if (!(mark->flags &
 			      FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY))
@@ -360,10 +361,13 @@ static int send_to_group(__u32 mask, const void *data, int data_type,
 			fsnotify_effective_ignore_mask(mark, is_dir, type);
 	}
 
-	pr_debug("%s: group=%p mask=%x marks_mask=%x marks_ignore_mask=%x data=%p data_type=%d dir=%p cookie=%d\n",
-		 __func__, group, mask, marks_mask, marks_ignore_mask,
+	pr_debug("%s: group=%p type=%d mask=%x marks_mask=%x marks_ignore_mask=%x data=%p data_type=%d dir=%p cookie=%d\n",
+		 __func__, group, group_type, mask, marks_mask, marks_ignore_mask,
 		 data, data_type, dir, cookie);
 
+	if (WARN_ON_ONCE(group->type != group_type))
+		return 0;
+
 	if (!(test_mask & marks_mask & ~marks_ignore_mask))
 		return 0;
 
@@ -469,6 +473,26 @@ static void fsnotify_iter_next(struct fsnotify_iter_info *iter_info)
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
+		if (ret && group_type == FSNOTIFY_GROUP_TYPE_FS &&
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
@@ -494,7 +518,6 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 {
 	const struct path *path = fsnotify_data_path(data, data_type);
 	struct super_block *sb = fsnotify_data_sb(data, data_type);
-	const struct fsnotify_mnt *mnt_data = fsnotify_data_mnt(data, data_type);
 	struct fsnotify_sb_info *sbinfo = sb ? fsnotify_sb_info(sb) : NULL;
 	struct fsnotify_iter_info iter_info = {};
 	struct mount *mnt = NULL;
@@ -535,8 +558,7 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 	if ((!sbinfo || !sbinfo->sb_marks) &&
 	    (!mnt || !mnt->mnt_fsnotify_marks) &&
 	    (!inode || !inode->i_fsnotify_marks) &&
-	    (!inode2 || !inode2->i_fsnotify_marks) &&
-	    (!mnt_data || !mnt_data->ns->n_fsnotify_marks))
+	    (!inode2 || !inode2->i_fsnotify_marks))
 		return 0;
 
 	if (sb)
@@ -547,8 +569,6 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 		marks_mask |= READ_ONCE(inode->i_fsnotify_mask);
 	if (inode2)
 		marks_mask |= READ_ONCE(inode2->i_fsnotify_mask);
-	if (mnt_data)
-		marks_mask |= READ_ONCE(mnt_data->ns->n_fsnotify_mask);
 
 	/*
 	 * If this is a modify event we may need to clear some ignore masks.
@@ -556,7 +576,7 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 	 * event in its mask.
 	 * Otherwise, return if none of the marks care about this type of event.
 	 */
-	test_mask = (mask & ALL_FSNOTIFY_EVENTS);
+	test_mask = (mask & FSNOTIFY_EVENTS_ON_FS);
 	if (!(test_mask & marks_mask))
 		return 0;
 
@@ -578,27 +598,15 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
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
+	ret = send_to_groups(mask, data, data_type, dir, file_name,
+			     cookie, &iter_info, FSNOTIFY_GROUP_TYPE_FS);
 
-		if (ret && (mask & ALL_FSNOTIFY_PERM_EVENTS))
-			goto out;
-
-		fsnotify_iter_next(&iter_info);
-	}
-	ret = 0;
-out:
 	srcu_read_unlock(&fsnotify_mark_srcu, iter_info.srcu_idx);
 
 	return ret;
@@ -691,6 +699,35 @@ int fsnotify_open_perm_and_set_mode(struct file *file)
 }
 #endif
 
+static int send_to_ns_groups(__u32 mask, const void *data, int data_type)
+{
+	const struct fsnotify_mnt *mnt_data = fsnotify_data_mnt(data, data_type);
+	struct fsnotify_iter_info iter_info = {};
+	__u32 test_mask, marks_mask = 0;
+	int ret;
+
+	if (mnt_data)
+		marks_mask |= READ_ONCE(mnt_data->ns->n_fsnotify_mask);
+
+	test_mask = mask & FSNOTIFY_EVENTS_ON_NS;
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
+			     FSNOTIFY_GROUP_TYPE_NS);
+
+	srcu_read_unlock(&fsnotify_mark_srcu, iter_info.srcu_idx);
+
+	return ret;
+}
+
 void fsnotify_mnt(__u32 mask, struct mnt_namespace *ns, struct vfsmount *mnt)
 {
 	struct fsnotify_mnt data = {
@@ -708,7 +745,7 @@ void fsnotify_mnt(__u32 mask, struct mnt_namespace *ns, struct vfsmount *mnt)
 	if (!ns->n_fsnotify_marks)
 		return;
 
-	fsnotify(mask, &data, FSNOTIFY_EVENT_MNT, NULL, NULL, NULL, 0);
+	send_to_ns_groups(mask, &data, FSNOTIFY_EVENT_MNT);
 }
 
 static __init int fsnotify_init(void)
-- 
2.54.0

