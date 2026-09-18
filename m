Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47786547070
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 23:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789774145; cv=none; b=ZYn9U/4OMyUtML4KaoxUOsoEtN5lsf+N4oHeA9eb4EYPlbODyjqW1Qa38KoF9h+0bfx0atm566tGxRuUNLz9dEaVdd6CuSt32NfXdbhuRW9Ecgh10CrGEwySYo5bf5NYp9QPV/QGC6UByPyBmPsW0NlsOSiJAZVDO99vt2rYqsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789774145; c=relaxed/simple;
	bh=188T93z4qV5uNJh8FeTOQrPGMOwnqFGa0qLgHhQ2j6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NNtLHYJe6/cjnwswkkXr+GNfoMhv3B9HZ4C1qbvhrQ7H1851V3lGoJNXIQ9SNAYB8jLbg2hrNots5BXasa3fofsORKtGsSUu3XEq69Hh0aqTxIVr5FqZn5c+VaRDBm7Gpex1y8W9eLBzaidOe/6/YLJj8ecgSqEieuR6WT0qtmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiSRnKvC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiSRnKvC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12B11F0089D
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 23:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789774143;
	bh=188T93z4qV5uNJh8FeTOQrPGMOwnqFGa0qLgHhQ2j6I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PiSRnKvC/7TsaU1jXYZznoLG1Io9kiC/TmZcfMXDIPzau2YYvOdIyD3AGztj9PbG9
	 ZUmNI4lfmhvhM2Xt/8BfOr0pLFu8EaU37nLqsaDIYGZG8WRhdPy8AfxMz3xtq1dK/F
	 tw+F7NFMfaZWw6ffFUmGNtlwHpOWiULgMVWC4JNqawpm9mSwlqoxXUdJb2MZXBNeiN
	 +gZ940xRg21AKtjOiqF36zZy7r2jy1a8bzyJPdFnoW0UzJpXvy4djmkwZHWx3ge0O4
	 TezPFQ7L5bjod01G8qyhX0bKHHHNy9BksPm4OVkHeSMOodqOLoJTrVeg9fG6YrTx2e
	 k0IqK6W0l2q/w==
Received: by mail-qv2-f40.google.com with SMTP id 6a1803df08f44-90cdfe57a3bso10607996d6.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 16:29:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz59xQJCSK+oDKeitSotF4kvH4fDgnkEjYQeAwZmH4KjoYvzKk9aknsdp3icCcu96qM/+kQvavPv4Z1uYdq@vger.kernel.org
X-Gm-Message-State: AFuF++l4WH8CH7uHdWCYRfOX7vJH1KxO1LvkRB30mfTczN3SrAfClTH5
	Dr3bTPVeNE+SZLBN2E40R+Txa6cE+BrnLjAyYsl9YF0PCJgiRfodnclgBXNasPQY4eiN2xzAt3b
	60BVZp60os62LEVKutu9TPAly1UKSFls=
X-Received: by 2002:a05:620a:2258:10b0:93b:e578:583d with SMTP id
 af79cd13be357-93be5785985mr347910985a.21.1789774143217; Fri, 18 Sep 2026
 16:29:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911121341.178028-1-alex@ghiti.fr> <20260911121341.178028-3-alex@ghiti.fr>
In-Reply-To: <20260911121341.178028-3-alex@ghiti.fr>
From: Barry Song <baohua@kernel.org>
Date: Sat, 19 Sep 2026 07:28:52 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4xPvb+t752-7cgBD+A_rnC0RsBr5xzqLH7WxfMDyUZOgQ@mail.gmail.com>
X-Gm-Features: AcwNN1V3GmEDwNyGC-51iWFm0sj4MaQx5oLhHhe_bGWgP4pIfVXISsARrLm7dQk
Message-ID: <CAGsJ_4xPvb+t752-7cgBD+A_rnC0RsBr5xzqLH7WxfMDyUZOgQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] mm: swap: drop dropbehind swap cache folios on
 writeback completion
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
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 8:16=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> A PG_dropbehind folio is dropped from its cache once writeback completes
> rather than left for reclaim to find later; this is implemented for file
> folios in folio_end_dropbehind(). Extend it to swap cache folios.
>
> The drop takes the folio and swap cluster locks and may sleep, so it
> cannot run in interrupt context. Set BIO_COMPLETE_IN_TASK on the write,
> as the file dropbehind paths do, and drop the folio directly from
> folio_end_writeback().
>
> Suggested-by: Yosry Ahmed <yosry@kernel.org>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---

LGTM,

Reviewed-by: Barry Song <baohua@kernel.org>
