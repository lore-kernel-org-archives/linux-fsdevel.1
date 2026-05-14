Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1269C282F32
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 13:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778764178; cv=pass; b=qDcxV1sbqecOGwTgZG93Sydmyk5k42UNy2k/UDia+oFdSxVEXipx/DyXH5kQaKMz8Al/qXP/1q9y5vlhcU98pJykS9pzo6ENEt/qR5PcbLYvl9pBSuxh1xsBUw5BRrFzpvISrjqUb9l679Cyjz66IcDzkbmvsP6z9S04b1dAW0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778764178; c=relaxed/simple;
	bh=429UQAl07phH8nlRtoA85sH+iBZiRo/Y3nskQ1kXYLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FkERs9nfSpdXEvbIAhZuRQv8dk3CnYihIHuNg6XoIqW476OlpHbjLqAGSA+Vwl2g6SIqXQMz4xEyApQWk/6DPKG3nWbY5dEydvBdxq6S/aC2ZWzhortLi1ebH3R+Iv5ar9FdMOvQ3n4nzbqwhTroPX57C3IKHMfJ6qgTHlM+xew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vy+Ntvnk; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vy+Ntvnk"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-67389cf78b0so13998692a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 06:09:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778764175; cv=none;
        d=google.com; s=arc-20240605;
        b=RwhQVQA/cuhIvxTxGqT+Mod020Dy/Jgyl0KPBLe0Fubs0679amMn91+Lk8NXUL8dCL
         ehJHFlS/prpBiop1/L5mW+QFyNeqi1ipSqq2KMA6C65upwPbD4+INhC66ReshSfUd7OM
         RiCbE+b9EPO0UsLlKPJNbMD9tthWMCXe8FdcpRfFAW5vd0kTZn5HS7/NLndW7WumLyVx
         Rb/uAOnpgmp56nu7iALNFFONtFgnwI8750ooPCG8HfbrFJ/egxYWVC5XQfcPK5Hb3DaB
         LMyecg83/okHGQKpgUV3OOqH9xIgIUakPED0xPIlxqy/NOpcgZIMcufSOPK3W4FsIwug
         EOCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lzs+KKGB6sB6D+VbuyBjxQbDGUp4kci1SR+mHxM7YjU=;
        fh=e/1KAOaebj5wfvqfwbpxji9vSA1+AITWdpdyOz3G9N0=;
        b=IaTh5a8eW568T7HdtVgijiQT8p7EaePs4RY8Nhkxq/LPdMtuCUSMLzA0ozTjduTo/P
         OE5eqe5VCFekiEoAWTIo9IJys3ij4c+A9cF+e7zIgRRfiDkIt4+gNOqeC1sAOweNRBVC
         8eliNHs+39JI4tIJZvsFKTEPzhZqtLSONH3yv0MVKQY2SOarysvTxK0tR0dsdlAwa5eH
         ENCblJQgfEQxap2dWPxmyIa05D6lWg7dtLGTE70Fj3+z30N8cG+c7wlLGOG+/F2CTHQp
         ElA0EnlgQkt1HomGSHeB4xWAoUuTNcvN2fnSmPOoeIMCChPtCqRHJkdvwjwlzKuNvsSK
         fpFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778764175; x=1779368975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzs+KKGB6sB6D+VbuyBjxQbDGUp4kci1SR+mHxM7YjU=;
        b=Vy+NtvnkZtONrKjKibcl0wPlBELybMICTlPRi7RfH8SNk8xmSFtm4HWcOzrkjkPLbr
         8jZzOEXpoOQl5sK6JZbPAyzyp4vNt//pjLv/VhTYJ08Vzt5HFpF/fs+oz13WDwyJoaEP
         YenclKZuR2jCVPThh1yEk8carvGQdVsMxMyUPjC9B95fI3Fvpt1qQnDnqHavS08Crjr/
         Yd89GX1Ox7b/oFlGAkF151dCtfNz4mjqjnmS10gKAN5/wsPD+nIeCgZkuDp7G1DibEui
         DleJ35e4ynkQ58I9YfCQvHvoIt5BfTrywb8sgjTeur4Vd8J2zELnly2S6D+RUt8XQkfh
         lPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778764175; x=1779368975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lzs+KKGB6sB6D+VbuyBjxQbDGUp4kci1SR+mHxM7YjU=;
        b=tJhmGuyJv5wbBHtFuFVVGuZ+oQk9EAxspU7mo21S3ETokucE74wV4lE1ODBTlXspLz
         9DSAaGdVDP+C+MNqvVJW1zzjmg6QtieuGy3eMQmvnbXk8XNxBuu866/zMuTiyL7CXsfd
         hjVzRw1pf50d0F4eizeThV2M+M8pmtG9ltCawCrSJTF4TAlZT55ql/vORuz4kdCRfIBX
         YEFGX8DJBs29f6+XedUrfvzTygLtiapr9eqVEKMOjUbFA3IPTVC4joAlKP4BZXEiQsig
         +fhIOcrgrql/pd18o39SO3SGSNCY0IZV/y39tFAUpf6jSCKe8I8723hkLdBVa3jc5mV6
         +6+w==
