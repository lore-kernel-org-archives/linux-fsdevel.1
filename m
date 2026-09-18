Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8978A434993
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 09:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725347; cv=none; b=obu8nEHaiHR+ZHwY8FT4D9u6irr/RhhHXIvSmb/yvcd5xfe1D/o+A9NF7LUiFBd/fIdXbSk+cyNlaBLFbBPvF+ZtNKwNzD94xBsBf05zPit1qWFT+Q9vyuyYnXJU/g/F0QrnedRVGW/UlehMjVm1YcIHLZRQix2+ySSIP6Jb/5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725347; c=relaxed/simple;
	bh=6EyzirZhuZslfdqjVG+yehDC21q8bZ7QaGD1t9QFZfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rp9Ex6LBEJEPB1LZTS4mhLkMyOfTO8mgCk+beh5PIDrst4ZUTCrj3shs4bJgHHniPfzWvtxe7Z4itn+bEufVrjsnmphIoTPcwrIyMfNKbSQnmxo98zbYTPlyBxFpYR516KXDe8WNtXlnfpF/veb9lkfAYuaT19XfDFRDfDV+RAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdSDUozK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdSDUozK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA731F008A0
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 09:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789725336;
	bh=tM8T7Uyk81H/R6khmlHeL1LEwtikebuwV9hSCk4cYqc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZdSDUozKta+pPXlKlVhvq3dQiNghzLZ4+ZRdaXLuBBtLXqzAPSqBD5GRUG42DFO7O
	 D9AyiMSf1X84iCbeSnwhj0rXzeeN4LMOqouMt711EfrZcFu82/uADeIDyfCfxuy6jQ
	 XvBThQeUn6mh6pq9y09Ibr+wEp+qZc3pUajtGvL/cGMkCtLlTO/92pMyS2ZaH6w2Sh
	 46khP8NUtu77vcwCooUEtqaPqR/Zq28K51ARp8PAWuJ+NOI613jhR8cOCg0BK11vN0
	 N59cK/QrMikmx4VoB3/4qE1h6Ti2NcOINzGdSq0Qy40CZDZEu3voXw/5Jl5q0N85jy
	 Zq0hPRP9Yt0DA==
Received: by mail-qk2-f17.google.com with SMTP id af79cd13be357-93910ca5aa7so48297885a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 02:55:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy/ov1Lw0Yq5fhSuYfaLbYlQBLjsRK528H8dsx05myCxI64NS/u4b4AfuPYp+FKlc6bnN7OMqM/MumBAhIb@vger.kernel.org
X-Gm-Message-State: AFuF++lpaEb72M4yGo7IFZqTj94XfQo6Vzw4kcMycPWeqZcv/qhdz6Z5
	IOHMc7a3tIGZccb7lPrvHyb+3cafDqI/vEOC8iDusHWj120sz4Wd059DTZQUQCEOy4ijbvCfZWU
	naW/eFneVLLmFc4ZthzHxbN18HBU4RU0=
X-Received: by 2002:a05:620a:839b:b0:93b:d79b:9a5c with SMTP id
 af79cd13be357-93bdca885d1mr252021985a.61.1789725334936; Fri, 18 Sep 2026
 02:55:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911121341.178028-1-alex@ghiti.fr> <20260911121341.178028-2-alex@ghiti.fr>
In-Reply-To: <20260911121341.178028-2-alex@ghiti.fr>
From: Barry Song <baohua@kernel.org>
Date: Fri, 18 Sep 2026 17:55:22 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4w1FxNMTWiYDU86=bifr6mWZ=Rs0suUBGtN4qs_pU88Bg@mail.gmail.com>
X-Gm-Features: AcwNN1Wz8bI-Do0Pl_jSvJNgp8ItV3WUx6SNSfLqfj9e_G3JRN0VvgqtJzwJL84
Message-ID: <CAGsJ_4w1FxNMTWiYDU86=bifr6mWZ=Rs0suUBGtN4qs_pU88Bg@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] mm: swap: move LRU insertion out of the swap cache allocator
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kairui Song <ryncsn@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baoquan He <baoquan.he@linux.dev>, 
	Youngjun Park <youngjun.park@lge.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Michal Hocko <mhocko@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Wei Xu <weixugc@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Kunwu Chan <kunwu.chan@gmail.com>, 
	Tal Zussman <tz2294@columbia.edu>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Usama Arif <usama.arif@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 8:15=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> This is a preparatory patch.
>
> __swap_cache_alloc_folio() adds the new folio to the LRU itself, which
> leaves its callers no way to act on the folio before it becomes visible
> to reclaim.  Two users need exactly that:
>
>  - moving the refault evaluation out of the swap cache folio allocation
>    requires it to happen before folio_add_lru(): that consumes PG_active
>    to file the folio on the inactive or the active list, and under MGLRU
>    it also reads PG_workingset to pick the generation.  Setting either
>    flag afterwards does not move the folio;
>
>  - zswap writeback dropbehind needs the buffer folio to stay off the LRU
>    entirely, as the per-CPU LRU batch would hold a reference on it and
>    keep remove_mapping() from freeing it once writeback completes.
>
> Defer the LRU insertion to the callers of __swap_cache_alloc_folio():
> each of them adds the folio right after the allocation, so there is no
> functional change intended.
>
> Suggested-by: Kairui Song <kasong@tencent.com>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
> Acked-by: Usama Arif <usama.arif@linux.dev>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---

LGTM,

Reviewed-by: Barry Song <baohua@kernel.org>
