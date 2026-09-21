Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E1A5158BB
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 21:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790027823; cv=none; b=UReOzYS92SvIye+BMloJBR+Bgp3TKT93pZKW3qmCtXbpzhzDVHzDygqBVsv3/NbzOm21fYp9ZgmK+3CsXx6SaLV7kgp6wR4U3AIMRc4q9b7a1DM96JaTktkXou4DSTYcM4V+2wmqUpbiZ0OhnlM7Mt1A/0H4EbVK0vdhEFAMPms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790027823; c=relaxed/simple;
	bh=SzM2SvHPjiWBwoSeU0UqgGIeTyIUlBCr8zzL/bbLfb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f0ZyTO5+IjoxgNcEvMXJsjzHb86zIUS/Qjz5oRC5esCMhoVt6D01cecK8oYr/3XonKOagDRX47gU5mGwXaWlMYIXxbMZObAE9k4syqHTVAoQqafZJShVlq0riO08OEqFeSEki5LVsCj13vJi8pWxs1bl3lk2/Pc3dkOeyOBHtWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWLymRA4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWLymRA4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7EF1F008A3
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 21:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790027821;
	bh=qSVVL7TW61oF74m7rSQbYkMlEzrUZT28aAJlLtjv558=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UWLymRA4dRaUVCNgxbyFuI0sgH1RptweTBoHL1aoPAuEMPHD2GwK9pr0Y2/F8IjtC
	 AzsMOelpBRu0ibT+YgaKcQhY81MQunCrgiY+70Hj0oQsicaHoDvg6wzTkgWnekys1o
	 nH7DX+jrIEledtA+S+0dPk5Gq2D1lzBOG37kumVi5PzgS9UymwW6pillHTZq/mv/oL
	 g3c/aJpf021oj019kcIeqxkxwSe2KcGcCKuIfazdIUADNGLvQU2/+s9zuMNrre1uHN
	 nMEU85phY2UHu8nW59GB50G6dPJ9t6WeC20yS8fp5o1FO1Na3An/OIR6q4HgDIOiXW
	 TZ3uhGwcAxTCg==
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910ad2273so417761985a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 14:57:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByRHKrd6+t9ayFZ7CwR8iwVywGsIP6G8Yi+2zw7d5koZ4EYZatuKU4IZTLzpm+3VHBPw/EvL8/BsqdE9GtK@vger.kernel.org
X-Gm-Message-State: AFuF++l5nnNp/foe/kssd5HcMz0bGJY0oe5/HnSsLTD2KvcobXFfa4dH
	2ip8rsH8wU9SvQFpqSbyOXviVJQF/sMte1LPb/BxbE887GzH4/Sbh9HLkHYeQ5+dZB/aoDq/rFY
	QpVkCwus4ebrdAzc1ZAL0BPA5gtlRGw0=
X-Received: by 2002:a05:620a:2893:b0:937:d6e8:59b0 with SMTP id
 af79cd13be357-93c15d69efdmr230732985a.10.1790027820912; Mon, 21 Sep 2026
 14:57:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921152449.629486-1-alex@ghiti.fr> <70cae945-3a4a-40db-96ac-5ce66a3fa186@kernel.org>
