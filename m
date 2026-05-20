Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4463F1AA2
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779289821; cv=pass; b=D3Tiph3pB0trj1VUkaimCCV6cQohBJoRpEoLeClC3uI3APXhuc8Spoek96QPtRh8M35AHg4Et2+Goc8tNQbiribBeFx+XVlaLQc1l0LivOrWtpLfHoJPJELnlknAO67QExacXapXu4ReLx2wdPDKzg3kFNpluSlB4gWtFWBdXMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779289821; c=relaxed/simple;
	bh=OAaWFz+TsGAnH6xUI8XNHHJOVMUgnRQNUGTfqeeoGlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nEIRzaMZgp+Rur2QJOaOYH2BXPRyCOW/5UeXKevdh0bDherQYdOymq/lD6MIg8QzL1kfu/k8VTsztcejklHryuy2chK3CnKQXWLgqk7oPsB+dUiPZTlrF8OtcqJZc0BdFpPkrsSGG4IBmcCTCEdrfXFLH58olBdmIg3aP7rQlAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRZUTszu; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRZUTszu"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-65e81d623bbso132052d50.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 08:10:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779289819; cv=none;
        d=google.com; s=arc-20240605;
        b=hu3bfax5LGBZG8b4s/ZK5/Ifc6cJhnNkCi2mktoxZdlir3vJJn5bvoDmhioRP88iNL
         FelT2OHpq5Tjhz0KojUjaMF4zfBwxQruNPrq2BbQVIOFJS/6kx9nVyPR5sA6tgFR2f1w
         ComxJlNxDo2/7NCrcMFvxfjfeX2nLsxKNjyFmkSdOPVdmbW1AfGxGksZeTUdoNPUvn5P
         h8+qqtbohDFxzBH79atTe64dp9M160MztowBQxQFRfq3ehiS4tiF1arNWm5Yno6L7GVk
         HQAT2suoZ1VZMhfae05tNtZ9aPokT9JLqqlRVnqQ98Zp04f9SUhAETRkHR74pzGK06qX
         T9sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SQ+qa2N+Xnvw5eZa8sMj4BZiW+dajk5hgBKqXhkpx2I=;
        fh=+pOz2Ew0885TDGBrRboKcr4nXy2ciVrSBJl0gh+9Wz8=;
        b=aL20eowqe4/fLFJ01dDUa1TWaJ7r2jW7EqZSqnYoJYP3gn8H55Wx5Udzhl/BdJ1AWa
         oTSL5v0f1h5py00W0LfF/DExZHQjEirEYkSJoJFYREVS3nBxq/6MKpXHlLLCN7gqmKAV
         wg9KuNIAyf5XckaIAo9qOFnrN0uradHbI9hipNgQw9cde/i11RnElLSYouWdR3NC9Xhq
         iQPv3ozI4gTwflzokZE0FL2D8Dbaa7MwvDzJmG4RjiMGRwrj8z6IIBMAhoxBv7ernBxX
         9zTY2PCrly474bT0mlP5QuD3qO3RJucQwKgKDheXYuqCu9nv4UW52VUURyXkLx0SSlrz
         jvVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779289819; x=1779894619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQ+qa2N+Xnvw5eZa8sMj4BZiW+dajk5hgBKqXhkpx2I=;
        b=dRZUTszuJEuBlCe0+T8u2kMgiWc70K5xXz9eZ6zDn8NrmFvcImupWX5nJVNN4FfICa
         vk7s0l/i07eX/9RXfMuCIezEFD7nyQ7CeCFJbB6QAxbuVdMt4kkqgUu7M9WfZj1gNTT8
         y8WQN4Vx68Nn6yR/dfbcqgMsKL2thBEhJeIA9w+dCrvfTazibOxFw3oUoFyu//iWhNpx
         SkVIWNrlQo8/qas02TBkRft882Oi1zqwgm4C7Ij65Z6OPysWLSPyvLNMCgTLKHQP2Mb1
         xyIn7NMH9oUmqCwzRj9vfzQGbAUhnenHPPSn/OAYarW/e5azeC+Qf6AbND3S3wlpgCdF
         hgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779289819; x=1779894619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SQ+qa2N+Xnvw5eZa8sMj4BZiW+dajk5hgBKqXhkpx2I=;
        b=QLNYSeTU0tm41G3p74YT3oVjnuXm1jrvbEONgqXnA9PnJKn/MmelKzDLxJPsopUi1h
         ekhRe3p0VItC1ffs1BvGsaehGg4NWrBuZWDtod0SuHn8O3CjcOBBxGeNjJHlAmcDzzKJ
         VOzUQPFQRI4xs/Vm4ptObprjPAnfSiYFyYvOoK//lrEO5CdyXVLceZQkPtHdu3jlhSxv
         qNu8UkOSR35PHkvJS3FM1sMX/uurdO+J+bFKBlwjQLxQcaM/nqdPXJYM6BRxb+T8yDZ9
         +tO9uwPv0ozhupPuEqI2kLtulEVwnlhIEx7pqBIE/yqRSDrCVbcPAwGdxA+rcGq2kT6r
         Ackw==
