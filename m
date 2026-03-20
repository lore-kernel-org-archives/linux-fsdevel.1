Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09743002DF
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 14:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018042; cv=pass; b=c+MU1LWsYuwq+t7zBElXvM6NTaqbLzvyMx9gVDMROXt5Iy1tOCsme7BYkTheWAQDem0ZjxmecBCuHF3rUHsvoWXvrqiYzTNwYl+N2suRbUM4wimk4X/Lz2Ky1m40udfy9SmPQBYRyjJ19uwlPSivI3VB9KI6KSy9BvSIYT27s/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018042; c=relaxed/simple;
	bh=hUXCCzNq+YoSrT1MYXebgJGJ2avs/D6mzf9IXZRcDHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPOaj3FVBJR7NK+0WKyVt7SsVYRBMRocOdpznOB6W1Ivusk0YHYkSjyP2eyvz3VeZHhnlZPGoMBQkIlkGy/1xu/AjJz8vQNncl4b/Qi8aio3aC5gTbxRxPib8e7pNbFyTM58YTIQlvEE3CAwvS/9TLWtfwAt95BhS2Ht0Aj8rXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2vC/Kkr; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2vC/Kkr"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b9793fa5371so265012866b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 07:47:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774018039; cv=none;
        d=google.com; s=arc-20240605;
        b=Coz1gt03b7blyWQXmYlcMiSsKB8fFv4jxamqXatIsALPopQSEXUEb5LqguELML6Xh+
         nmKi82s+gYyktI0KHASp9oOWe61ol2nSi8rBgAEq/x8n+V9y+tXzYt6l5Vfd5iQx0pt4
         gdb8GgUKEqwI3REEK85x1X1UjJeT6PgiuSwAcqpNMqvs5ojyz4kIAQbTfl0MjicCs1x9
         bnULJt4xHlOwA36SVH4Zm1xjB7fIy4j4Et1IWDG9UVpANyhjFAdcb5DIUeb8jJnrTake
         qoakhZ81JTH8qVTTo6FucvqXigBSashoUXTJlJ6aTFIjdC+rYfReC2V9qJglJlKlD5Rp
         8cdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vTgQ50O1oiNynzwEGL7y41l8E79C+EzJRmuAl1+fekM=;
        fh=REFj5e3N1RzXSl3gUhYOQQ449NCCenG84VHA8VEf3kk=;
        b=TijaLGaJAeiSK9Ujryi0cgxRS6CeVnngrxG+58wKqxrX86QIa9OVP04LnN4JGruJf1
         tFjwdfIggZEBBz2SpeYTUv3IDHGUF3RF2/i1PjeugR1an01SUoVbvvUMf8wB4Iw9oa+L
         Cg15ktR6qkjyKSb33NqH3ycuHgCYWi8TR+gRWlj/7lO9idH2QUtEFzFgiOqupASldDtU
         Dy13AnlQdRA2PcXx3db2gFWY8f9ix4zYZaSp4TIVGl8I9aM2g41WbzTfsVOTiI48lfnE
         815h5A2xUlK55i1+q+yrwJPc8zF3Dh0DiWDpj40ol9u/AOrl0keAPcLy3d2WLh0H/pSt
         NgbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774018039; x=1774622839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTgQ50O1oiNynzwEGL7y41l8E79C+EzJRmuAl1+fekM=;
        b=W2vC/KkrPGk+/a1+HyOHqOYzuqvBmboQfZvbtUBTW1Vl4xS6XO0sZWbVlHlijH61uJ
         N4WIHf/jyr/cA3IurAwPx9qqeZHmeNfVuSJMC7GjGomH1YXIF1MidCAXqd0eVyC2JGQf
         FfqoLJH8UlWNM29n3tr0hXcpW0neCdO0mkeza7Gkr+zY6y/OrMLDiwYUaDx3kyj+0nHA
         XtxE/LFDoW4OGVrE8crOzrVCl63HhHqFLbx1QPQwG48XjXAzaqORIQJOcEPj1Pv8JiDn
         zpSjAYcgqAS00PyYSPRHj3j+0+MEyFLfDfsReSXat6oFrFCrs/16WHabcjtbGA7pTVTr
         AGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774018039; x=1774622839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vTgQ50O1oiNynzwEGL7y41l8E79C+EzJRmuAl1+fekM=;
        b=hw8eMJ3ynGbdf/OE7WL2kmA5IYBcbG+0Pg6/Sa3t+I9DqLtHBb7EsiSyneBoHr4jwv
         ydf/UxpD1iYz5XEHJsAnH8UC9SBq3xCCUbQ8iRVfrE3mnVoKEYa0p4cLr+y9o8SPf9jv
         tKymEuqBNs//f8DrEXdSzBigqjEBouDe5lfoKwXNnOL54sbIBbjj1HRUvsgTLDxYAEYJ
         4UDEV7OxrvCkJZTQUglWGBwOTds6mraBRQnx0+Oa+ynT9Rg4VEkR7NRCfLrhZpVY3bnz
         GnsT8+tFq6jp9w8M+/TEOP6FGJROdmRA+UKALnBo66pHXTU5xx5ULfGFnNBCArqGNE8k
         acfA==
