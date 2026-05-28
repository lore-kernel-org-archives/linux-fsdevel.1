Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0308B3FD12B;
	Thu, 28 May 2026 17:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989522; cv=none; b=iin0ufNsjxoJucz0qoH7RlIPWvQ3mjO1Wp8yG768Dwxq1pC6vk5goo/HYpwALrmST6X18W8VJZ0c1rDsPo9CZUQuqpJ9S4qGu+t3Fk10A0nhHJNynDTBZZm4wW5TLYjHBNwSxt28vOElIrrCi/YWZK0QvIVBoI8govFF6FcK360=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989522; c=relaxed/simple;
	bh=JrNJZn/FWYfJ3P0eF9A8v0ZUbeq7Ge/xQQo+tfRTnm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aK1YqETdXnovkgjt9lr5GA9XVShCJOQmMzgBiKRwUJHyuSFXJ4dM317qpgDW4+GNhTq7voNY93prsWOoGHHHjj/X/EXrrfM7C6xjrs92SJMugsz9gF/sFBvbMqV10cg3/ap2VfBlvSsNvYNx+5GBvOwerZzeBWUnn00nDDqrpSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b6oY6Hho; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b6oY6Hho"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=o/oCAm8HKy2X2Af6hn0gWiEKGc/s2Kg595pEYC3Nu9s=; b=b6oY6Hhog1kBl4EvoSwnusLmRT
	/earcU/hQUivf8OwlwOImR1z8rD/C7WL1pLjg6Ujfy4gp1y9eQHg2Yy5lyYsyF/Q5ex5zOOm5j1r4
	RMd+MUvzRvrX9MMv+QYgkrIPeoTo94uOx3AQKB2EpfxVzuVYyfHicVYY0Ex8AGC/DTqvkz55QanN/
	+NjxcebFUJkz+L0O1qODIIqCfxx8oVWOm1Xb3WDINAhcZ1NDdSJmg6tf5YMzWqB+RZUo2zqJp/hG9
	8jd0YjD8Mm1+mlEVUx9ucN2H2Die4uQEitcBd8Tt52Z3dUColhW7U0KYKvpwvLflVBycq01vR9AXK
	7dspiLhQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSeaK-00000004aaM-192p;
	Thu, 28 May 2026 17:31:56 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: [PATCH v2 22/34] gfs2: Convert gfs2_metapath_ra to bh_submit()
Date: Thu, 28 May 2026 18:31:35 +0100
Message-ID: <20260528173150.1093780-23-willy@infradead.org>
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

Avoid an extra indirect function call by using bh_submit() instead
of submit_bh().  Also simplify the control flow now that the buffer
refcount is not put by bh_end_read().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: gfs2@lists.linux.dev
---
 fs/gfs2/bmap.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index b3d7fcd95f03..d158c4b7413d 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -304,14 +304,15 @@ static void gfs2_metapath_ra(struct gfs2_glock *gl, __be64 *start, __be64 *end)
 		rabh = gfs2_getbuf(gl, be64_to_cpu(*t), CREATE);
 		if (trylock_buffer(rabh)) {
 			if (!buffer_uptodate(rabh)) {
-				rabh->b_end_io = end_buffer_read_sync;
-				submit_bh(REQ_OP_READ | REQ_RAHEAD | REQ_META |
-					  REQ_PRIO, rabh);
-				continue;
+				bh_submit(rabh,
+					REQ_OP_READ | REQ_RAHEAD | REQ_META |
+					REQ_PRIO,
+					bh_end_read);
+			} else {
+				unlock_buffer(rabh);
 			}
-			unlock_buffer(rabh);
 		}
-		brelse(rabh);
+		put_bh(rabh);
 	}
 }
 
-- 
2.47.3

