Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9045A25B08A
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 18:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782930759; cv=pass; b=Iaf2OReSMQJRB85DkrE6GGR/Q2GUf+wFWPrNBkO5f6dLDg2dFqBbUMTxsuLrkFQ2p7CHl6BuowlJJHq8kHcO8VlJ3PG7p7bePtSUDyqk8eZ1zop+bNwTfCVOLF6IccpSHWWKZuzcgNe9g7dcq89XFKj5QWBjzATK+nlu0E3QfPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782930759; c=relaxed/simple;
	bh=It259Ouc3A+yZUnoilJm4+HFW3Myc9oXVlr7H04p98E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+pPdbYUsneUmvdeuiIkt3ij43wJVTLZhPVHdbt6B2yVl/uiojOx7a2gwj7PSnJ5KXvZQUO9PQyGwvTKywH+0Whb5NFv2TpZHqx+5ovyF1dU4YvDlB/0a8A97KGNtYwfDx5hoEi34jNnH25tWbSkUikGXyq649Hc2SPxIjjFmJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyGo2q0z; arc=pass smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyGo2q0z"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-448b69cfc6dso552754fac.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 11:32:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782930756; cv=none;
        d=google.com; s=arc-20260327;
        b=PckQBq34pkJkUXxpfCR5++PZlNtnLLEQ0y/6WQar+HFJvtCNxCxrQ/p8CIJLwzWiFR
         EOxmclqcCkofoZvqLioL5mDKbDtF89ZSXYa6MvdXSM1k0xk7XwpYh2apcmSYqVQvlf8b
         Bf14IYrkQEOZ5Oh8hX5uzKquySKMUPrZb2plw0xluaqaOgy6TEUUnMYeJad6najBjgxT
         9/gmp8hEtRZPoypAXu4/2aUhZ3rjeo4zmmES35v0k2alTLZtQ5JPBGJ/3hfqwadeQuDv
         UtPqQbnpJNg2IL37fthR16o7WyHZbl7rcM8gg2GpZldNAT8ODmxaM6pIiNwsZvPorK58
         EkdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZVgckl9uI0O92Rrakj4heaOIKyoiJayF7Uzt7DBBaxU=;
        fh=3f05R44LPn5QtKTe5Ybn5txrPU91y8/U1XHlpy2T+1E=;
        b=IonomlFZ8flHe20VXIPxq7e17GYN9jJlAJjIfFXTSkv5m7DUNvXhL7LzArJhGhCG1K
         mK7XNEwTHLorMF5AA8YfYZ/pGuJEtF14G7z7FnMogP8WzHumCagU+jva2A0HrlLa9AkS
         2ZqEyyBxILFkGhIAuksXNa4LYwi3HZPy05vCl7194/gKmFMaMShHqJICYxRok1nA1/jx
         WyQNXlAgxwD1QdI18bveoU7+Hd8niD/cYueT2INICzWWoYk2LIrGkycbVaojnXCx5WYq
         tgSFKGK7F3L4tihG1qvbPDyebRrq/VevntPuxlmWxiYHxdN11QLbsxJIHhk3dfuDjf7B
         hvZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782930756; x=1783535556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVgckl9uI0O92Rrakj4heaOIKyoiJayF7Uzt7DBBaxU=;
        b=eyGo2q0zwipmiB7psMZlrfiwIzMO3r/tmmOPtcyUleq4461Uan64QsIaW7XYTc6tZR
         BR2vEweXhoV4jjiDFDpVfPiCas6uCZ+B22wdNnUWOPTQO/Ma3SIxZqCVgELeP+14C7/w
         NYwWhHmNMzaLTYnUnP705RpqLjIv6RaViKqIQxVx9nHTo+00g619H2QySGMJdORMZixu
         kgT1eS/SE8DSw7hbAmfZpSS2ePCjmVF9yp6gaYy9lNZrSGCPi11WqJgwFv2nGqhqGw/Y
         /6N2t6bui+2YQNd95ZupGDgLVee3dsx7A0e97DthnV/f8b3ivH7eQLbMiKXY8kNeV5/O
         SLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782930756; x=1783535556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZVgckl9uI0O92Rrakj4heaOIKyoiJayF7Uzt7DBBaxU=;
        b=q12cMaBGexiAsGpot2mwjk+ptgOqAW8XnR2K1L/8h5EKmWvSIZ/CEnFfIYAGeKcl6s
         JdqCLXmR/F5NxCDSVaMDSbnH3I3rA1aCbVsUm+AbIYpz6NG8HGg4ECrSoPsDUEq7CqY9
         +6EZlF927XVQKRqIgw/rhHCgevl1BNZPwCCULVJ/gPQdWGvbHTY8spgNCLnOdeJi8SrK
         eah7zHqA6o45XKej0u1HLd9vlNINbEQ8IeNA7TZAQRhOecnQKagaLrG2D/CLStYQ0UuB
         GPKruvyr1VnZaGdBuFcQXMZqIgOXreF3ch6MS4acZFOItUDhBKKMMQI5Z2ViQlM6znJw
         VPdg==
