Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6582C0323
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 May 2026 05:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778046555; cv=pass; b=kbskp9p0a8iljo2GruuHfnbhMN3RqZvd68HiOUhksiuJdNBzqbTxsgLBSgYgFu91h79/mI8JGhI2WLuzv7hN2WaxkgKhsNEJNyoOj9+wbzGY0BYc/Hk29R11qAOhbC1+xs8Fs11nfoQa0XoWC//MEbSuwu9sIqTVFUMtxWZwVIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778046555; c=relaxed/simple;
	bh=3BinkjGqfZl3AIgrT0ANsR2Uat/+5AIGzkar5xViJZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SI4SikJrUHkjbk6j27hPYgpmatdyLT9XnxZv8x1ZxMPAWTShxe4qsCeUhe9kiAv7g/iXwc/UnrQ+WQvf90ZfdWsxBz8Ex69x/vaavkHRAAm+WsPRvinZ+UeLDpKvU4s5zD4OCtes4rup5MWw/Soaw9I9qNrDEhLvw+V1BD467iY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erZF2kpx; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erZF2kpx"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a74ac8b40aso6289091e87.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2026 22:49:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778046552; cv=none;
        d=google.com; s=arc-20240605;
        b=YaSSO56vlahrX/isFabo3nvN/9dtPTxEm8/KszeJfGcHBfEhaj+5ieyvzfElLJ4uYn
         UCIvfYIQ/2KGjR3AmtyN8rS7LlA+zIYBzp3XwDOF9zwCsAmyVy+Xc0OM7Df+Hfp+qFBk
         xMbY+0kzHaHO67n00dm9AZqAztbBCedBPH7lHm3e9qv0KnOiZuVYTX2ekALpeSP7jnwE
         p+lAhx8XqOxlwfQ4trKAGep1nLpVa/hoKwgtgXB4sRAfLg5cO/sphmkYNdk0pHnxilOz
         PTH3XGnvQA2Cxp+zYIXB/EEoD9ZZpSjMj4tWgQqsdehTgL3UtxQMjZuE7fxLeqyRsp5R
         7rDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4xQ1xzJF9pw9eZaxhJxIkYpL/UZHbdupiF3NtR1LWD8=;
        fh=84zTRZU6RHwgutVGdpyphN+6Ringpq3No1YEwY3sxI8=;
        b=fTl64hgXcHZXxzvmUY/VYjjbI9OC5BHvOn79zBhdycxJrICggnB+WjHqxi75QY0IqS
         WuUB9fwOCyXeVBxg/vXrP1RO7taX6dtojRu77zhZW6o+Uo9YFqWV65aqX5pMJv8s1fbk
         nFBxXAMMF4+kXGRbT6cEp5dKLxSh9SiqUfvlQtiqxgCFDJAYsapU6O6m12sNdovPdObn
         UEsbywQkebtu49jJ/SaegS4lvGonzZwBpxaNCGH5GKxpRxUBQSVIhd2wFEk33HSt/RDH
         zyj7t4z0Vmk1pOa5qKKkqOG2jUxUCXclChLM7jakBIVNAizGXaehcCD/UpEci9jo6Doy
         BR6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778046552; x=1778651352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xQ1xzJF9pw9eZaxhJxIkYpL/UZHbdupiF3NtR1LWD8=;
        b=erZF2kpx2jPePDTh4IgJ5oy0cvci2MW++DKePeNvGHDEd6YQnm4PQtiI16GBp+JwT3
         L84idG0KPpSpMKfkvc/1IPx8fkvG57N0179mF+iqnB+Sg9okYrOAkn9r/AyWybg981am
         4cnkpMWA8d7NrVaWPMAD6a678DLtfOfpVUb8Bq+a64UK3zcg36bjzH4rFvcADzv31qMm
         pyIAvv8KIn8t9yTLxoj6G2N6n9oqizfpU07RvIMGhDm+aFSGdWjY1pM4uRHU1eutdmeZ
         4q6wJdB44dFbDOoPYqRk27LiBHx9155VfVFIA3UB8eyiyYxREHJs0zmaThbNGobyPXVp
         X2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778046552; x=1778651352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4xQ1xzJF9pw9eZaxhJxIkYpL/UZHbdupiF3NtR1LWD8=;
        b=IyFiaAH81ewplzAfRIkqSZBLVvn4xGdQ/4LSB5OI891l9Ol99zGY39p0y/yvlZYT2y
         BdhDgoAwEUKUOheDx22C2CwLMQdIWl3zwTOuMaDff1rWQ7DmG1YNJGNcu3LRYUrMzToG
         TEi/iU9781aKL8aVEPNrsZJCoQw0GZedIDByCXeugFisU8puhPwsBHNDIRkV+9LgWdNF
         oiREfEhAM9pgMsfk3jaLTdGtKGsvuSqYYVX/BKO1FxXpT0K1ndiR99XruxH4pRKH0w59
         HbFUEuayOvgdJhHoNKBksPajXnSbEfKzZasSlWwWgop0LXK4IO4jDD8IJD5v3NNrFNqo
         XLAQ==
