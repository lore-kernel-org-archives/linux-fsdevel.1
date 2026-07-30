Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12C542586F
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 12:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785413675; cv=pass; b=lvqvA5pk+Sp37216egnKsePLfDqNsyW7uGZXKZs97HZg8O5vBon3hC3CPQgIBkdVovXb7Vnl8p5RPPQEr0WADmowpwKRj62fROkQ/+NL6vdgPnqIS4rUVxFaoQLWT0yzYduFXMDpOdx/PqIguqXS4VI4cxO6wZCH9xeGMiAUG7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785413675; c=relaxed/simple;
	bh=sy83WF8tBDASPAVNijM5A8ViZA2FGZdaffH6yOfUtp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bLpuISjBTHTR+QS1L/Z7sv5+BqUpCulX0exJHaH1Eumcw0r0v6ZOHbd5eI7k2rkOUtw7H7mMUIN4a5MaeYICNrllsilGp+DnEWxx+F9RJblKcuBystmCyuzg2rzaLwkTuzgmAFXzmR0qMIKenZviEAxhPxAL7ZLtovEameLH9Oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=qIp4Fu0f; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="qIp4Fu0f"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-39c86ce9e29so17121581fa.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 05:14:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785413665; cv=none;
        d=google.com; s=arc-20260327;
        b=ck0gJpPaRXbhPg82KPxXUiKIo9M9cs/rMyD4JjaIngBrHLDmK4j926zGA929T/3nUW
         HuJks4MPqiTE1NFLStoQvY5yFDlngdgePYEKTdUPDEK66/0nFFHHJp5idtpmf4Kyu19i
         SfX3tMSVCa5dQjCE1jG4Jw93O5FxfOkaRwchsckcJrSmG/XKS9UmF0qj4Q9L8sUMuQH8
         30mw4ZiJFxCSHQYJQVfzFn4xLmGHeodpzburhXyo4QH9gJbXB9HtLLO36jUIoen9tZSS
         TowxoBJXaE+L9R8creBmta5YmYxck2IEimdTQqQufASfHqdCc5/6f7VmbDpZqINrYf4S
         yO9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wx+UNvwOJiLu/XduKc4iuhqajIkekuvthNe+BI1r1w0=;
        fh=i9hWDeLYrCpBwDe+PfFKdFdoqpigvMrIBK2gYRtZHuk=;
        b=SsQQqVYmH3Qyp0rmve8Io/fAzR/Yp+WReG8Oy+AzBRLBO33Ux7kulhGG+gdOIEDDCN
         UTxO0BTFpZmWFN1whOSWhWNA0mxxqOR/bqdlkhHW0nxjTrA7rtsziLejD54bdC2RWOC4
         tgAYOgf913t1qWWvTFNbE/Qw/TYKC7XbTYk4m6b4DDbXjCvClOxMzL6I+N9mPDvakI/J
         Z1DtPXyU+arGMH4ulSqsVK0hKLG+CUVJV2ksG6jqARzMOWtVi+lct18+uWhivqfoA1v/
         W5M/j0pQ4wFidU1shLWqkAuRoY9SS/jjFPg0bkPeCujNyQWUKo+4WholqCq4op4X9oYi
         latA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1785413665; x=1786018465; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wx+UNvwOJiLu/XduKc4iuhqajIkekuvthNe+BI1r1w0=;
        b=qIp4Fu0fGqO17LoKXt7AYUKcyBs+1fr1GDqkPQBJjLHxUYJ+nV8mMseQ2INed+yw2p
         kzLpuAf3w2PN0chpafhdhl0aO8N2qG1dhDnC2aT1Gzc+P429Qv6QqGHc/jKWQGP7mCAm
         aMio6AMrQTRVTayaqOy8p6tcE3J6ZQ/c+TY60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785413665; x=1786018465;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wx+UNvwOJiLu/XduKc4iuhqajIkekuvthNe+BI1r1w0=;
        b=Yv0Ljstbf81aKqluLz2y72uVWujuO56XlDHULM/EywDbybhkelbFSPzGeHA1IZLtog
         u+J4F91gqc4MNxi96QOs0D4NF8nUxYRjOglnNvxvzo6Z9tEKi8kTDdst2OseI6ua/5OJ
         dSYj0ni1cFyuhUiT7UE1w/AwMfn/pEeGfKzOvfie21hzIVhh0xGBwRiWa8rnnRW608kN
         zacwKM9beAdmibVHpxyBU0oGQ3+F1PGz2DrvqbhQBjlSqhtyVjSHYpupRMFFyh3UXXmC
         NbHjY3j75m8veA21WLyiw4pxSPvFnaqhsbhHVRwa8ttsw1R80w5LucC70dfhbRT1yGOZ
         whcQ==
