Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E60C3815EE
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Apr 2026 19:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775418640; cv=none; b=Q61W+qEn2k1bU27tCA6HKKtkhnWeYt4dbeOd2opVQpBor24FXJ9cgCcxuLEkcijp2jYLpra/S9QB3AUNg4gfff+PhPkEn7KAaGWkhoI4U17FszlL/8KOLOBe2YUwJRXFwYXRaQZNDaT+1dhGbMM/df5eXlAQEhpnubNlVDEww3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775418640; c=relaxed/simple;
	bh=hU9BEcBtU1BBLNMoyk+Hth5Nr+ssFTdxV7hM11OlEK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uX3re5dEODeTnQLuQ7RJOm9WFRucAbKoUUrc34/8XKGI9+Dmhdngv6pixbxd4O4rA6N7aVgWUzyFjgFOZhs0NTZMtN+ZTnk+V2B81zfZyo4OiQgDkxmcn+SyERPn1vK/CAfk81I0MDeSmBKcpkmiOur9fzxV+rGEwZEf+eD2pDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVXrs8bm; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVXrs8bm"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-46eca92a297so1675744b6e.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Apr 2026 12:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775418638; x=1776023438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YfcbYnu/pMQdwPjkXzXqWwSF71Fmf6slXoGMkRuceU=;
        b=EVXrs8bmHgO5s1t90z3Eg+M08P1oG8LrWnRCgXbjTfDMCRDKHcHznXQIsEr8SaYN2V
         jynu10b89Jm8Xtk5/TelCEnVUsbUEbbK0I5anXQjsuIegtGQR9dLqSPB/wPJn9oHPgcg
         ho9znGnNCmJKeu4INjVpi/1+6LT4IO5xLcnCkD31QwuIl5UVGsLBpVi1GaOvTQ+//Ejq
         BWeEwYqj0YmOPSqZ/5IpuZOav4vxXJ7wUTD8Ba//k4MGi4cGxTU5X30PHG+DlvR91H24
         utNwxCv+gYX3zqC81ePRIlWdDBvzENw2reukDwk15K+wD9MSIyLNaVxfpqMHjlEBGCee
         oteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775418638; x=1776023438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8YfcbYnu/pMQdwPjkXzXqWwSF71Fmf6slXoGMkRuceU=;
        b=mtm4Z2twTyEBgcmWfzYYtuH7yZnQsnJ//WX/do+Tu2YkeuhkzTMMTyOQYqNC645OZ+
         Q6F1Mj7Q/j+hpavNU9vfUmIwnUpSqKhNS+l34gyWrFYui6ZbkmYy6pXLKuZbLEzEUcsC
         ALGj7Gns4D8+hFCLkRmM3eKBQfJ0FKOB5y4zd3nUeruwVmbiWo9SPToz8zrnop1uC6NV
         6Og+qBBOtudT1o3EIxrzFSwdZp8oOhGHmk5unTHebYXzn/6ovpsgkdmz6lNkE+98QWQj
         xYDSJCIGh1g1OgDE0uK621e8nWGSOyvbDFNVpeetgNMahy2UfexFB8Jgr5jV2ZeiKDb/
         HGiA==
X-Gm-Message-State: AOJu0YxXFVPO754nrsCgxwYss0mraB8bx3dTL8VKLNIbGmEsM9M7D5q9
	yB6XgltT4fNrgg5bHQjmtdPUHQron1Ex6PpYQake8tSVp9wqgpgmBMQtsVKNvtuq
X-Gm-Gg: AeBDieuB3mKNOmpwNJDwFPTUmb+2MbZi23VOvUaEB5pvscDyTTr+GNatFxH83YoHr79
	zx2URIKQv31ptPHhDBNNzsLqKiUM5TAmvZlCN2k0kCoxT8u4g0oeNqo1rxZHzuEvilTlNV2vjTR
	tkcmPFLKZ1V8lUrSgTmLmvme8PV7x5CoZu+eURg5jESe8dHd2zxd7BiOneT1NMbYmn3Lobp3vaR
	/Hz9EdFKpAGq9ejfMe044Vui4lGhWijIg+55YXh3nSPtkRfzpVt8nCO2ln01Q+W5o7Lx94ECcv1
	lHrKqp95My6duNY0aIxp2nm63DPa4WVFKtMUMp6uBitajwRLikc7xLVCHE4TUjkzPvUAWGGebIx
	vkSpWNEwQ5LqCSAFNK/IHQXv/EeguePQBM7a7NEIpODUQKEXGmQiCHIrANjVBLDeSAnD5ezKrF6
	fj8TG4vSdcUMMl9uNKFVUBOBIjVcpV3DAUk5BJTLYbgaSGM3QKCnlp1LXFTcMvtFqIMr1nCKAt+
	+zLP4aLSFumork=
