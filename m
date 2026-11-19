Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795062742;
	b=alpOcdbnFbTkIEOWOd2bm76jsdUSm4xYxoZGNWoMyeLkH96ewHrUTnWYE3hlty1Ia7wF
	 Ei+6F82PQeNtsqC0jjL2nRsp3apH/p2j5K8tgbw0Cg4sxhyivhAEaQ/umozks2J6VJIcc
	 gUCNPjRxvBJTgLpWuiH7uTm8K+Ke40yuYNN+O6ffsEvM1YicQpflYlMZgCTM30+e+SP54
	 HLl99GegZGeGseVLMEFqznmo0bfuAqERtHzZO/k5MvJRau3zkYBJkRatl3lxkbdtjgwvE
	 6QTXu+SD8YxPAflMlohHBtzIIrttHVJ1B2/N+R0dPENzyhe7laHlSBGsRakQ4LT7pLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795062742;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=771EE4Y01/Bz+vrcmL8YA+yAmlZjomzAQG5AFXGOp+Q=;
	b=5gxgzstZ8/n45Xein/UbfmaCQHgn30QYYOH2I2SFB/kSVu2Qu95O0HQ18+/SX/moORJD
	 qx5R10sw4l9h4PS0TTbWVecDKzod/pqGEfy8Uka2iTS39z2lc5Mou0+lYwCIcAUFAnDC8
	 F4Z/wgh6A68j3XSH/UTLxyelZ/ir06WsTzJmnskN5AL/TNcDTc7xGm/FzcToBrxwuRdwb
	 CyLj28mRugaq4Po8NL5jJgslMHvZ5H7jlpFPXR/v7ZFgMQd8AoPMBf4BmoPXoWeeit5Ij
	 7Hx1yjBuEhBxPjU1U9sZQSNuMChYhbrA6IOqXRwQ4x6G2jFfffHyC0AEvE2MPGnps4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=fzsy+AgW;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCC3606A320;
	Thu, 19 Nov 2026 04:32:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCCC3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=fzsy+AgW
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E5381477;
	Wed, 18 Nov 2026 20:32:18 -0800 (PST)
Received: from [10.163.128.149] (unknown [10.163.128.149])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFF553F882;
	Wed, 18 Nov 2026 20:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795062741; bh=pyvnNs/u4c2sdesFangcHufEcUQlfeZ1CpbXhit+XHs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fzsy+AgW3SDfZ0T0gM78vrOJ5nYrWP9ALoqZBJH7YjoQMr68ffveYDzvqH6WTFATW
	 bDvZZx2xiTVm1fM5PvT0skiHbtN6F09EMzldAEV6yvJYxuT+ee+rRh4lnOi9IABqWB
	 zqRT2hnsXawMzwcaiiZhUVin69lHALHSjOfshA7M=
Message-ID: <9a813531-3489-473a-82b3-78cc8babc27d@arm.com>
Date: Thu, 19 Nov 2026 10:02:11 +0530
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new v2 2/5] mm/swapops: remove unused
 make_guard_swp_entry()
To: Shivank Garg <shivankg@amd.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>,
 Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>,
 Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20261117-unused-sym-mm-v2-0-2f845e94dd50@amd.com>
 <20261117-unused-sym-mm-v2-2-2f845e94dd50@amd.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20261117-unused-sym-mm-v2-2-2f845e94dd50@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 17/11/26 12:46 pm, Shivank Garg wrote:
> make_guard_swp_entry() has no callers.
> 
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---

With the commit message improved:

Reviewed-by: Dev Jain <dev.jain@arm.com>


>  include/linux/swapops.h | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index 603f9e3f909c..6f62fc3c8cfa 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -306,11 +306,6 @@ static inline swp_entry_t make_poisoned_swp_entry(void)
>  	return make_pte_marker_entry(PTE_MARKER_POISONED);
>  }
>  
> -static inline swp_entry_t make_guard_swp_entry(void)
> -{
> -	return make_pte_marker_entry(PTE_MARKER_GUARD);
> -}
> -
>  struct page_vma_mapped_walk;
>  
>  #ifdef CONFIG_ARCH_HAS_PMD_SOFTLEAVES
> 

