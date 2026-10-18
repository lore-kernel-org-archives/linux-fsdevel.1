Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21016413797
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 19:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792352854; cv=pass; b=IPhkV6Ye90xSVcRPvf6zbV5qvm3vJuQoiRP21giFYmvaF1THr9HfBONqGP6/+iineqeEb6xEuORJh9y9KmSxDjcsU82Fh/cgMIQuybqXde1Bq/r2yFuxOfz6wU4caL9jV86qRkOpkEKxi1aQqZcaZOaDs3Hvg8b/zkA+qTq3p7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792352854; c=relaxed/simple;
	bh=uSwsGj7z13o5NrJE21iC68UKNr7h5yOq6P5JpP5TNDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/bcSyPxt62NLdYBfJgzcN7Hs7joe6LqFodeTjNaqnt3EZInXyI1THVLOYPUr7biJJxJfcnjKV0Nj1MblfAU1JzvswmXCPVAon0TX29Bk3+iEV1XvNNPdjTi5L3Pry8zuEtjQimIhB6Qp1WXWQLMO0ejdy64I0y0/NaBhxTiDaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=U61hr0Px; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b="U61hr0Px"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3ab3b29a1d4so2793641fa.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 12:47:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792352851; cv=none;
        d=google.com; s=arc-20260327;
        b=E7HfSVHKw+wJlnY2T8WGflqrB/iGx3FHSys3S8Ys5VwJR1mnRz236o/leiWutwzLzr
         e7CFcfxYwmnjoEOaCifZXQU6127WIO7ors8mRLvsLVFzvB010Bfe8xb3vV03zxnbYw//
         1kimmNstAmcvL+kr52ghMTtavhAwnZUPn1q6AmvdSson084S9vJfghyoN8KsgHW6By4h
         OADKlNhMZXREM+Z/a/4IcSFB0TyXG5s6uZZXBncoYmvx4t1euAsVq7zGuJKmxrfy1eUi
         y6ItjjzPX5grgK+lLnm/pZyRJTKBEWBp6s61MBdx6Io1JxacTca0dfoD84ZAqfQj6ImM
         //3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C9PTaRCgfnWLejuxwMwgHezQmSpb/Q49pSzLQ94ksTk=;
        fh=eAx43EAkwL9kFvKgL/KYU2ma/AzGZqOOOseEGUe6iWw=;
        b=ckJzghrzJAIWHVXsf3eoVENOCLlPckL0ZjxtXlsCspRPXkVg+a3fPfPMqpASg2CPCc
         T+gO7uQg/j4mV+TvE26WuqwN3hMsIvpaCiBX7ti84ALsHfABZBUHCIq2JuIvk2yq+wbq
         mhL6iHiupIKF1iS5o5rj0LlXe1FyNZ6QVQIwVipEzkS3227MgtyQXXWAmTRwVbRC5Ij5
         Kbby2lKRfIXtYi5W4H0ztM8jkrvOyRi7ZFteUT4BNeZ729FHOpNC8dY1i1aI4O4Pckg+
         /J5Gg2DR9tzxfnrsdMzK6Rsj+jd3FExc0GRobcAIqCfHnMS+6A/5Y5C4p8w5mHvYNfM/
         JnLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1792352851; x=1792957651; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C9PTaRCgfnWLejuxwMwgHezQmSpb/Q49pSzLQ94ksTk=;
        b=U61hr0PxGjsekFN/Peus8SSvsCkWL+X4cEShlWPsXJwFZsPSOlvUCsybYg9BgwgJRd
         4XnxIJgNM2UxnPRJ7LJ9ePNZaMA3S+v2khZQd28a3QJuiBcuUaNEpSAyegrHLGxeAQOF
         XWhhz9z4gvoj1jD71wUdmMg7TKUgBLlQEbfCfdSDreL0vc42Gwa+0w9MuT0mJeW9FjHk
         InbXbqmJqWqFBCaE7bhMzpyoImihsnstJokhn5vCptf2p7cb0uxL1CtKsrsoOoa51lXm
         tyklrtgAN7N7S853vG7iCSHElYqHLPGyLpCn9vrAZ76I1HHBL84qCv0LlLe1GVF1/qq2
         6Adw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792352851; x=1792957651;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C9PTaRCgfnWLejuxwMwgHezQmSpb/Q49pSzLQ94ksTk=;
        b=Tc1xVkXHB5PQH/m/uuUhhLkmGZOgPb3eudjoayz4qWHy0Z90yXPGwPbkRFL0H0bW34
         k7pZJtilsEmyO88h/MOpj3UGRXcy9eviXPcJgb9WuL5REUPYJ0uqZPmB9ZGOZxXi7sP6
         XfA9Gpy74470wjW3qkb1eFcstOgVpJGrDtUxxDmutglsqw7ZLd6EPZ1DythakQKYFAOl
         Nzk5IVQcOWtlMtyxIoZPhDXGPMlD9Gc2g0Kh3Hz+xvGhfcwzLaGod5t2csOc8U/gcAse
         awWJrJ0GQ+5hyNczacHEwLFgXShZB1uzBuOrSX/bB5/Zr1JbndxT8Kc5dCwTQUOteTR6
         Qb1g==
