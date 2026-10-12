Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7F54AEBDA
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791821766; cv=none; b=L+oO5HlNNTpPvpsu6BxL9sTiaPxn3A9N2dCNhVXNDslneQ/fPXfr9vHvU2vzRVAfj1lKfH9NGJSWp3QM0hSIqZO5YIw5RB3bS79rTDtev2kizpA0t+zZ5f0vTE1waZNq9EfqstWa3hfFX0YaaBoQ+/OkK8/gc7s4/0/JVaT/YFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791821766; c=relaxed/simple;
	bh=PQoyupbMg2njfXs6ToWwebDfUPj5dNNJpMJ29LhN9Rw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pSah3vjriyGt2GCLH95DLiywlLaPVIJ6vhS0Qt7H0x/jZycnj1ScewcdraVKW1xQNVxVIz2rD7BeIwm6DlxSb5gw9d7RvKq0G+U90Pc6LMh4LgJbIBfJ9LPc2co4W7fk3MCqdVsDE2p0IqAn/quE1zMWCkEbhv4tYnKQYhw2f8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=nOtYszC6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TCF2NlgG; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="nOtYszC6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TCF2NlgG"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CAA847A016B
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 12:16:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 12 Oct 2026 12:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791821763; x=1791908163; bh=Pg3hxvDD6o
	wJYEC8osEs0xvRypblrYhrq+yi0+WhwUM=; b=nOtYszC6u1gSxjspQtSFgqsHof
	TWPfqpJ+yPbqQR8fAo5GoKLQslqMP+q3f89hzqcOEQiPP2oSvd/5i3TTnZF5JLA1
	JCbZmilgSFPhOX1d6IjVLtrF/7yhLuw6uLISwkEhnEuFl0Bl/cXXP9q6nCz8soN4
	b0G4HKQOW7LBMjSeplILDrC/Ab+gajPALW9mSvCL6ZkRgtPTeKw/UtjscpgPutbY
	yuyAMvLd66FUm5Pi/tMiBtxgKyI0+ddkZR5+JQn7nAHvmVYsfH7Zq+tvu8ahhDaD
	w9GYRriGXgsU7Myv3MGlJoan/voVdTippRYortGT4yIJi4HZcuZx1uFKwsWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791821763; x=1791908163; bh=Pg3hxvDD6owJYEC8osEs0xvRypblrYhrq+y
	i0+WhwUM=; b=TCF2NlgGBpvRjeAeMdEErasoc0YJA3BP8iVRrN0Mz/swt59aX7N
	yaaOFUH+BdFeU4e4eiyp/WQ36bGWCX2237/2OThzUkfAngO5n1H3cD7gX9mQQ3lQ
	zeII72+KiYGRpTUJW/0lae3yFndfYD8YasABwPHEsgOYyI/tL1Ava+urns/s8Zjq
	56+At7Sxr58PGRrjg9nN1KOxF/Yd2LBgXWmtBq95ZEIeyDNOy9qKHp/WPErC0snh
	uwdHOlF9tCQ0EbZDTE6+BuPuHUfWA7HfezAXsx6AZYvwSVzJ3pMfJbQrZxSPkZjP
	4iuCGlsBpDhM8fHEYXP5bcg622Xc04/NXRw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fluxnic.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791821763; d=fluxnic.net;
	mf=PG5pY29AZmx1eG5pYy5uZXQ+;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:LREiP+lIXWig05WYexNURksYYqdY4171rr7rEG6HqQlQ6LP
	q5gPNOuLK3wU7i/0NXAVXH6WaGonzisjhveZvHA8c7UFZrnkQg24hGtxSmu40HRz
	ODyKeh3lzE81FE2MFSU90A9axNuMkL2Mnm68MzT5S7O7vtjpcQ8gYzk3N3oMLD0M
	jDP5OT1XkBAbiUgs+sy061FyhaDuspawMVzFlLSm5NFLS0k/0bnBpguzuKRYGYYw
	3/J0PL+tqv+PoCohanylt1nSQLTveN2YWxZcI+nelN1FJY5uNW4rthY+E2regkWH
	FWogM0UG30OkpRmpHqwOMZXjcei1Ne6DurGzFqw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:D4WqQoUOrtRyfbgG5KlxzH+HpzDOoemLeeWWF/nLiCg=:PQoyupbMg2njfXs6ToWwebDfUPj5dNNJpMJ29LhN9Rw=;
