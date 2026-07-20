Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CE739B97B
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 15:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784563057; cv=pass; b=df/8R+ipMMIAyWcCumVJ3cGYwOxJ7Pds+CEbkf/4syYZyzK19qrkdbaxk1cKDilhQjgQ9N+gPehhUErnV13nuh53chk8JdD7PT+SjhYXgtcmfGhuoLh1xS7R6e67xGh9vZyzThASsMCzRaSRtgDztYclanfcK06NzYCvWjkf58I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784563057; c=relaxed/simple;
	bh=Mon3Pr+zMAlMVv9yjVmVgwPQkR50RhUlnF/ZB4UOMXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6kjhWB2nwcpQC1r+LTaXI8/kAJrW5j0p3CMzebqGLHNIkpu3QDVqoWUiqIbfAXz1bkPPYAxEjRHF6MUqH/c/Yxhv9GpHzTNfWnBOM0mg4dWW4CirK7CidXuVAR86ga4MqZxL2jvVLicNipgDEp6VKwNYdv/TCpKnYQ/YGu+0HM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5jj355o; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5jj355o"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49558ce01afso13388195e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 08:57:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784563053; cv=none;
        d=google.com; s=arc-20260327;
        b=q2UL66tB5AmljShnH52hy4EUyoBjZm72TcHczev/hJUIi0VDjVankycabjUX/8muiT
         IYqzgqJfIZQL0BZaajEvE68WUquKzVgQIU4F93yvjhjEWsW1DnyPbQp3R2jPH4Q3rN/u
         5FQfvKPhPOFzhyJhDVdEjGjURs5lntQJm1lB9UGumEDyYjKpPAN+5ZeSxDpqliNJ0Ble
         lqgVnzpewi+Pf++na1vpc3xQGXqA2Kkf+2Ii9bg4YFY0N7jqtqxTjWplSyJajBBKoXzf
         IC+TdyrhNrgbxMTh2D/MWcDZzU2WyurOSgInPBBd9jOhdgnv7FMy1Ik7iv1lKoq3jxT/
         vDpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0KyJzAdpvvNft9Y4h33/V64POIpIo0Lhh3rE6JSsSJM=;
        fh=9U7yNhWYvCCMKFLf91m1JedUgOpnBfBjI55O3DYbc9U=;
        b=hHW7vw9WD1SNyzLfFr9zP9TLrqHkZdehghgeicgPFG71cxz934z55pMxdp2jgPoXPm
         fmTAPKosFB4NDELcYGT396LF+fZrZYsUnz599Lm4zqtV/UcVMpbpDEHthSLhWP8K9LRs
         QPXrrKEI3xRZSI4SeRPSeJBgse9UqxymK3KKuj7jgCsZ0j9T/YMwy0l27ijmO+P7i5Ub
         7lS4q9KMkVy6bfHOvZv5sCwsnK1mBooAeGBbumhdgzk1KfJOh8lkFsuXd+ySmiCl6p19
         Q82Ph92HOF87hS2A9pi5flTUQLuEx55k1nmf8DI/W/iuBslMAnNSEYcmS89vgMm7ejoF
         vR7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784563053; x=1785167853; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0KyJzAdpvvNft9Y4h33/V64POIpIo0Lhh3rE6JSsSJM=;
        b=R5jj355o1N4VrnSCmzkRKoaA/B51Km22KQvLDdxtH5N5QieLQqOo17z68CuujtJ52p
         P4I8MCWvCxTeu4E00F9Nj3SDt7CaYloE4yjxlILz5Po8A2vtREP87cnj6wDomeqQSxLe
         UgAZnW2LhgQEZLS4t5s8lEz2TCZF3QayVGQpeERcuFdm5E8tJ6H4pUxw6PAord/k/ZSF
         LV5E1VQRYUYWrScmpDx3bl/tEBJsJFCu+P0cqzNkKmFIrOAIt3iODyF/fq+7D/KtSiZ8
         fvRC4ZwxLhZBJoC4RrXKelRElcn/7nnLNUmbU1g7INXULRRp/5p+GXCz2OIy8BID/BX7
         Y3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784563053; x=1785167853;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0KyJzAdpvvNft9Y4h33/V64POIpIo0Lhh3rE6JSsSJM=;
        b=YtcQcDH0T6mGjfisJ4BkzM/GTFPgOl2tsBOTdxwmR2hl3vqSxRXew2lhdm/Y1+747s
         yWpOJPlhBIjfrcYl3MR0+Jjp54cMumk2pm8bPk0SBaXE8+3mPix6XEeQlKDauMllanJJ
         39u9Z4rVUME6x3bhjyfRqoViwdAW2MY18gJtRE5I6jBXW2F/a44WCk3YoXx/FQHTQtV7
         OVkgEnA20sRiSCiQ90dr33VkXnfD0tqAeIhImAdAGUDgvDKLcCkjtAu6aO2erZuSdFUo
         5QkHyRmepbHtmFDI+sn4q7DaFZi+DJDQFXomJlNjwm/aikVIyBfX4FCDYq9cg9jXkYPl
         2l7w==
