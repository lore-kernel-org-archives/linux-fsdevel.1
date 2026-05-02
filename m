Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE8433F5BA
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 May 2026 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777733403; cv=pass; b=hzNUqugFyBzCQCgxVBPaemmdlObrDY+8jF8eIM/whFBvTa5X43kCr+yEHUeb99gRW5BUaC67ieUQE5Qr9XNTDQnIULKuYPqU3cp78Yr7oPhS6o8WFPfmOMjkacPx8LW/nrOOo2CLU5u2FYA7Nbe/SqEQh4kjaqcRTcVDwCeKcVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777733403; c=relaxed/simple;
	bh=7Zm22bb7k5CZqRmKKonJJMCPlOrZEXrOD3RabN/7vpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KgmsNNpP/Y+6LcOHcBP4ZyfwmfnyVyKuhPgfwr2G4JRWn4cDqc81xN3jFaTM9a+b5FB2jOwNey+6qsykmf9cYQMYzXciSkZTTWXq9TDHyxyNwPQozXmm8Dt3LBUVeD1YpYxYnR4nKGUCmCLimp7HJGuVprsuOPfxUAZ8TUBsqWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+Eoz1DU; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+Eoz1DU"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-799001d73bdso26020747b3.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 May 2026 07:50:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777733401; cv=none;
        d=google.com; s=arc-20240605;
        b=aYHlt/4yjOGv+V8aviW1Uuq4zMt+H//04CB21Wl0jMNp5L9JKArj8/wHqHI/JLw1Pf
         OEJo5GKmAqRxEkEfK1fh5JVJpdmKlYa9RTeMTx6R/roTCLmI1B24fSxZ6q5f+HweuFST
         kA7PO2GViZg2FZZYYGV22BFdI+qh51rpGE3iePC3ifFF0rMeIpxNXrL2zvY2N5RMKYSu
         Rv/zqqUN06GQ82XsSzLS98BfWFwd3O7QvzDWl9diy7HoCeZTypgE/2ij85ap1NLwrqKj
         0HGo0CElV76bTBd0N4UlFk0mBWc0YgFc6205vofsCNHglwYDddL0kcGOGygqE9wTi3Sg
         Un4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QBUvZoRbKONrWduOgYXXDvmJnsK5ce0NnYeg8V4pgso=;
        fh=4ic/LqQa1HsVwnqLtqxBpI7adizHiKA98nkj05DtKBE=;
        b=Y7kb4du5BBA1XoFS6tqnOs/K09zvOl/59a5FZ0WIQUzAU+zxDt3qFWTXRH32Uw1A/V
         yS6TLwqPJNuvD5U/a7bd/ujtaW8np16Jsmbskwn+o3/3AstL+aMZxU7CxKHBmrp0fO+/
         wPr5zZUBDm1pM69TRXgbF/2AZ9Z6u1qoo/KY2y7SkoGpjPeyf5lMWhUO0q3fMv2+ohgJ
         Y4mYxE+7kSEMUM2kTjwHzOdFAT72/aYr7rBe2okMp+O10dWOpgYnxPb07jbiLLVFJgs3
         SZJMrhdA3UtpGY/UtfOgisaiokhHwYOWLs2IWEjSNccA/0yk5wptbkPKBP/lyAW+dW6Z
         FUfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777733401; x=1778338201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBUvZoRbKONrWduOgYXXDvmJnsK5ce0NnYeg8V4pgso=;
        b=m+Eoz1DUN3N8BCRwIN2rQWLJFVUltqgsKnAUPByQ4iXyGspVQ5YUve6nh6kD7zV7Nf
         cOxdKsCqD3OBrWumhmb12MtQ9Yr+PSSUPydnys0vFPxGzRHGaxkZ9PBNTzDADhi4CV8+
         GTY8P/F+wzUwEshNnPUKwlCa79p3/fWEgDp/s+AhtORdFZN6V9BPIu2Wso2B4mSu1k5B
         q3NwIMkyfuB9TMpz3F6mKnBfl38RN1TVg6AdwFfyMgXJv+XWs9LAZ98v/zQib8HeLX82
         F4/8dAeEw1pr4klFhvpSd/EesdEm1p32T2NmjvFEQp2lRv1CVxLzEao32pXWL5MLZ9mG
         H1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777733401; x=1778338201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QBUvZoRbKONrWduOgYXXDvmJnsK5ce0NnYeg8V4pgso=;
        b=VZo5k/JgIOXpMBw1F3gluBiDkr14hAaoGpL4K0WXFb8JN+gA515oiKOePRVF+gYPTn
         1evHWlr5KH5y+VygMDGv2YCbWLBpkWpAjyjQOSZly+CiVOyLmEOK5nvQV2/9GybokWMd
         vZjofEzUnOpwEyctO6AYtfWGJeCqIB8JD2IICD30+2teTpw61gAwS/5o2a/M/5IMn6cq
         N8BySHIlyZ/Q5MOkq+wnOG/g6Be2LS4KgZlqeX+H+95lTQoNrKhEjzRlg8EHL5LPdStT
         WDdaie72JrHVEM4hx4ckeHHJtfFYpfKNFKcIJR85Rqwilfs5F9UJT3FunepqmtfdlAt4
         FX4g==
