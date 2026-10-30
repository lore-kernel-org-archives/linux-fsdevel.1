Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.193
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793332552;
	b=Z0Iqe15bOHwQ7NOkk7K2M7kuveb0ZugfmT685p1ml9j2pP1aQM4OwcTfUY8W0VMenf/G
	 hNIuZjC/BE5hUlZGTg2OC4KmOmD2JEYLceN7J0WA9vtplOlJyZhNlZvbaPKaLEymvujJl
	 z3dgk1Ppe3OUpUuHaZZN3f2ByyyOUGnC4DJff0kMOX0HnKiMKzUQIIf3XCsR+NN5+3pbm
	 Iaxnx7OAWAasZ4wz7fblW+fM5f5jEcbg+cxldM5DsYqYb4C48fCtt1LFNWjeDgxhA3U9M
	 P42UTgkpT7Ou2cutw2LGqHsUzPw6p35HMmUJSnm5i+PT+MMuO7JZ/h7/MkJHgWJUxOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793332552;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ey3vPsJ2dQFhz2BxI4N3mBDHBT7ectNl9BIu9ANR89g=;
	b=yO2UEA0iQL9M55i3Go4kD+pgNyj65zWj8HtGBSPntFox8cjo2jGAv5CiqVwnmYCMWGn5
	 HKFk2ChTPnciagfCi+KTXh9ilEMbKSGKdFdAbf3TpROEl+RQ8fh8sJ5e6arsk3fRXKPHh
	 LW2r12lCawc7eCdoIpNyYyEM+JlVlf9ch7aUVgfLkp6OwSi4zTdWZ6rpO5g/A36wxk9DT
	 B2nqhkur9F0/C9sU/lqcgFS7ugN5qDoPQXDBdu2/cRWInR+s0xUq/Ql+LdyD9dy5qXYch
	 In/HWfT2ctV5dSERUgv7x4u+z0ty+IUi9+MeoJ6RsieIZdzxqbXDvcJ2iYKrF1+edfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=95.215.58.193
Received: from mta1.migadu.com (out-193.mta1.migadu.com [95.215.58.193])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED79D606A321
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 03:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED79D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=U6aEVcyx4cbsQT0ReFIAsX7642J2D1rQ7p5hav7hVYg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793332545; v=1; x=1793937345;
 b=JZqpmtFQ7Ohd/1LNlZcCz7DJxGmfw1W0QBIwKd81WGlQ+GCSScpslPKi5z61+nW3yuNQ2DfG
 qYpgDNHPL3GYEromeJ9ePTKmdga4oQNe9eAq94ZKZxJjP2u8k8hH0quzBvtjDNrpC+rFPoXIxuw
 UlDm22KbKQ+To97lJYUZVLqY=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 29251291072b5e95;
	Fri, 30 Oct 2026 03:55:20 +0000
X-Mizu-Trace-ID: 29251291072b5e95
X-Migadu-Flow: FLOW_OUT
From: xu.xin@linux.dev
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	aneesh.kumar@kernel.org,
	apopple@nvidia.com,
	axelrasmussen@google.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	baoquan.he@linux.dev,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	dev.jain@arm.com,
	gourry@gourry.net,
	hannes@cmpxchg.org,
	harry@kernel.org,
	hughd@google.com,
	jack@suse.cz,
	jannh@google.com,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	joshua.hahnjy@gmail.com,
	kas@kernel.org,
	kasong@tencent.com,
	kees@kernel.org,
	kexec@lists.infradead.org,
	lance.yang@linux.dev,
	liam@infradead.org,
	linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	mason@kernel.org,
	matthew.brost@intel.com,
	mhocko@kernel.org,
	mhocko@suse.com,
	minchan@kernel.org,
	muchun.song@linux.dev,
	nico.pache@linux.dev,
	nphamcs@gmail.com,
	npiggin@gmail.com,
	osalvador@suse.de,
	pasha.tatashin@soleen.com,
	peterx@redhat.com,
	peterz@infradead.org,
	pfalcato@suse.de,
	pratyush@kernel.org,
	qi.zheng@linux.dev,
	rakie.kim@sk.com,
	riel@surriel.com,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	shakeel.butt@linux.dev,
	shikemeng@huaweicloud.com,
	stable@vger.kernel.org,
	surenb@google.com,
	usama.arif@linux.dev,
	vbabka@kernel.org,
	weixugc@google.com,
	will@kernel.org,
	willy@infradead.org,
	xu.xin@linux.dev,
	ying.huang@linux.alibaba.com,
	youngjun.park@lge.com,
	yuanchu@google.com,
	ziy@nvidia.com
