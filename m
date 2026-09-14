Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0223A1CEA
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 20:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789419571; cv=pass; b=p9jY0Bw5svGoe51nzCjtTRdfdtJ1IB0sZS8VUc180FexmQ7oH6X1uviiptmtwZghWZjKzuJN9HGuWu6jr+1AIbnBvQwMS+pMh7OVl3Zvrh+fdNH+KuhhtmPZXu2uqF/o0Akcxh/7q/YxV85mzpW/Q8ZOREbN7Ltgwlqt+gM+HNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789419571; c=relaxed/simple;
	bh=j7u3CVocYfNSz6ykANmlSKsGM16yN6Y/4fPWJSUINcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZ0DLNLEjy+3OpSHeOZKz55JnjKs8vfSzfAEwlpO8mIXCR6KGNv8QUYe+BFlC47iPzv8dAH/BlujcUDzyExJCsLjUiWidNx33XN2b8ey61Jp7F9MxE76jUA+lUeswuTTYQIPlA4dKFyob9D/JCAN21CS4G00rhWKUgcNcybzJJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVIWYqIF; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVIWYqIF"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c1670dad7a8so673651166b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 13:59:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789419568; cv=none;
        d=google.com; s=arc-20260327;
        b=kXGbtje1P7DnxxaX25j6R/lFS20AkBx+GW9FmCMMF63mnysZyuxcWgZoP7EB4tNExZ
         oITtYcmEDLcmqdyND7KL/Wr5ZQCJQ6jScp+dXRlAo+aZWALQ6ycW0i0bVMTyeGKntGyj
         xsBWCqVLXWKTDAMSR7ehbaEVKuOGWes5WRjxZKn+c4dfiTGCx9nB8GVhXED5+Bt9ZSwA
         Anipuv81CSGvIli4RgCEIT6warDNOePdl9fbp4F10rdA4r7pE/8OT72dwthrzFESubvr
         yA/4TGRsn8K8AGFm+VB0JkMJcHwBcDkQEbPyqbkBN1FZOWkuU5Zt7MsqoIFDeIJmXFVX
         97pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7LSg5RdUyrJ+d+U0WBwd0ySTQ6Z5VZa5bGOIanx2lvk=;
        fh=FSuxSicbT3G/9oOTjC8NrTG4flsRMkrvdBHswBPDZRM=;
        b=rGZhSCghQEj5gP3SwtJzXSiM/PBzleWp7vElW7J5tjbTdJMSvaFSgL6LP1/qFDqW6W
         13Fp+bpcSPT+KCS7Yg9Dw2GPEslB2+hksZACe4lPBln13N8ytl33uLkZzUbnMdP5TyfG
         d8MJdg3t5+2psGNRInlL9CAdlvPcp4RtFlPXeqEAVjirNKcwWLjq7/wZVRmPTFJudl8T
         iKTT0mnJiLQAcVeshEuCFbexoSCwwca74cqcmN0qP9xEG+BpGnBKoXByUEX0Nn87NCiv
         iYeioCzumOksBAi0Vhw7aqruXdLL9W0yHnWrjhmFe1aQHZz9mIgDXiJOiUdcOQXNTnLa
         SMGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789419568; x=1790024368; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7LSg5RdUyrJ+d+U0WBwd0ySTQ6Z5VZa5bGOIanx2lvk=;
        b=nVIWYqIFnX26CKQeY6NMWP+RgaIiLlJnjeRRgDQtOEm+YfIFWWnDM0+XpuyT/LmW9S
         I/HrVOtJCqPrir1zKI7OqJsgA5uezQKJxx1xhu1iQB3WLLdzs6sPvt7T9ACMWjo0ee5H
         xXKwfnnlUdQykcsMCOOQ7ADoB+LsjFJdQTdw4FS/W1VsS4YNf2Vm4IAEtCC7fuSRkgTe
         YjQ/yzELwEpxn2QsxPJTvSLFNe02uXQS+AwO9mTpDYaXyeJx09q4kirlx6gwJqTr2heH
         mxj4fREfaQTKkkVFcKKDV+pGlh4Ef/a06XtnYQ2q/u5LHoU85DUwBOiH6Yn5N7LfKL2x
         hpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789419568; x=1790024368;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7LSg5RdUyrJ+d+U0WBwd0ySTQ6Z5VZa5bGOIanx2lvk=;
        b=ZVwkpA7AfHaoDTGvlKtgdSvUHtsAZ2R4CDyn8ClSS/TNlZK+KTiboBWvDvW2IK/7iq
         gFm+PaYiWvlVOG+iFbtQqKegEI8W+sMYU3SSiUbubUfj3DvOStZOUmAI+TShQZUl0Yqv
         pNUlC+WsGCDEix/7gUqYerLI8BQRIyxCybxTGS7GNl/QoKbF9CUkM8bYdRXFipjer3XT
         u4Ijytky+J4IGMLHjB0PmozU4RJ/8PIAR0JyJVgBn4wiN6vvO71kRHtwrJudhlpdJqjR
         P9OT56ntnfLiJVDhR6eAqQNWVFcSsjr+VTYbA6Q7BuHBBDhTeoXpr+FCT6niDr6VewJO
         zDrQ==
