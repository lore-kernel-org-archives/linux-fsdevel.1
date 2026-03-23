Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3083833120A
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 06:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774247760; cv=pass; b=XiTtJLVuHKNSW/WJlZ3ieDPGV2vOVgqjrITBG+BGEy8aE81r6bBnV/1O3kdweilA3IY8ixMeAordkvAvF6z67PRrGG+4tMHXzzZpFmUEeL3TkLnZzYZDNSCPsGI+diy5dLERc+otxuoOOrejPg2PqLWjZB9QQSRZrDRmmNewJ5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774247760; c=relaxed/simple;
	bh=59uxIH21CKtv5O0wLkhDlOe6WnBmhQwJfCN/wKAHNG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=XqGqSrVhiwy3tu9GfXv4G/QqX8Bh0eVQRz69UDh10FAC6/qb+b79Cu6s7nG7KJTqzoLYMFK+48K5bavrynLeanIHCdHwXlQZFMF7UjeZoSbIVrnBTO+tLdb+2qn+AIF/Y53uj6hfODpOpkePdlFX7WOSUAvP/PGrD02wNd4W3hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXY3ZTe8; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXY3ZTe8"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6697c7ffa98so1538679a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Mar 2026 23:35:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774247756; cv=none;
        d=google.com; s=arc-20240605;
        b=WoRGNiat2g2kcz87UHlrMj7DRiCzy+ZXfD5ehiTOo1b/H4OFOmJUsbHONG/70+aAZ/
         +Mj1/+K1My/6bLaqFbAwCM78RDBgzANeJSbTq1xz7+bTXBuJIICNfFRilCbqLgjByZpl
         NAWnxowvlgJWjbAyVVnbCJL1MC1wuieHF31MeNiOYEoHeL3VMLOu3tf//PiI4dKwgrQZ
         54qRwAeCdkRBMYFUmdYoi1E/axm7MNhMar7WGFClJJaysAeUBQsV6HPxR06y3rZQE5b6
         E2komcPnKLgUyX1oSbpXRw9cC7YVu2ujbxWOJ1be28FcQYVKlUm84PWvb6ocPe8dmdbx
         pbDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=59uxIH21CKtv5O0wLkhDlOe6WnBmhQwJfCN/wKAHNG4=;
        fh=KvVirAiQ7kdEPXS0ke7Y8REFl+I86cpA671GUfYZ37M=;
        b=kGLyhU6jaUcCI87hygvvROB4el/eDCLuouXfczkZ2PmLOHLNXQBLqMnlA/aaGzBDJK
         95uZULb887phu58ebe+ZjXAnPiZiqU8cpheZF9sb+33fFTDWuAeWGWhhvTbTY+Hv7pft
         yYxbgqxIacnMUNBb5KUmRmHZLlO5vnEg662VR+k+zz5VBjiRMCi5ZZaR0cdGn0+Qzmc2
         cQlxet+lrzT6Om6AMaMdptp812jyoxiQewwRhPSuUu3kFVUzGDr8qLsgEvxfdu8IfMT8
         Y8bpYG9Cpy80/796wBcP6YueYjgs/Ct6jyevx1x3EKdrcGBpS82r94ymSD54oxtHAPLs
         7RUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774247756; x=1774852556; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59uxIH21CKtv5O0wLkhDlOe6WnBmhQwJfCN/wKAHNG4=;
        b=BXY3ZTe8bhEVo4X5zmF3fHsY6nmxHL4Bz92SlDi9M0zuhM+QHKa+PSHAf0FZmXvaLP
         NEr03wDW+941DdB1ezCmcQjxpXCee5L6oV1wPnzr/flZZSN9HqnkhTiy2sHRbWbZZ6ns
         xhuWyDj+29NEqUS2R9RptPQZF3ZGfZ9qsV2K3naUwweWz/2RZr0eL/5zl+RllrJTY4zn
         kG6kGZs23PzR2ula8mSV4Q0/1sC4xntsPwtkKzI8W392AEmz8tItXEyKhl8Ac4LUJPKe
         Q05oWfomhbrcMMlz+GYmhEn7QYPRkmJyIybjN5SQwi5Ds11LxZ1EtGyJi383w7m/Iv4X
         L9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774247756; x=1774852556;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=59uxIH21CKtv5O0wLkhDlOe6WnBmhQwJfCN/wKAHNG4=;
        b=Ds5IVtzhA/d4zfiHHRg4dgxsQeZrfeXHq33lixne+SqWEvO9MeFu14X2ha2tpWltx9
         AbtOxTx4Ef6JxP6dm+E2T7400gOyv03+xLINrvnZzi//1qdYvM85fPJ6MalRzLUFXgYH
         a46vM0bV42kxEf+eQGTph7nBKZgAZ689D1ee/d97RXwVkaFKosUkhfoSrGisYhnDSqBK
         Fx9nvWOZs3ikOt679+1XmRwAASqRdSOtsLREa6n7GSAv3MJzhfCIfenBRMN+L/+R9FoA
         bhpZPKA1jSzyjAcCexu3lyFsOxjneqPgtUSriDy2uoW7vD+TxgL8s6E5Euwf12uUEb4O
         sicA==
