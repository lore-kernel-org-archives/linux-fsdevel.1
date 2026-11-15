Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794754850;
	b=smFhexJKQpDYCmCCJSMwKxFZKfwa6eqrVYhEM9yHbnFIokvAbzGc1yejPK23ySfvduUa
	 B+CVztE9vAPgTOlKmh1aLMBogv9D8Gw7K6656BehlT5UWxgL4BIlQRaRGQwCiyBjF+zPf
	 sEAxvc7P6wWL1IBbwxzCqQSxSiwULU/TKdRo5S1Wac0TcSNxdYD6wHK2zLLtYkt5fcM3I
	 VXGKxW2FYiImOXUHVSN/RTsiO+NsflW6dN9QR8fF7RBdX2H6ikSrSBdCQECQ82U3mSbbX
	 esHTV/+ieOpnfwjVWv3vGp83X4FYICY1Nf4P+dnQ7RAlmZ8PTcobyJSix9r1PrFwdCQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794754850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=1MVRNS3ac0YlanU0Fwb5KpLyyO9U1oXwO9vfFA3eak4=;
	b=QkHUm/nZlz/p2U1CbiKypr0kuUfxqGHqHWLURUUVUyTnA7QupV6tD0Ur23YdIIduFUTm
	 mnVQvmj/zNHQe/N8gARD7pXNwgR6VuUNrVBb2PE6B2wCLlWPdFZizakug7HcuZqOhTWvG
	 jaiRoXMgLtWkvYIQoWyzNPn4FPwW9UHZyhRlL7lESgMkvWc82E+vhOadgAcQkdnIUC2kX
	 c8lpiIEy/lg8J7yeNobEkfGARyEO5SgJFtU4tnI+t4b/c73iIwbGpR6HlzJeULw/Ujb7F
	 RSJUMj3X1AEgEvge/tn8qrlu4oeIj9+YDzpB/Ova7lkOn9CchY69SrWOoImLR0Q5NJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SHyOkxQw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE3B606A31A
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 15:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BE3B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SHyOkxQw
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c50cc7540b7so67033066b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 07:00:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794754849; cv=none;
        d=google.com; s=arc-20260327;
        b=SA3wBAaLW9deLUfFCAwtriYISGjqrW+srR/gf8/COgR0naNvUoC/G1gG900AR8OprB
         f0yqAtVsD9xfVdY58ersqnkyo2ifKGpThk/EN0gvQzN6ibnTRlSYQBo58X0PIiVXR5RB
         vuFxTV1/4ztrpYUWwtO3eGaG755sGEog43ThuKIcQMjdQZ/b0NQ5qqi3vQbawSnY+Bj0
         TvL7gU9n3bcMkW2o7WukUdU9S16m7mEho2IhiUVpfjcxQHSAFtybsLYu6wzdVYPy4sLn
         u0EL010X0W6/gzaINB8NZCE73fKEfkMEFF5xq/1gmmkTCoP9buG2VQ/DDyYsyLb9xo+q
         T9oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1MVRNS3ac0YlanU0Fwb5KpLyyO9U1oXwO9vfFA3eak4=;
        fh=yhIVx4MIQdls10njj6mbr6OlezYa8g9osUJM/k39Jf0=;
        b=FmK7NkxTSPLEiv1LQ0j3uUB3zMixXn+iDz63/WgKU4sISK9w39nWXg6DCJYu0zomZj
         meWQQqVyOrIi9lTeVsYI/rJFLWNOYF1iB2pH9+PIYCjdNxWyxQWlPGVLuuYS5Kv9A76R
         W8I1RPK2Sh/x0WsQYwiofShHHMYo3fg6C4a2xnQEpjssHGSCwtg7lMQ4zEYfHBB5x1PY
         nnvan7JpsTDXV4eFdYZt3xyA3ZSqDk0mp5pSUHF2uObfypZhgZUr0a/Hcf+7reqUtP9/
         4/0ELFcIYQbOO1h4fv6ts83xoFu5UgHqPjKDwKDs+LuZ4G6SERqNNqVBF5KhSMmdlt/L
         NjXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794754849; x=1795359649; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1MVRNS3ac0YlanU0Fwb5KpLyyO9U1oXwO9vfFA3eak4=;
        b=SHyOkxQwYuLtL0+Qa53+jCNHfMYZrDoIhK10usTnr/SPlsQtxy3DYcaURrAaqZRP6p
         j9KX2LwDO7WvpxAFvRbeGvPMOpBnbsJEvuh/a+pWnWLMDcViXZq6b/VVaPZ68EhpaptP
         zHr4LucIEpdLZQDJogd72JZdMAkBHyXTxsReEVunL/+oJmqoO/hXoqxPt2Qr8UINUk8W
         PKisRAodcZl5vzpIsG78e9fRi2Mkv3dgu35W/QqWyi6fF9QsZX61BfySIbEHZ7oFXuQb
         7fuxV2YOwjcp9LUN7zRZYNpbm5Ey2kJzr2xgJrjMsYP1vCyRno2ESPfdF+IIuftfMTEI
         HtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794754849; x=1795359649;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1MVRNS3ac0YlanU0Fwb5KpLyyO9U1oXwO9vfFA3eak4=;
        b=smFvZDFpVBx/Yx/ZCsfrCJ3vP1+zkF+JLicolIt34imuPQEM5S39sG08LAqxSSbpwN
         bZNW8ML+yTrgkW1UnT1mywfhY7C+l72S65KZ3lnr0u9FiD1NsIgJ7WlxfR57ibwxGNLt
         a0yIhbA9Y94/BCcKP3gvF3FHH1A6gSEbWPrlg4gikIyZGedJbLWcgZ43TuKX3N2ictcV
         LBvjq2DfRAbTcMZT4IQyYYsy+foWl7SFOAMnfYJ/Ge0eHXm8Q7eB+adXKOjpP7rxlpw/
         1b+UPCExx0oQNVR0uLC+ktBZwgZJ9ULEyF9SRn2tPHMkLiDbpwS4ngTYg7Sph17yRnf1
         mkFg==
