Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793498253;
	b=3vVtfviaxlCT43lLRwOvpt86zTUoX2jBbUosuFNuiYAD4oMbaJnTE1msDFZsMawPTgtv
	 1RHHguE8CsHJIooVZoJRfubGg3OH4hhL/B02FhjFvdRM29upkWA5L6Uz2TtWBMaXYZJL0
	 I4l9BVbQz1B4COEqxcRWKmUx0UE7RlzKErdMEcM65s+O4iSyw9BHTOlA7q5RJLtn6q9cq
	 LxBcgWFZyJP03KEe6ZnLDcLFoHKUlQyS4XXKyxKkiP4/QQ4pSxHq0b0WeragI2JnykyyK
	 NFEBF+pED2a9RwNNxQ+xRW2DObrWR1r1Sr+Xpj9hoCQcAkdT0rUSoRj7Vw4yvqDOyaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793498253;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=p8gqfUFSv+Rji6NVZjPl0fEsf893Obde69tyzuNJ1VA=;
	b=YT+xSVwOVkz8964oxIeZp71SlOOR6Td4rrz5rOmeckkeT3JbsQdFQhZXP/GEYu7MUgTK
	 b9ZZpylfPt0ftrpBJPd99x5Ua1+wYw+wUN7bI0hwfxI8U38qR1zni1QVhNp+cCfjOWof9
	 6a8+8cPh8QVTBR2Dme8blmlfAT6ljDolwQDJvcMtoY7JEj+bZ45H/Ko/DhcfQ16O8ddt8
	 l1rLTjC6nRjVBRNRUXCsOpihPIOUQk8kSZV4iMJoLyPhhjML3aAJe3LPS/ABNK440ZbUV
	 tCRIpfXN/JcWMAmNpM536UXjH6la0atCIevNEM5iMTpMHW/nlznuOJi8SnS9QrdKOHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FyEr0mg5;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B995E60A2619
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Nov 2026 01:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B995E60A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FyEr0mg5
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so11766665e9.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 18:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793498251; x=1794103051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p8gqfUFSv+Rji6NVZjPl0fEsf893Obde69tyzuNJ1VA=;
        b=FyEr0mg5qfm+AS19Djqfasj9/qCbMdjarJt1OOKZwZ2DFTLKgN6I7WvSBds+QF4GA+
         HidC8Eq5Nx+K9pCCoQ6iDVlchrI07WQOgx0xyjLjiu00rlWKJORa4NXpgvJ8WPaDxTLG
         eeCaxTUpHF4bKWY1K/tgEzcUUbylAy9SV6Mpbza8P69uZCFf+lJhIRaEOMY1s0cT7OMt
         uyDMFk5RV28BywX9FVaa9WZvGmgVDM0BbHPrDVd7W4Snr3XoDvwD4I5HUa8s0QRg7Nvg
         Ddzgrp54zc+XOnaVrcKafgDR3MZ/5D/LAPBpX1JdlwNWypMoQvdnjnafvMzb5YcE4aEi
         5Y9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793498251; x=1794103051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p8gqfUFSv+Rji6NVZjPl0fEsf893Obde69tyzuNJ1VA=;
        b=Gn9gnJPVzx3vEM0bJ5NBLoiniVADBDDbHCmbtZ1Fv/OkNcfk0Jxzr12QpkIHe9ijHG
         qfeTqhMaYJlHafTSoo+8WJCKZOWhAyCUXsc3WtQDC0Em1Qw1cxlAC4bHbzMQrjx5Ao3f
         9bnJfwWKr6DYZ8cY9/P97JbAOkmWb1cp/GdBihQlXO0tKf1cHSVRrl183hfbIKl+E414
         tYQaM5j+WLmLT73fSrpYfs3RYw/3XBAKLAucPkWT733E7PtFHwczA8IjRRoRF9pHBDVT
         HOHYJqcg0bfF1+miLSvWSTRcfKP6WJFAwLNDvtmWGM1USK3Z81XdTdVfrIbz9criKs61
         nKCQ==
