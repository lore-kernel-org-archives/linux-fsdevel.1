Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BBF285CAA
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 15:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783695735; cv=none; b=OqP+tEynI+GOCtqe3aq8TcwJR8xd4gQt6Cp4CCiNbAb4TtpqJ93Vk7oJDIbZyBzoX+eeHtNucXO1bB4HE4lQO/Lv0hZ2gDe71fIGz/SrxNdeoKLIG6Oi9We0S3X1jr7WtdIjYOWI/JGgkF2/e3XN3/wGjBGRgskCRc34B1Lff74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783695735; c=relaxed/simple;
	bh=PWzBTKypw2gLHnz89NWVL5NsYOVj1OJvcfISJqnx24Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ks4cZFIF0bs4ja1LOLdvv+9qGFrr1mbK6beyrZ77nvsMAay9HQ+uoJawV55eFTo9o9hbe+R2dDcA8VQizue473x9RN0xmW4p6tn44irDc4eazdv8O1MY8Az+nXjTiOuG+2smQXmiHfNO61CvzUSxk18uCDqyXjmUF2WuckIXsa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MZROCy6l; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MZROCy6l"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783695730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZI5LYV42PS6biPr4EpPtmNA2/Ct3B0vmxWhVv67hMQ=;
	b=MZROCy6lL1QQmCPfIUisZeY0kM2GabQXwOtIPP3A3cm+RMRXSOgYac6UptYGQ7VhqXNeyw
	wtutsvb8aPqVZi6zc3EgSwoO0ln7YS4KO4nhj6JIKdxo8xv2KVisPl5jAXmGHUZKQ/nqtB
	2NYd28az7X/hUd6bbc+c0FbG1Akn/0M=
From: Usama Arif <usama.arif@linux.dev>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Usama Arif <usama.arif@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>,
	linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH v2 06/10] memory-failure: Prevent UAF in raw_hwp_page list
Date: Fri, 10 Jul 2026 08:02:03 -0700
Message-ID: <20260710150204.1887475-1-usama.arif@linux.dev>
In-Reply-To: <20260709184740.1286561-7-willy@infradead.org>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Thu,  9 Jul 2026 19:47:34 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> Most accesses to the raw_hwp_page list are protected by mf_mutex.
> However, the call to folio_clear_hugetlb_hwpoison() in mm/hugetlb.c
> does not.  This is probably OK today as this is in the freeing path and
> I think all current calls to is_raw_hwpoison_page_in_hugepage() hold a
> reference to the folio.  However, the next patch will call this function
> without holding a reference on the folio, which will expose this race.
> 
> Rename the current folio_clear_hugetlb_hwpoison() to
> __folio_clear_hugetlb_hwpoison() and wrap it with a new
> folio_clear_hugetlb_hwpoison() for the benefit of external callers.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/memory-failure.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 53063e2a1f97..353288cce1b2 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1935,7 +1935,7 @@ static unsigned long folio_free_raw_hwp(struct folio *folio, bool move_flag)
>  	return __folio_free_raw_hwp(folio, move_flag);
>  }
>  
> -void folio_clear_hugetlb_hwpoison(struct folio *folio)
> +static void __folio_clear_hugetlb_hwpoison(struct folio *folio)
>  {

Good to add lockdep_assert_held(&mf_mutex) here, but there is a issue below.

>  	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
>  		return;
> @@ -1945,6 +1945,13 @@ void folio_clear_hugetlb_hwpoison(struct folio *folio)
>  	folio_free_raw_hwp(folio, true);
>  }
>  
> +void folio_clear_hugetlb_hwpoison(struct folio *folio)
> +{
> +	mutex_lock(&mf_mutex);

This wrapper can now sleep, but its external caller is the hugetlb free
path.  __update_and_free_hugetlb_folio() is reached from
update_and_free_hugetlb_folio(), which has a comment saying
"Defer freeing to avoid using GFP_ATOMIC"

> +	__folio_clear_hugetlb_hwpoison(folio);
> +	mutex_unlock(&mf_mutex);
> +}
> +
>  static int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
>  				 bool *migratable_cleared)
>  {
> @@ -2051,7 +2058,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags)
>  	folio_lock(folio);
>  
>  	if (hwpoison_filter(p)) {
> -		folio_clear_hugetlb_hwpoison(folio);
> +		__folio_clear_hugetlb_hwpoison(folio);
>  		if (migratable_cleared)
>  			folio_set_hugetlb_migratable(folio);
>  		folio_unlock(folio);
> -- 
> 2.47.3
> 
> 