X-Gm-Message-State: AOJu0YwLheQhYhAqSU2xO5z39/CTsJqMwqoZ5tkws9D2BD/iEtbV+wTL
	zmz6+aLLpvYiPbTmvhfd0FK6eTBk0kts4+2x7Dp1x0mZFEibU5Y6h11jcx0g2GNZeWVF5AGsm4S
	sxqJKfiGnvETS4HfyFG2WOftF2U6XBnndMRr/
X-Gm-Gg: AfdE7cllmv1iGHEvxV7okrK67gmSWYei0MYcivnHkHZqefc1g9Enj8v+YXDN94zPVZ8
	5m+2gyytRWFmBRnylcv335yWUgBje2OipCbP83P6ViDCA3PZVQ9cYDiGbQu9LtOBGMmk8im6zjR
	RXG3TofR3uOu0gMYaqzWKFv42YQ1LQGxZp7fDGlLa8eU/K0XJd9eTEMvPkxNXaORUNIGHG95mJP
	g2mYIo/DOCFZHXFUxqIrVUiDTz9s5I6otz5gLqJvcVaJ3BdGGDCz0J2eOwqnXhny0Q/14DZ
X-Received: by 2002:a05:6808:3206:b0:495:e957:ff1b with SMTP id
 5614622812f47-4962422cb8emr1113681b6e.0.1782930756451; Wed, 01 Jul 2026
 11:32:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1782619718.git.jbingham@gmail.com> <041284c8aa6d5e73e834bac9842b91885d05b982.1782619718.git.jbingham@gmail.com>
 <20260701180656.GB6507@frogsfrogsfrogs>
In-Reply-To: <20260701180656.GB6507@frogsfrogsfrogs>
From: Jeremy Bingham <jbingham@gmail.com>
Date: Wed, 1 Jul 2026 11:32:26 -0700
X-Gm-Features: AVVi8CfPz2S4W6e6adByTTEcRFlyFexOCZQBd6jeuMjtPko2LFOiLKYNkixstpQ
Message-ID: <CAMyBmMCPk4yoTskRq85mcYC6g6XecaORRFkw6nxjRNUgH5cSdQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] minix: add iomap infrastructure
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	brauner@kernel.org, jkoolstra@xs4all.nl, jack@suse.cz, hch@infradead.org, 
	viro@zeniv.linux.org.uk, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 11:06=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
> > diff --git a/fs/minix/iomap.c b/fs/minix/iomap.c
> > new file mode 100644
> > index 000000000000..7bb0439e3669
> > --- /dev/null
> > +++ b/fs/minix/iomap.c
> > @@ -0,0 +1,114 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * iomap functions for minix. At least the first pass of this file was=
 taken
> > + * from the xiafs iomap.c, which is fitting since the xiafs module in =
turn
> > + * borrowed heavily from the modernized minix fs kernel module.
>
> Is this the "modernized" minix fs kernel module??

I guess it is, yeah, in that it's been updated to use iomap. The rest
of it remains pretty
ancient.

> xiafs hasn't been in the kernel for years; I see little point in
> mentioning an externally maintained driver inside the kernel source.

I simply mentioned it for context on where the iomap conversion originally =
came
from, that's all.

