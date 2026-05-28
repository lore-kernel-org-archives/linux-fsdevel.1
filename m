Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7293A2D3A93
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 17:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989518; cv=none; b=bxbMlnHPzO/NYlSQqFl7uwljZLw9ydtKLjiP+5XzvTOgGnkpbChuyZ3riO9uw5HiX8Pj4GyzJQnzFqSTNdhqYNfBfAUh9x4r6jNu6zF0V7hfR+VvE0rb/n4m/jiq8BWNlee3psHn7H66QeUX13RDV7AA6Hzu2l4f+nrO1f5UcRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989518; c=relaxed/simple;
	bh=Nmf1KbqbwN9V+UgC6CMihPvNK3l12C1aDzFjEljwDMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJHJTsgp+0ulZGSF9TnjQrYzpstHlSTmsrEypJZwr7HImmUi+kF78goKqPKYWhOdUSd5fBhn1N6kfN4HHG1dopsoL/xi1gnMapWuIIsLRFzvp7XhPlPhJbCDmM4tONqTyccz6W3dWsAMok4pzY+lEI6fxeXRg/7e9rqPDK71WFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cgZUd9Wy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cgZUd9Wy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=le6ZmY8M28M9dx9C26aY4tuYtt9QW5QBHt5M3arZ8ns=; b=cgZUd9WyFzPdnHSxZ66Ey9E7l+
	uJSAzOBtDEMyIjP7gPXU91VjLi5yrRxm7HLod952RCb9dNqjuNDJubqQx38LVT3jwkegeiK/Ww6SU
	Dkns/toAp0BI+Z224AdlWGDCUM59Xv34rC5SSpOCYRLWg1HL47t81QYj4eqCplOnH+o1OYEe1LpI/
	CnyKZzD1pjkXseORAIUdEy9WalxGPfc6ZI1dZ5YvQRgTLjFSFDEHxY6nD7lp4scgBa8rZH1FJR02u
	n0W9pyzkPHTzSVe1mWQ+EGiwpZtIugWMPylBBKtD3FH0rAzukjMOXTTGmqUTFbPfugbhVavS3t0e9
	lXpcKpQQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSeaG-00000004aYQ-2Owv;
	Thu, 28 May 2026 17:31:52 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 05/34] buffer: Convert write_dirty_buffer to bh_submit()
Date: Thu, 28 May 2026 18:31:18 +0100
Message-ID: <20260528173150.1093780-6-willy@infradead.org>
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
index e22a94afa385..6329f2b554da 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2836,9 +2836,7 @@ void write_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags)
 		unlock_buffer(bh);
 		return;
 	}
-	bh->b_end_io = end_buffer_write_sync;
-	get_bh(bh);
-	submit_bh(REQ_OP_WRITE | op_flags, bh);
+	bh_submit(bh, REQ_OP_WRITE | op_flags, bh_end_write);
 }
 EXPORT_SYMBOL(write_dirty_buffer);
 
-- 
2.47.3

