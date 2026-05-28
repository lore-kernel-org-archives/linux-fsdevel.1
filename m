Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA313FDBF8;
	Thu, 28 May 2026 17:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989520; cv=none; b=HDZUW8JFXAkZHCroIaYFnH5PfJFSc+80xRz2xWOW7duBFApxsrqIPLU4xp8nBVvZt9MaFnRSvUS94eKiGADnEE0cisERMKruGqeHrarKB7WoBuyQakLL3CVwxBqpaw1tc2BdeRKCPkpQsgk0PX3nqJ6OvhgGklnk+1zZq1/Fuws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989520; c=relaxed/simple;
	bh=8LBme12+P13mqk21AZZuQha2+fzGxE+wnAr/k2OfRIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9OGvefmaPSLFwprxoXiGKxO+Ir/e6w9AZ0kO5Qd3mrRQ4XLSL0uWOuczmO6fuxhbX6lIFdEDIymc/0+HU5Nz3f7QTa+pq4alQvzxBR3WoBpWJJQLpwb40uB4H/gGQg2wUvIynPyrmRwVUNZnL0Wj8FkICpHGJ4AFkBeD9iFAxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f3BySANX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f3BySANX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=P5deVenHtcS2V+TzEKwlW4DgTh/kp1lVP7OY/zqzvEw=; b=f3BySANXIyMipgGTxEeZxqXoU9
	gHydO+kSb2KRmfDwDxl1dQ3+DOQ3Eg05BXKH+oxdqCTbQ/gn7EdEhRNvVLMSpVB1CPXuY+yYETy1A
	FUKYPILVKPWeIJy7Xw0E8WWw1cd/ysHDO+2oz1foly2/VXzSIcBwWjPS93VkdSl5cXXJwcDBq8SJQ
	wrxug+ZzwsHh63q14aFLjuWKCBHhuuOMs1uxTRrENCVG7UW1t7vf3i7Ty1OyG2oIJNxpeqXP0+86R
	3frv21Qa6C3HLVKNK3TChZfXGoilqbX/xnurh5akMZ/QgJu6IpqG02VjAan4yF6y8gv5KtsY/bKB2
	judSJw+A==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSeaK-00000004aaO-1hpZ;
	Thu, 28 May 2026 17:31:56 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: [PATCH v2 23/34] gfs2: Convert gfs2_dir_readahead to bh_submit()
Date: Thu, 28 May 2026 18:31:36 +0100
Message-ID: <20260528173150.1093780-24-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528173150.1093780-1-willy@infradead.org>
References: <20260528173150.1093780-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid an extra indirect function call by using bh_submit() instead of
submit_bh().  Also simplify the control flow now that the buffer
refcount is not put by bh_end_read().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: gfs2@lists.linux.dev
---
 fs/gfs2/dir.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index 022dbb31e0d9..0237b36b9eb1 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -1505,15 +1505,13 @@ static void gfs2_dir_readahead(struct inode *inode, unsigned hsize, u32 index,
 		if (trylock_buffer(bh)) {
 			if (buffer_uptodate(bh)) {
 				unlock_buffer(bh);
-				brelse(bh);
-				continue;
+			} else {
+				bh_submit(bh, REQ_OP_READ | REQ_RAHEAD |
+						REQ_META | REQ_PRIO,
+						bh_end_read);
 			}
-			bh->b_end_io = end_buffer_read_sync;
-			submit_bh(REQ_OP_READ | REQ_RAHEAD | REQ_META |
-				  REQ_PRIO, bh);
-			continue;
 		}
-		brelse(bh);
+		put_bh(bh);
 	}
 }
 
-- 
2.47.3

