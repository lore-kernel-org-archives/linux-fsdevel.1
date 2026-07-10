Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D36367283
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 05:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783662208; cv=pass; b=qymsuCkuPZLHpIqatKwOG71n4lcZg2RULKA3F4WkHsPtcGpc/4voGDnzCSPJebH9hld0WQpqgF39dtuMsl6zKxtKnSJTW5/FkUbAi4Vg4pMheeob1B3PGJq7mET+dB+weErFkgCg15asTgLltdtHg914o3SRE9U69Gc62SWYA8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783662208; c=relaxed/simple;
	bh=2YVgkG1gnJMkfaa3owHYhG2Umuahx4FRmcOq2yBAdmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wqpo/0RTv8Rw3eaO36X25ij7yqo8ELDo9wlCKKItp43QXbr8cC+TmivUzjY5rY42VZ8sg4KNIxRoG9azT9K3Y6xUGRWn+XgdE0U39W3/IOom4eqYx6L9GR7LOpef4CuqLJVPc+X+FrCvPLu2x4uzBdFX5a8HhueEx8ED8yqUvHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCo0ijbA; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCo0ijbA"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b018fe8318so442084e87.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jul 2026 22:43:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783662206; cv=none;
        d=google.com; s=arc-20260327;
        b=RjMd0J3g9fBoxCx72JI+oXz9p9DhOdVCKWEtp9aAxqQkxWwlzM1ctsbP7RHG6HJqhH
         C3fGX2Z+qas7w31+6GZDdBdHalAjqQjq+mvAeSAaFF9ZJ3AYfa8WuUm0Zpe/ORrPlt5k
         nJG5wiFooXa0b8YJzNVsL5CvOtRsYYNW9wxoNmQb4GtIx4e6Gwgngh+IVMe1OVUXEcjx
         cEOxKFIVhQPlm4JpTyUg0sNh2XKrJhm16sshqKSXKx2hMkQ/P3/kE5SFRhxtiOe64F4G
         br98qSLVgVkm/uegeLHZ0QybBuHzbbH+OiVR5y2YvsspdYx5NTUIpqE2M1cnZHgmpcTn
         xZ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+9Re/KEsDNt2sGvpo1jBpc9Dd0Ptp7s8KPI1kfDwE2A=;
        fh=y2z/ewxQnT7zfMpi5+i/YDqC+ltcAmsjjru3ziOsAXo=;
        b=B10OdEyLqncF7UE8HXIUjlROpAmVnzulpPV9S/gTdlLjRJqzdw8iA+kYX+vchEFAD/
         kQQxSQLTq75W4ylwWW7C6I3lttOABLVXrIncHuvlgEuy7XrDxZ/d6xPVhCX09E9gEg+Y
         j7q+Vh444nMP7SZImiNDDCgruRlSTK80eEWeTHlD9+15DBdm9G3onXWJ7N+JM9oAMOwn
         pnWDN+pQRNzQBYVCr+LOmRoBhJU32RKJ/7INW5rEk4gl1JplwBGAsPYoW5nyraHkAcxD
         JSaWqD8/y0L22ZRj9Sj2M19FoQtKJ0KCsPI8UMhVGJ51S9cMqCarUSDgqLkyIpz3s8xi
         wtdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783662206; x=1784267006; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+9Re/KEsDNt2sGvpo1jBpc9Dd0Ptp7s8KPI1kfDwE2A=;
        b=aCo0ijbARciycCDOoN2iExphXvTSTDmrLtniA3kDSmk4/6/J08Va1BcTq1VFhejiEd
         IPEV9VYhJsd9PcGiE75yZZFNYOJlPxfXj0+zOdDCPzezMflshKr8ysjbk8hynLjHvFgk
         QI6T/Uy5XgOEtTFKe0kmnE7fjey+f0M1oUlZXuNZ4m7ryRqt9nLC24FbVO2UQmKSZrOt
         5+3f8vJgSBmUZlqeJZhTn9LX1hqo/L3UCTCjmHAY1euGcAXNtCM+hhk4rgYgP9wagls5
         2JI+dvz1+UW6l2KSo4mImMi2cwKYzKnHPVfyTkGEMXxCNgUt7k3bogt2QlPoVi8UFHcV
         b1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783662206; x=1784267006;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+9Re/KEsDNt2sGvpo1jBpc9Dd0Ptp7s8KPI1kfDwE2A=;
        b=duG6/MY6rJWSHGP/nkZ2d7zuzDMNQXh8t8R2CRxjDVtLFtAE/z9OfbT+RkR352fJI1
         RYh0G7IK8/MbyBHKQsX69+MJr+8Bhzg2LJVXH5+r4Ja9vnL+D+IFIJ+IPRrS8cm5b+vD
         NzBD0H8/XN63IuIoY2xgf+AO+3OTLvrHrJI1ab+hj+POcXJvrxePr083auAx7hK3kuBs
         R5wxzYMtIgqtX7F3pU9eqBSwdtTEneodNvz1toxSKf72CymKB6Mrm5JCZbokwrLXl8f4
         jsCn3/ijMuzDf5lX2Us7Q4+bRtXxtm/BvNT9hK5M9T0VApDtxlXA1Ug+5HnRxwDpdkPh
         Yheg==
