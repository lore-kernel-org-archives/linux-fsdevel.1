Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17523FCB2A
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 17:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989518; cv=none; b=GYrcH7h6NQkmIPhY0+BMtgsv0yRvf4OREtuI52Ltugey7iAU5APcPpotFL2+oaHPWN/WOiS3FF3g66BW5tbFN6W+m2TZaU/E7PdCOLVWZpux1jd8OJm5Ctbv4bCKpalr0STSK+D6ppXmjiq5qqQqmWdsk4uQQtaXKOaYRlKYRng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989518; c=relaxed/simple;
	bh=Epk+XgnftCSoRqPpaSzDhi/YuSWDWGd723ttkfbRYsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FpVOiAutGo5eXQyW0h2n+bZSbEFEKx3ZEjB1F797Foq2TsnkdSY2z4Yztbl0o4nQ6mRd+ionDY44QJzj2JFuOQPpDYzw+oTYUNB3/+TMRoh+PlE94vfKHsZ3odB+AmaKBP2Jx/noEzgdKsD05mULA3Hmw0gY2P67tVnXy2REn2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Go3sIPkW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Go3sIPkW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=UZvxx++qC2hAZOqKaNjNYfJI26NzT0kkxmZZ7Gd1qwU=; b=Go3sIPkWtWFrESGOzhq4KCAFEO
	TuWvMD2dH53YHtHfYy9qUJLFMgaVx8fQ9Z/z2m8RFS6tsmGzacCobixXDMn2lulFBDm/NW89LsIi7
	FlopqxskzQhbYoIfgep/q8gadxq9DOcM/v4Kg/oZw1UOdxyoaiB6eW0LtOKNKzKkScwjUZBto2bAK
	AM6x7ROKEoHZh6/1D6ef4djCjvSOpao7pOXVGp22A2sqHbdFbGE4iKmADOHxRvksPeCB2Ngl0pNaJ
	hhywrFQJYaTseTfSi5oU/99HN/+Ublah8/94KJ8oDn/QaWTYnHVR3u3hDKzDZuvIy1UDHcDJvTQq4
	c07Lq3iA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSeaG-00000004aYY-39kG;
	Thu, 28 May 2026 17:31:53 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 06/34] buffer: Convert __bread_slow to bh_submit()
Date: Thu, 28 May 2026 18:31:19 +0100
Message-ID: <20260528173150.1093780-7-willy@infradead.org>
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
index 6329f2b554da..f8428f802b68 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1326,9 +1326,7 @@ static struct buffer_head *__bread_slow(struct buffer_head *bh)
 		unlock_buffer(bh);
 		return bh;
 	} else {
-		get_bh(bh);
-		bh->b_end_io = end_buffer_read_sync;
-		submit_bh(REQ_OP_READ, bh);
+		bh_submit(bh, REQ_OP_READ, bh_end_read);
 		wait_on_buffer(bh);
 		if (buffer_uptodate(bh))
 			return bh;
-- 
2.47.3

