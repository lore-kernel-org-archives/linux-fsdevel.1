Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973793590A9;
	Thu, 28 May 2026 17:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989522; cv=none; b=nChVNADuEDTSaWAB4lWq5ABe7SKdwj4ZZDOCRybgt1mqq/M7oABzJNlkfp6meQgKit3PEtywnbZqVBq9vpwARugY+M49/sjUKLr3ZRglBotlQM5vT2aQv42dP9eSA1pfTkwaWTqhaSq8gI+8VpKNt+nPCwWh7e8CYJRBew1K3BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989522; c=relaxed/simple;
	bh=rWadORZhLsvM+wikz3Wxes9C/I5JTkcDQFGng+DWUHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvgQ3PWORQ7KaU7MH8THuTKxHKuICuiHQ4k3XO8xjAr4F9q1di02fYx+TiAK2EIPN9m57HKW+eTxSQNjG/BTIEm6LjB13TzWyoIR9BsDDvNukXMR8XGTNlgdY8aQ0WbjQUVdRX59AdtxRCdhUDGx6l1YcqgYD9SPzGl61e/sxGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZpqTFawe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZpqTFawe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=JklQE8IRoUKzlm70SkCQnzk7XT11rcF40aSTWvCNSj0=; b=ZpqTFaweHYbEXEVqfdLss0+Cx6
	ysy7eGmU2GXP2icJs08AWahQurjcG1Lpp9yCHCGJ4hOR3Qb3ZY+g1Bx2n0V4xMNj6lJewWRmFjAaB
	AtOleNLdHUjo5ksp4vCrqoSouuu5yX1jcXOvoAKSNOYEz/liJ1iRzvOCsUFjoMExP1Ysy+DZ7h9PL
	b1fTXr4ds1cTR4UVk803jLrD8SwSyZCaVKPvA8JHrBjYWvdzMYKQCurN/zCK6lkLIV2t5pxxu5/jd
	tq9ay1k5YexeXJSZc2W+QedFf1+T4VHiWuV6OSHiXjGXqzq9VLShzPrIdbkmJK+tPDeHXIKxFxJDi
	9t164n+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSeaK-00000004aaX-2YT0;
	Thu, 28 May 2026 17:31:56 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: [PATCH v2 24/34] gfs2: Remove use of b_end_io in gfs2_meta_read_endio()
Date: Thu, 28 May 2026 18:31:37 +0100
Message-ID: <20260528173150.1093780-25-willy@infradead.org>
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

