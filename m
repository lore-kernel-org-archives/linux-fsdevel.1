Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AC5288D0
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989518; cv=none; b=dZOmjYe5u8U8D1c/25qQUCaReM/jBD2e9Abx4Gg4k3qGs4dK7ke3yWThcOADl924UldWgeuDlpAaU1d9tEPtyTAKHnCaxHAEM/ZWaYcdKqjAGuduVAFy8ngh6Q+UxGiSPxIopzDa5L6apx6+9c0srcMFQRyFZ5uSwJoy7Y9h/6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989518; c=relaxed/simple;
	bh=oBo535glMXGLMv+bnts4aSwDQzr5U1RkxN6oGjMkX/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Klb4E0WH3Ro5v8OBeh7B2CBORWbB8+3W7mMeuaWIKkOzmAcUgmYLDxn15CblZH89vzAw/orYXvx6ft2+/cYWX+VwD8vleNvEi1PVIVZpBlU8RiALOijGRN7dlw30tt6Uzg9/4Abaob9UKbQ/mJMGfHVi7sqo084Rds+nq5umc3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ho8MMAfc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ho8MMAfc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=u8B0Gw91fndi6WZNc2puuGaH2pHkZ4dVqi+8nEIK7+0=; b=Ho8MMAfc7br4c3Ejg4zoiOZZfy
	jRk1u981SdoTAZ/d/4Ct+9b/Xwe/0OgL0B7epiVxh/WuM3xt9aL7tXeus1PZUJcjvIrdzYfri8SvI
	itSBun9DthHWi/Rn97V9StQAj5jKyXzBn7ixP7TVy62j1Vy5ImsztKgEpUZTLNAzugRXSUclV0NK/
	OItfg4VEpX75Z7S+wVouOKXShp1BObH4KErCVv4FJeQ4efOyV5VDQmZJXeDiEC2AY02/TzDNJ8l8u
	LDmbWPqR5L5EdrYZlAmD962xuUcpzjUK9Z2snkotwSMl9wx4WfH9eDw9Y8Iiqx8zNTAncrQWBm7lk
	zHPvmjGw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSeaH-00000004aYu-1zvd;
	Thu, 28 May 2026 17:31:53 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 08/34] buffer: Convert __bh_read to bh_submit()
Date: Thu, 28 May 2026 18:31:21 +0100
Message-ID: <20260528173150.1093780-9-willy@infradead.org>
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
index deabf7479325..97c8b9966060 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3089,9 +3089,7 @@ int __bh_read(struct buffer_head *bh, blk_opf_t op_flags, bool wait)
 
 	BUG_ON(!buffer_locked(bh));
 
-	get_bh(bh);
-	bh->b_end_io = end_buffer_read_sync;
-	submit_bh(REQ_OP_READ | op_flags, bh);
+	bh_submit(bh, REQ_OP_READ | op_flags, bh_end_read);
 	if (wait) {
 		wait_on_buffer(bh);
 		if (!buffer_uptodate(bh))
-- 
2.47.3

