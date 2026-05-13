Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E651238D6A9;
	Wed, 13 May 2026 11:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778671329; cv=none; b=AEoVlatlZLaYYtNWwItkaTQ+a+5Ba3aUvQy3GSwQVnf+YOtthZFNp4jfP8rI/7lmQls0V2Gwjh6dTieaSj1AuPSB/lufFxxCNk+e9uS01O+sXx5JbJvokz07hT4WXXHqLXXZOWi/BI/CYFg48U2cXbbb7dwQJ/i6ywx7XQU2QGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778671329; c=relaxed/simple;
	bh=yK0uhnIEaI92euI5l0VwJVWOD3p/CtLYSGo569dfZRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yzn0g1YdSQqCub0qWhy8HDMrfVHqDcudr3JGs6eklqAPchsGIcas+Yn/374SoqRa2yrJ4k2jzLmItW3gHMWBZMthVAG0ggN22BV71TrSAdFBbeLoItMYTbzsvPCVOSAZWh5bxo8Rpj3yrkP0hR98bMbylik4iGJ/mGadiEFWEn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cc3nrS2p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cc3nrS2p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1CD8C2BCB8;
	Wed, 13 May 2026 11:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778671328;
	bh=yK0uhnIEaI92euI5l0VwJVWOD3p/CtLYSGo569dfZRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cc3nrS2p32IV5JHv0JzA2mcvH7prc2N6yKrAcSBkcmIUFpFuGPPzO7VL6yTWNIS46
	 0mBtgp/1ohI4Fs309iNG8kc7bKSl4r178G70xAleoEvdHaPY4zJE8/vVJBoAdovm+g
	 CcP464nAz8DBIEXGi3WAhIQ8kRNy8COGIPrMPkwiMDRCydq4a6/JVxQRpMKiX4trf+
	 S/KrSnD/wCIg6YFkbfbuBfVLHFsCWHZYEUdSXR5t9HrKbwgcMhBh6b+Rb6oqTuV8vH
	 uKMyW/J193HvBJLHNv/HR79vgI5LeaxMq+XjnVaFCPOkn3ufINrTQ0RjH79OfxLAVv
	 4tbMUiPXR7bdA==
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
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v3 01/11] iomap: introduce IOMAP_F_ZERO_TAIL flag
Date: Wed, 13 May 2026 20:21:46 +0900
Message-Id: <20260513112156.9122-2-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260513112156.9122-1-linkinjeon@kernel.org>
References: <20260513112156.9122-1-linkinjeon@kernel.org>
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

