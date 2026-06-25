Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8349135DA75
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 00:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782347736; cv=pass; b=ZEFoaz9rXNPjEHcwaanUBnvqXNkRA0zIsVCpBTOapoCIhmYzthO5Q+1QbY1uWplkgHp4pa5ARgqUP3+KhfYfuJhxBL4KF/ymLMqC+kO1UMoPtQSib6s2qX7pIMIXtlFPSWynTsSdBpa9vqa4lJQhs/72p60EkvH3NOfOKej3I7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782347736; c=relaxed/simple;
	bh=jlY++uhbL9kzvh0wxgu1VtgxWqC79S8nsAlwo8Ixel4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ClcQaUrsqZBTzsl/5nDXKmHeEXMN2hUX2DS3s+u9k9v7KM9D7KwWh9j24u56wTXLGcErVw+JiNg2+QsRH4MVQY8byyCQE50y/DEIKHJdYjIWlN37iyT55XPapce09gWqfy1tyw87ELfmFI9LAwgx4And7O8Bw4f3J7HaEZrCRDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6SAxJhH; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6SAxJhH"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4923fb1f095so16470305e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 17:35:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782347726; cv=none;
        d=google.com; s=arc-20260327;
        b=iBDAZuU5hnHxIcJnXCJ72DtBJVcEebaQWo0Z8Ko9Joha22nya2WZ96A7GoA09q+suf
         N2y3gj7v+MDUKuGUFMfU+SN6H1tdMO5rUEODaStyyaKlMoV22mVIGK7xOnamEv2QZH43
         3GYkMgv5XrANuMi0a+fYmzqedzm/i/d6HHSJLquZfjBj2p5nvSvnPlSg8ma+s8twPYE5
         x7ognqtbICilTfiC4Cvd08NOpu+GwWp/H7nQkv96L16QfEfWjzZZcub9Y0dLRWRJA/g8
         eHMaS09U+/YgttvtLwkyV1dYnBHlPe/k648ejuSRn2VIcojOOEH8EecSqi6ysGRt5t8/
         rbdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5taJ+dyir9PzsaMGDhZgZm1otofqcGe3f75cf+Epyl8=;
        fh=kJT4LNCAkF1ZvuUqj/1YOVOySSdSONN/oq9Quab7D7I=;
        b=RDudZ298D+8se1Y/34DADLpWDPFlFBN3V9Es9XNrLSl3YHKzrSdLQ+y6g8Ao0f2kMg
         j5BTxNyHJV+TXT/iyyGMrRLuDSj/d+Wyj1OM5LCVa9B2rAtOKbjAiI/aCgB0lAariidR
         CUe3KglvQyxF4jfZ/+eFBXaG0MBWVBZsEahi1V+0NcSA3KZV+Xxj/4QGUrlnX1GYkYki
         Q1+CA6XnBbXKYZxLiVCCbiVQjPwZfAkcBJpCvo709q/5w0qbEEzA0oPFMvA28lyZ7V5N
         a9DvC6LBc61iLVwibLMjvk0EGMK8c7e7KDQyM8lJQnQSJrZ4IdCiO/Usa4QjdZ/6TChu
         oqGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782347726; x=1782952526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5taJ+dyir9PzsaMGDhZgZm1otofqcGe3f75cf+Epyl8=;
        b=K6SAxJhH/jGoXQaHNPXKguF4FWu0zHyEcSTUqbkxGaHZwtMa+OGabd54A9nHIOpWUx
         ZmTG6fjz2lDPNwZ6IazALyBLjbFKedSpTSnzwhPLKgTM+5wVe/wYyiwO6UvQGcDGHFfm
         fDkptj/Ds2eWlADRV0y2e3CULavKDu2XJxwFPzK+CMf9Kt+FisdLADcb0EMGX4MMWIdY
         opbNXBOkc2F8jd5Avodf0NX+eZf9rGsiNOsS6LrLes+6/xxURSLCaQNzlDIANrUfnbG/
         kP/piiLRFukA22ENWkH/qoNVPfigznkW50/nKWiJR9S1XSLRIfe3XRLB+/3PoRP/13TT
         LP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782347726; x=1782952526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5taJ+dyir9PzsaMGDhZgZm1otofqcGe3f75cf+Epyl8=;
        b=RYGzeqj4vN67PwY1Ov8W/slomP2QjCum/YGpLSN7eejhZ475PRJgRWnbJTQQwmPPTt
         BUX+eQxSxB2rv5Xn5nFwYor2GPVVJmjMLPgWpzxOiArwJksmi+cjmBVBpomgabTpMwGy
         C9jyhNrdCqfPE1y9HWiUpXwyWV3wVUucoodlqRPdYxEofeIBV62qVrOvfX67SKoCkG9d
         67DkOcfikgy/n/G1YO5YEPX/wvzMbBvWaMGFWb2OHMJ0iYJH6t9sqG34riVNiEVyaqph
         k4udCb9d5OyMQJN1jCNcYMrqoN/iqLSux7t2mhPax1VXRPPD9K4M0sVCwtcpo9lF3YPj
         IVxg==
