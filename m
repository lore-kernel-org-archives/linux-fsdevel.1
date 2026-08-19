Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95E67E0E4
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 07:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787124500; cv=pass; b=f+WeB8hPusacspdwdg1I2ijhTHnrDhSCcAOoO6dZPpOZiS8DyEUDeX08AD+WQJ9opmDtlFW1VpW7KDLEh4hO1Kt+tSUKTUeLN2RzI1tnxFGiR3cEAHPEDqeSehybweix9zq6jqrnCj2gk9rGn+K6wG/ge1cFcxcgSHcgctCWRfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787124500; c=relaxed/simple;
	bh=ypNKwl5VjsTh/F1gd+zVSROumx3Q07t0TywojSNOLJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lonpqna5CV740vedDrfgjG7BNd5UPHpL0aFWDh7oo5ZHl29ZkHkJuvwwGcVrC2l9qFI80dsoJMrMdrRPL8+mybEkbP7I97N4tZzfzwnjurrU4Sr3b8qE2Ha2aSGUCeJQeZ4baqAJwLI7fhhyN7rVz3/CkHidGprPhf6LheIGuGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jg5yODLg; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jg5yODLg"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b159850b16so761434e87.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 00:28:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787124497; cv=none;
        d=google.com; s=arc-20260327;
        b=qI8bVOQnlyeNsTekg8cQYgLnF1ddPvDigjmjgvHH8XzOe6/P+xqpqeRPkZmIfBTO7p
         HC9D6yfH4rLyE/IheKcrp/NZflRAJpO3BuG5g3AuZ2MaR129+47pEZIWMJ12WrvtZEQa
         tRgJvOFTlfgn3ekTaIOCooGJaYwAKACx9ItIAy/Ghx1icOjkrq3sdNnCIoaFJnbQpbCp
         9hMOw3L17GpvOZhNZft6HZrg5c9IwLdWufTfgfHPFDFuiL25KvPYYl+CYrURsodGRLW9
         Tay1Fqx8bjADMq+VvMJrA1pYcUOPF5PxqQJeUen8PoVRxOyDLOReL1YWBTuKO8Ns5LlL
         /00Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZZnJlI89pzUJLZ7OtklM8rfJssH9i4zHNvuRglTPFNQ=;
        fh=Qd4VS7wpFUwwMVjeahgAuhuJHFcBHXWVp7sfQZy7yIw=;
        b=mjVJJkdjVV0T3BjTB+1Ie49tRjXaIALnPD9kGnxL0UNfhbrltluJ/Lytm51bh0qJol
         hcYSDHEMADpciGDedMrKl/0l6549ei6G93AxqNjT+jtucVWn3OSm+bjzR06GqBJSFWxs
         xVJy4nGUjjMc2gsBLkIK/o+pHz0MoleWjzuRs+tJlejZ07m5c2Lz8Tj5zoHZ4NXcxB+6
         9z1IIWBakjQAdLEzh4f0jqxVRtyRpbQMjG7VzGSCYU4VfmFnWLhNbiNF6rKu6QbZPIvo
         OfTKxq5GvjzOTwLdomNJopqXCWaZfnf2+Cj93684t2mWz+QI7IdN/weAP/RvSq2Q344Q
         89Ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787124497; x=1787729297; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZZnJlI89pzUJLZ7OtklM8rfJssH9i4zHNvuRglTPFNQ=;
        b=jg5yODLgL4yfCijKILuLjGweGSQJWZWk/wpjOKHQdmVo2si2BZXYDRAEd9I4pWCGb6
         6Jo1C7o7B1JQPqQH9ow4okawksfpWhL2n3OyG9gthyx8/5Fj+iY35AzbxeOoSm9lJANf
         8CE2jQBgt60dLyeA7HlH/uC/63updiFMDAolG4XMf1aaRDeB0sscHycp8CR7orRtv8D+
         uVGHJTa47uQ1MKcR2XbjpQ7FsRma5v0yNL5PZgxEMoBHyJj9yyONrU7lU1j7eJWHMJ2f
         C7wQejR+Bv+XDjN1TynjkTGhGHW/PNHCUITodx76mPcvTuoDnr8upThLUwdG+8VYoohi
         XBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787124497; x=1787729297;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZZnJlI89pzUJLZ7OtklM8rfJssH9i4zHNvuRglTPFNQ=;
        b=DSd+42QAbJGS6wBx7jb1oq2eiJarKpHxH3QPsP7HRGIPIRkG4oPSwuSCEsGAZ0Gg5V
         GjwSb1k6fIoxCmsBGLds7yeUNUBnwl49rwBcfYIm33562Ll0rFUbZ8cPK+0DjR8zNO39
         j8hY/Hl2Kz+Ci0moqlNrpShEl0VWOhfc2HtsNpEE2f2iGV/6XoKImgeKVvIsPPTvIr1a
         MSuZ5TIwNTvGSFADkShpQpGPDVM9r7F2ZEBlH/EwiMsSrpGWvXUMkwIqNtwHKBQGoNeg
         Ijd4HSeEjromhl+BZ4IUILva0Y7l7mcRAUKLbX1PEBZNouJBHgHep7amT/ooha7ZdQLk
         dyFQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqt1DaienBSa9BD3XEYjcn6qVGPg8IYAIPjTwGEbpLmOfbYFQsydWrqrrCygdqz1cWJxU32OyZskFaqq0QY@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5wMV2ZaMpGwsG/XjAmcUMybCs9GIxT3trUdvs9F09MoE7sfn/
	0Q9ppMpqjxutsPEs1YiC3kasCrDSHphbNld7eEJ4PNDyS+uSZAeBoZ2SRGYt0blSMADzT5qhQMI
	jaef26IIoYvK5Axk6ZcyPGWtgwUTnEbs=
