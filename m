Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BD43CF204
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 22:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783032096; cv=pass; b=hiEArwR1NNmpvhiNEs+nPSVZ0Ec/THy1NqyP0olok6Udfmq4DTLEb6+vgHQHRekRaXNq5KvlnykohxDP14WMFiNIw6o5NO/8E/HRgszU9H9QmKnTDz0eOtI1BB5Y5+59YHSvZGK2UTWJ0vfM6Y2WySSNEzU7/y9IjORA3dLqOD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783032096; c=relaxed/simple;
	bh=WIAOw+mwvcTYeXCgk6/3W7/rb4zmiahpFKaV0/jt0YU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qYoZKknmuusXfwpuSKkULxkq8fTtEBslkaQ35pQbqvrIEnMs1QCkZstXmQUQpIzV38w9cYXCR0OXWgdSfLOtHvoQMJyPhcbqZr2pxfhQSTHWoKZLhAc9pM6KV4h6+wZY4NeCqb4vEIKGe0bLPdv6GQjC8a21WAqEwupMK/eAxbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqosHtCU; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqosHtCU"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493c59f740cso7858965e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2026 15:41:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783032088; cv=none;
        d=google.com; s=arc-20260327;
        b=XeRBVfYuqFeYzToBtpe+B9h6A3jeXqfUX/pUIT8mxXuOnwWcIuZoKs4BPOxUTUwl+Z
         9Zu6Phb6Hx65/uhGUuEhRFg5kUomAS/0LgsjX+VtaXiVB0+6oalgZVYweM94c/8b0cDo
         a2fOFQwMRCKZxzQyPWm3D4Wxprmi95S95jErtVmTbXyyloKkIpNrlzGJVg9VXII12Bgd
         ab04JkKrX8ZefaObb8yK9KhHDSnBUHzXb5SGXk6Cl7FfjGbZCqoVoa27XGPKgyrE78hm
         1bWj8CwDUnwCYdKFvFWCZ5eXx3LNydKiFQ7IWVXJEaJFh9WnqEGOoIBoxQVEtMDPlbJg
         +MHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h9a02slDLUgWwDo+yKrdEPAIuAXAqNrHLiCEZt+6Lmg=;
        fh=V5GhOrph1dzM7DEAbz9IKqQ3IOeklYhlQArQBgBPxi8=;
        b=NgtWVHqb4g1d5yi7DtWcWSPdGM7B+q5opCsfOivQ7lP5pEM++2+RxPdl+zdPQj+e+G
         /0azw+chOAFscoxXi8J9m2l9Hj1gcbWZbqIPdft6EvEfhXQUOPJyuG1CeiOo5SoikMdK
         Osi/1sDxO9Rf8Q/PZid9PBMF0fzyRnv9wckwE0bZakuqYeRGpzMFxUdX8IiSNeMBm4en
         N69jbMTieiyXxwtnec5xsFSiPlRBkV7oeVX+5a1Rkvqkn1byCsQtGDrGQ3wuTwmjFUqN
         9lLriclxItHuddam7sMsM6fp0UZO0aOSaNDE+coagcUt/2BoVsWC7PRA//3KETQzU5Pg
         Jazw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783032088; x=1783636888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9a02slDLUgWwDo+yKrdEPAIuAXAqNrHLiCEZt+6Lmg=;
        b=YqosHtCUXNzXfWUzNNlHrQf51o9AW413o3K7p4zaIw34/4ZuK2aEFAhm1/IVmUGR0Z
         8e3t/5uSeJwHAflA9cHsPJqYd4AuE7d94ljSpndkHSd5GoC/dfHFK7BU8yc4X0EEIMGm
         0MHnIVPrtn9AhoyBsKW1mkeE7m2HAijVu9AVyRIi7Aia++iHmJqev4LWKfdgD/tYfuhf
         WMvTxzqWF28Ptc8QQN2gHd0hscbIpy0/lXSjXacD8jKKViyVnN/H5TA39jCmaWVOi6zg
         diot39qwe8DwfIYsLTFdP4wGRIOEijiVNQnp0BCrN9MBYUkyK7Niv3HsTdqJVC0cN/CN
         Gvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783032088; x=1783636888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h9a02slDLUgWwDo+yKrdEPAIuAXAqNrHLiCEZt+6Lmg=;
        b=nqTUKQjdmVBWGvcoITlOkRwu0w6rPK7YAs3jPs/ufb+inZToGSSVljJ6nkzuvy6sUV
         n+uxH/JYuO0MYNqvMDR4ufSV37RLzrvnyInleUTWyf2P+tUx7y7BxIGe2sWeyTtVScnn
         yjOtvdWFS0co+ZvL/Nu+rUcUdwl64qUdomt7Z7mA+EdRDxZ2LUBUVHpqcH0COWiuAEXX
         rTfxJZTyxnnOFwGsdr76o0nbdWOkEmuRlbO6/kWZKB0+duNxSEncHcAIDR0HHk53zj/U
         6IFuDne9eQtt3SuKz6Rjl9+Th1dqwmuCew8mSDuTqFrjyqbP2EXvP1w2bJwfNmZgSZcB
         FT4A==
X-Forwarded-Encrypted: i=1; AFNElJ/BIoxkT37OT+p5quc7bglGvsvUVRG6SOAJWnPBoBEahZ+M9v2drUdIc047mC5XB9hQ7bYcZRvIQqfMRdXV@vger.kernel.org
X-Gm-Message-State: AOJu0YxcXVx5WpS/bOg+WdxqoJ74i9luQG9XmppUONpFYYgmWbRLykvx
	nSv/PThPV+s8EjPic0t4mUZ09vMGo2Dtrpe3c2aGHih/uHpPM7JiCDl4ycTotXn545FnNj0H/aX
	pCmdLMrlnNb9xEZn7mc+cWM1FSHIdcKE=
