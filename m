Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4392F372ED3
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 05:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776317446; cv=none; b=uwK5dntGFl2Jd8begP6HmbevCWP8coZTSVrJwDRdCurjARNFRVxaz/MciFKyvg01dMeBMLSasOMCumdJ8qOTzW/TvY2CPgPMuXgjBKoKOxv4+jpMwuWlfKGxZnbYOc74tBT2YMMAbgNKoUtErgcLb7C2B/cZkEx/NLz8gOBSolw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776317446; c=relaxed/simple;
	bh=BKdprjO9iqrDHMjwSYEyQPaHIfGiuPJrNzlgJ5M5gfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QtIKrTUdmjGZ/wtF4Kpo7QCZWY8n4C7hRy36wthYUB0fxck+k12e8ZZvpa7v8tW6nD3tnEqDhTGmYwuPLp66U4HCucDCfLDQiI3NH9+ggUJ47bgV9gOsUXYal0jNzxQb0rGAIRIk0UQWjlidYPw1uTe7Dg7O1vskWa/QH0J/9Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRxBNGsb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRxBNGsb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1940C2BCB7
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 05:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776317445;
	bh=BKdprjO9iqrDHMjwSYEyQPaHIfGiuPJrNzlgJ5M5gfM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nRxBNGsbpf6lT8jv42FQYWUnfQieCV9+Bt7qg6+somtTS0l0KoUmf/4olundcIat9
	 5EfcBH9UYrW0sGjyd6lF7LXXHITZxZZuM6PMwLIIwvyBSJoTtMD1U2F5SwoZwxeyG7
	 8QtFrmOsPMYD9tTnToEg/TKjKIb61eUIx4kCCHXwKOl34z6mP8FDbSqce1mp3jJtAJ
	 t0O7jKUX9pIII1b8RCwGFD13BeF0LLAjB3/9PyNVv+Mb++Xf8+DG3/C38swfs8PIWc
	 xGsB7cnbs3jrUrLVGufSxDyGOGnDhh+XitgEqfIzn3Ko2O35uiitJcmodJpt/9Y5oy
	 8yHo68SLFF4og==
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8a154cc6a48so88860106d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 22:30:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/WyGJcxSk2heOvbTXLAqLjh1PNxNIrzUidnwF8qORR2V2QcuyvlyzzDW6XSBZo6O+2bax4V7Svtft/RHHg@vger.kernel.org
X-Gm-Message-State: AOJu0YwS1wQQWoeq1aq21Eq7e6GFLU1scM3Tnj2Xor3FtzDYHyOOagvd
	lzSyqH/Ug8b5AubOaLoE0hcuCwIJq9B8oQIN0Yt/MLnXt0zVnycbn5Gb2iF36onu/EZAj4HaFAK
	JlZw41djAHiSJ8WadeSvwicYZCjftw+U=
X-Received: by 2002:a0c:f208:0:b0:899:e567:f04d with SMTP id
 6a1803df08f44-8ac8613a0c1mr388294306d6.11.1776317445207; Wed, 15 Apr 2026
 22:30:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415192853.3470423-1-stepanov.anatoly@huawei.com> <20260415192853.3470423-3-stepanov.anatoly@huawei.com>
In-Reply-To: <20260415192853.3470423-3-stepanov.anatoly@huawei.com>
From: Barry Song <baohua@kernel.org>
Date: Thu, 16 Apr 2026 13:30:32 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4yBmrFDHLg8Cf7x0dCLELBp+kY6yoMuP_sHt4Z1wuVrBg@mail.gmail.com>
X-Gm-Features: AQROBzA247U2xaU38UZDq7xvNkV4HsQyvZYePko41DYVZxoaxkV_BD5AjV-0F4w
Message-ID: <CAGsJ_4yBmrFDHLg8Cf7x0dCLELBp+kY6yoMuP_sHt4Z1wuVrBg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] filemap: use high-order folios in filemap sync RA
To: Anatoly Stepanov <stepanov.anatoly@huawei.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, david@kernel.org, 
	ljs@kernel.org, Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, wangkefeng.wang@huawei.com, 
	yanquanmin1@huawei.com, zuoze1@huawei.com, artem.kuzin@huawei.com, 
	gutierrez.asier@huawei-partners.com, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 7:47=E2=80=AFPM Anatoly Stepanov
<stepanov.anatoly@huawei.com> wrote:
>
> [Idea]
>
> If a mmap'ed file being accessed such that async RA never
> kicks in, we might end up with only 0-order folios in the page cache.
>
> if fault_around_bytes is larger than 1 single page, then
> it's beneficial to use high-order folios, which brings significant
> filemap_map_pages() speedup.

Please note that there have been many complaints that readahead
pages in PF, as well as fault_around pages, may not be used later[1].
The performance of filemap_map_pages() is not really that important
compared to pages that will never be accessed and could otherwise
be reclaimed. With large folios (=3D fault_around), a single young PTE
can mark an entire folio as young, which can be quite harmful to
real workloads.

> So, let's just use fault_around_bytes as a starting point here.
>
> if an arch supports PTE-coalescing we can get more of those for free.
> (see arm64 example below)
>
> We don't save the new order to "ra->order", so if async RA will happen
> it would normally start from order-0.
>
> [Things to be discussed]
>
> But at the same time, i can see drawback for 16K, 64K pages, in this case=
 fault_around will still be 64K by default.
> In this case, it seems makes sense to make the fault_around_bytes be like=
 order-N of PAGE_SIZE, not fixed bytes number.
>
> Another issue is - when fault_around=3D0, but we'd like to use high-order=
 folios for sync_RA, for cont-PTE for example,
> For this we can use kind of "max(fault_around_order, cont_pte_order)".
>
> Or introduce some dedicated tunable like "sync_mmap_order".

I guess we could benefit from a small order, such as 1 or 2.
Order 4 is really too large for many systems, such as Android.

But it seems Matthew never likes new control knobs?

>
> [Benchmark]
>
> Simple benchmark below reading 100M file in 4M (RA size) chunks
> such that async RA doesn't kick in and the page cache ends up being
> filled up with 0-order folios.
>
> The patched kernel gives ~3 times increase in throughput,
> considering the page cache is filled up at the moment.

If we consider reclamation, it becomes a completely different story.

[1] https://lore.kernel.org/linux-mm/20250916072226.220426-1-liulei.rjpt@vi=
vo.com/

Thanks
Barry
