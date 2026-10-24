Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792832811;
	b=ugmeJAI2s7md2gl+ZWArsycmcT5/3cXnaZwYBdVF8Pp+9S5G2aDt1ziLl/FJQDBDf4UT
	 4t8KD4qBGCxu2onC7mcgRxH7eNi1EntSx2pbECqlh7JvigtvqS2+x/uYKEYi82CEdpIG3
	 MY7Pzrh7x4t4JI7V2zW9UCG0e3gabGO39y6cDQxXuKDJ22lKuifuwc0nNFeu2rHHyYO+1
	 L0VDzdbv59OiuTY40RkwH/5lmmF5tKIq5if2+U1Axz3QyLaomI1J87+fwXwb1Zm6IFkhY
	 BmF5rIBmJPJJwkNGkE5e1kXtEVjHpZHNjTfb9Ui9vqw5dZOJUBEPpy8R2c/cPdujHgg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792832811;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=bwcOgZhzB8pVzIxjNmq1w6fxr7yFdfROLxQ8KM4F66w=;
	b=IeTm0QLtZphNnpcHjdJcDsaoB+Ir/Y9xaxfSarSV8Lhvt+4pcQ/wJts8izqO8+B6/ZxY
	 X9oJDhlJZuRYcdVHXKhxkLhVL41m9U9lBa+CsFM0sMSK6Ox8PY1ffiVhoZTqj6mJp7VMy
	 LpeGhe3s+vzjXs6kHI5l3+aFNI7Rd1pTj37Gs7iZU1SiYmg9crsEod+pkfTMAOzp33KOz
	 uG8RrpBaelLpFHmPkazTBCuf2ifOgh6nDQ12xPWJkMFxPNVwUzafhY2Qk3fVFpS9F+Ny2
	 SGnGXXdio1woyXQCI6O+HzZhenDWnrYXhfPCp8tTZ65D713YOwk8YZZ1lA2LCOPFq2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=peA8j1u8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DFF606A31D
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Oct 2026 09:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12DFF606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=peA8j1u8
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8ac4806e210so12807567b3.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Oct 2026 02:06:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792832810; cv=none;
        d=google.com; s=arc-20260327;
        b=RDEdHbUZbT0x4+zEC00cyMtw+PBb47C2Dyxt9aoUDpnW2zjNq5zuHswdErKeZrQreF
         10T5s8jDi91FFGL2CLPtKdq9hNUAfEqEwELmS7x+PT+PvyMKA8Klc8MHGbVBrsnu3OHT
         48gIhwMa3UFt9yg8bFognfiTX7uf9F9jw/AUkZ+8mm4JG5epkSwoQBOEgKGPQt9ElJvx
         gwe9w53+unlzYc0lDX4Qfm2FgQ9yIw6+iNns2B9e07HpVskBJbINiLcVKIOOdC4TPvgY
         SB7sSndCuPyRDFkmnYU/qHqPDGGgjZq4rZRfYupS61KOkwMF0oUGt6b6te4T6VDT1B+I
         mFBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bwcOgZhzB8pVzIxjNmq1w6fxr7yFdfROLxQ8KM4F66w=;
        fh=EPneUy8qzlSYMAp5vX4UzCsAZkJdT4AQU0Mv2/2Y+ds=;
        b=BAGSz4Eulyg+KYqd9lRXhPx5+DPtIol0Ui/nq4dMrbHsm8CWkuEqjvGl6XTYE9h2FK
         WacwPDtYiXHOuLTVutZORLHWRSJm0C9Pm0kxs/bMIMWeC3+5uT099VIt+0rzmTSsY7Q2
         bAhTbimMmxF16SncogSIaIaq2MYaY2Ar6pngsazkHRToFahQwqzsLbWRFVrelPkZ3z3S
         KCV7tz3MMqGf6CqoEzqgFRB0wtHCZ6/Z1fQxlDODk7bxrJaAG51x24lp5pD0wONZ6O41
         DFtrS+ao9TF4lr46aYk1VvPliWJRT3jX1XL7edYC+tAdVU/jkAakgzdSfLZQYTioHeLg
         MLrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792832810; x=1793437610; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bwcOgZhzB8pVzIxjNmq1w6fxr7yFdfROLxQ8KM4F66w=;
        b=peA8j1u8fL46r7ULUkBuBOrWgZjcZROMYGZ7QeWZumuU39NtAgwbi4lKLjEZaLpi47
         QUg2Z6kytDvoBooMMz+RxpxpxOyX0nTLXumOofYA3zDvaLw3eSjq6g8XG5abZjxmwb1X
         lwYYayYMe06KZol633gBGMa9TG9uuDAUqcj7dXfLtMD6f3NfIwLnsj1LL/momBthowgu
         QZx5ma2WqvHDDmnQ4+lOruyPixXvHY9CzMrDSVsXvXD2T8AS9pqeR52DysctWcB8Pdn6
         1ceY6Rd1dN+cDp2NgeNqz3BGo7J1Yzd+gMjD3f229idHPJxrCUHKfs6N1Z8N+QrzXgr4
         Yaug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792832810; x=1793437610;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bwcOgZhzB8pVzIxjNmq1w6fxr7yFdfROLxQ8KM4F66w=;
        b=el5vhtSCOAFkHTSncvJxALNLduZeolVrauZL2BuJL9nUFklo2ySrx+cCwaLG8PfFTo
         MxhTB+9bY6YhUvVIeigdSUdjowyZ4n4HS8QkYpp1cID8eChc3/0OcJvsaDKjv70AgDt4
         j6x0epOhid/RoAQOfCWjvSCKRubC7CSHhH0WAoLrIgZpnbSUX71nl/f5oOWB+775JCwW
         R1y3CJAeOb155ACQsVt6Whf4tCuQyiwQuBAi+QNE4eYWSgMQo+ANl46gTqQVof+MIxnZ
         L5rp8tAJPDfLw6mTXEtfMTDQ4xgJu87LSb47dbOx6peGTlalDTZmxVtGUIOTQOcCwae3
         E0fg==
