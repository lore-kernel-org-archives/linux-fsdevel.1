Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794754078;
	b=R10eA5lBWXS2aEotGvcK4Uw1DoejqvcDGuO/csAjRcoSidaARi9Y0Se6Hddou/OOy90e
	 fJKXvTX8ljf5/933cqfuXo/cqBb2vi/nmBOm2AMWVFr7LoxnIYi4SCfCus3OgLiIjUAE4
	 T4rfnBL3IsPA6jzq8ew8BPGZ4U33D533FsMG5A+uPcsjqSKFuaSCCFbuFLLb2D0UftvAN
	 7r9uku3/cHc9w5VDiSXZR3vzzBjXX7/Vn/A5OYwwTeYkXXfO19+9IJ7nlhhijekfNiJ/D
	 dIhkjrc/RFYYDXGviH/27kXhwVvLQxJcFfTX/DAiJPYRZb8AW2PWIy2Jf/tIFyZLjRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794754078;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=x7HykaAJlgnOpmpM8XJHQMzZjK2dm2wSOUdGIuC/Jng=;
	b=DXSYRTUI23MC4D0BpTcLmidAs1IyPOu+PP2+T5v10sHaAH0fx7Jq1qnd/HyBpm/WWEoW
	 UyJu6Bm4vE9esPtepA7YN+LPVW3M7vEtc6yQujQAQClUXlKxCBBbvnjlbFUehKS6m8b5T
	 hqTht608Xd0NuvliMIswUMTpJJULRAuh8TbMKlVFnzf80TLEqkpoI5okFilwI0P2OPoES
	 tJ9YLcZwKO+TSH+2lr5wod938tmWxBUwNQU4AeFll3K72bmNkOGuF6PnxzRnBBFGCedJz
	 ITMtoiK9rqL98gm1oznpJFmaOYf1bnBMEm1qY/q4aJPK4Fr+eYvQ//x24j0ie5Gtu9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vdeJy6VC;
	arc=fail smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29048606A31F
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 14:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29048606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vdeJy6VC
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b2237b596cso5977799a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 06:47:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794754076; cv=none;
        d=google.com; s=arc-20260327;
        b=IkOC2R4FNM7VYAH92bUOcMeeFHwZvtBzE5q1wt1J+j+pJQKuKEJlW9XuCLv9Mtw0KF
         Ag8uOSZshC64cJaSKWTYv5MiVfRPocurdA3jj5/bxh+iyhazJzfI9nSJaZM7u59lR5nI
         gOQcibDjWBmlnC30MK/+NDuA4+A70xpsyr3vyKJj3Va0iNEZ5/SF9h7WkpAuJ1wn1r8y
         o9+iNpiTCaNegoxpHuGI6jm742XmX1ElfXjwUQk99QVFAtb+xlX73zK0hD2jyaYq8djQ
         ZOsF/nDn/r+Ujv/rkNdly2dQ3/WA4ET5ldJ5evaJyg5HamhZdZ3XYZ/v6CedpLEN9m1J
         huLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x7HykaAJlgnOpmpM8XJHQMzZjK2dm2wSOUdGIuC/Jng=;
        fh=yhIVx4MIQdls10njj6mbr6OlezYa8g9osUJM/k39Jf0=;
        b=PmYazA3/TwvCxJdAgldU9Ri2dLTYPBgw2qo/jEhMSUgK3dmuGAHAND6Gv3q39e+Vgj
         jvEnIYZVSfJln2fG4093W0Yy3ZZN+RWY/c/JJ1yaV4boy92JERwu3bwsCusFtFbL+6zR
         N1jlC2D8aghld66/EX+w6bTT7zU/ioEy2eCC+bL96iHbP6XyHtPTJ0QSVezNLbsSyfN4
         DUo7N1IrkDL0Irm/0sgmO71NtZDAq0dVErhtfP7h7KVhi2uQjBsHdtP6wmymEbNGT7o6
         oL+DGG3jjc9kOyVrywSs5dToFGYCn/oc64WXg67IiQabP9jQs1+XLQ1hulSbjrlj9zCT
         ln0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794754076; x=1795358876; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x7HykaAJlgnOpmpM8XJHQMzZjK2dm2wSOUdGIuC/Jng=;
        b=vdeJy6VCk2IGRpnrLWlGo4pWLhKneS7IPoBk81bLTW0iD2g50lPI0We72sIkSM0SV6
         cyTbNZB4O3d6VzvDDG9DPV5xAXhxmw4YkAyPQvdWI1M8aVPLRajltXh2AQAOKJY1EPeA
         J/3fQzDOEdKdl4Og0NnAs1e+UKlTuJcD65e+vWcNglfpyVM0bRYj3j545Ccvj/p07kIf
         RJxqw4iAkOZDz6lvhqxGAdC4rSJXKnOPRkFB2PlSiergeTKJSozBYsIqbEfROUxsRiwA
         +nC6LR2BKa2t52tGscFSOG6fqqncSzV6SKT9uOygWHxo9fsmCNg/KFWBsER32dA/LqAU
         Q4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794754076; x=1795358876;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x7HykaAJlgnOpmpM8XJHQMzZjK2dm2wSOUdGIuC/Jng=;
        b=MD2Mgk52iP+5JaFsj1P7dSfmfnrenvUOlqpIN3htEo7c/FZKocpEXUq0hpclXyCwhD
         RoI2ACDu/kOHdml+SSLmzByfsRNLA60lZpPEFiQD+y5OR0g3KKmQsI5nmgclpouKkOzN
         Hu4+v4Nyu+f7hx1IaJYZfbPYbp7w5/XECcVPo4zTRg8nk0/t8omE5VzzHvP6K74UATKC
         EM7sPOs88eqx7dlwe1wuL5wO1A+VY0mnSuVcxrJ4Ayjssv/QO4BdgMVMoasv5/88K+g8
         6jPmZkX12p64CDWwvyNBs/vGX7DN+pmtiGhdcuDhxL/ZLAX14fezpc61EBd6HD0279Vm
         yyUQ==
