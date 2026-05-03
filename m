Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820A7391E5B
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 May 2026 20:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777840662; cv=pass; b=JWrPgrbC3ItGYPlPbyabeQEZ/9hTuh13KHbk3YmHRJe3whUGJdoU+Bxnxgg5xzNS5d6puNV0/2HiRcjGpjtoHm4y7ngvTPP/4wH5VEzDk+DYA9FDXhuVdx12jXc4Q6bI6pv6DVWPdLIQNfZCnKZevOT7YWsVg0NT/nKGmJ3S1xU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777840662; c=relaxed/simple;
	bh=ZK6kVE4aK4cIz4P0nuY6XGFvB37lYQqSEZxrRsUBqQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FIZFPm1otMsWBpkchhN5asadZdCrLWl3e0K/8vfCsDXBu8ECH8CZoqkNH70eP6Klq4DlGWkFg86gf64Qb+x9OCWFzpHlxCSx0H548SNd7BXGLat/r5Bry5GDpQHvOP+K/u1kvJdjsqK/3kLl7tY6yjif9Oa3/w2YYb0jguW/1gY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fI5E++54; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fI5E++54"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ba6838e76f2so377203566b.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 May 2026 13:37:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777840659; cv=none;
        d=google.com; s=arc-20240605;
        b=MgI/vJ0nNVZe7ikcTJpR+JxJnjM1sFIG+lSftqAxVAlbXOEbUWvn9AMqNr8GMTrWnf
         TU3sxNKaJxeyYKTe5yOCaH6c62H7429Khu6Glb6twnfm4l2Jr4qZ5/C7v33nCvgWYvbn
         1uAgfvoImrYfA6389CCGg7PjFV1dpa33463mR6iU5BAkxTDaUDp4owqRgG/AhwuIEQs+
         GxtzYzQoAzQnfAL4mFfLFLzxr1fTVQ8Iof0BhJfAQNhxRoFrCLnvmMZV79ALqHo78PSQ
         vybQCdfF5hrYeT0hWhTD/pM0JR1QmQnS7uSvFrtkm0Qa8qwhymrAW9lwUwZtX4D5NcMA
         JWWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oYDjILYmC2Y2v1Vrp32Hw/02aE233hVhJfUp7KpMFnU=;
        fh=53RW8v7fbEZ+oAQMUbKFUGhEpOUHy5IX6Yp8qmMuayY=;
        b=Bd3/la9Q8+6bXEGtzSbLJ4QLWejy53tlqykOwpGWpV3AxVcTcxeSFE43OpWgfnqE10
         ZCKsZcIsqvTvWGYllFdyRgWh1ObEjdrESTTcoL2lNpbSaolZ/e8tKcCdxS61qjKmztiJ
         9GOQRCCkUo+QG2rM35M0Sw2rxXtDYgRvwvkddQwl6rRJHPcU9MJaNfODcj19lKWt1Wha
         KJKWwH6ndz3MpVjv1bz2Zpekwo20J1uvtPHgRpJDo5V3cnGRG44h2iF+T6G5NgybIMMI
         0s5mQ6o13EyiylnCMjCCVJXOIStr939rw+YCF7J4jY7NS4C9TVdwVT1zuE/Q2BKvZEbO
         STwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777840659; x=1778445459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYDjILYmC2Y2v1Vrp32Hw/02aE233hVhJfUp7KpMFnU=;
        b=fI5E++54Eh/Bu+4qAfNYX2HtpCshbg6DTZGQAAaZiGG3tPLsUCr3JvB+GlFFzisQ8w
         VOkRyn8FHwx2o3pW2Q8w+IfjtxIeDmU85TxaStFMbmwYoCogLlRsgVRbjMGLJbyVm5/P
         V740t1pxDs+XHbbJJCr0ao9SvBC79r2YDLFNWhSg4dbKRYb8e59Caq42iwfXtumJU8DG
         g7UdFIB0CYDQ/li9t2rNa62BqWTo6uR7pLzYacaT9kO0psn6WQHZMMrrltejIvtdDqc8
         aRuDDp+G0bMG9lQ56Ld358hHzq3Daptp5tjbYY4evR5PJMRZM2Af30HTWSt1bDy4lb9f
         uVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777840659; x=1778445459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oYDjILYmC2Y2v1Vrp32Hw/02aE233hVhJfUp7KpMFnU=;
        b=d6mmnUOxa3sE50ckFS550fktyPSiry7yPqzBgOBXq2GHgUptExjPMzCyp9mMiGJQS7
         re81hhw0QY5+ioe/rqAzCABoNQDO5ZBKDxaxlZeaOvGhcnVCCUXO2MWwyuPd+qwEhp9H
         qVwvB8LRvqbz5R0CSELhZJFRvu4iLlRZ7AomXaCgdXAXRLnEmKES9F5IN/NH98/d9Vhs
         F/2j1Edi3J4aKMvJbM5HS+uN5te0XTew3v1ivYG5c8QdDc4lrNDxxOeAeDJFGzlRVrJK
         iQ2TqBzTPyPnOBQIEJi6UEAc/OxnFqI70ZxX6jFGd9d7mTXA6QfIsOAHRJcqtumZ5LcW
         h43Q==
