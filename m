Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793122721;
	b=nxbdF97QaBMtnT/pjREFW9yjYQmm7Z9unP30PX9scM+mnIBzm2kjWibjihMQxrexuCVf
	 SZAPpu7LtDvlgb1H8veaevfEPhR6IQtIyuAKC7c7Cf/C37wPIlcL6oeqtbNCX3XnVV44F
	 KHvv3MBdENjDi3Tg7QeD3/5R/qNieaKbL3QqemvtDwZDQQb/ex9CYavlsWcWfa186yyn1
	 vWHGoG1pmm6pLr3JpioxbefctuX9+C4OWEt3XlXzRWYY9HE6nEKRs7h1JqoOjI8ZoGLwA
	 8xPW0GjEgj5RHbKcHXJhSXetUWM/IQ6RE/XCeS5GziKzz8UERqBoMp5tUF+0rfUpp3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122721;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=AYi2YiR3kh+gzZk6CrM84tIidytqPHRNR76c45jsmXI=;
	b=ak/LmOTR9No5/LiuHwXkIIVNtiwICcCbZhUh3GmHmokKPCYw1TTC11gVBv7EjxvZnKbL
	 DDFPihYl5iWy0iegfyLujVhBpwPtMASJjZTZFgkwqSeENlIq1c/NDUl/XFqZcDVWIfcYh
	 aA5vEMS8lCY8ZLvS7i8D4LJySS4MPMK5u+iI4+zODF7oCLbroEDrL1e9fGf0BfHhWw0b1
	 NAsRUpBenLzNkc4MgTOpaO18EiIi0hwshizdUGxNeGXYa+08ajD90PIo4rKmNmN8zHjBi
	 3hmrJ4S/nCvtofPQNKGyejNFYMc8CedLwKqapFyxy8TCqodZQaSDFJvZGTphiI8HJ7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TMbu8PxL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CD0606A31E
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 17:38:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76CD0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TMbu8PxL
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso1001a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 10:38:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793122719; cv=none;
        d=google.com; s=arc-20260327;
        b=eYS6kfCUsmFA34UJq7IOZhlGkcEUFHRySJJjRQBw8Oxtekofb6t7enHY/YVVCnivhE
         efI6Q1KpWCkjEsnOkym55Jk+w4Rl08L73pxn3DkfNMbBYsybfemrV49UMKuq9yui79ai
         wKrAn8kvzskO19/TstR+SfjzCOCOEuYgGcItdvmLFnc5n3LgBZY4FQ8vtpK0kIey+Rib
         BNOU6CedheWNABleyNrAkTOgVd41/FP1vL4+clgBFF4Hr/iMmh+jrHJICQnq6s/RcOno
         12B4xnPIisCfYi9ACBaFgzEECUdPX8EpGoztpTiK2TDo23pt92WSV4hLN1pbT42bkgqt
         xTXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AYi2YiR3kh+gzZk6CrM84tIidytqPHRNR76c45jsmXI=;
        fh=BMqn6QsE+F2xPK74DyS00+v3P+1QQpjZfQthWRgC3nY=;
        b=Uwh3GArBUpxJSJpRKgr1H50XHWO910L4sjwIRzaHCOHbC8SPMCg0rk5DyEoP/y5reP
         2FyUkwWL0QFaO+zZfkLBjbJlk6GwPiUz2b6y1KJF+mjLqactjGG3vxR0SoAg+VjAkg2o
         +QA2adcwiVbVNPcxoP8GMPsLIR4oVxW4PsUgsuWBInfKJm5AhsqTK4JZRw5AvNkVaWI0
         PimZoLOwJtvucZ+WxEvTUVmpSDVLgpuM6CPiH0saCqiBLr9tNuXlXXaUZsp0Dl4mEaeV
         tu5gVnmoPDloYgiioYDB+m/NqXZvshFHtdiSmSWu43V30luKIwT3MZiGKGp0vrqwpUHo
         h7gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793122719; x=1793727519; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AYi2YiR3kh+gzZk6CrM84tIidytqPHRNR76c45jsmXI=;
        b=TMbu8PxLhpBm5Jxc+UmD3OrKaB4W+TrO+HcdLK/qemtnz4THsUOJblzPEUuFNQdsAX
         xVppISd9HZVk1k52dXnBDZH5JY2olDDSO95++GZTKXt09LrvWQXh0bdmoGTLejAK1OLt
         bxZAkxblGRQiGMML4G9URFa8xQWaDlL49VzCVKznumP2+MyKHmYFopFrp7Vomsp36yZT
         yCc03PZELOyQAfukDHyz3vOgAGIADyvURsSBd2Fsfa6RJBwz/JWJp+HSEvxtvlpPmo9U
         hDMP72JYBeOYHs8QzW38V9/J7Ub9YckAD4l0ZmHIvx0H8IlISifANZcUpwjvV3oxhTkL
         uyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793122719; x=1793727519;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AYi2YiR3kh+gzZk6CrM84tIidytqPHRNR76c45jsmXI=;
        b=bV5qxvrUMloigbnhZIvpoC7rxswM3UHmKzJY+UCxPMZZvYzqDtEuUE3aKJcuySlVZ2
         NMaB/3ks1cmAdgaI/ZMyAzq9YHIOHy5hEh5Om3e41voBkSOKArOtD63/ALyNx19Z9CTF
         iY818G29lAiW9PGbUY4ml8TEWCpbe7joUKQFk7sFiqcSQwG+t3Npwk1Jel5o9dLEg8+S
         1gc9lnRz/IM4OIjYDFQzvF33PzkZH6kgyp7lxFMnfLFzHACmpJgdpusXIKRdDwTW6nsw
         5XOM1aF64BiPx5RKuZHdvyOhV0599tPSH4S78rUlnoq0kGxM9hTTq6gmcwG0jeRlYP8a
         WIew==
