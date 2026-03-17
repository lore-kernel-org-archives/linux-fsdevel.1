Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3247E375F62
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773740645; cv=pass; b=ARfpDamjBQ16QZFR7uLN/OOsRzqcb9R9NlZZQZ6OD0e23u0tgePCCwilWKARNo8mHL9+U3kM78VexdBZP1SENQdgapVUWz1Symyf+I59cVNa3mI9slS85gtAKgqQmAoIUlaYjz+yf6fPOMzTnAZyM/nY0FO0t4vA/PwQlzocSTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773740645; c=relaxed/simple;
	bh=XRAyMbVsppAPvkz2awJ+fo8bkRCRjr1mCIULs0FBasI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dCA5RjlmkrQEjqRctP+1+JWPByf5qxCldjX1z8StbdKswvkNSjc5iwF7ir9hXGErUzqjeY6r/4ay+c1GQWZpGjLRj+0Py5v5eEMxMmNF0p4VDrOrW0A4MFrU2P/H7P25KYv2SU4qI8Fc5nibM4KF0ud3YzrkQsy9d+dZhodcTS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dfinity.org; spf=pass smtp.mailfrom=dfinity.org; dkim=pass (2048-bit key) header.d=dfinity.org header.i=@dfinity.org header.b=gPdpERws; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dfinity.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dfinity.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dfinity.org header.i=@dfinity.org header.b="gPdpERws"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b955351e0a6so879909666b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 02:44:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773740641; cv=none;
        d=google.com; s=arc-20240605;
        b=X1rz25oMCylO6cM+Mqnh5SRXWv6xcSGgRomlfcbb9/Q0ODVlZ0EgKKpugtZVdZ5jXJ
         4MUyAiBaCtamVUZH8XEQ/YrAvM5xdA5eNwnXZBRcjNrNecxgskGlUw2Bw4w11Z65mjwS
         MpIvF8TySn+X4euIYDmT6ssA6km0NUo1V+Chy1ABQDbj/mYTByZMB8OSRuwTv0IXqmee
         K7jluUNHvlwZqy+kJ7Deh3ZTkBhs7mCt0QUpHB/GQRURgEloL8W0l6OulV2VKUl0BgE+
         71GN1PlZKyJFNJzxal49E9UkGZ53ZLdcjjbJ41QTcG3aqINm5NPokdvclmJe+MKKoKyw
         8q6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UQVXw5BqQPlrykOq9wOrfS0RtHVDvKlRL1okYmgxXpc=;
        fh=Nb2cDWuEotkuZlvBolwYYNKqrNCyhRhsz0oDkz4bZOs=;
        b=f63Zz/S9gArkfCPID1bGk5BNJDXfxR5RRLRZqCfRSt5mIx0dp49D0GB255USulw+iR
         wy7Jms7STaX+4t8zFYgc+6P1H2I1deVmoDudcgL0lZ0kV4Zwl2N1RmxnoxJteTQgJ9TP
         3ndLHCAoi/T35yltwjxgXuevfm1V+F5xDISUSb6zESZPMQXkzUjAkHCn2nfTTFtM52uk
         5WvB63ixloBXGCujXQ2AIBIvHuIbgCdaMTdpHb3/KfW/Zda4ZWZAZXLMQNoHPDzb9xk2
         gpzAySTnA/NeSpReIqZVNTZu+0HNpPEbnaWLnWHSjQKs3sJQQBydD7ygrF9qTuxObgMD
         sbBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dfinity.org; s=google; t=1773740641; x=1774345441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQVXw5BqQPlrykOq9wOrfS0RtHVDvKlRL1okYmgxXpc=;
        b=gPdpERwsrLJyNyYYZHH8sRiTJmbK5mn7X4oq8muv3NcKxJc5EA9/60895IWpcEb/Bv
         2ZaLcNeAUE5YZCuxRUt0JWHeTV3JSfMbLRHEazRDhS1tbhTI+DSdRgQJvH0XYD+Uf5tm
         d8l1ilWvjZ03cnAYd1Jc7XBnN0Ym0j8m1q2liu0mb/o0VYBm+t8YzTA0GFeqmVIoCxtZ
         dss7GsysfXxc5+ntv6CV9rB2+ih/dHQYrf7AbJsnzAdKdyoMInEj59DntByPZxWy9s3v
         iz2jdDmu1aQKfZTtRilLZ46i9Wh8DzEjsWqEn0upZpM9B6YBHjPr1sXN73CN+5qXNaWH
         3khg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773740641; x=1774345441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UQVXw5BqQPlrykOq9wOrfS0RtHVDvKlRL1okYmgxXpc=;
        b=MPr9HGSRiaeWHJmuHRqXR3RcBwYJ/EGQW6ZvJYxbQvW1t4BgiQN8FnkrBkhjN5Yk+S
         QpDHrDy2rSt9ekzce+pnoqLcd7Jyhh5xevFu1U/sZyRJFkmk9iRC7Yeq7pnTpDvusYnF
         0P05IOltE1Zx1a+yWacxnqqqxt7WNT8xdkc15pKXQs29X8jNKYE7At90gvUpAv4TP+8n
         GWFCycQS2Mj5hjorBcSQGpz5kE1wSfwlVai7nq/QSH9UbEtReMe2HNC84owwGxhGvMsH
         FBi6onhGM3R/pq4VrKw7VoFJExDWbsa1C8bNwSGsz0h5PdaxoARxT0GvDX0ylutsmmTs
         SyMg==
