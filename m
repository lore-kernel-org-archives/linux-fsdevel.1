Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057B5299927
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 01:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779325451; cv=pass; b=jTrDkEmW+liqSZ07eHix2Um0fboYotPhlzuweEbGGDjlkHFwVQi5YoPoUGD2n3gZQLFEa2SjXfgne81MHEhGK+RTnb1TV9H5TQqWOJ22qxtPZEJfU6P+cSdMyEZwYklA2Ytd3yh6SaDVqdNT9zI2rmQPoWX0dPyT+0NdJY1gH0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779325451; c=relaxed/simple;
	bh=4kTJlINAcMYOKwMpj31qms1av/mGIj5S+EV88UKsRgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=izsBuVTJknPiUM3Yvsy4R77H7uodNZI3OXnbFntQe/xw4k4hR2xpU/IB1wNsHkWvWZSVnPPmnehb8mEVxFz0bZ+hF8ClPYgPcuUmqzIC3+cSRl210kxFnoQO52elxulmibLKht63F3MTrSlPHSOEGDk3SVYQ4S8TCitSXbJF54Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MS7N1SC+; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MS7N1SC+"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aa2c25c632so43461e87.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 18:04:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779325448; cv=none;
        d=google.com; s=arc-20240605;
        b=Kv2c7hfxf1m0Go2tbaJduw6qWM54MCADhgTlZY8UIahdcpgtCPRCJhfovsBoIifkBa
         6ADV01GeSoIa0S0Q8vJcSIR70noWNj14dHZIEkdgZ3jG6flYwI9S/FIyLFl7QyNLBo99
         i6dZtBrcNheDCDVCVH83uQDQOivPHhyGxDhhu5wF79nW9NIEoTvcIxt507x1NoltkY26
         kw57nwmnrvLlGTwT9a1Ntb+O20Zne2LxI3CnKGFuXaO2bAagvWioSzYhQCYVi4WWDgjl
         Y+i5zhzrjdM9IY4L4U8PiucKfmqPtVxgNDrrJeaeu0cklp3Rge79KGyLJGoX6+zjYanP
         9rxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J0RobRJ33YJC+WPKVjdnZAPW8gJJJqyvXSulgnPHcCM=;
        fh=OpT3QgRjdJKTZC7w7rNSfdcqld+nqPea27SGlz7Fe10=;
        b=bE/rFf+MnJ7kM41Myi3UwYb4EL6q3z1OTbR9k4jXPtEu8W6IfsL0cJUBFSSkXfs/rD
         7T9H9ldivVVJo/TjEXJy5izQ8on+JDBy+q4SvsvMxb/54g8sl8k475O1GZyv1G9bqgR2
         jyRsCTvYdIbYad62dFTboqe3jHJYegUmnnB4ZV+BvYqTQ5QoMMWhVMh79peP7Ks5X7QK
         r3Vg6EkCCwOgVheRINR4Fnb/6aWUopg0uxWILb1yrelejaRK7OqSIj9Ol7rL2ySauhde
         huy8ad4IB07FnKQJgE3qijSvCleYNParyeAchQrs1pc0gsGtcImgWPMykiJKktQih9vt
         qFeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779325448; x=1779930248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0RobRJ33YJC+WPKVjdnZAPW8gJJJqyvXSulgnPHcCM=;
        b=MS7N1SC+WgXxUJP3CFTA/d/TdjhnXxUJwkjW8KJfRh1fXZiWJi9RMD6Tl72250m0Bc
         DHCuDFpWGYpDc7PxJSklDUDAPBZPwUNKvzZnPQaTY7ExlJHNEiTFY0mdq6Bg69xT6veK
         dpZFGh1+S3GJLWLKIrHOTslzkxH9kYEfSA4walsA5ouSiOhEKlKVqhZkMy1fZra6wXFM
         NwQqRosS+21fPeBf60pVzOoI8TzSTBzRowOicJhAtpzPUv5TkB/4GtwlB83j5INcw8KW
         ExrmOGgTE0cNOZjJDfBcRifTwvlzmz2xKw8pTYWfMkgcCj9+RKLzxwylsiJybjSBMCy1
         f9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779325448; x=1779930248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J0RobRJ33YJC+WPKVjdnZAPW8gJJJqyvXSulgnPHcCM=;
        b=pdY7EVM+DX3x7rJvuq7PRfrnNQtbPDnvp/tSX3cpkrYme/Re9kUJfqtwxu6el2h3rn
         yD4z8WvpEFHLQAfrKqaCm6QjmB73W+AGttyUx2mR7OpE34rpE/e/hx87B3Lc1E5wEUJA
         vo7VwVDtXTLGatVoWdjUXXUlZhA4xSdxheMMcqZ8ON97/i0fBh1fwcq9BebpxtY/AOXG
         SX/0+MyDK47wV8l3M3Jsd4CLzg+CqdMmeo7wyY80i/OT7nXZwZVzK2FDbyWsMxpOTEbE
         f+Xp+t9u1qBvIy2wDSWS59BN3bkIkYinGT2tQBHUHXviWB82uC69SNmI0erne6cef6ui
         ecqg==
