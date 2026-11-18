Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795021544;
	b=V4XFnvkJWj01nVv7hPWXsMGkzmhGnGF9LbhZ+VB4zYVMUq32oTdlBe0/EXPX+lyyIlHH
	 RnSxAhVuyv7tz+9v5dw0/M8aZjKP2X+HTxxCd/HiwpmazeatD7Iu/BtMQIDs08/RF8scT
	 5tZIlNA/1o2ofJaRxpi1DtvVuVEyh47tvp1KvaxpPJSHSujklScKVCNQzMOgBxG9Mzshy
	 AMp7KgYhyOjwZUHfLM6RhvkNW8rOjvQScC/PlwxiFLGuKwE0eeW83g1XTUgB3jLQXbExz
	 OBncaYOXHAr3967N18QG6r6CCt0yypy7QX8ZH07nls5bcMyY93Wqk23L7+xuXjy6itg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021544;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=yQd7Q59/uJ09RDtnXaaw3syKdDGR5e1uWMGq/9Jn6+U=;
	b=J+6KAX+2q+ScrZTfPsrraWzaFPj02umL1pY95/lSJI3WpdTxy1L5UYcXr3Jfr3LBVhiz
	 7y6hT4i0VnuyEvBXN6eDZWE0lbdO2UKQORUEMKMmq5Qc6hDburEwdZHODZVVMF8ipex7W
	 pmZeSz3lbQuzZCCELKBXaJljPZgxCB6G+uTkBGg93IMWq3Fflm5d5ttlaN5act6YKFlrB
	 1i5zsqX/2OXdFelcxC/TWoa0/zNJPncEau+7tpjQqH2VswfMIG9L8+4FQxYZddwjOFA8w
	 hD1hW3FGU1WIJYo93F4/KM1ZbhL8DqEf9CVujAobXdwPvQAqn1uOoEGgI8pT3ibWyWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=njD0pyUP;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39BC606A31C;
	Wed, 18 Nov 2026 17:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A39BC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=njD0pyUP
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F6F01477;
	Wed, 18 Nov 2026 09:05:40 -0800 (PST)
Received: from [10.163.128.4] (unknown [10.163.128.4])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3386E3F632;
	Wed, 18 Nov 2026 09:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795021543; bh=lm8fR4VGPjinFRA2VTQV8MBU1YPZJR5e08gMeF/5ntA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=njD0pyUP0lvvOgYBBd1phTCojAQtgwJJe0bSG2aHoDsu5LGv3u9LxG2/95Se29cZ2
	 ZxB+zeWoPWlqia5030YhGIOEFbjM8ukjEvdI2mVqqP0SPIXi6mT+zZPZsvZUgBbnFn
	 SumFgAPdZeQqht5/9YBht7kT3VM+GxwiZQRpz7iQ=
Message-ID: <f3219880-c944-473e-82cc-bd6b4196badf@arm.com>
Date: Wed, 18 Nov 2026 22:35:32 +0530
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
Subject: Re: [PATCH mm-new v2 0/5] mm: remove unused functions
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
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20261117-unused-sym-mm-v2-0-2f845e94dd50@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 17/11/26 12:46 pm, Shivank Garg wrote:
> This series removes five functions and one variable in mm that have no
> users left anywhere in the tree. I found them with the kunused scripts
> [1], which I wrote with LLM's help. The v1 cover letter [2] has more
> details on the scripts and how LLM was used.
> 
> Changes in v2:
> - Split v1 [2] up by MM tree, as David suggested. These five patches
>   are based on mm-new. 
> - No changes to the patches themselves.
> 
> [1] https://github.com/AMDESE/linux-mm/tree/shivank/kunused
> [2] https://lore.kernel.org/r/20261026-unused-sym-v1-0-82ca2dceabe1@amd.com
> 
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---

Okay I just recalled that there have been numerous cases where people ran
scripts / compiler with flags etc and sent patches to remove unused functions,
but maintainers rejected them citing they are there for a future use. Here
are some of those instances:

https://lore.kernel.org/all/20240907021506.4018676-1-Liam.Howlett@oracle.com/
https://lore.kernel.org/linux-mm/20100211052247.GA15392@localhost/

So I think the commit messages need to do more, they need to prove that the
unused function was a genuine oversight.



> Shivank Garg (5):
>       mm: remove unused helpers from pagemap.h
>       mm/swapops: remove unused make_guard_swp_entry()
>       mm/swap: remove unused folio_to_swp_tb()
>       mm/zsmalloc: remove unused zpdesc_lock()
>       mm: nommu: remove unused heap_stack_gap
> 
>  include/linux/pagemap.h | 11 -----------
>  include/linux/swapops.h |  5 -----
>  mm/nommu.c              |  1 -
>  mm/swap_table.h         |  5 -----
>  mm/zpdesc.h             |  5 -----
>  5 files changed, 27 deletions(-)
> ---
> base-commit: 67f3b04b277373438f17300e056306adbd9edf7b
> change-id: 20261109-unused-sym-mm-8fa76462573e
> 
> Best regards,

