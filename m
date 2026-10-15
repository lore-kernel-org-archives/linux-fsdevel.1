Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1538B490BEE
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 20:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792097244; cv=pass; b=hT2hK3whpe7rnm/Wt3E3phT5StjbPsLoF+XNuInw4PYfw+qA1VjPl2hgTSyTmLDZ7y2gusZTP2HqtQtknhUvw2VOSCQCiBvuK5QhADF3R9wDUXkcvXCadI7WhUgpWObUz3i+KmmIfgQOsCH7C3KZI4wlsuYvjcMG0/bSp1usOXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792097244; c=relaxed/simple;
	bh=L1vTqlNSlo5T5a/keujEElxWpHoRIlrc2YZnv8bHcdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A4BfSQEAGWXMN2DaFSZN5HqtSboU7AeXhGeIkSErKp2Na3aNuzStt5gfIpBHmZCHJKJTptQ8jvn90MYUiuV1J9zFlvFltUX/y8ZtKednedcwdweKmS7WY/QU/b9a6tkKkiWW+BQo3GldFC+xmnBFyLFFZz87+094K2wwcss45XY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pydcasoe; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pydcasoe"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a02667ccebso42228835e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 13:47:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792097239; cv=none;
        d=google.com; s=arc-20260327;
        b=PAye9nNOgeoaY7UfRpa1ZiJdNtK2qmQx0WDQDkXa4DL/vXoPtB9paVX7nfhtkNXV91
         v52Woew5r0Sb9lzoAj0FScpAzB1O6tWCTCHGYFd4yRqVtKtjkCEok9IDorrPh1UsIxvh
         bVZuhxJfJoMyzQcVJlZB1gsN2COXm6sWMKV1fyTnQUuDq2MDjc1CwLDuVMfo8VtMFibI
         z/I+pXAHOIhnANpPqgtQErxDLN4C4VxflBOtNt1Ny2cZI5PplUwSnxw9ywG3Iwl19FVP
         /yz8a/KHtuqB8s7QeZWseoX8mi9s3ol75EyDu2Gt4u5UjqSaaEKIOWoECrZPoldA/Xbi
         dsdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jPqdmgliSQJVYELUQkNWh1QYQRXFQZopw8GTjLjl5RA=;
        fh=uH6mdfzqosQe5OTatCQUp8PP4g7+Zz189Az2LVamuDs=;
        b=dkI/C7hJqgss+GTBr1kyGFaOnZyqCs5H1LxhGd0ItccPJ5RjOW8nAN8cL+6Mqb2GP4
         qWlswyow/1HO6KfJworTpVTDk/uMgmTr21KmI5BNc2sHLWsalaKHTTJSTnOMNLdpox5q
         EcWviXCTFFnkycx7KDR7JuK21MVWwy4lZZcrsXmv3XxZ9L6ANVQjVPo9xqJsEUDkVb3M
         C1TAluA+9ykOgydQyQ3eiQ9zM6hoRs8btCJQZ/jKmHzSPy2dRIJzQNW4WazKX7Bplb8Y
         CW/IDawYXpjBZ+pELWatO1Ifm83/d3XWuorkLMzJIarXBArKSVfU0Yp/Nrx9mmTBcfm1
         Mkow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792097239; x=1792702039; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jPqdmgliSQJVYELUQkNWh1QYQRXFQZopw8GTjLjl5RA=;
        b=pydcasoe4z/47yqageleE0oT4D4l35B9GzwOMMkmLnyVBXxWkqtSTxt740PAkPYnut
         RwhTbirSyc7BwPGrROB7IS70FBeneuUhuGOhEx/6ZCBStMrxb19i41lCPkZ29hZ10R5l
         pjr6Uz1Kmq3l6ksOdbp9K3vimLyRdgAlFuSLO06CaGLoWfIA4YZfWoeWWT6LxqVeIW9Q
         ETNGNlQxxuqVVnWh87bf3uQ1GoC3RJfCzBc1D2EZbFW7w4xK8YIwSQsms49fhIBbIXEN
         Chx/JWi1ky5QwxvlY9zhxvJ3bfweEXjzZxmXwVDeUkJt34hr7bVbMV1NWBMM8LdcVGfc
         1oRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792097239; x=1792702039;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jPqdmgliSQJVYELUQkNWh1QYQRXFQZopw8GTjLjl5RA=;
        b=zz2BKFMOwFvzRNaiPitU8wJkBlnkhBfYfZSd8SmI3Tfs7e+QxqzDTQGMKOSCJms+rY
         vPx6lGYugVWZHnB5ulQI/LPMnQBlf1905/ZaU3uzBBu09gZ1ZqfdklKSQ0Mdi125g93D
         QE7XK6S+/vvv+YTNUVsnh9d/cHjvLmIVfcpczeJqErUuWmjTpgWu1p5iMVI7JTmBVwR0
         pIIPUGCKIqhCQQxr5jTFUXQO9zkJihXTqlO3elV1x15saHZ26KYjBKYiUSwkk6+AGeeu
         EHJ37Q+Ck5yXPpYE6If64kQSaGGT9vDVle9sR0PY5dE6qXh6oCTEt7dwKc3RrwRgHmWV
         e4vQ==
