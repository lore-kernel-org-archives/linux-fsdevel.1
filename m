Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2680634A78F
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 17:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776100342; cv=none; b=XbdePWQU3jx1bSnrqg1Mzdek2TCSP7Ny3EO4FoJ9TWeTBQHHOS3wVryPHIXe4QL9gsubfZs9OYdV5glpCr0sN5jP3xThD9MRVSaY6bWDUkNLiO5rdRkBwHtut9ZGJxQNB++veScAuCUy1mJhhLACPgK1CefeUDRt2B6+i7r/FzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776100342; c=relaxed/simple;
	bh=l0ibTDd9T5SAnR5tj5XYYPzpx9gVL3HEGDENGJMZRhw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c2ipmv+lWPiDhc83BWCU9/1itHPweWIP3oABvFMHi+ZCAirUebmcEEUwreduVTB2ltjaOwvGbTIpYr9IAyLjOe1sksd+E15olvsiRaOWT600pQv2jngRB5GLqcVV5ePdQDsc71TGIXVROCzGCQZtyfd5g96m0VMOsn6nKv0cZB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XB0rB7+J; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=S3u/fl6c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XB0rB7+J";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3u/fl6c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776100338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c1oOyb1XKWKz2gZI0SCSYBVOAwAVmOuvCceYMH1PDC4=;
	b=XB0rB7+J6VKzmaTobrzRyEKRsx/bNYJM/cS38fMTSpNeIY1WmjOK63Oggu/LJgFOWBnt8F
	Qia2jh6X6AIellUg0Q/wzR510HSZ3IHElB+vurSTW3Q4Ug7ts8cHXJqwhzdoVGdNIFO/EK
	HAGjXJmiDDnu0RYLD4x+OzbRBGcFkUs=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-t9fW3BnYM9iP6LPPVTvQDQ-1; Mon, 13 Apr 2026 13:12:16 -0400
X-MC-Unique: t9fW3BnYM9iP6LPPVTvQDQ-1
X-Mimecast-MFC-AGG-ID: t9fW3BnYM9iP6LPPVTvQDQ_1776100336
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-794b240c0d3so148602117b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 10:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776100336; x=1776705136; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c1oOyb1XKWKz2gZI0SCSYBVOAwAVmOuvCceYMH1PDC4=;
        b=S3u/fl6cCHqMKoY+ImAKb6IhUmwFf1oBLV3Ke0/j/HQ2A0NzJZ46qOW4gB1v1peT4z
         njxupyJw+zFpZurkMhZT9q3mPa9eT2f3M8ndfhodUQA/17p6pryg6FAq8M4BkpEch3Dq
         3PjuhnsewGArp6jaUl4elW822pqBERNgOYMoC0Ih0v+JXRwFmCHpn32A6bQ/MdMlq7VV
         0RLtacQbVz1SIB2AxhjZc1sxdlP4PLPtdBjGTRCOiTsNJGwN73gtA2Nb/5lyoz+l1PSz
         cFrBsED5Tkca2k8KusyxaVUFrIHk6Zg+RAjIKGuyUVlai3Nji8yD24byUXNQSDJVZOJB
         7v2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776100336; x=1776705136;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c1oOyb1XKWKz2gZI0SCSYBVOAwAVmOuvCceYMH1PDC4=;
        b=rTeEE7ZPdsn06Hx37QhsHzVsgo6YNi5nqp7VO1yrqe5M9Uo2XK3IKRI8w3IfANjwpH
         UJsDQnZ8gAPyCy5TAx2EHvcMWctrZ4SLIdW4gVKERwYH5KBlM7rQLk2K+krIME9bU0Pu
         8Sx4yLbC45WtKgMEoXvsvF/CZ+kRUxqMQ6IKpsJPVh4TYHLvOJiPYNcgiw1lwBIAu3bi
         oubEt+HmcuptI7t3+Sxgs3h/o+oBaK2bC+PDqO8rVhz9AOwAP649Clt4Tzf2E9X29HNh
         hxvXTUVgc3rPl6xzDKnSfNdWgyoB65iinrx/NnHBaX2r6JJo55WdhMctJy5WjKqR9zIY
         K7pw==
