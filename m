Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21673D34A8
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Sep 2026 03:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788493112; cv=none; b=FlfDEqamueDAtqkdF3ZPEnXWH7SKo/yufcPqIMcer3XW6UpobcrMx7TWAuU+55JOt75a1n1qiZqiZyPltzH/Pms931qD4O90vMiMsKLwg2i077d2q3U/gHRMyZjs0tmiP09953z0hRkQ273ZQ3GOm9HqdIwgo9NJJ0Tt2z9z9l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788493112; c=relaxed/simple;
	bh=SIxl79RQVug3Il2ZT7fp/ZCcUV6GlI+OgdCE9FEFUAI=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dhzvjyZ+29mOoWz1DUVUWcUo8mmLppktMPON8m6/Z5rCuIj4duhpeHDakKPhS48EGyd4h7FtES8BayaijVJGP4Ada4UK3zWndcOCB5YuHatd6GtMmewvDejYNEkNFAauKSHDepYp1MdOK/8h4gWDXonO07breWXzpBgHTSHdFn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=cr/bVGZm; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="cr/bVGZm"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=biC4R+3LhAPGPOqKjajgQ9ft5Kgc9aWgzDMercUsc4o=;
	b=cr/bVGZmvR+Db/oP0Dj9tZ6ueSc2zbqdvTsKUvCJhO/Jdi3VIzzceDdmWB2g/An67Vy4ZH3Y8
	+gJOaHYmE4iydXuWUh4hQZ+eyXPc82AtoKa5SMp2lCze+3HMM6sddWsmMFg7q+shXnewtB/pxGq
	Lep5wAs7BZItzX3UODjNGeE=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hbhjS5kvszKmVp;
	Fri,  4 Sep 2026 11:27:24 +0800 (CST)
Received: from whupemk100004.china.huawei.com (unknown [7.152.185.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 8931040572;
	Fri,  4 Sep 2026 11:38:19 +0800 (CST)
Received: from [10.173.124.160] (10.173.124.160) by
 whupemk100004.china.huawei.com (7.152.185.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 4 Sep 2026 11:38:17 +0800
Subject: Re: [PATCH v9 02/15] memory-failure: Prevent hugetlb freeing during
 unpoisoning
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>, Naoya Horiguchi
	<nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	<linux-fsdevel@vger.kernel.org>, Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>, "Gregory Price (Meta)" <gourry@gourry.net>,
	Andrew Morton <akpm@linux-foundation.org>, Jane Chu <jane.chu@oracle.com>,
	<linux-mm@kvack.org>
References: <20260805210557.1118966-1-willy@infradead.org>
 <20260805210557.1118966-3-willy@infradead.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <616d673c-3428-24c4-c3f8-ce93b950e142@huawei.com>
Date: Fri, 4 Sep 2026 11:38:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260805210557.1118966-3-willy@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 whupemk100004.china.huawei.com (7.152.185.74)

On 2026/8/6 5:05, Matthew Wilcox (Oracle) wrote:
> If we fail to get a reference on the hugetlb folio, then it might be
> freed as we operate on it.  Prevent the freeing and the attendant races
> around manipulation of the raw_hwp list by holding the hugetlb_lock,
> which is also held by the hugetlb code when freeing hugetlb folios.
> 
> Fixes: ac5fcde0a96a ("mm, hwpoison: make unpoison aware of raw error info in hwpoisoned hugepage")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> Reviewed-by: Jane Chu <jane.chu@oracle.com>
> ---
>  include/linux/hugetlb.h | 19 +++++++++++++++++++
>  mm/memory-failure.c     |  6 +++++-
>  2 files changed, 24 insertions(+), 1 deletion(-)

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.
