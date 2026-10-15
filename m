Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC8429DB64
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 14:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074975; cv=none; b=VvnQqbQBhCA9lqlnhWlQIse81H5J1Ky7Rp1LBdYkqg93VWA3RVy3fHui12UMz0Dw3jN4dP8CCthaI0tUYoG4LO38JrIOSXlYqvCq4yKnogyoMD4NXQ6yBxk7D+mGS9CnelEaCWCLQI/Owmdseqlf9F7uL+9dZyOz+RhAZEXKq64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074975; c=relaxed/simple;
	bh=LWsyBeuzKmc/1RY1y7fbt+JymFF3k9BmtZODv3Y4R7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mnBxEc3AMcVyaCAVDw+xEcZMy7C49PB/bTiHHMNdTZysZV7lN3oPR9bg7LyGfHm1F4FJ2qcoTi6D7P+DJoKs+dfnNH7VCV+piCdeqrkiQcgFGPIGohlZ+4QsgYdKecj/yBx6qMx/FvznE3SYp6hrhWvwjiPbjHKhbFTM4x0/Cq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qLUVLhWQ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qLUVLhWQ"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c20ce3c118aso7244766b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 07:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792074964; x=1792679764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=64KXVEcHFy/YGPoTuJAaz3brNMdBV6b6rUoToswpgr8=;
        b=qLUVLhWQXZGjQxbzDYM6tY1jVT2R/Dy30Q8sP6bvp1op70iQwHzXBFBVnpYGu0Cswd
         LHu1DxFbp8VEFTsU71r2UIisMotaVM6wQFNofeKhNAIx+xQ9GK17xG9NtS7TGkLWpJ1Q
         D4tMzzKAoeWyShI3hznuPQB8hpAe0UI0Xa3Ffsv8LSY363/zymr0G5VRaEoABbVa99tK
         xipXNFZLXJWfj/GhnPKiR2HOf3hT33rLWK7IeSRbUvdPE4NEmrNeRRmH56bjsfN7+A4P
         eH5m/hRHxrkzSdOLxXxhyrGz7Kd5F1uvAO9W78ZmgD7QXxLJMLutj2qEZT3YyVVKRF2H
         8ZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792074964; x=1792679764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=64KXVEcHFy/YGPoTuJAaz3brNMdBV6b6rUoToswpgr8=;
        b=N+EnM9M03s6Sr7rhtv9yL9a0nq6ntubs83RhzMiNjlgaB7LfWswru8Fo1ZsuNNnvjn
         VYgQdOH1c8Lf+uQ5kMLsU/od26OZlu10V2sszZeGEGz09or19KlNeRGNZpwjrunyX4/e
         QEEDqmfMR/NKtOuRRbcGF5RY7/dU85KX2Hf8/Ky1jUaBGqapXfcg11ROXZ3zhOA8YgRU
         DzxQE8dcQtOLztBptAMGDFN3ZBibwfoULPHfUNn6ofS/msiNT+EXPVlEwrIQqdv3xucc
         VBrYx1tLIry+aEWM2rESGapyNC/qCbY2HXkohocpbrlamOgFIbEasrx9z7N0igt5A0TL
         hqwg==
X-Forwarded-Encrypted: i=1; AKwUvBzAZzwVW8Q8XnPH+p6Qq8/wjNDZFxt+7/veto5kHUf5fqyZc9ynOSSsACxh082oDMfIj8uHbsDPo3kuofhf@vger.kernel.org
X-Gm-Message-State: AFq9FYKNrSoss4ZhuM/RXoDBNDKnCa7k6hLaPVb0CBswVfkrEqFDcG0v
	X+pnME2IteAgE1ZvpxYNICJuEnXzDzyYyk+8oxeuEvFuNidT14SL1TvM
X-Gm-Gg: AYBFou000PwaXYUJb04Bw5/kYf9FOj60B/M0mtoImPYm7hl+kAH3xUthokANm16UvVK
	Z74LtWKyxZvKB+7j0dHUYQ+jzXW975hxrkG1sbVaSvMlmmngb2d6s7HEi8h7Aj0fD64vVjpfLYK
	+xdID8OZIEv3TRTxKwZYwa635GEDC6TXe6Dm6uUM8+Fj7KbLgKXL+z5b9B+yavgT7mWGypFoft7
	/skoyRDm7PHdF6cnmrflahDoBA29kLzuxPLZejcr2a0YIT4XeSfqeB3zK4xZwpgJLuMlg5ACRrT
	Tc5mHyzhvfaGO9MZwWH47x0AStCcP4l03cUtwIHXIex1ggh0Xk26RXyVD2yx5koKdSMH1ZcJn1K
	Un4SyLIe6K0ijpf/ZC3LeDXsA/5tOvzgtHFRqE89tfzo+1FwOs3ZUGs9uDrOXifTK8iZ+Xj7Wpw
	CF8pxyCnsWb4UadImUBxE9GAwZXAS3zJlKw5lSucfhgoi752mXL9AluW9dWx0hGsy/G3eJIDMJM
	Jbk+VKUuBHu9FlE4t+4fYHqpQ==
