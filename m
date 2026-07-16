Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25C83BFAEA
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 22:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784240820; cv=pass; b=bJPghQcCbuglzSXX4ilXHQ98tUVxzCaRNVz2lokFQvuRE4s2k/pfJb/T1VN7YqL/8of6fInMApPQfCNlUW51diF9HuUwmizyQORm5MEnwfTPKdVyGihqUj+4uyWythg6x7HegISzDw6RHNOt7MrkqA5L528bScrj2OkN3we3okE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784240820; c=relaxed/simple;
	bh=XORAGmj4UwPXE+XpAJvwryIBfTrmjzMIj7yZFdIwN2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KnHPgQ05yZmGuNX/Cqw5iqUOUGHA4jJuikOlSuInvcnqmEdOpETOovD34w+pKW62nqMsvXemSP9WtJwcpK1Q4oN09vHTgm7++LJ88LBe2/9ClCTewP4wIPTWfdyrE4+Rw94gUEt+GDke2m43ZCDzxcdaEP7KKlHBVWqFvT3joe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0Db+O95; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0Db+O95"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aeba09900bso2943307e87.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 15:26:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784240817; cv=none;
        d=google.com; s=arc-20260327;
        b=VxExEjMG8ArC+BcC1uVWvNrZlQQQGUgQJ1dFUbND8MVI+6QS+nBi/b+uDHEIP1W5Cz
         tCmcyNd0JSl670wnyR/xYgVblpypMsU1pnYrY4OmZGq80ABmazGjodmCPLC/pv337QhZ
         YnIo8WqPH+8i53Zd/9hoaDLTGY2yiQa6+oxGjcqgdBndpchrnuQRYDZp5NLd73RuIs3R
         UOrJbC8lvVz7fRkoFCRzSkTfw86f0C6qQS9QR+BF944HIjvd2W3Rgl366I2eZNm6hddL
         0/6s7RJAXVyq4xfxq8fMwVllADOsv/lswuW4wDQ/wprNowJk5ew1/KBLq/9F1HbBL1sM
         2kYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xJ7rddNt5xKHUUB42duiZt/GywOH2qba09r4BNPqEFI=;
        fh=jbYq1zY11HyXX0ZarRnBqfc6i4cafp/aWuZ/io+r7H4=;
        b=EuPn6bQqKD3qSUIRPSJn86/dt8c0gj5Hj5cr3VC2HuEcjchJy705krUoFYVoMZSzll
         RsJloSfYFHeZ3mncfnqmnFz/TwrhBK32uGelXtnmPB6wLvfAPMTpCrFHNk9AK3Diap9c
         EYtLmXrQBPyczXtvwAMwDs/CDrih2O/hmi476xe/RQNyngyn1m9DDQ7fGVq8srWIOcLE
         Jwxmm8xHFpFNDLTtFRZEcumg/e1woSuZ6Rbtob5J3PT81Nz3Ue3p95V+YogYcYE69LAa
         kw85DVZNimxkw5zIW0UC0/z/vuBl10WrYqsgQJsGF0E09eHBRP+SyKwTRtop817i1n+M
         ebWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784240817; x=1784845617; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xJ7rddNt5xKHUUB42duiZt/GywOH2qba09r4BNPqEFI=;
        b=X0Db+O95dVIUaTXXuAWGtqrkH6rphhk7binaFESBiZrIXjwh5CCBDnUR4W8XignL5S
         6wsr8rQrTB/G2dj3hPoRBcqNfghnhJeJ8KEFWt9uV+fyY2HQNgeHwtkHG1QUNqAK4zCk
         rPsBx0o9i9AjPYCnNXWRcv3iLGNlJwOZMFRMvd/sZCtikKuVrhuH+MJ5jwOk53l3vDHi
         1IyOM1O8YE8i9bIQVX6oZeks+Qhl71cdYZwyeGFoSMxhOZLOnT0HfXJHwK9vpXYKb+kl
         0haw/q6E0zMgmvejjuKf6pLxQWn3Oqa9zZ2lnpkAOiBuCA9JzYXo4m5OLiW5mAlqxMaw
         sTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784240817; x=1784845617;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xJ7rddNt5xKHUUB42duiZt/GywOH2qba09r4BNPqEFI=;
        b=TqzFhbLe28c0E6JsThRHirkJf+8elI8e9g0UrYBIhszP7ez60SlYEZOIk/V90i/PK+
         rPLrKolpqR209/Z3AsZ2/lUw0XDQg1CLFN0gU9bj+v8QHm5TJbyAlLznPvxkVgfUY90Q
         2eC1AO4eb8FPABhbb9kC6Q+QIVDVUI4nbL5SrANfbkYsTRcprSmaW+fro79vYHPfdZi0
         mt1f6fErMwqPiX9NKuYCNZCxcwL7pomIn/+KmCuO6t6HKASZ0GAI3cj+LxUbDAgPFcmU
         NDHHkmadx+/ZYU+ORw7TemIJjDy5INg6hbBq90h46Z/+rF0RgNcYxf/YYfZ95z/tpDS7
         A8WQ==
