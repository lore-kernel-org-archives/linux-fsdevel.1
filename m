Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00171DF248
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074981; cv=none; b=oNc1Pr3DSTZFJbzVcV5itIzsm9Z/t4x5ns+VV1oUUBP3d1WR4pCAjJoFZXT4zVQb9ESE2kPmH1pKYckhGfZgWq5Ka1a488Kb2OSUbweuKonULJJjTjSzsviDbDeriqOtfJcdm54siGNXj7p9IiX6a9/lnmis//9mLrUIl83fuvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074981; c=relaxed/simple;
	bh=qKjZtqGjO5B9gHAowTKwpgcpb1HxcoZj6F0nr3EVmMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RhkNm+evkJkKdXjjP2e/edGEZk10uINl6XFTTgfJA0HxYxtRybff0aN4pYYfPptfR2JndlhIT8xTPssviPh8L1oVu+3b2ELstVhkFSwg7udf8ehv15ch4RSiHOtLuNFpj/HOYryCdEtmPgy65lnUpIstR4oF2ySN7wMOSFrREPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVkdBR+2; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVkdBR+2"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c169ae1cb26so2912366b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 07:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792074974; x=1792679774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s7Sxld5tsDLlrrSCe0t36DLRKimZjfW887iRc5DqTG0=;
        b=dVkdBR+2Wj+pqMbqPJhax5u5xZLlKZCRu9dilzXun7/trLnIBAIHDr8vmm6s/eYckS
         aorqSGK+psLYMTL7EkX4usfg3Ri7h0vK9xvHNUHnjb8ZcoFo8eLZgfXbgIs8fHpq9ApG
         IwrpEZmGN+h97GBvXehqvVdeWfnkb9mu4VhWJsV336kX3jiChZFgfBWe8m/jlcs+C7PI
         +sqa4/pjITePnjXfVMG3fpyv8g+rc+lgjTcVbLwt/Ary3aviOs1mzZX193ENzFKZwHZq
         NEGAeVm+wCc+YBcPAUe4RsEdN8El5LlHVAO5/vdCj5CrNOZrGSQ23qEzLiABMiqBAVUv
         mvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792074974; x=1792679774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s7Sxld5tsDLlrrSCe0t36DLRKimZjfW887iRc5DqTG0=;
        b=H1zjv6C4pFagfyFA2qc+5ItNohyzAIWSeJ31kjjZgeh/lUVnWyKkyaNdg+ZnMTBsQ+
         T/bFCz1n7rQaDQ+Tze7wSKUs3+9NZOPt7CxplrYKa6bxQGRos7Op7lGDxq9986kpb1sV
         dssp0iaquLUZYrQhlevo5jTewMvEJ7JWXHB9WrP2wMSLvQf3hK1WV731x5j2h0cvtg+s
         b09NGlIUBz0kNg/DqeMe4fMFKEEFai3eoaZ591sbFXN/FBN+SUeBGeT4gr1YhGEfycXw
         B4UU+O/PBOvOCLe0mX6Jw35IyJ+hztD3QsaIzUmBxPipVuKKyD/4ZKgX6zAoQMaA0ogO
         wM/A==
X-Forwarded-Encrypted: i=1; AKwUvBxNhv+F6Nrtv0GESrbMkbaOeQhYpNeZ0lBLnGH8tp6asPr83/wNEkDEmP86o2AY8GJc8qnZMgvsKjmM+8VW@vger.kernel.org
X-Gm-Message-State: AFq9FYLhekBNIJLJtvhQU6Y6founaiUgmFpQK1qtbEZRErLLcX2DC3aX
	Ws7Bl5dHXxb3UEW7/7q4LTQL/0z/xoswcY1eF570JoIWpromJJBMPszsxPF7I30y
