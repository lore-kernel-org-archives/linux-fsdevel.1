Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8136F3F9299;
	Mon, 18 May 2026 11:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104950; cv=none; b=aKubFBD4IHLSBekqW4+rg7yz1fkxIClR3pzNlus1cxYa7vfpPMk/dFfRtcNTQx4mNs7NLj4wwQYzVKj+s+mqOFhp4V50gVORVlNuJexpJpL6WQf0FsQ5Qaa9n/TBGlvx5pLRF8IZPmSNF3CmNKqCkdRp8yrUmQ/gQixRP+9J0nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104950; c=relaxed/simple;
	bh=u4ifEVE/cXM9Cx9fsWHu7TnRtG9B3S8T13PH0eZWAGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hQPETv74fW69NPLuM/JMyg5mhLTA/zt2OmZDAThlI2bZPQY9TSJRVbqvPGQQiYHKml/mBJ2atqiputLEKJI4hHSS8/1FLuYHVxnCRva4Qiu2o/hTab5wCeTeuUgJVEfyWPO/qWy5pFOgwqiJq1wG/2H0TXUdpzPFMwxJurWy0G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhL9Nmtz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhL9Nmtz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507EFC2BCC6;
	Mon, 18 May 2026 11:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779104950;
	bh=u4ifEVE/cXM9Cx9fsWHu7TnRtG9B3S8T13PH0eZWAGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VhL9NmtzFN7vdkYNfcFuBZ7IwWJMsoGi1AnBvWp9JWwM/Pcq2YJ7VwaX63h9LfRPD
	 cor/Ffjmul0FAsv/5v7dMoCXg+9QKNlcWifR3l9umBEs0djHVmGovPBmtvvOTQWXez
	 TMGmpPue8DPSPTys39svpvt1xQx7srMHOVxJjwjjtV3upjwPSGKaTEM2p6ro7G7VaJ
	 wVVFJOdG2+ME5pBBND9hw9qygOdhqfWc62KjZPvAYylDpgrJX9DJ0Hpli0Nq3vqbYM
	 BR0l73nfW8YJhUA+DdV2TfrP+rrgOBcgeHmgnY5+gRQfxLbxHEuYntqzmZ+9mDGUJi
	 wHCsZVOpXBxKA==
From: Namjae Jeon <linkinjeon@kernel.org>
To: sj1557.seo@samsung.com,
	yuezhang.mo@sony.com,
	brauner@kernel.org,
	djwong@kernel.org,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	anmuxixixi@gmail.com,
	dxdt@dev.snart.me,
	chizhiling@kylinos.cn,
	chizhiling@163.com,
	linux-kernel@vger.kernel.org,
	charsyam@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v4 10/11] exfat: add support for SEEK_HOLE and SEEK_DATA in llseek
Date: Mon, 18 May 2026 20:47:04 +0900
Message-Id: <20260518114705.9601-11-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260518114705.9601-1-linkinjeon@kernel.org>
References: <20260518114705.9601-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds exfat_file_llseek() that implements these whence values via
the iomap layer (iomap_seek_hole() and iomap_seek_data()) using the
existing exfat_read_iomap_ops.
Unlike many other modern filesystems, exFAT does not support sparse files
with unallocated clusters (holes). In exFAT, clusters are always fully
allocated once they are written or preallocated. In addition, exFAT
maintains a separate "Valid Data Length" (valid_size) that is distinct
from the logical file size. This affects how holes are reported during
seeking. In exfat_iomap_begin(), ranges where the offset is greater
than or equal to ei->valid_size are mapped as IOMAP_UNWRITTEN, while ranges
below valid_size are mapped as IOMAP_MAPPED. This mapping behavior is used
by the iomap seek functions to correctly report SEEK_HOLE and SEEK_DATA
positions.

   - Ranges with offset >= ei->valid_size are mapped as IOMAP_HOLE.
   - Ranges with offset < ei->valid_size are mapped as IOMAP_MAPPED.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/exfat/file.c  | 25 ++++++++++++++++++++++++-
 fs/exfat/iomap.c | 32 ++++++++++++++++++++++++++++----
 2 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index e5529d0698db..d9c4e8dd9fd8 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -917,9 +917,32 @@ static int exfat_file_open(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static loff_t exfat_file_llseek(struct file *file, loff_t offset, int whence)
+{
+	struct inode *inode = file->f_mapping->host;
+
+	switch (whence) {
+	case SEEK_HOLE:
+		inode_lock_shared(inode);
+		offset = iomap_seek_hole(inode, offset, &exfat_iomap_ops);
+		inode_unlock_shared(inode);
+		break;
+	case SEEK_DATA:
+		inode_lock_shared(inode);
+		offset = iomap_seek_data(inode, offset, &exfat_iomap_ops);
+		inode_unlock_shared(inode);
+		break;
+	default:
+		return generic_file_llseek(file, offset, whence);
+	}
+	if (offset < 0)
+		return offset;
+	return vfs_setpos(file, offset, inode->i_sb->s_maxbytes);
+}
+
 const struct file_operations exfat_file_operations = {
 	.open		= exfat_file_open,
-	.llseek		= generic_file_llseek,
+	.llseek		= exfat_file_llseek,
 	.read_iter	= exfat_file_read_iter,
 	.write_iter	= exfat_file_write_iter,
 	.unlocked_ioctl = exfat_ioctl,
diff --git a/fs/exfat/iomap.c b/fs/exfat/iomap.c
index c6841ad0b1cc..61a1b6aba860 100644
--- a/fs/exfat/iomap.c
+++ b/fs/exfat/iomap.c
@@ -98,12 +98,36 @@ static int __exfat_iomap_begin(struct inode *inode, loff_t offset, loff_t length
 			iomap->flags = IOMAP_F_ZERO_TAIL;
 		}
 	} else {
+		/*
+		 * valid_size is tracked in byte granularity and
+		 * marks the exact boundary between valid data and
+		 * holes (or unwritten space).
+		 *
+		 * When IOMAP_REPORT is set (used by lseek(SEEK_HOLE)
+		 * and SEEK_DATA), we return IOMAP_HOLE. This allows
+		 * iomap_seek_hole_iter() to directly return the
+		 * precise byte position.
+		 *
+		 * For normal I/O paths (without IOMAP_REPORT) we
+		 * return IOMAP_UNWRITTEN so the write path can
+		 * distinguish it from a real hole.
+		 */
 		if (offset >= ei->valid_size) {
-			iomap->type = IOMAP_UNWRITTEN;
+			iomap->type = flags & IOMAP_REPORT ?
+				IOMAP_HOLE : IOMAP_UNWRITTEN;
 		} else if (offset + iomap->length > ei->valid_size) {
-			iomap->length = round_up(ei->valid_size,
-						 i_blocksize(inode)) -
-							iomap->offset;
+			if (flags & IOMAP_REPORT) {
+				/*
+				 * For SEEK_HOLE/SEEK_DATA, clip the length
+				 * to the exact byte boundary (valid_size).
+				 * This ensures the caller gets the precise
+				 * hole position in byte units.
+				 */
+				iomap->length = ei->valid_size - iomap->offset;
+			} else
+				iomap->length = round_up(ei->valid_size,
+							 i_blocksize(inode)) -
+								iomap->offset;
 		}
 	}
 
-- 
2.25.1

