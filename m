Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696552;
	b=BmrpN7pc+oK3opBt1lcvdY3SbMWOkfzYl7TPBT56xApbfsAcOrew9u9gGbPdHL+9tah8
	 kGJmX4dXbgwUDzw6Y+ZMHNCkZZrRcrc8WUPk21A9RIVIKlfGND7tEmrY3HVdTA5Pdl7Y3
	 7bMtskaFnTQoTHKhb8Xa6o/S5YUoGN/acV98W/+aDQ7CYhj8r5rliF4VQnmCXk/6RZxUU
	 6XwDlpFBaXdc4cpyCsa5aLuCZOD63YUFN1TrdLEB0VYbLmEmUoSGGxfXBgbP39gqzUl33
	 nxFAG1JIBX54vew8LAdMMl88BLS0cZr5abGE03CSCQHPzHAYs3oQ/Lf4zktwPWTeSjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696552;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=yPwWcuoDWOTn8atKLFpGQ89U466zx/Mv3d/vV7gtKnU=;
	b=0Cohk2WhxQEbqYYPHQkxnoPhILsbEhLLywyKAPtI9SXICLno09sGVQWwseJyo3kLlwoH
	 RDj3/t3Tj0+9Hfz7yX61m9GLmaB5PHdBNHiS53EV4oGtsKn6DNE+LQQHUYvqVmBGRLPs4
	 VVJnfSeQtBdzVXpo9jaPOtlKO7Hkf4ZJ9UuhUAJlSvU2imMMQ+39Kkbm4EaRTJG+S1Omr
	 NfkFzbOkEyd+KjmeZkrcT+SMRvXUnHazWEWLth4/1P/7B+rOfm3Q4O9Dbs446yXKc6RpD
	 9gRv3EuBrxbhI1S5QRa74EljWDzMOBpvzCr4ODYieO4tiQC5Lq8Ke4cNIEaHiQp45tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b="1/oGAtuW";
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAEC606A327;
	Tue,  3 Nov 2026 09:02:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AAEC606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1/oGAtuW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yPwWcuoDWOTn8atKLFpGQ89U466zx/Mv3d/vV7gtKnU=; b=1/oGAtuWT2KWhEFRC0FTkzNppH
	wgXiQ2Ax4H/oBJt4BaXkLjBieYi3WUfEbFUxTw3xeT5wFBZpKwfVO+8jSBpOGIzs1SI8IfInMaOJM
	ZtULKr+ilyZI0KuG44SlzdR66N7LRMAVHnrjak6xgOtaQ6U15Fftbr4CnuRKBgviXR55bg77aszF9
	GMSWN0JL0gx7Qo17wPfMPofozNRuJN5Tih1J8LcjLSB0xFy3YIAbh5SzYzpD5G+iM2MHh8WFy+1b7
	1LV9qY3FTE26dPYsAG1p2DZcWv546ALdk2S7drH3vVBfTNfYmqNUGVyWwbAaoe0wSq0PI+A2+BZyJ
	WvC+VZOg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOAPH-00000001g21-0qAv;
	Tue, 03 Nov 2026 09:02:15 +0000
Date: Tue, 3 Nov 2026 01:02:15 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Tal Zussman <tz2294@columbia.edu>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] mm: remove newly-unused page wrapper APIs
Message-ID: <aumjF5peb2vyuncA@infradead.org>
References: <20261102-page-wrappers-v1-0-e7280bdb31f6@columbia.edu>
 <20261102175605.a0d9caee8279ffb5f6fdf15f@linux-foundation.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102175605.a0d9caee8279ffb5f6fdf15f@linux-foundation.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 02, 2026 at 05:56:05PM -0800, Andrew Morton wrote:
> >  9 files changed, 8 insertions(+), 110 deletions(-)
> 
> Tal, you obviously haven't been following along ;)
> 
> 
> This development cycle is not the one for cleanups and new features,
> but this one sneaks through!

Given that this is purely dead code removal I'd actually vote for
fast tracking this into 7.3-rc.  Unused API better be removed ASAP
before people start using them again.

