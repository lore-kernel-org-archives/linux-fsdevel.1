Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B913F37FF42
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 12:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779367716; cv=pass; b=Cs+90IUewUzcBR+xQla1/NedYRQmV9D+t32mhSQQBrDnxdkcJc8BHrK2Tp7osO5mXPZfTZwRHQWUGIctgPVkrLJAb9VlkpPjX8fe+9Mmm7g5TDPUeHvZilu/+CSlgkgOJoXXXDDa/sTKkpvdEtzooBZer6pGKgsyeRRIjUDgZts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779367716; c=relaxed/simple;
	bh=wXgFJ0QEwOAX606VR2Z3OAxNnPPTK3/ujlGfL1Shfns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rsvtou2l33obm7DPnZBdk6YVYxobqPHPV7kY5PvIKNrIPNH5HnvkA0scdDj1PWwS+sRrdC6aHt/umKq+txCm9cljDQ7/V85/ocY2UePyOZYWW7CTQ4dAP3LXw+rM5F4qBnUD75hrVbtBi/wfmyembqetKtSdGlivCuqmJg8FcXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKwBuzgZ; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKwBuzgZ"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-651ce87d785so566706d50.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 05:48:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779367714; cv=none;
        d=google.com; s=arc-20240605;
        b=UYE3ZBSYh/iF7C4g9Uz8T586i3RNk2RHtegSAMyHGtpvD16dJWIX7dNwUFjJLv/M4A
         oMKf4hZ0s9XzqqguLkZOwsOe7+tcFNxhmn/98kHSNj29h8ez5UVSoMJPh2im5/UwB48L
         hoKU3hrbzcz/r8hlxGRRkk2lOGpUfkL/XoY6ugwE09kQ2kqFkR0q2XNYrCQOfJsoCOIU
         0rVf0KbXu+KCqowKiCKS6hmUxZwJETJWefuozyNdprG4jvFgq2UNRr+2FZm1vORzfOKR
         7P4Nbo9V2dwjESa87VzccIvbt+A5xokjKzFaYCUeabLOnY9K0mVEXSufGzV+PANEl3TH
         tf0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bhH64AcohOQ97D3Lp/oawtZDe5Yax58Imt0i4CtV51M=;
        fh=vSunDo7OycykUVtY2iNLqn1dg6c3v2+09N4gR1b58PQ=;
        b=DF0bZ3Tixq/L/ZuJb9IWoVxT4M+wKY4VNr4vx+u2B5+yca2rWgz53HK9IemJyVtQCm
         /DFwEnKcoFe4cb7hyBXaAwddTT5MW6XFeix7cgMe6ShAkUqgSwsFikZW1vU0PeiKdYuL
         F5oX3sKOJHJLJM1Adn7xswOisraBEG98MC1bH3BO73ossicnHZ/uBmlJtMV1h+Tlyj0Q
         BD4XYUrhQ9uB9AvB11uWOsUkr6e5CepMVVLZBwpGpMVBwypcfHsJm5C457yM+8FrFJBK
         Lz8iCSvWSXvRkf7GkX8YPovjN+bwvLSSD0cI1BHAyV4pBrEqvQBVeFnwDzKeNuKUIWer
         xvyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779367714; x=1779972514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhH64AcohOQ97D3Lp/oawtZDe5Yax58Imt0i4CtV51M=;
        b=iKwBuzgZb0TVDFIMoUDKlizn4mZA13sLxlFDDWzQHyFfHhEQs1WolYLCx/Bii0sr1J
         jACIKHsR/yAn3K6fMNNvCIibAxHKsOd10UnlioWdRgJIyPnE4DXAla5AVNmkKFzpprni
         e8rX8fcylHxZKMm7LYeTu4WSTJglFc/CwatQ4NcGFE5pgWLw2nexB7+5wGf6ZPU6grJF
         K+/RN+Iw9x3OneniDe/yuUlRTKCmR2BMzw77ZH568qy1nS4Va9Bl0K3ZyiTbRoDEk+WB
         MN9MGFbpf9gESiJvIrcL5jl2KzrR9TCpc2xWoQ5+z6oqqE7A1pVT2gYZcwrXH1G8wNCK
         T+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779367714; x=1779972514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bhH64AcohOQ97D3Lp/oawtZDe5Yax58Imt0i4CtV51M=;
        b=Aieb3KrgaG5X45kRRwNeUbTPVnit/BpJY07zFuh7UDNlsznJ8v8natG2dUUEiNxp5k
         IlzqOjjxlL1pzTc/Z8M1LX0yzbXrTSawD9kfw17zcumicDomhxFP2OG/8q64N2N/a4Rw
         ERSKvJNR5czlJlIqD6tw7Rgg3wVijno6pTirZ8FDnf6QlNEMBhAEna11Qyq4D54n4eJX
         luqOfJewoukQjv5a++ppWdOrcdhgV1ZHDhMpDMNhfmef9Ttjdxm89uM/XHL8g3IaXQD3
         8BuCr04Ht9wf+0Cguy+m5GmxYNxC5NYOVIWs7xSDLjhuFLqroQR6Dc6Fo1XJCvV7Jbpj
         6ylA==