X-Gm-Gg: AYBFou33SP3iEcjTRaRCapGYNWgVe04C2YnFmYUlrYQ2nzYNMGc/SbPEXSovA6OILFi
	1PwtyuRec9iG/d0rcVTsw+VjRXZ1Y2bmVToOf5ekcvu6bn/U/VDtvsZGOtKLFQU5OGJSquptLq1
	y+8nDcPEO4tyGos+fRt8yWYyGIs2KVuz5dDiWgU2m9YPx/TD3Kkm0wBvypJSWvCfX66Ue0ucZkc
	7e9BpmgNVkeHlAPfWdew1LomUZ+d+gZjuth5aEcG+CYE13fazTFyu2uNIYaKMmjpOWKYGUuvZrL
	SldJ0vfKnxad86cP5PAVAtBOVzt9IBTzx8RHfZLVu0f75w9ghOBTA6y6s3FK2uRE8XYM+XZONVL
	qlBkQkvwDFO4Xvd0r+Kjhp6p6EOjOgIXdx0wnmW821R84E1RhWaewPLKPYcScyxctvsSTZOO4b7
	QVb7cOv9MjeDeDFR9wL9pYqK9xzUXFTbQ+LMN0e9xqY9K9HxHPHFVdW1ApfbmGhG1d6r/xLUJmM
	+i0eqoBnw6pE5utxsWNjSRhUw==
X-Received: by 2002:a17:907:e00a:20b0:c33:dbe8:290d with SMTP id a640c23a62f3a-c40212df07amr16904666b.22.1792074973643;
        Thu, 15 Oct 2026 07:36:13 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3eda03fe94sm135757466b.47.2026.10.15.07.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:36:12 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 09/14] fanotify: gate event mask in fanotify_mark() by group type
Date: Thu, 15 Oct 2026 16:35:55 +0200
Message-ID: <20261015143601.2095784-10-amir73il@gmail.com>
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

Bits 32..39 of the event mask encode the expected group watcher type.
Let fanotify_mark() accept a mask only when that type matches the group
watcher type.

FAN_MNT_* events carry no type in the mask, so special case them to pass
this gate.

The type is dropped when the 32bit mask is stored in the mark, so for now
the new FAN_NS_MNT_* events cannot be requested in fanotify_mark().

to prepare for overload the lower event bits, change all the bitmask
checks to use a helper fanotify_mask_match() which also compares the
type bits.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 118 ++++++++++++++++++++---------
 1 file changed, 81 insertions(+), 37 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index e8a8fc2ad52c8..76bb2574c8239 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1462,8 +1462,36 @@ static int fanotify_group_init_error_pool(struct fsnotify_group *group)
 					 sizeof(struct fanotify_error_event));
 }
 
