Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A1E37F740
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Apr 2026 19:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775418653; cv=none; b=XwhYXCQtagI/wuP0NIeQbZr8l1nUmm+HxtoWKmiFJdXzqEDJGtcnKi5zIm1DNIruohsingiJq2fzldr7l3yxfz+4BcQzIy0zDg6W9Jn/pdCVgnPTHmwuuxfV2NxEVaPHoLFJEqjmoYMbMLPwzxJHsXxvMZfEYvaG9eAIRKDLs5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775418653; c=relaxed/simple;
	bh=pj9izgkvaTpAgOnLoFsABfEkNw9zO15w9ucfnlZdKpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=INytQ/i2HBxNg3CGownL5gLQb4ROl9juhM8Q0u7+bqwwwOefUPnHJXJmgHXufuoOG6tN+8UDXKg5JL6xb3EFKtcvuV1fh4UtSXhAfyusWEJGH6i7puns5LCnRuJj4kw7w4Pu6+4Kwz9XJm/lhCHQ7OVGzXd4qUQZbR/9B6inh30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rh6owsbo; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rh6owsbo"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4670676ba03so1088216b6e.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Apr 2026 12:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775418650; x=1776023450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlPOfR3Gdqzse/ZH/+C3LmQPc6s/iyp+29XZTkd6JSs=;
        b=rh6owsbo2uEvJW6wIx2n3RiJ3gNb2G/Z6Y++ui7W+U1rQ5w/GzAfkVBKxmsfLCVtyi
         BiaJnDUgPrACvNiq0elkWG6+gRQocmyUHDJvGVKGn62wWiBJN6mGTUltO9YQDmUX+sKY
         CjkupcbyftMtNVHL616kFreIp0aaLgUHN5VWYcNBk5lyaE8Ei0Vm2hYhU4t2QsGPBc3N
         mU7/Y1+2ziR7PeI/abF+w5COa1dDtFz7wR0vDy9sNsVy2xraRGSsC029uUpbaKrKksHi
         JfLosLNN0fOLCtQ5BxrGEuXPDIL1p6wp4Th5+F8lXbH2zrgdtAvPbm/g3OwRwkocMpER
         NG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775418650; x=1776023450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KlPOfR3Gdqzse/ZH/+C3LmQPc6s/iyp+29XZTkd6JSs=;
        b=h2xiU+B3lox1/c8CUedsiUc8+44dUj49pmbUMpK2tIKaPnZmR0iS/+iZSNQIuvlN5K
         HMiAZb5z2PxrvUZHWoup/Fl2OeVOFue8cW/bZhphG/cQ5BZYC0wbWBLgf8ucne2ngBdf
         u6GLzNak+akgWiXTZGSyr6M1Y+LkABJl0J+z2Di7cz09ss1wxqc81+cvkuIwLj0vjK36
         RRYuivfq9ViI+1FGIXEKDfcv4L+ygB5UACWRcxwWWFrxX/lZgMbTEr+pZ6M3OAQ1JAxh
         AVBdt1gxgV5R/CgFgF7v2WPBesxaAWPSVVelB/mLOnbARzrQFE1ukUBD3jPTV53EkH/O
         zV1w==
X-Gm-Message-State: AOJu0Yyd22L/QzAE6xpKgJ6wtB8Bmim9YXyiuw6PcdNd/gDA5/HogEhf
	s2xiuP8rCQNjEcWn1YCx2K0krlkwLHnLYegi4XzRhC7uWLvIPqU15muUPG38Zqja
X-Gm-Gg: AeBDievsN99HvCLs0d0pFLHSzYFUyXBqzaKnBWt7YClsc4UEyVDd4AoYkrLyMITVr7K
	XwkczrFbc+7vHCUgmGVS85L6M24FWBl8rpzJpH25qeiiohuoArVxIew8bf6Nra1v8stLgiTNctM
	olPMka/44qeAQGmlhHVlhXv5mBwwNAJQNWXypCfvQkc5bL0cIkorHJ0M9J8+nixkIVSQav0XzP5
	qqZN0BP/v5zEYcdKHoBhagWauPiSJi5nj67i8qwQNICR144Pan7CpEmWJ8Uz/0eJZrnq9cahvM4
	4sIz58glNJQRsvhWnResR6qxTxH/Yr+WQDCQRZx+cBlCuaDybfL7YQbeJdrT8pBioDbXYitXi4j
	QJcr3hp/20YVQEzAmTrceooKwT1prPCXre/61c4c8Ap8CXmyCQlpyl/OQgKTt0pxYJxAhj66a0K
	6dzLTUtZGKmieA4ZY6s6MT/ElVC/f7q5mITr6VjJ3hjacJT4h0hmRKMTQwoK0odPBtoXWeLo4p8
	vulEGUsUu/uXJU=
