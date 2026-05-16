Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364192FFF99
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 May 2026 20:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778963982; cv=pass; b=u1yFgpPTJnmFJ2z01gqImN474JAu9uV9cGYGFk1lYEwT9JVaePu5s/O1Ew4L3oVwd68vF1wMp3ts/zaiypZrp7wZBtNBTGb+7zXseQI6YTrD0AaSdBOGlDpzeY7jcJ5HQ1PrkaumIrY4srW+y8V600oUUpe8JvpZhnEqlsqXmmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778963982; c=relaxed/simple;
	bh=NpUiG2LWfRf8x3SP/cPw1njC6/ttXMyWGTY3THWBtik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ret/zuC7LBtlrSwLrbTDHVbISIZkXhmiF2CxjeGhAgsmU3xdXsg29L26b+EtfwzBGjV2jmJyQHd7bdi0xEP7BBNNa7GgcMRrFbP6SKIMhjWrvyRu7gdfpMWPahFVa+fEM2jDR6oqkLmO/787GDgFrtVRzmX4ii85TNTN1nxXkD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvSO/p8W; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvSO/p8W"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-67c1e0229acso1740377a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 May 2026 13:39:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778963980; cv=none;
        d=google.com; s=arc-20240605;
        b=X1zwZ22lEdzZeVR3eX0Q5yZNfQ4gg8hLTsWU3GaEg9v49LMpRiGf01gEdz1Riccept
         QGYcBOJixhcZXeRRIKJC7g3bi4PmN/i/BW3bNoUzY8DG7p3dISXEY0WQw2iOH/lypX8w
         qMtHC2V+lDboBbvd1NZMi48wRADFqWumYFMjMGGqXTRAG3V9KWEGk3gYp65Xs9DcAD+1
         fvrrY4JQrCXERvIgM8GK74eL5f0KmiWeIjKqkKGdo/62etW5jjMBf0GOG+Ps0DW0R+VH
         HwBUh+yQeNif4AyIn/bsbI4UCi48K1WUe+HGw8SBgpS4W6f6HEqwJnFTzIG/lcGsXuAg
         WAfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K9E/Mw8hN/YOcZbEV0N8ExaCxTBWYWUJJ0rpQ46+P/s=;
        fh=fUNNmD8jdNwwoaljNlVDtmwgKIRynwVfX8WzKI8CiqQ=;
        b=JMeTM54aENpNQ+L8fojnynU7GzPzShSFGYkisxPuG0wkMI8Jv0ZxnIk+O8PeHPeE4X
         CtWkyXjd46QzifO0rDYpO3kdB/wHvMsihxBT8g+KWOvKiI1T8cp4ntfFB0kaQ6ARt2aL
         rDSK7kCl7+Rj04uSR3ObT+CUtwqkScW6DAbTdQFEpNe5CctEtzipHTZsXYLS7UQzaYAI
         E0bQboQmn3iz+vEPDOF5ubbZ9HokTtjnNLIqXqvrdwIwbyVu16te2pfn90k7g7JrzYD2
         1EGscIfVi0JrkNhRNYyR02QeoTuthIMRV0K/GZ2RmxcFvKhBUZuH3uYwAQT7MtwY9c6S
         wg1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778963980; x=1779568780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9E/Mw8hN/YOcZbEV0N8ExaCxTBWYWUJJ0rpQ46+P/s=;
        b=PvSO/p8W3E/ha/n/c3Occm+aPOZ5ncNyXEq+db8fT73AAdbgC/Moci8l2pbxDAORWw
         qt0FVT0uMkpY7gteecnk6/mm1lmVYpLJUVCsKO13L9MDhJdFaX3kKLU0MORQi+i14h6p
         DEd5HDZUv/vMSJ4broh/MntJqn0P6SwMd6QeubWvne9PjTGf579Z8PSsHJ+UX9m8+Rve
         ViERL/3tGihcpyjDQI5gGQVOTn8AuWAjGij/QZnPS2UDZO7ETUqqJrs8XaPtCPObNso1
         DYNfiPPPz7nkFizUZ4gqfDHAVKpgt4xxSuWowUuE16JKGEBWhp3wiNZyXYqgSgv4UL73
         9Yww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778963980; x=1779568780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K9E/Mw8hN/YOcZbEV0N8ExaCxTBWYWUJJ0rpQ46+P/s=;
        b=cLTTQJSU2eotckh3UtGaGBHSILEnhvXGZMcdiVs7r76jYGx0oe8FQrCvpq5tySCaYH
         o4SePzjGD4vReKvmseI6d9VBsLjSFWeRStLRdy3HVzbtPuJo0ymHdWA8JNAu6VAlw3TJ
         m9wxjdrUZ3VbvP7YWicCBNfRSAcIfS5zrBCqjLIRFHPNvja7cqybR1M5SNNE39b6jPZg
         soYn4FBl1GCW59xoqqRFaixuACuKum5f+WhUGj0kOUA11RfQq71Jv3T93hrlq29LCHps
         XvJdIhEAQ0a7mJBN30KAcjqUsraH7TY//XYn7ceViRHq7iR9BI2g4ygz5NWAFbKBXnLk
         lBXg==
