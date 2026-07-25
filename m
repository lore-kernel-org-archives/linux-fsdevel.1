Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01BB3368BF
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 04:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784955554; cv=none; b=nrXlt+me7iuyjJ6MKxdWnj07QneTlSQFYa/2bdqpMtaH/vjggU0TQkWlCmO6dSCKJr7rSinVXrc3TH4i9D0eJfJ0L+u4QZz+922+wZHdplrt1OnaLcq/4o+6UF5lIf7H3iwfqmMj+Gin7steMpW8VHIp1KCLR42xvIzh/nxgxhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784955554; c=relaxed/simple;
	bh=0aGZ0rD1zDzW0H8VjS/WryH5fjZzTnbUIC8Z33E3/q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kbc1zO3Eu/D4mdSvuGKgzM44SubiW1B5pvOWExWyTWjPHCoomBuhSB1xEbejoGsoA93epvu9vDgqpUQ1bJQ1qph8VZVTOZ5P37cypA6ixQBqJovqWISf2mX122mAJKyyiO+vDsTJW4zvkcjaHW7/vEl7rDloWAKdWGzz45qva/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ma5rbSqk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ma5rbSqk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790B11F00AC4
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 04:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784955552;
	bh=RXuKCrZYa+wXng6gAFvrG8/SAXu8bQWv2J7znLd5bqE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ma5rbSqkp/pvcSkUnX8iNsLNxxt7YWEWTG++KLHAJbuaudeGu/iCwC0NQRcZe+Uev
	 rMCl0yaTJcUjS9bTrTZ45GQnZdYRLjVe5ZpWb7F2v4HjxHFZZPdyMTPKNEpkrp86Qb
	 iAztYDOwaY/1EBgYiF6UKtfLsMy9vYIzZzqhY57GdsO/YQYu8TUQ8EWYjl3FX+uJ/+
	 h9Igxbiul5gRw8wZbVMNoTgaKiOP4XkpApaW5pXCttI0E8DJLrACDxP0MPxPLSxoVD
	 rgcEapgb7eHTnVn0vpWvAZrTjQrPla5TECZvi+DmV1swwTPyubfkZUm4ccjOyJoArO
	 hm6MhuOqebSDg==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6983f20a8bfso1696835a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 21:59:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rpkpfd55WnB4GWYSCmeYtO6Vnk2PomCiQS95z+Mv1+kUzOF3Iyd8AcdYuy3Wo0+inyLqZyFYy2W+79v1J10@vger.kernel.org
X-Gm-Message-State: AOJu0YykIBH4+794KdaSUvrPz2Nr+OI3eZ1oEMZjtTrXaT5a+fn7xm9h
	qLVUZWpvr55rxYSagIVlYL+hECPJ851Re7EGgBVbUJRUJX/foPdVBdvJ/J8QanYQXRAHTS+f7zj
	S3EPR/2HCYcmA9Kigul3Fha8nIfoaQcE=
X-Received: by 2002:a17:906:9f88:b0:c15:e5f4:63fb with SMTP id
 a640c23a62f3a-c1f1f1797d9mr41818766b.59.1784955551080; Fri, 24 Jul 2026
 21:59:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723191936.2419799-1-harshit.m.mogalapalli@oracle.com>
 <CAKYAXd--N_2nY5XPr3vNyb7Ai+xYbuR3EE4ivecVf6Eur-vC_w@mail.gmail.com>
 <20260724155307.GA7398@frogsfrogsfrogs> <CAKYAXd8Mat6dcNAnRbaNcy-9KP-OKJhbkP-W5gEQQ6JmWJPCpA@mail.gmail.com>
 <CAKYAXd94zxWLSMZst=jQZwSn3n=s=GSdY4F2wA79U5sx69Th4w@mail.gmail.com> <20260725042607.GD7398@frogsfrogsfrogs>