X-Forwarded-Encrypted: i=1; AJvYcCXyJ0LOexH1oMLSIM+YpLRbdiiRDwhyoaEGb8FiS/9CvF3oEXwXfN7BIcbYl/GrlJfV+TK3XeRQzuy6lKpD@vger.kernel.org
X-Gm-Message-State: AOJu0YypETJsgb/XuEsodDtWJJBAoCBEEhSG1CEY/wJFaSB5Dqgtp5nf
	TbwJtVJlsxHR/LLeMHb8JlKocyBSttMGE61vtyH3Mz443UzuGcnKgKxE/GCLdpbwUCoiiUpEoPp
	QjOuSslb9zcWKj7L82KjG3TU2wFWDGcueD0kFk2o8ZA==
X-Gm-Gg: ATEYQzzyHAJ7fhWIgoFISOx+HVtuTMz4Y3xYL24NTTat5VJrYQp7sxAcvfEjg0x8Wmw
	D5tYTURhp76fbppjvFPboUDGlCwj360bjs53h6rJP/YO3G9Tup3AH+A9tfxNUDc5iyg8+eVnS/s
	M1YUYFmVno/lL99wh9FESg091OTKrBdOsbcZy14FCCA7l6Zo9kpknvETBdsTHdbcNs4Jq/bSndA
	OZXfOLzD5h9xoJ+pp9Bt/Z6R5iYw6HatLOiluw7WhwnG8GWS/cD69RnreIx7KUDGA6CyXeDtOJE
	1AyVM2o=
X-Received: by 2002:a17:907:60cf:b0:b97:a459:b66a with SMTP id
 a640c23a62f3a-b97a459d1ccmr570643466b.25.1773740641289; Tue, 17 Mar 2026
 02:44:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313114037.3593642-1-ziy@nvidia.com> <EC71CE3C-08D9-48FE-95CB-B6A43B4BDB9C@nvidia.com>
 <CAON2GcE-1t7pbunFwtymxEiz1f5osT2CSEGw35Lv=7UaWFkZzg@mail.gmail.com>
In-Reply-To: <CAON2GcE-1t7pbunFwtymxEiz1f5osT2CSEGw35Lv=7UaWFkZzg@mail.gmail.com>
From: Bas van Dijk <bas@dfinity.org>
Date: Tue, 17 Mar 2026 10:43:50 +0100
X-Gm-Features: AaiRm50lvHy9nwqfKUin80CixoRq3XUbY1YqSLlRzLkGbYylSr1K5KsUsnHB3zM
Message-ID: <CAKNNEtwtgbzGX3Ac8U4gZ40eRiMpmU9EAPM-epsnR85v0uprHA@mail.gmail.com>
Subject: Re: [External Sender] Re: [PATCH] selftests/mm: add folio_split() and
 filemap_get_entry() race test
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Zi Yan <ziy@nvidia.com>, Adam Bratschi-Kaye <adam.bratschikaye@dfinity.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Matthew Wilcox <willy@infradead.org>, 
	Eero Kelly <eero.kelly@dfinity.org>, Andrew Battat <andrew.battat@dfinity.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

No problem for me either.

Signed-off-by: Bas van Dijk <bas@dfinity.org>

I'll add a GPL-2.0 license to the repo.

On Tue, Mar 17, 2026 at 8:32=E2=80=AFAM Adam Bratschi-Kaye
<adam.bratschikaye@dfinity.org> wrote:
>
> On 13 Mar 2026, at 7:40, Zi Yan wrote:
> > The added folio_split_race_test is a modified C port of the race condit=
ion
> > test from [1]. The test creates shmem huge pages shared by both a paren=
t
> > and a child processes, where the parent process punches holes in the sh=
mem
> > to cause folio_split() in the kernel and the child process reads the sh=
mem
> > in 16 threads to cause filemap_get_entry() in the kernel.
>
> Note that the fork isn't actually necessary to reproduce the issue. I
> had it working as
> well with the reading and punching in the same process, but just with
> two separate
> mappings. Not that it makes much of a difference - just in case you
> wanted to simplify
> the test.
>
> On 14 Mar 2026, at 18:27, Andrew Morton wrote:
> > I couldn't immediately find any licensing info there.  Bas and Adam,
> > please advise?
>
> GPL-2.0 license is fine by me.
>
> > And sending your Signed-off-by's would be appropriate.
>
> No problem:
>
> Signed-off-by: Adam Bratschi-Kaye <adam.bratschikaye@dfinity.org>
>
> Thanks,
> Adam