X-Forwarded-Encrypted: i=1; AJvYcCXlb7du6Je7VlC1XT6rPPs4GhzY54R8g+hem0dyAteWsxawBqYhz5X7KKSN84UG5OPmpvJDmas9+IiDiLG2@vger.kernel.org
X-Gm-Message-State: AOJu0YxtUA7BPWMiH2wi1sPDJnt9sLJUyOJjzfdtap6ZfeHLWA+WUETw
	FJdoa0b4EzK2CzT2Xbcy/pcascRwkhjtyZCRppZEGhQroEfhEKNaq2jb4hsXRy2h8tc8i3zGgED
	iS7pzAWYYqWvCYwqyjnB3L9k/ye5t2XU=
X-Gm-Gg: ATEYQzxduOr91aOiAa5Sep8CMe54FmgmmSKpjMKO8u/2IQQHOeoHoZAqySyyit6tyab
	lLKlq/YpTRMSvwckDclltBSvs17jUqcR9GxsyBosY8zel1OJbvlnFkiZmI+lSuFr6G4vOtWCtg4
	rke2rmn7qa/QYQf5rXZUZRdeGwzdHx/Fzwf5+Sss6XF6jBBvVP5WZAQOUv89jomDZu4hGl2hZwB
	CHogSSOkZ4NPtdHHr3AhkKjk3kjLew9wl1mEHmr0vfTfpkNi6DTNdy+9PiRfs8XJiT3CjXgLKnT
	FxbpoZMCVPXMmmv97vSAINm3HC1B8nGGL4BehZYD
X-Received: by 2002:a17:907:a807:b0:b97:b2dc:91e2 with SMTP id
 a640c23a62f3a-b982f1e66a0mr240320666b.16.1774018038640; Fri, 20 Mar 2026
 07:47:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312214330.3885211-1-neilb@ownmail.net> <20260312214330.3885211-17-neilb@ownmail.net>
 <CAOQ4uxjmcNxsCmDSVgkTns=3BAuQcT3pVvsQzza+u3iqXqrz5g@mail.gmail.com> <177386823998.3934327.10803400222725196190@noble.neil.brown.name>
