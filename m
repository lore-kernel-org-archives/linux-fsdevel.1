Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95EE346E44
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 22:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787954569; cv=none; b=SJ3AlTyAgHi4Sp4FZcJla6tFI5tw/vpxXiaF5hCnsf4a6FgXPIhRvHm4LPgs8WkbWWUcJsDwsvlEvbPtCks5paLYOgNR0Y51JRysYfDtOtZb+W1GyDE6fHY8LhcWoyANPbCNMNz7Vs/+IHC4jYmvz1zBUC9dc5B5kDz5Lihxc14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787954569; c=relaxed/simple;
	bh=C0Lc/ScTW7fF2d+eNiSG940ybJdGv1UZt4Xd8+iuGxI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PhOyxEuSI13AXeVjIc+ydmRaz9dapZtBVLxs+HNtKc+H0IZyeu8xsHrerdEq/HyQ0mcjsH+vz0USfUEPoSORPAWdOcfJIlSGwcTeOVvBIL/unirArFemtKmP6yuSL+w2MhxdxWmqMl/H9l2YKjsMdV86XsQ9UJtifeF6IBIe+38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sBC4WQoY; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sBC4WQoY"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-836c5b01e82so23501547b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 15:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787954567; x=1788559367; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wA8fy7HWE3V3WB6sMl8dDfF3ITuMIwqNn0Xomqm4doc=;
        b=sBC4WQoYs8GQSIqimBn8xzQ315Fj59wL2qQoiJrY4J0oixs3aZurBXDzqF5rEbHomu
         /U95D8YuGC2LCu8vX5bpSEVtk74AkfzfUodToAB01mxvf2aINgs98KINPjXUlv9C5zBP
         mgn1IqdMgSmeThjr9DN8n0tIBYZAHp58WpR14Ada7H5rPe7Mvs5tIhTyP41achStTj7Q
         RMc9+mL2P/JnPqgeSROTpULhMSMjy1shj7gCB4XNYSnN+HmyozK3WJHbmbJMODYM2ZRS
         HYLD4K1gYxrcLGG4zNOMGx8XQzTyPPSm1TJyDATXw8BnhU0hdlgfLMfHt7cnFr6jCF8Z
         4IJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787954567; x=1788559367;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wA8fy7HWE3V3WB6sMl8dDfF3ITuMIwqNn0Xomqm4doc=;
        b=VYxmoupGi33I2lNRU0WVS/TLcUpCfWypJU0EqvGfHhK7OIU7VlKrUw9fv7jRQUF6n7
         ikcttMl1WHZxWFNKV0/CT57ebSS3JXSdqdQ4ODL9FChtQX7VAGzgzRV23Rg2JA7S9TdT
         8vTQAC7j+x+80gaX+chjlfH6ByRwa1Ss5Gv1l/Oe8r/HSqMloop6ByoA35FxTOiTNDSi
         RCfppOP7k/y15BaZgOVbPxpx7TCVA86BZ1SMnui/d0V9AzyButsQU7QqQ44wXy4zndMQ
         mvAuLKtQ9pwDoBtvl0v9wrvKlzFzerIhW5bug6tPtkX3DSO89yD3XzS5w7SdQEn9U1+N
         kxdw==
X-Forwarded-Encrypted: i=1; AKwUvBzVXIXfMzp4ariCTIoNooGVAQiswGuoGnXPN4VRZSl2oYqUp5kBQ7/zuaXoHXolOY1+soF2p+33mfJyegRB@vger.kernel.org
X-Gm-Message-State: AFuF++kMXiBGIR0bothKqqUe/F+3NWB2X0cUuK2g5MUGh9eTGcK6lpXF
	9CWyliO2X1Q5+iyD/TpP9Z1wnnZo9sXW2E9npNNN/t0aB6K+T2VGjvtcYk43fM1HYA==
