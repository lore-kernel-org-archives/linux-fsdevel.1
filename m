Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.54.11.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793465066;
	b=ShgKLCuocg2jQXeKJ8vD6zvTMl6UpUqjRxO3UgyoyIZVYyi1yzOyUG48GaLkNHJUInNW
	 M0+kQRuajb0wmiuMdEXaI4pvRoAw3ih68AQP0IgE4YKAkli/DFPtVOQWk4q6nAxwCYxKJ
	 I3dIEgWDh2NQrahDvaNuwhEPghImAIAdbAlDZRqIpVY58+WWmiMbnVVaoqpYfCIkcMsj6
	 rFANIqGWxN7hogwRAeVV4XDE2saSfwyTnsKwV6z5/H5Z5can8XYT/eFYBrJzkzZuv1jjL
	 otYslI8q+CKmMCHGzbohOUx6lGIY5XPuZrcksLehNqarsuRyzcN5s3IhxMQ8prQ5nrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793465066;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wSe/SolztyUq7H3+XO4z4+YzyJNozvq3slAt6576OrE=;
	b=12izpE3Z6QYqj9b4uCaE0ktLSn0Q51pXbCoaD5tVsv1oxCaQpWF+WQbNxn8MxPevWYMw
	 LCQlivXpM/XIOx48rFidXKQJYzE0Z8Z8+EoXynjtjOXverPjmdLLIH26sOCaPhzhDk8UQ
	 0JqmDmI/+JHbO0Utthy/jgW8VJ8tRdzYQm6/kZ8RQTZJW/OeQoza02EKw5hR88UOjEiwc
	 KDgS6efs6hVnCS2uLYUy/ooksq8WVVfQWqOGFZkWFPsrsD4LSWuviDG/TfXfpwrrODiBf
	 phRAjZs5IUmLnDKYv97WIrkDCFVaTmxUdfVZthls1gKv/y6ZGtyrBAkYBqkeB8iP+TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inf.ufrgs.br;
	spf=pass smtp.mailfrom=inf.ufrgs.br;
	dkim=pass header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=nug27DK7;
	arc=none smtp.remote-ip=143.54.11.23
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073D2606A325;
	Sat, 31 Oct 2026 16:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 073D2606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=nug27DK7
Received: from LAPTOP-R01LEAQM.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id DD3831203F7;
	Sat, 31 Oct 2026 13:43:49 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1793465029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wSe/SolztyUq7H3+XO4z4+YzyJNozvq3slAt6576OrE=;
	b=nug27DK7q4ls6vqhnnHZkwdQSGm1J2ErrC03woGzxfUkumrDAOjvBseJ1DowtUFLYq4O2o
	b/8uCBCuC6pVR+zavzXpQyrrj2Ey0NKULLGIhm/ssAjI3DzcAjPnjnE6cGdN3OYJP/1mqF
	33dmreTRtFw2n5pmzQLoMOH6Htc+0xo1E0yj/x0V3rRsfowGN5ZZKUsaU46NbaG887X0at
	52rGP03cC1GVVSx6S7bzbdCDdYEF31SjQ4XvcVSXrl+tHw412e7iHs+dqpWMRYHQdkc4h5
	KrJkqtveSnHY9kd+dsjOz0FFMqvcEFOQzL6iRPJasRehOQnevD3/0g2eqDpLgw==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	djwong@kernel.org,
	hch@lst.de,
	linux-kernel@vger.kernel.org,
	Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Subject: [RFC PATCH 5/8] fat: drop ->write_begin() and ->write_end() usage from fat_cont_expand()
Date: Sat, 31 Oct 2026 13:43:23 -0300
Message-ID: <20261031164326.278125-6-matheus.aalmeida@inf.ufrgs.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261031164326.278125-1-matheus.aalmeida@inf.ufrgs.br>
References: <20261031164326.278125-1-matheus.aalmeida@inf.ufrgs.br>
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

fat_cont_expand() currently relies on ->write_begin() and ->write_end()
to zero the new file range. These callbacks will no longer be available
after the iomap conversion, so a new method for zeroing is needed.

Zero new ranges folio-by-folio instead.

Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
---
 fs/fat/file.c | 122 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 76 insertions(+), 46 deletions(-)

diff --git a/fs/fat/file.c b/fs/fat/file.c
index 177a26186ddc..8689cbbdad13 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -18,6 +18,8 @@
 #include <linux/security.h>
 #include <linux/falloc.h>
 #include <linux/fileattr.h>
+#include <linux/rmap.h>
+#include <linux/writeback.h>
 #include "fat.h"
 
 static long fat_fallocate(struct file *file, int mode,
@@ -353,68 +355,96 @@ static int fat_preallocate(struct inode *inode, loff_t new_size)
 	return fat_add_clusters(inode, nr_cluster);
 }
 
