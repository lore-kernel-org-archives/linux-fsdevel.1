Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793718781;
	b=FyHkU5l2qMqQsIsdGJMNB/nUKceXHQHRhIjF7yZ/r5fGwyjiLMuY5UtMqtjNr0LtiNaz
	 SSF+rz4bC+uIQI5Au6efCqPW1Ll3uaYd2RAe2AWK1BjLXtjCEDc120SyodS8SKtCH9E+S
	 0sFj+affxvRt/mbzsQgpR/JwBTzGV8nXvhoCP+mSFfsYv1ZElptpZjnF0Umh0lEiUw48n
	 ThjAo+9xiYwy76uKuYEF/vjbTDLakQOwXWsNMqBP+XAgcWMsqp04iQd7cMpFy19ZyFvnb
	 8r2AyvDvrkePWLzBwASBq9biHLjbU0KaWquEKGN9M52AOT3xPQMoPaRF5N97Etc2xSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718781;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7cMnatEM3HIlL4UaH1i3lvKdnRzKCLctOQy2OXRyT4U=;
	b=GJWl+VOSnJLzX2jfDX1vOx+aZs68IQYpYOKbfl0seOuQKUtGIPK3qNndje9/KWNqNmAI
	 bpWgOymTPdbsbYWEB4bfNnn23vVmeerqRVhaPdBUJ/cBV+9uHQws6Xwd2Wz6KnbrOkK3z
	 ZmN2qmGqOEgViLb4PaTv0wEONMV2MuRGhRWtAvQeY438S+bVWFrnB7vIJv1N7GY3BFply
	 ev7FgNVdeZbS1WiZF5VtFrMaML1rhhom+8RSpa1SzuJ4natuyLTrClSHu2WbAcPBxbbdM
	 285ZWDHerptSvKbgJix9HoA7SLsN3k4+dQO6Mp6MYfV+NezUotccAjo48auLeaHtQvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OvFvtKic;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9161F606B24E
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2026 15:12:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9161F606B24E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OvFvtKic
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b1aa27963eso1221240a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 07:12:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793718775; cv=none;
        d=google.com; s=arc-20260327;
        b=WXnd61e9YLbwUNxKAmKgjopnzK3ZsXW61m1peZOA918NWbYjlX8KGEXQvTRRgtGdNS
         De54SiyZz7Hy8JGJUrYEPpUAoWtFqcvBXEPELrC9MPO0jKxyhoIL3hPmze0y1Le/Umb+
         EN1nDsBcEFqk1Br4gnXLKjTEl8K1nI6sNdinTs/5ZsrrTH36VqE1tZ/EmCnAsAtIiZ1M
         QhtBMXGx8eTT34Rmk9hQa5lV+P5Qs4DyJ22aPsPFkZ63XmE0RiRRgqddGALUccZEaFBD
         8q5JuaLy468JOGofXsfR9p0ddtwOU/tnKOqdLg6RBgdrDtnU5cfkm41ofCWyPQRigi1i
         Jtnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7cMnatEM3HIlL4UaH1i3lvKdnRzKCLctOQy2OXRyT4U=;
        fh=J4a0IerkBe4UDDLiEZkvzWYJv8PhNvPrMGinyBTKCVo=;
        b=etPeRv18p2aJkxtOd6ViRR6Fq1I7PHonzw9qa2le5aed6DI/wM618GT9986/58cG84
         rvulwf3ofcpHh4r+bUQlfMUk/6qjbAkKzARe+T++zyJHPvMPOf0Webx57vZl3zxsLkgm
         qgnK9poML0w46SyuysvN9L6+1Fs69WSAMWVKPeH4WSfSVEMfof+TvuKYQGtHX4G663aJ
         W3jCVYwdeDPuO72LR47Im/MPGgyUTvelw26pmFvDKLnJjUGZNSx/DofnS6cpgfzrNqi+
         AuYVYQpPDGiFOjIwpbshCf5fmBU/USm6glfC2Ne1xfXDx8fcamyDciua6gZpHLz1Toxn
         bD2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793718775; x=1794323575; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7cMnatEM3HIlL4UaH1i3lvKdnRzKCLctOQy2OXRyT4U=;
        b=OvFvtKic68lKCYq5u4vqHczl3baTPtF15hOIez1MaJdBuzdCpImLq5Qv7L32t95reC
         ew8jluUvcc+N3iPd5ONhE6VQMsevXPTcnFcQMaMAXtydoe1Hvu4ufW8rct43NHU52g5v
         X6kQhB503r+JeDBVm2lVapqlL+7T5XwUc4QW0kNnCmhuVPRXuTmuIrietp2CZoQSDa/Z
         4jg55kmTR2BGZX5663w+3TGaH1OHMO4OEHB3ShEet7gRgN/NDGqdS+XvhVI8/KoYJeGO
         ZH8EsfNHZpQ1Z4aUgHGqr2/pfzFkq3nT8y24hz069Du181ff3kyUHLwqV6RHhY7o6PLP
         P4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793718775; x=1794323575;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7cMnatEM3HIlL4UaH1i3lvKdnRzKCLctOQy2OXRyT4U=;
        b=iBNGeQ1/R5mW+aUuBZjGNosg75s3P/imPxDwQPdxUHHRPdzHIWxH8wHe91Pmce+dMB
         MTz9GLAyWwwMEQXv56JIVf2Du3b7wnL2xjyni1O9oT0jekKuCjPkZvl9v/Vmcl1pSonp
         Ace0w5CIUXtMuMewwBuYQV/9aCWw1iDSkdiZzoUWlxOr0gCwOxSXmHSJmEjfDHHQ1UgV
         g4Bx4jNSnlRNFCuXd1smfYsU4E+t0Xy/Ve4GYx2s9tENKwttEPtcyIQceWzdTXGKa4jK
         UK1SAOd2O14hKzCFs30ZM0lHG9ChNzE8XX3Wz9l+KrSuwyC4ovGCRinL2BPaPJ5xn5Qy
         AsYA==
