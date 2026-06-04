Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C123783BB
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2026 21:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780609392; cv=none; b=sV1mNTtugTmnlAuoOyiLwuaF65sLpbK0izD5VY8Dig7Qrw0AhcdQSJm95Ap6GaXDDjkOUVXKepDrYaT3z8HMEs032kFWqh4mt+zZDwBaOGc/qv7B2Ko4dQoG5WpBmq/KW8IzIf+D0iL1jPFG9vNRoy1NpWjsXeyYr7wdcP9DvbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780609392; c=relaxed/simple;
	bh=ZWDSpacEFEQZGnIVBEbJF0VYYuNfWke7vLWrwwZT/Sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KpQRXopmLz3XixnsclrF1xaqZhFJ5tM9gBe7fhMUXb8VTFBxLgpZ6Oo1IxzEZ51yZQFUZMRTk0Bsc6fpZUxVywMtClTtQBfAr7dPzxXzzgunyu3K+IVEREQCcLrku6EY4mTYdQdXf+og8LcO81wCsk9ALKycz5mnPwyGD7UZItM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cGCqekVw; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cGCqekVw"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bf1141c26ecso179343666b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 14:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780609390; x=1781214190; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C0rKRLQ7b0xQkDszK4kB86a8NKDdPGLBrBut9iuJxEs=;
        b=cGCqekVw78n5ZIPveO7LHJDqnrEPR21SeuXk7KlfXlBcUevB3eBj0OssT0LUPi0Ds1
         55s4r5GenpFBZnFRQYHrbhjdNcdlOKk3RVxjAXL4/1D7Vrntz4bvQi0Faai493uAlY2J
         5NvMqC/du8RbPgU6taIIAZbty6L4rCVStvKeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780609390; x=1781214190;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0rKRLQ7b0xQkDszK4kB86a8NKDdPGLBrBut9iuJxEs=;
        b=osMecacBYPTtQGsv7KRi5hmuPPP557ukp0//xwX/MWHFGXy4zlioq4YfO8zx5sH6Gx
         ae0AA/qcq+BB6m1Rz34G1lVt8eA5gO9GcVqKh4arELucqPgi5D8IA3AoKuK1oLwb5c+Q
         ab5eiiaG6IIc+9LOhekbjiJpCP0rxzus1c9jfuVMb2u/57bEBaHsSRrSqzx3ZYyLdVxH
         YiJZG7TjcFgovlwHnpsXTOH0GXR9q9+pM3/9Xxq57u8HgsQoYsVHOoI+xfPwqTo/KH4y
         NUIWGyxAvOpOyGCnRk/6tzVEpC1akIL8bjoGwwPYVDgI5hWsJcaED2GIAOPRxXcOvTpd
         MMsw==
X-Forwarded-Encrypted: i=1; AFNElJ/hjoDSSPJExXK9faQEI+fSikTmE0IoGcfcDakBeoVEy6+pqJQVLINLfe3yy7YwoRPPv4jFDVr/UriisFfV@vger.kernel.org
X-Gm-Message-State: AOJu0YyjtMsAw3ay6SE5Mp8mO5qGDYQyI3aL24XqHt4yXmCB9kXvR/M2
	UhrNsuLAdP6uk2CXPcS3Iz2lEFsXsxH0FC6w3seDrI/faGq7mQEVCz9wNHRUZ45HRPMZh0AGYFX
	NXL20XdBPxA==
