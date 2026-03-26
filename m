Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E1D1B652E
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 05:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774504064; cv=none; b=pwDlr7RhrZ5laWOojDp8CrzifZ2KIsFZr/OdkNhmT4qM1CJUC/EMYLZDRzzSBnFlTydihz0MeJTO5EOcTy0b7EOMllIevM6LLH0Dsbm3yabpcZitBnslxAiYt04HvOSXHQWmwybAs3RJigUSdITE7RmmdBWeU9gldnje0OZgMz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774504064; c=relaxed/simple;
	bh=R5osSaE4VhAunpZc96tVg45sztS+Nkc5VIzlElHwYYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1EZxjWNx6uwMWQ8XjCK0q21btaTNaCbDFCkBj/+UTIxB/p37Siz3epaO1EPRsEB0iWydY6lMCOjFdojSRUuhdt37sYoJ6uQ0evjW9yeI5Sj9EmtjjwNvF/KvG9X2PT6IefT5va14b7MWA6e6c9m2twpFghpw1/botz8Wp45mdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uJUVRpgR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uJUVRpgR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gJPA5KfpnXgszSs3txv7BlRC9eKrJP27IScmTnIXBXU=; b=uJUVRpgRTExMa2njPMyzHszt7H
	EUWzMsahh2BumFxfST8smPwSQRoV6ldpmzk1Q4Flu87A7QnWS3EFkulWRahdiMeBwgdQZLbIEjgnp
	nWfOxbN/Ft8Boo868Z/UppyJLhED/uOhDatid3sc5ojg0yucu9hJ/pOGKBl0U+SGQQJiWNiCvaKus
	F9rQiaMFwBoEGZvXX9RZ1stNdVOulvkw787/IOHr94LXGIoWQk6UTYjV27Mhy+WSt0PnwwEVJqys3
	XOeoONTa+n4dc/hfjxY2mPUj7226Fk9ErqN7VryKjFX7ePuT/pFPGRsB7hboHc1vBHVWE+Q6o/HPv
	qLV4McyA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5dZE-00000004lAU-0oQg;
	Thu, 26 Mar 2026 05:47:40 +0000
Date: Wed, 25 Mar 2026 22:47:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Jianzhou Zhao <luckd0g@163.com>
Subject: Re: [PATCH v2] udf: Fix race between file type conversion and
 writeback
Message-ID: <acTIfOuv3Ik-erB0@infradead.org>
References: <20260325162209.29233-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325162209.29233-2-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Mar 25, 2026 at 05:22:10PM +0100, Jan Kara wrote:
> udf_setsize() can race with udf_writepages() as follows:
> 
> udf_setsize()			udf_writepages()
> 				  if (iinfo->i_alloc_type ==
> 						ICBTAG_FLAG_AD_IN_ICB)
>   err = udf_expand_file_adinicb(inode);
>   err = udf_extend_file(inode, newsize);
> 				    udf_adinicb_writepages()
> 				      memcpy_from_file_folio() - crash
> 					because inode size is too big.
> 
> Fix the problem by rechecking file type under folio lock in
> udf_writepages() which properly serializes with
> udf_expand_file_adinicb(). Since it is quite difficult to implement this
> locking with current writeback_iter() logic, let's just opencode the
> logic necessary to prepare (the only) folio the inode can have for
> writeback.

Still not a fan of open coding this logic, which is even worse than
the previous export.  Inline data is a relatively common case in
various file systems, and we should be able to handle it in common
code.  So having a callback in mpage_writepages seems much better,
but if you detest that we could just export mpage_write_folio and
mpage_bio_submit_write (and make mpage_data public) instead.  I think
that's significantly worse than just adding the callback, but still
much better than open coding more writeback internals, something I
want to get away from.

