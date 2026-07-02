Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9E034C130
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 18:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783017740; cv=pass; b=faxcrN+C1LxL5FBmnuFVh8FYO383tsPAPshtYH94HVIPuawxstMl5N1qrLBezjHEcC6LqleZvTUw3P1SDsbTrSnLHJ/+Vny+oz/BdAgf9IrBRp3uylEYTVAdAvL+LV2RDT9EQvTdIS3rD0PEUMaHQa5J3/nKIxxw4TFLLNpPEZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783017740; c=relaxed/simple;
	bh=qo5Re3OVwd7GivBqTpMKWqGTvZdlhDKHiUgYQq+J3BA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWtkZi1yDcoBX3JPgQVLTh7oejuQTJgQefBDHReG+wUuOHN17zwqRJuyQLgp+VNpzZSd487mJFn2I1pMayLxYqWz2diMcZNhAgvE/GiQEI5t+aPL0NMMusbBngh9YXD5iyytk64i1+muYY9uFmgKreqiAK5Jc1wlbvTNQ3t7rNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sRWuBtCT; arc=pass smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRWuBtCT"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-44ae264a785so1169025fac.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2026 11:42:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783017738; cv=none;
        d=google.com; s=arc-20260327;
        b=Ybn3fKTze4u74djlIioOMS1Ut/Q2RSBFfLgvsVcg5jCHxuDOXhwjimuVw5PIKR+jCr
         OSIrk3GHztHO2Tfko/CK0jj8P6GRqxgryLO7Zppkrf5DOiZjlCBdStcQ4L5HWz8kU73c
         mGP6gW8tAe/ZG6p0e7229FNTiYHYeyXdiCydFoFrYgZqz2aPNdVzLWiu5SK7vckN2KoS
         WbSxxm5n8vybSRf4yNlTMwqWvMAvyZsIvbnnDieky1azUzGvOknkqrytdHRXCQCkehqV
         ujBiWqNF6k4nAfE+/zEIdRmvuEWL/GHXERJdjnWCRt/zarNAU43iBNf52a2cNGUPE/uF
         7/Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=diWoWeRSOygR6Ew5EDc9To3quyAOQfacp2NgS+CuidU=;
        fh=3f05R44LPn5QtKTe5Ybn5txrPU91y8/U1XHlpy2T+1E=;
        b=ORjfu1W0m8cIkw5/92041fFfwIXmjeCXMo6HKpJIv81AvuLXZvzClUauv0KkoacemT
         18bgMGG2q2p6aNgsxX5pauIcJ1mTss+cpfXF38/2c55nITQD9wy9MloNaS3xUMsHSYMw
         kvFdZ037UMQBixfIUOi2VtFusUibNDzyURQXFn1OURRrqVZLCZxEcvRMUbWguST/LkRV
         +MWlioY1WEhcUOehzJTwjdQwivgcy5OWw0AA3uJ4Itz/E7rj0o35BekJpGZg8GQ+kRqG
         xufbDzx84kdyw/24MJGu6YJ+4FhKoaoZScXftNnfRBgn1VUgrhzbP5xmU7J/8dGfWea8
         HlxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783017738; x=1783622538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=diWoWeRSOygR6Ew5EDc9To3quyAOQfacp2NgS+CuidU=;
        b=sRWuBtCTYrueTLxOLzx+/6zu4y52FCtnisE2iXU37ipHCuov5Bpe6HNcU50LShmqCf
         qWfGZD9oPfl3S7iVTUrk8jF0wd+nPg3jFkJsw9rb5SFBnZdwfT2drgK2b5hVajGg/Bye
         Khbo5GuwIC6FeuDylMbnG5vUfzhP73gPXeQirx2HKV3haEwjgGMbxtvg8RC1DijAOw7G
         1W8toL011Uz0IirffTbSxJlUXV0+yxGzDHLaw489cRlIXVjTGctrxBFYlovAg6InjQlY
         fP2OT3j6+0Kij8pH0G3Fq47E0P/a1VCxiKumrPkPIDhUq0e7WqbG+4rCvZiolRZFK7bL
         JBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783017738; x=1783622538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=diWoWeRSOygR6Ew5EDc9To3quyAOQfacp2NgS+CuidU=;
        b=HlYsOwI7Tvodm3YFuZe5bvJFAKobdx2uKuUwx+pJceIYyasTUYcl6nG0yqc0vWoM+v
         mXnHJAIaVwkHzyO3iAdd5dgzK4z5flbXQCQu4URUlOAXPnBEQhnQhzYWfxii3jcvRrCg
         sa3qXJOgviD7Cu1qBiElPoOg3nvYPnDORWhGOxkiHL0C11+/anR5hoNYMVttPKjuU9td
         ho4ZZAP2m+DUreEc4Mte3FHAE4g5+LxLElVx5aOr/c4mWpevgF6HFQ6h2rLAgPRMS7Qp
         7G1TB8d4nOfSl3evQXQq8gIUIe3MdFt2nqFis2BnKnOR/tVa7d0D4UvsM19axAvdrpe+
         D/sw==
