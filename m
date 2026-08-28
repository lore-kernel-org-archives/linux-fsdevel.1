Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868A83ABD8F
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 20:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787950475; cv=none; b=NjPJdduZ8bcPrf4cWy4DvAJVh+1Ef5RzQCFmDOKhMaI/r5RUNcRAaaFfbzqVXfUW1EdV49lOj7FCJcDOnAoaao6G43mDuqyypuooGOThFJ3Yjz+QoVhzFlCTeIcT9TYaZ9yAXSb+TNcWd8qrJwDOM1HphB9rFr/QpkiTk5ulKl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787950475; c=relaxed/simple;
	bh=d0ya3J59tEWrC03+aiE5AnEjte7/Z0zw9nfPV3+7z/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utGU3eWtuk68SNJTw9URpwnKoyT4vVBc/lRHh/dCc2//Xh4PjhhqhITr9KZRjIlkDpUaWcm6K+7RTPfaUmEg95C0PdxRuBElhHeqtpBJtzSupkH+imyOwNE09vm57vdsvnptA9ZsbB0dubjCbeyg0ES9rJznu6+76SLm310Sbsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WCXQPYU3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WCXQPYU3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=b5mEzFLCa9pBaTp5c0b7aDU8twQCm/LbW+8sjEtDA68=; b=WCXQPYU368x6FallB7BFa1ux/R
	foO7fO/oO56aOtKw208GJMuT+AWjRFe9K84CCIBihtfT2E5EaeOy9QSQ3b0ftF8p08U/D7tNP/eFv
	a5kvlVkI8ataTon907aMA70QPgHwnD2YcDlO/dirawrEV4Lu9mpv2EDvpR/gOZj9l6WMPL2fpKrTI
	ry73fybvl2vfGsEw9Ur1DW7tbwZwTvlgu0/ELz5u//+r0dn0Y2W69uAKKG8V0+BxvCxns3xFMtFlT
	OySHa0nRwmvlfjgyVAgpOtFs4LF3YKr3DqtXgdqwimGgjzPxaDYPgWI+35XA1tsTo/NNGihpnbxGM
	edzwIkAw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x03ap-0000000FQs7-0KcK;
	Fri, 28 Aug 2026 20:54:31 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/6] buffer: Remove reference to unmap_buffer()
Date: Fri, 28 Aug 2026 21:54:21 +0100
Message-ID: <20260828205429.3678204-2-willy@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260828205429.3678204-1-willy@infradead.org>
References: <20260828205429.3678204-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

unmap_buffer() was removed 25 years ago in v2.4.10.0.1.  We don't
need to mention it in a comment any more.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index ed966fa73b1b..90ea52af042a 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1611,9 +1611,7 @@ EXPORT_SYMBOL(create_empty_buffers);
  * moment when something will explicitly mark the buffer dirty (hopefully that
  * will not happen until we will free that block ;-) We don't even need to mark
  * it not-uptodate - nobody can expect anything from a newly allocated buffer
- * anyway. We used to use unmap_buffer() for such invalidation, but that was
- * wrong. We definitely don't want to mark the alias unmapped, for example - it
- * would confuse anyone who might pick it with bread() afterwards...
+ * anyway.
  *
  * Also..  Note that bforget() doesn't lock the buffer.  So there can be
  * writeout I/O going on against recently-freed buffers.  We don't wait on that
-- 
2.47.3

