Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0242B37E314
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 23:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776902252; cv=pass; b=Qjc1+NpYKH514De7YUYYNgwgS0r3V9vEvT2z9kYfIFqlhixP353RtP2adCgandU1tv+nn8Qg0G9wg1WEBnkeolB1/4oz+BT028wi4dzEOoBTJpy0lRLnaL85Nf4EtIHog8jvstagpO91+en8JJC32kt/xbwHZOrtyClPTLeK4cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776902252; c=relaxed/simple;
	bh=zSelJba013/LeUm+1WTIOwf/Kq/3usipc4ByyYze3uY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zm71X6tgDWIW0/chJ3C/ehIumwCL871hwUr80bo/J+cxkjsAa/oOa+TjiZB4KpBCbwWrFpnKnjASUeFEVo8hR+v4Vb7yGEbDvx982gflXt7zmkJnnyYAPUW9GHfMmyuXmT1AKAbkxlZ+VXbN1Yl5iWs4k0vO+nQf40avBMsO5Ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhReD3PW; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhReD3PW"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38e800deae4so50878141fa.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 16:57:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776902249; cv=none;
        d=google.com; s=arc-20240605;
        b=RJIP1PpwvIt6L9Ufp0NTvbXTBWPpviYfvdV1SdoPlZQWyQkCV0fvLESKsa/5ROYcaP
         cXLa7MqMUN63SfSXPZrpGKFALDb/tl+0clnjdh5vW8dJIo8p1V8Ts3hWeK/zWu3hTBgg
         hE5kbh/6o2Jqdo7FD6hVJFNY69WWgEXVoV6ulMPLJBEKwujj0Z5PUYLXH2q8ZCMEEGnX
         PUGEEkep/0nkz3/g56BrRS2Z8yTaK0NbWt0SLF51OvR+gcl45EvcvdYkEBF9VXaQWYak
         B6f5sn95YKWnE9zF1F6Znc+tp2Ec1LdJE80TPTvYSSFdlNyPvsqQGZ9n9YVJ2APN28gt
         iYCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BHnuZiaUwM6csQC1PiZuhYHpb1+v+59oA9r0wwRU46Y=;
        fh=rhu6CrPHy+yHGDZJdU0/xvSgtPzh6mHbGvWXvn4Fvek=;
        b=QhS8H+ExvPIzh4dP93aKmR0i38a9C5trgsJVbo8gqHaV1cgAjHmywK8cCBHLiKuT35
         /nrSFyAZcQec2Yfp07dbxNRh0tIbXhkO9ZatBBrKFeqcT71fcEHt5NlB2mvPgfAsmSiN
         WGXmYdQvaQMtc4C9/h3rwKxsq6tRk2tx11f02j1GV+KorqyL4qW08/LlVtbOyJe98CDT
         sgs3JlRc+egR/jXFZ1yub9Ii2aU+NYgFkDfvkjo+wxRA0ztdPM7p1x+vwGmJIyUdS1wi
         H47dmp8/gugnZ6Jg6XphWU60vPaW2JnxVLbGJk230BGzhyaugjBuq0QsCVIBT1XtLaXg
         G2nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776902249; x=1777507049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHnuZiaUwM6csQC1PiZuhYHpb1+v+59oA9r0wwRU46Y=;
        b=GhReD3PWk5cML8zJt52WCySHyyarl3NjLOYqN7i4F47hjOxaF/nCWyviwaBV2YAkAw
         h+fEI+fhhzEkdWmhytZEGy7tWYnR5Y0GnToTOLJlBjBHkmMNaJvUNKSVQU+k10b0wNCa
         g4LrsgQHP7wyrnL+Syc0fXvvNo2RwrFdIakdPjMRH4MQ9gQYZUKoGhaqwLm37WiD8vMz
         eGLuhqpWGGl2wth9Fpb0YTUYMz7Z6F8HTAwL/YHoyY0/caGDZBsowL1u9SjNC3lIbuMe
         s6ghEOU+XmNkFmpkwPyCqE/JqB9wCnhzvS6KXI60J2fAxpR3hwYtZ3n3jG09UUrc6CTl
         DB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776902249; x=1777507049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BHnuZiaUwM6csQC1PiZuhYHpb1+v+59oA9r0wwRU46Y=;
        b=Oc0e7BwRSS5YReCyAKWbvqz2X2v168Kgpq6DAUroIebmwgWgzlvUpSQqmx5Jud22qd
         RuOTRJb4RPcoaqsusvadlUyWjn2dT3Lt0RbNuoZafqXWi1tzvAR9+S8/4Idk7ZsqI9uy
         e7lB7kwuo89HseilwY1zWZgwpH357bY3FQrxoD4VDhv+tQNAfaEiP9VcRI03Mew+FKkN
         aNPqV3WXUF/kmZCG/2xXC5WFRYVg2eSSZExfaRs3JN6KBOAFQ+4lRXTIP9o9RviYtUbD
         Ls/cgjVGC9hzFtgSkfVLbPQHFP8x5vF6i+0of9UnOGnQXHHBgSskuqH3Ick8ighFFN0C
         8L8g==
