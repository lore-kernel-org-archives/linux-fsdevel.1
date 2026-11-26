Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795724831;
	b=w78ZHzwIp3Gdo5Fk+Z2Fdb5jztXGLG2m7ssnnOkmlw8dDO9hqxj5f7gvsn+rJxmcCGMr
	 WgUjeuGmcc5qCR4RN7QMB2NdlKdhNZWdUjLmeBqNs2KscJR8cCOuNKSBVQEJhT60qtn4Z
	 ar6+MB7ZUE1OKCv+4vkx3sLUv/DDl0WASZxwPV8xs/Q+b+8ps3ChfVcWUSS/I/FO+09Ng
	 6t28d59+kkvnSfAILj+12LbbhoNZY4P1r9uEDdEzPDY4+RqxEhDrTMLglNUrH+YjehyLB
	 NTT2IBpPhYEZttyHE+OPmN35YK7l+6dWSI+P4O7zcg0P9Qnbz4yfes/9vPkSfNQgZUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795724831;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=mPIUXK+tyYI9lmjrCipc96I5GvVnkf1nt74AkZOGWME=;
	b=CDBXBM9mK/R178ZT8nxN5DnnXe8wjAWuXgRGltxdLiWbPFP2G4AvPr17sNmE9Wp5JXXZ
	 3Alx0vBFPJGp1ZOewBENifB41yKHKtfJXV6wdJoub3zso5s+aTKmuehSV3gMrVyV9ex1J
	 +Mi2g/M3nBWw9bZNDPu3/iCrbK6bi3SPdvQP49GOKagZ5eywc56WlQ2keHYTbm/ZrotII
	 do/i2Ot343L/PKq5zH0R2i2BFdqGTQmYj1gEwmaFJdYLPmzNpMMwQH+R8cOJHJos4AJYl
	 ui/rTEWpoAsvVYa5M/szNoiQHfnbjzAeTnggfg3GzHoRm1xpmBa4h2odS+W4qYDGX6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AN5S4dmm;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AD3606A31E
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 20:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53AD3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AN5S4dmm
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4a42b34e930so6501325f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 12:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795724830; x=1796329630; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mPIUXK+tyYI9lmjrCipc96I5GvVnkf1nt74AkZOGWME=;
        b=AN5S4dmmjEfr0x23doiCAhsgP9Rct0N1mVc31Eg7GWkoAhc8qZJXgJIGhwutKS4mN+
         zZxOwkvtjkS+UDTRYWpG38iWwNR3HTL+w5bMAS3q+Sm5xle86yKQtBTFIv96lEb3X/R4
         cJhUUzBzaTRYcFNx5A/CmCBUnFxHr7zVxdbCRiRTNSOPM6bTiYWk+H8s0DprAJ662SmO
         mFQFsD6FF8mtDrquIe+lxxN7+2nmyt8tlSWemAWNSDWjyZb7N2jWrrp+VijPIxiQnxNQ
         5aZ3ufDu56x7egcJO7RK/Kr3O8hviZzT/7mp2K8dTR6IEDuDObu/5Vzy8WJBEMZMrzRq
         sJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795724830; x=1796329630;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mPIUXK+tyYI9lmjrCipc96I5GvVnkf1nt74AkZOGWME=;
        b=1J+qFog4xRPH/VEQW0wvPldOL4gPFRdQ6iyjtQwpgjkonsr3VS5hGb23w7uX3UY1vd
         QBZ/t6nL1KqY4bukSD6/WY9x7HPUBiqNX1YB1EPDecHEue9XIN3e2MGy1gQbQDjUhsT2
         lTWxy3BbSZIBunqsH4/TbwFLMaWcX7g/RejycOxyKbJxnpurskbnX7MZP1MV9sXwP3vz
         Fu/Czr9JSCBP3XKugBtRoOiUNoDXcg931+gDY0TpureWQSBwSFikMHyjr57cY15DZZSV
         8VylGWS2zdrK9/c5A1CXvluS1HtIel5wmC9Gw/IYbCW/0xIuqMuMtxKrf+2C7cFWmTWr
         IM1g==
X-Forwarded-Encrypted: i=1; AL+hErHmbRo+ovRvA+4BOh1xsgf9rcfj5A6CNiMVNMoLKv7UpqNZ+VhMsn68WFwxNlfdpig8S1NKaeXSBGXJkhIU@vger.kernel.org
X-Gm-Message-State: APuU4Z8YYd1ujoccKjSR/B1m9b0HQyOyAHd0kFu8smhuk6p0kK7n8oaq
	ZXNDMndiPlELf6Nmco6KgzctgeU/pTYMEIkm8OclsQ3adfFZBd6RaUk9