X-Forwarded-Encrypted: i=1; AFNElJ90Oa03xWG7UnOtgGW71VgpFHtAvOwsj5Y+ohbNzAJCe9UX7Y+nJLxhjTU6FnW8ZD0JKEGJ5rystMDCiFhL@vger.kernel.org
X-Gm-Message-State: AOJu0YwsU6gkIaEA0gmkjyFKP/hZGuwIoGStUehX3OJpwbPhpvW+bF1v
	/GUVSjl/hSR78ySAQVsv6FSAKC3Lsucl8wSOjeWBcosTz4IohyEg9EkqZNLttbTVY9CBdXXQrja
	0vQR3+yV7CosD2IMvN5i6VFj8amgtQU0=
X-Gm-Gg: AeBDieuJR6Na86dbQ5tCqlMfSCxqrIsOmAKziguUfuwrFrvl243F+oyBqMJrJmbqFX+
	PbNvLS6DW9chCB6kRn/4Zp+W5OjKnYRtZaDqbefDzjC3xjdPMH4VOdIssn3TwgIdOm58L06HaKC
	SoWjNG90gafMmKFPGYORru1EjrFJUHJeyh66CuWftxy4Ikjm3bftzfcrnKooCHzX14YmmdAYS8w
	rNxOvOA0AZ+gPNc74SNVRL3z8OR/0c2vBvlxVSL9oLz5Q2i0buD5YdNw4uRgxG1hNspKJD0Glbr
	dMVgmoXenXmo+BZhbw==
X-Received: by 2002:a05:6512:1387:b0:5a8:86ff:38df with SMTP id
 2adb3069b0e04-5a887ce0428mr603332e87.20.1778046551663; Tue, 05 May 2026
 22:49:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504154851.3034915-1-charsyam@gmail.com>