X-Forwarded-Encrypted: i=1; AKwUvBwaJG9K5tc+8mJvwqp/xw1HU7/w7WSc2bLOZJM38WTjKBed87Cmo54GLrex/K4h1JNZB7GhWtNYg9aBFzNz@vger.kernel.org
X-Gm-Message-State: APuU4Z/UPD2z2c1tmx3cP+hFyZdJTdrEtYOmQ1Z7NPMeiDDIuzNhgJiZ
	KH52iJDmvy+IzyE0U6C1k4Sy37Xc+gTLkKtO7qMaCz+BDsfKlwrEOyx4o6rmvbMw0FYsJf2xuET
	eWrDk3wpss/FwjfMhDlzYKapqdpvZwnA=
X-Gm-Gg: AYBFou0muhIw01FPXX42jlwXyCm95kT5ob6HUXOdSPKl5JBkJcJFkFqG/nT2/tCQIo9
	Q7M2vlEky4q6Y72B13wE5jSjZ/JtdY4vwnuH/RHOQzaSP+d3uD6mF6ARDrrSt/7SQr3Tu/aMhGN
	v5MmT2SV6631K21UB6cS//MxWkRBxhAtu9OBgLKrIUY/LUwy3wgh370WWASuyQEEi2I7k38n0SZ
	QHfKUq4TTnNuRcQfPDBbUuDrVvJoD7GQMbKQsg0up9FUk2mbC6GTOa/weSFzWn8f96w/WdvBf0X
	UMP4+ietvS6vafciIcH+yQD5Ak6lH0D9iLQQnxAGDkkWOMFfeQSeb2oXfLBAQ5BxgBMQm1PO9Fx
	aGSbk7UjqL4woC8g4EMxiu9Nec4dGQkKP5rDepk5hDEealDNuyJHX+ZUiaeoTiX0pjFcKtuo=
X-Received: by 2002:aa7:c716:0:b0:6b1:c521:ebda with SMTP id
 4fb4d7f45d1cf-6b4d5ee6c50mr6756533a12.14.1793718774731; Tue, 03 Nov 2026
 07:12:54 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101015551.786044-1-koray.fra@gmail.com> <CAOQ4uxjkG=1j1z==Mv4wzkF042rXstodokKnBfMFBf2e-Eztmw@mail.gmail.com>
 <DMLJE2Z57AD9.1W22LSE7V9HH2@gmail.com>
