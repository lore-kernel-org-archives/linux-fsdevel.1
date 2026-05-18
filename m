Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4738C390205
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 18:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779130795; cv=pass; b=upYqT4xFYkg6ZG7gu+cDvPPSlKr6T9hxfulKPEkaMyqEDCKSy+SoPrNQS8qTowpfTz7aPE/i5g8fkSXp/TKHhLlFkqYkZdxWtphS2UCIMQX+UbiaV/0B1vPsPocBwm4X9oYuzbOKIYInmPa83XxxgmGyHnGv7zaDRkw7VaqViik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779130795; c=relaxed/simple;
	bh=dyypnGTPAbgYfVefP9g9uTGtAYGNrN6Dgbk9OMbK1Hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hfN+/RGIBo/kUwmjjpqKK+xYK3X/UITU9mB5jxFsgEGgvve8xV28lqE/hqVsqB5BC5cO/Aw5KfGgQPARJQa+dK4vXlFvJ8600skoCWBoCQq85dK+0fnIukhsRX8rFvbqhT6YjFi6JQDq73Ed8pIBxe/5TN+6aXB54LLP3T2pJ4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MbXTQR2K; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MbXTQR2K"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-67bf769704eso199a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 11:59:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779130793; cv=none;
        d=google.com; s=arc-20240605;
        b=hRTEyKETpLnBhdBr1TtrjJf6XztZ5IO5vC0s6Nzreh6GucwqFdagKYK6/4y0aXXXrM
         C4Siga01Tc7BcRt9Jjn/1FKDlmuoY/yIGgyzOoBqyFMaSgLQHHWvkXAWszQN/Mg7cIK4
         2bTYJAG+l8NR8E4eLraRlK0UC1XHiJo8YN7tzxrl0V2h3Ud78fMnLOddJG1RJMFLahcg
         i015lQxJx/fzG5zJsVGE9RmcG8jAbLM7VpcnejL5r0+9phFe48GAV+74NLZ3O924ttLh
         cr58MqMKg6gIyqyymJqcdkACX9UCRBXjOzi0it4ptKIcS88O+zWlxviPr8GJWwB2x6nq
         bUYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dyypnGTPAbgYfVefP9g9uTGtAYGNrN6Dgbk9OMbK1Hs=;
        fh=OinY3ygVI/aaj+jkG3y5U+zb7kP/e2ICfyIgpbwBJPk=;
        b=N7pykbAJMEzagrvqO9pgO3w/Sk+JoBmCLjGPrO1fjASA3+YFShSwyH7nd7QaIPcv67
         Y+u06xvgTrrEIIMWCUFgEDV0wzxFhdA5Hw+YvkIIVksD8Q31ewu0A/7Fyx6xcFfJfoa7
         2swk8IRYWL026NLM8Ete94FrR20jfIgbWErMKbPc29+PYcLE5G1M2UdxfhSFBbmF7QVF
         HX74mzCHsBmkkHMKwHRvjKV336MjEOwlKE/79AsGqH0IqJfsBwQ0k8el5LPuyMEFY0MB
         DR4Q6MrH7Bhh8FOa0h2DC+pMSfQ937BR9hFJ08qhzdQensXTSspNbDMCtC353RBBymhB
         qt2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779130793; x=1779735593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyypnGTPAbgYfVefP9g9uTGtAYGNrN6Dgbk9OMbK1Hs=;
        b=MbXTQR2Kpf3Xfl5M280xPRbvdgo+gR2vtrEEqA3ydY7IFiteCAJDeO5hlyqv8/4LvR
         P423+iH0NZUGkmxRGIiqCifqgBhPVH1SjRzky4o1bt5AEkEtlvNb3Kc7IBN/G+TQlcwi
         GwyjfhjFMqxbwfvhlzzAaz6tQaZLAvgW1u6U+BJE4/IeF90LEtphCNo/D3WY8DluK47m
         Ny9dPYbMiC067ULGy/9v7LKyEF4brkJJ/Q5Mn5vfNXng51VG91QnOdQzz/f5ffU1naHC
         6/hM39ScNm8mpMhL3L1tM5QWIca4PYydFdogGQ5foC8vi4A7owMoykGgRq+QczIFMolF
         vZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779130793; x=1779735593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dyypnGTPAbgYfVefP9g9uTGtAYGNrN6Dgbk9OMbK1Hs=;
        b=c907xPQcCZP8viQfXHL2SbIJ3KEVxft2nwELATJg3lM72/ygaHuIqToBiYLWHTpjgD
         jQmH3Whxoa0TQgbVQTtvFidBS/1Oq84BfWn+lD+6f0zqitgHe1YYlH2maJBCktC3WXed
         iu/qoae0sSSP44Hb9Giee1KjcbPGzWIonmVm7QFk/sDAUN0pEneBmPKqwlF7xWYNHvdY
         nig65ojOavCuiyAymXANuVWUpxFu3BvNjHA7D6Ajli54fPzgONtF9JAAMwX2ZtFCzcir
         f8U81OyncDcJfAnarAT7kbOXimZT/VjwQs3A+R1jaFvPTfMidkhhgLdkKDGaU4DqOXiv
         kpLg==