In-Reply-To: <20260725042607.GD7398@frogsfrogsfrogs>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 25 Jul 2026 13:58:58 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_nGWA1UUP3TpVzpB6QpiFkXLMX6au86Agr_haBinwwdA@mail.gmail.com>
X-Gm-Features: AUfX_mzLlOGm4_UiThyEsz1a3nZwuXGXleAv1qnXBE_he2O6-ee24GZORDZeIqs
Message-ID: <CAKYAXd_nGWA1UUP3TpVzpB6QpiFkXLMX6au86Agr_haBinwwdA@mail.gmail.com>
Subject: Re: [PATCH] exfat: preserve allocated extents for swap activation
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Yuezhang Mo <yuezhang.mo@sony.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 25, 2026 at 1:26=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Sat, Jul 25, 2026 at 10:51:21AM +0900, Namjae Jeon wrote:
> > On Sat, Jul 25, 2026 at 10:18=E2=80=AFAM Namjae Jeon <linkinjeon@kernel=
.org> wrote:
> > >
> > > On Sat, Jul 25, 2026 at 12:53=E2=80=AFAM Darrick J. Wong <djwong@kern=
el.org> wrote:
> > > >
> > > > On Fri, Jul 24, 2026 at 09:57:49AM +0900, Namjae Jeon wrote:
> > > > > On Fri, Jul 24, 2026 at 4:19=E2=80=AFAM Harshit Mogalapalli
> > > > > <harshit.m.mogalapalli@oracle.com> wrote:
> > > > > >
> > > > > > exFAT reports allocated ranges beyond valid_size as IOMAP_HOLE =
whenever
> > > > > > IOMAP_REPORT is set. iomap_swapfile_activate() also uses IOMAP_=
REPORT
> > > > > > while collecting a swapfile's physical extents, so it treats th=
e
> > > > > > preallocated tail as unallocated and rejects the file with -EIN=
VAL.
> > > > > >
> > > > > > Allocated space beyond valid_size is not a hole. Keep it as
> > > > > > IOMAP_UNWRITTEN so iomap consumers that need physical extent id=
entity,
> > > > > > such as swap activation, can still use it. The iomap seek helpe=
rs
> > > > > > already handle unwritten extents appropriately for SEEK_HOLE an=
d
> > > > > > SEEK_DATA.
> > > > > >
> > > > > > Fixes: b4b7fe2c7cbf ("exfat: add support for SEEK_HOLE and SEEK=
_DATA in llseek")
> > > > > > Assisted-by: Codex:GPT-5.6
> > > > > > Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracl=
e.com>
> > > > > > ---
> > > > > > LTP swapon/swapoff tests failed on exFAT, with this patch the t=
ests
> > > > > > pass.
> > > > > > ---
> > > > > >  fs/exfat/iomap.c | 16 ++++++----------
> > > > > >  1 file changed, 6 insertions(+), 10 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/exfat/iomap.c b/fs/exfat/iomap.c
> > > > > > index 190fc6471f84..24d93288a432 100644
> > > > > > --- a/fs/exfat/iomap.c
> > > > > > +++ b/fs/exfat/iomap.c
> > > > > > @@ -105,18 +105,14 @@ static int __exfat_iomap_begin(struct ino=
de *inode, loff_t offset, loff_t length
> > > > > >                  * marks the exact boundary between valid data =
and
> > > > > >                  * holes (or unwritten space).
> > > > > >                  *
> > > > > > -                * When IOMAP_REPORT is set (used by lseek(SEEK=
_HOLE)
> > > > > > -                * and SEEK_DATA), we return IOMAP_HOLE. This a=
llows
> > > > > > -                * iomap_seek_hole_iter() to directly return th=
e
> > > > > > -                * precise byte position.
> > > > > > -                *
> > > > > > -                * For normal I/O paths (without IOMAP_REPORT) =
we
> > > > > > -                * return IOMAP_UNWRITTEN so the write path can
> > > > > > -                * distinguish it from a real hole.
> > > > > > +                * Allocated space beyond valid_size is not a h=
ole. Report it
> > > > > > +                * as IOMAP_UNWRITTEN so iomap consumers that n=
eed physical
> > > > > > +                * extent identity, such as swap activation, ca=
n still use it.
> > > > > > +                * The iomap seek helpers already handle unwrit=
ten extents
> > > > > > +                * appropriately for SEEK_HOLE and SEEK_DATA.
> > > > > >                  */
> > > > > >                 if (offset >=3D ei->valid_size) {
> > > > > > -                       iomap->type =3D flags & IOMAP_REPORT ?
> > > > > > -                               IOMAP_HOLE : IOMAP_UNWRITTEN;
> > > > > > +                       iomap->type =3D IOMAP_UNWRITTEN;
> > > > > Returning IOMAP_UNWRITTEN with IOMAP_REPORT can make SEEK_HOLE re=
ly on
> > > > > page-cache/block-granularity handling, which can lose the
> > > > > byte-accurate valid_size boundary. Before activating the swapfile=
,
> > > > > extending ->valid_size to i_size through exfat_extend_valid_size(=
)
> > > > > safely zeroes the preallocated range and makes it valid for swap =
use.
> > > >
> > > > iomap swapfile activation can handle unwritten extents (unlike the =
bmap
> > > > activation codepath) so you probably only need to bump valid_size u=
p to
> > > > the next max(PAGE_SIZE, i_blocksize) boundary.  The swap code write=
s
> > > > to the underlying disk blocks directly, bypassing the filesystem.
> > > That makes sense. We can call exfat_extend_valid_size() to extend
> > > ->valid_size only to the next page/block boundary in
> > > exfat_iomap_swap_activate().
> > Thinking about this more, returning IOMAP_UNWRITTEN for the
> > preallocated tail under IOMAP_REPORT would affect normal
> > SEEK_HOLE/SEEK_DATA as well, where we need to preserve the
> > byte-accurate valid_size boundary. Would extending valid_size through
> > the full swap-usable range, i.e.  ALIGN_DOWN(i_size, PAGE_SIZE),
> > before activation be the better approach? That would let us retain the
> > existing IOMAP_REPORT hole handling for normal seeks.
>
> Manually zeroing by pushing valid_size out would also work, but that's a
> lot of zeroes to write to the storage, flash wearout, blah blah blah.
> In the ideal world the whole swapfile would be all unwritten blocks
> (except the swapfile header) so that nobody could reread the swapfile
> contents after swapoff.
I do not have a good idea for resolving these two conflicting
requirements, other than simply not supporting swapfiles on exFAT...
