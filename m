Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FABB3876A9
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 23:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775863564; cv=pass; b=g5WroL8hJkEvPSu6mZENpaeLta8nkSx/5e6ioVlzV5cD/W1HSLoLeSf/mQ7OtdgwApJz2SeLgtVxHecqmkVVx4DSOO+l+/BKulCBRAQcgXmYNMTlm2w+ZZKPiCNTURJL5H9INRVeF0j6Rxgp1jwpLyieBusUCmaAECDUtRK2184=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775863564; c=relaxed/simple;
	bh=Ctedkfm08XoSSUXxENdCsLe9XNAH9ADnJHMTWYIWX+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ufVOfVWNhHzT9MEMjU78vN2Nj4wAREiVgN3fGx5E6nkbZu6kYI8TrB1oR61VqkCp+5GGXn2XGivzfSD0D9mJ059O3pbDtPyzZlG+33Pg6tGG4LnNf/TTLrV0nGLfIwRKU+uqMgFLwux7cIENSkzKXbvaEHumn6daSq9K6nPbXP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djvp6uSM; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djvp6uSM"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59de8155501so2873868e87.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 16:26:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775863562; cv=none;
        d=google.com; s=arc-20240605;
        b=eUqtMkV68rMJsvBcVMJar/9wB2lgDMJH30HqjvBPLzwKc9jUciAQinBb1dDeEzzFBb
         kJjfATMCAsZBQuoRXK3TBl/om2b8A9PgmUt/cx+RkPF0FYp6vB80soTUYRKEpr7tBz6v
         OK84eMp6G4/t4snbZUF8ML9oWndNkYP1TV2O3AGnBshYhOSi3oYvMVwy46i+a02tbvoK
         Hj65RJ6uaQgriI25/vhNdD+qKm1yH1dyfwjJ7LMIyJpVlrO8bGsUf0wHdeNjtctzj4rs
         5a14pBvx6Ps5q7dhvnxVAJXGgY/GR2ezfBtULPBhr5/vj0S3zBRJOIYJnhMYsQapBQFo
         ZD2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=URHDsYQxbWckRjRtpI0pZvLDTeFqTvzZhMylWv9xs6o=;
        fh=8wfKxlQeDvsKVE059mdYgjf/0o910p1FWkaNc/mr8bY=;
        b=E5++dIkm02s1cj2gk8gShCy2iKChsBchqSzIVDWJXH7yP1AZbUUWC/MXwOFgc+xQRd
         RCl+8/AxFPsEVswY+nP4B+9METT6lAqTRyp6dU6MplKe1JI2/QmoBlENBLqfwjpvID9u
         PWDL7YsQrX/axPfjZ2QqaDD7DPKa1O85hZkNbMWLbuAtTgq1Bzc8JfGUmrMgtMQ2VUfs
         QG5MNC+Wk9dpGuYTMs150IyPNp2Y1LwEcg+MgCp14Jn8mIx/y6RsLsrOJm6Rxchjo5dA
         SYz0Tg8faEJtIxCyWjpJkGzc2Y34InwCuMMP5uxwI3p2MSk+gd6+A9ea7Rm6ft3bnN1c
         c6pA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775863562; x=1776468362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URHDsYQxbWckRjRtpI0pZvLDTeFqTvzZhMylWv9xs6o=;
        b=djvp6uSMn1jDY+NjDFzdacnXB7uSMsLn91qrBb1ZNnO+qeR6ClcgrDoglgqsBgSZ29
         BQt48nFfkPy/ghYxJBuQti+82Ux6JMbqZymTKYiPCuwZ7jTMEYkJT7Mba2lNJDn/Y8Vy
         SQuw8jFzYXFfmLiB+JNtKLZPeCrMqYbaQSDjB7KA/aPoR9cTOySbeeWI1p0dTvSK6wW1
         r03p9oEHpv84FNwqLA4waMJwSXAP0sYkPipAaF1LCo0p9hHoIpg06lEUkA+qA7NzlFab
         tmXUvMU6tDIqziDnhpMDyuJzA4SRdpkzavxotMgFoB7V77/IEBBMxXtQEM3+/F0RO5aW
         kQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775863562; x=1776468362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=URHDsYQxbWckRjRtpI0pZvLDTeFqTvzZhMylWv9xs6o=;
        b=CiD3PbCzqgENzl2a/1yLoPvjMb6qFMJ8RhQb5oe7Q3nOoFK1M49N4JCKSf68yI66X6
         2Tv2c/+o2v1KTF5IqwkAbsLDdGzttIQNx/WzBuwrjCVJbBUUNJp4cbvf8RsmPVz96U+U
         S9+bLn93MBhHdAqjrXQyPfmLB9PDLpX8S6Bil52hxWG71IPUBHdmG4Xt0634lCnUomS9
         1GLwNEIlyb0ShjCz5Nhr8pq+F9FyBm7Igkp+DwHoePGTL43WCTDvJFhUvWBn14AYHGqF
         kQuotiOGs2ypF6HDKqWhgHbbI9WkqvWH146DkML5R0ApoEM2CMnQGZg7C4sjfG1titir
         FmNg==
