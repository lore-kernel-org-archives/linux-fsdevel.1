Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D33C480356
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 10:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629496; cv=pass; b=BQjWT+kE001JqlwXsFOC1hNCFdy5Jllpb1AE2rUG7Dn5qWokAWXrGCxkJHJo72/a1rt29WCYUNk6rc9CW9p38vbSeZq4LvFftopZKK/wPZ1HiGh9XCI9XK3t6x+NC/svbk2fGzl9Lm7cqy3ThWlYkH4YvJwy7a1UaTY2ilcp3gE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629496; c=relaxed/simple;
	bh=niFtT279TmW8ySXevFvQFzJ/wBTdWSe6DHO/ckEaC8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sOo2wAyLUunrWeOwdglSMSgB697m2OOy04d/jfEFm8QOc/h/o9UTcph7lwI22HWcVraK+yQKPVJ4n2SVPTEg02cRQU17CPd13HOMkA+pu+RV1BYzxUxVaq1HyzCxa69ADPvH4kpyezMEa6Qh2+Nspt1JXORdq6p7FST2B7DGFzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1jsV8HW; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1jsV8HW"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c15cb6f5c12so1975788566b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 03:24:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784629492; cv=none;
        d=google.com; s=arc-20260327;
        b=Y4dLRgLV+qAom0XP4qf74rWmATVy3GBdHBS8Lih0IcCWigzdUh+TC8zbeRle8Q+hDD
         XHgg5xxn4bwndWQC6S6W8PzsoqeDPSHCdrYnKYl4tlOjEWl1pQNf1bx6CGiXRMCnXHJd
         3JPLjHsBFaHeDzeZ9Wg0Ar1/lzJr2UQkzqcXBeaUXwYIkammw5PocPuugiGZ5SpYoGY+
         yWDThhwQ5aLheZQcSTz96E7fJzbNsrbpuxdo4Hy0X2/srJSlur++J7eJhHdhl5y7PZyW
         7Gs7TtGAkqgIEg0+w8D3+p7O/TKZrpLdf8jg/QRA4XCgoGI7i0Ya7KR0Gm9tTRS9zrE3
         lsbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OtnqmtFg7Dx6MER3dQqruUgk06OxQyRY+EFDKNLKAiE=;
        fh=cnS5Mi/cjkduKFqT+ZqoX2JadNrFguPpd+KyfDNmpQk=;
        b=T3uyrYjdhDW1WZklYHqBRp0l8+s8eSU0GLWr8zcNK1V3Oc8v+33++a7JvLRiT6QFet
         aK1ugmU/LZJXab8ybOV0EFS5qz2T7ORQcCYoZAr5e9iExDmdT1MwrnZt+1U50J9c06Tt
         JAR+DEgY+jNojzTRrU0u4DecsZE05pllo8ErvGYtRgb1YzCASa1MautmcZbd3L5WUZch
         d9pUbvmSZq8kFo8Bku3kKXYKfo3W5vhTBaIZbAS3hIuNpHDEQ/rHJKVCRl0DcR0Q2+Xx
         aHa2/K/iBPTC/ydk/FvJw1nKacEZJnWyAtNuMeJiKq6EYPWdnWOrGaQZk31aOET1B8ui
         t4xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784629492; x=1785234292; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OtnqmtFg7Dx6MER3dQqruUgk06OxQyRY+EFDKNLKAiE=;
        b=E1jsV8HWK0XJd3OZDAMmDCunaat7YrQ74jCfv3zVbg9WGLN+Kpwcw6Ny4vNep7zDOp
         0jfd+er8cKDWP9dbrgg+O/Bd5Aam5gs89gk7iaJ/h7M4Y6iBAvodsWnjJjQiOGK67nxC
         wNvElGma1Ow1hiEiTjSGJDQWLTwRbEsC42spwC34BJK4QFPPvgRBLJ7uNiVwP8PfpbhP
         25pK+CZvglsjj9CX/hJfxJD9gBpMFeVOskBeXjmu9hLY7ploudkYbbMFcH+D+puT31oL
         z05jgccsBpX55pUU8LBwsCL2U+Qq288PPERqPkpbFHPrA4HBFTXmNy3hnP8cVT5p8NwA
         U3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784629492; x=1785234292;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OtnqmtFg7Dx6MER3dQqruUgk06OxQyRY+EFDKNLKAiE=;
        b=fo5f/qcwrPcWahGk0oDJrcg54/hhKD4WHuUo/mUfPR4FzQPupp0bVBHID+KF9vBJMG
         NQ9vRcWt4zZmyHgAIyzCnSojZcLLp8V/1Qu0LC6uY7jTEs7e4Lco4sbFCPL5hLsN9DZY
         NTX7VtFDN9h/x6EAUuiLh48uF2T+uKAyCfu9ojpw786j9KLP+wRDd11Xcu/HyC49ahI+
         9u6qUDEYbS2wyfP7eBWUelugTzWz82uo1byHSaFbgVvgnSbMTTFJD4xc3I2q8lrqCtcr
         IJx5uBTY4pgN1mz+xM0Na5sFsNuYJ6qviQHd/Tmjei0v3Q3FZ/uCIuVRv7ZsnxVqPTDV
         Bftw==