X-Received: by 2002:a17:907:6c11:b0:c2e:2ef8:5584 with SMTP id a640c23a62f3a-c401ff193a4mr22942766b.14.1792074964009;
        Thu, 15 Oct 2026 07:36:04 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3eda03ee48sm136981866b.48.2026.10.15.07.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:36:03 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 01/14] fsnotify: rename fsnotify group flag macros
Date: Thu, 15 Oct 2026 16:35:47 +0200
Message-ID: <20261015143601.2095784-2-amir73il@gmail.com>
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

Use more explicit FSNOTIFY_GROUP_FLAG_ prefix.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 2 +-
 fs/notify/group.c                  | 4 ++--
 fs/notify/inotify/inotify_user.c   | 2 +-
 fs/notify/mark.c                   | 2 +-
 include/linux/fsnotify_backend.h   | 4 ++--
 kernel/audit_fsnotify.c            | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 63c9759fc3b06..22c6424c334a0 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1670,7 +1670,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 		f_flags |= O_NONBLOCK;
 
 	CLASS(fsnotify_group, group)(&fanotify_fsnotify_ops,
-				     FSNOTIFY_GROUP_USER);
+				     FSNOTIFY_GROUP_FLAG_USER);
 	/* fsnotify_alloc_group takes a ref.  Dropped in fanotify_release */
 	if (IS_ERR(group))
 		return PTR_ERR(group);
diff --git a/fs/notify/group.c b/fs/notify/group.c
index b56d1c1d9644a..cf445e270ba6a 100644
--- a/fs/notify/group.c
+++ b/fs/notify/group.c
@@ -145,8 +145,8 @@ static struct fsnotify_group *__fsnotify_alloc_group(
 struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops,
 					    int flags)
 {
-	gfp_t gfp = (flags & FSNOTIFY_GROUP_USER) ? GFP_KERNEL_ACCOUNT :
-						    GFP_KERNEL;
+	gfp_t gfp = (flags & FSNOTIFY_GROUP_FLAG_USER) ?
+		    GFP_KERNEL_ACCOUNT : GFP_KERNEL;
 
 	return __fsnotify_alloc_group(ops, flags, gfp);
 }
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 5f19c24ec187f..641485e3492eb 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -644,7 +644,7 @@ static struct fsnotify_group *inotify_new_group(unsigned int max_events)
 	struct inotify_event_info *oevent;
 
 	group = fsnotify_alloc_group(&inotify_fsnotify_ops,
-				     FSNOTIFY_GROUP_USER);
+				     FSNOTIFY_GROUP_FLAG_USER);
 	if (IS_ERR(group))
 		return group;
 
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index b2640d836a712..79f32a42f580a 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -937,7 +937,7 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark, void *obj,
 
 		if ((lmark->group == mark->group) &&
 		    (lmark->flags & FSNOTIFY_MARK_FLAG_ATTACHED) &&
-		    !(mark->group->flags & FSNOTIFY_GROUP_DUPS)) {
+		    !(mark->group->flags & FSNOTIFY_GROUP_FLAG_DUPS)) {
 			err = -EEXIST;
 			goto out_err;
 		}
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 618eed4d6d724..ad310de907819 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -232,8 +232,8 @@ struct fsnotify_group {
 	enum fsnotify_group_prio priority;	/* priority for sending events */
 	bool shutdown;		/* group is being shut down, don't queue more events */
 
-#define FSNOTIFY_GROUP_USER	0x01 /* user allocated group */
-#define FSNOTIFY_GROUP_DUPS	0x02 /* allow multiple marks per object */
+#define FSNOTIFY_GROUP_FLAG_USER	0x01 /* user allocated group */
+#define FSNOTIFY_GROUP_FLAG_DUPS	0x02 /* allow multiple marks per object */
 	int flags;
 	unsigned int owner_flags;	/* stored flags of mark_mutex owner */
 
diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index fa33d57e43207..162ebe992fb19 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -194,7 +194,7 @@ static const struct fsnotify_ops audit_mark_fsnotify_ops = {
 static int __init audit_fsnotify_init(void)
 {
 	audit_fsnotify_group = fsnotify_alloc_group(&audit_mark_fsnotify_ops,
-						    FSNOTIFY_GROUP_DUPS);
+						    FSNOTIFY_GROUP_FLAG_DUPS);
 	if (IS_ERR(audit_fsnotify_group)) {
 		audit_fsnotify_group = NULL;
 		audit_panic("cannot create audit fsnotify group");
-- 
2.55.0