X-Gm-Message-State: AFq9FYIC4Owfit8wzz6xhOi/iz581pacID73E17yZpCW+25k3nwBtqfU
	fT4oy9mp5r+6BOLFgowusvmec2TfmMGpD9yV8u/TIVEjB67AF3oOWavSVKsELnCrs9um1JsAxBa
	241oaeLYj4FnJoilUJW/MAEfPjsKoPNQ=
X-Gm-Gg: AYBFou2rjubKkhQlPWlVBjL8LvtoflswmRunhMGWTqK+MWd8DBErpv0vHxl1WXxurCX
	a0akZU2e4N2S/wi+ePQwJ696guwWKfjH8MTZACoVcwTqM/sT5PS0nKEiIme950K2s4Mjp9/Cl/8
	safmJh8RvOCYfUsToDw919sZDgu6RkbQ8p2zTc6JC4djCPP1dR2FjfTJn58XP+X6++Q1ad7CrWB
	1miLXPadShdsVWHgmxot2aesr8BTrGDWqWffCBSQzZOQB9NJrIZCwa4mSbuv+HwJSmvAsgX6pKR
	P3pyoXGTIr1Plj1mESWlXySlUtC1GaAZRJddHRplRmPLEMzbSFBbV3uEHU4Fd4DeZiubCoPJNnu
	/RYKAEbvZpxKnL6taMx7xNMuUbrIHqBmzNGhbG7bDKrazPNNRAv8A48RxlQyviTqXSZDsWXM=
X-Received: by 2002:a05:690c:f07:b0:873:5c0f:28b with SMTP id
 00721157ae682-8b166cb996cmr13153177b3.53.1792832809935; Sat, 24 Oct 2026
 02:06:49 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261017020634.792390-1-nickolai@csail.mit.edu>
 <20261024041334.831273-1-nickolai@csail.mit.edu> <20261024041334.831273-2-nickolai@csail.mit.edu>
In-Reply-To: <20261024041334.831273-2-nickolai@csail.mit.edu>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Sat, 24 Oct 2026 10:06:37 +0100
X-Gm-Features: AclHuK-67mTcSnyua7KyheG5Qgmdf3UD4Himo3_0JnMqb1NB2HpTAb2W0dS9rpE
Message-ID: <CAMw=ZnRpCvUBzHb+-vbvgoefZetrnqJc2DNjDKiKKup=J+SVqg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pidfs: do not report fields that do not fit into
 the caller's struct
To: Nickolai Zeldovich <nickolai@csail.mit.edu>
Cc: linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 24 Oct 2026 at 05:13, Nickolai Zeldovich <nickolai@csail.mit.edu> wrote:
>
> The documentation of struct pidfd_info promises that "If the structure
> size is too small to contain a field (requested or not), to avoid
> confusion the mask will not contain a bit for that field", and asks
> userspace to trust the returned mask when deciding which fields hold
> valid data.
>
> pidfd_info() does not keep that promise. It builds kinfo.mask without
> looking at the size encoded in the ioctl command, and
> copy_struct_to_user() then truncates the copy to that size. A caller
> that passes a 64-byte struct (PIDFD_INFO_SIZE_VER0) and requests
> PIDFD_INFO_COREDUMP or PIDFD_INFO_SUPPORTED_MASK gets a mask with
> PIDFD_INFO_COREDUMP, PIDFD_INFO_COREDUMP_SIGNAL, PIDFD_INFO_COREDUMP_CODE
> and PIDFD_INFO_SUPPORTED_MASK set, while the coredump_* and
> supported_mask fields behind the 64 bytes were never written. Trusting
> the mask as documented, userspace then reads whatever its own buffer
> held at those offsets. The same happens for a 72- or 80-byte struct
> and the fields added after it.
>
> Clear the bits of the fields that lie beyond the caller's size before
> the copy, in the one place that knows both the final mask and the size.
> A request for a field that cannot be returned is thereby answered the
> way the header describes: the field is simply absent from the mask.
>
> Fixes: 1d8db6fd698d ("pidfs, coredump: add PIDFD_INFO_COREDUMP")
> Signed-off-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
> ---
>
> Notes:
>     The three size thresholds follow the field layout: coredump_mask and
>     coredump_signal end at PIDFD_INFO_SIZE_VER1 (72), coredump_code at
>     PIDFD_INFO_SIZE_VER2 (80), supported_mask at PIDFD_INFO_SIZE_VER3 (88).
>     Masking the request bits early instead (before the coredump and
>     supported_mask blocks run) would save a little work for such callers
>     but leaves PIDFD_INFO_COREDUMP set by the dumpable-state fallback for a
>     live task; clearing the result once before copy_struct_to_user() covers
>     every way a bit can be set.
>
>  fs/pidfs.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Acked-by: Luca Boccassi <luca.boccassi@gmail.com>
