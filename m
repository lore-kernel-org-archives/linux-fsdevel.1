Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534B2381B03;
	Tue, 14 Apr 2026 07:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776152894; cv=none; b=UIoCvH3HVJZKIemfU5DDW3S4zT38aCC5UGD7b1ztQCSSH2rxcfJVby3p3O80RAaTxazCQQCuPbycWB9weXpJnWaE4mceIiX6aEywv55bhkG3KX0xhWJA2P5xZyN6XAn16ncWtUyFC7Dyh/g1YyBETqvL22OJ/4cP/OfeJ+1q7nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776152894; c=relaxed/simple;
	bh=Vo8I0qhLt4wp907NZhqDdp5qUzTsOYUT5GTm2xQ9n1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzJWFJq983PX+YP7KW2xT8/jN0Lm6MEaF2/6dwJDI+IwZ5E7O+9FEEhPFyWRpLd+cnDWCYQf4oCOgBYNya+j2HhW9ay2SirrPvEpk7c3OR3rkKX9/p/4aqJDioHjLXw08wOQKS8M8THdp99QLdcTbp+0DDvNpOh4ZEee2Vv4qu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tCll1VUk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tCll1VUk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mQU94fiChMs8s73Hk9p3t74X0fyEWgNmpMh4SQ5FZtA=; b=tCll1VUkT0NJMf0YsZpYpkrg1o
	RTzsJU2xQlnhqreJID/gDCVDnlisTsCJTYbzcYi1E9X/yyhIvDBynb/xPodIuTB4JvJhG8JQYU/j8
	LSucQI3K8c6KBSHBTuU38+N3xWDY4uysgsZF8UpeLq7hy1gZ6wfgqTZaKTZnxW3hYZ5hxwJGZOiNf
	m1fFbMBbutq+fgqm32erUxfvGtuf9UgcexMnnv6j4RyLbpe54YzSDbybWZ2lneKzmNbbCuayaNDfb
	vpPUbpEH74RuO5OR4z7rbLjpdVu1bZFuzWo9bBSef1vd74Huag13SeGGoi2Ro2sYxaQ58vD831pK5
	iqAkoPDg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCYVE-0000000GvIY-0yr4;
	Tue, 14 Apr 2026 07:48:08 +0000
Date: Tue, 14 Apr 2026 00:48:08 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Jens Axboe <axboe@kernel.dk>, stable@vger.kernel.org,
	Google Big Sleep <big-sleep-vuln-reports+bigsleep-501448199@google.com>
Subject: Re: [PATCH] mm: Call ->free_folio() directly in
 folio_unmap_invalidate()
Message-ID: <ad3xOI71tU2Uofo_@infradead.org>
References: <20260413184314.3419945-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413184314.3419945-1-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 13, 2026 at 07:43:11PM +0100, Matthew Wilcox (Oracle) wrote:
> We can only call filemap_free_folio() if we have a reference to (or hold a
> lock on) the mapping.  Otherwise, we've already removed the folio from the
> mapping so it no longer pins the mapping and the mapping can be removed,
> causing a use-after-free when accessing mapping->a_ops.
> 
> Follow the same pattern as __remove_mapping() and load the free_folio
> function pointer before dropping the lock on the mapping.  That lets
> us make filemap_free_folio() static as this was the only caller outside
> filemap.c.
> 
> Fixes: 4a9e23159fd3 (mm/truncate: add folio_unmap_invalidate() helper)

That commit just consolidated code, but did not change the locking
assumptions, and did in fact not touch this part of the code at all
despite moving it into a new helper.  So I don't it this is the
culprit.