X-Forwarded-Encrypted: i=1; AFNElJ+LCbPp189K1BHasXYjgZWgSSUWND2i3qFgK6jpkBtgjulGyiqY1RlPWbfojMxBEJOrasvh2wvgfxICngOJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ7oVB+kFxGR/ukOSHh0IBgTrcMhUkp+As+IGLO+iwuWpcCjri
	EyVfxQglrgaYUt9fnZaNjQE4dDY0qX0Jjlnl0t4RO6JJo09wyZ0Wc7Kcf4wppCSlfTJ0Ma209Gc
	FiGHejQyM33MwhZQvYWnZlrBoc9VGA+I=
X-Gm-Gg: AeBDieuOCGvom9wsagV40BNsJ8jUPactks9AeLJf6vshJ8ZWeVG10qp1UxZrAWI7F3j
	orHfFAYLzyfBaAq8NM8bpbcRAOnrSN6B9ddwqBnmm2tTlccq1SeYst1VihX5Hdm0Bap0W7hieak
	6GHuRMnnsKGKlUGUmjDb9OX1+JEJHIoL8O4waFBpoXrtPkIMk1KQTL+aV/pVnKPqjcm/DhM1D+5
	YCKj2a3MvHN7XnNaWMn5+rPluCQLwBuy4G2qwWx2+0NX4VrVX4MpTwJH+sIArzHUU0pqWTSwEIT
	l+yHnRZXrGecI16V3Rq6x17lHINjwhHjwuInqiaW2H6c7gBbc/uEaMRQZbg9m9xwtjxxUZKcusq
	9t6vdhi8yZO6J96bfGg==
X-Received: by 2002:a05:690c:f:b0:79a:2f38:9a8c with SMTP id
 00721157ae682-7bd76fc2a1emr33596677b3.15.1777733401444; Sat, 02 May 2026
 07:50:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430020358.111052-1-kartikey406@gmail.com> <780d7cbfe8184eb2a90651393e0b3d28eee99ae0.camel@redhat.com>
In-Reply-To: <780d7cbfe8184eb2a90651393e0b3d28eee99ae0.camel@redhat.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Sat, 2 May 2026 20:19:50 +0530
X-Gm-Features: AVHnY4JxFK1Bwh4xa2MDZgy0pHvv0wWaGxgtaGf9gOVaoP0Uxr8is-EFAc9f7Zw
Message-ID: <CADhLXY5KsRUosTdmdxxkBS+c1SvOoSwNM8bSb5NUEJgt=1pkVg@mail.gmail.com>
Subject: Re: [PATCH v4] hfsplus: fix null-ptr-deref by creating hidden dir on
 remount rw
