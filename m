Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8219443803D
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 15:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784563008; cv=pass; b=kq/+H0qM2L1rEUeQMeiJ1gzIXrzpiy5NsgAqO3eAskKZTm6NoRoeIuqYS7/Qf/S2/Mbt80QBYwmbWFtV1Hr3CxNxvSanySx0ve+jvWy889OGBK4yXiCXaRsSdTtKSSlHiOb8ygVvgeKCzokkdFt2tN5R0fr0/tDPc7wuT3w6Zbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784563008; c=relaxed/simple;
	bh=vxtjAwLokgPvOpWh06Mn0JloWjEV1Q/tG9gJigKzFPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TCQ2aD/6hpCeXBRS580ZUQEOeecBJ8w8QiDYSDVSlYOp6v9wcHlT/AlBgY0cEf2SZ22f2R/GHkLlqOAM69ORssvK6eycrBVEITNfZWszowWxRccOcziiPQzc80LASEcdDetFVDCI6pd4sDa0m8EjgSR+OkUlVVgGavHKzdWkGKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmFZtukM; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmFZtukM"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4954a2e73a9so19942465e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 08:56:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784563005; cv=none;
        d=google.com; s=arc-20260327;
        b=jYm3yZVFuuvmQ3Ff2aViVGe8m1jAhsMj1HWbCa3yjtPDbygyDYFFWbR4GrqqYCHrAj
         B+1PO1P75ZXKaqHQrNr7yvICb5Z33te0l2HyF8Mofz0fc1MZvgcJspnuTca33SPxPZC4
         qT1gi1nU1XVb4rFuLAWTyiGB6vUvGJlnkU6sl+CNUKiQ+9UjDAKSIzo9ziT+zFtb6shc
         ZzTQtCuGCm3zB2c0DhXieo+kKmVbBXk27LILB9MyaK4Ajm4ksrfvLzKFfRuyDFHvl7Kr
         Y3O3nIh2f078Kb9o+oeEXsSbSwYbAA8gqYiC223endq17LyCHQ/rA+3HAXul+5Bh8y8b
         ygiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n2pi/xAA08HOnx69PMlTRrck+6Y6k//FzJj5lUPYCGg=;
        fh=dg+UIii19xyAq7vc4i9F86w2PQdOTF2pAm7cWTw2OZU=;
        b=Qid2xCMYxS9G/MfgstO+V7JWGBAmDsJzdxz04SyUnWXJWcC00l5ZYDka+7UYXGNQb1
         CA8YFOXULwR5rGJF2/fm3UmraxENlfQ0jwncSUQByFnLEUnhYwZNvsilNH9dcJD5qaQe
         Wm4dQTAD0VpfOunwcEqaljuIqBF9hhMRlCc1JPaL/9jv5R0KmN3iyRYr1u2sAkR0MqXn
         PE2CrJo7Jls0JK0tTJVntFx0bf4iEoggBjqZi53yEKA45k6g66CXvfuduFKHFaeM2BnZ
         90y2bP+YGaDahcq9Xoa5pT+3DkmQWs8XV5CB1y+tKrtS5hQ/zNnrtGPouj3Rv+DUJELS
         6npQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784563005; x=1785167805; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n2pi/xAA08HOnx69PMlTRrck+6Y6k//FzJj5lUPYCGg=;
        b=FmFZtukM48TpoAA50Tz+C1AQS1qRoA/69431eIf3+CtjnNnKxf/ItjoMz7CJ5HmZHY
         4XfXg84jXdls4cg9OJ2pq8B1oJgVrpZDgtrmZ+nYKy5LPoFCyk1wec+/ehJlKDzRQZks
         reEBlXp632DZBU9K2yNLv+K99neNvS95ilURInqoocdlrKg83RI2/m152GfwF9qa4ZoL
         zWLfNXufkPGaycB3ITQY82qOROIQEdUe0qUatJtPia9YvC5HwxQpDl8udZvgw9y0hkh6
         ghSpLLGnmZ7B7eG2QXJYn04p64u/eHgnDFNuWH9F44AqBHiF9fQO8qya+JzVzLLHhphA
         6U/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784563005; x=1785167805;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n2pi/xAA08HOnx69PMlTRrck+6Y6k//FzJj5lUPYCGg=;
        b=WMOla9QKfBq6LJZWaNxjoG7G9qorl0QSt0hcjllsaSAZbM2kGPgQe5f7eFYRj8WgiJ
         3I03rmDZ2bqgKG/Ycfving9cjrvzX3fi5nRYUJO6sCF3pFRAO+pYULJzMECfzAz/vnpX
         rtlcBTQ8LuX4Psd0vHY6bHR784x63l4m2oHgpg7M7A6l1Pg6+RghOd6NxgOtVjT1Vyzt
         E909T86/5Ij93/cHiKcT9LWxEIgnxHDVlsw9sGE3oiV33V/YbbeUWq8capmZwnhUEB8M
         UA1lwa3dTsMGUkSqgl3cMAZk769EBM8FeQ+t3AMh37SDa4QjkUvoEc/KkdfdqQSO+Htn
         UVqw==
