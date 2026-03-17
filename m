Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2143EB7E5
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773762213; cv=pass; b=p33pRY8uNhr7R5yKF+HtN9wDXeHbQUJFvLcYN28gouUEf9f9ZIwivasBDuUI5rWWVjgwh/4Hpsh91u+jDgrf1jWgOCzOxm5x9s7Cr3tSaNap8yS780weZinnqP6MSOx6WVhwv2WeEtYRh82pxl00AcUbyZ7863Roqn4p3T87Thk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773762213; c=relaxed/simple;
	bh=zoWpZVpxO+/H8XP41kuyVhzrp9M7ezO6XxJOR++kzFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=awiXgBmNuM9JOhU7qRZytWWf82urtf/XSW9ocA0e4FAzzhkxmuf9e2mEId9p2ziGpAeg1nbrJx55pUuuvQ4x+ADHGLqi+sJ1n+4/6UCtK/KVO1tcA7qyMEjOIFea0w8B/T5Y9RFfBr0qcYYA0Pef0eX3LttQ0e8kHK7tfQoXIlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSLBVQFw; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSLBVQFw"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-824c9da9928so3774468b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 08:43:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773762211; cv=none;
        d=google.com; s=arc-20240605;
        b=d5CdbvDKUlY0qOPOfex1SocBsPWYk92rSWHUow3TNyJ3hbw07ZUKk/ZNAV8QwABojN
         SLOxPbRLpxAyxkM6CWIRGf1hNQZrVuPH8w5q5Rogk756w431IgcFeV5SPiHyLiwCNWxA
         6Xx2TOdwmmvSkEIjHvVZakUOQhBmUYzgGjPCWnv2HwlxKPuuiZihe6mc+oulxMxBKHnK
         YcHh0KpcsLGvFX/I16GgkQKco/ife1ROjZVK3eVjiVvZu+4Jg83HtWI6QNlW+pfirnj2
         fZlYeK5KgRyFQUqWJRp86psYLJrR3BLGZ2oSFTFwBNlJIAa5QByu3lio04LjKGYQ1qcq
         7A9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zoWpZVpxO+/H8XP41kuyVhzrp9M7ezO6XxJOR++kzFY=;
        fh=9KD8cl2HVvgAJIVU2sW/SDDF2X9Dkp8onr63X1rDNBw=;
        b=Vzhs5GbPa+0bODDsKeqatvYC0emhz1I5Gr8m1iwf5rgA8eC1JTQ6C24e/SFbGZGyy9
         EmKLngZus5axSyuL+Yv1i6FahY3Lumwwwwr5EiemxFe1ET+afTwcTWGMyiPfwScleE0I
         9ViNF4UvolMVmqkT8ZKFKB6+W5kzmBc/YrAkVaeSKoLTSdrMKjNzPXd5ZFut9Fy5e0X/
         D8CKmZ4Cg59aCIgXnv3rjpozeBRzbfxOn4LCmKJ3MgffARBb6eUpMLutvCPdyPgmuTky
         7TKAhJtk7ovfWaVAC7dbkHCpz7YnEL9b2xY0MXsscSdbN8syl/SOhgh8AE7cCKFR3LKP
         ZaSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773762211; x=1774367011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoWpZVpxO+/H8XP41kuyVhzrp9M7ezO6XxJOR++kzFY=;
        b=KSLBVQFwxwafUtO/177Cnez9+yO9XugGJPoY7E12wcR84mVd3eUNHN1t0uCXX/C+LA
         i3SQh/KoJCVnkotwk5WM2NAkfFnjNVcFv0ln4Keb4hqHk2XWHnEIA2LcUjIu/4QeOkpS
         RUInYAvNEE2dE9Y/uyZ7jUme/zf85PAqU9PTvse80tmtq1prdormg6uaOoiYQxTJJHEf
         C2qn9s2pP/0hbonbF7/At6aMlApib197ft3QDodsI4fW6tW/VZmj1L6Qtbi3gTmvA/ys
         Y87lambac4nys4pSHEAdEOvaK6wGKerm/gWe8R3sfxcZMKd1oz4VKPAiaJjiq7spOPKb
         xInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773762211; x=1774367011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zoWpZVpxO+/H8XP41kuyVhzrp9M7ezO6XxJOR++kzFY=;
        b=QnyFSzXvubsA5zwyKkvWPOOWDZahXPgHy99wFJjw5ZPqXBTmJ0CpuXOjGoRv45fknf
         dRki4ZBBU6OdZQuo1FzuskrDkIgwIe1MwSbLS7+AIw6QYo9O8RsGk730D8WeeaUTwTAr
         HpbaNT162QwfUP0Ok33YHBl9lYGv7Mqc2FLFlr7uesvo7+Jalw2e9PmEZEoYIxeU9iM6
         Uz/Eusk5Mlfk0EiUL3HDy4nHThcVcG+VURZYPPcR1NZrdt5HaKDgX4HEp4dlHyXlkoDr
         wFPnkmzUB2TrgOCwHupBudSldBoTMg/MWWlByg+jWhQiqeuKY8WHXks58fpR/3uqAus7
         XxhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVd3FYBG7r1fkAlzwMkod4HLqUM5ER6WG0y0BDQPQhy46XdM9EejWwrY8Saof7GLxEzxxq2YNDscjharovz@vger.kernel.org
