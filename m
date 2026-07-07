Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAFB35BDA4
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 07:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783408903; cv=pass; b=bwoyvC43H1Q7L1vPN8uFKKDIjAo988zgLhVF/84VPklQH4HZtvGMKtC8RUgjXkMD7U7xKNz/O+IUSNYrgEjOXgpO4LLMR3d09XQQRyv1tiEozTtY4HQSNTUSIrAhaUOa1YMGZQUuWjVmUHGmEojoK1KY8XjdmtAtWlIEPV1acIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783408903; c=relaxed/simple;
	bh=qcg4RcF0mT1TEuo/6J21ZVBADngE4CsURMKwvYL8kvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TtJ/m8SvsVkmP8d086wCsZeCOZys5sZT8Ahakr1XBLdViaq60/AVIQeFtQA0yvX/x0nqA0FO+Msd5NdtGVPgtUSi6SlY1p8mo8fJJFPxcBLQsTyy12zIBXm5Eqtg4t6xI284Yet/g6lnmn8uQdDYPCryHPY0o/7NOdnTZmmCauc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=plMzQfR9; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="plMzQfR9"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aeb6bdeaeaso3018e87.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2026 00:21:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783408894; cv=none;
        d=google.com; s=arc-20260327;
        b=PwMY6ht+/t1n+dMFa4j9ELEAI7/5FXgHuZIygoQdT65bsOZUbGTZ+4l4lKa7LPvvIt
         3KjroRZni+hV3qgAdfuW7YM4HuSh9/8pgZi/xoaC2oMSoHb/gRm8v4x3vmSg4q2Mg+Qy
         CLC8OAz6wnmXcv0wKfXPnqD6rwjWlBGgZ9kE2knGH8IJ2oSBu4ysDJSr909Xey1AVfXK
         94j+hTG1f6JglIX//aONSGeIUODK/4ElnS1Pw8Rj3tZk7pUm5FHUCBJiWf15xeWrT+9+
         qa+kwl/UTHWdcsnR8xeDXPiA2jMyL+itfChRmaSyUuKqpJMncGfT8MhUALjQ5Y9t8uCl
         hFJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RuL7lrFAhFFbC0DaxVnYi7IkQ87nYE6lxKOGL6gGHpI=;
        fh=5VpppvSj7eV8rEcgz1caUqP+KS7ymkWfRzAZeNW2utM=;
        b=WZlwFbWQX/FGal9D31jRi0KVE2hTqO4oaM1hJsOwaPdG9eKFRzBnHXMUFivM9WOIDq
         PeA42kRMG2DZqVM8+ZOPlNOQZJHIiiKdrJ+leCMYHQWEnnFlMPJzskwQYB6iHUgIOyrz
         wOZ2i/eKiGX+kAQaiGPtcd9yCOwREHEnbHh/xFPZiYTXue+WdGAsWqqy/i1umdBczPjw
         wTXT7VPQ9B3EIzJI/K/BD7ZcNLwRyFxVMSdl7EjdWkAoV5Qz9HXIZqxqHH+QVpEcF0ru
         sugXYSJ4CwcprNCV7dOHtqLQaX0f3HGMl/YwL/kpqZsZMik2MINjnkdMVHnADFFH9urE
         m0vQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783408894; x=1784013694; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RuL7lrFAhFFbC0DaxVnYi7IkQ87nYE6lxKOGL6gGHpI=;
        b=plMzQfR922PtFnGS5XA2VJfL6RDVBLwf0PZzoxkLAca0PRT7FLyXmraU00QlJug3IN
         cLt+bzRgR9BldahYGoennkm3SBHH/mTwNKhd6WucaikwGTB0X/5vHDtDD4LR8jqBEMXg
         cVYxEslyJIiuasj9zdeDHEpOafrV9kDl4nhgNh8m0SCnvqjMi00eJkJkPbnka6pU2LBu
         plVg5ZcRfnlhA/QdwpWsnXG9X/0C0PVJO7AKZKQkWX7yqzd4JtZrWr1omfiCvh07Ww1X
         ybwIdITVQgJkOEjI7OXUnR5pI81QZqYTby0b+M0/gUxv7D25q4YeIlFwa/sIx2R17//N
         sNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783408894; x=1784013694;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RuL7lrFAhFFbC0DaxVnYi7IkQ87nYE6lxKOGL6gGHpI=;
        b=a9Q39o/xV9pr6Bs1nRkiQSXtjDps6ZfwxFclRaOel8q42mCueDZc/yW9BAZ9cvn5Rl
         q8x+DbwX+iR6I1hH3YxW7e8PROIoFzsUBcCXaKfxci4RcuLi05iWfGSPZJg0AULJmnD/
         LZYRaQxs31helMtPzbAjoJxOq+37FjrcpUgyKWbXXZMlUTDT1KhBNPlwwMKKHLwHbkis
         qhselGJDPPt6usHvPVp0Ov477zNr8f8Lw6XB7g78xkCMfCtjznzqAbzeR1RYj9H3ALdm
         oyt85NsVQrxStcFv7WvSmwo1NUgXNljGl+4od1gVUlYnkBw+3TJ2J0Wnah+HTlIezRSy
         LBbQ==
