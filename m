Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63698E54B
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2026 16:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784306986; cv=pass; b=DuEESdyrVc6OmXWfxOJs/S35KokhAqRwOCS/qdLpQy4VJzAmojw5U/fmCntJ9qKWmRckNhHBma5RdOxHTkdnJwbbxHYE/18HxfOab382E9uNRoHNqEz1gmI88ndRoaBhQ2C7QWCvvxO8U3/tXz8LvUPkDv2n6pBlbgWlqCl6Id4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784306986; c=relaxed/simple;
	bh=9CdHPsUZAy8Yo0MKXff0kgEmv/B+FhNhAg47sPzRDDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RPBQCN8ik4JnWvpg1YY24u9LzgAIqVYrr+2/SU2iw3nnK+qwcfyrhDa82LFLZMcBWqSozNZbxkpZ+km0F5FURBYu6aFkR1uQFU9NThdaOKzXch0lMwx3ZkTtlNq/Mv7Ah+oETF9QJk5Xggsh1xeZotGl2S3cK7dtt7rx5v3lDWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTmy13Oo; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTmy13Oo"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47f365afc5aso3619774f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2026 09:49:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784306983; cv=none;
        d=google.com; s=arc-20260327;
        b=R+6LwaZW+bPcpDl0A5qOUqiwhVLcRC23xxoX5gLhWTIzQQ1+Wo9fot5p8EikKwYwoR
         lX3Jq+Qtogo8Wm60sHV8udDXFJw6k7IG2BEtdqO0wIFWMPdG0sYDEdsqqTlAwacr+m66
         p8fagVhJvFteDSgLyJi9NwzfNd6ksiPksx5rHIRLhLLtD6kLJw8Zv7kxvYhVFRZCTqYQ
         uIQ7O4h3vuTJZgqsLRDJbwx5AG4PVLVq46e55+wRi2XAmI/BqpRFWHaJwy/3GeCcAS0B
         wYG6uikDPHAzxa4QmSUQMi6jwQk+zTuW2+hoA/w1HmY4UgClR2gykh4f/hPo3xJq7W04
         mbyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7lLuKKfJwb6KqGr3DuEUOFXs3XGlGNHq9ltG+hEfEQQ=;
        fh=z+ODpB+JdyTRzugD6+uKpFxpv4/aMjFSfLxH9hv/oKY=;
        b=C2HQi2gK0d4lyoiCn05rkQpPwqgCxOPzy//ovMrq7rymiXyrMJIXfZ03urTgoy3jvI
         vEzirbheKmbh7e+Fex6m7jurrTFkDDbnevwVLazPZSZRz3VTJDR3bdU4NkFP93L5U9NO
         VY+TxKOHCxtku7xfOEwE1VKBotOn7UAP/LwrCxjd2avYmlo8uTteCSBRlrgMlGZPk9cO
         dfQGQcI3jQtw9U42l4d4L/7S1vjmnWUisDkOWBdAUD+41twvewR5cDeh+QUq/BaEfJu0
         6qAdQilnQuH0LH18wSglefo6+TGXr69aQWdauDuFqn65vJIV5CTFztVDEblxzGnvQGGw
         48kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784306982; x=1784911782; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7lLuKKfJwb6KqGr3DuEUOFXs3XGlGNHq9ltG+hEfEQQ=;
        b=hTmy13OoRK1liLPUxuvmzEAiVJ8LXwv8QfkAZ9v071Iw02xLTfUeVW3nYl5oMyf8O1
         p82tyz/Wpr28lELsY85qvBXladIwd6N03UNpNn2TMgec5guuCIbaFEuGg/a5eNuuHmoa
         OG9ZfmnqKXOYjtcoI5x120GIr5p3CJjkr8KpvAkoRMBC2UaDqjInFPPmSBZ5pzEgRKQd
         xmZwkXp7nlkVV/vqOZCUxdebVwVn6AdcTda1y+LAAG72viMdDaRKVc0tdUaR6R2lW7D3
         R0xbKwwQ5qb1x1J3fA/Y38oLzjW16gO0Ilc68S8R4zhdpBr7Lj5NAvF7B8rRM+QMsfFp
         56Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784306983; x=1784911783;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7lLuKKfJwb6KqGr3DuEUOFXs3XGlGNHq9ltG+hEfEQQ=;
        b=WCKQWFO2jiByrhAyxl43X4B10En/SZePolAjvy6SXMG4+pF/WKsNCkomMyXaBxjivZ
         Fssxpi1ZFbg1JIDFVNb6cZafRr1SS01384So0WYo5WjcO6+BCsbPeKoCtWrFujBpSLmy
         LSOrKzF5O2B+83wAjDnyC6Dbm/dK59fR104CHSyobq0LrhUEVwoajzK/e8oXgXmi51dV
         szfy5+idPoSmSPGoyQOvnN1Y1wVkwQTtGky7HQibTJHjWN89hNZad5f8aJMfeR9fFB/k
         wF/lmuIa9WSnPQNr7S2jWY2pp2dycKGgHPQNDvPKFn3Y0qHanGTpc7yAUrdcyuBfzFhR
         kPRA==
