Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D22918AFE
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 00:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779408062; cv=pass; b=UlOv9MD1kOsZVQK0k0EFupgkznkFRCgeCq3tRSDPsmxJ1LH+qB91NPOI4q+OEHIL98cxGIhHoBasWRBUSaDJHvYI0FOH7jkcDE9TNVvh19WzrIw7mM7KYpy9X8L32a9H6yl+nZ4OxtYsZBjMEERxTPTTzE7wwgPwHI/0X42vIGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779408062; c=relaxed/simple;
	bh=4XmGzPexBuzllRYV18s42zoCl8P8CCj2taA8kI7RRmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iTbIjdQ9rR6++xpVzezmNe9PTA06CndtyyGDUGUpFHrQp1YEo7MnFtmTmOowalSQCjfdRUmMGilF/XcAlDcrz9qpIq39LpX5v61h2w7e/jfSzI9MULegBP98qvbGT/2KmG7oH/59gzllTtW1aZYi91Nc+bR+kDHVzXjbvpDbxdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAauro1M; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAauro1M"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a8891febd2so9281843e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 17:01:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779408060; cv=none;
        d=google.com; s=arc-20240605;
        b=Sr2bOShv2QGDcaxzy2X7bz3n3W/1uqLXY1mkwMnQY51w9I/L4cecO52nwjtETK4H8W
         2+ADsIiSAMmQ4dI8e0jQLadCt5Gz7MzPhLaXk3Gmtvp3eKr8SKfkgcFLF8xXjINHk0aC
         M9sNl2Kte2+XyxqRTcxM5MISIvD9tz63IPbnbcU6/CFKNEdOOxaSTiKgXLCmi7xavntE
         KSdzKszoiUtF5L+apoMRpav30/w5Z1V8c+wYfZuWfcxG82V1Hac1vuRAS9hQevPJAqA9
         /ddLH9HgnKnP9Fzyh4jZYUM5ggqv72341Qo/0d5BD0/PrjecGGfy8y4V0m4T2Ov9aq0q
         jC/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ll7i4mKIat2FgR79pcZoIpXXLsiTRxn2XLBDjZZZs8U=;
        fh=OZCtphWlppWZK5iZBL7OHoLbv9rAirff7F9HhtDVZzY=;
        b=G66Ua2Z1ebL8ZW6N0Rr//8RlDnqvRAP13zkVgHx84QjOP0tqHhaa9MfrEcujkDnVMZ
         7WzH78XJYWZCCxLH2V4+PBylliS69BXaK9qM3vFz5Nq9iVsEnlPVYafzgbsyTXseHqei
         gTFqieHC41cgk7LXyo/f0K03vRTabORZu/CFvK83itwjbvIRqH17snQb+r64qfM4HMKd
         8ZaOyefRlz5wFqwEiUbhIBvC6PLk5H/Z+GKJ5CIIj3epdgiqaW4Lx3LVlEPPzFwX1UqB
         6SDVYRwAbkipV02rl/DwKfPyu2VAvC7gB5S3FEm+8BlzzvlZEJWOYrS8WgRe3QVeEVZD
         vxfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779408060; x=1780012860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ll7i4mKIat2FgR79pcZoIpXXLsiTRxn2XLBDjZZZs8U=;
        b=YAauro1MUsLvx0gnVtmQsau51WOEThW5A7qpB8//Bay/JUrLyfevBvDEA8Z+l3+4PG
         opzDHenaV+BAFrkQecZy9i9+JhZrDvueeSsnvM+EdBRmExJU9aPmfwil8Ep43nffHvCW
         xtuL2+uIx2MIUHN9IVSUUtUYHkU+j4R8B0rtc4BFIHOLb7b8dhQK4MGsksxNbVNMiYPb
         PERHbfVjLjOYNTDfjSSt2bH5S5nju3OyOwpnsQApr3+wzVvhfJKzQ/azAbjkZikcsQKB
         YYEZGYOhTQ8qcvdZCx0ZK9x3RHQQJMu31wEQhHpig6ScWI0CBaaS1/Z/af2nRcCs8cwz
         wnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779408060; x=1780012860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ll7i4mKIat2FgR79pcZoIpXXLsiTRxn2XLBDjZZZs8U=;
        b=pwUql9PJDO+uPjm7PAeAvBRT4ivoLEXqvjIp6SGMg8w6dNax8HUjkTuyq/NRt5PGwV
         HS1EVMc9C7ER/5Obl4TUrVeFzF6bHoIPoh8DrtWWJhQacxnw58zjC+nnWZGMmQwi4gu3
         xNgpLcP/1Icgd7hq+Xkn/JBhobkB3OFmFGPQv+gUIsVWqlHMBz4c+oRugaEz1GuXUm9a
         3o/5dV+O17vsMwHy4Q+2rtGaVYVlEYrYHVV84UoWu3yU8XYINNBvbxL0m2QkQt5Tf5yM
         9mZKhUz/aThH/6nQHHW3D9IhN/DH//7Ldu7uAwQJixGu/5l4dBM5hP77xYL5YZFZ+dFo
         wm3A==
