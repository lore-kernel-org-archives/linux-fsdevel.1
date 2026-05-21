Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1294614A619
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 01:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779325424; cv=pass; b=AiD8OaqlfIvS2brDaForIF40C09N8QiJE3smaHWQ70Keq2QyUhbq04PZ53FCnmVPiA8a772roB+RtpJWsWO3MLPJo/W0fvVKwM4j7YWgbfdhEUdOL/j2l09QtQxlrHqp+AUUIR0PgZBTzoOBCmEI5D6n/NMoZH6892UYYEc/wBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779325424; c=relaxed/simple;
	bh=2llAZbtZc+IwHbVzpzuoA1BbHCNtPv6/nu3+rjjOQ+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SvLcp1Omb6qD15r4AI7UG+kG2cRJVQ2phQEZmbLKVwdV7536VBmHlKwAau2kIScIKcULcp8kjjGPiyaxTXdxUQ9NoTIah8cSAfaO3axKRSec75mmGsoLgI8VlKO/YJWS4c6FiqHy/yZyOw6qBAb5/V3mzK3AWOWGLcxu+t/t3eA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BK6OKpIi; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BK6OKpIi"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a87782588cso7057208e87.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 18:03:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779325421; cv=none;
        d=google.com; s=arc-20240605;
        b=aP5SXaJHF/cUfazm9ocpFMAm5/Hn9epYd+cIkpKDHtyiVR65fIk/E4TSPdeQFT9SEj
         j650Yz37jvgGN9Ex3A1rjtRI7csSuKWZnO8QI186Hmx2U2gUBevH9I2oIQ0j2vWBRkIz
         STT3kHFpNt2FjRTEWMft5KJPoweKekgPDEmv/KVAyEidr2YmA9Abh9kJ2Zjcg/xVgwIM
         AJSz9nMM2e95thYYU66qTgDp1HE3dYhhJ25oxB7z9N9+Tvc3QIWZeadPGeuEhqhhX6qz
         +y32jNIyqSE1W1jSlSMY51a+liMYklFGHCSizNKZ7AfjomEd7Az9VncBgPsOzVmCnhfO
         Uuag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6ALZB0FHT8vXZP4lDvKT9R6inb8X366JEqaLXf61JXA=;
        fh=PeVLCPhHlDFhIb8x0ocLOZmRhJCF0p29XODi1jR0xfI=;
        b=bVxqppIo7bnblqBp7p3XQcTrlXGkJeiZM+sfZjsvzDo/Tlp09zrjhwSd52tDLbwtMF
         O6/fqub8MI0D+1B416uXN69DwlnRSH/H6yWCp/MDoE9d+eagUpLYUrV4UHBpfBQZmSjy
         GfmCw7TtNUhc3WZKkU+rhMN5H6lIcbqLRGVOW/cFquD5t8nNqNi91uDA4QiUb1Uzslnf
         aCoGFc3da7s4I/mE90RDvDvzxTc6Xip0ao/PYT6EK+P3eo+t7DyQTXx4ppiaOuhw/8KW
         ZYN+BGL1zDj4VGBcJgyPOwtOuI/dzSR4CCkXHYEhUcsLrSoDXLyNwr9JHAHJqftJEUsA
         XQFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779325421; x=1779930221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ALZB0FHT8vXZP4lDvKT9R6inb8X366JEqaLXf61JXA=;
        b=BK6OKpIiK/j2fOVtIwXQUNS2BBthR+vMJ3eF/BYsZlYeXoQy6sOBrE2a8ITxPnVHUF
         kFOgAVTFhU3iGCd/n0wMeZx8ho1s1sTDoxrMgedczapFU+UecCpcFZqfPKfRkp1Etm4K
         ezvprA+yRkoxWC9FGLfZR6eeXIp37BTdAd5VacDArw9FlIh6t6Ec570sFJNa5yglAZcZ
         mEmepxzzuYiA4Qy+xaqK3plFn/zaxC5tKwcwXWnDgMGfyJ3c0F+1wcryiY77MqWmmQwM
         8YOv4Jo3wMxBEa2eUW2Vz+Goi95Hs1/NeTF6AH386BQf3S4h08Sy+pcB9dZvZv2mQ9Ib
         ixPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779325421; x=1779930221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6ALZB0FHT8vXZP4lDvKT9R6inb8X366JEqaLXf61JXA=;
        b=IhqcQKvxedJuza652hs5B+tlngXIIbJCkmVP3M2/QhDvIOVqVnh2FvsgQYxz48GVOf
         uWtBn9Vx+SVYOj31ScHO6ND7LR1rJgg1VhOc9tUY96H1jlXbSrspG0FecRfcOeRK/YQ8
         YF4wlqGB3OkDmt9pLnWjOntQgdap9SikMaYb7amiy/50hPYzn+fE5N/I5bA7h/gIWwzA
         q0A1c9fds6qS9TTx5c2IQaVKNWl+RvAMRONDi4mmDAY43P5ONkUQuzipLazE4Oqd5gmc
         72m2P/XiqLgmbldmOftZbjRgeunr0NXbIIwv+zunizFKNVQWfcijdnr1uUnPZmAl39Qe
         Tbyg==
