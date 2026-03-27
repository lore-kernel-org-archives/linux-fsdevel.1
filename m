Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3B1361DB7
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630330; cv=none; b=B3X4qtY9F5kKg72IMR4HmOG9sn3rD1F1taLHzHPufigEpukhToClNf+42uPFftDVs0dX4rTgsW5FOBVIUzI6z70jsgd1ckW14AOCnYTNoKeeK0/qtuqHFkyn8jwZYR0WEofrPVKPkqXgN9qNB2NzqhO8s9SsZ2h1Hxed+umxYlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630330; c=relaxed/simple;
	bh=Be4tWMUEIAcXPElyaU2L09C6kSYkZXT30+28DeHuCHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jGHLEFTa7wCR/K55pxeQujmuVp8AmM4015eN7xQDwp2rHV0gKvd8I7K9wYe5IChMYnQFn5AnaqFJmTWmToQAWVhhtuNUAhc+exe9rgUyNJt6jaez3RarbDD0MCw+QNWq2ncMq5WuRiktaIoxI8cvMEkfFxNrSL8xk6Hdcu9p1Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eQdxda0V; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eQdxda0V"
Message-ID: <09f1f982-4143-4c57-9bf6-fee546b2606b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774630314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=859ciwTLws9gTLdPiMbsS4SJ1GOzZrhoCCXtFwVU8lM=;
	b=eQdxda0VXEY8Bm/gK5z/H6o1WBS+xzZU7GDDlPJSxH272S+kvcs994vq5gP6ylP0fK8WMr
	wZ1KR8sjIN6G+BRLqc71go1CgG/LVZHt2CFRm94mVG4EXUF0oS5jnoZ0DXugjTmf62p1Ib
	6N/JEBZtBILoFe3eY8E3oEAIcUuUG20=
Date: Fri, 27 Mar 2026 12:51:47 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/4] elf: align ET_DYN base to max folio size for PTE
 coalescing
Content-Language: en-GB
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org,
 ryan.roberts@arm.com, linux-mm@kvack.org, r@hev.cc, jack@suse.cz,
 ajd@linux.ibm.com, apopple@nvidia.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, brauner@kernel.org, catalin.marinas@arm.com,
 dev.jain@arm.com, kees@kernel.org, kevin.brodsky@arm.com,
 lance.yang@linux.dev, Liam.Howlett@oracle.com,
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, lorenzo.stoakes@oracle.com, mhocko@suse.com,
 npache@redhat.com, pasha.tatashin@soleen.com, rmclure@linux.ibm.com,
 rppt@kernel.org, surenb@google.com, vbabka@kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, wilts.infradead.org@kvack.org,
 ziy@nvidia.com, hannes@cmpxchg.org, kas@kernel.org, shakeel.butt@linux.dev,
 kernel-team@meta.com
References: <20260320140315.979307-1-usama.arif@linux.dev>
 <20260320140315.979307-4-usama.arif@linux.dev>
 <ab1uqdcMBP1cBr7Q@casper.infradead.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <ab1uqdcMBP1cBr7Q@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 20/03/2026 18:58, Matthew Wilcox wrote:
> On Fri, Mar 20, 2026 at 06:58:53AM -0700, Usama Arif wrote:
>> -static unsigned long maximum_alignment(struct elf_phdr *cmds, int nr)
>> +static unsigned long maximum_alignment(struct elf_phdr *cmds, int nr,
>> +				       struct file *filp)
>>  {
>>  	unsigned long alignment = 0;
>> +	unsigned long max_folio_size = PAGE_SIZE;
>>  	int i;
>>  
>> +	if (filp && filp->f_mapping)
>> +		max_folio_size = mapping_max_folio_size(filp->f_mapping);
> 
> Under what circumstances can bprm->file be NULL?

Yeah its unnecessary here. Its used in other places and this is never
checked, so we can remove it.

> 
> Also we tend to prefer the name "file" rather than "filp" for new code
> (yes, there's a lot of old code out there).
> 

ack. will change in next revision.

>> +
>> +			/*
>> +			 * Try to align the binary to the largest folio
>> +			 * size that the page cache supports, so the
>> +			 * hardware can coalesce PTEs (e.g. arm64
>> +			 * contpte) or use PMD mappings for large folios.
>> +			 *
>> +			 * Use the largest power-of-2 that fits within
>> +			 * the segment size, capped by what the page
>> +			 * cache will allocate. Only align when the
>> +			 * segment's virtual address and file offset are
>> +			 * already aligned to the folio size, as
>> +			 * misalignment would prevent coalescing anyway.
>> +			 *
>> +			 * The segment size check avoids reducing ASLR
>> +			 * entropy for small binaries that cannot
>> +			 * benefit.
>> +			 */
>> +			if (!cmds[i].p_filesz)
>> +				continue;
>> +			size = rounddown_pow_of_two(cmds[i].p_filesz);
>> +			size = min(size, max_folio_size);
>> +			if (size > PAGE_SIZE &&
>> +			    IS_ALIGNED(cmds[i].p_vaddr, size) &&
>> +			    IS_ALIGNED(cmds[i].p_offset, size))
>> +				alignment = max(alignment, size);
> 
> Can this not all be factored out into a different function?  Also, I
> think it was done a bit better here:
> https://lore.kernel.org/linux-fsdevel/20260313005211.882831-1-r@hev.cc/
> 
> +	if (!IS_ALIGNED(cmd->p_vaddr | cmd->p_offset, PMD_SIZE))
> +		return false;
> 


ack, will try and address this accordingly.


Thanks for the reviews!!