X-Forwarded-Encrypted: i=1; AKwUvByPARZKxdyIMTB6vXJ2evEMy0HTtn2DvaRBTxMm6eb9oncIDMqcyPhx3LWth3lMpvCmhnxeiKAI3I2T4A4P@vger.kernel.org
X-Gm-Message-State: AFuF++lDm1J7ksNRwvgiAWyrTnorseBpQwgHJr4v1iVwxkme9/CJ8Zt/
	qOFp2zAbuo7HPzMr+NL93VCrJuhJm/vuSTF6UNp/DJjLqi4g1O2O17q5ltzj9//xOi71k4o5WCN
	UJlAtkaXTN+47i8kp5nNG3hUz+civW32F/A==
X-Gm-Gg: AYBFou1kAfOcJ6zrtvtmLZBobJ2k6g/Iciz0cbE5bxevgoHcePZY9bSV+THTul55I2O
	SQvil9hSF2GrnL6Asm8BHsbHUxtkzHvMpmePS+t5SLEEyAoA62b4huz82cR7sx+VxifizGvTMGu
	P8wfw4h7Yr/FYJqkyarMldsbToUChTpq6wrdjkXcobYLiN8hbVuber7AJCg9Ee3ijC8jDJaKkkv
	KNmmJE22a3+CAcU+tDlEnLghg2EYyyVuwHc/PnSXRgpRC8Z173pWYfwOs9RE7Bx6IEATCql08VP
	pZQ30CRvIgduc8edbf+AKfjNmykDpcpBH7fc0pickpPpe1IxjNcik+oqhLQfdT3i9Uos1x8oM9k
	bMPcE4wjO
X-Received: by 2002:a17:907:930d:b0:c27:420b:7c82 with SMTP id
 a640c23a62f3a-c29b876e022mr286157366b.48.1789419567915; Mon, 14 Sep 2026
 13:59:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910002934.192979-1-neilb@ownmail.net> <20260910002934.192979-5-neilb@ownmail.net>
 <2mr6afww7r67o2hjblafhdwqffg3zicsqjkddnquunfaalolpd@yq54r5nlqftm> <178933378203.207413.6142548185484898062@noble.neil.brown.name>
