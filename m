Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2041862;
	Sun, 19 Jul 2026 03:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784433352; cv=none; b=bs29E9+M5eEVSvmBHjw6LZ8RHJvwPCVs4JoWdnrJRvW9eRt4BifK9KHP/6/7FD+dLXnjZz12AHyM6Ncu3x5DbjIIcXN9dEx86CV6k5Ofrx9DUoo4nyv5RxCTcdSn3/pUGs+hZQ43CMVv5ij1aZM/VPZZkk6Ti7qNh2uwOkoaLNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784433352; c=relaxed/simple;
	bh=MIpBUs8FuIBlkYklbhlJScGg5JWiDjM2uf9MCZBJmUo=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=B/jmCfVAsbwdddlKtQkty6cSTG1dBUW5hWwLpK2CskxRfAFBB2xGZfKgF2EiPG1eGvboiJAZJF7bHvWJsQ4iJJcLfhsIs4P6N+nG/H6/HfOl9pv7apQoxyC6CTYkarN9SlMswvJsBdu3hfxgEVww55G4wtx6f+2i5knus/bp9iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4h2qYw2TQjz8XrrJ;
	Sun, 19 Jul 2026 11:55:48 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 66J3tf7v034198;
	Sun, 19 Jul 2026 11:55:41 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 19 Jul 2026 11:55:42 +0800 (CST)
X-Zmail-TransId: 2afc6a5c4abe5f7-4ef27
X-Mailer: Zmail v1.0
Message-ID: <202607191155425057lNrNOYTi44E_jmidmtkn@zte.com.cn>
In-Reply-To: <20260717-b4-scalable-cow-virt-pgoff-v1-1-cf24910ef094@kernel.org>
References: 20260717-b4-scalable-cow-virt-pgoff-v1-0-cf24910ef094@kernel.org,20260717-b4-scalable-cow-virt-pgoff-v1-1-cf24910ef094@kernel.org
Date: Sun, 19 Jul 2026 11:55:42 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <ljs@kernel.org>, <akpm@linux-foundation.org>, <david@kernel.org>
Cc: <david@kernel.org>, <liam@infradead.org>, <vbabka@kernel.org>,
        <rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>,
        <jannh@google.com>, <pfalcato@suse.de>, <willy@infradead.org>,
        <jack@suse.cz>, <linmiaohe@huawei.com>, <nao.horiguchi@gmail.com>,
        <riel@surriel.com>, <harry@kernel.org>, <lance.yang@linux.dev>,
        <kees@kernel.org>, <ziy@nvidia.com>, <baolin.wang@linux.alibaba.com>,
        <npache@redhat.com>, <ryan.roberts@arm.com>, <dev.jain@arm.com>,
        <baohua@kernel.org>, <usama.arif@linux.dev>, <matthew.brost@intel.com>,
        <joshua.hahnjy@gmail.com>, <rakie.kim@sk.com>, <byungchul@sk.com>,
        <gourry@gourry.net>, <ying.huang@linux.alibaba.com>,
        <apopple@nvidia.com>, <peterx@redhat.com>, <chengming.zhou@linux.dev>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>, <ljs@kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAwMS8xNV0gbW0vdm1hOiBpbnRyb2R1Y2UgVk1BIHZpcnR1YWwgcGFnZSBvZmZzZXQgZmllbGQgYW5kIGFkZCBoZWxwZXJz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 66J3tf7v034198
X-TLS: YES
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sun, 19 Jul 2026 11:55:48 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A5C4AC4.001/4h2qYw2TQjz8XrrJ

> This patch establishes fields within the vm_area_struct type to store the
> virtual page offset of VMAs.
> 
> The virtual page offset of a VMA is equal to vma->vm_start >> PAGE_SHIFT if
> they are unfaulted or were not remapped, otherwise it is equal to this
> value at the point of first fault.
> 
> Currently, anonymous folios belonging to CoW'd MAP_PRIVATE-mapped
> file-backed VMAs are tracked by their file offset. By adding virtual offset
> as a property of VMAs, we can now track them by their virtual page offset
> instead.
> 
> By tracking this, we provide the means by which to eliminate this
> inconsistency, and more importantly lay the foundations for future work for
> the scalable CoW anonymous rmap rework.
> 
> This patch simply adds the fields and some simple helpers. Subsequent
> patches will update mm code to make use of these fields correctly.
> 
> The fields chosen are packed in the VMA such that, for 64-bit kernel
> builds, no additional space is taken up.

It is not necessarily true that no additional memory will be consumed, as it
depends on whether the baseline kernel has CONFIG_PER_VMA_LOCK enabled.
Moreover, in the future evolution of mm, maintaining this benefit would
require that the layout of struct vm_area_struct before __vm_virt_pgoff_lo
remains unchanged, which seems impractical.

My personal suggestion is: maybe we could simply add an unsigned long field,
say vm_virt_pgoff, without worrying about the increased memory footprint for
now. Additionally, it would be helpful to add some comments clarifying the
difference between this new field and the existing vm_pgoff, to aid understanding.

Thanks,
Xu Xin

> 
> The first field is present on cacheline 0 containing key VMA fields, and
> the second on cacheline 3, which contains file-backed reverse mapping
> fields.
> 
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  include/linux/mm.h              | 59 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/mm_types.h        |  4 +++
>  mm/vma.h                        | 14 ++++++++++
>  mm/vma_init.c                   |  1 +
>  tools/testing/vma/include/dup.h | 26 ++++++++++++++++++
>  5 files changed, 104 insertions(+)
> 
> +static inline pgoff_t vma_last_virt_pgoff(const struct vm_area_struct *vma)
> +{
> +	return vma_end_virt_pgoff(vma) - 1;
> +}
> +
>  static inline unsigned long vma_desc_size(const struct vm_area_desc *desc)
>  {
>  	return desc->end - desc->start;
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 939b5ea8c9e0..2710628059b1 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -967,6 +967,7 @@ struct vm_area_struct {
>  	 */
>  	unsigned int vm_lock_seq;
>  #endif
> +	unsigned int __vm_virt_pgoff_lo; /* Low 32-bits of virtual pgoff. */
>  	/*
>  	 * A file's MAP_PRIVATE vma can be in both i_mmap tree and anon_vma
>  	 * list, after a COW of one of the file pages.	A MAP_SHARED vma
> @@ -1041,6 +1042,9 @@ struct vm_area_struct {
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  	struct lockdep_map vmlock_dep_map;
>  #endif
> +#endif
> +#ifdef CONFIG_64BIT
> +	unsigned int __vm_virt_pgoff_hi;  /* High 32-bits of virtual pgoff. */
>  #endif
>
