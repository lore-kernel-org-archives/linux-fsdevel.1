Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256253;
	b=mdt4awlZItaTf55Yr7AqnyQlNNYldQqb677rdX4CTHsVnH0Lsbh+j32YTlS7gWdU8jBY
	 p0ofLByg+8sN+w66VBYQFGqwvvHjlcpdx72nfoqAq95ESmjEkhyzfe5Q5ryCqu5XlcMcx
	 r7AS6eMwCJn98b+BFmSQx6wjCMP1S+5myEymKhXAtm2cPn1usFJ1vQXfHbTVfVy+rxBA8
	 akaDBVwXqius32Il9LekBTlt338B1Imwf6A6Hszjjz9KfM+E4y/hRD34GNkSwdrh7TJa9
	 1LSWFN35yMlCBDDL2U9sjwE+usXvcx4iLxzfaHlbmWDbsX+thisgHTj/u/HdcsazYrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256253;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=8fiDCQCRdhXgmLQB5RoXvNckgRlJaUgMVt4yvwE8wp0=;
	b=hqtn7ysDU3YO/SSVZU3s3Zlz8FsSy8JO47IAFAJRcdj+p4vWQkgsJFDvYPpbHjsjUQq7
	 34yzZ301XJUobpEYfLhpqsg+RHYZMtfrhk2tjnvzjbPEvcD5RG9FqRrh6JTqNZum5Kvi0
	 O1Wn+pi8Vf6xZlpFCV79L3pJHR6E54sJPl77IbXaVxUpE/arbRh/vWmwrWoFoHSV+Q6EA
	 dKM50WKfsi887RuDHKeaArRmaPqWCFGcBxtY8ifCMf+0VLOCwcqQNCMQiZ/YDJGY7Uqx5
	 uL6RslQZOVmXtXeMJ4V1iVngta2Bj5e/SVkMJDVQBt0FCsieg9YYfB9ddAERw4QOXXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=o+ZHiSlL;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A664606A31C;
	Mon,  9 Nov 2026 20:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A664606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=o+ZHiSlL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8fiDCQCRdhXgmLQB5RoXvNckgRlJaUgMVt4yvwE8wp0=; b=o+ZHiSlLjBJBn2ee3/lPBmRaSs
	VryBh9nDG8CuqdYgskBC0HfggwANkB3rxDS+VJs6NhztS84Tvg5pkagIvdKZZjuL9AN3gVZVL/yck
	wH5DnIFA8gxoTQdMEHgVLFJyphVxU/t3hRUF82o2h1zlB4AfNB8apqmUACY2FzocTTYdnCwfUAsGn
	TXfdtUC9XT6yHugH94idT1au2Wozd/Q7KscUnDZDAUvi3R4H4KzIrUB1eK6wetfnuQFbXwjl6GE91
	ANuBzWrTdFrQJu2WqNOp0H5HnRSlWZxNJfmWJ3XD7zRm2/sYafNoJwumff8oKyhMJ32MxtX0r8a1F
	sZOjsevA==;
Received: from willy by casper.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQW0u-00000000jrk-0IQW;
	Mon, 09 Nov 2026 20:30:48 +0000
Date: Mon, 9 Nov 2026 20:30:47 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
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
Message-ID: <avItd6rDqP3GB6pL@casper.infradead.org>
References: <20261109120403.82361-1-kas@kernel.org>
 <20261109120403.82361-2-kas@kernel.org>
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
In-Reply-To: <20261109120403.82361-2-kas@kernel.org>

On Mon, Nov 09, 2026 at 12:04:01PM +0000, Kiryl Shutsemau (Meta) wrote:
> do_shared_fault() unlocks the folio around ->page_mkwrite(). Writeback
> can lock it in that window, fail, and clear PG_uptodate with the folio
> left in the page cache. ecryptfs_writepages() does this when encryption
> fails. filemap_page_mkwrite() relocks the folio and checks only
> ->mapping, so the fault maps a folio that is not uptodate:

Filesystems that do this are buggy.  They shuld be fixed, not worked
around like this.
