Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437A433B6E3
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775746568; cv=pass; b=iY3GrG2wTcOGYSqPiwAxWEQjyUnGv9pU9Eq0QDtPLP0yrtUSlgHhXKLXLI2LQ01Z/8XT+0omlEsOsDWZWnH3e2kv0IDS7C5rzaC1nzbGanQGjhKygFItZQAOtD0BQGnQv+VRdg1yJ0KpcWCcec8WQpqAcdPAJxqysFafyY66AmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775746568; c=relaxed/simple;
	bh=iOpgq3r4MNYZKGYat2WbwJQH3SmgBegLoeTZdyZyHWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HNH8+t8HUisse+W06XxLRmO5mBxARLIRk2ufYpH1qzUKgIR2x3+BUBmRtVp7NuPswiCU2w8LPnHtHsdhbhyjdMWQz6e1oHYVkFOkHtiseeJsvuDu+6UsxYuzc6D+PuC8zYl602JlEeFRK7Gm/NuRc8dY82FPKHOKKI133xfbII0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6fKn7ZQ; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6fKn7ZQ"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9d6c8871c7so15535266b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2026 07:56:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775746565; cv=none;
        d=google.com; s=arc-20240605;
        b=AY9lAlIoiMbWES32QwQ9IVVESATfkKl+Iu13ZFJUatUPuaNHByM5sv4wN70jfJCWAj
         QF9qmhx7TsD6OOahq7/9XrOzfxBo42cwHMkKQ2rB2MnVhxc33YWfrWuxyYL4014X3YTD
         3BV+N1n8OwI0dEALdpz3HYqwKfEfiw6TAlL6IvVcfSW9gW3sRffTID4Qu2SPMJKO05wu
         luNfr+rT0qGidwv0Yul3i+Y7iUlduA8PLEkAkDvIyF5Q/7GqqCOuvPmywuoitaNN+HP/
         d8c24xpq154gGSmOpA7LK45vvDs6+DwkzaWVm0AH1MbBoh7RpH2chwz4ah9sNbYB0rYj
         Fpog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iOpgq3r4MNYZKGYat2WbwJQH3SmgBegLoeTZdyZyHWM=;
        fh=38pQKIjHQui7BPaMy1mAoCN664hRL1soD2JYS9zdmJI=;
        b=QTAnBRm0iFn9IQPzeA6f/BzuAey+XlN4M7qfUxrlf6Ic7K2DD1LGsozAjSV2Z3rU1Y
         iUbd/kpCDXMe+WipCDh8hGyySs7z1r7gGSfVgmTQQU/EwpUwVfilRzyte1f9UJMr1LOp
         kWSp0DMdRoeyoLhfYFbnXEairEnHT7aNVigZbdXHLgmJW8EcbvCOFYqdXZe2JyMP9qES
         88xpTxtJWb1OcuiD6lDw7HmMl88RJUk5M8QJHqRW/kgVMoeYvP/RCvern0ZMo2LUu+Wm
         JahRQlN1g/GDYSg+80Xzp7Sv7KNV1B/RzGFGJVFqQNptHh+pP53kScmUCgyYw+xa75rC
         rb3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775746565; x=1776351365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOpgq3r4MNYZKGYat2WbwJQH3SmgBegLoeTZdyZyHWM=;
        b=P6fKn7ZQTpjpVmtyVZpr3DUn8ssXkUG/TFb0V8+TOVIwPqeCWWOafm4z9rYgWVrydz
         h5Taj6XeT56LsJDgN0C04ehDoruBgpDemrSM1BKnOtLbzZs/WHxxtoWNZ/ORM9h09cbP
         +wUak69JiLw38kFe0eAgSq3BZNDpNEI3xYcAixvLaEGUyYbqN2aEAbWGnxTT3nW56mh2
         SLMOh6nPWfxeLrPuhbOym1ySKSkOq2toKa+drPb1SNUpBy034GQ8+KwyAa1o6RVS0c/h
         A86nUUGDlQK/NfiKhl+ab9aqT/RQJbJ/6XILcV2BUPfPaIEaFr3faOPL2ZpiJ5qJCH1H
         W6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775746565; x=1776351365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iOpgq3r4MNYZKGYat2WbwJQH3SmgBegLoeTZdyZyHWM=;
        b=LQzU4DKYPfqAWbat7l5FY/kR7ZQqLWiHolIbWce9uUjaNFEqyT02RP7QTgZoURFzzF
         JSThfyirWNJPb1P2XmBhfMP6QOvbp4aYSaVOo1wAIoWurBmM6OB1GdQFGDeNTB2/TUTD
         jdL1ToF7QiWkfnKq9b2SjkXXXWkg+yLQx7PfGvS7YgjyylV85mmUNZTTyJIWVPbU9JQ3
         3OxQv6qso2UwIyGmsC9+rSkscb2L67vx6c391H+3K5Occdb8HHHhJ8mUZGemxEzfyNRZ
         Q6CedXIZgnInAwa3U6HVOFL6zqZeg8T+rIUNhcHIEjMe0lE3qjq9MyXoQ/cPjFapBlbh
         VhzA==
