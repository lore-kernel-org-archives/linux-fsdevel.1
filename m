Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8F23A873A
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 10:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773831475; cv=none; b=TrXGfyen9E3CXyvh0Ri7Qc/ncrUzxSQMYCDi1T9GHRy4zM/fr4CMAT2lPFRv5qOkAm2h0kXy/PNI9XybvjyzerEgSIsEpjCp8xa0ruDaIo7Du+XE8gxytI/q1XtecQviBazOMaBmIuT2LgYgH99EyWIoPRADBQX/Dah7rwDvdkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773831475; c=relaxed/simple;
	bh=xHgb+BfX5m/PPZTLpbMGksFUR8hxWk6OGlriMnE3+cM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GozjHkhdclCy3+/9P7+rSszgtqiVp4mptPoF+OCeern8gg0hcvB0JtAVClp/WKnadIr0Gxjblzyqs1mUjyYbkKmtv9n2tXSe5W5EybNjxCoHs2xyyxibiPQBXm8HVbVFyq/vbAZBCOwPxWkWukSNvYSzL786YWhkQ2YgfzwOzhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SH99kRsY; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SH99kRsY"
Message-ID: <d0c0ac64-be15-4683-89ec-e32bf4867109@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773831461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IgLjZjiZAQDujWNQO4KkWHp+1oa/NVCBWzOVCA3bnuk=;
	b=SH99kRsYhm85fHzLq0PeXe+Bmssa3uLHL41zHKFW5m1uq3oVO68YMdQA5P0yhRRb3VjGCC
	zwlkGEaEamADlJ7708FKSc+i+m9W/j3VIF8nSyB2yhNspkesHeRK3OvWgc/BXvo6Qra6Zf
	/L9tRcXOOfqx8oI1ud0jioievUKdyT8=
Date: Wed, 18 Mar 2026 13:57:31 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] arm64/mm: contpte-sized exec folios for 16K and 64K
 pages
Content-Language: en-GB
To: WANG Rui <r@hev.cc>, Ryan Roberts <ryan.roberts@arm.com>,
 David Hildenbrand <david@kernel.org>
Cc: Liam.Howlett@oracle.com, ajd@linux.ibm.com, akpm@linux-foundation.org,
 anshuman.khandual@arm.com, apopple@nvidia.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, brauner@kernel.org, catalin.marinas@arm.com,
 david@kernel.org, dev.jain@arm.com, hannes@cmpxchg.org, jack@suse.cz,
 kas@kernel.org, kees@kernel.org, kernel-team@meta.com,
 kevin.brodsky@arm.com, lance.yang@linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, npache@redhat.com, rmclure@linux.ibm.com,
 ryan.roberts@arm.com, shakeel.butt@linux.dev, viro@zeniv.linux.org.uk,
 will@kernel.org, willy@infradead.org, ziy@nvidia.com
References: <20260310145406.3073394-1-usama.arif@linux.dev>
 <20260314095022.217231-1-r@hev.cc>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20260314095022.217231-1-r@hev.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 14/03/2026 12:50, WANG Rui wrote:
> I only just realized your focus was on 64K normal pages, what I was
> referring to here is AArch64 with 4K normal pages.
> 
> Sorry about the earlier numbers. They were a bit low precision.
> RK3399 has pretty limited PMU events, and it looks like it can’t
> collect events from the A53 and A72 clusters at the same time, so
> I reran the measurements on the A53.
> 
> Even though the A53 backend isn’t very wide, we can still see the
> impact from iTLB pressure. With 4K pages, aligning the code to PMD
> size (2M) performs slightly better than 64K.
> 
> Binutils: 2.46
> GCC: 15.2.1 (--enable-host-pie)
> 
> Workload: building vmlinux from Linux v7.0-rc1 with allnoconfig.
> Loop: 5
> 
>                 Base                 Patchset [1]         Patchset [2]
> instructions    1,994,512,163,037    1,994,528,896,322    1,994,536,148,574
> cpu-cycles      6,890,054,789,351    6,870,685,379,047    6,720,442,248,967
>                                               ~ -0.28%             ~ -2.46%
> itlb-misses           579,692,117          455,848,211           43,814,795
>                                              ~ -21.36%            ~ -92.44%
> time elapsed            1331.15 s            1325.50 s            1296.35 s
>                                               ~ -0.42%             ~ -2.61%
> 


Thanks for running these! Just wanted to check what is the base page size
of this experiment?

Ofcourse PMD is going to perform better than TLB coalescing (pagefault
itself will be one less page table level). But its a tradeoff between
memory pressure + reduced ASLR vs performance. As Ryan pointed out in
[1], even 2M for 16K base page size might introduce too much of memory
pressure for android phones, and the PMD size for 16K is 32M! 

[1] https://lore.kernel.org/all/cfdfca9c-4752-4037-a289-03e6e7a00d47@arm.com/

> Maybe we could make exec_folio_order() choose differently folio size
> depending on the configuration and conditional in some way, for example
> based on the size of the code segment?

Yeah I think introducing Kconfig might be an option.

> 
> [1] https://lore.kernel.org/all/20260310145406.3073394-1-usama.arif@linux.dev
> [2] https://lore.kernel.org/linux-fsdevel/20260313005211.882831-1-r@hev.cc
> 
> Thanks,
> Rui

