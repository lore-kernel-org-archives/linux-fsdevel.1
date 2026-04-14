Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569992D77F7
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 01:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776131489; cv=pass; b=eXfuTQUKEHX6JBa2Zic6vKJFvkcOyRhrMyyhRQI3obH5MYJcjSMhJ57vAw/617CxcMLMfgdtE4e1HxmTmTz9/CEPrkrf8rROXNHOEEV44tHj04iRMIS+CQwLlTf7wezHnYUoDZLmDPgFUEqh3gzuVnQHpYbblYXeqm6VxQtUGIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776131489; c=relaxed/simple;
	bh=FucshMcTx7i9b9x8v6wrNygWXaO1SsxKpilTMnmJayw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brWv6RAcqA/gn6PyGqfraJ2NFGORLkDaROksYU26KiGXi1DkAkv9vMp2YQmrsm4DLwc+Xk5NkdqKr1vMXc5BW4o/p3IqEB63ky8L8Ry/b0mkXyP9pcm7oAbOaG+FXyyJ8G9rpxE96L1tmNs0/TlcSVypa3RicdGAUKl9f6T9YiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9au4KwM; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9au4KwM"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79a535e7c00so59613267b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 18:51:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776131486; cv=none;
        d=google.com; s=arc-20240605;
        b=YBECU2ftqk+NBXmVkCrovuiesDq642E/pftCofDxCZNgPKR6wEHb4EAV8HYfEie7Cb
         8Z8ZMJYpByIHG3//nO8OHqQ7cKKWF9kbLZUttqXhfNatuEGx2pwWw4QzHT+BQqurhamt
         B3ttlcwHDzcZhDhk9tTheVicvIHmv17wav4/H5l+W/v281Xl7PJ+bdyGfYkqePKpeWZR
         yyBJdW80zlSUUB8qjE4TCOlKrYvzUV6dzCTjt/jdRqNxQJkv7JY04XRFJG7MbpOEOrOE
         7HhCQ33/piVR2tjiwWLafqf2hN3QyXFcUmvy2GSVH5FKNLege1DbtqYFrS8U2j24GeG+
         nlEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cp1fKGS8HOQVxwzbO4Dg5AkBDuPAHDAQVC0tdaoVPbE=;
        fh=ZvgrUFnRecEYxRA9JwhtiTfx0eeZxZ17OUZ2JCsvTX4=;
        b=Tukcetpq9WhUQYqmArVFOHreHCaFPEmuIYG/4XgdQOFwgYBz4GLD+bSKdLVVQWXBo1
         yAgqDZbqtjtQN3O0KgXwqgEQyS+KWHH96FiCuTqwfJLGUhn1SRb2Z5/uv00JJIyJAQOb
         aJYLC4bhREMvIN+w6blaAr2KITzQRUemfze0s3L9UwAgtIWkwZKwaZO0E2SzGssob1yQ
         /frFv6QJq3LbXJYG2eZ0eZstj3DklCZx0OY5Evw1zOAJZJXlWflVzFSt1LnrodAv+1D4
         0NuFqHOcgG/+Hsj/vAcB6Loj6RcKJ3Kiuq2zIIocoP6TDkKp3+9N/yGFUbSd1Vz4sYXr
         rNiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776131486; x=1776736286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cp1fKGS8HOQVxwzbO4Dg5AkBDuPAHDAQVC0tdaoVPbE=;
        b=i9au4KwMp4ErvtYDfC/nvspZm8PtA4PjxyXePCdvBiU0HQ97SJE+dLRCGgI4jyO1K8
         PilF7lQdnOXLFjBe0Llgz+l1ffnceNRicijmd18jAp2Dj9SvDzXKiQPAI5UmKfEeAKqF
         YZZQbwugrtqCqN7fDlXnfeuls+kJkhwUCGAd7QOySWLKJEjJOhbISXJz1EId0+WsVS5O
         Gj86pqPb8wyFBa3Y+fJioQJ3LN0na+2UZW6Bv3zU1GfZXIxe5I6eIIbVszep+E2Gmr16
         wxUP2gBPTXMLTLzJumNJoOPUpwW9SNdP4rq9husSEDBbPPZWeBmSQZNa76gOOQtF8Sis
         JwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776131486; x=1776736286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cp1fKGS8HOQVxwzbO4Dg5AkBDuPAHDAQVC0tdaoVPbE=;
        b=LdI/LkjsibgUK0cQgVMksGskkP4FRZ1ZftzkVkSl6PFSZ2z17lNBFpvtqUjIgT3xfF
         Q9ZLQbKolg35zw1FLK12iFPCMSkjUpjRr9+9trOvc6EQPBBYDN3QxzthEXkI0gRuBmgW
         Lk6EshIld1nR8q2InUjuIiuIfVDgDlvMVWeWiSO7QcuLM4rQ078+e16rZx+MxvOTLiRC
         KXI940vMXT4NuQSMphef8oUfQ+FNDDcQvP3yjk24qmz0zKCZDsLuU+NHBnac021ccJt2
         h/B5X82HICNyQC10ayIhbFKo4Vm3+SKI1jxdX9uUMNoOp1Iw01t4HJd7TTLyS9OJfRTb
         Vv+A==
