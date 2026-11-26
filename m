Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691833;
	b=TUXPAcd8dwuj4nKeXhEwq9VZuLDgm+whqtHPBd2RzIhurXG1lg80ulBLSqP9uFDHIigW
	 YWQi6xsUF1jtXgj8Q8XZGPdNEHbYnPQQg3LxzzPW5ykFZDYmNHun/7QqhmBrLg9aXZ6Az
	 NsUXFCTa6ZedYLFcoBfieV0ug8oncesD3dd0deEK8mbuLC1mXL/hNxzqySyFfurAf6XlW
	 n34IywEUFRCIL3vXMpwSjoC31M0ic7aNz1IlU5fHE/4GphVth3RiV5nKALA5zDwMFlO2V
	 MsS4DLN8oaHjPz5CD3bhSELNLAa7R11b2c6tUg+fX+pegg5J03kE8UWHrVDaalhBvYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691833;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=yvpFVPS5nHjAd98a7zI89o00MRQ9zkYpBpD7SEFfFdo=;
	b=Qupk+GPP31nEKR3g1ZQ+93JgQkzyASRv0hXORxqMF8ZQAetS4QTn4Zud51UYOJSQD2s/
	 jpP19+DVAHZjTlb5dIZdJEFNEJR/s1JS1NOpyy7GNyhTZRa9avMY4OMqY3aJf06KAevHs
	 wujP+a5mySzmTdwqaFTfgopP6GHO8a3yjLRGGi6JnqBwvZbH0HydXbew94jPmLE96ghQn
	 ad4M66VLetZHGcbyLm++CuiAypiB7xiAwJIPtdRSzXY+C/FLn0DjPo/ME98AnZXE8UuOV
	 Y2yeDOg3N4CXrehdjdPmCU4L/v+VgULN50WRACYu/ileP/GoCCDFDE5Hp4UlIbmwOjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC043606A329;
	Thu, 26 Nov 2026 11:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC043606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e71d7726e98a11f19a56ed5b684f684d-20261126
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_MAILER_MTBG, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS
	HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED
	IP_UNFAMILIAR, SRC_UNFAMILIAR, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD_SPF, CIE_UNKNOWN, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:7452ed6e-7e81-4150-93e8-1cd97ed03b34,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:7452ed6e-7e81-4150-93e8-1cd97ed03b34,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:ecac7c148939b6f01b1df28134bf306d,BulkI
	D:261126094937PW693UOR,BulkQuantity:4,SF:10|38|64|66|78|80|81|82|83|102|12
	7|136|153|841|865|898,TC:nil,Content:0|15|52|99,EDM:-3|-100,IP:-2,URL:0,Fi
	le:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,D
	KR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e71d7726e98a11f19a56ed5b684f684d-20261126
