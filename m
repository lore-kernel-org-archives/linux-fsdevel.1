Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2CC481B1;
	Thu, 16 Jul 2026 02:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784170048; cv=none; b=tarbanfSZ7t6LKMnqpeBKK8upTi4PpNjud+afYy4yqKJeC/JSZ8Yj0BTGqzFovLg+JMdezAGJUAUanXK1h0noHUrL7T5CcdfXggR90NxjaZpmJqhRcPREAg50OMQ7KsldojCXd1uNzwusU83uyp8y2zY1OULf/KrsOlGOCHDnZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784170048; c=relaxed/simple;
	bh=8CG1aoCeuIUE7rPhRflru504ymc6zOAJGZIH+EbqmvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PdSwaVHuBvnwJaGw/fInG2aoQCGfuelmtNoso4PgELaiwLV1OiFpEHJuczc5USUUaV/O5A+prc6bSkYz8Qszyy4XoxGdDy4SA+ep3+Sgy4/aNzm7Jgxma2gLUTToPentbhqd7Etelr4hs3reA51yGSzCHvv/Po2iQM521e1Lxcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtx7XRZc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtx7XRZc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D811F000E9;
	Thu, 16 Jul 2026 02:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784170046;
	bh=06Mncw7PmDHCJZVJB8qhJ+iRV9NJLKz87byWkIsJ7Eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dtx7XRZcIeqsc2VsJUFMwPvXvWgGNRw7z0GZ5YYAriLMfMu0SCNBJI+9+9A8kf+8f
	 /fa9/q5Rl6iTVY9wkX5zpyH2lob6ssKT+4fGmRe5mFsce35lYuXH2cD4ESspcYKmyT
	 BKHu9A3zsyJhzy+cp3629cxth8F86e7614BVVMi0by/TSU+XNMmC7+RVUU9HqjEasF
	 F1yCeNv8QUNFydD8GCuCHKc5Y1tmH69BfNJZ/yfS7bot7R+hhK2FKFDRDqGWh3mFfC
	 9/N7GnM6oWDA2eGRFH3s4o9r8DsBzVkjCAnDFaMdxjWDClXeVDWKilxJHQZ3DkNmJm
	 Rm+ggqb8pSj+A==
From: Namjae Jeon <linkinjeon@kernel.org>
To: hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH] ntfs: rewrite EA stream before updating metadata
Date: Thu, 16 Jul 2026 11:46:37 +0900
Message-Id: <20260716024640.13396-3-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260716024640.13396-1-linkinjeon@kernel.org>
References: <20260716024640.13396-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updating an EA removes the old record and appends its replacement.
Build the complete $EA stream in memory and rewrite it from offset zero,
rather than committing a compacted stream followed by a separate append.
generic/642 shows that the append path can leave an invalid record layout
on disk, including when a new EA entry is added.

When removing an EA, write the compacted stream before updating
$EA_INFORMATION and restore the original pair if the metadata update
fails.

When the final EA entry is removed the $EA/$EA_INFORMATION pair is torn
down. If removing $EA_INFORMATION fails after $EA has already been
removed, the original $EA is restored so the two attributes stay
consistent.

Fixes: fc053f05ca28 ("ntfs: add reparse and ea operations")
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfs/ea.c | 65 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 46 insertions(+), 19 deletions(-)

