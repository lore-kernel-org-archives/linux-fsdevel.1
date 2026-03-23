Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8AF2F3621
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 18:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774291417; cv=pass; b=s2yCxxrI6KDY7gQX5R/ExpBI+vJlDel+j0RNvV66GGXkguWem915jV4tsTwbkqjUYahOpMawS69n4P0ZceImM9CB3NCX+7feQDvLHGbQbYsxbdmcbd0DmIM4WXz0JsGjlMgolZR+ge8LJpFrYiseLpMPef3khgN4Pon9jxoxt1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774291417; c=relaxed/simple;
	bh=8iR09lTQ4Edfh1UQkmolcFNIjMuLzSLKVF5JEj/9nwQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDsUcV+gC9uzigz5SCp5haT1Fq4HNxvkqoubxdRskctKo1LwUHgUQt5p/94Qx8x0ZcJZHSp73PUvQmOxR70778nLcSpwCJkxfcapl/VfjmfRdDNHZC4er1hTWwhr7HAotNvXZhfBjXEJcMOH5Ji7kJ2x6BD3FqwKsdsL4xr6a8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BFE/MqnH; arc=pass smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BFE/MqnH"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-56cc6fe8815so1895958e0c.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 11:43:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774291413; cv=none;
        d=google.com; s=arc-20240605;
        b=gXb/gimThiBBF1wYIy9O3BEArqXvLSMB6bgpKBThs3iv7sQWa8aRG9EFVQcAidkfg6
         KDOsymvYcKDzAkFKCv6VISU+Iv3K7ul6FMmYdyHC7kCRbjvdy9XOX1vSoCUIxHaR3Wtm
         JJEJHkyPfEzG3HifV2cqGCRmc+EH2KMJ8b65LU4QSywOu4c7D2KQ1MfeiIy55JAuNR1B
         sy+xDYF0mh605d6JfHSv8DpJnFYIvO30vB0K9KE9AGsOGiDEKgH4uzzeFLVV0rvkK1Ym
         spDA7FF74HGfH5rFo949ZjMXjMv7EZNCBQXMLJaIUP6FBrEm6IXQQp1nuAsaGbupgJ72
         hAnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=jJ1uKbr2A9AcnUKDcibCUYQIsuprIaoAVD4N5Jh2tIQ=;
        fh=uQBceHq4tWvyCgCpbNnLlGHWq26uoTOOJydGCkE3iUs=;
        b=M6pJbjz9MHrGTEG1i7HjTEn+woF5fjKQNTrT9BfsPOqeUiEVz7IlK/PJwzdw62ytaf
         1Hza8yNqb9rFVMeYg7fjB1dpFqQUzLtqPjcZgOg4zuR2YhWyC/LFYRcCOebGFafrNKQm
         B2WORnfvvyyNNIdF/XwzM8azQM7yaH9do/OOoR2TqpTvqlqaJnggoClR4u0kKeAKuKrO
         67oMjPjCvblCtx94odBrMEilO8ygZPKYCYQ5BUVfLvIYJdjaCh2Z/eedyj5ld72PpW4I
         h2XhE/3qv9nbW1sR36SMAi4JEHgKzPBaS/H+VVcaxFPFlg/qVYi2nnEpEhP7KjpAKmJK
         sujg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774291413; x=1774896213; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jJ1uKbr2A9AcnUKDcibCUYQIsuprIaoAVD4N5Jh2tIQ=;
        b=BFE/MqnHyJEb2bXhOAAC42up0lIIBMrfoEaUX8sgL/fCQ+OsWy9jEUrxjg9bcJmPoy
         fFh8bXLK5ID3vOGVhKEVc7GAF51PL1t9OKV3RWP9X5s8vEosDUsRJlD3uvkHsm8gQJq2
         yLHP8cRadcr3bXcEbThsxn/zkicUhrGIYaE6OdJ72LqX74hGBAw25CKruf7r9f4qNORH
         sjBANVlN4x99JT3IOFRxsfjxUDwhL7j/ysJO/DTg5EQHHCWh0q2njy/Tk2gB0a9h0PTK
         0OzzbUqBAFPI16UIfWf3j6fxHMwr0c5rjIDHEfL9KU6Ipera8Z+VPiV3ARshGnuLrl83
         3Plw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774291413; x=1774896213;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jJ1uKbr2A9AcnUKDcibCUYQIsuprIaoAVD4N5Jh2tIQ=;
        b=TZNH1dFRjTzctRkEKI1FPcbGag3OU1hcZmL/1Acfdc+xY4eMKxVwLOo58BmCgDgzs3
         CwEj01YIkvOzGElEV9SUjCAvgX0ZM+KR0ITRgaqbE8BiHwwsvUaqgDyxw09IMyPq7HK/
         sfFBDd79+acj56P1ULHMs5InD1ZYNNnu/Jt3RVYe6oXhcOblQe68LQVQ2E/9lC0U/2fE
         rpokJATnTAIYxk9V3pmcd9L7d8Q8HkJqwDVB1k/MUWpraUuxk9DAXjML2iKYvbJCJYF5
         Cn+Jx/Z0c6z7jsQEeiIo6G5AB8h1TDad1ou/a76EW1YKgMItKd1I/+pBXpxDJghd1fo3
         HAdg==