To: Viacheslav Dubeyko <vdubeyko@redhat.com>
Cc: slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 1, 2026 at 1:16=E2=80=AFAM Viacheslav Dubeyko <vdubeyko@redhat.=
com> wrote:
>
> On Thu, 2026-04-30 at 07:33 +0530, Deepanshu Kartikey wrote:
> > hfsplus_reconfigure() does not create the hidden directory when
> > remounting from read-only to read-write, leaving sbi->hidden_dir
> > as NULL. This causes a null-ptr-deref when any subsequent
> > link/unlink/rename operation dereferences it.
> >
> > Extract hidden directory creation into a helper and call it from
> > hfsplus_reconfigure() when switching to read-write mode.
> >
> > Reported-by: syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Dc0ba772a362e70937dfb
> > Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> > ---
> > Changes in v4:
> >   - Correct fix: extract hidden dir creation into helper and call
> >     from hfsplus_reconfigure() on remount rw, as suggested by
> >     Vyacheslav Dubeyko.
> >
> > Changes in v3:
> >   - Correct fix location: guard sbi->hidden_dir in hfsplus_link()
> >     and hfsplus_unlink() in dir.c.
> >
> > Changes in v2:
> >   - Fixed commit message: hfsplus_delete_cat() has multiple callers,
> >     not just hfsplus_unlink() as incorrectly stated in v1.
> > ---
> >  fs/hfsplus/super.c | 88 ++++++++++++++++++++++++++++------------------
> >  1 file changed, 53 insertions(+), 35 deletions(-)
> >
> > diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> > index 7229a8ae89f9..8b5c39ce4d48 100644
> > --- a/fs/hfsplus/super.c
> > +++ b/fs/hfsplus/super.c
> > @@ -372,15 +372,59 @@ static int hfsplus_statfs(struct dentry *dentry, =
struct kstatfs *buf)
> >       return 0;
> >  }
> >
> > +static int hfsplus_create_hidden_dir(struct super_block *sb)
> > +{
> > +     struct hfsplus_sb_info *sbi =3D HFSPLUS_SB(sb);
> > +     struct inode *root =3D d_inode(sb->s_root);
> > +     struct qstr str;
> > +     int err;
> > +
> > +     str.len =3D sizeof(HFSP_HIDDENDIR_NAME) - 1;
> > +     str.name =3D HFSP_HIDDENDIR_NAME;
>
> The hfsplus_fill_super() has this initialization. It looks like duplicati=
on.
> Maybe, we need to add this into hfsplus_reconfigure() and get str as inpu=
t
> argument?
>
> > +
> > +     mutex_lock(&sbi->vh_mutex);
> > +     sbi->hidden_dir =3D hfsplus_new_inode(sb, root, S_IFDIR);
> > +     if (!sbi->hidden_dir) {
> > +             mutex_unlock(&sbi->vh_mutex);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     err =3D hfsplus_create_cat(sbi->hidden_dir->i_ino, root,
> > +                              &str, sbi->hidden_dir);
> > +     if (err) {
> > +             mutex_unlock(&sbi->vh_mutex);
> > +             goto out_put_hidden_dir;
> > +     }
> > +
> > +     err =3D hfsplus_init_security(sbi->hidden_dir, root, &str);
> > +     if (err =3D=3D -EOPNOTSUPP)
> > +             err =3D 0;
> > +     else if (err) {
> > +             hfsplus_delete_cat(sbi->hidden_dir->i_ino, root, &str);
> > +             mutex_unlock(&sbi->vh_mutex);
> > +             goto out_put_hidden_dir;
> > +     }
> > +
> > +     mutex_unlock(&sbi->vh_mutex);
> > +     hfsplus_mark_inode_dirty(sbi->hidden_dir,
> > +                              HFSPLUS_I_CAT_DIRTY);
> > +     return 0;
> > +
> > +out_put_hidden_dir:
> > +     iput(sbi->hidden_dir);
> > +     sbi->hidden_dir =3D NULL;
> > +     return err;
> > +}
> > +
> >  static int hfsplus_reconfigure(struct fs_context *fc)
> >  {
> >       struct super_block *sb =3D fc->root->d_sb;
> > +     struct hfsplus_sb_info *sbi =3D HFSPLUS_SB(sb);
> >
> >       sync_filesystem(sb);
> >       if ((bool)(fc->sb_flags & SB_RDONLY) =3D=3D sb_rdonly(sb))
> >               return 0;
> >       if (!(fc->sb_flags & SB_RDONLY)) {
> > -             struct hfsplus_sb_info *sbi =3D HFSPLUS_SB(sb);
> >               struct hfsplus_vh *vhdr =3D sbi->s_vhdr;
> >
> >               if (!(vhdr->attributes & cpu_to_be32(HFSPLUS_VOL_UNMNT)))=
 {
> > @@ -401,6 +445,12 @@ static int hfsplus_reconfigure(struct fs_context *=
fc)
> >                       fc->sb_flags |=3D SB_RDONLY;
> >               }
> >       }
> > +     /*
> > +      * Create hidden dir if remounting read-write and it does
> > +      * not exist - required for link/unlink/rename operations.
> > +      */
> > +     if (!sb_rdonly(sb) && !sbi->hidden_dir)
> > +             return hfsplus_create_hidden_dir(sb);
>
> It looks like hfsplus_reconfigure() is always false on a successful remou=
nt. The
> sb->s_flags is updated by the VFS after reconfigure returns 0, not inside=
 it.
> The correct guard is !(fc->sb_flags & SB_RDONLY), which reflects the nego=
tiated
> new state.
>
> >       return 0;
> >  }
> >
> > @@ -595,38 +645,9 @@ static int hfsplus_fill_super(struct super_block *=
sb, struct fs_context *fc)
> >               hfsplus_sync_fs(sb, 1);
> >
> >               if (!sbi->hidden_dir) {
> > -                     mutex_lock(&sbi->vh_mutex);
> > -                     sbi->hidden_dir =3D hfsplus_new_inode(sb, root, S=
_IFDIR);
> > -                     if (!sbi->hidden_dir) {
> > -                             mutex_unlock(&sbi->vh_mutex);
> > -                             err =3D -ENOMEM;
> > +                     err =3D hfsplus_create_hidden_dir(sb);
> > +                     if (err)
> >                               goto out_put_root;
> > -                     }
> > -                     err =3D hfsplus_create_cat(sbi->hidden_dir->i_ino=
, root,
> > -                                              &str, sbi->hidden_dir);
> > -                     if (err) {
> > -                             mutex_unlock(&sbi->vh_mutex);
> > -                             goto out_put_hidden_dir;
> > -                     }
> > -
> > -                     err =3D hfsplus_init_security(sbi->hidden_dir,
> > -                                                     root, &str);
> > -                     if (err =3D=3D -EOPNOTSUPP)
> > -                             err =3D 0; /* Operation is not supported.=
 */
> > -                     else if (err) {
> > -                             /*
> > -                              * Try to delete anyway without
> > -                              * error analysis.
> > -                              */
>
> What was wrong with the comment? Why have we lost it?
>
> > -                             hfsplus_delete_cat(sbi->hidden_dir->i_ino=
,
> > -                                                     root, &str);
> > -                             mutex_unlock(&sbi->vh_mutex);
> > -                             goto out_put_hidden_dir;
> > -                     }
> > -
> > -                     mutex_unlock(&sbi->vh_mutex);
> > -                     hfsplus_mark_inode_dirty(sbi->hidden_dir,
> > -                                              HFSPLUS_I_CAT_DIRTY);
>
> Are you sure that you work with the latest sources? Because, current stat=
e of
> this code is:
>
>   hfsplus_mark_inode_dirty(HFSPLUS_CAT_TREE_I(sb), HFSPLUS_I_CAT_DIRTY);
>   hfsplus_mark_inode_dirty(sbi->hidden_dir,        HFSPLUS_I_CAT_DIRTY);
>
> >               }
> >       }
> >
> > @@ -634,9 +655,6 @@ static int hfsplus_fill_super(struct super_block *s=
b, struct fs_context *fc)
> >       sbi->nls =3D nls;
> >       return 0;
> >
> > -out_put_hidden_dir:
> > -     cancel_delayed_work_sync(&sbi->sync_work);
>
> Why cancel_delayed_work_sync() has been removed? The hfsplus_new_inode() =
calls
> hfsplus_mark_mdb_dirty() which queues sync_work. So, nothing cancels the =
queued
> work in the case of any issue.
>
> Thanks,
> Slava.
>
> > -     iput(sbi->hidden_dir);
> >  out_put_root:
> >       dput(sb->s_root);
> >       sb->s_root =3D NULL;
>

I will send the patch v5 shortly

Thanks
