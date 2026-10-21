Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571594;
	b=WKpkYL03jCS2oOhZr90Y6OdClWbpdbMFylKcq8MiixLGyXI3d5kFL1G501T6GIKB+6p2
	 1k2PeW1AG2NnKtdhSDo29u4/hCbL5AADxC5tNe33r1LG+xdROAF50BTPROFW1N1twQ7bW
	 +SMGdIkWUSin39kVwLRt0Zvxs/aZQLwY8dncr6fAh0MIIIrH+YZBRrfjxEUpf2HKOPfRV
	 Swk3zn+3w+pkDaUJuX5rNBDCgwQq/UtHQptmnbK+geyBbGd0Csx4wjNYuCsbi9eDPAg6q
	 QfWfeVpftKlXeKhEkdPkbRhLRhg1BlnGxxPM4BgSqbRemfdTjOl+iC10WLcTon9VtGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571594;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=MKByxw8dDW6HSJz8+UMbqi5YMYg3uB2cb2BltWyQmtY=;
	b=hQC5ADC5QnA9G7Faji8s3j1cnv2wqBwes5pIxIOfKoLDUEbGQyu4di+c+Gy1va+ePLk4
	 pf8WGcS/o75smdJuB922esU0vVuGrbBaqM3+woPtKSnPgHYU3+uAI3B6FrwMZQs+tIM7Y
	 v/6jzKtUyyizu+Tw7NFrs9QMgQfXeJEorxzyKnKpJDDlHNvCOpqCWMrfq5zt4U0QWRmCK
	 hAuRxkPDkFlqzCkh8z1VSkZujnN6tywh3Xp1YCzLS5akbU+Dpg56dAn7us/o+743IX9H9
	 XmByfxTG/+feWp0dlovsdRydYxsfbEHqfdmukTFpdBi2cofVIU/l5hgpQkAL65su8dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QtpM+94P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED989606A32E;
	Wed, 21 Oct 2026 08:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QtpM+94P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5271F000CA;
	Wed, 21 Oct 2026 08:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792571593;
	bh=MKByxw8dDW6HSJz8+UMbqi5YMYg3uB2cb2BltWyQmtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QtpM+94P0z/ja2LfWi1SKDPVylIFLra5YBht5Gdl4ToK7koxRMrqLfqlFA6US5oc3
	 3+xUnVvo/Y7M+Izf5+pXUzsRxldK98M1KJrd5mNfp4ME9zkbgkkajDpOwKYTgtw/qj
	 r1DUqsE4e8dj7RM7K+JilygqmHkigjTqfMnclTo1YQ/YNCp1YGE8NcrGv9LF9qln6a
	 +OAHHmrFUeL9DW2HyspbiMqLPl5iXJX6S4GfOHC5geAqZpkLySVG2ImEaV4xp9J2LZ
	 jIz1SbEL45Sunpjq0AFLoRcG9SE/lz9ACwk7ieWFZy79gzhKLxYKkn26a6SIOEvMvE
	 AdV58TpRxBNYA==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.ams.internal (Postfix) with ESMTP id 96A7C198004A;
	Wed, 21 Oct 2026 04:33:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 21 Oct 2026 04:33:08 -0400
X-ME-Sender: <xms:vXjYaqD4Edw4zlL5mp13NmLz3tRKqOiPZcTgJgIpShC3QPuWlBmNTA>
    <xme:vXjYarPSQW8giGM80hU1G-6AKAFbQFhhzu6FP8FXkbGl_xwgSJXoZvt_wthwHPyXS
    Agw8fpGcsh-UE5pbchgsNIVOkgnQW1hQUb4Mj9xsynjFrOLv644KYZW>