X-Gm-Message-State: AOJu0YygQd+NWsZtlnqlJu+n9w5HxC/abHSwQhwzcjZPGctRNSlZucSI
	Qa02bbyVnhpSfpqGJ6wutloK/xeMC1XyngH/KIoRxnrRcBzf5xJ7Zr5glFO/Sg2qEPlkOCoMvmz
	WzE0WjF8OiMVZrJXe2w+GLM2cXxFLslI=
X-Gm-Gg: AfdE7cn7LNlVm1cL//QZIsUET+xWQMrajS7m52IixI+KDwGy3cIvzIAyN/HPCV4E2+h
	WKklYEfJGP7AEdl/xAS7k1hxr6ePoJ6xm+qf2ouhymTck/FhEyvu4eZulxGBz9o6WjfEAI6qAmo
	JUwGcjhQIiS+592/axLLT3ibry69gYYIlIOTvhYVtrg2vhg0SKU7R0I3NGcUjjXiRMGuWPiHaol
	Vzo53RHYf1YsEtbU5ZZ5bBs2onYxWi83GK2fWN+Ga3vKzI/pmSM6DzeHvUDUtqzlekm+hgp
X-Received: by 2002:a05:6808:3a17:b0:486:560d:aa91 with SMTP id
 5614622812f47-4960eefea3amr4970815b6e.19.1783017737239; Thu, 02 Jul 2026
 11:42:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1782619718.git.jbingham@gmail.com> <20260701180035.GA6507@frogsfrogsfrogs>
In-Reply-To: <20260701180035.GA6507@frogsfrogsfrogs>
From: Jeremy Bingham <jbingham@gmail.com>
Date: Thu, 2 Jul 2026 11:42:06 -0700
X-Gm-Features: AVVi8CcCHffMy_A7KDORX9GkXIxsnYJBvZhUWfixAUGR0vTWhYEUxdJ49SXf5Vg
Message-ID: <CAMyBmMAgSQ4S30js-4mLwC1gipKAJZ0oVNCzco7qy7AWWNcJTA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] minix: convert to iomap and add direct I/O
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	brauner@kernel.org, jkoolstra@xs4all.nl, jack@suse.cz, hch@infradead.org, 
	viro@zeniv.linux.org.uk, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 11:00=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Sat, Jun 27, 2026 at 10:15:52PM -0700, Jeremy Bingham wrote:
> > The iomap.c file is #include'd into itree_v1.c and itree_v2.c rather
> > than compiled as a standalone translation unit. This is because the
> > minix filesystem versions (V1 vs V2/V3) have different block_t sizes
> > (16-bit vs 32-bit) and different indirect tree depths. This follows
> > the existing pattern in minix where itree_common.c is included into
> > both itree_v1.c and itree_v2.c. Each version provides a thin wrapper
> > and a corresponding iomap_ops struct.
>
> Yuck.  I guess that's /one/ way to avoid having a geometry struct
> capturing those details... :(

It's all absolutely hideous. I've hated the way the minix module #includes
itree_common.c like that with the separate itree_v1.c and itree_v2.c for
years, but it's also been like that for so long that changing it is
intimidating.
I could address it in this patch, if it's not out of scope. (Also I
thought I had
already responded to this, my apologies.)

