Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7813B1D5AD4
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 00:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785370567; cv=none; b=O2SSdswfBBhcmhCrV7Sol9Ty4SiTk81czygC/MmGLvkLv4mIfKIcKi6tVTlKY33XcmHuz88ZcIVTiDUvMqnvZWyTEY50Owmbaw+JR0PVNf46k0YhsEFF0FGWNYWxZv2co+XqF857CqSpG8a5KrCfaI9gXsQo1vSNcLAc3aSY4gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785370567; c=relaxed/simple;
	bh=/8NemaW2xuFZL7yY+CwIv5j1TWBCa9SxYa5xgcMRoUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPlM/MQJfjSqzHedRTraUfEuZ1DhmWwsfPcXjrUy/MKaSFi+IsPEdth8+P++rn4FHy5BbNuQCT3GDbXaYYmzFeIwf3V5tmncSIammLdJqNAUb8cOrY+t+FmxOb0BVUsk5ROs3UnDj53duRJdChh9DBk1zdW0pN3Wh3vXJbLUYe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hJM47nWg; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hJM47nWg"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-69fec980a30so1675772a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 17:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1785370563; x=1785975363; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=njr7RlcLoyLwma0jwRM4gxbwOGfa+rZyF5Hk1jimKqA=;
        b=hJM47nWgX4S8SVukxOrKDURFbaAYbcT/kdq2BzmK4+ATd4B2AL6b+8f57IYszERBm8
         bpeT0pjSoVvCfYqCim1zydxNZrSp+Tx8vqja2M1kAAeIN8GKA4icgaEWQ8ilip746vT3
         uCCwnTOUDMSAQAj0IrYC8bQEYu8NIj6/EJbts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785370563; x=1785975363;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=njr7RlcLoyLwma0jwRM4gxbwOGfa+rZyF5Hk1jimKqA=;
        b=cpm64Ydk1qVCH5tRSi2oE/WuBm0Vmxfz2L752OjoUCO6nzq7cBcr9OzTw24Ymmt/79
         42pPM+ktzjwDgtaYhVU/8nyiYMOPe/jBHvILuXkQYp7L4DotwuHY3oCcUefE3EHNZCd0
         qbiSRJvUurvh5psd1CaWtUc1vi53URe2BKnDxqDQDw0PzRTLVr7Doc/O5ubDi4uiF6ob
         30oB+jHfwysvH1U9tSDPVHu6G326GO3MU4F3KuiO3zLRMXPqj4qh6ESzrOyGRd/5ifsd
         8h7lZIRwn7nKbCznKKiEM47aFxdj2TUpwMdJQHqftWmSO/GK5sV/AkfmWANGxtQXymf3
         lwVg==
X-Gm-Message-State: AOJu0Yz0eZ9Nlplul1cA/YZ1WWcRfNO7Pscec58IpV5/mD10+4wvzPAP
	pk+jpl6pLGYvfS/XFZOzLcLyHcoY4Cv08KqGQ25WNFP0fTPcxlVzRITSMBlCPNQZIXi75lk8dTj
	JnjWf7v0=
X-Gm-Gg: AR+sD10XAVBZ8PPHlLSSOjHA0VNBHhQEmhDsenbkyft3/kKliuj2D1mQ01rKChxyetD
	jyr/aevjiax83s0nWJZx5P+4pnGDT17boyPegcXMVSrTzMA8RY2vrdKYCB7JgQbQLUuJwJZy9KO
	hFO8iW02sYU+dF45F7Hzz0M5KkIcfEeWfJMHQSad9HCvI++vXSVXVGthiPyx7cHR58KiDorW32+
	0rH2L3FGloBZnznM27zi8lME70EuK9tIl2FcsjhO11q7gXf0aZpv33qtYEZu7UHHlB7NM+29Ozg
	eeGlWmtdilwloNh3hEiDwmTec4cspoYNuvbK9vEtCAHvd+pWLbJ58d6ylwnqNj0g+o2L0CSGVBD
	JDHDD73G7u1OfvpzzO+j2dzcuZXFDOfl6nrwbtoVrycGDEGbpMnGDqZ2itB8zK5QU7OYb/OHYDi
	hW9umzqwZyhRMAD/l71dkK5FALyiKEq55MO+BNQthMnsKPDKBfrQjcJOjJd6/hFJ8/NjSo2p7AE
	tawqZsS0liWQvWuCwJZ2qzNk/GXBLKq/HGOzw==
