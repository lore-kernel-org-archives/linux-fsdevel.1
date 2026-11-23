Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795447127;
	b=bT+gKfSTSKXqWZGs1bOGv2SEJRyvniVxCGz0Lg3k837wYVoSao62O2pfjqG9sUjFrsR4
	 jAWX4aLRd3Z4CV2zqCql6MM+JXVeDev6ihrILhjHV5GWSi2IiHFD3m4LFgkWkbVZmX6a4
	 5dmBMvj7gk1QRB6C/g8LmiuzriDx0txs0Nb/VXvJpadRQp8h3Xi8rga/eVlyvoBPp2N2b
	 XYfh2sCGiRU9ia5+6JxyylCTdkyXWAZLtmpE3/AIoQK+yZPeTnxlDc1hvir4jeZ01mURD
	 E5kJC0esRXxhZUmljvMCObqFRXbw74T56pKyVv1mnx7G972fWPq57P/qnwNz8qTLHOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795447127;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FQauslTrJye8WtEKr4/uMYFLXtDrCWIYYsnNnENx50w=;
	b=MpA/KG0BpDEDrSCWWRBhkEZidSeXGy7RBgPFQYmmzcNyRJKvKrm1rJaV2jVfbiI8zl8i
	 LfgTuKThndLW6gm3CNbgaJ+gN5phVehA/qGPDEqwRgNWR7pCGvk5NyNSvVx/h2NQT2oOY
	 uN+ngzH7XMe2m7cghxu7KLkGhy1JJ4PFuvCkyckZJaKH3Z0qlEIduDppNv6CZ7KTH+l09
	 G2NOfg8xyt0G5xj5u8eVaVz4nRSShteDJlgSlEVUDMBhqDwhhUI41r45UxmYTAYfRRsFr
	 tB1TGdo3CQQNAxJHLWmkNc0GmSMHi6YdWhBNpST0j7GnQSH3Q/rZ7V6yAU6ctEHDFwA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tnOVRIK8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4477606A31F
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 15:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4477606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tnOVRIK8
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b8786bb305so4175356a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 07:18:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795447125; cv=none;
        d=google.com; s=arc-20260327;
        b=Uuc6j8GUttjuvLI1HGAjNfnHQ+JMUvOSPrEFdtE77Ckbu/P+bVY+A3YDe8roaNX9EG
         6fPD1gVfGxpU4nVmFBucBbr3te5piBV4PYcXiBc3M1FZIJplycWKsHeXcOEzBgRmU7Hu
         Uc4UA1q/6YqD2B4BE7lehwd3m16+mZUUual/8fiip178sVmbDxEvCnI5IVjhIn4sODvR
         ncX4oww4V3Ob06+JY+PJL65PgwSz4itoNktaS6Tow0XGmi3HancZ2n9LolUXfRM1uFZi
         H5X47WqRCBTS23EjmZjsT1k57ccSSnMGqbJD2jzOcvt9WKv1f7LgjR+3mAo1h2+3zf6x
         eBxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FQauslTrJye8WtEKr4/uMYFLXtDrCWIYYsnNnENx50w=;
        fh=FGSMeB8YvNTQlIVYQ9jQsk7rMJFSiTCzBotWOxfGdmQ=;
        b=W9gl7QvAniHDEa6fYVbra6/X49tl6vOlYuLpmT1/q81sea9VTq5VYepJTEhr/no+1s
         XsKudKxQRmr8fYrpNEUUV4HyU9qM2BeD4XHUWAxid0rGF1+ojNFA7rbsGYCuyBIk2LMy
         5b3NZ1H3nqtS5eoAmwiKIXZdtpNRyV7Dhh9Z3mCm2wkzfAX5YQwTKHOkhbboZehzkZT+
         VwXxv4rPnGTt7vIV/byj3sUQzU/Ug49aTnllzRYiQ2O1yCKcJoId263wGsIT1lQfg4Ta
         MHmG5ZZ4Ve2ez4MwQfEJL5hHuBmTq2nVJVpXi3oXW94A0OEgSuwwMiXvyGGA3t08T+eX
         KBng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795447125; x=1796051925; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FQauslTrJye8WtEKr4/uMYFLXtDrCWIYYsnNnENx50w=;
        b=tnOVRIK872Am/h1zBxtrm624YwtnAaM1ODFpUf4BIJQhjvNzDIVKPp0Tc0+kuNgK+T
         P6zbEiDvzhGQMmXVnvEgssD5Os9Kxz71/UfuvuNfnMWhsGjmbEY+8raprIJ9X6wrs9+P
         t+n4QGoPL0En++2BIFCjCTfGW7tcR93V3ClOyWg2gSS8rvl/rQevnj+NbA2pmKoegUTq
         wAOmepamNX26KktT8XanGPaaDNNp/wDvhl8maLDsDH89HC5UHE/TdVVYvF0O7DiHJyEN
         CZVx9d478DNjHDgR4foo1kre37sD3glA5umfoInRNznQIrbXZtcPjA2+5t6yJceHDFpe
         Nzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795447125; x=1796051925;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FQauslTrJye8WtEKr4/uMYFLXtDrCWIYYsnNnENx50w=;
        b=uRzLDz8930/XB0lpM8qMPlNXTMaV2sg0hBetQs15DFgsuGqmtyS8huGKoRHKTogas4
         iGI9kSb9jNXxJJGbWFqLWMpATaBHbhxgH/a2jdsD/IbP8LTclxnWEcHIap7rOAuHpCGh
         rGyPpI16CmZ/1K/jydtDaF9cWNLkDxji3TnvGKpUPugxM6G9illuI+Ug+x4DTQmrsxS1
         aR2emVl48q1VDccdGkzs+yzBn6ij+NoSRp0G3GkPa+WEFMTiHZgEYDQq3oHyZOCMwKSH
         xWttcTBTT4NbEhrtek/YcKnQ/0H/8tHRW+Gr4ZiutW2yackGWlFimoYrUNKeYn+GiWf3
         814w==
