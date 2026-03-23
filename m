Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742C635DA48
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 11:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774263641; cv=pass; b=R1NeB2ldQ6++Iq8cSCOY+mlObFONODhpo7tneod2h6k7sjyCqoHgnf9y063oLDD+xgIRrFKC+zxYDqbTm8PEOk/najbfDksEPoxDQ3l/AJs9mzljV4ZXXPSj73Qo5TzXAjmwq4jOy0A66bzboMgy8KbQQR/h2tIFfrpCcLYL+l4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774263641; c=relaxed/simple;
	bh=Gn5uwAfWOOMoxVJ6M4pHKOA2XtPBawoLryKzrSF56lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GufxU2Zz7NrMHnD2ZGcDa2XVGDzNwzbGNGrsxCPt/MaE+8UNjsEDlcKEiZmPsrm/kmKqSJvezBdp0aj5NoUwBg440PHMvi/deprnUC8ODh8pkoEZNVgS6PK5aNPKEiaTM+qlGNRBq8+UIeOqB0lQIEOxjh26OrnEiZ3FiB/6eTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIY1WRsX; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIY1WRsX"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b9358bc9c50so3595566b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 04:00:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774263639; cv=none;
        d=google.com; s=arc-20240605;
        b=B5Db4/xcKqsv9w3nxh3lVpwtCnOA1KiirbTU72NQuxjCUC2N1BCM79J+aSZNvMJp5s
         FUfUEM2y7ZNZANh4FlCIXa/IMlCMhykMdOOsck1FxGheFrswFZu5OycL6vwj5O8zCfWI
         Zmyi6XfOggkupQGp8zFbOEmGHvwFnNQY5WNv32d/Y0Zea9eSHEpkdWyn5BehpK6v+pbJ
         hUxiCHk22DLL8di2ox6fXH53vd9Pt9oM4iM3JpRTEemgKMf5ZKqYIjdudKh1p6nz/NQl
         zA7t2NB102VKGlP8Q/Rq5KKFhPY4FUVj1nGddY6P5CrbygOncU8HRsE0NHxWTUQwgraH
         YISw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cSGpaVyF39hFMSdks4NM78WkSjn0wX5SlwI9WU6IOOo=;
        fh=i/fFi7XQFbEfuygojJKFiPo6UZylx/spPyLWK4gja6Q=;
        b=KGQ6tx6sq49TZxbnJ/EvXyHjFsAzj1H0vw7OB1eixlvzIc3fNaevDHpqI79t41keZJ
         A/7QYg/J6W4jY0pWIjBZ2ulHpioL15aMpSPS/KjpayECZ9HPcAXM0G5UhRHchLTcuQKZ
         RRGPn82lXDZbnCnWBeMaJ7XNpYjLExYJgDxbCVTK+b17Ndj1Dh2lGx5k9jN1MCTKpBTG
         wPIhptLSruMKOf+NsiaFTUV/j7VSkQ7Gz/wmUAS7iUO1lcMuBUU6ScF0Ud9ykfZmL9Na
         87wFOkRwoCRBNF+YGGthqtD3IaP5qXpbv7CoXgNW2M5nmeLmUzE6Eyx3NWQ0AXsm33Gd
         5ALA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774263639; x=1774868439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSGpaVyF39hFMSdks4NM78WkSjn0wX5SlwI9WU6IOOo=;
        b=UIY1WRsXz9eJAMhzMUUUrdLtYV6Wz7KxTi2bxZW+ADoCGz9I/2g3IyWG1VkdHZqMFn
         D7Vgdqg6/qGii99AW9GEAu6O1WpP8KN2Hd0VaTmgS96/z0RcvYCm4kuM7ZGoJ+VODSK5
         9456g5kgJWoEP33aQRzOi3JowSTY+n1DE9Mi6degq6+Cc4GbvFy3+eS7Atnz5HrvNpL7
         /ExXKc4Go5Z3XIWUWgRmJEi5ANTEXkk0mm1HKHnb3S07pZEovCB9YYZoagkUkQB/Si8X
         hagMHOzZigWtlqTjHmItYgMEe/O1LTD4m/Zvr4QMD1Frsz/rmItrc0Lpj3egnkz6piSj
         JjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774263639; x=1774868439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cSGpaVyF39hFMSdks4NM78WkSjn0wX5SlwI9WU6IOOo=;
        b=JoBGKUCf8gI47cUfuhV22soiIHnWfp9i9xU0IUXwDHkc+/KYeLUECjXC5XfTnL5pub
         w06QTPG4K9bw/RbMsI5ceayAHalDIlZwyTq5asqgps4C21pAA0ubI/kvuRUfCevEEF+r
         u1pI5QrHlW1Oxb/fhieSXkje782b4c+TpB9GLrRUCPfX6m/Uch6NBmX7Hbl5arzntJme
         LkoyNW/syi7zfwhRVX7PaBMu9ADTLpwQzF2Wu/mcMRNk096GasfceNvybg58bHJ9dW1t
         z4SOJDmgb/OCrR+IfgibWLDiNLf8rk1+QUgYjJFiTrnhDDsCrmI/2DO7PisMzqSrp0Kt
         RJrg==