X-Forwarded-Encrypted: i=1; AFNElJ8ErqFbuMMjRq5TD+wuaZ80TI4YYI2h0+hsOQBsnQK+JXjgXoT8bUkgGsnFvN5t4SSIc43+2ft4cdTrcyI0@vger.kernel.org
X-Gm-Message-State: AOJu0YwiGZs5mnUv9GPbnrNfY37dhBQYGdoAGijHBKZvEV+sOETGxl50
	rNgpKcM4wMEWSknHi6rIUV6EcOsdDiiCv9J4cqrRD1Mb5E00+Efpz0xE7mCDHCWCahVWcbkt1hM
	F/5tFkL67sJ9kwQOP/ZkmPym3Y1lAFRo=
X-Gm-Gg: Acq92OFjK/13p9GXuzWKTzPeR7yWAjH3DcxwLpNWWtApm3UZZND3T9GHusyMwbtUIeq
	H8Zh7xqpIbjx4sMqUxrgXfWgg+neiFdu3XMiX8ic7fJK9dgMpvdk7EAz3NDJYrnT/Ht15g9ZeEX
	bb9HgpjrpFGjEoz8p9REckbnQcX0hu2yv+NDec/WisbZ4aB9n3i8f80TuI3YaPbOD6zGFkCnlyp
	D0jbbiegVD0z6wV3dqtsSC45mj3nbEsn8mFQ89LtrLSRQy9l5sJFRmUr+gRgQth/AVFGYSs0bES
	UWfbGEPwftG26S+ssNO0qutI9J+yQuanSqmJjDZmIw==
X-Received: by 2002:a05:6402:2815:b0:670:8bc2:7fc with SMTP id
 4fb4d7f45d1cf-68255602ff7mr4834516a12.2.1778764175258; Thu, 14 May 2026
 06:09:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxg+DkTuinnf9AMR6gdHqAydbD88+oBkTtQtABJfdC0vVw@mail.gmail.com>
 <20260514121336.439565-1-nirmoyd@nvidia.com>
In-Reply-To: <20260514121336.439565-1-nirmoyd@nvidia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 May 2026 15:09:24 +0200
X-Gm-Features: AVHnY4Jc_CUcxpTIpmBQZFX5NP9WwYxJSI85bnMXv_tsUkLcgbfi3ea1PdxwW7g
Message-ID: <CAOQ4uxg=gONUh5QEW5KJcyXLDF15HbLnc9Ea7RKPcgtyfPasTA@mail.gmail.com>
Subject: Re: [RFC PATCH] ovl: keep merged and impure readdir caches separate
To: Nirmoy Das <nirmoyd@nvidia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+a16fb0cce329a320661c@syzkaller.appspotmail.com, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 2:14=E2=80=AFPM Nirmoy Das <nirmoyd@nvidia.com> wro=
te:
>
> Hi Amir,
>
> After a lot of debug and traces I found another bug in