-static int fat_cont_expand_simple(struct inode *inode, loff_t size)
+static int fat_zero_and_extend(struct inode *inode, loff_t new_size)
 {
+	struct msdos_inode_info *mi = MSDOS_I(inode);
 	struct address_space *mapping = inode->i_mapping;
-	const struct address_space_operations *aops = mapping->a_ops;
+	loff_t pos = i_size_read(inode), fpos, next;
+	loff_t old_size = pos;
 	struct folio *folio;
-	void *fsdata = NULL;
-	int err;
+	size_t from, to;
+	pgoff_t index;
 
-	err = aops->write_begin(NULL, mapping, size, 0, &folio, &fsdata);
-	if (err)
-		goto out;
+	while (pos < new_size) {
+		index = pos >> PAGE_SHIFT;
 
-	err = aops->write_end(NULL, mapping, size, 0, 0, folio, fsdata);
+		folio = read_mapping_folio(mapping, index, NULL);
+		if (IS_ERR(folio))
+			return PTR_ERR(folio);
 
-out:
-	return err;
+		folio_lock(folio);
+		if (folio->mapping != mapping) {
+			folio_unlock(folio);
+			folio_put(folio);
+			continue;
+		}
+		folio_wait_stable(folio);
+
+		fpos = folio_pos(folio);
+		next = min_t(loff_t, new_size, fpos + folio_size(folio));
+		from = pos - fpos;
+		to = next - fpos;
+
+		/*
+		 * An existing shared writeable mmap of the file could allow
+		 * writing into the newly zeroed range, so make it read-only.
+		 */
+		if (pos == old_size && from)
+			folio_mkclean(folio);
+
+		folio_zero_segment(folio, from, to);
+		folio_mark_dirty(folio);
+		mi->mmu_private = max(mi->mmu_private, next);
+		i_size_write(inode, next);
+
+		folio_unlock(folio);
+		folio_put(folio);
+
+		balance_dirty_pages_ratelimited(mapping);
+		if (fatal_signal_pending(current))
+			return -EINTR;
+
+		pos = next;
+	}
+
+	return 0;
 }
 
-static int fat_cont_expand(struct inode *inode, loff_t size)
+static int fat_cont_expand(struct inode *inode, loff_t new_size)
 {
-	struct address_space *mapping = inode->i_mapping;
-	loff_t start = inode->i_size, count = size - inode->i_size;
+	struct msdos_inode_info *mi = MSDOS_I(inode);
+	loff_t old_alloc = inode_get_bytes(inode);
+	loff_t old_size = i_size_read(inode);
+	loff_t old_mmu_private = mi->mmu_private;
 	int err;
 
-	/*
-	 * Preallocating space here is more efficient than during
-	 * fat_cont_expand_simple() because of batching.
-	 */
-	err = inode_newsize_ok(inode, size);
-	if (err)
-		goto out;
-	err = fat_preallocate(inode, size);
-	if (err)
-		goto out;
-	err = fat_cont_expand_simple(inode, size);
+	err = inode_newsize_ok(inode, new_size);
 	if (err)
-		goto out;
+		return err;
+	inode_dio_wait(inode);
+	err = fat_preallocate(inode, new_size);
+	if (err) {
+		/* fat_chain_add() does not rollback on failure */
+		fat_truncate_blocks(inode, old_alloc);
+		return err;
+	}
+	err = fat_zero_and_extend(inode, new_size);
+	if (err) {
+		filemap_invalidate_lock(inode->i_mapping);
+		truncate_setsize(inode, old_size);
+		fat_truncate_blocks(inode, old_alloc);
+		mi->mmu_private = old_mmu_private;
+		filemap_invalidate_unlock(inode->i_mapping);
+		return err;
+	}
 
 	fat_truncate_time(inode, NULL, FAT_UPDATE_CMTIME);
+	mi->i_attrs |= ATTR_ARCH;
 	mark_inode_dirty(inode);
-	if (IS_SYNC(inode)) {
-		int err2;
+	if (IS_SYNC(inode))
+		return write_inode_now(inode, 1);
 
-		/*
-		 * Opencode syncing since we don't have a file open to use
-		 * standard fsync path.
-		 */
-		err = filemap_fdatawrite_range(mapping, start,
-					       start + count - 1);
-		err2 = mmb_sync(&MSDOS_I(inode)->i_metadata_bhs);
-		if (!err)
-			err = err2;
-		err2 = write_inode_now(inode, 1);
-		if (!err)
-			err = err2;
-		if (!err) {
-			err =  filemap_fdatawait_range(mapping, start,
-						       start + count - 1);
-		}
-	}
-out:
-	return err;
+	return 0;
 }
 
 /*
-- 
2.43.0