X-Forwarded-Encrypted: i=1; AKwUvBxo7oy31NRs1JgWRQ/Hde74s+AmWCxwIZJiowSAJEF1vHHelY82r1Yt7K/n6WGCudc7w253xVVQFxBunoGt@vger.kernel.org
X-Gm-Message-State: AFq9FYI1vQk7xAwdp3MGkVSKY5TbYgPGcfxKXjqgO/pBiE6aEAKk6A2d
	KiUPVuSSNOfsytM3zzvk8YzRaKwLlN9Gg83KirSYZ+1oHQp336RUHxPRGCRW3xUU7boRUIifSYz
	CrzqeypacN/qfPb8awCwLrwMywXJM+XsvtT3vn2ve
X-Gm-Gg: AYBFou2O3fgOSE/EICW24spaJ6M8PRav45FAjBV63OccMfaYd72LoXvr0rEi5w9xs1h
	hwoerS0bfcnCuojIL9av6V3n8nr9WRnL6zvIJXXPfRiOQePIIxjo38ZKyD8Y/jrbiY02Gl/53vY
	YiAFfrxTytomuWsqzTN4KyWhU/1D48hGGHDiKg6f1tegQKT0QUBU/owvnBNf+AbCHCvkALbFftp
	aykJv87RzXO4tPSdNU5V2hcIm56SJMuyk4eTV3THW1IS+K9sw36zig7PzsHW8pxgwir97is9Rp3
	dgVV3nXXPdl4SC4gE+xQcDnzUVBKJcOW2HAD5U/XPBkYE+OHdh+3
X-Received: by 2002:a05:651c:3614:b0:3ab:1639:9a79 with SMTP id
 38308e7fff4ca-3ab292b7375mr9897881fa.15.1792352851051; Sun, 18 Oct 2026
 12:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1792346472.git.jan.koester@gmx.net> <9c17a1f7f82b953e6f4d9e17f4ca19d5220d7f2b.1792346472.git.jan.koester@gmx.net>
In-Reply-To: <9c17a1f7f82b953e6f4d9e17f4ca19d5220d7f2b.1792346472.git.jan.koester@gmx.net>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sun, 18 Oct 2026 12:47:19 -0700
X-Gm-Features: AclHuK_TjVvADO7YV_Of3nNvklGJn7yisT4mnRNh7189wUPwvl6Zlkl0ZNpg8pA
Message-ID: <CALCETrUjRpHSTBzO65uU-YaEj4espqnwDSaSLcXu653xJyooHg@mail.gmail.com>
Subject: Re: [RFC PATCH 09/41] uidgid: let kuid_t and kgid_t hold a UUID or a GUID
To: Jan Koester <jan.koester@gmx.net>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jan Kara <jack@suse.cz>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
	Paul Moore <paul@paul-moore.com>, Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, netdev@vger.kernel.org, 
	audit@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026 at 11:10=E2=80=AFAM Jan Koester <jan.koester@gmx.net> =
wrote:
>
> Make kuid_t and kgid_t (and vfsuid_t and vfsgid_t, which share their
> layout) tagged unions: a classic 32 bit id, an RFC 9562 UUID, or a
> Microsoft GUID. KID_LEGACY is 0, so zeroed memory still holds the root
> ids, and KUIDT_INIT()/KGIDT_INIT() keep building classic ids, so the
> bulk of the kernel needs no change. The member is renamed from val to
> legacy so the compiler finds code that peeks at it directly.
>
> Semantics of the new ids:
>
> - They are not in any uid_map or gid_map: they exist in the initial
>   user namespace only. kuid_has_mapping() is false for them in every
>   other namespace, so no capability in a child namespace gives
>   privilege over them, and from_kuid() and friends give -1 (the
>   overflow id when munged), exactly as for any other id without a
>   mapping. Anything that can only store or report a 32 bit id thereby
>   already treats them safely.

Why?

>
> - Idmapped mounts map classic ids; UUIDs and GUIDs pass through them
>   unchanged, as long as the filesystem itself is in the initial user
>   namespace.

Okay, so they pass through but don't work.  Sounds unfortunate.

> +/* Like kuid_t and kgid_t: a classic id, a UUID or a GUID */
>  typedef struct {
> -       uid_t val;
> +       u32 type;
> +       union {
> +               uid_t legacy;

Linux is Linux.  small numerical uids are not "legacy".

> +               uuid_t uuid;
> +               guid_t guid;

I'm at a complete loss.  Is guid is only unique on Earth but uuid
unique in the entire universe?  Even Microsoft admits that GUID and
UUID are two names for the same thing.

I realize that Microsoft colossally screwed up years ago with their
little endian uuid idea, and I sincerely hope that this is not some
endian thing.
