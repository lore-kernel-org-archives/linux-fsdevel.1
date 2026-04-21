Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77F03A4523
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 09:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776762171; cv=none; b=uuf2fYEnyaVB6LwVZC9T1yn05l6fE8txtk++Q8bovEv2Ymx3x31n+Nric+PvNqLsaQMwXXs48P/XIzhIY8G/RHCwF9LtQewWCy8u5CpYvP/1CzWZRD6BrfOLSW3P7ZAEyBr1ySemnNNexni7prjOsJyGaKgjYzJPxXRLc+Lr7mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776762171; c=relaxed/simple;
	bh=PtUQkhF8ODo+uUc8J4/pGSkHu0QMqX1x2kVB2oV6dAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tRDPJgU709SoP3CiXfJNIMldha6mi4JCf287KvWves/40xp7sNC5uT9D3EZVZbG2WPYne6Cak0au52KS2BqQwagYB5Lo5357ueuxu7oXWx4wuEtBbnrxxRlvKgQCpGnvT7xFY6kmj1HVVYKAiPtId7x8rVkOzfFhgHx+1IiEi1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YxtO80Py; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YxtO80Py"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d7dab87e1so318672f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 02:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776762168; x=1777366968; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D1tUMNKsUka20XG67YhLFUj+hBxuaCOCgy+TNZlHY/s=;
        b=YxtO80Py/n3gxmHgHjs6Eh2Bk/cI921/+YOfcAx40aw+LmhohQLDFN1GIT4Wp077ua
         Y4jmQInmJHK8GCoDFgXDFcH+vwSsEUjI5gHcJU0ZgC2MfQSZkQGp1rWISfvGxl7W3yny
         fVXbiZNfhKawTeLkjmeRLfPw5dOJ2lmBbtU4hPu8MtuY984kNYJBjzvHXOK5mFej75ue
         w1lnfg0a+JuRFDsl/Vo3f5dJcvMOc4S9hTN+B1+ODqq4paqSR39Q9BNAYnvXuWxE3blK
         0kGKgYXhct+6Td08nRtNpfWJ8E0Tdu8IV2PPtP+hqfaComPktR3Qfw008gI8uOJWS8kq
         PUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776762168; x=1777366968;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D1tUMNKsUka20XG67YhLFUj+hBxuaCOCgy+TNZlHY/s=;
        b=qWzPxfU3/mqL/DSl9owbTSY3nYPLq3DHvnMQ9EGixuRV/fFVnfL1bYLBDdrlqbuXcw
         c6Kz49G6y2XkMEauSPkBPUxrQ0JVtIq1dOZ+5rfAJ5Vr+f1tHtKtkPZXKhJm+kRKxkiI
         N/tPyW8NGF957EUx4wBfI8cTXhrYGJyY5B/fSmNc9ldq5U0oKw1hARifjwE/DTDy5cLx
         wapT0pUcFy25iJ+vjQTItRZOWCm7A50d4lEY70dTUKZh+Vx/R15Ar9deW4c62pguJ/Dz
         MrBma7XzSgXjU5ZyrqK8baR1OZnNCWrvQuhRi3dxoiC7QCRntqDoRCbvpd/Ag7R8ysaJ
         Lj4w==
X-Forwarded-Encrypted: i=1; AFNElJ9gt9D9rg3Wv2yXkt6N0uV+m1bINo36tfqb18kQesTXSJCbzTP0OX59QSoJLZ07G1Etu5ZX+VOnl0jml5Ej@vger.kernel.org
X-Gm-Message-State: AOJu0YyKt/DKyh1wUBYFrikznmV+qJfNkXXhbZ71zs7+QstUCd5NcgHm
	k9xP1TG988zQoZJdx1Zh3yKK2mut2ZNVmk+bSubG+KwWvU43rjf2WbkZxFbvTugqkLM=
X-Gm-Gg: AeBDieshLi7X3TObuEGzSdb0sj+2tV9Qf8+KqQ9cX5kCvlXi2SjxTflFSOAgLsr1a/q
	NOKRbMPD8RPUKllLTsDcsHrcpW06CBduU7SuWBVMCi0FeKfy8KWR2kGnY0LQAA1UeObcblrZinf
	59YQRGWeVdiwdoR7IKptshXurnbvye7TUKXCfB3owMQt5LGRwuEkqCR+p9j8u5RmAv8YVAwKQ6Q
	yelgnnT6ave2/sd7AxSNLzvbBavzjDkJNUYM9/JY6XI4PWydHNuVTTUdjNJsujOvP4NP1Tgbrg1
	qka7CAOuTOJRcb63NQxMLqVm0qQLhIW2zXZ31v/3q2A2gn2ojSgkzJpnRpEzT7t8hxf/uslACVa
	OGS6WP1/KGDBz+hj+VuMMIyVcl9cbQdLLEUoNWsaLSpNW7Za2VAGd4qVUL5k7kW8Hatp4FcxJib
	hbBY+L1LA54twrBObR7U6/m3E2HtCDqnA3K69xM4uSf1CeUkVRfl63+zlkH4oXUiYyKuGX
X-Received: by 2002:a05:600c:4746:b0:488:ac4b:59d1 with SMTP id 5b1f17b1804b1-488fb7ab49cmr115940905e9.8.1776762168051;
        Tue, 21 Apr 2026 02:02:48 -0700 (PDT)
