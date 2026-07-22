Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2260125B0B3
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 02:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784687943; cv=none; b=ZcFL6DEhl+8X02ElM29axBDsjfGPYFCwVXA5jcEtXw1mIdtoQam3ODkwgqAjbLBIgY2DXJcnTfenjkaztZZ7j7bUk7XQUH2+FqHias9COg8+Zye9MJp2UXRyuLA8ywB8H9rNM6pyqMvM2cpK3TxwU0PE2ULZQn3MkOh34lLK8+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784687943; c=relaxed/simple;
	bh=8gycsm2+xdXxejKQkW9ZgdDPe2993wRWrwcmZe/hVj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=snSs1rBlCXCFpsGmLcHCTyw7ELA2CKCqe4cHl+tWK5VyDQRc/84ziyzKCr9g7vWWW0pzPaQVvH4rHpmsT665MH7jof+J8Z97NBRcsaHHVvy4QUfvy9MkBb6zhZT3Wec75gPFHjrxJdyqNjJIFydcqlUOZeje6SJYA25j1FmR6I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chRTL9Es; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chRTL9Es"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41EA1F00ACF
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 02:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784687941;
	bh=BoG0ckj0uBMKx2AZzLaYA1Q3tAn31fS37fVnCHz+w7s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=chRTL9EsLf16R4S+Kyel8wXInS+rWxkSz0S2U524Cq48KKpIgJKcIWKay95XyzktS
	 mJYgADItDielMx4fK890aA2n5qW64GJp12BojL2HDIPOGC30lGWQfT9Sk0ZQzJSWrr
	 dD6H5kpK8/cZRB/u5MxYVBk8asVKyo5jfv67BjgJzSdi/WTiQBzK41okePv+cyXD3y
	 bNBkAxYs2UGv2lsoK0pKHaWQB3UrsruIofLCFQcz+utDsb0v2qyPTjtzZZQRmLLaPU
	 TUdURzfzdnQH4r5SBqk0jdurob/k1gTrHnljAJyQpeDchQbq8GFd1BDojlgchE8NF5
	 RvIbdke5ztxVQ==
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-9309d4ea213so690355185a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 19:39:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr6oZo8vGhWed0+5i7UKJLEPbmDfFF9eORw2uxjx5SNW4q2iME8+qen77dk+/0Om9yjp8QZkvBbs9V28XMc@vger.kernel.org
X-Gm-Message-State: AOJu0Yys4hGhcXjOna+6bmIEkOITq1+4TGui6/j8Dg75ZWFlkd4+b8T5
	4XHdo6FxU5QliF/cJ4r2FbmUq1fU8GtYNbVEJrT+CqZhDbaaMymhbJKzGO6XALTqRh6RI40btxe
	FjHm6cy5KZm0lqIsMchOp5wwF4bqvWJs=
X-Received: by 2002:a05:620a:199e:b0:92f:e20:8c07 with SMTP id
 af79cd13be357-930b3eaac01mr2131489685a.16.1784687940741; Tue, 21 Jul 2026
 19:39:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718093723.153324-1-alex@ghiti.fr> <20260718093723.153324-2-alex@ghiti.fr>
In-Reply-To: <20260718093723.153324-2-alex@ghiti.fr>
From: Barry Song <baohua@kernel.org>
Date: Wed, 22 Jul 2026 10:38:49 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4yvfGZ_2505PRWFHaqdmUvb3R77GFJSzpQ1vEFChAK+Lw@mail.gmail.com>
X-Gm-Features: AUfX_mzZn8SrKi477dFNexXRzw4N2jgyxaCJqdRLvjk79dxFEMzh2fa2OjDmik4
Message-ID: <CAGsJ_4yvfGZ_2505PRWFHaqdmUvb3R77GFJSzpQ1vEFChAK+Lw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: zswap: free synchronous-IO writeback folios directly
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baoquan He <baoquan.he@linux.dev>, 
	Youngjun Park <youngjun.park@lge.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 18, 2026 at 5:38=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> When zswap writes an entry back, it allocates a swap cache folio,
> decompresses the entry into it and writes it out. That folio is cold by
> construction, but it is currently left on the LRU for page reclaim to fin=
d
> and free later. This wastes a reclaim scan and keeps cold memory resident
> longer than necessary.

With MGLRU, we already have code like the one below that reclaims
folios directly without requiring another reclaim scan, whereas the
active/inactive LRU path doesn't have an equivalent mechanism.

                /* retry folios that may have missed
folio_rotate_reclaimable() */
                if (!skip_retry && !folio_test_active(folio) &&
!folio_mapped(folio) &&
                    !folio_test_dirty(folio) && !folio_test_writeback(folio=
)) {
                        list_move(&folio->lru, &clean);
                        continue;
                }

>
> For synchronous-IO swap devices writeback completes in the calling contex=
t,
> so the folio can be freed right after the write rather than left behind; =
do
> that. Because it is freed directly rather than through reclaim, it is
> allocated off the LRU: dropping the last reference on a folio still on th=
e
> LRU would trip the free-time page-flag checks. A folio that a concurrent
> swapin has meanwhile claimed is left in place and reclaimed as usual.
>
> Asynchronous and filesystem-backed swap complete writeback in interrupt
> context, where the folio cannot be freed; they are handled in a later
> change.

Might be a bit off-topic, but I've been thinking about this problem
for a while.

MADV_PAGEOUT, and reclaim in general, don't actually free memory
when using asynchronous swap devices. Do you think it would make
sense to free the folio directly, at least for anonymous folios,
once it has been written out, instead of waiting for another reclaim
scan?

It seems a bit odd that after MADV_PAGEOUT completes, the memory is
still occupied.

>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

Best Regards
Barry