> > + */
> > +
> > +/*
> > + * minix_iomap_begin - map a file range to disk blocks. It acts as a r=
eplacement
> > + * for get_block in itree_common.c, at least in the important ways, an=
d is
> > + * adapted from it, but it uses iomap instead of buffer_head. This is =
taken
> > + * directly from the out-of-tree xiafs iomap changes, and the exfat io=
map
> > + * changes were an inspiration for that.
> > + */
> > +static int minix_iomap_begin(struct inode *inode, loff_t offset, loff_=
t length,
> > +     unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
> > +{
> > +     struct super_block *sb =3D inode->i_sb;
> > +     unsigned int blkbits =3D sb->s_blocksize_bits;
> > +     sector_t iblock =3D offset >> blkbits;
> > +     int create =3D flags & IOMAP_WRITE;
> > +
> > +     /* Mostly taken from modern-xiafs itree.c get_block with elements=
 from
> > +      * similar exfat operations.
> > +      */
> > +     int offsets[DEPTH];
> > +     Indirect chain[DEPTH];
> > +     Indirect *partial;
> > +     int depth =3D block_to_path(inode, iblock, offsets);
> > +     int left;
> > +     int err =3D -EIO;
> > +
> > +     sector_t phys;
> > +
> > +     /* block is beyond max file size */
> > +     if (depth =3D=3D 0)
> > +             goto out;
> > +
> > +     iomap->bdev =3D inode->i_sb->s_bdev;
> > +
> > +reread:
> > +     partial =3D get_branch(inode, depth, offsets, chain, &err);
> > +
> > +     /* Simplest case - block found, no allocation needed */
> > +     if (!partial) {
> > +             /* Bit of a weird order, but it'll make sense when you ge=
t to
> > +              * the bottom.
> > +              */
> > +             iomap->flags =3D IOMAP_F_MERGED;
> > +got_it:
> > +             phys =3D block_to_cpu(chain[depth - 1].key);
> > +             partial =3D chain+depth-1;
> > +             /* Set up the iomap struct before cleaning up */
> > +             iomap->type =3D IOMAP_MAPPED;
> > +             iomap->addr =3D (u64)phys << blkbits;
> > +             iomap->length =3D 1 << blkbits;
> > +             iomap->offset =3D (u64)iblock << blkbits;
> > +             goto cleanup;
> > +     }
> > +
> > +     /* Next simple case - plain lookup or failed read of indirect blo=
ck */
> > +     if (!create || err =3D=3D -EIO) {
> > +             iomap->type =3D IOMAP_HOLE;
> > +             iomap->addr =3D IOMAP_NULL_ADDR;
> > +             iomap->length =3D 1 << blkbits;
> > +             iomap->offset =3D (u64)iblock << blkbits;
> > +             iomap->flags =3D 0;
> > +cleanup:
> > +             while (partial > chain) {
> > +                     brelse(partial->bh);
> > +                     partial--;
> > +             }
>
> Uhhh ... these three ought to be factored out into separate helpers to
> (a) clean up @chain, (b) set up a IOMAP_MAPPED mapping, and (c) set up a
> IOMAP_HOLE mapping.  Don't write a pile of spaghetti goes.
>
> Also kinda surprised that you set IOMAP_F_MERGED but don't try to look
> forward to find adjacent blocks?

That's fair. I was sticking to the same general pattern used in get_block()=
 in
itree_common.c, but just because it's done that way in the older
function doesn't
mean that it needs to stay that way. I'll split that up.

Thank you for the comments,

-j

> > +out:
> > +             return err;
> > +     }
> > +
> > +     /*
> > +      * Indirect block might be removed by truncate while we were
> > +      * reading it. Handling of that case (forget what we've got and
> > +      * reread) is taken out of the main path.
>
> /me wonders how we'd be racing with setattr?
>
> --D

The same race would be present in get_block(), since that comment and the
following code was lifted & adapted from there because they do the same
things. I'll investigate to see if there are any races with setattr with bo=
th
functions, though, and fix them as needed.

> > +      */
> > +     if (err =3D=3D -EAGAIN)
> > +             goto changed;
> > +
> > +     left =3D (chain + depth) - partial;
> > +     err =3D alloc_branch(inode, left, offsets + (partial - chain), pa=
rtial);
> > +     if (err)
> > +             goto cleanup;
> > +
> > +     if (splice_branch(inode, chain, partial, left) < 0)
> > +             goto changed;
> > +
> > +     /* Successful allocation, mapping it. */
> > +     iomap->flags =3D IOMAP_F_NEW;
> > +     goto got_it;
> > +
> > +changed:
> > +     while (partial > chain) {
> > +             brelse(partial->bh);
> > +             partial--;
> > +     }
> > +     goto reread;
> > +}
> > +
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
> > diff --git a/fs/minix/itree_v1.c b/fs/minix/itree_v1.c
> > index 1fed906042aa..58c29f4443d3 100644
> > --- a/fs/minix/itree_v1.c
> > +++ b/fs/minix/itree_v1.c
> > @@ -49,6 +49,18 @@ static int block_to_path(struct inode * inode, long =
block, int offsets[DEPTH])
> >  }
> >
> >  #include "itree_common.c"
> > +/* NOTA BENE:
> > + *
> > + * This is icky to me, but at the same time having it be a standalone =
C file
> > + * that's compiled to object form and linked separately like it is in =
xiafs is
> > + * much nastier in minix because of the different versions of the mini=
x fs that
> > + * have some very, very different aspects, like the size of block_t. I=
 don't
> > + * like it, but since minix already has this pattern where a common it=
ree file
> > + * is included in the itree_v1 and itree_v2(and v3) files, I'm includi=
ng iomap.c
> > + * in these files as well. It does at least avoid exporting some curre=
ntly
> > + * static functions that aren't needed anywhere but itree_common.c and=
 iomap.c.
> > + */
> > +#include "iomap.c"
> >
> >  int V1_minix_get_block(struct inode * inode, long block,
> >                       struct buffer_head *bh_result, int create)
> > @@ -61,7 +73,18 @@ void V1_minix_truncate(struct inode * inode)
> >       truncate(inode);
> >  }
> >
> > -unsigned V1_minix_blocks(loff_t size, struct super_block *sb)
> > +unsigned int V1_minix_blocks(loff_t size, struct super_block *sb)
> >  {
> >       return nblocks(size, sb);
> >  }
> > +
> > +int V1_minix_iomap_begin(struct inode *inode, loff_t offset, loff_t le=
ngth,
> > +     unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
> > +{
> > +     return minix_iomap_begin(inode, offset, length, flags, iomap, src=
map);
> > +}
> > +
> > +const struct iomap_ops V1_minix_iomap_ops =3D {
> > +     .iomap_begin =3D V1_minix_iomap_begin,
> > +     .iomap_end   =3D minix_iomap_end,
> > +};
> > diff --git a/fs/minix/itree_v2.c b/fs/minix/itree_v2.c
> > index 9d00f31a2d9d..fc7a5ae8fa1c 100644
> > --- a/fs/minix/itree_v2.c
> > +++ b/fs/minix/itree_v2.c
> > @@ -57,6 +57,10 @@ static int block_to_path(struct inode * inode, long =
block, int offsets[DEPTH])
> >  }
> >
> >  #include "itree_common.c"
> > +/* See the note in itree_v1 in a comment that starts "NOTA BENE" for a=
n
> > + * explanation for why iomap.c is included here.
> > + */
> > +#include "iomap.c"
> >
> >  int V2_minix_get_block(struct inode * inode, long block,
> >                       struct buffer_head *bh_result, int create)
> > @@ -69,7 +73,18 @@ void V2_minix_truncate(struct inode * inode)
> >       truncate(inode);
> >  }
> >
> > -unsigned V2_minix_blocks(loff_t size, struct super_block *sb)
> > +unsigned int V2_minix_blocks(loff_t size, struct super_block *sb)
> >  {
> >       return nblocks(size, sb);
> >  }
> > +
> > +int V2_minix_iomap_begin(struct inode *inode, loff_t offset, loff_t le=
ngth,
> > +     unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
> > +{
> > +     return minix_iomap_begin(inode, offset, length, flags, iomap, src=
map);
> > +}
> > +
> > +const struct iomap_ops V2_minix_iomap_ops =3D {
> > +     .iomap_begin =3D V2_minix_iomap_begin,
> > +     .iomap_end   =3D minix_iomap_end,
> > +};
> > diff --git a/fs/minix/minix.h b/fs/minix/minix.h
> > index f2025c9b5825..77e503cca97f 100644
> > --- a/fs/minix/minix.h
> > +++ b/fs/minix/minix.h
> > @@ -5,6 +5,7 @@
> >  #include <linux/fs.h>
> >  #include <linux/pagemap.h>
> >  #include <linux/minix_fs.h>
> > +#include <linux/iomap.h>
> >
> >  #define INODE_VERSION(inode) minix_sb(inode->i_sb)->s_version
> >  #define MINIX_V1             0x0001          /* original minix fs */
> > @@ -69,6 +70,8 @@ extern int V1_minix_get_block(struct inode *, long, s=
truct buffer_head *, int);
> >  extern int V2_minix_get_block(struct inode *, long, struct buffer_head=
 *, int);
> >  extern unsigned V1_minix_blocks(loff_t, struct super_block *);
> >  extern unsigned V2_minix_blocks(loff_t, struct super_block *);
> > +extern int minix_get_block(struct inode *inode, sector_t block,
> > +                 struct buffer_head *bh_result, int create);
> >
> >  struct minix_dir_entry *minix_find_entry(struct dentry *, struct folio=
 **);
> >  int minix_add_link(struct dentry*, struct inode*);
> > @@ -80,10 +83,20 @@ int minix_set_link(struct minix_dir_entry *de, stru=
ct folio *folio,
> >  struct minix_dir_entry *minix_dotdot(struct inode*, struct folio **);
> >  ino_t minix_inode_by_name(struct dentry*);
> >
> > +extern int V1_minix_iomap_begin(struct inode *inode, loff_t offset,
> > +     loff_t length, unsigned int flags, struct iomap *iomap,
> > +     struct iomap *srcmap);
> > +extern int V2_minix_iomap_begin(struct inode *inode, loff_t offset,
> > +     loff_t length, unsigned int flags, struct iomap *iomap,
> > +     struct iomap *srcmap);
> > +
> > +extern const struct address_space_operations minix_aops;
> >  extern const struct inode_operations minix_file_inode_operations;
> >  extern const struct inode_operations minix_dir_inode_operations;
> >  extern const struct file_operations minix_file_operations;
> >  extern const struct file_operations minix_dir_operations;
> > +extern const struct iomap_ops V1_minix_iomap_ops;
> > +extern const struct iomap_ops V2_minix_iomap_ops;
> >
> >  static inline struct minix_sb_info *minix_sb(struct super_block *sb)
> >  {
> > @@ -95,11 +108,17 @@ static inline struct minix_inode_info *minix_i(str=
uct inode *inode)
> >       return container_of(inode, struct minix_inode_info, vfs_inode);
> >  }
> >
> > -static inline unsigned minix_blocks_needed(unsigned bits, unsigned blo=
cksize)
> > +static inline unsigned int minix_blocks_needed(unsigned int bits, unsi=
gned int blocksize)
> >  {
> >       return DIV_ROUND_UP(bits, blocksize * 8);
> >  }
> >
> > +static inline const struct iomap_ops *minix_iomap_ops_ver(struct inode=
 *inode)
> > +{
> > +     return (INODE_VERSION(inode) =3D=3D MINIX_V1) ?
> > +             &V1_minix_iomap_ops : &V2_minix_iomap_ops;
> > +}
> > +
> >  #if defined(CONFIG_MINIX_FS_NATIVE_ENDIAN) && \
> >       defined(CONFIG_MINIX_FS_BIG_ENDIAN_16BIT_INDEXED)
> >
> > @@ -129,7 +148,7 @@ static inline unsigned minix_blocks_needed(unsigned=
 bits, unsigned blocksize)
> >   * big-endian 16bit indexed bitmaps
> >   */
> >
> > -static inline int minix_find_first_zero_bit(const void *vaddr, unsigne=
d size)
> > +static inline int minix_find_first_zero_bit(const void *vaddr, unsigne=
d int size)
> >  {
> >       const unsigned short *p =3D vaddr, *addr =3D vaddr;
> >       unsigned short num;
> > --
> > 2.47.3
> >
> >
