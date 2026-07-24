Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638573CAE84
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784908154; cv=none; b=I9h/8jkOWHG/Rk4y8ma5lRPIYR7H5xnV12OP/DkdVyHwsravQNSNXH9+nyv6hgvLb4SBltnxEIcKBOMhPYtle/Ep7ruVDsO20MAktHlopN4s6Ren+hjmbvrDs8GSWo1ydjJBUwden9iYTUgX2DbmbMzwDoD7DRwDvcUe6OmzTnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784908154; c=relaxed/simple;
	bh=m2phItV52mWNj+mcfgLsr7GZ56HrAsdyGCSDYt9zqn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nYa+6LRdZO1XBVnKIOOXJXo9CK4mxp4CpG5PpF6Zu/zzaeQ/obxPQqAXjdMrN9neByr53Df2OlZHfO3qJ1wvpl7gG+kuIp49+PUvdpU0zX1c1QRxOXxT8dWhoa82waWYz2E6nemmqYNhFKDeh/xfOw/KbaE1shX4LwFmy/6Q1To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Nwts4fjd; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Nwts4fjd"
Message-ID: <fd239383-dcbe-4daf-b337-32facef07076@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784908138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wpu1gJe0sM1zpg7qn6uKI6n3VZyrOevD5zqeBPXBfwE=;
	b=Nwts4fjdNhRkKoiWWgZb1pTyJfagzBgyAnhKRuaoRCtBx7aSslbqFtzy/tsaZj6SPePbPj
	+h8333InKBjxMVvWvd3VZk65pWaNGEHdIfYDP0nvTh3PcpkutNlEUvY2oMMCgrEm5Igfrr
	HnNV1rKdfXh4xzFXjakZOI0RjFHt+wk=
Date: Fri, 24 Jul 2026 16:48:50 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/5] mm/parisc: constify ptep_get() argument
To: Pedro Falcato <pfalcato@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>,
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
 <253f7ac0-205b-42f1-9fb5-d19eceb581b6@linux.dev>
 <amOEUZlp1BxYh6_t@pedro-suse>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <amOEUZlp1BxYh6_t@pedro-suse>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 24/07/2026 16:32, Pedro Falcato wrote:
> On Fri, Jul 24, 2026 at 04:03:44PM +0100, Usama Arif wrote:
>>
>>
>> On 24/07/2026 15:14, Matthew Wilcox wrote:
>>> On Fri, Jul 24, 2026 at 02:36:59PM +0100, Usama Arif wrote:
>>>>
>>>>
>>>> On 24/07/2026 11:20, Pedro Falcato wrote:
>>>>> ptep_get() does not need write access to the PTE.
>>>>>
>>>>> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
>>>>> ---
>>>>>  arch/parisc/include/asm/pgtable.h | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>> hmm I think you might break build bisectibility if
>>>> you separate out the patches, you should squash patch 3 and 4,
>>>> with patch 1.
>>>
>>> I don't see how this breaks bisectability.  Can you elaborate on what
>>> you think would break?
>>
>> Patch 1 does:
>>
>> -static inline pte_t ptep_get_lockless(pte_t *ptep)
>> +static inline pte_t ptep_get_lockless(const pte_t *ptep)
>>  {
>>  	return ptep_get(ptep);
>>  }
>>
>>
>> ptep_get() takes a non-const arg till patch 3 for example for parsic.
>> I don't think you can pass a const variable to non const function arg?
>>
>> So parsic won't compile in patch 1 and 2, powerprc wont compile
>> for patches 1, 2 and 3..
> 
> Aha, yes, nice catch! I'll have to rethink that. Maybe squashing the patches
> would be the cleanest way forward.
> 

Yes, squashing is the simplest way forward.

> FWIW, the vast majority of architectures aren't doing funny things on
> ptep_get(). E.g PA-RISC, loongarch only define these so they can use it in
> their own asm/pgtable.h. I'd really like to delete these but I can't tell
> if they are *actually* required.
> 

Ah maybe there is something in git history on why it was needed?

If not, hopefully someone from the arch lists could clarify..

> With those gone only PPC 8xx and generic would need to be squashed (arm64 also
> defines its own version of ptep_get_lockless()).
> 
> 

