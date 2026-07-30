Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E443C7690
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785401877; cv=none; b=VJCxC9gqu7WMUFDVORTgj9KrDBBqBDVBOSsrAK7NXMpNayOdZCW/kAUwdJ4tvYHYZRzQQKJ0SO4D7Lw8kJTUL9JXuGZZd7DhM4oL32/ONSvc178DGKp4l7i9/Eba7ZEGuH78CKlS/44Q7m+xu2dxC0NFodCEuZnFF4vXRQrXgPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785401877; c=relaxed/simple;
	bh=XFck+zQbLjVXByOZI4jMj1vdRhZek34CfrD/wLcmUx8=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MwAYfVMWzdR16JPSm/psCTiCWgInNC8C5/afdLAab4XqvcbmipNRJq8jOp/Lugc81evMhiKQDCCHukvEfHZxw4mhEqFMR6T+1W+jgza0Ge65174HisVL6hm7m2Kp6xibFM6RbyBrHPj6yzvA8x+d9u+zRF8zSSNNYej9MjK+PBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=4ezA0bOW; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="4ezA0bOW"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9rMtCmYRE4yKFhMmgCu1LbAu5IZOmFSXihnF1nAJiuc=;
	b=4ezA0bOWlGuGwTq+3v9Z7hX1eqJhwpRJMbaNvFi9IGnDLWb89LKHYCjqb3hyGTuRqIs7Ooo3F
	q4Ym9hLwdd6ft2eGYmRwnmZbkw+LYQS/bi9qPiW0QCWbOvDfO0W3ZqI7aJNwlXQZngsUOYsCZYy
	2ISns1h1IVv7cItxAga9gV8=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h9jXS1DXmznTVd;
	Thu, 30 Jul 2026 16:48:24 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id E16114055B;
	Thu, 30 Jul 2026 16:57:50 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Jul 2026 16:57:50 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Jul 2026 16:57:49 +0800
Subject: Re: [PATCH v7 03/13] hugetlb: Mark some function arguments as const
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>, Naoya Horiguchi
	<nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	<linux-fsdevel@vger.kernel.org>, Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>, Usama Arif <usama.arif@linux.dev>, "Gregory
 Price" <gourry@gourry.net>, Andrew Morton <akpm@linux-foundation.org>, "Jane
 Chu" <jane.chu@oracle.com>, <linux-mm@kvack.org>
References: <20260728204409.3396238-1-willy@infradead.org>
 <20260728204409.3396238-4-willy@infradead.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <28f41c7d-a869-4495-f2b8-822d8435ac2c@huawei.com>
Date: Thu, 30 Jul 2026 16:57:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260728204409.3396238-4-willy@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/7/29 4:43, Matthew Wilcox (Oracle) wrote:
> These functions do not modify their folio argument, so we can mark them
> as being const which will allow for some minor optimisations and let us
> mark other function arguments as being const in the future.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Usama Arif <usama.arif@linux.dev>
> Reviewed-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.
