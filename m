Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEE8284690
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 18:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782931043; cv=pass; b=b7sG1vOgIpBTrPH0mBY8mMmDEB6HI5OX27ctjnkFG7RmhOZv5ZheG3Zdk8zNph3y9GzwWSalAvHan5gwJuzBnBgJ3FhvuSYvGYJ162AWpJlFE86AIhX1Gi0e248idxryO2xI+ck8SMB9Qv76+wanbKbrmhYimdN+e2PuAGCGr8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782931043; c=relaxed/simple;
	bh=86T8HGijUmG5N3Wrv32g/qlBPVVulMZCiBUGVeDWSI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e7Xb5SChbAbmMCdr6gu9FSckYwrgO9vjxkWogbqnS8cxPvx6XZ+HSTv37kQoVzwyLW7Fdxi0UyE3LAcnQNlBy3Y/XVzxA4Y3WYsXCdljayQve42RHUcIgFgr7QvbHOjFTxyu48mCnBjNlYxUeCEahMl9sfGiqvMd0vj6Yy9dycE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AoYPNg+W; arc=pass smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoYPNg+W"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4973695df9eso112579b6e.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 11:37:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782931041; cv=none;
        d=google.com; s=arc-20260327;
        b=oXY0t5udgJHrPN+BLWDC6omNsMF0+7mbKQdZ6xH+5Nq/lg0elHbNKWDTxt0ISyHYAk
         ymT/T3l688bcFR4vOSJqO4Irr7StrGHkLDzEYqTMN4/LnRUYPJ/S9zyncGKdEJkDZQ9m
         QeQPDwNatTDe8uf7HAFfrrnMHQ+sI+harcdp8tF9znK7+CEgWIEncKUx2sOPgSKpKl/h
         8MJ0J93C7qvVwhAlLNwWhpL5mxOquZyohypZl9l+soyC6yxH0QMrjC1jwZOVd1F/pXDR
         Xj/eoiAZ2nFZ9wKmjqPHYOXELMXIgUyBinUjWO2hjX5ggMepvfhMjJGED8oQQ8Z2SbgH
         GUPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3HBDewaD3Efzdr4Gk80MXrAZSgsR1/XHSGJsiRHAcRg=;
        fh=3f05R44LPn5QtKTe5Ybn5txrPU91y8/U1XHlpy2T+1E=;
        b=JsN/wQmjfIJQlZafrvVHIoJZMSitU3P+vBQSevebk39jz3eZUlZ8aI7cmrRkpi/FCu
         KKrzY0WYr56wC0kD/goyJXqjine/VwBPOviGAMYiSCml7d4jQ1huZvwvmMHw6suQm9s7
         BElJA1VQtgXr7RMQo5UaSMO9fn5vBdEIueNi3lks0fwOhzE055YQq6G7mXmVLy5rK5XG
         52/USz+J+BYL/bzFq89rjk4lW+i11IqyxU8crTHsVyPv5C/GzMZFGPgy1BZnjPb8nvl5
         XKvjJrvl/lIIO/Xo1mJ5jTAu73oGbZK32QbTMENQ07kL6KzVzKYilr88UTsNW8OfWJbN
         QQMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782931041; x=1783535841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HBDewaD3Efzdr4Gk80MXrAZSgsR1/XHSGJsiRHAcRg=;
        b=AoYPNg+WxOBJIQOoe4ZcT9hZUiKMJfM54HQqo42bKEh2X3i46gu3Zn17Lxome+D3Zd
         rYefXGoptOPxift0J0OBEhViMbJXBzqyzgaeLcB9RUXJYlwxywkv1uAnlyoZR4t7px/C
         VSm6iIlEQ0ELGLlnRJAnoN+B6XCuNNDahKhHy2h6GEIrY94e6YPxO88wZ4znB1nrzgRY
         HioQoqWQ90sjqNkkBa8WK7fQfVoa5Japr/DeEG4NSjyqVtyzR0nlswAmyrFqOYjQB8jM
         ZGOpZSKSl2SwgZVmjQOlRIzIRaXVQI4yAK5gm4kNjF/UKLAe16Y3Pw6VPnKcQsXmVWDu
         QNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782931041; x=1783535841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3HBDewaD3Efzdr4Gk80MXrAZSgsR1/XHSGJsiRHAcRg=;
        b=hprGGeqvtIFhwJ3E9kyMHjmssmbRGgqCzt23gaMimX1JuR1rJXbptJcTHZNeZR9cZa
         8NzqFrc6XB2NYopqeNqQJP3LX2j3AvA429E46LCUM3ruJoC+fH3OoSqTzDo8JXfdwlow
         0eCT3pMo0BwHPrw6KsGsRYoVTiEJFg0n0GZDIxO1md8BwMm/n3rGrGxTEa4XNas5QkXG
         yeCt1Mb14C6SlgRpyRs2TmUfIWp7Xvp4lMcI+0hIdC4EJlKQhSHbeSVAL/MPz3W9seKJ
         6fuHliRqQxmSI2zMiEvissFAZ+2lYHuSQYSxlJ4VBrXLamIPiTb3MG3N5fzoMLevL3DG
         1SUQ==
