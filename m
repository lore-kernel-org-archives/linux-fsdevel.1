Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B7A270EDF
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 May 2026 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778337994; cv=pass; b=jZOWsYTNHRzaQahpLoXm3L71KokciRDfkfIJtQidgmzsmeO7At9dI4n4aIQRPgNVaZPdcXJSmXtWlLKxFHyEtRsNb5uYksxrWY/IvfRYIZ8Na4l+0ibWQGy5Tsk7SsucQGz7DgOisjXsTFAs/n2AqtrBAxa2TRcplWisxJh7d24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778337994; c=relaxed/simple;
	bh=sawKN+qRD/vAY7MWOXqkqKaG0HyQdKakE6fstvcoU3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o93xV8JHYD3/6Dsci/rNMi/2wN5S0ZjsrbxoMRwHwuQZtcBA2Zepq3xiSmTSkSiB5+Ch9JrvkyiipE6rcc0Wz/iSZPKXeeTv4x2MJOEvzXU1SwOQ2cejiyDB+dzAOGKyd3lCw9w2Cs4CUR5G6bMK6ZiOg92G/fk2ZAPCLN+vlFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLSH/d4H; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLSH/d4H"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-67e9e343b22so2877611a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 May 2026 07:46:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778337992; cv=none;
        d=google.com; s=arc-20240605;
        b=Z8ZixoheHYQuzFkTEZw4FvnZYxCutrXmAC0rW3/up/oIKNLTzXHgVbI7F19iRw5ouu
         odgbmbkFtgNCsm87tAdYGpgzuLeIzun8efAYgJsGOAad5T+K1BOMd9dCREYWU03lI0/k
         rQDaKs95LjnH/PG9Hx7SsqDiQYS48PAQ1LObHx/OWqBwFbCmGHtx9/771xqC4FleK0Qk
         /EE0CSG5P8RPi2QzOZcjMJMtrwaP8x0fx1OiGMX3Xn8wTQ2i3qvlxOq+HA2ewHzDg4bh
         MjGpQDqZA29kBOWI8zNJelbgRlCgB+GOP8AvA/EyhhALK93IIKsHyioJzF9TV+YGyb+M
         Qw9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hxvAH6B3ovI1KriPqXOwwGFTFPthi96p6jV9SADdE0c=;
        fh=nGXSPDt/T+M6diPsxauAGlZkvicqvxRNODF5oHW2Ksk=;
        b=cCfG4bLLDCW7NFF/54so8Sc5JOPJJJbAEL5GaqGKS382DOSZCjv2xb91BcZMcJM6Ih
         kxXaIhb9XKQ7y5Zz6M6hkrUKFMZ7s93OPLi+xOUQhQTvQBafX29OLqNleFAiiGtzfyFX
         Uzdf2/8UINSdFBynCAGagcIcFWPVeeSGsZeluo6GjsW1dGefLpqenmssRQZ8pqhICwL+
         S05o6sMmZLjuiTjmc/WoYOGoMf2F5rcOWhownl/yRDGtAn5Blsf4zAwNeUXorpzCMA3U
         PWYrJF21VYhXfFTMPhnWnkrs9/fbhG9rhDJb8esdLtkpgMjm4zPW5Bzr5h1yQ5DcPOLh
         V9Rg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778337992; x=1778942792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxvAH6B3ovI1KriPqXOwwGFTFPthi96p6jV9SADdE0c=;
        b=JLSH/d4HGxh/YnC2fy08uaJacwT1QOiZO9KoDfKGXfzP74I+gErKquG60fJikEyeVn
         CoBXnBo1f8TFFxI8TD3PHKTz/thB2+knn0osardbSeSN7Eo22I9XJSfdQPopOkWRDiIh
         wfxADFihNE9eSHSDdqbek5VBtyKL5OBICxokz4eiMLvVwq9YFtFYnsl+89RGp6dRBasW
         5OBZ+BGZKxSwJVoEmqBZa7YtV2aUviQfvuKAV4GY3CL0BJKLR+PKPvrIapBSQ6GfFdrO
         IJjUvK+OVypdlgXpFkXp4wKY5X2RYeSwFTOWJb0hun27aJLbXDjx2nD4zXilMaexwzQr
         qFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778337992; x=1778942792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hxvAH6B3ovI1KriPqXOwwGFTFPthi96p6jV9SADdE0c=;
        b=b6F2fhgZGDPcxclXfA3lF6x+JuSkz4GB33Bw1QP5gRutAjj3JlcUQEDMFzB40EOyK0
         nxW9MZ7A9QapDWUCBltouVWmBuU76Jh2EEoi5v40z4dd3jv25qvlG3Yh1mVvJrlx3cSt
         r3H++4RbUdr+hAo7y6IzhIMSSybMkXUWLmz4XK3qY1i45pZCkLKpp7MO+VFLLDMgdQ1n
         uoc0hgfk8VF5oc4cf8DdTpuGrGO/D8q59FROBUQmv7cP5ZX4Br/UTjfvLdAt4rXdtFXX
         Krdf8Wuy5X5zV8Vn5nDOIm+2dodSKhfPr8vfbGnZQTg1ctvVyomcmtePI6lyqTn2yiX2
         04xA==