X-Gm-Gg: Acq92OG8MNyf5ge3wPOJyanM5iJ2iyYygo9I3wDvnjUIFVNGddA1SilvsuwMVO9CaM6
	xRXduEvYDztNaJFUd3zIZx9DB3FVTLp6EEx4evjPsq9ky7XJTUxrDwAVZrDCqfOUvdT3VwpyjLC
	/lOCm5d2fy9srsShMkXMKDqijSte6nSRG5W8tsC6lxq5NVqL/u4YNOCxtdk0epYinGaaE1kRbnA
	9Yhdu/BMPTud5Pm9hPNxCna+L6szRMDvNL8bwGc6ugeY6v7mggBPSPoN0UOD4b0IwAVCIM2tCUC
	PbhgZx3Qt0RpeQgdBIJzVNRi2MyYOMSaW976Cels6/nELySKIGHG2gqbd4pMU1IIzxrGKCUvkwy
	2rcjRs4FA+bsliHYdHIp0h+7Cfxu/Lbc1O717XBq7ioqztTlaZA5xOoKA0Z4rxmq6ZOXfQVpMs/
	CriJ/TT1Ehjg3w/RSu8+LYTUyi37J1Vze1WxtqINP+qg/fg1PbQDPJWA2s/53ljg23PhLcTbSUA
	i1eI/U0Nuo=
X-Received: by 2002:a17:906:c107:b0:bd3:32ce:8902 with SMTP id a640c23a62f3a-bf37390389amr22329766b.39.1780609389638;
        Thu, 04 Jun 2026 14:43:09 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf0558f3885sm351240966b.54.2026.06.04.14.43.08
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 14:43:09 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bf0170c80f7so221285666b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 14:43:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+G1ndoB3lN4yzAUUjmSbXxsTgrZXXFo7HSMNgL+xEYpsSrIhpTspMbI70RKRN4qzCzeuPAd88xkJKYWH7i@vger.kernel.org
X-Received: by 2002:a17:907:a03:b0:be2:dd37:facd with SMTP id
 a640c23a62f3a-bf370e6211cmr21551966b.20.1780609388179; Thu, 04 Jun 2026
 14:43:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f919874c-065e-48be-ac5b-300c4ab86d4e@samba.org>
 <20260603211736.755139-1-safinaskar@gmail.com> <20260604100609.6b37f500@pumpkin>
 <CAHk-=wjvb56qo27-axALOKCY-CjLsj9_294zeBovPVJaYm14dA@mail.gmail.com>
 <20260604183829.63c35fd9@pumpkin> <CAHk-=wip3mwLOHOYJ9TtjDxOaq9YUXmuCg2AycyASGgeY6qqUw@mail.gmail.com>
 <20260604223216.73468830@pumpkin>
In-Reply-To: <20260604223216.73468830@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jun 2026 14:42:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh1Avi8FGbWkt9k0Z-KXWB0spo5mQyowO8PB2sJ3unbkw@mail.gmail.com>
X-Gm-Features: AVVi8CfSQTIVkCCY1e0qHuDIqCVA2aM8un_0a9-AOfB95snGVQXFlgTgq5lonE8
Message-ID: <CAHk-=wh1Avi8FGbWkt9k0Z-KXWB0spo5mQyowO8PB2sJ3unbkw@mail.gmail.com>
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: David Laight <david.laight.linux@gmail.com>
Cc: Askar Safin <safinaskar@gmail.com>, metze@samba.org, akpm@linux-foundation.org, 
	axboe@kernel.dk, brauner@kernel.org, david@kernel.org, dhowells@redhat.com, 
	hch@infradead.org, jack@suse.cz, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, miklos@szeredi.hu, netdev@vger.kernel.org, 
	patches@lists.linux.dev, pfalcato@suse.de, viro@zeniv.linux.org.uk, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jun 2026 at 14:32, David Laight <david.laight.linux@gmail.com> wrote:
>
> I think riscv might sign extend 32bit values in 64bit registers.
> x86 and arm both zero extend.

That's different.

x86 really doesn't *care*. If the caller zero-extends or leaves high
bits set randomly, according to the x86 ABI that's perfectly fine: the
callee will only care about the low 32 bits. So the high bits are
simply not relevant for the ABI.

The Powerpc ABI makes the the sign extension part of the calling conventions.

So if a caller doesn't sign extend a 32-bit value, the result is
random behavior - if you pass some function an 'int' argument, the
function may end up looking at bit 63 to see if it's negative (except
IBM calls it "bit 0" because they have to be different from everybody
else)

            Linus
