Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64942330668
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 15:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253954; cv=none; b=EgkqJVMdgjEITIEizDfHxaABRwaORwpcSfeEgZJSHSNEU4aQXEkB4I0BKkzFpHgGULRJwwxq00lymfYHuwS4eA5bZcNKJPyPN0cnnR3Yffm4nxQvhTdGLgbIwTEKp2R5Ztr87aIFkkoa/YvlQD+eqyYiYjyjBDa3CF7I9BG/Qv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253954; c=relaxed/simple;
	bh=bMOl0LoZ9OG3r13De5qvfam6hhvkOi91d3jCbtx/GCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nC6M0aM+xhkz5aDY5NXNa53yf5uyigPLGlgUU2tZwaMJ1sZjB8rc1GcTlZMk9yC17ArpvmS3nUXJS1u4vEW3/5B4xIgBJVMP+7s7l6UJON0mqLXk2VyCSVF+adTFx1KJwmieVj7oYnKS1zB3aRNKe/CTzF0f1F1u6V9Tbq5eN2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwQrC4Hx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwQrC4Hx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2121F00A3A
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 15:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785253951;
	bh=bMOl0LoZ9OG3r13De5qvfam6hhvkOi91d3jCbtx/GCE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KwQrC4HxpZh8eu98lPCEWvADjY35rrDNQdlSq4/4cv+GUa/6oFVY/+nV7CaInlAMm
	 DXxdtQri5w3Z39H9enq5RS8eJyLdgWRRbnJzIgEbZ7uqR9xQ82VNezv7zbqCZflTiZ
	 av2L8MB5oj4OS7nZrlwUdAh2pnMNwSKAqFqB0vWkm+UIkMVIxdSR+pEm3liKMQXdb6
	 NarPWuCCD18M0Vkec+sxLEpTP25v7QNxz10ehYPBKHa8OJ3vPK4tGgCVYyhmqlNRAE
	 /k2nf4liDNWdfVS1E6yu8pWjYf5ZdnnXhdbHNHXemGa2Hbodp19vUsGe18RyKL8vVt
	 fxnhlstLfgVbg==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c1740c36c5cso570221466b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 08:52:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqbBYuofFivSLMuapUg7sGqzKH6YQh6csxf7+SkwZKcddtUSNZTOmSHhWEfMJe8qXC4dXdiFuTFxMRCde3I@vger.kernel.org
X-Gm-Message-State: AOJu0Yy51Ep8Ie5JTMn8jll5HSiyLHYYJQvfc0t3GNM09G8Qt4F8iiPc
	aDrXSN6XUzvkVdgMpswaoxK7fxE7NNTSyu5hCMhRCLGnEhxUrTEJarltQ0IcjtdTYK4Mnq3qU2d
	rm/1jTBiL1pk/uvswrD9mTIdOU4yhLnU=
X-Received: by 2002:a17:907:1b22:b0:c15:cc30:6c70 with SMTP id
 a640c23a62f3a-c1f7222aad1mr157579366b.42.1785253950068; Tue, 28 Jul 2026
 08:52:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727143618.1582318-1-alex@ghiti.fr> <20260727143618.1582318-4-alex@ghiti.fr>
 <CAO9r8zNJ1cfCVgxtpqx4Db380bjZ+Z0P842eAxPXw6Mh4XBrww@mail.gmail.com>
 <CAEmasaXR5EmGCv3T5AzM_2908R-VjfMcObrACyVGokY2U=+i+Q@mail.gmail.com> <CAKEwX=P5G=Ckafy6fm9ws3njWP_Zm_AHRKOFERScB9Pkd_KvGw@mail.gmail.com>
In-Reply-To: <CAKEwX=P5G=Ckafy6fm9ws3njWP_Zm_AHRKOFERScB9Pkd_KvGw@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 28 Jul 2026 08:52:18 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNsZUvMknjmH7MvkQ=09DnB9YvtYoA0ei5Hj_cESQAVPg@mail.gmail.com>
X-Gm-Features: AUfX_mw17xHEr87Xj-0eNal-34Y7WD8xyS6pNm9H3A2zMrpBFz_XUx8rLZL9Rcg
Message-ID: <CAO9r8zNsZUvMknjmH7MvkQ=09DnB9YvtYoA0ei5Hj_cESQAVPg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mm: zswap: drop cold writeback folios via swap dropbehind
To: Nhat Pham <nphamcs@gmail.com>
Cc: Alexandre Ghiti <alexghiti@meta.com>, Alexandre Ghiti <alex@ghiti.fr>, 
	Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, Kairui Song <ryncsn@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baoquan He <baoquan.he@linux.dev>, 
	Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Wei Xu <weixugc@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 8:48=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Tue, Jul 28, 2026 at 5:58=E2=80=AFAM Alexandre Ghiti <alexghiti@meta.c=
om> wrote:
> >
> > Hi Yosry,
> >
> > On Mon, Jul 27, 2026 at 7:05=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> =
wrote:
> > >
> > > >
> > > On Mon, Jul 27, 2026 at 7:39=E2=80=AFAM Alexandre Ghiti <alex@ghiti.f=
r> wrote:
> > > >
> > > > zswap writeback decompresses an entry into a fresh swap cache folio=
 and
> > > > writes it back. The folio is cold by construction, yet it is left o=
n the
> > > > LRU for reclaim to find and free later, wasting a reclaim scan and =
keeping
> > > > cold memory resident longer than necessary.
> > > >
> > > > Allocate the folio off the LRU and drop it as soon as writeback com=
pletes:
> > > > mark it PG_dropbehind so the swap dropbehind path frees it once wri=
teback
> > > > ends. Synchronous-IO devices complete writeback in this context, so=
 there
> > > > the folio is dropped inline instead.
> > >
> > > Why does this need to be handled in zswap? Doesn't writeback from syn=
c
> > > devices still call folio_end_writeaback() and do the dropbehind
> > > handling?
> >
> > That's an optimization rather than a real need: since we know we are
> > in a sleepable context, we can safely drop the folio from the swap
> > cache here. And since we don't mark the sync folios as dropbehind,
> > they never enter the list handled by the dropbehind workqueue.
>
> It's a bit artificial, but you can try testing zswap writeback to
> zram? :) Likely you'll see some small tput win there?
>
> (TBH I have not seen sync IO swap backends other than zram though so
> idk what's more realistic. We don't have pmem device available for
> testing etc.)

I don't think it's worth optimizing zswap + sync backend tbh.