X-Gm-Message-State: APuU4Z8eXF3q9SCFzp2bYjpJqsRDGJrKgSzTJ0TszuzxdwK6xh/k7xgx
	286pE69u1y+HPe2l+mm55ieP0E5qV7x9Getsq3TNOBPYO8i2V53oLXfaWttQHIhsTezDZNJosV+
	O/LMFHlE2l0ooWk+TY48Uucs0W/QKp+k=
X-Gm-Gg: AYBFou0CKa/YaipqxOEFP8LHk50NqlZpYGYl6j+Vay+RgmYjdiCnKIUb2ERu41uXc4x
	3EAk81Fzn+i8E3rN+a7yuQNLdBIZz5R8U4A0qcmFZVqubAlFMvX2k8zU1W2+cvTXJJaB+DpzKUC
	TBfa8a2I7wMQ3i1r5ch5zSAYiezVGh9z6M5FS/mcefGznxHHwiksHJQjNdLycGTotdQg7BDFvHs
	Cs5ASbsmUGcP9Boi0VMWFu+6zSX97j1C8lLNUskjOpsJ6s1ajmTjUNXyhdwz6SiUSwwkgopuU3G
	ODwYBB57xAmJ4l6ifCvTIgdafvtCkAEaYKO4XIcEmdK1xrzf5OWNghxlO5xuqGgCZE11MeffnRe
	vUncsntApbHkBZBZlJl1SlndvjCsRiAXsFwR743eU6Fueviwaqj2YQsvfrcGcINpjk3LPqA==
X-Received: by 2002:a17:907:6d11:b0:c26:2a2:b91d with SMTP id
 a640c23a62f3a-c509612a23fmr694079266b.6.1794754848470; Sun, 15 Nov 2026
 07:00:48 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org> <20261115-work-ovl-d_real-v1-2-ca155efbcb2e@kernel.org>
