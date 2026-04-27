Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AD925776
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 00:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777248673; cv=pass; b=qHzBF3f91ll1Ta5p7LHDPeT9L7nhALAs0d0wdzuGfhxJKz7WCUYOQpGU51Fi/JmUwOyUS4BpHljal4NCPmLXPmqbrgL04ADj7XBS6V+VUYD2FAvHtZ1Y2qwiqaI4BRex9hh/A+BxYWxIy3megrvNY2mBbl5faHTdTlunKCDvGnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777248673; c=relaxed/simple;
	bh=wIKuMzHeBfCzt70ovbG++ajtRCh6tv8NB6mFqqL7EBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rQ3eROsGPvHIdPr/PNWQzrBl5vHxoFG94snggnSTzIv6OiJtJKOo8FmcrB2FgWU5ANVql/1OR7zJ+msezIVFQDoG5Dyww/T1ESkF0EHIZBkolW3oAvaASgXPhmeAkl7Mld1C54gZTxIV73Pnx0W43yjlfNbT8C0QH394MfUrWQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4US47rv; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4US47rv"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a40b2bc96dso11202112e87.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2026 17:11:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777248670; cv=none;
        d=google.com; s=arc-20240605;
        b=axQENiLRtD/0Cn+aqwaXLjjCuHPKne/F4Bp6kWtmvEo4EOT9X+wUwQXsOEC/giw6YG
         PVu5wjHiDhsI1iK3qBS5Bg6Vbg0VIqXKXi5ukXt1sA4RRrfT4eFm7OE1T02tmf9t0D/m
         l7Scjko4rcZ/VP08fiZz4AqYdBLGboObuEpaNz64UbbOuASBirz3G5wIu5EZdaDhobZg
         DmYWFCpfnpp7muUlaSxwVUsdnmmELT+GelSZo4S2/K+Tj8CYR0CG/uyKCYigyRoPggyx
         SrfBCYTzRc47NyXYoqZgl4FnWH0OA3muI/pchtv7Y+3lFBWPrUmvziOTbIs8BBAujj1p
         6g7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eRC2JslG73FK7QhfhRfHpLp/Q557OQnLn32NMzTDYOQ=;
        fh=o0pjv++B4tlanFtPf66AdYzMG+HllGIbWL+VETLum38=;
        b=DGVTiNMXBDq8k7sbCnj8+LHB3tvjy0gCYIBtSKQO733DM6ELgZ0j1mAJ3cRgsnQERA
         tuvUodP7SLM4gex/u2NT64WE2oLHXiu6vfois5kN/TWN1AcvUPhQrE5akhzcOTbs7E2i
         g2idXdXD7rJ6K42DPyIg5Q6tKAPeGLS3h2tSV/an42YbSMzfos9THI+K//6oSHO0E4gQ
         iS+0UfvNfmTEYD8VWNQ3tqF+ShZojr0a0/km1LB6HEGFp9063r7Y95aMBdCYF04gVI+m
         ek+RfTbhJl1DtPQw7Qq1/91OafVnnCF3jEomPdAgZFFlY8Ae9kIGnz2GrITUzVyCiVJC
         A7gQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777248670; x=1777853470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRC2JslG73FK7QhfhRfHpLp/Q557OQnLn32NMzTDYOQ=;
        b=S4US47rv7MgV40ym4hdqbJWcRjDdBwOqDrT259J8qxqChD5VUrxEoj2tUGGTuekjSi
         aILHda+JuPfioUJb50CM47ZvSGCNpEgdwae9mQW2BcpkHO8YI5DbgDsD91ltWDnpUGnQ
         kgzLWmIrELn/jSXoIkoZmBJ3i2eyj8HqV+QPsixeoa/zfMrwNm9kF8Ncv/X5M+Vqe+uK
         nL+5V+bsFzLqD6Kvgad7zh5fPD4ea0hWjmMys2VUH1Q6PMPMMOXE8H6QoAhwcjxe/Asu
         I4jQmwkopjzwlh7raCUBmebn7X7nd8TczFvSCyYwP3He+gZ7drxNaEOBvzdARfuT4ReS
         Sxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777248670; x=1777853470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eRC2JslG73FK7QhfhRfHpLp/Q557OQnLn32NMzTDYOQ=;
        b=sC0wMM0kKrUVYniXLM2y9Lw0D4N6+LChqaUX0W0fDwTxpNvutaN5Yy1dlhkhPR9SJi
         eu05h1k1XettIV5cP0HU9YbHT8LGwCp69EgAcc+1P/qtvFk6vOXhNjlrW3tUR64BjYZ4
         JiQGC+/FuWIw6G8feVxWBNz/aoOxwk2pbZlTeufMMJ2RL71dyg2iBvzKtC1CncFUvgMu
         IIhkpWxiArhwX775saafWlcri1Ukku7ei1WYbEiuzfDhTuOUsyljjZqp36FiBY/DsuDw
         ZfV9PlQ7JOYWshiC0HGSekQoy2cVbg+/O3KHCqBng5JhQ/qrblBM5frXEexFbH8rcbpH
         0uJw==