X-Forwarded-Encrypted: i=1; AKwUvBxSTGNyjknG3FRyc3r6FYKZxFy7Ikw2DqHa6ju6HIypvrohtz1njFc2TJGxqHd45vuqxJG9blXsRjmiQTlI@vger.kernel.org
X-Gm-Message-State: AFq9FYJvLsXrxWc278OxuGZHM78k8AKkzCZYGib9DIjTEwkA18+XRNMr
	sQBtuetDaVIR+IehZxTnSm+KKYg2n1hUe0zC9R8uGOuGKWjnrPfKQ1MD
X-Gm-Gg: AYBFou03YquPTXcTCdjH40KCuOXFsk2W8esm5rCoXVwNmeg+7rzQAgFKMwD0O7/i+6z
	Opjm+g9CQUxamRwG9TG5X1q6ogFNJQZxhbRA4JhztNRltwHB0BviKVdiaadfW5AM/F9uT6sHk/6
	gm+KRxZmt7fFNTo2n8saHPtCYLrKGUqn5viT7qU13pFMBr/HpRJCSpbjNgueTevolJqHkkZRtaa
	207zoQXTwTRbLZQXaXkLuointeadCy3Vy6nHddkMuY7BBbnCSGkPRaK+UCrB++dkDjK5BfhBRtn
	FkgGycsIwbJRFSmu9kEBGnOEWCM5e/1aG0a9pNRF0L3ffoRitkraOhZxon7wwaDbvMun9uZ7jn/
	IfrCv/Itr8kBEi+ArbeRcQIZ+gZXuT7CLURSEiltx9xcZBTsi96WoS7KddKZ9QcC5ADk0yEDaga
	eoQsUbqP73Kc7pXANerDBBVFceDYZlDEIoA30H+RjJLNH7/3kQdpwLwCsxsklrom6Z7QRe9k2LR
	qnekiadfU1tHa34Fs6J96MkJE91CQiIgHv+io3Nypw0aX+NWdKMDND4I66YZWQcrNYD4Voau2LY
	FDEIg9KTIxyHfBsVqltXdpD8
X-Received: by 2002:a05:600c:4fd4:b0:4a1:e250:b191 with SMTP id 5b1f17b1804b1-4ac180f2ff3mr144286495e9.17.1793498251133;
        Sat, 31 Oct 2026 18:57:31 -0700 (PDT)
