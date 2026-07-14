Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDC741A921
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 18:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054619; cv=none; b=hNifK0yej2vCQKEEd3VIA06cOa7KIG9iDXIcXMdM8bz0FtQOJrVwXajhcaDaG+QlP5oT9ov5q0lL0jW588JV8RDAY+YPNLs/VSTYuPLRGS+rZNa+3gTVw6RUkWUhyVXNPAyeAr9a73phKzOGUwYhHaBDgx6GK3odW73MSVY/ODI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054619; c=relaxed/simple;
	bh=m717ipbd//U+a03fcaAJmoAst2ai6On9B4hX+vL8wQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fI9dHNA2RwRur1vUW9kSErIBzOnqoTOKMuqvKgQ2V0dgqt35yE2sIn/GxuUkFbq0sNOeyo02T/ORp5G6y4qiaJphZ6IZ+vq0VoSLG8J0Zl9Ufmjb4QK505fwRFY0JyrbX6Z4gEbQwpHI1q65hVj4GG6WQKUYGrxamYuSi4lPcYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JEZDeTSb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JEZDeTSb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8qqi4VdONaPzMmzSGj2FveffiuakjmYRTDGSB2OYp7I=; b=JEZDeTSb6RduW2pmNb7i1wSbQD
	5myTIzLkzMC2f5HB7ARMHx1Ha9EvY7XPPMjvWTdwL2uA91wLyrfmsMGwSt3Jkk2rbmd3UlJJy7TR8
	y67ibPhpyJPc40ieGjH6q2iGhZLhlX3UUONb+Fsd40T9HU9ausX20zeYAgtsMLlfL6eroQkQ4C55t
	GQJsZo5inGDxZ4T4hcpNNYp7+2XCkuQ9GplCMPxHwuzvAmeqmb5Usz23cVv+cJyz3xy3MW074vOiZ
	ifwHyXxj6y68KDCx5Q3xzIjYN/d0ADKqI/06jbUo7zgYAGAONm2izXaLbdF6k30QqLYCDnpWpNw5A
	7akP/q4g==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wji69-0000000FixS-3GAv;
	Tue, 14 Jul 2026 18:43:17 +0000
Date: Tue, 14 Jul 2026 19:43:17 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH v3 6/9] filemap: Remove checks in
 mapping_set_folio_order_range()
Message-ID: <alaDRerpJdISdlRu@casper.infradead.org>
References: <20260714180840.3731244-1-willy@infradead.org>
 <20260714180840.3731244-7-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714180840.3731244-7-willy@infradead.org>

On Tue, Jul 14, 2026 at 07:08:36PM +0100, Matthew Wilcox (Oracle) wrote:
>  static inline size_t mapping_max_folio_size_supported(void)
>  {
> -	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> +	if (IS_ENABLED(CONFIG_FILEMAP_LARGE_FOLIO))

oops.  This test suite I'm using clearly isn't much good.