X-Forwarded-Encrypted: i=1; AHgh+RqzOu0F6lb3O0YxgArCoCdkudC7fR1XHKSd3LUTOIoj5Y+bJFQ5y61GATg61QmwDRyt0SD/NUnEA/hldeTZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwGg3Xd1BP1m7Mstbi62aFZmd7LtpbV0hymBhqOYSi50qzeL86j
	wdeML+4T0Do8pVMTsQN3vP37yWT0CbrSUpXzcWloBUACSpQn4JPuU5+88NpftE/aViNZNcSndKy
	2usLtRvLVEFiYsW4aPemE3AH1i0pq8xuZs7FGPCh/
X-Gm-Gg: AfdE7ckVVKUYfF4YK5US5NdPkM0vOgApydhdav9HyqNc7fWR+uDvcRuoPt1HBK80b43
	+qfNERqf9GADI8Wm5A58yQBHd63aGs32FqnWOAzT3ygwOBkdqn4ejI4NgBlIXC3spjOoIetQI2f
	v99ruiajtv91uYJFQtzoDVWSoDpLIlbjPYvItAvCf5Tl3KNof/Afa9QSsLPXZ0BIQLMzlzS0qIl
	WoL+z4XSMzrk3Xzt9vFYUbF56LZvtv27tw40j+bJF2D5Yjccvm7AeJjUkD7hv9xBv4yQqOMPKeV
	Td0V0uDkjvVHGznVDtGwzgFK05qjYBYviQECY6n+u8pli0Q49aUJMHdU00FEBg==
X-Received: by 2002:ac2:4f05:0:b0:5ae:aff3:3eab with SMTP id
 2adb3069b0e04-5b00ad136f4mr95410e87.3.1783408894149; Tue, 07 Jul 2026
 00:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707064235.1386552-1-souravpanda@google.com> <20260707024744-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260707024744-mutt-send-email-mst@kernel.org>
From: Sourav Panda <souravpanda@google.com>
Date: Tue, 7 Jul 2026 00:21:22 -0700
X-Gm-Features: AVVi8CfKV_0_sx6GsBkVajWa1tfSd9GrFQw1r5LpgNz3KY7jvpoCzYNvR5XKQh4
Message-ID: <CANruzcTiDCi_xg=FyykAgnrstvwGqzRDOeHQxu6LAJ_LdYDygw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] mm/hugetlb: Dynamic, NUMA-aware HugePage Cache &
 Free Page Reporting
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: muchun.song@linux.dev, osalvador@suse.de, akpm@linux-foundation.org, 
	david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, mhklinux@outlook.com, 
	fvdl@google.com, gthelen@google.com, mike.kravetz@oracle.com, 
	pasha.tatashin@soleen.com, rientjes@google.com, riel@surriel.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 11:57=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Jul 07, 2026 at 06:42:29AM +0000, Sourav Panda wrote:
> > Overview
> > This patch series introduces a dynamic, NUMA-aware HugePage Cache,
> > backed by a kernel shrinker to safely return memory under pressure, and
> > integrates it with Free Page Reporting (virtio-balloon) for HugeTLB,
> > specifically targeting gigantic (1GB) hugepages. The goal is to solve
> > the tradeoff between allocation latency and memory
> > fungibility in virtualized and heterogeneous cloud environments.
> >
> > ---
> >
> > The Core Problem: Allocation Latency vs. Memory Fungibility
> >
> > With highly heterogeneous workloads, latency-critical applications dema=
nd
> > gigantic hugepages. However, dynamic runtime allocation of 1GB pages
> > from the buddy allocator (via CMA) is slow.
> >
> > To bypass this latency, operators often pre-allocate hugepages
> > statically. However, this locks up the memory: when the HugeTLB
> > workloads are idle, that memory is completely unavailable for other
> > buddy-allocator workloads (e.g., page cache, anonymous memory). If budd=
y
> > memory is exhausted, the system will OOM even if gigabytes of HugeTLB
> > pages are sitting idle.
> >
> > This series resolves this challenge by delivering Dynamic Fungibility:
> >
> > 1.  Dynamic Caching: Intercepts freed surplus hugepages and recycles
> >     them into a NUMA-aware cache instead of dissolving them immediately=
.
> > 2.  Fast Allocations: Satisfies subsequent dynamic allocations
> >     instantly from this warm, local hugepage cache.
> > 3.  Kernel Shrinker Integration: Registers a NUMA-aware kernel shrinker
> >     to dynamically dissolve cached pages back to the buddy allocator
> >     under memory pressure, restoring host/guest memory fungibility.
> > 4.  Free Page Reporting Integration: For virtualized environments (Gues=
t
> >     VMs),
>
> I was going to look into this part, thanks for working on this.
>
> > cached pages trigger background Free Page Reporting via
> >     virtio-balloon. This allows the host to reclaim the physical memory
> >     while the guest retains its Vmemmap Optimization (HVO) metadata
> >     savings (~14GB saved per 1TB VM)!
>
> Why "!" - that's 1.5%, seems surprisingly modest.
> Are you sure it's working as intended?

