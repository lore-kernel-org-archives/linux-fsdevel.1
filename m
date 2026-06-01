Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56AD38F227;
	Mon,  1 Jun 2026 09:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780305279; cv=none; b=ZheWGMsFR94lt4OWFlv02QobHZyKBX+RqKi2DYxHcAO9Icv1oA6FuWtqXkL+GrNIatmvhz97cIfpflqv+TsJ09UHlM0GOwursDSAXDDCoffjc61admeiHWUfAyKuEzBtp+2uOIl96jY9yPkBMETLDnq69mTZdGALgpPr0Y4xJV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780305279; c=relaxed/simple;
	bh=h838crh2cFkXrbwjE1UKSICfRuEgy6SwChiZVz3UvrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N++bQiYiwoD/Db8UiQU2z8t7Ij3KmDlxY98X+nhapnGaWI7mXarpZfkAUJv7E5Gr6UCQ2Z1ocvaMjwPvnr3z2hm5oRD/1w+bnrGkUbktWMdN3MtR4PJoqzp9hxYiJg244VRAYI+NrsmjTjMrFsL+SIvMhiMShVwcpQsjWAMx0b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NJ8wPokP; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NJ8wPokP"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 469EA1FCD;
	Mon,  1 Jun 2026 02:14:32 -0700 (PDT)
Received: from [10.164.19.28] (unknown [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9CC13F905;
	Mon,  1 Jun 2026 02:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780305277; bh=h838crh2cFkXrbwjE1UKSICfRuEgy6SwChiZVz3UvrI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NJ8wPokPqFJEjcJHWuI8Z9iNFV6h7LrUyx5sTA83Y42dAgIBjNpOx+u3wuWvef+Go
	 u951O7Qq51z3n+IinzUAgyxUDkGVGxdfL8DQthXmjCFxcQMzkIrJlmMcouvOZto6Em
	 Btelm0kthvpRg58KLSUeGmJwfZeXZTOGf0Tg/TrM=
Message-ID: <9d861614-2c84-4390-a34f-af7bb42aad1b@arm.com>
Date: Mon, 1 Jun 2026 14:44:27 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] selftests/mm/hmm-tests: test pagemap reads of PMD
 device-private entries
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Balbir Singh <balbirs@nvidia.com>, akpm@linux-foundation.org,
 liam@infradead.org, jgg@ziepe.ca, leon@kernel.org, david@kernel.org,
 shuah@kernel.org, vbabka@kernel.org, jannh@google.com, pfalcato@suse.de,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, linux-kselftest@vger.kernel.org, usama.arif@linux.dev,
 ryan.roberts@arm.com, anshuman.khandual@arm.com
References: <20260530085413.1270139-1-dev.jain@arm.com>
 <20260530085413.1270139-3-dev.jain@arm.com>
 <9d8bffb5-bb07-4cde-8a20-8b9b9996f8cf@nvidia.com>
 <7750de96-44c6-47b0-b0a9-dd948fca2e90@arm.com> <ah1EI_JfZYop7VF8@lucifer>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <ah1EI_JfZYop7VF8@lucifer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 01/06/26 2:05 pm, Lorenzo Stoakes wrote:
> On Mon, Jun 01, 2026 at 10:40:48AM +0530, Dev Jain wrote:
>>
>>
>> On 01/06/26 5:39 am, Balbir Singh wrote:
>>> On 5/30/26 18:54, Dev Jain wrote:
>>>> To cover pagemap paths scanning PMD entries, add assertions to check
>>>> whether a device-private PMD entry has the correct pagemap information -
>>>> the PM_SWAP bit must be on in the pagemap entry. Before that, we must
>>>> assert through HMM_DMIRROR_SNAPSHOT snapshot that the leaf entry is
>>>> at PMD level and not PTE level.
>>>>
>>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>>> ---
>>>>  tools/testing/selftests/mm/hmm-tests.c | 29 ++++++++++++++++++++++++++
>>>>  1 file changed, 29 insertions(+)
>>>>
>>>> diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
>>>> index e1c8a679a4cf3..d09d4a9081de1 100644
>>>> --- a/tools/testing/selftests/mm/hmm-tests.c
>>>> +++ b/tools/testing/selftests/mm/hmm-tests.c
>>>> @@ -2276,8 +2276,11 @@ TEST_F(hmm, migrate_anon_huge_fault)
>>>>  	unsigned long npages;
>>>>  	unsigned long size;
>>>>  	unsigned long i;
>>>> +	unsigned char *m;
>>>> +	uint64_t entry;
>>>>  	void *old_ptr;
>>>>  	void *map;
>>>> +	int pagemap_fd;
>>>>  	int *ptr;
>>>>  	int ret;
>>>>
>>>> @@ -2318,6 +2321,32 @@ TEST_F(hmm, migrate_anon_huge_fault)
>>>>  	for (i = 0, ptr = buffer->mirror; i < size / sizeof(*ptr); ++i)
>>>>  		ASSERT_EQ(ptr[i], i);
>>>>
>>>> +	if (!hmm_is_coherent_type(variant->device_number)) {
>>>> +		ret = hmm_dmirror_cmd(self->fd, HMM_DMIRROR_SNAPSHOT,
>>>> +				      buffer, npages);
>>>> +		ASSERT_EQ(ret, 0);
>>>> +		ASSERT_EQ(buffer->cpages, npages);
>>>> +
>>>> +		m = buffer->mirror;
>>>> +		for (i = 0; i < npages; ++i)
>>>> +			ASSERT_EQ(m[i], HMM_DMIRROR_PROT_DEV_PRIVATE_LOCAL |
>>>> +					HMM_DMIRROR_PROT_WRITE |
>>>> +					HMM_DMIRROR_PROT_PMD);
>>>
>>> madvise(..., MADV_HUGEPAGE) is not sufficient to guarantee that the allocation
>>> was indeed converted to THP. Might be worth using the kpageflags interface (but that
>>> requires elevated privileges) and then KPF_THP? Otherwise the HMM_DMIRROR_PROT_PMD
>>> can be a miss from time to time. One other option is not to assert, but to check
>>> and inform?
>>
>> I'll then use the existing check_huge_anon() to assert that a PMD THP got allocated.
> 
> Would MADV_COLLAPSE work here?

So MADV_COLLAPSE requires at least one page to be faulted in (or precisely,
HPAGE_PMD_NR - khugepaged_max_ptes_none). So I rejected that, but now I
noticed that we are initializing the buffer first.

So yes I will use this, thanks.

> 
>>
>>>
>>>> +
>>>> +		pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
>>>> +		ASSERT_GE(pagemap_fd, 0);
>>>> +
>>>> +		for (i = 0; i < npages; ++i) {
>>>> +			entry = pagemap_get_entry(pagemap_fd,
>>>> +					(char *)buffer->ptr + i * self->page_size);
>>>> +
>>>
>>> If this is a THP entry, do we have valid pagemap entries for offset of i * page_size?
>>
>> Yep we do, see the populate_pagemap label in pagemap_pmd_range_thp.
>>
>>>
>>>> +			ASSERT_NE(entry & PM_SWAP, 0);
>>>> +			ASSERT_EQ(entry & PM_PRESENT, 0);
>>>
>>> Nit: You can use PAGEMAP_PRESENT()
>>
>> Okay.
>>
>>>
>>>> +		}
>>>> +
>>>> +		close(pagemap_fd);
>>>> +	}
>>>> +
>>>>  	/* Fault pages back to system memory and check them. */
>>>>  	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
>>>>  		ASSERT_EQ(ptr[i], i);
>>>
>>> Balbir Singh
>>
> 
> Cheers, Lorenzo

