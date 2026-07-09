Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F77224AFA;
	Thu,  9 Jul 2026 11:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783595379; cv=none; b=pEcLq3HMDdn0FzAw1wlNREBuKgMo44u7gzD/ammmKj4XFNcYKzdVUfy+Id1GJwJh1ct+NybsKxC/g3tuK212YZ+d5j1IWYhEFR2iwmliwETC1Mr9x/VVv4NBw7bIVZgelOk3No7vIGBwGwhaOdA22ylACgiw2tz3UXhmGj4wEKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783595379; c=relaxed/simple;
	bh=9cnKKDJZrSfXXGy6d6HNa/9GmhTcjV3LvohaULrRNhI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tz5sBC1z6CkBupr/OdPfvyRmMKBI+oSdzzYqpyWQyZNRJH+cHjjsydYKlj3qGAcsqxm6m5ff6iauDdZtjoqyPeRy02b3d9ZynAaE0KlH+GWnzhQCgaIBl3U/JJR3cGddW9E77SLh+Ad7ghoji0NXgsqzBRQSn+okbnBx5Zc17xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BiN40XTd; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BiN40XTd"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783595373; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=uImjXXPcL41dSiGErhCZMVoNRrVWs+eZDG6csqO3Dn8=;
	b=BiN40XTde33vb1ntH5YvbuiMuzic/bmYyXppBM8WitHysZd3WwHZYj5fye96Z/VH2etctsN/twUWao16iNOnaSikrGcwDib+78Wr3LSHV0zd5VK0i7JKJr+gfSSPb6RbwcZr0dN6Wm56Q30DvuEy9hI94luWnbvTgxIuaZN0How=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=ying.huang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0X6kkhgH_1783595370;
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0X6kkhgH_1783595370 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 09 Jul 2026 19:09:31 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  kernel-team@meta.com,
  willy@infradead.org,  jack@suse.cz,  akpm@linux-foundation.org,
  david@kernel.org,  ziy@nvidia.com,  matthew.brost@intel.com,
  joshua.hahnjy@gmail.com,  rakie.kim@sk.com,  byungchul@sk.com,
  apopple@nvidia.com,  Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 0/2] mm: don't apply task mempolicy to unmovable kernel
 allocations
In-Reply-To: <20260701222112.2820098-1-gourry@gourry.net> (Gregory Price's
	message of "Wed, 1 Jul 2026 18:21:10 -0400")
References: <20260701222112.2820098-1-gourry@gourry.net>
Date: Thu, 09 Jul 2026 19:09:29 +0800
Message-ID: <87echco1w6.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gourry@gourry.net> writes:

> This series stops a task's NUMA mempolicy from steering incidental,
> global kernel allocations that have no real relationship to the task.
>
> VMA-less allocations (alloc_pages(), folio_alloc(), vmalloc(), slab
> refils) - fall back to the current task's mempolicy as their only
> placement hint.
>
> This sweeps in kernel memory that is not the task's:
>   - unaccounted slab
>   - kernel page tables
>   - driver GFP_KERNEL buffers
>   - one-off global structures
>   - etc
>
> On a uniform multi-socket system this is not implicitly harmful.
> On a tiered-memory system a task's interleave/bind can push these
> incidental allocations onto slower tiers and cause regressions.
>
> The memory may outlive the task, or be shared by others, yet a single
> task's policy dictated where it landed.  
>
> The fix is to only follow the task policy for allocations that are
> plausibly the task's:
>
>   - movable allocations (mostly user data), and
>   - allocations explicitly tied to the task via __GFP_ACCOUNT.
>
> Everything else (unmovable and unaccounted) prefers node-local.
>
> Cpuset still enforces any hard confinements (ALLOC_CPUSET), and
> fallback allocations may still cause spillage, but this at least
> prevents interleave policies from making poor placements.
>
> Patch 1 makes page-cache placement explicit in filemap to retain
> existing behavior (pagecache and metadata still end up following
> the task mempolicy).  Since the metadata can be significant on
> some systems, retaining this behavior will ensure there are no
> surprises for existing users.
>
> If we want to change this behavior, this patch is droppable.
>
> Patch 2 adds the alloc_task_policy() filter for bare allocations.
>
> Test 1: Page cache follows the task policy (unchanged)
> ======
> A process running on node0 but bound to node1:
>    (numactl --cpunodebind=0 --membind=1) writes a 1.2G file.
>
>   membind=1 (non-local):  FilePages  node0 +0MB     node1 +1200MB
>   membind=0 (control):    FilePages  node0 +1200MB  node1 +0MB 
>
>
> Test 2: Incidental kernel allocations no longer follow it (changed)
> ======
> Added a debugfs interface to do movable and kernel allocations:
>
>  w/ --cpunodebind=0
>  numactl ... --membind=1      echo 100000 > .../alloc_kernel
>  numactl ... --membind=1      echo 100000 > .../alloc_movable
>  numactl ... --interleave=all echo 100000 > .../alloc_kernel
>
>                        GFP_KERNEL          GFP_HIGHUSER_MOVABLE
> membind=1    base:     node1 (follows)     node1
>              patched:  node0 (local)       node1 (follows)
>
> interleave   base:     50/50 (follows)     50/50
>              patched:  node0 (local)       50/50 (follows)
>
> Movable (user) allocations are unaffected in every case.
>
> The unmovable unaccounted kernel allocations stop following the
> task policy and place node-local. With no policy set, both place
> node-local as before.

Personally, I think this should be the right thing to do theoretically.
However, you may need to find some practical issues that this resolves.

> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
>
> Gregory Price (2):
>   mm/filemap: place page-cache folios via an explicit mempolicy
>   mm/mempolicy: skip task mempolicy for unmovable unaccounted kernel
>     allocations
>
>  mm/filemap.c   |  5 ++++-
>  mm/mempolicy.c | 40 ++++++++++++++++++++++++++++------------
>  2 files changed, 32 insertions(+), 13 deletions(-)

---
Best Regards,
Huang, Ying
