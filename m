Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4047A3EDE6A
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 19:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778613675; cv=pass; b=PtInvRRDRPpjBESysDL7lzn8f/485XN68gPD0Unmurs2O4H4hd76zcT5lXiy+jO1j4rv6ECbYV/7XCSZiGRb52GFUpy/S4IiFINfzBAnXWTJeUKd3Yl+pxXz98OrTYSaWbbfM6dT02wPSpZzdZ3A3hKxe7qJlidEkpFozQwM8Ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778613675; c=relaxed/simple;
	bh=nll91ULm6w2aHk9Z18ZnaI6Kevm+cuOw6+VQhhfKLeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WpfF6AQynnfKolePJm5ISZOUMTaH0IV7rfasAzRDBfxXrj6HRS0JmXX1m8OjKSEfMx8tqeiUZN+GvYjfM0Si0kzpSvhY5Yil9fiQWnOhAoHUdDVNHUa5VrWgvEt69UZC6sdGfmPk2jMig3sNJ/X3IksEbuDlfGF4i78lBjFKhv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=W4HnrVJK; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="W4HnrVJK"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-694907f7967so383760eaf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 12:21:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778613673; cv=none;
        d=google.com; s=arc-20240605;
        b=VzNzQby4CIAqQi7vBy9Fsczxxu6nvUQNMt8TToRcFaGBCJWl2o9/FZqMn4uTJQobKc
         LB1QFapIuwVCssDNncMcM3Zy7UWdK+WIazGJ3SWFnXMl3xo5+8YOT5HuNuib9m14i0X2
         nwZWyyLdWUMARIGF8M0mf5VL8MT9pKEOK8EOrSVGv3uyJx0xiJ+Uephz1esUhRSxdDXF
         moNgdLBfq2vxFmpuuS6h40BYMc6vUdbpITrCrz8iNFTTdNh5H3DPpBaMgf1njvoGxt1Z
         4fs/oo8ln88ArS2z0kPUWyzU8AMlxwEAr8g/Hm3nsWsYyC6xTEiVnQXfhgQLqmhni6Qx
         fJSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nO3qnWfhbRxzX+PzpSpdWAjHeYnC8LurbOKJOZKk+Lg=;
        fh=mVUPQIhWY05uYD2F/FvwFrBHFUEkzY4AQ45dE5BS4s0=;
        b=dgMz1LJV3QfRfVt6DOukDK2WX0t4D4cp+/GKEYHqwEwTM2FzAHdhZpIDM4g+rxlKyp
         hjVOIZ5Cdzur4eGSsYCdxmjYY974m2KD9HCchPSBOcDRidMTZGfKV2dP4L3n/Opr4Skz
         M+BmCO0iA5czqHzRsXWMHDhJM0GT8uLNxVd5GdW3Fnci8LMalSDeEiGWFwxCOpSdegAr
         5GIbcJgYhGDUdwT5NrKNlORACRxk4fQgKasRl0t9PIsoQZrkAw9vD63e5xxsW7iRVoT5
         mXqs6cWZzi93jDhU1kO/gfGPiWRbd3XWhD5nmzKD6gixU3sPR/HyicGU2LOFASNRwswE
         Mj+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778613673; x=1779218473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nO3qnWfhbRxzX+PzpSpdWAjHeYnC8LurbOKJOZKk+Lg=;
        b=W4HnrVJKCyu4I17/DkGo2/lcuHGcx2K4xJeeHUcDkBp71WiAhIhH6SlSJNNLhMcYNs
         JhZZZLajy9pexHsnycEMKlPTtAiCO8qQo40AVelIpf12hbBTLGZtjgr59jdicq6pL3MG
         gkthr01U20Lwve6ZM0mKyEgXxdO9Sp72XLlhss54KRfpFFbMBQ4r4E0E1AwB95g3docw
         zaLn0hXN6Hktfbj/RVg2NP/U26KdZlQk2rcYKus2RbdMkir2X3LLK1T1iNOofFpwlcg3
         Xo46vGFXAeibumYie/Rvq/nD9GbwGNcQWh9r8gS7RcgGSkuZSI3Pwt6kTCLukU1bZcbo
         okZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778613673; x=1779218473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nO3qnWfhbRxzX+PzpSpdWAjHeYnC8LurbOKJOZKk+Lg=;
        b=TkqFWPuVJjoO7a9tYqN4SDjvrjVoU+8eyG/fQOEzIZcLz/vMwFXzAOhylmEvLdPurs
         iymzo8ogvUoXok3I5LaDuvB6Lpaws46brtKFiXsWvoYc10LY+BvpynEPVV2ZTwY+GK22
         JFgR64QL6jElCpeKqAXZzcx3VSjzr/VG1SU2Xd4JQdy8xP3GH1olVf/nD69OepIf4S+M
         h/vy5JYwXWpEQM0AcJjW6gRe3afGI7Wlf/OsFcV7LqFLmv1+oKPIkfgNni8XEz5Anr+/
         Tjb5XV9P+KFFbBDPsZ+vM/sTZUFt1qe31K3ZrOucHBA4wt9oL8pwhJ6E+ivgUFkTfqiG
         3grQ==
