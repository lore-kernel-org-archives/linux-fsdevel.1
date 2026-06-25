Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75D730AD1A
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 18:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782412377; cv=pass; b=ADMxauLz7NhE+1EM0V2JL5STRlwbhoAKwmhS2w9+TV40nLRjcSOJclrI8sc5+0vwMa34nB8ABdfYmW3ntU7GJbBVnkWA4UY99GXvZWBTMjUq9zXaoghz1pnpjf7YoKwBHsgaWG46FImvStMa1Xt7uX2e+zdsKtXatCYuAsQudu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782412377; c=relaxed/simple;
	bh=BDX+NQmwbo8tKyIHJVU3KO5zaM+mKg+N84iqF/OWUBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GbG0Hn0X2PSO2lcQuteBikArlqX2ylgRlrj49PUCyQLml/3BtRlyhqh6PQKtKfYi1Uf7ySncnTQ/Ibds4qGak2Ma1FV0GyUq/dOfQpY+H6763sABxELH9MAV+phf1olvdAa3dVuGP3PjXl/XnonmM368boKnUC82kvdpUUxV108=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKyJCLRD; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKyJCLRD"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-463b2f6fc9dso46038f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 11:32:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782412373; cv=none;
        d=google.com; s=arc-20260327;
        b=b9g3NEN8WRMbAqmRh34rhmnascnsfg5fbOEtx06lEpYe9Df77xiGJU1zvt/A7QiNEE
         /kNbT75AFqKWp2YO5IBXdzcS/AE4pPhv2x6rpvhp6Xy163j1T8Aa3vEN5O7LMVzOCQO3
         HcK6XOG+GO4o7NhBUZBhtDcESSgDrkvZSLZif7vpEHhmPXa1A5T6MPoNCtq1ZU/jk272
         N8W9OPffZSMn9GGMzH3bfTLvKEtBDJ9d8pumxm3tRAuIW1CGj3m7wd+GFOpOhTUwu2vk
         ZkH0vRmhg11fUjCfbP4Z0S+oqea+q59stdDR8+bYnOvKpm6pJIzE9Twb29eFsY6Hrque
         j3hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g9V61tcEtmNSRd/wIPFD8Kzb7PIr8WM9gRz3AhdzXFA=;
        fh=aE6vXRMqQR5QpT6hNe+3Snq9H16IXrjpR9ZEucdCvdg=;
        b=EZo/geGYDMPyBtjbZkxWjxYt0woIK7659sceeRk+d4N8EdIrI/8r4nP08tnyoe0eNd
         T4JqwGdEJV0oJ8S/ZQV603+8oxl9+d4IqvDQxFhJidFK3L5qqX1W0jFWomLJAykp1u8J
         6tNCE4xg3u9wvV+3KpshCuMdLQizvT+bSf4wurxr4jC2Me3Jx8QG5WC9uL6ieyZKOxNA
         OqNVPxDJtCBn3Sf9V+/p5Gd3T6txN7WGw+uZDEjU3m6QbSXpnqFI2iHcnnFCLJ/ofihS
         3sXSzj1XbAlOFroQl4Jmn2g716S/8mVzfOqGBMPB57IZp1XPGNbxtjCZ1RIYcUVGfcYK
         mnaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782412373; x=1783017173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9V61tcEtmNSRd/wIPFD8Kzb7PIr8WM9gRz3AhdzXFA=;
        b=BKyJCLRDjTujVynHf/v+U7D/LXyTDEu8jthJww0EJEDKC8i+9SaFY3LusmUACJcTyc
         LgsRSpaUqECW92LA7Hn4GFQVwIZbNnvSQyNvcqeuniKMF0w56p/XYr9KLRsBYifLvxZf
         Qx66qkNsY6JJfTY7cahDbvaoyuV2cbn/McNNLRK+3F0FqMtLesZThd+XAkvMmB7apV/u
         7tIN2sliG74qz2u3Let5X0KvDzZPpLnh7J7Jhld83IdHbHq0Vr8/2VgeIDawWh1frjlU
         PwXi7WvYyM8zQCBnXG1dmwQlpRi5DGLP5142J2TSd5VjBASE4vadZijEafqA/m4Xu5Ew
         8uFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782412373; x=1783017173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g9V61tcEtmNSRd/wIPFD8Kzb7PIr8WM9gRz3AhdzXFA=;
        b=aamxCVnJDLZMQwNZndlB64bUgS8bxdnB9UkKhTBOccoNKG6yTWS6lU10w8Wek8yiZt
         GjKjs8Uj/dByylGTLR/xUWIvdTO9g9POLhDIck7ywul7woddewLdacI7p05LF4hCN0mV
         1JIL5WASQ5Y/30HTJw3LPluZyOjBTwMLV1Kv4UG/wgGoY/nvgK+JXQbNrNkXwdl4jLtD
         6S8Q2sHOR4y6Thb96OrhrZEIwqiAt0uP0X7sV42/z8ltRfY96XUAE8gnziAiAtliabnt
         I/w2Ie8+Z1jcy8Zq/pdx5YhAT2rNWIWqjZQf0FgAekiOhMCezGDjP8w9+bmJM+ndjhaB
         WUAg==