In-Reply-To: <20261115-work-ovl-d_real-v1-2-ca155efbcb2e@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 15 Nov 2026 16:00:36 +0100
X-Gm-Features: AclHuK_wHYShIpzO3KRe2QttGftKj9EtJqTGjYXExDCpgXdtVHvMQ3jGuPVE7gY
Message-ID: <CAOQ4uxjoHbevvu8auB4m8AVcY9H6uHdDAP6mfi9OOMh+3775xA@mail.gmail.com>
Subject: Re: [PATCH 02/13] fs: add d_real_data_inode() and d_real_metadata_inode()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Chris Down <chris@chrisdown.name>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 3:02=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Currently, d_real() can't fail. When overlayfs fails to look up the data
> of a metacopy file in a data-only layer it hands back the overlayfs
> dentry and callers silently work with the overlayfs inode. That's more
> problematic than current callers realize.
>
> For trace_uprobe and bpf's uprobe_multi it means uprobe_register() fails
> with an -EIO that has nothing to do with the actual problem. For IMA it
> means the stacked change detection is skipped and for IPE the file is
> evaluated against an inode that has none of the properties of the real
> file.
>
> Teach d_real() to fail and teach all callers to handle errors. This adds
> two helpers for the callers to switch over to:
>
> - d_real_data_inode() returns the inode hosting the data or an ERR_PTR()
>   if that can't be resolved.
>
> - d_real_metadata_inode() returns the inode hosting the metadata. It
>   never has to look anything up and so never fails (but no promises for
>   the future).

About those promises...

>
> d_real() can't fail yet so this is a pure preparation. d_real_inode()
> stays around until all callers are converted.
>
> No functional changes.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Link: https://lore.kernel.org/all/CAOQ4uxhGxpBtMZ5kfuzR1tQAewiecoX7UjXQRo=
91QjJHH9T_Yw@mail.gmail.com
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  include/linux/dcache.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 84b0cfe4ed0e7..674bc50b81827 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -3,6 +3,7 @@
>  #define __LINUX_DCACHE_H
>
>  #include <linux/atomic.h>
> +#include <linux/err.h>
>  #include <linux/list.h>
>  #include <linux/math.h>
>  #include <linux/rculist.h>
> @@ -660,6 +661,49 @@ static inline struct inode *d_real_inode(const struc=
t dentry *dentry)
>         return d_inode(d_real((struct dentry *) dentry, D_REAL_DATA));
>  }
>
> +/**
> + * d_real_data_inode - Return the real inode hosting the data
> + * @dentry: The dentry to query
> + *
> + * If @dentry is a regular file on a union/overlay, then return the
> + * underlying, real inode that hosts its data. Otherwise return d_inode(=
).
> + *
> + * The union/overlay may have to look up the data first. This can sleep =
and it
> + * can fail, e.g., because the data is missing or because its verity dig=
est
> + * doesn't match.
> + *
> + * Return: The real inode hosting the data of @dentry, or an ERR_PTR() i=
f it
> + * can't be resolved.
> + */
> +static inline struct inode *d_real_data_inode(const struct dentry *dentr=
y)
> +{
> +       struct dentry *real;
> +
> +       /* This usage of d_real() results in const dentry */
> +       real =3D d_real((struct dentry *)dentry, D_REAL_DATA);
> +       if (IS_ERR(real))
> +               return ERR_CAST(real);
> +       return d_inode(real);
> +}
> +
> +/**
> + * d_real_metadata_inode - Return the real inode hosting the metadata
> + * @dentry: The dentry to query
> + *
> + * If @dentry is a regular file on a union/overlay, then return the
> + * underlying, real inode that hosts its metadata. Otherwise return d_in=
ode().
> + *
> + * Unlike d_real_data_inode() this never has to look anything up and so =
it
> + * never fails.
> + *
> + * Return: The real inode hosting the metadata of @dentry.
> + */
> +static inline struct inode *d_real_metadata_inode(const struct dentry *d=
entry)
> +{
> +       /* This usage of d_real() results in const dentry */
> +       return d_inode(d_real((struct dentry *)dentry, D_REAL_METADATA));
> +}
> +

Wondering out loud - since you needed to change IMA anyway and need
IMA patches reviews, do you think it is hard to also gracefully deal with e=
rrors
from d_real_metadata_inode() and not have to promise that it never fails?

This question is not intended to block your patches.
If there is a reason we should keep this promise for now,
I have no problem with it, so

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.