X-Forwarded-Encrypted: i=1; AFNElJ8d7cBlXZIgxUybOELhbAWfUm8dRQPUGwl1oV+ccU9pOyJftVko4Sp+qwB1d/+2h45dRfRJhIoLN88X+oUu@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+yvuSOVwn9YjcT+NTVqP79RP4wFM6oyWf/y+EVTAdmIZGqdGl
	HBr1ByEmQtSIx/hRrxBa2mqrzvR/mrOyj32OGBSozlnvUd6XbuG/vxm3q9MSPQNxJT6x2TzII9t
	yhJTPP745zqUo8gQvUd367MttlviCIz0=
X-Gm-Gg: Acq92OF0dSIJwNizBkk5Y5uV9xbmCU/ZlPbiSGXUWn21GYWUZ3UCW5DVCDq52N2/4T4
	mzdsuT1P+6jpN4xX18x/qiFQzYVXBUxk4qrTO4zfogXM5wz9RiCSfKI1EvSd7dILaDZNuKrsT7G
	AgcRKD+Sl+GhAM/bZqylLbuQYHyGSiP/SvV0hvPSG/g4ut+KoOJvkgYx3+dZQsd+5cC96as3jka
	mbWGq0fBRDQ/dT6iiXEKlRMKa1UheQA9OPm+X0X+QFenTBWLtzOxkXb1VJhTtX6FRu5RPOXH7Az
	jgzMGl78ARMkT6GDliPFBcUKwTzN+MOUNM9w/vLF4b38lIU7aLC+d5+dRmwkoDM=
X-Received: by 2002:a17:907:c06:b0:bd5:2ce2:8d0b with SMTP id
 a640c23a62f3a-bd52ce28d5amr332011466b.23.1778963979220; Sat, 16 May 2026
 13:39:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514200129.94862-1-amir73il@gmail.com> <20260515193010.056ef472@pumpkin>
 <CAOQ4uxjDeF3uDe=OTVZ3fK65dF148FRUvPx5fOqZpoFuGUsmJQ@mail.gmail.com>
 <20260516094242.77d20c92@pumpkin> <CAOQ4uxjX=C6WZvW1DdJ13tJj-XBWVxgE2Q9vVvHoYqiOhqW0wQ@mail.gmail.com>
 <20260516134219.30a30927@pumpkin>
