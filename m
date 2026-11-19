Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795062988;
	b=FK1nJscSiIsWZw0PfKaByfUXrhE0XgCh+VqOx9q/ovQLw01n9RpyZsraOSLkTsIwTKLH
	 u6tJPhayFhulFgdx7+ty7VmNqzSQ//VlfyhJlK+fNl1rxf84HYwPnIaeaHsADK6o+2mgC
	 UvV5CFnn+eG6AbbKTy/L4S927T77s1rs3B4OeSmdghdyNZWyV7NtV7Z9jM7nuCPgSgRQo
	 lOvt46Yd/F+SRKhw08a661JluJbe/Z3urW7h5pt3Y9Gtx+IinBfye29xMWO+LO1FYVs6i
	 7KvzkjAHXGDUbBL2Rr3aASZqb5fnqeS9DPyTP7NjegA6wzCpCvoyfRhEU+1/Mkkw2bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795062988;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=3jfCZy6SiWS7DTdY9KnhR8HM774z4oPEC7pkYn58qRE=;
	b=puo4FfASwkpR3FibYvWNm29evm2v4Fb5rv6CNd8DgjndSgnj04ennyM2wevZEa0MqwlB
	 nqmrJhhTkTtWVXdMDGGYSNYDJLFG0Yi2SFxbtsheD6blxAzOeypzVx2DL19Hah+E3ZVDo
	 LAYt+wH0GXGCXpAPKcpSVK/XfBO+pFoXqpAG49lrhiifeFgO2jcLEJrDzE+ibNRHJGMzJ
	 JpWeo81wUikEhZcSIs0EYSPTgKXQaHU0bPxHMmxdj+PDK3flc38eFdwU7cyUaUnupFt+c
	 Fo/U1gDsbJwqQ/+9db5nRWdE//QSS/XZ2kpTUOvnbTXBFZEmURBhTeKqaHC3rx/GOMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=RUHc4HPK;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018AE606A320;
	Thu, 19 Nov 2026 04:36:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 018AE606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=RUHc4HPK
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42606152B;
	Wed, 18 Nov 2026 20:36:24 -0800 (PST)
Received: from [10.163.128.149] (unknown [10.163.128.149])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70E083F882;
	Wed, 18 Nov 2026 20:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795062987; bh=neGOr0hP78TEIQZkJ7PN5DflwqzgDrJbonprN/ve+C4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RUHc4HPK8NvwYVieJPbxLpzyc1UPVo50Jc0n+9Tw4JPOVnao93AOPr86jHa7+9oub
	 OMY+sfwdMJaQ8hyFB2pbCWG+rp0l73PyE5X/BcrKuFGY/oefsSc8jxVKuqA60Vf3zo
	 TmdVPdA1ZDKOjr4GNkUdxNzloFxw8zQzuCcwaYtU=
Message-ID: <dd4aba07-f533-401a-a5a6-22356f09f868@arm.com>
Date: Thu, 19 Nov 2026 10:06:16 +0530
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
Subject: Re: [PATCH mm-new v2 4/5] mm/zsmalloc: remove unused zpdesc_lock()
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
 <20261117-unused-sym-mm-v2-4-2f845e94dd50@amd.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20261117-unused-sym-mm-v2-4-2f845e94dd50@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 17/11/26 12:46 pm, Shivank Garg wrote:
> It was added in commit c1b3bb73d55e ("mm/zsmalloc: use zpdesc in

This was in late 2024 so seems fine.


> trylock_zspage()/lock_zspage()") but has never had a caller.
> 
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---

Reviewed-by: Dev Jain <dev.jain@arm.com>


>  mm/zpdesc.h | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/mm/zpdesc.h b/mm/zpdesc.h
> index 4fd81c2e8076..aaab5f1bfb52 100644
> --- a/mm/zpdesc.h
> +++ b/mm/zpdesc.h
> @@ -107,11 +107,6 @@ static_assert(sizeof(struct zpdesc) <= sizeof(struct page));
>  	const struct page *:		(const struct zpdesc *)(p),	\
>  	struct page *:			(struct zpdesc *)(p)))
>  
> -static inline void zpdesc_lock(struct zpdesc *zpdesc)
> -{
> -	folio_lock(zpdesc_folio(zpdesc));
> -}
> -
>  static inline bool zpdesc_trylock(struct zpdesc *zpdesc)
>  {
>  	return folio_trylock(zpdesc_folio(zpdesc));
> 