X-Forwarded-Encrypted: i=1; AHgh+RpAczTWjZGpZRVx6kVzny/EPuOZkHeTTKpuvgH0nkavCX2kPaodzWExiaf9gzxkvtiTNvUIvyqEAD0O/5E4@vger.kernel.org
X-Gm-Message-State: AOJu0YwkHn4Wuh52f4DoStm8EXKD8sREP/kPISjQiH6HPPG9nKYYOQ3U
	SZneusPuXCCgrbK3tGuBP8Es/RQ03JXFXorFO9wwmuwxOmHesbMxbfGdFdL9lEOW1h4L9oD3+Sk
	8sSmUoZHABJ3nDnBPYp6/Be/4GtLQN0Y=
X-Gm-Gg: AR+sD10ktgLs3jo6/PvurFyg/3lr0cP7YOGUPFX5c9+g+VCZUkoH9emS3cYmVrQQ/9S
	JfJvT9ZP3ReX9jCAAv5OBayR2AoweDbHahXFdOPN6+YJ8mOvrHi9Wvehxhiq6SffQyrNf7cM/Z/
	XqPbSi/z76trpCfEROkuqd8em+RM7FPLtfV4SIWZqcOJ+t8NZiUhjm8CclLoxdNI5Z3COLvYJcX
	ROA9wSjS/SSd0NpZ6fL1AX7yfW//vhrKMwbwECDjMuSjb96SKuBfVLDitjwGfXI8ZMSZCqhYaKS
	G/KiNRkEUwNGWYxm8A==
X-Received: by 2002:a05:6000:220a:b0:47f:6fe0:294a with SMTP id
 ffacd0b85a97d-47f6fe02b02mr10096598f8f.23.1784563004542; Mon, 20 Jul 2026
 08:56:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718093723.153324-1-alex@ghiti.fr> <20260718093723.153324-2-alex@ghiti.fr>
In-Reply-To: <20260718093723.153324-2-alex@ghiti.fr>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 20 Jul 2026 08:56:32 -0700
X-Gm-Features: AUfX_mxuiyoIjzhEutGTO511_NhirARSYjjeIOZoGjTVYtHHDTkIhdeMfEHtsQY
Message-ID: <CAKEwX=Nn0dMc1K9drXFVMwt7wMZ2P6KToeh7T3rE1+Xq5yrCFw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: zswap: free synchronous-IO writeback folios directly
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baoquan He <baoquan.he@linux.dev>, 
	Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 18, 2026 at 2:38=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> When zswap writes an entry back, it allocates a swap cache folio,