Thanks for persisting on this problem!

> ovl_iterate_merged(): err is set from PTR_ERR(cache) before the
> IS_ERR(cache) check, so on success err holds the truncated cache
> pointer.
>
> Claude generated this:
>   getdents64
>   =E2=94=94=E2=94=80=E2=94=80 iterate_dir(outer_overlay_file)
>       =E2=94=94=E2=94=80=E2=94=80 ovl_iterate_merged                     =
               [OUTER]
>           =E2=94=82
>           =E2=94=9C=E2=94=80=E2=94=80 cache =3D ovl_cache_get(dentry):   =
                 [OUTER ovl_cache_get]
>           =E2=94=82   =E2=94=82   cache_local =3D kzalloc(...)
>           =E2=94=82   =E2=94=82   res =3D ovl_dir_read_merged(...)
>           =E2=94=82   =E2=94=82   =E2=94=82
>           =E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 iterate_dir=
(inner_overlay_file)
>           =E2=94=82   =E2=94=82       =E2=94=94=E2=94=80=E2=94=80 ovl_ite=
rate_merged                    [INNER]
>           =E2=94=82   =E2=94=82           =E2=94=9C=E2=94=80=E2=94=80 cac=
he_inner =3D ovl_cache_get(...)  valid 0xFFFF8881_CAC4D940
>           =E2=94=82   =E2=94=82           =E2=94=9C=E2=94=80=E2=94=80 err=
 =3D PTR_ERR(cache_inner)        =3D -893068992 (low32 of ptr)
>           =E2=94=82   =E2=94=82           =E2=94=9C=E2=94=80=E2=94=80 IS_=
ERR(cache_inner) =E2=86=92 FALSE
>           =E2=94=82   =E2=94=82           =E2=94=94=E2=94=80=E2=94=80 ret=
urn err;                       =E2=86=90 leaked stale int
>           =E2=94=82   =E2=94=82
>           =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 return ERR_PTR(res);   =
                       res =3D -893068992 (int)
>           =E2=94=82                                                     s=
ign-extended =E2=86=92
>           =E2=94=82                                                     (=
void *)0xFFFFFFFF_CAC4D940

Wow! This is demonic.
I think we need to fortify ERR_PTR() to not accept illegal errno values.
I'll try to write a patch.

>           =E2=94=82
>           =E2=94=9C=E2=94=80=E2=94=80 err =3D PTR_ERR(cache);            =
                 err =3D -893068992
>           =E2=94=9C=E2=94=80=E2=94=80 if (IS_ERR(cache))   =E2=86=90 FALS=
E: IS_ERR only trips on top 4K
>           =E2=94=82                                  (errno window);
>           =E2=94=82                                  0xFFFFFFFF_CAC4D940 =
sits below
>           =E2=94=82       return err;                                    =
=E2=86=90 skipped
>           =E2=94=9C=E2=94=80=E2=94=80 od->cache =3D cache;   =E2=98=85 co=
rrupted pointer stored
>           =E2=94=94=E2=94=80=E2=94=80 ovl_seek_cursor(od, ctx->pos)
>                   list_for_each(p, &od->cache->entries)
>                   p =3D *(&od->cache->entries) on bad pointer     =E2=98=
=85 PAGE FAULT
>

Oh boy!

> Sent it as a separate patch: "[PATCH] ovl: keep err zero after
> successful ovl_cache_get()".
>
> Let me know what you think.

Patch looks great - real root cause, gave you minor comments.

IIUC, as far as you know, the repro never triggered the theoretic
OVL_WHITEOUTS race?

It was always just this ERR_PTR(PTR_ERR()) black magic?

Thanks,
Amir.
