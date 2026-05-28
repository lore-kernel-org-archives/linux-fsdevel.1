Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E8E1D130E;
	Thu, 28 May 2026 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779972587; cv=none; b=EHpRUitifn3LhCApPl9vzWVAYmKyrRPNUNmS/77mclToGI9T8qq5/NbAuF6tFc0fwomdP9sL2X2O/9nYUz2w1+qzQBCU/MLNe6qj6TGPryddVbNsZjgSj5wyZsZmCuF7E4sEueYyk34IGPHzhy0JaPS0hsC3sy3GTixT9Tl+4qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779972587; c=relaxed/simple;
	bh=BxsZlQH/NmhJWCy0C0vQPhklXsles/VSUoE8slX9KFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6RKMkXKViyxKLL15dUrFGIydHyKoA78t0RZueis4tF7r/sGeAcqevR5XaS2DRfgaGBELFfDxY2evNfTXI1HT6TvLR0sbA9cwOe6k0rcYu/XKyl8II/HqW6BWxY9ZNPq9dXaNnGIhMu+mX71mboQ1n9VZgdV+Z3uK45ukI6F/NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AcBo2kFB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AcBo2kFB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7G6U2FOW7FeLuMO+G3YOi7XP6zPp5DB5XZz1vAGJDdM=; b=AcBo2kFBlUmREj6D6f0eKT4T4y
	46dZcGN/eLbRRLwv26lUr6d8nBZ0DIrSduOoMatNxpjeLqIgYQaXCdrqIivgiBHMSBojOcil+KSF5
	b9U1sMiwffkblDJ+zhJF+unRt5BfW8oj4Q1CAq3TbVB3RigiyZdEiDvgx/xQ0vk2zurn7JXidKboT
	RBGLE8aMptY21RjCVD6XyVH4pqPz7u1ZJn3tCoMfj6+v09920aPPwS6PuceYOOt5MbT303mbhXVuz
	h09jXnUKm+dAQEanZ5//GDHo0yMbBZcjnqu8FYS+kxM7k/NJZzzevOeDt5CThnMzUsLBxTSj5/s7K
	AiDiENhg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSaBA-00000005jvl-2bcT;
	Thu, 28 May 2026 12:49:40 +0000
Date: Thu, 28 May 2026 05:49:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Tal Zussman <tz2294@columbia.edu>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: Re: [PATCH RFC 00/11] mm/filemap: split out folio wait and VFS code
Message-ID: <ahg55Ei8Fc3iRsnA@infradead.org>
References: <20260520-filemap-split-v1-0-c36ddc2b6cf2@columbia.edu>
 <3dxzu3ck5y3wxw4pp2qhzwwb6y3f7mwhvgxfpl56sokw4ymop7@xaaoxsa5yu5q>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dxzu3ck5y3wxw4pp2qhzwwb6y3f7mwhvgxfpl56sokw4ymop7@xaaoxsa5yu5q>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, May 28, 2026 at 11:22:37AM +0200, Jan Kara wrote:
> Overall this makes sense to me. In particular I agree it makes sense to
> move the file read/write helpers into fs.

I disagree very strongly.  Mixing default implementations with the
higher level APIs is a really bad idea and leads to people taking
stupid shortcuts and other layering violations.

Splitting up filemap.c makes sense, but I'd rather keep the generic copy
into and out of the pagecache code with the MM infrastructure for it,
as it is not VFS code, and making that clear to anyone touching the code
is important.

