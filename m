Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338F041B352
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 13:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777556927; cv=pass; b=m9z+CAsq+VcQXR+1xLHJdMoPIb6nwqbXMW2zEdGEQt6HJk2fTz0YOytxHy0YVDQqBC8tVrr5+HjX1Gw6Xdx7btefJ0YAWvTTJGLdrDXWhugW8+PonlwnCgtMrN9jmwsW9lkLTsIsWC/EC7SNUSwjfaXG/gKWGXyh7mCQBa+YCHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777556927; c=relaxed/simple;
	bh=awoGZxf2q3nDKXFPFxE9tpePPmL8Dty+XBwhKFFJwI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i7zknpJTzrkTAN2nnq1lxiw59msHJQX1VZ+LUSJlUpMbui3RbayayuWvVBTsve7/cH1SDdQOdOnAzL2NGScseUi9ihir/ggzun04tMdJcOOHtonlEAUk+HCMtHF6J9qAI1sytcm5G2+zXHbtdPVLyfwPAmrPn1qZdo57r4105LI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hmjzkwm1; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hmjzkwm1"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d43e09de5so506428f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 06:48:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777556924; cv=none;
        d=google.com; s=arc-20240605;
        b=cFK4v0uIn3G9VcqYO2tlOntlWirPe9sjfmSx/Nvij09snnkpb2q8Pij+s/piD+Y4hh
         v9YSNIT+yuUcSHogS5KZgYZ3M3uzqnXoKDW3mQd4KphwtM5P/KG04IBP0bzjXPAuJ7LM
         A9q3DAjDx4fKssv2U3ijs3hGu20RNUOfeDq4nSVC7VLIFNToeI+xLNG8Hdw5nFSS4083
         /EZEEP0AK4DA++A1sd+hZ/JIorDFwknqC6R9wifqfFucyfNugxdbMMQU2+tumwL6H3hp
         WBpFP80xtr14G+JxUsIi8TB3MTP/9a13gAQtTkY/yZU1AObkYBE+Qt3rIAUrmtD/2rTT
         +Q6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vDQMX39ARER7sr8oPR+B6TmAFYNGVE2TnJKAY5kjymE=;
        fh=+zsYn5UJGYFGEWWnM2O4LHGmbIZwxgcGpaa8R7MZjWE=;
        b=UcqJzjJl4lYgTkz8UdjGp2NWzZVOfmGCXur1uFaABV3BnHC4q8Klx4p6V9VcZt8ko6
         NHFyJwRuvGHRsUEtN4JXTceVAVXfU8gV8bSpuFWMBmSX97MJmYQHccnF4ce/q2p6Aayv
         wl5WRaeSzBjZkV97zzDzhJaGzYXjCqIUZxTpXP4ZsP7rZePfjRoz/F0HEXYa5XphesVl
         pR6ByaElj1NpJ2vc2oKiPCUu506ueEjOHSA9eQ6ZmbmZDwjSmCqc05pE2WLGTO4Vr5dM
         Xy4t9Crmad2x4KFxYI8BEe9fHokk3+aQGbGfuM1V6TltHEJwFWgdfqz1bZprpU2dYuig
         t4XQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777556924; x=1778161724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDQMX39ARER7sr8oPR+B6TmAFYNGVE2TnJKAY5kjymE=;
        b=Hmjzkwm1tMxSqle4yR3IBmlFbHPElGJlgTn27IelC3snAxEGghKkpGIO1xcytGUsFq
         px6DXk8NQTKkGb/zbIsJdEIP05he3HXp0LX58g5ZMEKOLuIBC3ta9+Dmqk1O0R5sFoE1
         hlRRfKoGG0ALRkb/aq/NbK6rlF067Ychhq6QYZ+wHEGW5+5QJBIAc8x4Wha4woYB1dkM
         OSA3Xh8LOrHXt62JkmXWtuPkfN/bKErnEFTcQxFEdBacIxTDTk/NPyu2pMP4b3VQMJXP
         CQjzQd0xmEPm8zq3YmXiIyobGUV9Rnk03JKg8KA/jhMcsEwmXjjfFSlsbt/yK0R2aWrk
         pz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777556924; x=1778161724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vDQMX39ARER7sr8oPR+B6TmAFYNGVE2TnJKAY5kjymE=;
        b=Zc51TGMEN2C1DO3wtlBk6mxDM6O7AvcsgjD5/02VZdF9edM+mdL6r0Asalg+cC7Bhf
         3wgckViOOUD69T7Jb8BOrl+wZpW+X1XPIZH5gAtHpXAxQu45khv3ErqwSuce8KFhb0vJ
         DEYxgYZcbAx05Rj1RFk0QRyiGD89QpYRV/fjKTx/LvchYM9hJLHDLPojqgnvrT66DiaI
         4biUf82i9aKxZMY1Q6Pchs6iS5RXndP7b7iiUVA85JB8X8PM+Hh2Dm+gaomaxZjOZ3mS
         myJWjKy1F2o9el+EL+zy2UJ3UIzxv7yVxKARsMCow/+q7Q0M0j0yJtMwb2DKEhDOE6xY
         hw6A==
