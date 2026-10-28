Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.139
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793178282;
	b=hAZu4arrpC/xDnPstTc1M8b2KQuRdHrzeMq71C85t3GpVQ3vLRpxadJApipW/c3Dzxt2
	 CwHUhpD2mmyTYvxz0GPjwuVq0M5ZbHsm/+gzD7PFZIpkgZ93V63r0pFonAC4do8OHu7Ui
	 MFjTMcg9JKYgv5Gcpx0Oh7U8I56zuvBhqX73yND/nFLSj6AcAFX43P/4C6LcYmFkS1+MG
	 IKfsKi9qrFGqRaE+mJOKpoYkiKtRMp7ticgc+tbMipxlfdgdaTZBx8t/3mT/FVqXA8HOr
	 HQ5gRVy6v+6LB9WBH+bTYhCmpHfmXziMdMmI87rOlqesf/M+1YSq2LA4xUzRjHgtOOQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793178282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7baAZch0AV2ZQpsltJrgKMT5HFebbDsF2TyQttQo+4Q=;
	b=Te/7qFesyiuzx5bj8Z1bjF8QEDz8JXq2BRCKcHaENZ3TZBjiAE4plp7ZRhaqKbxVUGrZ
	 9a+NfRqtgBpTEuc8G0qbKquwt+kV662A4y1ddqwi5V19Pv2mZXClY0PIbjy7ip3y7aXpD
	 I4CSXHCekiw9x1oU+JRC+/BMaVeHIjPgFlhBmWWujj9quehiq8LNV1CgDSKrghsQuGSjw
	 F/pksnF+9qE0VGY4mkg5RTABzMuULPTijdEruQrZxgWaUJA/vgDk8H9l+xIki4IffqMh5
	 cN3pNRW6y3GCCoDg89lxGQQaiaS18YwWXAt/dTbOWz5JmO67u5Bx8sUed5lfityRBpg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PeHJH9Hz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.139
