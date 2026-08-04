Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E751D46F4B4
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 18:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869228; cv=none; b=sx+EsKwDFTGUi0wNvTZAJiYNfh3xpnFEYFoROlr8peM1mBT7rCCp8fZjE0lL5ZIMBvhq49LJ/7yjRBJ5IXjzigJmpXlc0lX6q8OU9g6tnwFwzWri8XSF/CiYU/Lgy5ue2nq0YxUOp8QIMewT4ulTlF5mjy0rag8zUgWDExgcOMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869228; c=relaxed/simple;
	bh=1dgyZEfov7cTiKURuAHz5zzAOpl5soSUna6DYq9tTHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Voop6THqVj9VuMhqLJ5KJAhz4NePV3PVZqgULCMLOh3IuvHN1Jl+TUIFkqM0TEzDEmSnfi/f0mwOXtgN7TXAj/z4yP0y2cv76FczouhQKQ53azFVz5zx4S8W3qwcDVq+6Em4uyrLl1c5VIqABfnWWcg1sPFNI9AmtekE+mqbTSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=umOouo7u; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="umOouo7u"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-90004d2f7b7so1472796d6.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 11:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785869226; x=1786474026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0XhFL1Aufp21Ws6fsSI1vIe2k9HSzrqnJkS9QsV30Gk=;
        b=umOouo7uLhgxJNonat8lpkh5VycnVSc4ZIilfets/dZrnnfaul4CYH+x2qRZK11Xa5
         5Xhqxf+/qks0ae4LJ9ta786mMN+KgzqhvMil3qM+9MRSPjVc0oqFY5IkyyvhRBOaPrAm
         U8p/eguPojD84H8RHRsBS4kcu8raCU4gG+Ah2HbkVyh4E1bzzqOmp9FFb8H4uCsVfHFS
         wZpSbtMPR/CVpUTpTRqSX59Mlh9WmRtg+Z2xnZMyCcR8uKSd7ROnuvIyZB0G6eJxvXiX
         NFxNChi2h2hMKNpVGKEr2lNBLEO8MqZIOUjOvT/9cvabKYSxegnQvrGaiCZNtaqN4/o8
         ALKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785869226; x=1786474026;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0XhFL1Aufp21Ws6fsSI1vIe2k9HSzrqnJkS9QsV30Gk=;
        b=TKhene1bqPCswh/9HjVYvlMBjz4Is/q5B0Pu/CXrO9RKujkiTf3f2M7NTTO3mVchcr
         VCL1zwF+KJ6cEozHbB5XL00JlXswc8RPGhLDp4Jp1mmQtoQyLZ6ADz8Sh3pcsK/MTqGK
         7fzmb2ZmuNaHtzDFNUTGVmLQvFFs8zLjCesaGZ+qP0xdmUWHw7+Fvh7BqzR8lNF1xaSU
         UsHmMcp+hUX7sS+34kd8DCtnb/Eb85gE07GgAHiiH3mx7hkHzEA4rtAyeQpTzTMQFC50
         6xwD1Umw5NNnid1l3ykqQJyvl4DnY9C3rHuQ7iWdFbdxmiXgNV/LX/5TAtSxChMVxBLn
         xHcQ==
X-Forwarded-Encrypted: i=1; AHgh+RqA5H4Cx0zFl6oBb18t0Kr/ov7qWo5sp6MDiRNUS85GE698IkaDuN8agPUS9TwIvDlxhFknSse4/d/hTSct@vger.kernel.org
X-Gm-Message-State: AOJu0Yx83ywwoPlob54RWuBH661W66NPJyIvs5dqINmw7RV7SuemMwUc
	uwIRLylyZbE2prG7Eh/dzTWGiBrSpLxfs453o3rDQ4Wf0OLYUti7r67eokkF/u6Z4UE=
X-Gm-Gg: AR+sD10D0jhkKuXN9do9OPYRhaA+zmdA9DDP3ZTYQjZUddkLeH7+AjbdWFBGb9gRySO
	fkIYeKLXLipqYiHfP2l0hUrjHqYBvoxtlCDNy5CI7WmeTqSHmKXQVMbcQ6k/rOU4zMvd/yrMu1K
	0MOTYzRPmsQ2an5RyMWtZ3Azqlyw+vZJvuiLx6N4g2RT19r1J13Y3xYv+7kUB+yVG+BKCdYdUWC
	DBu8aotwyQdz1V1GS/OO1DAwTjAWxVla6L35LqcehNMVjSupgIwcVqIg5gdwe3NF3hkbOzMt8BE
	dTlMnVezS59yCQmHChemtwlKmDnisKe5Sawmt1PxxfHIn+GMSJG2lWCo9vgFDCv/a4QVkgK+8gR
	REjmpV6Y2dkdAV5PmFGVuOTUfL574NPVyqeIN0cbCEF5pZZGSpgnesbCVLcm4Q2mrrqwB+lAQXr
	AkJrlvNA1jOfNM9DE9fPuvW1k7FFHNQwU5gkVUwiMYULZWDcexxAxju6hbYvLor52ZewDFOaWTX
	hOsf2mM+87De510f+9gI1k7lbUPA+zDPbjGygw+es5q
X-Received: by 2002:a05:6214:4687:b0:8f3:e97:59be with SMTP id 6a1803df08f44-9088124bbadmr16733196d6.17.1785869225675;
        Tue, 04 Aug 2026 11:47:05 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9087ff9d79bsm8203346d6.6.2026.08.04.11.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:47:05 -0700 (PDT)
Date: Tue, 4 Aug 2026 14:47:03 -0400
From: Gregory Price <gourry@gourry.net>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <christian@brauner.io>, Jiaqi Yan <jiaqiyan@google.com>
Subject: Re: [PATCH v8 09/15] mm: Remove locking mf_mutex in
 is_raw_hwpoison_page_in_hugepage()
Message-ID: <anIzMHAH8dImAcsk@gourry-fedora-PF4VCD3F>
References: <20260731200802.574821-1-willy@infradead.org>
 <20260731200802.574821-10-willy@infradead.org>
 <anIUe_Zq8bFX0-Dk@gourry-fedora-PF4VCD3F>
 <anIaMs7XtXp631QU@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anIaMs7XtXp631QU@casper.infradead.org>

On Tue, Aug 04, 2026 at 05:58:26PM +0100, Matthew Wilcox wrote:
> On Tue, Aug 04, 2026 at 12:36:00PM -0400, Gregory Price wrote:
> 
> So we have all manner of protections that prevent us from taking this mutex
> -- the folio must have a hwpoison page in it and must be hugetlb, but at
> the end of the day, one can still be preempted while holding a mutex and
> we never know when we might want to call this from a non-sleepable context.
> 
> I'd be open to arguments that this should be an rwlock rather than
> a spinlock.  Or figure out a way to shard the lock per folio (lockdep
> etc make it very hard to embed a spinlock in struct folio).  I think
> it'd also be profitable to change how we record poison for hugetlb to
> not need locking or memory allocation.
>

I think such complexity needs to be driven by an actual demonstration
the spinlock is problematic.  It seems like if you're hitting devastating
contention here, you have much bigger (hardware) problems.

> But this is all a very long way from where I want to be working -- cleaning
> up the page fault path.  I think I've made a reasonable set of improvements
> here, and somebody else can come along later to make the code even better.
> 

Agreed.

~Gregory
