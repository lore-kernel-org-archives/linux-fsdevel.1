Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDDE2D661C
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779729590; cv=none; b=bgOCc7lHXle870B9/lExv2IHN6KakBt6cKnHKqeTKik7zFB/Cow2UTNGZS4mHG1GDJDqLP9ZRsaNSfmgPBpv2M74XZAB/4KR7QKmZ1KKCmXhn2QAO92rWiOie1iRXEMeg2zo9X7l+E7kJiAf8D+D5dm1dWAW6ym1e4GTO31b/g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779729590; c=relaxed/simple;
	bh=KyH67SPYzNO8MwAAsRlbwGfz3OBognZ5EK05GnLHGR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NuxSPpGLX6viI4Gsk+SJYS45ebxiXQMqCSekzsnp5YdVc4U1OLCM2z6JARap1LgpzSZUHBX/oHpE2mh/FwxcIl7DCzIIzo6Of1Z3pHLD1R/jZIhJgg8qyK+ss+PUOD0bfHy/YzCBcB5n00SyHMUl/P2prEQ1e1URmselq7XxBbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NOEOpS8/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NOEOpS8/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=kQjnSNk01bRi/JGkE0rjCTrgFx1dc6C4tQeLLtULM80=; b=NOEOpS8/0CRd9bK9egdUQ5VRYz
	t1RfZTFVLm9pe6m/qVdhhNcGw6ZmEJYoqlcWP4SQJRUzjmx46mKg8lQZ80al3r4i0f9V98KJKXbTw
	MJsDVoyWq1YeWxlABy5xUCTzaBhyZVzojnbc/UPIGzDlQdCF61HpkAwYOatTxf9oky59XaMT0BeLY
	89PmpKHMOe69XUW+xGDMpGzTWcX5zvscLOHyWqwM77cJNEsLUzp2uys2GW8l0qlQTPidZS26s+wFG
	na7k6uY1GWD3RTrciXJf3A85CN10BMelBPRnXgAJ/AOSB6G+l4RediORUGRV0Zb/3ahB6Mg4p+vEh
	XpGn2G1Q==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYxu-0000000HODi-0lxO;
	Mon, 25 May 2026 17:19:46 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 33/34] buffer: Remove __end_buffer_read_notouch()
Date: Mon, 25 May 2026 18:19:26 +0100
Message-ID: <20260525171931.4144395-34-willy@infradead.org>
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

It has one caller, so inline it into end_buffer_read_sync().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index f057d354b353..623a09ade8c7 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -153,15 +153,15 @@ struct buffer_head *bio_endio_bh(struct bio *bio)
 EXPORT_SYMBOL(bio_endio_bh);
 
 /*
- * End-of-IO handler helper function which does not touch the bh after
- * unlocking it.
- * Note: unlock_buffer() sort-of does touch the bh after unlocking it, but
- * a race there is benign: unlock_buffer() only use the bh's address for
- * hashing after unlocking the buffer, so it doesn't actually touch the bh
- * itself.
+ * Default synchronous end-of-IO handler..  Just mark it up-to-date
+ * and unlock the buffer.  We put the buffer first because buffers
+ * on the stack may be freed as soon as unlock_buffer() is called.
+ * Buffers attached to a folio will also not be freed until they are
+ * unlocked, so this order is safe for both kinds of buffer.
  */
-static void __end_buffer_read_notouch(struct buffer_head *bh, int uptodate)
+void end_buffer_read_sync(struct buffer_head *bh, int uptodate)
 {
+	put_bh(bh);
 	if (uptodate) {
 		set_buffer_uptodate(bh);
 	} else {
@@ -170,16 +170,6 @@ static void __end_buffer_read_notouch(struct buffer_head *bh, int uptodate)
 	}
 	unlock_buffer(bh);
 }
-
-/*
- * Default synchronous end-of-IO handler..  Just mark it up-to-date and
- * unlock the buffer.
- */
-void end_buffer_read_sync(struct buffer_head *bh, int uptodate)
-{
-	put_bh(bh);
-	__end_buffer_read_notouch(bh, uptodate);
-}
 EXPORT_SYMBOL(end_buffer_read_sync);
 
 /**
-- 
2.47.3