X-Gm-Message-State: AOJu0YwzTgRD517JvQNLqoFzLvwBS479iZwLYpPpg/VBbwn894cjyeBg
	a2LKuM1UByXfXfwtXqzy2FJsooeeKQjeDQiArQcTPfJZK9qJ5SjxELqmVhLTgifI09lk7NfTG6f
	G3B1128RetwijEPp+Jb6ZQs2+iCrjooI=
X-Gm-Gg: AfdE7cneaJrEPLEkLJNeNgfZTsPQq86Ikq+uX7Fwg6swReU6tLjJ9iPl9AVfEdzaPvL
	dkd0j4AWjF4hnjlhdCrrIvkYb4271lp0gAj6ikUTVk0To4ZWrTwTS6TGy5Sa094ud+VScLZa9st
	PBy5eITTHjUvKrJLTWN9Gukj7P/8N0dAzP9V85doVJpbuvT6aCyEs2dRdcnVxxGmTt1PsABas7F
	kDsaNFV7U8oW/vEnbuCuuLAuTFFVdayWD5TyTKKRgEwUI4bmIS97pcDW/uEVGc/FmIrU99P/Zox
	cNMzVpk=
X-Received: by 2002:a05:6808:a60b:b0:496:1c0a:d4c9 with SMTP id
 5614622812f47-4961c0ad5ebmr1130133b6e.19.1782931040933; Wed, 01 Jul 2026
 11:37:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1782619718.git.jbingham@gmail.com> <7060fde4f164617c58eeac616a40e5bd89b921d2.1782619718.git.jbingham@gmail.com>
 <20260701181451.GC6507@frogsfrogsfrogs>
In-Reply-To: <20260701181451.GC6507@frogsfrogsfrogs>
From: Jeremy Bingham <jbingham@gmail.com>
Date: Wed, 1 Jul 2026 11:37:10 -0700
X-Gm-Features: AVVi8CeTc1DEHRCX5d1VQpw1wWNNWRDM11fe42LKDhSY5ofxjjwgTSlCxHSVz94
Message-ID: <CAMyBmMCVQpA+X_M6nH1nx6O-QCfng2OWqrDWOxcL7qNohE797Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] minix: convert address space operations to iomap
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	brauner@kernel.org, jkoolstra@xs4all.nl, jack@suse.cz, hch@infradead.org, 
	viro@zeniv.linux.org.uk, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 11:14=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Sat, Jun 27, 2026 at 10:15:54PM -0700, Jeremy Bingham wrote:
