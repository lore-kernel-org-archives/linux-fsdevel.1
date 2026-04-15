Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FA528BAB9
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 00:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776214283; cv=none; b=IvikFOpAplkz/baje1RXCfaZFEIPOXEfQ9CI3uA5GH7RDgfisN7jAfeVVj1uhnto9caPdzHv8jBATbj7kbdfb5bWNRRytNpl5Q5nSyzyHFgqLR+Ck2MKLycKMAlimarPFgXhESWFbrTgXSPWdQrOQu1z+x882AN0yVGtgzrxv/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776214283; c=relaxed/simple;
	bh=EWTn4M9BJF+za/T+/mJOFb4HtEHc0IBJUVKLa1AIRis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p9ueZcj6amKO3yEOsdriVaSohzOhcv1ZRhaTh3PFLIyKZgQ1pMJADuHWmJRSwFM/atK5kuC9q0bN8O/jWQUZnmX9hEnG1JHQitqM7UTBYxRKoZBAoXauG+3vpfCuYf94+7gOGqgPiFaVSgc8692iHbRBhoBxU6MzsqWg/j4mvoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J8YU0AlS; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J8YU0AlS"
Message-ID: <9a852e74-1499-4a5a-8e98-56a33c67d639@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776214278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4mzC9E+DlpUUGq46xAvgFHlJHte5hw9EwrSfNtsp0mE=;
	b=J8YU0AlS5C5k/kXq7rlFACUywmi7oGfW7YBS4Bq+IlpZTYRixEXAT3hqtLFusz3FxsXs6B
	rD8AsY97471H0gKZlgTZq1ZtamhUSPOnl8FSJVkIFg+jDSjB0vMtLRP3uLZDLFDplN4CFi
	027XHKDxVHXTl5dh7RIN1ZMbHGu5Pj0=
Date: Wed, 15 Apr 2026 08:50:54 +0800
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
References: <20260414150001.3262806-1-joshua.hahnjy@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <20260414150001.3262806-1-joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2026/4/14 22:59, Joshua Hahn 写道:
> On Tue, 14 Apr 2026 17:15:20 +0800 Ye Liu <ye.liu@linux.dev> wrote:
> 
>> From: Ye Liu <liuye@kylinos.cn>
>>
>> Replace the single call to __node_stat_mod_folio()
>> with node_stat_mod_folio(), and remove the dead inline __node_stat_*
>> wrapper definitions from include/linux/vmstat.h.
>>
>> Signed-off-by: Ye Liu <liuye@kylinos.cn>
>> ---
>>  include/linux/vmstat.h | 18 ------------------
>>  mm/page-writeback.c    |  2 +-
>>  2 files changed, 1 insertion(+), 19 deletions(-)
>>
>> diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
>> index 3c9c266cf782..54da7d820f78 100644
>> --- a/include/linux/vmstat.h
>> +++ b/include/linux/vmstat.h
>> @@ -440,24 +440,6 @@ static inline void zone_stat_sub_folio(struct folio *folio,
>>  	mod_zone_page_state(folio_zone(folio), item, -folio_nr_pages(folio));
>>  }
>>  
>> -static inline void __node_stat_mod_folio(struct folio *folio,
>> -		enum node_stat_item item, long nr)
>> -{
>> -	__mod_node_page_state(folio_pgdat(folio), item, nr);
>> -}
>> -
>> -static inline void __node_stat_add_folio(struct folio *folio,
>> -		enum node_stat_item item)
>> -{
>> -	__mod_node_page_state(folio_pgdat(folio), item, folio_nr_pages(folio));
>> -}
>> -
>> -static inline void __node_stat_sub_folio(struct folio *folio,
>> -		enum node_stat_item item)
>> -{
>> -	__mod_node_page_state(folio_pgdat(folio), item, -folio_nr_pages(folio));
>> -}
>> -
>>  static inline void node_stat_mod_folio(struct folio *folio,
>>  		enum node_stat_item item, long nr)
>>  {
>> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
>> index 6f9b7b081ab7..ed3301753e89 100644
>> --- a/mm/page-writeback.c
>> +++ b/mm/page-writeback.c
>> @@ -2627,7 +2627,7 @@ static void folio_account_dirtied(struct folio *folio,
>>  
>>  		lruvec_stat_mod_folio(folio, NR_FILE_DIRTY, nr);
>>  		__zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, nr);
>> -		__node_stat_mod_folio(folio, NR_DIRTIED, nr);
>> +		node_stat_mod_folio(folio, NR_DIRTIED, nr);
> 
> Hi Ye, thank you for the patch,
> 
> In addition to what Matthew has pointed out, I also wanted to note that this
> substitution isn't trivial; there are differences between the __ prefixed
> version of node_stat_mod_folio and the one without. Even though the correctness
> of the two versions might be the same, I think that a change like this should
> be supplemented by a description of what side effects this change has
> (i.e. introducing additional overhead from the cmpxchg loop).
> 
> Thank you, I hope you have a great day!
> Joshua

Thank you for your review, Joshua. Regarding the difference between
__node_stat_mod_folio and node_stat_mod_folio: in the current implementation,
both functions ultimately use __mod_node_page_state, as mod_node_page_state
is defined as __mod_node_page_state. There is no functional difference
between them in terms of atomicity or overhead. The __ prefixed versions
were wrappers that are now unused, which is why we're removing them.

-- 
Thanks,
Ye Liu