Received: from ?IPV6:2001:1a48:8:903:1ed6:4f73:ce38:f9d4? ([2001:1a48:8:903:1ed6:4f73:ce38:f9d4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891c08faffsm269654935e9.1.2026.04.21.02.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 02:02:47 -0700 (PDT)
Message-ID: <1f50ce04-20e6-46a0-9d8a-00a5f7a74967@suse.com>
Date: Tue, 21 Apr 2026 11:02:45 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iomap: avoid compaction for costly folio order
 allocation
Content-Language: en-US
To: Dave Chinner <dgc@kernel.org>, Salvatore Dipietro <dipiets@amazon.it>
Cc: linux-kernel@vger.kernel.org, alisaidi@amazon.com, blakgeof@amazon.com,
 abuehaze@amazon.de, dipietro.salvatore@gmail.com, willy@infradead.org,
 stable@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, "Ritesh Harjani (IBM)"
 <ritesh.list@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
 "David Hildenbrand (Red Hat)" <david@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>
References: <20260403193535.9970-1-dipiets@amazon.it>
 <20260403193535.9970-2-dipiets@amazon.it> <adLlrSZ5oRAa_Hfd@dread>
From: Vlastimil Babka <vbabka@suse.com>
In-Reply-To: <adLlrSZ5oRAa_Hfd@dread>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/6/26 00:43, Dave Chinner wrote:
> On Fri, Apr 03, 2026 at 07:35:34PM +0000, Salvatore Dipietro wrote:
>> Commit 5d8edfb900d5 ("iomap: Copy larger chunks from userspace")
>> introduced high-order folio allocations in the buffered write
>> path. When memory is fragmented, each failed allocation triggers
>> compaction and drain_all_pages() via __alloc_pages_slowpath(),
>> causing a 0.75x throughput drop on pgbench (simple-update) with 
>> 1024 clients on a 96-vCPU arm64 system.
>> 
>> Strip __GFP_DIRECT_RECLAIM from folio allocations in
>> iomap_get_folio() when the order exceeds PAGE_ALLOC_COSTLY_ORDER,
>> making them purely opportunistic.
>> 
>> Fixes: 5d8edfb900d5 ("iomap: Copy larger chunks from userspace")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Salvatore Dipietro <dipiets@amazon.it>

BTW, backporting perf regressions fixes to 6.6, when they are only reported
at the time 7.0 is released, might be too risky. There will likely be a
different workload that will regress as a result, no matter what we do.

>> ---
>>  fs/iomap/buffered-io.c | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>> 
>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>> index 92a831cf4bf1..cb843d54b4d9 100644
>> --- a/fs/iomap/buffered-io.c
>> +++ b/fs/iomap/buffered-io.c
>> @@ -715,6 +715,7 @@ EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
>>  struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len)
>>  {
>>  	fgf_t fgp = FGP_WRITEBEGIN | FGP_NOFS;
>> +	gfp_t gfp;
>>  
>>  	if (iter->flags & IOMAP_NOWAIT)
>>  		fgp |= FGP_NOWAIT;
>> @@ -722,8 +723,20 @@ struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len)
>>  		fgp |= FGP_DONTCACHE;
>>  	fgp |= fgf_set_order(len);
>>  
>> +	gfp = mapping_gfp_mask(iter->inode->i_mapping);
>> +
>> +	/*
>> +	 * If the folio order hint exceeds PAGE_ALLOC_COSTLY_ORDER,
>> +	 * strip __GFP_DIRECT_RECLAIM to make the allocation purely
>> +	 * opportunistic.  This avoids compaction + drain_all_pages()
>> +	 * in __alloc_pages_slowpath() that devastate throughput
>> +	 * on large systems during buffered writes.
>> +	 */
>> +	if (FGF_GET_ORDER(fgp) > PAGE_ALLOC_COSTLY_ORDER)
>> +		gfp &= ~__GFP_DIRECT_RECLAIM;
> 
> Adding these "gfp &= ~__GFP_DIRECT_RECLAIM" hacks everywhere
> we need to do high order folio allocation is getting out of hand.
> 
> Compaction improves long term system performance, so we don't really
> just want to turn it off whenever we have demand for high order
> folios.
> 
> We should be doing is getting rid of compaction out of the direct
> reclaim path - it is -clearly- way too costly for hot paths that use
> large allocations, especially those with fallbacks to smaller
> allocations or vmalloc.
> 
> Instead, memory reclaim should kick background compaction and let it
> do the work. If the allocation path really, really needs high order
> allocation to succeed, then it can direct the allocation to retry
> until it succeeds and the allocator itself can wait for background
> compaction to make progress.
> 
> For code that has fallbacks to smaller allocations, then there is no
> need to wait for compaction - we can attempt fast smaller allocations
> and continue that way until an allocation succeeds....

So, should we do a LSF/MM session?

But I think in any case, the page allocator needs to know which allocations
do have the fallback. __GFP_NORETRY exists for this. Here it wasn't tried at
all, in v2 [1] it was, but not alone. I'd start from __GFP_NORETRY alone,
and then we can look at tweaking what it does if it's currently insufficient.

We could have a helper to encapsulate this "turn this allocation to a
lightweight fallbackable one", which would add __GFP_NORETRY. It probably
already exists somewhere but not gfp.h. But I'm not sure we can simply
change GFP_KERNEL to start failing more for non-costly orders. We've
discussed that a lot in the past :)

[1] https://lore.kernel.org/all/20260420161404.642-1-dipiets@amazon.it/

> -Dave.

