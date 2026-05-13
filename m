Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFD63C379F
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 23:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778715979; cv=pass; b=kw1NLVTs3RB7Z6JNEiDJQ7RpCclmhCzkAgMP56U5SPcXEJ50zVbrP/01gBUSh9TFG5NwaXY/dw0yos9zS63KEYKWOvbVmPT3+zYNNxw/u6x91/vu41S2hFCUK2J5xzVZa8c0Au9vf9BzmagBqJW0j4sd55Ntqk4gtX/biab70vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778715979; c=relaxed/simple;
	bh=tyzTL3ZM/CqefmFe7D09NFTQXS+tF3E0NxC6baga120=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fK/GqK7IZmy6q4FJcgwnNX4YtFyF9wPFgKHMoRWi7KhJ416HJrBPYl+LrulFC8RgtUVtNt7vxxHb1TP2dmVBzVb2ogk1B3koUNxAROC9ml3MwJgj+Y2WMonrf2m1xHvtfYpRoPEBLwwFdraf/o1LDjTkjpnKuYkWc5R9v5j66Xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjGP/8Zg; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjGP/8Zg"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a8fbe18b1dso1035141e87.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 16:46:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778715976; cv=none;
        d=google.com; s=arc-20240605;
        b=HzzrFJkaNDSfJ4ptSZrIkbk4qdJd5gS96aQEbOzUZ3rh3qhPcGac+E0g6PNXTgFkXJ
         ZA98RUaQfRhIFF43qESbDwRq8arbFEVnv2Da/EY2z5ljCgjbJ3GYSRG8VYpT22kaMCID
         juA2AUXoyxrVrAZX9E8czJHYQo38dQylw9EiZF2I8Q39mXTspCdAMkkF7HL+AT0scx4O
         eZL/qjDBlrpfz2DNzGamNiRw2eiJOtB0xuEtMyf8JRy+QE75tJboEjaeYJT/y61n946o
         WRq8hxHnvBqS2dVtB41iLBv4D+uDE8Dmlg/ybJdTdG9ZAktDSpkis/IqELHTlEkZwVxV
         tmSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PGRwI3IduwjmmuOtswCaIsGRHyxev2XGrZfskh2LnVc=;
        fh=OURnP0/ZAw9t3m4oYmHfFkqPacEJvKre11HBi1coPuA=;
        b=HqJCHoE2jLuv4fgRkDw8plkdV6IyborJLvQdH6WT5UZhFVoOJzkAWwcG58mGAnsHLt
         Ch7fasKRYDW1LgSYJIhNEFBLy0OYPVokHs4nTWy/n7LAhyCg87GEl0oEQ9lI5SBM+SqK
         KExTLCcAPLmZoYn15ubOTudG/ZYN1MG6LhBfd6CvCR11LKJ0od4xngwv9JkWJuZvAu1K
         Iq81gTA9a8gIY705eNd7O3SRRAurLoEJaN67KPpUwqScoi3e4DDdHwRdfEC1lgziOLZE
         mZH1xHArlgisAU/Hnl8hcIMb6QnjWgg+S805NGDfHVgUfxCFe9yjQABUjaC225Gfv2B6
         R7Pw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778715976; x=1779320776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGRwI3IduwjmmuOtswCaIsGRHyxev2XGrZfskh2LnVc=;
        b=BjGP/8ZgTokAY2SfzlNUhEJgkaCAut0dpEwLwNkA5c9qxZTxnzCrDOMcziXtjjt6XK
         W23eTlfJM1Y8wF9zpi+fKl6NdELTdkExeWfH5yOYXx/0zPasMJmRhVN9FzlCmJ/MO2Tv
         7+V2kBX8BJjJG2mzM01lSFpYSfMLsWUkoKdOhv1GkKouiXr+G7PYZJYpPw2fuD9C8vlz
         SkoVEAcpHxI9KgjRcnaC88sxonM479TWf5ijl77i9H7YPR1YFoFgnF4es5vXwlXsmnr8
         2iSxrk2U6KhxLycqlU4NM2pZFLLLHMQr6kSXAn0JhlVZTvLMFq6D2muFfmTsY2Gyg+gs
         QgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778715976; x=1779320776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PGRwI3IduwjmmuOtswCaIsGRHyxev2XGrZfskh2LnVc=;
        b=ssFEsuzvwrws26YQZszkzXz5/UJejrJzZ3nfSWmtelEwMBarZBe8lBqxwYPmnRpEHR
         2SrSbN/wV3IcseZok3i0TCGzhwQWozyK5h5jnPfuT/4mjmZgeP8vPYnWD/MXN8rwc1Wk
         NmglaC3ispZ+12VXqvOyqCrM7V2irdqc+jfLAYeVhNwVODR6hWFVfuPGZdqSRYw847b4
         4Ikr+E23Bis53iWL8POkhaZTg3qpJfXJOQFjOZUIggmolPbGaORuJiahBG4iF/jD9dna
         CplKFQvd4RD2Aj3jL7+G0PHkmZT/eYzJFhwiqCDFmIDxhM/Tb92ATS/dZ/UiGHLAtcNb
         5i0A==
