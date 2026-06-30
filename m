Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1847226F288;
	Tue, 30 Jun 2026 22:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782858871; cv=none; b=tD8NCrr/+avDgBRpp+MA+6E01x6TPP/M2wFcBznl7+JTLxdpttu6re8UFu1CvwcikT6PnmaApqTQ/ieH9lXY/cP77ZDgjJmFtH95QX2g45DF4RAbxuN9h5AuMJpvJKuRcQpKM/VMSzcrpn+WabsuBlqShioXMoBvZaIkIhiXhas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782858871; c=relaxed/simple;
	bh=o38Vv4ZfrVwsvTxdHueHwpecZLkwRzJBnL9hvCQrmU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBC+dmVgDbT9yM6D/lEQwsjUEx3BegktMU5qKdLs6DCrSzvYw9Hu6ccdZw8C6rX1Nj3CfhLzNc+gy9STZn5uWeY8f0UdEHCijaPDWOpRtBkCOBwbn/+Ncq11qVj1HZyqmvgrmixgcvYMxAv0M3K946MMLbJ23JJNrbP+SvuR9yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WpKr6pNi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WpKr6pNi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1BqAxmW3e1hhXspm1Gh4qNnGjB5Tn65aWNgmzXjJfok=; b=WpKr6pNidx3q9iJnRzgtyiWoiu
	b8vgmhgbbS8QUDxZXIhz7FswaFl9XJCSeQf73V47deJf040xnTTeUL4xzW1WWdg0Ag1qM6soZ030S
	MDIWUBalfqj7iQlO7skfhgo7545AVisGdzMhJFUXgwI7qREWL7apWFK1ftFg8lEyv2JQ5ZtWiXKEi
	6aA8IsaypyDt1PgMQlizUxmjvuNccOb2xfGLZJNNvRozbhmdtsZaaAKzo+ZyENa62xyxlPwohxweb
	/dle3Je8Y1GHgtEFSPyH+GkuHE+qLos1GqekVWivmSVImTm9uoURrnCme7ol58/vUumL0rRz9qmgO
	LnbEMwkg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weh27-00000005cZQ-1Zuh;
	Tue, 30 Jun 2026 22:34:23 +0000
Date: Tue, 30 Jun 2026 23:34:23 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Gregg Leventhal <gleventhal@janestreet.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Song Liu <song@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Eric Hagberg <ehagberg@janestreet.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Zi Yan <ziy@nvidia.com>
Subject: Re: Subject: [BUG/RFC] write-open file THP cache purge can discard
 dirty page cache
Message-ID: <akREb81Z15bChEt3@casper.infradead.org>
References: <CAFN_u7H_0ECF3jixP=T=U7AH5=Q3wQNvJMo8an3VqUDMerQfUw@mail.gmail.com>
 <akQIIav_zaK6RmIC@pedro-suse.lan>
 <akQO8JtTxmp89GS8@pedro-suse.lan>
 <akQekZUyoKadiGCH@pedro-suse.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akQekZUyoKadiGCH@pedro-suse.lan>

On Tue, Jun 30, 2026 at 08:55:12PM +0100, Pedro Falcato wrote:
> Gregg, if you could test this patch, it would be much appreciated. This patch
> (hopefully) makes it so no dirty folio will ever coexist with a ro-THP, thus
> hopefully sidestepping the entire issue in a simple way. Only compile-tested
> and not reviewed.

I'd suggest this is slightly misplaced; it's actually called in some
failure places (eg:

                if (!folio_isolate_lru(folio)) {
                        result = SCAN_DEL_PAGE_LRU;
                        goto out_unlock;
...
out_unlock:
                folio_unlock(folio);
                folio_put(folio);
                goto xa_unlocked;
...
xa_unlocked:
        try_to_unmap_flush();


I'd expect to see your new code inside the existing 'if (!is_shmem) {' block
immediately before the xa_locked label.  I'd also follow the
inode_is_open_for_write() case and decrement nr_thps there rather than
introducing a new SCAN code.

> -- 
> Pedro

> >From 43d90a937f0b24656a8d0405035c3efcfdf0961e Mon Sep 17 00:00:00 2001
> From: Pedro Falcato <pfalcato@suse.de>
> Date: Tue, 30 Jun 2026 20:48:41 +0100
> Subject: [PATCH] mm/khugepaged: write all dirty folios when collapsing
> 
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> ---
>  mm/khugepaged.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index a97b20617869..3f0f90ab16ba 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -60,6 +60,7 @@ enum scan_result {
>  	SCAN_STORE_FAILED,
>  	SCAN_COPY_MC,
>  	SCAN_PAGE_FILLED,
> +	SCAN_WRITEBACK_FAIL,
>  };
>  
>  #define CREATE_TRACE_POINTS
> @@ -1812,7 +1813,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  	pgoff_t index = 0, end = start + HPAGE_PMD_NR;
>  	LIST_HEAD(pagelist);
>  	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
> -	int nr_none = 0, result = SCAN_SUCCEED;
> +	int nr_none = 0, result = SCAN_SUCCEED, err;
>  	bool is_shmem = shmem_file(file);
>  
>  	VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);
> @@ -2043,6 +2044,17 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  	 */
>  	try_to_unmap_flush();
>  
> +	/*
> +	 * If collapse looks to be successful, flush any dirty pages
> +	 * out the page cache. With the nr_thps incremented, there won't be
> +	 * any new writers (nor new dirties).
> +	 */
> +	if (result == SCAN_SUCCEED && !is_shmem) {
> +		err = filemap_write_and_wait(mapping);
> +		if (err)
> +			result = SCAN_WRITEBACK_FAIL;
> +	}
> +
>  	if (result == SCAN_SUCCEED && nr_none &&
>  	    !shmem_charge(mapping->host, nr_none))
>  		result = SCAN_FAIL;
> @@ -2210,9 +2222,10 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  	/*
>  	 * Undo the updates of filemap_nr_thps_inc for non-SHMEM
>  	 * file only. This undo is not needed unless failure is
> -	 * due to SCAN_COPY_MC.
> +	 * due to SCAN_COPY_MC or SCAN_WRITEBACK_FAIL.
>  	 */
> -	if (!is_shmem && result == SCAN_COPY_MC) {
> +	if (!is_shmem && (result == SCAN_COPY_MC ||
> +	    result == SCAN_WRITEBACK_FAIL)) {
>  		filemap_nr_thps_dec(mapping);
>  		/*
>  		 * Paired with the fence in do_dentry_open() -> get_write_access()
> -- 
> 2.55.0
> 

