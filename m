Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03129443
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 18:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775759955; cv=pass; b=u5QSuQgJgBSgIJVmV+FI1Gbmqvow9PuGtjIkBhLi+vL8i4RuB3F2U3yFiRAjxtterJ86ctUIrXJDbDIRlYnO0srBgIEDv1G8p87xDhVPFSErsGFlRN72AnZW3Gt234Uq+dT7uPgA4vJ88fEFq1rtgwXDR1ogNuiNUXE76axuxVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775759955; c=relaxed/simple;
	bh=0XWn66TZR/ob8ebOJ6fuw9cXJcQnqokm3cJKhraJxsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cjk+iT0RVzaskowz9xLGaSOxgdMR/cgwq3An2uX8XHm7AWUYh+yz1RIb77SRnucdnHNBwpwfrhQRWkKssjHMVJRdr1Fa5Y+/8QUMkNPFnGn4T8Jlo4FoVQB7RNgeyyMQzjKSxUdFAnkO9H3nKBtKi782eq+R7HpNX46jUQGYi38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i21ZLSwR; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i21ZLSwR"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43cfac48bc7so844055f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2026 11:39:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775759951; cv=none;
        d=google.com; s=arc-20240605;
        b=SB1TI5qcXTGuEUadZ8B5myLqlNYADEiwUSHH/oOE0cv8IR+QVJZegmv64tZDGswHK8
         zQjAG2VHvHPIS2Gs1NloOmkJhkbp/C5Lf0jujl/m8KGgbFzZw4acgDx5AM3QYBOGaJUr
         95VA2Ssg4m0qmox/9O/rz8DHRnPuxnzen07Uij+O+EAd2iRyBtYa/o/Gx4FdYyp9kHTJ
         f9Nf+o7lXUsfzarwJNgHFYurP0n6s+CCo6vVjJUqUxKYEGRCwtXTfF48vqB0kBYIj7bK
         raj6eRbqFJKm8ciI/A1nsxx0OmxQxWgHQF0kLZ/ZWC0o0MmlbuBp7qdfdWID+ds86ikr
         KtuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MdBJSfVa5+8QXRbBH5euwY2ZwyXubb1czyhJN1TCaP0=;
        fh=AUfZlD3Q0Eo0+pgMMzrizFWLpM3HMq5KYPORT26sCLI=;
        b=JZkmeDOnXSuCcWa9LV7t9YHogHBCfi/wKnJ8041E9YD8jW665j0PfjBTHbXkvFkpO3
         29YetifoVs0qGwkNTAGYb6pm3DsGvlhNX/jWyh19KpCeEmtoHZjEpsKAUMGBtnQz8DC1
         ts0laH8kPS0+5lE19Lm6aagyG1EJYPuorvMjIBlv1hW5pJg9NMvIgYDjDVDsF9fpInpU
         p8ZRN3Eka/u3GASwBFuuUhA3GWiuX3yBT0ASvEyNM2EN2VZkTHsxVuf/K57MYdiSWwm5
         f1XfC5LkymKQzooqSkeluPiRgSiyctJKrx7J0bnArsBM9hRb74gZRlbOKmN5fGzSM3P/
         OS8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775759951; x=1776364751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MdBJSfVa5+8QXRbBH5euwY2ZwyXubb1czyhJN1TCaP0=;
        b=i21ZLSwRocQOY5cFnPAnY6C0VQVI0pDftcKKohq0hvbRnNAha043rI1f2Jky+SdZqW
         oImR7JqzIu1AgjloDRGcfobVenebwRYsRCVVbYY/hKyUa6J9oy8MIex3gdVLxzqcpViz
         LZfhXvyQAiT9XUoDzOke1Gh9Kz7vZh1EbKjsVnFmcQspzbhYgiAtVysAgugh5VJQFigz
         0s3wt8l7EKQwxB4GPvnQqhFQ6MjjvgE76ucnqq3xBsbPbkzf5yorw1IXhwLO5NLu+Uc4
         iIVsSQOis9qh/Dqk2icWUa8+z+bH8izwZ2EZcuKKDggKesXNk7Bz4q8ljswSZGyTZhup
         Yyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775759951; x=1776364751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MdBJSfVa5+8QXRbBH5euwY2ZwyXubb1czyhJN1TCaP0=;
        b=SmS/nMm0yZKqXNwFgElHnCdIqoherswObvpLEKVst64tcc0f+cH+NARARDcWUSWLkY
         WV8EG2AVNMzb/n2UJ4Fd0l112fJLL09gYhXjJ5Wlm8Kzmzj+g+7gfeSs2KnewbB2K2G7
         HYKOleyzk2UtA4t0eImw7MBtruu5mhxlyU/XMmmmJ80pzNWOo2CLNotvaRH6kp/UhWPD
         j+Iz0ogXN9ptNV86aiaQ+E+bW7lAAp4+JaO3nY119yJOJQTpI6J92yJjTvdhY9ezKw04
         u2/NKj3vlxxIRsjHRIFyWxy/4NfofvZAQ4ox6EooR9V53WdpQqFVhRr+Fz8+MV5Bna0X
         Zn2g==
