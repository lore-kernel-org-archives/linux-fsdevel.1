Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598BC23ABBE
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 02:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784515002; cv=none; b=cC52hAE5mLcx/PPrsBjW/16oi3jcLAT31Dj/B5Iyh+FOeCS2COn5ixYnyuMARgbw5SJpb0a0KN3Mhgmwdi/owF4yj+qAKN+dUzzY5OI5Tl/ylcu3z5iwlBTgs5KoSgGR6SgL2Nbt9kjEgYvhakluqUINsiJrl7YcdO81y35Bpck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784515002; c=relaxed/simple;
	bh=BnY1OUJgMV/YL/WyEIzD4Ylveq2RJTx0N1HyfQAyw1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wis93neLWpHWQPhH1vE0B3CuWp9Ffkv/XeN7hMUQjx/wq1UgHIJbAdmk6WNqibw7491FGV/08fvH3PGb5BzXT+xM/f5mcx7qaLEYwxolj+MCqLGkP0BzchKUcLbIQHHMG4gQubm/2dQFH6kCrJydd0kD+2/moqQof7n440a0xg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eOkJFHgM; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eOkJFHgM"
Message-ID: <c0265ec9-e983-4547-a166-7c1d30237b73@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784514998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KusPc2Cpip6sPBv9PieUVxeP0LYiRvmdBMosAeD5k90=;
	b=eOkJFHgM6kcMlXyh79+foKL5z5ba2DkfV7iAXPTnhaKpSyAfu+A4jkqQyailvUNMc/6G4M
	zWGbF8zey1Q6P6wxgRW81ZPZq542iHED+d3N/jM8OdRtPmCigRL/bxu5+GnNbEoTTCgObo
	hFa9uZ3fDfD2zOrYYfaVO6DiCuPlLV4=
Date: Mon, 20 Jul 2026 10:36:14 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/thp: expose deferred split folio memory usage in
 meminfo
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Ye Liu <liuye@kylinos.cn>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Kairui Song <kasong@tencent.com>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
References: <20260717063025.168436-1-ye.liu@linux.dev>
 <46017e29-48a3-4a74-8c5a-0be9d912deaa@kernel.org>
 <dd037379-cf59-468e-8b42-51546bf2e28c@linux.dev>
 <f041f1e0-8ec4-48d4-8656-a6789c8ad379@kernel.org> <aln6SBHcxBY-9Vfl@lucifer>
 <41bc5ca5-08ed-4aba-86a3-d7f44b16e6f5@linux.dev>
 <b6b04cf2-30d0-4511-9bd4-042b176c1b31@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <b6b04cf2-30d0-4511-9bd4-042b176c1b31@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2026/7/17 18:29, David Hildenbrand (Arm) 写道:
> On 7/17/26 11:54, Ye Liu wrote:
>>
>>
>> 在 2026/7/17 17:48, Lorenzo Stoakes (ARM) 写道:
>>> On Fri, Jul 17, 2026 at 11:33:05AM +0200, David Hildenbrand (Arm) wrote:
>>>>
>>>> Don't expose it to user space.
>>>
>>> Yeah please stop.
>>>
>>> We don't want this change, it exposes internal implementation details. It's a
>>> no.
>>>
>>> Next time send an RFC or a discussion thread.
>>>
>> Yes, sending an RFC would be more appropriate.                                                  
>>                                                                                                 
>> I'd also like to ask if it's possible to implement this in                                      
>> `/sys/kernel/debug/deferred_split_pages`, or are you completely against querying this statistic?
> 
> It's not pages. It's folios.
> 
> You don't know how much memory is there to reclaim. You don't know if it can
> even be reclaimed.
> 
> You don't even know if there can be any memory reclaimed *at all*, because there
> are scenarios where we add folios that are actually *not* partially mapped today.
> 
> You don't even know the relationship to memcgs.
> 
>>                                                                                                 
>> How can we quickly identify this situation?                                                     
>> I believe some people will still be confused: where did the memory go?                          
> 
> Just like other caches that are shrunk on memory pressure.
> 
> We do have a "split_deferred" and a "nr_anon_partially_mapped" counter in
> "/sys/kernel/mm/transparent_hugepage/hugepages-2048kB/", maybe that helps.
> 
Thank you, it really helped.

-- 
Thanks,
Ye Liu

