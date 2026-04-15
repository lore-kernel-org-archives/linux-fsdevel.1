Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DE83016F7
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 05:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776232283; cv=none; b=ullHvkWRBOuXOXKryKIpP+fUL09yv6YEtju3zFGd2/AmMox6kTW5kj3f8ujp0VQoivLSTOPo7G+5oOmFHDM4gBa+N6vaoyqPfX3Ymkeu0xPyOirKZOQLOiurq0NQohBRvRsrJfyShI2eOuXDSFY/iKGQJyfHYKtniegweXGCzY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776232283; c=relaxed/simple;
	bh=tSBmTsoI0oOODYCBbVRX6vyNBx7IroBhfOGW97xiOWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UQn6GpnnSQWUVu5XA7H/8BmIXUX5hdPeo0fJ9yLVO+DoBMdnD/8LCSgjkiS5qRf1l2UiuXwykY76vn9Ur4+5eG1eyARz40VCwzo+Ulx1n80wGsXSbw6dKFjR7ccEaiCjLRVeopY+ulc/09qesRVsthpKYTZG9Rqcmrw5yuKAv+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O1wBKG9X; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O1wBKG9X"
Message-ID: <c55c49d7-642b-4b99-a2c7-053cb88541d0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776232277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fk7YcQ6QKf5fLUVsvamkPBjeLdGsl9ofX5zFjUfyoj4=;
	b=O1wBKG9X40Zk2mMmuCRqGjMgiGlRuDC+q7N47GfqkXQg8WL8pshpe1HRLc8NEm4jemSF8b
	KgwkiMqtYJtlqorV/PWC5OtuPCGZ7kX+05rXeX6JYXYBzdYL9Afx3DUG7G1ez7TRaZOpgH
	dMOzuM1aV4jv9sXiJ1KcbwLPMnmhQWY=
Date: Wed, 15 Apr 2026 13:51:02 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/4] mm/vmstat: remove unused __node_stat_* wrappers
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Ye Liu <liuye@kylinos.cn>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20260415022910.1890050-1-joshua.hahnjy@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <20260415022910.1890050-1-joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2026/4/15 10:29, Joshua Hahn 写道:
> On Wed, 15 Apr 2026 08:50:54 +0800 Ye Liu <ye.liu@linux.dev> wrote:
> 
>>
>>
>> 在 2026/4/14 22:59, Joshua Hahn 写道:
>>> On Tue, 14 Apr 2026 17:15:20 +0800 Ye Liu <ye.liu@linux.dev> wrote:
>>>
>>>> From: Ye Liu <liuye@kylinos.cn>
>>>>
>>>> Replace the single call to __node_stat_mod_folio()
>>>> with node_stat_mod_folio(), and remove the dead inline __node_stat_*
>>>> wrapper definitions from include/linux/vmstat.h.
>>>>
>>>> Signed-off-by: Ye Liu <liuye@kylinos.cn>
>>>> ---
>>>>  include/linux/vmstat.h | 18 ------------------
>>>>  mm/page-writeback.c    |  2 +-
>>>>  2 files changed, 1 insertion(+), 19 deletions(-)
>>>>
>>>> diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
>>>> index 3c9c266cf782..54da7d820f78 100644
>>>> --- a/include/linux/vmstat.h
>>>> +++ b/include/linux/vmstat.h
>>>> @@ -440,24 +440,6 @@ static inline void zone_stat_sub_folio(struct folio *folio,
>>>>  	mod_zone_page_state(folio_zone(folio), item, -folio_nr_pages(folio));
>>>>  }
>>>>  
>>>> -static inline void __node_stat_mod_folio(struct folio *folio,
>>>> -		enum node_stat_item item, long nr)
>>>> -{
>>>> -	__mod_node_page_state(folio_pgdat(folio), item, nr);
>>>> -}
>>>> -
>>>> -static inline void __node_stat_add_folio(struct folio *folio,
>>>> -		enum node_stat_item item)
>>>> -{
>>>> -	__mod_node_page_state(folio_pgdat(folio), item, folio_nr_pages(folio));
>>>> -}
>>>> -
>>>> -static inline void __node_stat_sub_folio(struct folio *folio,
>>>> -		enum node_stat_item item)
>>>> -{
>>>> -	__mod_node_page_state(folio_pgdat(folio), item, -folio_nr_pages(folio));
>>>> -}
>>>> -
>>>>  static inline void node_stat_mod_folio(struct folio *folio,
>>>>  		enum node_stat_item item, long nr)
>>>>  {
>>>> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
>>>> index 6f9b7b081ab7..ed3301753e89 100644
>>>> --- a/mm/page-writeback.c
>>>> +++ b/mm/page-writeback.c
>>>> @@ -2627,7 +2627,7 @@ static void folio_account_dirtied(struct folio *folio,
>>>>  
>>>>  		lruvec_stat_mod_folio(folio, NR_FILE_DIRTY, nr);
>>>>  		__zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, nr);
>>>> -		__node_stat_mod_folio(folio, NR_DIRTIED, nr);
>>>> +		node_stat_mod_folio(folio, NR_DIRTIED, nr);
>>>
>>> Hi Ye, thank you for the patch,
>>>
>>> In addition to what Matthew has pointed out, I also wanted to note that this
>>> substitution isn't trivial; there are differences between the __ prefixed
>>> version of node_stat_mod_folio and the one without. Even though the correctness
>>> of the two versions might be the same, I think that a change like this should
>>> be supplemented by a description of what side effects this change has
>>> (i.e. introducing additional overhead from the cmpxchg loop).
>>>
>>> Thank you, I hope you have a great day!
>>> Joshua
>>
>> Thank you for your review, Joshua. Regarding the difference between
>> __node_stat_mod_folio and node_stat_mod_folio: in the current implementation,
>> both functions ultimately use __mod_node_page_state, as mod_node_page_state
>> is defined as __mod_node_page_state. There is no functional difference
>> between them in terms of atomicity or overhead. The __ prefixed versions
>> were wrappers that are now unused, which is why we're removing them.
> 
> Hello Ye,
> 
> Thanks for the quick response. However, I'm not sure that's true.
> For #ifdef CONFIG_HAVE_CMPXCHG_LOCAL in mm/vmstat.c, I can see that
> mod_node_page_state calls mod_node_state, which includes the cmpxchg loop.
> I think many users enalbe this config, including x86. IMHO, we should document
> this effect of the changes.
> 
> Thank you, I hope you have a great day!
> Joshua

Thank you for your review, Joshua. You are correct that there is a difference.
The __node_stat_mod_folio call goes directly to __mod_node_page_state, which
assumes the caller already has the necessary serialization. By contrast,
node_stat_mod_folio goes through mod_node_page_state, which on systems with
CONFIG_HAVE_CMPXCHG_LOCAL uses a this_cpu_try_cmpxchg() loop and on other
systems serializes via local_irq_save/restore.

That means the wrapper removal is not purely cosmetic: it changes the
update path from a direct per-cpu diff update to a serializing update
path, and therefore incurs extra overhead.

-- 
Thanks,
Ye Liu

