Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17BA322B87
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 09:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779097942; cv=pass; b=cxDxIdpobhujrzN4XjFFTrv7YpNYzCZcP97ThTbE9TnM8jewwYQlvOvgcWOtG85ADbCdDdj1qkUEwc3ArvWBW/eP3OPoUSR+D5xxKqdD/k6Y7U7YG8P9Je76wv0viSMtgfQmCw0/B58O2q2LOFAXSfLlB9+i2k3Eo27pHRK0dM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779097942; c=relaxed/simple;
	bh=KigKW26hzOXOk0DnB5iTtKWzFWSQ3TghZ6TRctLAp5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iPXIeLTSGcIn19NM7Nv01PcAd6t+meA+V9r/RZcCWcTBmYnr+YlrD/jvocE1AEC+erCskeVOEYPbTFeluTYkjVBcpDXpQpglxFWGA+yIgkvYdg1xdzNvbZZWW6KCcVgG4S2ZfoOeae6oe4FgwPyHu/v/PZewzJS83DN+s9kLPJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+t4bJdH; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+t4bJdH"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-67da63ae541so4593469a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 02:52:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779097939; cv=none;
        d=google.com; s=arc-20240605;
        b=aehnbF9LRlNm9VWvyjhw14ocWanyp+Pcyh+Xe34Vhkfa6egpOq8vSGoXRV4XQiUAg6
         K749cMfq+cKO/TDTkvIC+et+nwTXmK7pQ5ouBHV+basOrhvb2erF5h8M2y9oEi6PjirP
         mUzRvhTGFAyK0blUsd5oEyvuAdHvTv1KFQewtZLr1JODUs5heMeX5VFdJnYgr2zSoJ63
         bmll1s7zhrDbpNLftfOrZHEngeNS6jfCkzJLvm2PeX6bQ3Ttr3OtZpHNjShKgpGFr12x
         rl7+0N4SGLMKZ2T4I0sE+2MQibQ53A3vppQxWprwlp2fhGnefEPdfaDA4BonYZGAJFVt
         00qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9r9CYEpqvhF152363w7YhgQ/z6cpm6LzbBUZimMW9FE=;
        fh=bpeAaVQ4pnxQ+JK9Vk5C2fVcwDH2ud7iCxpoTkVg2ss=;
        b=GE8TFmCPiENUNy1K20YfTJIaLYZVOT6ybvyPRwNJY0JBlRFXw7ZrTXdIZlu3PG4EU+
         khS9N7LAF778j8+cOGltANQ3nM3jYgoILc61Yjnq5J77dxAoI+ibW7mdndMUCciwebRH
         j6vYS+FLj/jB5pzl4xZbJLonszNDdVxMS7x9xU1FCsQYkgXdO2O+aa/b6knaFUYMWdi7
         XPBk1KgJM6bCIrbA6cIU9YYsMu6sYenhLrF6SoQZBWuiw0mq/IMs3aehQ+PTbR4nCEz4
         fw/ob4mec6C+QNU7SH9DsdCpEpNw2hm7Sf+uAe4L3dhIb+IEERrnL4fG2+95uDDAxYb8
         ezeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779097939; x=1779702739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9r9CYEpqvhF152363w7YhgQ/z6cpm6LzbBUZimMW9FE=;
        b=G+t4bJdHNIiNBmk3x6Oo2jyowWleK6jKauumuaT6c/BAMz7S7MLI2eNJj2BP7paU6d
         9wZGCjHDp5LJuqj+hmgcTydWGS7SgVjZLY1Zvajc+L8JeIUcCbHI1wqseInJWUPSpdPs
         +byd+1Lhic4sHk33DSSXv+eESIYu0IfLRslBQPeqMwIVXpt9c6qLUHqMb8lw29wqLbuo
         3vZphWg9H404y0b6OzINYfPPGy2SLY06+eS0XJepCKMuF0+k1KGcZfQh3dNo744UzH6s
         mbtfI481TZgLd8k+OY1i4wkIEvOPtJ4hUFHzQCF8mDqev+BfFgIn54rToossEBpQvWI3
         G+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779097939; x=1779702739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9r9CYEpqvhF152363w7YhgQ/z6cpm6LzbBUZimMW9FE=;
        b=DExevpJJlKHs0lwj0Tc2ndRu8CiqNChENaSd5JhmC8/q1JtI12XT1+Gf1+FeWEMN4x
         /n5Asxd5uGnv1sV+HYRB157++/aPNZeI11w7/KhIx2M92EiU5lQxy2tAtIbM1DrGmTkC
         RjTA3V1JxNIlFzAPhmjSQRUM9h99zNhViPp3KcD9GRcDZ23ZLsvSpoVIvgWcBqjU/wXA
         liCLFW4jVXuMc9b/b45IhsgdAnHJu/2LogIhtBkxXmSZZuh8gxfq5HUt35lmCjWC1h5w
         LqF8RibY6mFmS4ZvsBvt5G1cj0WNGaq2lO1pb9+WG+OueNjjhOUc5U0fxgrwvkg8ztzt
         hsyQ==
X-Forwarded-Encrypted: i=1; AFNElJ/QwwwRDGmSIE2iio8ntYcNJo1QHglsS0WdSdTucJ0GXC+Elv3sNSs531GTM1XIRq/C5zrVXSZq0b/EBCwQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4gHHM8soEmglkBOn2f7dxfeSFu9jOcPG7ynfRI+E0ujqEuDG3
	dU1cU7AmVIgMx+HyxtREvfwgxqNYMV5a25nUUwzSrfVxjEoXvQ4c5Za2FCAPIk6beZxgrU4bNc7
	WXflBGEPlznPx3iV+8KCFVM7d7CC3CtY=
