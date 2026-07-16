Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B70827F19F;
	Thu, 16 Jul 2026 02:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784170056; cv=none; b=MAvr986L17qOHoyRuh/9G+d3vGKmxe26s/cBSYtnyxxReb6BxDlqpkdASIoV/u9UE1GudSPg0dOlO/5sxNmd18/Vl02mlUFf7ber09BwOYl996P+t5UBbu5P6FHKBjBwNanXCcyPzCs+6q6GcHJR3LGKfkUJBVzpBf7zBMzo+BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784170056; c=relaxed/simple;
	bh=dZ7LJTjcYMGsyATFHMcswNT955Tj8eHjkBoF+iTtIWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ELsX+gkDrD/ly03w2nBZAbSqxNZhY8vIrhqo8OeI622I3OWCLIfKcrN27WBeZ7IxqN8m/Jen4VyHCVfRtdd2j3Bb3xrqXoaL4lj1FtWly4zCWcGk7FCsHdGo1jUjKQFQCKtqset7Ayb4BcpvYlzyzC69N4izGjIYR7+tz+gxaoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4JMNdKq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4JMNdKq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441B61F000E9;
	Thu, 16 Jul 2026 02:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784170055;
	bh=q9bX+cgplhnv9rIrRgngliVohGjiezErlz49u7dGY0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a4JMNdKqrFsXMSzL84BEGBYzCqLt2YMTVrRtdDonA7ArGTyniPgSHEgt3Yaq10Xur
	 87uMGkzGmFFhLbbI+coA68L1ytTmAN/xiL4H/w77K6NeN1AsEuanyTD1LfoI8rnqnw
	 lSv8z6uHqjywkkzF48K3syWGtNGRDQB7cIXt+9omNV12KFEzC4ZF5Gco+gXANAyS5Y
	 ieAx8C5fjD8cnYQv2A4L4mse09tDfdiRKvfFOic78q9ZJMfpqsmOX7Lz9TTx8/mWYN
	 77ixxnBGKGptHAWl+DO7SUCL6m7rACOYrghX8DGUlXdaK12xUb2EOVu8gqMyY0Nat8
	 FA5VMxJhr7PlA==
From: Namjae Jeon <linkinjeon@kernel.org>
To: hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH] ntfs: use pagecache_isize_extended() on size extension
Date: Thu, 16 Jul 2026 11:46:40 +0900
Message-Id: <20260716024640.13396-6-linkinjeon@kernel.org>
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

When extending file size, call truncate_pagecache() first, then update
i_size, and use pagecache_isize_extended() instead of manual
iomap_zero_range(). This ensures the straddling folio is properly marked
RO so page_mkwrite() is called and post-EOF area is zeroed.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfs/file.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 9061f8f77f7e..c8e49f83fd92 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -268,23 +268,19 @@ static int ntfs_setattr_size(struct inode *vi, struct iattr *attr)
 		return err;
 
 	inode_dio_wait(vi);
-	truncate_setsize(vi, attr->ia_size);
+	if (attr->ia_size > old_size) {
+		truncate_pagecache(vi, old_size);
+		i_size_write(vi, attr->ia_size);
+		pagecache_isize_extended(vi, old_size, attr->ia_size);
+	} else
+		truncate_setsize(vi, attr->ia_size);
+
 	err = ntfs_truncate_vfs(vi, attr->ia_size, old_size);
 	if (err) {
 		i_size_write(vi, old_size);
 		return err;
 	}
 
-	if (NInoNonResident(ni) && attr->ia_size > old_size &&
-	    old_size % PAGE_SIZE != 0) {
-		loff_t len = min_t(loff_t,
-				round_up(old_size, PAGE_SIZE) - old_size,
-				attr->ia_size - old_size);
-		err = iomap_zero_range(vi, old_size, len,
-				NULL, &ntfs_seek_iomap_ops,
-				&ntfs_iomap_folio_ops, NULL);
-	}
-
 	return err;
 }
 
@@ -1165,13 +1161,9 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t le
 		filemap_invalidate_unlock(vi->i_mapping);
 	if (!err) {
 		if (mode == 0 && NInoNonResident(ni) &&
-		    offset > old_size && old_size % PAGE_SIZE != 0) {
-			loff_t len = min_t(loff_t,
-					   round_up(old_size, PAGE_SIZE) - old_size,
-					   offset - old_size);
-			err = iomap_zero_range(vi, old_size, len, NULL,
-					       &ntfs_seek_iomap_ops,
-					       &ntfs_iomap_folio_ops, NULL);
+		    offset > old_size) {
+			truncate_pagecache(vi, old_size);
+			pagecache_isize_extended(vi, old_size, offset);
 		}
 		NInoSetFileNameDirty(ni);
 		inode_set_mtime_to_ts(vi, inode_set_ctime_current(vi));
-- 
2.25.1

