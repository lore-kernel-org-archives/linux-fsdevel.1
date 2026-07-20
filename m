Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B71409138
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 17:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784569491; cv=none; b=Rguf5RL+u7gG5Q0dVmsY4HSWVeMk1Nn8MM7eEWGTF9le/iN8IWsJXg1iSv3EdA4E9osSlWF5wKtfdKSWbG4nIkN1zAzFemJUfPq4nK6ZqBIWHG/+O42kDnQAn83QnyXvpe2PmI19sHclgkMOUQ4TTZXcjGpn1Ps2e5gKdDJLuiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784569491; c=relaxed/simple;
	bh=eQwLG50FQTlGIaxFUWOZqCCOrmund6wJNcAiP3xOaXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGlgH8adXoKYyeQaSgi8UZw/BWdYi7YqYG269TDbKFEF5ONUNFcPmUWhnE+yjVB/Wbp1AEqA3rV+InDZoYJhnnxM3p7oY/foBwbPrB6tx2cIt14FNoNiVAQAGLvGilm5xmc/cDRRBw4UMbJi34N4SKgi7rmxkWl4W7jVctSTx3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=X8U6zM0w; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="X8U6zM0w"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51bfbe05683so94789051cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 10:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784569485; x=1785174285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fh0Ky+WC8JAb92VghcxhTRFBn6Go7CAcxa18f3039ho=;
        b=X8U6zM0wVzqBdPhme0rKH4934jbpYW7yQmUifhqTtQKugUMzjxrbWR2V0nbPkyGBQh
         9oEanJic11w4rFy7w4bJsWVLEdr5NvOH86f28My6ZAYChA3qDKSCIEKL9wDJXpQdy6MA
         H70tVAM4f0rgUzOwqE/Go3xFdHmvfIoFSdCaNE9AkeSJmHlr/FzvKsEoOo/ZSMe3xXi9
         A87GeIdVUoGCBJOZzbmTRjuSVMq8uoC9GucP2CSIV8hxiP9i0t4b3LQ0tUi9aik56pEM
         TPyyrvqsTIyBTT46XV/wt8ZLbanNjaaKY0I4Y79+bo8Uwas/HcYEKSSZM3SWmQXQgoIx
         R51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784569485; x=1785174285;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fh0Ky+WC8JAb92VghcxhTRFBn6Go7CAcxa18f3039ho=;
        b=WcWqNPvOBkXVLRHcv71aHuiCheYqQ/yabrkYdGJujjsYvLohYcwwj8bAk8JvuAiqN5
         ihegLr1i5v91GWgjf+9JKluzMxACPADiY3HOBheiH9MDpwbh5MaeZL5EnG6+nbeLjQ89
         80mZvyefcAoWCTfkO1zOkQJ4uoUHQ1rWdHOachzZqs1mLa6EqFYEWDNJP86rOftlNxT5
         b4AXakT4+iC0DsQqipbVMa0cOt20fSdjyU5x1H2c+UaK6VhM7Fb97+c59UoKPRYDOLlH
         g/LaDKm56jjqqx23ijaWCHSuafCgZAVgDjx3NjgzwSWKQBZmb9xxrnfpRzrsF4g59XHi
         yxUg==
X-Forwarded-Encrypted: i=1; AHgh+RqDK5O1fUxP2E/XNbyi+W/HngX4TxrVD4FabwcPxYW7i+V1/SLZAXe4odtLOFlTZiBCEWX59PH6hB4gHv4J@vger.kernel.org
X-Gm-Message-State: AOJu0YxpgEgX3Xd5rEQttzcy5uUa73Dx0uYGrC6JvGbh+OZraIygWrWM
	jGiRx5LuiJ+QyQfwSrmVDh6uHjHOoNL72sgdXHYFDWmOf8pyNb1AtL2ODdU2W1a/U8k=
X-Gm-Gg: AfdE7ckzDwZtzA70fKIHxackXW0U+348eBnmY1rnqWoPjBXmGekxdUusKcb6hmpGQPU
	XF0/Tj8qmvt0SMvyh1ELTkZ8y+Zznh/JJZWf+YXkiw1zYivblb1LLKKYEu3O9pqDZ23kfUX6P6t
	HslP3amWv2qKCz7soGMXMOGkEulp9NJGIkLnQXWTRKplryVzVvVUHOWqthd992VetnAKEe9OAnC
	72azl/6UYOGBWDwhuA2BQ3kh2oBLTiSqX0E6O9QbQplhPza8z3jIvT1Xx2yqKbPTCPaa0rlrU/f
	ZSxas2cAMTuyOTFcXBJl4ACNvIxHcJ7Pe940j7jKifFMWtHGyGMS8ajl2RvRGEfwE42CtO2NnGV
	IMTd1Bw/G2PhTpnd0ReCad93iyjhufvaq04bW4c75YWKdkTZCdN7O3YJvWCROiyxvIKgbKfiboD
	VxfwT7gd0bMu9NwBz1Dmyxxx2KZRa/WyFKCKQvfK9zCjJ6q+I8SMrJ9vttrw==
X-Received: by 2002:a05:622a:1107:b0:51b:fddc:1de8 with SMTP id d75a77b69052e-5213e67e2c1mr141645811cf.65.1784569485065;
        Mon, 20 Jul 2026 10:44:45 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5214cda7dbfsm77462971cf.9.2026.07.20.10.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 10:44:44 -0700 (PDT)
Date: Mon, 20 Jul 2026 13:44:39 -0400
From: Gregory Price <gourry@gourry.net>
To: Brendan Jackman <jackmanb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, 
	Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Thomas Gleixner <tglx@kernel.org>, Chuck Lever <cel@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	iommu@lists.linux.dev, loongarch@lists.linux.dev, linux-nfs@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: move __folio_alloc() to page_alloc.h
Message-ID: <al5eCOfvXR3OZjVi@gourry-fedora-PF4VCD3F>
References: <20260716-folio-alloc-cleanups-v1-0-5363b8e92d33@google.com>
 <20260716-folio-alloc-cleanups-v1-3-5363b8e92d33@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716-folio-alloc-cleanups-v1-3-5363b8e92d33@google.com>

On Thu, Jul 16, 2026 at 02:30:12PM +0000, Brendan Jackman wrote:
> This is no longer used outside of mm so reduce the scope.
> 
> Ulterior motive for the move to mm/: A later patch will add an
> alloc_flags arg here.
> 

I have a similar commit that is coming in on my next private node rfc,
i'll reference this, but i wanted to make sure i hit a solid mm-new base
so sashiko picks it up and people can actually apply it.

> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Reviewed-by:Gregory Price <gourry@gourry.net>