X-Gm-Message-State: AOJu0YxL0m7ZDGEh7IDtg6rSPY9/vpLlPNLkGSpzhpoPoR8/iEv/TR9r
	yxwKGlFzLKnPWmDJr5sGRqTRJQG2anfP6vCwT8faleV71CZXhQFn6EVFLc/m7X8hjpQWVP0elFx
	HYpAQyVzz8Dlu4j44mnr4ef8PsuamTJQ=
X-Gm-Gg: AeBDievO5qj/OO8mFfF/gKSHyTa4rjV7spm7miT83ULUEqgyC8ED0rn8HRuXu2l80Bd
	Cv08yzizXmcvJMgUNwT6z7S4PzkAqTnxAvopcmSa/WIufmlgcXV5FGk/AmDEKnfqyy9FHa0jn+w
	jFn2lB+6OLFJamEyPGUBLc5nkjJS+5fX4sb3sLCW91zgIStFUUUEzwfwf9RkFdvXvWDjkj9/nnD
	dV/IP10+10gGUHTEFNZ/BB5Rse5lvfWtvWtcFwnyy2FPo69WimmT5B7On5ZlMBFzGvnal/wh2CQ
	CRf14het0hLLjRrfmQ==
X-Received: by 2002:a05:6512:3d25:b0:5a3:6d02:846e with SMTP id
 2adb3069b0e04-5a4172e2d4amr8248205e87.36.1776902248613; Wed, 22 Apr 2026
 16:57:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANFS6bY5KfZ34dAw8StDnXkrr59r883ETB2enZr++Ny++B6H=g@mail.gmail.com>
 <20260422094737.194069-1-zhanxusheng@xiaomi.com>
In-Reply-To: <20260422094737.194069-1-zhanxusheng@xiaomi.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Thu, 23 Apr 2026 08:57:16 +0900
X-Gm-Features: AQROBzDo8zse9uHCvKnHiDXsp462-F3pH042g-7UGXyMf-TWZiXrzFTJFyNy0SQ
Message-ID: <CANFS6bYt4Byg=iqEmVV0ruLKgaBoPHotis-r4=PAwvYwkp8=TQ@mail.gmail.com>
Subject: Re: [PATCH v2] ntfs: fix VCN overflow in ntfs_mapping_pairs_decompress()
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zhan Xusheng <zhanxusheng@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 4=EC=9B=94 22=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 6:47, Z=
han Xusheng <zhanxusheng1024@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
> In ntfs_mapping_pairs_decompress(), lowest_vcn is read from
> on-disk metadata and used as the initial vcn without validation.
> A malformed value can introduce an invalid (e.g. negative) vcn,
> corrupting the runlist from the start.
>
> Additionally, the accumulation
>     vcn +=3D deltaxcn
>
> does not check for s64 overflow. A crafted mapping pairs array
> can wrap vcn to a negative value, breaking the monotonically-
> increasing invariant relied upon by ntfs_rl_vcn_to_lcn() and
> related helpers.
>
> Fix this by validating lowest_vcn and using check_add_overflow()
> for vcn accumulation.
>
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> ---
> v2:
>  - Validate lowest_vcn from on-disk metadata
>  - Use check_add_overflow() for vcn accumulation
> ---
>  fs/ntfs/runlist.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
> index b213b4976d2b..ee68258ebffb 100644
> --- a/fs/ntfs/runlist.c
> +++ b/fs/ntfs/runlist.c
> @@ -749,6 +749,12 @@ struct runlist_element *ntfs_mapping_pairs_decompres=
s(const struct ntfs_volume *
>  #endif
>         /* Start at vcn =3D lowest_vcn and lcn 0. */
>         vcn =3D le64_to_cpu(attr->data.non_resident.lowest_vcn);
> +       /* Validate lowest_vcn from on-disk metadata to ensure it is sane=
. */
> +       if (unlikely(vcn < 0)) {
> +               ntfs_error(vol->sb, "Invalid lowest_vcn in mapping pairs.=
");
> +               goto err_out;
> +       }

How about using overflows_type() ?
And please include <linux/overflow.h>.

> +
>         lcn =3D 0;
>         /* Get start of the mapping pairs array. */
>         buf =3D (u8 *)attr +
> @@ -823,8 +829,17 @@ struct runlist_element *ntfs_mapping_pairs_decompres=
s(const struct ntfs_volume *
>                  * element.
>                  */
>                 rl[rlpos].length =3D deltaxcn;
> -               /* Increment the current vcn by the current run length. *=
/
> -               vcn +=3D deltaxcn;
> +               /*
> +                * Increment the current vcn by the current run length.
> +                * Guard against s64 overflow from a crafted mapping
> +                * pairs array to preserve the monotonically-increasing
> +                * vcn invariant.
> +                */
> +               if (unlikely(check_add_overflow(vcn, deltaxcn, &vcn))) {
> +                       ntfs_error(vol->sb, "VCN overflow in mapping pair=
s array.");
> +                       goto err_out;
> +               }
> +
>                 /*
>                  * There might be no lcn change at all, as is the case fo=
r
>                  * sparse clusters on NTFS 3.0+, in which case we set the=
 lcn
> --
> 2.43.0
>


--=20
Thanks,
Hyunchul