X-Gm-Gg: AfdE7cl1hEDFGQO508RflWU3FGmJceNpLszpI6M4D6KMFhh9l/VCTGXx15W9rrdxUaF
	y9q2VE+CQ0C3zsCDnj2t06p8f3rl3g5bx4bCQ8XhmaoUyUR9IU38cnThJT02uFstDAwaE3c7Pcj
	iWXU8l6AXcUra/K5IXuJmkon56YY4zZnm5DZ/48A4qPAfG2cORpsemSm53udCAhFzXgz4zth+ky
	Z4OdAuHaKHLGmsTE+7zTYVt+oNIiz9Z6mMPlKAnS/xjsUiqV9eh5s52uXyR0DlT3eW3iOQy/EwR
	q8p+Sn9YIwBVHRY6f+TPCqNL5Rer8GXClNPtdiB0On5ij12C9+8i
X-Received: by 2002:a05:600c:4f94:b0:493:adc3:cced with SMTP id
 5b1f17b1804b1-493c2b9826fmr112815045e9.34.1783032087995; Thu, 02 Jul 2026
 15:41:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701000949.1666714-1-joannelkoong@gmail.com>
 <20260701000949.1666714-2-joannelkoong@gmail.com> <20260702162308.GH9392@frogsfrogsfrogs>
In-Reply-To: <20260702162308.GH9392@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 2 Jul 2026 15:41:15 -0700
X-Gm-Features: AVVi8CcF6CmN9sR8NoQCdzue53Nqs4TLr02dXcvyfMRXcWTVkIDv2UbgUVh2ijY
Message-ID: <CAJnrk1a2ZT8DRgw5nS1G_9-QpDcA323iebsxZ9cn_BP9XTRvVw@mail.gmail.com>
Subject: Re: [PATCH v2 01/18] iomap: add ->iomap_next() and iomap_process() helper
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, hch@lst.de, willy@infradead.org, 
	hsiangkao@linux.alibaba.com, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 9:23=E2=80=AFAM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> On Tue, Jun 30, 2026 at 05:09:16PM -0700, Joanne Koong wrote:
> > Have one ->iomap_next() callback instead of ->iomap_begin() and
> > ->iomap_end(). ->iomap_next() finishes the previous mapping if needed,
> > and produces the next mapping. This lets performance-critical callers
> > inline the iteration with a fixed callback, which the compiler is able
> > to call directly instead of indirectly.
>
> Er... what is being called directly here?  The iomap_{begin,end}
> functions?  It looks to me like ->iomap_next is still an indirect call
> even at the end of the series, right?  That's still a net reduction of
> indirect calls at least.
>
> Oh, wait, it's the __always_inline iomap_process function that a smart
> compiler can use to turn the indirect calls into direct ones, isn't it?
> It might be useful to add a comment to that function saying that out
> loud so that dolts like me will pick up on why it's critical for it to
> be an inline function.

Ahh the sentence was confusingly / ambiguously worded, sorry about
that - I was trying to say that it lets callers have the ability to
inline iomap_iter() with passing a const iomap_next callback as an arg
which lets the iomap_next callback be a plain direct call. But your
interpretation of it is also true. I'll add the comment you suggested
to spell what you mentioned out and reword the commit message to make
what I was trying to say more clear.

>
> I like how this is going. :)
>
> > iomap_iter() uses ->iomap_next() when the filesystem provides that
> > callback and otherwise falls back to the ->iomap_begin()/->iomap_end()
> > path, so filesystems can be converted one at a time.
>
> > Add a iomap_process() inline helper that does most of the logic needed
> > in an ->iomap_next() implementation.
> >
> > Suggested-by: Christoph Hellwig <hch@lst.de>
> > Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/iomap/iter.c       | 113 ++++++++++++++++++++++++++++++++++++------
> >  include/linux/iomap.h |  91 +++++++++++++++++++++++++++-------
> >  2 files changed, 171 insertions(+), 33 deletions(-)
> >
> > diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
> > index e4a29829591a..1062e4e34c38 100644
> > --- a/fs/iomap/iter.c
> > +++ b/fs/iomap/iter.c
> > +
> > +/**
> > + * iomap_iter_continue - decide whether iteration should continue
> > + * @iter: iteration structure
> > + * @iomap: the mapping that was just processed
> > + * @srcmap: the source mapping that was just processed
> > + *
> > + * Helper for ->iomap_next() implementations, normally called via
> > + * iomap_process().  Called after the previous mapping has been finish=
ed to
> > + * determine whether there is more of the file range left to process.
> > + *
> > + * Returns 1 if there is more work to do, in which case @iomap and @sr=
cmap are
> > + * cleared so the caller can produce the next mapping; zero if the ran=
ge is
> > + * fully consumed; or a negative errno on error.  Any folio batch atta=
ched to
> > + * the mapping is released before returning.
> > + */
> > +int iomap_iter_continue(const struct iomap_iter *iter, struct iomap *i=
omap,
> > +             struct iomap *srcmap, int ret)
> > +{
> > +     bool stale =3D iomap->flags & IOMAP_F_STALE;
> > +     ssize_t advanced =3D iter->pos - iter->iter_start_pos;
>
> These both could be const, right?
>

I'll mark these as const. Thanks for looking at these patches!

Thanks,
Joanne
