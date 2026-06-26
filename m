Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2352DF13E
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 02:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782439753; cv=none; b=nPqKGtG9iYTUcczL8UU8xkvp7U3QZ/n9x/oo4fIDV/OPTQ+m2qiFcCUVqUvGu1uL91KwKIedugTTvK9WE8GXxXiTjXtTgvnTlUrrzFCn3yfEndv5wyKkFkb9X8AlQFPtsik8bOzwxMnqRwMu0QcP0UhyZHdBy+2KlixlO78swMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782439753; c=relaxed/simple;
	bh=uOOXEB4mHJXEcvxC7lXnZZd6n06y/X1MIyVDjmQu4Ww=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=k7SYEmmB30JahmMeNwpTjw78nu67HNzZlRNUN5TMF2CbXKQryr2Aa9FoEyac5Ew+Gu4wChEllTZgb4fW0oDXu+1EW/QIzfIqUXLZCJV9Ds2M7Bp3m6ZnPNsVd0kuHBV43YbnpkqC2DcM1W8tNqhqvBGADeDlel4XTQUb7TK7FkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gmfHN2s5sz8Xrr9;
	Fri, 26 Jun 2026 10:09:04 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 65Q291n7062221;
	Fri, 26 Jun 2026 10:09:02 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 26 Jun 2026 10:09:02 +0800 (CST)
X-Zmail-TransId: 2afa6a3ddf3ef4a-cb033
X-Mailer: Zmail v1.0
Message-ID: <20260626100902993K04Lc3GM32AnCvCmzGequ@zte.com.cn>
In-Reply-To: <20260626013252.2846774-1-tujinjiang@huawei.com>
References: 20260626013252.2846774-1-tujinjiang@huawei.com
Date: Fri, 26 Jun 2026 10:09:02 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <tujinjiang@huawei.com>
Cc: <akpm@linux-foundation.org>, <ziy@nvidia.com>, <david@kernel.org>,
        <luizcap@redhat.com>, <willy@infradead.org>, <linmiaohe@huawei.com>,
        <svetly.todorov@memverge.com>, <chengming.zhou@linux.dev>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
        <tujinjiang@huawei.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2Ml0gZnMvcHJvYzogZml4IEtQRl9LU00gcmVwb3J0ZWQgZm9yIGFsbCBhbm9ueW1vdXMgcGFnZXM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 65Q291n7062221
X-TLS: YES
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Fri, 26 Jun 2026 10:09:04 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A3DDF40.000/4gmfHN2s5sz8Xrr9

> Reading /proc/kpageflags for any anonymous page returns KPF_KSM set, even
> when KSM is not in use. As a result, tools misclassify all anonymous pages
> as KSM merged.
> 
> In stable_page_flags(), if the page is anonymous, then use (mapping &
> FOLIO_MAPPING_KSM) check to identify if the anonymous page is KSM page.
> However, FOLIO_MAPPING_KSM is FOLIO_MAPPING_ANON | FOLIO_MAPPING_ANON_KSM,
> (mapping & FOLIO_MAPPING_KSM) check returns true for all nonymous pages.

"returns true for all nonymous pages."

should %s/nonymous/anonymous ?

> 
> To fix it, use FOLIO_MAPPING_ANON_KSM instead.
> 
> Fixes: dee3d0bef2b0 ("proc: rewrite stable_page_flags()")
> Signed-off-by: Jinjiang Tu <tujinjiang@huawei.com>
> ---
> Changelog in v2:
>  * use FOLIO_MAPPING_KSM to match explictly instead of use FOLIO_MAPPING_ANON_KSM
> only.
> 
>  fs/proc/page.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/proc/page.c b/fs/proc/page.c
> index f9b2c2c906cd..7d9387143435 100644
> --- a/fs/proc/page.c
> +++ b/fs/proc/page.c
> @@ -173,7 +173,7 @@ u64 stable_page_flags(const struct page *page)
>          u |= 1 << KPF_MMAP;
>      if (is_anon) {
>          u |= 1 << KPF_ANON;
> -        if (mapping & FOLIO_MAPPING_KSM)
> +        if ((mapping & FOLIO_MAPPING_FLAGS) == FOLIO_MAPPING_KSM)
>              u |= 1 << KPF_KSM;
>      }
>  
> -- 
> 2.43.0