I phrased it poorly, my bad! Thanks for pointing out Michael :)

That ~14GB is only the guest struct page savings. Meanwhile, the host
is reclaiming the full underlying physical memory of the cached
hugepages via FPR. I do not have a number for this yet.

Let me reword this in the next iteration.


>
> >   +---------------+   Slow Allocate  +---------------------+
> >   | Buddy         | ---------------> | Active HugeTLB Page |
> >   | Allocator     |                  +---------------------+
> >   +---------------+                    |                ^
> >     ^                                  | (1) Free to    | (2) Fast
> >     | (3) Under                        v     Cache      |     Allocate
> >     | Pressure                       +---------------------+
> >     | Shrink()  <------------------- | HugeTLB Cache       |
> >                                      +---------------------+
> >                                        |
> >                                        v (4) Free Page Reporting
> >                                          (Host Reclaim in the case
> >                                           of virtualization)
> >
> > ---
> >
> > Patch Series Structure
> >
> > Patch 1/6: mm/hugetlb: add Kconfig and basic cache infrastructure
> >   - Introduces the CONFIG_HUGETLB_CACHE option, hstate tracking fields,
> >     and the HPG_cached page flag.
> >   - Establishes the clean helper API (hugetlb_folio_is_cached(),
> >     hugetlb_cache_remove(), hugetlb_cache_add()) and updates
> >     remove_hugetlb_folio() to be cache-aware, eliminating inline #ifdef
> >     blocks.
> > Patch 2/6: mm/hugetlb: implement cache recycling and allocation
> >   - Hooks up recycling in free_huge_folio() (up to the cache limit) and
> >     allocation in alloc_surplus_hugetlb_folio().
> >   - Implements MRU allocation policy for maximum warmth, poison safety
> >     checks, and MTE/dcache cleaning.
> > Patch 3/6: mm/hugetlb: add sysfs interfaces for cache
> >   - Exposes global and per-node sysfs attributes (max_cached_huge_pages=
,
> >     nr_cached_hugepages) for dynamic userspace control, including NUMA
> >     memory policy scaling.
> >   - Supports dynamic delta adjustments (+1/-1) to safely scale cache
> >     sizes alongside concurrent background reclaim operations.
> > Patch 4/6: mm/hugetlb: add memory shrinker for cache
> >   - Registers a NUMA-aware kernel shrinker to evict and dissolve cached
> >     gigantic pages back to buddy under memory pressure.
> > Patch 5/6: Documentation/admin-guide/mm/hugetlbpage.rst: document cache
> >     interfaces
> >   - Documents the Kconfig option, sysfs attributes, and shrinker
> >     behavior in the admin guide.
> > Patch 6/6: mm/hugetlb: support free page reporting for cached hugepages
> >   - Integrates the cache with the Free Page Reporting framework (virtio=
-
> >     balloon), introducing the HPG_reported flag and the
> >     reporting/isolation/draining lifecycle.
> > Sourav Panda (6):
> >   mm/hugetlb: add Kconfig and basic cache infrastructure
> >   mm/hugetlb: implement cache recycling and allocation
> >   mm/hugetlb: add sysfs interfaces for cache
> >   mm/hugetlb: add memory shrinker for cache
> >   Documentation/admin-guide/mm/hugetlbpage.rst: document cache
> >     interfaces
> >   mm/hugetlb: support free page reporting for cached hugepages
> >
> >  Documentation/admin-guide/mm/hugetlbpage.rst |  34 +-
> >  fs/Kconfig                                   |   9 +
> >  include/linux/hugetlb.h                      |  45 ++
> >  include/linux/page_reporting.h               |   1 +
> >  mm/hugetlb.c                                 | 590 ++++++++++++++++++-
> >  mm/hugetlb_internal.h                        |   9 +
> >  mm/hugetlb_sysfs.c                           | 158 +++++
> >  mm/page_reporting.c                          |  10 +-
> >  mm/page_reporting.h                          |   6 +
> >  9 files changed, 844 insertions(+), 18 deletions(-)
> >
> > --
> > 2.55.0.rc0.799.gd6f94ed593-goog
>
