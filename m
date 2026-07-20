Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D2F31195C
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 18:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784571955; cv=none; b=keanp1dKasDraoi64qLx9/HCaRaNxh5k3FF//+hYabaZHYEhdXGYa3F/PRATP0i989B9uqr3W31jPdi7hrWSD75OZaKamlKunySDQGCAbaA5/IO4qch5VJ5wmVpPoK9/daNQwANA/8KvjXwVL/m2B5epuonnOLd9cIuSZcVTDEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784571955; c=relaxed/simple;
	bh=CUVO/0f068Y+94S975oXY+2rDBvV6tZxax75QBdgQSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qa+tC2SeHOX6dpldVUOTh6VWi8kexAeQ/goefgqbKrXFdwvNqN3bQby7xvDUZSLVwnm02eeNMiMCxuHvBFpeLmWZVarqTPZ3ZghMQRTNM5bqYl5qKWqZWex9iBlbNdv8xU6V2Y9rYEbfJU93DNrMzgHacf6068qagxC92HQUyR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKk6xpOZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKk6xpOZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758AD1F000E9
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 18:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784571954;
	bh=LOnFljFhV2dUFdU/uIhu9/nha+9HOsRpmQhNwC+zfoI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JKk6xpOZBt44TFJXkCqPCizf/0tLncTcgvjOLcLA9iuIicp7tl0p26CR7H/RQE1YI
	 N+Lx9m7x1YkxEmOuaw7GICmSNTqcp8nlQ3H/dfiVEHQ9YLnvzXyvVUynA19akdVXou
	 2nAAxaqoJeDYjJNrBOGBhP9qEwX8oLJ8ury3ztS+gdX2WZ/zCE29ZYTSPJoPkGGKuk
	 J3QEXdZX1eMTp4lmHWSEQOzFycu7MHorDsZoIxygf2KSLr3+GuloR0f8CTQNYjBKcL
	 U6AwpzY5F9agCHrakSf3KsJVkQVWvz4C0203l0NJp5erBCdPWsiFcR8DlW5TtA3Cqx
	 DXrzFrJ/T2bcA==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-69a5ecbbfb2so11644434a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 11:25:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqgYGJl5Z+UUY1+R2NTsxklBNleksc6IhbSY4eLhpbQc+kUrKcfo/s40mmr2nVZ7dXA6IW7p+xS7UWQk1kU@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+PTTcRMAnpSSioPAtg99M3GgXqvsT9A1VZ+jUinVJlKxUWNPA
	zI6f6XKeLFFnNDDqwikZkUZsxbAhIsel3hP9WNaETJKIQrZTS2a2WI21Zz4JpyXoqX0D7Y0Xe0Q
	0lgfpQZMPEKL93edo7GAH3iAEYaIL55U=
X-Received: by 2002:a17:906:eec8:b0:c16:2e4f:a372 with SMTP id
 a640c23a62f3a-c16b46cb3damr736150566b.13.1784571953371; Mon, 20 Jul 2026
 11:25:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718093723.153324-1-alex@ghiti.fr>
In-Reply-To: <20260718093723.153324-1-alex@ghiti.fr>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 20 Jul 2026 11:25:40 -0700
X-Gmail-Original-Message-ID: <CAO9r8zM9SQR97cAJ2wLuJKjgi4oYatPP=3B6j=-hUhNFiGHDFA@mail.gmail.com>
X-Gm-Features: AUfX_mzJlYTx2MaKF_YFbmqzhrvy6YfFAfp6DJB-04xyhOmv1DJgR7SEquMo2tU
Message-ID: <CAO9r8zM9SQR97cAJ2wLuJKjgi4oYatPP=3B6j=-hUhNFiGHDFA@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm: zswap: free cold writeback folios promptly
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baoquan He <baoquan.he@linux.dev>, 
	Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 18, 2026 at 2:37=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> When zswap writes an entry back, it allocates an order-0 swap cache folio=
,
> decompresses into it, and issues the write. The folio is cold by
> construction, yet today it is left on the LRU for page reclaim to find an=
d
> free later. That wastes a reclaim scan and keeps cold memory resident
> longer than necessary.
>
> Free the folio as soon as writeback completes instead:
>
>   Patch 1 - synchronous-IO devices (zram, brd, pmem, ...) complete writeb=
ack
>             in the calling context, so the folio is freed directly there.
>
>   Patch 2 - asynchronous block devices and filesystem-backed swap complet=
e
>             writeback in IRQ/softirq context, where the folio cannot be
>             freed (that needs the folio and swap cluster locks and may
>             sleep). Allocate the folio off the LRU and defer the free to =
a
>             workqueue, which folio_end_writeback() hands it off to.

I took a quick look through the patches and the implementation seems
too zswap-specific.

I am not super familiar with how the drop-behind mechanism works in
general, but it seems like it's currently intended for file pages and
not swap-backed pages. From a high-level perspective, it seems like we
should add support for swap dropbehind in general first (regardless of
zswap), e.g. by making folio_end_dropbehind() properly handle them,
and then have zswap opt into this?

I guess one of the challenges is that folio_end_dropbehind() only
frees folios in task context while we need to support interrupt
context, but this also doesn't seem like something that should be
handled in zswap.

In theory, there may be a use case for doing dropbehind for swap in
general, right?