X-Forwarded-Encrypted: i=1; AKwUvBzfPdmePs13gqEyUFxgb18eHFHK754OzvAFDRbhPRbJJXWTmTivPYk/gu0oeClz/phMmnhkmHSxlvlUZiWo@vger.kernel.org
X-Gm-Message-State: AFq9FYKLrTk3K8DyTnLbuHjws/Ocny3kapC8d4sgVd4jeQUp7RyMsqSQ
	3Vt22UPm882IFcOsrRLbGvgasry3P81O5um32ZJkuwJNIg6kep19kuppcePbMStV2dqbPmxpIgO
	ftIw1lv8QuXV9eHDX0QqLELygPfsOQKm07vwaI94n
X-Gm-Gg: AYBFou2IlHqGHPSiqMBXtTByrIk+tPni67G1G1BjATbdiA8cd0RxzvfC6c4KQg524oQ
	5mqBSDaIgkeaUYASrpHhKCEx7G8wKuX7uiynSEZ+31TngbSW6Bhpm8+WFsq1vDdgm4DeE5Yjzem
	Y/DffOhOXLtf3GBQ0Tz4M3k4K5J1XzmOkuZUDHnpNzcxLFli0DpDg+KFGopDmQzVDTXgqvlRsTX
	b1w28VDWIMBbq4eayl3UZxaNrxe/VLSGcOZyDqMgr1ydpTp+RA2e8YwZlFKcfToErjIhA+I7knJ
	fXJja5b866rodtityiXxC3Ty0QU3E8Rftg/mpnhDKdp6U162Xf04tWUZ9yDITGrx1LAq0A0Kfq0
	PXLgiJjLqSgI+xEBmv8L15ijR1NvfHgpTiS3qK3ENpOj37PoNNaBEp+B/3I9eBGo6e5z/IBeMTY
	/8fw3r9zlymNjhkxOELfb4GCga3oSN/naQFQ9ZozANtDQr5uF/72P8
X-Received: by 2002:a05:600c:1d20:b0:49f:fd40:80fa with SMTP id
 5b1f17b1804b1-4a18e4f50ecmr425834315e9.34.1792097238491; Thu, 15 Oct 2026
 13:47:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014225811.i.852-kees@kernel.org> <20261014225818.3457479-2-kees@kernel.org>
 <2026101517-profane-opponent-4523@gregkh> <CANiq72m_iyquf4Lc8AWvbsBp++ASz4+C_MQ5iYQW-fHd_MNDxA@mail.gmail.com>
 <C46E97AC-3722-4264-B541-04EBC3091E00@kernel.org> <2026101532-fantastic-deafness-e04c@gregkh>
 <CANiq72=wS5NJyeKKaYiHKWhDq2Wjk728qkCUNq4xVoHrPEPCRw@mail.gmail.com> <202610151304.AA5EC855@keescook>
In-Reply-To: <202610151304.AA5EC855@keescook>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 15 Oct 2026 13:47:07 -0700
X-Gm-Features: AclHuK-rLxxhEDBL9-rcDMumk-sd1jsus0ssxmyF55pyppHSQxHMSWMGokd2Kic
Message-ID: <CAKwvOdkn-CniSBEb6ospWuLSGHmXkZwM0JuPcnNbW8biv7TC9g@mail.gmail.com>
Subject: Re: [PATCH 2/2] seq_file: Require explicit initialization of struct seq_operations
To: Kees Cook <kees@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Ian Rogers <irogers@google.com>, 
	Greg KH <greg@kroah.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-fsdevel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 1:07=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Thu, Oct 15, 2026 at 09:47:34AM +0200, Miguel Ojeda wrote:
> > On Thu, Oct 15, 2026 at 9:11=E2=80=AFAM Greg KH <greg@kroah.com> wrote:
> > >
> > > __must_init might be smaller?
> >
> > That sounds fine too. I like that it says that something *has* to be
> > done (like the original name did). Hmm... On the other hand, I guess
> > "must" could sound like one has to initialize the field "somehow",
> > i.e. writing:
> >
> >   struct S s =3D {};
> >
> > definitely initializes it, yet the compiler would warn. Would
> > "explicit" hint a bit more at the fact that one has to actually
> > "write" the field, even if it may have been initialized anyway?
> >
> > (Of course, if one knows that the attribute only applies to fields,
> > then it doesn't make much of a difference)
>
> Hmm, I just noticed Clang isn't diagnosing for file-scoped definitions.
> I've opened: https://github.com/llvm/llvm-project/issues/232483
>
> Do we want to wait on this attribute until Clang has full coverage for
> all initializer cases, or land the attribute so we can continue to add
> coverage for function-level coverage? I'm worried about a compiler bump
> (once the bug is fixed) suddenly exposing a bunch of missed
> initializers, but then again we also have no users yet...

This is a false negative, right? When it gets fixed in clang, the
existing uses in globals start getting checked.  Nothing that would
require compiler version checks, IMO.

>
> -Kees
>
> --
> Kees Cook



--=20
Thanks,
~Nick Desaulniers
