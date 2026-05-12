Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BDD306745
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592191; cv=pass; b=YKYtLKiA+XbLlX9p1D49ZjAczCy7YwpDoDc4C1eJ3FG3yN4JxkWK3oZoVVy/AN9ysdkS9ptI8xcwDNoKvitdHbhg9paKiR2yZra8RZ+uAv5G32q4DPLsRq4JqZDM7ex7X6xpewdmyswW56VjGOkzM/YiK36SyQ0IP1PwL/+0obM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592191; c=relaxed/simple;
	bh=oLNne5cobDJZx5zkoUSLGFP9qe8rytYx2dxIodND2sk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2BX61ZV9SjeJqmiI67SSAvxL2gy74Gelahiszpeyyi2G7pdc9zUh/BV6mV67OmjyNjK88E30iCWdAAtDJUl//Tcu8mA2iZQaemRJOk2jQ0gb8ggOHq3+K1BZMctAEKEGNVR0CnRbt+3ZsU4G3MEWgAdezDpD8WYw3NLS3wluyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7lItS+f; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7lItS+f"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-651b71f5cffso714221d50.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 06:23:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778592189; cv=none;
        d=google.com; s=arc-20240605;
        b=TMS38k0l6vmIQRAaxsh9tO3eIkPg0fbTOk4shLehx8+8qvEh5OvB+xDCfXgpg/c8Aa
         bI0Ye1kBB2JhJRW4Y6rKyNesfE+eNvlzNiixUw3b/Zd1IQylFKXx4sU42MJxKNEmbl2b
         nxMloeVhRLjs3Sd0l/11ksksuO/sS2wfaVoCRNg/L3f34bvRWlB0yRa8YXWWmhi8ht7A
         pSfSSvRForfJNGjRb3ytY3qj4h60Cm5xu3kIecI8C9ZcjiBIRRsATuGg8wpeqxUUZFEJ
         ThSli775lD1yCFlKN7AXVXX5vnd/IxKCoAkZcUrj4LStRxAUm0njXO1MiSfDN41pp2By
         xNVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QJPBnYs94tK7QkuXGsl4iBCO8CLdE5ARLqd4Db6XIiI=;
        fh=Vxu/QSl0yxbOOTQtbiLIXM3CHR0wKgMD0JLxYPqwqEc=;
        b=VhgfvkWZEb4HcU8f8UjifxkPnTi8u3oH91mwcdEwd8lOC3GtlUaXnwjrMrRgGrEaU0
         znpedJn5TD7Gf2IHEYLYK/8Lmzw3xpucUBZz71Csl0EHILLpPSAFztZYTOnuhrslNMNB
         nAeuoLxEpkmdrZYxSrZFgyk5FkEIK4B0dHIv+EFzQYNqAwKz9UlQ68Xxz9rfHl3xSRFs
         1RLKq22b6kfjfLs/RCMMNfShGKPaztsZt97/UZwG1/CPcyKeWqufR2/enWPvwIA9viYA
         QAP79FGsVZPcM4peDpF00S0gJui7O0U21yvwkYH6nmPhXeHuTH5w5PVoJl36odEy3Jdh
         vULg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778592189; x=1779196989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJPBnYs94tK7QkuXGsl4iBCO8CLdE5ARLqd4Db6XIiI=;
        b=N7lItS+f7DWAjNLR2qC5vPqEH5cDwbCGT9nyrQOWTH1ixmkV4xQTwLkaY9wyx95xSH
         G2PlcAa8SGed6AWdVjLSVFUXhDiGBD0W3L1LQ2GwjBXrqYAslVI0bxXOanaCZhQKId/J
         sunNNGoOT3iMg8LJ5DhnZALN3hoY2hQH49KP1pILl1WBWCyYRbFojajJSy/tVPyi5kzX
         faaypv7neCLq73Ve05Y9HC/Zpjcrj2zuC17ExODCQpcNt3zvcajqHQ7kFPNudDuZBcVf
         Fp+Nb7x0Or8CYCJF93b3QE6+v8U50bv41GznUrm/H2FPrnIY+1pXDYFdmd+EQdxQ25RG
         zjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778592189; x=1779196989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QJPBnYs94tK7QkuXGsl4iBCO8CLdE5ARLqd4Db6XIiI=;
        b=TRspyhhEnjLocbJsMvd3tJWKip9JO7i176lyHa96GQfpdkYmqah4/Brw7v1Fh7tH6h
         9RyVmCBMA8WHzKvMp2yj66NrbHfFBDdHjJmG0tAZP6RmblSinLaMxdsl9JlZHD2NcjXS
         5qbWKBf0CwS+b34Djsyioj6woP1jeCowNtYl++faprtHJQiQFgE42Xhju/SbT5VVWaGN
         OGJBoRvSSQn3QFH/IeFLyV1RnkTs4ooBOyABITxEfAUp1uRb5+G4+ewFfe6y5k7HqWb3
         oQFxqy1DbxhLamjEoM9LlRBrMTdPmAdYUsJ1KPRVMjxPCxFV8AxIYvfShAWhmKs99vsZ
         /qkw==