X-Gm-Message-State: APuU4Z+LEKKwpKMoav/qcpwu5pQSPr2dworrwS66h7mdy6eUjjqbatYz
	06oaOdr5726eGqWBGxduCgqkzrK0zqgFildtN0CBEWbo2u6xCp5P9AX55DzyWH70yWfamtQnKzc
	2bIQYD6nMo6MZj917TCwiMoFBsSQaQag=
X-Gm-Gg: AYBFou23TUXyQVUN78XCSYrf/gGf7SjWbj1o9DVNk7WRHUyJZfM/Q0jtdj5ykJ4TvLs
	jx5Bo2Aukgz5kzeYLvfnVTVyfGvMuKC30WFNyYjp4XD+d1Y+fmGmEOysqCk1La3ASjnN89ZWRPN
	o7xMTzQKHBgV2lOpoZUkcp2L9YyfZSjfoAuFyBt2gvsvL2Ipi+ELaTuNIDYkUTMqdetsfsC3/Si
	UQ6qJuGiHe2NOdgLACNexa2FAIjHa5NZgTjN2Qya9BF41dlxz1RIf8y4fp8s3NRwN5mbnw091Id
	39YmIJNWIS1h5M915UengSj+TuvnHpkr7HP9l0FoYhtjiP4HFD3uMLw9L9kfLY117Xq7SJsviuz
	TJR3cGtTTOshbjqb+kZBWDRW652ESuy8NuhcZISq9MBpLl8ouL+hDRFVNae9h52woZqfjEA==
X-Received: by 2002:a05:6402:1d4c:b0:6b7:e12e:7f1f with SMTP id
 4fb4d7f45d1cf-6b7e12e824fmr3426650a12.10.1794754076394; Sun, 15 Nov 2026
 06:47:56 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org> <20261115-work-ovl-d_real-v1-10-ca155efbcb2e@kernel.org>