In-Reply-To: <20260516134219.30a30927@pumpkin>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 16 May 2026 22:39:28 +0200
X-Gm-Features: AVHnY4JIVMPrcF1z1Raum5tdKskVMH3kvk4vrLEhP0KOwJSQHZRt97H60ncn43M
Message-ID: <CAOQ4uxh3ABUAN8Fwk02YAVtfsACEPgu3qX2LSBhhj-chGvi8tA@mail.gmail.com>
Subject: Re: [PATCH] err_ptr.h: introduce ERR_PTR_SAFE()
To: David Laight <david.laight.linux@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Nirmoy Das <nirmoyd@nvidia.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 16, 2026 at 2:42=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Sat, 16 May 2026 13:39:11 +0200
> Amir Goldstein <amir73il@gmail.com> wrote:
>
> > On Sat, May 16, 2026 at 10:42=E2=80=AFAM David Laight
> > <david.laight.linux@gmail.com> wrote:
> > >
> > > On Fri, 15 May 2026 21:26:04 +0200
> > > Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > > On Fri, May 15, 2026 at 8:30=E2=80=AFPM David Laight
> > > > <david.laight.linux@gmail.com> wrote:
> > > > >
> > > > > On Thu, 14 May 2026 22:01:29 +0200
> > > > > Amir Goldstein <amir73il@gmail.com> wrote:
> > > > >
> > > ...
> > > > >
> > > > > The object code bloat would be noticeable if this were used every=
where.
> > > > > But you could make it a bit simpler:
> > > > >         if (__builtin_constant_p(__e))
> > > > >                 BUILD_BUG_ON(__e && !IS_ERR_VALUE(__e));
> > > > >         else if WARN_ON(__e && !IS_ERR_VALUE(__e))
> > > > >                 __e =3D -MAX_ERRNO; // Or maybe -EINVAL to stop a=
nd other boundary errors
> > > > >         (void *)__e;
> > > >
> > > > Yeh that's nicer thanks.
> > >
> > > Actually this might be better still (or just more succinct):
> > >         void *__e =3D (void *)error;
> > >         BUILD_BUG_ON(!statically_true(IS_ERR_OR_NULL(__e));
> >
> > This condition is wrong but also my compiler does not evaluate
> > __builtin_constant_p(IS_ERR_OR_NULL(__e)) as true.
> >
> > This works
> > BUILD_BUG_ON(statically_true(!IS_ERR_VALUE(__e)));
>
> Yes, it is easy to get those wrong - especially when typing quickly.
>
> >
> > I think it is enough to statically assert on ERR_PTR(EINVAL)
> > and no need to bother with ERR_PTR(0)
>
> Then the tests don't match - which looks funny.
> IS_ERR_VALUE(val) should be: val +=3D 4095; jump_carry ...
> and IS_ERR_OR_NULL(val): val--; val +=3D 4096; jump_carry ...
> but I can't remember whether gcc manages to do that.
>
> >
> > >         if (WARN_ON(!IS_ERR_OR_NULL(__e))
> > >                 __e =3D (void *)-EINVAL;
> >
> > Oh, anything but EINVAL please - the most overloaded error value
> > My choice of meaningful error value would be EFAULT
> > because without the safe helper we would be returning an address
> > which is in most likelihood bad, so better be explicit about it.
>
> I'm not sure about EFAULT; it is only really used for user copy failures.
> IIRC at least one Unix (I've forgotten which) generates SIGSEGV when a
> system call return of EFAULT.
>
> There is also the 'problem' of PANIC_ON_WARN which is set by a lot
> of distributions.
> That (sort of) means than you might as well use BUG_ON() and get the
> associated slightly smaller code size.

Come on. For real?
I might as well use BUG_ON() which is strictly and rightfully
frowned upon instead of using WARN_ON() because some distros
choose to do PANIC_ON_WARN?
That logic is backwards.

> On x86-64 (and maybe a few others) both BUG_ON() and WARN_ON() just
> execute UD2 (an undefined instruction) and the trap handler finds the
> associated info and does the printk().
> That makes the code smaller than pr_warn().
> Someone needs to add a 'I_REALLY_MEAN_WARN_ON()' that never panics.
> (And maybe with an option to not dump all the stack.)
>

Well, the whole point is that I would want to get a stack dump
if my code was doing ERR_PTR(<positive_value>) because without
this stack dump it would have been really hard to understand
the conditions that caused the regression in the Link.

Thanks,
Amir.
