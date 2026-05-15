Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536873DF019
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 20:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778877230; cv=pass; b=HklFBzeCQUKhekmLnoMBa/bGmSwp2zWJjydMw/rs+CQ2fL320M2nE6Yr7JlbCQobAgIzNjQusSrVm0uqIgx0i/4dEyBrvGexc0vliKR8V0YNd4aLxiWoh7tr8kGfmzdTKKSaiuxNNZx3PZOhljLsCCssNoJC7LrZHoiiju2sJ9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778877230; c=relaxed/simple;
	bh=sJ08cfxGxtMWEPXCgzYLZJMNbjtpjryi3KoiukkfceI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u62biQWNCiAmpJWyly8FDY6tvYqurZKx7qzEqv8PkG9h58TuzgBo57lwjSAGQbthj83KKd98Ujs4l4jpO24qzajorPr5zoEI/ZW9NaR6gRu9q92hx5W28RAGx0Ztf0g5y731kKf0q6KGmYN9Sn1+bSZkHeGrW1Dd1ssV5WZn/3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/q/+TXk; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/q/+TXk"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-676a89de629so483232a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 13:33:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778877227; cv=none;
        d=google.com; s=arc-20240605;
        b=TvJfnhdWRtzsIEX5mSbT7kZcokTwICAt6Tz8uAd06EocEf9KKLUkl8dayLHulZOtaS
         KhJ9QYHAO7R0qbhfIHyIWEP8Mebhvb7l7QRF3xBKwLMLimbrWP1QhfIlzYs6cwqXY9el
         g81nodCXIfhlCR1Mo9kyIrX5UZRpvP6WizVw+HriST/92mf2vhirBAGzZM8VocZwR2A1
         lok4AqUNsgQumCnfpt+IzDjwZD8B0z//7WIu71Tm7MAh2JaHujigyrqZ9gicJ+h765Xf
         k4d0IlEi9GhFPl6YRXMCz+7H+1PTRU5Iqj6C2Kyhe44efDaWhRWOzaA/VrS5pMK/nOQF
         AqsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9YwlJJcvYwY8fns8m48KGL1VHm6uk+SQqlLXYhIKgz8=;
        fh=7i2Dt8HEbakhIURiTOWNuciinz3D/mFlhftI71mx30U=;
        b=JlNSxodAEx+5IWLMxQHVjDdSLqSyqjyeV6Zl4BIrYEpzerdA5ppSM4jtTdlXzK1OtT
         0mHznAx/LlQWCGLxjWKHtdstkZujfyXgWkofnPJkSN8bcKtABIo5Faxl+TMBazDUCo59
         mH+dSRbbnLPXzu71uBhYuVzNnirkpSr9EvR8bLxD1TwJkyEbtbX4PK8LZRm0DAFChWhv
         G2QQflcylJx1grpLnkOv9ojnUdQNWB44t2GMqXOiurBr1rc7Ia0ErfBLpxtAHWoEqrD/
         TkbgAV1MGC1nhmuon3Kb72G4PiUzj9FWvIh2ZV8Jy40Eb4Y6s1pqnGmgKmKm8E4KbsfR
         EaBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778877227; x=1779482027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YwlJJcvYwY8fns8m48KGL1VHm6uk+SQqlLXYhIKgz8=;
        b=K/q/+TXkqRzFxSVtpb4xM/CeweHbODVoHJmIYU5p64xeeJyIzw8hPqgn323zCqxWkg
         ruq0OdxNgVTaWacOpOfdBJ3wMd7jzkPx4/X6xcuOM/k1QstObEcDCs9kKAeyFch1/DGU
         nl6aRIKnuhgmxMBifA27v4OBP8/B8NzH7pm9+P+FOoNWnpwFS1WfcJrrO8S+djfkPBw6
         uizFq34pAGIPvPpq3JBB//x51HroDOp2drBDQ9iDgafH8wV48x7UrMrFixCovtG9OfMS
         RQ2FQOSb9VYuivSBGU/aGWa4roM+py4c6BIK57IoWMwDbZK94nwWkQYVpUWoQXDPN2Hi
         NyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778877227; x=1779482027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9YwlJJcvYwY8fns8m48KGL1VHm6uk+SQqlLXYhIKgz8=;
        b=Fi3E5YWUsXrLSGxkTq4lw9KSGNCxa2kkWZOi55l+SxUZrGlgVWY0lrH8hgzK5bFBEd
         ApxDvOeFundlKHfxQQxPZsTHQRpR2FR4h3gejEKYVgJP2gHUq0Do2kCAv/XdzQx+hl1h
         RhKcdjStw3QnTLHRx3AlChAE2JzYF5YVUcqUYiNPvB6p7zBy01bN03IBAvVmEfX7IDcc
         K0/OfIAMQgIGnFJqqav3oQbJS8iEgnk6fenYS/T7LN+g2LAgpeo5j2sbTQotI9t9uUSa
         op3HfDkZb5/NsuI3W1q1eMUpsqdfskHndo/CuYrrmXlSu06lKRVc4sJETbpL43Uz9PuF
         RutA==
