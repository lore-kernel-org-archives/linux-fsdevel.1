Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795020858;
	b=Hdf/Egf05AsJXeIR3YFZSuvuPlYQ5Q+4bNOhQcDJddjquiLoWJU6idORGmOzC3GA8Ngr
	 ktCzSp6wW4fFk2bNTHfwmtMuV0VHpeibnfp06sgIMeZJujhFP2v7W9eALM+9Z1MjxwsPx
	 sJ64ldXc/38HcCDlJ4tn58BrwxnDGuHeB6c6LvaSegpNkbZX46Wyp3XeR7I2X6PeQIFNF
	 /m+LSy/HTWwF66SxmkUJsxscVJh26h/SFBtLn21BXQi9nR/PGPh3uHy7Ya/EHwbq7J1iS
	 mfxJRrDdfuJsftUV9GqeurHCc7aGy+NBccgI6U34T5R9MCjpAuyETrEu7hnlKFL7Epg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020858;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=CDJiK8ulCmGPXt6juYUEqx4i/lVoMjTSowTa2yTzZD8=;
	b=n5rNwsZymaR+87kQFDEu607qXTsZMXXN7KQVc/pdVYCUjQYhT88r1gbQLlr/7XlgfBnB
	 B40TS74QHJElf9CAXbWCFxaJ3wjndZmwDw8gpeGcXKROBAL3pY/4KPW+Eu4A03LpaTjCO
	 6SQX5a/viAsXflXVKkRqT0kN9+0Hs1fCpR4ontO+VKp847OaS4LKqTcnTvtXxlg+3z1i5
	 nQzaIsV1/TikmNA2l022isrQb3jhF2rf5jmWS+b1irpa262MbLdvRdMBJYgCmWDjA98lR
	 ZY8YUnAVfo3srB2FDthBM9J/PNk1RcYtQoTJ1LW/qxtTscimP9NuGpArFsmwlWLVGqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KsQdPKwp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044AA606B5A8
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 16:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 044AA606B5A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KsQdPKwp
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b88d143160so1483125a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 08:54:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795020856; cv=none;
        d=google.com; s=arc-20260327;
        b=jZ9An9JPwYP50fnLhQLF+DVamOW42OxakxSxDq8hA2+1oeFQyTiQAjtYTWPjHo1/+b
         ro0wo/AB0yJ5OZEtr7UdZCnoGAPdbdBiYt8WGIxb/xMo/qfpmNvXeFz38uQ0KelxY8Gy
         AL29jd2cwitwdy68QeiccX092dv9ouhNhE9bLD3LAYD7Lcm7VNpSuK7vT/ECLdd9slje
         vXVANVRu7sNjLZfpcArV4+cwo2ECdGEwJ3JG6s7DC1hVfjN+bswqWbn4nUKIkq1RYVKq
         E06KatyVltZG7bKai2ZwYq3rpCKbXHeSxHjAkD9x6T1xoFVRhK+krRjDZOTjE7KjM1ln
         jmCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CDJiK8ulCmGPXt6juYUEqx4i/lVoMjTSowTa2yTzZD8=;
        fh=7ukJ8HRKIvi49BzeaSqXzhKT9yo4ZIvIabVq6aj9HgQ=;
        b=YLUcUlGNJX60WWBnvwUDngWz0y/AtAaJZZeAeeZtMg9RRoDvjN32gidJnxfZ/13Mqv
         V2prRjmrRyvEiXUpvVSMPuSjUdUJHqLzwFAMLJvKON0rlXGH4kMvyvglwUxia2yXilPB
         hS2RcNX9PQROQyWoIsz1pkApt0izAUoTzKP8iL4ngNycVYrT3ioGgztwxbv+bGXKsgU0
         di/G+rGX0QIrXBRwB7SUJ87cCX+cwZ2K2FMgQChSIx7tloXyih4a1451vR9VziPnu1u6
         pgBKh/cyCwmMbQjNghXvkModZKyDflsyDNIrvx7TtiKCv+nuFb5i/reeC78ICPpjCa0z
         ZVdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795020856; x=1795625656; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CDJiK8ulCmGPXt6juYUEqx4i/lVoMjTSowTa2yTzZD8=;
        b=KsQdPKwptjdtytQXQpi8tV1PrrJApryKPo8FzWoGYo4agivvqGhqaDdnhaz8a8YlpD
         byLUXbJp/iX9nWNoPaip7gbWOSBmMhzNk/HVadWmsmCIWqMuSmAVdFTlx5pXgE0IcOwp
         e0AWwpif5wLARK20RmPAvsfutHn+6WoDiGgkTXLezOa+NuIgK+c8OcZsbX4I7CoukABF
         CPa44YgRSyY2ECidbL3iZ6og1R4mHs6LBK/7lnjPx9tzl2wttHLIMZtPdd3/ae56kPB/
         u6W4Az8jGilGmP2W4Nh8LNm9cFiPxfBQTam+J4Y1ClLYYdq/7yvHQt14uiy1pWOu9AYX
         viCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795020856; x=1795625656;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CDJiK8ulCmGPXt6juYUEqx4i/lVoMjTSowTa2yTzZD8=;
        b=SDUaU6f8Xo6WiM+1r5JiKTR7DvdaI9NWOnAuyCcUnZoqOg0G1M/1JdvGwzsJECvPdF
         +lDlhsLic5c4Bnv+HasafPEw/lfvszUi5xuqeD+RRdr9xYCRdyBM+x8qeh+M0NbRjadd
         cbU3PCO5mHscdFxtV5ZBc+vvGW+ezTOxd1AWe2MqXBDna4BMh2MzMewJAX3IimY82vmc
         wvIH7GeGQLxH89czJLjGJo0VGtp2kPIK5Ve5QVGtiGTmyAgAwy8+Q+7qjj19DUjwEuJy
         9srGvilVkjmKmWA64giaf1LmwZyoBFCZ1y+sIGEiffr1xneiylqp3LBcyT1hqho9ORjp
         pSQQ==
