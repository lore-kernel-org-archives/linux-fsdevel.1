Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22BC3E2AC8
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 22:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780524894; cv=pass; b=K1OjjxZ6sh2S1ot5dKqJiR/sg3TBIXxolfAFEoGGwSgAMNEt82jbl/zuYjzoexb5A8OdGN8TJz4puIhtKiUuO9wWpSjkyDsIqc6eJBxAnILooak0Ov8ZEEAlsr6QVF6JLBWJIlZpLwHbDxE+zfwL9h+arJ86UaFQNr7KGqpGkI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780524894; c=relaxed/simple;
	bh=xgUe0AQGXjeGjvTj0ecs5Nu+F+iIOfUesQJXMInIf7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PFihkE7wruI15A90XAtZK5Xylm3wAcLkw6t7xeUaH1O7OK9pD0aWzIxh/acHllzvTiMJbsMFRL5ZPTCTu7N8+W58YdOa3jpdfCs4yJTQTDVY6SzuqaBrzUwM6A/fBHTXIBAqpwrJnc/R2OQXaBEthBLRv06kdkmF7fpHC3Yv8fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ng1TB4Z8; arc=pass smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ng1TB4Z8"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-9157d3f2098so11019485a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 15:14:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780524892; cv=none;
        d=google.com; s=arc-20240605;
        b=JK/7CxmF768rJ2J0p4Hnk6f+G2WsSUsN2M9TsdKxDs9m/fTlIDCfmL8rJSYYLjoylr
         wR+q/7yNqubo2waiJwY0hAUORQbS8PZsIyjkgVNIp1s8dNceeHfusDKGEsxeuEvLCb4/
         7Dn0E1XYMRG3yzJLS8H4S2htX9VOX3bsEUpQi5trlytbXdfJltKLjN9dOvZc15dUwQXA
         AikU6hH1/1wqvnUeoq/79NKThcLlclOCHh1dCLdOIWzKtPDucqMOfNkhInsB4dWT+oXg
         V8uC4wU2RS6HOd0dYfjYstSzwyVQJp1C6USow74bO5dnxEEzT3+EW7LkPOEVWncLyZvr
         aKGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FmzDsup0sFlBNWhGg0+0FS+tEwpLPYz+Yh+3amtQtVM=;
        fh=ITrOT4M/UrWeppW2tQd3kZ7ptl4UeZE4ZdQD1KQCPy0=;
        b=NgVJc/xZxSMQ+ShFqA3Kzyz2y+gIYseapSi2ngIEuehU+4BqxSj1b83CEY50ZrjAuC
         ZENR38xIpXGLvUdD0r4ePFLgPMQ1xEHpPehrWN0EV9WVCFeldDQqNs8qMCuVjsbdYDy0
         1JmDT4DsyuzE8tiqrysNgqXfHUlb5WcmGIGk01CUy7hIcEIB+xB5lS7/H91mYMx9VPh4
         1K6eUpeF/quFItpN7sZXHzxgSwcvxnwPcZTHOWdY5MrujsOhF6VLTZfiP/fWpLE6Ai6g
         s2/I4xsVKgvxnBN2Z42c5/yHh1qZ6Eaf0NTAZiXUE1AaLSR1JDBVmJtRWGgOY3fFXIBs
         ZOtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780524892; x=1781129692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmzDsup0sFlBNWhGg0+0FS+tEwpLPYz+Yh+3amtQtVM=;
        b=Ng1TB4Z85ZVBVNOqAvlL6uAcjQAQkUjHvLTKrSXxegfQJZtKP/6x1lL9lSpJ0ZkmGe
         rFJv4W4ezg+mU8NkW7iAv3Wea+HZEPm3jn1CoGOK0eLEXUhA+CfUTx/NFT1xa2gHACrP
         4XPIBJtrSyDSsNz7j/cbASBDpWgkRY7ElCh7gvscCClTTxh9yDKKIDWoIKzCEtRzTGpF
         PwmA7RrkOo15/za3nzC6Mo+w2Pm559rUOV7aEpFyOu+8MSIRnKENPq8OIvnwjIRNBUfJ
         S/bRjS9ESrJjUXUl0F6/T/eEeaUUCPPRzQSgMJRydDbEHpH/Zbi8YAXLAaHgtgTe9v4u
         qyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780524892; x=1781129692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FmzDsup0sFlBNWhGg0+0FS+tEwpLPYz+Yh+3amtQtVM=;
        b=M5fxlh8+9OZRaKXLesU7rJ9S6MHhw2/64jWFwye+ZMJ67X1WybiLCW6EzsYGGQspME
         PZThyDtUpQ4fmSuHkUdI7l/W+eNXslNG5g1Ap9gURAV7Od/8J8yolwdN3dTkKF60vRdd
         cGUDezvWagv308yMm2TOlKEFNYksd+bZHEicwKdL4BPXm5uc3NVk7wIIL4noiYV6O3aR
         XCaRJ1vih2xtRPpPMnflB5AQZ52Q75VpB8fFjZK6MkXQVxaTNu6A4XAEjm/57a5q3xDZ
         SYrJ5LQBzt3iFG/MNU1WYeG4vg+gIL6JptooHlyJFToapU7RlgsQeD/e1cBuXbWWpFE0
         N8JQ==
