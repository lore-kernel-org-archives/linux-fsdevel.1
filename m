Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB28C2EDD6B
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779729587; cv=none; b=GABeFeHq+MdeebVqMn4OUn2BBTx8q5an7ZaTHXTwN17t+PT4g8WeDlDxKi5UtVXql3WEaqIesmdRwa0Z7a/VSlVt6lA/knsjnNJi+xrxfYTOLcsIO9uWCO/qUsF9jpIQ/CiSP8roY/QA20+a23V0YJh+0aJ3cBHoujxWzlU7ryc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779729587; c=relaxed/simple;
	bh=1ZXmRPOrGMxazAPrP3imtoNNSpyT3q64/BrthjxnffI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Acd2hPnRPNehwOWLfN+XGxo7KWy9Rbq5KLmhPARoa9ni9F+CUzXbkAx9RRzRrYNoSS4WRGrhztO6uGP0PFYAFeX+U0qi/7zqE1HIGzwUZKfT2yekPmRkIEdWmBZhze/FfpItJBQ9qHP5FDfmzgXBDUtsg4HLACh4/2mx6yW3Uzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gD4u307g; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gD4u307g"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=73TaKEpy/fLOwfF8qq3b4YfJViHaEHaiyKUeXHw3U/o=; b=gD4u307gfd/MTEV2Ps6x9LoXQd
	+W8/MPo3K07beMj6ejChO9YsrT4zOOmWI9cy3v0sXA/nNy0uEMl97lx1xzMdaP3bLXs1ePq82yoxa
	OM9n/t7lt0qOmPCkKg0qHphsCkrPuKbMGusmwFO7gGuADCQA5cQZ7hslG0HaLBCzLPjy//GGxkl6b
	O8nA22NSOdQYwl5DzveCOomtXvbDF+ZYMlsf8+Gn0rbA3yc5C3PUUtoF/KuGC4DrS9GOkdiIDVg8D
	8Z7bblMLf6ootEx33KFRuNN4i8VZDVipeacGgCi8KUlXUaILFBBXig/7vgzQsK39EfH9cBXnd1LUj
	PSiPyLqQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYxo-0000000HO9y-1CUE;
	Mon, 25 May 2026 17:19:40 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/34] buffer: Convert write_dirty_buffer to bh_submit()
Date: Mon, 25 May 2026 18:18:58 +0100
Message-ID: <20260525171931.4144395-6-willy@infradead.org>
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

Avoid an extra indirect function call by using bh_submit() instead of
submit_bh().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 84ba0d892267..3bad3f4edd54 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2826,9 +2826,8 @@ void write_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags)
 		unlock_buffer(bh);
 		return;
 	}
-	bh->b_end_io = end_buffer_write_sync;
 	get_bh(bh);
-	submit_bh(REQ_OP_WRITE | op_flags, bh);
+	bh_submit(bh, REQ_OP_WRITE | op_flags, bh_end_write);
 }
 EXPORT_SYMBOL(write_dirty_buffer);
 
-- 
2.47.3