X-Forwarded-Encrypted: i=1; AHgh+RpS4XmCX9275UzoCFaGl57cCCWDs8DRp0PT5F/9QoLjjgiE01kBWELwplP50TFGkrkdQcZJb9vBA96jtsvh@vger.kernel.org
X-Gm-Message-State: AOJu0YwP4Szp1gK4sYHhbWOw907Zl59y7hMhfZvbIzae0E5UZTWeTSTG
	i7Im5FUKgkOR8MqX1j5y5Y5istdPdCUuxpGnOhIwVOqmQnXyLQuDDCgM5+0Hqpbt93pzw1XLBTH
	uDphC42GUXtbGYnTI80NqQnBKtrU+5J3fJ0cKw8AwiUTH0h5j/XZH5fBEJaA/
X-Gm-Gg: AR+sD12cvk0bsQJqN8ISEdZhUAbDSIOb8izQL+2ReJ1929E+i+7LvQT6SepsuGxHtEA
	EnuwTtcf6zjJGqtJf29q2diOjt+RMBc9gxOFi6XxSVlRq3BYV9YEgLnQbYH3MMaZMNXj1g0KNqs
	BpM+6GRfZdutGUsihWw1z0wHn0mOKbvf43fnOAf9HCr218CqiDA/S5Z8ahHHN625KUXT3Cxuj0A
	WZ3BSEp5w1BQnagOZyTIWVzSt4xI0QBAykb6hJRPIYV7gD/L5CwxIKfGChljOYjh9WNcA5fk+4q
	2FCHVe+CPiqyPNslTyoHszFyC6PKHxcNhB7V2zSUE6SCqhityUCOaOtWDLwleVDEv1W9fsDSZHf
	j
X-Received: by 2002:a2e:ad12:0:b0:39c:7ae9:daa4 with SMTP id
 38308e7fff4ca-39f6b7f6069mr4269071fa.6.1785413664890; Thu, 30 Jul 2026
 05:14:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACwKKmANzQaVSLni4QkvfoL6Axd3_3mYvCrsWRazXg0QeO6y3w@mail.gmail.com>
 <dtryuddxj63ibzfzmktla4ypj7vnxj5gia66joet3lp6zgzpot@btjuuubvckv3>
 <CACwKKmB_wwUoW9g_hgqESwKeEuM2k4MiAUn+6Nu=zpyE1VgmYg@mail.gmail.com> <o3y7rskcnpaalaut2qro5ntewog64jdtzrxjw5q7lhg52rlo24@rxogt3dmzx6f>
In-Reply-To: <o3y7rskcnpaalaut2qro5ntewog64jdtzrxjw5q7lhg52rlo24@rxogt3dmzx6f>
From: =?UTF-8?B?wq3qtozsmIHsnqwgLyDtlZnsg50gLyDsoITquLDCt+ygleuztOqzte2Vmeu2gA==?= <yjkwon0026@snu.ac.kr>
Date: Thu, 30 Jul 2026 21:14:13 +0900
X-Gm-Features: AUfX_mwLxmYYfVA0LuBWkbbA2YsIbO3LndSAwn71BbhW_kpCXQDQIVSuMZ78iao
Message-ID: <CACwKKmA+2CH6xKaULmgR4Jbo7oE41q6VzBgA-L3XnAsUVxXszg@mail.gmail.com>
Subject: Re: [BUG] fsnotify: concurrent mark updates can publish a stale
 aggregate mask and lose events
To: Jan Kara <jack@suse.cz>
Cc: amir73il@gmail.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Honza,

Thanks for clarifying -- I'll write the patch and send it. The "happy to
test" line was only in case you had already started on one.

I'll go with the simple approach: call fsnotify_recalc_mask()
unconditionally whenever mark->mask changes, and describe the reproducer
in the commit message.

Thanks,
Youngjae Kwon

2026=EB=85=84 7=EC=9B=94 30=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 7:50, J=
an Kara <jack@suse.cz>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hello!
>
> On Thu 30-07-26 00:39:49, =EA=B6=8C=EC=98=81=EC=9E=AC / =ED=95=99=EC=83=
=9D / =EC=A0=84=EA=B8=B0=C2=B7=EC=A0=95=EB=B3=B4=EA=B3=B5=ED=95=99=EB=B6=80=
 wrote:
> > This did not come from a real application. It started as an LLM-assiste=
d
> > source review, but I only reported it after reproducing the lost
> > FAN_MODIFY/IN_MODIFY events on an unmodified v6.12.95 kernel.
>
> OK, thanks for confirmation!
>
> > The fix you describe makes sense to me. Happy to test any patch
> > against my reproducer.
>
> Since you wrote: "If either direction looks reasonable, I can prepare a
> cleaned-up patch and a regression test for review." my understanding was
> you want to write the fix yourself to get the full credit for you work
> (which is fair). If not, just let me know I'll write the fix myself.
>
>                                                                 Honza
>
> > 2026=EB=85=84 7=EC=9B=94 29=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 9:4=
0, Jan Kara <jack@suse.cz>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> > >
> > > Hi!
> > >
> > > On Tue 28-07-26 14:32:33, =EA=B6=8C=EC=98=81=EC=9E=AC / =ED=95=99=EC=
=83=9D / =EC=A0=84=EA=B8=B0=C2=B7=EC=A0=95=EB=B3=B4=EA=B3=B5=ED=95=99=EB=B6=
=80 wrote:
> > > > Concurrent updates to marks from different groups on the same inode=
 can
> > > > leave the object's cached aggregate mask missing an event bit that =
is
> > > > still present in a live mark. An operation started after both mark-=
update
> > > > syscalls have returned can then be filtered by fsnotify_object_watc=
hed(),
> > > > so the matching fanotify or inotify notification is not delivered.
> > > >
> > > > I forced this source interleaving with diagnostic scheduling barrie=
rs and
> > > > reproduced persistent FAN_MODIFY and IN_MODIFY loss in 3/3 independ=
ent
> > > > boots for each interface. A control update that caused a fresh aggr=
egate
> > > > scan restored delivery. I also observed the same loss-and-repair ou=
tcome
> > > > without kernel instrumentation on an unmodified v6.12.95 kernel ima=
ge in
> > > > 3/3 independent boots, with 9 strict hits in 30,000 attempts. I hav=
e not
> > > > identified a memory-safety issue or a security-boundary crossing; I=
 am
> > > > reporting this as a notification correctness bug.
> > >
> > > Thanks for the report. To clarify is this a result of a code review
> > > (personal or by LLM) or some real application was hitting the problem=
?
> > >
> > > Also for the next time I'd like to ask you to try to keep your report=
 a bit
> > > more condensed (either by instructing LLM or by selecting the substan=
tial
> > > content from LLM output). E.g. in this case the above two paragraphs
> > > explain substance of the problem and reproducibility, the scheme in "=
The
> > > race" section shows how the problem happens and the rest is mostly ju=
st
> > > uninteresting noise so this report could have been less than two scre=
ens
> > > worth of text whereas now it is over 7 screens in my terminal.
> > >
> > > Now to the problem:
> > >
> > > > The race
> > > > =3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > > Let P and E be marks from different groups on one inode. P initiall=
y
> > > > supplies event bit X to the cached aggregate, while E does not cont=
ain X.
> > > >
> > > >   P update/removal                 E update/add
> > > >   ----------------                ---------------------------------
> > > >   remove X from P
> > > >   start connector recalculation
> > > >   scan E without X
> > > >                                   add X to E
> > > >                                   observe old aggregate containing =
X
> > > >                                   decide recalculation is redundant
> > > >   publish the older scan without X
> > > >   both syscalls return
> > > >
> > > > The add-side decisions are not serialized with connector->lock:
> > > >
> > > >   fanotify_mark_add_to_mask():
> > > >
> > > >     recalc =3D fsnotify_calc_mask(fsn_mark) &
> > > >              ~fsnotify_conn_mask(fsn_mark->connector);
> > > >
> > > >   inotify_update_existing_watch():
> > > >
> > > >     dropped =3D old_mask & ~new_mask;
> > > >     do_inode =3D new_mask & ~READ_ONCE(inode->i_fsnotify_mask);
> > > >     if (dropped || do_inode)
> > > >             fsnotify_recalc_mask(...);
> > > >
> > > > __fsnotify_recalc_mask() scans under connector->lock and later publ=
ishes
> > > > the sampled union with WRITE_ONCE(). A different mark can be mutate=
d after
> > > > it has been sampled. Its add-side redundancy check can still observ=
e the
> > > > old aggregate, which the in-flight scan then overwrites.
> > > >
> > > > After this ordering, E contains X but the aggregate does not. The s=
tate
> > > > persists until another operation causes a full recalculation.
> > >
> > > Yeah, right. So for simplicity I'd just solve this by always calling
> > > fsnotify_recalc_mask() whenever mark->mask is changed. We *could* kee=
p the
> > > current behavior by providing new mark->mask to fsnotify_recalc_mask(=
) when
> > > adding events and then doing the check under conn->lock or even impro=
ve on
> > > it and completely avoid scanning the whole conn->list and just add th=
e new
> > > mask to the current connector mask. But at this point I think it is a
> > > premature optimization - we don't expect many notification groups to =
be
> > > watching the same inode and frequently adding marks to it. So let's k=
eep
> > > things simple for now.
> > >
> > >                                                                 Honza
> > > --
> > > Jan Kara <jack@suse.com>
> > > SUSE Labs, CR
> > >
> > >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
>
>
