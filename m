Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8E8331203;
	Sat, 25 Jul 2026 08:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784966934; cv=none; b=CFMYN/DSZ8eq+YZi3wLDb1v140xEJOd2fOM+rY13bMWRXn+yEnipuiNik/f1d2JwaFwzqi7ftUmmhzq9KlyxpDQrXM748xgKKlkGoPtjjtV+uy+x07zCpz6hnaer+AO/FcVRAdtVnBxtemGRoiaMNpW1GGxT0ibnV0x2hnHbZTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784966934; c=relaxed/simple;
	bh=UznW21p4x5SnVK5V3t92kWmp8jCLMJiO8uI4eELsqb0=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=GWIkHs0CS5hkSkR8YzzB4eBUhl/8hYfR1OFiml8g1KqKH4eVwJXB2wmyDyn4p9ArB6YCmTgrcybfoBdzAnlTd3ODM+9jsSkua9duJsZtIYg0FG3r+x3SBm+0prKH98Sa9EurCa4bOCM1MuXIiRf5Y6Cncm6/BlWzWFjL9CIeMTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4h6cv442sWz5B12g;
	Sat, 25 Jul 2026 16:08:48 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 66P88hVb021478;
	Sat, 25 Jul 2026 16:08:43 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 25 Jul 2026 16:08:45 +0800 (CST)
X-Zmail-TransId: 2afa6a646f0d226-2e19e
X-Mailer: Zmail v1.0
Message-ID: <20260725160845504-gOk3xjMjshwFGEPvJ_lL@zte.com.cn>
In-Reply-To: <20260720-b4-scalable-cow-virt-pgoff-v2-1-2d549757a76f@kernel.org>
References: 20260720-b4-scalable-cow-virt-pgoff-v2-0-2d549757a76f@kernel.org,20260720-b4-scalable-cow-virt-pgoff-v2-1-2d549757a76f@kernel.org
Date: Sat, 25 Jul 2026 16:08:45 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <ljs@kernel.org>
Cc: <akpm@linux-foundation.org>, <david@kernel.org>, <liam@infradead.org>,
        <vbabka@kernel.org>, <rppt@kernel.org>, <surenb@google.com>,
        <mhocko@suse.com>, <jannh@google.com>, <pfalcato@suse.de>,
        <willy@infradead.org>, <jack@suse.cz>, <linmiaohe@huawei.com>,
        <nao.horiguchi@gmail.com>, <riel@surriel.com>, <harry@kernel.org>,
        <lance.yang@linux.dev>, <kees@kernel.org>, <ziy@nvidia.com>,
        <baolin.wang@linux.alibaba.com>, <npache@redhat.com>,
        <ryan.roberts@arm.com>, <dev.jain@arm.com>, <baohua@kernel.org>,
        <usama.arif@linux.dev>, <matthew.brost@intel.com>,
        <joshua.hahnjy@gmail.com>, <rakie.kim@sk.com>, <byungchul@sk.com>,
        <gourry@gourry.net>, <ying.huang@linux.alibaba.com>,
        <apopple@nvidia.com>, <peterx@redhat.com>, <chengming.zhou@linux.dev>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>, <ljs@kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MiAwMS8xNV0gbW0vdm1hOiBpbnRyb2R1Y2UgVk1BIHZpcnR1YWwgcGFnZSBvZmZzZXQgZmllbGQgYW5kIGFkZCBoZWxwZXJz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 66P88hVb021478
X-TLS: YES
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sat, 25 Jul 2026 16:08:48 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A646F10.000/4h6cv442sWz5B12g

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
> 
> The first field is present on cacheline 0 containing key VMA fields, and
> the second on cacheline 3, which contains file-backed reverse mapping
> fields.
> 
> Given the relative time spent accessing reverse mapping fields as well as
> updating them, there shouldn't be any performance impact here from false
> sharing.
> 
> Update the VMA userland tests to account for this change.
> 
> No callsites are updated yet, so no functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  include/linux/mm.h              | 59 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/mm_types.h        | 12 +++++++++
>  mm/vma.h                        | 14 ++++++++++
>  mm/vma_init.c                   |  1 +
>  tools/testing/vma/include/dup.h | 26 ++++++++++++++++++
>  5 files changed, 112 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 87feaa5a2b78..59b98cc60402 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4393,6 +4393,65 @@ static inline pgoff_t vma_last_pgoff(const struct vm_area_struct *vma)
>  	return vma_end_pgoff(vma) - 1;
>  }
>  
> +/**
> + * vma_start_virt_pgoff() - Get the virtual page offset of the start of @vma
> + * @vma: The VMA whose virtual page offset is required.
> + *
> + * If unfaulted, then this is vma->vm_start >> PAGE_SHIFT, if faulted then the
> + * virtual page offset at the time of first fault.
> + *
> + * If the VMA is anonymous, this returns the same value as vma_start_pgoff().
> + *
> + * This value is used for tracking MAP_PRIVATE file-backed mappings by their
> + * virtual page offset.
> + *
> + * Returns: The virtual page offset of the start of @vma.
> + */

Thanks. These looks much better to me.

Reviewed-by: Xu Xin <xu.xin16@zte.com.cn>