diff --git a/fs/ntfs/ea.c b/fs/ntfs/ea.c
index 88bfd6560692..d0044c61152a 100644
--- a/fs/ntfs/ea.c
+++ b/fs/ntfs/ea.c
@@ -196,6 +196,9 @@ static int ntfs_set_ea(struct inode *inode, const char *name, size_t name_len,
 	struct ea_attr *p_ea;
 	u32 ea_info_qsize = 0;
 	char *ea_buf = NULL;
+	char *new_ea_buf;
+	char *old_ea_buf = NULL;
+	struct ea_information old_ea_info;
 	size_t new_ea_size = ALIGN(struct_size(p_ea, ea_name, 1 + name_len + val_size), 4);
 	s64 ea_off, ea_info_size, all_ea_size, ea_size;
 
@@ -249,6 +252,14 @@ static int ntfs_set_ea(struct inode *inode, const char *name, size_t name_len,
 			err = -EEXIST;
 			goto out;
 		}
+		if ((flags & XATTR_REPLACE) && !val_size) {
+			old_ea_info = *p_ea_info;
+			old_ea_buf = kvmemdup(ea_buf, all_ea_size, GFP_NOFS);
+			if (!old_ea_buf) {
+				err = -ENOMEM;
+				goto out;
+			}
+		}
 
 		/* Check the final $EA size before removing the old entry. */
 		if (val_size &&
@@ -281,20 +292,33 @@ static int ntfs_set_ea(struct inode *inode, const char *name, size_t name_len,
 				goto out;
 
 			err = ntfs_attr_remove(ni, AT_EA_INFORMATION, AT_UNNAMED, 0);
+			if (err) {
+				/* Restore the original $EA if $EA_INFORMATION removal failed. */
+				ntfs_attr_add(ni, AT_EA, AT_UNNAMED, 0, old_ea_buf,
+					      all_ea_size);
+				ea_info_qsize = le32_to_cpu(old_ea_info.ea_query_length);
+			}
 			goto out;
 		}
 
-		err = ntfs_write_ea(ni, AT_EA_INFORMATION, (char *)p_ea_info, 0,
-				sizeof(struct ea_information), false);
-		if (err)
-			goto out;
-
-		err = ntfs_write_ea(ni, AT_EA, ea_buf, 0, ea_info_qsize, true);
-		if (err)
-			goto out;
-
 		if ((flags & XATTR_REPLACE) && !val_size) {
-			/* Remove xattr. */
+			err = ntfs_write_ea(ni, AT_EA, ea_buf, 0, ea_info_qsize,
+					true);
+			if (err) {
+				ntfs_write_ea(ni, AT_EA, old_ea_buf, 0,
+					      all_ea_size, false);
+				goto out;
+			}
+
+			err = ntfs_write_ea(ni, AT_EA_INFORMATION, (char *)p_ea_info,
+					0, sizeof(struct ea_information), false);
+			if (err) {
+				ntfs_write_ea(ni, AT_EA, old_ea_buf, 0,
+					      all_ea_size, false);
+				ntfs_write_ea(ni, AT_EA_INFORMATION,
+					      (char *)&old_ea_info, 0,
+					      sizeof(old_ea_info), false);
+			}
 			goto out;
 		}
 	} else {
@@ -309,21 +333,23 @@ static int ntfs_set_ea(struct inode *inode, const char *name, size_t name_len,
 			goto out;
 		}
 	}
-	kvfree(ea_buf);
-
 alloc_new_ea:
-	ea_buf = kzalloc(new_ea_size, GFP_NOFS);
-	if (!ea_buf) {
+	new_ea_buf = kvzalloc(ea_info_qsize + new_ea_size, GFP_NOFS);
+	if (!new_ea_buf) {
 		err = -ENOMEM;
 		goto out;
 	}
+	if (ea_info_qsize)
+		memcpy(new_ea_buf, ea_buf, ea_info_qsize);
+	kvfree(ea_buf);
+	ea_buf = new_ea_buf;
+	p_ea = (struct ea_attr *)(ea_buf + ea_info_qsize);
 
 	/*
 	 * EA and REPARSE_POINT compatibility not checked any more,
 	 * required by Windows 10, but having both may lead to
 	 * problems with earlier versions.
 	 */
-	p_ea = (struct ea_attr *)ea_buf;
 	memcpy(p_ea->ea_name, name, name_len);
 	p_ea->ea_name_length = name_len;
 	p_ea->ea_name[name_len] = 0;
@@ -344,13 +370,13 @@ static int ntfs_set_ea(struct inode *inode, const char *name, size_t name_len,
 	 * no EA or EA_INFORMATION : add them
 	 */
 	if (!ntfs_attr_exist(ni, AT_EA, AT_UNNAMED, 0)) {
-		err = ntfs_attr_add(ni, AT_EA, AT_UNNAMED, 0, (char *)p_ea,
-				new_ea_size);
+		err = ntfs_attr_add(ni, AT_EA, AT_UNNAMED, 0, ea_buf,
+				ea_info_qsize + new_ea_size);
 		if (err)
 			goto out;
 	} else {
-		err = ntfs_write_ea(ni, AT_EA, (char *)p_ea, ea_info_qsize,
-				new_ea_size, false);
+		err = ntfs_write_ea(ni, AT_EA, ea_buf, 0,
+				ea_info_qsize + new_ea_size, true);
 		if (err)
 			goto out;
 	}
@@ -370,6 +396,7 @@ static int ntfs_set_ea(struct inode *inode, const char *name, size_t name_len,
 		NInoClearHasEA(ni);
 
 	kvfree(ea_buf);
+	kvfree(old_ea_buf);
 	kvfree(p_ea_info);
 
 	return err;
-- 
2.25.1

