Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552693A1C9
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 00:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783297545; cv=pass; b=Bb4NDsgTn1Mg+7sqkPORX68XVQheWdPIqb4G4KVg6DJFDaXE4uMgCg+XSa40ichkoayIuddgX8rRjo2AMpCCohDKkGdgUFo+Pnjrehhng2Ne168IyVxy/r+kVwvQdnwHLiMeZv+y6c7WH49qBViPpwqK2qh7o1CQtDu/ucqqrsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783297545; c=relaxed/simple;
	bh=DT+z1Y1+R31jv9XpirsEiChiGFeY4BwCSTaKiootkMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CELjURA7iA+ldm0Xjr7ymK+GwWugwh2B89v4KEMrfUt42LxlEHcA2stTXBy3oYHXIFXsn/pMbMxAmd/eTQiDQFUtS5awjvPGZ+FiSoKdIuRgMWmf9IBik8IjZADXmWWYs3id7cqeEjP0b9pCOgU/LFiA0NwjJGfv18WJROgJuxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awTql6/9; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awTql6/9"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aeb2b17167so2992272e87.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Jul 2026 17:25:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783297540; cv=none;
        d=google.com; s=arc-20260327;
        b=WW2ViS1nNsPzJleIhcRlVIC10mvJZ5YP/g8+pGqW34QDb95SYQWAldPNrBfDj0kFta
         WUfp20ZiyGjqWrlc+P2AkSlLPpaye2S18vEw21euh/jbQjyg+HIdpT0eilq4QCMG7ylf
         slxiKD7+253/msyjL/LtOwcmdroqC4qIWpitSyRAVcx3D6XeDkVESQmLTdsjTE3X9l/1
         8J9Tqifbm3e8hEjEpXdlxK0HmifkGrDt9Ff6LIzBCiblL40s4ep50PvT8K4dr1BPlbXb
         rTiZ20r3l8lqSmiiaeDxDGNzV1ChYc2rzhsq1xdLbq2GmyPrVYTYmrlAoprOJGsoYTjI
         WApw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d9E3SIQfAuL6IPexY6CDkGAiXkVbs7KgM9pILjSs0EI=;
        fh=TM/2vU8Tnz17mzRM/eSu3tRh4K2XwfSURWtezRkTDWk=;
        b=AP7zWI5AjEnkOJ6r8vJKqN6Lz4N/NfFq9sjeBEv8aesmtuiLG/4qcl5TqiqUmfcSnR
         jPlw+GbIX4624wDQgulJDPkcxbuYrKlPTev0xSWwJSk+ASPFhOWRJX8sBgnG0GEneiR3
         vapIM/VJR72SGKv1qCvQU3rSbn7XR3Xj0mRcsb5pdCK+BnNGQ56u8cXAzZEJwGGUSEA3
         E2LoXGLcp24O6v5/M5XQLKCX/dKQopOPjHpY26h5XooT+OyY9tTL7vl6mMq26upopc7R
         lpFMIWrKwx4licb4PaFZjdc9g5ekhfsuZye/SeuCko5FCt8Xv8aBsWZmV8btLSOgq4F4
         iL9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783297540; x=1783902340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9E3SIQfAuL6IPexY6CDkGAiXkVbs7KgM9pILjSs0EI=;
        b=awTql6/9PuucrMnqXALO/X6AWzqbnQX19qvRDMbLA+Ob7+MdidtpiLEFiIJzbxBXQ5
         K4dL72Qq8JSuh0fhbGz2fI/+SuxnDgBfe8yJFmJWcxiJmeUfAn0zGxqZ1UFDrQ+xDd1Q
         49a//ZvIknw+SqsIhQGHUuV2UVxXXNpKwrBP6Wp/kl+n6DDgf0U4ww4XfAMo4cFUWGWs
         FikDRSotUiVeHwRQ7FXzMXhJLYwft/YU126puf1KSKjlnVH/yVMqrznhlZWtdxRUdBDo
         qeI4dLtm+z2GwQRVO4r0UOC9cS2SrseF6HCDQ/EniCTYYy1bjK9T60b1b/2Js3NiabW1
         9LhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783297540; x=1783902340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d9E3SIQfAuL6IPexY6CDkGAiXkVbs7KgM9pILjSs0EI=;
        b=nsTbFeRjg5eJui2yg00MkJ4L3WjeY3TEbrvE9REPJE9QoPUD8HotecUefyk31XDh75
         P1OlJh2JQNowogkCF0ain7uFXhPAxLmXbCNqqGU6G4xzZhMbVy51VJ3jNxJAfhUg5q3d
         LWQCqFJcFww4SuMXOo29voqnvnqPtbyl6em1WIzh9XpxTFsege5aTxa0KEwDbw19O+MN
         /MNc0Ui9yBGoAN97tY9QTERr5iQEiyrHgioAToYr8pz/89Xzp0mk18Y3E9NIqlUqeTjP
         c+XittdWc1FklRwqnBiRgqvCQGt12taq446628POqmYYp6a4ubaxJZmpnr3QiSuIOq6T
         qCrQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro0eJrixrx4bReIezrQ4Jwo9vuFQRa1mXotNYGzdqPATOJD2UZdwFotNkbz+k90q3aaCOoCJOA9wcjdgXqq@vger.kernel.org
