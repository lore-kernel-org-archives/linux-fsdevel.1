Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ED918CBE1
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 01:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779499771; cv=pass; b=U0PgCQn2u9zF0yerwtozn5mjZX5ibTwAFex1XcG7oBMzBV/7/zWF8AP/2tJ5nII67KsmUIjMPTbdjN6ptvzNZ82nZJ/pcILpynqKGN5dkcFHUTJCzOs58g87wH+Q773FsFBlFmUFt8wFsf5ZJjlGWwuF5nJ6AlawZIwTs1TMezA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779499771; c=relaxed/simple;
	bh=8zBbg7dKD2bCJagPoNSxQrY8p5aHiYz6PMx9M+9bufA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SHlbwG4um3qvxsCCre/PzeQqQ3erpcAhglqo74FYE/kzrGbpv3s6PTRmjkbobEGuRAxcXN6+gVDvzCle6COHTMUaZ8P20xKWBFP/Ge64xJ9YSnpYFN1hyOtlhVnl4FXLUl2SZKGCALzyEscE/q8DQeM7jqtMY0koW1FxAlzg2G0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9j/xVwz; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9j/xVwz"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49050ff7cbdso1612815e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 18:29:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779499768; cv=none;
        d=google.com; s=arc-20240605;
        b=MME4gbiVMPEOhVlf5xAk2hazthGwh+hQ0Xp0Dm6C3SxtiSqfIAtNhg/0X8Ll+Q1Rw3
         bUgrzWLYZize5uA6QODE36Olo5B4a+ZK4Ek2ddWh0oWFaXf4BNPzkg0kQXY3J6eGKuNr
         OLGX5jyoljSdh8CTeWogkVAbVZWyu1cE1rvINptVVQJHVGpD/qTKqymQBR7gi9JSlSfj
         KrdKdloTapBi0kWGOcMcCcsFq7lEYgLd1BdZ/3DKuAipVA59f/Z1andn+QuVlnmT6NDO
         dy4a5/pcXjdHpjjsMsygjmBDTfJs24OOnPP1ToHa8XEULPaI+diFspioasx/ky0HH6q4
         ttQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9S3dDz6OKUHQX7zCqtzJ06OZJ8Gs+3uEKEFTZcI+LDs=;
        fh=9FWytFvRo+BIGuYH0iSq7bs1PYYA7KPNKepZg4nTHZE=;
        b=U+BuxdIGo5N4dB0ped0mXrmyACbVW4GpehH7tsjeOTWWxsmTja9I1+l+lIhGLe0FrX
         cgYOWnz7K2OaG2UK4Apxg1yUVb/OH1Xay9YBmbmBJA/txlNft2GoTSkgJvYp7jXdwDXx
         UxpMBT0OnY0mdOXpFoZlML49co3FAjwd75iyGTeqJgARDHFNg2hLvEA6WkpS+EnFIqoA
         WtPtahrlNPyMIhb6E8zcPTvKXZqxmy5AD9Pf69MAn9KvJ80MqPdC0JJi5Y0XtKGbkNvm
         /9s2VylazAaPBxa6/SRSizWR59ejvjRs3XWvQ26ig4kZgSrV1D1HCzNEaRTEFUKW3W08
         ixfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779499768; x=1780104568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9S3dDz6OKUHQX7zCqtzJ06OZJ8Gs+3uEKEFTZcI+LDs=;
        b=g9j/xVwzl3AmiyGNAkLjO62q6uNHlGgrBjEOlGSq4rgJuOgwTckfDsVrKJJm+DXNcO
         TE1Y9SP+1k34FkTZthBmG5UH5YCHmCXgjXgenEO1kLBH8eybrOSy/MP11o3E0JzIQ9RZ
         UGVfIluOvF0vqotTsXuWR97HCGKjzKJf/g43v5usmSukydRlIf25jrClDcc70q7dDDnl
         I6HMBW/y3Q9xdvE/UrvELMINCegqswP5Iv+EnvUPlaXkLYvwJ+Z8lLYScA0Ap6P3AaCK
         H3aHhq2NPbW5jIb0CTTMRigaNn8gUDUqJ3lLs96TzoQG1M6yFXep+dtKihbpX5k7Snch
         qChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779499768; x=1780104568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9S3dDz6OKUHQX7zCqtzJ06OZJ8Gs+3uEKEFTZcI+LDs=;
        b=P4Q5F8RgbWiZQ4Ic5OT1topfTYMjqdq8YITt3itg1I4Jczd+ukqQXcQPrGH/IwbEvW
         G2/6S2+w+2n/n6lXnkLE6ey0+DVnJpbGlnEENzMd1Yvp+ZH08KND1Hdfs65UX8ZcEv1m
         Y3Gk+VRAmgJJ0tmjcB93ikYRprvllsei5COYdziNeVHRZO6Xyl8wsYrlFJpJXBIXtHik
         T2yX6hV6Xyu1Pu2GT9UsyHq7vYOaZC6B7Cxz6ojQdqFuHBWT043FsR8O+8vnG4bvQ0tT
         H8/e0/3o53dcJRhodergXVBW612EU7O7W1CS9PikHdzthXb+f/wDGmyxIEyVHVlwrf5a
         /stA==
X-Forwarded-Encrypted: i=1; AFNElJ9MaJPiZ26ExrHsuPJ9pkU4u4jnc6upy4/yC7m9E4sJDjq5hqEDZX6oXM+/A4aUxgfJ9rZWTkz6/jCLn/v1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2qutPnMTnOtVMpP56NvjCQc7oWgZOfEJEZKhUvXqva6JT0kGo
	gX394QTigACKLuhDhTOmwREymKfn1eZ5ex5XCoQeODSiSLGiaKX4a/C+h97Vzqu3FZcvKVshJ0P
	hGbeB+K3EPjuSot7Iv23Pe18+AEjmyL9ve1Ld