X-User: lihongfu@kylinos.cn
Received: from [192.168.43.7] [(114.246.238.190)] by mailgw.kylinos.cn
	(envelope-from <lihongfu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1496325343; Thu, 26 Nov 2026 19:17:01 +0800
Message-ID: <5dc5ea66-ba09-48d3-8c72-bcc5c141b6d9@kylinos.cn>
Date: Thu, 26 Nov 2026 19:16:54 +0800
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
Subject: Re: [PATCH 01/21] mm/hugetlb: charge the copy made at fork to the
 parent
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jinmeng Zhou <jinmengzhou22@gmail.com>, Hongfu Li <lihongfu@kylinos.cn>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Hugh Dickins <hughd@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Dave Airlie
 <airlied@redhat.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Mike Rapoport <rppt@kernel.org>,
 Mel Gorman <mel@csn.ul.ie>, Dave McCracken <dave.mccracken@oracle.com>,
 Andy Whitcroft <apw@shadowen.org>, Adam Litke <agl@us.ibm.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Rik van Riel <riel@surriel.com>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>,
 Lance Yang <lance.yang@linux.dev>, James Houghton <jthoughton@google.com>,
 Yang Shi <shy828301@gmail.com>, Suren Baghdasaryan <surenb@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Pedro Falcato <pfalcato@suse.de>,
 Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Matthew Brost <matthew.brost@intel.com>, Byungchul Park <byungchul@sk.com>,
 Alistair Popple <apopple@nvidia.com>, Wanpeng Li
 <liwanp@linux.vnet.ibm.com>, Andi Kleen <ak@linux.intel.com>,
 Kenneth W Chen <kenneth.w.chen@intel.com>, Hugh Dickins <hugh@veritas.com>,
 Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>,
 Joern Engel <joern@logfs.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Michal Hocko <mhocko@suse.cz>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>,
 Sasha Levin <sasha.levin@oracle.com>, Guillaume Morin
 <guillaume@morinfr.org>, Wanpeng Li <liwp.linux@gmail.com>
Cc: linux-mm@kvack.org, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@osdl.org>, linux-doc@vger.kernel.org,
 Chris Mason <mason@kernel.org>, Hongfu Li <hongfu.li@linux.dev>
References: <20261125-hugetlb_fixes_2-v1-0-db27fd2f71a8@kernel.org>
 <20261125-hugetlb_fixes_2-v1-1-db27fd2f71a8@kernel.org>
From: Hongfu Li <lihongfu@kylinos.cn>
In-Reply-To: <20261125-hugetlb_fixes_2-v1-1-db27fd2f71a8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 11/26/26 06:32, David Hildenbrand (Arm) 写道:
> When copying page tables during fork(), the child is not yet assigned to
> the right memcg. When copying possibly pinned anon hugetlb folios, we
> must charge them to the parent's memcg, otherwise we can end up
> allocating more hugetlb folios than allowed.
>
> Let's fix it by charging the copy to the parent's mm, like we do when
> copying small folios in copy_present_page(), introducing a new helper
> function alloc_hugetlb_folio_for_fork().
>
> This is a hotfix for v7.4.
>
> Fixes: c2deb1356d82 ("mm/hugetlb: charge folios to the target mm's memcg")
> Reported-by: Chris Mason <mason@kernel.org>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Tested-by: Hongfu Li <lihongfu@kylinos.cn>
Reviewed-by: Hongfu Li <lihongfu@kylinos.cn>

> ---
>   mm/hugetlb.c | 26 ++++++++++++++++++++++----
>   1 file changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index d0e66fb306221..f46c85fc0cd0b 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3103,8 +3103,9 @@ typedef enum {
>    * allocation).  New call sites should (probably) never set it to true!!
>    * When it's set, the allocation will bypass all vma level reservations.
>    */
> -struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
> -				    unsigned long addr, bool cow_from_owner)
> +static struct folio *__alloc_hugetlb_folio(struct vm_area_struct *vma,
> +		unsigned long addr, bool cow_from_owner,
> +		struct mm_struct *memcg_mm)
>   {
>   	struct hugepage_subpool *spool = subpool_vma(vma);
>   	struct hstate *h = hstate_vma(vma);
> @@ -3187,7 +3188,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>   		.nodemask = nodemask,
>   	};
>   
> -	folio = hugetlb_alloc_folio(h, &mpoli, vma->vm_mm, alloc_flags);
> +	folio = hugetlb_alloc_folio(h, &mpoli, memcg_mm, alloc_flags);
>   
>   	mpol_cond_put(mpol);
>   
> @@ -3249,6 +3250,23 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>   	return ERR_PTR(ret);
>   }
>   
> +struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
> +		unsigned long addr, bool cow_from_owner)
> +{
> +	return __alloc_hugetlb_folio(vma, addr, cow_from_owner, vma->vm_mm);
> +}
> +
> +/*
> + * Allocate a folio for a copy in the child VMA during fork(), charged to the
> + * parent's mm: the child is not in its memory cgroup yet.
> + */
> +static struct folio *alloc_hugetlb_folio_for_fork(struct vm_area_struct *dst_vma,
> +		unsigned long addr, struct mm_struct *src_mm)
> +{
> +	return __alloc_hugetlb_folio(dst_vma, addr, /* cow_from_owner = */ false,
> +				     src_mm);
> +}
> +
>   static __init void *alloc_bootmem(struct hstate *h, int nid, bool node_exact)
>   {
>   	if (hugetlb_early_cma(h))
> @@ -5110,7 +5128,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>   				spin_unlock(src_ptl);
>   				spin_unlock(dst_ptl);
>   				/* Do not use reserve as it's private owned */
> -				new_folio = alloc_hugetlb_folio(dst_vma, addr, false);
> +				new_folio = alloc_hugetlb_folio_for_fork(dst_vma, addr, src);
>   				if (IS_ERR(new_folio)) {
>   					folio_put(pte_folio);
>   					ret = PTR_ERR(new_folio);
>