X-ME-Received: <xmr:vXjYau6T3aVIkWBowCPXTm5p3pJwbJMNfUI5vSNXMq4n7tgqoQE6ZaLep5U>
X-ME-Proxy-Cause: dmFkZTFrsjqyNAVpEK98oebWFXwZpI7LqX9Aov6fN8jUp2sNNep1ITMUB5YykhVbmPS/JW
    hhu+Ze1IE7IQhEqDUpsMd7Cg7z0t93UpSSU3DYZM/EVADOuUVk+FjdtAeACf5DVZ07Qkhn
    t/PA68gModROd74o4gybU16E1jPYQsNXGLetxZ7IOa6m+sCSckxL6wwATbX1RUo4X8mwkX
    tvQzyXOt7I1CuCjEyKtXxHmz4HGj57DN9ITZyqARldyoDovSDBIwoWizcJ+AuScX7751LZ
    GsLMiHVmGYyi+16tRQPq7oISzc69Z2qZ+zI4txcHKFEUanCWKZTYL39zREtM9rxHRO8Jhq
    WH7pVuWso/HHzbbIyQWn+a0kjP0y4p2oz5+TPjDWJrRopIdu1nE5WVdG0PPJFjuufj8M0L
    GJ//TWPi0snycliRS5JJ37gww9RykpVb7LoEMV6J/YhMqGDXlyLbJ0tx1TUjl9rfgYneJi
    OKTrtcZU/jhXGREu335v/vLNLk3WQxS1jzpklNaJ7gFd3IhswJL1OmaUOh/+v2t6E1l+Bl
    AWWX+tWL4e/AZIyHtWrbzT8WHj0a9UNa5jeHi82Da4a/8bdG8RYbXxatW9tRg0y2KQIITM
    GFV8HOuowBhoXkp3irIUh2WZcBODF2cXEfd1sZfpqWHqGU10kSs+RI7+0DGw
X-ME-Proxy: <xmx:vXjYauqfryVHxqE4auQn3axpAf2N62CEDED2JFHUY1W7ULceo2orXA>
    <xmx:vXjYak-s_P_X8IEzwImFUarcxPBVPLP1kPrB88HbNgTTf78QDf_Xxw>
    <xmx:vXjYapX7GsewJFLd_bHvVob-INQxR0pTumlNEYFqdaGdZvJll5VOVg>
    <xmx:vXjYarAmMQmJsCyknzln-QjD_6RT5voeOhvjDeH7JEsjPXELfo-Org>
    <xmx:vXjYagbgYiwyZnitRIjHGBhDBbxop9wsVdzJkQiMncCsOZqnbKYQxt5s>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 04:33:00 -0400 (EDT)
Date: Wed, 21 Oct 2026 09:32:59 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Jan Kara <jack@suse.cz>, 
	Hugh Dickins <hughd@google.com>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, "Liam R . Howlett" <liam@infradead.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Brendan Jackman <brendan.jackman@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Pedro Falcato <pfalcato@suse.de>, Harry Yoo <harry@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Ilya Gladyshev <ilya.gladyshev@linux.dev>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, kernel-team@meta.com
Subject: Re: [RFC PATCH 13/18] mm/filemap: store the end of a read in f_ra
 only when it changes
Message-ID: <ath3Fk56VcWp7NPe@thinkstation>
References: <20261019154913.1765974-1-kas@kernel.org>
 <20261019154913.1765974-14-kas@kernel.org>
 <CAHk-=wjJpuLXt5BHieXV1qBE-uoWDXKugcfGgR+DiVGVZQ8RvA@mail.gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjJpuLXt5BHieXV1qBE-uoWDXKugcfGgR+DiVGVZQ8RvA@mail.gmail.com>

On Tue, Oct 20, 2026 at 11:20:00AM -1000, Linus Torvalds wrote:
> On Mon, 19 Oct 2026 at 05:50, Kiryl Shutsemau (Meta) <kas@kernel.org> wrote:
> >
> > filemap_read() writes the end of every read to file->f_ra.prev_pos.
> > Threads that read through one open file all write that cache line, on
> > every read.  The value often stays the same, as for reads that start at
> > the same offset each time.
> 
> This seems silly. That "often stays the same" is only true for the
> pointless benchmark, no?
> 
> I don't think it's ever true in any real load.

Right. The patch is bogus, not only the commit message.

It is worse than useless: for random reads prev_pos changes every time,
so the compare reads the shared line and then writes it anyway.
Bisecting a RocksDB slowdown led here: with patches 1-12 it runs at base
speed, this one costs 4-5% at 16-64 threads.

The store itself does matter in a real load.  RocksDB threads pread()
through one fd per SST file, opened with POSIX_FADV_RANDOM.  With the
folio refcount gone, the prev_pos store on that shared struct file is
what they fight over next.

For an FMODE_RANDOM file nothing reads prev_pos but filemap_read()
itself: readahead is forced and returns before looking at it.  Skipping
the store there takes a small hot table at 64 threads from 10.7M to
14.1M Gets/s, against 12.5M with the series as posted.

I will replace this patch with that.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