X-Forwarded-Encrypted: i=1; AFNElJ/0AYi7+/8E49yorGa5p/sKj64A3dycdItF12oniAa92+oqBOE7lXz+jQ7GPcrykkH5ZrezuAYsz2krpxgT@vger.kernel.org
X-Gm-Message-State: AOJu0YwGGLrT6upM5e7uLRaC/gRbzpC253Beh0e7ceKxmbxhKv3DhtRp
	OtcFsl+EHtZPYtbZZqwA1Hzr4oc5F1u9kBSdQlHsAEUrzYiJfSyubiGd80RYPOTqOEXdSvM96l2
	khiEQmsefJxu2Q81RACvpyle/GRHq9eo=
X-Gm-Gg: Acq92OFej9DpgnVUt9eIR/DYGQWIdjkZ2T8gMH4YlH71ynbToerXf7ZhUwxfqb4kYpB
	uh8wMJrnW8XMoKVw5aV6eJ2cvnfdkrzghmW9pU3I83IJCrXnCwKrKuzBKBci3W9p4RObQHQ73/t
	J6EIlHEN/mKKBFIAAWVy5DK0UWFiFfkR6XvS4zoB1uNqaqyx7WKDU6694d9TUgCjljM2fDfhnbt
	58LC0MrqYtRCb9ovlq2ixwQz/xg9Mbz/FToXTfL/V2fy1BQI8EHJ2xe9DkqMaYGIGpA6nmt783N
	s7phkRyDuxCNP9PTvQ==
X-Received: by 2002:a05:6512:114b:b0:5aa:b6a:7a8d with SMTP id
 2adb3069b0e04-5aa2baa217dmr277964e87.44.1779325448153; Wed, 20 May 2026
 18:04:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520170151.4115308-1-charsyam@gmail.com> <20260520170151.4115308-3-charsyam@gmail.com>
In-Reply-To: <20260520170151.4115308-3-charsyam@gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Thu, 21 May 2026 10:03:56 +0900
X-Gm-Features: AVHnY4L4-vCYJkV39sqHrbHfV8qP3PzY_qjH3OOMR1OFseO1LtrTAkTg3e8edl4
Message-ID: <CANFS6baYgJ3PNLaQ5vkobwfUme_mRf26WbjmSK49HeoWdBpVsw@mail.gmail.com>
Subject: Re: [PATCH 2/3] ntfs: wake free-cluster waiters when precalc
 allocation fails
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 5=EC=9B=94 21=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 2:02, D=
aeMyung Kang <charsyam@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> get_nr_free_clusters() is run from the precalc_free_clusters() worker
> queued at the end of ntfs_fill_super().  It is also the only place that
> publishes the result by atomic64_set(&vol->free_clusters, ...), sets
> NVolSetFreeClusterKnown(), and wakes vol->free_waitq.
>
> The initial kzalloc(sizeof(*ra), ...) can fail before that publication
> happens.  Callers that need the free count wait on NVolFreeClusterKnown()=
,
> so this failure can leave statfs, write, and allocation paths blocked
> forever.
>
> On the OOM path, publish a conservative free count of zero, initialize
> the per-bitmap-page free counters to zero, set NVolFreeClusterKnown, and
> wake the wait queue so callers fail with -ENOSPC rather than block
> forever.
>
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
> ---
>  super.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/super.c b/super.c
> index 6cf09bbe017d..c90cb5673f98 100644
> --- a/super.c
> +++ b/super.c
> @@ -1980,8 +1980,23 @@ s64 get_nr_free_clusters(struct ntfs_volume *vol)
>                 return atomic64_read(&vol->free_clusters);
>
>         ra =3D kzalloc(sizeof(*ra), GFP_NOFS);
> -       if (!ra)

How about declaring ra as a stack variable?

> +       if (!ra) {
> +               max_index =3D (((vol->nr_clusters + 7) >> 3) +
> +                               PAGE_SIZE - 1) >> PAGE_SHIFT;
> +
> +               /*
> +                * Publish a conservative free count and wake any waiters=
; the
> +                * NVolFreeClusterKnown flag is the sole signal the wait_=
event
> +                * loops in statfs/allocation paths use, so failing to se=
t it
> +                * here would leave those callers blocked forever.
> +                */
> +               memset(vol->lcn_empty_bits_per_page, 0,
> +                      max_index * sizeof(*vol->lcn_empty_bits_per_page))=
;
> +               atomic64_set(&vol->free_clusters, 0);
> +               NVolSetFreeClusterKnown(vol);
> +               wake_up_all(&vol->free_waitq);
>                 return 0;
> +       }
>
>         file_ra_state_init(ra, mapping);
>
> --
> 2.43.0
>


--
Thanks,
Hyunchul