X-Forwarded-Encrypted: i=1; AJvYcCVWow+LOFB0NdbVTyZuUVjEvfMTrTt/lJs/TODfHMD9SBQ+uAOnUpo6J6LbXxufoS0tTuC4TgrNkvoexPr+@vger.kernel.org
X-Gm-Message-State: AOJu0YxPKxcOf4kzz2Gk+6jjXJeJyePXxCCWV9pQ71goV0J0vhz87nDG
	Nr2IGX7vFhumJvGUkz9+aGSnEomZqjVXk1yoBZYZmRGWfT9l6VEwymewKyenudMbdUCcIAjsiep
	OKMG0sfVf28/3hmb5x9kzqrfvCKj4YpE=
X-Gm-Gg: AeBDiev9Xyx7w1tBDTIZvjzrfieRjiUd1/X4ENggM2XJfrwUG9v7ybujgmuRQrthqCy
	VXpqa9HnqY/hepvqr905EvVCZpY0Nc/Yb6bjS38UsNkr1MTCtS8I4iIfdknT9AYEEtNnXj4yrDZ
	w6AEJvcCyzbgaor9xKTfm4IE4IF4Ih/XjJCOmMqg6ww1nibCLVqCDS6wqIU5qeGIpXHuOH+/EI7
	waXLiftwT3d8GEkdq5comVCxBHY9cMvU8E5iUmP3/7t4mWBxzsoPlBAmO4jQCjl/eRuT09UTNHh
	4CQv8Cvxg2dmR29Tx0WUCz05PSynXU5PpClJ/Wg=
X-Received: by 2002:a17:907:94c1:b0:b9c:c855:d93e with SMTP id
 a640c23a62f3a-b9d4766352dmr219894266b.29.1775746565100; Thu, 09 Apr 2026
 07:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331160851.3854954-1-mjguzik@gmail.com> <20260331160851.3854954-4-mjguzik@gmail.com>
 <itaix3v2pgkrlvhxetyepfzrbyg7bnigghrkrdofznas37nsyf@irriakb7cwzj>
 <CAGudoHEBkMu=mY12U6WmXDReY5EUXehP6wG45XmLyQ5qHiMA3w@mail.gmail.com> <20260409-weben-obstgarten-1465edb3d7bf@brauner>
In-Reply-To: <20260409-weben-obstgarten-1465edb3d7bf@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 9 Apr 2026 16:55:52 +0200
X-Gm-Features: AQROBzBqVVhydJF7vdhez0G2Mq_EjLvcSsHSUMMLy4z3S1ROsaH6RxhCcQVNCdY
Message-ID: <CAGudoHHeRPm+yZo7AVvadkZg5HNEKx6JPBBNQu0UPecJf2H7hw@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] fs: handle potential filesystems which use
 I_DONTCACHE and drop the lock in ->drop_inode
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 3:40=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Wed, Apr 01, 2026 at 08:50:39PM +0200, Mateusz Guzik wrote:
> > On Wed, Apr 1, 2026 at 7:45=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Tue 31-03-26 18:08:50, Mateusz Guzik wrote:
> > > > f2fs and ntfs play games where they transitioning the refcount 0->1=
 and release
> > >
> > > I don't see ntfs providing .drop_inode at all in current Linu's kerne=
l? The
> > > f2fs case is indeed ugly and a gross hack. But I don't see easy way h=
ow to
> > > fix that for now.
> > >
> >
> > This was generated against next-20260327, then:
>
> Ideally don't develop against next... If you already know you're going
> to do a bunch of work in an area. I can just assign you a branch to work
> of off. Easier for everyone. Also makes the CI easier.

So what should stuff be generated against? fs-next? vfs.all?

I don't have enough work left to warrant any special branches I think.
