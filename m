Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A564A3DC4CF;
	Tue,  4 Aug 2026 12:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785847836; cv=none; b=Tk6SxUeqooUpwEvPFAvAxw0WRozYdvGIFW1HwwKxf2hLBSHZAowbVFIjeYlj/oA4Fx5w2Seyc0pDNo5mWC9ctSiCoLU/Ge/A0BdGNC1Q/6Okp5AkhWMDyhxxtxNpg/E3y5Bxedxah3OHngivvEJlGRsxN8lGBcUnSWZOHbb0+E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785847836; c=relaxed/simple;
	bh=JvAbT9q4QB3FDwqD92pZaQJ45cprG18bjSSj0Vifpbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pVsLY0dGD5iPFAefAlKoNdTWkrBQsUCcGcVqdhP5iQJkzJ8a93z9Gg6t+SlHSyoeq8eEZ88VBz9Yys4/0q46sBJsXjRcZ1N7XJdJBs5IRmypVCObK+wVYnlDeu2j2ygYIrbQFfvxTMAP6RO7jHnn9E6cjB8U+9Wu1fLwpvzlBds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YABf4fdg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YABf4fdg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA74A1F000E9;
	Tue,  4 Aug 2026 12:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785847831;
	bh=dwIlf/7Evmvt247IE4OinLG+J81ldxUzqSmjbn1lj4I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=YABf4fdg/D3MZ/bWjeLut7tnE92glPPUblZGjARSmDu+SgTZpTVi3WlLm5HquAEGf
	 J2bpoFXvno4uXAcJ7Qo2ETmUHwVx7QaU4Q6WWLBRWh0ptmCIMDZ7RFbr0vY3E7y26f
	 HxBmGepETc20zSML41v9hWk4GYBDyII5UeitdQ7FJ1clvB48Hd99D6tRp7kXQbSc+/
	 XRPUWDoOmZMUHaf+U1rl7d5ImlwquVOEdD/uQN4srP+6xLmPHZhNDl1rgq1RFigrZq
	 Gs2boYFuSu/p89NeE3nlhVrLloKDlGkdWJOQ09Yz3skgBGv9l0vTzQ2rYw7eRih4tx
	 ETPFvsGGDEVUQ==
Message-ID: <dcdb8cab-c18c-4995-ad1d-2f2d4700e7c1@kernel.org>
Date: Tue, 4 Aug 2026 14:50:19 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] mm/powerpc/8xx: constify ptep_get() argument
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Pedro Falcato <pfalcato@suse.de>
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
 <20260803164400.531199-4-pfalcato@suse.de> <anHI4B-lMu6AJJfA@lucifer>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <anHI4B-lMu6AJJfA@lucifer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Lorenzo,

Le 04/08/2026 à 13:13, Lorenzo Stoakes (ARM) a écrit :
> On Mon, Aug 03, 2026 at 05:43:57PM +0100, Pedro Falcato wrote:
>> There is no need for write access to the PTE.
>>
>> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> 
> With below addressed LGTM so:
> 
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> 
>> ---
>>   arch/powerpc/include/asm/nohash/32/pte-8xx.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
>> index e2ea8ba9f8ca..f2bab31040c7 100644
>> --- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
>> +++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
>> @@ -226,7 +226,7 @@ static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, p
>>
>>   #ifdef CONFIG_PPC_16K_PAGES
>>   #define ptep_get ptep_get
>> -static inline pte_t ptep_get(pte_t *ptep)
>> +static inline pte_t ptep_get(const pte_t *ptep)
>>   {
>>   	pte_basic_t val = READ_ONCE(ptep->pte);
>>   	pte_t pte = {val, val, val, val};
> 
> Worth making these const too (that {val, val, val, val} horrifies me btw :)?

Any suggestion welcome.

powerpc 8xx page table is independant on page size. When you use 16k 
pages, depending on the address you hit the page for the first time, the 
HW assist page table walk will fetch one of four 4k cells in page table 
that need to be identical as they all four define the same 16k page. Not 
sure I'm clear.

Christophe