In-Reply-To: <177386823998.3934327.10803400222725196190@noble.neil.brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 20 Mar 2026 15:47:06 +0100
X-Gm-Features: AaiRm50_edNtekIrrv4eSu4Qa5bvNeyUgtpCK3q4qoH_yisc1DeMkbaOnfrPdQ8
Message-ID: <CAOQ4uxgvD3COuoD5r67CfpYSiRFSr0LY5TB-QPcSn-zD9Ht1HQ@mail.gmail.com>
Subject: Re: [PATCH 16/53] ovl: drop dir lock for lookups in impure readdir
To: NeilBrown <neil@brown.name>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 10:10=E2=80=AFPM NeilBrown <neilb@ownmail.net> wrot=
e:
>
> [[ CC list trimmed ]]
>
> On Mon, 16 Mar 2026, Amir Goldstein wrote:
> > On Thu, Mar 12, 2026 at 10:49=E2=80=AFPM NeilBrown <neilb@ownmail.net> =
wrote:
> > >
> > > From: NeilBrown <neil@brown.name>
> > >
> > > When performing an "impure" readdir, ovl needs to perform a lookup on=
 some
> > > of the names that it found.
> > > With proposed locking changes it will not be possible to perform this
> > > lookup (in particular, not safe to wait for d_alloc_parallel()) while
> > > holding a lock on the directory.
> > >
> > > ovl doesn't really need the lock at this point.
> >
> > Not exactly. see below.
> >
> > > It has already iterated
> > > the directory and has cached a list of the contents.  It now needs to
> > > gather extra information about some contents.  It can do this without
> > > the lock.
> > >
> > > After gathering that info it needs to retake the lock for API
> > > correctness.  After doing this it must check IS_DEADDIR() again to
> > > ensure readdir always returns -ENOENT on a removed directory.
> > >
> > > Note that while ->iterate_shared is called with a shared lock, ovl us=
es
> > > WRAP_DIR_ITER() so an exclusive lock is held and so we drop and retak=
e
> > > that exclusive lock.
> > >
> > > As the directory is no longer locked in ovl_cache_update() we need
> > > dget_parent() to get a reference to the parent.
> > >
> > > Signed-off-by: NeilBrown <neil@brown.name>
> > > ---
> > >  fs/overlayfs/readdir.c | 19 ++++++++++++-------
> > >  1 file changed, 12 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> > > index 1dcc75b3a90f..d5123b37921c 100644
> > > --- a/fs/overlayfs/readdir.c
> > > +++ b/fs/overlayfs/readdir.c
> > > @@ -568,13 +568,12 @@ static int ovl_cache_update(const struct path *=
path, struct ovl_cache_entry *p,
> > >                         goto get;
> > >                 }
> > >                 if (p->len =3D=3D 2) {
> > > -                       /* we shall not be moved */
> > > -                       this =3D dget(dir->d_parent);
> > > +                       this =3D dget_parent(dir);
> > >                         goto get;
> > >                 }
> > >         }
> > >         /* This checks also for xwhiteouts */
> > > -       this =3D lookup_one(mnt_idmap(path->mnt), &QSTR_LEN(p->name, =
p->len), dir);
> > > +       this =3D lookup_one_unlocked(mnt_idmap(path->mnt), &QSTR_LEN(=
p->name, p->len), dir);
> >
> > ovl_cache_update() is also called from ovl_iterate_merged() where inode
> > is locked.
> >
> > >         if (IS_ERR_OR_NULL(this) || !this->d_inode) {
> > >                 /* Mark a stale entry */
> > >                 p->is_whiteout =3D true;
> > > @@ -666,11 +665,12 @@ static int ovl_dir_read_impure(const struct pat=
h *path,  struct list_head *list,
> > >         if (err)
> > >                 return err;
> > >
> > > +       inode_unlock(path->dentry->d_inode);
> > >         list_for_each_entry_safe(p, n, list, l_node) {
> > >                 if (!name_is_dot_dotdot(p->name, p->len)) {
> > >                         err =3D ovl_cache_update(path, p, true);
> > >                         if (err)
> > > -                               return err;
> > > +                               break;
> > >                 }
> > >                 if (p->ino =3D=3D p->real_ino) {
> > >                         list_del(&p->l_node);
> > > @@ -680,14 +680,19 @@ static int ovl_dir_read_impure(const struct pat=
h *path,  struct list_head *list,
> > >                         struct rb_node *parent =3D NULL;
> > >
> > >                         if (WARN_ON(ovl_cache_entry_find_link(p->name=
, p->len,
> > > -                                                             &newp, =
&parent)))
> > > -                               return -EIO;
> > > +                                                             &newp, =
&parent))) {
> > > +                               err =3D -EIO;
> > > +                               break;
> > > +                       }
> > >
> > >                         rb_link_node(&p->node, parent, newp);
> > >                         rb_insert_color(&p->node, root);
> > >                 }
> > >         }
> > > -       return 0;
> > > +       inode_lock(path->dentry->d_inode);
> > > +       if (IS_DEADDIR(path->dentry->d_inode))
> > > +               err =3D -ENOENT;
> > > +       return err;
> > >  }
> > >
> > >  static struct ovl_dir_cache *ovl_cache_get_impure(const struct path =
*path)
> > > --
> >
> > You missed the fact that overlayfs uses the dir inode lock
> > to protect the readdir inode cache, so your patch introduces
> > a risk for storing a stale readdir cache when dir modify operations
> > invalidate the readdir cache version while lock is dropped
> > and also introduces memory leak when cache is stomped
> > without freeing cache created by a competing thread.
> > I think something like the untested patch below should fix this.
>
> Yes, I did miss that - thanks. I think I missed a few other details too.
> I no longer think it can be safe to drop the lock without substantial
> rewrites - and even then maybe not.
>
> So I'm considering a different approach.
> This patch demonstrates what I'm thinking, though it still needs work I
> think.

