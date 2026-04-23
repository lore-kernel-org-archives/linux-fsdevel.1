Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BFE371053
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 04:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776918681; cv=none; b=iSKqge0q7tlp1SgKBE50gDJe++Ye/2wTrMrCGB4hbz/XXfY9ZFSnG6GHgVy8YS4z5BzdPdY/gNVHS7a+v1t+okAb9Tq+9qUFIgD+RCDn1f+adeiPotiazZYcGqFgI+5WkMq7uMdr9LXS7lPfrQlIld2XUwVjeTxlgExdiMQBw6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776918681; c=relaxed/simple;
	bh=WjqD8BmJJCSwnwwzfZ25UIQEN6U/q+AVmj3pu35cNZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZ8p1PfbusBpfhtQqxD171Nnhy1UJLa3tCR0YB2YZ65rrvMe2azG/hE3eWlmpdC4dXU9qdKx8/Pg04qGUfc/MknpnQD3iOCKacFNmND+BCfVrgxJLrCrVxCxOKOKa8nMgxekA72P0dHCFySgjOcJwDkd+4VXCm8dqhWk4kRo4TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=lfHVfuV/; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="lfHVfuV/"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-506aa68065eso46301031cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 21:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1776918679; x=1777523479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KzBI8Vs9g1xHTdi85g03Pkd08y9g2RbvUpIAv03SBC0=;
        b=lfHVfuV/2xUlszx/Y3hVu0UHezfkaDNRKqqTnR5+ZiPhdjW5JGjjxw0xLcgRi3PstX
         G86nhEoj105Xz1q2YzTD5tLbbGjAEpE2ephQ2Gw6dbYzAF0KjF+HUqU+t+99r8Ov4xwR
         IMdfW7d2Lr6SjWAqWEE7cugOKphDyjsn3EpZ09qZWQKRX+ugmlQVnvMgeA+n+UOMRTCn
         HlB5pnGDJqUHzwEAEnqpRhT0n3fFulDW5RfyTPL6mY1TWb11VzpJ7sNX15JxS/zdkKW/
         yBHAzNjwfadNdr7a7et1WofdY9KOj84Zr/bj4YtGpIorLq5ISqtcq6yUmCdM0KDMYp3g
         QlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776918679; x=1777523479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzBI8Vs9g1xHTdi85g03Pkd08y9g2RbvUpIAv03SBC0=;
        b=NQRzuqwu+KuEh7v7VZVjvIazKysK1cLym3ckvzm7MIWv2R2P4fUYH76ujcPxcZnmkB
         MqkF89X5gqlmtV8zmv063/aCO22ByfjF/2Om961BsjV5mhv/qMraB+68+IWHoHjfQaR2
         k/C52EYw9Fy/dTCnkRTevgty8tV/1n8JFZSCCwCQQ3bfnZMzQBZMntoj53IQ4Xv9RvA+
         P3Pm8EmuRf9v5i3Spg5jSZ7eATuiuNnYujBhelPLtx6zfrAmo19IjlgmqrvX8SQIHR2a
         ynv3o53amNy0BUEXxwXgeSmDPvXdU3D0mDBUMYpVhk2lLeisuT9WMSG7TqvOKpVAHsRe
         g9CQ==
X-Forwarded-Encrypted: i=1; AFNElJ9EERP7vtgCwIKJz20Wwa1j7O03lB4uBzfBMveP89t/Yj6BL9nTFSvcVwKmbMP4OmZdtR4SByrWoGNQdEHJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzI0FC7WTfmOMpppV+XT4h+SS0BAjXYK3LATd88zO5HAGY5UHRn
	UTJN/XdcpimphpuN+/u5aJBzTwcLDqMi/IwepaW5ZT3wTYomqsGzUWxFFUScDR4BEwM=
X-Gm-Gg: AeBDiesIqU1nYIaUr7kt0QMKnfgbSQCEIAgLHs9SkLFXqcIltVgtfGcMpsmnz+G/nt7
	9uJESFKSlpMAlmLNne19VhuDiQebsxkJnloEB3Weo4keAjWgMp4rNVXJJB/GuuGQk+vC+Q8+29z
	e6vnaqLYnfi444kGJ26ES02b+X0tPBCdO+javh2bFWWMytN0sKIoyUCEkvzHDOHbvgpSkWYT2lM
	NuOyKg9Te66hclwJOmBgOhBMOuH3A/99y0XWhAoPrY8g3jTCGkIwqJk094gUsz7L1mqWstCptsu
	IUu6M/Ptbfj64fyHO83ntwGF/zWda8xDEzA6FnZFNPDVt9zOD6D97HQkfAYy6yfAe0JHpxcGmTp
	vJoqa7rN67nqaA7a/xyaZmVDycjzprVXlXpGA7giLCg6X546qwH+jRxoJrvNRg4oqdKqbZPYBpM
	8Z4SdOcWRKNUu0sPJryb4Fx2sEULwwcjS3xY1T98C428HjwuwbIOaSYJVcJjK0XLov5PlFU5B2m
	043LqvMTyQV6HNtJ5eE
X-Received: by 2002:a05:622a:409:b0:50e:89e6:669c with SMTP id d75a77b69052e-50e89e6697dmr204320091cf.37.1776918679403;
        Wed, 22 Apr 2026 21:31:19 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-71-246-228-50.washdc.fios.verizon.net. [71.246.228.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02aec3a3bsm147982736d6.49.2026.04.22.21.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 21:31:18 -0700 (PDT)
Date: Thu, 23 Apr 2026 00:31:16 -0400
From: Gregory Price <gourry@gourry.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Hugh Dickins <hughd@google.com>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v3 01/19] mm: thread user_addr through page allocator
 for cache-friendly zeroing
Message-ID: <aemglPlcwFFHNj1A@gourry-fedora-PF4VCD3F>
References: <cover.1776808209.git.mst@redhat.com>
 <9dd9deabd42801f3c344326991d1431c3d8db39d.1776808210.git.mst@redhat.com>
 <aekluxNPxF8CN8fL@gourry-fedora-PF4VCD3F>
 <20260422171315-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422171315-mutt-send-email-mst@kernel.org>

On Wed, Apr 22, 2026 at 05:20:27PM -0400, Michael S. Tsirkin wrote:
> On Wed, Apr 22, 2026 at 03:47:07PM -0400, Gregory Price wrote:
> > 
> > __alloc_user_pages(..., gfp_t gfp, user_addr)
> 
> With a wrapper approach, looks like we'd need something like
> __GFP_SKIP_ZERO so post_alloc_hook doesn't zero sequentially, then the
> wrapper re-zeros with folio_zero_user().  But then the wrapper needs to
> know whether the page was pre-zeroed (PG_zeroed), which is cleared by
> post_alloc_hook before return.  So the information doesn't survive to
> the wrapper.
> 

I was thinking more that internally you already have that information
you need to know to skip the zeroing - and so the wrapper can just pass
__GFP_ZERO and post_alloc_hook() would do the right thing regardless

Then on the way out, the new wrapper would take care of cacheline piece.

However, i explored this a bit - and while it saves some churn on the
interface, it adds two paths into the buddy - and that increase in
surface might not be worth it.

So I see the tradeoff here.  The churn is probably worth it.

~Gregory
