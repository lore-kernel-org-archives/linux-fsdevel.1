Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795063131;
	b=nzSyr4TuXvB4EZ1qrVVyANvrdfrChW0W4GjdL1z61rZV+ucpNg1WiZ4eIhle8X7hWlSI
	 NS42v0YRtlIjyQS8THVWkjA0TGYzRqCk1gwpS4phuxwyRS0UnfFSqR/FrKPRfG39Z68Vj
	 YqtlcotRrWqV5GBryal9kYmOL7zlrl12bKhwlFc0BatAiJ9H5FKJebGA0eA8TicK2+6xx
	 5e2V3SfDmkzBtEpzJpidiC2QHB/a3o8weuWyeX7RyhgyPWPKZZ0hEmuT28GiIX2QgKaIa
	 YcLLNtPm416o7OWK55+8mfVevGwYNX2vohKaW1TvFQq0Fm8BkKC2s4KNVCRSBZYYIcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795063131;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=boV9j9CJiFSO2Y60FsNmlMGCziCduZoOfN17A//Gn10=;
	b=MvEbW8Zk2Z59choxNoIYRa/nPhVCVK96t6xm9A3i8CvgnwxC63NF0ewF6CSzE6JVCKIk
	 i3FEkiA40WAZKjpg4m2bAloQMCy1fs1szeVU5KQ+6AOBIUefRoZy5TEgl0aROZgQXcH85
	 +e4w2NJpwQffzULi0qMbt7TRYJZpf+S3dE9Fj2YOyHMBnyeM3S47y8p9bMkK1fkUgg3ID
	 g9P4jc0kzihbfj1suY8Y5Occ1F2cUwA6t25FmRgTX8Ktm4reXvvICysDrANg+grzs1pCE
	 6p4k7K6BVd8FrTzxz06hCl0ptbRoLuJYGcxghEAEefTyuXnhT51t6lWxbvCajGf862A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ISnp1hYQ;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B29606A320;
	Thu, 19 Nov 2026 04:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38B29606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ISnp1hYQ
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 757EA152B;
	Wed, 18 Nov 2026 20:38:47 -0800 (PST)
Received: from [10.163.128.149] (unknown [10.163.128.149])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD11B3F882;
	Wed, 18 Nov 2026 20:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795063130; bh=EcZiEGeiH3FHAMhxWmsIUo56I3szGrADgPmAMfAcAeM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ISnp1hYQlv1T88o3LSEUjbvpB2fm0RfDcV/gWnHvHLw1Mnw4y+ybPLlqFExeLkarC
	 3r2QYiOR/UBto46mbJFkxBKnE1UzeDMJUTXsgSNB363MOyxftBrBVY/7nslJZbaU7c
	 kbwLjFFbKDVESDn/OfvyHqui9dgqEtdx/E6rzLNQ=
Message-ID: <ac1d1bfd-5305-4292-8905-edd14ad028fa@arm.com>
Date: Thu, 19 Nov 2026 10:08:40 +0530
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
Subject: Re: [PATCH mm-new v2 5/5] mm: nommu: remove unused heap_stack_gap
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
 <20261117-unused-sym-mm-v2-5-2f845e94dd50@amd.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20261117-unused-sym-mm-v2-5-2f845e94dd50@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 17/11/26 12:46 pm, Shivank Garg wrote:
> heap_stack_gap has been unused since at least the start of git history,
> commit 1da177e4c3f4 ("Linux-2.6.12-rc2").
> 
> Link: https://lore.kernel.org/linux-mm/20140430083620.GA4711@dhcp22.suse.cz/
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---

Reviewed-by: Dev Jain <dev.jain@arm.com>


>  mm/nommu.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/nommu.c b/mm/nommu.c
> index df99495c8902..a971c12f2732 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -43,7 +43,6 @@
>  #include "internal.h"
>  
>  unsigned long highest_memmap_pfn;
> -int heap_stack_gap = 0;
>  
>  atomic_long_t mmap_pages_allocated;
>  
> 

