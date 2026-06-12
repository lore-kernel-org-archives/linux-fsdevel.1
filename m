Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A155357CE0
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 07:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250208; cv=pass; b=M2X4NX8MmViLkr1h4fGrax45VvK27RDf4/INduvb6JiaYo/aVacuUI3RSUTDZ4Pn3GICNT9yuH7B/pU0/nNniXN1/sxwOIw+zG6b4TUM5oIB7gqyTRKp/BMDEr9ubhKHIAMf7cQJ2XaNUs8lAD9pdXVM7rTabVRMiAhFhZSO6Sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250208; c=relaxed/simple;
	bh=VrH4UKHRvTmB/2CptIwHtfPA2ScYldlqyYcLfApLtK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JIpvLBt5Ziw7e9YRZ3X9uHKkRkWsBZLSku0NvwhYQx0vs0qbJEqx65Sd0x3nWCVDzT95iACqYzszFZ9UFVs/jR0hVz9EmFkj2KaxdnkW81J/mOWXFLpsBMwOJRECkcijIXTQHc/r9kZkdFkJHANLpg4XtvX9rKxvKCNx8OYY1Cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShitvveZ; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShitvveZ"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-69165354c87so821869a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 00:43:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781250205; cv=none;
        d=google.com; s=arc-20240605;
        b=JJ1q2eHD2t5sELbJQYSBKdJo/LvD4e47jBKS94b9nMtWsYBHDPK0YumW/ciHvc3L5y
         LNBmBqLpv93ZQWWbB/u3+dWObQf0zXuN+06elJPc/OUIx0qTBFZ+/Nupukan2t6bmV4H
         UwLchqsUrIg5VNzV1EvlLKNcJwlHwd/TzcsHorUT6zitNGIU92pORn/QTQO5SMj+EuAK
         2jIOaA+h3gjvfEqtD4dO6/a/SIh+cCTYDknOeBGLSyBLT2cyjYOYewIYrf0CYGHLs9R6
         aNU5Lwhxr2tc0k9hY65RIoc0SO1tWqjwrUNKkmGkGHp3v8Ol0dblydliuaI39vWgxjX0
         ZmAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=un+XV168Qec4A0LpZpVP4rjWX9m0fs7Zzq7wZ4T4rgQ=;
        fh=lKM5XLUUVlGAaHYQ7DeunSSOyBlA1sqIkqePt+vHUkY=;
        b=J2Gz4PYN2jrapmeryXstoSTPf6X3JXkmpGWtJ5hq6sKxcQCCNx6DpgIGGevKzPo5RW
         5RdjVcUnBjJCfsbYVzGdU9BKplqnfUPGTUoNtE/8qta7lPxPvORalhe/w9iFexDY4JI5
         bM48Mtwtau88h7xrlVlbvY13V+MewL+k3TF9csa2GVT7vsFxytr6i1PPaasJFU2KCKga
         2rwx6jt4c76IhcbJepmUopEgSJHypXCv9tWpaxf5+zYQ2KTzTTIgDt1uSA/bjABEotOj
         zpx/ZrcUeOTt0aZ4redr9sZ1a8/+pKTQg7XBx/kFbPW9nYL/7gxN2dUyZXyog4VUfEB8
         1vfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781250205; x=1781855005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=un+XV168Qec4A0LpZpVP4rjWX9m0fs7Zzq7wZ4T4rgQ=;
        b=ShitvveZr6CwxzGJqA27RIoHbV4cCFHslOGbvbzwYxi+TFvfUXTLCLSBQKYR3mGCA/
         CMUug4YwdzgGNTY0LKITZtWwm+CXP4mquA2IC7d5MpaAMF7YkZcfOG02EoW1naHYb339
         Umbi4EyxBNxvKgBu29XFaNCxlcoAslKKc3x5+3+J6OOPXUPdOA2B0+VFXR6OByzTaGeN
         bhb5Y8RCrq3P9IlODJjbm9bPIiGiUYqh/oPgfTPQer5FisQwAEHbPmd0OV15829SXxLH
         Qx39jzLjR+exTPMTmq4MM1JDC8IS5Z/aPjzm2JoQXt7oCvQmlVG9V9qEPiyukb5jJK/B
         5x6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781250205; x=1781855005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=un+XV168Qec4A0LpZpVP4rjWX9m0fs7Zzq7wZ4T4rgQ=;
        b=X4Apli0SNWNJ08APIaQ9jQ4ChoResLlOsUR3zD5f4h/4KMTRSWF4PrqfgkFP8OcBbU
         NfekbXHScfz+cXEawAXr71NwkIWP55KSPcYSwrLwHzvHVfMMMhosDAOcmXtLCsYYvPvN
         9/pW3YDnGxNWefYOI+XMAJY5hTcekx6ouL9/Wt9k66gh+W6uSTU142XbYeRcT5BraQQu
         NNrKkAfJXzxeAl2eD6sgEzyTh5S/poITZW9pth2IA7MOnpHSKAIkbYDdRRo+/U01R++U
         xowhxXLFX7CskIDWy73xYJvz7uu5ViK2/xjSenk6uAzQRkK0RTSs7r4gzCGeTJBZOQlt
         W08w==
