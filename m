Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D433B636C
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774011234; cv=pass; b=SdxsrAnAljCx84qaBXrJQlJnsP8bm3Zf24a0t8j2A1nZncuUM61xGCZWlJj04bsZIuHWmj/9Tjcn9xErCJgorkBsP9MHTEu8aLmxUKlKw0NqDFhCNNiuM+QuHVf6Kw9ESUsrkOgUdl+QX0Rvn7Wtq+hYUxxopHSl/wOLOzFUblU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774011234; c=relaxed/simple;
	bh=sxb40RyXjBOvkVq2MrBV1Eo8DmTziCzGNtpBWcwYXIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKp3ZrXLOvQ0s22L9zpknSCjoDWobDKJ2Y/CYr4C0LuW90NYqcVJ8kVUQZxBClmO2v890qadPgG4XbpkhP/m75Oj3AgK1PU2Rm36lT9RBqZxmTo11FMfZ6HvlrjPDDJZozBSCTtYGEL5WgnmuenP+D0qm8V7bEhO26hLw+NGfb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=KzF4l/Xt; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="KzF4l/Xt"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-668e55bd36bso606029a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 05:53:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774011231; cv=none;
        d=google.com; s=arc-20240605;
        b=cnpspe2WDz4pfR2TR2WiBVB8Fl8ySzOP0l0cJi7czfNL+Gt/I3QeCqGeD5G+5mFPIP
         9Ozrip3ULE6Tm74XCdv98WXHaffgm/0Uov111BXQKHAV2ETYk1Ca3ZnT4Pnq9liHNWTx
         DcR04lU9nJJKy8RlwbKhwb8kLA2L0pOmCqO5gSSGxvDLnkwCeI9hBQWBLzjKtErz9FVd
         OADTb34QkOQQFZjooqkoDkHP6MlL5BS39MxSOmFq7XuRDo8ukWWbwlc89vDRBPN6CViB
         xsaRCsl1Y0HLHqQ1Flg4bGb7A2zqLidcPGN7HCUtnixW/Tp/5lGR83jyznv+NAnDteSy
         Gobw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sxb40RyXjBOvkVq2MrBV1Eo8DmTziCzGNtpBWcwYXIc=;
        fh=inPaXuNf/n2Vuj9TCnlmR/RtF5bTxc9KZdIjSxRppco=;
        b=T8t/nr4eG4qEF1EUSpfoE+MtnotyWeo8vKEgO1h+6DPEwz9dkQZ652MgG34dj/RuT3
         R5gF2V2e3Dbaxv1P8WkxMNAR74aHTi//BYuiK7W6U+Exq9l2VQug3ld95VDGoH0Nmu+3
         UFqlt6E2YnifosbIjrAKovUPUMYfQe8w1X+JNuH3lEMEpAze2OEUuGyg7xevDjR5zV+v
         2597C5szjEpkalDrap8zsY7klz9VZ7c3xeaimbbqP3GN1lAaaj/VLAZm238Rd5Nx7jXs
         eE1IYlUnAdsNlYAwjMEVxRZT2hIQxgWf43IoZj9DL89Y0M6Lg5ooxGttffxsKhR/5gaB
         h0GA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1774011231; x=1774616031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxb40RyXjBOvkVq2MrBV1Eo8DmTziCzGNtpBWcwYXIc=;
        b=KzF4l/XtYtURcNfK6k6dMJivuS9fEDK6V+KhIXbVeJaKQbuIIpUemY7U6zzB+2diSi
         MmYXJyhGwJajPJeRihZPFrnvVUe3nzsEocb1cv8atkwixgi02iMTnvt2TJhi5ZcqmGU2
         bhLxTcWA6JYzuPYxih/bby4MnTq7pJHYfOhqEOyE7UVc0HPx/OJ43T5b933ystcOqIio
         WDXQdg1lWpg0irLPLcGNUYK5T50vcdqQ7Yrf2y0dPK4MrTmUJ/TanozQwX6OSGtqe8o1
         QKfOSzMQzdwCceWoDOk5RRsEPMibp2PJmBbOycob0DtlQFKNxC02uJDCg4W78tGSp8dq
         LILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774011231; x=1774616031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sxb40RyXjBOvkVq2MrBV1Eo8DmTziCzGNtpBWcwYXIc=;
        b=GpTbEvILka2L++76DnGd2BJZtW7Rn16bM9CmSOfF60WpAPg4WhAcrmGIpBhJAm+FoE
         1062xvigOp3BX9wScTNXyaBvkxRILuPX4xrY+BKln/sNSn8l5T5Ax3afAOQB5EUepVL6
         VddY/FRQ7jeT9ANBm7+zIrvHazfbBM9smqy7u4tPIsPTPuG8ctEsjyOVWrlD9mj9f2L/
         nm258xhdFwh69Ks/Lt9NgOYBolgSZD3GxDmVIDtMFRI5kMyabc+v0MYdYLBIQ/H7KqAv
         ANQza8iCVCHvW8i4ve/xCAXS6O/msDGWikUOscDL+qhA+UNTA9AP1BCYLRGqddN/ktxZ
         J4sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQeUuYFysgEz1jQbAkMId1zowCO28GcD1BSz7CdXh8Y+QfmCn06SZoOj5t7HeeZKmZC8lxcfqdHtuMpHY9@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr7UUZaNhoIa2riwOIDN2SBL8W2KtE2JXnQ5GrwLRTakOjCzlW
	fdC+Uvxt82BYM077QfuJbkkSepoDgihm+lQSL4xXnIA/w9XSmBloCsaODVMvWTo/+JYctKbKQ1I
	wWbIxv3vd+g01b26kBwYF26FAkjGftJhXgkFturajEw==
