Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6982BE65F
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 01:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784942307; cv=none; b=VvjCDBzunkgCKQvGTOTym785tnY8lxHju8Nw32/TzLP1u1VfJ8+3pK2OEjkoYKy1kN8ebhpvSMVBVcGsGLrqDmRVj8wTKdk+JFhq3JLO+O5Vo+yMhddI8j0qf+OY07d853X1B39p3eNwJ2m57UPhKp5MQjaqbtINUDEbUsQPgWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784942307; c=relaxed/simple;
	bh=9oYjlnqP04cEz1C+6/Oi93xqb8xyTH0cprkKR9hiFXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rPsNjGPLXyKiCFzavt6q83Tne4cRhq/nl7ofcl1XOYQ55EIuG1185R75V47IZuvKslXn6LmaM724rqMRCd3qRUhwijYmrv5VBD0JGzK5FH9lkJ07hoxl+P4JctzaChy6dqmvhwdbG6ZyfM3ThbquznrQcU3OK1wuQDR6kNxdBmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHy8OBkv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHy8OBkv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4D51F00AC4
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 01:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784942305;
	bh=8xKPHO22fBbY51MPVWs7b7SwqGZPXrPYguvnQLMAMJQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lHy8OBkvKZu/GdQMEb3Zc/PmldPZrW5b1wB5kYOKcgwqSkC+LS5umB0ICjaAomHfO
	 BxgLH8PulGA1L2XkK4BZYHsRJLaJY1UrleyevlgQLUlc/x48H0KewcOWzXSbVICLxE
	 kvgtlyz/UcAQGopCJk/L/2NL+ddnCIK7ejJUZ6SmsPZs+nfXd47rDwF+Sesom9mdVi
	 ZLS5tA7kTYTaljR5oN8lzshGLw7i8SsH/EUPm5ZoQqjmwFQ5tExTjD9+F5ukoQNi8G
	 iD2S0aaHBuB8rGFoHg1nCBAKhJw/rbN94b73kU6U1ykdWQlD9gFsVef5PGEzjoEk84
	 8ZRENDK9+C3Kg==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c160420289bso129238866b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 18:18:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RohD6ICCa4xJMmhzrFI2IhSOFjq21vB1L3Vm5ywdIC52R7MHmnOaeK4eslv7060cZpIF9apUY+umk4uFATi@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx4ZXXB1ml4BjsJXdJCmXVioDsn61sqNPYkG/zQO0BkJuD3I+K
	ATd5wd71dxGmGuWobRq24LTtV5zamvihG/6xjnHKO92Ch3AeOvinjk7y9hHUGfEjoe4p5JaRTo8
	GNbtI2Kbx6c+XG+suOZUlj9EoKPam1wA=
X-Received: by 2002:a17:906:9fc7:b0:c16:739e:e836 with SMTP id
 a640c23a62f3a-c1f1f0f9cc9mr23382566b.35.1784942303714; Fri, 24 Jul 2026
 18:18:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723191936.2419799-1-harshit.m.mogalapalli@oracle.com>
 <CAKYAXd--N_2nY5XPr3vNyb7Ai+xYbuR3EE4ivecVf6Eur-vC_w@mail.gmail.com> <20260724155307.GA7398@frogsfrogsfrogs>