X-Forwarded-Encrypted: i=1; AFNElJ+OZ1zFxDU1/H+Spw1KV0jFOC56TuxK4y9jeeFPpbom9NRqexUhoacvvwOIySgxxVwgXUzcDw6IESrU5QnE@vger.kernel.org
X-Gm-Message-State: AOJu0YxnTAlwtw9Oachy7D3QUle+eeJrhLYU/r7DJ5mUY6cK2v0iIxcE
	zh2qXygrxaqT3D543r/R3FAP096HQA2a/l34M1b7yvrPkblOKkhesSAiD152QI0YZG2sSfJekE/
	XsxqsOVkcVHUZWvrTRAcKRKbLmXZJo0A=
X-Gm-Gg: AeBDies5FAAr6JEPsKE97wMqO1B4jVUXl/y/FJ5lTD7o4+qzHFosJYbU8jRzA2C5CTx
	p/zduhd/VplMefW40C+sKGskheThfJ8kw8DNwGXf6T8/D/h+vZ6Gkwa4XsPWWkIlFGHuiPuuWe7
	EFSd+uRcV7F26XSNfmqlV6f0ATQNIYc+JaesHFcTqo1FWyfHp6xZF04embhDF8QlGjQmsAaucbn
	hc0qOfo0XDJGqH0B731SxWSycRaReN8X/FWf9+LYUrnZzMHEwm/SDmVBG3HARi2YcwTx1aaFzCw
	3jDxu11cgOe7VU4A5Q==
X-Received: by 2002:a05:6512:2313:b0:5a2:c0c8:52bf with SMTP id
 2adb3069b0e04-5a4172c332amr11643855e87.10.1777248669966; Sun, 26 Apr 2026
 17:11:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777175371.git.charsyam@gmail.com> <e59d3bc4a15adbf6c227a0c62f81362aac8be383.1777175371.git.charsyam@gmail.com>
In-Reply-To: <e59d3bc4a15adbf6c227a0c62f81362aac8be383.1777175371.git.charsyam@gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Mon, 27 Apr 2026 09:10:57 +0900
X-Gm-Features: AVHnY4J1G9G-04PmflA0rr7tL8zFyxa86sCV8VVpKzmMPtsjqClC9Gr4nPK2iro
Message-ID: <CANFS6bZUCTmMJh1VbXyBd1RH_sjHcdg2Bj6uiVowS3d4R2TzGA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ntfs: fix WSL symlink target leak on reparse failure
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 4=EC=9B=94 26=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 1:02, D=
aeMyung Kang <charsyam@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> ntfs_reparse_set_wsl_symlink() converts the symlink target into an
> allocated NLS string and transfers ownership to ni->target only after
> ntfs_set_ntfs_reparse_data() succeeds. If setting the reparse data fails,
> the converted target is left unreferenced and leaks.
>
> Free the converted target on the reparse update failure path. Use kfree()
> for the other local failure path as well, matching the ntfs_ucstonls()
> allocation contract.
>
> Fixes: fc053f05ca28 ("ntfs: add reparse and ea operations")
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
>  fs/ntfs/reparse.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ntfs/reparse.c b/fs/ntfs/reparse.c
> index 8f60ec6f66c1..74713716813f 100644
> --- a/fs/ntfs/reparse.c
> +++ b/fs/ntfs/reparse.c
> @@ -505,7 +505,6 @@ int ntfs_reparse_set_wsl_symlink(struct ntfs_inode *n=
i,
>         struct reparse_point *reparse;
>         struct wsl_link_reparse_data *data;
>
> -       utarget =3D (char *)NULL;
>         len =3D ntfs_ucstonls(ni->vol, target, target_len, &utarget, 0);
>         if (len <=3D 0)
>                 return -EINVAL;
> @@ -514,7 +513,7 @@ int ntfs_reparse_set_wsl_symlink(struct ntfs_inode *n=
i,
>         reparse =3D kvzalloc(reparse_len, GFP_NOFS);
>         if (!reparse) {
>                 err =3D -ENOMEM;
> -               kvfree(utarget);
> +               kfree(utarget);
>         } else {
>                 data =3D (struct wsl_link_reparse_data *)reparse->reparse=
_data;
>                 reparse->reparse_tag =3D IO_REPARSE_TAG_LX_SYMLINK;
> @@ -528,6 +527,8 @@ int ntfs_reparse_set_wsl_symlink(struct ntfs_inode *n=
i,
>                 kvfree(reparse);
>                 if (!err)
>                         ni->target =3D utarget;
> +               else
> +                       kfree(utarget);
>         }
>         return err;
>  }
> --
> 2.43.0
>


--=20
Thanks,
Hyunchul
