Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8184346E56
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 09:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784193412; cv=none; b=nAwOq4Sr3QgrBfzWhQLm13NrZdvG8lSMZ7NDS/oE3GoUPxu00DnZiHB0a6WGvcIRYtYvICL43CzT6zIbGpwyFB5Ejrcv1aLlFga6rs3MVDES4YVbsZuhYzqhB2zzAnJp5AbsY6lLGqvHef/x63p4FsJAexF1/ZDOlhwkTnCxA3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784193412; c=relaxed/simple;
	bh=7Ik1VVdSnwCEXj4A2YVLcOE89PFesmMZ+XksiAPJ/Qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pdiRxT7sr0oXo/hGL4vEYDgh+qTyQJG8WY+exe0yV+vGJuejjrOsvwmhgoxI7TojNdiuLMUzY2////cBqy7UutfF+MlmVtHx0hUnB9LYX6YZxSZXvG1NfBdqNLuluRZ1WzakmUGl5zYcNY6BqIAUF9K6xDsVWuttRyVhJc7jqTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXEGcTIt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXEGcTIt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42D51F000E9;
	Thu, 16 Jul 2026 09:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784193411;
	bh=9+QeO9iVoKKWJWvyNCqyHwjW/CuxxhtsZmsx/N4xNfk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=aXEGcTItFQ6SMDs02DRy0B4OYxLDEovdTpEJN0LtkUsmt0xCgc3HoOeau7zJJ83TK
	 kJBNJiuJY0vBG7fO73AoFkCplwx+p+Fv/CPcBQm4kyMekySIjyuPWQcdv4G6+FiA8r
	 Wc/jFSyFgq35df4pkSM9pH0ITWXerLGb/G4VMQ7JdDiIaP8hI/OPpbOcmz0cocxZ52
	 +Q4vuvfohwPXGDz+dz0jUdVSEvaalb2bYTFe6e5Bo2k3z+l83f4+CH8Ai5CNa872Ef
	 ARX3HjsWixqx1R8flUBuOrzOoerY7ZRcBe72eRpPE0Huoy9tU7g36NLQWABlOr1wJp
	 UBpGKeBTO81Uw==
Message-ID: <7f630930-fbf7-42bd-945d-664484defc2c@kernel.org>
Date: Thu, 16 Jul 2026 11:16:48 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] memory-failure: Prevent UAF in raw_hwp_page list
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jane Chu <jane.chu@oracle.com>,
 linux-mm@kvack.org
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi
 <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, Christian Brauner <christian@brauner.io>
References: <20260709184740.1286561-1-willy@infradead.org>
 <20260709184740.1286561-7-willy@infradead.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260709184740.1286561-7-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/26 20:47, Matthew Wilcox (Oracle) wrote:
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
>  	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
>  		return;
> @@ -1945,6 +1945,13 @@ void folio_clear_hugetlb_hwpoison(struct folio *folio)
>  	folio_free_raw_hwp(folio, true);
>  }
>  
> +void folio_clear_hugetlb_hwpoison(struct folio *folio)
> +{
> +	mutex_lock(&mf_mutex);
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

As mentioned yesterday, I wonder if we can remove the entire subpage hwpoison
tracking. With HVO it is just beyond ugly and not really fun to maintain as it
seems.

Regarding read(), it was added 3 years ago [1], and the cover letter did not
even state a single real use case.

"Since memory_failure already tracks the raw HWPOISON subpages in a
hugepage, a natural improvement is possible: if userspace only asks for
healthy subpages in the pagecache, kernel can return these data."

I doubt there is practical use. But I'm happy to be educated :)

Is anybody aware of practical use for that?


[1] https://lore.kernel.org/linux-mm/20230713001833.3778937-1-jiaqiyan@google.com/

-- 
Cheers,

David