X-Forwarded-Encrypted: i=1; AFNElJ/mdappatjuwMcf3il1BaUyMtm/Er+JkuJnNoCnb8QGTsljiA/W2QxV87yt4EYpTHMYKb5TF87E07C1OyEW@vger.kernel.org
X-Gm-Message-State: AOJu0YzLpmO+b1kGAFyODVTT6TMbVswLnYSDHkTh4doKrrUZggPAIPDA
	J7k6qzydhuFmTSCM8jdbfP396I9zEhzwga3nmDCbsFet6dtFObnV2SP+Ex83dlHK86tlkqlnGOr
	q5R0d38KLrZoKn1O3xtKy3PVibMRn2V0=
X-Gm-Gg: AeBDiesO6m2LiuCvf66HKnGHH2a6NUE/ZaI3XjwPOjqrqI/YpRmT8F3qr06GxTVh4ie
	b2C/f9bN4Vjht6uCvoel70yhDh5VjLm/hvthNat55MaFSyp1iD5CM6Pf+sQDIMdNebodJPAtxbO
	obEzwsZ6SQn/oKbD52s+GHiuHenI3wVmjYuqRfIBojRNoZMaEMCodkavjavdX/QuU76rTv0MSPD
	BsQnmSna8bo8RlOK8CaI7JZ6aGSonnsQIogSjxoetpD3BUHZnlJweZ7NrJ8c68Ivw9hT+mDiMHi
	R7nXDGz359t1/0M8+g==
X-Received: by 2002:a17:907:84c8:b0:bb8:fd88:f401 with SMTP id
 a640c23a62f3a-bbffb043992mr251200166b.25.1777840658652; Sun, 03 May 2026
 13:37:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260501232735.2610824-1-souvik@amlalabs.com>
