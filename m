Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52F8305663
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779729585; cv=none; b=au3ScIEVUaS7INLL7pYNHLE5Zuf4SPYihTevH6eTNxSLma8cMJykTvguaAuwAwWzUfXRid9Oy1vjcCu9UKp1r9T3exmYL6fSGHHs4DNKupSGHeISI9nQ6uliTxexYgIygChgt/rwkMjmtqjx04cEhI0ctRW1JH2LGRrT1l2jyh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779729585; c=relaxed/simple;
	bh=GV5NO9mNCCW6yaNzNPWnlY2dVacvKlQolmUdmk7UGQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwGfKgkwm7MxQvQxJPwfc4ghM9IQhJ3+8Zua2ScQA4+TRvYyxch5FpxU43BsHzuEq11Jk0n7vKDNK1+0cJhajMux/gUeWUUSGK09H1o9yjZUuas2wfd9MKlO43kVnXeVY9qPeUFn26tIUw/EeW6Wf9mXAoJLECK8sPITHBM3wxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tS/R3f5B; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tS/R3f5B"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=XWSArlKsVclKnt3KlOAWrGWaIY9SqI4A4hzKuCynKXg=; b=tS/R3f5B7ICnE54ofimRdZ1919
	mvOVorIfYZ7Vb5j4RhWnxLPB/UTd4Fv8JQNJhf7hXXIEJQViWPM6+OfUppg+88ddZWPZYrRhzzUTm
	SS9PNdewLmNAvFmpIHmi/UyTsNlSV7lRJJ5QuPlqGi4xBhF3OTQ1DFLN0083pTnmizdnb+B1PYoEG
	/CB2fwRZuavRvK2V02HgLD2BzafzjX1nabVJVqKQcVt8C5Hpwj/ox1ECP6VGtqS1MI9yWnw1b7PQi
	HEftqwkEOKgyQypYX0QvBEhNpM2Io2EnFbmTBgXcRX4NHWwPAEx48cuY3W+xQ7jeJVG5IG2sCEcHA
	MhyGivAw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYxo-0000000HOAU-3sRm;
	Mon, 25 May 2026 17:19:40 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/34] buffer: Convert __bh_read_batch to bh_submit()
Date: Mon, 25 May 2026 18:19:02 +0100
Message-ID: <20260525171931.4144395-10-willy@infradead.org>
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
index 48b4480e9915..44b14f0642f4 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3125,9 +3125,8 @@ void __bh_read_batch(int nr, struct buffer_head *bhs[],
 			continue;
 		}
 
-		bh->b_end_io = end_buffer_read_sync;
 		get_bh(bh);
-		submit_bh(REQ_OP_READ | op_flags, bh);
+		bh_submit(bh, REQ_OP_READ | op_flags, bh_end_read);
 	}
 }
 EXPORT_SYMBOL(__bh_read_batch);
-- 
2.47.3