X-Forwarded-Encrypted: i=1; AHgh+RqX/wA2hEc32fBjWIJyTmN8Y+D9+SDkx8p1Tpx67dWmz1uOou/zfJAMt5JrVtOOT0OpoNrBAfbJBLDhOUyb@vger.kernel.org
X-Gm-Message-State: AOJu0YyhFh2P35eJF7SvTYEfmvYcHufph/efqD9CHUzQxRxsQL4Tynn8
	zT4uwXXgsj3W5OwpWlYiVcTVpNaTsIPEmcolsjkMmqMVuqW3g9jJExua9GSZBNYYqSltqdMuSSC
	oO0TjDy+RQTKuX8k56OMkq+uxxzQX95M=
X-Gm-Gg: AfdE7ck0gnbKub1IR1X9CLVQ1WGTMoHyHMGdgn1zawdkjYe85JF78ntkngLPo+RM7vU
	/egWj4V+pKBsMIDqg4Eq3aCleWDr1xQnc/+bdDkR6Em5S4fPsIakkqBHz4D9mfcheq+uwrntM7q
	2KyCGT5zy9Ag6G6NIUnUoQxDWgi7gHWbcHZ5JjYuLEs/UuVBgDgXbNpSrzlREXGx86KknVs1S1J
	2uvgeZ+Ioijwrs7xXn14bW2DHixtsmIgMQYiXkvzVc1k62rcbK6bxJLqJlesh0=
X-Received: by 2002:a05:6512:1047:b0:5ae:befc:97a7 with SMTP id
 2adb3069b0e04-5b28f854e4fmr17980e87.13.1784240816604; Thu, 16 Jul 2026
 15:26:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716024640.13396-1-linkinjeon@kernel.org> <20260716024640.13396-2-linkinjeon@kernel.org>
In-Reply-To: <20260716024640.13396-2-linkinjeon@kernel.org>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Fri, 17 Jul 2026 07:26:45 +0900
X-Gm-Features: AUfX_myHhVJbrThmMs5xfQR2Q-AZwHWKvv728hxOFYIbILvnNIFIHA594vnnQG8
Message-ID: <CANFS6bbLi90E0YkYZ3+6GDTDL8hYNFra1Au3wvN+Wu1Tx=TWDg@mail.gmail.com>
Subject: Re: [PATCH] ntfs: remove empty EA attribute pair
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: ntfs@lists.linux.dev, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 7=EC=9B=94 16=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 11:47, =
Namjae Jeon <linkinjeon@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Removing the final xattr leaves an empty $EA stream. An empty $EA
> attribute paired with $EA_INFORMATION is not a valid EA chain and
> ntfsck reports it as corrupt.
>
> Remove both attributes when the final EA entry is deleted.
>
> Fixes: fc053f05ca28 ("ntfs: add reparse and ea operations")
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
>  fs/ntfs/ea.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/fs/ntfs/ea.c b/fs/ntfs/ea.c
> index 0eba3f41c7bb..88bfd6560692 100644
> --- a/fs/ntfs/ea.c
> +++ b/fs/ntfs/ea.c
> @@ -275,6 +275,15 @@ static int ntfs_set_ea(struct inode *inode, const ch=
ar *name, size_t name_len,
>                 ea_info_qsize -=3D ea_size;
>                 p_ea_info->ea_query_length =3D cpu_to_le32(ea_info_qsize)=
;
>
> +               if ((flags & XATTR_REPLACE) && !val_size && !ea_info_qsiz=
e) {
> +                       err =3D ntfs_attr_remove(ni, AT_EA, AT_UNNAMED, 0=
);
> +                       if (err)
> +                               goto out;
> +
> +                       err =3D ntfs_attr_remove(ni, AT_EA_INFORMATION, A=
T_UNNAMED, 0);
> +                       goto out;
> +               }
> +
>                 err =3D ntfs_write_ea(ni, AT_EA_INFORMATION, (char *)p_ea=
_info, 0,
>                                 sizeof(struct ea_information), false);
>                 if (err)
> --
> 2.25.1
>


--=20
Thanks,
Hyunchul
