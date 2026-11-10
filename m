Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327794;
	b=KwSEfbqrsPFp2n1FpxdgsvtE4wqdB2Bmt7hcKOaqIBcMEjRSMYYFo5U4E8nnWbfN4RXG
	 a+ViJb8wbaQMcgBmjxEUNigWepmduAf9vyeo2w347SyOij0+TrNrB+DhUR03N9YXtP72n
	 pTKJODlYh3RZGQCQK6CHTiuk7tc13GQYjoGKXbGzlo/5fGqbPc+CiglpvxeVas+hQr1jy
	 hRrwwT8+57hTL2YkEcn5tLcEQOzcgJkr2zyd8pDZiEWR1rCE2AgbGJT4+0wqb1o/02hl8
	 PmNJi/LHs0wXBRW/XGP+yK7i5Dh74rYNN5Yo2xes3nD3nMQZho2IGAQ0NYAs8FhegHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327794;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=9YuRkRGnxp0vWQ1dHMpnKuM8tkA2uFdXTQzJ8jzW5DI=;
	b=bD0mTh1eEMYFAkZmDZePujMzCQG8+B9ZA2w1uQvPtP/TU5fQXHzExijEjzBKszA5Bcaq
	 Fazk9jI3KR99UgAQVLV/A1vqDquMlpLBQHUTyB66mekOdsUocnWl5TbbfOCklyXA1cxeV
	 ZQ9+4R0eOu1cyMzBXkJ74nRWr1ma06KjFLUWGjAEn0DVTC3j9s0lNBTSrdReQz94Tu32N
	 3nXKEmrDP2nYjh1HyqbN33HeTiebCslP/kpbx3u560qzZ2uDEim4eFyjBFI1JU8S247jG
	 Ib5pn55TXbwv/q7imRtqNoqkFa2vJs85xz090BU2f1S1hL+bDGuo7imipqT0Rqopsxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=debian.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EF2606A33D
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 16:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4EF2606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b300713befso18808507b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 08:23:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794327793; x=1794932593;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9YuRkRGnxp0vWQ1dHMpnKuM8tkA2uFdXTQzJ8jzW5DI=;
        b=y/1z5lvgihE4zV3GYmNRT7bc8myD1oAlUE8le5ebbkyd2SSmqP5VT0WsudBHyjEanv
         RZiT//IylmbTfWOyO4FVVYqcX+nzqYIlTUrToD3AmVSqkgjtXpoL5Fe/9dljLoPxS8/c
         5aL1AFsHdwJAeUqUH0aFh0o3/1OO99WRH+mnKk2KRl/KVEjYM8jNONooa1l8nMsxv0iB
         ZxK+wb0W3/F8qrCgG74OLGpLWD9LkZ4PR/UE+pefMzOxWfDUG8dd5FNywNnqz3uqMjiz
         e3tmQSaNTcNoMLV9P0+reiAJksCnhTzkvv46pQ1oFL7T/SoxWeXiWfS9FqneBKFSwgHs
         HscQ==
X-Forwarded-Encrypted: i=1; AL+hErGiukdC53qaupAvIwkxCfND7bHY+h8v7d9UEYjmSrz1aDZjC1qbdHx+1oXI7HyHFbjtaVt3ZGffc2sTufm4@vger.kernel.org
X-Gm-Message-State: APuU4Z9KYTbsU++C3krdb8h5wjoM9pXvBKt3jjN0LRLz+gwqa0SD8YMo
	hxTtnjFcsg0NNMDZHHlbWLYiX00tcWBmtZt5LreRqIUG+MRgvrEixbiM
X-Gm-Gg: AYBFou38tk+s/XiNasb5JxlYzNm9PBBjNG4EEN9bTgpXduygFicB/R+zWx5fzFPodel
	Or2Lk7TKGZQoZT6Coq8tQ6o8ckpdIg3cMWwnnuXz4vt9A8mzHCIChMGrMfRer/c8wzzX/NxGA8m
	e28qF2qqDbwmV03VfxYNMsYbifJYfDF9RDdEz2gSVZnnYkVlgU4F7ePXfeyGvzQhvbaB4LDc9kn
	V0N91FefRkVD0UrBrrDRUHPvI4K8p6X6H+Fyi9AI4NfC8ig9rPVKUpe06UPAxkr6PG07M727bab
	NTuab0qbNaxEdUSuU6haQ5yaItYngfaoQDws3Mp1IuG2jDood5jRLnlSDJPBU8QzDc0QcscnRHn
	OS+RE8EQcGh72BDZP93MeqKcd8Rzns3a8LLvGGNp0hzPeYW4fLSSFDf/9O3f8VhStyu3P7PX6Gp
	M7PmTimGN0r76hvFuhA2or7ImeJ96jXOU5cog0fCx2NmxK5/Vi5xi0MGvbWDepWFmCahrRC6IBn
	zbTm+60efdJEmlSryspVSYsxiyiIe/zNR8b3daU6mHZfrsfpAJ6SG+QeswuT4ZrqQV85LdD0zO8
	OB8fp0XVSeU8LU7RX50=
X-Received: by 2002:a05:690c:6607:b0:8b1:901:b9ee with SMTP id 00721157ae682-8b392a58fdcmr20600847b3.13.1794327792882;
        Tue, 10 Nov 2026 08:23:12 -0800 (PST)
Received: from gmail.com ([2a03:2880:24ff:6::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b39324bbf5sm22932117b3.1.2026.11.10.08.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:23:12 -0800 (PST)
Date: Tue, 10 Nov 2026 08:23:11 -0800
From: Breno Leitao <leitao@debian.org>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Lorenzo Stoakes <ljs@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, stable@vger.kernel.org, 
	Sashiko AI review <sashiko-bot@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Muhammad Usama Anjum <usama.anjum@arm.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/6] fs/proc/task_mmu: fix make_uffd_wp_huge_pte()
 prot-update race
Message-ID: <avNEgmvYdoukt6MS@gmail.com>
References: <20260529172331.356655-1-kas@kernel.org>
 <20260529172331.356655-2-kas@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529172331.356655-2-kas@kernel.org>

Hello Kiryl,

On Fri, May 29, 2026 at 06:23:25PM +0100, Kiryl Shutsemau (Meta) wrote:
> The non-hugetlb sibling make_uffd_wp_pte() does this correctly via
> ptep_modify_prot_start() / ptep_modify_prot_commit(). Mirror that
> pattern for the present-PTE branch. The migration case stays as-is --
> migration entries are non-present, so there's no hardware update to
> race against.

I am  seeing this on next-20261109 (arm64, PAGE_TABLE_CHECK) while the
pagemap_ioctl kselftest runs next to a workload that migrates pages:

    WARNING: mm/page_table_check.c:206 at __page_table_check_ptes_set+0x168/0x178, CPU#21: pagemap_ioctl/894691
    Call trace:
     __page_table_check_ptes_set+0x168/0x178 (P)
     __set_ptes_anysz+0x50/0x240
     make_uffd_wp_pte+0x104/0x1c8
     pagemap_scan_pmd_entry+0x1b98/0x1df8
     walk_pgd_range+0x7b4/0xd00
     __walk_page_range+0x108/0x510
     walk_page_range_mm_unsafe+0x150/0x3e8
     do_pagemap_cmd+0x418/0x7d0
     __arm64_sys_ioctl+0xc08/0x1338

given you've touched this recently, I am wondering if you've seen it.

--breno