X-Received: by 2002:a05:6808:67cc:b0:467:1ad3:80c with SMTP id 5614622812f47-46ef50025b2mr5012571b6e.1.1775418650293;
        Sun, 05 Apr 2026 12:50:50 -0700 (PDT)
Received: from localhost.localdomain (c-73-5-99-191.hsd1.la.comcast.net. [73.5.99.191])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46f46160155sm4547428b6e.17.2026.04.05.12.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 12:50:48 -0700 (PDT)
From: Sean Smith <defendthedisabled@gmail.com>
X-Google-Original-From: Sean Smith <DefendTheDisabled@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	tytso@mit.edu,
	dsterba@suse.com,
	david@fromorbit.com,
	brauner@kernel.org,
	osandov@osandov.com,
	almaz@kernel.org,
	hirofumi@mail.parknet.co.jp,
	linkinjeon@kernel.org,
	Sean Smith <DefendTheDisabled@gmail.com>
Subject: [PATCH 6/6] exfat: map ptime to exFAT creation time with rename-over
Date: Sun,  5 Apr 2026 14:50:02 -0500
Message-ID: <20260405195007.1306-7-DefendTheDisabled@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <20260405195007.1306-1-DefendTheDisabled@gmail.com>
References: <20260405195007.1306-1-DefendTheDisabled@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Map ptime to the exFAT creation time field. exFAT creation time
has 10ms precision.

Getattr: report creation time as ptime.
Setattr: write ptime to i_crtime.
Rename-over: save target creation time before __exfat_rename, restore
  after. Preserves creation time across atomic saves.

Signed-off-by: Sean Smith <DefendTheDisabled@gmail.com>
---
 fs/btrfs/inode.c |  3 ++-
 fs/exfat/file.c  |  9 +++++++++
 fs/exfat/namei.c | 21 ++++++++++++++++++---
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index dce80561a..918dfd4c5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8715,7 +8715,8 @@ static int btrfs_rename(struct mnt_idmap *idmap,
 		/* Note: if rename fails below, ptime mutation is harmless —
 		 * the source file keeps its previous ptime=0 semantics since
 		 * the rename didn't complete. The in-memory value will be
-		 * overwritten on next inode read from disk. */
+		 * overwritten on next inode read from disk.
+		 */
 
 		ret = btrfs_update_inode(trans, BTRFS_I(old_inode));
 		if (unlikely(ret)) {
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 536c8078f..b6438bd79 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -277,6 +277,11 @@ int exfat_getattr(struct mnt_idmap *idmap, const struct path *path,
 	stat->result_mask |= STATX_BTIME;
 	stat->btime.tv_sec = ei->i_crtime.tv_sec;
 	stat->btime.tv_nsec = ei->i_crtime.tv_nsec;
+	if (request_mask & STATX_PTIME) {
+		stat->result_mask |= STATX_PTIME;
+		stat->ptime.tv_sec = ei->i_crtime.tv_sec;
+		stat->ptime.tv_nsec = ei->i_crtime.tv_nsec;
+	}
 	stat->blksize = EXFAT_SB(inode->i_sb)->cluster_size;
 	return 0;
 }
@@ -337,6 +342,10 @@ int exfat_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (attr->ia_valid & ATTR_SIZE)
 		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 
+	if (attr->ia_valid & ATTR_PTIME) {
+		struct exfat_inode_info *exi = EXFAT_I(inode);
+		exi->i_crtime = attr->ia_ptime;
+	}
 	setattr_copy(idmap, inode, attr);
 	exfat_truncate_inode_atime(inode);
 
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index dfe957493..9c0b59e00 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -1262,9 +1262,24 @@ static int exfat_rename(struct mnt_idmap *idmap,
 	old_inode = old_dentry->d_inode;
 	new_inode = new_dentry->d_inode;
 
-	err = __exfat_rename(old_dir, EXFAT_I(old_inode), new_dir, new_dentry);
-	if (err)
-		goto unlock;
+	/* ptime rename-over: save target creation time */
+	{
+		struct timespec64 saved_crtime = {};
+		bool inherit_crtime = false;
+
+		if (new_inode && S_ISREG(old_inode->i_mode) &&
+		    S_ISREG(new_inode->i_mode) && old_inode->i_nlink == 1) {
+			saved_crtime = EXFAT_I(new_inode)->i_crtime;
+			inherit_crtime = true;
+		}
+
+		err = __exfat_rename(old_dir, EXFAT_I(old_inode), new_dir, new_dentry);
+		if (err)
+			goto unlock;
+
+		if (inherit_crtime)
+			EXFAT_I(old_inode)->i_crtime = saved_crtime;
+	}
 
 	inode_inc_iversion(new_dir);
 	simple_rename_timestamp(old_dir, old_dentry, new_dir, new_dentry);
-- 
2.53.0