X-Forwarded-Encrypted: i=1; AFNElJ8+rIMpQz3hh7jGGBYZww+ELR13CdM4A3YJ8/kjNSimFdH31/hqieK3mtMukIuTw90XSUFxCPRvqDyz1LIY@vger.kernel.org
X-Gm-Message-State: AOJu0YzaDyqFBKO+a6JI3JlwjtkLeUEHbrXH4lbMweDrC6QpvGS/ZpC3
	KFYeGrpANlEt3wFBgpb+2vWBp/gVaOPKCkwZyPbCwYBnszV6Kc4us9OQfNUv/Cxuxs2/2JrCgeC
	9apLtYiKgWOt/hm3WrS1skyutNDkNTDa4Ew==
X-Gm-Gg: Acq92OH4ARKb35OP3vXTFO9C7Uxnx8VKisDHk+kNbIBnSwGdP241Uw5c0FYaYGQJ/Re
	YutJhEah43RlvTtQzxP9tnjU/InUVN6XBuRE1VLmJFzFTgSGbqErwo0zcFW4Zi3EdGaWpHWvJR1
	X64hpRUu/avphowboI7W78tOFS3HXalrRLzSZLePYKCC8rrHVLiJeOzpo4EeV6S3EuZ2lFca/EU
	dRMTGEJpDYQBY+chxM+Rdl46KIPadWGsl2fzU5YvBctrcigZfp3d6O6GNabCYksbrCP5Vy05+IX
	aNa4gNGhgw9RXs0QZT3YMqMgzJZ+
X-Received: by 2002:ac2:41d1:0:b0:5a8:f984:142c with SMTP id
 2adb3069b0e04-5a8f984165bmr801198e87.12.1778715975557; Wed, 13 May 2026
 16:46:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511160626.1268612-1-charsyam@gmail.com> <20260511160626.1268612-4-charsyam@gmail.com>
In-Reply-To: <20260511160626.1268612-4-charsyam@gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Thu, 14 May 2026 08:46:04 +0900
X-Gm-Features: AVHnY4Lz5Euq4h3CeE8PBjoZIg0Mv1gGxaxnOV4IJ5YdTAoMRN0yZRCc84wvlnY
Message-ID: <CANFS6baeNEftv9Zwn7_tNxhH2B8kEhrWOT14RLyewr1_rhnrsw@mail.gmail.com>
Subject: Re: [PATCH 3/3] ntfs: mark quotas out of date on initial rw mount
To: DaeMyung Kang <charsyam@gmail.com>
Cc: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello daemyung,

2026=EB=85=84 5=EC=9B=94 12=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 1:06, D=
aeMyung Kang <charsyam@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> The remount read-write path marks quotas out of date after emptying the
> logfile, but initial read-write mount only loads $Quota and never calls
> ntfs_mark_quotas_out_of_date().