In-Reply-To: <70cae945-3a4a-40db-96ac-5ce66a3fa186@kernel.org>
From: Barry Song <baohua@kernel.org>
Date: Tue, 22 Sep 2026 05:56:49 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4y8-wD0yMV8GCtCz5MfNrOKqUaTd+UgH=8MoP_nuvPnGg@mail.gmail.com>
X-Gm-Features: AcwNN1VSw5Rr4NROqiaRDFlkbhVNl6ttklStB_B4KIyo7Yo7DDoF7gUuyR6ZS_s
Message-ID: <CAGsJ_4y8-wD0yMV8GCtCz5MfNrOKqUaTd+UgH=8MoP_nuvPnGg@mail.gmail.com>
Subject: Re: [PATCH] mm: madvise: drop MADV_PAGEOUT folios at swap writeback completion
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, akpm@linux-foundation.org, willy@infradead.org, 
	jack@suse.cz, liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, 
	jannh@google.com, chrisl@kernel.org, kasong@tencent.com, 
	shikemeng@huaweicloud.com, nphamcs@gmail.com, baoquan.he@linux.dev, 
	youngjun.park@lge.com, qi.zheng@linux.dev, shakeel.butt@linux.dev, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, yosry@kernel.org, 
	chengming.zhou@linux.dev, kunwu.chan@gmail.com, tz2294@columbia.edu, 
	hch@lst.de, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 11:37=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 9/21/26 17:24, Alexandre Ghiti wrote:
> > On an asynchronous swap device MADV_PAGEOUT only marks the folio
> > PG_reclaim and rotates it to the tail of the inactive list once its
> > writeback completes, so the memory is not actually freed until a later
> > reclaim scan removes the by then clean swap cache folio.
> But we have the same behavior when just reclaiming memory ordinarily? It'=
s added
> to the swapcache and only the next scan actually frees up the memory.
>
> Wouldn't we memory we reclaim ... just gone, like in the sync case?

For synchronous I/O, such as zswap and zram, the memory is released
immediately after sync I/O is done.

For asynchronous I/O, such as NVMe, the swapcache is currently
expected to be rotated back to the tail of the LRU and wait for
another scan. Alexandre once mentioned that when he tried handling
async I/O the same way as sync I/O=E2=80=94releasing the memory once the I/=
O
completed=E2=80=94he saw some regression. So, delaying the release until a
later scan may allow swapcache hits before the folios are eventually
reclaimed.

But we actually have a problem here: this rotation, which puts
writeback folios at the tail of the LRU, is not reliable at all.

`folio_rotate_reclaimable()` would only work reliably if the endio
happens after the folio has been put back on the LRU head, rather than
while it is still isolated.

But nowadays NVMe is very fast. If we isolate N pages and perform
shrink on them, M pages may finish writeback during the isolation,
while the remaining N-M pages are still under writeback. M can easily
be more than 50% of N.

As a result, we can end up with the following cold/hot inversion:

LRU head
----- M pages whose writeback completed during isolation
----- other pages
----- N-M pages that are successfully rotated to the LRU tail
LRU tail

Now we can see that the M pages were expected to be reclaimed, but
they are not only left unreclaimed, but are effectively promoted to
the LRU head.

For MGLRU, commit 359a5e1416ca ("mm: multi-gen LRU: retry folios
written back while isolated") added the following code to reclaim
those M pages that finish writeback during isolation by retrying
`shrink_folio_list()` on them:

                /* retry folios that may have missed
folio_rotate_reclaimable() */
                if (!skip_retry && !folio_test_active(folio) &&
!folio_mapped(folio) &&
                    !folio_test_dirty(folio) && !folio_test_writeback(folio=
)) {
                        list_move(&folio->lru, &clean);
                        continue;
                }

This somehow resolves the cold/hot inversion, but leaves the M and
N-M pages with inconsistent behavior: some are actually reclaimed,
while others remain at the tail of the LRU.

For the active/inactive LRU and `MADV_PAGEOUT`, we don't have a
mechanism to restore the missed reclaim opportunity. Ridong's patch[1]
addresses this cold/hot inversion in the active/inactive LRU reclaim
path. To my knowledge, there has never been a patch to address the
same cold/hot inversion in `MADV_PAGEOUT`.

BTW, if `MADV_PAGEOUT` is an explicit hint from userspace to reclaim
the memory, would it make sense to skip the later scan and reclaim the
folios immediately once the I/O completes?

[1] https://lore.kernel.org/linux-mm/20260920132519.3369946-1-ridong.chen@l=
inux.dev/

Best Regards
Barry