X-ME-Sender: <xms:wgfNaoasVMd5sE2Z-0QTDxBtFyqDD6Ac8TIIbIZulLEQtZCDOeI97A>
    <xme:wgfNak4DN7cMc6a5M7yUqbaFRJYAengTST9I-ymmhbEv4RANPWxk3pDmXVbIpvNLs
    08Oph7ShpjdwSjdsjPENEj8L0sPl5t3d58vu-Vh-OF1WoMGxqRHeAHD>
X-ME-Received: <xmr:wgfNajA5YlT_WTSeDY4fXH0WXHLN1uZMviJxPLv_fVvjTEx63DRVAjqZqkRnwAdaQuJGL7RD58SvgOl-uvE3aP_hLZlwG78CeWJi_zIZkVpbTWU>
X-ME-Proxy-Cause: dmFkZTFEMwmtDSpelq94cY4P+EWtNIN0mxMVSICiMHJZEWvgzVlQ9JFl8GF7VjQxLsP99k
    C75AILWGnDOiF8tAYoZq0HS227A6wx243eJhU4UAfgknTDtjHw32qCb/Xu9pTW+9UucOci
    sB2vvOQed9qMlv5X9tuf8t11f0jqtrChZi11Xal7oGFqu6wgS1AIL7+Tj4NpzV38R8VrY/
    NrXiE8K8BGUT5DbOvlBxIWOM7lBcNe1DpVMbgd3CKe41xsX5p6PQ6mPCEfpIak4hHbwbuC
    fQyto39x0Zw1U52RVAYk5DobjifECXsMssX7QtWPWVlZcwNEfUqaAFNpjSHbVAfgWaPQAb
    46FnYsRHsdedwiOyWTftu/V8BnNAEosJ9TM+zZpvznksQa1KXky/vDFq1rvXq+UWLCvRpD
    BJcYZTxG1mPYu6IlGS6QCvO9njFRu84wzAwt7fPpRPj+wh0kwnysAQDD46hWcmUT1Y5+kK
    ysn7aN/6z03LV0FP9KGAHMI57fKjhiQoIw0wru37Pir3VNLBS7D8A3hYvPhb2v765G/LLr
    bAB/v5l5GV7WU2LRRK0RiWU+1ZJ85mNqsrkkVBv6rB3B+OEm07D/1JiLEzTjuxOJ+lyR6B
    ZCuYtWI7uIrT3xBT70k5ZNnxM9g4SzEqr9bldMBxn3zm1NihUu0s4TR2+AaQ
X-ME-Proxy: <xmx:wgfNaifTb4mtvBo1MVPMyhZ4q7TIzoci6tzrs9BrYJtkNKl6_kyqLQ>
    <xmx:wgfNaqI5f8zaFQ_s-mWMrFKMwwDJKu_o9g333mPZDdEubDv1LiyuWA>
    <xmx:wgfNal1XvPT2_xRP7yMKSIB_cy0T0TE8gkrRWYFQudwbtDUvz_LvcA>
    <xmx:wgfNakgbLuP_SqiYzVZICdjajW1FnTd84ANQzHQhojVkOP-AM8fDsg>
    <xmx:wwfNaopY4WOW5IwI902MDv_JmDqJJBiRqr7AYbL2LfZMjkHtImPlhuGb>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 12:16:02 -0400 (EDT)
Received: from xanadu (unknown [100.84.23.49])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 0F00A22583;
	Mon, 12 Oct 2026 12:16:02 -0400 (EDT)
Date: Mon, 12 Oct 2026 12:16:01 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Tal Zussman <tz2294@columbia.edu>
cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
    Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cramfs: convert cramfs_blkdev_read() to use folios
