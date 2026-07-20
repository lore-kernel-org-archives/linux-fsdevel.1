Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BE9445AEA
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 17:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784568383; cv=none; b=XDM058H8U3V/lrt7eCvF+Ks4bjruf+2jsaDOv0Q5Tc0Yyyvtx/xwg/qnNFzPit/oFFM6UkUyuEhzZoPxVpeOJVKC71BGnc9t+ITLXOLND1Kj51qPtvul4R/flSPQJCLoUqr0BeBY2+DqH+ltbEc44yhGlqFFgwt9WXFvXKfX1Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784568383; c=relaxed/simple;
	bh=xAVd6i83kgeqkxok+4gw/WnABSDaX1zpDO+8SrcTaVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2zxBefqJTnSQUXzqM5tA7xnEIiE0HAasaIdZIlSVrHTlhFxLwfi0GC3f5lj6e9p4xyhRb3V9m+M0kmvsM6GzR273JYNQbxo6khgouQXOXj0j+5G95nAwC7SsgbwTCXclmTBaQl+1/D7xUna4jXSv3Uqz0A4aR8WwlEgYZBHVak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=sQPxNztB; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="sQPxNztB"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e6c4a867cso456760685a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 10:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784568375; x=1785173175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xuNoMT9tYeRPYMpWqWaN4lATHuSPR1MQ4bXWUnUxpyA=;
        b=sQPxNztBtrZgIZRs2gn6aWekmY9xkjrwOZLIHUnqTcDBqdyXy2HIwsEMt+SKuyt3Jc
         eGIVwc4QzjN3xyp6Q7HR/f1DuFqvp/U49FYG5MdoWAStpiw8UjOGph+cV1X1QttY5/hP
         ki/EvTdhhY7rV8E044kOAwFSnFUwKA4K6UGm6NmHva3KRnKOTd5/QjmMw3IEhCztqvs5
         V2a/031wFVpTYAm6JuG65GR5HBydiwN7qGtQfMnTuONpTzOh6wJWV2RPtJ2dl+PqGr11
         88PZJVudJKIk/+HZ46TEBl4AR76t0yldjkhyqDysTM0k5++rX+EJ8cpp4Elep7eu/PF0
         bwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784568375; x=1785173175;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xuNoMT9tYeRPYMpWqWaN4lATHuSPR1MQ4bXWUnUxpyA=;
        b=J+tTK/Iy0W6F35ZgyzeBnL1J1Ou/im1xmPv3CBGiXhSS7Ml6nCxpVt9ev+H90qbFk8
         TM8/b+M4TFislUmT87SL736BGtzD/2b/aF4b0kHycr0IT85b03GS1D+VxrpGgpdP0u5t
         alSBjMEO30/YpBXLEV9YZiIbFNqN+nl2m0s1eJOTbja5oSoj/MMyfqlQY3Ck3UE+rSrg
         fn4Bim6XsjGbkDcPI+Peaa9ZLpLPzMxLEr/HZIhhKdcELTJe+y4P6vlmL7QeBFVIs9dQ
         kmajiZtoiPslVo1HnWazDH0m5xpVdJAdTj7wQ56UcP9U6pFWIQhb3rMyyA0gMBlUDiQo
         kNAQ==
X-Forwarded-Encrypted: i=1; AHgh+RrLUvGHZBYir+BR0gczZPcFvNw2Ym3l1U5QDdvvgzZVAUksHHT25IG1QLLzemW84xHBi+PnGoyWmjnzcoGR@vger.kernel.org
X-Gm-Message-State: AOJu0YwcGfS/q/t0qiQfMvmpXaScexlV53X0rouBCYmLVVFE6YpjtJMT
	EdwvDcQH0jkjI5zQyRJ7hRG610lt26albBibk3CR2WMf3IMB05X+EYIz5Oz/u6QxaoM=
X-Gm-Gg: AfdE7ckgLHEpYX/ke9cothDJ8LKG4eOqr6GoEOpzNEXYoditmh6v0wxAu+mCfhhLXxG
	yAd+E+of6xHbReo0tA0xu18qO9UfNwxs9s2NMOYWyyGewXGvUb0amRIZ22VfHTcWQQy/10BRniE
	p64pfuYUHzY/SCv48kb7bTp6A3UCtsTba22KEZ5W6D5IyTPUHewgcocrO6RblPEEmBh3KoUZh0D
	cwd4D6dI9xSMozts2R4kw9/pAzyAdB/gKzRd3LwjgZSPVLA/y81gGqTT4Tg8iVbJy5Qo4FJU/0K
	rOWaTvRo3WhD1evH7P9H2uTRZ6lASC2KVPmbhNG1BS61YkJTj9N0CkdL/rjSa7lI8HOu+/h5ObU
	dNOX69qCcUn/G6nsqZDXGRiU7qTZ6dcMGbhUmgC55adBDMUHdS8QHjNRh6/6wIjQLx7mQ35CVM5
	Q4C/actCkmnm8Zz+cg2bnFKj8sxf9oqN85chSkawCRXCi4NkCgjj0LJm/jDQ==
X-Received: by 2002:a05:620a:6ccd:b0:915:5cbd:1d96 with SMTP id af79cd13be357-930b3ea9fbdmr1533624685a.33.1784568375015;
        Mon, 20 Jul 2026 10:26:15 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b54773fbsm912994185a.39.2026.07.20.10.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 10:26:14 -0700 (PDT)
Date: Mon, 20 Jul 2026 13:26:09 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 01/15] mm/vma: introduce VMA virtual page offset field
 and add helpers
Message-ID: <al5ZPYH-0T6IPXox@gourry-fedora-PF4VCD3F>
References: <20260720-b4-scalable-cow-virt-pgoff-v2-0-2d549757a76f@kernel.org>
 <20260720-b4-scalable-cow-virt-pgoff-v2-1-2d549757a76f@kernel.org>
 <al5CPpc7XpRX7Vbt@gourry-fedora-PF4VCD3F>
 <al5Surm6fPIl4LNA@lucifer>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <al5Surm6fPIl4LNA@lucifer>

On Mon, Jul 20, 2026 at 05:56:52PM +0100, Lorenzo Stoakes (ARM) wrote:
> On Mon, Jul 20, 2026 at 11:49:00AM -0400, Gregory Price wrote:
> > On Mon, Jul 20, 2026 at 03:38:27PM +0100, Lorenzo Stoakes (ARM) wrote:
> > >
> > > The virtual page offset of a VMA is equal to vma->vm_start >> PAGE_SHIFT if
> > > they are unfaulted or were not remapped, otherwise it is equal to this
> > > value at the point of first fault.
> > >
> >
> > The latter half of this description is a bit confusing.
> >
> > Why would the value differ from (vma->vm_start >> PAGE_SHIFT)?
> > (because it's file backed?
> 
> Because the VMA gets remapped.
> 
> If it's remapped when it's unfaulted, then virtual page offset gets updated, if
> it's faulted then not.
> 

ahhhhh the wording is just wonky then

when faulted or remapped, x is...
when unfaulted or unremapped, x is...

instead of

x is ... if unfaulted or were not remapped, otherwise...

Sort of a complex combination of 3 negatives there.

~Gregory

