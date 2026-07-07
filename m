Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C0D33291F
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783441162; cv=none; b=dj5dwccl5W+XcvzyyQHuz/3+IrP6uuan3EeiOVMZvLhSqE6pouwQQH2Mxp0hVH5HYu20ec6d/B3zGW7eaGq7E6hZcwvn7dEgdwoDE6JeYx7Dse5QRfztCmiKszdy79OTiQcJxKqIczlDMiVrjO2gIKrZam0OGk8otKKWswPXyuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783441162; c=relaxed/simple;
	bh=zSkYvM1j3bXBVN3GN9JHi3PTLk/FUppI2uWt99Lug5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETUixW4iwjpYGGEswVldmDjotgkFUxhNUaaDXU9wzv466ShkLhdFIo6Auo9YO7eOqyqrqU2R0mFhVT+mlDB3lo2bIHaGx86n+DwfilkocF805bS7rRwQFT2NebCs5D+6Ui9vzc4ZWXeRTBXy7qBQC7gvptmclQ200r1KMwjFaOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=tOu0AuX1; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="tOu0AuX1"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c0cea8883so6740501cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2026 09:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783441159; x=1784045959; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=shTm78OzX8lamx3AIG2aka+O0fr6RJu853HQxce+7Rc=;
        b=tOu0AuX1FDWoyvYMHCvWmlaTSHUD6PEpTTlEE1s5M3FykAgHZF9yifJg2cX24DQWS1
         F1Hyq40+EffI4Jw4DNO0phdLK3CF6sAk5zDlQPBL6Cy3mLhJW6p4NcU1GHwLtioydHWi
         Z07uca+uB3L3POr5O7FDveWzX/6UbBZ8l/AiOutRTTQAMDKNUGpQapP3pM7t9yE3bL7S
         mOTX3KGtP2Uee4E1GNDnipNBkqgltNYxygx3AlYRPOoJgZqwRSmJjLrnFLGidwjcbGNp
         qiX1DMnI8okfB/qzgmsu0dCpZD9+JgLIgwq0qbQQhTzP4o4PM0JN5KmaxuYF4bK99HLL
         i61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783441159; x=1784045959;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=shTm78OzX8lamx3AIG2aka+O0fr6RJu853HQxce+7Rc=;
        b=jeoeh3bUC7jXyGkj+QP9YxzcQRN3tpOS1QuO13/igcmRmqpA1q//dxpLe71cm/JmN9
         Gd02d++WgBI+wGYfLtAJQnLvQSBoNqCRcD6kPOnJIb4HI6BhyPQhXNoUHzRrAdNfX/Hy
         cxRZdR+T180+JXQqYnmKjNIZKNiKV3a6/2as8eo/n0FTXofzcukIUqWZUBjHa1EhdoxM
         GNWmts0opEQkLV+Jjka2FmvhMbJ8O0n7kz8I2WKEFpcqH912RKOc0K9ZGtgBbRKDqisc
         AgKTNQ5DnIWN2n812QeuQkk86LK+YcX80OhjvF+uki65XypUcJNOOr1NOXliFhNqJQEd
         vVqA==
X-Forwarded-Encrypted: i=1; AHgh+Rq++MHNk9M0zQMmLYQz5XaNU13gQcp3F5wUTeQ2uzEkfno+TBEZ4J8DCW/w9xAh9aGx7THsHnACc5+wz0xa@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1+Gd245uf0lBcmqGkub9w6s5IBpsQcLS+eJkdRWcANOOugqqM
	LOauud/e6OBq3q91wXRPALB3AmXNoU4TZxcVaNCWVH9tu2ZL+JW9qg0pCq8BrHXgUJk=
X-Gm-Gg: AfdE7cl711UoXE4koyFqXLeDs65Dqhow5gfIiQiT5Bdfo6TAQ6zQjoCA0qEmDWN4PaA
	FV6Km491Lm1dy3O0j+9L/gE2o0ptGuK/aZ7Dmk53pw1XifoITA+FsSYl1Bz+QOPyf2U68V0woYy
	5a5sMVIchRxlvWmoLKazU4292qO0RaWSg16UeWXYsURi9MiKERH2cKn3bjwDK03821x+338ow2C
	VedLlEpRDjs0K874/5/VS4xvnqzu6BsAMR66XE+BErPydngNtlXVFwLEr7GRrtVq47XCY/fwQ6k
	fE+frSgLRtB+njewr1/GXerTPRu9r1sXudLKzXdawxbU+cizGkEGhJAW8PTJZGCNYdiAPr038YD
	YyK3qjLjd5+UkFKrfTeuoeQjB+cSxTX+oAdP4GsL9kz35WZxVAPRovExnWgypM6A9KLhS29gOkK
	2n2B2pcApEo3an0QmPDk1ylHMbXB5nJaPObDwPrchdbZMvBu7bGswUOqZK54qV76CLQ+1Y