X-Forwarded-Encrypted: i=1; AFNElJ8IJU1rocxctFirVNNHrqEmn/wr9TqhiHWUPQ18e+IR0//Ch+f2aUPvhbiqeKkcwIg8X5Wfr7BbmLVVO+tt@vger.kernel.org
X-Gm-Message-State: AOJu0YxsvNcH5+f0q1QD61YlROI8tmc4QfiXLD2bIK7jwi+Dn/9IsBl8
	1vhwmZZSMZuR+G8JYSNNVbFmMfWy7ajtiRJKqU1mOqJCAVEEzjhVDiHkNzQCL+WAopvddU3JSwz
	dd/vVwq24YAxtF0MQzIJceTxvCbME1mVr2KO4
X-Gm-Gg: Acq92OHttt9UZxvcMgiS2c7+lCj8nLZf5TBt2spiWRuxmk2eYNsAAWYMdOZZHXiIT11
	jA//tm+xKx+0khexXlH2pgHzEUa0//g2mZkm/gY9eob/skz8CJL+zUtCYChem2tioUCnAJxv2Ki
	kllmkhfkiiB3qCdYliEKIWIYHStkeQETXavqxcIFpqoilODn/WUpWxGFiaYNVIeags0zXt/iLmt
	9oSqF3CAEK3aqx8ZlKBdMhBeLbmXWntxpi4nLz0F3+rQx/D46dYaikCq0InLoR3YovkuOO1q2Dh
	B07lI/5if0WUGEiYgdekeP+PeJ58RZlLxU/IFjtMYg==
X-Received: by 2002:a05:6402:1f45:b0:67b:7d77:14da with SMTP id
 4fb4d7f45d1cf-683bc8a94b8mr2651562a12.8.1778877226469; Fri, 15 May 2026
 13:33:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177747206436.4103309.9048553717124547447.stgit@frogsfrogsfrogs>
 <177747206510.4103309.7610933581068572895.stgit@frogsfrogsfrogs> <20260514220921.GI9544@frogsfrogsfrogs>
In-Reply-To: <20260514220921.GI9544@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 15 May 2026 22:33:34 +0200
X-Gm-Features: AVHnY4I8kyXSTZqiDtcBeg8yln7B_x_AdIYn1XaB6rWDgusxSClx6hrtRtpnpKI
Message-ID: <CAOQ4uxja1znK3pz3YAX2uFM-GFVS1zENHJzHBLAVrVqcz6bVhw@mail.gmail.com>
Subject: Re: [PATCH 1/9] fuse: enable caching of timestamps
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev, 
	linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry I was absent from iomap review for a while.
Using these Codex replies as opportunity to get back to it..