X-Forwarded-Encrypted: i=1; AJvYcCVnkeav1WCEHJR0q/mZh+egtHzOkZh1Bodt6z2mMMW9kvJG+Q4V7mcvmEpfXGbEERTE3jg98mXWgDyS/Rln@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8DqAU1pn284XTcBXWTojCgrgd9O8v+vQRG0C0lbS1sRMgjk38
	9Rq4CP77r/6j6cWfKYrL+cLfKLscTEENt6B0U9p6Tf8t5fMsM7gRkbY56xDnU8VRtahQM28wRSM
	F7mMYYGzGQjN5TBhllKsj4b+4uXD0t4XfwqUlcSB2
X-Gm-Gg: ATEYQzxCRo2f8ysI6UiNCbVtwQfbtGThqfoJItT3rNrpyfqW2GVic0j77hWBKb/ub6g
	Zfs19febKj15HmxNq5y4uN8FuJ+M4ki51JrvkgT/jxCgqcgTffqN3ioRbj3xyp1Xz2DVSIIu5CS
	d2uA5O0oy9kCqs5Ddl0zqXwCK3wNIbEfhhp6DWJQkmhYP/d736gkVxg/wVyAKocKY2XdUXwcl/v
	VwaNEvi28Ubv+J3q9946c4ZziwsZDcAHUO7mHuLfVRFyqtAdvxl8kIzAUTxsKn+cWpwgGw/2qCx
	NhYvXy/KxR7qFlCDf76BYxJffkirDpiwVTaQdNMXzq0C79OM7C/IlrHSsIUA+KQn8M9z9w==
X-Received: by 2002:a05:6122:3c54:b0:566:2711:d8ab with SMTP id
 71dfb90a1353d-56cde344094mr6273796e0c.6.1774291412097; Mon, 23 Mar 2026
 11:43:32 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Mar 2026 11:43:31 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Mar 2026 11:43:31 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260317141031.514-3-kalyazin@amazon.com>
