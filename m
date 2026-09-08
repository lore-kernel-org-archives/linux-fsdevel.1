Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7A348F019
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 22:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788905150; cv=pass; b=esB6WrdkCHVd3o75lLdGzUvtDJ+6lJqPsUr3D1+cEOgRYZ+K0iDLWMo/EMBPXLgRLGRQuFHRCV57zqNkffX0cOWMRrdPj2JHW66dbVh1TWWjM9liYEdkNSFK/BJ5yxLa3arw7iSgtvPNIu+cRLScr0avcbc1AGaoUm7VSRIS2+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788905150; c=relaxed/simple;
	bh=gWyldk0oc12yDTN1m54loFdW4UdsmUa/ZK1j4ZExUpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQnhbfEluEn8EhXlVaAQxWg5PLEQGvYRyhGHzDMnQHS6higTD37oRV0Hrq9qeZOPEqBJds9SrI23RbFXqCV3LvmbHs+4wDPfOjBCtlBIGRZLh227J4j3Tn+wQcPymyBrLnA0hxbCIzwn42980mrdX+fVr93FCFF1ti7NC9WIlpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZLRLTFZw; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZLRLTFZw"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d6f9e2f681so56426545ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2026 15:05:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788905148; cv=none;
        d=google.com; s=arc-20260327;
        b=FaJbWRUBGCelu85jVmd70qL3N65yE8ax1bYtZoKfLlLDRXSEE1ALXh/guJZRnOdM8r
         cS137VMH3BxeZ9JONxc/j0Cl1qhP/Na63CywcOuDpd60ZAsjAy3TsvDhjJ61U/Bc4qlm
         nvVoyZLWTzMR9zg/eZHyD68IJScgz9rtPdJIYXA35MJBHMPC82SyNHPAS7k+FcGbxPbQ
         SElL45khefwfhCIYXbUARHuwjfBiJ0Ob+DE9mNxRmBlpm+0LFcEjWfD+mXr1b7WBNDjZ
         tg3oakf1kG0KdWQzFCxRyZr8uSd6mHnxs9TKYM8lpgi/W/hup0RIfwRirrLQ59D430gA
         xdOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wViXqQw+49Q+sqlxh6pZf9kI4lGcySkRvR38g0HW4SQ=;
        fh=nC8RJpJctjtA/3l0UMfIHwfE4rN/OwdDGZgCd6+ni14=;
        b=eKD5Gsrmt9n1Oc7OfQErcXmvDgY18ZMywb+GdCkpl+R0it+8v9PogYWmoaFUFqFl9O
         XrBaeIsv7tnrTqy3SuCPSarOnoSJ218ILgWAq+2dBW1UR/G4acwOqCqnsAsrqwbUt5ZC
         AcP3YdGGmn6dP+WcOQVkxomvgr5nOhIG/xL0dwM5etgQ/9C0PeM5dpbT5R5wM8NQM3Bq
         M4NtG6L/DZMeV5nERlcDDH9yfyLcN6RiiGipwCzeFn3gwaSlh//5o4mbNkiaUOBaNNSF
         2Ke1kpsmjOjAfKOYfjtoTD9A/A9LTvWFcbcYK+ZutKvQVkhV0NRrLhdg10LiA7RRr8A7
         Blqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788905148; x=1789509948; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wViXqQw+49Q+sqlxh6pZf9kI4lGcySkRvR38g0HW4SQ=;
        b=ZLRLTFZwLnb/2GRIUNigIpydpUPDsmiveg10k8EXIkCTcHEUDSd+RkwAVSEpPLIGuH
         kIOqYVJmHZzAfexFzAlmVKCgoLzv2LjpeIQGs9ONCLNn0uA8rUrEoCHsbOdy9OpLX3qT
         8tpVgiri4S2nkwKCXj5DN2+GdfTWYec99FrEzKhnMpxfuKpZUu75y5Dw1Um7hSTQoSuC
         eaXZnaKLUVb/hJSZKbb2ZmhSDY//hKM/w7ZVt+RKv1JFZ5RJTY9aIDGnSaQD5V0gEjki
         U66rI1gkH9XZuCfrha+GExcm7CHZhtmGpG3etgue6tkV0j6GD1x1h+rIcsBnHYTGgbvF
         xlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788905148; x=1789509948;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wViXqQw+49Q+sqlxh6pZf9kI4lGcySkRvR38g0HW4SQ=;
        b=P3mwQHLiljis7E+uOymNra4ICiSk/SGbX2W/XaHfr3tHCr+LPcWl+54GGbovDsAnx2
         HWMVIt0PEolzLuI/uXrOY7mQog6w+D36ViI5ABgb9Xu5cgVePP3MFTJxMU2tDEMShhOt
         E2bWWZkri4wawclL1QnKZPoZpo/GfIyfQc5RgZpN42Jt+tv14e4pmcSz+6cMn9+EXuvF
         CcoeJotd3AX8sQ4Ut2fkgEyTMi59KPclbC8H6WE/q9eqpI6u+qmPgy8fHJ7cF+Fdmvdd
         NRL4jHxv+zXYAKEKsKRLqiMGdcG615ahcHWZkiA7n8+rT/ZDV+o4bwEqtyqqJVgiwozs
         m+pA==