Subject: Re: [PATCH 39/46] mm/ksm: fix use of a freed anon_vma at swap-in
Date: Fri, 30 Oct 2026 11:54:47 +0800
Message-Id: <20261030035447.140856-1-xu.xin@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027-fixes_core-v1-39-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-39-6f74bec9a5bb@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

> A folio read from a swap slot previously shared by KSM can remain in the
> swap cache after the process that first mapped it exits. Its anon_vma
> can then be freed, so ksm_might_need_to_copy() must not dereference it
> to compare roots.
> 
> Doing so can result in some false-positives, resulting in the reverse
> mapping missing the new folio mapping, preventing migration and reclaim.
> 
> SLAB_TYPESAFE_BY_RCU allows individual anon_vma objects to be reused
> immediately after freeing. A stale pointer can then refer to another
> anon_vma whose root matches, even though the target VMA is not linked
> to that anon_vma.
> 
> Move the anonymous rmap compatibility checks into
> folio_anon_rmap_compatible(). Keep the page-index check and compare the
> folio's anon_vma pointer against the VMA's own anon_vma and root first.
> 
> If neither matches, bite the bullet and walk the VMA's anon_vma_chain.
> The VMA keeps these anon_vmas alive, and finding a match guarantees that
> reverse mapping can find the new mapping.
> 
> Lorenzo Stoakes says in a private discussion:
> 
>   "This isn't quite equivalent to the existing check.
> 
>   Every anon_vma in an anon_vma_chain shares the same root, but if you
>   split a VMA then fork both of them like this:
> 
>                   VMA A
>                /        \         <split>
>             VMA B      VMA C
>                \        /
>         root <- anon_vma 1
>                ----^ ^----        <fork>
>               /   parent  \
>         anon_vma 2   anon_vma 3
>              |            |
>            VMA D        VMA E
> 
>   VMA's D and E both get their own new
>   anon_vma's such that:
> 
>   VMA D: anon_vma 2 -> anon_vma 1 -> root
>   VMA E: anon_vma 3 -> anon_vma 1 -> root
> 
>   And if you found a folio referencing anon_vma 2, the existing check:
> 
> 	anon_vma->root == vma->anon-vma->root
> 
>   Would be true for VMA's B, C, D & E.
> 
>   However after your change it'd be true for VMA D only, as it's the only
>   one with anon_vma 2 in its anon_vma_chain.
> 
>   Whether or not that could actually happen in practice... 🙂 I don't
>   know.
> 
>   [...] after your change it'd be true for VMA D only, as it's the only
>   one with anon_vma 2 in its anon_vma_chain. [...] I would [...] say that
>   you are making the test stricter but more correct.
> "
> 
> If this affects performance when KSM was never even involved, we could
> just track whether KSM ever merged anything and just skip these checks.
> 
> There isn't really a lot we can do otherwise: for mapped folios we might
> be able to use folio_get_anon_vma(), but for unmapped folios there really
> is no easy way to see if the anon_vma is still valid.
> 
> Document the (confusing) lifetime requirements of folio_anon_vma().
> 
> Fixes: ba6f0ff3981e ("ksm: fix ksm swapin time optimization")
> Cc: stable@vger.kernel.org
> Reported-by: Chris Mason <mason@kernel.org>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/ksm.c  | 36 +++++++++++++++++++++++++++++++-----
>  mm/util.c | 13 +++++++++++++
>  2 files changed, 44 insertions(+), 5 deletions(-)

Acked-by: Xu Xin <xu.xin@linux.dev>