X-Forwarded-Encrypted: i=1; AHgh+RqgHgw044pamg9Ya7usSGGa0uQDsMUsayWlyl3dDR/XliSJ8ixWA5c4PsuAwgZ8gi5P5hQRU9W8iAKVLMkm@vger.kernel.org
X-Gm-Message-State: AOJu0YxoR57FMn/BW6Di8N5/JwReNuDDgGVMYn/v4CEbjiZroemR/hjO
	ZpzPb/eM4Mx1KXmXjAOWFCQ+Tefvt2M+5djCVemJzcUHVKs+FneDFJVFBMozYYb84qR2/IzjNNL
	E4yk4HslhQqWAdD7je65jEvRHTQPC8/E=
X-Gm-Gg: AfdE7clum63DHa47FDiDc1N3uZe3jzqxqungijP0dYRCFv0EvcDrz0vn/IDNKJg67x9
	DTZnL/hpeQqXdwEG0fmrS1Dsxa85FXK7NpR5sYgNpPRMjs1aELtx08B5AlD8YAGFQDSUv5ScmUe
	D4saeX4fw9woTcDkye4KizCYoZs6J2UrglCdDGoM3X5ZC7W5DHO3lbaZY0xnQB9IjYsqjBSV/tT
	3YEaW+iZh3VTlK32VAntlyCvJ7rVL5/yEajthCXN4QZmDWtbjxCnINMNkZ9tnD32+Rvqda8BHCY
	J9s0jijJh/arJhlamLGqfps548Nr
X-Received: by 2002:a05:600c:3b24:b0:495:5d6d:9cb3 with SMTP id
 5b1f17b1804b1-4955d6d9dcamr68483165e9.37.1784563053362; Mon, 20 Jul 2026
 08:57:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718093723.153324-1-alex@ghiti.fr> <20260718093723.153324-3-alex@ghiti.fr>
In-Reply-To: <20260718093723.153324-3-alex@ghiti.fr>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 20 Jul 2026 08:57:21 -0700
X-Gm-Features: AUfX_mzE9oSx9gAUE_0Haa5WsqXuVdTKlLnp73bYqy-q2AYPJ21KT8MxigUKzsY
Message-ID: <CAKEwX=NY=Uvcfm2BT-HGqu8B3OaoC0eePW1M7fW1qH4wpjQ8gw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: zswap: deferred dropbehind free of writeback folios
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

On Sat, Jul 18, 2026 at 2:39=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> The previous change frees zswap writeback folios promptly for
> synchronous-IO swap, where writeback completes in the calling context.
> Asynchronous block devices and filesystem-backed swap complete
> writeback in interrupt context, where the folio cannot be freed, so
> those cold folios are still left on the LRU for reclaim to clean up
> later.
>
> Free them promptly as well by deferring the work to a workqueue that
> runs once writeback has completed.
>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

No Suggested-by for poor Nhat? :(

Just kidding, of course - thanks for working on this cool idea :)

