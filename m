Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53694414
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2026 01:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775870404; cv=pass; b=OmUTanltA3n3c54WuqzhEbuceHXsU8BCvVzSt9zf9z/CgBD3IXGfAEnIAyfFFhpkdDW0WZbuy49JwtdDBoxXh9hUmj8SpCXnGSp0ysK7f2KCKWKNRd1pOMXe03iXjhamEW87vtdrXfRGzgeigVlYiFTtH55sVaMmwKtjv9evbcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775870404; c=relaxed/simple;
	bh=22rFAgDqVDG50ejhrpQv4hJWXdghfRkmLipndupE0ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hcj2sMCTFKP/jDsgxPV4Zkn0jMtBATiqIV+IVkCUkn85wLHyKqo/Y0seLYsquUWmT9M0Q4OB1BvPxUxqWGOTh2bDPLBSyoYzZnuMFK5jO8atH8c/Dpx6MlEoIiKwlaORBHubpnmbNVUl7bAChPwoRQH/4/V6ZzghGmNWudnxFYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScjNDfg2; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScjNDfg2"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8a1e1817db6so22057876d6.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 18:20:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775870402; cv=none;
        d=google.com; s=arc-20240605;
        b=KOtzOYAhRBZ0j7HtnqD5zCSTaHWt1ykCPsyRwyJX3PfMeysjWRvrek6HEayhggeH8g
         q+J+qQkZXrffBzQq3Xmla6r0L9D87OuRUHPbmQuf4tuXkMEONmDg6kn1s+F8pyrpVSmG
         hYFQwWGqa/ALIiJJyCH0e7AAaab+IBNzbC+5rmkUpZ6DHPhl7nmvFjNKnQhTykOCvuzQ
         m2VRAgPYdExR4TLgtm0W0ILwlFzDgNW+UgF8+094/xnLI6doQY/FHNhICNvWyBCnkAwg
         MO3DUk1Ch5aH4/mVclgrfrNdtGzl4Z/tdXhoHzYIhk+1EcXDfh6t1wsAu5TGbtId1+Ak
         NEMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BoYCXVPyh3KeQurt9+gDQolsDYN//x6FIjC2f2/YJk8=;
        fh=0OzqAiztnCxSzXb7qWijPKQIpz3VSKIkRycjzaz64RU=;
        b=B0hN5zTHeSeqYQNN3FZdtXs7ulzmXyF5myM6q9DMYbihSOuLZLQziXOriId7fhYY0W
         DPY/+pY0InmHr540+FqHQVCii0m7L9kvxYHSiuMrKvrfiFv97DvgfwVN4vRN4aGOVnfK
         /8yjF52cpf2dhZwb7q5IkWFJ3W/u8ngS1gXCahDGiiNs8XZkGUhbB0z5aKfiolCaW3xr
         a78Gay2Dqlrn5v/9hNoB0muwKdQC8Nnm0eEKVXJIqrjEa1oIWDb6z/rW0u9P11wGzHzH
         zZ5o0iRpCAMJ1OgcMfmXxyAc0gzY0qmHv9geBQrfiZr9Evuk9nAMfP9dKzsVLy/hNz2U
         EYWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775870402; x=1776475202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoYCXVPyh3KeQurt9+gDQolsDYN//x6FIjC2f2/YJk8=;
        b=ScjNDfg2TXABRaqGnDRC5kscf5XlZrZDDxXgggkuofrKbXAmRK12PimPCCb0AfctQM
         i7mt73HHyHlHwMkqr6DyrCUXN1t2Eswey3LrsmDTG1XD4LastO6Qvi61igjD3b6lwtbx
         9oBDGxibAilVcZFVXzBYOLLrqLAk76wfPEiQCJ+wr3Wjvackm4FcrriC0o9qqUM1vsLk
         wNno9gsrX55vN8ulgd5luh/j7brHMfBQeHPteZOyeXRX1PzTz4WnLnl9zuWwXNN0pAgq
         OYarNgXVrpgIXTq15mWaiaOeCgHy8QjcGLUidTiuCEhc0j+C5B1WncsAgZNGp2KOysYy
         eEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775870402; x=1776475202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BoYCXVPyh3KeQurt9+gDQolsDYN//x6FIjC2f2/YJk8=;
        b=oDVaJE8ep38+HXPExstnDwTPxwzyeLHj/oF/EkZpG6QKfYN6hrl9CHdqp93byhhzfo
         ypEG8HXa05u9HKpKPceVKSNfYW+qglmZN9OIpc5aSHPgmTTP/N3sVwhUYPrdCYwRv+KR
         IKeDP3AQA6kVQ9KFsqpDN4uiFQLYu1fa7QAMVyjx/knZxfuoEN1QDa1y70gTHx1NVE/J
         2jWWpa28Wiglw2LBDlz56VqehZOczTektDuNAu+M7+9jTSpjwbd4X38ozO/1ESXlcxfW
         J+JaJgAAC76POgCArqzdISisriP1EPI/CGMyVAN11WN8WV9CTvYS5EclJjfqBry1FLcd
         lELQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPTH8wv0gRTB67/LnBh7wLmCFdMmNGCxRLu0KjdwgyW0uZ5tq8AYJlgRyCNZ4JmcCGhAA8UwlxpiKukzR1@vger.kernel.org
