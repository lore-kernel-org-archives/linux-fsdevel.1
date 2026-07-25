Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BC02F39B5
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 01:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784944296; cv=none; b=W/DgihR+ZzokTpdIfKojKKm00Awz5Ezj+8SLvRX70YEFp1RszUHivgYqyCU1SdEOutjLdbRbVEILZ6jisXUK98oclszqzBE4QTkk84DkZqIIs6ZO0kaSOeKG78tgRkHtfVxBn7iyCEAf3jUXw/9CMHHW847eMUyXgV36rMOkTYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784944296; c=relaxed/simple;
	bh=Ebp/LzV1hMoE/TXO75CUoid6BC+AYncKIM10jrjxcBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FZkci0aXiGwsCZv3JMlIlPPuIDSCwE0sP1ZxwF9+d7OHYnVRDtFJd1gghmOVG39XzsVm0L3IgcyUhRE+GF4zuJdL+gl5V7GJoAcWzOIzLPac0epMuNFOxNlH4q+PfYJlurk+2svE039QjrNvR96Nyj+bxIcIY/I4Rp5irc0Lui8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObA2udAQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObA2udAQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D371F00A3F
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 01:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784944295;
	bh=4dMEVSU8mgEzV37PLiRBlpkHS5kovHlLkvPcP5T83Fg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ObA2udAQCVC8/yIt07SMUZ68RAFGDotnd/3wE48VDDsW+AQhIUP8Uca8fXw6JEnIN
	 QpMNdis3nKRqjzvhvN+DuNbjZgZpipkz7CnNWT4iQiw4N2PnKzOsGi22LAzeVrKueR
	 1XrKOp4lY4BSqHJIoNO95EgOsJ3EScGgB3Pyfvc7gAMA7vtuBWDa6rn0zCboB5s3Mo
	 1AmZ2dpgppXG2RSe6pKZM2JnIQ1L5OcutXW1lnqOaq28aX4xY3Gug8c40c3nU2Bfil
	 kQMRZnTD1l2fyHW4ICFZRc7M5Pg5WuQ0ILIndlO9gj577tvRkfehgBVIRlWQZb+mYB
	 I75Gt1WW5obGA==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c15b1da6b82so140856566b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 18:51:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrGETazGqRtPTMfrDeEHxh2DJe4/jtTF0vepDxH+eHbWWNON9SLivSe12pOYv0sUgxKUMICPTBB7RMWcI/5@vger.kernel.org
X-Gm-Message-State: AOJu0YyEcAoJTrn7PGGiuL4H4hJC2JwSWOWs7MOwdcIwWMjTafkkUobr
	cperJMG3wFNH3kd9F0L+2BjT5sc2g6jedGUEw8oGVMFUDJHQxjqxwDIa0O+vYEnkBO2h8y2nNJ9
	TPLarHqgSSx8HKiXb2hsmHnGHiNJsy/w=
X-Received: by 2002:a17:906:9fca:b0:c16:61d9:1679 with SMTP id
 a640c23a62f3a-c1f1f0c4729mr26081366b.52.1784944293614; Fri, 24 Jul 2026
 18:51:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723191936.2419799-1-harshit.m.mogalapalli@oracle.com>
 <CAKYAXd--N_2nY5XPr3vNyb7Ai+xYbuR3EE4ivecVf6Eur-vC_w@mail.gmail.com>
 <20260724155307.GA7398@frogsfrogsfrogs> <CAKYAXd8Mat6dcNAnRbaNcy-9KP-OKJhbkP-W5gEQQ6JmWJPCpA@mail.gmail.com>