X-Gm-Gg: AR+sD108UfEEwE624U80Q3zo1LYr7pzuvuXEodxq8UNymPQfeYj+HF8Wbn6nNdYV9bJ
	riYaO+V10F5gcc+FvLiS7nBsn/l4QcZJ1OgknFnEC7mkVcy00vlDQ23GqbtgLtx6bFf9PjbQqlz
	+lJcx5HJJk73/IUYCQ/iZRTPBNXrexDJukNKQveFyZ05WijOIMwv0ET63xicaECJiq8cZ1eLwyR
	iHmq2o7SEB8azyH+aAxvt0hDILwbOOOwFXqV2o58Vqs4GirwlxhzjlKsh5/aHIJwrU26gGRhpvR
	JPCMuKXCNwdcsYtTctcV2dLQfQaym8qMKB9Yua7zAsma
X-Received: by 2002:a05:6512:1324:b0:5b0:1eed:f707 with SMTP id
 2adb3069b0e04-5b478be4749mr736128e87.23.1787124496412; Wed, 19 Aug 2026
 00:28:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9519.1786907182@localhost>
In-Reply-To: <9519.1786907182@localhost>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Wed, 19 Aug 2026 16:28:04 +0900
X-Gm-Features: AcwNN1Xd_GxvBT1dsVLQcKmu561drRbjoo2mmvqeg22JTWDVID5YxH_Thzl31kQ
Message-ID: <CANFS6baUAfXTN+80-088YXHvuGfc+EPVTLudq6478z3vAdpK1Q@mail.gmail.com>
Subject: Re: red zone violation in ntfs_runlists_merge()
To: rtm@csail.mit.edu
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Robert,

I have submitted a patch for this issue:

https://lore.kernel.org/all/20260819-fix-empty-mp-v1-1-fb60b2eeca51@gmail.c=
om/

2026=EB=85=84 8=EC=9B=94 17=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 4:06, <=
rtm@csail.mit.edu>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> The following mounts a corrupt NTFS image that produces a red zone
> violation:
>
> # uname -a
> Linux xxx 7.2.0-rc7-00016-g3d6d817622b0 #40 SMP PREEMPT_DYNAMIC Wed Aug 1=
2 13:01:40 EDT 2026 x86_64 x86_64 x86_64 GNU/Linux
> # wget http://www.rtmrtm.org/rtm/ntfs2b.img.gz
> # gunzip ntfs2b.img.gz
> mount -t ntfs -o loop ntfs2b.img /mnt
> [Right Redzone overwritten] 0xffff888100321300-0xffff888100321307 @offset=
=3D4864.
> ...
>
> The overrun occurs in the last three lines of this code in
> ntfs_runlists_merge():
>
>                         drl[ds].length =3D marker_vcn - drl[ds].vcn;
>                         /* Finally add the ENOENT terminator. */
>                         ds++;
>                         if (!slots) {
>                                 drl =3D ntfs_rl_realloc_nofail(drl, ds, d=
s + 1);
>                                 rtm_check(drl);
>                                 *new_rl_count +=3D 1;
>                         }
>                         drl[ds].vcn =3D marker_vcn;
>                         drl[ds].lcn =3D LCN_ENOENT;
>                         drl[ds].length =3D (s64)0;
>
> After the ds++, ds is too large, but slots =3D=3D 1.
>
> Robert Morris
> rtm@mit.edu
>


--=20
Thanks,
Hyunchul