X-Gm-Message-State: AOJu0YyPpFDAB5l+NfPhvIWCQy6GlkWLQr8LB1ufUyfkgT+SW7GQx+Cy
	lh2+OrDG0iX2gXPtI9Klv+BouJYfVOT/cLO5PilD59hCg2u4EMgyh/TAfynW5yBEriyj33TSdv7
	VfZu5fgc2fp9u5ZdGiEMx60T5hKxLUXP+1w==
X-Gm-Gg: AeBDieu/XwLwJE/L0b5LtMsjp5hc+EdRROjPM7FH2ukf4UsCi6pK5JqfO+Zmpytgc4g
	MTyRMEGloDA/w1HztUkKVgXpJl3SiA6Kd+GVE9wqLL3H9bLwbCNbXd7EMwOTYmej2gdElqpfDtW
	IpIzMdEeOptZ+rEjaFVqFMj2/L3vfDvjucHX59iBytoXbPqzd8QfHAjLO2ARTpWOCYJ3NMe7MBl
	c3PBdQzl/PoB/itU74nMY1ExwLg8OF+DMzUcCc5CijJNfcQoXh3TgLKwN6MmIRS8y6UKuJcfRlH
	QQADbofHNtke25Sv5piBJDB/t1N7zK72NbA+10nhavPliobL9A67YpTLpVYiND1SS/POj55dp6B
	RDoQ1UhBTDvj54qHDzfw0+w/b0EEx6Sz0oArLy0xyfO520uynekdgJ5ieQRjQwxtT2poP9sEkRr
	BomeTr7yv1ZQstLSSZTDIixg==
X-Received: by 2002:a05:6214:3f81:b0:895:48c2:aedc with SMTP id
 6a1803df08f44-8ac862aaea0mr85807826d6.39.1775870401696; Fri, 10 Apr 2026
 18:20:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410232055.1582463-1-pc@manguebit.org>
In-Reply-To: <20260410232055.1582463-1-pc@manguebit.org>
From: Steve French <smfrench@gmail.com>
Date: Fri, 10 Apr 2026 20:19:48 -0500
X-Gm-Features: AQROBzARoYM-u0fR89e2CVNtSwAzLVKiCkVB8reyFtV35u3oyT1bDy_YUe9_JXA
Message-ID: <CAH2r5mvGYy9i8mPoWZah2kpv=98xaSFATsn1xbpihUa_RuhLEQ@mail.gmail.com>
Subject: Re: [PATCH] smb: client: get rid of d_drop()+d_add()
To: Paulo Alcantara <pc@manguebit.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, 
	NeilBrown <neilb@ownmail.net>, linux-fsdevel@vger.kernel.org, 
	linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

added to cifs-2.6.git for-next