In-Reply-To: <CAKYAXd8Mat6dcNAnRbaNcy-9KP-OKJhbkP-W5gEQQ6JmWJPCpA@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 25 Jul 2026 10:51:21 +0900
X-Gmail-Original-Message-ID: <CAKYAXd94zxWLSMZst=jQZwSn3n=s=GSdY4F2wA79U5sx69Th4w@mail.gmail.com>
X-Gm-Features: AUfX_mw7wk4c_EqSeeQ41ErtxOcxAJBOShTGRrcDxMckvAVZwk-RxB1t216Diqc
Message-ID: <CAKYAXd94zxWLSMZst=jQZwSn3n=s=GSdY4F2wA79U5sx69Th4w@mail.gmail.com>
Subject: Re: [PATCH] exfat: preserve allocated extents for swap activation
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Yuezhang Mo <yuezhang.mo@sony.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 25, 2026 at 10:18=E2=80=AFAM Namjae Jeon <linkinjeon@kernel.org=
> wrote:
>
> On Sat, Jul 25, 2026 at 12:53=E2=80=AFAM Darrick J. Wong <djwong@kernel.o=
rg> wrote:
> >
> > On Fri, Jul 24, 2026 at 09:57:49AM +0900, Namjae Jeon wrote:
> > > On Fri, Jul 24, 2026 at 4:19=E2=80=AFAM Harshit Mogalapalli
> > > <harshit.m.mogalapalli@oracle.com> wrote:
> > > >
> > > > exFAT reports allocated ranges beyond valid_size as IOMAP_HOLE when=
ever
> > > > IOMAP_REPORT is set. iomap_swapfile_activate() also uses IOMAP_REPO=
RT
> > > > while collecting a swapfile's physical extents, so it treats the
> > > > preallocated tail as unallocated and rejects the file with -EINVAL.
> > > >
> > > > Allocated space beyond valid_size is not a hole. Keep it as
> > > > IOMAP_UNWRITTEN so iomap consumers that need physical extent identi=
ty,
> > > > such as swap activation, can still use it. The iomap seek helpers
> > > > already handle unwritten extents appropriately for SEEK_HOLE and
> > > > SEEK_DATA.
> > > >
> > > > Fixes: b4b7fe2c7cbf ("exfat: add support for SEEK_HOLE and SEEK_DAT=
A in llseek")
> > > > Assisted-by: Codex:GPT-5.6
> > > > Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.co=
m>
> > > > ---
> > > > LTP swapon/swapoff tests failed on exFAT, with this patch the tests
> > > > pass.
> > > > ---
> > > >  fs/exfat/iomap.c | 16 ++++++----------
> > > >  1 file changed, 6 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/fs/exfat/iomap.c b/fs/exfat/iomap.c
> > > > index 190fc6471f84..24d93288a432 100644
> > > > --- a/fs/exfat/iomap.c
> > > > +++ b/fs/exfat/iomap.c
> > > > @@ -105,18 +105,14 @@ static int __exfat_iomap_begin(struct inode *=
inode, loff_t offset, loff_t length
> > > >                  * marks the exact boundary between valid data and
> > > >                  * holes (or unwritten space).
> > > >                  *
> > > > -                * When IOMAP_REPORT is set (used by lseek(SEEK_HOL=
E)
> > > > -                * and SEEK_DATA), we return IOMAP_HOLE. This allow=
s
> > > > -                * iomap_seek_hole_iter() to directly return the
> > > > -                * precise byte position.
> > > > -                *
> > > > -                * For normal I/O paths (without IOMAP_REPORT) we
> > > > -                * return IOMAP_UNWRITTEN so the write path can
> > > > -                * distinguish it from a real hole.
> > > > +                * Allocated space beyond valid_size is not a hole.=
 Report it
> > > > +                * as IOMAP_UNWRITTEN so iomap consumers that need =
physical
> > > > +                * extent identity, such as swap activation, can st=
ill use it.
> > > > +                * The iomap seek helpers already handle unwritten =
extents
> > > > +                * appropriately for SEEK_HOLE and SEEK_DATA.
> > > >                  */
> > > >                 if (offset >=3D ei->valid_size) {
> > > > -                       iomap->type =3D flags & IOMAP_REPORT ?
> > > > -                               IOMAP_HOLE : IOMAP_UNWRITTEN;
> > > > +                       iomap->type =3D IOMAP_UNWRITTEN;
> > > Returning IOMAP_UNWRITTEN with IOMAP_REPORT can make SEEK_HOLE rely o=
n
> > > page-cache/block-granularity handling, which can lose the
> > > byte-accurate valid_size boundary. Before activating the swapfile,
> > > extending ->valid_size to i_size through exfat_extend_valid_size()
> > > safely zeroes the preallocated range and makes it valid for swap use.
> >
> > iomap swapfile activation can handle unwritten extents (unlike the bmap
> > activation codepath) so you probably only need to bump valid_size up to
> > the next max(PAGE_SIZE, i_blocksize) boundary.  The swap code writes
> > to the underlying disk blocks directly, bypassing the filesystem.
> That makes sense. We can call exfat_extend_valid_size() to extend
> ->valid_size only to the next page/block boundary in
> exfat_iomap_swap_activate().
Thinking about this more, returning IOMAP_UNWRITTEN for the
preallocated tail under IOMAP_REPORT would affect normal
SEEK_HOLE/SEEK_DATA as well, where we need to preserve the
byte-accurate valid_size boundary. Would extending valid_size through
the full swap-usable range, i.e.  ALIGN_DOWN(i_size, PAGE_SIZE),
before activation be the better approach? That would let us retain the
existing IOMAP_REPORT hole handling for normal seeks.