X-Forwarded-Encrypted: i=1; AHgh+RpwCSRn+4iv3uUXFw8BQD+tB0Pdinqi5lwvbc/I0arQeNP2/QbOv/KWaEFpSqAiXbSZwbZNS4smEECXIXgV@vger.kernel.org
X-Gm-Message-State: AOJu0YzLw1jiJi6WOfC9pGT+B7l1J9UfjHWi+ylxFl+1du83dgmqV92g
	1r/XKCT4wdZI6k50cihUfYBvtAP5ngrfRBvpM0sVzeFi/KGj27WMxVc7+cB3UVZSy5LYUqAHSYk
	+Fvo/DzFD3IKhhqxpjlAQjzTZm95HD/g=
X-Gm-Gg: AfdE7clhnu4WkLDADuVjBl7di93Cjr4QWJ5AGThmhmOPmpVABp/DlKdKhJWIfz1TlwB
	SW9WvRk4qwp2w88+89uPx+VCI1QiQabtX7DThorlAARFdSbcnyLC1r6/cD9ZxrhHtHka/blQPIS
	MWaDuGkEEbIJ6pFgwsQ9hkbj1zLRnUx6W+H0ZK5qEn9NHOTV70MKAd9cgQf2vOi5z8DmCK4JMkJ
	Y12pGh4T14FqbV/NV2tBJRXzyx2TOk0CZ22DU/Fdj3rCn49Qpx4xbpltEpa7KQYuaPPh1ZKkTyv
	s3fCers=
X-Received: by 2002:a05:6512:641c:b0:5ae:ba7a:1789 with SMTP id
 2adb3069b0e04-5b011464f5emr2122074e87.13.1783662205315; Thu, 09 Jul 2026
 22:43:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608210618.3437216-1-willy@infradead.org> <20260608210618.3437216-3-willy@infradead.org>
 <CANFS6bYc5uSSYWvwJZ4BgjzF0_bO9rkcFNvX2vVHnzWDi3kpuw@mail.gmail.com>
 <CANFS6bZZN6455QLhPE=yYi5fAHMt+MuqumtW6BCg__pESLiLaQ@mail.gmail.com> <CAKYAXd8qPHHNrDkJ29NwR7NrOj7Ny05vRPKzjUPckC870ULeRA@mail.gmail.com>
In-Reply-To: <CAKYAXd8qPHHNrDkJ29NwR7NrOj7Ny05vRPKzjUPckC870ULeRA@mail.gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Fri, 10 Jul 2026 14:43:13 +0900
X-Gm-Features: AUfX_mzwF_1VKVPfeVlM4SLysK1qhzKRkOCuoUWfDc1HQMXWox3yF9t2IeaLpaI
Message-ID: <CANFS6bZZjBx5GQxu+ZYVYAL5T5mG1ZRtMo9TEqEYC2FfNbdCpA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] ntfs: Remove use of __folio_index in handle_bounds_compressed_page()
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, usama.arif@linux.dev, 
	lance.yang@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 7=EC=9B=94 10=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 8:28, N=
amjae Jeon <linkinjeon@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> > > > diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
> > > > index c904858dff3d..b279f38636d6 100644
> > > > --- a/fs/ntfs/compress.c
> > > > +++ b/fs/ntfs/compress.c
> > > > @@ -105,13 +105,14 @@ void free_compression_buffers(void)
> > > >  static inline void handle_bounds_compressed_page(struct page *page=
,
> > > >                 const loff_t i_size, const s64 initialized_size)
> > > >  {
> > > > -       if ((page->__folio_index >=3D (initialized_size >> PAGE_SHI=
FT)) &&
> > > > -                       (initialized_size < i_size)) {
> > > > +       loff_t pos =3D page_offset(page);
> > > > +
> > > > +       if ((pos >=3D initialized_size) && (initialized_size < i_si=
ze)) {
> > >
> > > I think the following change would address the review comments for
> > > this patch and patch 3/6.
> > >
> >
> > Would you mind if I continue working on this series?
> > I would fix the above if-condition and add Co-developed-by for my chang=
es.
> >
> > Please let me know if that's okay with you.
> Could you please provide the updated ntfs patches so I can apply them
> to the ntfs tree?

Okay, I will send those patches.

> Thanks.



--=20
Thanks,
Hyunchul