On Fri, Apr 10, 2026 at 6:20=E2=80=AFPM Paulo Alcantara <pc@manguebit.org> =
wrote:
>
> Replace d_drop()+d_add() in cifs_tmpfile() and cifs_create() with
> d_instantiate(), and in cifs_atomic_open() with d_splice_alias() if
> in-lookup, otherwise d_instantiate().
>
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> Closes: https://lore.kernel.org/r/20260408065719.GF3836593@ZenIV
> Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
> Cc: David Howells <dhowells@redhat.com>
> Cc: NeilBrown <neilb@ownmail.net>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-cifs@vger.kernel.org
> ---
>  fs/smb/client/cifsfs.h |  4 +--
>  fs/smb/client/dir.c    | 62 ++++++++++++++++++++++++++----------------
>  2 files changed, 40 insertions(+), 26 deletions(-)
>
> diff --git a/fs/smb/client/cifsfs.h b/fs/smb/client/cifsfs.h
> index 64c7a4c6ac83..18f9f93a01b4 100644
> --- a/fs/smb/client/cifsfs.h
> +++ b/fs/smb/client/cifsfs.h
> @@ -52,9 +52,9 @@ void cifs_sb_deactive(struct super_block *sb);
>  /* Functions related to inodes */
>  extern const struct inode_operations cifs_dir_inode_ops;
>  struct inode *cifs_root_iget(struct super_block *sb);
> -int cifs_create(struct mnt_idmap *idmap, struct inode *inode,
> +int cifs_create(struct mnt_idmap *idmap, struct inode *dir,
>                 struct dentry *direntry, umode_t mode, bool excl);
> -int cifs_atomic_open(struct inode *inode, struct dentry *direntry,
> +int cifs_atomic_open(struct inode *dir, struct dentry *direntry,
>                      struct file *file, unsigned int oflags, umode_t mode=
);
>  int cifs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
>                  struct file *file, umode_t mode);
> diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
> index bfc887d506b6..6ea1ae7f7a46 100644
> --- a/fs/smb/client/dir.c
> +++ b/fs/smb/client/dir.c
> @@ -219,6 +219,7 @@ static int __cifs_do_create(struct inode *dir, struct=
 dentry *direntry,
>         int rdwr_for_fscache =3D 0;
>         __le32 lease_flags =3D 0;
>
> +       *inode =3D NULL;
>         *oplock =3D 0;
>         if (tcon->ses->server->oplocks)
>                 *oplock =3D REQ_OPLOCK;
> @@ -462,7 +463,6 @@ static int __cifs_do_create(struct inode *dir, struct=
 dentry *direntry,
>                 goto out_err;
>         }
>
> -       d_drop(direntry);
>         *inode =3D newinode;
>         return rc;
>
> @@ -478,11 +478,11 @@ static int cifs_do_create(struct inode *dir, struct=
 dentry *direntry,
>                           unsigned int xid, struct tcon_link *tlink,
>                           unsigned int oflags, umode_t mode,
>                           __u32 *oplock, struct cifs_fid *fid,
> -                         struct cifs_open_info_data *buf)
> +                         struct cifs_open_info_data *buf,
> +                         struct inode **inode)
>  {
>         void *page =3D alloc_dentry_path();
>         const char *full_path;
> -       struct inode *inode;
>         int rc;
>
>         full_path =3D build_path_from_dentry(direntry, page);
> @@ -491,9 +491,7 @@ static int cifs_do_create(struct inode *dir, struct d=
entry *direntry,
>         } else {
>                 rc =3D __cifs_do_create(dir, direntry, full_path, xid,
>                                       tlink, oflags, mode, oplock,
> -                                     fid, buf, &inode);
> -               if (!rc)
> -                       d_add(direntry, inode);
> +                                     fid, buf, inode);
>         }
>         free_dentry_path(page);
>         return rc;
> @@ -504,13 +502,13 @@ static int cifs_do_create(struct inode *dir, struct=
 dentry *direntry,
>   * Look up, create and open a CIFS file.
>   *
>   * The initial dentry state is in-lookup or hashed-negative.  On success=
, dentry
> - * will become hashed-positive by calling d_drop() & d_add(), respective=
ly.
> + * will become hashed-positive by calling d_splice_alias() if in-lookup,
> + * otherwise d_instantiate().
>   */
> -int
> -cifs_atomic_open(struct inode *inode, struct dentry *direntry,
> -                struct file *file, unsigned int oflags, umode_t mode)
> +int cifs_atomic_open(struct inode *dir, struct dentry *direntry,
> +                    struct file *file, unsigned int oflags, umode_t mode=
)
>  {
> -       struct cifs_sb_info *cifs_sb =3D CIFS_SB(inode);
> +       struct cifs_sb_info *cifs_sb =3D CIFS_SB(dir);
>         struct cifs_open_info_data buf =3D {};
>         struct TCP_Server_Info *server;
>         struct cifsFileInfo *file_info;
> @@ -519,6 +517,8 @@ cifs_atomic_open(struct inode *inode, struct dentry *=
direntry,
>         struct tcon_link *tlink;
>         struct cifs_tcon *tcon;
>         unsigned int sbflags;
> +       struct dentry *alias;
> +       struct inode *inode;
>         unsigned int xid;
>         __u32 oplock;
>         int rc;
> @@ -545,13 +545,13 @@ cifs_atomic_open(struct inode *inode, struct dentry=
 *direntry,
>                 if (!d_in_lookup(direntry))
>                         return -ENOENT;
>
> -               return finish_no_open(file, cifs_lookup(inode, direntry, =
0));
> +               return finish_no_open(file, cifs_lookup(dir, direntry, 0)=
);
>         }
>
>         xid =3D get_xid();
>
>         cifs_dbg(FYI, "parent inode =3D 0x%p name is: %pd and dentry =3D =
0x%p\n",
> -                inode, direntry, direntry);
> +                dir, direntry, direntry);
>
>         tlink =3D cifs_sb_tlink(cifs_sb);
>         if (IS_ERR(tlink)) {
> @@ -572,13 +572,21 @@ cifs_atomic_open(struct inode *inode, struct dentry=
 *direntry,
>
>         cifs_add_pending_open(&fid, tlink, &open);
>
> -       rc =3D cifs_do_create(inode, direntry, xid, tlink, oflags, mode,
> -                           &oplock, &fid, &buf);
> +       rc =3D cifs_do_create(dir, direntry, xid, tlink, oflags, mode,
> +                           &oplock, &fid, &buf, &inode);
>         if (rc) {
>                 cifs_del_pending_open(&open);
>                 goto out;
>         }
>
> +       if (d_in_lookup(direntry)) {
> +               alias =3D d_splice_alias(inode, direntry);
> +               if (!IS_ERR_OR_NULL(alias))
> +                       direntry =3D alias;
> +       } else {
> +               d_instantiate(direntry, inode);
> +       }
> +
>         if ((oflags & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL))
>                 file->f_mode |=3D FMODE_CREATED;
>
> @@ -622,11 +630,12 @@ cifs_atomic_open(struct inode *inode, struct dentry=
 *direntry,
>   * Create a CIFS file.
>   *
>   * The initial dentry state is hashed-negative.  On success, dentry will=
 become
> - * hashed-positive by calling d_drop() & d_add(), respectively.
> + * hashed-positive by calling d_instantiate().
>   */
> -int cifs_create(struct mnt_idmap *idmap, struct inode *inode,
> +int cifs_create(struct mnt_idmap *idmap, struct inode *dir,
>                 struct dentry *direntry, umode_t mode, bool excl)
>  {
> +       struct cifs_sb_info *cifs_sb =3D CIFS_SB(dir);
>         int rc;
>         unsigned int xid =3D get_xid();
>         /*
> @@ -640,19 +649,20 @@ int cifs_create(struct mnt_idmap *idmap, struct ino=
de *inode,
>         struct tcon_link *tlink;
>         struct cifs_tcon *tcon;
>         struct TCP_Server_Info *server;
> +       struct inode *inode;
>         struct cifs_fid fid;
>         __u32 oplock;
>         struct cifs_open_info_data buf =3D {};
>
>         cifs_dbg(FYI, "cifs_create parent inode =3D 0x%p name is: %pd and=
 dentry =3D 0x%p\n",
> -                inode, direntry, direntry);
> +                dir, direntry, direntry);
>
> -       if (unlikely(cifs_forced_shutdown(CIFS_SB(inode->i_sb)))) {
> +       if (unlikely(cifs_forced_shutdown(cifs_sb))) {
>                 rc =3D smb_EIO(smb_eio_trace_forced_shutdown);
>                 goto out_free_xid;
>         }
>
> -       tlink =3D cifs_sb_tlink(CIFS_SB(inode->i_sb));
> +       tlink =3D cifs_sb_tlink(cifs_sb);
>         rc =3D PTR_ERR(tlink);
>         if (IS_ERR(tlink))
>                 goto out_free_xid;
> @@ -663,9 +673,13 @@ int cifs_create(struct mnt_idmap *idmap, struct inod=
e *inode,
>         if (server->ops->new_lease_key)
>                 server->ops->new_lease_key(&fid);
>
> -       rc =3D cifs_do_create(inode, direntry, xid, tlink, oflags, mode, =
&oplock, &fid, &buf);
> -       if (!rc && server->ops->close)
> -               server->ops->close(xid, tcon, &fid);
> +       rc =3D cifs_do_create(dir, direntry, xid, tlink, oflags,
> +                           mode, &oplock, &fid, &buf, &inode);
> +       if (!rc) {
> +               d_instantiate(direntry, inode);
> +               if (server->ops->close)
> +                       server->ops->close(xid, tcon, &fid);
> +       }
>
>         cifs_free_open_info(&buf);
>         cifs_put_tlink(tlink);
> @@ -1035,7 +1049,7 @@ static int set_tmpfile_attr(const unsigned int xid,=
 unsigned int oflags,
>   * Create a hidden temporary CIFS file with delete-on-close bit set.
>   *
>   * The initial dentry state is unhashed-negative.  On success, dentry wi=
ll
> - * become unhashed-positive by calling d_drop() & d_instantiate(), respe=
ctively.
> + * become unhashed-positive by calling d_instantiate().
>   */
>  int cifs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
>                  struct file *file, umode_t mode)
> --
> 2.53.0
>


--=20
Thanks,

Steve