X-Forwarded-Encrypted: i=1; AKwUvBy0VngTiqPTR5p8eI6VGaTywO76wHdx2i6ZTtvMXDbcCBYNqrCYDrDrxTTehy0JKk+v+fdCORLvjqI41AMd@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1ZZI7rweFfh7LIS4zIuuoQxaXAyi+fxdL5TduVtzAOB664IcA
	BsG1wjG9nuTQQCgTwsIuHEGF8LhrKD/IXbxFgMcTIB7ZNBVw2ztUAWXyabQHsu9VEY+9jHLycJp
	xI4dUgX8jq4vTCB5nXeOem/5MwRD4hVPp6YGcoSVo
X-Gm-Gg: AYBFou1wBsIZvjFOHsIA14NVihAMsgwfafHFEf4vOVzxdCa0xlj7gv6JuvOhetjUuAH
	Fx1aHBeTcZy0wJozcwVY4qc0X6ig3T/EbouFHYa28PvPFUGbGvgDBg/b1KTGZ31v6SLDQFkEOoZ
	sM34T1T6xh6BEXOuiHeupfsHChy/YWwLdRizhfGbm9aYOs+fTtJNiVrUZZYiCNoeJKw07xBhEqT
	2W71CMuL/rIaRd+p5hXZfc06D4rALUr0gk8BkQbOehHOcmGmOVm87vnqf7paVdPe22xspwIKCKL
	7pE/owDYHouc53qKl5vcuK7ESUt0ONys7iUv3spj82HK+umcrDOghnWpP34eYzi1EWrwHiANZR4
	+253DlvClgu5ZDZcbAtzXm8BuxMOaq4Pj0LFUtlCu9rV2fhC9zEubFxpmEYnYrqQVDA==
X-Received: by 2002:a05:6402:a2cf:10b0:6b4:597f:50ed with SMTP id
 4fb4d7f45d1cf-6b4994c5b30mr2214a12.5.1793122718174; Tue, 27 Oct 2026 10:38:38
 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-23-6f74bec9a5bb@kernel.org> <auBityGTDQjXURWg@gremlin>
In-Reply-To: <auBityGTDQjXURWg@gremlin>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 27 Oct 2026 10:38:22 -0700
X-Gm-Features: AclHuK8I8xcfhrxH9JH4rYz28CrMoohsxda9QortkIHbiI93aH5ozWron9iLPAM
Message-ID: <CAJuCfpHEHPNj9DKOGbVHYCUsmLf==-XkhzBAR94gNt_ErhdnnA@mail.gmail.com>
Subject: Re: [PATCH 23/46] mm/userfaultfd: write-lock the VMA before waking
 waiters when unregistering
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Kairui Song <kasong@tencent.com>, 
	Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Lance Yang <lance.yang@linux.dev>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-cxl@vger.kernel.org, stable@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 1:43=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> On Tue, Oct 27, 2026 at 12:17:43AM +0100, David Hildenbrand (Arm) wrote:
> > userfaultfd_unregister() wakes pending missing faults before clearing t=
he
> > VMA's userfaultfd registration. With per-VMA fault locking, holding
> > mmap_lock for write does not prevent another fault from queuing after
> > the wakeup but before userfaultfd_clear_vma() write-locks the VMA. That
> > waiter can then remain asleep indefinitely.
>
> Oof.
>
> I guess userfaultfd_clear_vma() only implicitly takes the VMA write lock =
via
> vma_modify_flags_uffd().
>
> >
> > Call vma_start_write() before waking waiters. Existing fault handlers
> > queue themselves before dropping the VMA read lock, and new readers are
> > excluded until mmap_write_unlock().
>
> Clearly an oversight from the VMA locks work. I guess was always a Hercul=
ean
> task to catch every single point at which there is an implicit assumption=
 that
> mmap write lock ~ readers (esp. faults) excluded.
>
> >
> > Fixes: 29a22b9e08d7 ("mm: handle userfaults under VMA lock")
> > Cc: stable@vger.kernel.org
> > Reported-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

Thanks!

>
> > ---
> >  mm/userfaultfd.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index 669f71d485d02..7e30b5ff17be1 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -3991,6 +3991,9 @@ static int userfaultfd_unregister(struct userfaul=
tfd_ctx *ctx,
> >                       start =3D vma->vm_start;
> >               vma_end =3D min(end, vma->vm_end);
> >
> > +             /* Prevent new userfaults from being queued after the wak=
eup. */
> > +             vma_start_write(vma);
> > +
> >               if (userfaultfd_missing(vma)) {
> >                       /*
> >                        * Wake any concurrent pending userfault while
> >
> > --
> > 2.43.0
> >
>
> --
> Cheers, Lorenzo