X-Forwarded-Encrypted: i=1; AJvYcCX5OKCxMtdPkhHi0pvYpNtQkEpYEPxka3tR/SFAEueVpWboqOM/YTyyUCGHgNOywMvmAir5h5KapLxybz0z@vger.kernel.org
X-Gm-Message-State: AOJu0YwkOYvs65tk+Yg4Oqa3fX7iWIBGD4l1qIyzE++Bs7C9HOyBlqZN
	yL85TYtc5FvXtqiKpGDcZK/J7HmB2rbxznZyxbB7oxfvUqF3YHmwBCito5Kg0UIhiJ14lZq+EtV
	+Mm8znYYp/Shd4uqY2U2HatcdErIiX+s=
X-Gm-Gg: ATEYQzxk+vQrjg6KHvOEbrPAwb23jLTS+B+kSymS2FnZr3htRSpJXd3zYsE2z0zqaFp
	rtx9B0qDLWsCQtzhDgU+s6Xzi2i/gvt/dtKK6m8Lp/6qcK2UcjjVA2BffCo/Y5LXV8t3JN+w3KH
	6TJPlhhXkosJhPbLrpRHrqrr+LT7HA4CEXbmI+uBntQYWegxxfs/V8pkzZZPBilEKAneu8p6Sqt
	w5v2J+56W5otxYSBzNs0LBNQ9APQEvI7WAwtVF1zgexoPVBEW93Zl9xFBKrkkOKVtCAeCiZTvry
	SmwMSUJV9/Cwt6rJ2zBdyT4DkuMutSct9KUOjYE=
X-Received: by 2002:a17:906:1444:b0:b94:ec:4b42 with SMTP id
 a640c23a62f3a-b982f2f0f91mr571386966b.26.1774263638404; Mon, 23 Mar 2026
 04:00:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321210544.519259-4-thorsten.blum@linux.dev>
 <jdyy4txjjlmbwofqbsvpk53yx6cvx5lto47guv3nevpiflylhc@vjyncn6aesh3> <20260323-frohsinn-rudel-2f5a8bbae433@brauner>
In-Reply-To: <20260323-frohsinn-rudel-2f5a8bbae433@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 23 Mar 2026 12:00:27 +0100
X-Gm-Features: AQROBzDh27iaL8CrSNs-UiijEiHk7EG9MTb9mkwAVBzgjEV8wxTdWFWLgjSGbTo
Message-ID: <CAOQ4uxgHuZvYfw2nZV+1h5L=_Q37jbMR2YhgN0fhX=+ciif3Rg@mail.gmail.com>
Subject: Re: [PATCH] fanotify: replace deprecated strcpy in fanotify_info_copy_{name,name2}
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Thorsten Blum <thorsten.blum@linux.dev>, 
	Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 11:12=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Mon, Mar 23, 2026 at 10:14:24AM +0100, Jan Kara wrote:
> > On Sat 21-03-26 22:05:47, Thorsten Blum wrote:
> > > strcpy() has been deprecated [1] because it performs no bounds checki=
ng
> > > on the destination buffer, which can lead to buffer overflows. Replac=
e
> > > it with the safer strscpy().
> > >
> > > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#=
strcpy [1]
> > > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> >
> > I was a bit undecided about this one because I was wondering what
> > additional protection does the use of strscpy() bring here. But I guess=
 the
> > protection from corrupted qstr (where the length doesn't match the real=
 string
> > length) makes some sense. So I've taken the patch into my tree. Thanks!
>
> Fwiw, patches are now auto-tested on vfs-ci:
> https://github.com/linux-fsdevel/vfs/pull/860
> Just for some testing data. We should probably hook up the relevant LTP
> tests for fanotify there as well.

That would be cool :)

I guess for vfs you would would to run these LTP test groups
$ ls runtest/fs*
runtest/fs  runtest/fs_bind  runtest/fs_perms_simple  runtest/fs_readonly

fanotify tests are currently only in the syscalls group.

I could create an fsnotify test group or
we could try to create a vfs focused group such as fs_syscalls,
but actually, at a quick glance, it looks like ~75% are fs related syscalls=
.

Thanks,
Amir.
