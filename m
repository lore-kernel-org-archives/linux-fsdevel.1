Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF7C282F03
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 01:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783386376; cv=pass; b=AN31A2S+R5Zn+qS83cJtP/yDFZUZiJtfzihBUO7PtlxBK96yTfbYtw04NJpWyNtyKH9mFe67YBJldPNzawHNDCllWL25sgUT6H8DjClneXqkWhfq3QNFRy5EpvCQXh9Vkpi76eNyMf+9OFA4JKB1OXe2TQ3WAJuAV/ltNWJ5pjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783386376; c=relaxed/simple;
	bh=1cVUMFMBeoUz0Y8dmZcg+CAn0nZ3hquYpnV4AN1MMHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lZUMVvbcWJ+CfWXb9Ms1y72yL5J6nS7oOIYyRz0ph9iajiyrBseodLM8GRuWfdcUMq6+Yb5N8MSqI54cnG+Qh/YFnaBK0p/jQrbiA8ygX0nUKmBUnP/lbVtrkffqhVSKOxXcxQoXrflKP2yq9HN8AvByN2ImWKESTJOrNoKpW2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BANOuUAI; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BANOuUAI"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-698aa7ba3e6so6255984a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 18:06:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783386373; cv=none;
        d=google.com; s=arc-20260327;
        b=Zx8OV3x8FhY81CmDBKEtxHfBiffgn7EYktSziiNCLJ8FAlRIuXuzZ1jBeJO2Nb9RCo
         8GCfN2QaQsoQcL97hePuy1t0HPTeEDrU5a0Pxz0iZgOW3a6R4I6WJH6/GY/Rlb9VYSpu
         T97eAajA5MDGNvPMlGHy918oKh70lf7r2WBNM903XGY9qhv4WpgYzvqRX432VQI8A2yp
         oUAnBUUoKIsSV8+E41Gvxp0eydBhq9dhYztAQ+f10Oh2VRhaLNh4K9s7bw5h3u/Cgi3W
         Wyhflr/M+dasBcX4R4eROcJAo0UltE6W/Y9A3DgYaFlPVjGM27lXLGEeFlaWILJ93Cdb
         WJPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e0WA+1xWMmwxJhQG3lcP+OMC81WDVxu32cEwJ7yzLdU=;
        fh=izkOpUwV00e2PT6hxLVnG0xXvAjUUWOEkgw1wIIedMc=;
        b=SOZtRK1L69qx2FYRLgNZ3deY902pm0XAF6whm1dGgDo08W4ysUBM7/ami+BQmbpAOt
         WmTbvRxvrniGONJNX8fUljpvo4/28QZ+mD1CJ2q+1Oof9qLzQjt5EdmVlvsyHhwdL+z1
         E/jguERn6NenY7OfPDno5H0N+f2TjxNaYgZ4TBf8axYK+22QqQl8XgVkoLgrxG4/IBD6
         kVGA7rDvc3HHGqGViIK/CE9WeEVII6dtNjMI39BgjKhQaQMQ/H7RNYXUvEDHnP5IDLTc
         0zKJQCBffpGSQV35a8f+GaWedw0GD2N42Z1VMnp+HdrRm6pkt4cXhqekBe6u/SEvpZCa
         IRmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783386373; x=1783991173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0WA+1xWMmwxJhQG3lcP+OMC81WDVxu32cEwJ7yzLdU=;
        b=BANOuUAIXh0wEwFJ190NYWVKiiudeeVuwHrZrZyjj5hhHBbwPKPMB2FI0dK4Xsr7vo
         PdRqJp3/OjG0/fuu1A+aqCXJSkTrh5KGGso1//+hTSug/cscGSYmMcCVrbj7Eew+ji+i
         suPjk/fysWD2J29k0ARC/DXpSb/ltzsrIN+TFQZzUGkVsvHLtne9arLIfuYHYvfRyYRV
         uodpvLFlT1K5hGSeDfJ6wkyyhhKUmwbvyG9oOqzyvJZs7XLzzzEdeVtV12UISTUYah37
         /UAORNeVTCsacd1GpMPCgbtwDzhM+7NcKMQGbcdtCXSSN1zkig9sWZGvcMVaz201fC5L
         6j6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783386373; x=1783991173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e0WA+1xWMmwxJhQG3lcP+OMC81WDVxu32cEwJ7yzLdU=;
        b=SRNjZ6UkOyTGVYqnK/7+BblCnAfRAhbe54ue8PU5/m7TdoQbhbhCrYgQh6fPC+oKGs
         44mrKrdn8nEuHFNtVMG5lAS61rRrQLlRvafNmDBm+CCr3+ZTAhvC4cAClwUC3EePQD0u
         Km20+hdon/73HbIOxJheWC1FdEISsIfBHFsgxfT6P4UPaTCSpSvaHS+e3BkJ8Q3dpmej
         a3exCE9UBGu1w8MtzsFCiENc3CXFdIk3Bqtw52X4hgEK2IzK5bFNm1xJWN5VXfdellnF
         c8vuvdwZwOMDjxvY75/NfuG1N+/3Iw84F67aSDT7qfyrsLXftVqVD9fD5DLrKck059KL
         PKQg==
