Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0278F3FD12E
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 17:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989518; cv=none; b=uvqBqbBXHhTg81sLuYrTcjsxIeSsyyIRJzvxTyJ+u85CKUUzP+GTuVZhf2g9zPdRdpgZDQyA1qcS94qVGhrPbj6HUC31IF6DRqnFoohppm9gRdhQMMUYltTDGFyRHLfEQBN0nFiL1kXmriWJR+Sbjr9P678Sllt5zMLjovtl0f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989518; c=relaxed/simple;
	bh=EmIYcKZCfoIjsrAbl0N3cEubC20pTcw0h0fyZfQJEdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gyVkf6qB1sPWpP+Fcz4zDwAqtl+HU9wTDRF4GUkl+P+sLBLR4/0w3FeHASdNl4cSaQepZjYGUw/8eXPPPHZkFgyWR979CBkOo4dU/VhKcM644BKXFeC1bv4sfnVvr1k66bdb9ejLiQ6h4gxlIE00GgGTggCcS+mAcPlfnqXJjf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aznGS0gb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aznGS0gb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=YfT8A/2Z/fLo4GGMFWodGEjsyeC7uyIQVNuwAw1Omgo=; b=aznGS0gbPOmzOsjwzxoeEJoDtf
	53qHEhsIs7TMIiFnj7AnZgxLVTAso4aWyl4qxjcrdphdgxIcqlOqdbH6n1QS2ytnzrlzc1p/fzgDG
	d0GcNdNjHCwGVgg7Jr6zJDt4UBzmNSHa9fv3y4dS6ldyNa4SNrLPJDjyDGo7p8d4fBgc7mNclFxK+
	gD05QMR1opRqgBm+KJQCR3X33bsu0rzrCZVwS0ywHfb7Mb2Cvpq8m2LyR6IlTzbM9+xhZEwslwYU/
	TZsWgvx3j5wJeV/scQ4n9c+PoBD1wJix/Xi8ToWpGlfjQ+ivUbz7WsGkEQ1IVPHl+K9sy8ArY0cW5
	SUz8i+0w==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSeaH-00000004aYm-0wGB;
	Thu, 28 May 2026 17:31:53 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 07/34] buffer: Convert __sync_dirty_buffer to bh_submit()
Date: Thu, 28 May 2026 18:31:20 +0100
Message-ID: <20260528173150.1093780-8-willy@infradead.org>
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

Avoid an extra indirect function call and changing the buffer refcount
by using bh_submit() instead of submit_bh().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/buffer.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index f8428f802b68..deabf7479325 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2857,9 +2857,7 @@ int __sync_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags)
 			return -EIO;
 		}
 
-		get_bh(bh);
-		bh->b_end_io = end_buffer_write_sync;
-		submit_bh(REQ_OP_WRITE | op_flags, bh);
+		bh_submit(bh, REQ_OP_WRITE | op_flags, bh_end_write);
 		wait_on_buffer(bh);
 		if (!buffer_uptodate(bh))
 			return -EIO;
-- 
2.47.3