X-Forwarded-Encrypted: i=1; AFNElJ+eQ05RrBKr/O73hoy3QENY/PR4f0thyR7W8ly5HKQHVkKKl6c6EyVxxuzRN2ICFn8sjWYxRpk79jQCyfcc@vger.kernel.org
X-Gm-Message-State: AOJu0YxpVc+2rGQepXzCM2AXeqxw3QHCn8zItTTEceIKqiCUpySkDsoC
	JI3ij/zFj72AJE905L7SxTLRXccK0DbCbFvO6w2Lgk5idLis5sDh2fGnr5W/nFRPdCqM0VS5hFW
	XyhLiiPbFkw6+1O29GXGRTc6ttsAtTB/kQp0aiw2y0A==
X-Gm-Gg: AeBDievxBB8XdsoX9zvkogzh0K5L4/Bv5L1l1rbZIeSj4R3T+7MvlvJGYkE8BY7K4Hb
	TS2MQvUB11NsfG0MG+rhAcDLVZ4ATMv0VExfIhNNE7N+iNklw1mmbagAGUmGwrgHr4vjShHhZyQ
	NMWElyKIN+sJ2mX6EQ6m/kQLchH7u61a7QIwdAShdGromRmzH4qbco1QsLv4Hnpzp3hPE+bZaRg
	q2mW9NZ1Keynmt+YrU+CEjZixFJzrkeiqEmDZNc/p+n8NPl80y+B8/CCn+WNA5bBcG678iZVmIc
	BiojvCO1AF9W3uVZf00TKVx6MqokT863ZQ==
X-Received: by 2002:a5d:5f56:0:b0:43e:a69b:d810 with SMTP id
 ffacd0b85a97d-4493f42d8acmr4932087f8f.38.1777556924354; Thu, 30 Apr 2026
 06:48:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177747203969.4101397.1905820467457875817.stgit@frogsfrogsfrogs> <177747204051.4101397.16466232272715875212.stgit@frogsfrogsfrogs>
In-Reply-To: <177747204051.4101397.16466232272715875212.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 30 Apr 2026 14:48:29 +0100
X-Gm-Features: AVHnY4LuvqdirL71TOiHeNzEGws525X31LZFSgOdKMvBLmbLHgxA4PpQ0acvD3I
Message-ID: <CAJnrk1bYYBf2qYBvhv=MFKvG-2VekKwHCuRS6tjva=tExw6Gdw@mail.gmail.com>
Subject: Re: [PATCH 3/4] fuse: update file mode when updating acls
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org, 
	bernd@bsbernd.com, fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 3:22=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> If someone sets ACLs on a file that can be expressed fully as Unix DAC
