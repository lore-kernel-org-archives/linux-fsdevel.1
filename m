Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D513911C7
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784900241; cv=none; b=lFIvfhi5zECVMKGtvL4HgLahiBVMiX8rvFl43EF54GDKgvGgtK7L1i2gCJU387GwpaTUb/rGxDW+S2rNc6FcQWMdpS3nbBy7otMlqaAVKOqTFZvN7Br5OyGpdyCiPMMsGEYCaY34yWogQtAcVFfFPxKbZjvfH5T300V1b1Gexdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784900241; c=relaxed/simple;
	bh=2+keQIk7JM9nrHkBIMRZyyUE2/I5bNFxu16eW8JymBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SqkjjNw5btQIAPUgxEOreDogxGpRKFIVEJfToTslUGZlC2gvpjBX0xtfPJNRnEdb4b/83Adr+hMUhqM1IlzzvHqDIorSKcwesqZONHi2F/QW9zyzK23v6cHxC7NgDfunA+qVOaopz8XT5LExxrgOswU8WiOl+TcIFnNsF8KS6Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UvQ7Evnd; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UvQ7Evnd"
Message-ID: <0fd713a8-e4ab-4c07-b36e-79dd138b4a86@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784900227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6/FxFds0ZblJiTDVn0Zh6YSzNFtgG6KSsc6BX2Vp7N0=;
	b=UvQ7Evndl12aryBj5Gzh/4Kx4IFxjvJ4rQR7z7ZeZ02IkJcBysdcs4RGKKa4/VtIk/MUN4
	kFv0UzKogYSnjvY8paSxOYiT0jsEqzPaZPtCX7Fha6cYM3qT2NMr9omxqoVR6rqLt06FcV
	aqyG0djpQWd5Myh9Rdt5ZWa+1GWgLE8=
Date: Fri, 24 Jul 2026 14:36:59 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/5] mm/parisc: constify ptep_get() argument
To: Pedro Falcato <pfalcato@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Kevin Brodsky <kevin.brodsky@arm.com>,
 Muhammad Usama Anjum <usama.anjum@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20260724102017.141532-1-pfalcato@suse.de>
 <20260724102017.141532-4-pfalcato@suse.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20260724102017.141532-4-pfalcato@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 24/07/2026 11:20, Pedro Falcato wrote:
> ptep_get() does not need write access to the PTE.
> 
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> ---
>  arch/parisc/include/asm/pgtable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
hmm I think you might break build bisectibility if
you separate out the patches, you should squash patch 3 and 4,
with patch 1.
