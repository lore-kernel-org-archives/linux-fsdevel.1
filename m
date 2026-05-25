Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2FD3F54A0;
	Mon, 25 May 2026 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779729589; cv=none; b=CH+SCkHYBK8MAeqE4Blmb5muB6WKMy2P1n8kpChPrxJKlE1kue5RTkhjJfudySja+k6kDob2fsAxF3xhN5KIbu13JwEl8iexTgMQqk2gPcVYbAR0HaE2akuJr11uoPx6AIqnkv6ke9t11ROKlmXZgBrcpWjmHX8nQxfdwc1uero=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779729589; c=relaxed/simple;
	bh=rWadORZhLsvM+wikz3Wxes9C/I5JTkcDQFGng+DWUHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZCufqO5WjT9paqPllHitDgmXMY9z6y5YajgEhsC9FOSj4JnM+XHzoqoiqf77FZY9W1/uhS9YK+v2x+rt06vop34gYsWMJ3z7bHvF8qJMT0Lb0z0aHLp/NKTaILt9ADaEv9jtlgpllkbea/6mvJsiBsmKbHm45Y7zte4xwqSo4wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vRTgEas/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vRTgEas/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=JklQE8IRoUKzlm70SkCQnzk7XT11rcF40aSTWvCNSj0=; b=vRTgEas/uPtO8OSx8xgJFhE4TZ
	LGKAASbLttbwe9kwNuccTEd2Ew6v401ro25I9xhyieyUe1T1ufjhVh32e9KXE1vfSksC3XLPICJnS
	J6Rzg/H4vtWEBnYocCasq/cmUrSSM5UrvGDR+lpBwaQa+VwQ/sfRPUzURxs37UFhqL385ChDU7yCW
	9UZkb20YO9PTfJgAFQ+0C7BZ/LnJmVYLhWbiPfng5M4Sg0RmVUaaW/Q6N0397p8AQxK25nnmOUCgx
	nKr/NkNFM9siN2U0zg87FHQvv1pqyZaNPEZnPYhvwCSSfvfq/aDMtGXgviDqyYt3jDoR4CSGzZLgq
	jH4omSSA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYxs-0000000HOCX-1ibo;
	Mon, 25 May 2026 17:19:44 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: [PATCH 24/34] gfs2: Remove use of b_end_io in gfs2_meta_read_endio()
Date: Mon, 25 May 2026 18:19:17 +0100
Message-ID: <20260525171931.4144395-25-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525171931.4144395-1-willy@infradead.org>
References: <20260525171931.4144395-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All buffer heads submitted by gfs2_submit_bhs() use
end_buffer_read_sync() so we can call it directly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: gfs2@lists.linux.dev
---
 fs/gfs2/meta_io.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index d407dd476e72..df5f05054f6e 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -212,7 +212,7 @@ static void gfs2_meta_read_endio(struct bio *bio)
 		do {
 			struct buffer_head *next = bh->b_this_page;
 			len -= bh->b_size;
-			bh->b_end_io(bh, !bio->bi_status);
+			end_buffer_read_sync(bh, bio->bi_status == BLK_STS_OK);
 			bh = next;
 		} while (bh && len);
 	}
@@ -275,7 +275,6 @@ int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno, int flags,
 		unlock_buffer(bh);
 		flags &= ~DIO_WAIT;
 	} else {
-		bh->b_end_io = end_buffer_read_sync;
 		get_bh(bh);
 		bhs[num++] = bh;
 	}
@@ -288,7 +287,6 @@ int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno, int flags,
 			unlock_buffer(bh);
 			brelse(bh);
 		} else {
-			bh->b_end_io = end_buffer_read_sync;
 			bhs[num++] = bh;
 		}
 	}
-- 
2.47.3