In-Reply-To: <20260724155307.GA7398@frogsfrogsfrogs>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 25 Jul 2026 10:18:10 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8Mat6dcNAnRbaNcy-9KP-OKJhbkP-W5gEQQ6JmWJPCpA@mail.gmail.com>
X-Gm-Features: AUfX_mzjhY2yIDMpshbbJTHSMmWvHqdeSGMHC2ase1uGx82VeB-rcyVP15WvdVA
Message-ID: <CAKYAXd8Mat6dcNAnRbaNcy-9KP-OKJhbkP-W5gEQQ6JmWJPCpA@mail.gmail.com>
Subject: Re: [PATCH] exfat: preserve allocated extents for swap activation
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Yuezhang Mo <yuezhang.mo@sony.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 25, 2026 at 12:53=E2=80=AFAM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Fri, Jul 24, 2026 at 09:57:49AM +0900, Namjae Jeon wrote:
> > On Fri, Jul 24, 2026 at 4:19=E2=80=AFAM Harshit Mogalapalli
> > <harshit.m.mogalapalli@oracle.com> wrote:
> > >
> > > exFAT reports allocated ranges beyond valid_size as IOMAP_HOLE whenev=
er
> > > IOMAP_REPORT is set. iomap_swapfile_activate() also uses IOMAP_REPORT
> > > while collecting a swapfile's physical extents, so it treats the
> > > preallocated tail as unallocated and rejects the file with -EINVAL.
> > >
> > > Allocated space beyond valid_size is not a hole. Keep it as
> > > IOMAP_UNWRITTEN so iomap consumers that need physical extent identity=
,
> > > such as swap activation, can still use it. The iomap seek helpers
> > > already handle unwritten extents appropriately for SEEK_HOLE and
> > > SEEK_DATA.
> > >
> > > Fixes: b4b7fe2c7cbf ("exfat: add support for SEEK_HOLE and SEEK_DATA =
in llseek")
> > > Assisted-by: Codex:GPT-5.6
> > > Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> > > ---
> > > LTP swapon/swapoff tests failed on exFAT, with this patch the tests
> > > pass.
> > > ---
> > >  fs/exfat/iomap.c | 16 ++++++----------
> > >  1 file changed, 6 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/fs/exfat/iomap.c b/fs/exfat/iomap.c
> > > index 190fc6471f84..24d93288a432 100644
> > > --- a/fs/exfat/iomap.c
> > > +++ b/fs/exfat/iomap.c
> > > @@ -105,18 +105,14 @@ static int __exfat_iomap_begin(struct inode *in=
ode, loff_t offset, loff_t length
> > >                  * marks the exact boundary between valid data and
> > >                  * holes (or unwritten space).
> > >                  *
> > > -                * When IOMAP_REPORT is set (used by lseek(SEEK_HOLE)
> > > -                * and SEEK_DATA), we return IOMAP_HOLE. This allows
> > > -                * iomap_seek_hole_iter() to directly return the
> > > -                * precise byte position.
> > > -                *
> > > -                * For normal I/O paths (without IOMAP_REPORT) we
> > > -                * return IOMAP_UNWRITTEN so the write path can
> > > -                * distinguish it from a real hole.
> > > +                * Allocated space beyond valid_size is not a hole. R=
eport it
> > > +                * as IOMAP_UNWRITTEN so iomap consumers that need ph=
ysical
> > > +                * extent identity, such as swap activation, can stil=
l use it.
> > > +                * The iomap seek helpers already handle unwritten ex=
tents
> > > +                * appropriately for SEEK_HOLE and SEEK_DATA.
> > >                  */
> > >                 if (offset >=3D ei->valid_size) {
> > > -                       iomap->type =3D flags & IOMAP_REPORT ?
> > > -                               IOMAP_HOLE : IOMAP_UNWRITTEN;
> > > +                       iomap->type =3D IOMAP_UNWRITTEN;
> > Returning IOMAP_UNWRITTEN with IOMAP_REPORT can make SEEK_HOLE rely on
> > page-cache/block-granularity handling, which can lose the
> > byte-accurate valid_size boundary. Before activating the swapfile,
> > extending ->valid_size to i_size through exfat_extend_valid_size()
> > safely zeroes the preallocated range and makes it valid for swap use.
>
> iomap swapfile activation can handle unwritten extents (unlike the bmap
> activation codepath) so you probably only need to bump valid_size up to
> the next max(PAGE_SIZE, i_blocksize) boundary.  The swap code writes
> to the underlying disk blocks directly, bypassing the filesystem.
That makes sense. We can call exfat_extend_valid_size() to extend
->valid_size only to the next page/block boundary in
exfat_iomap_swap_activate().
Thanks.