In-Reply-To: <20261115-work-ovl-d_real-v1-10-ca155efbcb2e@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 15 Nov 2026 15:47:45 +0100
X-Gm-Features: AclHuK_at8qVhKBNN0WXPGQ7F2lmyjSQgMjlfNE9nQtuQriTEXeBZE7dwGmSTD8
Message-ID: <CAOQ4uxggW+UifxBJDY8fAb+g5EWrsD+rELwXa1ngZ_5X_OZx0g@mail.gmail.com>
Subject: Re: [PATCH 10/13] ovl: return the error from the lazy lowerdata
 lookup in ovl_d_real()
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
> All callers have been converted to d_real_data_inode() and handle an
> error now. So return the error from ovl_verify_lowerdata() just like
> ovl_open() does. The lowerdata dentry missing after a successful
> ovl_verify_lowerdata() would be an overlayfs bug, so keep warning about
> that but return -EIO like ovl_open() does when it has no real path.
> D_REAL_METADATA never looks anything up and still can't fail.
>
> Update the comment in ovl_d_real() and the documentation of d_real() in
> dcache.h and vfs.rst accordingly.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Link: https://lore.kernel.org/all/CAOQ4uxhGxpBtMZ5kfuzR1tQAewiecoX7UjXQRo=
91QjJHH9T_Yw@mail.gmail.com
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Nice!
Thanks for cleaning up this mess.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  Documentation/filesystems/vfs.rst |  6 ++++++
>  fs/overlayfs/super.c              | 17 +++++++++--------
>  include/linux/dcache.h            |  6 ++++++
>  3 files changed, 21 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystem=
s/vfs.rst
> index 1824462a43711..6953f399672f3 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -1374,6 +1374,12 @@ defined:
>         for returning the real underlying dentry that refers to the inode
>         hosting the file's data or metadata respectively.
>
> +       For D_REAL_DATA the filesystem may have to look up the data first=
,
> +       e.g., for a file that was never opened.  If that fails an ERR_PTR=
()
> +       is returned and callers must handle it.  D_REAL_METADATA must not
> +       fail.  Most callers should use d_real_data_inode() or
> +       d_real_metadata_inode() instead of calling d_real() directly.
> +
>         For non-regular files, the 'dentry' argument is returned.
>
>  ``d_unalias_trylock``
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 1985b553a47b7..39d4d57dec230 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -42,7 +42,7 @@ static struct dentry *ovl_d_real(struct dentry *dentry,=
 enum d_real_type type)
>         }
>
>         if (!d_is_reg(dentry)) {
> -               /* d_real_inode() is only relevant for regular files */
> +               /* d_real() is only relevant for regular files */
>                 return dentry;
>         }
>
> @@ -57,17 +57,18 @@ static struct dentry *ovl_d_real(struct dentry *dentr=
y, enum d_real_type type)
>         }
>
>         /*
> -        * Best effort lazy lookup of lowerdata for D_REAL_DATA case to r=
eturn
> -        * the real lowerdata dentry. Callers may ask for files that were=
 never
> -        * opened, e.g. for uprobes or O_PATH files, so the lookup can fa=
il
> -        * here. Return the overlayfs dentry then.
> +        * Lazy lookup of lowerdata for the D_REAL_DATA case to return th=
e real
> +        * lowerdata dentry. Callers may ask for files that were never op=
ened,
> +        * e.g., for uprobes or O_PATH files, and the lookup or the verit=
y
> +        * validation can fail. Return the error then, just like ovl_open=
()
> +        * would. Callers of d_real() have to deal with that.
>          */
>         err =3D ovl_verify_lowerdata(dentry);
>         if (err)
> -               return dentry;
> +               return ERR_PTR(err);
>         lower =3D ovl_dentry_lowerdata(dentry);
> -       if (!lower)
> -               goto bug;
> +       if (WARN_ON_ONCE(!lower))
> +               return ERR_PTR(-EIO);
>
>  real_lower:
>         /* Handle recursion into stacked lower fs */
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 674bc50b81827..5b3b34d271bd0 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -638,7 +638,13 @@ static inline struct inode *d_backing_inode(const st=
ruct dentry *upper)
>   * If dentry is on a union/overlay, then return the underlying, real den=
try.
>   * Otherwise return the dentry itself.
>   *
> + * For D_REAL_DATA the union/overlay may have to look up the data first.=
 This
> + * can sleep and it can fail. D_REAL_METADATA never fails.
> + *
>   * See also: Documentation/filesystems/vfs.rst
> + *
> + * Return: The real dentry, or an ERR_PTR() for D_REAL_DATA if the data =
can't
> + * be resolved.
>   */
>  static inline struct dentry *d_real(struct dentry *dentry, enum d_real_t=
ype type)
>  {
>
> --
> 2.53.0
>
