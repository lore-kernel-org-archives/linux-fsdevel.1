Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6250E3403E8;
	Wed,  5 Aug 2026 05:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785909491; cv=none; b=kx1CNYjaqFANVatDbUB1UAks0JjEIp3I/haqaIpT7A6WDIKjOvklIsEvYKftY0tNE1FD7f450O+54vZZS8Ti3IIwePBVl/V+PCghN1BGXVM71lWZ0wrwMkO350s2rK8nOR2kwgAdIWXf9nvIzyV2GI5xExJzh69ZgD2cqFE2X4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785909491; c=relaxed/simple;
	bh=05r7tS7FwUKD/e4NnomclcLpuPqMIKhQGaOK/mPLxWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yd2amsJXl1jCscPKOPBk8Cc6v7/BtZ6mz0fSfF+OpEeiU8tbHyziZYapnWK3B3DVJ2BEX09iDWKuQ9ShzobGcDll00VLeg+Hi2HVnnol4MV1wsL9JfnSgaP10bUH5OPfSQQ6P3aAo5tJ1MxMlab/Bgf1Yfr2fJJj3ReA/jkDQIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpTfVY+g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpTfVY+g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574631F000E9;
	Wed,  5 Aug 2026 05:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785909490;
	bh=v7zCWK++jNfxfhEt8Y8jIgML8WXQN15ZQy6uHyDnBnc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WpTfVY+gis0GaZ8Ilij2iuNXtip1yECYuuQNUlYVo6jVc87VSMT30kmNOwPl/ZTao
	 7oJbpElLKRYZM/H9E3uzPA0m2dDs7qxBrWfUSWeNQgVusyFJAB0zhgsb3CndB3eLBl
	 oVx+8kJVKo/dvCnEjFd77EC7hbxP5rQoI682riTb93MQ9TfiRSWCb3g5JOckn0oZli
	 58e+xTR7r2M3llPSRy5MrzI9rSBdgu2K2JYrZI3FiSOydblbfVLAtbSKgrhbcozdEM
	 SIQIBRN5owC9lJ1/5UdzSc5P9So3/Y8YL+DvqEaETnFE51wJndUFjamNuiFbFR2lzb
	 lLGJvpl87Db5A==
Message-ID: <595fe323-59d3-4f4a-92a3-ac5d67b7461b@kernel.org>
Date: Wed, 5 Aug 2026 07:58:02 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] mm: constify the pte_offset_map_ro_nolock() return
 value
To: Pedro Falcato <pfalcato@suse.de>, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kevin Brodsky <kevin.brodsky@arm.com>,
 Muhammad Usama Anjum <usama.anjum@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20260803164400.531199-1-pfalcato@suse.de>
 <20260803164400.531199-7-pfalcato@suse.de> <anHJ48Glq8EdHatd@lucifer>
 <anI6BEyTJFzQY-N9@pedro-suse.lan>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <anI6BEyTJFzQY-N9@pedro-suse.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 04/08/2026 à 21:22, Pedro Falcato a écrit :
> On Tue, Aug 04, 2026 at 12:22:19PM +0100, Lorenzo Stoakes (ARM) wrote:
> 
>>
>>>   			if (!pte) {
>>>   				mmap_read_unlock(mm);
>>>   				result = SCAN_NO_PTE_TABLE;
>>> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
>>> index b91b1a98029c..2cfc6e608ef4 100644
>>> --- a/mm/pgtable-generic.c
>>> +++ b/mm/pgtable-generic.c
>>> @@ -308,8 +308,8 @@ pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
>>>   	return NULL;
>>>   }
>>>
>>> -pte_t *pte_offset_map_ro_nolock(struct mm_struct *mm, pmd_t *pmd,
>>> -				unsigned long addr, spinlock_t **ptlp)
>>> +const pte_t *pte_offset_map_ro_nolock(struct mm_struct *mm, pmd_t *pmd,
>>
>> Can pmd be const too?
> 
> I was going to say "yes but then pmdp_get() also needs to be constfified" but
> actually no, it can't:
> 
> pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp) {
>          if (unlikely(pmd_bad(pmdval))) {
>                  pmd_clear_bad(pmd);
>                  goto nomap;
>          }
> }
> 
> so PTE mapping actually needs to write to the pmdp if the pmd looks bad.
> Tricky stuff :)

But if pmd is const, can it be bad at all ?

Christophe


