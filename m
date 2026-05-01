Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAE6345CCE
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 May 2026 09:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777629215; cv=pass; b=rAgcOymkUJRaiOzaaO4dxYj7NYf8zs04HSgz56Mr3smtIeF4SkuKYauJhqGeqqGpe47npq6nv6E4riGDqlBrW9jOSswjNkfvtp+0xrPY1Rl2hhFcxxgApRKo5TmbMoOabQ9lmb3riBbXgTccVevMPDwMqwxhWkFPtUnL/rxnF38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777629215; c=relaxed/simple;
	bh=pnCF7RKW/ZBea3QVIcE/BoVQI4fFbh72snkbEaZJQKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WqU7xydUzeKn8htTBZ+3pL50l5iZ+QxTzFL7ikfvgvI4o031zRoKU9PnKm1RuhnEA/HsPkZ0PTfWDmuhblw6k/uUv8yGxjR37y2D++HSD2On9MyfqkvhO+7b1gIxJfcs7IRON2QCfaskW/9aWMcXQXT9SD2b0PVRb7PPHtCe6d4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlU6K8nn; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlU6K8nn"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso14977005e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 May 2026 02:53:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777629212; cv=none;
        d=google.com; s=arc-20240605;
        b=F3dIek3xzGlC4YHG+nzwv4mr0Q3E4SjbEsD9LyUMRfigpw901aPI0+Di301HIIOrzG
         Iaph7BxIH1VxbTBEkZDA3BuuOOh5NkICJaJ/2F//QqYyDLNDcHcB8tQIv/7IgPga9s00
         XEOkamgmvsNyzPlhGurO/JeidLWGk3UzrcO8p5iOAZLZcotzooruUTs7uYm0oiVdk+T4
         P3qrt9EBa10P1H/sBUqSa2zk/fuzBGeANnj15bUpD5l5f8tiLn5zg0F5Rqux1DEPiEOc
         D3ws3Q4BaMcaBOwWI8Rqb9/yyFrlOfvSUFigjBN4DmSVy4Tyu12u1J78r4Q0UlYzYziv
         rmAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xL9mVkPxyTMqA24T0d3gnXjBA/spoHwfySHOCNQ006Y=;
        fh=bDtDalTraQxQ/i9ugaiwinEubPwMJlQr+9WEgYmiWLc=;
        b=f7d1IGwfSqVvpe1gB3vMB08RlfY3DRalAlb1OYV0khMCOa2yJkzEsob4019iZmCHJm
         9mgG3zr3TjVeTnKojSnjvB0HqOy1cKwqlFGexgHKREp6pPgdkXn9RP0ewI1Z7l04bIMe
         +1eh9WQNB+HrRmLtvIgOJYQYwkzX7TlbmisD/vvcpCwsHTVhPGLT30Xun679AZayS9C3
         +xw+7wfgdH1306n5IfaUU5Tgb1qwpVUbdChu8mVuTpOV2UmPo7lRA7LxofmSdNf0sBNO
         bstnh0m708R2fHX8goTukEX9Rs0wiby95gxGqDz7wshwMKE5i+ScKtMhS+urV+k5THXw
         qhaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777629212; x=1778234012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xL9mVkPxyTMqA24T0d3gnXjBA/spoHwfySHOCNQ006Y=;
        b=hlU6K8nnYQcubiro37GLm9ernHpPBSNtzHMt5a3fBpx/lKCACtqu8B9R/whZwR0pvZ
         Yq+xzKYg+K97kHuLKnABbynDK9usN4zUT37p1jlINqZtzu6jnBeee0qWjTW20VujfpY6
         WGCFajVXbwuscjSQkcw70wQMT9X32euHFU3PTY4Co3X4PJv33he5O/Jul/LYDm55gRO7
         MverZLteWMyD94Mx5t0K/v1AUHZBqQ4iD/nzh5wt2gbWMSSeghWwO/SINeeLCkNzR1gU
         IqxW2PQWObhDb8+GtYDu9o855TAfuplCZXLvWymHAvUt3/BdrQODoOYSh6GDADVCpMMo
         gCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777629212; x=1778234012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xL9mVkPxyTMqA24T0d3gnXjBA/spoHwfySHOCNQ006Y=;
        b=QZZsHgAqa16BvY0XrRovtIg5G1RPrSr9BpYxitasZizHzUX3uYVpeJ4mNAtiEfi42K
         o5iyeK1GDJlKhBti5HKcjLWQ6HE+njScbXh66GF+dk8V1pQifM4SiSN5OIzsm6FM6aDj
         A1vAr7hpaOG8UvO49uu/aoaZzdpurvF5cRchCOtUxRufYcBtfS+mGoGSxs6XR1FwK5/j
         BZLOgiKuN0wOIjiUeiU3nKo2DoOud+YJpEYKo6ow0zOuEtFF/tuyeurWDUJJE7oHJun7
         eyoU3VRXWxih2QRVyuaJDhHfkFDl9s3+hKnCd2gGnRkgWCqaMtRqCpTDsN7OkMoRJeM7
         DGRA==