X-Forwarded-Encrypted: i=1; AFNElJ/SUe7eOii8b7VmjwdXlC0NP0TTUBDt1RBfeUetEz96mTGffObM9EtT8Ne2s1dGSKIYiRCPQcoXDeWqXDul@vger.kernel.org
X-Gm-Message-State: AOJu0YxXhHL5KVbTkjcFK302PuHisK3WlOaGolXXs3rGmdE8qJ6r1lff
	68saCZIhXW9In5z6gGRwZ7b9B8dYZLW02yKsAo8urm1vn+POZaMhFwSUiNyTzB1fZmFZvJz3WDT
	6REO3sBrZS6v61N9CM1F0aw1tVilo+jM=
X-Gm-Gg: Acq92OGuKlAdokc61MiD+Y0T2D8mgnCz1+CynP3HfNrZztGmWFuEve+Z9ovz93H+fNd
	9Pv+8IDsO5u7d2PESw2bHFVs7TANFcOlW2ExR7Cr2rjMjmoLXgLcUXNFskITPH4DCUmoX+wxdRT
	ARYPu5yP1FCITKMYjGBKYmSwXuylKpF/c9MNlKIRGkunLFfV+QAU47+sf1wyaaRuco4CnCUPYl3
	AZEhkNTCgiw9N/cLd8QklS2ZRi6VDgLcFPJVFEudWxrzcImOMMPWdE8Er3ZJNCfZqxYVdkYax9z
	es64LUhEfvOrT3HnbdaOMGjqJjNeyjdvCs0NKKTw
X-Received: by 2002:a05:6402:3891:b0:691:affa:38da with SMTP id
 4fb4d7f45d1cf-693784f79d7mr698652a12.1.1781250204504; Fri, 12 Jun 2026
 00:43:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260501232735.2610824-1-souvik@amlalabs.com> <CAOQ4uxh6YUJEh75sASqi1gOaQYKpWhftz4to1j8s2Y9Jef-XQg@mail.gmail.com>
 <CAJfpegtnj0wmQ_mJCwJ+UKqzG_LTrUCwhRyc_NAhHj2T9Jr8uA@mail.gmail.com>
In-Reply-To: <CAJfpegtnj0wmQ_mJCwJ+UKqzG_LTrUCwhRyc_NAhHj2T9Jr8uA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 12 Jun 2026 09:43:12 +0200
X-Gm-Features: AVVi8Cfsd00rG_CuZ-3XJb7ocjHsCW2AA5Bpj46lwTBlumbSNluLhGMMoUvO0ww
Message-ID: <CAOQ4uxiv7yKyuLX_cTdu6f_Gnzk4XR+R4NAuTa_kDhJRV7i=ig@mail.gmail.com>
Subject: Re: [PATCH] ovl: use linked upper dentry in copy-up tmpfile
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>, Souvik Banerjee <souvik@amlalabs.com>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 1:26=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Sun, 3 May 2026 at 22:37, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Sat, May 2, 2026 at 1:27=E2=80=AFAM Souvik Banerjee <souvik@amlalabs=
.com> wrote:
> > >
> > > ovl_copy_up_tmpfile() stores the disconnected O_TMPFILE dentry as the
> > > overlay's upper dentry reference via ovl_inode_update().  vfs_tmpfile=
()
> > > allocated this dentry via d_alloc(parentpath->dentry, &slash_name), s=
o
> > > d_name is "/" and d_parent is c->workdir.  Local upper filesystems
> > > (ext4, btrfs, xfs, ...) immediately rename it to "#<inum>" via
> > > d_mark_tmpfile() inside their ->tmpfile() op; FUSE and virtiofs do
> > > not, so both fields stay that way.  Neither identifies the destinatio=
n
> > > directory and filename where ovl_do_link() actually linked the file.
> > >
> > > When the upper filesystem implements ->d_revalidate() (e.g. FUSE or
> > > virtiofs), ovl_revalidate_real() calls it with the dentry's parent
> > > inode and a snapshot of d_name.  The server tries to look up "/" insi=
de
> > > c->workdir, fails, and overlayfs reports -ESTALE.
> > >
> > > This causes persistent ESTALE errors for any file that was copied up =
via
> > > the tmpfile path, breaking dpkg, apt, and other tools that do
> > > rename-over-existing on overlayfs with a FUSE/virtiofs upper.
> > >
> > > Before commit 6b52243f633e ("ovl: fold copy-up helpers into callers")=
,
> > > the tmpfile copy-up path used a dedicated helper ovl_link_tmpfile()
> > > that captured the linked destination dentry returned by ovl_do_link()=
:
> > >
> > >     err =3D ovl_do_link(temp, udir, upper);
> > >     ...
> > >     if (!err)
> > >         *newdentry =3D dget(upper);
> > >
> > > and published it via ovl_inode_update(d_inode(c->dentry), newdentry).
> > > The fold inlined ovl_do_link() into ovl_copy_up_tmpfile() but dropped
> > > the dget(upper) capture, and rewrote the publish line as
> > > ovl_inode_update(d_inode(c->dentry), dget(temp)) =E2=80=94 where temp=
 is the