In-Reply-To: <DMLJE2Z57AD9.1W22LSE7V9HH2@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 3 Nov 2026 16:12:42 +0100
X-Gm-Features: AclHuK8QI8V9NvEKNRSnDchTL0FslmV7Uh3t35Xsoq4Akwwc8XamtLwVFdORxbE
Message-ID: <CAOQ4uxiMLDgMXuij99-43UfCqfZN2a=CTet560o_RzU2m_Y4SA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/5] add provenance time (ptime)
To: koraynilay <koray.fra@gmail.com>
Cc: David Sterba <dsterba@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Chris Mason <mason@kernel.org>, 
	Jan Kara <jack@suse.cz>, Yuezhang Mo <yuezhang.mo@sony.com>, Chuck Lever <cel@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Sean Smith <defendthedisabled@gmail.com>, 
	Andrey Albershteyn <aalbersh@kernel.org>, Pedro Falcato <pfalcato@suse.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, exfat@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 12:25=E2=80=AFPM koraynilay <koray.fra@gmail.com> wr=
ote:
>
> On Mon Nov 2, 2026 at 3:54 PM CET, Amir Goldstein wrote:
> > On Sun, Nov 1, 2026 at 2:57=E2=80=AFAM koraynilay <koray.fra@gmail.com>=
 wrote:
> >>
> >> This is an initial implementation of a new timestamp to indicate the
> >> time when a file/directory was initially created.
> >>
> >> This patch series takes inspiration from the one by Sean Smith
> >> <defendthedisabled@gmail.com> [1], but using
> >> file_setattr()/file_getattr() as suggested by Darrick J. Wong
> >> <djwong@kernel.org> in [2].
> >>
> >> The semantics of this new timestamp should be at least these:
> >> - it should be the same as btime on a newly created file
> >> - it's user-settable, so it can be preserved for backups, filesystem
> >>   conversions, archives and any similar operation
> >> - it should be preserved every time mtime gets preserved
> >>
> >> and the correspondence with the other timestamps is as follows:
> >>
> >> ctime <-> btime
> >> mtime <-> ptime
> >>
> >> Examples:
> >> 1) a .zsh_history file created in 2019, then after a few years the use=
r
> >>    decides to switch to another filesystem, copying the .zsh_history t=
o
> >>    the new home, in that case btime would have the timestamp of the co=
py
> >>    and ptime would have the 2019 timestamp (just like mtime would have
> >>    been preserved)
> >> 2) a symlink created in 2020 from the home directory to a /path going
> >>    through the same process as the .zsh_history, in this case it would
> >>    also make sense to sync the ptime to the 2020 timestamp instead of
> >>    keeping only the btime (so the inode creation time).
> >>
> >> The proof-of-concept code (for testing) for stat(1) and cp(1) is
> >> available at https://github.com/koraynilay/coreutils (master branch)
> >> (Note: these coreutils code changes are a prototype and won't be
> >> submitted upstream as-is, but they work as expected in simple stat and
> >> cp -a/--preserve=3Dptime tests)
> >>
> >> Lastly, the name "provenance" and "ptime" are not final, I personally
> >> don't have a strong opinion on any name, but while testing with stat(1=
)
> >> I noticed that "Provenance" is definitely too long for the normal
> >> output, so another option which would fit well is "Origin time",
> >> abbreviated as "ntime" (OrigiN time) and not as "otime", as that would
> >> conflict with btrfs' internal naming and create confusion.
> >
> > FWIW, I agree that given the existing uses of btime and crtime in the
> > kernel and various XXXprogs, using 'ptime' for kernel code is probably
> > the lesser evil.
>
> What do you think about the origiN time (ntime) (Origin: in stat)?
> It would also coincidentally be alphabetically (ntime <-> mtime, n -> m)
> the same as btime <-> ctime (b -> c) ahah.
>

Honestly I don't know.
My new idea is don't publish it in statx() at all.

Thanks,
Amir.
