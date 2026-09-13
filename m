Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8C026CE2C
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789311094; cv=pass; b=qVBC7PQDCxby3AWOL0StG138ZQr6t+f38nMvCiEFXLqvNNaLPK2a02ZvSfl/l2FJfFSZOLWFsmvJ5mJbIsY3GCXhHpJ6PCtWe4nJdjWfhjYdl/FUBRYVQLeeiJhS2Km5qQtJqzHVoAnP1MuoNERuBlvP3fL+drNGolQxMcbePLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789311094; c=relaxed/simple;
	bh=U6Cz7nC+aX4P0QBeaWHHKotWTMtyZHTqqFKSJ/+pDcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nL+xjaVpLHuqS4kCBrB1KdgjneVrr1pKX3z1KK8zxMyB7ikJOXddZoPP0TsfX0qe0xtRBHeNs/NfimfpEbTc5b1ErslAB0VZIoqSkbJZXCUNWPpF37+Dxt1IwDuFrtS78dM9LgDBIU0irpA6jq7m4D8bGYk8oUd7ZBl6/W0QuWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkBWTWRN; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkBWTWRN"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f55eff0so132906366b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 07:51:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789311091; cv=none;
        d=google.com; s=arc-20260327;
        b=c8XxeLKqFSI6ri3TjG2tiw4iwLLe2RBocA51gdYHogMLbwR4xJxgttLvBshO+X2G0z
         zWlQH7GX/KlCtgAxetKFBZcGueFYANNvqY/Xy6396W/a7/Og5pxoieTwudbT51audhEE
         dIHXwwAN9MMT127lF3JFtCdYdY/VZb2m+ZaAyJSvdDgIlk4f5rVpTFKdWJEsVvSYa6w/
         spOEJX1II3TcmMXM8Ub0yPQDLlDjoZReAtkL/59D4PrC17ZT21sIB4soGKb4gC5IBExW
         3f5RHWRxO+1u61lS2+MXiQpNYorPWIVOXgpXQ/QFHw2SYOVmDKHRQpZJuOvSzcNnAefk
         t5OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/A57JkHsOA+C8UXQaVFMCiOBZ9Y6TKcUQ9Z20dIJoXY=;
        fh=ASV9kOH/y19sk89mpv/VxDyMon9k4lyQTXbDWJEpOzA=;
        b=QenCnrAtDN8CEkCL3nF4Suituaqt34nt55fiylRYD7QCa72zvttWEeEtYNLcRv9vtm
         ozq5J54V+uIrGm28at58+h0/YqUrcgXscjBuBxUcdWyTKLmJf/1jnbQzA6jXpbQTbuoy
         R0VAMnrL5xqxKV8Fskw5kbqD7xo41JQ+JtiuGXairhV4Wk/u0nWNKb5EI2eckpAHchzZ
         hr40gQuZnoTY0krJYvia3cxhufXbCjqszKBv0B40M8TMr634D0o5+AVFEG/69RRPwpL7
         +dm0nzhzafAGIFqR6VWqVsCHu9ToAUmQpURl+84StEWgM9A+J87ZEcKkuEQOLyYrU4i2
         cMRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789311091; x=1789915891; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/A57JkHsOA+C8UXQaVFMCiOBZ9Y6TKcUQ9Z20dIJoXY=;
        b=BkBWTWRNW5i4lucsVr8mr/LGVDBuodk5KvILTrBR+QEOQ+7lkvDFXSQ6Yf+MdR9bKU
         ih8Pz99wjpGThaVjQQ8uMLittqhf0eflBlyIt2ZCLc43gBRZFC35ZdmQkuDQ5bTktXQ6
         y3Xe2uNoDDxu7Lbd4UYcawzjKh7KgETogIpuHtXnBa+Dcbi9tvZo/7u5YoWhZGKs//HM
         4RtgEekh+H/LL1VEpYIXjXymMeFIPdIbaRHu+hpuQxVKdM1h2opU3mNsIIVkQY3hjoh+
         EbY5NAUVJjFv1Pf2VrPZlU+4iVjxWlXcHMQZTJvSDcdm4CNjmGbHRSCEPkFuSCugFeeO
         P2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789311091; x=1789915891;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/A57JkHsOA+C8UXQaVFMCiOBZ9Y6TKcUQ9Z20dIJoXY=;
        b=i+nX+9HL4H+P45ZlNvEGRUc54b0hmUKVCTLsM7YXXgJuRA/aOfDaJG8rNbvVJm9WTj
         Z1DSi61PlFxkAHpnvQQe1cMgKLXIWrla9gmPVkjvYkMXxNMqGHvTpkC4WWJRKdWOPOMu
         x/KbT0Dg9vqrDJLwgeV0YVb+1QYfC9UqEu43WVZv6Yok0YTm8aakeKhPrvlnPNqYrgaw
         1ObEvRcXVZMrO6JfMyyRtiYS3Q7F6NmlmR8HD5OacqLehxhj1CVEoTyJ2Wuzje3oUEpt
         X3zHO+vvjtIWQ+0yDyf6MPWmFvkNxQR98y7aCWnfqqk7SwnRLEP9f/nMgC1XWAFc6UAc
         dCwg==
