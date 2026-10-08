Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA53483BD9;
	Thu,  8 Oct 2026 09:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791451500; cv=none; b=LAPbDZmWFRLpsozOm9ueEMcyb6+kaDd5GSkI7BXNOgAGoQ1R5xXgWX/jtom8zwhRImyhHTC1/dyShm9pqQ0IbvbcA9IXDmdipUFeOdOp1NpuQmL4uhuTMmdxJOJC7LQyxe8GXUPmJDPPLV1GXXilLYTeSVOSN8Hh8Aj2wbRIG98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791451500; c=relaxed/simple;
	bh=pT6b/vzr2WN0ox/Vn0FuooSsRXOYvHu95+QAcB2ftl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEi6ZfD/3x7dK9yB7nBOYGmB9bW067TKJY20Nm6YVpVwxfW7a9pc86uW8s9L+skYiw1mSU1ZU/A2JRAoMO5paT1yn+rXJ6i4Fs5yW3W9fsmjzVSW1CH+Izdw+eUpked6GlMECxG4v5A4p187h7NvKyPLibiXyX+I/byNZ7OsFLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1A92021BEB;
	Thu,  8 Oct 2026 09:24:52 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3CFD13354;
	Thu,  8 Oct 2026 09:24:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 84CsL2Nhx2qNewAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 08 Oct 2026 09:24:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 79CDFA13FC; Thu, 08 Oct 2026 11:24:43 +0200 (CEST)
Date: Thu, 8 Oct 2026 11:24:43 +0200
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ayush Ranjan <ayushr@modal.com>, Pedro Falcato <pfalcato@suse.de>, 
	Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>, 
	Gregory Price <gourry@gourry.net>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] shmem: FALLOC_FL_PUNCH_HOLE vs fault-around race corrupts
 page cache / rss counters
Message-ID: <fyswoh7wpxzlbnjjanggjd2jz6yispmeirhwjl3wzi57nacddb@bjkb6kxyfcal>
References: <20260924061708.1645968-1-ayushr@modal.com>
 <arTdLsBENhrpOyk-@pedro-suse.tail5790ac.ts.net>
 <20260925053027.1998394-1-ayushr@modal.com>
 <20260925065013.3682431-1-ayushr@modal.com>
 <20261003033107.1488699-1-ayushr@modal.com>
 <20261004222831.bdd648a2b406f02747dd9e40@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004222831.bdd648a2b406f02747dd9e40@linux-foundation.org>
X-Rspamd-Pre-Result: action=no action;
	module=Unknown lua;
	unknown reason
X-Spamd-Result: default: False [0.00 / 50.00]
X-Spam-Score: 0.00
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Pre-Result: action=no action;
	module=Unknown lua;
	unknown reason

On Sun 04-10-26 22:28:31, Andrew Morton wrote:
> On Sat,  3 Oct 2026 03:31:03 +0000 Ayush Ranjan <ayushr@modal.com> wrote:
> > Gentle ping on this. The reproducer in my previous mail [1] triggers
> > "Bad page cache ... still mapped when deleted" on 6.18.46 within a
> > couple of minutes on a 128-CPU bare-metal box, with no fork() and no
> > gVisor involved.
> > 
> > We continue to hit this in production at low frequency, so I am happy
> > to test patches or collect more data if that would help.
> > 
> 
> fwiw I made gpt and gemini argue about this for a while and ended up
> with the below.

Worth a try I guess. Let's see :)

> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: mm: shmem: serialize fault-around against hole punching
> Date: Sun Oct 4 09:05:31 PM PDT 2026
> 
> shmem uses filemap_map_pages() for fault-around.  Unlike shmem_fault(),
> filemap_map_pages() does not participate in shmem's fallocate exclusion
> protocol.
> 
> During a partial hole punch of a large shmem folio, the folio can be split
> and the resulting smaller folios can remain temporarily visible in the page
> cache while shmem_undo_range() restarts its walk.  Fault-around can then map
> one of those folios again before the hole-punch path removes it.
> 
> shmem_undo_range() may subsequently delete that folio from the page cache
> despite the new userspace mapping.  This can trigger "still mapped when
> deleted" warnings and leave stale mappings or inconsistent RSS/page-table
> accounting behind.