X-Gm-Message-State: AOJu0Yw269U73oJLLTeLsPMPqJJ077di7TyBRo7Dtz/lVokSaLGyna/6
	6WYKaqQD/CyXD0bDUxv0PlPITNpOErnpEWw1dtIO9umzQi5Ai2OF0EdMD0ObglbfIVPEEOfedJK
	nd+inQ/uBmKosB6CktlbycrBt+E396t8=
X-Gm-Gg: AfdE7ckgudKSE9ryZPToQk/zNxxi6k1O/lBGP/l/DgNKVFgWvFDefe8rP/wdhiYJg5f
	OYNKNbS28kP8lhSAwoN19T8m7I+1PTtsXYVBaDqsKlTza3n/BWzq+XcVWhlWBvHkKOXsBDsm5cc
	DCdJX5UJ9zikjyl//f0cn4e3+daSef0Le0gVfdPff24l2nEQtDxzq5uJm3tqaarcjM3PlOan9iq
	vAsUrnrzxbV3LPpY5v+ckxLMu5SiskaxGmNZY3NPnS1+y7U/jYrkzQ/dlYMD6+t6Xm44GWph++7
	zZbCrvY=
X-Received: by 2002:a05:6512:b94:b0:5ae:c2ea:b3f1 with SMTP id
 2adb3069b0e04-5aecf4b8764mr2461325e87.10.1783297540126; Sun, 05 Jul 2026
 17:25:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5A2D944D5FE68879+20260705100554.3797781-1-peiyang_he@smail.nju.edu.cn>
 <01B02B3C02CE4CD1+20260705111409.3834024-1-peiyang_he@smail.nju.edu.cn>
In-Reply-To: <01B02B3C02CE4CD1+20260705111409.3834024-1-peiyang_he@smail.nju.edu.cn>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Mon, 6 Jul 2026 09:25:28 +0900
X-Gm-Features: AVVi8Ccin6hdwwNj7OHqDu4688cL1PIaoZ995U2bRzdQdRwitb6Fb85ob2Ln5jc
Message-ID: <CANFS6bYw6Cpf=JkZquN1OqEGwi5csC9ZDRwK8CQWAYDeYRHSSw@mail.gmail.com>
Subject: Re: [PATCH v2] ntfs: fix hole runlist memory leak in insert range
 error path
To: Peiyang He <peiyang_he@smail.nju.edu.cn>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 7=EC=9B=94 5=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 8:14, Pe=
iyang He <peiyang_he@smail.nju.edu.cn>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:
>
> ntfs_non_resident_attr_insert_range() allocates hole_rl before mapping th=
e
> whole runlist. If ntfs_attr_map_whole_runlist() fails, the error path dro=
ps
> ni->runlist.lock and returns without freeing hole_rl. This leaks memory
> of sizeof(*hole_rl) * 2 bytes.
>
> Fix this memory leak by freeing hole_rl before returning from
> that error path, matching the later error paths in the same function.
>
> Fixes: 495e90fa3348 ("ntfs: update attrib operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
> Changes in v2:
>   - modify commit message to resolve checkpatch.pl warning
>   - add Cc: stable@vger.kernel.org tag to the commit message
>
>  fs/ntfs/attrib.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> index dd8828098511..55603df0a2ed 100644
> --- a/fs/ntfs/attrib.c
> +++ b/fs/ntfs/attrib.c
> @@ -5325,6 +5325,7 @@ int ntfs_non_resident_attr_insert_range(struct ntfs=
_inode *ni, s64 start_vcn, s6
>         ret =3D ntfs_attr_map_whole_runlist(ni);
>         if (ret) {
>                 up_write(&ni->runlist.lock);
> +               kfree(hole_rl);
>                 return ret;
>         }
>
>
> base-commit: 1a3746ccbb0a97bed3c06ccde6b880013b1dddc1
> --
> 2.43.0
>


--=20
Thanks,
Hyunchul