X-Forwarded-Encrypted: i=1; AFNElJ/dlacdNDuzJb/Fcjz8uDVYzHnyEAs/nWxPe3M2tUyFwBWq3tKi+V/U5oZ7Hikp+iRiy/Nfy1HFVo/n3GP6@vger.kernel.org
X-Gm-Message-State: AOJu0YxDCwgbkQMCP9T9oVHenyNTaE5u4nQvGcn77U0uVs7kN3BaioIf
	FQcwdnpNA+O5TyKiQLJ8AcUhfMRk6lnUDel09GE9Gh2pY2Lifbn3OgTr/ZSYp84WXmRVXKZNl3l
	MN1QlGBZfbHFd/1fcjO9/Ad8OpJtQ4Fw=
X-Gm-Gg: Acq92OFKmtgvyipC9blJHJj7dnI3rkf49F8V9Cfcb8DKbI6NQMNIO8C65EoExXVR//p
	5o+ip2OoR3h2mITdjvPV3uxTVAdf+tbrCqGnop3SOEuVRYWG/qyNj/ndgosIzgNfWtkQP3Op5yF
	oMW1tXiikkb0wkvSH2wTTzIatetED2UUCveggmLGiWZbDIcmkL1d8txxGx+QaPFbDOXVOX09iMR
	nG17jG4eSYOSNj1VKRPCrhf7VWuc6849wZTKxj2FAssaBNy++4TNqPhYKC3K8zU6xXQgAYXN/4P
	7+5+PcLpBg==
X-Received: by 2002:a05:690e:b44:b0:654:a4fd:ebdb with SMTP id
 956f58d0204a3-65e227c0234mr15555366d50.3.1779289818836; Wed, 20 May 2026
 08:10:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520111555.79902-1-zenghongling@kylinos.cn>
In-Reply-To: <20260520111555.79902-1-zenghongling@kylinos.cn>
From: CharSyam <charsyam@gmail.com>
Date: Thu, 21 May 2026 00:10:08 +0900
X-Gm-Features: AVHnY4ItFOmpb2uplEl_-_Z-u0LA_AIxWcOtIQRE3zNWsscT669CFuKA_CBnjvY
Message-ID: <CAMrLSE5LM1Okkh8zhBH1Pch=JF2U3e+B2H6ZqWo_NRaBcP_uYg@mail.gmail.com>
Subject: Re: [PATCH] ntfs: Validate error in ntfs_lookup()
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: linkinjeon@kernel.org, hyc.lee@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhongling0719@126.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Hongling.

 I don't think returning NULL is the right fallback here. This branch is
already the IS_ERR_MREF(mref) path, and -ENOENT has been handled above as
the negative-dentry case. If MREF_ERR(mref) ever decodes to 0 here, it
should probably remain an error, e.g. -EIO, rather than being converted
to a successful lookup return.

  Also, I do not see a current producer for MREF_ERR(mref) =3D=3D 0:
ntfs_lookup_inode_by_name() normalizes zero err to -EIO before
ERR_MREF(err).

The Fixes tag also seems wrong, since the same return is
already present in af0db57d4293^.

Thanks.
DaeMyung.

2026=EB=85=84 5=EC=9B=94 20=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 8:16, H=
ongling Zeng <zenghongling@kylinos.cn>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:
>
> Check that MREF_ERR returns non-zero before using as error pointer.
> This prevents potential ERR_PTR(0) when error code is zero
>
> Fixes: af0db57d4293 ("ntfs: update inode operations")
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
>  fs/ntfs/namei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
> index 10894de519c3..bb075aa97b53 100644
> --- a/fs/ntfs/namei.c
> +++ b/fs/ntfs/namei.c
> @@ -236,7 +236,7 @@ static struct dentry *ntfs_lookup(struct inode *dir_i=
no, struct dentry *dent,
>         }
>         ntfs_error(vol->sb, "ntfs_lookup_ino_by_name() failed with error =
code %i.",
>                         -MREF_ERR(mref));
> -       return ERR_PTR(MREF_ERR(mref));
> +       return MREF_ERR(mref) ? ERR_PTR(MREF_ERR(mref)) : NULL;
>  handle_name:
>         {
>                 struct mft_record *m;
> --
> 2.25.1
>
>