> > Convert minix regular file and symlink address space operations from
> > buffer_head to iomap. The new minix_aops uses iomap_dirty_folio,
> > iomap_invalidate_folio, iomap_bio_read_folio, iomap_bio_readahead,
> > iomap_writepages, iomap_bmap, and related iomap helpers.
> > The write_begin/write_end callbacks are removed since buffered writes
> > now go through iomap_file_buffered_write in file.c.
> >
> > Directories keep using buffer_heads via a new minix_dir_aops, which
> > retains the old block_dirty_folio, block_read_full_folio,
> > block_write_begin, generic_write_end, and mpage_writepages. This is
> > necessary because directory entry manipulation (minix_prepare_chunk,
> > minix_write_begin) still uses the buffer_head chunk protocol.
> >
> > minix_bmap is converted from generic_block_bmap to iomap_bmap.
>
> I'd drop BMAP support entirely, unless you know of people who use LILO
> and minixfs.  If all you want is swapfile activation, use
> iomap_swapfile_activate... assuming that anyone actually cares about
> hosting swapfiles on minixfs.

I'm not dead set against dropping BMAP support entirely, but is there a
compelling reason to drop it?

Thanks,

-j

> > The minix_get_block function is exported (non-static) so the
> > directory aops can still use it for block_write_begin and
> > mpage_writepages.
> >
> > Signed-off-by: Jeremy Bingham <jbingham@gmail.com>
> > ---
> >  fs/minix/inode.c | 86 +++++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 78 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/minix/inode.c b/fs/minix/inode.c
> > index c30cc590698d..2ba6766fce51 100644
> > --- a/fs/minix/inode.c
> > +++ b/fs/minix/inode.c
> > @@ -436,7 +436,32 @@ static int minix_statfs(struct dentry *dentry, str=
uct kstatfs *buf)
> >       return 0;
> >  }
> >
> > -static int minix_get_block(struct inode *inode, sector_t block,
> > +static ssize_t minix_writeback_range(struct iomap_writepage_ctx *wpc,
> > +     struct folio *folio, u64 pos, unsigned int len, u64 end_pos)
> > +{
> > +     int error;
> > +
> > +     if (pos < wpc->iomap.offset ||
> > +                     pos >=3D wpc->iomap.offset + wpc->iomap.length) {
> > +             if (INODE_VERSION(wpc->inode) =3D=3D MINIX_V1)
> > +                     error =3D V1_minix_iomap_begin(wpc->inode, pos, l=
en, IOMAP_WRITE,
> > +                             &wpc->iomap, NULL);
> > +             else
> > +                     error =3D V2_minix_iomap_begin(wpc->inode, pos, l=
en, IOMAP_WRITE,
> > +                             &wpc->iomap, NULL);
> > +             if (error)
> > +                     return error;
> > +     }
> > +
> > +     return iomap_add_to_ioend(wpc, folio, pos, end_pos, len);
> > +}
> > +
> > +static const struct iomap_writeback_ops minix_writeback_ops =3D {
> > +     .writeback_range =3D minix_writeback_range,
> > +     .writeback_submit =3D iomap_ioend_writeback_submit,
> > +};
> > +
> > +int minix_get_block(struct inode *inode, sector_t block,
> >                   struct buffer_head *bh_result, int create)
> >  {
> >       if (INODE_VERSION(inode) =3D=3D MINIX_V1)
> > @@ -445,17 +470,45 @@ static int minix_get_block(struct inode *inode, s=
ector_t block,
> >               return V2_minix_get_block(inode, block, bh_result, create=
);
> >  }
> >
> > -static int minix_writepages(struct address_space *mapping,
> > +/* The old minix_writepages, preserved for directory operations. */
> > +static int minix_block_writepages(struct address_space *mapping,
> >               struct writeback_control *wbc)
> >  {
> >       return mpage_writepages(mapping, wbc, minix_get_block);
> >  }
> >
> > +static int minix_writepages(struct address_space *mapping,
> > +             struct writeback_control *wbc)
> > +{
> > +     struct iomap_writepage_ctx wpc =3D {
> > +             .inode =3D mapping->host,
> > +             .wbc =3D wbc,
> > +             .ops =3D &minix_writeback_ops,
> > +     };
> > +     return iomap_writepages(&wpc);
> > +}
> > +
> >  static int minix_read_folio(struct file *file, struct folio *folio)
> > +{
> > +     const struct iomap_ops *ops =3D minix_iomap_ops_ver(folio->mappin=
g->host);
> > +
> > +     iomap_bio_read_folio(folio, ops);
> > +     return 0;
> > +}
> > +
> > +/* The old minix_read_folio, preserved for directory operations. */
> > +static int minix_block_read_folio(struct file *file, struct folio *fol=
io)
> >  {
> >       return block_read_full_folio(folio, minix_get_block);
> >  }
> >
> > +static void minix_readahead(struct readahead_control *rac)
> > +{
> > +     const struct iomap_ops *ops =3D minix_iomap_ops_ver(rac->mapping-=
>host);
> > +
> > +     iomap_bio_readahead(rac, ops);
> > +}
> > +
> >  int minix_prepare_chunk(struct folio *folio, loff_t pos, unsigned len)
> >  {
> >       return __block_write_begin(folio, pos, len, minix_get_block);
> > @@ -487,19 +540,36 @@ static int minix_write_begin(const struct kiocb *=
iocb,
> >
> >  static sector_t minix_bmap(struct address_space *mapping, sector_t blo=
ck)
> >  {
> > -     return generic_block_bmap(mapping,block,minix_get_block);
> > +     const struct iomap_ops *ops =3D minix_iomap_ops_ver(mapping->host=
);
> > +
> > +     return iomap_bmap(mapping, block, ops);
> >  }
> >
> > -static const struct address_space_operations minix_aops =3D {
> > -     .dirty_folio    =3D block_dirty_folio,
> > -     .invalidate_folio =3D block_invalidate_folio,
> > +const struct address_space_operations minix_aops =3D {
> > +     .dirty_folio    =3D iomap_dirty_folio,
> > +     .invalidate_folio =3D iomap_invalidate_folio,
> >       .read_folio =3D minix_read_folio,
> > +     .readahead =3D minix_readahead,
> >       .writepages =3D minix_writepages,
> > +     .migrate_folio =3D filemap_migrate_folio,
> > +     .bmap =3D minix_bmap,
> > +     .is_partially_uptodate =3D iomap_is_partially_uptodate,
> > +     .release_folio =3D iomap_release_folio,
> > +     .error_remove_folio =3D generic_error_remove_folio,
> > +};
> > +
> > +/* A special aops for directories that keeps using the buffer head chu=
nks, at
> > + * least for the time being.
> > + */
> > +static const struct address_space_operations minix_dir_aops =3D {
> > +     .dirty_folio =3D block_dirty_folio,
> > +     .invalidate_folio =3D block_invalidate_folio,
> > +     .read_folio =3D minix_block_read_folio,
> >       .write_begin =3D minix_write_begin,
> >       .write_end =3D generic_write_end,
> >       .migrate_folio =3D buffer_migrate_folio,
> >       .bmap =3D minix_bmap,
> > -     .direct_IO =3D noop_direct_IO
>
> I forget, does one have to set FMODE_CAN_ODIRECT if the address_space
> operations don't supply a ->direct_IO function?
>
> --D
>
> > +     .writepages =3D minix_block_writepages,
> >  };
> >
> >  static const struct inode_operations minix_symlink_inode_operations =
=3D {
> > @@ -516,7 +586,7 @@ void minix_set_inode(struct inode *inode, dev_t rde=
v)
> >       } else if (S_ISDIR(inode->i_mode)) {
> >               inode->i_op =3D &minix_dir_inode_operations;
> >               inode->i_fop =3D &minix_dir_operations;
> > -             inode->i_mapping->a_ops =3D &minix_aops;
> > +             inode->i_mapping->a_ops =3D &minix_dir_aops;
> >       } else if (S_ISLNK(inode->i_mode)) {
> >               inode->i_op =3D &minix_symlink_inode_operations;
> >               inode_nohighmem(inode);
> > --
> > 2.47.3
> >
> >