X-Forwarded-Encrypted: i=1; AFNElJ8qNAqe5FP1r8OM8X0U2OoITvbomnr2aKMVthsnIg5p77AESJ0c5r66YkC+7eBSPqdKTOB9Bh/SQwBHpu7q@vger.kernel.org
X-Gm-Message-State: AOJu0YwbsbfCM6IXmdFxJxzWsSz1tLubq98TPEF8jh1ysq/AgXHxo64u
	dQ5wbnipSYJyORewpmTi+d4CAZS3akRJ90MJGkT3nGeoNGf5+DWR27EmpocEVv89W4PF57JA5Dj
	diml49FLWxFDnA/Ng84/J/JRM+mygZzTRVVVHZ1bU
X-Gm-Gg: Acq92OGv4WA2qvh7sDWTzheIitWCnIALw+sSatoVCt6BWHQmfhRgqUdmHjUC/iZB+KE
	uvtD6029dA0MdRpPRQrB4To/CjmVZcWPITpgfkaOjl3NEx8xyKxx4Nn1eekoMVylrxcNNIl8ITj
	oOkbLXAx7syXr8PnEMXCrzSIumOfqQkfblMdSw/1qx9483tbIQB+SAwzvoFVsupEtibYMNDzXML
	dXPuvBqqdb6P4yBT/4yhbNSMjL9Vu4IN22+C7ocpEyYELXPyoM2jyXmrGYWUXxOB0Jw/QJocYCy
	O4n7XZHR79BSAVyyAhFc7fEvRF91ggwPlBI3n0zp6mx2x3M=
X-Received: by 2002:a05:6402:a587:20b0:668:c2b6:9fa2 with SMTP id
 4fb4d7f45d1cf-684986efb13mr83277a12.7.1779130792215; Mon, 18 May 2026
 11:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516182126.530498-1-pfalcato@suse.de> <20260518-starten-messdaten-3b8aa670ec85@brauner>
In-Reply-To: <20260518-starten-messdaten-3b8aa670ec85@brauner>
From: Jann Horn <jannh@google.com>
Date: Mon, 18 May 2026 20:59:13 +0200
X-Gm-Features: AVHnY4LvxvBtU7IvbOZw7RgET8Oa9vmPu-ETaJy_kmEvSdqRrpv4JPgUqfOI0wg
Message-ID: <CAG48ez0jbSUgT3ZxPKZP7Eu=K7ce2cX7k2NzHCHNMOxQjOGT9w@mail.gmail.com>
Subject: Re: [RFC PATCH] fs/splice: allow for a way to block splice() with
 read-only files
To: Christian Brauner <brauner@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>, Jens Axboe <axboe@kernel.dk>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Mateusz Guzik <mjguzik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 2:30=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Sat, May 16, 2026 at 07:21:26PM +0100, Pedro Falcato wrote:
> > Since the advent of vulns like Dirty Pipe, Dirty Frag, Copy Fail
> > and Fragnasia, splicing a read-only file is fundamentally unsafe.
> >
> > As such, as a mitigation, add a way for users to block splice() for
> > files they cannot write to. This eliminates this whole class of exploit=
s
> > that use splice()+confusion in pipe/net/etc code to gain write-access t=
o
> > files they can only read.
> >
> > Users can simply toggle fs.splice_needs_write=3D1 and suddenly splice()=
 will
> > refuse perfectly legal splices() from files it can only read, but not w=
rite.
[...]
> At that point you can also just ENOSYS splice() and vmsplice() via
> seccomp and force a fallback on non-splice codepaths that userspace has
> to have anyway as splice() isn't supported unconditionally.
>
> It feels like a knee-jerk reaction to an exploit class originating in
> buggy modules that we have little control over and we would extend an
> API to users that is really difficult to use.
>
> What might make more sense is to add a splice specific security_*() hook
> into the code so that an LSM can deny usage of splice in whatever way it
> wants to - bpf lsm or in-tree lsm.

I feel like a sysctl for "disable all the splice-like interfaces and
zerocopy TX" would be reasonable to have? Either by blocking such
operations, or better, silently downgrading all such operations to
normal copies.

FWIW, vmsplice() and splice() are also weird in how much memory they
can implicitly pin - if you call vmsplice() on a single byte in a 2M
THP page, I believe you'll implicitly pin 2M of memory...

By the way, another bug a few years ago of a similar shape was this
one - also a bug in networking code that can lead to accidental writes
into spliced pages:
https://project-zero.issues.chromium.org/issues/42451650 ("ktls writes
into spliced readonly pages")
with fix: https://git.kernel.org/linus/c5a595000e26
