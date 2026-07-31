Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D8B78F2B;
	Fri, 31 Jul 2026 00:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785458745; cv=none; b=dPFgDDm7L26Po+QU37LegQjTGu25pfNqe9jn6CktxQUi+eWt6PeSCBFaqw69Kd7/ooRjoNv2C5VInVw8nM+rQb73ZJ7KB1QhtHJTL3RlbH2sF2EXlLZ0WGXNvztXwNu7my8TWXBUHBnJLFum3UAEJXnDjYxEsxCm5BaSK/VYiIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785458745; c=relaxed/simple;
	bh=LhuiEup/GxCD+hfY0H/JK0ljiAo27VA/K9/zG9yGgTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNq7rT/lQ1gyxD5lMKWIqDSqnDUKJVcBgdfH8HAimImBhokxcQwY/fNkYkrscThjSZJrPe2LGVnn0ORWnfHVO2xtYpG4kEGz6cG3hbRDBO2IATH24TfS33KAxg9FQUixCminJJ9gDhp8QTZQU+AR1ke3Wd3PKD2rAketIRKF4Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OLItyuvo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OLItyuvo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/8KT5iqIpbd73mY6uWvbJBWjKzaYR5WxnqmPOsws9Vw=; b=OLItyuvoeEl09jIaR6dpLXUvI2
	YVl4oQ1ql3ZM2BqouWzXXGH4aWBgBZ05/DXeK9p27guTGfL1gecvkesjfl4BO44Lx1AeqgohubGB9
	Z5MnXWmowLBrzV4Wrn0PAw0j+e7YCCX+f7fdBy3CPKqtPYihaAUN8UynXg7+bwjIMvsNAuBbMF8ey
	rYSZb6ZU81pdvfO9+yPjs1aDsYkF86e9fpfRQHNopQb6eW6RXbc0LvFHmFgR08n2Nc1u+CJUXBDEV
	cSmrKVhjBEAkIO1nNt9CNmGtDwYmGhRRlwHcm+TNpHvFaefskmXKLhx0X0wCrlIb7meQCTlOOVl7G
	RlL2p6eg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpbNY-00000004ztJ-0CsM;
	Fri, 31 Jul 2026 00:45:36 +0000
Date: Fri, 31 Jul 2026 01:45:35 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Chris S <coshi036@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH v2] fs/buffer: serialize set_buffer_uptodate against
 concurrent clears
Message-ID: <amvwL-diBsUo2ouS@casper.infradead.org>
References: <20260430053645.1466196-1-coshi036@gmail.com>
 <xaqwfkwjnp7h2lg7ir6wy2tnyay26t3im3ftkdl64rhys3rhmu@lc5vfh5tc2f5>
 <CACd_6n17-pJuNoCLsstP7goocedrr5F8T8BwTjRUNx8frKEPgA@mail.gmail.com>
 <bnchcfog427eo3bxt5h6qautlq7sb2o4ww7cjgad73biycdn5f@np7qkbyqizup>
 <CACd_6n1Sht4xs6P_GT0-+wj1uu9Ww_4X=TysQRvq6ZSFJ71CBQ@mail.gmail.com>
 <amuyCIg0Y1YRiFT7@casper.infradead.org>
 <CACd_6n3C1btK38SdwiG_RPdxxCQ2qUtp4o-aODhhRzH3LNn+yA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACd_6n3C1btK38SdwiG_RPdxxCQ2qUtp4o-aODhhRzH3LNn+yA@mail.gmail.com>

On Thu, Jul 30, 2026 at 06:09:24PM -0400, Chris S wrote:
> Yes, that works. And appreciate your reply.
>   I prototyped it, and it survives a journal replay.
> 
> Six sites, with bio_add_virt_nofail() covering the submit side:
> 
>   bh_offset()                     b_page may be NULL
>   buffer_set_crypto_ctx()         NULL guard
>   __bh_submit()                   bio_add_virt_nofail() when !b_folio, and
>                                   skip wbc_account_cgroup_owner()
>   jbd2_journal_write_metadata_buffer()
>                                   b_folio = NULL, b_data =
>                                   jh->b_frozen_data, not folio_set_bh()
>   jbd2_checksum_data(), jbd2_block_tag_csum_set()   both kmap the temp bh
>                                   (fs/jbd2/commit.c:705 and :745)
> 
> 4 files, +38/-12.  I'll send it as the first patch of the series.

Fantastic.  Would you care to also include this patch as part of your
series?

From f7cd3419ce0518ba429ac854282888833bf60147 Mon Sep 17 00:00:00 2001
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Date: Thu, 30 Jul 2026 20:43:22 -0400
Subject: [PATCH] buffer_head: Remove b_page

All users except bh_offset() have been converted to use b_folio instead.
Convert bh_offset() and remove b_page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/buffer_head.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 8b23bc9a244c..3881141a3ff1 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -59,10 +59,7 @@ struct address_space;
 struct buffer_head {
 	unsigned long b_state;		/* buffer state bitmap (see above) */
 	struct buffer_head *b_this_page;/* circular list of page's buffers */
-	union {
-		struct page *b_page;	/* the page this bh is mapped to */
-		struct folio *b_folio;	/* the folio this bh is mapped to */
-	};
+	struct folio *b_folio;		/* the folio this bh is mapped to */
 
 	sector_t b_blocknr;		/* start block number */
 	size_t b_size;			/* size of mapping */
@@ -172,7 +169,7 @@ static __always_inline int buffer_uptodate(const struct buffer_head *bh)
 
 static inline unsigned long bh_offset(const struct buffer_head *bh)
 {
-	return (unsigned long)(bh)->b_data & (page_size(bh->b_page) - 1);
+	return (unsigned long)(bh)->b_data & (folio_size(bh->b_folio) - 1);
 }
 
 /* If we *know* page->private refers to buffer_heads */
-- 
2.47.3

