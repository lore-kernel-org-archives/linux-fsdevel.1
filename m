Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC093C4B63
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 23:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785884821; cv=pass; b=KbOR4qkqW+Xh7nsl6547Teipu5MrrnCfxM2R+e7xWMdlugAgkHBGYJwYX6E6iuh9scH90Wk7+WmHESCn+O62rbQ/zWoXPc+yCs56ciAW+jeheDctfh0teoRyEbom86HdrCuQSK6xAHulKxoSuruhK43Ed1B6IY8/4Mq/YFjjt8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785884821; c=relaxed/simple;
	bh=PMpFo1HfD8khbAAlxqkyKZRs/E05UT5D9hNFmyw/iB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KbtX+sk2aUOfC+DvQsvM+YkgblO4V+Xc8OWOttRl6MyYurSSNBEaXs9THmVDtBydMmi1ypxGtSlCwmpnhTmLBmMGWc5QJ2JqBiVRdSiPusidXI/kB3iZrEAfQtvfRRMS9vrwnLub2Wem8qV9jt+ULFdcEujWw17dk7dsMdJqb8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgsdM3GM; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgsdM3GM"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a0de062db5so507735a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 16:06:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785884818; cv=none;
        d=google.com; s=arc-20260327;
        b=Fmyu/XFqPN1Sa120w2AO4fZiTMJePYNgzRW2UPm2F3kWCiaHqsj55I5dsj6zI8XOQ8
         WeyvRRb4YXGmTzpTqF3EiNYHd87gbk1RPqjdkm2DVJbd+hweH/06chJ5/L32mywc/WDR
         hJMbvW0xq7zIFvPvoDgvsFP+7tK222G6DAJhDMcBpMSsZDTqg43cVqdtKrqUpbIbeP1O
         9Vun9VKUuEdp1HpBbv+2kRAjt63h1Q8tmGL8FmvINoSX6nKZp0efsGRSM4liQwWLG9Vy
         PZoiAs+kDTom9N2lPby+AS37Nb72wuIsKo+8ZyyisqvQ8W8PF0PfcyjQrBZFmO17taSp
         J4OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qtp00HQe0YEhUVbmZKFkfm9h9fZb8SFvoPIno10cSVE=;
        fh=DzJ8jayPQ6AR0maQKfj4C07EaEHr+aEtGU3h1zxfPq0=;
        b=YbPiTaBz+SaIQhuSGlWoNm3xuZ4ke6IbMcBdcjYiqQ1GoAYu58HDTIEXcLzjFScg5g
         gmli3YOGpWrHxEzgLU7vyjGVECcuhLvf/Iva3Jelz9pZag8fvAho3SboGiWdUd1ga3s7
         ItpPz6LHWjc9rAqkvpO9ReVf6SHN7YtWmCbHhHuclzwRYHUk2r5StMFzM5c9LEdPGZc0
         qnsL2c5PTM0+F2lawFH7xDkvC/481WZD3HJHV9v0b6W6Syi1r/LpIjQhG0Qnd/dbnxzW
         7AqdwFmEcdP+t0/2W+edlhfYh0V20pHQ+fU5GnxyIIsuSKOAEZs9MzhPMkElwbSwhHlm
         KqfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785884818; x=1786489618; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qtp00HQe0YEhUVbmZKFkfm9h9fZb8SFvoPIno10cSVE=;
        b=bgsdM3GMiSGtBU4Ypwu3zN7bfu1Xk/8XJTNa6uKanVZQoX6L673+BAlnbPjqUc5fDK
         aNEIS3uKF7QDmhG3w+58+Ly5MEeo4MACPSTvvd93nQ4Z17T8cckMJR1MAr9CCgkhDW9L
         y/DsmJ/2cQWDEOTwKSnCW4LSNA6nnR3yOdXERkpd0Uj0g7RgdlSodPcBLAHiPHzr8RXw
         wQ+jyRZvUXOY7+79owb4Z0pogF4XD5OYl1xDr6GlAjIar9cOFlXFaGOGPwsoueWke5q/
         PFkA2bBtxabjL3I/tyxoNe9n/PgmvF46kB/IrabulS69Lf395CNkeJtwFjP/eDpHnUZ8
         7M2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785884818; x=1786489618;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qtp00HQe0YEhUVbmZKFkfm9h9fZb8SFvoPIno10cSVE=;
        b=lkhr5ej32DvStzcd8gCN3UqBAGl6IG4R9iNl2W/xrBCgPSnBnERH4oO09lmG/IyMKs
         r2nrG+U38rnwzJVknfnAutzhuWNAwZMD9fleC43QEqwo69VJVB1QsUlbfBzwnV5j352R
         U1EHOirKS0E3USrAR2tCTJCsbQqBEIa6WX5ODYG6Kpahu+BSP5GjMiYhWybHZkD9dwfk
         ymjGTo0Kr4eepC3v1WLMw0zFpOxUCZRnos7th/N88uUoqXMWvAbTm0qcyznNhXXUEap8
         LMS3KIrZYhmCoJT5ilcaacGZ7GheIqYBagij5P/anMLDNA3j4Iy7BQZ98ycnTuicf1XF
         RiFg==
