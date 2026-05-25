Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3151BD9C9
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779729586; cv=none; b=PkxuQDA9BI5lCxXWBDreHj3YY4nGX5EAEUFh/zVGFYG6CWBVr/FlV/GnQPIRxHjjkNqyhsR1NbWsFc9GmphBISGUPNAjWhkxn5VFTQZVwYq4ulHiwoCl1litmVzsv2VW3A5Nd/S5nXw42Q66fGq0ZQgHr2KRD4ML1N8atDHT0Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779729586; c=relaxed/simple;
	bh=5CdMDVy+a6tjmd1of7gVhJgfR2yk4NF4kv4g2Re+ZTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=imjPk03irZdAtniwQrb1L8X5nlPmqlgi39wJ/RR1l83UPYD4jRVuqvQ9N8w1CePzY/4MuZi/mCL3NVqMA2rsrFPyNds9MYae+eW5VftHxJ6HQujIUfw/ENYM0kdgU9PZm+3otOroTZQPkzc/IMFQcrCaeLT4hhfLwK3yy7B0fpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XDMw9R2Y; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XDMw9R2Y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=iBUtrjGejclJZ2o0pUNL/8EnhQ6cRmKfmK4U7EHY2a8=; b=XDMw9R2YF9sYTPxNAUWuENh7Dj
	VpJi3D882mlmC74+HzNAYc0W/6wFEsoKO6ovDZ2f9GFcluAdsQm9sFH7J7vbFt5lOSg+zo9PTWI9t
	NKLtBptoSBLK9Y2ZMatjGiwFh8nRIPOslEnCmwwBSDAj+ks+AatYKzHgNGwZX5xdEMy5OBRdYk2N0
	k+Yz/hMChyU5XWtOv8Di/Y/5qhvtFcf3WqVvOaSVRkVD+3ljyjv9a+fZr/EMDQkLbP358NUdv0TEF
	gTUBXzDXok6iXD7irMG2QDAXSUgIkGW4lYIYTFA2ALEfvnOAKbVccf1KCau6ULZXCdMngBXqn3SqX
	fBMlf6Fg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYxo-0000000HOAM-3LRd;
	Mon, 25 May 2026 17:19:40 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/34] buffer: Convert __bh_read to bh_submit()
Date: Mon, 25 May 2026 18:19:01 +0100
Message-ID: <20260525171931.4144395-9-willy@infradead.org>
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
index fbbb2febe383..48b4480e9915 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3083,8 +3083,7 @@ int __bh_read(struct buffer_head *bh, blk_opf_t op_flags, bool wait)
 	BUG_ON(!buffer_locked(bh));
 
 	get_bh(bh);
-	bh->b_end_io = end_buffer_read_sync;
-	submit_bh(REQ_OP_READ | op_flags, bh);
+	bh_submit(bh, REQ_OP_READ | op_flags, bh_end_read);
 	if (wait) {
 		wait_on_buffer(bh);
 		if (!buffer_uptodate(bh))
-- 
2.47.3