Received: from mail-yx2-f11.google.com (mail-yx2-f11.google.com [74.125.224.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA60606A31F
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 09:04:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAA60606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PeHJH9Hz
Received: by mail-yx2-f11.google.com with SMTP id 956f58d0204a3-66c70d59eb7so95409d50.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 02:04:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793178281; cv=none;
        d=google.com; s=arc-20260327;
        b=rMEQcwcp7O1z5wONEaDEXPl3LQqBSRqU5jxynETr2Rm+K0SqQ4ctaYn2fS7EYMT8Vq
         hipGUSJsdvg3W2PMSlYHMUV8jFS5UtA6imEzxs56wYvF0FPbDhw8wQuxWOelc5lh5CZy
         LjkuXkUyrb+n6ZzQyeCqSqWzO+9sYP8fQWm6Qbr4tpeLRuHz3zbaFdeAkjr9USOoIbN5
         vduzUs3IXPy5C1SY95rR2DmGTMZgD9m9CaX+wFo5b0scvfpiyTiyKNujdbLiuJGx9veW
         rKFuEnmMBhkRSNQ2WZjp7GVzY5rKyEf+KGRpyqvtQ8jQ5C/N5g8OaTVn1zaknpTWV8Fv
         o0ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7baAZch0AV2ZQpsltJrgKMT5HFebbDsF2TyQttQo+4Q=;
        fh=XdWkK3CvgG70fvqszYLJtcESXrmcHsfp8Gela5fXnTs=;
        b=RGtUSgJw0bmvl3OktpgF9mLO7GqdG5stGLZ8hIzHls/U71nXEqedEJTpguOi/khyqV
         wPtFr5dkNWTjb6xy1D5BZuadLXE0HWTTDe7Ms5cK3lpyqGMkQzpjxufIyWCwa0sKyzLY
         QYw60NlNNhmXg1bnVV5d04FKy6kmyqgBm3xGJ2agk6OSpZ2wfdD55VPy8qcqOJDgfR/g
         1lFjdYeXg0jjYsxR3t1ga0FYWm6/bmMMeU2Ocyh3hwB4v4wzn64rTBMkMy5qbGf7wHM8
         hXwGBKabR2Mi6E+2uaAlokQ8NjWkc5asGFD9gutJwFXbA0ZfbElQtzS9MoYrZaIUU8zJ
         vyog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793178281; x=1793783081; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7baAZch0AV2ZQpsltJrgKMT5HFebbDsF2TyQttQo+4Q=;
        b=PeHJH9HzitfqkHwUIHziH4oDgPV1ijSyhYS2wKuypkLLe+lOu9OQCg4T2KXrMxSJZj
         ykW+O7RylgBeVYNscJ5iqZJ48jlNNNhh5Rbuz9fAsvvS0TIV0EW0QjcgjuNyhmWVvJw4
         FjPxtpF0pBkjnucpcDHDuSPGnO+Hy27FrzDtYFdzJWI28spm2h6kWo9IHKSe3LsuX/uz
         tuRLgGxD1DQX32ulW41HqIyNhcxn4mGnXUXwccr2adZ0vUr5t1zF1mVyAX4A3Ak5NcZ8
         h8K8FiQqeJ7ujG2qQANX6pRLM2r8U8qFiPxlpeHb7eK0xlk0lqtC+O7j/RAjDQWTKkar
         qfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793178281; x=1793783081;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7baAZch0AV2ZQpsltJrgKMT5HFebbDsF2TyQttQo+4Q=;
        b=bZZGRtMnHCGB4xvTjQAK8U4gtf+Bh1N+9JwMwlp3+QFuo6fGdt5U7rmXDT0yo2KIp1
         kdz9YVYfwGbezrBwR0CiSiAVxsW9v+07OiGven0BRIENKbPwBcfnwtr5xfi5VQIGZFoC
         j745Kblh0XWYP2J31m9/0dgUsaAnmtllmcWnJ5nwA/ojoNt1YadmjmypHKJx3NUu7uqz
         aE8DJR0qHYMVTQJg3/rZEucXShGuRE7fiBeh6A6R3s95pIBGwCumiQNlaoZ2t/MU64R2
         kbAKgAMz1EzMYU1+6ZYg5o9bT116kzXoj8q3l8p8kqanJ/oYFLgTWhcKSB0plWSkZXkX
         tYEg==
X-Forwarded-Encrypted: i=1; AKwUvBzNKc5Lzi0DSHnw0NFFjAdBP1z2pr1VDPMuLS+DatdUR2Fyc9/3Qt0q5FHmMFuu6dxe9D5j1jroIrCgFXiL@vger.kernel.org
X-Gm-Message-State: AFq9FYK3iZMd3EJs+kdVo5mYQxQrUBfsOfm2rCKhGiWHvlnfZTRBvQT7
	UEvE1slrhbyo8BX+SKIZIt6eHryxXJkoU/E1Vw1Whi8HVBIr5X/b0y6QJJGGQrDQsQGWl/sCn88
	G4203dXLiz/eC3ixR0UT6ACLDyNl+PRfaqHQhjDfIv9Q6fXE=
X-Gm-Gg: AYBFou2vTv9pWiBgT9EEPrMMxnm1xIsBVUooimjC/ipZZMoUQ7PX5RPq6x9E1mT46Om
	Q6LszmFky6IO2MkbWTy0ZUvBruNGjf8hKuv23kW9re3n4y/8PEkuiG6dusnoYhKoeP2Gmo+TLZP
	JhS/wyTgY7MgNG80Y9FAEoMX2Cp5hscl3LFQE6+UDLKkr0/a1lcNtBQEfMDx7eIUuv9YO8S+hYl
	sWEF3qdRDFV+T1RA+wY0XYQ4WHNWKoYoRAtAOIrY+z7QjTz+u79Lq+ACVCRetWkU9wvk9tdXJn5
	k+utHl7AcqO9C5jJ2NsnBXhUmiq9dZO4E8venL50+2PkzX4tjnIzrm4FdsFxvyU90f9viRLX/5c
	oSEoJ0TVCgc40Cf7/fRcv8CdepkzZDqIDVLyexPZ7QsZzF59+cMfWRlnKoQ==
X-Received: by 2002:a05:690e:1699:b0:679:bd09:f46 with SMTP id
 956f58d0204a3-67a813f79cbmr815916d50.6.1793178280698; Wed, 28 Oct 2026
 02:04:40 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018081203.2431035-1-l1za0.sec@gmail.com> <20261018183707.23dba84df0a235e36de1620d@linux-foundation.org>
In-Reply-To: <20261018183707.23dba84df0a235e36de1620d@linux-foundation.org>
From: Li Zao <l1za0.sec@gmail.com>
Date: Wed, 28 Oct 2026 17:04:23 +0800
X-Gm-Features: AclHuK92W6eCjxLVFBVIgwy3cZtZtdZpLsiCnKY2XBI3u7Tc-5IEfkiWO_P6Glk
Message-ID: <CAAwbnpdgKj5hEky8ZRcPOzJurj6W_rf4X4nEkMsfCU2CfXJj0g@mail.gmail.com>
Subject: Re: [BUG] KASAN: slab-out-of-bounds Read in copy_folio_from_iter_atomic
To: Andrew Morton <akpm@linux-foundation.org>
Cc: viro@zeniv.linux.org.uk, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Tal Zussman <tz2294@columbia.edu>, Daehyeon Ko <4ncienth@gmail.com>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 9:37=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:

> Thanks.  Boy I burned a lot of tokens on this.
>
> I was able to reproduce this.  I found that Daehyeon's "iov_iter:
> validate extracted segment for bvec alignment" makes the KASAN warnings
> go away.  https://lore.kernel.org/20261015061907.2713943-1-4ncienth@gmail=
.com
>
> Daehyeon's patch is presently in mm.git's mm-unstable branch, with
> cc:stable, targeted for upstreaming during the second week of the merge
> window.
>
> Daehyeon's patch prevents this reproducer from triggering the bug by
> rejecting the misaligned direct-I/O request before extraction advances
> the iterator.  Without that check, extraction skips the initial empty
> iovec and the following 10-byte segment, then encounters an alignment
> error.  The bio is discarded, but the iterator remains advanced.  iomap
> subsequently restores its byte count without restoring its position,
> leaving 1025 bytes recorded when only 1015 remain.  Buffered-I/O
> fallback then walks beyond the imported iovec array.  So Daehyeon's
> patch avoids the bad path, but doesn't address the underlying failure
> to restore the iterator when rejecting a bio.


Hi,

Thanks for investigating the issue and preparing a patch.

I was wondering whether a CVE ID would be assigned to this vulnerability.
The CVE ID is important for our research, and we'd appreciate any update.

Best regards,
Haocheng Yu