X-Forwarded-Encrypted: i=1; AFNElJ+Ed7FBjumzNQLfS6S3oyG//itgo/2W+nwAiPncaLJ45FoYS/EgPPoLV8VB5nm2mVPPHk8Kv3aD/7K6AmMD@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Rl028abMzXK8fBP7AgH40UB5dkOIIR2FzCRV87nTmXVydqB+
	Vy12PZIkL4heK+dbBAnOizlZT9oUMVVKv7fGwnhKbyPP0ywx/tCo9qBOAunp0EXjaURvoBjX+OH
	58P0ZVL9ws7iZaVFpEG12J8BOaQTK8eNM4on10jd0UhxpRbejpGNEvHgWIgBp7J241pY=
X-Gm-Gg: AeBDietv4ckQdytLVfe604woRYL6JnmKJVQbIYLR8Ysmgn8nEvM/CaI1mNfIXlNo6N2
	iFFP4CvTD+tF3vAIWJF7ponEGrsw31C+8J482EinZJioy/2uGZ1Em0KnrfWdI9JPWXFEHxnz2PB
	OBdaKJScAHZrlGwcoqjCV/val3M3HrXglATxVJHG4Nl87mFdiVn9zKWGuix02lB4LkMIurBuS0n
	dm+T+LLKXZgIeDROBh4A+TU19+NfEuopUc9w4lhWEzFBHxGnub9np64HAMmY+3sIxsSGCkwId1X
	SbZ3BROy0FNFEjGxciB2HOka9nApbE8LttwfNh9qdbrGZWuu47OLuFgEKnxxHznXrwu+od5bBJs
	oP9mxEA7HLfoGKl/YJnqb11QIO5La1/LjqcG/QmpZsEER7iHIatRQ
X-Received: by 2002:a05:690c:39b:b0:7a3:68eb:11ae with SMTP id 00721157ae682-7adef5fffe9mr164760577b3.33.1776100336088;
        Mon, 13 Apr 2026 10:12:16 -0700 (PDT)
X-Received: by 2002:a05:690c:39b:b0:7a3:68eb:11ae with SMTP id 00721157ae682-7adef5fffe9mr164760077b3.33.1776100335517;
        Mon, 13 Apr 2026 10:12:15 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b3b0d656a0sm11650187b3.4.2026.04.13.10.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 10:12:14 -0700 (PDT)
Message-ID: <b0e9b8218a2daeb65c8481d1f4646f3ca89d713a.camel@redhat.com>
Subject: Re: [PATCH] hfsplus: remove xattr error message
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Colin Ian King <colin.i.king@gmail.com>, Viacheslav Dubeyko	
 <slava@dubeyko.com>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>,  Yangtao Li <frank.li@vivo.com>,
 linux-fsdevel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 13 Apr 2026 10:12:13 -0700
In-Reply-To: <20260411125338.165758-1-colin.i.king@gmail.com>
References: <20260411125338.165758-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-04-11 at 13:53 +0100, Colin Ian King wrote:
> When exercising hfsplus with the stress-ng xattr stressor a large
> quantity of somewhat unhelpful error messages "hfsplus: xattr exists
> yet" spam the kernel log. Remove these.

We can convert it into hfs_dbg() and to add showing inode ID + name. What d=
o you
think?

Also, there are other pr_err() in xattr code that can be converted into
hfs_dbg(). Could you please take a look into other ones too?

Thanks,
Slava.

>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  fs/hfsplus/xattr.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> index c70bb6f494b2..e10e1d8a5862 100644
> --- a/fs/hfsplus/xattr.c
> +++ b/fs/hfsplus/xattr.c
> @@ -301,7 +301,6 @@ int __hfsplus_setxattr(struct inode *inode, const cha=
r *name,
> =20
>  	if (!strcmp_xattr_finder_info(name)) {
>  		if (flags & XATTR_CREATE) {
> -			pr_err("xattr exists yet\n");
>  			err =3D -EOPNOTSUPP;
>  			goto end_setxattr;
>  		}
> @@ -348,7 +347,6 @@ int __hfsplus_setxattr(struct inode *inode, const cha=
r *name,
> =20
>  	if (hfsplus_attr_exists(inode, name)) {
>  		if (flags & XATTR_CREATE) {
> -			pr_err("xattr exists yet\n");
>  			err =3D -EOPNOTSUPP;
>  			goto end_setxattr;
>  		}