X-Forwarded-Encrypted: i=1; AFNElJ9+iNv/NVTTNahgVISnJZxFq67o0GVAjIMR8n84eCc7iwkQlntSCI+CV6A3QfFF8JUr5eNGn4fr8d8I7ZZq@vger.kernel.org
X-Gm-Message-State: AOJu0YzFGIC/6ma3OoQUZoZyoPxpFlyLu45oVQEeTqpLg2+ylYzMubGI
	1rKRZj5GETN6EjnQHLc65Rbj0yDef6W3527lRZLrwzt3DjPgMeyihaI35E2e81xfEejjcMS9B9i
	n0PPDBfKL3yCi96O/B+mM4v20iCXSYzKjEx04F6VAlw==
X-Gm-Gg: Acq92OEer3q1NabahkkLyasCP7fB36xw++cNHjJeznry7m/gnBV0QqlFPcOfwZ5q4yr
	uOhAXKMVX2D3ay0SYyekNXPTz5uWYoCMOPeTEFKwpoq0nAd1G5dAn7Z7o+1yyYRHAvyW6SYoSwO
	yrIy7OGzvXZ8Pa5eCt7qHVIp5JcRHDScnSdb1D6BKZrH6rXQTONABFXYZNk2O/Sgc9TgIGfWew8
	dG33v29cm3GHkC6wgg3lzzjyol95kIROGtDcQsYUCzlvJNb/LtzDhxosjP+4UsGwlDmhv3jaP/j
	L1JFC7FzUDhvx3eQoKg=
X-Received: by 2002:a05:6820:55d2:10b0:694:8ed2:9bbf with SMTP id
 006d021491bc7-69b78d98e1fmr26675eaf.2.1778613673210; Tue, 12 May 2026
 12:21:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512170525.357573-1-dmantipov@yandex.ru> <CADUfDZqnV5BRwZq3c3Atu8w3gOm87AbmtexL=MenWcSbTVOgvw@mail.gmail.com>
 <26c1f22358ca894945dbfb8b7b6376a8a59229c7.camel@yandex.ru>
In-Reply-To: <26c1f22358ca894945dbfb8b7b6376a8a59229c7.camel@yandex.ru>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 12 May 2026 12:20:59 -0700
X-Gm-Features: AVHnY4KR8wr161beKIFztTVzYdNB9ClF9w_gJXdqgle_01-EMcDGH2azbqJmguw
Message-ID: <CADUfDZrmXfHFV3k=m0+0Jmpd3dtx=pmsEefwkAunQt1JbQnG0g@mail.gmail.com>
Subject: Re: [PATCH v2] lib: free pagelist on error in iov_iter_extract_pages()
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Chao Shi <cshi008@fiu.edu>, Weidong Zhu <weizhu@fiu.edu>, Dave Tian <daveti@purdue.edu>, 
	Sungwoo Kim <iam@sung-woo.kim>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 11:45=E2=80=AFAM Dmitry Antipov <dmantipov@yandex.r=
u> wrote:
>
> On Tue, 2026-05-12 at 10:46 -0700, Caleb Sander Mateos wrote:
>
> > The mismatch between ret <=3D 0 here and ret < 0 in
> > bio_integrity_map_user() would result in a use-after-free in the ret
> > =3D=3D 0 case, no? I guess this should be fixed by the "block:
> > bio-integrity: Fix null-ptr-deref in bio_integrity_map_user()" patch
> > that landed today.
>
> Not sure about null-ptr-deref but IIUC this patch fixes memory leak
> at [2] but not at [1]:

Yes, and I think your patch would fix the leak of pages in the ret < 0
case. With both patches, ret =3D=3D 0 would result in calls to
kvfree(pages) from both iov_iter_extract_pages() and
bio_integrity_map_user(), but the value of pages in
bio_integrity_map_user() should stay as NULL, so the second call
should be a no-op.

>
>         ret =3D iov_iter_extract_pages(iter, &pages, bytes, nr_vecs,
>                                         extraction_flags, &offset);
>         if (unlikely(ret < 0))
>                 goto free_bvec;                                 [1]
>
>         /*
>          * Handle partial pinning. This can happen when pin_user_pages_fa=
st()
>          * returns fewer pages than requested.
>          */
>         if (user_backed_iter(iter) && unlikely(ret !=3D bytes)) {
>                 if (ret > 0) {
>                         int npinned =3D DIV_ROUND_UP(offset + ret, PAGE_S=
IZE);
>                         int i;
>
>                         for (i =3D 0; i < npinned; i++)
>                                 unpin_user_page(pages[i]);
>                 }
>                 if (pages !=3D stack_pages)
>                         kvfree(pages);                          [2]
>                 ret =3D -EFAULT;
>                 goto free_bvec;
>         }
>
> Dmitry