X-Forwarded-Encrypted: i=1; AHgh+RpTgrHoCohDK3k+NC+l5DjZGEoghKasMID3cjRKM+Hb6nf3c9RxICdzRmws9P7qDRH/Q+WeuFzjuUxKHAHn@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjz/0G75+TZG5LllWnVF21nS24OvqRIAeGTlKn/Mr+GaTooXcE
	pPVFaEGgdahqPnhUT9Rp0MSnyXUXmHaCjUvDLyOhtNINlW2dnh1c0VkjJ7Z8gbRHJ3nx7tyUCyT
	vx5Xf12MicEI38uw9ecp3V55XMPKWSss=
X-Gm-Gg: AfdE7cnPOfxjtVsZtEeceZpcvigXpM7F3Yv7zYAq2oSJMfrrhk5gcsw8XW40lod4eRu
	f4CbByT2wUPi++V5RCTW6KdvRkHiQS8C4ONKZAId80G+5PV11zwEMXPbwXTXhkrLqMEU1j46RGw
	G7mcLIKWzTnZvavKZ9Di54ColV/ZOm7IIkQLRZb0+pdPGQz23/4kbGe5JUxinfyFDyJ/0gBTK7N
	ZaZK3c5vKx3eadFhTLPkh2Ro9A/eC4uxVea/7cp1ZGrXJ1lIa1Rgfe3Bu3+gEjP04TaK/OxLe95
	475HcRSqqBRfUkyblGhrKe5RCPOiW9qFoRuO5rsfdQ==
X-Received: by 2002:a05:6000:188f:b0:47e:81b1:74aa with SMTP id
 ffacd0b85a97d-47f6233419fmr4831356f8f.42.1784306982525; Fri, 17 Jul 2026
 09:49:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701000949.1666714-1-joannelkoong@gmail.com>
 <20260701000949.1666714-3-joannelkoong@gmail.com> <20260702164339.GI9392@frogsfrogsfrogs>
 <CAJnrk1ZRQaFseAnz3zm31oR3KmQWje5HDJjhNbAQSAQyK9_PMA@mail.gmail.com> <CAJnrk1bj4pLpAzLhehrbDJuKWa=WMq-3XOAm9dhsEVDF9WCBPQ@mail.gmail.com>
In-Reply-To: <CAJnrk1bj4pLpAzLhehrbDJuKWa=WMq-3XOAm9dhsEVDF9WCBPQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 17 Jul 2026 09:49:30 -0700
X-Gm-Features: AUfX_mwBLTjYZBsmrkzBHbWUlNQxbiDGEEKR9rvM2xEKSv_VHq7AM_IkTmwM4go
Message-ID: <CAJnrk1YkAEUhjw6mNEx70ojN7UMQT__oHn5m1Ng2Lz7FoLRhrA@mail.gmail.com>
Subject: Re: [PATCH v2 02/18] xfs: convert iomap ops to ->iomap_next()
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, hch@lst.de, willy@infradead.org, 
	hsiangkao@linux.alibaba.com, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, Carlos Maiolino <cem@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 6:21=E2=80=AFPM Joanne Koong <joannelkoong@gmail.com=
> wrote:
>
> On Thu, Jul 2, 2026 at 4:59=E2=80=AFPM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
> >
> > On Thu, Jul 2, 2026 at 9:43=E2=80=AFAM Darrick J. Wong <djwong@kernel.o=
rg> wrote:
> > >
> > > On Tue, Jun 30, 2026 at 05:09:17PM -0700, Joanne Koong wrote:
> > > > Convert xfs iomap_ops to the new ->iomap_next() callback. This uses=
 the