X-Forwarded-Encrypted: i=1; AJvYcCXYI9GU5G/BHlhfkgwNpRYUxiUCv8+2Y4pv3KH7UpqiPI3rrNbPEeQc45GzNBBs7d9rJ6F77Y847NfJRgJ5@vger.kernel.org
X-Gm-Message-State: AOJu0YwMzs8VDTU2DcNGA/J2GreiU/edF7e1TVbsMYi9M9VqGG2GG9+s
	0nWRmoUQBBmuKCfNpM61KY3G3gqTfGfDkdcNsI4JIeLFcSFwui7+3MQ0OZvYJ6FejHuO3u7rLdc
	/UYxlP4ISEwYS/+Jba0hDx41kgKdXw29cgQbz
X-Gm-Gg: ATEYQzx8x4GLU7siMePYYKSjZeQdZpR5+6Ym2Fc6PgPia42G5Y0gRVeX/Wy0bzm1cl6
	EVD90I/srGL/z78ExjR5aVRs0ZsdYihNROAUW0MdeWm6QtPUBKcreWwax2dhX0mKbGfukkwkEYd
	bOyw6y7UtnDRCAytJAkw8waa5RJyQ+4hgTdgmq729OUcsBfYrIyo0AyQlUC9FkaGcZopnbjrKnu
	AuZl/Z4lGiBDEst8in54LJi8WAqPvQSOSUmYW2da3wrc/76uUH2AILSOguZKJNxINCqCRO8GKkX
	deJA7rc4
X-Received: by 2002:a05:6402:51d1:b0:658:d1b0:9970 with SMTP id
 4fb4d7f45d1cf-668c8f03bc5mr7850131a12.5.1774247756047; Sun, 22 Mar 2026
 23:35:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABR4S-vSW7qpvBfUrARtfgc91iF=PZPQNHvd0Xc=iiK=mx79vQ@mail.gmail.com>
 <b79abd77-9cf0-44da-8436-b6e4de0e8712@linux.alibaba.com>
In-Reply-To: <b79abd77-9cf0-44da-8436-b6e4de0e8712@linux.alibaba.com>
From: Raghav <raghav.original@gmail.com>
Date: Mon, 23 Mar 2026 12:05:44 +0530
X-Gm-Features: AQROBzBXsodMCKTXy-a8LisxaQyoGE9Zuu2vvBy8Bws1PLLyfdH5ZS1-GCIUUr4
Message-ID: <CABR4S-v_JgdN00E0kZPb04zanBb3ZMv2KJoHm1tbBi3CHBapSg@mail.gmail.com>
Subject: Re: [RFC] FUSE: support for file_flags and birthtime (FreeBSD use case)
To: Jingbo Xu <jefflexu@linux.alibaba.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jingbo,

Thanks, I=E2=80=99ll look into FUSE_STATX.

for file flags (chflags), I don=E2=80=99t see an equivalent in the current
FUSE protocol. Do you think we could extend the protocol to support
file flags?

On Sat, Mar 21, 2026 at 11:30=E2=80=AFAM Jingbo Xu <jefflexu@linux.alibaba.=
com> wrote:
>
>
>
> On 3/20/26 5:06 PM, Raghav wrote:
> > Hi all,
> >
> > I=E2=80=99m a new contributor working on improving fusefs in FreeBSD, a=
nd I'm
> > bringing up an issue in FUSEFS.
> >
> > FreeBSD supports file flags modification with chflags(2) and file
> > creation time (st_birthtime) at the VFS level. But, these are not
> > currently supported by the FUSE protocol.
> > As a result, fusefs on FreeBSD cannot expose or preserve these attribut=
es.
> >
> > I think we need to append struct fuse_attr with:
> > uint32_t file_flags;
> > uint64_t birthtime;
> > uint32_t birthtimensec;
> > Handling them in a backward compatible way.
> >
> > Is extending fuse_attr in this way acceptable? If so, I=E2=80=99d be ha=
ppy to
> > make the changes and follow up with a patch.
> >
>
> FUSE supports statx(2) with FUSE_STATX, which exposes btime.
>
> --
> Thanks,
> Jingbo
>