X-Forwarded-Encrypted: i=1; AFNElJ/0dQaGFCV5VRyVtAxWaO8OD74rxKskUZmZqp6C9w4nM8jdFSwb2paGqzqh8tvo3+HaOhUjob6JgP02emFK@vger.kernel.org
X-Gm-Message-State: AOJu0YyrppeAl9sSvQ7aZDHZi/52Xz+N/R31N+K9ywAOkoQ0/m2Nuqw2
	zpm8HS9hO/qsEqwOOR8IUpPMHU6616ExtqmrGsYQeAaTy8PxefM43lpwpBmqvECJEN7maZSp9Qn
	n7YGv2Qdd0SvyGMFIskpChzkI2910C0UC9y95
X-Gm-Gg: AfdE7clbFeh0MuSAK5qXnLWieA6uMuLCzKufCwsuIN5pw3PC72SA/AOqm9Im8d5MKw8
	xpKr6e5UWKNrr8GPIxcSe69KL870GHQMgXkkRQkaWRP4qRmQFe5nOG6jBwntCcZUT5IAShE0wq3
	Zlo5z4A/Oxx6+XEPm2110bHIldpxwPrE8ROrVHxZag11NLUv7CVH0AQTPieY8CiuVnhMyFuKB6N
	6d+IZmEt4Zbjh89ncgDm9U4+9QueVYE8A/TTT3hURLQVe4ejI0PhGeLvLB1Ub//60VKLQFgXepJ
	51c8+FihH95bBVPb4cyA9Rix50jvSAu30EEnVJCCFiCigkEzF+Ne
X-Received: by 2002:a05:600c:1392:b0:492:488c:f630 with SMTP id
 5b1f17b1804b1-492668b6847mr1380885e9.34.1782347725536; Wed, 24 Jun 2026
 17:35:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624212925.1668662-1-joannelkoong@gmail.com>
 <20260624212925.1668662-3-joannelkoong@gmail.com> <20260624221820.GB6095@frogsfrogsfrogs>
In-Reply-To: <20260624221820.GB6095@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 24 Jun 2026 17:35:13 -0700
X-Gm-Features: AVVi8CfaPQLl0Wy1529H3PRCoe5W_eUxx7v0m8vqdxBIlCqjJBZAJ3GkB5EvT9Y
Message-ID: <CAJnrk1aMe09bYZ_MiR-tr=umZ1nJxDx0B7DCs751zhxEyCL-7A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fuse: use iomap helper to mark folio uptodate
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, willy@infradead.org, hch@lst.de, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 3:18=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> > --- a/fs/fuse/notify.c
> > +++ b/fs/fuse/notify.c
> > @@ -192,7 +194,7 @@ static int fuse_notify_store(struct fuse_conn *fc, =
unsigned int size,
> >               if (!folio_test_uptodate(folio) && !err && folio_offset =
=3D=3D 0 &&
> >                   (nr_bytes =3D=3D folio_size(folio) || file_size =3D=
=3D end)) {
> >                       folio_zero_segment(folio, nr_bytes, folio_size(fo=
lio));
> > -                     folio_mark_uptodate(folio);
> > +                     iomap_folio_mark_uptodate(folio);
>
> I wonder, if a fuse server stores to a range of dirty pagecache and
> completely over-stores the dirty range, can that folio still get
> scheduled for writeback?  I guess it's no big deal if that writeback
> happens since the fuse server already knew about that content.
>
Yes I agree, I believe it still gets scheduled for writeback since it
still has the dirty bit set.

Thanks,
Joanne
