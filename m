Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018434;
	b=iH+Jz2psuvhNA6rzb5c0OjDMElEZybzm3Rd5Y7EKfoTNI4DXHR5DBnZe7AiX5bY3P75K
	 QR4sFPAcj5kykCnptFWTwkokX1uHYSiS+PeppNHadU6v0L44Yf3qmTO7G78ZzxSl5qBCO
	 Pwit2kKz/Qku8AAZ0OvoYnw3WnbjtqPvRkyatUKr24Q5FE51W6+uw5IVyj5kKfkd2XaNb
	 2frVbFhzEzHhCcXd9ZvPF33+4Ef1JLZGR4/39FNcuCtKWbfrGbnTUQQp/IGaVnbo+qdMa
	 APvquVrCBjYGw3qPqjocqB0dWqUXYtDm8pDKR2YxRIyAvSZGfKN9YSXyuIYMuWD1xPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018434;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=UDY6LeieQk2sGbGiXNXbPPvHnTeUTEIgT8C3oVSPieo=;
	b=Wwgyxx1PWflTP9PFL0LsX5Bc9tuq0rGCEXpJ6C8sz0DCF4zkTcet3k07ovEeoNNW5tiS
	 tDn8s0pqr5F1/himtV8oh3BGgsrvwqeh6DxYe6m95M+y57E41Be0fXDqcinLjwJP03lkv
	 cutBzHzgFJDXxA3Gq5mhvGQCmXiLzMtQb3mTsm9ZJoInRCULVXCz3y6JMtFG8WIlBdyl3
	 9p1YniUq6cJdRyPhYTpIF1N5bks1j+mwj8M6hBOujAoWN7pimXU/Wa5EGaQY484RMSlV3
	 8sccx+5+IFJVZGMi+3cwN+oTO2CMNaAdj4IRwD7vg+TYCwpy0GAFS7jCo5ovqHl5Y4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=u2jgpdyY;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FF2606A32A;
	Wed, 18 Nov 2026 16:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89FF2606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=u2jgpdyY
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06319339;
	Wed, 18 Nov 2026 08:13:50 -0800 (PST)
Received: from [10.163.128.4] (unknown [10.163.128.4])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9299A3F673;
	Wed, 18 Nov 2026 08:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795018432; bh=pfB2+G/VoDxmSSgbbYNYneQ5JEOWrzBbTorN+tE3j/4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u2jgpdyY1nx7ZxYgQWIL3DzdxEuJutCwltNdY9EaAvsqO7brLg/j9Ns2PQsLZ/HSU
	 XeHOk9QoYMskJGgkCIAx72cG40jDuYx8DscQhcxP2wcxdDgFxzww0/VW0HR0BrbSgd
	 IErEv2HBX5ors7qzipqCaYh4j3YMg7HC1YIBqcKA=
Message-ID: <9144c79b-4052-4794-94cb-51477ba91cf2@arm.com>
Date: Wed, 18 Nov 2026 21:43:43 +0530
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
Subject: Re: [PATCH mm-new v2 3/5] mm/swap: remove unused folio_to_swp_tb()
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
 <20261117-unused-sym-mm-v2-3-2f845e94dd50@amd.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20261117-unused-sym-mm-v2-3-2f845e94dd50@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 17/11/26 12:46 pm, Shivank Garg wrote:
> Its last users were removed in commit 0d6af9bcf383 ("mm, swap: use the
> swap table to track the swap count").
> 
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---

Reviewed-by: Dev Jain <dev.jain@arm.com>


>  mm/swap_table.h | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/mm/swap_table.h b/mm/swap_table.h
> index 072625d60d54..022d2251884e 100644
> --- a/mm/swap_table.h
> +++ b/mm/swap_table.h
> @@ -135,11 +135,6 @@ static inline unsigned long pfn_to_swp_tb(unsigned long pfn, unsigned char flags
>  	return swp_tb | __flags_to_swp_tb(flags);
>  }
>  
> -static inline unsigned long folio_to_swp_tb(struct folio *folio, unsigned char flags)
> -{
> -	return pfn_to_swp_tb(folio_pfn(folio), flags);
> -}
> -
>  static inline unsigned long shadow_to_swp_tb(void *shadow, unsigned char flags)
>  {
>  	BUILD_BUG_ON((BITS_PER_XA_VALUE + 1) !=
> 