X-Forwarded-Encrypted: i=1; AJvYcCXrEM+mtzGRVNaLaJymZLdOGif1QTXubG67wzJAlOSJy3VGNh9nyZjZ3kECMeAILllYqZOkBrfLg4jNHsw1@vger.kernel.org
X-Gm-Message-State: AOJu0YxW0BKwoHc5K4yM3osI2leTPdkqBaQOCThibI6OvYwK3CbAqX8f
	tBAnGmahHSFKfKcYARuCUxmjcZ/DdXd3uBX3K/bDIMzxD3aPlIeZwmaMew9GSuR5aZEObNP51K2
	atNc+J2earAMntmX3iGr/2YLUatZ5aeQ=
X-Gm-Gg: AeBDietezvQz1Lq+vDs7RT7Fpl8cmrE+RazllDXewcmlfiJP9p/6lVd5FlCfuJUBhcJ
	IwPb22fb0zTzox5gn0idJQ4Gjwwq1hBe/QiZJ76js+9ZiFlI6Te8A11czXDIsnL+FUuff5s2Mu7
	GY38DrIYSzULDxVQcZrGFfguIbrcXecC62WZco6eFmaMEp8kPnT1Ugr4AkRXZGTkVJnnJEBevVl
	F1XVMHfeT4sy3CyNuGRt6kziHIsDIMPoE9xtnISkwTTY5N7jrSXisn+7SGVGiAGK8tf1dVu7K+2
	lks5c7z28MmUKt8ILRG8
X-Received: by 2002:a05:6512:3189:b0:5a3:e016:979c with SMTP id
 2adb3069b0e04-5a3efe994c1mr1626268e87.36.1775863561443; Fri, 10 Apr 2026
 16:26:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adjMsTa3Xv7O3jWH@stanley.mountain>
In-Reply-To: <adjMsTa3Xv7O3jWH@stanley.mountain>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Sat, 11 Apr 2026 08:25:49 +0900
X-Gm-Features: AQROBzBThMHBhMrYKU48tKnMzybia1V7xtSEq8GeK9_HbMfZiOVJhmzFsQUW2Zk
Message-ID: <CANFS6bZxN8iqtyMRxrvdXBssMBu2S=zBDFds_Asc1W1vs_WDoQ@mail.gmail.com>
Subject: Re: [PATCH] ntfs: delete dead code
To: Dan Carpenter <error27@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 4=EC=9B=94 10=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 7:11, D=
an Carpenter <error27@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> We know "ret2" is zero so there is no need to check.  Delete the
> if statement.
>
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
>  fs/ntfs/file.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
> index e5b897a6c1e1..b04919124989 100644
> --- a/fs/ntfs/file.c
> +++ b/fs/ntfs/file.c
> @@ -534,10 +534,9 @@ static ssize_t ntfs_dio_write_iter(struct kiocb *ioc=
b, struct iov_iter *from)
>                         ret =3D -EIO;
>                         goto out;
>                 }
> -               if (!ret2)
> -                       invalidate_mapping_pages(iocb->ki_filp->f_mapping=
,
> -                                                offset >> PAGE_SHIFT,
> -                                                end >> PAGE_SHIFT);
> +               invalidate_mapping_pages(iocb->ki_filp->f_mapping,
> +                                        offset >> PAGE_SHIFT,
> +                                        end >> PAGE_SHIFT);
>         }
>
>  out:
> --
> 2.53.0
>


--=20
Thanks,
Hyunchul
