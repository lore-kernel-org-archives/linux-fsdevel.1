Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6AF3A9D82
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 12:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775822766; cv=none; b=Ud19B+aZ8zLA7vpHIN11yncb1LhVPS2N/qKrICzb/WwfaUCdOaypOO0Q0HUFjaqlM2kZujTSJeLXALPWYn5VCu8oay/LAN2SjnKR6SmyvwUIHGzM3Igkci9JI9EptBOjhYVDnFYAfzsEhCXs2mFbRzqvBpzMQ3Opbx4/fGU2IDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775822766; c=relaxed/simple;
	bh=wG3uG4ovBE7pXGSiq9zHihT7SfNzPKr3++OZ0H6X08U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JXhCO6a0dMYGcoQIgD3Wi2rJgfAg+Gy84rEImBE4RFy2IaI6W3KugLfd24fMBbaDpvcuo41zM7NK6C8OctxZhWqHP5+lj3Nc2PKBwKmIU0XXBzNwQvNfNaNoXsOeRRQVHSFVjZQyvLCEbAr7TKtgOjWuFR6BGkNd2YOCTbHWNLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S1IPhLac; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S1IPhLac"
Message-ID: <262a41db-a425-4362-bb67-df61119625d5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775822752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UciXY4UpwF/PVQ55Oa+nceO1l3r0LRhzvlDseaImpoY=;
	b=S1IPhLac5GLe8aWkzUNhPX1PlP9fq5z3WRAjL+vGJS6PRIGTZh7B7rKGP6zR510zSkjeYf
	K2QNdKANEbpRs7f7uwGklMZu8fyrnR1UsL3rCWPzJNLUoi6SJAO92EUU22rkQ1qumaPnr5
	nnM4xvZ//KZw8+pWbEggmfs0orX141o=
Date: Fri, 10 Apr 2026 13:05:40 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/4] mm: improve large folio readahead and alignment
 for exec memory
Content-Language: en-GB
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org,
 willy@infradead.org, ryan.roberts@arm.com, linux-mm@kvack.org, r@hev.cc,
 jack@suse.cz, ajd@linux.ibm.com, apopple@nvidia.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, brauner@kernel.org, catalin.marinas@arm.com,
 dev.jain@arm.com, kees@kernel.org, kevin.brodsky@arm.com,
 lance.yang@linux.dev, Liam.Howlett@oracle.com,
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, mhocko@suse.com, npache@redhat.com,
 pasha.tatashin@soleen.com, rmclure@linux.ibm.com, rppt@kernel.org,
 surenb@google.com, vbabka@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 ziy@nvidia.com, hannes@cmpxchg.org, kas@kernel.org, shakeel.butt@linux.dev,
 leitao@debian.org, kernel-team@meta.com
References: <20260402181326.3107102-1-usama.arif@linux.dev>
 <803a0c15-0a6a-4c00-b6b3-eaae56d5fc15@linux.dev> <adjkCOiLgZ_-zovg@lucifer>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <adjkCOiLgZ_-zovg@lucifer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 10/04/2026 12:55, Lorenzo Stoakes wrote:
> On Fri, Apr 10, 2026 at 12:03:03PM +0100, Usama Arif wrote:
>>
>>
>> On 02/04/2026 19:08, Usama Arif wrote:
>>> v2 -> v3: https://lore.kernel.org/all/20260320140315.979307-1-usama.arif@linux.dev/
>>> - Take into account READ_ONLY_THP_FOR_FS for elf alignment by aligning
>>>   to HPAGE_PMD_SIZE limited to 2M (Rui)
>>> - Reviewed-by tags for patch 1 from Kiryl and Jan
>>> - Remove preferred_exec_order() (Jan)
>>> - Change ra->order to HPAGE_PMD_ORDER if vma_pages(vma) >= HPAGE_PMD_NR
>>>   otherwise use exec_folio_order() with gfp &= ~__GFP_RECLAIM for
>>>   do_sync_mmap_readahead().
>>> - Change exec_folio_order() to return 2M (cont-pte size) for 64K base
>>>   page size for arm64.
>>> - remove bprm->file NULL check (Matthew)
>>> - Change filp to file (Matthew)
>>> - Improve checking of p_vaddr and p_vaddr (Rui and Matthew)
>>>
>>
>> Hello!
>>
>> Just wanted to check if there was any feedback/review on the latest
>> revision?
> 
> It's -rc7, this is definitely something for next cycle :)
> 

Yeah no worries! Just wanted to check what people thought about it!

> On my part, my upstream bandwidth has drastically reduced, and review is
> probably going to have to be a hobbyist thing at least for now.
> 
> Also, not to be mean but:
> 
> $ git log -E -i --grep "(Reviewed|Acked)-by: Usama Arif" --oneline | wc -l
> 21
> 
> So... :)
> 
> Review in mm is very lop-sided, let's try to balance it out a bit!
> 

Ah yeah actually I have been reviewing a lot over the last few months.
I dont ack patches that have already been acked-by/reviewed-by maintainers.
as I am not sure if it adds anything. I never really cared about Reviewed/Acked
by/patch count but I can start adding tags if it helps in stats.

The reviews I have done over the last week alone:
https://lore.kernel.org/all/20260408122307.1360475-1-usama.arif@linux.dev/ 
https://lore.kernel.org/all/20260408123700.1596800-1-usama.arif@linux.dev/ 
https://lore.kernel.org/all/20260409142256.131676-1-usama.arif@linux.dev/ 
https://lore.kernel.org/all/20260410114809.3592720-1-usama.arif@linux.dev/ 
https://lore.kernel.org/all/20260410112433.3248586-1-usama.arif@linux.dev/ 
https://lore.kernel.org/all/20260331103451.1070175-1-usama.arif@linux.dev/T/#t 
https://lore.kernel.org/all/20260401152343.3294686-1-usama.arif@linux.dev/ 