Received: from infinity ([2001:b07:5d26:7a6a:365a:60ff:fe0d:cfc6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81b7fe80sm273532835e9.11.2026.10.31.18.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 18:57:29 -0700 (PDT)
From: koraynilay <koray.fra@gmail.com>
To: David Sterba <dsterba@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: Chris Mason <mason@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chuck Lever <cel@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Sean Smith <defendthedisabled@gmail.com>,
	Andrey Albershteyn <aalbersh@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Amir Goldstein <amir73il@gmail.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	exfat@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-api@vger.kernel.org,
	koraynilay <koray.fra@gmail.com>
Subject: [RFC PATCH v3 4/5] exfat: make crtime user-settable using ptime
Date: Sun,  1 Nov 2026 02:55:50 +0100
Message-ID: <20261101015551.786044-5-koray.fra@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101015551.786044-1-koray.fra@gmail.com>
References: <20261101015551.786044-1-koray.fra@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since exFAT supports user-settable file creation timestamps, map
provenance time (ptime) to exFAT file creation time (crtime) using the
newly introduced ptime API (in commit "vfs: add provenance time
(ptime)").

To do this, implement exfat_fileattr_set(), set .fileattr_set to it for
both file_inode and dir_inode operations and update exfat_fileattr_get()
and exfat_getattr().

The timestamp is now retrievable by using file_getattr() or statx(), and
is settable by using file_setattr() with the FS_XFLAG_PTIME flag.

Assisted-by: Gemini:3.8-flash-high antigravity-cli-1.4.7
Signed-off-by: koraynilay <koray.fra@gmail.com>
---
 fs/exfat/exfat_fs.h |  2 ++
 fs/exfat/file.c     | 36 +++++++++++++++++++++++++++++++++++-
 fs/exfat/namei.c    |  1 +
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index eee573d1697c..aff96afa258a 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -619,6 +619,8 @@ int exfat_getattr(const struct mnt_idmap *idmap, const struct path *path,
 		  unsigned int query_flags);
 struct file_kattr;
 int exfat_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
+int exfat_fileattr_set(const struct mnt_idmap *idmap, struct dentry *dentry,
+		       struct file_kattr *fa);
 int exfat_file_fsync(struct file *file, loff_t start, loff_t end, int datasync);
 long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
 long exfat_compat_ioctl(struct file *filp, unsigned int cmd,
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 1386149916bb..70e226cb4ab7 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -384,15 +384,20 @@ int exfat_getattr(const struct mnt_idmap *idmap, const struct path *path,
 
 	generic_fillattr(idmap, request_mask, inode, stat);
 	exfat_truncate_atime(&stat->atime);
-	stat->result_mask |= STATX_BTIME;
+	stat->result_mask |= (STATX_BTIME | STATX_PTIME);
 	stat->btime.tv_sec = ei->i_crtime.tv_sec;
 	stat->btime.tv_nsec = ei->i_crtime.tv_nsec;
+	stat->ptime.tv_sec = ei->i_crtime.tv_sec;
+	stat->ptime.tv_nsec = ei->i_crtime.tv_nsec;
 	stat->blksize = EXFAT_SB(inode->i_sb)->cluster_size;
 	return 0;
 }
 
 int exfat_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 {
+	struct inode *inode = d_backing_inode(dentry);
+	struct exfat_inode_info *ei = EXFAT_I(inode);
+
 	/*
 	 * exFAT compares filenames through an upcase table, so lookup
 	 * is always case-insensitive. Long names are stored in UTF-16
@@ -400,6 +405,11 @@ int exfat_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 	 */
 	fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
 	fa->flags |= FS_CASEFOLD_FL;
+
+	fa->fsx_ptime.tv_sec = ei->i_crtime.tv_sec;
+	fa->fsx_ptime.tv_nsec = ei->i_crtime.tv_nsec;
+	fa->fsx_xflags |= FS_XFLAG_PTIME;
+
 	return 0;
 }
 
@@ -485,6 +495,29 @@ int exfat_setattr(const struct mnt_idmap *idmap, struct dentry *dentry,
 	return error;
 }
 
+int exfat_fileattr_set(const struct mnt_idmap *idmap, struct dentry *dentry,
+		      struct file_kattr *fa)
+{
+	struct inode *inode = d_backing_inode(dentry);
+	struct exfat_inode_info *ei = EXFAT_I(inode);
+
+	if (fileattr_has_fsx_mask(fa, FS_XFLAG_PTIME))
+		return -EOPNOTSUPP;
+
+	if (fa->flags & ~FS_CASEFOLD_FL)
+		return -EOPNOTSUPP;
+
+	if (fa->fsx_xflags & FS_XFLAG_PTIME) {
+		ei->i_crtime.tv_sec = fa->fsx_ptime.tv_sec;
+		ei->i_crtime.tv_nsec = fa->fsx_ptime.tv_nsec;
+	}
+
+	inode_set_ctime_current(inode);
+	mark_inode_dirty(inode);
+
+	return 0;
+}
+
 /*
  * modified ioctls from fat/file.c by Welmer Almesberger
  */
@@ -1110,4 +1143,5 @@ const struct inode_operations exfat_file_inode_operations = {
 	.setattr	= exfat_setattr,
 	.getattr	= exfat_getattr,
 	.fileattr_get	= exfat_fileattr_get,
+	.fileattr_set	= exfat_fileattr_set,
 };
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 68ddb9c5504f..15ec7f1942c8 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -1349,4 +1349,5 @@ const struct inode_operations exfat_dir_inode_operations = {
 	.setattr	= exfat_setattr,
 	.getattr	= exfat_getattr,
 	.fileattr_get	= exfat_fileattr_get,
+	.fileattr_set	= exfat_fileattr_set,
 };
-- 
2.56.0

