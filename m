Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795060566;
	b=3353wDCitRFppHnztZ85UBRNqPw6NwcU6sSYObGLjUEzoUCwVmBqGvHdry8yxeoV1aWw
	 5EVTCInC3kX106+m3pXLmCDwhX0QIIvBaPMBedsOvjTgeXXAlqaOtXyalYrkmht5uIaXk
	 fX1sXJof/EnxTEcJLO5QZIDpWGG6nMvFuZgsFsXGMxQXtcZ/7EkCXpqv5rUaL2+nFzOKR
	 Fl8+c12KxucE+Vle4iL6LecEfn5xduJc4EjTqGr+ewLITBvhkdGIyFuCHZB9XRaV8ct6Q
	 pghlZx+J5BL3XyubvS6I1qBvrI010FJVvTWGTktquVOLtg/CLzD6Gds7x+dFwyeZlJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795060566;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=BkbJSF4aY5DwwRvkf74HcCi1x+58qV+mJKy0JwfSO5s=;
	b=b8pBslTERAwGAS1wvsXwMpb58IdpPILl1th/J8CUu9OSUy9IwNA/2ZOiUszOETM05QxU
	 84bJK3TE2Xx1cOS0AA+WEaLmkX/xV3pBJdKSKgwx+UZf/ZWVbeoZ9LB7kOnZ513x+aqrX
	 3S7k/grCoiO2rKjtyNQaaVbINBxC7gHlqv2JM2Kt2Y++fozuVSO45cqnkVwWm8bSoXFRT
	 gKsHvmktq99msJUgsTFyyNwbYQt72NP8wPqQj8hSEBTWgYF8yeDuuP721jpq45pTSlN4w
	 gNvhvWqcoNmtC/ZKalaCsfEx3k2gz8A8TC/2Rmd/emdo32pxKc2Dnc0k7QronVe3LUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Lxmpmq12;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA33606A326;
	Thu, 19 Nov 2026 03:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CA33606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Lxmpmq12
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2515B1575;
	Wed, 18 Nov 2026 19:56:02 -0800 (PST)
Received: from [10.163.128.149] (unknown [10.163.128.149])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF1013F632;
	Wed, 18 Nov 2026 19:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795060565; bh=WWLj3TJuHvOcKDydq7vUx0XFf4zQYs67gD5nDNDmk5Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Lxmpmq120iVYYZpt/BMW/eZVPiMYER6b0FkFrrXxHMi1YgKpd1d1xf+vlY7aF+pR0
	 cKuB88IF/zv8zJtYN00aCQcv/3txCn5Wyj8Pwmml1dGuxUrDAT5nKyKDr5TuDudo/o
	 7nvwwmuEopoV0sXNOCuHnVRmjZkofU1kozzBSzSM=
Message-ID: <5aa0c814-b3fb-4588-bbf2-fa141235c8bb@arm.com>
Date: Thu, 19 Nov 2026 09:25:55 +0530
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
Subject: Re: [PATCH mm-new v2 0/5] mm: remove unused functions
To: "Garg, Shivank" <shivankg@amd.com>, "pfalcato@suse.de"
 <pfalcato@suse.de>, "nphamcs@gmail.com" <nphamcs@gmail.com>,
 "chrisl@kernel.org" <chrisl@kernel.org>,
 "shikemeng@huaweicloud.com" <shikemeng@huaweicloud.com>,
 "vbabka@kernel.org" <vbabka@kernel.org>,
 "willy@infradead.org" <willy@infradead.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "youngjun.park@lge.com" <youngjun.park@lge.com>, "jack@suse.cz"
 <jack@suse.cz>, "minchan@kernel.org" <minchan@kernel.org>,
 "liam@infradead.org" <liam@infradead.org>,
 "baohua@kernel.org" <baohua@kernel.org>,
 "kasong@tencent.com" <kasong@tencent.com>,
 "jannh@google.com" <jannh@google.com>, "ljs@kernel.org" <ljs@kernel.org>,
 "baoquan.he@linux.dev" <baoquan.he@linux.dev>,
 "senozhatsky@chromium.org" <senozhatsky@chromium.org>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20261117-unused-sym-mm-v2-0-2f845e94dd50@amd.com>
 <f3219880-c944-473e-82cc-bd6b4196badf@arm.com>
 <27ef4d8f-f4fa-49aa-b166-8335ca6f5898@arm.com>
 <c28c2ab82afa2cb3f331f1f3b3b20159bc7767b1.camel@amd.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <c28c2ab82afa2cb3f331f1f3b3b20159bc7767b1.camel@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 19/11/26 12:25 am, Garg, Shivank wrote:
> On Wed, 2026-11-18 at 22:44 +0530, Dev Jain wrote:
>>
>> On 18/11/26 10:35 pm, Dev Jain wrote:
>>>
>>>
>>> On 17/11/26 12:46 pm, Shivank Garg wrote:
>>>> This series removes five functions and one variable in mm that have no
>>>> users left anywhere in the tree. I found them with the kunused scripts
>>>> [1], which I wrote with LLM's help. The v1 cover letter [2] has more
>>>> details on the scripts and how LLM was used.
>>>>
>>>> Changes in v2:
>>>> - Split v1 [2] up by MM tree, as David suggested. These five patches
>>>>   are based on mm-new. 
>>>> - No changes to the patches themselves.
>>>>
>>>> [1] https://github.com/AMDESE/linux-mm/tree/shivank/kunused
>>>> [2] https://lore.kernel.org/r/20261026-unused-sym-v1-0-82ca2dceabe1@amd.com
>>>>
>>>> Signed-off-by: Shivank Garg <shivankg@amd.com>
>>>> ---
>>>
>>> Okay I just recalled that there have been numerous cases where people ran
>>> scripts / compiler with flags etc and sent patches to remove unused functions,
>>> but maintainers rejected them citing they are there for a future use. Here
>>> are some of those instances:
>>>
>>> https://lore.kernel.org/all/20240907021506.4018676-1-Liam.Howlett@oracle.com/
>>> https://lore.kernel.org/linux-mm/20100211052247.GA15392@localhost/
>>>
>>> So I think the commit messages need to do more, they need to prove that the
>>> unused function was a genuine oversight.
>>>
>>
>> One way to do that would be to mention the commit and its date, if its too old,
>> or, if it was part of a patch series but then the author changed their
>> strategy in the later patches making the function redundant, etc etc.
>>
>> In patch 1, you remove mapping_clear_release_always() but d73065e60dcc 's description
>> implies it is going to get used, which is confusing. Maybe we are missing
>> a genuine bug, or the author forgot to drop the stale description across
>> revisions.
>>
> 
> Hi Dev,
> 
> Thanks for the review. I agree that some unused symbols may be kept
> intentionally for a planned future user, which I checked for before
> sending.
> 
> For most patches I had included some history, like the commit that
> removed the last caller or the commit that added them without one. I
> missed that for mapping_clear_release_always() in this patch and for
> make_guard_swp_entry() in patch 2, so here is the history for both:
> 
> - mapping_clear_release_always() was added in b4fa966f03b7 ("mm, netfs,
>   fscache: stop read optimisation when folio removed from pagecache") and
>   never had a caller. Earlier version of had called it from ->evict_inode()
>   but V4 dropped those calls as unnecessary [1] leaving the helper.
> 
> - make_guard_swp_entry() was added in 7c53dfbdb024 ("mm: add PTE_MARKER_GUARD
>   PTE marker"), has never had a caller, and none has been posted in 2 years.
> 
> I left some symbols out because a posted series adds callers, for
> example folio_dup_file_rmap_pmd() and folio_is_pfmemalloc(), or because
> they are one half of a pair whose other half is still used, like
> kmsan_poison_memory().
> 
> [1] https://lore.kernel.org/all/166924370539.1772793.13730698360771821317.stgit@warthog.procyon.org.uk

Thanks! Sounds good, you can reply to the individual patches with the additions
so that akpm/David H. can fold that in.


> 
> Thanks,
> Shivank

