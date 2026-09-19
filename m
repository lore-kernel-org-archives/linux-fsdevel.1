Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1A333F8BC
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 15:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789831744; cv=pass; b=qbr1IACbCXgbglOBfC/z3xlv/DOLmDr7de1TNCh5kqKdjeA/pU4uhyk/AZ7CO0vPT4fcLmpfdTC0l124GvkDut3s98GFZIjX/YQ6D6DzcqPVqWmY3taTGfNp/uXV6rMwWpCADK8RqzB2naaWBEYJ/YOcZGu2aSAVqLvo7N3Hi5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789831744; c=relaxed/simple;
	bh=jOLtCA5xBCMN+IeZjOlru0hQ1zFhY1Y2MZjJga/2kjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pD1B/H/faSVwosOY4FiWQqS+qdxsefrbndjI1PSBoHu4nR0SAGb9g+zp4ryUCfwy2XU2IFMTT/ucN32zF3aHtovONeFbUR2Xoz+Us+5z5jUFIezlqvFvMN8QLbTrvQlaI/aB6Aci4sSoLbMhHiuw1SXn2qadw/pzDJsnKQIEOjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thechris.in; spf=pass smtp.mailfrom=thechris.in; dkim=pass (2048-bit key) header.d=thechris.in header.i=@thechris.in header.b=llYmP40x; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thechris.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thechris.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thechris.in header.i=@thechris.in header.b="llYmP40x"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4ab201f9so1446854d50.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 08:29:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789831742; cv=none;
        d=google.com; s=arc-20260327;
        b=Ty9Rfu3pCeGL45z2fSwk4FsJC01L/LSvSgKCX5UPPOvaty3BfOd3I5wpGYx/YXy9eK
         30UfDtoRzqoPdecQZaMLdRpR2gjW/ePUHNDqhqX/n1L6Y9QrSZ639mtUYzUwUNF1leeZ
         bKtNub2wbECZj7qbN23qoStdKOHCMejRixSBHfpv/mvNv0nhX/r3V4jKRmR75dt6qOSA
         SwaqRMYOekPBGBB8tWDSqlOaiiGJPUqaUSJQ3D+idlV2YV1H6VIdUusobqjvNV1g/hdb
         0k032hos8zPCeJ4xJJifnUIf3niOyChEMuVDDd+M/K47sP+gLkzK7seu/yFOGLSuRG9b
         NySA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l0TpZBfQv1YVfjKqwYzlR7A5wrn37+yIqc+S/AtQHiQ=;
        fh=HJU6DqwDh3EAS4YJ6Aozov3NDPMnDIHNzt1TSRfrtFk=;
        b=aYsldKnbGkp2VTVDymGJHjOS2D6kyeJiG2+bs2ltiLKQHf6aOjkEXidBSEiJnaO1wA
         iFcF+cpaS+BFYNuMmXjTbi0qY31ZKaASPVkrbfgJ9e2vst4j5QANoXJd2hi/QamsPvcR
         qi03VdYras9CHn9QktME54uyI6KeKbPMvb03ysWpOuilOz+BAFAxGuPQ9d7qNQOsmWvA
         6L4Yg1pFnxua8uhCdSRcvUjKSoRcLgTWwwO67QJ602D/nVrXPlWs4mEj4ohqIsaUL6CO
         YfZhUq9w6EpKtwYjWHik65/Q39cFk10zsoZ8yOIr1tNt6G/WkEl/VldTvsUTCFB7c8hO
         /xCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thechris.in; s=google; t=1789831742; x=1790436542; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l0TpZBfQv1YVfjKqwYzlR7A5wrn37+yIqc+S/AtQHiQ=;
        b=llYmP40xKNZ20aSxEgnhNtwj1+wy3vaq5lPD2Tt/ZyII/AvdiIJwc/JGC9RkG3JXTm
         4mA4yToVzsQ1wmc5igc5U1i2AKJosL9Cb4+qKNnv6X5MidIgMMgdZ+OQVrvA/dgHqzY1
         ctRXPjxtO+QLd4Y1+W86ql5qlEUHcuxC67F529VvweGnpwpQ6zeosnLXTRsZaeoll+tZ
         qppfVA2mnFiptpFqROVI6ON/upCOT8wOIwLrwKjTzoJ1foSda+InGQl+MmqTjkxOgZCi
         yyrecMNsEAh7qnesnNb2McSeBKzb6y3T3gY2712X3tJ4553gPwMcsOjhupIopI2Qu1XC
         5T2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789831742; x=1790436542;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l0TpZBfQv1YVfjKqwYzlR7A5wrn37+yIqc+S/AtQHiQ=;
        b=PcL1yu55VtQWq7S19hWKKn7pAdGU6DHJm6822y6BlnTZonuOSpjo521WnHrJeRfbLK
         QW4zJNacESTsYaFzrVrnHrV2oSJADOOwPxi/Yj64dwhnygVw98w/25XoP73/HaCkYcJQ
         mcEWkUhxg7rBrxJUOCLzp36gVRyf95ctrx4+iJWugIHsQ9Q0d9jjV0zqrEdda4uDarDu
         rl1SRvENsd4sLRq4wFBBBX+42wBHrg+1K1xCHSiyXb9h+qbPeGbB2PkFCOG0e70bZqMe
         Foa0fHk4o89ZcOuARhpjcihVf1t9MDfquHrhyBvjDLmA5KmOOtL3Q1b2zIhAEszPAjbV
         wYfQ==