X-Forwarded-Encrypted: i=1; AFNElJ9raI4Pivflm3ewByAe+QlvBvhxAYz4RnuivOBd0SwkTVa7NKH0QWJOcNncyinc6jg9CBA6vGYFe6YcLWC+@vger.kernel.org
X-Gm-Message-State: AOJu0YwOhexgPKIIM6y6cmRCogw6SxY9DpuH/Lbx3ieJ9mgjea5riave
	gZLrIanjsX4uO3rqPW7smfPdwA8nMME4joG7AdywwuZQ4qlq0sVfF+whw6cei2i37okOvMR9kFI
	5c1+QsFpQijeF+2PlRyB0RZB2XuQj5XI=
X-Gm-Gg: Acq92OHPbKxuVpWlzP2KXr5tri3gPHWs+HP8d3SFcoHNfR6H3Ov8vKLUZ2CeVVvF4K4
	LpfUDIElsHDdpPVX9CTErh0JT0hzJwgMv+vEhEmajVQ7stg4dT4DHIMwM3291tJA6/twvOv9bmt
	ykOm8v1fitCAHexfZt7i7KVt6cYOCUG5otc42xxk9Sj/dV3iVwXcEW4G/vmrB0HJDjlkSR5Eau7
	3yBvMifHBXnLJK/fY7ux/9ElzmZntabDcWn+7QNR96BQ2lOpll9tNH5kKpEtT6uYHFCN5qdQ0If
	ye1Zo6dzsRHrdIEHdPuh2v4Gb/1DN0b5BUqYzclzQahbA0Op
X-Received: by 2002:a05:620a:40c4:b0:915:9c4b:fdb4 with SMTP id
 af79cd13be357-9159c4c0fccmr119218285a.22.1780524891016; Wed, 03 Jun 2026
 15:14:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527110147.17815-1-tao.wangtao@honor.com> <70377626-500d-46f2-a3f5-a0d2914ce365@kernel.org>
In-Reply-To: <70377626-500d-46f2-a3f5-a0d2914ce365@kernel.org>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 4 Jun 2026 06:14:39 +0800
X-Gm-Features: AVHnY4LRywF8yijh3uWS4ASgIO-DqQ0mxyZBegdnnjWwYExKtCPyz-v6JopNV6g
Message-ID: <CAGsJ_4zg8+pVDwtsJtxxiC1ahJ9MR56Ue8VXCt_VrQgcXES2uQ@mail.gmail.com>
Subject: Re: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred anon_vma creation
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: tao <tao.wangtao@honor.com>, catalin.marinas@arm.com, will@kernel.org, 
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, akpm@linux-foundation.org, willy@infradead.org, sj@kernel.org, 
	kees@kernel.org, luizcap@redhat.com, zhangjiao2@cmss.chinamobile.com, 
	kas@kernel.org, ljs@kernel.org, hpa@zytor.com, liam@infradead.org, 
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	jack@suse.cz, riel@surriel.com, harry@kernel.org, jannh@google.com, 
	jgg@ziepe.ca, jhubbard@nvidia.com, peterx@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, lance.yang@linux.dev, xu.xin16@zte.com.cn, 
	chengming.zhou@linux.dev, nao.horiguchi@gmail.com, matthew.brost@intel.com, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com, 
	pfalcato@suse.de, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, damon@lists.linux.dev, shakeel.butt@linux.dev, 
	ryncsn@gmail.com, jparsana@google.com, dvander@google.com, zhangji1@honor.com, 
	wangzicheng@honor.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 4:25=E2=80=AFAM David Hildenbrand (Arm) <david@kerne=
l.org> wrote:
[...]
> >
> >  arch/arm64/Kconfig         |   1 +
> >  arch/x86/Kconfig           |   1 +
> >  fs/proc/page.c             |   6 +-
> >  include/linux/mm.h         |  38 ++
> >  include/linux/mm_types.h   |   9 +-
> >  include/linux/page-flags.h |  34 +-
> >  include/linux/pagemap.h    |   2 +-
> >  include/linux/rmap.h       | 165 ++++++++-
> >  mm/Kconfig                 |  22 ++
> >  mm/damon/ops-common.c      |   4 +-
> >  mm/debug.c                 |   2 +-
> >  mm/debug_vm_pgtable.c      |   2 +-
> >  mm/gup.c                   |   6 +-
> >  mm/huge_memory.c           |  16 +-
> >  mm/internal.h              | 171 +++++++++
> >  mm/khugepaged.c            |  13 +-
> >  mm/ksm.c                   |  43 ++-
> >  mm/memory-failure.c        |  11 +-
> >  mm/memory.c                |  19 +-
> >  mm/migrate.c               | 126 ++++---
> >  mm/mmap.c                  |  15 +-
> >  mm/mremap.c                |   4 +-
> >  mm/page_idle.c             |   2 +-
> >  mm/rmap.c                  | 690 ++++++++++++++++++++++++++++++++++---
> >  mm/vma.c                   |  76 ++--
> >  mm/vma.h                   |   4 +-
> >  mm/vma_exec.c              |   2 +-
> >  mm/vma_init.c              |   1 +
> >  28 files changed, 1279 insertions(+), 206 deletions(-)
>
> Hi!
>
> When I saw the diffsat I was concerned. Going through the patches made me=
 ...