X-Forwarded-Encrypted: i=1; AHgh+RpjeEvOiauImhBtrcK0kZ0BDhKLgXMCzWh45tqlBfPgHyaIhWAtEPIsEBcwCHI/0gHCsLQbrlOzF3hBrfWS@vger.kernel.org
X-Gm-Message-State: AOJu0Yx937VZ3MR72t/vaheiixG/XdN0QNfOsMaZ2hptMtg4feQQTNi4
	IkS4c/ysva7Wd5KrC6XppKJ8VBEew58t9BQYV4Hb0t++t9pUzpH5+RIxebjkj70TWpmzeG4FoIA
	6GEOc41Z7haF9YW6gve/qkEK2NYKJxmY=
X-Gm-Gg: AR+sD13bdZosHfbFZaOocaYpeQURfOZ07mXbkO4qIRWluCSipHnFsrwtgM6aHwfHVpC
	Q6heTJ6bLyBaBAd6RBfKhKQx1L14riat2WL5e5lmvz31PvbSK8iS7jz2kqiMeXSDDyLN96xnqqz
	hRf4zpmKp98KU1ySm/4NMV86K35MJxmWh5oCRiQ44+U068fCR9XiaJuMaTj1htXvHoTpemJWyzr
	L8C9kw0ldpcktlMwWt5y56e5UJoj8V9i5dh41yCszbzm1cHQjVoui9okjZdF0yHKTzaYY7Wsf0Z
	Qsdwee848AMHV7OmGfZq4a09gDKscIB8jVArogjDdGena4+Rd+pb/9o=
X-Received: by 2002:a05:6402:5023:b0:699:12e8:1c54 with SMTP id
 4fb4d7f45d1cf-6a14f103f88mr1267020a12.5.1785884818029; Tue, 04 Aug 2026
 16:06:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785621505.git.coshi036@gmail.com> <41c6fee66724e374d4682124a1eb80041e22efb9.1785621505.git.coshi036@gmail.com>
 <z5jfe6bsxhgqqgjtxcm7ass2fslc4ynizvpmzlqxtr6rrfaopu@fxzntlxafmxj>
 <anDW5UTbF2d0EQmr@casper.infradead.org> <74ts4lwsq73mce3rvc7imisot436742ykzahnogysnbklot45b@q3nhfq55knx3>
 <anHyBATDe8yQEFNi@casper.infradead.org>
