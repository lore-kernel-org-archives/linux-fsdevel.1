Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4AF3B05AA
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338263; cv=none; b=gFnTTtG08e1LZ1ENjVV+iDQzuEEBJrb1G0WJIkC4j1IguF+LN/AwaCJNbavVMNNII8twz4MMaunmmu35j5Lbkf/ZMeWfOcyGiltWaLv0VljH4QniH4auJ2/ZXNhOrlJm2iNZCUA7Hi7ZISdxzIvowh4Oknq34N0Va2aJYXjf2aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338263; c=relaxed/simple;
	bh=B9aIAqlXnL1IiwBN7JkBT7+26fwnn4a+fu7SBR6VMlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbYxtkYvVNwRcpbX96gWusn+F0Hcum/8iN6s+fzaPJEeBir10K2k7fzSnCrSwVGWoaJvTK1+2lH9psx2crfEpqyf39ASX80iOsbwzKbVIgLbA1S+0MunkKeyU0KNxIg3amgzPxh+03FZtDJyRJi3sQwXvZDg40eUCn76PkWhq88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Hrj/dKBS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hrj/dKBS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3DuE2acrJKm1lx3lAybhbSRrGqjpBrUfPbaGHYn3cHA=; b=Hrj/dKBS24t9/BeX1YTwpnj0yG
	OmkWXsZg8EYbhPa/hxzzYeiqk0XF24jXbZatgnCW5R5OLlvDFFm6nYwUN0TOlY5h1gpArsu7AMEsd
	yL4EMfI6vJ26ql+drtmC0esoasRtYY3gNK4/LyxRXd1UsC5G7mtPzk0ZiMJS0OXuDNUuEL8t8ezy4
	N3iWKifETgUH8HVMa3tX13ncXvQnj7ZfZk/pDVm+FM0anHt4j+2t2qCoFvXz+Nw+e75ym0IDKkc6D
	kFuaVpjloVO2htqPYugmDRjlsWfSyY6s/OU3+wl7v8gsyU8lFTjtR9C48/qOkVyIX/Oy77WJ+ZWZZ
	FyygVEDg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp62C-00000008bM1-2SI0;
	Wed, 29 Jul 2026 15:17:28 +0000
Date: Wed, 29 Jul 2026 16:17:28 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>
Subject: Re: [PATCH v7 00/13] Use generic_file_read_iter() in hugetlbfs
Message-ID: <amoZiGwATl_1Kv0v@casper.infradead.org>
References: <20260728204409.3396238-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728204409.3396238-1-willy@infradead.org>

On Tue, Jul 28, 2026 at 09:43:52PM +0100, Matthew Wilcox (Oracle) wrote:
> This set of patches are separated out from Jane's earlier series.
> https://lore.kernel.org/linux-mm/20260617172534.1740152-1-jane.chu@oracle.com/

Sashiko pointed out that I hadn't touched kpageflags, and it's right.
I'll add this standalone patch for v8:

commit c392dd16cf5f
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Wed Jul 29 11:12:01 2026 -0400

    kpageflags: Use is_page_hwpoison() to set KPF_HWPOISON
    
    Instead of knowing how hugetlb handles hwpoison, just ask
    is_page_hwpoison().  This gives us the flexibility to change how hwpoison
    is handled without updating this function in the future.
    
    Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 7d9387143435..28c9a7b724f3 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -233,12 +233,8 @@ u64 stable_page_flags(const struct page *page)
 	u |= kpf_copy_bit(k, KPF_UNEVICTABLE,	PG_unevictable);
 	u |= kpf_copy_bit(k, KPF_MLOCKED,	PG_mlocked);
 
-#ifdef CONFIG_MEMORY_FAILURE
-	if (u & (1 << KPF_HUGE))
-		u |= kpf_copy_bit(k, KPF_HWPOISON,	PG_hwpoison);
-	else
-		u |= kpf_copy_bit(ps.page_snapshot.flags.f, KPF_HWPOISON, PG_hwpoison);
-#endif
+	if (is_page_hwpoison(page))
+		u |= KPF_HWPOISON;
 
 	u |= kpf_copy_bit(k, KPF_RESERVED,	PG_reserved);
 	u |= kpf_copy_bit(k, KPF_OWNER_2,	PG_owner_2);