X-Forwarded-Encrypted: i=1; AHgh+RqbugitTmhJNYgJKmXjVDDd7og44t+9VB6gjlUrN9yD/ankZelvS7EH5aENU5Aw08YE5v3zeVmOdHh6PQaj@vger.kernel.org
X-Gm-Message-State: AOJu0YxlcfsiMKrgwlT5wAIUxzduJ5QRxbsvxvU/ANTjBw89IHMZgg66
	7ydodsZ5VBAannOJuNRup4XzcHqobUwWl+rUartG9qLcgavSpJZgRINKdLG850wsif8gSCQ5WHW
	eZX5hfd0QyELuBz2/v7vhi0M8uotpdED+FQ==
X-Gm-Gg: AfdE7cn4RKrjmvKHW0PcbDrYw7vKb9o23xWTtgVIQERMx+HdDoIyHiiQ80zbWC2uV+5
	VdhIz72Kf1s9Qgonl1DnGNioWxIMMOUzlIhfsCnGIQ98UVu6xua2yha7X5E3E4zSdBrNbwKiIAN
	QU54SnlZLcnPgHgHxxBFNaVzRFDvHnfR+sfZUNAXO6nRxVbBBIJ9lJsufYnWrrfwikGYrlmug+t
	dQuyDWMCQFqoxfPXT9BRyJnohTfa5x+ISAtHh/uYKxO8ft1fZLbaoDcDLm8Q9tkPr82ziwDrJTE
	RGxl4JCeBGkyGb/YEHKRaNZo/Okhx7U796Tb76UL4yIjn3LDxcjXEhew2GBhCFfmrZdQUzMzxA=
	=
X-Received: by 2002:a17:906:a2d9:b0:c12:cacc:92c6 with SMTP id
 a640c23a62f3a-c15a699604bmr108442866b.59.1783386372722; Mon, 06 Jul 2026
 18:06:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703092815.4602-1-swethav0411@gmail.com> <CAJnrk1bxAfK0QJQtQ213T0ZKhXu4Pi=2wfRfZ5u0_frC8bucDw@mail.gmail.com>
In-Reply-To: <CAJnrk1bxAfK0QJQtQ213T0ZKhXu4Pi=2wfRfZ5u0_frC8bucDw@mail.gmail.com>
From: Swetha Vadlakonda <swethav0411@gmail.com>
Date: Tue, 7 Jul 2026 06:36:01 +0530
X-Gm-Features: AVVi8CeXlaZFCuhFG6NwSUSQ8oaTkB5rs31sBMoBozWu9soJY8C4jbsGkGRjM28
Message-ID: <CAAoLz1fpotiSjFcthTEMZEAaKbhtd0poHC2w++eWMCa-euoKbQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: add folio_max_order and folio_min_order controls in fusectl
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 2:40=E2=80=AFAM Joanne Koong <joannelkoong@gmail.com=
> wrote:
>
> On Fri, Jul 3, 2026 at 2:31=E2=80=AFAM Vadlakonda Swetha <swethav0411@gma=
il.com> wrote:
> >
> > Expose `folio_max_order` and `folio_min_order` entries under the FUSE
> > control filesystem (`/sys/fs/fuse/connections/<connection_id>/`).
> >
> > Motivation:
> > For fuse based systems like GCSFuse (Google Cloud Storage Fuse), large
> > folios gives a significant boost to the read performance.
> > - Without large folios, single file read perf is capped at 3GiB/s
> > - With large folios, we are able to achieve 12GiB/s, 1MB blocksize
> > - Writes:2GiB/s with large folios vs 1.6GiB/s without folios for 1MB bs
> >
> > We understand that subfolio dirty page tracking is not available for
> > writeback cache with large folios. However this is not a blocker for
>
> The buffered write and writeback paths in fuse go through iomap which
> tracks subfolio dirty state.

Thanks for the review and update. I was under the impression that not
all changes
related to subfolio dirty page tracking are done.
>
> > GCSFuse and similar cloud/network-based filesystems for the following
> > reasons:
> >
> > 1. We generally recommend applications to use larger io sizes (>1MB)
> >    for writes because of the latency involved with the network calls.
> > 2. Random writes & small overwrites are also not recommended for cloud
> >    based filesystems.
> > 3. Beneficial when write back cache is explicitly disabled. Incase of
> >    GCSFuse, write back cache is disabled for different other reasons.
> >
> > Providing these controls allow individual filesystems to explicitly opt
> > into large folios once they evaluate their specific workload patterns.
>
> Could you explain the use case of this granularity? The page cache
> already adjusts folio size adaptively (eg small/random i/o still has
> small orders, high-order allocations fall back gracefully to
> lower-order allocations under memory pressure, etc) so it's a bit
> unclear to me why a tunable would be needed. It also won't enforce the
> order for any inodes that are already in the cache.

Our primary motivation was to give fine-grained control and users can set
it as per their workload requirements. But agreed on the fallback strategy =
and
have a single on/off switch.
>
> There's a patch to enable large folios by default [1] and the
> benchmark numbers showed improvements all around, so I don't think
> this would be something individual filesystems would have to
> explicitly opt into. Does the change in [1] suffice for your use case?

Yes, the change in [1] completely suffices for GCSFuse.