On Fri, May 15, 2026 at 12:09=E2=80=AFAM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Wed, Apr 29, 2026 at 07:33:20AM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > Cache the timestamps in the kernel so that the kernel sends FUSE_SETATT=
R
> > calls to the fuse server after writes, because the iomap infrastructure
> > won't do that for us.
> >
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  fs/fuse/dir.c        |    5 ++++-
> >  fs/fuse/file.c       |   18 ++++++++++++------
> >  fs/fuse/fuse_iomap.c |    6 ++++++
> >  fs/fuse/inode.c      |   13 +++++++------
> >  4 files changed, 29 insertions(+), 13 deletions(-)
> >
> >
> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > index 3a76eea04c6425..11898102adefe2 100644
> > --- a/fs/fuse/dir.c
> > +++ b/fs/fuse/dir.c
> > @@ -2265,7 +2265,8 @@ int fuse_do_setattr(struct mnt_idmap *idmap, stru=
ct dentry *dentry,
> >       struct fuse_attr_out outarg;
> >       const bool is_iomap =3D fuse_inode_has_iomap(inode);
> >       bool is_truncate =3D false;
> > -     bool is_wb =3D fc->writeback_cache && S_ISREG(inode->i_mode);
> > +     bool is_wb =3D (is_iomap || fc->writeback_cache) &&
> > +                  S_ISREG(inode->i_mode);
> >       loff_t oldsize;
> >       int err;
> >       bool trust_local_cmtime =3D is_wb;
> > @@ -2405,6 +2406,8 @@ int fuse_do_setattr(struct mnt_idmap *idmap, stru=
ct dentry *dentry,
> >       spin_lock(&fi->lock);
> >       /* the kernel maintains i_mtime locally */
> >       if (trust_local_cmtime) {
> > +             if ((attr->ia_valid & ATTR_ATIME) && is_iomap)
> > +                     inode_set_atime_to_ts(inode, attr->ia_atime);
> >               if (attr->ia_valid & ATTR_MTIME)
> >                       inode_set_mtime_to_ts(inode, attr->ia_mtime);
> >               if (attr->ia_valid & ATTR_CTIME)
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index fa67b20f5ad3ae..eecd0610fbd3e5 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -262,7 +262,7 @@ static int fuse_open(struct inode *inode, struct fi=
le *file)
> >       int err;
> >       const bool is_iomap =3D fuse_inode_has_iomap(inode);
> >       bool is_truncate =3D (file->f_flags & O_TRUNC) && fc->atomic_o_tr=
unc;
> > -     bool is_wb_truncate =3D is_truncate && fc->writeback_cache;
> > +     bool is_wb_truncate =3D is_truncate && (is_iomap || fc->writeback=
_cache);
> >       bool dax_truncate =3D is_truncate && FUSE_IS_DAX(inode);
> >
> >       if (fuse_is_bad(inode))
> > @@ -477,12 +477,14 @@ static int fuse_flush(struct file *file, fl_owner=
_t id)
> >       struct fuse_file *ff =3D file->private_data;
> >       struct fuse_flush_in inarg;
> >       FUSE_ARGS(args);
> > +     const bool is_iomap =3D fuse_inode_has_iomap(inode);
> >       int err;
> >
> >       if (fuse_is_bad(inode))
> >               return -EIO;
> >
> > -     if (ff->open_flags & FOPEN_NOFLUSH && !fm->fc->writeback_cache)
> > +     if ((ff->open_flags & FOPEN_NOFLUSH) &&
> > +         !fm->fc->writeback_cache && !is_iomap)
> >               return 0;
> >
> >       err =3D write_inode_now(inode, 1);
> > @@ -518,7 +520,7 @@ static int fuse_flush(struct file *file, fl_owner_t=
 id)
> >        * In memory i_blocks is not maintained by fuse, if writeback cac=
he is
> >        * enabled, i_blocks from cached attr may not be accurate.
> >        */
> > -     if (!err && fm->fc->writeback_cache)
> > +     if (!err && (is_iomap || fm->fc->writeback_cache))
> >               fuse_invalidate_attr_mask(inode, STATX_BLOCKS);
> >       return err;
> >  }
> > @@ -820,8 +822,10 @@ static void fuse_short_read(struct inode *inode, u=
64 attr_ver, size_t num_read,
> >        * If writeback_cache is enabled, a short read means there's a ho=
le in
> >        * the file.  Some data after the hole is in page cache, but has =
not
> >        * reached the client fs yet.  So the hole is not present there.
> > +      * If iomap is enabled, a short read means we hit EOF so there's
> > +      * nothing to adjust.
> >        */
> > -     if (!fc->writeback_cache) {
> > +     if (!fc->writeback_cache && !fuse_inode_has_iomap(inode)) {
> >               loff_t pos =3D folio_pos(ap->folios[0]) + num_read;
> >               fuse_read_update_size(inode, pos, attr_ver);
> >       }
> > @@ -870,6 +874,8 @@ static int fuse_iomap_begin(struct inode *inode, lo=
ff_t offset, loff_t length,
> >                           unsigned int flags, struct iomap *iomap,
> >                           struct iomap *srcmap)
> >  {
> > +     WARN_ON(fuse_inode_has_iomap(inode));
> > +
> >       iomap->type =3D IOMAP_MAPPED;
> >       iomap->length =3D length;
> >       iomap->offset =3D offset;
> > @@ -2021,7 +2027,7 @@ static void fuse_writepage_end(struct fuse_mount =
*fm, struct fuse_args *args,
> >        * Do this only if writeback_cache is not enabled.  If writeback_=
cache
> >        * is enabled, we trust local ctime/mtime.
> >        */
> > -     if (!fc->writeback_cache)
> > +     if (!fc->writeback_cache && !fuse_inode_has_iomap(inode))
> >               fuse_invalidate_attr_mask(inode, FUSE_STATX_MODIFY);


It is so easy to get lost in the code handling attr cache coherency
between kernel and server, so many little details (a.k.a maintenance
nightmare). It's not great now, and becoming worse with iomap.

On top of existing writeback_cache special casing and now iomap
more special casing, passthrough code also has special cases
that may need to be handled better.

Can we maybe abstract some of these open coded checks in
a way which is easier to review?

Thinking about some attr_mask in the inode which determines for
every attribute, who owns the authoritative copy, server or kernel.
For example, for (writeback_cache || iomap)  kernel owns ATTR_MTIME.

This is very hand wavy and far from dealing with all the complexity
in every specific case, but the bottom line is - very hard to review that
this is all correct and nothing missing and very hard to figure out
what's going on when looking at the code
for humans I mean... Codex seems to be doing well ;)

Thanks,
Amir.