X-Forwarded-Encrypted: i=1; AFNElJ82BqPJXRck4Je4zvqrVCqligCe9+/9XvjWBkvseywg8Lw+eFFJEORlQrSYJ8kN57yrzqXFh6ON9BGTNmze@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8lZ+9nlOPjasBys+JVH0NtPyWKDPIP8A+EXkOaHJTz7AV4FWa
	1j0KpB5pMgGK4dams92tvMXuwQb3q+ZxjjKrOVmw9HYU0J/+hDXOqw7NV5Af8Kd+UyQzsMcFLdX
	DwTqyVKvWLEmnHjXkHjiwNt31HSp98gM=
X-Gm-Gg: Acq92OGDSjQxsT04V782XGAQDHxaDpT360lTk9PxGbU5O2shKnf6hlCWGgM6PWenjia
	I2SBa7OM42ElRmL+8zRZ0Il3nMzro3RZkx2M/evIW6vqNzj6z5hX20KbSZ4QFm10SMhDtH9Iguq
	fwn9biB/7omj9TQehNPJyribavB/OLvTB7Q3dEhg7matF/+2LkOVaTePiOFamdMwoo4sVIRI0cT
	kZIe+L4Rs48APsdITWgi8I1dMIGEt2VOt5cTR2pNaslVvbMx6E8dSUVQOPnx43xNU1XEuz0zTuE
	R1W/SN6c9ZVI6kGA8ufq
X-Received: by 2002:a05:690e:120d:b0:651:b163:fc88 with SMTP id
 956f58d0204a3-65eae30cc3bmr1597919d50.5.1779367713703; Thu, 21 May 2026
 05:48:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520170151.4115308-1-charsyam@gmail.com> <20260521101751.591345-1-charsyam@gmail.com>
 <20260521101751.591345-3-charsyam@gmail.com> <CAKYAXd_usY7yTjFt92r5V4HGn_RTR2mhu7JFbVxSjttYivzrSQ@mail.gmail.com>
In-Reply-To: <CAKYAXd_usY7yTjFt92r5V4HGn_RTR2mhu7JFbVxSjttYivzrSQ@mail.gmail.com>
From: CharSyam <charsyam@gmail.com>
Date: Thu, 21 May 2026 21:48:21 +0900
X-Gm-Features: AVHnY4JsLfLt_Ed9u4SRAGlLkO9rPOIWM9TzEbTeYwVv0Svs4Hf9rxS3DH-rx3I
Message-ID: <CAMrLSE7npNDECFg3qnX6NKXUoXYps326GN=BnBjKxoUPciuDzg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ntfs: avoid heap allocation for free-cluster
 readahead state
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namjae,

Thanks for testing it.

It built successfully on my local setup with gcc 13.3.0
(gcc (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0).  I tested it on top of
mainline commit 8bc67e4db64a with CONFIG_NTFS_FS=3Dm using:

make O=3D/tmp/linux-ntfs-mainline-v2-build fs/ntfs/super.o
make O=3D/tmp/linux-ntfs-mainline-v2-build fs/ntfs/ntfs.ko

However, I found a portability issue in patch 2.  I used:

struct file_ra_state ra =3D {};

which gcc accepted here, but this can be rejected by stricter builds as
an empty initializer.  I changed it to:

struct file_ra_state ra =3D { 0 };

and re-tested patch 2 alone and patches 1-2 on a clean mainline tree;
both build fs/ntfs/super.o successfully.  The full series also builds
fs/ntfs/ntfs.ko.

I will send v3 with this fix.  If your build error is different from the
empty-initializer issue, could you please share the exact error log?

Thanks,
DaeMyung

2026=EB=85=84 5=EC=9B=94 21=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 9:19, N=
amjae Jeon <linkinjeon@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> >         /*
> >          * Convert the number of bits into bytes rounded up, then conve=
rt into
> > @@ -1985,7 +1981,7 @@ s64 get_nr_free_clusters(struct ntfs_volume *vol)
> >                  * Get folio from page cache, getting it from backing s=
tore
> >                  * if necessary, and increment the use count.
> >                  */
> > -               folio =3D ntfs_get_locked_folio(mapping, index, max_ind=
ex, ra);
> > +               folio =3D ntfs_get_locked_folio(mapping, index, max_ind=
ex, &ra);
> This patch causes a build error when applied. Does it build
> successfully for you?
