Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC15E44C66B;
	Wed, 23 Sep 2026 09:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790156827; cv=none; b=u7cWZQVG5XNg5x7pYMEsoYAS8O2sl0hRzt6xvymdEFCUkoOrxOvLycxZVWo93pz0qLITkF6shcTjrz17onBXCuY7rDqAr0/hAADPYMnwXWVXZmxX81yHTaeYyYllQlqVOmunqyUWT5xDxVvGqFsmpzw9kylNjKoA70opwWA3JLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790156827; c=relaxed/simple;
	bh=up/guhLojFLGtZrGIWqwUTqQsLkp6ijLf/QNYb56n3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=on6kVsKigr8RqVDpUX/KY+wFwdOCVsWLHxtCS3Vf6RnTguQ2iOpJG4MQwPao4ATYEz56cWA+EFryunsS7yKmBqpD0BPPIJz00/H2H1oLKOvJZD/EYxokgZS8PHEWyHDkUiqhZCDdIS8S072Fj7M0B6kKLKX/eO8aSJaKV/rUJak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmNaAty0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmNaAty0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0908E1F000FF;
	Wed, 23 Sep 2026 09:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790156825;
	bh=q9lu7/Lfykw5rD9RIMqHSiEol63xjIdEyxl0Gcv3hpo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WmNaAty0/yAlFHU43CCV2MnKPupK91y4CnUMGEPeh8kUxiMJUVFllGCnEn+XOmwGQ
	 jtlvJlSlTo3pXUrwqWFokdpYCApi0lr1RmxxvWBXUTbVZf1W3uMFwAY1NHYkIBYb7h
	 nuRxiRXpupiJkqa41j5HZAfQSgHa4I1bvNweGE1VLB12K3Xb9yp8565qAjjqByqEdr
	 YErL9gNtCzYJriHq48dJYL0TnKGxgmyjrXSWvOdY9cZzlMTcKiLi3OUVthdWHc684f
	 5zQqvMwgkRmNx6lztZ2a4kpyFR8UaBglnNyLfEZInlMVmnff0Vwz5sDSgVeUEwYY8H
	 qm1dmQ8eGJU6Q==
Message-ID: <d9a77381-cf88-4726-9223-c16a5c6608c2@kernel.org>
Date: Wed, 23 Sep 2026 11:46:55 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: madvise: drop MADV_PAGEOUT folios at swap writeback
 completion
To: Kairui Song <ryncsn@gmail.com>
Cc: Barry Song <baohua@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>,
 akpm@linux-foundation.org, willy@infradead.org, jack@suse.cz,
 liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, jannh@google.com,
 chrisl@kernel.org, shikemeng@huaweicloud.com, nphamcs@gmail.com,
 baoquan.he@linux.dev, youngjun.park@lge.com, qi.zheng@linux.dev,
 shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, hannes@cmpxchg.org, mhocko@kernel.org, yosry@kernel.org,
 chengming.zhou@linux.dev, kunwu.chan@gmail.com, tz2294@columbia.edu,
 hch@lst.de, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260921152449.629486-1-alex@ghiti.fr>
 <70cae945-3a4a-40db-96ac-5ce66a3fa186@kernel.org>
 <CAGsJ_4y8-wD0yMV8GCtCz5MfNrOKqUaTd+UgH=8MoP_nuvPnGg@mail.gmail.com>
 <108487b7-0529-4282-b5f4-355804b4c0cf@kernel.org>
 <CAGsJ_4zGmGh70QtRBpnhueev3qt_bgB4ZiE9fkW-hgNjAVhv+w@mail.gmail.com>
 <2e695c8a-4212-42b5-bb51-fbe1aa162e1d@kernel.org>
 <CAGsJ_4z2nakqBCKd_uAn4bfub99r3NJt2spOUx-K0M7bHW3_-w@mail.gmail.com>
 <4c7c6ea0-84a7-45f6-989c-d1502b90694c@kernel.org>
 <CAMgjq7DeYsJxG_VCf2KnViV5nd10m-PPYzXRD1fi8QcGWwD0qw@mail.gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <CAMgjq7DeYsJxG_VCf2KnViV5nd10m-PPYzXRD1fi8QcGWwD0qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/23/26 11:35, Kairui Song wrote:
> On Wed, Sep 23, 2026 at 10:46 AM David Hildenbrand (Arm)
> <david@kernel.org> wrote:
>>
>> On 9/22/26 22:55, Barry Song wrote:
>>> On Tue, Sep 22, 2026 at 7:26 PM David Hildenbrand (Arm)
>>> <david@kernel.org> wrote:
>>>
>>> I guess that's because the LRU is not always accurate. There are cases
>>> where our prediction of future access patterns may be wrong, resulting
>>> in refaults?
> 
> Hi All,
> 
>>
>> Right. But these would happen in both the SYNC and the ASYNC case. Which seems
>> to indicate that making the SYNC case behave like the ASYNC case (keep in
>> swapcache before evicting) could actually improve performance?
>>
>> Or is the SYNC case in general so fast that it is not a problem and the
>> swapcache is just not a good use?
> 
> I think the problem is not LRU being inaccurate, but ASYNC case could
> overshoot the anon reclaim very easily. File folios can be simply
> dropped, and increase nr_reclaimed, but anon writeback (swap) can't be
> done durig the reclaim iteration so nr_reclaimed never increase during
> the scan iteration. So the scan tries hard to scan and reclaim more
> anon folios, more than it really needed.
> 
> I think the real fix is some kind of different watermark, throttling,
> or a different counter to limit the scan of async swap. I mentioned
> this at LSFMM this year but I guess I presented too much at the same
> time so few people remembered it :D.

:D

> 
>>
>>>
>>> Even on Android, which uses zram with very fast synchronous swap-out,
>>> I can still hit the swapcache from time to time. So perhaps with a
>>> slower device, such as an HDD, keeping the swapcache around for longer
>>> could allow applications to hit it more often?
>>
>> Why is that specific for HDD? It's the exact same app behavior independent of
>> the underlying swap technology.
> 
> If you have a shared folio, you must use swap cache, and even for
> single used folios swap cache is the way to do synchronization,
> regardless of the device.
> 
>>>
>>> I don't know. Maybe Alexandre can share more details about this
>>> benchmark. I'm also a little surprised by the 15% regression in
>>> Sysbench OLTP. My initial feeling was the same as yours: we should
>>> release the memory immediately after writeback completes, for both
>>> synchronous and asynchronous I/O.
>>
>> Right. And see if we can identify why we are swapping out the wrong things :)
> 
> I think we are not? It's about over-reclaim. In the worst case we
> might put every anon folio under writeback, while no folio is
> reclaimed, if the device is super slow.
Ah, that hints at the real problem then? How confident are we that that's what's
happening?

-- 
Cheers,

David