X-Received: by 2002:a05:6808:1903:b0:467:46e7:e6fd with SMTP id 5614622812f47-46efb1cf743mr5361782b6e.35.1775418637761;
        Sun, 05 Apr 2026 12:50:37 -0700 (PDT)
Received: from localhost.localdomain (c-73-5-99-191.hsd1.la.comcast.net. [73.5.99.191])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46f46160155sm4547428b6e.17.2026.04.05.12.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 12:50:36 -0700 (PDT)
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
Subject: [PATCH 3/6] ntfs3: map ptime to NTFS creation time with rename-over
Date: Sun,  5 Apr 2026 14:49:59 -0500
Message-ID: <20260405195007.1306-4-DefendTheDisabled@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <20260405195007.1306-1-DefendTheDisabled@gmail.com>
References: <20260405195007.1306-1-DefendTheDisabled@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Map ptime to the NTFS Date Created field in $STANDARD_INFORMATION.
This is a mapped-ptime implementation: setting ptime overwrites the
creation time. Justified because Windows treats NTFS creation time
as mutable via SetFileTime() - it was never truly immutable.

Getattr: report NTFS creation time as ptime.
Setattr: write ptime to NTFS creation time via frecord cr_time path.
Rename-over: save target creation time before unlink, restore to
  source after rename. Replicates Windows behavior where creation
  time survives application atomic saves.

Round-trip: NTFS Date Created -> Btrfs ptime -> NTFS Date Created
preserves the original creation date through cross-FS copies.

Signed-off-by: Sean Smith <DefendTheDisabled@gmail.com>
---
 fs/ntfs3/file.c    | 13 +++++++++++++
 fs/ntfs3/frecord.c |  8 ++++++++
 fs/ntfs3/namei.c   | 14 ++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 13d014b87..8688a48b1 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -161,6 +161,13 @@ int ntfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 
 	stat->result_mask |= STATX_BTIME;
 	stat->btime = ni->i_crtime;
+
+	/* Map NTFS creation time to ptime (provenance time) */
+	if (request_mask & STATX_PTIME) {
+		stat->ptime = ni->i_crtime;
+		stat->result_mask |= STATX_PTIME;
+	}
+
 	stat->blksize = ni->mi.sbi->cluster_size; /* 512, 1K, ..., 2M */
 
 	if (inode->i_flags & S_IMMUTABLE)
@@ -857,6 +864,12 @@ int ntfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		i_size_write(inode, newsize);
 	}
 
+	/* Accept ptime and store as NTFS creation time */
+	if (ia_valid & ATTR_PTIME) {
+		ni->i_crtime = attr->ia_ptime;
+		ni->ni_flags |= NI_FLAG_UPDATE_PARENT;
+	}
+
 	setattr_copy(idmap, inode, attr);
 
 	if (mode != inode->i_mode) {
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index d5bbd47e1..b164b2f50 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -3197,6 +3197,14 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
 			modified = true;
 		}
 
+		/* Write creation time (ptime maps to NTFS cr_time) */
+		ts = ni->i_crtime;
+		dup.cr_time = kernel2nt(&ts);
+		if (std->cr_time != dup.cr_time) {
+			std->cr_time = dup.cr_time;
+			modified = true;
+		}
+
 		dup.fa = ni->std_fa;
 		if (std->fa != dup.fa) {
 			std->fa = dup.fa;
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index b2af8f695..40d06884f 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -292,6 +292,16 @@ static int ntfs_rename(struct mnt_idmap *idmap, struct inode *dir,
 		return -EINVAL;
 	}
 
+	/* ptime rename-over: save target creation time before unlink */
+	struct timespec64 saved_crtime = {};
+	bool inherit_crtime = false;
+
+	if (new_inode && S_ISREG(inode->i_mode) &&
+	    S_ISREG(new_inode->i_mode) && inode->i_nlink == 1) {
+		saved_crtime = ntfs_i(new_inode)->i_crtime;
+		inherit_crtime = true;
+	}
+
 	if (new_inode) {
 		/* Target name exists. Unlink it. */
 		dget(new_dentry);
@@ -330,6 +340,10 @@ static int ntfs_rename(struct mnt_idmap *idmap, struct inode *dir,
 
 	err = ni_rename(dir_ni, new_dir_ni, ni, de, new_de);
 	if (!err) {
+		/* ptime rename-over: inherit target creation time */
+		if (inherit_crtime)
+			ni->i_crtime = saved_crtime;
+
 		simple_rename_timestamp(dir, dentry, new_dir, new_dentry);
 		mark_inode_dirty(inode);
 		mark_inode_dirty(dir);
-- 
2.53.0

