Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C599D39A04C;
	Thu,  7 May 2026 12:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778157915; cv=none; b=T8qzyvLa2Vvl7d5NkziSafOmwLUa3kUX1NW6DnM2uJLIV1ySdcqHw5Q9yGi2TCzR95EOmIOwU/YpoWWQlG1Ga+HiXIM2XgPLfG1AjvKLR198ZTUtIaEjj3HOauBv1pFghXpF13lUUgKaIlwMZPKGsZDGibQ5FpvgMTlFHlABmME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778157915; c=relaxed/simple;
	bh=+/ypl/zNHou/Jp8yX+qXMJHwTHS775TiCo6L63Xpsz8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A+Gros6xqrbwM0TMXoheENKZ/rHCDmX1/GHJULkhLDJYL0vmwntRGspdwcz2sWc9D6iNQEloOKC2CkZ9LPIQ6QbtpvuHXfpsMvQtWu044SHbzaQ0QFZDZk6YOe7TItT1W7WbcplKiorB/zuat41l1tHhvasQ97sbTbRBnF7+Dmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5XNcgn8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5XNcgn8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D46C2BCC4;
	Thu,  7 May 2026 12:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778157914;
	bh=+/ypl/zNHou/Jp8yX+qXMJHwTHS775TiCo6L63Xpsz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p5XNcgn8PV3zlubWnHz7+WMNKBPyZumzdCEpEGqrF+WkCd7GlIHVyOfLNyVCJk7S/
	 /c0CqKPhe2XaUOD56LW/sW1fL/THWv3MfOHj/9zQ5BO8y4WIBCW3KkgZQj70Brj0UK
	 ZNQFCxbnYLvrcsz7tc+rcIr6FzmRpuDEsDukld411ViEQm+YVCVYWh8p5hBYeNckuY
	 0MjKwapu7B1JCQjGqYrTH3N2JxfxTGY/+F1LZloNUsNmr42N/y77nwb675GU0p86Jz
	 n8nJ8qBqGeWkOF9Rea8pFQXftlMSJ1iamj1VF4yLJMwfV/sHowacTbcvz9zA84lF/9
	 KlfUrlf/dAkxA==
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
	linux-kernel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v2 9/9] exfat: add support for SEEK_HOLE and SEEK_DATA in llseek
Date: Thu,  7 May 2026 21:42:38 +0900
Message-Id: <20260507124238.7313-10-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260507124238.7313-1-linkinjeon@kernel.org>
References: <20260507124238.7313-1-linkinjeon@kernel.org>
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

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/exfat/file.c  | 25 ++++++++++++++++++++++++-
 fs/exfat/iomap.c | 32 ++++++++++++++++++++++++++++----
 2 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index c4e6afc21bfe..c1567d206253 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -911,9 +911,32 @@ static int exfat_file_open(struct inode *inode, struct file *filp)
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
index 69308d66c55a..9b1499a30d39 100644
--- a/fs/exfat/iomap.c
+++ b/fs/exfat/iomap.c
@@ -79,15 +79,39 @@ static int __exfat_iomap_begin(struct inode *inode, loff_t offset, loff_t length
 		else if (iomap->offset + iomap->length >= ei->valid_size)
 			iomap->flags = IOMAP_F_ZERO_TAIL;
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
 		if (offset >= ei->valid_size)
-			iomap->type = IOMAP_UNWRITTEN;
+			iomap->type = flags & IOMAP_REPORT ?
+				IOMAP_HOLE : IOMAP_UNWRITTEN;
 
 		if (iomap->type == IOMAP_MAPPED &&
 		    iomap->offset < ei->valid_size &&
 		    iomap->offset + iomap->length > ei->valid_size) {
-			iomap->length = round_up(ei->valid_size,
-						 1 << inode->i_blkbits) -
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
+							 1 << inode->i_blkbits) -
+								iomap->offset;
 		}
 	}
 
-- 
2.25.1

