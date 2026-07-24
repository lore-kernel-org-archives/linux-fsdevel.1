Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ACB42DA59;
	Fri, 24 Jul 2026 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784891728; cv=none; b=nmsZ/MOk7vg24c5s8tfsR/xIQAuEoLYlw4NQZ+qolZIaGxbUNvHHpxXkVKgBLMHUlHJmt42kj4sqt1vi145HDlnQTLpVclG6DUPo/vpYqHoQD8vSEeRgzrVBDI58K55vSVd87X+tlobwIK035BOspVNiMXVAhR0/fqOh3+Ltiug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784891728; c=relaxed/simple;
	bh=ww/v4fzv5EDmwMlYp+tkHIbnW2c2KxLoPaCqSW+TIqg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QltYLrJC1lim/hJZVUtwITY5Ce90l/4bS+mNogkRGq+uVBoSn+KhCCuQMFk/yrEPRks0MrJyCAh2Hs517uaXJj2AbxL0JXlRuuRxIvUPaUedd2AP+iKW14zXHEJXbj0wiSAQpAwxACV+4Cq2p0HliRhmaI+fg/lclxzs0MVihZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=ijAA4aXx; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="ijAA4aXx"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id B662E241;
	Fri, 24 Jul 2026 11:15:43 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=ijAA4aXx;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 5178F37;
	Fri, 24 Jul 2026 11:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1784891723;
	bh=F6a+/dl3M+yQdXY+2LCypHdAs5IML542OtLCKH+q/es=;
	h=From:To:CC:Subject:Date;
	b=ijAA4aXxBTWkSJKYdzkoEvIAQOv8iSOtqXfHJzgrgHmCTmlPfAU8nFcuEys0F10fC
	 VC+7tN0XnoKvLNO7Dz/tVH5RY977YV0CTLstuo8rXZ1WxmwBi9bEY/bOnukHp3AxQZ
	 +fecuapGtsLBXYKyb9Hxvo3nPmv0Ly36hz+/rav0=
Received: from localhost.localdomain (172.30.20.208) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 24 Jul 2026 14:15:21 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: Rename 'err' to 'ret' in read paths
Date: Fri, 24 Jul 2026 13:15:13 +0200
Message-ID: <20260724111513.14766-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

ntfs_file_read_iter() and ntfs_file_splice_read() store both error codes
and the number of bytes transferred in a variable named 'err', which is
misleading on the success path. Rename it to 'ret'.

While here, rename the 'in' parameter of ntfs_file_splice_read() to
'file' for consistency with the rest of the file, and add a local 'ni'
instead of calling ntfs_i() inline.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/file.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index fa8e2e56ff3f..1eda8c31b054 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -820,11 +820,11 @@ static ssize_t ntfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	size_t bytes = iov_iter_count(iter);
 	loff_t valid, i_size, vbo, end;
 	unsigned int dio_flags;
-	ssize_t err;
+	ssize_t ret;
 
-	err = check_read_restriction(inode);
-	if (err)
-		return err;
+	ret = check_read_restriction(inode);
+	if (ret)
+		return ret;
 
 	if (!bytes)
 		return 0; /* skip atime */
@@ -867,17 +867,17 @@ static ssize_t ntfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 		if (ni->file.run_da.count) {
 			/* Direct I/O is not compatible with delalloc. */
-			err = ni_allocate_da_blocks(ni);
-			if (err)
+			ret = ni_allocate_da_blocks(ni);
+			if (ret)
 				goto out;
 		}
 
-		err = iomap_dio_rw(iocb, iter, &ntfs_iomap_ops, NULL, dio_flags,
+		ret = iomap_dio_rw(iocb, iter, &ntfs_iomap_ops, NULL, dio_flags,
 				   NULL, 0);
 
-		if (err <= 0)
+		if (ret <= 0)
 			goto out;
-		end = vbo + err;
+		end = vbo + ret;
 		if (valid < end) {
 			size_t to_zero = end - valid;
 			/* Fix iter. */
@@ -889,35 +889,36 @@ static ssize_t ntfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 			bytes = i_size - vbo;
 		iov_iter_zero(bytes, iter);
 		iocb->ki_pos += bytes;
-		err = bytes;
+		ret = bytes;
 	}
 
 out:
 	inode_unlock_shared(inode);
 	file_accessed(file);
-	return err;
+	return ret;
 }
 
 /*
  * ntfs_file_splice_read - file_operations::splice_read
  */
-static ssize_t ntfs_file_splice_read(struct file *in, loff_t *ppos,
+static ssize_t ntfs_file_splice_read(struct file *file, loff_t *ppos,
 				     struct pipe_inode_info *pipe, size_t len,
 				     unsigned int flags)
 {
-	struct inode *inode = file_inode(in);
-	ssize_t err;
+	struct inode *inode = file_inode(file);
+	struct ntfs_inode *ni = ntfs_i(inode);
+	ssize_t ret;
 
-	err = check_read_restriction(inode);
-	if (err)
-		return err;
+	ret = check_read_restriction(inode);
+	if (ret)
+		return ret;
 
-	if (is_compressed(ntfs_i(inode))) {
+	if (is_compressed(ni)) {
 		/* Turn off readahead for compressed files. */
-		in->f_ra.ra_pages = 0;
+		file->f_ra.ra_pages = 0;
 	}
 
-	return filemap_splice_read(in, ppos, pipe, len, flags);
+	return filemap_splice_read(file, ppos, pipe, len, flags);
 }
 
 /*
-- 
2.43.0

