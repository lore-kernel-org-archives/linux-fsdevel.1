Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795456523;
	b=bpla6G8S1Zy/6Z3WxaK2XOr8Q+ZvmuXkZ9NUI88rEpPjRifkSnbaCGc5f+gr2gWdOnLM
	 s21pwZ2LNNEyax8/AAM7xhdUET6fW3SCj2/QOViAOEfJWQnz5oN2/CYeuqMn1jga0jIgZ
	 NbXqVYtzzN5xnDoXPyaV/+05dsJE6eKEBQQtg2+ag/lJ4sIIeNUBH5c19FsNSj7Y8zcGD
	 AlSsWPQ0C+wjY73m9z6pfBqKUAHWZCpOminPKC5VA15Zk7MNtJPwiy427oTlu/bo1txrA
	 Dg7wb0KnwAlAzS810p/MU3tGQg+KXlFT4691KT1jnO8S3zba2+E66dTIvAetKqF3UjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456523;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=xMHaM0uSgX3eSpN4mZEmyB3Lyh48q6GW6tOkCnfZECI=;
	b=tTRshY+m+RbWO8b4RC2NTn5o5poGyynDF3wN4TqE7aLrTf8GgO9L1idUZJyDHe8PmpW1
	 K/okCue8NAj8vc2nxH4b9Z06Xdx9B5Qdb1KLyodaQsAbyurAiD0CfmYESa6UrhTf7UweV
	 dzlks6C7MiBO7tCF7mWQUWma4xDcGWMx4Ck48Y18gPWf8EW5Y4fXZWvCuo5vHeheVjLlq
	 YlXosyeFO6wm2y5FNycFQSEts21S9i6FtyU41xSreVNs1EXj0JFs4m1s+qW8A+wL6DGGp
	 fwLU0YSkoSCXetRNlepmfs/muqXCbsxZJEgHJjk225zTuhJnn6oUNv7ttYPcv8udrcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nAPVMx2m;
	arc=none smtp.remote-ip=95.215.58.78
Received: from mta1.migadu.com (out-78.mta1.migadu.com [95.215.58.78])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5464D606A332
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 17:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5464D606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nAPVMx2m
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/8a5s3NnlmOS+o3OmDGmvQNljvm+stDs8p/PoHCQulk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795456520; v=1; x=1796061320;
 b=nAPVMx2mzQQTQbJbg0Z4a11SsMepXBqjha69zs3FDfbtuGRPkWP1ni8+Rrj820a196YSt3Tl
 sV1fP26pVukADIcJguZEuVdEWZNamVKifmfXXaa70LE/TjQBU7FEt7+mqC9hDqhrks7KckKI0pC
 2KBTh+s3+ooN7vphvD7KPThA=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9cef6277f6cdfc24;
	Mon, 23 Nov 2026 17:55:19 +0000
X-Mizu-Trace-ID: 9cef6277f6cdfc24
X-Migadu-Flow: FLOW_OUT
Message-ID: <94a074f1-753c-4ed1-99e8-59d227f70ea3@linux.dev>
Date: Mon, 23 Nov 2026 17:55:17 +0000
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
Subject: Re: [PATCH v3 3/5] fs/proc/task_mmu: read the PMD once in
 smaps_pmd_entry()
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, apopple@nvidia.com,
 byungchul@sk.com, david@kernel.org, gourry@gourry.net, jannh@google.com,
 joshua.hahnjy@gmail.com, liam@infradead.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, matthew.brost@intel.com,
 mhocko@suse.com, pfalcato@suse.de, rppt@kernel.org, surenb@google.com,
 vbabka@kernel.org, ying.huang@linux.alibaba.com, ziy@nvidia.com,
 kas@kernel.org, hannes@cmpxchg.org, riel@surriel.com,
 shakeel.butt@linux.dev, kernel-team@meta.com, baolin.wang@linux.alibaba.com,
 Nico Pache <nico.pache@linux.dev>, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, lance.yang@linux.dev
References: <20261123163301.1568240-1-usama.arif@linux.dev>
 <20261123163301.1568240-4-usama.arif@linux.dev> <awR2bZl4CvSuInmk@gremlin>
Content-Language: en-US
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <awR2bZl4CvSuInmk@gremlin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23/11/2026 09:24, Lorenzo Stoakes (ARM) wrote:
> On Mon, Nov 23, 2026 at 08:32:09AM -0800, Usama Arif wrote:
>> smaps_pmd_entry() dereferences the pmd pointer six times. Read it once
>> into a local with pmdp_get(), the way smaps_pte_entry() already does
>> with ptep_get(), so that every test sees the same value.
>>
>> No functional change intended.
>>
>> Suggested-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> 
> LGTM so:
> 
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>


Thanks for the reviews!!

> 
>> ---
>>  fs/proc/task_mmu.c | 11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index 540c936aad4714..105c4998eef48f 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -1022,14 +1022,15 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
>>  	struct page *page = NULL;
>>  	bool present = false;
>>  	struct folio *folio;
>> +	pmd_t pmdval = pmdp_get(pmd);
> 
> NIT: Can this be const or are the helpers not safe for it?

Ah yes, good point. Its good to have const here.

I think the rest of the series is good to merge. Should I wait
a few days and send a new revision with the const change here?

> 
>>
>> -	if (pmd_none(*pmd))
>> +	if (pmd_none(pmdval))
>>  		return;
>> -	if (pmd_present(*pmd)) {
>> -		page = vm_normal_page_pmd(vma, addr, *pmd);
>> +	if (pmd_present(pmdval)) {
>> +		page = vm_normal_page_pmd(vma, addr, pmdval);
>>  		present = true;
>>  	} else if (unlikely(thp_migration_supported())) {
>> -		const softleaf_t entry = softleaf_from_pmd(*pmd);
>> +		const softleaf_t entry = softleaf_from_pmd(pmdval);
>>
>>  		if (softleaf_has_pfn(entry))
>>  			page = softleaf_to_page(entry);
>> @@ -1046,7 +1047,7 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
>>  	else
>>  		mss->file_thp += HPAGE_PMD_SIZE;
>>
>> -	smaps_account(mss, page, true, pmd_young(*pmd), pmd_dirty(*pmd),
>> +	smaps_account(mss, page, true, pmd_young(pmdval), pmd_dirty(pmdval),
>>  		      locked, present);
>>  }
>>  #else
>> --
>> 2.53.1-Meta
>>
> 
> --
> Cheers, Lorenzo

