Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17113FCB0A
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 17:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989518; cv=none; b=N2YGH4IGQmVoxlioXly/HfC4sF4h7Jvg6GG27OUUCfhZn634Ng0Bs65P1bi8+4fDVblQDooyYXUDjq02n+nGso9Tqb6gp+p4GeapvweM7PAfv9wOukm7+OeoG/7HvBM5+ZXRhFKUSIWyMPp2MNn2UuYYPm+7tu/gK8yuUpGUujU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989518; c=relaxed/simple;
	bh=52kqf3OlA4513MW+MMiki4uzLXYzNdkx8YkN0VO0KmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ThSWrDG6wXWeyL2ePQSzrtMt5LH89g3T/jhR/vm2W0tR47FLsLmaLP9D2ivNDWpOLa2bKSmHU6jHIYP+OnzBet2X9kt46zyg/oMRtCnAbDXDNUEpVA5JPGVjWHX9SYc12b35GeJf8TW010CSVASakHZJEZxukvk3WE4zVL2F4TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HuFi4+RK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HuFi4+RK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=KHhctYz6F+oc9rXZztJST2djL9lMfdStKZy3FMQNjds=; b=HuFi4+RK6TJesP2SYagte7ssyQ
	GPQrejMrPN0ru2Zb0v2hcJ4kO+7OC6Cg4acH7OuPhxmo9/rRRpKMLZOgBqqHhZC9NWVVKFc1wc8X5
	DfJrZo1E20KQK5xjsTqO5c0qfcDzLiPCQCck51QV6Ey81Ii9Eq/DKqpcQGst2Pc/mkQajn2lPu/kU
	6O7oQwMjYANoaYtUdsXip+uuSz4zpqQnzbldB84UgirmX8FrTTCarr1kqh6jAv/or4M4ZzmTIvnUG
	CY/0l8K+dp7X9ACtWHo4aFTMYqzoL4TKipVM1RnYVPuyTOzpsqyorVadVUvcLKGPIl67bQtICYggt
	5AB0mkKA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSeaF-00000004aYA-4033;
	Thu, 28 May 2026 17:31:52 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 03/34] buffer: Remove mark_buffer_async_write_endio()
Date: Thu, 28 May 2026 18:31:16 +0100
Message-ID: <20260528173150.1093780-4-willy@infradead.org>
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

All callers of mark_buffer_async_write_endio() pass
end_buffer_async_write, so we can inline mark_buffer_async_write_endio()
into mark_buffer_async_write() and just call that instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/buffer.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index ea926963529e..4dcce64ef006 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -443,16 +443,10 @@ static void mark_buffer_async_read(struct buffer_head *bh)
 	set_buffer_async_read(bh);
 }
 
-static void mark_buffer_async_write_endio(struct buffer_head *bh,
-					  bh_end_io_t *handler)
-{
-	bh->b_end_io = handler;
-	set_buffer_async_write(bh);
-}
-
 void mark_buffer_async_write(struct buffer_head *bh)
 {
-	mark_buffer_async_write_endio(bh, end_buffer_async_write);
+	bh->b_end_io = end_buffer_async_write;
+	set_buffer_async_write(bh);
 }
 EXPORT_SYMBOL(mark_buffer_async_write);
 
@@ -1903,8 +1897,7 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
 			continue;
 		}
 		if (test_clear_buffer_dirty(bh)) {
-			mark_buffer_async_write_endio(bh,
-				end_buffer_async_write);
+			mark_buffer_async_write(bh);
 		} else {
 			unlock_buffer(bh);
 		}
@@ -1958,8 +1951,7 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
 		if (buffer_mapped(bh) && buffer_dirty(bh) &&
 		    !buffer_delay(bh)) {
 			lock_buffer(bh);
-			mark_buffer_async_write_endio(bh,
-				end_buffer_async_write);
+			mark_buffer_async_write(bh);
 		} else {
 			/*
 			 * The buffer may have been set dirty during
-- 
2.47.3