X-Gm-Gg: Acq92OE4yRtvY72lQzbbNoMFFOkfHwYNMAaQcHmYGfW8e7X9OtkjtWcv2uk9cFmTEts
	/oUI+HW4UxScDqSD0tBVFj6PfH1D/9W7nhTIHuAZ37+RJ3JuKHqCm0ukmOsPt9M99Luce4i6dUf
	IDpUHSnzAf18a57MD+m4HlE7T65hjhiEQbfa5CB0rv6bD5Fx6W7y80GJImN/RNMCqFXx1ocdfPG
	59yzkUCYJxCNShJDbj8TPmKXVdOCojCjmB38ok4j/9IzqiSjCGQ6izpVEeI/9H/1Mq9WDqUT/71
	xJPB+Xq6u9XGTdynZ8W+VG7BaxxIdiI88O44lIap4g==
X-Received: by 2002:a05:6402:304b:b0:678:e6a9:c39 with SMTP id
 4fb4d7f45d1cf-683bcd9f43amr4810104a12.13.1779097938863; Mon, 18 May 2026
 02:52:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514200129.94862-1-amir73il@gmail.com> <20260515193010.056ef472@pumpkin>
 <CAOQ4uxjDeF3uDe=OTVZ3fK65dF148FRUvPx5fOqZpoFuGUsmJQ@mail.gmail.com>
 <20260516094242.77d20c92@pumpkin> <CAOQ4uxjX=C6WZvW1DdJ13tJj-XBWVxgE2Q9vVvHoYqiOhqW0wQ@mail.gmail.com>
 <87se7pdr7a.fsf@prevas.dk>
In-Reply-To: <87se7pdr7a.fsf@prevas.dk>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 18 May 2026 11:52:06 +0200
X-Gm-Features: AVHnY4KWs2vUCH6jUzS1W7hr8zsGFJwgra5DKB_XQHV-YlVobPgAcA2P4f3-R7g
Message-ID: <CAOQ4uxj0sgB5B+1gzzq8fPuAPJxU=TfXMUaJtjB6vdfXUSOuqQ@mail.gmail.com>
Subject: Re: [PATCH] err_ptr.h: introduce ERR_PTR_SAFE()
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: David Laight <david.laight.linux@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Nirmoy Das <nirmoyd@nvidia.com>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 11:04=E2=80=AFAM Rasmus Villemoes <ravi@prevas.dk> =
wrote:
>
> On Sat, May 16 2026, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > On Sat, May 16, 2026 at 10:42=E2=80=AFAM David Laight
> > <david.laight.linux@gmail.com> wrote:
> >>
> >> On Fri, 15 May 2026 21:26:04 +0200
> >> Amir Goldstein <amir73il@gmail.com> wrote:
> >>
> >> > On Fri, May 15, 2026 at 8:30=E2=80=AFPM David Laight
> >> > <david.laight.linux@gmail.com> wrote:
> >> > >
> >> > > On Thu, 14 May 2026 22:01:29 +0200
> >> > > Amir Goldstein <amir73il@gmail.com> wrote:
> >> > >
> >> ...
> >> > >
> >> > > The object code bloat would be noticeable if this were used everyw=
here.
> >> > > But you could make it a bit simpler:
> >> > >         if (__builtin_constant_p(__e))
> >> > >                 BUILD_BUG_ON(__e && !IS_ERR_VALUE(__e));
> >> > >         else if WARN_ON(__e && !IS_ERR_VALUE(__e))
> >> > >                 __e =3D -MAX_ERRNO; // Or maybe -EINVAL to stop an=
d other boundary errors
> >> > >         (void *)__e;
> >> >
> >> > Yeh that's nicer thanks.
> >>
> >> Actually this might be better still (or just more succinct):
> >>         void *__e =3D (void *)error;
> >>         BUILD_BUG_ON(!statically_true(IS_ERR_OR_NULL(__e));
> >
> > This condition is wrong but also my compiler does not evaluate
> > __builtin_constant_p(IS_ERR_OR_NULL(__e)) as true.
> >
> > This works
> > BUILD_BUG_ON(statically_true(!IS_ERR_VALUE(__e)));
> >
> > I think it is enough to statically assert on ERR_PTR(EINVAL)
> > and no need to bother with ERR_PTR(0)
> >
> >>         if (WARN_ON(!IS_ERR_OR_NULL(__e))
> >>                 __e =3D (void *)-EINVAL;
> >
> > Oh, anything but EINVAL please - the most overloaded error value
> > My choice of meaningful error value would be EFAULT
>
> Could we have a dedicated "EBUG" that can be used to indicate "there's a
> bug somewhere in the kernel, we can handle it somewhat gracefully here
> by returning an error instead of BUG(). You can't do anything about it
> but report that you got -EBUG from $this_syscall", instead of
> overloading EIO, EFAULT, EINVAL or whatnot. Internally, EBUG could be a
> macro that did ({ WARN_ONCE(); -__EBUG; }) or something, so there would
> automatically be bread crumbs in dmesg if it is ever hit.

How exactly would you use this EBUG() to write the graceful handling?
A bit of overengineering if you ask me.

>
> Userspace code could also benefit from having EBUG to indicate that some
> internal inconsistency has been detected.

So what about

#define EBUG MAX_ERRNO

as per my suggested patch.

Thanks,
Amir.
