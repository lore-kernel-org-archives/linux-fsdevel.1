Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C19380FEE
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 15:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905454; cv=none; b=IUJ5811/dGKHmNXlUKzFsJtWvtDOuMMdqBDoa04IwN5478Lyg6+nH/0wZrSXqCldyzdfn0JN3NQUu7SweRcZYx0JkVH4sEdeelOhSXDIZ074mwhazj3CQMK5Qeh1vWeXa+SM6yllfhbj3RGigWQKeNpjeHZy7oohhkIrLEQxx28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905454; c=relaxed/simple;
	bh=CrYiJM8ffDM+mtkbIdKIX6nT6ua3608EeCNadSwL8KE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=es30cqOm7ncHFm2NkhD3n6S0IJ9ubuGKph8OCrbS3MTuMlYMSr0yTCB0QbZcz1zMkKbQ2PBy/H0EcPBHxmlGwkS+NZEHITZCWA3SWWxuFC86WRrtGokJhHhoRmCEbWoxJuBojpg/oA/fLxCNCJOQ7juXz4LEMZ8eo9vhH11UgJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n5/Rd4ev; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n5/Rd4ev"
Message-ID: <253f7ac0-205b-42f1-9fb5-d19eceb581b6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784905439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CdO7KCyyIro+bfenb1xkDQljGGt5dLLkhErcCFsE/Qg=;
	b=n5/Rd4evPANGbx1Hmm1azC85wU0nheG46FNmmGZJPiYVUUuGaxBTO3RHHaSsxBQmXrEiYH
	w9WBY2Cs+toTZTVSry5TJuqptsIkQ9usv7g3oI2qlLAi3yC1kjAzyk0KK+DRltA6b8/OHH
	0wfJYfPBAYVBhVVxrB7ixiXxNmqIs70=
Date: Fri, 24 Jul 2026 16:03:44 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/5] mm/parisc: constify ptep_get() argument
To: Matthew Wilcox <willy@infradead.org>
Cc: Pedro Falcato <pfalcato@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Kevin Brodsky <kevin.brodsky@arm.com>,
 Muhammad Usama Anjum <usama.anjum@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20260724102017.141532-1-pfalcato@suse.de>
 <20260724102017.141532-4-pfalcato@suse.de>
 <0fd713a8-e4ab-4c07-b36e-79dd138b4a86@linux.dev>
 <amNzLXuwflIZFKtI@casper.infradead.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <amNzLXuwflIZFKtI@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 24/07/2026 15:14, Matthew Wilcox wrote:
> On Fri, Jul 24, 2026 at 02:36:59PM +0100, Usama Arif wrote:
>>
>>
>> On 24/07/2026 11:20, Pedro Falcato wrote:
>>> ptep_get() does not need write access to the PTE.
>>>
>>> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
>>> ---
>>>  arch/parisc/include/asm/pgtable.h | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>> hmm I think you might break build bisectibility if
>> you separate out the patches, you should squash patch 3 and 4,
>> with patch 1.
> 
> I don't see how this breaks bisectability.  Can you elaborate on what
> you think would break?

Patch 1 does:

-static inline pte_t ptep_get_lockless(pte_t *ptep)
+static inline pte_t ptep_get_lockless(const pte_t *ptep)
 {
 	return ptep_get(ptep);
 }


ptep_get() takes a non-const arg till patch 3 for example for parsic.
I don't think you can pass a const variable to non const function arg?

So parsic won't compile in patch 1 and 2, powerprc wont compile
for patches 1, 2 and 3..