X-Forwarded-Encrypted: i=1; AKwUvBx/pNY/wQvDVaVFa2hE/rhs0UZJUmXmJ6GOeh9CXZas8ii1HFbNEa2wbHBrIGW/1TKxVx8D8Af/KvxkqWyJ@vger.kernel.org
X-Gm-Message-State: AFuF++ntTbgqa3RP6xAoCL/o6fjTkWswK/66pa4nbr+/0KhgfCMhS68m
	5XrSa/sMdru9t+/oolULtHEoCOAHVsjBa3l4RiD0M9KoseUtGsI2DFUyl6UxvRYt7kfddrjAZAP
	c2pLjfURRKb0PyHTqZqaOiBuX0ulU/fs8i8THwTSVaUw9Fmhhw6PtG7qEy4zgSg==
X-Gm-Gg: AYBFou2LMug66Bnyj+koxghsL0lQAGR71DCVEtxaqPp7WaGOOFr9xfZP6yT9+RJmhf0
	RaphHcEv7VLtVQ5hhv2scegJpx9RbkC+HglTZ31tc0AQmH4eEuUJi8AnxoiM2rf+y/fassTH0tq
	rv3YbTrTMIB3aS+GVBOXKiF76bAP/eq8VKnqfY6mUatd8Il7hQW1n/2ESiuPhSRHmtAuPzZAmup
	8sBAMtseMGHTmZ7nMGElJ28lIpGNCbUgEKC75neM0FNWSaKGxHnE/WK4Xkl6u2VV4vnFc5Yhu3Y
	Ra+rVJ7YFGMjR+KMl178WzjA3c/VFk+YR6XTLUGHJimov1z9jIJtxhISUYwnC1sHhmbaHp4fT1T
	snzw6+4MOaVX8CdO93t3x9bGNNvoqe8sdsdmGL9QiubVyWEkaxNpuyJZiwyS/05j5NJ1dA/EBtx
	Uya48ETWkGMUKfX2w=
X-Received: by 2002:a05:690e:4511:20b0:672:99e1:11e8 with SMTP id
 956f58d0204a3-67299e11752mr455363d50.133.1789831742087; Sat, 19 Sep 2026
 08:29:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE2Bdm3NuEHshrG6K2boKAnCQUvT5SX79cP9nPgS2s1afzY1hg@mail.gmail.com>
 <6aab0f82.e91c2013.3bdb06.0009.GAE@google.com> <CAE2Bdm2wzxj-J0TM8F+3SVnu0W3HeiROW97U4qvBeyHKdHJFmg@mail.gmail.com>
 <2026091753-broadness-bootie-b683@gregkh> <CAE2Bdm14hif17B8RTAE+PhWEps5Fzh=WPurZeSNp9C6TqCKumg@mail.gmail.com>
 <aqwuWWMwdIcx3704@cashel.logfs.org> <mu82xsi6.76ee613a-07fb-48b1-9336-99e8780e8b6e@nod.at>
 <CAE2Bdm3FqBPAMxqKoz_h1cw+OXpm=LJHdJjsME_Jy966tqhq_A@mail.gmail.com> <aq6gJTYTpTr8sYPj@cashel.logfs.org>
In-Reply-To: <aq6gJTYTpTr8sYPj@cashel.logfs.org>
From: Chris Roy <iam@thechris.in>
Date: Sat, 19 Sep 2026 20:58:51 +0530
X-Gm-Features: AcwNN1WmuQ-yAJK_L0Mqu0n7bynCj_HJ7gLPmHLdxL6kt8_egR93r-O600_Qqss
Message-ID: <CAE2Bdm3K+ZnrfB7xzkg=2fzMs7AmJzdF3aYCpN00h90TR6FMog@mail.gmail.com>
Subject: Re: [syzbot] [fs?] possible deadlock in ovl_create_object (2)
To: =?UTF-8?Q?J=C3=B6rn_Engel?= <joern@barelysecure.org>
Cc: Richard Weinberger <richard@nod.at>, Greg KH <gregkh@linuxfoundation.org>, 
	syzbot <syzbot+7cab6a19619f1b8efc00@syzkaller.appspotmail.com>, dakr@kernel.org, 
	driver-core@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com, linux-mtd@lists.infradead.org, 
	miquel.raynal@bootlin.com, vigneshr@ti.com, 
	Adarsh Das <adarshdas950@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2026, J=C3=B6rn Engel wrote:
> Finding good names is probably a fetish of mine, so "val" is mildly
> disturbing to me. [...]

I have a similar pet peeve in my domain. I kept "val" since
it mirrors block2mtd_setup2()'s own "val" parameter
(the raw <dev>[,[<erasesize>][,<label>]]), so I kept it for
consistency with the existing call chain. I had considered
"spec" but probably it would have been similarly unimaginative.

> Is this check necessary? [...] Looks like the kernel is still
> undecided whether checks are necessary or not.

I will keep it. kzalloc()/kstrdup() under plain GFP_KERNEL can still
return NULL under real memory pressure (no __GFP_NOFAIL here), and
dropping it would be inconsistent with the kstrdup() check two lines
below.

> That's quite a few calls to the same function. [...] If you feel
> motivated to dig deeper, please do! If not, I'd rather leave the
> mess in place than come up with a half-hearted attempt of a
> solution.

True. It is accretion. I'd rather not bolt a redesign onto this fix.
However, I can look at setup2()'s callers as a separate effort.

Regards,
- Chris

"But how could you live and have no story to tell?"

On Sat, 19 Sept 2026 at 20:16, J=C3=B6rn Engel <joern@barelysecure.org> wro=
te:
>
> On Sat, Sep 19, 2026 at 02:22:15PM +0530, Chris Roy wrote:
> >
> > +struct block2mtd_setup_work {
> > +     struct work_struct work;
> > +     struct completion done;
> > +     char *val;
> > +     int ret;
> > +};
>
> Finding good names is probably a fetish of mine, so "val" is mildly
> disturbing to me.  It's not an objectively bad name, just something
> where I'd spend another five minutes trying to come up with something
> better.
>
> > +/* Runs block2mtd_setup2() on setup_wq, blocking until it completes */
> > +static int block2mtd_setup_defer(const char *val)
> > +{
> > +     struct block2mtd_setup_work *w;
> > +     int ret;
> > +
> > +     w =3D kzalloc(sizeof(*w), GFP_KERNEL);
> > +     if (!w)
> > +             return -ENOMEM;
>
> Is this check necessary?  I'm in the camp of "malloc should never return
> NULL".  That condition is so rare that it is effectively impossible to
> trust callers with error handling.  So the right approach is to crash
> (or kernel panic here) instead of returning an error.
>
> Looking into sources I see this:
> static inline void *kzalloc(size_t s, gfp_t gfp)
> > {
> >       void *p =3D kmalloc(s, gfp);
> >
> >       memset(p, 0, s);
> >       return p;
> > }
>
> We have at least one example of explicitly not checking the return
> value.  But we have other prominent examples of checking as well.  Looks
> like the kernel is still undecided whether checks are necessary or not.
>
> > -     return block2mtd_setup2(val);
> ...
> > -             return block2mtd_setup2(val);
> ...
> > +             ret =3D block2mtd_setup2(val);
> ...
> >               ret =3D block2mtd_setup2(block2mtd_paramline);
>
> That's quite a few calls to the same function.  If setup gets that
> complicated, that's a strong indication that we're doing things wrong.
> Typically we get into such a mess one well-intentioned change at a time.
> Find a bug, fix it by adding another caller, repeat.
>
> It isn't obvious how we could improve things.  Sometimes it's lack of
> infrastructure and the entire complicated setup-dance should be moved to
> common code.  Driver can then call a single function to deal with
> everything.
>
> But if there's only a single driver using such infrastructure, maybe the
> driver is doing things wrong and should copy whatever other drivers are
> doing.  The problem shouldn't be unique to a single driver, so we should
> find the best solution and then use it everywhere.
>
> I don't know the correct answer here.  If you feel motivated to dig
> deeper, please do!  If not, I'd rather leave the mess in place than come
> up with a half-hearted attempt of a solution.
>
> J=C3=B6rn
>
> --
> You cannot suppose that Moliere ever troubled himself to be original in t=
he
> matter of ideas. You cannot suppose that the stories he tells in his play=
s
> have never been told before. They were culled, as you very well know.
> -- Andre-Louis Moreau in Scarabouche