X-Gm-Gg: ATEYQzzo+h1q3bqlXlsYa0gz6PUrrts0EWllQymAJhTOtMmI3EI5Wl2tgPnexwUREY/
	f196vb65D1YEwbjWAaszlX1gmX0Yxl/cuwWdd6NixT3nzjeRhVf9bOnjV6IWAhUojYj8QfrtGEH
	UILP7tcDU2GGUO/WF9NN/zfvNNgXmds/LGPP1qMletmfGdt8kPxlekrM5EorZLSm+AAMmpza9Yt
	KU3DrQLw6SEeTDraEKBKBkSUwe9Re9aYRTK4Vf0+dKWxEkOzc5fqzwu6G2roA+k+H7bWU8nE0rS
	Q74IWzajTp6+nBk1oNJtMFK4qZfPb9jFlpfayQ==
X-Received: by 2002:a05:6402:4542:b0:662:b884:d1c with SMTP id
 4fb4d7f45d1cf-668c9420fc6mr1899113a12.10.1774011231281; Fri, 20 Mar 2026
 05:53:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317023834.487682-1-pasha.tatashin@soleen.com> <2vxzqzpeaj1s.fsf@kernel.org>
In-Reply-To: <2vxzqzpeaj1s.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 20 Mar 2026 08:53:14 -0400
X-Gm-Features: AaiRm52JEkyZm6b_G1RRMaL21J4AyKm75SR_joFkY5PERgm0yr9pb9DptmMSN6c
Message-ID: <CA+CK2bC+U9BfPAScE4pvtd4BVbEZohy1xH9BT+_gN57_NQ-rZw@mail.gmail.com>
Subject: Re: [RFC] liveupdate: prevent double preservation
To: Pratyush Yadav <pratyush@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, rppt@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 6:31=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> Hi Pasha,
>
> On Mon, Mar 16 2026, Pasha Tatashin wrote:
>
> > Currently, LUO does not prevent the same file from being preserved twic=
e
> > across different active sessions.
> >
> > Add a new i_state flag I_LUO_PRESERVED and update luo_preserve_file()
> > to check and set this flag when a file is preserved, and clear it in
> > luo_file_unpreserve_files() when it is released. This ensures that the
> > same file (inode) cannot be preserved by multiple sessions. If another
> > session attempts to preserve an already preserved file, it will now
> > fail with -EBUSY.
>
> For consistency, would it be a good idea to also set this flag after
> retrieve? And then clear it on finish? If we do that then I suppose we
> should rename the flag to I_LUO_MANAGED or something similar.

Hi Pratyush,

That is a good idea. Between the retrieve and finish operations, the
file still has limitations due to LUO ownership, so keeping it flagged
as managed is useful. For example, in memfd the memory should remain
pinned, and in iommu the DMA mappings cannot be resized until finish,
VFIO also has some limitations.

I will rename the flag to I_LUO_MANAGED and update the retrieve and
finish paths in the next version.

Pasha

>
> Other than this, LGTM from LUO perspective.
>
> Acked-by: Pratyush Yadav (Google) <pratyush@kernel.org>
>
> [...]
>
> --
> Regards,
> Pratyush Yadav