> more concerned :)
>
> This is a lot of complexity. On top of something that is already so compl=
icated
> that I fail to grasp most details without regularly taking a look at the =
nice
> figures Lorenzo created recently.
>
> For example, I read above "since child VMAs do not need to allocate anon_=
vma"
> and wondered how that could be part of something that is just done lazily=
. Then
> I had to learn in the patches that there is some additional "Child VMAs
> are created as ANON_VMA_TREE_PARENT and do not allocate anon_vma" -- excu=
se me,
> what? :)

Yes, that part is quite complicated here. There are two cases here:
1. A forks B, and B inherits a VMA from A. In this case,
B's VMA gets ANON_VMA_TREE_PARENT.

2. A forks B, and B later creates a new VMA via mmap().
If a page fault occurs in this new VMA, it gets
ANON_VMA_TREE_VMA.

In both cases, we need to upgrade B to a regular anon_vma
when B becomes a parent and performs a fork().

This may be a bit off-topic, but I'm also considering
whether there is a chance to work with Suren to support
case 2 via a GKI hook in the Android kernel before
Lorenzo's work is ready.

Even then, the optimization would apply only to the case
where B never forks, allowing us to skip the anon_vma
"upgrade" entirely. That assumption holds for most
applications, although there are a few cases where it does
not.

I'm actually hoping Android could eventually disable
forking for UI applications altogether. From what I've
heard, some applications use fork() primarily to evade
LMKD (the Android low-memory killer daemon). For
example, a child process may monitor the main process,
and if the main process is killed, detect that event and
request a relaunch. This is one way some applications
attempt to keep themselves alive indefinitely.

But even if we limit the optimization to the subset of
case 2 where B never forks, we still need to handle
mremap(), VMA merges, VMA splits, and similar cases.
That starts to become quite a headache.

So please just ignore my rambling if it turns out to be
nonsense :-)

>
> Reading about VMA refcounts made me shiver. Reading "Holding only
> folio_lock(folio) cannot guarantee that the split
> operation completes atomically." confused me. Learning that we have to in=
vent
> interesting ways to make page migration mutually exclusive to free_pgtabl=
es()
> concerned me. Figuring out that there are arch-specific config options an=
d
> runtime toggles is a clear warning sign.
>
> Seeing test_folio_unmapped() was funny, though (why?! :)).
>
> I think this patch set has a noble goal of reducing anon_vma overhead whe=
n anon
> pages are not shared during fork. However, using anon_vma for them actual=
ly
> makes the overall implementation (e.g., rmap walks, locking) more consist=
ent and
> simpler.
>
> Even if we could be convinced that most of this here is correct, how shou=
ld we
> reasonably maintain this increasing level of complexity here?
>
> I won't echo what has already been said in this thread (and I didn't mana=
ge to
> read all, unfortunately), but for such big and invasive work it's often b=
est to
> get in touch with the community earlier. Otherwise, you might end up wast=
ing
> your time.
>
> Ok, arguably, someone who writes that code learns a lot on the way. And i=
f this
> code really was written by one developer only, I tip my hat! I'd be curio=
us if
> that code already ran somewhere on some Android kernel out there?

I heard from Zicheng that they have been running this for
months and it seems reasonably stable. Please correct me if
I'm wrong, Zicheng :-). This really should have been
discussed with the community earlier.

>
> But adding more complexity on top of something that's already extremely
> complicated to save some memory looks like the wrong direction, really.
>
> I was excited when Lorenzo started working on a completely new approach t=
hat
> would focus on improving the common cases while trying to reduce the over=
all
> complexity. Because I think most of us really dislike anon_vma. It's stil=
l work
> in progress, and I am sure there are some rough edges.
>
> But fundamentally, I think we want to find a new design that is just natu=
rally
> simpler.
>

+1

> Lorenzo has been hard at work exploring various design options (and I'm a=
fraid
> he might be one of the 3 people on this planet that understand anon_vma i=
n full
> detail), so I suggest we wait for a redesign proposal from him and see if=
 that
> is doable?
>

Thanks
Barry