X-Forwarded-Encrypted: i=1; AFNElJ/fAt+hfwH8Cq1ogtWeAJRDz92rH4hZXCYP1i0EYjNjSD64Q2v5JjdRso0KBnsdDUak0UMxA34QrpRPiwY4@vger.kernel.org
X-Gm-Message-State: AOJu0YzxS2USNV1YwizMKipHVjC34ylVK4fgoU19iSXmjiUSY9VW7gji
	2iiAe/qJoLXR2aTrKa4PMLHZmuAH8U/1ctVudEewmnJlhBAzYr0hH0l3Cg0c0vYioK5aXjE5RR1
	xBi95WySySywf0l6fqhoFuulrQ6vdUec=
X-Gm-Gg: Acq92OEmMkPsAddXG2ky8L8PyVRgLlAmuSKw1QOu0C8QCiO3Sm2yqsu9sOH++pXKBr7
	/TPu4MqYyo0jVXCO7OHayMW/LvTvPqJ7c9WeuZ5lIzOh9Xbhuz98R62Fgm2PMtP6bLrFHVOqa2d
	GSj7qVmKrW6aMxRFq/endLdKE+M59OgkXfJy20cU5dAD3zTv97OZF9bKkymIsuTZjt/f3rBnlx6
	98K56lY0IH2TOd5MvMZOolGKdGUflsB9OprwP8oKI6WNj73PKQ/QJQ5KxUlNVLsA/hbq/ECzgbp
	vSygLaGl
X-Received: by 2002:a05:690e:128f:b0:65c:124e:61ce with SMTP id
 956f58d0204a3-65c796f49e5mr19234437d50.0.1778592189338; Tue, 12 May 2026
 06:23:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512123404.719402-1-dhowells@redhat.com> <20260512123404.719402-9-dhowells@redhat.com>
 <CAMrLSE5jFZwmUrx5GWhz4AD9QpLsF9VsdaMJxiDa6ukXqH8RPg@mail.gmail.com>
In-Reply-To: <CAMrLSE5jFZwmUrx5GWhz4AD9QpLsF9VsdaMJxiDa6ukXqH8RPg@mail.gmail.com>
From: CharSyam <charsyam@gmail.com>
Date: Tue, 12 May 2026 22:22:58 +0900
X-Gm-Features: AVHnY4JVdrnalD3VcY2gJzGM9eUXbqquyOoAkwfHaKwpTwhqh9XLF19h2Tihueg
Message-ID: <CAMrLSE6Ff-_Kuyk44U1kbe6gjaeLuXanXUoBA5As69EYhZzw0g@mail.gmail.com>
Subject: Re: [PATCH v6 08/24] netfs: Fix potential uninitialised var in netfs_extract_user_iter()
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, David.

Sorry for the confusion. I was looking at the current mainline code,
but after checking
the version with commit 8ef352bc015d, I agree that `ret` needs to be
initialized to 0.

Looks good to me.

Thanks.
DaeMyung

2026=EB=85=84 5=EC=9B=94 12=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 10:07, =
CharSyam <charsyam@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi, David.
>
> It looks like ret does not need to be initialized to 0, because it is
> only used after being assigned the
> return value of iov_iter_extract_pages(). In the zero-length case, the
> loop is skipped and ret is not used at all.
> What do you think?
>
> Thanks
> DaeMyung
>
> 2026=EB=85=84 5=EC=9B=94 12=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 9:43,=
 David Howells <dhowells@redhat.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > In netfs_extract_user_iter(), if it's given a zero-length iterator, it =
will
> > fall through the loop without setting ret, and so the error handling
> > behaviour will be undefined, depending on whether ret happens to be
> > negative.  The value of ret then propagates back up the callstack.
> >
> > Fix this by presetting ret to 0.
> >
> > Fixes: 85dd2c8ff368 ("netfs: Add a function to extract a UBUF or IOVEC =
into a BVEC iterator")
> > Closes: https://sashiko.dev/#/patchset/20260414082004.3756080-1-dhowell=
s%40redhat.com
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: Paulo Alcantara <pc@manguebit.org>
> > cc: Matthew Wilcox <willy@infradead.org>
> > cc: netfs@lists.linux.dev
> > cc: linux-fsdevel@vger.kernel.org
> > ---
> >  fs/netfs/iterator.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/netfs/iterator.c b/fs/netfs/iterator.c
> > index 154a14bb2d7f..6903028b7162 100644
> > --- a/fs/netfs/iterator.c
> > +++ b/fs/netfs/iterator.c
> > @@ -43,7 +43,7 @@ ssize_t netfs_extract_user_iter(struct iov_iter *orig=
, size_t orig_len,
> >         unsigned int max_pages;
> >         unsigned int npages =3D 0;
> >         unsigned int i;
> > -       ssize_t ret;
> > +       ssize_t ret =3D 0;
> >         size_t count =3D orig_len, offset, len;
> >         size_t bv_size, pg_size;
> >
> >
> >