In-Reply-To: <20260504154851.3034915-1-charsyam@gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Wed, 6 May 2026 14:48:58 +0900
X-Gm-Features: AVHnY4L00OY_U_JIqyggAyxuH2plwdNr2PizfXl4_skf_HnG0dkH8j34rn7Fu7s
Message-ID: <CANFS6bZvfXAjizAMAZo4W1SNPGng96RMBw+nEBTcNbPpvAC=zg@mail.gmail.com>
Subject: Re: [PATCH] ntfs: fix out-of-bounds write in ntfs_rl_collapse_range()
 merge path
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 5=EC=9B=94 5=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 12:48, D=
aeMyung Kang <charsyam@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> ntfs_rl_collapse_range() merges the run on the left of the collapsed
> region with the run on its right when both are holes. The contiguous
> check correctly clamps the index to 1 when @new_1st_cnt is 0:
>
>         i =3D new_1st_cnt =3D=3D 0 ? 1 : new_1st_cnt;
>         if (ntfs_rle_lcn_contiguous(&new_rl[i - 1], &new_rl[i])) {
>
> but the merge itself uses the unclamped value:
>
>                 s_rl =3D &new_rl[new_1st_cnt - 1];
>                 s_rl->length +=3D s_rl[1].length;
>
> When @new_1st_cnt is 0 this computes &new_rl[-1] and writes 8 bytes
> before the kvcalloc'd runlist buffer. The path is reachable through
> fallocate(FALLOC_FL_COLLAPSE_RANGE) starting at vcn 0 against an
> attribute whose first run after the collapsed region is a hole. In that
> case ntfs_rle_lcn_contiguous() returns true because both sides are
> LCN_HOLE, so the merge path is entered with @new_1st_cnt still 0.
>
> Use the same clamped index for the merge as for the contiguous check so
> the write always lands inside the buffer.
>
> The out-of-bounds write can corrupt an adjacent slab object. On a
> non-KASAN kernel, it is reachable after a crafted NTFS volume has been
> mounted read-write with the legacy fs/ntfs driver, by a local user that
> has write access to the crafted file.
>
> Fixes: 11ccc9107dc4 ("ntfs: update runlist handling and cluster allocator=
")
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
> ---
> Trigger conditions / reproducer notes:
>
>   - subsystem: fs/ntfs (legacy NTFS runlist collapse path)
>   - introduced by: 11ccc9107dc4 ("ntfs: update runlist handling and
>     cluster allocator"), first released in v7.1-rc1
>   - affected kernels: v7.1-rc1 through current mainline; also present
>     in any branch that includes 11ccc9107dc4. Pre-v7.1-rc1 kernels do
>     not contain this collapse-range code path.
>   - local: yes
>   - remote: no direct remote trigger
>   - authentication required: no
>   - special privileges required: yes to mount the crafted NTFS volume
>     read-write in the normal case. After a privileged read-write mount,
>     no additional privilege is needed for the fallocate trigger if the
>     caller has write permission on the crafted file.
>   - filesystem requirement: the legacy fs/ntfs driver must be mounted
>     read-write against a crafted NTFS volume.
>   - repeatable: yes, the crafted runlist geometry and collapse range make
>     the sequence deterministic.
>
> Reproducer summary used during verification:
>
>   1. Prepare an NTFS volume containing a file whose runlist makes
>      @new_1st_cnt equal to 0 and places a hole as the first run after
>      the collapsed region.
>   2. Mount the volume read-write with the legacy fs/ntfs driver.
>   3. Call fallocate(FALLOC_FL_COLLAPSE_RANGE) on the crafted file,
>      starting at file offset 0.
>   4. Repeat with different crafted runlist sizes to place the temporary
>      runlist allocation in different kmalloc caches.
>
> Observed result without this fix:
>
>   - KASAN reports a slab out-of-bounds write in
>     ntfs_rl_collapse_range().
>   - The write updates the runlist element immediately before the
>     kvcalloc'd temporary runlist buffer.
>   - On a non-KASAN kernel, the same trigger corrupts adjacent kmalloc
>     objects.
>   - The crafted runlist geometry can steer the temporary runlist
>     allocation into different kmalloc caches.
>   - Impact: local kernel heap corruption, reachable only after a
>     privileged read-write mount of a crafted NTFS volume. Practical
>     impact in the field is bounded by that mount requirement.
>
> Verification with the fix applied:
>
>   - "make M=3Dfs/ntfs modules" succeeds.
>   - The KASAN QEMU reproducer no longer reports an out-of-bounds write.
>   - The non-KASAN QEMU observer object is no longer corrupted.
>
>  fs/ntfs/runlist.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
> index da21dbeaaf66..e09bc86a7276 100644
> --- a/fs/ntfs/runlist.c
> +++ b/fs/ntfs/runlist.c
> @@ -2058,8 +2058,12 @@ struct runlist_element *ntfs_rl_collapse_range(str=
uct runlist_element *dst_rl, i
>         merge_cnt =3D 0;
>         i =3D new_1st_cnt =3D=3D 0 ? 1 : new_1st_cnt;
>         if (ntfs_rle_lcn_contiguous(&new_rl[i - 1], &new_rl[i])) {
> -               /* Merge right and left */
> -               s_rl =3D  &new_rl[new_1st_cnt - 1];
> +               /* Merge right and left.
> +                *
> +                * Use the clamped @i; new_1st_cnt - 1 would index
> +                * new_rl[-1] when @new_1st_cnt =3D=3D 0.
> +                */
> +               s_rl =3D &new_rl[i - 1];

When new_1st_cnt is 0, this merge should never succeed on a
normal runlist. Therefore, instead of clamping, it is safer to skip
the merge entirely when new_1st_cnt =3D=3D 0.


>                 s_rl->length +=3D s_rl[1].length;
>                 merge_cnt =3D 1;
>         }
> --
> 2.43.0



--=20
Thanks,
Hyunchul
