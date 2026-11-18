Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=143.54.11.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794967361;
	b=f3e6MdxJHo+dg8Ffpk0nKobxLWiiTHjo6PVhLLeXeX92n0dgZ6JTo5AfwjeSNecqFbT3
	 yWfzvoB+K0Bp/nIJSf1Tfnpr5i37XD0ROghXoi7tWhfFMyfv46wvOV/l9v7zBNIc8F+x4
	 PJOdNc1AyNUkbasIJnLeCbdGSQQafinAlcicSyUFs6aCq8EyM9NtqP3VCViHqWPrZkmzD
	 3ESeuDYP3IDd+GW0MiT3zeWHfcGO/7wmSfJx5MsYWf2bHWDKcNhxn1jC61tNxM0caQOjX
	 EIk7xr/gXIThYfPYMZ4nilIITHP84HCQDrJv7thYXy8fYNnKIVjB9SEYx3VOikStvlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794967361;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mEcIysdfxBXozQzUlQVnw+tOetJtMdNHx+THCbHGwJI=;
	b=rPvpcR50rDSqQCnUjR5WrcdQuJaGeduj3S4DWoXeqrKdJwNWAsFoMeR6xwTLUDUduFy/
	 K0DBcYTUikICrMEUczGGlxqcTMmJP7x93cyKhsI+HXPe3d0OesQ56slNe3IWPSPnyEoUV
	 C+frOCkNOqfxbmElm58O/VIYWa1sYsMg+RyJJwAIbOSTCD8evHRWpK0GtkTUextGy3OFq
	 dwY+5OcovwKxNS3DbWLbdk/V60fkYrzvzjf1G3rVBBfgGJPjqD13SYsW4KXUnEYrcl1HG
	 dQ0mfSQTldgtL9hSiiMgUHmNlmPaXCMZ+edxq5V154zd/9RS+OzCVAkZvtl2DzQYHTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inf.ufrgs.br;
	spf=pass smtp.mailfrom=inf.ufrgs.br;
	dkim=pass header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=Xfy4sVS+;
	arc=none smtp.remote-ip=143.54.11.23
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBF9606A31C;
	Wed, 18 Nov 2026 02:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFBF9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.a=rsa-sha256 header.s=dkim2026 header.b=Xfy4sVS+
Received: from LAPTOP-R01LEAQM.localdomain (unknown [189.6.233.4])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 593911210EE;
	Tue, 17 Nov 2026 23:02:06 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1794967326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mEcIysdfxBXozQzUlQVnw+tOetJtMdNHx+THCbHGwJI=;
	b=Xfy4sVS+hRfrN0uRf1bgxdFr7UE22T2mcrnRXLcSCQ5mZmBjmmi2UlvsIOfFvLDPjg69wN
	IovFtsZllzIO5rQId9+oDX6koCSGoSWTw4E6ELOiI80IFmkOr1icO2LatR0qQPU5SvoHsW
	sA2Fjt6onDPHS1rQpgKkuZnnmQ5lfQzc4em6QYXVdPjSGg9s4ouTI3FF7UsjDT8TaVbYWX
	dNwiYoQIbwJrz8NNuP8Esgr7f5jXiKXINvxN6+eZ78eVIzeRXS+CF/UDJqgpVKrkbryS5L
	ZvfAlL2VWkdDPvEL372fhUqqYd1oDe88VUwzFCOabaiqhCnfHjjzvVHHN7/o3g==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	djwong@kernel.org,
	hch@lst.de,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 5/8] fat: drop ->write_begin() and ->write_end() usage from fat_cont_expand()
Date: Tue, 17 Nov 2026 23:01:45 -0300
Message-ID: <20261118020150.1023865-6-matheus.aalmeida@inf.ufrgs.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118020150.1023865-1-matheus.aalmeida@inf.ufrgs.br>
References: <20261118020150.1023865-1-matheus.aalmeida@inf.ufrgs.br>
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
 fs/fat/file.c | 139 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 93 insertions(+), 46 deletions(-)

diff --git a/fs/fat/file.c b/fs/fat/file.c
index 17638f283..83a066b50 100644
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
@@ -342,68 +344,113 @@ static int fat_preallocate(struct inode *inode, loff_t new_size)
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
+
+	while (pos < new_size) {
+		index = pos >> PAGE_SHIFT;
+
+		folio = __filemap_get_folio(mapping, index, FGP_LOCK | FGP_CREAT,
+					    mapping_gfp_mask(mapping));
+		if (IS_ERR(folio))
+			return PTR_ERR(folio);
+
+		if (!folio_test_uptodate(folio) && folio_pos(folio) < pos) {
+			folio_unlock(folio);
+			folio_put(folio);
+
+			folio = read_mapping_folio(mapping, index, NULL);
+			if (IS_ERR(folio))
+				return PTR_ERR(folio);
+
+			folio_lock(folio);
+			if (folio->mapping != mapping) {
+				folio_unlock(folio);
+				folio_put(folio);
+				continue;
+			}
+		}
+		folio_wait_stable(folio);
 
-	err = aops->write_begin(NULL, mapping, size, 0, &folio, &fsdata);
-	if (err)
-		goto out;
+		fpos = folio_pos(folio);
+		next = min_t(loff_t, new_size, fpos + folio_size(folio));
+		from = pos - fpos;
+		to = next - fpos;
 
-	err = aops->write_end(NULL, mapping, size, 0, 0, folio, fsdata);
+		/*
+		 * An existing shared writeable mmap of the file could allow
+		 * writing into the newly zeroed range, so make it read-only.
+		 */
+		if (pos == old_size && from)
+			folio_mkclean(folio);
+
+		if (folio_test_uptodate(folio)) {
+			folio_zero_segment(folio, from, to);
+		} else {
+			folio_zero_segment(folio, 0, folio_size(folio));
+			folio_mark_uptodate(folio);
+		}
+		folio_mark_dirty(folio);
+		mi->mmu_private = max(mi->mmu_private, next);
+		i_size_write(inode, next);
 
-out:
-	return err;
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
+		if (err != -ENOSPC || inode_get_bytes(inode) > old_alloc)
+			fat_truncate_blocks(inode, old_alloc);
+		return err;
+	}
+	err = fat_zero_and_extend(inode, new_size);
+	if (err) {
+		filemap_invalidate_lock(inode->i_mapping);
+		truncate_setsize(inode, old_size);
+		if (inode_get_bytes(inode) > old_alloc)
+			fat_truncate_blocks(inode, old_alloc);
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

