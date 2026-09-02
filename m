Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992C14AA039
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 17:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788368918; cv=pass; b=Lg5S4R748yxvJm8lT7ZGJzyx551UVhe06oEtYEVJ0+h0dnX5BkFR37Rl5sE8SvkDBwtA1HUixbhQPkiikYx65TOXImpVmIo6KtJ8fc98n6aoQcOtl4KPTt989bidc4tG5avyvqQlUkylHgDYQkMk8ZcYFZ4sDfk1bRp/+Q7aXMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788368918; c=relaxed/simple;
	bh=QG1zjpJfnhWFEvPDt5X/M/5gI6ZKh6bIpAbhyhDnR38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B+mv++XJ7V2y8iMjsh3eyoqJnwxeIlQJs0CNdJiUY1lBxHND+/Ev9UyQcCVRb0oYWLQNey1kF3Co5j3jaLZCkVWffxTALrJ/qRWLdwh2/8qNTGQVRB7OjYiHbPrmqk6rT8B12QyGjqBn3bVxsaRv60y2CydeHbCFamBizqJGtx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ny5VfGDq; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ny5VfGDq"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a5e329c0f2so1776271a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Sep 2026 10:08:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788368915; cv=none;
        d=google.com; s=arc-20260327;
        b=PET4d0ix/qGNKsfKXKkM/rhsnewh2ybWXVuH0qDk09eMF0I0QAELcwvkLDgC/SuJQ3
         DWtGyTW1XvCxbyR1QNVcjiJ8lYkQM9HeI0e+fljgEl+WYjCJJgc+m3Io1wwJitZHaFFX
         MMw2sHdIJePJiJf/2mbnPrZGR+v927ZQF7BzuOTzQVEMbJct/UqCiVamXaM+ylkUhIBl
         AGwHH6uwsTJGdnRS5r3R5sFAMUUASCT0PONxhgIFalOmpVkwX6AlnAWckBjS+LNHtWoC
         K6eIpMYMf3oIUrZiz7WplPkOAXfvVO6/ZpnNzFD9it2bemV/RZdf2EVn4E6JCW6s3fgS
         ICkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pmtfEAR2Y5+urGpoDjih/WPk1lE/DVfGd0l5q6mP2NY=;
        fh=zTI+w1J5SdUy3Nx0S9gM6ehPybueL0OUVgsy0XNq44Y=;
        b=clIZcRc6OR9e3Krm0fiRGq3vtg5ErlHVyUpM010abDWog2UEJYOovPst6lEO6KvyFa
         M7bxER/+vQw6/ZQUrxRlbXa244Qb2xMLQY4SGV41Xlo3qdlotyAe3wGMxfldScIXTBEX
         p9/xWjCIxyFir9ZB8lZEWmDAAIT8chUp9wKAhdDG8XtsaYtSoPm0E1m701JgKccHkFmc
         uVfOCLZYKH1zlvGmKIZQ0R1LXydXbV6GPNeEzqUoiPlzfywPdODreEworpOqdV1Uv3ZD
         nqB0cO2Yn06OkVyXwXOOnRzBfxt2o2y7iZUIr3dHhJy0djN0WS3dqNBWT/8L9OEbOnEf
         p3Tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788368915; x=1788973715; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pmtfEAR2Y5+urGpoDjih/WPk1lE/DVfGd0l5q6mP2NY=;
        b=Ny5VfGDqBvl9g555impHScDfYeJl6q6z+FpmGwGnOZKycYBB/t2MaS4q5w5Ihip6/z
         Wn3EH65g20PwA6opZdNmqAoVDyvuqRgWCQ7NHqv7E17sTC29vDmVDEqwNVbUfsXlctb8
         BDI2QrOUZF7Qr97eOJHl31bf8T9YSF2EUhE8i2bPCizPEWb+wlzuVf/THxYI7iZeng8L
         bkQ3XTHlBrwuItiv4saFIH2kPHJo37jOODEoXoFZh5bJHeU64d1i80kcBcuRlP6wlzdL
         NRNHcxo95EBlH7kgs1PZA5pNYvDAi/Hlx5/j6PvCubq4xmTl2MXeYjXYIfVC15gnAurj
         Sh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788368915; x=1788973715;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pmtfEAR2Y5+urGpoDjih/WPk1lE/DVfGd0l5q6mP2NY=;
        b=tCUET3dZYW5tmN10tXO8l4pOxt/T1x/LIe3nunQTpSkbZi7ovQBdehk+gKGdOMqAtO
         dKHA88M95gMvo/55txPCgcYZEYPDNYQd7wODOgkzfERkDKtpIyibbb7Akt8mKPGjRdSj
         cdns7YxDC+69QrL948suRVr5EmxugH1wqgla/qeoOzENnpZIbyL7rVGfGCFTICGQUf1p
         w64pWL2jzx0w7OHsi3ChVWoFPpcqUjuf5aG85SldvWnsio4noC+cPF2lOxRQiut24jK2
         lDe38TlllOhO5Ba58n0UtMtLYEig0ngoxyF1RFKF/X46qQdnlXLAdLZ+faVyeqMManrz
         I+Aw==