X-Gm-Gg: AYBFou0DfM8lhJ+oJmaGWBaDqSSHna4e0atN12+97PzvwzMVw5qdL/lTShMdqdiX9gG
	d7fzlL1gmC0GVrjT1u8bUodOo6DBQh9HYyC0BXIl7jVkg8jBPm9f6TJsmkQcYxhlXXrJSvVRrke
	WDFJiPH6JicaDtkDPG9HzcNuuKcx9KH5umvJuOIUKCBTZKtUMk9s+WJ4ol1ZdJWnlx5xjGc1ssk
	7h1bqYHf0Rc7W8CxY0WRJD8kswPLdMMdAHjFjuplytbmV827awTb67OrsS1BUITLhUet5qYEWjR
	DLbQZ5YXF3Lnu44YLuJIektEm5j9WXwlMW8Fe77Vusqq6UHohUwCZL0RDhr+nWMEdnT04aPMQ93
	sRi377uYKfTnQql/4SjJkWpRvS1PuusrWA1E+QoFVaSCHQuGhAEDMHkV3uF24T4ripnlZVwvIZl
	sGhrqdzig4zIqvU973S75bXNlsY4zzNK6b2FbFYUoq1yrlC3lIeqIFVzPNizU5W2qAgePN+j2E8
	U5BAJz4tOTFEbuj1ov2BePPZc6yncJ8nATB5hmJBsmfiEoB
X-Received: by 2002:a05:690c:692:b0:84c:6169:49f4 with SMTP id 00721157ae682-85d6a3d835emr43441127b3.19.1787954565878;
        Fri, 28 Aug 2026 15:02:45 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e66abaf31sm12814067b3.35.2026.08.28.15.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 15:02:45 -0700 (PDT)
Date: Fri, 28 Aug 2026 15:02:01 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Ackerley Tng <ackerleytng@google.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
    Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, 
    Christoph Lameter <cl@gentwo.org>, David Hildenbrand <david@kernel.org>, 
    JP Kobryn <jp.kobryn@linux.dev>, Jan Kara <jack@suse.cz>, 
    Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>, 
    Kairui Song <ryncsn@gmail.com>, Kiryl Shutsemau <kas@kernel.org>, 
    Lance Yang <lance.yang@linux.dev>, Leonardo Bras <leobras.c@gmail.com>, 
    Lorenzo Stoakes <ljs@kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, 
    Matthew Wilcox <willy@infradead.org>, 
    Mel Gorman <mgorman@techsingularity.net>, 
    Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>, 
    Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
    Oscar Salvador <osalvador@suse.de>, Peter Zijlstra <peterz@infradead.org>, 
    Qi Zheng <qi.zheng@linux.dev>, Rik van Riel <riel@surriel.com>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Shakeel Butt <shakeel.butt@linux.dev>, 
    Suren Baghdasaryan <surenb@google.com>, 
    Vlastimil Babka <vbabka@kernel.org>, 
    Yang Shi <yang@os.amperecomputing.com>, Yu Zhao <yuzhao@google.com>, 
    Zach O'Keefe <zokeefe@google.com>, Zi Yan <ziy@nvidia.com>, 
    linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 20/25] s390/fbatch: no lru_add_drain_all() in
 s390_wiggle_split_folio()
In-Reply-To: <20260828170217.324c3445@p-imbrenda>
Message-ID: <ef4081a0-908d-bdad-4e6a-91c4c8b20130@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com> <7bf68e7b-f88c-6ca9-39ab-e9fedab0c8be@google.com> <20260826155722.0198d3ce@p-imbrenda> <2319f670-fe0b-f032-c0dc-486cbec0f3e1@google.com> <20260827145502.2fb4505b@p-imbrenda>
 <cdbaa4ff-d2b3-34bf-dd41-01fdc65edebe@google.com> <20260828170217.324c3445@p-imbrenda>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 28 Aug 2026, Claudio Imbrenda wrote:
...
> 
> so if I understand correctly, with this series the LRU caches
> will never hold extra references (as in refcount) on pages anymore,
> therefore calling lru_add_drain_all() will never decrease the refcount
> on any of the pages that are in any of the LRU caches

You understand correctly.

Though just before hitting send, I remembered one further detail.

lru_add_drain_all() also invalidates the buffer_head cache on each CPU:
entirely unrelated to mm's fbatches and LRUs, if I understand correctly
it's a genuine LRU cache of blockdev buffer_heads very useful to some
filessystems (e.g. for quick superblock access), which prevent the pages
(folios?) they are attached to from being freed while attached.

My understanding is very poor. but from glancing at the folio-oriented
kvm_s390_pv_make_secure(), I'll guess that you have no need for that
aspect of lru_add_drain_all(). But if you think that you do, then
we can replace your lru_add_drain_all() by an invalidate_bh_lrus()
(like 22/25 does to drop_caches).

> 
> in that case the lru drain can indeed go

Thanks for confirming - but please reconfirm in the light of those
buffer_heads.

Hugh
