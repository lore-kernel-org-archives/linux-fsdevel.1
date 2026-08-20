Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DBC47CC97;
	Thu, 20 Aug 2026 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787240536; cv=none; b=LCfWIKkh4yBXa9Y7UBNZyl5jYCCBb9BJruPAHenbX/A/KxpnZTbpnulUkF7HIOj1gt+0c15Qm4a18wS7L5SjApFlFO92VckyNYzZ5zaQ1+INL1+ClfrbWhbk7ik91bAR8F0p+rIiWNCtISb9jyrQbESf+rD0iiQC73WNwqH7Rqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787240536; c=relaxed/simple;
	bh=jQcoYoIGE5sY/R1HNGev4oMmWQwIYyOiz9kcMyWDz8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZgNm97h/yRzmkRw8gI7vZMUCPPogjwMSRCsB2nCASc9y/8acI1MooQtOFW8hu3u/NuROqk8x67sEj0YwQsJh9bES4SHoWWQOJbei6X6moMj2GaZMteNkt3wpgdSUQbWyAHMv2/MJmjtfk/gXRqrJQWums+zErp/bqRdf2yJamQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RKGS2X0c; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RKGS2X0c"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ulTlwX27slVFaLoUCzg2XqBiAD4jg0AAXlg4UNDOJpQ=; b=RKGS2X0c6oUnHo1brczhP49qgs
	UNr6SnLdoKe5XY4sfd9c074PQ4u+LSiVaw/uu+kNw2/SbZ86YeLSRgGf6f944TDYbE6SNWUctolci
	bxorucXSRC+hPkpqobOHuONmTWd5oxCP9TYcLypfNNAjmh1OwEpZk7V7LANh88DHWNGi/8+aPMooV
	CHqnPq7/jVcBtt/DaMe+JfylsuTHQv2evDKxvKkmE1bSpEbtvsDSeJnvQnuxHaUmfrdaiaJMH1T/h
	j6f68mIkXwhHk0nz9aKyauskCDqzSDeOxuMtwmwLI7bRsYuWTs58YyU5Jdsp1aygHHqLOkn0zcYya
	LiaWG5/A==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wx4qL-0000000FtO0-2kQt;
	Thu, 20 Aug 2026 15:38:13 +0000
Date: Thu, 20 Aug 2026 16:38:13 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Barry Song <baohua@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kairui Song <ryncsn@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>, Jan Kara <jack@suse.cz>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Youngjun Park <youngjun.park@lge.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>, Wei Xu <weixugc@google.com>,
	Yuanchu Xie <yuanchu@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] mm: swap: drop dropbehind swap cache folios on
 writeback completion
Message-ID: <aocfZSYFRvP7_vEG@casper.infradead.org>
References: <20260818163221.589352-1-alex@ghiti.fr>
 <20260818163221.589352-3-alex@ghiti.fr>
 <CAGsJ_4zC+wAuevG+i5y23rLPGXn0P=D7JpMECnZ1OuP1BsyYkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4zC+wAuevG+i5y23rLPGXn0P=D7JpMECnZ1OuP1BsyYkw@mail.gmail.com>

On Thu, Aug 20, 2026 at 07:36:42PM +0800, Barry Song wrote:
> > +void swap_writeback_dropbehind_folio(struct folio *folio)
> > +{
> > +       llist_add((struct llist_node *)&folio->lru,
> > +                 raw_cpu_ptr(&swap_dropbehind_llist));
> > +       queue_work(swap_dropbehind_wq, &swap_dropbehind_work);
> > +}
> > +
> 
> This is good. For file dropbehind, I see both F2FS [1] and block
> devices [2] reinventing workqueues in their own filesystems or
> drivers, while folio_end_dropbehind() simply benefits from its safe,
> sleepable context. This seems a bit odd.
> 
> So I'm really curious whether this could be extended to file-backed
> folios as well, so that those filesystems and device drivers don't
> have to deal with this themselves.

You should probably both be aware of Tal's series:

https://lore.kernel.org/linux-mm/20260730-blk-dontcache-v7-0-3e8e6850068d@columbia.edu/

In fact, I'd base this series on Tal's.  It would be considerably
easier.