+/*
+ * The low 32 event bits of a fanotify mask and the watcher type encoded
+ * in its high byte.
+ */
+struct fanotify_mask {
+	u32 mask;
+	u8 type;
+};
+
+/* Match @fan_mask to any event in @event_set of the same watcher type */
+static bool fanotify_mask_match(struct fanotify_mask fan_mask,
+				 __u64 event_set)
+{
+	return fan_mask.type == FAN_EVENT_TYPE(event_set) &&
+	       (fan_mask.mask & event_set);
+}
+
+static int fanotify_mask_from_user(__u64 mask, struct fanotify_mask *fan_mask)
+{
+	if (mask & ~(FAN_EVENT_TYPE_MASK | ALL_FANOTIFY_EVENT_BITS))
+		return -EINVAL;
+
+	fan_mask->mask = mask;
+	fan_mask->type = FAN_EVENT_TYPE(mask);
+	return 0;
+}
+
 static int fanotify_may_update_existing_mark(struct fsnotify_mark *fsn_mark,
-					     __u32 mask, unsigned int fan_flags)
+					     struct fanotify_mask fan_mask,
+					     unsigned int fan_flags)
 {
 	/*
 	 * Non evictable mark cannot be downgraded to evictable mark.
@@ -1491,8 +1519,9 @@ static int fanotify_may_update_existing_mark(struct fsnotify_mark *fsn_mark,
 		return -EEXIST;
 
 	/* For now pre-content events are not generated for directories */
-	mask |= fsn_mark->mask;
-	if (mask & FANOTIFY_PRE_CONTENT_EVENTS && mask & FAN_ONDIR)
+	fan_mask.mask |= fsn_mark->mask;
+	if ((fan_mask.mask & FAN_ONDIR) &&
+	    fanotify_mask_match(fan_mask, FANOTIFY_PRE_CONTENT_EVENTS))
 		return -EEXIST;
 
 	return 0;
@@ -1500,7 +1529,8 @@ static int fanotify_may_update_existing_mark(struct fsnotify_mark *fsn_mark,
 
 static int fanotify_add_mark(struct fsnotify_group *group,
 			     void *obj, unsigned int obj_type,
-			     __u32 mask, unsigned int fan_flags,
+			     struct fanotify_mask fan_mask,
+			     unsigned int fan_flags,
 			     struct fan_fsid *fsid)
 {
 	struct fsnotify_mark *fsn_mark;
@@ -1521,7 +1551,7 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 	/*
 	 * Check if requested mark flags conflict with an existing mark flags.
 	 */
-	ret = fanotify_may_update_existing_mark(fsn_mark, mask, fan_flags);
+	ret = fanotify_may_update_existing_mark(fsn_mark, fan_mask, fan_flags);
 	if (ret)
 		goto out;
 
@@ -1530,13 +1560,13 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 	 * needed (i.e. FAN_FS_ERROR was requested).
 	 */
 	if (!(fan_flags & FANOTIFY_MARK_IGNORE_BITS) &&
-	    (mask & FAN_FS_ERROR)) {
+	    fanotify_mask_match(fan_mask, FAN_FS_ERROR)) {
 		ret = fanotify_group_init_error_pool(group);
 		if (ret)
 			goto out;
 	}
 
-	recalc = fanotify_mark_add_to_mask(fsn_mark, mask, fan_flags);
+	recalc = fanotify_mark_add_to_mask(fsn_mark, fan_mask.mask, fan_flags);
 	if (recalc)
 		fsnotify_recalc_mask(fsn_mark->connector);
 
@@ -1545,7 +1575,7 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 
 	fsnotify_put_mark(fsn_mark);
 
-	if (!ret && (mask & FANOTIFY_PERM_EVENTS))
+	if (!ret && fanotify_mask_match(fan_mask, FANOTIFY_PERM_EVENTS))
 		fanotify_perm_watchdog_group_add(group);
 
 	return ret;
@@ -1811,21 +1841,22 @@ static int fanotify_test_fid(struct dentry *dentry, unsigned int flags)
 }
 
 static int fanotify_events_supported(struct fsnotify_group *group,
-				     const struct path *path, __u64 mask,
+				     const struct path *path,
+				     struct fanotify_mask fan_mask,
 				     unsigned int flags)
 {
 	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
 	bool is_dir = d_is_dir(path->dentry);
 	/* Strict validation of events in non-dir inode mask with v5.17+ APIs */
 	bool strict_dir_events = FAN_GROUP_FLAG(group, FAN_REPORT_TARGET_FID) ||
-				 (mask & FAN_RENAME) ||
+				 fanotify_mask_match(fan_mask, FAN_RENAME) ||
 				 (flags & FAN_MARK_IGNORE);
 
 	/*
 	 * Filesystems need to opt-into pre-content evnets (a.k.a HSM)
 	 * and they are only supported on regular files and directories.
 	 */
-	if (mask & FANOTIFY_PRE_CONTENT_EVENTS) {
+	if (fanotify_mask_match(fan_mask, FANOTIFY_PRE_CONTENT_EVENTS)) {
 		if (!(path->mnt->mnt_sb->s_iflags & SB_I_ALLOW_HSM))
 			return -EOPNOTSUPP;
 		if (!is_dir && !d_is_reg(path->dentry))
@@ -1840,7 +1871,7 @@ static int fanotify_events_supported(struct fsnotify_group *group,
 	 * waits for fanotify permission event to be answered. Just disallow
 	 * permission events for such filesystems.
 	 */
-	if (mask & FANOTIFY_PERM_EVENTS &&
+	if (fanotify_mask_match(fan_mask, FANOTIFY_PERM_EVENTS) &&
 	    path->mnt->mnt_sb->s_type->fs_flags & FS_DISALLOW_NOTIFY_PERM)
 		return -EINVAL;
 
@@ -1863,15 +1894,15 @@ static int fanotify_events_supported(struct fsnotify_group *group,
 	 * flags FAN_ONDIR and FAN_EVENT_ON_CHILD in mask of non-dir inode,
 	 * but because we always allowed it, error only when using new APIs.
 	 */
-	if (strict_dir_events && mark_type == FAN_MARK_INODE &&
-	    !is_dir && (mask & FANOTIFY_DIRONLY_EVENT_BITS))
+	if (strict_dir_events && mark_type == FAN_MARK_INODE && !is_dir &&
+	    fanotify_mask_match(fan_mask, FANOTIFY_DIRONLY_EVENT_BITS))
 		return -ENOTDIR;
 
 	return 0;
 }
 
 static bool fanotify_is_valid_mask(struct fsnotify_group *group, int mark_type,
-				   u64 mask)
+				  struct fanotify_mask fan_mask)
 {
 	u64 valid_mask = 0;
 
@@ -1894,14 +1925,20 @@ static bool fanotify_is_valid_mask(struct fsnotify_group *group, int mark_type,
 		if (mark_type == FAN_MARK_MNTNS &&
 		    FAN_GROUP_FLAG(group, FAN_REPORT_MNT))
 			valid_mask = FANOTIFY_MOUNT_EVENTS;
+		/* Classify the legacy mount events as namespace events */
+		if (fan_mask.mask & (FAN_MNT_ATTACH | FAN_MNT_DETACH))
+			fan_mask.type = FSNOTIFY_GROUP_TYPE_NAMESPACE;
 		break;
 	}
 
-	return !(mask & ~valid_mask);
+	if (fan_mask.type != group->type)
+		return false;
+
+	return !(fan_mask.mask & ~valid_mask);
 }
 
-static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
-			    int dfd, const char  __user *pathname)
+static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 __mask,
+			    int dfd, const char __user *pathname)
 {
 	struct inode *inode = NULL;
 	struct fsnotify_group *group;
@@ -1909,6 +1946,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	struct fan_fsid __fsid, *fsid = NULL;
 	struct user_namespace *user_ns = NULL;
 	struct mnt_namespace *mntns;
+	struct fanotify_mask fan_mask;
 	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
 	unsigned int mark_cmd = flags & FANOTIFY_MARK_CMD_BITS;
 	unsigned int ignore = flags & FANOTIFY_MARK_IGNORE_BITS;
@@ -1919,10 +1957,14 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	int ret;
 
 	pr_debug("%s: fanotify_fd=%d flags=%x dfd=%d pathname=%p mask=%llx\n",
-		 __func__, fanotify_fd, flags, dfd, pathname, mask);
+		 __func__, fanotify_fd, flags, dfd, pathname, __mask);
+
+	ret = fanotify_mask_from_user(__mask, &fan_mask);
+	if (ret)
+		return ret;
 
 	/* we only use the lower 32 bits as of right now. */
-	if (upper_32_bits(mask))
+	if (fan_mask.type)
 		return -EINVAL;
 
 	if (flags & ~FANOTIFY_MARK_FLAGS)
@@ -1952,7 +1994,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	switch (mark_cmd) {
 	case FAN_MARK_ADD:
 	case FAN_MARK_REMOVE:
-		if (!mask)
+		if (!fan_mask.mask)
 			return -EINVAL;
 		break;
 	case FAN_MARK_FLUSH:
@@ -1972,7 +2014,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	 * FAN_MARK_IGNORED_MASK.
 	 */
 	if (ignore == FAN_MARK_IGNORED_MASK) {
-		mask &= ~FANOTIFY_EVENT_FLAGS;
+		fan_mask.mask &= ~FANOTIFY_EVENT_FLAGS;
 		umask = FANOTIFY_EVENT_FLAGS;
 	}
 
@@ -1986,7 +2028,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	group = fd_file(f)->private_data;
 
 	if (group->type != mark_group_type ||
-	    !fanotify_is_valid_mask(group, mark_type, mask))
+	    !fanotify_is_valid_mask(group, mark_type, fan_mask))
 		return -EINVAL;
 
 	/*
@@ -2001,14 +2043,14 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	 * Permission events are not allowed for FAN_CLASS_NOTIF.
 	 * Pre-content permission events are not allowed for FAN_CLASS_CONTENT.
 	 */
-	if (mask & FANOTIFY_PERM_EVENTS &&
+	if (fanotify_mask_match(fan_mask, FANOTIFY_PERM_EVENTS) &&
 	    group->priority == FSNOTIFY_PRIO_NORMAL)
 		return -EINVAL;
-	else if (mask & FANOTIFY_PRE_CONTENT_EVENTS &&
+	else if (fanotify_mask_match(fan_mask, FANOTIFY_PRE_CONTENT_EVENTS) &&
 		 group->priority == FSNOTIFY_PRIO_CONTENT)
 		return -EINVAL;
 
-	if (mask & FAN_FS_ERROR &&
+	if (fanotify_mask_match(fan_mask, FAN_FS_ERROR) &&
 	    mark_type != FAN_MARK_FILESYSTEM)
 		return -EINVAL;
 
@@ -2029,7 +2071,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	 */
 	fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
 	if (fsnotify_is_filesystem_watcher(group) &&
-	    mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_EVENT_FLAGS) &&
+	    fan_mask.mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_EVENT_FLAGS) &&
 	    (!fid_mode || mark_type == FAN_MARK_MOUNT))
 		return -EINVAL;
 
@@ -2038,11 +2080,13 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	 * new parent+name.  Reporting only old and new parent id is less
 	 * useful and was not implemented.
 	 */
-	if (mask & FAN_RENAME && !(fid_mode & FAN_REPORT_NAME))
+	if (fanotify_mask_match(fan_mask, FAN_RENAME) &&
+	    !(fid_mode & FAN_REPORT_NAME))
 		return -EINVAL;
 
 	/* Pre-content events are not currently generated for directories. */
-	if (mask & FANOTIFY_PRE_CONTENT_EVENTS && mask & FAN_ONDIR)
+	if ((fan_mask.mask & FAN_ONDIR) &&
+	    fanotify_mask_match(fan_mask, FANOTIFY_PRE_CONTENT_EVENTS))
 		return -EINVAL;
 
 	if (mark_cmd == FAN_MARK_FLUSH) {
@@ -2051,12 +2095,12 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	}
 
 	ret = fanotify_find_path(dfd, pathname, &path, flags,
-			(mask & ALL_FSNOTIFY_EVENTS), obj_type);
+			(fan_mask.mask & ALL_FSNOTIFY_EVENTS), obj_type);
 	if (ret)
 		return ret;
 
 	if (mark_cmd == FAN_MARK_ADD) {
-		ret = fanotify_events_supported(group, &path, mask, flags);
+		ret = fanotify_events_supported(group, &path, fan_mask, flags);
 		if (ret)
 			goto path_put_and_out;
 	}
@@ -2066,7 +2110,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	if (ret)
 		goto path_put_and_out;
 
-	ret = security_path_notify(&path, mask, obj_type);
+	ret = security_path_notify(&path, fan_mask.mask, obj_type);
 	if (ret)
 		goto path_put_and_out;
 
@@ -2134,7 +2178,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 
 	/* Mask out FAN_EVENT_ON_CHILD flag for sb/mount/non-dir marks */
 	if (!inode || !S_ISDIR(inode->i_mode)) {
-		mask &= ~FAN_EVENT_ON_CHILD;
+		fan_mask.mask &= ~FAN_EVENT_ON_CHILD;
 		umask = FAN_EVENT_ON_CHILD;
 		/*
 		 * If group needs to report parent fid, register for getting
@@ -2142,18 +2186,18 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		 */
 		if ((fid_mode & FAN_REPORT_DIR_FID) &&
 		    (flags & FAN_MARK_ADD) && !ignore)
-			mask |= FAN_EVENT_ON_CHILD;
+			fan_mask.mask |= FAN_EVENT_ON_CHILD;
 	}
 
 	/* create/update an inode mark */
 	switch (mark_cmd) {
 	case FAN_MARK_ADD:
-		ret = fanotify_add_mark(group, obj, obj_type, mask, flags,
+		ret = fanotify_add_mark(group, obj, obj_type, fan_mask, flags,
 					fsid);
 		break;
 	case FAN_MARK_REMOVE:
-		ret = fanotify_remove_mark(group, obj, obj_type, mask, flags,
-					   umask);
+		ret = fanotify_remove_mark(group, obj, obj_type, fan_mask.mask,
+					   flags, umask);
 		break;
 	default:
 		ret = -EINVAL;
-- 
2.55.0

