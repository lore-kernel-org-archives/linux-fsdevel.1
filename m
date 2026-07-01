Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EDA3B47E1
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 07:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782890638; cv=none; b=hiSg4Ho0FEyCYiwWqa/wybKUkBxWY4sDpASl0z/OErZiD539CeZvtta2eFpz0QtYDwS+/XZlifQKk08+QQEVYabZDhIh7WlHu4YHPhEHJBi4pcpBe7RJdmuiciLJMu+aP3lAdEYpUWoE1PEWf1+wNYz3gLFkv+if61KoDhXon9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782890638; c=relaxed/simple;
	bh=xBgKRQgBgGiy7DlW67HB4qALiz0nlI8I170mBNHVwik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fi12vBNFww+ttCaUwKM+qSW2TAZUX4weW5xGyTHYs340jtx4ms5hdKoU5SFjTLY4kNsO+u2cOrzUJKgjK74VU/Mfn3ngdauJWdA7bn5ZN2DN/G9hkjaTlMKvYvoy0XK4qYPNWNMSs5kDPzBPn3NsqgDs9IZTQ0aKZen5Np3/zIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPTkIe5t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPTkIe5t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193F11F00ACA
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 07:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782890636;
	bh=v+IHg2WxViz+zVdAZSPxzggSpywKO1GRs/+QAIG31bw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mPTkIe5tioIWueL01SArrhs05xr2CNeMjE/jBRBOzxp22v5eHL9XPsFcBXV1owih5
	 laPCDaQedW2WgLlLmVuqsTzry38G6poqBtWDu2kbTs/drBq5u+vM6lWrQtN7Zla16p
	 6BalR/gG2PwclINuokqGGiOqu+TedbC5jQwMJFKwElgRtFKUt0WFe1Wa/p+b332utR
	 DvLZ+84GARMZKT7IBkb3Aca5Jc0h+SbJkZiKHQ4IZQXWhJ5m0DKjz1AE+Rt3TDRV3J
	 4nZoAmItZdUBF0StM8doww+0d0gVaqaXM7AOeDldrQZMkWpbVWhOS6twthOr7zULB9
	 YMmXldNuguGAA==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c127a694ccbso52603966b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 00:23:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp/3nIJYp4BM3O6hF2r26Kyh4N1zBnqdiZ/4AvW66IWmOFv51g7L0VBX2NUZiooVcy5OdA6UW43OkES9zYy@vger.kernel.org
X-Gm-Message-State: AOJu0YwN2aVam1cJvoXZ1KS4bPBg5CPxWp3cEHs2Af/CRlwOIqfhfHAw
	7yx3YwLNslYVZbnnQ3J41Np0Ota9p5u7FV9LWxQ8NryOXOSL1fZfSgUWsXZ02ZRTovmoxFl6dID
	QtZzxc/v1LkiA+I4rU3wB9eJZu2ohBYc=
X-Received: by 2002:a17:907:60cb:b0:c12:1e33:8590 with SMTP id
 a640c23a62f3a-c12a9de707cmr15645466b.14.1782890634754; Wed, 01 Jul 2026
 00:23:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701070635.53544-1-zenghongling@kylinos.cn>
In-Reply-To: <20260701070635.53544-1-zenghongling@kylinos.cn>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 1 Jul 2026 16:23:41 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8apB6yGP9WL9WQU3cw9MqU3sQXnjYVMT=Ttr4JBt_e+Q@mail.gmail.com>
X-Gm-Features: AVVi8CcExy3OWkN0EBkYpe9NxnW1P1rNPS_pFy2kaZh_qReVqjvTxoNwjzgq238
Message-ID: <CAKYAXd8apB6yGP9WL9WQU3cw9MqU3sQXnjYVMT=Ttr4JBt_e+Q@mail.gmail.com>
Subject: Re: [PATCH v3] ntfs: validate error codes from untrusted disk data
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: hyc.lee@gmail.com, charsyam@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhongling0719@126.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
> index a19626a135bd..5229522b29ba 100644
> --- a/fs/ntfs/namei.c
> +++ b/fs/ntfs/namei.c
> @@ -233,9 +233,17 @@ static struct dentry *ntfs_lookup(struct inode *dir_ino, struct dentry *dent,
>                 ntfs_debug("Done.");
>                 return d_splice_alias(NULL, dent);
>         }
> -       ntfs_error(vol->sb, "ntfs_lookup_ino_by_name() failed with error code %i.",
> -                       -MREF_ERR(mref));
> -       return ERR_PTR(MREF_ERR(mref));
> +
> +       long err = MREF_ERR(mref);
I prefer declaring all local variables at the beginning of the function.
> +
> +       if (err < 0 && err >= -MAX_ERRNO) {
> +               ntfs_error(vol->sb, "ntfs_lookup_ino_by_name() failed with error code %li.",
> +                               err);
> +               return ERR_PTR(err);
> +       }
> +       ntfs_error(vol->sb, "ntfs_lookup_ino_by_name() returned invalid error code %li, treating as disk corruption.",
> +                       err);
WARNING: line length of 118 exceeds 100 columns
#108: FILE: fs/ntfs/namei.c:244:
+ ntfs_error(vol->sb, "ntfs_lookup_ino_by_name() returned invalid
error code %li, treating as disk corruption.",

Thanks.