In-Reply-To: <810d7901-b897-4880-a8d4-d80fe0f8770b@columbia.edu>
Message-ID: <eb5ff8ee-cc80-f8f8-0602-ccb9ad4a1b12@fluxnic.net>
References: <20260906-cramfs-blkdev-read-folio-v1-1-1be99a82be55@columbia.edu> <810d7901-b897-4880-a8d4-d80fe0f8770b@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

On Mon, 12 Oct 2026, Tal Zussman wrote:

> On 9/6/26 7:45 PM, Tal Zussman wrote:
> > Read the block device pages through read_mapping_folio() and copy with
> > memcpy_from_folio() instead of going through a page.
> > 
> > Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> > ---
> >  fs/cramfs/inode.c | 23 +++++++++++++----------
> >  1 file changed, 13 insertions(+), 10 deletions(-)
> > 
> 
> Following up on this - I don't see a cramfs tree, so could this go
> through vfs if everything looks ok? It gets us one step closer to
> removing read_mapping_page().
> 
> Thanks,
> Tal

Yes, please forward to the vfs tree.

Acked-by: Nicolas Pitre <nico@fluxnic.net>



> > diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
> > index d4cd03f4f60d..b55eb3bd29c1 100644
> > --- a/fs/cramfs/inode.c
> > +++ b/fs/cramfs/inode.c
> > @@ -194,7 +194,7 @@ static void *cramfs_blkdev_read(struct super_block *sb, unsigned int offset,
> >  {
> >  	struct address_space *mapping = sb->s_bdev->bd_mapping;
> >  	struct file_ra_state ra = {};
> > -	struct page *pages[BLKS_PER_BUF];
> > +	struct folio *folios[BLKS_PER_BUF];
> >  	unsigned i, blocknr, buffer;
> >  	unsigned long devsize;
> >  	char *data;
> > @@ -227,15 +227,15 @@ static void *cramfs_blkdev_read(struct super_block *sb, unsigned int offset,
> >  	page_cache_sync_readahead(mapping, &ra, NULL, blocknr, BLKS_PER_BUF);
> >  
> >  	for (i = 0; i < BLKS_PER_BUF; i++) {
> > -		struct page *page = NULL;
> > +		struct folio *folio = NULL;
> >  
> >  		if (blocknr + i < devsize) {
> > -			page = read_mapping_page(mapping, blocknr + i, NULL);
> > +			folio = read_mapping_folio(mapping, blocknr + i, NULL);
> >  			/* synchronous error? */
> > -			if (IS_ERR(page))
> > -				page = NULL;
> > +			if (IS_ERR(folio))
> > +				folio = NULL;
> >  		}
> > -		pages[i] = page;
> > +		folios[i] = folio;
> >  	}
> >  
> >  	buffer = next_buffer;
> > @@ -245,11 +245,14 @@ static void *cramfs_blkdev_read(struct super_block *sb, unsigned int offset,
> >  
> >  	data = read_buffers[buffer];
> >  	for (i = 0; i < BLKS_PER_BUF; i++) {
> > -		struct page *page = pages[i];
> > +		struct folio *folio = folios[i];
> >  
> > -		if (page) {
> > -			memcpy_from_page(data, page, 0, PAGE_SIZE);
> > -			put_page(page);
> > +		if (folio) {
> > +			size_t offset = offset_in_folio(folio,
> > +					(loff_t)(blocknr + i) << PAGE_SHIFT);
> > +
> > +			memcpy_from_folio(data, folio, offset, PAGE_SIZE);
> > +			folio_put(folio);
> >  		} else
> >  			memset(data, 0, PAGE_SIZE);
> >  		data += PAGE_SIZE;
> > 
> > ---
> > base-commit: df2908090cda368b01ff43709f51890076c56157
> > change-id: 20260906-cramfs-blkdev-read-folio-16fecf6908ac
> > 
> > Best regards,
> > --  
> > Tal Zussman <tz2294@columbia.edu>
> 
> 