X-Forwarded-Encrypted: i=1; AKwUvByuITiCFAyJj/qNe9rec+e9BrjV4KYQ+gQcekQO+BZcPP1vxCgGuHv/CH9dXxeLY+jxc5WVfLwxeaflhv5u@vger.kernel.org
X-Gm-Message-State: AFuF++l69KuFH9d0XU2ctxjd6gqk3htWbooxmBF03cUd5vwm5FDbiNVs
	TIiHNDP7oEsFMSQMEjbCVo4SyRCsuU7KGVcqsokLqtDea2XFwgYIwyYC5W3yJKxPJ4VLiYjpTet
	0BO+seVV3JXnSdLy83X5PU762KPdLPTg=
X-Gm-Gg: AYBFou1f9rLAILbFC/Sjf9mB+ReAv2mufYzgUpigGE1Upnwqn3/dWIqH3MGgVI0ZEzC
	kjz09xHt+NpBzlg39YFWROEsr03nHb/4J9dlA3ggHeFG6OKCqR/6jpkoA+BNCAzVIMXus4R4DVJ
	bJVpX2N3FtvjIyC+poYrAe9BuqcMAsILxIjcauXLVJIi4LCr5qLyFQV48FRWHYfoK2fPwcf/MMc
	CTRTLe6c1wr+7mvQ0SN8zltbU0tDqGIvXNU5aoLwX82HipI8o++v/bDo46EEnawt+xeC3cECl3d
	VvbHfg1tNdUEebuvb2NkhXtdF8LivR/ZMmRbivBPRVNnSg==
X-Received: by 2002:a05:6402:a203:20b0:6a6:8dd5:ef33 with SMTP id
 4fb4d7f45d1cf-6a68dd5f003mr1625715a12.20.1788368914490; Wed, 02 Sep 2026
 10:08:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <yjfqzckumtd32dgqidi5sndvth2t67mjwah4kt4jiahlx2a5uf@if55sinfv5o7>
 <20260828042421.964822-1-4ncienth@gmail.com> <ptco7s5x7tjzp42dzlsitibdigpwucl2whwrq37tknjpo7x2lc@b7q27ldlorak>
 <CAOQ4uxgB9anyJcWem04w65VCJdxbbb2cQDZ_u8qMusw3xpB9Gw@mail.gmail.com>
 <63aj7jbfaoamdmcurlge2c2kqpliaifgq4vbythrrxpfyr5vtm@z64myom426zd>
 <CAOQ4uxh-NZ76hEFoNNGjyhodr9U=dvZuGVmYHVPGZ_=jRxCAsA@mail.gmail.com>
 <67hq7zqnvp6onwwjp24axucgxbzsko2dphielupdfzmfyk6x57@bdeef7fjkqfa>
 <CAOQ4uxiQF4M_YSBMW3h8VCKR15GV6g_K5nf=2odtYetEwKHm9A@mail.gmail.com>
 <6n6r5zvcu5ojihyb52rhejlky7xrn2a2p4l2cgfut5lsscunek@bcnpy7bifjrs>
 <CAOQ4uxjbEY12XMmfCXTPTpASmECCXcGBQR+bS93k=4vgqzFDZA@mail.gmail.com> <3ds635aoslm67h5exattggmcmitru3owqrryexdq6ue5nubh4j@cmbhmsq6xdgr>
In-Reply-To: <3ds635aoslm67h5exattggmcmitru3owqrryexdq6ue5nubh4j@cmbhmsq6xdgr>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 2 Sep 2026 19:08:22 +0200
X-Gm-Features: AcwNN1UUgRWjh1gt6kF5dNLawq-DAT70hONdPtxUPiFx1STkZP2ICll21p7kdxw
Message-ID: <CAOQ4uxj4sYikVUEhV1pdUdzoq2U4pBa6RheZa7a0WanBmXkEow@mail.gmail.com>
Subject: Re: [BUG] fanotify: destroy/add race leaves a mark on a detached connector
To: Jan Kara <jack@suse.cz>
Cc: Daehyeon Ko <4ncienth@gmail.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 6:52=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 01-09-26 23:53:48, Amir Goldstein wrote:
> > On Tue, Sep 1, 2026 at 6:57=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > > +       }
> > > >         res =3D __d_find_any_alias(inode); /* recheck under lock */
> > > >         if (likely(!res)) { /* still no alias, attach a disconnecte=
d dentry */
> > > >                 unsigned add_flags =3D d_flags_for_inode(inode);
> > >
> > > Thanks for looking into this!
> > >
> >
> > See attached patch (again helper named debatable).
>
> Thanks for the patch! I have somewhat massaged the changelog and names an=
d

FYIW, I like your simplifications
and changelog definitely needed a touch up.

> sent it for inclusion to Christian. Since this is messing with dcache cod=
e,
> it should better go through his tree (plus I want to give him a chance to
> stop this somewhat hacky workaround ;)).

We'll see...

Thanks,
Amir.