X-Gm-Gg: Acq92OHm/Cvgqf7rNTS6i78I6Ge/wygZLrpHsaCRMJJcNjlxh6vdmWqRvRlL4q1pDil
	MVp5FQtXcA7auG+2yavQA3sLBaKfPe9X12CPVSD06zQ/XRvfhVKPYLz6E9VE8gjDIN2HOH+yWOw
	B5VZ1wQJKMiHTSlxzcMS3PDETh+EA9SU9Eb/CbmNw+mj8Dce/sAtoH4Q2zGiAN0/m0E98z5WtV8
	FjWCM9P/CkqN5taIwFTs4kKi19GO8hjwtkA3o93Ark1s+MUVDT0X874oKo1o2QsrECuDJZsDXpu
	hggn1w==
X-Received: by 2002:a5d:5d85:0:b0:43f:e272:edff with SMTP id
 ffacd0b85a97d-45eb367034emr8829004f8f.4.1779499768323; Fri, 22 May 2026
 18:29:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177922946123.2439242.16666495969848656301.stgit@frogsfrogsfrogs> <177922946329.2439242.17189876954349215664.stgit@frogsfrogsfrogs>
In-Reply-To: <177922946329.2439242.17189876954349215664.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 22 May 2026 18:29:16 -0700
X-Gm-Features: AVHnY4Lep95ZJ6v19KUpg1LJlQIFxjGaUjTORgCARtry_EUicyIkhEs3Kr6SwAI
Message-ID: <CAJnrk1bvmZ0htacx8sqZ+aBVVS_x+7kap77SEctwwB_F6ttsSw@mail.gmail.com>
Subject: Re: [PATCH 7/9] fuse: invalidate ranges of backing devices being used
 for iomap
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, neal@gompa.dev, 
	bernd@bsbernd.com, fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 3:32=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Make it easier to invalidate the page cache for a block device that is
> being used in conjunction with iomap.  This allows a fuse server to kill
> all cached data for a block that is being freed, so that block reuse
> doesn't result in file corruption.  Right now, the only way to do this
> is with fadvise, which ignores and doesn't wait for pages undergoing
> writeback.

imo this would be cleaner going through the ioctl backing interface
instead of through notifications.

I was thinking of something similar in idea for this for passthrough
where you're able to dynamically update or invalidate a mapping
corresponding to a backing id. It'd be great if we could both use the
same uapi.

>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_iomap.h      |    3 ++
>  include/uapi/linux/fuse.h |   20 ++++++++++++++++
>  fs/fuse/dev.c             |   28 +++++++++++++++++++++++
>  fs/fuse/fuse_iomap.c      |   56 +++++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 107 insertions(+)
>
>
> diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
> index c4b98123072a37..f40d202c64c822 100644
> --- a/fs/fuse/fuse_iomap.h
> +++ b/fs/fuse/fuse_iomap.h
> @@ -67,6 +67,8 @@ int fuse_dev_ioctl_add_iomap(struct file *file);
>  int fuse_dev_ioctl_iomap_support(struct file *file,
>                                  struct fuse_iomap_support __user *argp);
>  int fuse_dev_ioctl_iomap_set_nofs(struct file *file, uint32_t __user *ar=
gp);
> +int fuse_iomap_backing_inval(struct fuse_conn *fc,
> +                            const struct fuse_iomap_backing_inval_out *a=
rg);
>  #else
>  # define fuse_iomap_enabled(...)               (false)
>  # define fuse_has_iomap(...)                   (false)
> @@ -94,6 +96,7 @@ int fuse_dev_ioctl_iomap_set_nofs(struct file *file, ui=
nt32_t __user *argp);
>  # define fuse_dev_ioctl_add_iomap(...)         (-EOPNOTSUPP)
>  # define fuse_dev_ioctl_iomap_support(...)     (-EOPNOTSUPP)
>  # define fuse_dev_ioctl_iomap_set_nofs(...)    (-EOPNOTSUPP)
> +# define fuse_iomap_backing_inval(...)         (-ENOSYS)
>  #endif /* CONFIG_FUSE_IOMAP */
>
>  #endif /* _FS_FUSE_IOMAP_H */
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 0366101be3a321..899964f8d6616a 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -247,6 +247,7 @@
>   *  - add FUSE_ATTR_EXCLUSIVE to enable exclusive mode for specific inod=
es
>   *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
>   *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geo=
metry
> + *  - add FUSE_NOTIFY_IOMAP_BACKING_INVAL to invalidate iomap bdev range=
s
>   */
>
>  #ifndef _LINUX_FUSE_H
> @@ -706,6 +707,8 @@ enum fuse_notify_code {
>         FUSE_NOTIFY_RESEND =3D 7,
>         FUSE_NOTIFY_INC_EPOCH =3D 8,
>         FUSE_NOTIFY_PRUNE =3D 9,
> +       FUSE_NOTIFY_IOMAP_BACKING_INVAL =3D 99,
> +       FUSE_NOTIFY_CODE_MAX,

Could you explain why this is 99 and not just 10? Btw, I don't think
we can define the max enum code like this in uapi, as I think that
will break backwards compatibilty when upgrading to a new kernel if
new opcodes get added in the future. I don't see this getting used
anywhere in the series anyways though so maybe best to just delete it?

Thanks,
Joanne
