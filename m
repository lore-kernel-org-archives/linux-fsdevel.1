Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBB519F12D
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2026 07:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782719442; cv=none; b=I0sDwAVtMjH9iZFburNF9JMbEUiTMQKcux522GQrvM9L4hTtowYx3IRMzDhHo9oNhFnZUDQFnm9Adc2roa2+6QEcgSL+7/UHEKpPo7f5iSqKCsUObBwEY/n0B8/balRRa4BXgs2W9ckihMsqxwZrFyOTWkUIOME8AuU7uEoe4/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782719442; c=relaxed/simple;
	bh=Al1hASRXjfejI+CoCKxnEMxyR5XV1fFf8NVzIyioyOE=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=I4pWHfNpZOYhB9mW7xZGywNp8itj76nEteTE0vYoCcXIPTDsOxqZ+SeXiXsM6rY9Vv8oKWLPnrWuYWWo1RG7nRgu9b3CkEUoLnR9zf9ruoIwF584cCubSLAfJfnvkdpOGQ2O7ST3BW8ReGiNlDgLNmE2lgRMKSdiE1utulUsZDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4gpdjw2Dn4z58fdM;
	Mon, 29 Jun 2026 15:50:28 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 65T7o4VA056669;
	Mon, 29 Jun 2026 15:50:04 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 29 Jun 2026 15:50:07 +0800 (CST)
X-Zmail-TransId: 2afa6a4223af016-ff81d
X-Mailer: Zmail v1.0
Message-ID: <20260629155007041-i6ON_Yq8sJs3QymHqB9q@zte.com.cn>
In-Reply-To: <20260629033122.774318-1-tujinjiang@huawei.com>
References: 20260629033122.774318-1-tujinjiang@huawei.com
Date: Mon, 29 Jun 2026 15:50:07 +0800 (CST)
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
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2M10gZnMvcHJvYzogZml4IEtQRl9LU00gcmVwb3J0ZWQgZm9yIGFsbCBhbm9ueW1vdXMgcGFnZXM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 65T7o4VA056669
X-TLS: YES
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Mon, 29 Jun 2026 15:50:28 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A4223C4.000/4gpdjw2Dn4z58fdM

> Changes in v3:                                                             
>  * fix typo.                                                               
>  * add CC stable                                                           
>  * collect Acked-by.
> 
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

Reviewed-by: Xu Xin <xu.xin16@zte.com.cn>
