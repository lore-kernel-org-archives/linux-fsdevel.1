Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB752DCF4C;
	Mon,  3 Aug 2026 02:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785724797; cv=none; b=jY/A0l+whFkJuZ+wGg/aL4osIfahZrVfjetdRBmOoTE6/xU/7JcnE8RJbIHMZcJoX0kkloLJnnvQFeJkQYQCJaUUCiMiMXKyqD5flSNvHDnFHBwnCGk63QOJZtVX3wopS4es9lyTPwxKt2wAkQFRDbUv73/N2VAQ/mmcYPKf+T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785724797; c=relaxed/simple;
	bh=xYRqqyU8aWV1BD6EvJK9g5z7OfrKCZbIUYOyzMI2k9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/F8cXKLRXCYlM5cPJP7/HFwluapMnI/CX/9d97yHPHXoXWNL6M/OlH/G+9X3qosNJ3Eb0acf0TLTD0FozGSzss6FCDlaKqPGDqUexeiQ+AhvXETX5xKjh2DwcS+HFYupFIeO3iHdzDOuLMDgrBbZOuDntkKpSa7G0uhV2o731E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FVpy/8Oh; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FVpy/8Oh"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785724792; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lZyI/Zcbivmd91K0VLJCzjKzknnvAi4iuaDCsAmqSG0=;
	b=FVpy/8OhwcE+NwLRhP0sX87l2ibgxB7917pYVNKznk2DWUiDtyZUWi/8LaFRsNWq40Tm4m23AEXZnwZmBEwGh2re+ZXFCGFzMXmqkkcjMLQZzC8FflB7fkfnbJVk/ANSzH/H+cP4dF5D4pMuF+9L2rMGuTLnHHzHdR00CBKVnCw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X8DpzJ9_1785724790;
Received: from 30.74.144.148(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X8DpzJ9_1785724790 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 03 Aug 2026 10:39:50 +0800
Message-ID: <0a319957-0691-43b9-bbc8-0e85ef06d176@linux.alibaba.com>
Date: Mon, 3 Aug 2026 10:39:49 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm/huge_memory: use folio's memcg inside
 __folio_split()
To: Zi Yan <ziy@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>,
 William Kucharski <william.kucharski@oracle.com>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
References: <20260730-add-gfp_account-to-xas_split_alloc-v2-0-5a56c2361d85@nvidia.com>
 <20260730-add-gfp_account-to-xas_split_alloc-v2-1-5a56c2361d85@nvidia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260730-add-gfp_account-to-xas_split_alloc-v2-1-5a56c2361d85@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/31/26 10:18 AM, Zi Yan wrote:
> During a pagecache folio split, an xarray node allocation can happen and
> needs to charge at folio's memcg instead of folio split invoker's memcg,
> because for example folio split can happen during reclaim and reclaim's
> active memcg might not be folio's memcg. Switch to folio's memcg at the
> beginning and switch back afterwards.
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Fixes: 6b24ca4a1a8d4 ("mm: Use multi-index entries in the page cache")
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