References: <20260317141031.514-1-kalyazin@amazon.com> <20260317141031.514-3-kalyazin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 23 Mar 2026 11:43:31 -0700
X-Gm-Features: AQROBzAKG1Xpk4hVDWY3sqqSXNvIKws3qrAExzeSImrnNlU_ii0wYSbiIV_SQDw
Message-ID: <CAEvNRgEFBexkZCjOMFHJRQFHOpiUezD2jbfDVFrGhYXODdpMjg@mail.gmail.com>
Subject: Re: [PATCH v11 02/16] set_memory: add folio_{zap,restore}_direct_map helpers
To: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "kernel@xen0n.name" <kernel@xen0n.name>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>, 
	"maz@kernel.org" <maz@kernel.org>, "oupton@kernel.org" <oupton@kernel.org>, 
	"joey.gouly@arm.com" <joey.gouly@arm.com>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, 
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	"will@kernel.org" <will@kernel.org>, "seanjc@google.com" <seanjc@google.com>, "tglx@kernel.org" <tglx@kernel.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "luto@kernel.org" <luto@kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "willy@infradead.org" <willy@infradead.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "david@kernel.org" <david@kernel.org>, 
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, "vbabka@kernel.org" <vbabka@kernel.org>, 
	"rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com" <surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, 
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"andrii@kernel.org" <andrii@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "song@kernel.org" <song@kernel.org>, 
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"sdf@fomichev.me" <sdf@fomichev.me>, "haoluo@google.com" <haoluo@google.com>, 
	"jolsa@kernel.org" <jolsa@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "peterx@redhat.com" <peterx@redhat.com>, 
	"jannh@google.com" <jannh@google.com>, "pfalcato@suse.de" <pfalcato@suse.de>, 
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, "riel@surriel.com" <riel@surriel.com>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "jgross@suse.com" <jgross@suse.com>, 
	"yu-cheng.yu@intel.com" <yu-cheng.yu@intel.com>, "kas@kernel.org" <kas@kernel.org>, 
	"coxu@redhat.com" <coxu@redhat.com>, "kevin.brodsky@arm.com" <kevin.brodsky@arm.com>, 
	"yosry@kernel.org" <yosry@kernel.org>, "ajones@ventanamicro.com" <ajones@ventanamicro.com>, 
	"maobibo@loongson.cn" <maobibo@loongson.cn>, "tabba@google.com" <tabba@google.com>, 
	"prsampat@amd.com" <prsampat@amd.com>, "wu.fei9@sanechips.com.cn" <wu.fei9@sanechips.com.cn>, 
	"mlevitsk@redhat.com" <mlevitsk@redhat.com>, "jmattson@google.com" <jmattson@google.com>, 
	"jthoughton@google.com" <jthoughton@google.com>, "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, 
	"alex@ghiti.fr" <alex@ghiti.fr>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, 
	"borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>, 
	"dev.jain@arm.com" <dev.jain@arm.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>, 
	"hca@linux.ibm.com" <hca@linux.ibm.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"pjw@kernel.org" <pjw@kernel.org>, 
	"shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>, "svens@linux.ibm.com" <svens@linux.ibm.com>, 
	"thuth@redhat.com" <thuth@redhat.com>, "wyihan@google.com" <wyihan@google.com>, 
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>, 
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>, 
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "urezki@gmail.com" <urezki@gmail.com>, 
	"zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>, 
	"gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>, 
	"jiayuan.chen@shopee.com" <jiayuan.chen@shopee.com>, "lenb@kernel.org" <lenb@kernel.org>, 
	"osalvador@suse.de" <osalvador@suse.de>, "pavel@kernel.org" <pavel@kernel.org>, 
	"rafael@kernel.org" <rafael@kernel.org>, "vannapurve@google.com" <vannapurve@google.com>, 
	"jackmanb@google.com" <jackmanb@google.com>, "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>, 
	"patrick.roy@linux.dev" <patrick.roy@linux.dev>, "Thomson, Jack" <jackabt@amazon.co.uk>, 
	"Itazuri, Takahiro" <itazur@amazon.co.uk>, "Manwaring, Derek" <derekmn@amazon.com>
Content-Type: text/plain; charset="UTF-8"

"Kalyazin, Nikita" <kalyazin@amazon.co.uk> writes:

> From: Nikita Kalyazin <kalyazin@amazon.com>
>
> Let's provide folio_{zap,restore}_direct_map helpers as preparation for
> supporting removal of the direct map for guest_memfd folios.
> In folio_zap_direct_map(), flush TLB to make sure the data is not
> accessible.
>
> The new helpers need to be accessible to KVM on architectures that
> support guest_memfd (x86 and arm64).
>
> Direct map removal gives guest_memfd the same protection that
> memfd_secret does, such as hardening against Spectre-like attacks
> through in-kernel gadgets.
>
> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
> ---
>  include/linux/set_memory.h | 13 ++++++++++++
>  mm/memory.c                | 42 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+)
>
> diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
> index 1a2563f525fc..24caea2931f9 100644
> --- a/include/linux/set_memory.h
> +++ b/include/linux/set_memory.h
> @@ -41,6 +41,15 @@ static inline int set_direct_map_valid_noflush(const void *addr,
>  	return 0;
>  }
>
> +static inline int folio_zap_direct_map(struct folio *folio)
> +{
> +	return 0;
> +}
> +
> +static inline void folio_restore_direct_map(struct folio *folio)
> +{
> +}
> +
>  static inline bool kernel_page_present(struct page *page)
>  {
>  	return true;
> @@ -57,6 +66,10 @@ static inline bool can_set_direct_map(void)
>  }
>  #define can_set_direct_map can_set_direct_map
>  #endif
> +
> +int folio_zap_direct_map(struct folio *folio);
> +void folio_restore_direct_map(struct folio *folio);
> +
>  #endif /* CONFIG_ARCH_HAS_SET_DIRECT_MAP */
>
>  #ifdef CONFIG_X86_64
> diff --git a/mm/memory.c b/mm/memory.c
> index 07778814b4a8..cab6bb237fc0 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -78,6 +78,7 @@
>  #include <linux/sched/sysctl.h>
>  #include <linux/pgalloc.h>
>  #include <linux/uaccess.h>
> +#include <linux/set_memory.h>
>
>  #include <trace/events/kmem.h>
>
> @@ -7478,3 +7479,44 @@ void vma_pgtable_walk_end(struct vm_area_struct *vma)
>  	if (is_vm_hugetlb_page(vma))
>  		hugetlb_vma_unlock_read(vma);
>  }
> +
> +#ifdef CONFIG_ARCH_HAS_SET_DIRECT_MAP
> +/**
> + * folio_zap_direct_map - remove a folio from the kernel direct map
> + * @folio: folio to remove from the direct map
> + *
> + * Removes the folio from the kernel direct map and flushes the TLB.  This may
> + * require splitting huge pages in the direct map, which can fail due to memory
> + * allocation.
> + *
> + * Return: 0 on success, or a negative error code on failure.
> + */
> +int folio_zap_direct_map(struct folio *folio)
> +{
> +	const void *addr = folio_address(folio);
> +	int ret;
> +
> +	ret = set_direct_map_valid_noflush(addr, folio_nr_pages(folio), false);
> +	flush_tlb_kernel_range((unsigned long)addr,
> +			       (unsigned long)addr + folio_size(folio));
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(folio_zap_direct_map, "kvm");
> +
> +/**
> + * folio_restore_direct_map - restore the kernel direct map entry for a folio
> + * @folio: folio whose direct map entry is to be restored
> + *
> + * This may only be called after a prior successful folio_zap_direct_map() on
> + * the same folio.  Because the zap will have already split any huge pages in
> + * the direct map, restoration here only updates protection bits and cannot
> + * fail.
> + */
> +void folio_restore_direct_map(struct folio *folio)
> +{
> +	WARN_ON_ONCE(set_direct_map_valid_noflush(folio_address(folio),
> +						  folio_nr_pages(folio), true));
> +}
> +EXPORT_SYMBOL_FOR_MODULES(folio_restore_direct_map, "kvm");
> +#endif /* CONFIG_ARCH_HAS_SET_DIRECT_MAP */
> --
> 2.50.1

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

I also took a look at Sashiko's [1] comments and I think that the
highmem folio issues should be the responsibility of the caller to
check.

[1] https://sashiko.dev/#/patchset/20260317141031.514-1-kalyazin%40amazon.com
