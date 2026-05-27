Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B222F6560;
	Wed, 27 May 2026 08:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779871735; cv=none; b=uGA9+MsPXe5nbzs8Jhq18wBXIo5l3vk7rR2Us8yYfFG4pJnnY3KlW28s3Bz5iuo1q6EpZPg3R6WTuvwS0JkeGovT1xZ8G623srsVjEnNpjEXDrFkMgAtahy+Gslz5MVt0aXANiDUCeicPel1QCA2MRpcXrJvEJOGiQ7QQMv6e4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779871735; c=relaxed/simple;
	bh=0NEe1fpBjvEOML8OtlSvPlZx2xId+Au52fZtgRJuxug=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=si2GuFeniPfe7ADVFlANluY8YYaekLkuRs2rrZfyNzgokHsyTochbyubZbVDwygjhCMMtbTPRDKuakyx3Eb1nXHb/AT7e3xuG0DBhf7auMS9TV0qHVnNhntVq4uIuDYGZqtSJVdTZkjr91aZGlmDvqNnQC466cgzfQVTqQrbVTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=UJGJ0WIm; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="UJGJ0WIm"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 23A72C4;
	Wed, 27 May 2026 08:48:54 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=UJGJ0WIm;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 9085F2158;
	Wed, 27 May 2026 08:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1779871731;
	bh=tkR1AHaTrjBlNO5JavwPUutUHPVC4uYCTgcq5wIPNko=;
	h=From:To:CC:Subject:Date;
	b=UJGJ0WImD1UThSQj0NWfe+oWdUZzUK/RI0f8yqZL8aiUaiOxeKxD/DO4P6T5GbDQT
	 oRLFp806vESUcnvmYlairOFAe61QOP0ZfVvnAHw1qnr6psD+KTXR6m3vd0y2wa5ms+
	 612p99kIJBc7Bm0+w7pRs5BLe6y5/rpHSTphIxOM=
Received: from localhost.localdomain (172.30.20.133) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 27 May 2026 11:48:50 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: reject SEEK_DATA and SEEK_HOLE past EOF early
Date: Wed, 27 May 2026 10:48:42 +0200
Message-ID: <20260527084842.7871-1-almaz.alexandrovich@paragon-software.com>
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

Handle non-data/hole seeks through generic_file_llseek_size() and return
-ENXIO immediately when SEEK_DATA or SEEK_HOLE is requested at or past
EOF. Handle compressed files in such cases properly as well.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/file.c    | 14 ++++++++------
 fs/ntfs3/frecord.c | 17 +++++++++++++----
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 06a5d9b44ac1..1b52447bd228 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -1008,7 +1008,7 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 		CLST lcn, clen;
 
 		frame = valid >> frame_bits;
-		frame_vbo = valid & ~(frame_size - 1);
+		frame_vbo = valid & ~(u64)(frame_size - 1);
 		off = valid & (frame_size - 1);
 
 		err = attr_data_get_block(ni, frame << NTFS_LZNT_CUNIT, 1, &lcn,
@@ -1077,7 +1077,7 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 		if (bytes > count)
 			bytes = count;
 
-		frame_vbo = pos & ~(frame_size - 1);
+		frame_vbo = pos & ~(u64)(frame_size - 1);
 		index = frame_vbo >> PAGE_SHIFT;
 
 		if (unlikely(fault_in_iov_iter_readable(from, bytes))) {
@@ -1530,7 +1530,12 @@ static loff_t ntfs_llseek(struct file *file, loff_t offset, int whence)
 	loff_t maxbytes = ntfs_get_maxbytes(ni);
 	loff_t ret;
 
-	if (whence == SEEK_DATA || whence == SEEK_HOLE) {
+	if (whence != SEEK_DATA && whence != SEEK_HOLE) {
+		ret = generic_file_llseek_size(file, offset, whence, maxbytes,
+					       i_size_read(inode));
+	} else if ((unsigned long long)offset >= i_size_read(inode)) {
+		ret = -ENXIO;
+	} else {
 		inode_lock_shared(inode);
 		/* Scan file for hole or data. */
 		ret = ni_seek_data_or_hole(ni, offset, whence == SEEK_DATA);
@@ -1538,9 +1543,6 @@ static loff_t ntfs_llseek(struct file *file, loff_t offset, int whence)
 
 		if (ret >= 0)
 			ret = vfs_setpos(file, ret, maxbytes);
-	} else {
-		ret = generic_file_llseek_size(file, offset, whence, maxbytes,
-					       i_size_read(inode));
 	}
 	return ret;
 }
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 78eb065c7e43..4b5dd3de327b 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2889,8 +2889,14 @@ loff_t ni_seek_data_or_hole(struct ntfs_inode *ni, loff_t offset, bool data)
 			 * the file offset is set to offset.
 			 */
 			if (lcn != SPARSE_LCN) {
-				vbo = (u64)vcn << cluster_bits;
-				return max(vbo, offset);
+				/* Normal cluster. */
+				break;
+			}
+
+			if ((ni->std_fa & FILE_ATTRIBUTE_COMPRESSED) &&
+			    (vcn & (NTFS_LZNT_CLUSTERS - 1))) {
+				/* Compressed cluster in compressed frame. */
+				break;
 			}
 		} else {
 			/*
@@ -2904,8 +2910,8 @@ loff_t ni_seek_data_or_hole(struct ntfs_inode *ni, loff_t offset, bool data)
 			    /* native compression hole begins at aligned vcn. */
 			    (!(ni->std_fa & FILE_ATTRIBUTE_COMPRESSED) ||
 			     !(vcn & (NTFS_LZNT_CLUSTERS - 1)))) {
-				vbo = (u64)vcn << cluster_bits;
-				return max(vbo, offset);
+				/* Hole in sparsed or compressed file frame. */
+				break;
 			}
 		}
 
@@ -2914,6 +2920,9 @@ loff_t ni_seek_data_or_hole(struct ntfs_inode *ni, loff_t offset, bool data)
 			return -EINVAL;
 		}
 	}
+
+	vbo = (u64)vcn << cluster_bits;
+	return max(vbo, offset);
 }
 
 /*
-- 
2.43.0