X-Gm-Message-State: AOJu0YxxrWBFrUdipzI+TrO2N+ZBQQ874SgMevjgzAkNsUIvT3/e4qz+
	sgeLCrSzyoUJi3ZZlwKrwOTu68bxnuaw0P1si12xHY83hAM+sweKs1Pp3mkG0rC5yYq3aG8j1Oi
	+rPnZ1zHVaqxgHwyd5AQiVfllKIJ1xT2eUd1ghEg=
X-Gm-Gg: ATEYQzzHvG/dGsRbhJv7bnU5q4mz9eAsrz2hiLcjpgyL/V7+UBlOV5WlpNp87QYKllE
	f9okw2RxyRjhSeaQ6IgzW2offwUuQzEWYrP6JP5BsbudjTQZjox1SrWqZkL+7TP5imyuv0hxpf2
	10q+gG2DJGksQLkLx9JT2qqmS45m5abDo4dvvR70Eo08d454jnABjPiyn+i0w28uYIs9Odpt1tq
	Hrq14M8MF8AWbDpK9SeoWkqq/yOqXzGGL6JsdJwJjXJujmUa7dloe7VasrfOjHsOSEdzDZHDzPQ
	q+C4Cg==
X-Received: by 2002:a05:6a00:2495:b0:821:78ae:9dcd with SMTP id
 d2e1a72fcca58-82a19703f47mr13666809b3a.13.1773762211354; Tue, 17 Mar 2026
 08:43:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317054556.1821600-1-jhj140711@gmail.com> <20260317-inventar-wirksam-11bc2443fabc@brauner>
In-Reply-To: <20260317-inventar-wirksam-11bc2443fabc@brauner>
From: Hyungjung Joo <jhj140711@gmail.com>
Date: Wed, 18 Mar 2026 00:43:19 +0900
X-Gm-Features: AaiRm50FlHlLYQm8nMRsFhxPE2hOVf4sa6FB_dtKESCbaveT78-xAh5GfOKcUGo
Message-ID: <CAP_j_b85YA+h04Y91zWfmXH83+CQv5DiaJjbDF4DH+KPV4U-AA@mail.gmail.com>
Subject: Re: [PATCH] fs/mbcache: cancel shrink work before destroying the cache
To: Christian Brauner <brauner@kernel.org>
Cc: jack@suse.cz, greg@kroah.com, linux-kernel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 3=EC=9B=94 17=EC=9D=BC (=ED=99=94) PM 11:38, Christian Braune=
r <brauner@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> Pretty sure this is AI generated and it misses a Fixes: tag but otherwise=
 looks
> correct.

I'm sorry, forgot the fixes tag.
Below is the correct fixes: tag.
Fixes: c2f3140fe2ec
Cc: stable@vger.kernel.org

Thanks.