So this part of explanation is either incomplete or wrong in my opinion.
Yes, shmem_undo_range() calls truncate_inode_partial_folio() which can
split a large folio. Yes, filemap_map_pages() can map those pages back into
page tables. But how "shmem_undo_range() may subsequently delete that folio
from the page cache despite the new userspace mapping" happens is unclear
to me. After splitting a folio, shmem_undo_range() will restart and find the
newly split (and mapped) folios and calls truncate_inode_folio() to get rid
of them. Now truncate_inode_folio() calls truncate_cleanup_folio() which
does:

        if (folio_mapped(folio))
                unmap_mapping_folio(folio);

so the mapping is reliably removed under folio lock. Can you perhaps push
your agents further to explain in more detail how this "still mapped when
deleted" happens in their opinion?

								Honza

> The race dates back to d7c1755179b8 ("mm: implement ->map_pages for
> shmem/tmpfs"), which enabled generic fault-around for shmem without making
> it participate in shmem's hole-punch exclusion protocol.
> 
> Serialize shmem fault-around against the hole-punch unmap/truncate sequence
> with mapping->invalidate_lock.  The hole-punch side holds the lock
> exclusively while unmapping and removing pages.
> 
> do_fault_around() invokes ->map_pages() under rcu_read_lock(), so the
> fault-around side cannot block on invalidate_lock.  Use the shared trylock
> instead.  If the trylock fails, skip fault-around and let the normal shmem
> fault path handle the fault.  Otherwise hold the shared lock while
> filemap_map_pages() installs mappings.
> 
> This preserves fault-around in the uncontended case while ensuring that
> pages in a punched range cannot be remapped between unmap_mapping_range()
> and shmem_truncate_range().
> 
> Fixes: d7c1755179b8 ("mm: implement ->map_pages for shmem/tmpfs")
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  mm/shmem.c |   27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> --- a/mm/shmem.c~a
> +++ a/mm/shmem.c
> @@ -2938,6 +2938,27 @@ static vm_fault_t shmem_fault(struct vm_
>  	return ret;
>  }
>  
> +/*
> + * A hole punch can temporarily leave split folios visible in the page cache
> + * after it has unmapped the range.  Do not let fault-around map them again
> + * before shmem_truncate_range() removes them.  ->map_pages() runs under
> + * rcu_read_lock(), so this exclusion must be non-blocking.
> + */
> +static vm_fault_t shmem_map_pages(struct vm_fault *vmf,
> +				  pgoff_t start_pgoff, pgoff_t end_pgoff)
> +{
> +	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
> +	vm_fault_t ret;
> +
> +	if (!filemap_invalidate_trylock_shared(mapping))
> +		return 0;
> +
> +	ret = filemap_map_pages(vmf, start_pgoff, end_pgoff);
> +	filemap_invalidate_unlock_shared(mapping);
> +
> +	return ret;
> +}
> +
>  unsigned long shmem_get_unmapped_area(struct file *file,
>  				      unsigned long uaddr, unsigned long len,
>  				      unsigned long pgoff, unsigned long flags)
> @@ -3865,10 +3886,12 @@ static long shmem_fallocate(struct file
>  		WRITE_ONCE(inode->i_private, &shmem_falloc);
>  		spin_unlock(&inode->i_lock);
>  
> +		filemap_invalidate_lock(mapping);
>  		if ((u64)unmap_end > (u64)unmap_start)
>  			unmap_mapping_range(mapping, unmap_start,
>  					    1 + unmap_end - unmap_start, 0);
>  		shmem_truncate_range(inode, offset, offset + len - 1);
> +		filemap_invalidate_unlock(mapping);
>  		/* No need to unmap again: hole-punching leaves COWed pages */
>  
>  		spin_lock(&inode->i_lock);
> @@ -5467,7 +5490,7 @@ static const struct super_operations shm
>  
>  static const struct vm_operations_struct shmem_vm_ops = {
>  	.fault		= shmem_fault,
> -	.map_pages	= filemap_map_pages,
> +	.map_pages	= shmem_map_pages,
>  #ifdef CONFIG_NUMA
>  	.set_policy     = shmem_set_policy,
>  	.get_policy     = shmem_get_policy,
> @@ -5479,7 +5502,7 @@ static const struct vm_operations_struct
>  
>  static const struct vm_operations_struct shmem_anon_vm_ops = {
>  	.fault		= shmem_fault,
> -	.map_pages	= filemap_map_pages,
> +	.map_pages	= shmem_map_pages,
>  #ifdef CONFIG_NUMA
>  	.set_policy     = shmem_set_policy,
>  	.get_policy     = shmem_get_policy,
> _
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
