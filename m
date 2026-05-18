Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A5A1D5147;
	Mon, 18 May 2026 11:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104917; cv=none; b=JT9Kv1myKk/i5uyzEfaYa8ClmT+FNXLMeLQ66JW7/1Se5v3KXbcJ2+pL3ThbBQdJYaT49eemHBDJrx6LRIZrsO9va4Kaw1sXs1Zt4HLLG7KMge5nwqwbM2ZyQM4OsPOC91oV80Ede5Xr66CKrenrp92loGAK9BK2MjJELZoCJsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104917; c=relaxed/simple;
	bh=Tznz0eNh767FZfB9iN4IZkkSAhVO25nd3+3iQePiJzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EnIsRnhgtp/sNxHbSH+ii4xTm87JZhTsaJe4UZR8kfZ/yUy28h96SQIoVOGdAzx06n7sj2YbeV7yXXCVN2TN2ZmqZGOt02rTZAuQbIlz6Kjp/SFjpG7mTmEVQy1Y9v0g/zk0KCgwuT3SPbMxaV1oTDtdGbphPIKNdPoAUCHsrIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsfRIDFs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsfRIDFs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6A6C2BCB7;
	Mon, 18 May 2026 11:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779104917;
	bh=Tznz0eNh767FZfB9iN4IZkkSAhVO25nd3+3iQePiJzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hsfRIDFsD/jWaT83GnZP0NxG8BDbyUwH56V/qhboZEjteIAe7Cqr77XGo7ga01V1w
	 uC8Ks1/4eaGIV4mrw19LsV3HZNE/6EFNmpGZwPb1VNlKGYjfBRWD+6rz0hr2gLOT5I
	 se72mCbJYRsQ1SWKmrmj5NXhQgxuOeLE4niZefqqGbXz/QxZeC9mKnWE3BOS66Vj6q
	 Mb8RG8hhkeRjEuI34j/giJUxyc4VN6r2nWAD7a5mnu4OmS8r3H0xeWp/Rf0NkYsQul
	 jnp3Z3cvfFEDbFllLUUHmzGlopuaLhyV67cQQ7wU+J84neSIywZcEENRJ3TP/v2ARY
	 a1u0Qo0r7aOkQ==
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
Subject: [PATCH v4 01/11] iomap: introduce IOMAP_F_ZERO_TAIL flag
Date: Mon, 18 May 2026 20:46:55 +0900
Message-Id: <20260518114705.9601-2-linkinjeon@kernel.org>
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

In filesystems that maintain a separate Valid Data Length, such as exFAT
and NTFS, a partial write may start at or beyond the current valid_size and
extend it. In this case, the region after the previous valid_size but
within the same filesystem block is considered unwritten.

This patch introduces IOMAP_F_ZERO_TAIL. When this flag is set in iomap,
__iomap_write_begin() will zero only the tail portion while preserving any
valid data before it in the same block.

Without this tail zeroing, stale data in the unwritten portion of the block
can remain in the page cache. Subsequent reads can then return incorrect
contents from that region.

Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/iomap/buffered-io.c | 4 ++++
 include/linux/iomap.h  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d7b648421a70..44046c648df4 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -836,6 +836,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter,
 				return -EIO;
 			folio_zero_segments(folio, poff, from, to, poff + plen);
 		} else {
+			const struct iomap *iomap = iomap_iter_srcmap(iter);
 			int status;
 
 			if (iter->flags & IOMAP_NOWAIT)
@@ -853,6 +854,9 @@ static int __iomap_write_begin(const struct iomap_iter *iter,
 						  len, status, GFP_NOFS);
 			if (status)
 				return status;
+
+			if (iomap->flags & IOMAP_F_ZERO_TAIL)
+				folio_zero_segment(folio, to, poff + plen);
 		}
 		iomap_set_range_uptodate(folio, poff, plen);
 	} while ((block_start += plen) < block_end);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 2c5685adf3a9..750602e18750 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -67,6 +67,9 @@ struct vm_fault;
  * bio, i.e. set REQ_ATOMIC.
  *
  * IOMAP_F_INTEGRITY indicates that the filesystems handles integrity metadata.
+ *
+ * IOMAP_F_ZERO_TAIL indicates the remainder of the block after the data
+ * written should be zeroed.
  */
 #define IOMAP_F_NEW		(1U << 0)
 #define IOMAP_F_DIRTY		(1U << 1)
@@ -86,6 +89,7 @@ struct vm_fault;
 #else
 #define IOMAP_F_INTEGRITY	0
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
+#define IOMAP_F_ZERO_TAIL	(1U << 10)
 
 /*
  * Flag reserved for file system specific usage
-- 
2.25.1