We set both the owner id and quota charged in $STANDARD_INFORMATION
to 0, so it is questionable whether setting the out of date flag in $Quota/=
$Q
has any meaning.

>
> That leaves quota tracking metadata looking up to date even though the
> driver can modify the volume.  Call the same helper after $Quota is loade=
d
> during initial read-write mount.  If marking quotas out of date fails and
> the mount policy is on_errors=3Dremount-ro, convert the mount to read-onl=
y
> and set the volume error state, matching the nearby $Quota load failure
> handling.
>
> This intentionally follows the initial mount error policy rather than the
> remount-rw path, where a quota marking failure rejects the remount with
> -EROFS.
>
> Move the load/mark/policy handling into a small helper,
> ntfs_init_quota_for_mount(), which captures each call result in a local,
> derives the failure reason, and gates the read-only downgrade on policy
> in one place.  This avoids calling helpers inside compound if conditions
> and keeps ntfs_load_system_files() flat.
>
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
> ---
>  fs/ntfs/super.c | 46 +++++++++++++++++++++++++++++++++--------------
>  1 file changed, 35 insertions(+), 11 deletions(-)
>
> diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
> index 22dc786..8fa298f 100644
> --- a/fs/ntfs/super.c
> +++ b/fs/ntfs/super.c
> @@ -1221,6 +1221,39 @@ static bool load_and_init_quota(struct ntfs_volume=
 *vol)
>         return true;
>  }
>
> +/*
> + * ntfs_init_quota_for_mount - finish quota setup at mount time
> + * @sb:                super block of the volume being mounted
> + * @vol:       ntfs volume to set up
> + *
> + * Load $Quota and, on a read-write mount, mark quotas out of date so th=
at
> + * Windows rescans them on next boot.  On failure, downgrade the mount t=
o
> + * read-only when on_errors=3Dremount-ro, matching the volume error poli=
cy.
> + */
> +static void ntfs_init_quota_for_mount(struct super_block *sb,
> +                                     struct ntfs_volume *vol)
> +{
> +       bool quota_loaded, quota_marked =3D true;
> +       const char *reason =3D NULL;
> +
> +       quota_loaded =3D load_and_init_quota(vol);
> +       if (quota_loaded && !sb_rdonly(sb))
> +               quota_marked =3D ntfs_mark_quotas_out_of_date(vol);
> +
> +       if (!quota_loaded)
> +               reason =3D "Failed to load $Quota";
> +       else if (!quota_marked)
> +               reason =3D "Failed to mark quotas out of date";
> +
> +       if (!reason || vol->on_errors !=3D ON_ERRORS_REMOUNT_RO)
> +               return;
> +
> +       sb->s_flags |=3D SB_RDONLY;
> +       ntfs_error(sb, "%s.  Mounting read-only.  Run chkdsk.", reason);
> +       /* This will prevent a read-write remount. */
> +       NVolSetErrors(vol);
> +}
> +
>  /*
>   * load_and_init_attrdef - load the attribute definitions table for a vo=
lume
>   * @vol:       ntfs super block describing device whose attrdef to load
> @@ -1638,16 +1671,7 @@ get_ctx_vol_failed:
>                 ntfs_error(sb, "Failed to load $Extend.");
>                 goto iput_sec_err_out;
>         }
> -       /* Find the quota file, load it if present, and set it up. */
> -       if (!load_and_init_quota(vol) &&
> -           vol->on_errors =3D=3D ON_ERRORS_REMOUNT_RO) {
> -               static const char *es1 =3D "Failed to load $Quota";
> -               static const char *es2 =3D ".  Run chkdsk.";
> -
> -               sb->s_flags |=3D SB_RDONLY;
> -               ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
> -               /* This will prevent a read-write remount. */
> -               NVolSetErrors(vol);
> -       }
> +       /* Find the quota file, load it if present, and set it up. */
> +       ntfs_init_quota_for_mount(sb, vol);
>
>         return true;
> --
> 2.43.0
>


--=20
Thanks,
Hyunchul