X-Forwarded-Encrypted: i=1; AFNElJ9D5nTDeF3xfl5ews/0246N4aW6HNGCMB1hUq1qIiy/kFVwb8skQHWJEMsoEPpbVhfpPOjPgqoSrAJdeTQE@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc0LGo5tpo+yi7v0A6zexg0c6vEx1EX2nSy152iWYSTndwiYkd
	4Fm8whHa7YCCyH8cmkq1H5S4AhbWaq5ZHIwLPNroxur0uA2pf9OY+Yboeu3SyKhz6527GYjDYXD
	k/SUVtRsai7OsYqGuF5Z/KAQgzapun4A=
X-Gm-Gg: Acq92OGZj+9nfKmiPXlAqwUIqa39LHZmqIIdNHKnLsvJtnWVbkLHV24vheZ9GNsTVIZ
	N/7+6hF1oXwiBNbRn4UD77LJtyXb7j1WLnHvK/vbtautuP7p2AF+w4CGYdBnMiG0Os+BcyZRoFy
	Bk6y17wCV2JzsibZeo6tG2zNEvDNJ8MUbbQt9DQHtRZv7AqatkEndRc4bWC2MLaCcK26agh19Qz
	zwYq3mBgt1uhPv4JbZ0n4cCIVUJNc5zm6WpkqcbohApHXomLAVIo3kRtFLqshHucpkdozlYzpDr
	FSz44RiVFSyVfXCJgaIMS84Dl3F1jbw/AgeSXJMY
X-Received: by 2002:aa7:da02:0:b0:66e:e024:1a08 with SMTP id
 4fb4d7f45d1cf-67d646b082bmr6638931a12.24.1778337991544; Sat, 09 May 2026
 07:46:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509102337.272593-1-liwang@kylinos.cn>
In-Reply-To: <20260509102337.272593-1-liwang@kylinos.cn>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 9 May 2026 16:46:19 +0200
X-Gm-Features: AVHnY4JRiI1W0a00aZBMx9Zu9ZwGd-b_kHgAXX5Dt--Xvfq-HwbodxzXIgAENc8
Message-ID: <CAOQ4uxjRtUkWB6oCttv-VnznCB3T+HNXgoYgEcU3RwU6BokaYQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: propagate async RELEASE queue errno in fuse_file_put()
To: Li Wang <liwang@kylinos.cn>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong <joannelkoong@gmail.com>, 
	Bernd Schubert <bernd@bsbernd.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 9, 2026 at 12:24=E2=80=AFPM Li Wang <liwang@kylinos.cn> wrote:
>
> fuse_file_put() queues asynchronous FUSE_RELEASE via fuse_simple_backgrou=
nd().
> When queueing fails, the failure branch always passed -ENOTCONN into
> fuse_release_end(). fuse_simple_background() can however fail for multipl=
e reasons
> with different return values, such as -ENOMEM or -EINTR. Pass the actual =
negative
> errno into fuse_release_end(). Currently, the callback does not interpret=
 it,
> but passing the real value avoids misleading future development or debug =
printf
> that assumes -ENOTCONN meant disconnect.
>

Hi Li,

If fuse_release_end() does not do anything with the error, just drop this
argument.

I see no point in this patch as is, serving some unknown future development=
.
If future development needs the error, future developers can pass the error=
.

Thanks,
Amir.

> Add an explicit (void)error in fuse_release_end() so builds that enable
> -Wunused-parameter (for example make W=3D3) stay clean.
>
> Signed-off-by: Li Wang <liwang@kylinos.cn>
> ---
>  fs/fuse/file.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 3bdab8d03373..8b7badb7721a 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -96,6 +96,8 @@ static void fuse_release_end(struct fuse_args *args, in=
t error)
>  {
>         struct fuse_release_args *ra =3D container_of(args, typeof(*ra), =
args);
>
> +       (void)error;
> +
>         iput(ra->inode);
>         kfree(ra);
>  }
> @@ -117,6 +119,8 @@ static void fuse_file_put(struct fuse_file *ff, bool =
sync)
>                         fuse_simple_request(ff->fm, args);
>                         fuse_release_end(args, 0);
>                 } else {
> +                       int err;
> +
>                         /*
>                          * DAX inodes may need to issue a number of synch=
ronous
>                          * request for clearing the mappings.
> @@ -124,9 +128,10 @@ static void fuse_file_put(struct fuse_file *ff, bool=
 sync)
>                         if (ra && ra->inode && FUSE_IS_DAX(ra->inode))
>                                 args->may_block =3D true;
>                         args->end =3D fuse_release_end;
> -                       if (fuse_simple_background(ff->fm, args,
> -                                                  GFP_KERNEL | __GFP_NOF=
AIL))
> -                               fuse_release_end(args, -ENOTCONN);
> +                       err =3D fuse_simple_background(ff->fm, args,
> +                                                    GFP_KERNEL | __GFP_N=
OFAIL);
> +                       if (err)
> +                               fuse_release_end(args, err);
>                 }
>                 kfree(ff);
>         }
> --
> 2.34.1
>
>