> mode bits, most local filesystems will then update the mode bits and
> drop the ACL xattr to reduce inefficiency in the file access paths.
> Let's do that too.  Note that means that we can setacl and end up with
> no ACL xattrs, so we also need to tolerate ENODATA returns from
> fuse_removexattr.
>
> Note that here we define a "local" fuse filesystem as one that uses
> fuseblk mode; we'll shortly add fuse servers that use iomap for the file
> IO path to that list.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_i.h |    2 +-
>  fs/fuse/acl.c    |   56 +++++++++++++++++++++++++++++++++++++++++++++++-=
------
>  2 files changed, 50 insertions(+), 8 deletions(-)
>
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 4c135a7edf54ac..0bcfb42592895c 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1050,7 +1050,7 @@ static inline struct fuse_mount *get_fuse_mount(str=
uct inode *inode)
>         return get_fuse_mount_super(inode->i_sb);
>  }
>
> -static inline struct fuse_conn *get_fuse_conn(struct inode *inode)
> +static inline struct fuse_conn *get_fuse_conn(const struct inode *inode)
>  {
>         return get_fuse_mount_super(inode->i_sb)->fc;
>  }
> diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
> index cbde6ac1add35a..bee8a9a734f50a 100644
> --- a/fs/fuse/acl.c
> +++ b/fs/fuse/acl.c
> @@ -11,6 +11,18 @@
>  #include <linux/posix_acl.h>
>  #include <linux/posix_acl_xattr.h>
>
> +/*
> + * If this fuse server behaves like a local filesystem, we can implement=
 the
> + * kernel's optimizations for ACLs for local filesystems instead of pass=
ing
> + * the ACL requests straight through to another server.

nit: "to the server" instead of "to another server"? another server
sounds like there's 2 servers

> + */
> +static inline bool fuse_inode_has_local_acls(const struct inode *inode)
> +{
> +       const struct fuse_conn *fc =3D get_fuse_conn(inode);
> +
> +       return fc->posix_acl && fuse_inode_is_exclusive(inode);
> +}
> +
>  static struct posix_acl *__fuse_get_acl(struct fuse_conn *fc,
>                                         struct inode *inode, int type, bo=
ol rcu)
>  {
> @@ -98,6 +110,8 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentr=
y *dentry,
>         struct inode *inode =3D d_inode(dentry);
>         struct fuse_conn *fc =3D get_fuse_conn(inode);
>         const char *name;
> +       umode_t mode =3D inode->i_mode;
> +       const bool local_acls =3D fuse_inode_has_local_acls(inode);
>         int ret;
>
>         if (fuse_is_bad(inode))
> @@ -113,14 +127,25 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct de=
ntry *dentry,
>         else
>                 return -EINVAL;
>
> +       /*
> +        * If the ACL can be represented entirely with changes to the mod=
e
> +        * bits, then most filesystems will update the mode bits and dele=
te
> +        * the ACL xattr.
> +        */
> +       if (acl && type =3D=3D ACL_TYPE_ACCESS && local_acls) {
> +               ret =3D posix_acl_update_mode(idmap, inode, &mode, &acl);
> +               if (ret)
> +                       return ret;
> +       }
> +
>         if (acl) {
>                 unsigned int extra_flags =3D 0;
>                 /*
> -                * Fuse userspace is responsible for updating access
> -                * permissions in the inode, if needed. fuse_setxattr
> -                * invalidates the inode attributes, which will force
> -                * them to be refreshed the next time they are used,
> -                * and it also updates i_ctime.
> +                * For non-local filesystems, fuse userspace is responsib=
le for
> +                * updating access permissions in the inode, if needed.
> +                * fuse_setxattr invalidates the inode attributes, which =
will
> +                * force them to be refreshed the next time they are used=
, and
> +                * it also updates i_ctime.
>                  */
>                 size_t size;
>                 void *value;
> @@ -137,9 +162,10 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct den=
try *dentry,
>                 /*
>                  * Fuse daemons without FUSE_POSIX_ACL never changed the =
passed
>                  * through POSIX ACLs. Such daemons don't expect setgid b=
its to
> -                * be stripped.
> +                * be stripped, unless they've explicitly told the kernel=
 to
> +                * take care of that.

nit: imo this would be clearer as its own sentence, eg "For local
filesystems, the kernel already handled sgid stripping in
posix_acl_update_mode() above".

>                  */
> -               if (fc->posix_acl &&
> +               if (fc->posix_acl && !local_acls &&
>                     !in_group_or_capable(idmap, inode,
>                                          i_gid_into_vfsgid(idmap, inode))=
)
>                         extra_flags |=3D FUSE_SETXATTR_ACL_KILL_SGID;
> @@ -148,6 +174,22 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct den=
try *dentry,
>                 kfree(value);
>         } else {
>                 ret =3D fuse_removexattr(inode, name);
> +               /* If the acl didn't exist to start with that's fine. */
> +               if (ret =3D=3D -ENODATA)
> +                       ret =3D 0;
> +       }
> +
> +       /* If we scheduled a mode update above, push that to userspace no=
w. */
> +       if (!ret) {
> +               struct iattr attr =3D { };
> +
> +               if (mode !=3D inode->i_mode) {
> +                       attr.ia_valid |=3D ATTR_MODE;
> +                       attr.ia_mode =3D mode;
> +               }
> +
> +               if (attr.ia_valid)
> +                       ret =3D fuse_do_setattr(idmap, dentry, &attr, NUL=
L);

maybe something like this is clearer?

    if (!ret && mode !=3D inode->i_mode) {
         struct iattr attr =3D {
                .ia_valid |=3D ATTR_MODE,
                .ia_mode =3D mode,
          };
         ret =3D fuse_do_setattr(idmap, dentry, &attr, NULL);
    }

Overall, this lgtm though.

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

Thanks,
Joanne

>         }
>
>         if (fc->posix_acl) {
>