> > > disconnected O_TMPFILE dentry.
> > >
> > > Fix by keeping a reference to the linked destination dentry after
> > > ovl_do_link() succeeds, and publishing that dentry at the existing
> > > ovl_inode_update() call site.  The non-tmpfile/workdir path continues=
 to
> > > publish the renamed temporary dentry.
> > >
> > > Reproducer:
> > >   - Mount overlayfs with virtiofs (or a FUSE fs whose server advertis=
es
> > >     FUSE_TMPFILE) as upper
> > >   - Run: dpkg -i <any .deb>
> > >   - Observe: "error installing new file '...': Stale file handle"
> > >
> > > Fixes: 6b52243f633e ("ovl: fold copy-up helpers into callers")
> > > Cc: stable@vger.kernel.org # v4.20+
> > > Signed-off-by: Souvik Banerjee <souvik@amlalabs.com>
> > > ---
> > >  fs/overlayfs/copy_up.c | 12 ++++++++++--
> > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> > > index 13cb60b52bd6..e963701b4c87 100644
> > > --- a/fs/overlayfs/copy_up.c
> > > +++ b/fs/overlayfs/copy_up.c
> > > @@ -853,7 +853,7 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up=
_ctx *c)
> > >  {
> > >         struct ovl_fs *ofs =3D OVL_FS(c->dentry->d_sb);
> > >         struct inode *udir =3D d_inode(c->destdir);
> > > -       struct dentry *temp, *upper;
> > > +       struct dentry *temp, *upper, *newdentry =3D NULL;

This init is not needed and confusing because never in this function
using a NULL newdentry is correct.
We rather get an uninit variable warning if that happens in the future.

> > >         struct file *tmpfile;
> > >         int err;
> > >
> > > @@ -889,6 +889,14 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_u=
p_ctx *c)
> > >         err =3D PTR_ERR(upper);
> > >         if (!IS_ERR(upper)) {
> > >                 err =3D ovl_do_link(ofs, temp, udir, upper);
> > > +               if (!err) {
> > > +                       /*
> > > +                        * Record the linked dentry -- not the discon=
nected
> > > +                        * O_TMPFILE dentry -- so that ->d_revalidate=
() on
> > > +                        * the upper fs sees the real parent/name.
> > > +                        */
> > > +                       newdentry =3D dget(upper);
> > > +               }
> > >                 end_creating(upper);
> > >         }
> > >
> > > @@ -903,7 +911,7 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up=
_ctx *c)
> > >
> > >         if (!c->metacopy)
> > >                 ovl_set_upperdata(d_inode(c->dentry));
> > > -       ovl_inode_update(d_inode(c->dentry), dget(temp));
> > > +       ovl_inode_update(d_inode(c->dentry), newdentry);
> > >
> > >  out:
> > >         ovl_end_write(c->dentry);
> > > --
> > > 2.51.1
> > >
> >
> >
> > Hi Souvik,
> >
> > Thank you for the analysis and the fix.
> > Looks correct to me.
> >
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> >
> > Christian,
> >
> > Could you pick this up for vfs-fixes?
> > I do not have any other ovl fixes queued up.
>
> Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
>

I applied the patch without this init to NULL to ovl-fixes, so that it
will be in linux-next.
Kept your RVB. Hope that's ok.

> This seems to have slipped through the cracks.
>
> Christian?

I don't think it is particularly urgent to merge this patch for 7.0
this late in the cycle, so I will hold off on sending an ovl-fixes PR.

Christian,

If you take this ovl fix (and the other one [1]) to vfs-7.2.misc
let me know and I will remove them from ovl-fixes.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-unionfs/20260609184656.1916631-1-amir73il=
@gmail.com/