X-Forwarded-Encrypted: i=1; AFNElJ8eMYKjIQdWcvb0RqFrKjJSRh9YQl9tUaeRIWrtNO/xJUn+U26GZDymvHsk5A5pf5WfcX5vrKZFYy2mofz3@vger.kernel.org
X-Gm-Message-State: AOJu0YwycEx47vihNSBEvXOGYpHdfWte/YkbDcbzutEgl02+iLko0Z/K
	eQri+a3kHgyCvIa2v7oJ4/DfuP9I+gbNP9m+OHNEw2HV8Yu5UqIilwAaZBfDh4lgGAtLyT1/Q1Q
	44uIcFiRyGAyE3NihFr7QQ75ICipks5M=
X-Gm-Gg: AeBDietxAv5mHx9oUdDlTF/jGNMzPNLaGt2gk2kjwtFjSdIY2amZqRxoInlDOwBVkZH
	Ry2CCQGCAwwkVExnzsQlZ5jd3nNPTUpLTASNbsXR1FEkcF9SGC/27jvSveA66t9zyZ5wOIROtPm
	P6EQ7PijRkpA3NQMOg/F64wuFCPuplhWRSzxYxpplIjWYxcM6qzfSrtMf05ljTRE2fNwLIIeezE
	kElK9iip8/Equ+r6YMHnoY8yiTQIMmc04xv75JNhe36JeJHQMCdW+F09tJ9yG4cuP7p6yOxw0y4
	poFGK1lL5WVl7sccVJg=
X-Received: by 2002:a05:600c:c086:b0:489:1fa5:997f with SMTP id
 5b1f17b1804b1-48a8eb6bf02mr25197125e9.9.1777629211898; Fri, 01 May 2026
 02:53:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177747203969.4101397.1905820467457875817.stgit@frogsfrogsfrogs>
 <177747204051.4101397.16466232272715875212.stgit@frogsfrogsfrogs>
 <CAJnrk1bYYBf2qYBvhv=MFKvG-2VekKwHCuRS6tjva=tExw6Gdw@mail.gmail.com> <20260430205731.GV7739@frogsfrogsfrogs>
In-Reply-To: <20260430205731.GV7739@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 1 May 2026 10:53:20 +0100
X-Gm-Features: AVHnY4IcyjwgT_beDnjwb1HgtmHdIEhuwAm6TNcJqefjCh9ew0C4iwMvZS1ltcM
Message-ID: <CAJnrk1YCXxXvd7vgTm5vhbHOJCiW=FGWkMNQLzGPh5PHdZpvpw@mail.gmail.com>
Subject: Re: [PATCH 3/4] fuse: update file mode when updating acls
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org, 
	bernd@bsbernd.com, fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 9:57=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Thu, Apr 30, 2026 at 02:48:29PM +0100, Joanne Koong wrote:
> > On Wed, Apr 29, 2026 at 3:22=E2=80=AFPM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > If someone sets ACLs on a file that can be expressed fully as Unix DA=
C
> > > mode bits, most local filesystems will then update the mode bits and
> > > drop the ACL xattr to reduce inefficiency in the file access paths.
> > > Let's do that too.  Note that means that we can setacl and end up wit=
h
> > > no ACL xattrs, so we also need to tolerate ENODATA returns from
> > > fuse_removexattr.
> > >
> > > Note that here we define a "local" fuse filesystem as one that uses
> > > fuseblk mode; we'll shortly add fuse servers that use iomap for the f=
ile
> > > IO path to that list.
> > >
> > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > ---
> > >  fs/fuse/fuse_i.h |    2 +-
> > >  fs/fuse/acl.c    |   56 ++++++++++++++++++++++++++++++++++++++++++++=
+++-------
> > >  2 files changed, 50 insertions(+), 8 deletions(-)
> > >
> > >
> > > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > > index 4c135a7edf54ac..0bcfb42592895c 100644
> > > --- a/fs/fuse/fuse_i.h
> > > +++ b/fs/fuse/fuse_i.h
> > > @@ -1050,7 +1050,7 @@ static inline struct fuse_mount *get_fuse_mount=
(struct inode *inode)
> > >         return get_fuse_mount_super(inode->i_sb);
> > >  }
> > >
> > > -static inline struct fuse_conn *get_fuse_conn(struct inode *inode)
> > > +static inline struct fuse_conn *get_fuse_conn(const struct inode *in=
ode)
> > >  {
> > >         return get_fuse_mount_super(inode->i_sb)->fc;
> > >  }
> > > diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
> > > index cbde6ac1add35a..bee8a9a734f50a 100644
> > > --- a/fs/fuse/acl.c
> > > +++ b/fs/fuse/acl.c
> > > @@ -11,6 +11,18 @@
> > >  #include <linux/posix_acl.h>
> > >  #include <linux/posix_acl_xattr.h>
> > >
> > > +/*
> > > + * If this fuse server behaves like a local filesystem, we can imple=
ment the
> > > + * kernel's optimizations for ACLs for local filesystems instead of =
passing
> > > + * the ACL requests straight through to another server.
> >
> > nit: "to the server" instead of "to another server"? another server
> > sounds like there's 2 servers
> >
> > > + */
> > > +static inline bool fuse_inode_has_local_acls(const struct inode *ino=
de)
> > > +{
> > > +       const struct fuse_conn *fc =3D get_fuse_conn(inode);
> > > +
> > > +       return fc->posix_acl && fuse_inode_is_exclusive(inode);
> > > +}
> > > +
> > >  static struct posix_acl *__fuse_get_acl(struct fuse_conn *fc,
> > >                                         struct inode *inode, int type=
, bool rcu)
> > >  {
> > > @@ -98,6 +110,8 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct d=
entry *dentry,
> > >         struct inode *inode =3D d_inode(dentry);
> > >         struct fuse_conn *fc =3D get_fuse_conn(inode);
> > >         const char *name;
> > > +       umode_t mode =3D inode->i_mode;
> > > +       const bool local_acls =3D fuse_inode_has_local_acls(inode);
> > >         int ret;
> > >
> > >         if (fuse_is_bad(inode))
> > > @@ -113,14 +127,25 @@ int fuse_set_acl(struct mnt_idmap *idmap, struc=
t dentry *dentry,
> > >         else
> > >                 return -EINVAL;
> > >
> > > +       /*
> > > +        * If the ACL can be represented entirely with changes to the=
 mode
> > > +        * bits, then most filesystems will update the mode bits and =
delete
> > > +        * the ACL xattr.
> > > +        */
> > > +       if (acl && type =3D=3D ACL_TYPE_ACCESS && local_acls) {
> > > +               ret =3D posix_acl_update_mode(idmap, inode, &mode, &a=
cl);
> > > +               if (ret)
> > > +                       return ret;
> > > +       }
> > > +
> > >         if (acl) {
> > >                 unsigned int extra_flags =3D 0;
> > >                 /*
> > > -                * Fuse userspace is responsible for updating access
> > > -                * permissions in the inode, if needed. fuse_setxattr
> > > -                * invalidates the inode attributes, which will force
> > > -                * them to be refreshed the next time they are used,
> > > -                * and it also updates i_ctime.
> > > +                * For non-local filesystems, fuse userspace is respo=
nsible for
> > > +                * updating access permissions in the inode, if neede=
d.
> > > +                * fuse_setxattr invalidates the inode attributes, wh=
ich will
> > > +                * force them to be refreshed the next time they are =
used, and
> > > +                * it also updates i_ctime.
> > >                  */
> > >                 size_t size;
> > >                 void *value;
> > > @@ -137,9 +162,10 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct=
 dentry *dentry,
> > >                 /*
> > >                  * Fuse daemons without FUSE_POSIX_ACL never changed =
the passed
> > >                  * through POSIX ACLs. Such daemons don't expect setg=
id bits to
> > > -                * be stripped.
> > > +                * be stripped, unless they've explicitly told the ke=
rnel to
> > > +                * take care of that.
> >
> > nit: imo this would be clearer as its own sentence, eg "For local
> > filesystems, the kernel already handled sgid stripping in
> > posix_acl_update_mode() above".
> >
> > >                  */
> > > -               if (fc->posix_acl &&
> > > +               if (fc->posix_acl && !local_acls &&
> > >                     !in_group_or_capable(idmap, inode,
> > >                                          i_gid_into_vfsgid(idmap, ino=
de)))
> > >                         extra_flags |=3D FUSE_SETXATTR_ACL_KILL_SGID;
> > > @@ -148,6 +174,22 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct=
 dentry *dentry,
> > >                 kfree(value);
> > >         } else {
> > >                 ret =3D fuse_removexattr(inode, name);
> > > +               /* If the acl didn't exist to start with that's fine.=
 */
> > > +               if (ret =3D=3D -ENODATA)
> > > +                       ret =3D 0;
> > > +       }
> > > +
> > > +       /* If we scheduled a mode update above, push that to userspac=
e now. */
> > > +       if (!ret) {
> > > +               struct iattr attr =3D { };
> > > +
> > > +               if (mode !=3D inode->i_mode) {
> > > +                       attr.ia_valid |=3D ATTR_MODE;
> > > +                       attr.ia_mode =3D mode;
> > > +               }
> > > +
> > > +               if (attr.ia_valid)
> > > +                       ret =3D fuse_do_setattr(idmap, dentry, &attr,=
 NULL);
> >
> > maybe something like this is clearer?
> >
> >     if (!ret && mode !=3D inode->i_mode) {
> >          struct iattr attr =3D {
> >                 .ia_valid |=3D ATTR_MODE,
> >                 .ia_mode =3D mode,
> >           };
> >          ret =3D fuse_do_setattr(idmap, dentry, &attr, NULL);
> >     }
>
> I know, you said that last time ;)
> https://lore.kernel.org/linux-fsdevel/CAJnrk1YL3KnON-WtNjNi+2GZ+6rYvnVUnY=
wCk5efv0o41XkxcA@mail.gmail.com/
>
> and my reply is the same:
> https://lore.kernel.org/linux-fsdevel/20260325222308.GH6202@frogsfrogsfro=
gs/#t

Fair enough, I'd forgotten the conversation from v7.

Also btw, I think there's the edge case where if the fuse_removexattr
succeeds but the fuse_do_setattr() fails, then the acl would have been
removed but the mode bits weren't updated. Maybe reordering it for
that case so that the mode update happens first before the xattr
removal would be safer (eg if the xattr removal fails, the old acl is
still there to enforce permissions)?

Thanks,
Joanne

>
> ...which is to say, does anyone think that's worth the churn?
>
> >
> > Overall, this lgtm though.
> >
> > Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
>
> Thanks!
>
> --D
>
> > Thanks,
> > Joanne
> >
> > >         }
> > >
> > >         if (fc->posix_acl) {
> > >
> >