X-Forwarded-Encrypted: i=1; AFNElJ8+cbTHr24bawIcuuRhW1qoHI5et+SS/oV4KGThk1BwKOFSquxrumLkjcyacsxHqTAcfqU6ML7Tmf5dGbEx@vger.kernel.org
X-Gm-Message-State: AOJu0Yz745rPuU9grVsEjiWrVvb4lxg0o7PfopeywhxIWxGVfwPw5c2O
	1GZFf2uLisrEXQ+bPTAL0qIevK+29IQKOTlCguxvIE4AxuZU6r+D2JuQwScZMeD8YkNb9Sv+v2W
	WqnnT6wJGhJJoaEMhmOARwq6ejHHCwJc=
X-Gm-Gg: Acq92OEsIczu6JEDLfOqm2d+DmxR6XtGMQW+FcwDj9Zo51Ce6ofl155oKcKTP/ftvSE
	fwwEvmCO3ybEVK3lC2sskwgF2OoBeCm3iTITwheY6S/Qt58w77eqINwTCgxadJLPWLV0aWSHh1m
	sY9s8dNfKZMRtsuRmuXCd7k/UESjOC7SmL7CIri54lh4YrjfWcMYMYUoWRGZOhgOOqMzYzzzD2M
	Rkri4M1hZXeaf4WotGxJj9NSsgLReYPnvf7AZ4jeEKko28aPmSmVT0jFHmqihfjx2+BNtYwGYzr
	p+aMPec=
X-Received: by 2002:a05:6512:38c5:b0:5a8:fb56:e322 with SMTP id
 2adb3069b0e04-5aa323cd973mr177798e87.36.1779408059524; Thu, 21 May 2026
 17:00:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520170151.4115308-1-charsyam@gmail.com> <20260521101751.591345-1-charsyam@gmail.com>
 <20260521101751.591345-3-charsyam@gmail.com>
In-Reply-To: <20260521101751.591345-3-charsyam@gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Fri, 22 May 2026 09:00:47 +0900
X-Gm-Features: AVHnY4JuujtU54I4rIf09S23UJ38snG0bIm6fon4DK_tbppQ34344qSggr1kH0k
Message-ID: <CANFS6bYVMzKP2uBV=-XMJ4JHyoBNfzqHDAteZ_8gj4t_C3e7xg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ntfs: avoid heap allocation for free-cluster
 readahead state
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 5=EC=9B=94 21=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 7:18, D=
aeMyung Kang <charsyam@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> get_nr_free_clusters() is run from the precalc_free_clusters() worker
> queued at the end of ntfs_fill_super().  It is also the only place that
> publishes the result by atomic64_set(&vol->free_clusters, ...), sets
> NVolSetFreeClusterKnown(), and wakes vol->free_waitq.
>
> The function currently allocates a temporary file_ra_state with
> kzalloc() before that publication happens.  If the allocation fails,
> get_nr_free_clusters() returns 0 without setting NVolFreeClusterKnown()
> or waking vol->free_waitq, so callers that wait for the free count can
> block forever.
>
> The readahead state is only used synchronously while scanning the bitmap
> and struct file_ra_state is small.  Keep it on the stack and pass it to
> the readahead helper by address, eliminating the early allocation
> failure path.  Zero-initialize the on-stack state because
> file_ra_state_init() only sets ra_pages and prev_pos.
>
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
> ---
>  fs/ntfs/super.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
> index 7e3561265b47..14fd244f29fe 100644
> --- a/fs/ntfs/super.c
> +++ b/fs/ntfs/super.c
> @@ -1954,7 +1954,7 @@ s64 get_nr_free_clusters(struct ntfs_volume *vol)
>         struct address_space *mapping =3D vol->lcnbmp_ino->i_mapping;
>         struct folio *folio;
>         pgoff_t index, max_index;
> -       struct file_ra_state *ra;
> +       struct file_ra_state ra =3D {};
>
>         ntfs_debug("Entering.");
>         /* Serialize accesses to the cluster bitmap. */
> @@ -1962,11 +1962,7 @@ s64 get_nr_free_clusters(struct ntfs_volume *vol)
>         if (NVolFreeClusterKnown(vol))
>                 return atomic64_read(&vol->free_clusters);
>
> -       ra =3D kzalloc(sizeof(*ra), GFP_NOFS);
> -       if (!ra)
> -               return 0;
> -
> -       file_ra_state_init(ra, mapping);
> +       file_ra_state_init(&ra, mapping);
>
>         /*
>          * Convert the number of bits into bytes rounded up, then convert=
 into
> @@ -1985,7 +1981,7 @@ s64 get_nr_free_clusters(struct ntfs_volume *vol)
>                  * Get folio from page cache, getting it from backing sto=
re
>                  * if necessary, and increment the use count.
>                  */
> -               folio =3D ntfs_get_locked_folio(mapping, index, max_index=
, ra);
> +               folio =3D ntfs_get_locked_folio(mapping, index, max_index=
, &ra);

This line modifies the __get_nr_free_mft_records function, not the
get_nr_free_clusters function.
Therefore the patch needs to be rebased on ntfs-next branch at
git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/ntfs.git.

>
>                 /* Ignore pages which errored synchronously. */
>                 if (IS_ERR(folio)) {
> @@ -2024,7 +2020,6 @@ s64 get_nr_free_clusters(struct ntfs_volume *vol)
>         else
>                 atomic64_set(&vol->free_clusters, nr_free);
>
> -       kfree(ra);
>         NVolSetFreeClusterKnown(vol);
>         wake_up_all(&vol->free_waitq);
>         ntfs_debug("Exiting.");
> --
> 2.43.0
>


--=20
Thanks,
Hyunchul