X-Forwarded-Encrypted: i=1; AKwUvBz/6uVjY5ll/7m750rFD2LqUgbUTyFa2D/UFZD3BVNQSZdF7k96cPzXxqwzIdpB5arspQ0BhDAx28JiQJsZ@vger.kernel.org
X-Gm-Message-State: AFuF++nXv5DN9cGvcUUMsg0KvzEEy8lm6ULTaXnVEOjyTXaW++ZfdJhi
	XOtQ1q43xY8LrpH1UepqmTHaFb4mPQiTRfvYYlTahhgdb92LSdz5KrmOKYm3+gsd3ZixVfcr08W
	u1a7ldWG3fpNCqz6wc/8lERmGnHwuiW+4NlRp4AgA
X-Gm-Gg: AYBFou3d0lVHgAmsVDVCsW1Z6i1u39+6Skfy2wNcy/gUXjThP6JH0akhWUGXbLQv5IX
	tk2rzI7jFmq25ZMwsjabBhbw3FjvktTDn0z/L9hVeedAaQxtwg/79Gs27SmBjeW73slcycHDat+
	NpQPNp8pj9p+uFMPdf5wTX8NQ5HgoNkJ4vN9BmLt2rs/4Qm9m/zaRUS96NkCA1SCk5RlofEHJBD
	xMkeZ6OpMWKMo9kXRs9pvF9/ZWDAXcJLUx2RVL1Xn+POQuHYsywZNCdYlVpHH8WH1F0e76EWBXC
	tN4hZf15owIWGHQ6W0fkVuAXL851/fa9xjTvkrYddzUwNGoRglKtcpYfmMSSEgi1sfd6cXx3Ve1
	U
X-Received: by 2002:a17:90b:3ec5:b0:398:9c00:29ed with SMTP id
 98e67ed59e1d1-39b26277673mr45556792a91.21.1788905147387; Tue, 08 Sep 2026
 15:05:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-lsm-mount-idmaps-v3-0-920a1963675d@amutable.com> <20260904-lsm-mount-idmaps-v3-1-920a1963675d@amutable.com>
In-Reply-To: <20260904-lsm-mount-idmaps-v3-1-920a1963675d@amutable.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 8 Sep 2026 18:05:34 -0400
X-Gm-Features: AcwNN1VBzLRcTymdA1zjcoOHYpTWayCftPPsC70quA8PGtg67RyLgDxcQLUcPf4
Message-ID: <CAHC9VhS5q2=6p2bi5c7CZ3mutji1xiKR2eFKgJ9C+XZsYgky2g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] lsm: expose mount idmaps to inode hooks
To: daan@amutable.com
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 10:48=E2=80=AFAM Daan De Meyer via B4 Relay
<devnull+daan.amutable.com@kernel.org> wrote:
>
> From: Daan De Meyer <daan@amutable.com>
>
> Pass the mount idmap through the create, link, symlink, mkdir, mknod,
> and permission hooks. Update the in-tree security implementations and
> non-VFS callers accordingly.
>
> Signed-off-by: Daan De Meyer <daan@amutable.com>
> ---
>  fs/cachefiles/security.c      |  4 +--
>  fs/namei.c                    | 18 +++++++-------
>  include/linux/lsm_hook_defs.h | 23 +++++++++--------
>  include/linux/security.h      | 58 +++++++++++++++++++++++++------------=
------
>  security/security.c           | 40 +++++++++++++++++------------
>  security/selinux/hooks.c      | 19 +++++++++-----
>  security/smack/smack_lsm.c    |  9 ++++---
>  7 files changed, 100 insertions(+), 71 deletions(-)

Casey, are you okay with the Smack changes (below)?

> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 8e88ac65fd7f..a45819d13c0d 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -1089,14 +1089,15 @@ static int smack_inode_init_security(struct inode=
 *inode, struct inode *dir,
>
>  /**
>   * smack_inode_link - Smack check on link
> + * @idmap: idmap of the mount
>   * @old_dentry: the existing object
>   * @dir: unused
>   * @new_dentry: the new object
>   *
>   * Returns 0 if access is permitted, an error code otherwise
>   */
> -static int smack_inode_link(struct dentry *old_dentry, struct inode *dir=
,
> -                           struct dentry *new_dentry)
> +static int smack_inode_link(struct mnt_idmap *idmap, struct dentry *old_=
dentry,
> +                           struct inode *dir, struct dentry *new_dentry)
>  {
>         struct smack_known *isp;
>         struct smk_audit_info ad;
> @@ -1226,6 +1227,7 @@ static int smack_inode_rename(struct inode *old_ino=
de,
>
>  /**
>   * smack_inode_permission - Smack version of permission()
> + * @idmap: idmap of the mount
>   * @inode: the inode in question
>   * @mask: the access requested
>   *
> @@ -1233,7 +1235,8 @@ static int smack_inode_rename(struct inode *old_ino=
de,
>   *
>   * Returns 0 if access is permitted, an error code otherwise
>   */
> -static int smack_inode_permission(struct inode *inode, int mask)
> +static int smack_inode_permission(struct mnt_idmap *idmap, struct inode =
*inode,
> +                                 int mask)
>  {
>         struct superblock_smack *sbsp =3D smack_superblock(inode->i_sb);
>         struct smk_audit_info ad;
>
> --
> 2.54.0

--=20
paul-moore.com