I like this direction.

I always thought that we need to get rid of this vfs lookup
inside readdir but I thought it would be a lot of work.

Your suggestion walks around this in an elegant way.

>
> Thanks,
> NeilBrown
>
> From: NeilBrown <neil@brown.name>
> Subject: [PATCH] ovl: stop using lookup_one() in iterate_shared() handlin=
g.
>
> lookup_one() is expected to be removed as it does not fit well with
> proposed changes to directory locking.
> Specifically d_alloc_parallel() will be ordered outside of i_rwsem
> and as iterate_shared() is called with i_rwsem held it is not safe
> to call d_alloc_parallel().
>
> We can instead call d_alloc_noblock() and then call the ->lookup, but
> that can fail if there is a lookup attempt concurrent with the
> readdir().
>
> ovl cannot afford for the lookup to fail as that could produce incorrect
> results, and it cannot safely drop i_rwsem temporarily and that could
> introduce races with handling of the directory cache.
>
> Instead we rely on the fact that ovl_iterate() has an exclusive lock on
> the directory, so any concurrent lookup will wait for the ovl_iterate()
> call to complete.  We allocate a separate dentry and if the lookup is
> successful, it is hashed with the result.
>
> When the concurrent lookup gets i_rwsem it mustn't do its own lookup -
> it must use the existing dentry.  This is done using
> try_lookup_noperm().  To manage overheads we keep a counter of the
> number of "Stray dentries" there might be on each directory and only
> check for one when this count is non zero.
>
> If a 'stray dentry' were discarded for any reason before the concurrent
> lookup completed, the count would never reach zero.  That might be a prob=
lem.

Can we deal with the discarded dentries using OVL_E_FLAGS() for
a stray ovl dentry implement the relevant ovl_dentry_operations to decremen=
t
the stray counter?

Thanks,
Amir.