X-Forwarded-Encrypted: i=1; AL+hErGdueVuPFZjq4QzGm9x01HneR0h6k1NIGXcy5e9Agc2IM80B2zHbFgV1pEDatBVv72wQKC588EtWJN7rAxL@vger.kernel.org
X-Gm-Message-State: APuU4Z/KVFreWaQZ9oUXGgw1WOBI7qxEXeqNJ0U39HunVT6oj/dPDxUi
	C50LX7z1ufCS1Pbhy07QgvAzgfG9g4ik0wfUddLhIM6OykT1KeHr+kAUoI5yYnoOEzZuw0bBzzE
	xIfKfpWZbjZE1IHXxqqYJK2N+D5CsKUM=
X-Gm-Gg: AZFdTZdb230X/5KBfMX0Yoo6VY93KoClyXm9f2eu5yS4ZmTriTveHm11IsRpyxt/tV2
	Hh5KnkaLI+2Fw9hBNePLzConTIyMmfDBvq/CvAXs4KARwwcQhDDlYyGvogvKHZNXxbMw9u7SMuX
	dwSd+Y53cektZatFCuQ5qL8KRS2QrbQADnAipPi+CqQABiU1ShgdmWmkGMolwarTO3cE2rIVRL4
	3NWAhUCVbgg9dMQAwXV0dmI3hXNyRpOlvcIBhnG1/mm5gpkhG+aLo5Hpb6V+IxQNbkFiT+jryKF
	WRUHqBG727oROubwhZ97ZD0P8nyrtQr5V0OzWb42I7CGHekBscl6zK42udWyI4qcYdZLtbWISSI
	eAyu5i14ANZONHv21z5vDdKjD/wWpDqDTuqDfqCWgWHdz3mMw4DhxX3m7wFDYJIJzYFg2M3M=
X-Received: by 2002:a05:6402:23d0:b0:6b1:b97b:744 with SMTP id
 4fb4d7f45d1cf-6ba37ec18e4mr7070716a12.32.1795447124603; Mon, 23 Nov 2026
 07:18:44 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122000856.536902-1-koray.fra@gmail.com> <20261122000856.536902-4-koray.fra@gmail.com>
 <CAOQ4uxgc6pP+_xvJMbqj6wOdGzS75Vn6x6i_vUfCJDD46DAA_Q@mail.gmail.com>
 <DN2N0BY83OY2.1OV3ZAZFSWCDG@gmail.com> <CAOQ4uxg9O-R_SUPAZ75ESGB99-4Z4EEUKGMkCF2f-sXkGPq1GA@mail.gmail.com>
 <DN2NVGUNO0GA.89JAB2PVI0LA@gmail.com> <CAOQ4uxjuAN0FdxGr_-OccO5qnUuLF5oxOq7L_545tG3+36EKFw@mail.gmail.com>