X-Forwarded-Encrypted: i=1; AHgh+Rokk8oYL/Pi1nFsld03fGC32tpMW6p3+UEjT0IQCCvBdvBg44xoPNN//7Le2bG3ZtBgy17RVa6xvzCm7x7K@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcsdm8ag+UhNygzpN5x6Y66I3QnbNv7ZM7k/FG58LNybOVnj5S
	7Cf+WFpLBBQzLpAGxE3p+jzBBKCschy4MJBR6sVmA8ta8M0mF1gbIvUk/c/xv/CxizNn9EzDyU0
	XpuL5V1HHQFN0yoioLJS0UHDbbYqhjmw=
X-Gm-Gg: AfdE7cl3C42H5pfDOvp8Sdp/TUIhwTpQyE6KnaCSol4cX8/LQ4k4jPRY8aUv5ywPv9Z
	Jx5pb2IMyG65QukM+FG61eLSNqIvtcsVP1M0jZSxouWKdTOQJdmjrF5DogryVSoDWbJHwYbgnoN
	sjyV6nDRdP+qn9ruOmGYSmETtraSMPmVRc6ptfMLnp/7Xl55AF8qJrmW8pRpm8nlLFhfZKnIEDr
	WJsvaq0JsssER48PFIQJPQ5alqTZpsqGk6/Ihnw1y00zq1UG8Wo3WuhhPDWzrJIMd+IH9cJeXcu
	GBFgNNOsB+6G7ketA9PXxV9Fj8/cGbvoEWPYbLy7mq4axHMbGcha
X-Received: by 2002:adf:e198:0:b0:469:3bd0:fa7d with SMTP id
 ffacd0b85a97d-46dc1e7d2aamr5538200f8f.41.1782412373179; Thu, 25 Jun 2026
 11:32:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625120803.2462291-1-hch@lst.de> <20260625120803.2462291-3-hch@lst.de>
 <20260625174758.GE6078@frogsfrogsfrogs>
In-Reply-To: <20260625174758.GE6078@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 25 Jun 2026 11:32:40 -0700
X-Gm-Features: AVVi8Cft-saEfjqDMyKwAQ7hs3asCzTZsJFUliVou9sVBM1d6hPzz_2GUJ4y52Y
Message-ID: <CAJnrk1YFeirQ4g7qcVsda-8qPLeAtoiyW6ZBuJb2qDsGpxi-tg@mail.gmail.com>
Subject: Re: [PATCH 2/2] iomap: submit read bio after each extent
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>, Kelu Ye <yekelu1@huawei.com>, 
	Yifan Zhao <zhaoyifan28@huawei.com>, Ritesh Harjani <ritesh.list@gmail.com>, 
	Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Hyunchul Lee <hyc.lee@gmail.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 10:47=E2=80=AFAM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Thu, Jun 25, 2026 at 02:07:57PM +0200, Christoph Hellwig wrote:
>
> > So instead of adding more checks move over to a model where a bio only
> > spans a single iomap.  Change ->submit_read to be called after each
> > iteration, and pass a force argument to indicate that the bio must
> > be submitted set on the last iteration.  Switch the bio based users
> > to always submit, while keeping the single submit for fuse.
>
> Is fuse the sole reason for the "force" parameter to exist?  I wonder if
> fuse could drop its submit_read function and call fuse_send_readpages
> after the iomap_read{ahead,folio} function returns?
>

Yes, that works. I think that's a good idea. fuse only needs
submit_read logic for readahead. The change would just be:

--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -953,19 +953,8 @@ static int
fuse_iomap_read_folio_range_async(const struct iomap_iter *iter,
        return ret;
 }

-static void fuse_iomap_submit_read(const struct iomap_iter *iter,
-               struct iomap_read_folio_ctx *ctx)
-{
-       struct fuse_fill_read_data *data =3D ctx->read_ctx;
-
-       if (data->ia)
-               fuse_send_readpages(data->ia, data->file, data->nr_bytes,
-                                   data->fc->async_read);
-}
-
 static const struct iomap_read_ops fuse_iomap_read_ops =3D {
        .read_folio_range =3D fuse_iomap_read_folio_range_async,
-       .submit_read =3D fuse_iomap_submit_read,
 };

 static int fuse_read_folio(struct file *file, struct folio *folio)
@@ -1089,6 +1078,9 @@ static void fuse_readahead(struct readahead_control *=
rac)
                return;

        iomap_readahead(&fuse_iomap_ops, &ctx, NULL);
+       if (data.ia)
+               fuse_send_readpages(data.ia, data.file, data.nr_bytes,
+                                   fc->async_read);
 }


If this fix needs to go into 7.2 though, maybe it makes sense to land
the v1 implementation [1] + the xfs integrity fix now and do the fuse
change later?

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20260619050105.439956-2-hch@lst.d=
e/