X-Forwarded-Encrypted: i=1; AL+hErEax/NuDgKO9FELdydli4CZ6QXDWLMYwvG4sMcsPQk+gZjnJvzWo53Xg6RuCkYgwSmiHh9A6PgSJp3lx7iz@vger.kernel.org
X-Gm-Message-State: APuU4Z+Fpwv8LMoTbBfAReRGslJ2XqA1LoLI8rtAiQ2rmlf12cEmrUcw
	cr0RN9DktbRDiTNV4ry2K3hoDDPC0QIuA99cWoI/vYdBT7Ez4n0d92oilwnRmkdq2ogeGh7tJuC
	0UXXp31pOLSKe5ABxXdOFq3Wka6vb8ALPjXKU
X-Gm-Gg: AYBFou1UINNrckyWy/MhOgRE0lmZ/uRJqctPNsYbaj3dtEowi946qWF5G3zpK4AlEXN
	UkJ3gibqBPfnsUJ6WZet0ptDHMuydNtJZf0Qlv+z9nd/EuYLr7O3w0OCQlrOGbajMyiB8XKWyR3
	cztplgtpDrcm4lCac80FKoljpVFcjt58YXjNbXYZZUEKYvKOu5vhZyuH2M81FXyJiQoauM3n2W1
	l7KA96ZmZg7e2KK4NqZ3jw527CqNmnrHpprYqv0PDmIsd2fsEUt3N7syeQEAlGhaZHr9v2elObz
	SMkYqKDOoWZIVyZPBqTdTwnGocLqgt+UXLy1GPlv4VtOcMTW5CUxaW/vXKfgwSzlmg17y3GtaDF
	7QBdDF0PUUF4uwfYmPVSpi78xalpux990TuimeeELYoceyn9csD53ykdnuytQPvTqeBcSVw==
X-Received: by 2002:a05:6402:1f12:b0:6b1:e8e1:a3cd with SMTP id
 4fb4d7f45d1cf-6b887ec81ecmr2799883a12.35.1795020856100; Wed, 18 Nov 2026
 08:54:16 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118073102.1216568-1-amir73il@gmail.com> <20261118073102.1216568-5-amir73il@gmail.com>
 <20261118-wildwasser-raketen-hierbei-10c9d844ca6f@brauner>
In-Reply-To: <20261118-wildwasser-raketen-hierbei-10c9d844ca6f@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 18 Nov 2026 17:54:04 +0100
X-Gm-Features: AclHuK-Q9fUaoJA1bUQRbqr_aK3VHd-DiceNuxoLUwcVldFRusbtcGe0YcFhEoI
Message-ID: <CAOQ4uxh7ri8hF_4+2p4M5rotQ5UF9bKEXr_mQLQU2DDLe6NdOQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] ovl: refuse pseudo lower layers unless offline lower
 changes are allowed
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 5:26=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Wed, Nov 18, 2026 at 08:31:00AM +0100, Amir Goldstein wrote:
> > -             /* Pseudo filesystems don't hold data for metacopy files.=
 */
> > -             if (i >=3D ctx->nr - ctx->nr_data &&
> > +             /* Pseudo filesystems don't mix with new overlayfs featur=
es */
> > +             if (!ovl_allow_offline_changes(ofs) &&
> >                   (l->path.dentry->d_sb->s_iflags & SB_I_PSEUDO)) {
>
> sashiko.dev <sashiko@sashiko.dev>:
>
> [Severity: Medium]
> Does checking ovl_allow_offline_changes(ofs) here run before
> ofs->config.index has been finalized?
>
> [...]
>
> Because most pseudo filesystems do not implement export operations,
> evaluating ovl_allow_offline_changes(ofs) before those fallbacks run
> causes a regression where mounting with an upperdir over a pseudo lower
> layer fails with -EINVAL instead of falling back to index=3Doff, and make=
s
> multi-layer mounts depend on whether a non-exportfs lower layer appears
> before or after the pseudo layer in lowerdir.

This has the opposite effect of what I want to achieve with this patch set.

If I could ban pseudo layers completely I would have but I am afraid
to cause a regression to some legacy use case.

index=3Don which falls back to index=3Doff is not a legacy use case.

Thanks,
Amir.
