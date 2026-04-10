Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF89838F920
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 11:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775818999; cv=none; b=HNN3OxBmp+Ymy0J9wZn9rBNjnSfEy/c5x+2aohbWCcoVhYmSvy/wmrdf0a/RLBfJn1Cdx4keksmMRIBgr5CS8UtFfFSmevvUywLf5r6XGdlntVZdW9VuiHoiBofrxfd4BYGbk57mxQc8Rdc3ePI3kQqMMNTY0T3+FiLeY+R2aaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775818999; c=relaxed/simple;
	bh=wEhZRWB2QYR9aCfpJcHsbkBH8H7Via0tqcyJM/CTihg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bvC15tRw1Mx7+zZzyGuNWN/ZoTGXeWyaqIVi+iCIneA6o0L+2U1aye1ShW6z7aB0cTJOLIYtMLNvO7yx9oplepmHmUljX+jWT6l4b0qP3jK32X9Qe2EtyghW7D4vyfAUjOIJYUPR+bWX16QtwoKa7TuMOFUMJZhgAyUydbVx6cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iJoGufjQ; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iJoGufjQ"
Message-ID: <803a0c15-0a6a-4c00-b6b3-eaae56d5fc15@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775818995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8bka1cw1Qi/26a2+Jc2kZb2RQ89wlOuzga7814xjpSI=;
	b=iJoGufjQVaQA6OgKeg5PcAsyZ8KZg1ybHyCC/iI7k/7xV/aIhUEg2lF1iVeMxXrG9M077+
	EoC6fgrcjKXP0ZjKnjkT1Yvi28Vfmm6jVAR3ASkUYQ/Z0Ldz7JnJE9po7D5M3BnsWEuBwm
	p8XAjefEGV13yARmt8akLWTc9caFn4g=
Date: Fri, 10 Apr 2026 12:03:03 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/4] mm: improve large folio readahead and alignment
 for exec memory
Content-Language: en-GB
To: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org,
 willy@infradead.org, ryan.roberts@arm.com, linux-mm@kvack.org
Cc: r@hev.cc, jack@suse.cz, ajd@linux.ibm.com, apopple@nvidia.com,
 baohua@kernel.org, baolin.wang@linux.alibaba.com, brauner@kernel.org,
 catalin.marinas@arm.com, dev.jain@arm.com, kees@kernel.org,
 kevin.brodsky@arm.com, lance.yang@linux.dev, Liam.Howlett@oracle.com,
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lorenzo Stoakes <ljs@kernel.org>,
 mhocko@suse.com, npache@redhat.com, pasha.tatashin@soleen.com,
 rmclure@linux.ibm.com, rppt@kernel.org, surenb@google.com,
 vbabka@kernel.org, Al Viro <viro@zeniv.linux.org.uk>, ziy@nvidia.com,
 hannes@cmpxchg.org, kas@kernel.org, shakeel.butt@linux.dev,
 leitao@debian.org, kernel-team@meta.com
References: <20260402181326.3107102-1-usama.arif@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20260402181326.3107102-1-usama.arif@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 02/04/2026 19:08, Usama Arif wrote:
> v2 -> v3: https://lore.kernel.org/all/20260320140315.979307-1-usama.arif@linux.dev/
> - Take into account READ_ONLY_THP_FOR_FS for elf alignment by aligning
>   to HPAGE_PMD_SIZE limited to 2M (Rui)
> - Reviewed-by tags for patch 1 from Kiryl and Jan
> - Remove preferred_exec_order() (Jan)
> - Change ra->order to HPAGE_PMD_ORDER if vma_pages(vma) >= HPAGE_PMD_NR
>   otherwise use exec_folio_order() with gfp &= ~__GFP_RECLAIM for
>   do_sync_mmap_readahead().
> - Change exec_folio_order() to return 2M (cont-pte size) for 64K base
>   page size for arm64.
> - remove bprm->file NULL check (Matthew)
> - Change filp to file (Matthew)
> - Improve checking of p_vaddr and p_vaddr (Rui and Matthew)
> 

Hello!

Just wanted to check if there was any feedback/review on the latest
revision? 

Thanks!