> decompresses the entry into it and writes it out. That folio is cold by
> construction, but it is currently left on the LRU for page reclaim to fin=
d
> and free later. This wastes a reclaim scan and keeps cold memory resident
> longer than necessary.
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
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  mm/swap.h       |  3 ++-
>  mm/swap_state.c | 17 +++++++++++------
>  mm/zswap.c      | 36 ++++++++++++++++++++++++++++++++++--
>  3 files changed, 47 insertions(+), 9 deletions(-)
>
> diff --git a/mm/swap.h b/mm/swap.h
> index 77d2d14eda42..c617e5a0257f 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -306,7 +306,8 @@ void *swap_cache_get_shadow(swp_entry_t entry);
>  void swap_cache_del_folio(struct folio *folio);
>  struct folio *swap_cache_alloc_folio(swp_entry_t target_entry, gfp_t gfp=
_mask,
>                                      unsigned long orders, struct vm_faul=
t *vmf,
> -                                    struct mempolicy *mpol, pgoff_t ilx)=
;
> +                                    struct mempolicy *mpol, pgoff_t ilx,
> +                                    bool skip_lru);
>  /* Below helpers require the caller to lock and pass in the swap cluster=
. */
>  void __swap_cache_add_folio(struct swap_cluster_info *ci,
>                             struct folio *folio, swp_entry_t entry);
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 9c3a5cf99778..048efc7ca612 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -403,7 +403,8 @@ void __swap_cache_replace_folio(struct swap_cluster_i=
nfo *ci,
>  static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
>                                         swp_entry_t targ_entry, gfp_t gfp=
,
>                                         unsigned int order, struct vm_fau=
lt *vmf,
> -                                       struct mempolicy *mpol, pgoff_t i=
lx)
> +                                       struct mempolicy *mpol, pgoff_t i=
lx,
> +                                       bool skip_lru)
>  {
>         int err;
>         swp_entry_t entry;
> @@ -484,7 +485,8 @@ static struct folio *__swap_cache_alloc(struct swap_c=
luster_info *ci,
>         lruvec_stat_mod_folio(folio, NR_SWAPCACHE, nr_pages);
>
>         /* Caller will initiate read into locked new_folio */
> -       folio_add_lru(folio);
> +       if (!skip_lru)
> +               folio_add_lru(folio);
>         return folio;
>  }
>
> @@ -507,7 +509,8 @@ static struct folio *__swap_cache_alloc(struct swap_c=
luster_info *ci,
>   */
>  struct folio *swap_cache_alloc_folio(swp_entry_t targ_entry, gfp_t gfp,
>                                      unsigned long orders, struct vm_faul=
t *vmf,
> -                                    struct mempolicy *mpol, pgoff_t ilx)
> +                                    struct mempolicy *mpol, pgoff_t ilx,
> +                                    bool skip_lru)
>  {
>         int order, err;
>         struct folio *ret;
> @@ -522,7 +525,7 @@ struct folio *swap_cache_alloc_folio(swp_entry_t targ=
_entry, gfp_t gfp,
>
>         do {
>                 ret =3D __swap_cache_alloc(ci, targ_entry, gfp, order,
> -                                        vmf, mpol, ilx);
> +                                        vmf, mpol, ilx, skip_lru);
>                 if (!IS_ERR(ret))
>                         break;
>                 err =3D PTR_ERR(ret);
> @@ -643,7 +646,8 @@ static struct folio *swap_cache_read_folio(swp_entry_=
t entry, gfp_t gfp,
>                 folio =3D swap_cache_get_folio(entry);
>                 if (folio)
>                         return folio;
> -               folio =3D swap_cache_alloc_folio(entry, gfp, BIT(0), NULL=
, mpol, ilx);
> +               folio =3D swap_cache_alloc_folio(entry, gfp, BIT(0), NULL=
, mpol, ilx,
> +                                              false);
>         } while (PTR_ERR(folio) =3D=3D -EEXIST);
>
>         if (IS_ERR_OR_NULL(folio))
> @@ -683,7 +687,8 @@ struct folio *swapin_sync(swp_entry_t entry, gfp_t gf=
p, unsigned long orders,
>                 folio =3D swap_cache_get_folio(entry);
>                 if (folio)
>                         return folio;
> -               folio =3D swap_cache_alloc_folio(entry, gfp, orders, vmf,=
 mpol, ilx);
> +               folio =3D swap_cache_alloc_folio(entry, gfp, orders, vmf,=
 mpol, ilx,
> +                                              false);
>         } while (PTR_ERR(folio) =3D=3D -EEXIST);
>
>         if (IS_ERR(folio))
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 761cd699e0a3..3c494c5a671c 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -972,6 +972,30 @@ static bool zswap_decompress(struct zswap_entry *ent=
ry, struct folio *folio)
>  /*********************************
>  * writeback code
>  **********************************/
> +static void zswap_writeback_free_folio(struct folio *folio)
> +{
> +       folio_lock(folio);
> +
> +       /* The folio was allocated off the LRU and nothing re-adds it her=
e. */
> +       VM_WARN_ON_ONCE_FOLIO(folio_test_lru(folio), folio);
> +
> +       /*
> +        * Gate remove_mapping() on folio_test_swapcache(): a racing swap=
in may
> +        * have freed the swap slot (folio_free_swap()) and dropped the f=
olio from
> +        * the cache, and remove_mapping() must not run on a non-swapcach=
e folio
> +        * (it would trip __remove_mapping()'s mapping =3D=3D folio_mappi=
ng() check).
> +        */
> +       if (folio_test_swapcache(folio) &&
> +           remove_mapping(swap_address_space(folio->swap), folio))

Hmm I think you also have to test for writeback and dirty here right?

After a racing swapin freed the swap slot, the folio might be dirtied
and swapped out again. We probably shouldn't try to remove_mapping()
such a folio?

We also do similar check for zswap/sync-io devices in pageout handling
(mm/vmscan.c, shrink_folio_list()), and the other dropbehind handler
(filemap_end_dropbehind()).

When I was playing with this, I also tested the folio with
folio_test_active() and folio_mapped(), but I must admit - I do not
remember why I did it. Could just be me making sure we dont get rid of
frequently used folio rather than for strict correctness. :)
