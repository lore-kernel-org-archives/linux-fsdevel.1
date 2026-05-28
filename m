Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7596F3FCB22
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989521; cv=none; b=dQpSa/grw62KDqReTYs79xnskwPwd5faPwxCFcQAml/y+G8H+tKyGWZ38rGFrvg7eSGiYCFF05+OTFCiTQYlO/wCo+h5VKcCZMEPWZ+Avp5cLQ+xBsQSV9moN/CNSvrJQtISpUa6lUkBzuDbmQVxGX5nm7EzTMBxcLAx7n2ctTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989521; c=relaxed/simple;
	bh=sKMQAwkJqZnUSKFwVQqqaGUPt4M0X1PwGMqOnO73dlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/7doUR0BeCyr4PdiuoLP0ZNwgr5vULuA8xM5adE6v0Pv12nAJBfOLNnnkBn490mm+U9BiQ3KOxYKQRLNvW5gKRkeQUtTNpNDZzBBZ0Uzw0jLTwjad8juA3FsGZmGfVfiLJFQzlUy/83F4rrYhTQh3f9VsnnyeULP0BkmivU+J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YMkAIPHS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YMkAIPHS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=lmSrh9pH03Gmg7AGncjiv0wUEF/LqgUKl1WoSoM2Ds4=; b=YMkAIPHSLK1VjYvJGP0YIQBJ+k
	tH/C5384pEef65UDYsFVrDIBQbGBnmIUe3dTXrIU7QAwHBa8eps3IX3Gz83uUFmNEtd25LPqkRcN2
	my5sXQSAG+ZaM3pYHzP70vrsCkzyNC8EIVYSET7Omg8Bkqa7V3HFhAqL9bptoGo5Nm6Np4+hGVkT0
	QWiA7L166jCuKFl4nf1Uh0xhioGBS/rpfnPbEwj+aheIThrTPygAGvapiBg+Gg5K6oq4NT9rpbmjx
	NWz7ywyEuBTRzOqUOvUsn/Agvih6vYM7HZJLqMbO2bCwv39daP85NdDcPrBqhn2zylAGa/DSlWWdg
	WmW6tLeQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSeaH-00000004aZ2-2wbf;
	Thu, 28 May 2026 17:31:53 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 09/34] buffer: Convert __bh_read_batch to bh_submit()
Date: Thu, 28 May 2026 18:31:22 +0100
Message-ID: <20260528173150.1093780-10-willy@infradead.org>
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

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 97c8b9966060..d96320c18acb 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3131,9 +3131,7 @@ void __bh_read_batch(int nr, struct buffer_head *bhs[],
 			continue;
 		}
 
-		bh->b_end_io = end_buffer_read_sync;
-		get_bh(bh);
-		submit_bh(REQ_OP_READ | op_flags, bh);
+		bh_submit(bh, REQ_OP_READ | op_flags, bh_end_read);
 	}
 }
 EXPORT_SYMBOL(__bh_read_batch);
-- 
2.47.3