X-Gm-Gg: AZFdTZeJNyPTG7cou4hcI58esI460XPWEjGcdMO922RCDEGV79D6c+EGjdu6kw57cC5
	2Gu3Dg6Z3En2AXHeN6RttWu+KoX3h0wVNDJJsLzYW4f+XvKj+pnJRvRNM2Rf+ozcRjfV3P2AqvP
	AQbZm5dzZIQD2Dp0nt4XEVbczve/y5/G5+7awpl44VoxpeUPNaOmQ2IrlvsyhOkVyVW2Bizl3+M
	p2/gYy221u5ap/14Ranw2tpr0q0oAFLEoGByQK3XL11jdsixlFNC1ZnaQyfOMrlJL0niH+UYLe/
	OcO9ZLN/Jr2HaWuqZEVC9nsJtpZzJydwNgODcMV9DcOfbEOqtp2XIQ/kQN0VllmW+QqTCEGOVyw
	GU8nTAvvlUv6Cq6zmVkukbuuRU+1XTIlVOOTWtZmSNxjODNOvBDdjrtdkpXELYK529VRjYthtB7
	nQ1r4EcBNN4VPiQksQEAC8miWUWaO/nqnW59zi89Bece8B6WVFOpsGDuWR4DFXBGjLEUpO/Ec2T
	zkES2cKa/7ROvUmE3ThaBh06nV4ZvItTpJductx1kNgBQxnVhsGVJvbxpZV4HeYt2+SmcQjHVBK
	q58wli5a26+Xsx42O4r8Fwzz
X-Received: by 2002:a05:6000:310c:b0:487:27f9:844 with SMTP id ffacd0b85a97d-4abb627ed47mr53600472f8f.57.1795724829363;
        Thu, 26 Nov 2026 12:27:09 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b10b1ebsm44007075f8f.33.2026.11.26.12.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 12:27:08 -0800 (PST)
Message-ID: <03ab430b-83a2-48c5-883a-70b20c4bcffe@gmail.com>
Date: Thu, 26 Nov 2026 21:27:07 +0100
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
Subject: Re: [PATCH 2/4] mm/memory: don't allocate in finish_fault() with the
 folio locked
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Zach O'Keefe <zokeefe@google.com>, Lorenzo Stoakes <ljs@kernel.org>,
 Dev Jain <dev.jain@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Hugh Dickins <hughd@google.com>, Kiryl Shutsemau <kas@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Rik van Riel <riel@surriel.com>,
 Song Liu <songliubraving@fb.com>
Cc: "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Michal Hocko <mhocko@suse.com>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
References: <20261125100058.15200-1-azpijr@gmail.com>
 <20261125100058.15200-3-azpijr@gmail.com>
 <9d506473-4844-4ed2-ac58-e72cd72b5c9e@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <9d506473-4844-4ed2-ac58-e72cd72b5c9e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/26 5:29 PM, David Hildenbrand (Arm) wrote:
> On 11/25/26 10:59, Jose A. Perez de Azpillaga wrote:
>> __do_fault() preallocates a page table only when the PMD is empty, so
>> that finish_fault() does not have to allocate one with the folio locked.
>>
>> Since retract_page_tables() no longer takes the mmap and VMA locks, the
>> page table can be removed while the fault waits in ->fault().
>> finish_fault() then finds an empty PMD without a preallocated table, and
>> calls pte_alloc() with the folio locked. On ppc64 with the hash MMU,
>> do_set_pmd() allocates the page table to deposit in the same case.
>>
>> Allocating with __GFP_FS while holding a folio lock can deadlock in
>> reclaim, for example the memcg reclaim deadlock on cgroup v1 described
>> in commit 63f3655f9501 ("mm, memcg: fix reclaim deadlock with
>> writeback").
>>
>> Return VM_FAULT_NOPAGE instead, as we already do when
>> pte_offset_map_lock() fails. The retried fault preallocates the page
>> table before locking the folio.
>>
>> Fixes: 1d65b771bc08 ("mm/khugepaged: retract_page_tables() without mmap or vma lock")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
>> ---
>>  mm/memory.c | 13 +++++++++----
>>  1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 11cc4039b853..b7e53d7cf6e5 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -5986,16 +5986,21 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>>  	}
>>  
>>  	if (pmd_none(*vmf->pmd)) {
>> +		/*
>> +		 * The page table was removed after __do_fault() found it, so
>> +		 * nothing was preallocated. Allocating with the folio locked
>> +		 * can deadlock in reclaim, so retry the fault instead.
>> +		 */
>> +		if (!vmf->prealloc_pte)
>> +			return VM_FAULT_NOPAGE;
> 
> Hm, but do_set_pmd() really only needs one for ppc64. Assuming we allocate it as
> NOFS in there for that corner cases ...
> 

yes, I'll allocate it with NOFS in do_set_pmd() instead of 3/4.

>> +
>>  		if (!needs_fallback && folio_test_pmd_mappable(folio)) {
>>  			ret = do_set_pmd(vmf, folio, page, /* may_alloc= */ true);
>>  			if (ret != VM_FAULT_FALLBACK)
>>  				return ret;
>>  		}
>>  
>> -		if (vmf->prealloc_pte)
>> -			pmd_install(vma->vm_mm, vmf->pmd, &vmf->prealloc_pte);
>> -		else if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd)))
>> -			return VM_FAULT_OOM;
> Could we instead fallback here, after we tried to install the PMD ?
> 

sure, I'll return VM_FAULT_NOPAGE there when nothing was preallocated :)

-- 
cheers,
jose a. p-a