X-Received: by 2002:a05:6402:1909:b0:698:585c:f07b with SMTP id 4fb4d7f45d1cf-6a07b7ebca4mr218007a12.3.1785370563505;
        Wed, 29 Jul 2026 17:16:03 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a07d3831ddsm38329a12.17.2026.07.29.17.16.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 17:16:02 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c1c24ec9525so264757866b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 17:16:02 -0700 (PDT)
X-Received: by 2002:a17:907:d10:b0:c12:959a:1477 with SMTP id
 a640c23a62f3a-c1fa57076cemr24198966b.40.1785370562656; Wed, 29 Jul 2026
 17:16:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMwtO3LAzbJHZXixDbYD-LGu2qe5P4zVQBD4fsqNr-P3wzAZUg@mail.gmail.com>
In-Reply-To: <CAMwtO3LAzbJHZXixDbYD-LGu2qe5P4zVQBD4fsqNr-P3wzAZUg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 29 Jul 2026 17:15:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjrds=Xi4SrMQocb7_kF5eyi0WOUbJ7Lb3bBbRf9gTvoQ@mail.gmail.com>
X-Gm-Features: AUfX_mwu7dKWTx8tRXlPlddTLn8uAgkRPSAOd4fyhQg6iXRHRalFulLyjoKR5Hw
Message-ID: <CAHk-=wjrds=Xi4SrMQocb7_kF5eyi0WOUbJ7Lb3bBbRf9gTvoQ@mail.gmail.com>
Subject: Re: URGENT BUGS TO FIX IN THE FILE SYSTEM, KERNEL PANICS, INT
 OVERFLOWS, ETC.
To: Agamalt 10 <agamalt10@gmail.com>, David Sterba <dsterba@suse.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please do proper kernel bug reporting, which means "don't just sent to
Linus", but figure out the maintainer etc. We have documentation about
this all.

That filesystem isn't a serious filesystem, and that code needs a lot
more fixing if somebody cares.

Instead of doing

        if (affs_validblock(sb, block)) {
                bh =3D sb_getblk(sb, block);

it should probably just do

        bh =3D affs_getblk(sb, block);
        if (bh) {

instead, but honestly, I can't find it in myself to care about an
unlikely error case that nobody has ever seen and reported, all in a
legacy Amiga filesystem that nobody really uses outside of hobby Amiga
enthusiasts.

But we do have a listed sucker^Hmaintainer for it that says "Odd
Fixes", and this certainly counts as an odd fix.

So I'm cc'ing David and fsdevel in case there is somebody else with an
Amiga background.

Me, I'm still bitter about those rich kids with their fancy sprites on
their Amiga HW, which may be one reason I don't feel like fixing the
problems in AFFS ;)

               Linus


On Wed, 29 Jul 2026 at 17:05, Agamalt 10 <agamalt10@gmail.com> wrote:
>
> In here https://github.com/torvalds/linux/blob/master/fs/affs/affs.h:
>
> You have:
>
> bh =3D sb_getblk(sb, block);
> lock_buffer(bh);
> but, sb_getblk() can return NULL on failure.
>
> If allocation fails:
>
> bh =3D NULL;
> lock_buffer(NULL);
>
> =E2=86=92 kernel crash.
>
> Same problem for bh =3D sb_getblk(sb, block);
>
> wait_on_buffer(bh);
> Also, an INT overflow risk here:
> #define AFFS_TAIL(sb, bh) \
> ((struct affs_tail *)((bh)->b_data+(sb)->s_blocksize-sizeof(struct affs_t=
ail)))
>
> If:
>
> sb->s_blocksize < sizeof(struct affs_tail)
>
> the subtraction underflows because s_blocksize is unsigned internally.