X-Forwarded-Encrypted: i=1; AHgh+RpyGSdZD0qMTG4Qmlk8AxP1TMBBeXldYMLXeptSwDVSXeZg85gQGVJr9QNYQTucaKTj8zFtumwoy5m9/C/9@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp9/kJNCu9QvhnOA4aH2MQPIlcWNSItsBv/s+w2SXVia8HDkla
	e2mjSZnYeqXG0jSJjhujBENL2tP9btRl8gclkCFHV+5xtK8RpMfREIpL/2qRiXmVsYLR4izao23
	KRCezAWGanSiVDXNud4aBR40EyzShBkM=
X-Gm-Gg: AfdE7clCZBVURwmce2d8FdOBFmfXzy2Ce+37W7o8lHsQbpEN122jyuuo0AlunfKl+/t
	BJilpLVbRmRj1TpBogP+2NZRFhkB+5SfW7+dQF+6Lxvf5vdpA40xCEpmA7RCrAnRyYaQHYzpXld
	IKMWO6BvaXUw16wQaI8SCsk7cmhJZ2r+dR/o7YSu1Mgl7KTiRkrCn07JOPsG2XBdlMvMLNh7jg7
	r5eLV3usPCideZymZIfGUk5lGkin03F0GZpeGxEDg7IT5a2c9Efqwtf0V7H+5x3q0EizAsoGEsV
	7KDa9JWNWov1068s0EU=
X-Received: by 2002:a17:907:1c9f:b0:c16:9af8:c77e with SMTP id
 a640c23a62f3a-c16b46b642bmr662468766b.1.1784629492265; Tue, 21 Jul 2026
 03:24:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721085458.2716-1-aditya.ansh182@gmail.com> <20260721085458.2716-2-aditya.ansh182@gmail.com>
In-Reply-To: <20260721085458.2716-2-aditya.ansh182@gmail.com>
From: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
Date: Tue, 21 Jul 2026 15:54:39 +0530
X-Gm-Features: AUfX_mzqk-L-WvEDQguzwkbHi5MCK4ajCmKKcgUYZRs9rNFCznygmRA3lbFhwKc
Message-ID: <CAK5ssPNpr1Htx5gq--vjx=JM8_ZpXiD5eoSk_8cVMiCr5y2WOw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fs: make file_listxattr and file_removexattr
 helpers non-static
To: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 2:25=E2=80=AFPM Aditya Prakash Srivastava
<aditya.ansh182@gmail.com> wrote:

> -static
> -ssize_t filename_listxattr(int dfd, struct filename *filename,
> -                          unsigned int lookup_flags,
> -                          char __user *list, size_t size)
> +static ssize_t filename_listxattr(int dfd, struct filename *filename,
> +                                 unsigned int lookup_flags,
> +                                 char __user *list, size_t size)

Please ignore this patch series as it has some redundant changes on
top of v1, sorry about the noise. Will send a v3 by removing the
redundant change.
