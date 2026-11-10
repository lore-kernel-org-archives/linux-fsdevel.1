Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794338753;
	b=oMxN5u37X2tJjuYY+FJdKg9L8GFW9PRukoL7WjtPDJme4rUTKS2TPaNeu6rZFBy1RowP
	 og5GSWwUPpAZbSaQ+jnDHReDLjNqd4pgmWAEbKp+xXhBBHK/x4C5NEeEgUYln9A36R+aM
	 oslR3JnDL+7jMTz2Da1lMXZuef/OQGJgF0hRVBt79lm9YUMWGq6HkTEZobh7B6hUbNV23
	 d7gQPTfT67yU0Xazl03RbjcRt8lF/6kuQUkkTxTjytAQOYroHqTijplOlrnvrvA7lrgS9
	 5rlvd3Crlvj/Bb4a3qIsPjN0xTjgo5BAI1+1+M/RZiFu1/EWD+REvxOZ9fdH1YI9SXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338753;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=ExSFRNBdpFZqpaarK7S24/veHyaXPw+cAkj34YFoUsg=;
	b=Nv2yHB4mK9TVE3Bai9gIrs5wijfsh2rxB5inqTBuwmWRwtBvPV0B9t1UEctLA+o/fm/H
	 Sa2YGjqCFOFrXKqrA6xjNnwn60q+KP96+Bquvtxb/JPr+ywgyLlblm9GJGM2QxhpNx1bp
	 00pD+K3aqt8A5W9vb7oqDpLRA4bpMdlRUCli1+KSq+3hvAUFsjn0y6cp94Fbjox/CqA2E
	 SiceaTlvnZhKsWSxCmP+0Ru2J3/Du63F5xsRGKIhnuyH/l5q1EyGuzr/S6EZc5kmMjdmt
	 0GAZac4RPZ3KeOUF1hZmCv/XSp9Njp3ZRTHtSWUNq5uwJoiS92XQ9zeSskm5YoG4B+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=mga3BmeB;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D2D606A320;
	Tue, 10 Nov 2026 19:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09D2D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=mga3BmeB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ExSFRNBdpFZqpaarK7S24/veHyaXPw+cAkj34YFoUsg=; b=mga3BmeBgZ2RPvRZvXlBQ7Q9tz
	XouFPDsqvq8SAEQvaqGMv7iU2O+VEH9MG23DJWzJJzD+yrCHWUvM2L8PjOs9b5feXZXH4rEGw14rY
	ZQ8X5cwp1Q4/g4sMooNR7ciLkpZqwN8zkW4at7wmvuvY1+F144VSMQlZn9QZW9aE72mlMJaeY8kVj
	m8kRJbfcnClHz5IhKU8P5KjpVTb2yhuCvGELCXhuujyOho6cVXAlv87ukRNnq+P59eUjN5INC+SZU
	EvQC8rPJfUWhs4w77LHL2DajB6bVUHL2EIJtSZyYCvNMUnwodQOCI7xx9XfanOhzIiU0qnTtCdEcq
	yYulOyNw==;
Received: from willy by casper.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQrTV-00000000TR9-2wpr;
	Tue, 10 Nov 2026 19:25:45 +0000
Date: Tue, 10 Nov 2026 19:25:45 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>, Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>,
	Chris Mason <mason@kernel.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2 1/2] mm/memory: recheck PG_uptodate after
 ->page_mkwrite()
Message-ID: <avNvufn4HLIhVm2k@casper.infradead.org>
References: <20261109120403.82361-1-kas@kernel.org>
 <20261109120403.82361-2-kas@kernel.org>
 <avItd6rDqP3GB6pL@casper.infradead.org>
 <avLzpIM1VdE31a-B@thinkstation>
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
In-Reply-To: <avLzpIM1VdE31a-B@thinkstation>

On Tue, Nov 10, 2026 at 10:38:34AM +0000, Kiryl Shutsemau wrote:
> On Mon, Nov 09, 2026 at 08:30:47PM +0000, Matthew Wilcox wrote:
> > On Mon, Nov 09, 2026 at 12:04:01PM +0000, Kiryl Shutsemau (Meta) wrote:
> > > do_shared_fault() unlocks the folio around ->page_mkwrite(). Writeback
> > > can lock it in that window, fail, and clear PG_uptodate with the folio
> > > left in the page cache. ecryptfs_writepages() does this when encryption
> > > fails. filemap_page_mkwrite() relocks the folio and checks only
> > > ->mapping, so the fault maps a folio that is not uptodate:
> > 
> > Filesystems that do this are buggy.  They shuld be fixed, not worked
> > around like this.
> 
> Fair. What is your take on the way out?
> 
> Is there a timeline for the filesystem fixes?
> 
> Until they land, mm should still not map a folio that is not uptodate.
> 
> Would WARN_ON_ONCE() and SIGBUS, like the other checks in 2/2, work for
> you? It flags the buggy filesystem instead of hiding it.

It doesn't matter which way round the race ends up; if a filesystem marks
a mapped folio as !uptodate, there are other VM assertions that will
trip eventually.  This is one of those cases where we should ignore the
bot because it doesn't quite know enough.