X-Received: by 2002:a05:622a:124e:b0:51c:1f35:4638 with SMTP id d75a77b69052e-51c7a7515famr34037661cf.21.1783441158809;
        Tue, 07 Jul 2026 09:19:18 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41da510dsm114014641cf.22.2026.07.07.09.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 09:19:18 -0700 (PDT)
Date: Tue, 7 Jul 2026 12:19:13 -0400
From: Gregory Price <gourry@gourry.net>
To: wangtao <tao.wangtao@honor.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"tglx@kernel.org" <tglx@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"willy@infradead.org" <willy@infradead.org>,
	"sj@kernel.org" <sj@kernel.org>,
	"kees@kernel.org" <kees@kernel.org>,
	"luizcap@redhat.com" <luizcap@redhat.com>,
	"zhangjiao2@cmss.chinamobile.com" <zhangjiao2@cmss.chinamobile.com>,
	"kas@kernel.org" <kas@kernel.org>,
	"ljs@kernel.org" <ljs@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"liam@infradead.org" <liam@infradead.org>,
	"vbabka@kernel.org" <vbabka@kernel.org>,
	"rppt@kernel.org" <rppt@kernel.org>,
	"surenb@google.com" <surenb@google.com>,
	"mhocko@suse.com" <mhocko@suse.com>, "jack@suse.cz" <jack@suse.cz>,
	"riel@surriel.com" <riel@surriel.com>,
	"harry@kernel.org" <harry@kernel.org>,
	"jannh@google.com" <jannh@google.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>,
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>,
	"peterx@redhat.com" <peterx@redhat.com>,
	"ziy@nvidia.com" <ziy@nvidia.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"npache@redhat.com" <npache@redhat.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"dev.jain@arm.com" <dev.jain@arm.com>,
	"baohua@kernel.org" <baohua@kernel.org>,
	"lance.yang@linux.dev" <lance.yang@linux.dev>,
	"xu.xin16@zte.com.cn" <xu.xin16@zte.com.cn>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"muchun.song@linux.dev" <muchun.song@linux.dev>,
	"baoquan.he@linux.dev" <baoquan.he@linux.dev>,
	"nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
	"matthew.brost@intel.com" <matthew.brost@intel.com>,
	"joshua.hahnjy@gmail.com" <joshua.hahnjy@gmail.com>,
	"rakie.kim@sk.com" <rakie.kim@sk.com>,
	"byungchul@sk.com" <byungchul@sk.com>,
	"ying.huang@linux.alibaba.com" <ying.huang@linux.alibaba.com>,
	"apopple@nvidia.com" <apopple@nvidia.com>,
	"pfalcato@suse.de" <pfalcato@suse.de>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"damon@lists.linux.dev" <damon@lists.linux.dev>,
	"shakeel.butt@linux.dev" <shakeel.butt@linux.dev>,
	"ryncsn@gmail.com" <ryncsn@gmail.com>,
	"jparsana@google.com" <jparsana@google.com>,
	"dvander@google.com" <dvander@google.com>,
	zhangji <zhangji1@honor.com>, wangzicheng <wangzicheng@honor.com>
Subject: Re: [RFC PATCH v2 00/13] mm: rework anon_vma and remove
 anon_vma_chain
Message-ID: <ak0nAXzlwnQ-zPkN@gourry-fedora-PF4VCD3F>
References: <20260707063308.29176-1-tao.wangtao@honor.com>
 <08c001ab-320f-4676-830b-8e4ba6a05dee@kernel.org>
 <b00a03d62c53430ca22b3f3c5e5327b5@honor.com>
 <0e8e5a28-1111-4b81-b04f-b81e749eb3dd@kernel.org>
 <f640c89d9722462098bf1b7a0a6854c2@honor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f640c89d9722462098bf1b7a0a6854c2@honor.com>

On Tue, Jul 07, 2026 at 09:20:24AM +0000, wangtao wrote:
> > >
> > > If there are technical issues, please point them out directly.
> > > Or is this simply how technical discussions are usually conducted in the
> > Linux community or the mm subsystem?
> > 
> > I suggest you go back and read my email.
> 
> At first, I thought I was the only one who found anon_vma hard to understand. After reading your earlier email,
> I realized that many people also consider it difficult to follow. So I tried a different approach and implemented
> anon_vma rmap using a simpler doubly linked list plus depth mechanism.
> 

The in-flight was discussed at LSF and then reported on by lwn

https://lwn.net/Articles/1072378/

https://git.kernel.org/pub/scm/linux/kernel/git/ljs/linux.git/log/?h=project/cow-context

If you have issues with the in-flight work and think there's a better
way, it would be good to engage on that front - rather than posting
competing work and expecting maintainers to have to context switch
between two solutions for an objectively hard to understand problem
(which carries significant risk of regressions).

No one is saying you can't engage, just trying to avoid doing the same
work twice for negative value.

~Gregory
