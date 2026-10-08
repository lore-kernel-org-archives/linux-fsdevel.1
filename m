Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67474B1473;
	Thu,  8 Oct 2026 15:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791472989; cv=none; b=TnhKwujPXM0Q3lxTbz6ZRqepAsIaO7dlhufNpTGDTkGHmpV4Zulx9vNX8iiuYk+hJzqYkYZQagFv0nlasD2OqKo7JTzr7kjVFPr38gRUjay6JC+4KPGRDBkL1J4a773bSKNdbasjQVD9dd9soVFC7qJUzuzUwURzL8K5bFO6SDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791472989; c=relaxed/simple;
	bh=piFFa/Hyqbg5nhGUqDzhQiZnSoFtR3dQJbgVmc2Nmvc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=n+n2kzwffwYxFZPEeiLQabifW7eMEQojO3hKW8vgmqRa7ce2eom8PV87FGMUTTH8qJZ2VDtQq5lCmxXudrIglQYk6OuJbwWsBsP4LGtovYCEeHB0b/d4paWH888n77U1/73ef/Bc1vOwDVYBblkyM/+7Qk0J33dJh98LineM5Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dg/XcnNm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dg/XcnNm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F2B1F000FF;
	Thu,  8 Oct 2026 15:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1791472985;
	bh=fktCSzXnzSArMXx2H5jz1jzKpq1XlCXEdiEKb6zN3UM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dg/XcnNmNfHhYyVEaxqh1yGjfpJX4lpMY/htsYBegD+nxiyjtU8PvuCqjYodFdSKU
	 wT9o1xD1Cf0qtnlbQdUruk0andtRTl0WVQ6Z/0U0IKR+ZOL5394V+GaIFktTEZrDuy
	 8GmXQzFAMQm3xb0yqkQDT2nTrDRJe2rWlAH0+8mE=
Date: Thu, 8 Oct 2026 08:23:04 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jan Kara <jack@suse.cz>
Cc: Ayush Ranjan <ayushr@modal.com>, Pedro Falcato <pfalcato@suse.de>, Hugh
 Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>, Baolin
 Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>,
 Gregory Price <gourry@gourry.net>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] shmem: FALLOC_FL_PUNCH_HOLE vs fault-around race corrupts
 page cache / rss counters
Message-Id: <20261008082304.bc6f4bd6c80fe6432abd4fc5@linux-foundation.org>
In-Reply-To: <fyswoh7wpxzlbnjjanggjd2jz6yispmeirhwjl3wzi57nacddb@bjkb6kxyfcal>
References: <20260924061708.1645968-1-ayushr@modal.com>
	<arTdLsBENhrpOyk-@pedro-suse.tail5790ac.ts.net>
	<20260925053027.1998394-1-ayushr@modal.com>
	<20260925065013.3682431-1-ayushr@modal.com>
	<20261003033107.1488699-1-ayushr@modal.com>
	<20261004222831.bdd648a2b406f02747dd9e40@linux-foundation.org>
	<fyswoh7wpxzlbnjjanggjd2jz6yispmeirhwjl3wzi57nacddb@bjkb6kxyfcal>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Oct 2026 11:24:43 +0200 Jan Kara <jack@suse.cz> wrote:

> > From: Andrew Morton <akpm@linux-foundation.org>
> > Subject: mm: shmem: serialize fault-around against hole punching
> > Date: Sun Oct 4 09:05:31 PM PDT 2026
> > 
> > shmem uses filemap_map_pages() for fault-around.  Unlike shmem_fault(),
> > filemap_map_pages() does not participate in shmem's fallocate exclusion
> > protocol.
> > 
> > During a partial hole punch of a large shmem folio, the folio can be split
> > and the resulting smaller folios can remain temporarily visible in the page
> > cache while shmem_undo_range() restarts its walk.  Fault-around can then map
> > one of those folios again before the hole-punch path removes it.
> > 
> > shmem_undo_range() may subsequently delete that folio from the page cache
> > despite the new userspace mapping.  This can trigger "still mapped when
> > deleted" warnings and leave stale mappings or inconsistent RSS/page-table
> > accounting behind.
> 
> So this part of explanation is either incomplete or wrong in my opinion.
> Yes, shmem_undo_range() calls truncate_inode_partial_folio() which can
> split a large folio. Yes, filemap_map_pages() can map those pages back into
> page tables. But how "shmem_undo_range() may subsequently delete that folio
> from the page cache despite the new userspace mapping" happens is unclear
> to me. After splitting a folio, shmem_undo_range() will restart and find the
> newly split (and mapped) folios and calls truncate_inode_folio() to get rid
> of them. Now truncate_inode_folio() calls truncate_cleanup_folio() which
> does:
> 
>         if (folio_mapped(folio))
>                 unmap_mapping_folio(folio);
> 
> so the mapping is reliably removed under folio lock. Can you perhaps push
> your agents further to explain in more detail how this "still mapped when
> deleted" happens in their opinion?

back to the drawing board...


You're right.  I pushed this further and I no longer think the explanation
in the changelog is sufficient.

filemap_map_pages() takes the folio lock, and shmem_undo_range() also locks
the folio before truncating it.  truncate_inode_folio() then calls
truncate_cleanup_folio() while that lock is held, and
truncate_cleanup_folio() calls unmap_mapping_folio() before
filemap_remove_folio().

So if fault-around maps the folio first, truncation should subsequently
unmap it.  If truncation gets the folio lock first, fault-around cannot map
it before it is removed from the page cache.  I don't see a direct
fault-around-only race which leaves the folio mapped at
filemap_remove_folio().

The earlier fork/copy_page_range() theory did have a way around the folio
lock, since copy_page_range() does not take it.  But Ayush's single-process
reproducer rules that explanation out.

The strongest remaining clue is that the reproducer requires repeated
partial splitting and aggressive khugepaged re-collapse, and the production
splat was on an order-3 folio with nonzero mapcount.  That makes a
split/re-collapse/rmap or mapcount problem look more likely than the simple
fault-around race I described.

So I don't think this patch is ready as-is.  It might suppress the problem by
adding broader serialization, but that would not demonstrate that it fixes
the underlying bug.

A useful next step would be to instrument truncate_cleanup_folio(), e.g. warn
immediately after unmap_mapping_folio() if folio_mapped() is still true.
That should distinguish "unmap failed to remove an existing mapping" from
"some path installed a new mapping afterwards", and narrow this down
considerably.