In-Reply-To: <anHyBATDe8yQEFNi@casper.infradead.org>
From: Chris S <coshi036@gmail.com>
Date: Tue, 4 Aug 2026 19:06:46 -0400
X-Gm-Features: AUfX_mywycbzfMLtI3iRX8QYjwuoGt1JUOb_Y0mmTpKfptijtN3o82-3luOQJN0
Message-ID: <CACd_6n0zcg85_p=+dcVK__SECdom8K01BBsdzakuwJ1ibMhKJQ@mail.gmail.com>
Subject: Re: [PATCH 02/19] buffer: allow a buffer_head to point at memory
 outside the page cache
To: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Baokun Li <libaokun@linux.alibaba.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>, 
	Bob Copeland <me@bobcopeland.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, linux-ext4@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, gfs2@lists.linux.dev, 
	linux-karma-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Agreed, and done - but not in this patch, which is worth flagging because i=
t
is not obvious.

folio_mapping() is doing two jobs here.  The one you are objecting to is th=
e
swap cache mapping.  The other is that it returns NULL for a slab folio, an=
d
that is the only reason this path is safe for jbd2's shadow buffers today -
they are the slab-backed buffers this series is getting rid of, and they do
reach buffer_set_crypto_ctx() through __bh_submit().

So doing it in this patch would leave one commit where shadow buffers still
sit on slab folios, and this code reads folio->mapping directly, i.e., hand=
s
fscrypt a struct kmem_cache and dereferences ->host on it.  Fine at the end
of the series, broken in the middle of it.

v2 does it as its own patch 4, after the jbd2 change.

Chao

On Tue, Aug 4, 2026 at 10:07=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Aug 04, 2026 at 10:07:39AM +0200, Jan Kara wrote:
> > > Yes, agreed.  I think it's fine to add in some 'if (!bh->b_folio)'
> > > tests, but only where they're needed for the occasional consumer.  Th=
is
> > > really is a rare (but legitimate) case.
> >
> > Yes. If we were to write this code from scratch, I'd rather push for
> > forming and submitting the bio directly instead of trying to bend the b=
h
> > layer for these temporary bhs. Eventually we might want to do this clea=
nup
> > anyway (since bhs don't really buy us much in this path) but not in thi=
s
> > patch set.
>
> I think that would be better, but it is out of scope.
>
> > > > >  static void buffer_set_crypto_ctx(struct bio *bio, const struct =
buffer_head *bh,
> > > > >                                   gfp_t gfp_mask)
> > > > >  {
> > > > > -       const struct address_space *mapping =3D folio_mapping(bh-=
>b_folio);
> > > > > +       const struct address_space *mapping;
> > > > >
> > > > >         /*
> > > > >          * The ext4 journal (jbd2) can submit a buffer_head it di=
rectly created
> > > > > -        * for a non-pagecache page.  fscrypt doesn't care about =
these.
> > > > > +        * for memory that is not in the page cache at all.  fscr=
ypt doesn't
> > > > > +        * care about these.
> > > > >          */
> > > > > +       if (!bh->b_folio)
> > > > > +               return;
> > > > > +       mapping =3D folio_mapping(bh->b_folio);
> > > > >         if (!mapping)
> > > > >                 return;
> > >
> > > Do we want to call folio_mapping() here?  The only case where I can s=
ee
> > > this being useful is if we attach a buffer_head to an anonymous folio=
,
> > > and I don't see a good reason to do that.  I think this can just be
> > >
> > >     mapping =3D bh->b_folio->mapping;
> >
> > For all I know yes, bh->b_folio->mapping should be enough here. But I
> > thought folio_mapping() is kind of preferred to open-coding?
>
> It rather depends on the path we're talking about.  Looking at the
> implementation of folio_mapping(), it's actually mildly dangerous
> to call folio_mapping() in this path.  If we were ever to point a
> buffer_head at some memory on a page in swap cache, we'd get a pointer
> to a swap_address_space.  I think we'd safely crash in that case because
> mapping->host would be NULL, but in other contexts doing things to a
> swap mapping would be quite bad.
>
> So I think this should just be folio->mapping; don't risk getting a
> pointer to a swap mapping.