X-Forwarded-Encrypted: i=1; AKwUvBxyJyECjaz78jxJEIU3DH8pJSJzBNWDd69nIPjixoUa9+MGXtQcOnMchyKHgFF46qHNMG7P+KzPIGRg0dvo@vger.kernel.org
X-Gm-Message-State: AFuF++kXcXqs0keoDKBhXhwTGE/iQhdBy4nqfv/lTk77+L47EKWknhzE
	UiAntQF8enK+WipnnVfzFKujCnv5spicXHTo87JTnV+P8YQi2lDvNTHk7C9IaaF+8jCjEedQCYt
	v/KlHQ9nB/jGzFNM4cqrQQkwI43XINh4=
X-Gm-Gg: AYBFou0mj9TxMnDVLsr/9C9fP4u8eUj4qVrqdetFlm0dXpqkXvvmRDPKbGgDpSrtt6Y
	GxBWIfQiFMhQpv8SsbsoqiSWu4RfDb014fbM/zaTmRUWx7l5ngw0aKaRnPCUZZbe9Glmvj0nqsh
	jbWjBYU1OblkZ9obxYI0UBDGjZMS6/kmMAo/iCrUjXV02WRNuJnFaRSao1+eqazYvbeZBlkJUf7
	dCYX9PnEH7bo3zoj1xdyW0NuNqO6puogZCNdbeflG95UruzT+COxszfS9niq8DtS5yOO9OqlMxH
	S50QWZPZfH840UEuul95c6KV9Amirrgs7I7uNrIuSgJrZSTQlLOz3H50uBb7kFZVXBOyfRdADKE
	xyOretDR/YA==
X-Received: by 2002:a17:907:6093:b0:c26:1691:b36d with SMTP id
 a640c23a62f3a-c29858842cbmr399520766b.38.1789311091357; Sun, 13 Sep 2026
 07:51:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913144918.1606123-1-mjguzik@gmail.com> <20260913144918.1606123-3-mjguzik@gmail.com>
In-Reply-To: <20260913144918.1606123-3-mjguzik@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sun, 13 Sep 2026 16:51:19 +0200
X-Gm-Features: AcwNN1X1rdspH6JI1iXNYOsa8ljwnzz2DO1twadqF9g5ZfaY7EiBXHNmk6aHnJs
Message-ID: <CAGudoHGyaBkcLfggaUYgcKPLhzZzN7_YELomKsQBR0qiX+hPyA@mail.gmail.com>
Subject: Re: [PATCH 02/10] fs: add path_create(), path_move() and path_clone()
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 4:49=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>  fs/namei.c           | 29 +++++++++++++++++++++++++++++
>  include/linux/path.h | 14 ++++++++++++--
>  2 files changed, 41 insertions(+), 2 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index ca4f5e3be99a..c8754c7ba8be 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -698,6 +698,35 @@ static __always_inline int lookup_inode_permission_m=
ay_exec(struct mnt_idmap *id
>         return security_inode_permission(inode, mask);
>  }
>
> +/**
> + * path_create - WRITEME

sigh

I'll take care of it. for the purpose of review pretend this is actual text=
 ;)

> + * @path: path to get the reference to
> + * @mnt: WRITEME
> + * @dentry: WRITEME
> + *
> + * Create a path object using the given vfsmount and dentry pair while i=
ncrementing
> + * the reference count on both.
> + */
> +void path_create(struct path *path, struct vfsmount *mnt, struct dentry =
*dentry)
> +{
> +       path->mnt =3D mntget(mnt);
> +       path->dentry =3D dget(dentry);
> +}
> +EXPORT_SYMBOL(path_create);
> +
> +/**
> + * path_clone - WRITEME
> + * @path: path to get the reference to
> + *
> + * Given a path increment the reference count to the dentry and the vfsm=
ount.
> + */
> +void path_clone(const struct path *src, struct path *dst)
> +{
> +       dst->mnt =3D mntget(src->mnt);
> +       dst->dentry =3D dget(src->dentry);
> +}
> +EXPORT_SYMBOL(path_clone);
> +
>  /**
>   * path_get - get a reference to a path
>   * @path: path to get the reference to
> diff --git a/include/linux/path.h b/include/linux/path.h
> index 7ea389dc764b..8a621e0e1921 100644
> --- a/include/linux/path.h
> +++ b/include/linux/path.h
> @@ -10,8 +10,18 @@ struct path {
>         struct dentry *dentry;
>  } __randomize_layout;
>
> -extern void path_get(const struct path *);
> -extern void path_put(const struct path *);
> +void path_create(struct path *, struct vfsmount *, struct dentry *);
> +void path_clone(const struct path *, struct path *);
> +void path_get(const struct path *);
> +void path_put(const struct path *);
> +
> +static inline void path_move(struct path *src, struct path *dst)
> +{
> +       dst->mnt =3D src->mnt;
> +       dst->dentry =3D src->dentry;
> +       src->mnt =3D NULL;
> +       src->dentry =3D NULL;
> +}
>
>  static inline int path_equal(const struct path *path1, const struct path=
 *path2)
>  {
> --
> 2.53.0
>