> ---
>  include/linux/zswap.h |  2 ++
>  mm/filemap.c          | 20 ++++++++++++++++++++
>  mm/zswap.c            | 34 +++++++++++++++++++++++++++++++---
>  3 files changed, 53 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/zswap.h b/include/linux/zswap.h
> index 30c193a1207e..23dcde274964 100644
> --- a/include/linux/zswap.h
> +++ b/include/linux/zswap.h
> @@ -35,6 +35,7 @@ void zswap_lruvec_state_init(struct lruvec *lruvec);
>  void zswap_folio_swapin(struct folio *folio);
>  bool zswap_is_enabled(void);
>  bool zswap_never_enabled(void);
> +void zswap_writeback_dropbehind_folio(struct folio *folio);
>  #else
>
>  struct zswap_lruvec_state {};
> @@ -58,6 +59,7 @@ static inline void zswap_swapoff(int type) {}
>  static inline void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)=
 {}
>  static inline void zswap_lruvec_state_init(struct lruvec *lruvec) {}
>  static inline void zswap_folio_swapin(struct folio *folio) {}
> +static inline void zswap_writeback_dropbehind_folio(struct folio *folio)=
 {}
>
>  static inline bool zswap_is_enabled(void)
>  {
> diff --git a/mm/filemap.c b/mm/filemap.c
> index dc3a0e960b9f..548e465b5b9a 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -21,6 +21,7 @@
>  #include <linux/gfp.h>
>  #include <linux/mm.h>
>  #include <linux/swap.h>
> +#include <linux/zswap.h>
>  #include <linux/leafops.h>
>  #include <linux/syscalls.h>
>  #include <linux/mman.h>
> @@ -1680,6 +1681,8 @@ EXPORT_SYMBOL_GPL(folio_end_writeback_no_dropbehind=
);
>   */
>  void folio_end_writeback(struct folio *folio)
>  {
> +       bool swap_dropbehind;
> +
>         VM_BUG_ON_FOLIO(!folio_test_writeback(folio), folio);
>
>         /*
> @@ -1689,7 +1692,24 @@ void folio_end_writeback(struct folio *folio)
>          * reused before the folio_wake_bit().
>          */
>         folio_get(folio);
> +
> +       /*
> +        * zswap writeback folios are off-LRU, so we must prevent a racin=
g
> +        * swapin from removing the folio from the swap cache and keeping=
 it
> +        * off-LRU: the writeback flag allows that. Afterwards a swapin m=
ay win
> +        * the race, but the folio is already queued and the worker puts =
it back
> +        * on the LRU in that case.
> +        */
> +       swap_dropbehind =3D folio_test_swapcache(folio) &&
> +                         folio_test_dropbehind(folio);
> +
>         folio_end_writeback_no_dropbehind(folio);
> +
> +       if (swap_dropbehind) {
> +               zswap_writeback_dropbehind_folio(folio);
> +               return;
> +       }
> +
>         folio_end_dropbehind(folio);
>         folio_put(folio);
>  }
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 3c494c5a671c..d185da85bb68 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -34,6 +34,7 @@
>  #include <linux/writeback.h>
>  #include <linux/pagemap.h>
>  #include <linux/workqueue.h>
> +#include <linux/llist.h>
>  #include <linux/list_lru.h>
>  #include <linux/zsmalloc.h>
>
> @@ -990,12 +991,39 @@ static void zswap_writeback_free_folio(struct folio=
 *folio)
>                 goto out;
>
>         /* Raced: the folio is now owned by the swapin; put it back on th=
e LRU. */
> +       folio_clear_dropbehind(folio);
>         folio_add_lru(folio);
>  out:
>         folio_unlock(folio);
>         folio_put(folio);
>  }
>
> +static DEFINE_PER_CPU(struct llist_head, zswap_dropbehind_llist);
> +
> +static void zswap_dropbehind_workfn(struct work_struct *work)
> +{
> +       struct llist_node *pos, *next;
> +       int cpu;
> +
> +       for_each_possible_cpu(cpu) {
> +               pos =3D llist_del_all(per_cpu_ptr(&zswap_dropbehind_llist=
, cpu));
> +               llist_for_each_safe(pos, next, pos) {
> +                       struct folio *folio =3D container_of((struct list=
_head *)pos,
> +                                                          struct folio, =
lru);
> +                       zswap_writeback_free_folio(folio);

nit: I wonder if it's worth doing some batching here for the free step.

i.e, after remove_mapping() succeeds for a folio, we can just add the
folio to a batch, then call folios_put_refs() in the entire batch :-?
