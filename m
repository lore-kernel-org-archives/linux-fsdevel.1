Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B1530149F
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779729584; cv=none; b=akA3/cOo+elMoH+onrTS9k0rF0mYLI8Q1JLb0HPDKX5VoUMrC3XF5FA9/q08DgbaS+k0felDa9K62nTiNwsrhnm1xtDmiylKVyPlfDEbdPuA8BJyFp9FJKhdY5IGSCcR7EyvZ50D64c/2cPgfQrP0VpYTBh4BxI21ltsMz4JmkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779729584; c=relaxed/simple;
	bh=YFCpUHmtNLoHT9J4OdVQddxxYSImZmSK+h9jS7q3kn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZp1CvZwD6uNlENtJkXLVPXjRSFBi8nLQ445VZRKbXmB4XEuM3YEP5Wdnl0JN1T9dATKnU9npXztF9m1G6IrSeTvl9UKjmWlWsIg6ek1v65etes13iPCbXOMxAGVzxYgXmQC/AHcHBUyOislvrf0yEOxVyrJXsibc4x9WFtWbC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lmOd+9t0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lmOd+9t0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=tkIvnLJfe6dGmApQtCF82UTqvqepnm8rMhMySjRc7rI=; b=lmOd+9t0OP20HH5OpNF67OV89n
	ADGUe6DRKoT6wPUKGqHwhp5TgJlxs6xPJYyMTarMVax+NmNHaYhLedfyo5teqdyjZBxH8jWu9lnL6
	Emj5VcetgbySNK/R8e4K8253jgP4iU2I+2Jgar5BoOQrfOH3a5yJJUJsVMtM1Ln4CCHJErFDOIb+2
	Ml8ulLyDD0q73SCfWz+8qNEAh9rCaD9X1bGy4YzAjmVZBt9GPEqkLUYX0/3YsD0KgpwORztR6hn8O
	VLr3Eyino7TVe3zyRxb2mrPLoUGTS5Z7ayA3teYEdWAWncpAARekJCcws3EJmSuZdpyUI6LemZvC9
	G9iTs/gQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYxo-0000000HOA6-1yc8;
	Mon, 25 May 2026 17:19:40 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/34] buffer: Convert __bread_slow to bh_submit()
Date: Mon, 25 May 2026 18:18:59 +0100
Message-ID: <20260525171931.4144395-7-willy@infradead.org>
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
index 3bad3f4edd54..1699be521672 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1317,8 +1317,7 @@ static struct buffer_head *__bread_slow(struct buffer_head *bh)
 		return bh;
 	} else {
 		get_bh(bh);
-		bh->b_end_io = end_buffer_read_sync;
-		submit_bh(REQ_OP_READ, bh);
+		bh_submit(bh, REQ_OP_READ, bh_end_read);
 		wait_on_buffer(bh);
 		if (buffer_uptodate(bh))
 			return bh;
-- 
2.47.3

