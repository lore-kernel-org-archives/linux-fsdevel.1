Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1C53F4DD2
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Sep 2026 06:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788503853; cv=none; b=dMgSO5AhIO2PS5CBCLBWVLtLVMZCwO81CaPdENYWMHgF3SwOlsvGEM4Qxi7d/0fbdy4+rCP8gQJAevU9+JpLCvMYXNRfX4k7bxb+aAnbzvur24wipDXwOgtIJgo7Z0oIgCI7ZIFzz5FyBOcsmDKgJ1dQ8rgOm6R962GoK0pSljs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788503853; c=relaxed/simple;
	bh=+b2oNb3SSIzXdybxdFWgLzWcPLSUQ49C6jz2kCp6u0s=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KUaryyFsLRV1ViA8AHCmcyfVbhO1xUml6I+KOe5Y4DgVz9gaQb2SWAJvVkwoJxshYcr3K0Pqu7KFGCSSEfMyaiO7uLynHte60FflZTlwlNdjiz+iWW6nrBogaJakDoi8/QCiDc1Pj1VxESr9W6Egg9xZ1h2/7BsvRL4o6eduMY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=YEtxI0FR; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="YEtxI0FR"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=LWLs0SHkrM24MSInQ2XpsIeq1uN6XlQiC8ArRKGi6VU=;
	b=YEtxI0FRow7IvcmxoAJBY+ae55mUabDb/bjKQgeX9SS7QQ+8nfXAva973oSdhRtKxwQYZTtDj
	utiknF5qkpjoK4A8MV8LYD1sQzyp6engTnsbd6jrwFXKN5N+dLXDlaKZYUmSX/WSyLp3qpmKbMF
	jmVGXE5qkc4hBMnG5NPOM6c=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hbmgf3nTdznTVx;
	Fri,  4 Sep 2026 14:26:06 +0800 (CST)
Received: from whupemk100004.china.huawei.com (unknown [7.152.185.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A03140572;
	Fri,  4 Sep 2026 14:37:18 +0800 (CST)
Received: from [10.173.124.160] (10.173.124.160) by
 whupemk100004.china.huawei.com (7.152.185.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 4 Sep 2026 14:37:16 +0800
Subject: Re: [PATCH v9 10/15] mm: Check individual hugetlb pages for poison
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>, Naoya Horiguchi
	<nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	<linux-fsdevel@vger.kernel.org>, Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>, "Gregory Price (Meta)" <gourry@gourry.net>,
	Andrew Morton <akpm@linux-foundation.org>, Jane Chu <jane.chu@oracle.com>,
	<linux-mm@kvack.org>
References: <20260805210557.1118966-1-willy@infradead.org>
 <20260805210557.1118966-11-willy@infradead.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <0ca31092-bfc1-af3d-a588-bb6bb7d5d9d8@huawei.com>
Date: Fri, 4 Sep 2026 14:37:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260805210557.1118966-11-willy@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 whupemk100004.china.huawei.com (7.152.185.74)

On 2026/8/6 5:05, Matthew Wilcox (Oracle) wrote:
> So far, is_page_hwpoison() has returned true for the entire poisoned
> hugetlb folio, but we can usually allow access to the pages which
> aren't poisoned.  It's slightly tricky due to not having a reference
> to the folio, but the hugetlb lock can save us here.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Jane Chu <jane.chu@oracle.com>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> ---
>  include/linux/page-flags.h |  4 +++-
>  mm/memory-failure.c        | 43 +++++++++++++++++++++++++++++++-------
>  2 files changed, 39 insertions(+), 8 deletions(-)

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.
