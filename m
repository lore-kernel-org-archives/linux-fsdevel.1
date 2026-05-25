Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A2F2FFF8D
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779729585; cv=none; b=I2PCO6IX5AEuwPTAr9QX2DaMUSzOJmM6L4+Tcp7HMzqrCYU2m4MSClgjv16489JF+zXr5Lc1nuUT+X+UL5G5A5MmQu5s97GZhj94Okqif2mN4uskQ8OHX5NNdMpTCO4+RvOBA5Te7IBY/hexA8fcnjqFpfsvTZ2IsQvMnwBb8xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779729585; c=relaxed/simple;
	bh=fQAd8Mjqz28JeNEsXoPEveRJF0/XR7r7QdYLk6+IU9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVCvdpNZhXOsH5MVUNNwa1SwHMQ+zwx/KHA59kxJAkE+MWkbpqawOaOE5CiQ6Wn/WW9RNJvZvgQvUBz/sMN4tWYl18V2gke7dLoL+Nemtbw2c6Bnx6z8IkuJg11ZSlLY6eBKzvpagbRj3IXtKjNnxszOageKOClcxRlNXI48tY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TlTSHosT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TlTSHosT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=U60COOKY4jaSCpYwmQUjebt5gSjpeMUaBSrOFYPqiXg=; b=TlTSHosToem0VrmC9em5I0pJt+
	Zyh/FvqYBbvhNqoUpQQyTpO7W0r8oDG2pRxMQskCKphJYnWtLMBZGq6y5jRq/++c1t/DMPcmlJvoH
	LnLoZGa5iGo+o5riecF3W0dHaLRvfnsNHOlN2PJp9tGrN9bdxJZfXTUQ1NcGH/mF+wMSsfGGpcZIp
	i8eC6S6B/BoAyFUjyJjPpFKAky42Ei20tQb/dyHblSAYcANNhLtUO9S3eWFcKiwBkysog3QuTRj6r
	a88xkKcfQEYdPgSVPr8vswqyG2rvdnXGzSJEtwZyYYYOKzlY/cI0I8A2ffen6aptWS7vr4yOKUNBy
	iOMkWayw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYxo-0000000HOAE-2eqX;
	Mon, 25 May 2026 17:19:40 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/34] buffer: Convert __sync_dirty_buffer to bh_submit()
Date: Mon, 25 May 2026 18:19:00 +0100
Message-ID: <20260525171931.4144395-8-willy@infradead.org>
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
index 1699be521672..fbbb2febe383 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2850,8 +2850,7 @@ int __sync_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags)
 		}
 
 		get_bh(bh);
-		bh->b_end_io = end_buffer_write_sync;
-		submit_bh(REQ_OP_WRITE | op_flags, bh);
+		bh_submit(bh, REQ_OP_WRITE | op_flags, bh_end_write);
 		wait_on_buffer(bh);
 		if (!buffer_uptodate(bh))
 			return -EIO;
-- 
2.47.3

