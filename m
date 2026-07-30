Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0C73FF1C4
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 11:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785411648; cv=none; b=NDqgzhKMsl+cR4nHrZIwYcB/YDO0DJ1HaWTkmk7y0vKdWAyZH7DM8dlhn8lxUw9JH9SUiOcS6uaSCiD9vbR8RqEjH3/gRR/0ipCGB49elbX57qiXaeg/K5XTlTbjxxK1z+6NHcEu9e5wnB2UgXFh/ayp57KHn9oFJb6QnLCWeA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785411648; c=relaxed/simple;
	bh=QyxGVzTU8n4lrxTRNfnHTSntzgEvvA4VjQ63ZuBoeMU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XN9XaKKjTm2xXL7KOcQ57A5o6PW11mAkBt91vRoaTO644hOcgGblrl7qvs/kBHz3igrXcXak5mE6svX+UZiSsXfF2ehoD7kMMovXUe6BjRRScVND/icgwx3sgBWCcezRF7udr1tqmtsRSxldieQ6MWX5K7xMI/YzNF7c+LsaHGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=AwO3qBz2; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="AwO3qBz2"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=MR/BR2k1/LO34RHmGOvBqb2jzfFxevkLWrRtbLLGJa0=;
	b=AwO3qBz2tS38UtUlQJmB4nDKxPeo9EYut46MUmvJ0ihEAQ20O286IgZRMp9gzdCuj16jGr7wp
	afQV2kAbrv0YfdnMNpEQIyq2Xr6OhDdPHXh50Ky5HhwjbGcQ8sYfLfcJfiT4A9TU7cJBGRe8UVU
	z4dG4dpLbfirNVYHXB3jIs0=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4h9n8G0n8PzLlX5;
	Thu, 30 Jul 2026 19:31:10 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id C913740586;
	Thu, 30 Jul 2026 19:40:37 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Jul 2026 19:40:37 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Jul 2026 19:40:36 +0800
Subject: Re: [PATCH v7 05/13] hugetlb: Move poison to pages before clearing
 hugetlb page type
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>, Naoya Horiguchi
	<nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	<linux-fsdevel@vger.kernel.org>, Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>, Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>, <linux-mm@kvack.org>
References: <20260728204409.3396238-1-willy@infradead.org>
 <20260728204409.3396238-6-willy@infradead.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <ff9f5060-347c-c18d-0bdb-ad1b90e704e7@huawei.com>
Date: Thu, 30 Jul 2026 19:40:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260728204409.3396238-6-willy@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/7/29 4:43, Matthew Wilcox (Oracle) wrote:
> For is_page_hwpoison() to be reliable, we need to set the hwpoison
> flag on each page before clearing the hugetlb flag.  Introduce
> folio_clear_hugetlb() to make this easier.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.

