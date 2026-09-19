Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B8222E3F0
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 17:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789840305; cv=pass; b=om/PWskVf7+E9LnC0/5QlKIeEmPzHlmJjaAlfcZvwhgzVId6N/KMC1318DWDle4V9R9rZmpyYvFfyL3gCBj+6LXRdqsjCdq6tFUAczPErzm+uT23+X2DRb/SIWwnXFU7Sc+rQQgqzXhIq+lJtoz/TqR4eb40aW1AmV2N3LJiOTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789840305; c=relaxed/simple;
	bh=fZC5KOxygQCvgzX23m5hmGIytJqdAkOFo+4PrqktGnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EsydKVlMej8sZwWg9XX/ETBQP0koV9AAWrIJMVj8N7e8L8lSbh9O4B9JrTofSpokVfC2hU5ZGABG2oEYAv9LWvcy8mO8Yn1EZUs7O+YVCYOb/CHiJUxhAmyZOpHa5LSlzq/6mk6PKheNf+7dFRDha97+UtIEab4Q6fZsSesEReA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IV68DmfZ; arc=pass smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IV68DmfZ"
Received: by mail-oi2-f12.google.com with SMTP id 46e09a7af769-7f4f0d298caso746467a34.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 10:51:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789840303; cv=none;
        d=google.com; s=arc-20260327;
        b=ZgzERqkgDkL+lUREHYVxTNYa+9I+clcQxcCbvwvae3b6H+IzFB/dHzY6BXssiq7kRQ
         qNeA6g8jl9QiutAkjMzl+Wnp+4UGRLD+3ii3ETqNMaqaeuf23yzXyMtOKC4roQou9/u7
         B2st5/xa7Fqg8Uxqh8PGHZ1DkvLF+2ExGZrDo3syh9knGeMZu5MAyM1Z5Dg71qS0jdOB
         cBaL8LKRxM+D/rFtOLX+NuSBubCc2bE80HT0kiovrydPn0NAwifDshNBuIxbcE7wxgh7
         kS9WPc+laCxXkaAcSrQLe+61zOm7ImR1TgjYHBj8Iw9oJe3ageLMPiy9/jOqEsoo9eSb
         DkYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Okip5gnBeaXNXEAYrkxX3LEziZrA3SBraWS/ZdG+Lro=;
        fh=yOiudSuk+B/rR47n2F7nA/XPr/J7mTeztq57UTMxu4Y=;
        b=SftluDPH6g48rZItHzex+03iD7p+WXqerxygW/F5LhKsxoA9Oj6afk/GPlj/bjyUJ3
         FALF/dJ6YP93ERqXwS9wNc2r+kIYrMvE7+M/uQFjW6/QUd/DF0dd0ELK+zn0eOqYsE7F
         Au+ywpxog7iYXEr7iVA5S5+inExY9pDP3CD/H+EOIrVK6VJ2NoGxj1YhUoej9BDhSI4z
         xr86Ifiyp4Tp7Te3dveOyAhHKNZZjHEvUWZLLy96NMWMgceUvxCWqo+KDfAAYyApbKOe
         4pVTJ5lfC/1PtNwgQ8kDQT2vYfBXt5geqC1picYoqjV3fFRqGx+ueHT09MaUtd4gEKdJ
         Htaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789840303; x=1790445103; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Okip5gnBeaXNXEAYrkxX3LEziZrA3SBraWS/ZdG+Lro=;
        b=IV68DmfZK8+4+yd92UQw0Me6cu0dGUxiNqgOhipiFesmkesBCBFy3mp+PySd9dBZb0
         LsjcWFPXnljZ2UtngeLWMQzyosyjoj9Eo/w07G8mCRrR31H4+5/a3XP5WaXSVKOxThuw
         PAuDTiMktFwa7tcMfzB1n6KpJB6yxrkhd1I5mTSIc6Cv4bwVetF4XN4YpN5Q5HtPC6ZA
         k2NTRpvsqajqTwqw/HTjKCLkuEf+M+eDDGWh1eaNBRYj7PGoCnrNomJiZVYxGcn4HmVL
         MqUDPGLCx/5nKA9EtGduhfftJzyOTldiySgcpoPoUy3fRZEV1MbdkUBfGT61Wm4BkbBl
         IFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789840303; x=1790445103;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Okip5gnBeaXNXEAYrkxX3LEziZrA3SBraWS/ZdG+Lro=;
        b=q3bo1bQJrz2QEySxBEOwYATTojMf4dkXuutRXXReyUujQx6XqEtfC7hxhvIKeVu9yE
         3962wYISdMxD+ZYHpnpRJYz2Jqwr2Cdm7ed4TgRxesIsSFPxQD1jUynmuOnpETYjl9T+
         s3gFnRi9qon6Fk1WN8n0GWrupoRa6hiNBhSb1E4wKH56BEJD3l61PaZjoDd3xcXsuTai
         EB+XzNLZSqOrm8NaGzlR50firQ8R/8CcyJMJrZAKxRyN5Guz4HDQF7wGIVNsZoN1YsXp
         g7xYhP8OflMIsdrYq7B1/t5acsBg0acJDAwvguCXgdaaEn/zG4P+NjKdpvhCU7ClR3n4
         EZQA==
X-Gm-Message-State: AFuF++kFE2GCQ5PmVYl/1yjVbI833Q58dJABQye0ehhP7plb6BTIvK0s
	eSgDEdmjERW0AsHwpjPfAqlHWgybax19is8dNcskwFIUlOjoG+bhgomnu6m36AgtANal9CL5ftc
	uFUEWc0yvYZtgZ9rEBUtO3w0+DH9+TeM=