In-Reply-To: <178933378203.207413.6142548185484898062@noble.neil.brown.name>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 14 Sep 2026 22:59:14 +0200
X-Gm-Features: AcwNN1Vo9_WgDFAN78Ox2ZEC0TlJ_qNc6EDOHH1iRPNXfhxDrKnXqyUtshK7RNI
Message-ID: <CAGudoHG59N0Fen0-Wh+yz+OMA_HcX+Bu-dx+7J0QnypyK_b3ZQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] vfs: change vfs_lookup_open() to return found dentry
 in path.dentry.
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 11:09=E2=80=AFPM NeilBrown <neilb@ownmail.net> wrot=
e:
>
> On Mon, 14 Sep 2026, Mateusz Guzik wrote:
> > On Thu, Sep 10, 2026 at 10:20:50AM +1000, NeilBrown wrote:
> > > From: NeilBrown <neil@brown.name>
> > >
> > > The caller - nfsd - needs to know the type of object found when a
> > > non-regular file was found to exist.  This is most easily done
> > > by passing back the dentry.
> > >
> > > So change calling pattern so that the path (now called "path") contai=
ns
> > > the parent dentry on entry and the child dentry on exit.
> > > vfs_lookup_open() will dput() the parent and caller must dput() the
> > > child.
> > >
> > > If lookup_open() returns -EFTYPE (from ->atomic_open()) we need to
> > > use d_lookup() to find the dentry.  If ->atomic_open() didn't add a
> > > dentry to the dcache we return %NULL in %path->dentry.
> > >
> > > Signed-off-by: NeilBrown <neil@brown.name>
> > > ---
> > >  fs/namei.c | 31 ++++++++++++++++++++++---------
> > >  1 file changed, 22 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/fs/namei.c b/fs/namei.c
> > > index 0c787363b101..30ccc0c2f02f 100644
> > > --- a/fs/namei.c
> > > +++ b/fs/namei.c
> > > @@ -4606,7 +4606,7 @@ static struct dentry *lookup_open(struct nameid=
ata *nd, struct file *file,
> > >
> > >  /**
> > >   * vfs_lookup_open - open and possibly create a regular file
> > > - * @parent: directory to contain file
> > > + * @path: directory to contain file
> > >   * @last: final component of file name
> > >   * @open_flag: O_flags
> > >   * @mode: initial permissions for file
> > > @@ -4619,9 +4619,15 @@ static struct dentry *lookup_open(struct namei=
data *nd, struct file *file,
> > >   * If the fs object found is not a regular file then -EFTYPE is
> > >   * returned.
> > >   *
> > > + * @path is updated to contain the dentry that was found if possible=
.
> > > + * In particular, if -EFTYPE is returned, then @path.dentry will be =
the
> > > + * object that is not a regular file, or %NULL.
> > > + * Consequently the caller must be prepared for @path.dentry to be
> > > + * dput(), an it must dput() whatever is in @path.dentry after the c=
all.
> > > + *
> > >   * Returns: the opened struct file, or an error.
> > >   */
> > > -struct file *vfs_lookup_open(struct path *parent, struct qstr *last,
> > > +struct file *vfs_lookup_open(struct path *path, struct qstr *last,
> > >                          int open_flag, umode_t mode)
> > >  {
> > >     struct file *file __free(fput) =3D NULL;
> > > @@ -4638,7 +4644,7 @@ struct file *vfs_lookup_open(struct path *paren=
t, struct qstr *last,
> > >     mode |=3D S_IFREG;
> > >     open_flag |=3D __O_REGULAR;
> > >
> > > -   error =3D lookup_noperm_common(last, parent->dentry);
> > > +   error =3D lookup_noperm_common(last, path->dentry);
> > >     if (error)
> > >             return ERR_PTR(error);
> > >
> > > @@ -4646,7 +4652,7 @@ struct file *vfs_lookup_open(struct path *paren=
t, struct qstr *last,
> > >     if (IS_ERR(file))
> > >             return file;
> > >
> > > -   nd.path =3D *parent;
> > > +   nd.path =3D *path;
> > >     nd.last =3D *last;
> > >     nd.flags =3D LOOKUP_OPEN;
> > >     if (open_flag & O_CREAT) {
> > > @@ -4658,9 +4664,18 @@ struct file *vfs_lookup_open(struct path *pare=
nt, struct qstr *last,
> > >     op.mode =3D mode;
> > >     dentry =3D lookup_open(&nd, file, &op);
> > >
> > > -   if (IS_ERR(dentry))
> > > +   if (IS_ERR(dentry)) {
> > > +           if (dentry =3D=3D -EFTYPE) {
> > > +                   /* Try to determine what was found */
> > > +                   struct dentry *child =3D d_lookup(path->dentry, &=
nd.last);
> > > +                   dput(path->dentry);
> > > +                   path->dentry =3D child;
> > > +                   WARN_ON_ONCE(child && d_is_reg(child));
> > > +           }
> >
> > Does anything prevent the child from flipping over to regular?
>
> Yes.  An inode is never allow to changes its type.
> And while you hold a reference on a positive dentry, the inode is that
> dentry is not allowed to change (a negative dentry may become positive,
> but a positive dentry must keep the same inode).
>

Let me restate: what prevents the repeated lookup from finding a
different dentry, which also happens to be regular?

I don't see any locks held here to prevent it, so AFAICS in the time
window between lookup_open() and d_lookup() someone else could have
for example unlinked the target and linked something else.

But that's a side remark, the real criticism was later in the e-mail
and it is present in the quotation below.

> > I would say this is the wrong approach to the API. The path dentry
> > switching is a massive hack and should be avoidable. So happens I was
> > working on cleaning up the overall handling and you convinced me to pos=
t
> > the patchset early, see:
> >
> > https://lore.kernel.org/linux-fsdevel/20260913144918.1606123-1-mjguzik@=
gmail.com/
> >
> > On top of that the routine as is has avoidable refcount traffic and it
> > seems you are adding to it. Instead it can switch to vfs_open_consume.
> >
> > On cursory reading of the nfs patch, the following should do the trick =
instead: split the
> > helper into 2 parts (say vfs_open_lookup + vfs_open_lookup_finish, mayb=
e add
> > vfs_open_lookup_abort should the caller decide to not go through with
> > the open).
> >
> > Then in nfsd you could have something like this:
> > struct vfs_open_lookup_arg v;
> >
> > vfs_open_lookup(&v, parent_path, ....);
> > [ child dentry is in v->path->dentry, do arbitrary work with it]
> > if (ok)
> >       file =3D vfs_open_lookup_finish(&v);
> > else
> >       vfs_open_lookup_abort(&v);
> >
> > The new struct would hide 'struct file' and whatever else
> > vfs_open_lookup might want to allocate first.
> >
>
