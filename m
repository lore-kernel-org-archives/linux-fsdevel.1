Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235391;
	b=ynKmqU/03gZRJYWJQVFasa/Gvc6uXRTVOLNmi+eX4Ouy3fHeVRgw6wYo0psP3TegyoRE
	 TdBP1tayy+HuF+FaRAdRdfqBY0d7yiHBtgiIxCyz+k46CCqgn1X/4rUuu5/ml58HmbLMA
	 UlpcHolh5zW8VK2p4lQQpRhXXfjxlhB/s2OS4yDy36xg841uyRTZtjTbxZYFmfSbccQqO
	 LK0VmbThf3pxjMWpCIKJX+ih9OXQrvPDVpnUnnYwEhxqXOYGOhY5Zl1GMGXM9qfKixSOx
	 MI4t3n/W9yutIvIeT53TrNRAAbABHIJ5XvgHRjTES38B90qTWCBvtQaFxXwNyZM1gOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235391;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=8xp9qI2Ok6sylEAN+gwDtNeJcQqJMD2By0aR3Vam4ic=;
	b=EYonIdh7RsTSdNj0sqZkjhb4/V74Njz3IBFqauGwEvuLYOH4vw8vEidccY8r1NR9C0ag
	 zeJOF15n4ovNxu56DEFdaV9a99nmWnr+3WK/RjnxcugMdfnMkxlImRMnf2ZgOfzkwOIah
	 iKF2evnZhZMQDNi3E21Px6uvKjuq5oG7SCUVydfoD7NcLhSwLGl99S/d7R6ZF+55S8JFm
	 QSGVOj+56oOFVy/NQm3P2OKGikK+8R9J7CNcXfN+wo2yAi1GVDCt95oXn3yvfY2JBYVcx
	 z3fq9OHLItISZl+npxXzCbdnwhDu5SOK/HCIF1c0lGVDBsevFFjOeswI8xNq0fXLq4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fiRcdJU3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3FA606A331;
	Mon,  9 Nov 2026 14:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fiRcdJU3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71801F0089F;
	Mon,  9 Nov 2026 14:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794235390;
	bh=8xp9qI2Ok6sylEAN+gwDtNeJcQqJMD2By0aR3Vam4ic=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fiRcdJU3ll1oX0GL0kFkxzsBFsMHgUWajfOKORb5n5LGR0Ijd/a/ZTZV+msRt+7AE
	 izmHSZ0aw7NmYNXW2GLtEsOVZAVfpyTgNpWMg0tnkNJIiyc5/KCWAsOooJ2agALkvo
	 xMx1r2vihgzi5AJitWcAdZVUonHMXvaKgl9UVq27SVx9gYsvdThm6KBH+43D8zNpIr
	 FMQ7SsNDb6DxIz8AlwOC0mr0jutSYBOHsbEGL+VL9IRKLrnSaOy3QQQC3fefk2V1Bc
	 NeugOO2gVdweOhasQ4WB+Fp70fov7x2MciIpscO2WdjUB0pXFmsgdSIiWUkB+DBpqF
	 g6u1UllN9MC0w==
Message-ID: <aa2a1e32-9b1d-4545-b2e0-03d213593023@kernel.org>
Date: Mon, 9 Nov 2026 15:42:58 +0100
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 01/18] mm: free PG_rcu_free folios only after an
 RCU grace period
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Jan Kara <jack@suse.cz>,
 Hugh Dickins <hughd@google.com>, Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Harry Yoo <harry@kernel.org>,
 Miklos Szeredi <miklos@szeredi.hu>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Oscar Salvador
 <osalvador@suse.de>, "Liam R. Howlett" <liam@infradead.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <brendan.jackman@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>,
 "Paul E. McKenney" <paulmck@kernel.org>, Pedro Falcato <pfalcato@suse.de>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Ilya Gladyshev <ilya.gladyshev@linux.dev>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev,
 kernel-team@meta.com
References: <20261104130118.2507513-1-kas@kernel.org>
 <20261104130118.2507513-2-kas@kernel.org>
 <ecad7b3c-7244-425a-9413-04d49f221057@kernel.org>
 <au2lsbDkyWt-To0C@thinkstation>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <au2lsbDkyWt-To0C@thinkstation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/26 11:23, Kiryl Shutsemau wrote:
> On Thu, Nov 05, 2026 at 09:37:31PM +0100, David Hildenbrand (Arm) wrote:
>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>> index 604c58199acb..6e5341b0bf64 100644
>>> --- a/mm/Kconfig
>>> +++ b/mm/Kconfig
>>> @@ -718,6 +718,21 @@ config PCP_BATCH_SCALE_MAX
>>>  	  latency.  This option sets the upper limit of scale factor to limit
>>>  	  the maximum latency.
>>>  
>>> +config PAGE_RCU_FREE
>>
>> I think we really want to focus this only on folios (like the current code does).
>>
>> FOLIO_RCU_FREE ?
> 
> Sure.
> 
>>> +	def_bool y
>>> +	depends on 64BIT
>>> +	depends on !PREEMPT_RT
>>> +	help
>>> +	  Reads from the page cache can copy from folios that are read
>>> +	  again and again without taking a reference on them, so small
>>> +	  reads of one file from many CPUs do not contend on the folio's
>>> +	  reference count.  The cost is that memory freed from such
>>> +	  folios becomes reusable only after an RCU grace period.
>>
>> While that description is helpful, that's not really what this patch, or rather
>> the basic infrastructure in page_alloc, does.
>>
>> I'd suggest to have a dedicated FOLIO_RCU_FREE config and maybe another one
>> (that selects/depends on) FOLIO_RCU_FREE that actually enables the pagecache use
>> and documents the details.
> 
> I will make the help describe what this patch does.  The page cache is
> the only user, and both symbols would be def_bool without a prompt, so
> I would rather add the second one with a second user.
> 
> Does that work for you?
> 
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 1e5d68acf62a..25082949a4ca 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -3743,6 +3743,7 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>>>  #endif
>>>  				 (1L << PG_dirty) |
>>>  				 (1L << PG_dropbehind) |
>>> +				 __PG_RCU_FREE |
>>
>> That looks a bit odd at first, as it's very different to the other once. But no
>> easy way around assuming that the flag is not always around.
>>
>> Maybe we should just have this be a const mask constructed somewhere using BIT()
>> and __PG_RCU_FREE etc, instead of having this growing list in this user here.
> 
> Makes sense.  Something like the diff below, on top of this patch.
> Introducing split_copy_flags would be a preparatory patch, and this one
> would only add __PG_RCU_FREE to it.
> 
>>> @@ -1327,6 +1417,19 @@ static __always_inline bool __free_pages_prepare(struct page *page,
>>>  
>>>  	VM_BUG_ON_PAGE(PageTail(page), page);
>>>  
>>> +	/*
>>> +	 * Not for a hwpoisoned order-0 page: it never reaches the allocator,
>>> +	 * and page_handle_poison() takes a reference right after this free.
>>> +	 */
>>> +	if (unlikely(folio_test_rcu_free(folio)) &&
>>> +	    !(PageHWPoison(page) && !order)) {
>>> +		VM_WARN_ON_ONCE(fpi_flags & FPI_NOLOCK);
>>> +		__folio_clear_rcu_free(folio);
>>> +		count_vm_events(PGFREE_RCU, 1 << order);
>>> +		rcu_free_defer(folio);
>>> +		return false;
>>> +	}
>> I'm wondering whether we want to intercept on the folio freeing path instead?
>> That would be __folio_put(), before we go into free_frozen_pages() used by other
>> machinery that does not apply (slab etc).
> 
> Not all page cache folios are freed through __folio_put().  Reclaim
> frees them with free_unref_folios() directly (shrink_folio_list(),
> move_folios_to_lru()), and so do folios_put_refs() and the LRU batches.
> __free_pages_prepare() is the one place they all pass.

Can we just rework that code first to have some clear folio freeing path, IOW
doing this in a folio-specific helper?

folios_put_refs() is just a specialized and batched variant of the __folio_put()
freeing path in the end. So we can hook into these two easily.

For free_unref_folios() would need another hook or a cleaner rework.


> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index a1e52a1f8a52..6d4e534c9ccc 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -1185,6 +1185,18 @@ static __always_inline void __ClearPageAnonExclusive(struct page *page)
>  #define __PG_MLOCKED		0
>  #endif
>  
> +#ifdef CONFIG_ARCH_USES_PG_ARCH_2
> +#define __PG_ARCH_2		BIT(PG_arch_2)
> +#else
> +#define __PG_ARCH_2		0
> +#endif
> +
> +#ifdef CONFIG_ARCH_USES_PG_ARCH_3
> +#define __PG_ARCH_3		BIT(PG_arch_3)
> +#else
> +#define __PG_ARCH_3		0
> +#endif
> +
>  /*
>   * Flags checked when a page is freed.  Pages being freed should not have
>   * these flags set.  If they are, there is a problem.
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 25082949a4ca..44a1aaa3f834 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3689,6 +3689,23 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>  	const bool handle_hwpoison = folio_test_has_hwpoisoned(folio) && new_order;
>  	long new_nr_pages = 1 << new_order;
>  	long nr_pages = 1 << old_order;
> +	const unsigned long split_copy_flags =
> +		BIT(PG_referenced) |
> +		BIT(PG_swapbacked) |
> +		BIT(PG_swapcache) |
> +		__PG_MLOCKED |
> +		BIT(PG_uptodate) |
> +		BIT(PG_active) |
> +		BIT(PG_workingset) |
> +		BIT(PG_locked) |
> +		BIT(PG_unevictable) |
> +		__PG_ARCH_2 |
> +		__PG_ARCH_3 |
> +		BIT(PG_dirty) |
> +		BIT(PG_dropbehind) |
> +		__PG_RCU_FREE |
> +		LRU_GEN_MASK |
> +		LRU_REFS_MASK;


I was rather thinking of a


#define FOLIO_SPLIT_FLAGS	BIT(PG_referenced) | BIT(PG_swapbacked) | \

...

To make this function actually shorter :)

(ofc, you could also have a static const unsigned long, if that's what we want)

-- 
Cheers,

David