> > Changes since v1:
> >
> >   * Added a fourth patch to fix the symlink and truncate issues:
> >     - Replaced page_symlink with a custom __page_symlink that writes
> >       the target directly to a data block via minix_new_block +
>
> Sounds to me like it's time to write iomap_write_symlink.
>
> int
> iomap_symlink_write(struct inode *inode, const char *target, int len,
>                 const struct iomap_ops *ops,
>                 const struct iomap_write_ops *write_ops, void *private)
> {
>         struct kvec vec =3D {
>                 .iov_base       =3D target,
>                 .iov_len        =3D len,
>         };
>         struct iomap_iter iter =3D {
>                 .inode          =3D inode,
>                 .pos            =3D 0,
>                 .len            =3D len,
>                 .flags          =3D IOMAP_WRITE,
>                 .private        =3D private,
>         };
>         struct iov_iter iov;
>         int ret;
>
>         iov_iter_kvec(&iov, ITER_SRC, &vec, 1, iov.iov_len);
>
>         while ((ret =3D iomap_iter(&iter, ops)) > 0)
>                 iter.status =3D iomap_write_iter(&iter, &iov, write_ops);
>
>         if (unlikely(iter.pos =3D=3D 0))
>                 return ret;
>
>         mark_inode_dirty(inode);
>         return 0;
> }
> EXPORT_SYMBOL_GPL(iomap_symlink_write);

Noted. I'll take this and the __page_symlink I originally made, smoosh
them together as or if needed, and put it in fs/iomap.c.

> >       sb_getblk, bypassing the aops write path (which no longer has
> >       write_begin/write_end). Added a matching custom minix_get_link
> >       that reads the target from the data block via sb_bread, similar
> >       to ext4_get_link. No iomap-based filesystem in the kernel uses
> >       page_symlink; XFS, GFS2, and ext4 all handle symlink storage
>
> That's because they embed headers and crcs in the symlink file data
> and/or do fancy things with inline targets.  xfs has its own buffer
> cache, so there's no need to duplicate it with the pagecache and then
> have to interpret ondisk formats.

Also noted.

Thanks again,

-j

> >       directly. The on-disk format is unchanged.
> >     - Fixed a buffer_head/iomap type confusion in truncate:
> >       block_truncate_page attaches buffer_heads to data folios, but
> >       minix_aops now uses iomap which interprets folio->private as
> >       struct iomap_folio_state. truncate() now dispatches between
> >       iomap_truncate_page (for regular files/symlinks) and
> >       block_truncate_page (for directories) based on the inode's aops.
> >     - Added .setattr =3D minix_setattr to minix_symlink_inode_operation=
s
> >       so symlinks truncate properly through the iomap path.
> >
> >   * Patch 1 (iomap infrastructure): minix_get_block is now exported
> >     (non-static) so the directory aops and iomap writeback path can
> >     use it. Added minix_iomap_ops_ver() inline helper and extern
> >     declarations for minix_aops and the version-specific iomap_ops.
> >     Fixed unsigned -> unsigned int in minix_blocks_needed and
> >     minix_find_first_zero_bit to silence checkpatch warnings.
> >
> >   * Patch 2 (aops conversion): unchanged in approach; minor cleanup
> >     of the writeback callback and minix_bmap conversion.
> >
> >   * Patch 3 (file operations): minix_setattr is now exported for reuse
> >     by the symlink inode operations in patch 4.
> >
> > Testing: the full series has been tested with mkfs.minix V1/V2/V3,
> > exercising file creation, read/write, overwrite, append, binary data,
> > directories, symlinks (full path, relative, directory symlinks), hard
> > links, truncation (shrink/grow), large files (1MB, exercising indirect
> > blocks), deep nesting (20 levels), 100 files in one directory,
> > deletions, remount persistence, and fsck.minix. All pass cleanly. The
> > four syzbot-reported issues are resolved.
> >
> > Jeremy Bingham (4):
> >   minix: add iomap infrastructure
> >   minix: convert address space operations to iomap
> >   minix: convert file operations to iomap and add direct I/O
> >   minix: fix symlilnk and truncate for iomap compatibility
> >
> >  fs/minix/file.c         | 157 ++++++++++++++++++++++++++++++++++++++--
> >  fs/minix/inode.c        |  90 ++++++++++++++++++++---
> >  fs/minix/iomap.c        | 114 +++++++++++++++++++++++++++++
> >  fs/minix/itree_common.c |  11 ++-
> >  fs/minix/itree_v1.c     |  25 ++++++-
> >  fs/minix/itree_v2.c     |  17 ++++-
> >  fs/minix/minix.h        |  30 +++++++-
> >  fs/minix/namei.c        | 137 ++++++++++++++++++++++++++++++++++-
> >  8 files changed, 558 insertions(+), 23 deletions(-)
> >  create mode 100644 fs/minix/iomap.c
> >
> > --
> > 2.47.3
> >
> >