X-Forwarded-Encrypted: i=1; AFNElJ8npzMM1AHsxCTJ0maHZuMPCVfBDZH9diz3IfPv8+jZEoupm75deWoYRHuXb1O2YIxOrG6MjXKvlDZ2/qKk@vger.kernel.org
X-Gm-Message-State: AOJu0YzdxL1KSdlTWOAYw8oP1fuL4dmrlnlC5KYfSfn9bwUJz1SVcfvg
	s0ObVyZT5XZRNIcIKznIikNni8WwU/bE756FS5I2eTr2tJZ3laB0sopSXjgGQAy4hivFpmTiw3A
	+HCnb6neUqJmRyC5PoPHNsbXBQ2eY9Wo=
X-Gm-Gg: Acq92OHklJcVJoNTs2T0GK7wY60tbNKeq12YOmQ/HqLVGhmoEAjMne7bzR2lr2I3xrW
	H5RRmeaMkIrf6HgGhp6ok1XOIa5pZP8gMBW/PpyrRDY0j0bjNs4ETrFLWIOPkMIzIqtUt4xQK85
	AVbisfbNSXbAnHQcOpE0Z2iVgLzmcBLcq94FYILiE67ZbBqywyPa8L3/t7/OF+3XAjR8WNlyzr3
	TQSj8AEeiJh0vHXC9W0k8cU2/dof8OHQOZADbkRjluVqkxt4I3cL1iq4MmGb4vNhC9T8MS8fo0f
	LEchTyjjRCaZ/ujb6w==
X-Received: by 2002:ac2:54ba:0:b0:5a8:6e3f:ad5c with SMTP id
 2adb3069b0e04-5aa2ba69a5dmr167501e87.2.1779325421200; Wed, 20 May 2026
 18:03:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520170151.4115308-1-charsyam@gmail.com> <20260520170151.4115308-2-charsyam@gmail.com>
In-Reply-To: <20260520170151.4115308-2-charsyam@gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Thu, 21 May 2026 10:03:28 +0900
X-Gm-Features: AVHnY4LatbL4eYKT7DU7zbDlmI-oo0AUAT0x1sEQaFpz3VK4OHkvk6H9d39tKKk
Message-ID: <CANFS6bY=F-88wg=ot4EgCp3aZrh0CUPm4QZHBnbTZ683KGa2dQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] ntfs: free volume-wide resources on fill_super failure
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 5=EC=9B=94 21=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 2:01, D=
aeMyung Kang <charsyam@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> ntfs_fill_super()'s err_out_now path frees only the volume struct via
> kfree(vol), leaving several vol-owned allocations behind on mount
> failure.
>
> vol->nls_map is loaded by ntfs_init_fs_context() via load_nls_default()
> or replaced by an explicit nls=3D option in ntfs_parse_param().
> vol->volume_label is allocated by load_system_files() once the $Volume
> name attribute has been parsed.  vol->lcn_empty_bits_per_page is
> allocated before load_system_files() and was freed only from the upper
> error label.
>
> Move these per-volume frees to err_out_now so every failure path
> releases them exactly once.
>
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
>  super.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/super.c b/super.c
> index f93f0f8bcc45..6cf09bbe017d 100644
> --- a/super.c
> +++ b/super.c
> @@ -2638,8 +2638,6 @@ static int ntfs_fill_super(struct super_block *sb, =
struct fs_context *fc)
>         }
>         /* Error exit code path. */
>  unl_upcase_iput_tmp_ino_err_out_now:
> -       if (vol->lcn_empty_bits_per_page)
> -               kvfree(vol->lcn_empty_bits_per_page);
>         /*
>          * Decrease the number of upcase users and destroy the global def=
ault
>          * upcase table if necessary.
> @@ -2659,6 +2657,9 @@ iput_tmp_ino_err_out_now:
>         /* Errors at this stage are irrelevant. */
>  err_out_now:
>         sb->s_fs_info =3D NULL;
> +       kvfree(vol->lcn_empty_bits_per_page);
> +       kfree(vol->volume_label);
> +       unload_nls(vol->nls_map);
>         kfree(vol);
>         ntfs_debug("Failed, returning -EINVAL.");
>         lockdep_on();
> --
> 2.43.0
>


--=20
Thanks,
Hyunchul