X-Forwarded-Encrypted: i=1; AFNElJ/6VEzSY6r+sReOQFnHw6gcboIraZtuxpAjC4RIcfHd0U8Ok+cYcaO4VOVHYjJrWZjFbDtZQL6AAphte2BX@vger.kernel.org
X-Gm-Message-State: AOJu0YxSrMYl+yjcKyeMu6TOH34qowMUlL9uiu+Y4avSjA99vOdyot2U
	gMCToE4DcFpNgiFgUvr74ABfJziBsj6jZ/81vKGQMR8MjAzJVrm25EjfZfUVt007TBmNGIdJSos
	UXzmS2ozwkQjC9MzFq55wSMyMk9PkKVxcIg==
X-Gm-Gg: AeBDievGofIvX6y5Ki4emddtTILj5eSwjdhjacEELcU+Kwzr9R/JVu3qw7pxYDJ5z50
	lRL5mSsVAW6kkKvKKr1XmHMbWzY1o6GXsh514Be7gqVz7/RwvIj4DQoeGQJIkUVD6KxZkbl3rBW
	5LATYrLRkTO/ZuxEz+788xLMJYfv/elqOW76OpYoHXsuMqOU8RDh76E8q2p7k1sZQYY2j+El2JY
	qeN1/PR0BYlOIqPQqAGU71pnoLb2nl4SFW9DdI50BL7OvhY3YEQKGrKSxAa6QukDF5WMw+OCt2F
	X0IymgIaE2BL8ZiBK/CjeXRUUrwqXMMQPT39cx+obhr2U6wCVkwq55ZRvriOdNKEWeXZHpRi5SI
	ryBatJtA=
X-Received: by 2002:a05:690c:e3c4:b0:7b3:401f:2e7d with SMTP id
 00721157ae682-7b3401f3a52mr64132787b3.25.1776131486247; Mon, 13 Apr 2026
 18:51:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414011303.61374-1-kartikey406@gmail.com>
In-Reply-To: <20260414011303.61374-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Tue, 14 Apr 2026 07:21:15 +0530
X-Gm-Features: AQROBzDFZnjLHhQXRYH5ffQPXWTFFSwpbY5_u1d3reHEMsx0dkQsE-tMU_jhHwQ
Message-ID: <CADhLXY46cHXXew+gxFfxwSkoghEvfYah-6tK+4t_+TuWu2W3GA@mail.gmail.com>
Subject: Re: [PATCH] hfsplus: fix ignored error return in hfsplus_delete_cat
To: slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 6:43=E2=80=AFAM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
>
> hfsplus_delete_cat() calls hfsplus_delete_all_attrs() to remove all
> extended attributes associated with a catalog entry, but silently
> discards its return value. When the xattr deletion fails due to
> filesystem corruption (as in a crafted image reported by syzbot),
> hfsplus_delete_cat() returns 0 (success) to hfsplus_unlink().
>
> hfsplus_unlink() then proceeds to call hfsplus_cat_write_inode() on
> the inode in a corrupt, half-deleted state. Inside that function, if
> HFSPLUS_IS_RSRC() is true but rsrc_inode was never properly set,
> main_inode is assigned NULL. The subsequent dereference of
> main_inode->i_nlink triggers a general protection fault, caught by
> KASAN as a null-ptr-deref at offset 0x28.
>
> Fix this by capturing the return value of hfsplus_delete_all_attrs()
> and propagating genuine errors back to the caller. -ENOENT is
> excluded since it signals normal loop termination (no more xattrs
> left to delete) and is not an error condition.
>
> Fixes: 324ef39a8a4f ("hfsplus: add support of manipulation by attributes =
file")
> Reported-by: syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dc0ba772a362e70937dfb
> Tested-by: syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  fs/hfsplus/catalog.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
> index 02c1eee4a4b8..adbaeabc06ab 100644
> --- a/fs/hfsplus/catalog.c
> +++ b/fs/hfsplus/catalog.c
> @@ -421,8 +421,15 @@ int hfsplus_delete_cat(u32 cnid, struct inode *dir, =
const struct qstr *str)
>         hfsplus_mark_inode_dirty(dir, HFSPLUS_I_CAT_DIRTY);
>
>         if (type =3D=3D HFSPLUS_FILE || type =3D=3D HFSPLUS_FOLDER) {
> -               if (HFSPLUS_SB(sb)->attr_tree)
> -                       hfsplus_delete_all_attrs(dir, cnid);
> +               if (HFSPLUS_SB(sb)->attr_tree) {
> +                       int attr_err =3D hfsplus_delete_all_attrs(dir, cn=
id);
> +
> +                       if (attr_err && attr_err !=3D -ENOENT) {
> +                               pr_err("hfsplus: failed to delete xattrs =
for cnid %u: %d\n",
> +                                      cnid, attr_err);
> +                               err =3D attr_err;
> +                       }
> +               }
>         }
>
>  out:
> --
> 2.43.0
>

Please disregard this patch and i am sending another patch with more
correct commit message

Thanks
