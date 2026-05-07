Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA10E3AB262;
	Thu,  7 May 2026 12:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778157897; cv=none; b=qPBao5e8h738BxrkC+e92yovJkOruQC8srx9d5ZpMaLde6eqlwiH9yHqo8Pcluwv0OC/e/6SV0z7CAHpsEp0FrpgrUL5s8smNE+c/NrVbNchfp+jLZ0KiVZ7pe0URmch7wP3wh8Vpd94DW9Mn8fDpqAoTtBJbkKXlwk+Q4sb+us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778157897; c=relaxed/simple;
	bh=CVxGxcnAW5/o9BqN0DaMgSSTzT0Xe9tR5fS9KdRLbLs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nwcT3Ayaq+ipR29rdGTZVaMrY0u2TQPSeBNqnNTgfN2sTf+SHXVKkgfZWOjFsegiykfZDV2/bLbq74hiVz0bjhb17YCRPLozeYbUz4d0FwRcLVX2iy1NQv5LRiqCccJOU9/bnwm4COyZebIZU2rt+WCAEXZNjLXlWYCEPuU1ZVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1HCw/VH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1HCw/VH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20785C2BCB8;
	Thu,  7 May 2026 12:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778157896;
	bh=CVxGxcnAW5/o9BqN0DaMgSSTzT0Xe9tR5fS9KdRLbLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y1HCw/VH7msnp8F/8RPA6UmS6E6aHtliR0znmZ5R25UqJBfb5BuYaZsYFwDZREO9n
	 5tKkRv7NsMct1DnvcLykQRgeP4dJpndHNtWfoOAsLAs71D/jDkBIq8sIJM8/XZAOB1
	 4EiADMIBjz2PAfxQNqTfD6aUZ7UZZ0tPpc7YHsKuaWjgwCayFaRujWV9Q9fiIaHaaV
	 Jbb2sXoVNaRIh5RRp3f9kVoxmbjmsL7N8PRuz5jt/Lg/qwHeEauWWd6qjKJZgsNTAR
	 DBsp1rWUEsUmJfq2NbDqeJOGy6W/i8CuuKYgjt0RIY3FwrR/o84gmDAgNxiPRSSMYb
	 8apuufMQlqRcQ==
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
Subject: [PATCH v2 5/9] iomap: introduce IOMAP_F_ZERO_TAIL flag
Date: Thu,  7 May 2026 21:42:34 +0900
Message-Id: <20260507124238.7313-6-linkinjeon@kernel.org>
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

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/iomap/buffered-io.c | 4 ++++
 include/linux/iomap.h  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d7b648421a70..9ae136a9fcd4 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -837,6 +837,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter,
 			folio_zero_segments(folio, poff, from, to, poff + plen);
 		} else {
 			int status;
+			const struct iomap *iomap = iomap_iter_srcmap(iter);
 
 			if (iter->flags & IOMAP_NOWAIT)
 				return -EAGAIN;
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
index 2c5685adf3a9..e3e7ad72b29e 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -67,6 +67,9 @@ struct vm_fault;
  * bio, i.e. set REQ_ATOMIC.
  *
  * IOMAP_F_INTEGRITY indicates that the filesystems handles integrity metadata.
+ *
+ * IOMAP_F_ZERO_TAIL indicates only the unwritten tail of the block should be
+ * zeroed.
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

