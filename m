Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795508726;
	b=I4EQEkDtCgoY/V5Eoe03fKYNaB8sdV7vR7SNu7cuu/H2iSQ2QhhZGJb5so11p7HzqYLz
	 DQQuStC6rwi9dZ2WRBGr5VxIcVVOs3n6DusE8yAApd9TjnMDPV5r7qNnjTTnLgCs1qRBh
	 eyuMkPzth8RLJEO8vp34zPSGARXzddqW2KSA7zCTj0CyWfNVlIcIU7OftCLGmWwmcibgj
	 WwV/YiyjRydLDgKJSCag+lhQrwJ0OKLA1yEB/NOqyDZWbIKe4PnpJBk5NOFTBil94hfAm
	 sTZuwVGXfxBMykA+Zm5sfuKe2U7gAYnsfaS60Qwg2pKtmXfKZjMtlx4i2rm+rmtM3uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795508726;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=/YC56fOuK2lKYPOoLLh5K2Mmq0DOi0LfSniRN6pltyg=;
	b=DdhLjplt9DJR2k9zg7s7F6iA4n+r+zB7gvONxXk9m2laxiaEMykTVaay/sJCpiJnmplD
	 HnFfd5taenDrMdbW84IxsFyqOBgwMHQgaSytnpnDsZPeNWuAWL3QD2UWwKPahjJ8zTBpo
	 6K4ez/NpPt5VWo/tQnCJ0GUY3R7C/mo6PFQ/+ErQrtWJnK+kRe74GHSV+tgq3SK5A6Wh0
	 kwjpmi0smKXBHqWShJA/AmG4XaSS62KRGvt7+OzCohJa9OYdX/Ak+JRl5UyPij9EhpQ+m
	 F03VO3A9ltNSoX9ULqGIhBldY3geAmjHCVsaijzEkvmfjcEFOdBm9II5cbYSO6kIazg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nPExmO/r";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7DF606A31E;
	Tue, 24 Nov 2026 08:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nPExmO/r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA771F000C0;
	Tue, 24 Nov 2026 08:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795508725;
	bh=/YC56fOuK2lKYPOoLLh5K2Mmq0DOi0LfSniRN6pltyg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nPExmO/r+i9gdd3EAohwkDsXt1p80upAUPOUyQn3Mn4iaQdFqzONg1Wt/cOivBttv
	 Gj2OjcQZYdN+pgo5w9hAJGg3IjqV8oj1iGqW1sdhfwxD4re/RyKU+a6+QYDJPHJ2mh
	 s1mfqA2Tsd5m0ut+b2Jds2M7oxMaVhlpOYwr99NkEuNSzWVRqCn6/sIZgZmBj5zD/R
	 gN71INdtQaLPHuvU+nhN2UGRjl6Lnf8xvKUJlfoitHnSNatzS+c8uICRrOT9ECewju
	 4iuv3BiGNHtUR5JoCN6zu+nOS5tcE6q8jLX8Swsax1c+4PHgkPP5aogewdTTVXImlB
	 aNgBaPLjwaEJA==
Message-ID: <031b595a-376f-4848-bfd1-ea85d273db13@kernel.org>
Date: Tue, 24 Nov 2026 09:25:14 +0100
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
To: Usama Arif <usama.arif@linux.dev>, "Lorenzo Stoakes (ARM)"
 <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, apopple@nvidia.com,
 byungchul@sk.com, gourry@gourry.net, jannh@google.com,
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
 <94a074f1-753c-4ed1-99e8-59d227f70ea3@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <94a074f1-753c-4ed1-99e8-59d227f70ea3@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/23/26 18:55, Usama Arif wrote:
> 
> 
> On 23/11/2026 09:24, Lorenzo Stoakes (ARM) wrote:
>> On Mon, Nov 23, 2026 at 08:32:09AM -0800, Usama Arif wrote:
>>> smaps_pmd_entry() dereferences the pmd pointer six times. Read it once
>>> into a local with pmdp_get(), the way smaps_pte_entry() already does
>>> with ptep_get(), so that every test sees the same value.
>>>
>>> No functional change intended.
>>>
>>> Suggested-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>>> Signed-off-by: Usama Arif <usama.arif@linux.dev>
>>
>> LGTM so:
>>
>> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> 
> 
> Thanks for the reviews!!
> 
>>
>>> ---
>>>  fs/proc/task_mmu.c | 11 ++++++-----
>>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>>> index 540c936aad4714..105c4998eef48f 100644
>>> --- a/fs/proc/task_mmu.c
>>> +++ b/fs/proc/task_mmu.c
>>> @@ -1022,14 +1022,15 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
>>>  	struct page *page = NULL;
>>>  	bool present = false;
>>>  	struct folio *folio;
>>> +	pmd_t pmdval = pmdp_get(pmd);
>>
>> NIT: Can this be const or are the helpers not safe for it?
> 
> Ah yes, good point. Its good to have const here.
> 
> I think the rest of the series is good to merge. Should I wait
> a few days and send a new revision with the const change here?

I'd pick the fist two directly. Can you resend the other 3 such that Andrew can
pick them?

-- 
Cheers,

David