In-Reply-To: <CAOQ4uxjuAN0FdxGr_-OccO5qnUuLF5oxOq7L_545tG3+36EKFw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 23 Nov 2026 16:18:32 +0100
X-Gm-Features: Aa3M54oObGzmT9EyX7FArFQpCHBYwqipULgBnYau0_-PZcRo8HGalO_VEERbt3I
Message-ID: <CAOQ4uxgyKcB8GjE5_S9fgMv9oC_dKKaypDWEf-eXEkFeo5e89g@mail.gmail.com>
Subject: Re: [PATCH 3/3] ntfs: switch to the new xflags fileattr API
To: koraynilay <koray.fra@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Darrick J . Wong" <djwong@kernel.org>, Andrey Albershteyn <aalbersh@kernel.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Lauri Gates <lauri.gates@gmail.com>, Christoph Hellwig <hch@infradead.org>, Dave Chinner <dgc@kernel.org>, 
	linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	ntfs@lists.linux.dev, linux-nfs@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 3:55=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Mon, Nov 23, 2026 at 3:31=E2=80=AFPM koraynilay <koray.fra@gmail.com> =
wrote:
> >
> > On Mon Nov 23, 2026 at 3:14 PM CET, Amir Goldstein wrote:
> > > On Mon, Nov 23, 2026 at 2:50=E2=80=AFPM koraynilay <koray.fra@gmail.c=
om> wrote:
> > >>
> > >> On Mon Nov 23, 2026 at 2:00 PM CET, Amir Goldstein wrote:
> > >> > On Sun, Nov 22, 2026 at 1:09=E2=80=AFAM koraynilay <koray.fra@gmai=
l.com> wrote:
> > >> >>
> > [...]
> > >> > Rule:
> > >> >
> > >> > You cannot add a flag to common without carefully auditing all
> > >> > filesystems that support the legacy flag.
> > >>
> > >> Yeah, sashiko pointed out a problem in f2fs, and I could reproduce i=
t in
> > >> testing, where adding COMPR to COMMON makes f2fs crash, it also need=
s
> > >> NOCOMP in COMMON.
> > >>
> > >
> > > I don't think this is correct, or at least not enough.
> > > My agent said that this breaks or changes things on  f2fs/ext4/ubifs
> > > I didn't bother to check if all of them are true - I doubt it
> > > bottom line - need careful audit and good testing.
> >
> > Yes, definitely.
> >
> > >
> > >> > FS_XFLAG_ENCRYPT can go into common but must also
> > >> > go to FS_XFLAG_RDONLY_MASK because it's read-only for
> > >> > all existing fs.
> > >> >
> > >> > COMPR is rw for some fs and ro for others.
> > >> > As with CASEFOLD, you cannot make it COMMON before
> > >> > converting all casefold fs to new API so that each can say
> > >> > whether it wants RO or RW.
> > >>
> > >> How's CASEFOLD currently handled? in the v2 I'm drafting, I added
> > >> fileattr_mask_to_legacy() and fileattr_legacy_to_mask(), which conve=
rt
> > >> between the old format (filtering by FS_XFLAGS_MASK) and the new mas=
k
> > >> format.
> > >>
> > >
> > > Good question.
> > > Need to check this.
> >
> > Can you do that? If not, I'll check tonight, no problem.
> >
>
> CASEFOLD is set in FS_XFLAG_RDONLY_MASK and NOT set
> in COMMON
>
> Therefore, doing set with the old xflags API for the common flags always
> preserves the old CASEFOLD.
>
> This is kind of ugly and works but its hard to see the design there
> so hopefully all the new helpers and masks will sort this and make it
> more explicit.
>
> IOW, ENCRYPT can use the VERITY RDONLY and COMMON
> precedent because it is read-only across all fs (via this API).
>
> COMPR (for the purpose of ntfs patch) can follow the precedent
> of CASEFOLD of RDONLY and ~COMMON, which somehow works.
>
> Note that for fs that were converted to the xflags_mask API,
> COMMON should be irrelevant.
>
> COMMON is only used in SET to do GET and preserve the ~COMMON
> bits of the "other" API flavor.
>
> With the xflags_mask API, unless we adopt the "verify" feature
> there needs to be no internal GET with user SET and then COMMON
> is not used at all relevant at all for those fs (e.g. ntfs) only the
> _fill_ converters are important.
>

The statement above came out too strong

The internal GET is still needed for the permission checks (immutable, etc)=
,
and for converted fs COMMON still matters for the legacy ioctls, but it is
not used when the new xflags_masks API is used.

I would love it if we could get rid of the internal GET, by moving the
IMMUTABLE|APPEND checks to the fs fileattr_prep_ helpers.
But this can wait, you should not be distracted by this now.


Thanks,
Amir.
