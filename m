Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEFD3AFAFF
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 15:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337802; cv=none; b=hsTB+xfjPS2JcQlY4OLhGpr0zwaxOvDvgNKXxf97rjMmeWridE50/SffuI/HaFjFbTKyQXioAPfmMBorql7VnliaLdUXkzdYQS0jeHaKe4O1PwQBoqVYWiOEHiLVn8bn5PTyFlK6J054asLPfdkg96qh+l2x40fDhB20+C2JEn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337802; c=relaxed/simple;
	bh=E/FLQXipQ0K2+/SZsSnDyNxS4/Ll61lf7dZ4IW4dJIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NSu51LvwUgTPPCBs7krFY0UcfgXXTJN/l6O+2nXOvgmxU+w5ZklM+64wBj5dLU3/EGbmIkSiWCRJrsBDOfsGULFU0dC75VURDTzN+zlGykQDahrq+CTuFPoYvfOAVyQRRgI51VQNgcmS73VWf9U59gIgb0lMJl+hKF6xNUUjxJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CmYuaXqg; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CmYuaXqg"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c15f47e6297so127691666b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 08:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1785337799; x=1785942599; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bbUgySyaXxdCM5TiDxVMfKO2Pl7MWD7VCGVOlsUNi5s=;
        b=CmYuaXqg47EbYq50JRGshn20dxkc2FSOx9wT9qy00HQMCTznvf4PqPOlEPPRWWToRI
         gUCBJaqgjuG3UhJo2JyqqNdcnjNMFi8Iw6/cPTGEYAWOUBGdoD6cGUTYPTYBFxTm633p
         5BYkMD2bbb+lXy6saEiTcGsr+6U7PA6EsIMqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785337799; x=1785942599;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bbUgySyaXxdCM5TiDxVMfKO2Pl7MWD7VCGVOlsUNi5s=;
        b=iIU21nS+7XLGAV9zjhRinRyU5QkeqBDMP6yWMdko2KsQxJNRy7KTik9csd5mj6GZmz
         oCD7FojDlxTnil/4fk69Wt54zWTzbc2IJxZGwWMhOaKFa+DqtEE6StxpMI8jb6rEzknI
         O8tA0zNfAyQIHzl2BFVeYr9bVWTZPL36asb3KoaTC/JELbZhjVrZDc2sd3Cfl3I1RjKZ
         f5SpBQcoJ21V2aQNDkthcM6Rr/H2vSjXMjc/uCIyVhNDdZ8zV2wQykNOuJezbXQSvh/k
         VTTeBVNlz40nMnaEeqtyZl7gO8YLJ8w9e7gyzdhRKYpz9z+qNE8IyJDcaN9h7Ej4EdVI
         m6HA==
X-Forwarded-Encrypted: i=1; AHgh+RpaJlD/0MU2ZZCHxaX9UTh4fuTizAqcXSa8hCAiUXI2lyCkiW32Hw4+weM77JNmBZs33Gj6ro2mbEDx0lbe@vger.kernel.org
X-Gm-Message-State: AOJu0YyCPFDIBzPtoJPtIFC19gHFQ+OJ9l7Zao3OE5ARwPDnyV0VHWOt
	Me/vpzgOebYjBsUZ6QXWJTTABZ4BIf2ll5SsaQMNGH6aFM9mVobnYoDd0NzsmTQkNiSyxww1x2g
	UxRH0ghw=
X-Gm-Gg: AR+sD124KTa7pLv3kt1xAVIofmzxcg8nJOVhOx4Pj64mdPpcDg7L4e6E5B0acFDDqtX
	UBFdqACzidwUfLQ04OYVzKkrH8LpFJmNnzsZanGsL5E9PQ8nq73gB13i3QcT+QMg1NQ3hQGJZ9s
	oePc1cG819JUrqzYXaIn5LvYwsY49fgn6w4fCwfv7t/A/3Budu0GwOoIkWceOpLlbW+zoT3yw2y
	gDvvRh2b+tzbz79TnsvFdWDCcBfpUq6LfrKglkXDO++zstCFpk5iw+j/K7UTuv2zAYzkw+usKJ2
	jtFcifdp/07PtWq3kViQLPo9cJNlFVbaPvFSDS2Io/98XFGmT+czE4GiLqSVdTmD93zVlAH5gTl
	w6mWDdADD/erLf4VAHswxwPzxuwAEeo5Cso4ERTRHu60A8aZegBL5InAeq8M7ezdCuPFLpxNFsZ
	NRcaAlXskXgAee1vygfX+7qYjDtKcyksWDo5Ypu6BLZEV/wFVrOM+TBCynIUwcGkjbeS0znulL4
	PN492JWKa7YPXAX5+Nd8fwoAKkFXtbkUjOWcQ==
X-Received: by 2002:a17:907:60d1:b0:c16:a484:90df with SMTP id a640c23a62f3a-c1f72221988mr381480166b.35.1785337798629;
        Wed, 29 Jul 2026 08:09:58 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f83cde4dbsm134799466b.15.2026.07.29.08.09.57
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 08:09:57 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c1740c36c5cso153093266b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 08:09:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoX5FZ1m4/cc1+4ILxsP97ZutBP4BdFCHpKKg1gXiVSMFb8gqVHPYnzs4EsEjH+vV72fZPga6yjg1S2D6UW@vger.kernel.org
X-Received: by 2002:a17:907:6d1a:b0:c15:f376:9642 with SMTP id
 a640c23a62f3a-c1f724ee1ecmr389008466b.65.1785337796931; Wed, 29 Jul 2026
 08:09:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514140817.623026-1-axboe@kernel.dk> <20260514140817.623026-7-axboe@kernel.dk>
 <605939add4dfb674bd7ab39ef8dbd3fd22e754e4.camel@xry111.site> <427b15c8-c168-4e2a-ac38-b00dc00400d3@kernel.dk>
In-Reply-To: <427b15c8-c168-4e2a-ac38-b00dc00400d3@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 29 Jul 2026 08:09:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeSgFEr3WSO1C1sPP+fy+Mt5_EL9WXW-s11BOhD_S5Ag@mail.gmail.com>
X-Gm-Features: AUfX_mw-kTtyuQrkUq67j8f_qvo8wTHBUpDqR2AVQRqJeAFNQym68SnG2Gs80B0
Message-ID: <CAHk-=wjeSgFEr3WSO1C1sPP+fy+Mt5_EL9WXW-s11BOhD_S5Ag@mail.gmail.com>
Subject: Re: [PATCH 6/6] io_uring/epoll: disallow adding an epoll file to an
 epoll context
To: Jens Axboe <axboe@kernel.dk>
Cc: Xi Ruoyao <xry111@xry111.site>, io-uring@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	=?UTF-8?Q?Juan_Jos=C3=A9?= <soyjuanarbol@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Jul 2026 at 03:54, Jens Axboe <axboe@kernel.dk> wrote:
>
> I think it's pretty simple - if libuv is using nesting already, then
> we will have to revert this single commit before 7.2 release.

Yup. What a horrible interface epoll is, and now it's made io_uring
have any bugs it has. Oh well. Horrid or not, the first rule of kernel
fight club is that we beat ourselves up to keep compatibility.

            Linus