X-Forwarded-Encrypted: i=1; AJvYcCVo4Pqco5oWQz1qkWjs//FAbJmG2mzsjzUT0WdK0D5zNwG1AbL84HHT6VmX2HyRho0Gn34BMH/goUMR4NXu@vger.kernel.org
X-Gm-Message-State: AOJu0Yyeu4jgePMmDnb7wUS8FBMYMvtsVMrE709CWpQreySrFouxC+hU
	jTgD7U+aXjrA8W1hXSnnxUzzaV6veiGsozUfOAAI0crujE8alR+O++CA8xAYvcM9v0jLYI9zTj1
	L1seV6++/nPBnjNFJlsvrTKFH/X2odsvdJnwKicI=
X-Gm-Gg: AeBDieu5WuU8O1Hm53ygVpCeqhWeFdhWp123MyOKaiho1MBe0A4ePdhsItUPdoidzls
	/dFyH0ER97MPpnEbJivY0TfVl7Bcvg4sLhNmWOybTvuVQpuyiW7l2tQMpc7qB8uXMFOq+rUVOWX
	ZIWp6vXX4VbHatuBPGeHhi1Nabqus9Nw5khkvgLIqcD3lIAiJuTizTGqrkVADgD7Un9uvga2s/p
	B6UtLvYIy9jf0icp+GxFWG3jJs8W+V+2HhPhKYBevQU/zs7guUVzO+LIGVFSEZfsccTNAfqkeEF
	CwVsPg==
X-Received: by 2002:a05:6000:40de:b0:43d:650:25e9 with SMTP id
 ffacd0b85a97d-43d6428d3efmr296823f8f.20.1775759950980; Thu, 09 Apr 2026
 11:39:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409030457.4632-1-liwang@kylinos.cn>
In-Reply-To: <20260409030457.4632-1-liwang@kylinos.cn>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 9 Apr 2026 11:38:59 -0700
X-Gm-Features: AQROBzDuzJ6W0p_2TXTCOOTzX77WTTlelN0HjAa7dbRHUAZu9xwSy5mEUKMMbWw
Message-ID: <CAJnrk1a9pC4dVHDfCqrQU=O9ucSWpDw9vqw3YmNdNQD94jbi_g@mail.gmail.com>
Subject: Re: [PATCH] fuse: drop redundant err assignment in fuse_create_open()
To: Li Wang <liwang@kylinos.cn>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd@bsbernd.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 8:06=E2=80=AFPM Li Wang <liwang@kylinos.cn> wrote:
>
> In fuse_create_open(), err is initialized to -ENOMEM immediately before
> the fuse_alloc_forget() NULL check. If forget allocation fails,
> it branches to out_err with that value. If it succeeds, it falls through
> without modifying err, so err is still -ENOMEM at the point where
> fuse_file_alloc() is called. The second err =3D -ENOMEM before
> fuse_file_alloc() therefore is redundant.
>
> Removing this redundant assignment not only improves performance

This LGTM but imo this line is inaccurate. Modern compilers
(gcc/clang) will likely optimize away redundant assignments anyways.
Even if it were not optimized away, the impact on performance is
negligible. I think you could get rid of the second paragraph
entirely, as you explain it clearly in the first paragraph already (eg
the second err =3D -ENOMEM is redundant).

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

Thanks,
Joanne

> but also makes the intended error semantics obvious: a single ENOMEM
> initialization covers both allocation failure exits that share
> this prelude.
>
> Signed-off-by: Li Wang <liwang@kylinos.cn>
> ---
>  fs/fuse/dir.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index f7443ca37e35..b118cf23d41a 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -838,7 +838,6 @@ static int fuse_create_open(struct mnt_idmap *idmap, =
struct inode *dir,
>         if (!forget)
>                 goto out_err;
>
> -       err =3D -ENOMEM;
>         ff =3D fuse_file_alloc(fm, true);
>         if (!ff)
>                 goto out_put_forget_req;
> --
> 2.34.1
>
>
