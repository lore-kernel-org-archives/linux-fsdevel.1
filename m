Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEF5352031;
	Tue,  4 Aug 2026 13:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785848966; cv=none; b=SwYVTMaUx1H3Pw+sKdgO91gydJYSAjwzNeoiD8Mtb+gouqUHa3R4XyQDAWDC3dVplZIQRDjSIewWVAz0tZ2JReN0zRZ3kbNWjoOi1jL+s8LeESHDOPja954tfqw8Q2NcvXFAKGE2RvuT94xi25mDDMLHOJj1q4QEudAxl2UlkW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785848966; c=relaxed/simple;
	bh=bImrk0GogDNKfUCv7zQeMqs/sv6XiPq+SX4g2NWvkDc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DwdpWsna1gv8lxe7SsQ47n7YWHIcKxF5kUWIAm/6wopT8oiJ1YLxgSwKeDovTAFWrv1RSPNbGtqKA52Ei28G1PKA6y/eCqnUYAtvv76j2OAaETDAijl7rfeeTmN3ZjMpM5fyTQ+EY7Xw3wl+OwbC3WYzRMHH3tEOrHIbfBTR0Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ui7t6UYn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ui7t6UYn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61BCF1F000E9;
	Tue,  4 Aug 2026 13:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785848964;
	bh=4f7ucuIUW8vF4hICwF+LuP1Ke4k5i/LOY8wkqoppgQU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=Ui7t6UYnjDGA7jUXdMOZJ6Axzrun5isfzKVm2Uxl2vfraDeFP2914FnkkgGhu02mt
	 voOMjZW+YQ46kAl40nY5yZAVMVTwc2qmAKmCz9LQhk5ulRqhzZ/m3BmyZQAM9NVgx8
	 FwOD9Y8T/fvcC5vlvAad/UEgX4uXdJMGHYQlatXXVZVZd+jSgiNaUDo3eXIDHUpHPb
	 H9f3aviudsPqRTHHXbL4Vk5hI08JKwkf42AE7BMOT0rqjFGPcbbnzBwf1XrdOxPL93
	 HRXzP9YkSZKmWwWsTd+SDFdFB4YbPaM8pEuJ0zHw4olpd2r+ILT02xSPpdClMWKtk7
	 45CLGnbTDgBTw==
Message-ID: <6bd4f498-6699-4d54-a43a-57c954bff958@kernel.org>
Date: Tue, 4 Aug 2026 15:09:13 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: Re: [PATCH v2 3/6] mm/powerpc/8xx: constify ptep_get() argument
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>,
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
 <20260803164400.531199-4-pfalcato@suse.de> <anHI4B-lMu6AJJfA@lucifer>
 <dcdb8cab-c18c-4995-ad1d-2f2d4700e7c1@kernel.org> <anHgw2Z-d-OQk9qs@lucifer>
Content-Language: fr-FR
In-Reply-To: <anHgw2Z-d-OQk9qs@lucifer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 04/08/2026 à 14:59, Lorenzo Stoakes (ARM) a écrit :
> On Tue, Aug 04, 2026 at 02:50:19PM +0200, Christophe Leroy (CS GROUP) wrote:
>> Hi Lorenzo,
>>
>> Le 04/08/2026 à 13:13, Lorenzo Stoakes (ARM) a écrit :
>>> On Mon, Aug 03, 2026 at 05:43:57PM +0100, Pedro Falcato wrote:
>>>> There is no need for write access to the PTE.
>>>>
>>>> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
>>>
>>> With below addressed LGTM so:
>>>
>>> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>>>
>>>> ---
>>>>    arch/powerpc/include/asm/nohash/32/pte-8xx.h | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
>>>> index e2ea8ba9f8ca..f2bab31040c7 100644
>>>> --- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
>>>> +++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
>>>> @@ -226,7 +226,7 @@ static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, p
>>>>
>>>>    #ifdef CONFIG_PPC_16K_PAGES
>>>>    #define ptep_get ptep_get
>>>> -static inline pte_t ptep_get(pte_t *ptep)
>>>> +static inline pte_t ptep_get(const pte_t *ptep)
>>>>    {
>>>>    	pte_basic_t val = READ_ONCE(ptep->pte);
>>>>    	pte_t pte = {val, val, val, val};
>>>
>>> Worth making these const too (that {val, val, val, val} horrifies me btw :)?
>>
>> Any suggestion welcome.
> 
> I'm being super nitty, all I mean is:
> 
> -   	pte_basic_t val = READ_ONCE(ptep->pte);
> -  	pte_t pte = {val, val, val, val};
> +   	const pte_basic_t val = READ_ONCE(ptep->pte);
> +  	const pte_t pte = {val, val, val, val};
> 
> :)

I'm fine with that, I was reacting on the "horrifying".

> 
>>
>> powerpc 8xx page table is independant on page size. When you use 16k pages,
>> depending on the address you hit the page for the first time, the HW assist
>> page table walk will fetch one of four 4k cells in page table that need to
>> be identical as they all four define the same 16k page. Not sure I'm clear.
> 
> No that's clear, thanks!
> 
> (I say 'horrifying' because I am looking into RCU page table freeing which this
> may complicate, though perhaps not in practice, to be continued :)

A few more details here if needed: 55c8fc3f4930 ("powerpc/8xx: 
reintroduce 16K pages with HW assistance")

Christophe

