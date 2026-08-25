Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E7D44838A
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787673111; cv=none; b=a9/Ng11Cgnzl3Mm4F4Y/zSL/BZXOKNU28jxQC3cICCmqLiGfZqo5bMcAkbzYVcjA/w4lI+sIbk5tVe7BeDzZW9LuwqA6VN3v7gZip3WLmJLPuZur4UbnbN9d7g3apV1uYN97t/NLiZ8H9n25BXl4qXI2EF5GPgM8d5hHIgdUn9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787673111; c=relaxed/simple;
	bh=PvFnf4Z6JVgjgh0VHZQGFaS4YqE/P/cMJ279n6GuDVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YO2uRnVbVSw6WnP2eAzTLU8s2aIWKCqI8hZ1HeUAzGslcobS/Tznoj3fVh9q5u62cyYjL87tUHE/E2anIkWPiCiSr+gKUuh6ce7XhNhaiWlSHEcke9czWkeuH3FI23azQFYLxLL31Vlp5QP+VoqWxEephjGN9PApfGf4PVBGtUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNI3GGF1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNI3GGF1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9A61F00A3D
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 15:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787673110;
	bh=kPtaLcz8oyqb6Dhnt8ZxpZ7m467rVFXuKSe5zifAGbI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FNI3GGF122n8Ouo1BdnWVvOVLXIfgPKuMj24d3XuOq0X6YPaYmfBIfHCkE9Ycj7XR
	 PXx+f16gRbKpX3HXReGVlVEKmNKe26KbRJppXsHS9PzJIJ49NYSKXin0zl8zlhcH9w
	 FyOuAXFNP7AQTddzt1tyq/Px7Y8fnWM1xqwuvS9StNL9ONOAubutZaahfvL3Gym7go
	 CczlWMp4zg/PTvblLMth82n7xyn94trwKSBGQ435QAWLGnjKH1LhFxSVE8ISJd5FNt
	 O8RvWMgvNTwsZvqGJ3ntvKthl0A4OxaF+1/LSdXMT9ZuWWIOPD3EM75EX8x+lh6x7a
	 B6TJUCRRZb2ZA==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a0de062db5so8677349a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 08:51:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqOZbh8I1JWU4iJQCImhjw3M9ESKE5MQh2hI+2lVsOUrxhmJtKzttB3SB9+eNSPjnj0aolXQPkEkBeyzWAG@vger.kernel.org
X-Gm-Message-State: AFuF++kuBKxLfvQG0Y6OkH2uzqjifPev9JqNSydymiYuXYQBep1Yiw+/
	zgYpd9uOJw5nTuoSSKQa2PImiosaqgpZd7KDHnAzGmqCcAsug8cZzqOLGbu9S9PCLGejqIrRrtf
	11jSA/dszfOmhGkS1yx2toGki9c1mloE=
X-Received: by 2002:a17:907:5c6:b0:c21:96e8:578d with SMTP id
 a640c23a62f3a-c24e5fd3199mr1048498266b.15.1787673109022; Tue, 25 Aug 2026
 08:51:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825135209.3135169-1-alex@ghiti.fr> <20260825135209.3135169-4-alex@ghiti.fr>
In-Reply-To: <20260825135209.3135169-4-alex@ghiti.fr>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 25 Aug 2026 08:51:37 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPsQ9J_mL-eYiNEZNu1LdxoVXL-mQ+=QMUvcT_71cf7cw@mail.gmail.com>
X-Gm-Features: AcwNN1VMT11QiZ3TZSju0-KhHsl-_5A2hhHloThY4_24fIsp40qg5IR7wyqhkq0
Message-ID: <CAO9r8zPsQ9J_mL-eYiNEZNu1LdxoVXL-mQ+=QMUvcT_71cf7cw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] mm: zswap: drop cold writeback folios via swap dropbehind
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kairui Song <ryncsn@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baoquan He <baoquan.he@linux.dev>, 
	Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Wei Xu <weixugc@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Kunwu Chan <kunwu.chan@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 6:55=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> zswap writeback decompresses an entry into a fresh swap cache folio and
> writes it back. The folio is cold by construction, yet it is left on the
> LRU for reclaim to find and free later, wasting a reclaim scan and keepin=
g
> cold memory resident longer than necessary.
>
> Allocate the folio off the LRU and mark it PG_dropbehind so the swap
> dropbehind path frees it from the swap cache once writeback completes.
>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  mm/zswap.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 8163e6c5f76c..d16822a516e8 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1013,7 +1013,6 @@ static int zswap_writeback_entry(struct zswap_entry=
 *entry,
>          */
>         if (IS_ERR(folio))
>                 return PTR_ERR(folio);
> -       folio_add_lru(folio);
>
>         /*
>          * folio is locked, and the swapcache is now secured against
> @@ -1046,12 +1045,26 @@ static int zswap_writeback_entry(struct zswap_ent=
ry *entry,
>         /* folio is up to date */
>         folio_mark_uptodate(folio);
>
> -       /* move it to the tail of the inactive list after end_writeback *=
/
> -       folio_set_reclaim(folio);
> +       folio_set_dropbehind(folio);
> +
> +       /*
> +        * Drop our reference before starting writeback so the swap cache=
 holds
> +        * the only one: the drop in folio_end_writeback() needs that for
> +        * remove_mapping_reclaim() to succeed, otherwise the folio is ha=
nded
> +        * back to reclaim instead.
> +        *
> +        * Nothing can free the folio in the meantime: we hold the folio =
lock
> +        * until writeback starts, PG_writeback then blocks swap cache re=
moval,
> +        * and folio_end_writeback() takes its own reference before clear=
ing
> +        * PG_writeback and donates it to the drop.
> +        */
> +       folio_put(folio);
>
>         /* start writeback */
>         __swap_writepage(folio, NULL);
>
> +       return 0;
> +
>  out:
>         if (ret) {

This check is now unneeded as ret should always be non-zero here, right?

We should probably also rename the label to indicate that it's only
the error path. Maybe "error" or "fail"?

>                 swap_cache_del_folio(folio);
> --
> 2.53.0-Meta
>
>