>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/overlayfs/namei.c     | 12 ++++++++++++
>  fs/overlayfs/ovl_entry.h |  1 +
>  fs/overlayfs/readdir.c   | 26 ++++++++++++++++++++++++--
>  fs/overlayfs/super.c     |  1 +
>  4 files changed, 38 insertions(+), 2 deletions(-)
>
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index d8dd4b052984..c3ff57047712 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -1399,6 +1399,18 @@ struct dentry *ovl_lookup(struct inode *dir, struc=
t dentry *dentry,
>         if (dentry->d_name.len > ofs->namelen)
>                 return ERR_PTR(-ENAMETOOLONG);
>
> +       if (atomic_read(&OVL_I(dir)->stray_dentries) && d_in_lookup(dentr=
y)) {
> +               /* This dentry might have forced readdir to do the lookup=
 */
> +               struct dentry *alias =3D
> +                       try_lookup_noperm(&QSTR_LEN(dentry->d_name.name,
> +                                                   dentry->d_name.len),
> +                                         dentry->d_parent);
> +               if (alias && !IS_ERR(alias)) {
> +                       atomic_dec(&OVL_I(dir)->stray_dentries);
> +                       return alias;
> +               }
> +       }
> +
>         with_ovl_creds(dentry->d_sb)
>                 err =3D ovl_lookup_layers(&ctx, &d);
>
> diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> index 1d4828dbcf7a..0e7751d5dfca 100644
> --- a/fs/overlayfs/ovl_entry.h
> +++ b/fs/overlayfs/ovl_entry.h
> @@ -172,6 +172,7 @@ struct ovl_inode {
>         struct inode vfs_inode;
>         struct dentry *__upperdentry;
>         struct ovl_entry *oe;
> +       atomic_t stray_dentries; /* directory */
>
>         /* synchronize copy up and more */
>         struct mutex lock;
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index 1dcc75b3a90f..add556a0a2b6 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -557,6 +557,7 @@ static int ovl_cache_update(const struct path *path, =
struct ovl_cache_entry *p,
>         enum ovl_path_type type;
>         u64 ino =3D p->real_ino;
>         int xinobits =3D ovl_xino_bits(ofs);
> +       bool did_alloc =3D false;
>         int err =3D 0;
>
>         if (!ovl_same_dev(ofs) && !p->check_xwhiteout)
> @@ -574,8 +575,29 @@ static int ovl_cache_update(const struct path *path,=
 struct ovl_cache_entry *p,
>                 }
>         }
>         /* This checks also for xwhiteouts */
> -       this =3D lookup_one(mnt_idmap(path->mnt), &QSTR_LEN(p->name, p->l=
en), dir);
> -       if (IS_ERR_OR_NULL(this) || !this->d_inode) {
> +       this =3D d_alloc_noblock(dir, &QSTR_LEN(p->name, p->len));
> +       if (this =3D=3D ERR_PTR(-EWOULDBLOCK)) {
> +               /*
> +                * Some other thread is looking up this name and will blo=
ck
> +                * on i_rwsem before they can complete the lookup.
> +                * We will do the lookup and when that lookup gets a turn=
 it
> +                * will return this dentry.
> +                */
> +               this =3D d_alloc_name(dir, p->name);
> +               did_alloc =3D true;
> +       }
> +       if (!IS_ERR(this) && !d_unhashed(this)) {
> +               /* Either we got in-lookup or we made our own unhashed */
> +               struct dentry *alias =3D ovl_lookup(dir->d_inode, this, 0=
);
> +               if (alias) {
> +                       d_lookup_done(this);
> +                       dput(this);
> +                       this =3D alias;
> +               } else if (did_alloc) {
> +                       atomic_inc(&OVL_I(dir->d_inode)->stray_dentries);
> +               }
> +       }
> +       if (IS_ERR(this) || !this->d_inode) {
>                 /* Mark a stale entry */
>                 p->is_whiteout =3D true;
>                 if (IS_ERR(this)) {
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index d4c12feec039..172d3ac7d3e2 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -195,6 +195,7 @@ static struct inode *ovl_alloc_inode(struct super_blo=
ck *sb)
>         oi->__upperdentry =3D NULL;
>         oi->lowerdata_redirect =3D NULL;
>         oi->oe =3D NULL;
> +       atomic_set(&oi->stray_dentries, 0);
>         mutex_init(&oi->lock);
>
>         return &oi->vfs_inode;
> --
> 2.50.0.107.gf914562f5916.dirty
>