X-Gm-Gg: AYBFou1f7UOT5vxOEfi4Nrg+RzJ1bEKhdMspCER0c3ADMzcdoB9BNgcCXqOXjnnVLFE
	dvVUYrlkmJVHWhdRvqZx4e7Jl4NSedPPFWwfFo4FgbqcClOBrCzLDcmzjR9Ff0nR5N76g7t8bz9
	IWnfVPWkYH2DRv4b9N7tdd+EAvfzO3vEgZzGcR7qPc9P7cu+vM2M7ZY33hzzBDFimQ+TgkJLkJn
	e3vh2AVMlcvx/DJktRw6Car7zOAo+VnsVhV29r2LcjZ4sZYuccPX0y9D458SfHm87CzLVm0d5yp
	9p6gmh6KbAXgP8XtslZqp99ldVncTT4HDE2PVdOnEpQPztIUwxrMenrcJyzoOHaTh89oiuFaNhS
	jbhWSjnXztLmvGB0MAIsimPUhrGF/dSlSwmvLQFyp
X-Received: by 2002:a05:6820:1846:b0:6ca:5253:9644 with SMTP id
 006d021491bc7-6ca9d14b2a8mr4883427eaf.62.1789840302770; Sat, 19 Sep 2026
 10:51:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1787770110.git.jbingham@gmail.com> <e7ab836149f814b04017905dca2e07a4c94078db.1787770110.git.jbingham@gmail.com>
 <aq1GsO6dkS747OEb@infradead.org>
In-Reply-To: <aq1GsO6dkS747OEb@infradead.org>
From: Jeremy Bingham <jbingham@gmail.com>
Date: Sat, 19 Sep 2026 10:51:32 -0700
X-Gm-Features: AcwNN1UwXGt1i0ZpfillThgf-DVm5Bruym7sGY4z8Lhyzj-X1ZGxgnRAU8IUmNA
Message-ID: <CAMyBmMA5bOaGK0TfPMGpmfR6oD0k9EdS4_R3RoJ7d5QTjm0bqg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] minix: add iomap functions and definitions
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	brauner@kernel.org, jkoolstra@xs4all.nl, jack@suse.cz, djwong@kernel.org, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 7:12=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Wed, Aug 26, 2026 at 02:41:56PM -0700, Jeremy Bingham wrote:
> > This patch also wires iomap.c into itree_v1.c and itree_v2.c, similarly
> > to how itree_common.c is included in those files, and exports version
> > specific versions of minix_iomap_begin and iomap_ops.
>
> Can we keep the iomap code out of this double build mess?  Just define
> some low-level helper in it, but keep everything else in an only
> once build iomap.c

OK. I went back and forth a bunch on how to best do this, because it's *suc=
h* a
mess. I had a lot of reservations about the way I had done it, but
it's so all around
messy I ended up there. When I refactor it I'll either move that function t=
o
itree_common.c or craft a way to get that depth information out.

> > Also updates 'unsigned' to 'unsigned int' a few places that got picked
> > up by checkpatch.pl.
>
> If you want to do these cleanups please split them into a separate
> patch.

Noted. I did submit a patch like that back in I think late June or
early July, but got
told (politely) to knock it off. I had kept these cleanups because of
checkpatch.pl
griping, but as you said below there's no technical downside to leaving it.

> > +++ b/fs/minix/iomap.c
> > @@ -0,0 +1,122 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * iomap functions for minix.
> > + */
>
> Not really a very useful comment :)  OTOH this lacks a copyright
> statement for your work.

I didn't want to be presumptuous. I'll add that in.

> > +static int minix_iomap_begin(struct inode *inode, loff_t offset, loff_=
t length,
> > +     unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
>
> This mostly does not need the iomap.  It basically returns a physical
> block and a trystate of HOLE/FOUND/ALLOCATED.  If you change the
> interface to that you can keep it in itree_common by directly morphing
> the existing block lookup into that, or even do it as a prep patch,
> which first refactors get_block to this interface, and then do the
> iomap mapping on top of that, and in a place that only gets built
> once.

I'll address this in the refactor mentioned above. I don't think I can
entirely get rid of
or refactor get_block() unfortunately because of the directory
operations, but I'll see
what I can do.

> > +/*
> > + * minix_iomap_end ends up being a nop; since minix doesn't have any e=
xtents or
> > + * transactions to worry about, there isn't anything to update here. T=
he on-disk
> > + * indirect blocks get dirtied in minix_iomap_begin.
> > + */
> > +static int minix_iomap_end(struct inode *inode, loff_t offset, loff_t =
length,
> > +     ssize_t written, unsigned int flags, struct iomap *iomap)
> > +{
> > +     return 0;
> > +}
>
> In which case we can just drop it.  Note that for the next version
> against 7.3-rc should also move from the begin/end calls to the
> single next one using the DEFINE_IOMAP_ITER_NEXT helper macro.

Conveniently I had just updated my test VM kernel to 7.3-rc and
verified that the
module still builds unchanged, so everything's in place for that.
Thank you for the
head's up.

> > -static inline unsigned minix_blocks_needed(unsigned bits, unsigned blo=
cksize)
> > +static inline unsigned int minix_blocks_needed(unsigned int bits, unsi=
gned int blocksize)
>
> Overly long line.  I'd much rather generate the baseless checkpath.pl
> complaint and leave the plain unsgineds in place.  There is absolutely
> no technical downside in using that notation.
>
> > +static inline const struct iomap_ops *minix_iomap_ops_ver(struct inode=
 *inode)
> > +{
> > +     return (INODE_VERSION(inode) =3D=3D MINIX_V1) ?
>
> No need for the braces.

All simple, all noted.

Thanks,

-j