In-Reply-To: <20260501232735.2610824-1-souvik@amlalabs.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 3 May 2026 22:37:27 +0200
X-Gm-Features: AVHnY4IQ3DwkmtwigHf-eOErVpffi8TOS1hCi4QQA1RgX6m_dsBwKEfxps9aVY0
Message-ID: <CAOQ4uxh6YUJEh75sASqi1gOaQYKpWhftz4to1j8s2Y9Jef-XQg@mail.gmail.com>
Subject: Re: [PATCH] ovl: use linked upper dentry in copy-up tmpfile
To: Souvik Banerjee <souvik@amlalabs.com>, Christian Brauner <brauner@kernel.org>
Cc: miklos@szeredi.hu, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 2, 2026 at 1:27=E2=80=AFAM Souvik Banerjee <souvik@amlalabs.com=
> wrote:
>
> ovl_copy_up_tmpfile() stores the disconnected O_TMPFILE dentry as the
> overlay's upper dentry reference via ovl_inode_update().  vfs_tmpfile()
> allocated this dentry via d_alloc(parentpath->dentry, &slash_name), so
> d_name is "/" and d_parent is c->workdir.  Local upper filesystems
> (ext4, btrfs, xfs, ...) immediately rename it to "#<inum>" via
> d_mark_tmpfile() inside their ->tmpfile() op; FUSE and virtiofs do
> not, so both fields stay that way.  Neither identifies the destination
> directory and filename where ovl_do_link() actually linked the file.
>
> When the upper filesystem implements ->d_revalidate() (e.g. FUSE or
> virtiofs), ovl_revalidate_real() calls it with the dentry's parent
> inode and a snapshot of d_name.  The server tries to look up "/" inside
> c->workdir, fails, and overlayfs reports -ESTALE.
>
> This causes persistent ESTALE errors for any file that was copied up via
> the tmpfile path, breaking dpkg, apt, and other tools that do
> rename-over-existing on overlayfs with a FUSE/virtiofs upper.
>
> Before commit 6b52243f633e ("ovl: fold copy-up helpers into callers"),
> the tmpfile copy-up path used a dedicated helper ovl_link_tmpfile()
> that captured the linked destination dentry returned by ovl_do_link():
>
>     err =3D ovl_do_link(temp, udir, upper);
>     ...
>     if (!err)
>         *newdentry =3D dget(upper);
>
> and published it via ovl_inode_update(d_inode(c->dentry), newdentry).
> The fold inlined ovl_do_link() into ovl_copy_up_tmpfile() but dropped
> the dget(upper) capture, and rewrote the publish line as
> ovl_inode_update(d_inode(c->dentry), dget(temp)) =E2=80=94 where temp is =
the
> disconnected O_TMPFILE dentry.
>
> Fix by keeping a reference to the linked destination dentry after
> ovl_do_link() succeeds, and publishing that dentry at the existing
> ovl_inode_update() call site.  The non-tmpfile/workdir path continues to
> publish the renamed temporary dentry.
>
> Reproducer:
>   - Mount overlayfs with virtiofs (or a FUSE fs whose server advertises
>     FUSE_TMPFILE) as upper
>   - Run: dpkg -i <any .deb>
>   - Observe: "error installing new file '...': Stale file handle"
>
> Fixes: 6b52243f633e ("ovl: fold copy-up helpers into callers")
> Cc: stable@vger.kernel.org # v4.20+
> Signed-off-by: Souvik Banerjee <souvik@amlalabs.com>
> ---
>  fs/overlayfs/copy_up.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index 13cb60b52bd6..e963701b4c87 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -853,7 +853,7 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx=
 *c)
>  {
>         struct ovl_fs *ofs =3D OVL_FS(c->dentry->d_sb);
>         struct inode *udir =3D d_inode(c->destdir);
> -       struct dentry *temp, *upper;
> +       struct dentry *temp, *upper, *newdentry =3D NULL;
>         struct file *tmpfile;
>         int err;
>
> @@ -889,6 +889,14 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ct=
x *c)
>         err =3D PTR_ERR(upper);
>         if (!IS_ERR(upper)) {
>                 err =3D ovl_do_link(ofs, temp, udir, upper);
> +               if (!err) {
> +                       /*
> +                        * Record the linked dentry -- not the disconnect=
ed
> +                        * O_TMPFILE dentry -- so that ->d_revalidate() o=
n
> +                        * the upper fs sees the real parent/name.
> +                        */
> +                       newdentry =3D dget(upper);
> +               }
>                 end_creating(upper);
>         }
>
> @@ -903,7 +911,7 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx=
 *c)
>
>         if (!c->metacopy)
>                 ovl_set_upperdata(d_inode(c->dentry));
> -       ovl_inode_update(d_inode(c->dentry), dget(temp));
> +       ovl_inode_update(d_inode(c->dentry), newdentry);
>
>  out:
>         ovl_end_write(c->dentry);
> --
> 2.51.1
>


Hi Souvik,

Thank you for the analysis and the fix.
Looks correct to me.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Christian,

Could you pick this up for vfs-fixes?
I do not have any other ovl fixes queued up.

Thanks,
Amir.
