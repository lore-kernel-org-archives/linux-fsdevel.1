Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A813947B5;
	Wed,  1 Jul 2026 11:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782906900; cv=none; b=M+BmyGNV+VbS+9jvdZohr9PHUC67ktQhLQtBN7tdeSbTEnBo61wSceZA4oGGYXhV+U0fGJkbIvPqFSXOPl5uMUsKVReMYCMYCcams6RBuYMTi9rbtdgpngtRqlED1xul360kKSgjoJT81B8o5LupfvXRzrOKrRTuzRi54vHXV1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782906900; c=relaxed/simple;
	bh=B1JbXvkwd4/Y4ZH2QTjAeMegR5lucGW4hOym5f+V9aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgQEYswpXTlG/xE6GwsJiIR7v9riIkMF6cFWFBkM2ivi3ZDcmR5MBDW7YZazPugYHHEBkxfIt77zuedXiQXYgR4IenOfuiy3125aLT9n/ruy4pkbRxydbkY8odm/JxpEhoX4YMk3y6hInITxvMsIBhTdi7/rjBwdkLmYn1zvPB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=G6juNmxC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G6juNmxC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ynEd00maGClTV0JaeyRDWLXtGZwZhygQ1CoNB2HYOls=; b=G6juNmxCl0VnCD8s4JdbR2Ira0
	f92jZs8zB01KxR7CsJhun/q0X7drYbh0LJ8T9TCF4rA0isvlEQaKWnEtGHJdW/1Jjw41nuqGFtNB3
	oh/w/2QB4BSFybsRcYT6Du/5BDIf9ztwl4FkVNQLcItpyNo9RG6yDh701zsp0ZDPiwOWNZWtaRef0
	/+4katzvz3iF1ank4ReEh9jcRtAD+2Rw0Y7VUR6WOTDa6pZuAWCTKjaR00fOoC3KOlmoSqdDX3ZI0
	5oBl8Ur+O1/gDL8Lh7ZKm2iEpFDig1mFZw6PZZzGZOxiBfpQjj4d6+b3f4r1OwQKoD+H4Escuc/iq
	sVeLKmoQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wetWm-00000006YZU-2TT1;
	Wed, 01 Jul 2026 11:54:52 +0000
Date: Wed, 1 Jul 2026 12:54:52 +0100
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
Message-ID: <akUADHLWEetveHLp@casper.infradead.org>
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

Oh, the other thing is that this should be conditioned on
!mapping_large_folio_support().