> > > > iomap_process() helper, which finishes the previous mapping if need=
ed
> > > > and produces the next one. No functional changes are intended.
> > > >
> > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > ---
> > > >  fs/xfs/xfs_file.c  |  4 +-
> > > >  fs/xfs/xfs_iomap.c | 96 +++++++++++++++++++++++++++++++++++++++++-=
----
> > > >  2 files changed, 88 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > > > index 845a97c9b063..7f8bef1a9954 100644
> > > > --- a/fs/xfs/xfs_file.c
> > > > +++ b/fs/xfs/xfs_file.c
> > > > @@ -857,9 +857,9 @@ xfs_file_dio_write_atomic(
> > > >                       NULL, 0);
> > > >
> > > >       /*
> > > > -      * The retry mechanism is based on the ->iomap_begin method r=
eturning
> > > > +      * The retry mechanism is based on the ->iomap_next method re=
turning
> > > >        * -ENOPROTOOPT, which would be when the REQ_ATOMIC-based wri=
te is not
> > > > -      * possible. The REQ_ATOMIC-based method typically not be pos=
sible if
> > > > +      * possible. The REQ_ATOMIC-based method is typically not pos=
sible if
> > > >        * the write spans multiple extents or the disk blocks are mi=
saligned.
> > > >        */
> > > >       if (ret =3D=3D -ENOPROTOOPT && dops =3D=3D &xfs_direct_write_=
iomap_ops) {
> > > > diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> > > > index 225c3de88d03..4fa1a5c985db 100644
> > > > --- a/fs/xfs/xfs_iomap.c
> > > > +++ b/fs/xfs/xfs_iomap.c
> > > > @@ -1037,8 +1037,18 @@ xfs_direct_write_iomap_begin(
> > > >       return error;
> > > >  }
> > > >
> > > > +static int
> > > > +xfs_direct_write_iomap_next(
> > > > +     const struct iomap_iter *iter,
> > > > +     struct iomap            *iomap,
> > > > +     struct iomap            *srcmap)
> > >
> > > <unvarnished brainstream ahead>
> > >
> > > Now that I see the callsites, I think the "next" name could use some
> > > bikeshedding <cough>.  The purpose of this function is either
> > >
> > > (a) to look up the first mapping to start iterating;
> > > (b) to release whatever resources were attached during the current
> > >     iteration and look up the next mapping to continue iterating; or
> > > (c) to decide that it's time to stop iterating.
> > >
> > > From that it seems obvious to me that xfs_direct_write_iomap_next yie=
lds
> > > iomaps for iteration.  In Python those are called generator functions=
;
> > > in Rust they're called objects that implement the Iterator trait (or
> > > iterators for short).
> > >
> > > How about s/iomap_next/iomap_iter/ ?
> > >
> > > Then this function would be called xfs_direct_write_iomap_iter, which
> > > IMO is a closer description of what the function does, which is to sa=
y
> > > iterates iomaps for direct writes.
> > >
> > > (Yes, my brain might be polluted with thinking that "iomap next" refe=
rs
> > > to a major shift, in the sense of "linux next". :P)
> >
> > Thanks for sharing your thoughts. The idea makes sense to me in theory
> > but I think in rust and python the "iter" naming is reserved for the
> > iterator object itself and the method / callback for advancing and
> > yielding the next item in the iteration is named "next" (eg
> > Iterator::next in rust and __next__() in python)? I wonder if the
> > s/_next/_iter gets confusing with multiple things in iomap already
> > called iter (eg the struct iomap_iter, the iomap_iter() function). I'm
> > not sure, I'm happy to rename this if that's the preference.
> >
>
> Ahh okay, I think I see the point you were trying to make. The
> callsite functions are like:
>
> ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *fr=
om,
>                 iomap_next_fn iomap_next,
>                 const struct iomap_write_ops *write_ops, void *private);
>
> int iomap_fsverity_write(struct file *file, loff_t pos, size_t length,
>                 const void *buf, iomap_next_fn iomap_next,
>                 const struct iomap_write_ops *write_ops);
>
> void iomap_read_folio(iomap_next_fn iomap_next,
>                 struct iomap_read_folio_ctx *ctx, void *private);
>
> void iomap_readahead(iomap_next_fn iomap_next,
>                 struct iomap_read_folio_ctx *ctx, void *private);
>
> etc, so it's not clear from the "iomap_next_fn iomap_next" naming that
> it handles per-iteration logic, whereas renaming it to "iomap_iter_fn
> iomap_iter" makes it more explicit. Am I interpreting this correctly?

Going back to this... "iomap_iter_fn iomap_iter" doesn't feel quite
right. I think there's too much naming collision with iomap_iter() and
struct iomap_iter, and I like how in general ->next() matches the
orthodox naming scheme for advancing an iterator. I think
"iomap_iter_next_fn next" would be the best of both worlds - I'll
change it to this for v3. But if you don't agree with this, please let
me know.

Thanks,
Joanne

>
> I think this is a good idea. If no one has an objection, I'll make
> this change for v3.
>
> Thanks,
> Joanne
>
> >
> > >
> > > > +{
> > > > +     return iomap_process(iter, iomap, srcmap, xfs_direct_write_io=
map_begin,
> > > > +                     NULL);
> > >
> > > But then "iomap_iter" sets up a new problem: should iomap_process hav=
e a
> > > new name that goes along with that?  iomap_iter is already taken for =
the
> > > legacy path.  If we were emulating python I'd suggest iomap_iter_yiel=
d
> > > but this is C so we get to reinvent everything from scratch so who
> > > knows.
> > >
> > > --D
> > >
