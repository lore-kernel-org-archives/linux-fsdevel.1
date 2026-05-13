Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD12E33121E
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 13:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778678955; cv=none; b=PPN+e+R8QsdmZqJ2ky1GmCSEGZe/cnpLiM3tEEJ1iHVbJTshD+ijx0ZLO7zhSidlPCDddqU00/6+oamKkPzEka0zLSJ+4EoV67lAKzOdQUhHmnySoFT9Z/ZdYgKAOFL5+gPmc2Fp1brnr1RKdbqNQwmoNiEB3mofSlvGJ0LLFZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778678955; c=relaxed/simple;
	bh=qvrzIgPI09xnL+lPNRKw47FDVzkn2xkt2K7Rwhlyrpg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jg+/1CRqoJQpJpQoa02ewDQBzc/pPa28JAQmCgOoACSPo7rQm4dCB2rGnfoJWhK/GDbAsAK/KUt7nFBOMuCM0RtkiR/UQrN8FIco61dw1LjdT/70kPy3prVdNNpXrKh3WzxHl9Xo5C0gSNenCY43QvTnxUyun5DxP+/uV5UtLjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a107B9Ew; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a107B9Ew"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso73856885e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 06:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778678952; x=1779283752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cq+23+E96HQoAhwgeeSJr3+OJ8IJX5BGImZhad/wV8=;
        b=a107B9Ew/L+JG9kf+Z1nV/fx/+/Yb5mbJ9IZSmqcqG5NRhHtSigWVxLyt5e4tVheRP
         fVjtYzbSvKxWG/9swUAl2JC7bOL4zt7vyjCnIC8OuK2OMjbgJBd7ZXSOd9A2k/U6ZdZx
         IjexhbZVncU3yj8qsWTZZXbphJKEGru0GTV9TW0VSNxNUEF9TejQU1LxeC23owu6b8iT
         ERboyV8DTmKJyNrtYYu2ZtgNGMFqTuCpA+7JxZMpzt9wq45ITtvGgvRTJ8s7Z9NXHaiv
         Dc2JWteKzwRsB8GUKRASoBUvNyZQ288ROHW0dQRuuliK8uDWf25EzvdXbuywp4OcMKw3
         hDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778678952; x=1779283752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+cq+23+E96HQoAhwgeeSJr3+OJ8IJX5BGImZhad/wV8=;
        b=UlsTUHGsN7sK3qtw+i6H1D+kYjxQS4Dj3Rs97jTmKQdQmPJmjifKLukFnLyiUg1ihO
         fDuTwHraxTV9gZVh4BlyMQZimRQWg7Bm7C4TWNnHtf3ocw+7YKoOcabJN01oABo7Imlf
         78dry192e3e8th5e7pK9lpT5FzlwO/Lw/yO+b+k1PIRswGK3rkP2hFL/PAho6D73ZJFx
         PojxmJLHYpy29ayDfhiFEPW230a0e0TBQIzmfm2OnZRafD/addGERaSLeohrt4T5z7m6
         XTCgSj7nmcjZ5iCr7aF41qFI4XkDRr+AWo/yBurCRJ/d5N9+nF1ppGmpKm2yGRWonkjw
         AorQ==
X-Forwarded-Encrypted: i=1; AFNElJ9MFH8wOaWftihJXtHUgGnUP6b6QpWleirthZjVPOC9Hk/FEuCrDvCbToOnLRKQkY8BnelOY9VTJLMs5+Cw@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0RxObuvdnw6KCFnrS1GAqGgBwZOdKHqGQeuptomOrpRxOyj9v
	LG3asE0gqCFr9su9mEpq2J5LYHs61VFnH3ynxx6wDpp36ffTEXgcG98J
X-Gm-Gg: Acq92OG8+Q3ZtB4M4C5jxRD0m+5EVnQoqq43TXemNO90Mcg4d8MopulePmXirGdoMix
	YBT+2AOSuTaPhutP5ilFbyMJcR4PK8KCQPXDKoNx4xG0oG8Bqoge1lCasZmr3OFx0LEILx+ObLB
	3qzSTrl3guo3lNHzO+5bNArr8sIrW75VC3P+2Eb5xzRlhvxx+igSDXOTncQpDtN7g/l6z0wIsHz
	Bmh1nRhG0DfP6PMqu5Nyw5L/IKdVAHJWOlYe9M5OyGpQQlUadnHX5lpYTmhBsmkGPFGI6clnGFq
	Ohi0eCwZsCCigdbrKNo2HaiZL2MjDUwSrZw0PkGDq8/O2yWfJPnc4GMpK/aZxojiZ7MQ2R8wDwC
	oB5hzQvd8nNt1fF08312IihjklRfVpCynufcEYP37FkZNdTB5R/dMOLYo10/PoEYnHWY161cDqD
	vl7E7y7q9p7WVYc8gWEuymLwHqC2bBUXvAX7KZfCr77sg5ptaVjwhImMR/PXh2
X-Received: by 2002:a5d:591c:0:b0:446:708e:1e8d with SMTP id ffacd0b85a97d-45ac4504a13mr9930360f8f.30.1778678951817;
        Wed, 13 May 2026 06:29:11 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4549120ec0asm40068578f8f.17.2026.05.13.06.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 06:29:11 -0700 (PDT)
Date: Wed, 13 May 2026 14:29:09 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, Nitesh
 Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, Anuj
 Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 02/10] iov_iter: add iterator type for dmabuf maps
Message-ID: <20260513142909.03ae6c2b@pumpkin>
In-Reply-To: <20260513110557.705bdeed@pumpkin>
References: <cover.1777475843.git.asml.silence@gmail.com>
	<20a233d2f35274817aa643cc0fe113707eb47e72.1777475843.git.asml.silence@gmail.com>
	<20260513110557.705bdeed@pumpkin>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 May 2026 11:05:57 +0100
David Laight <david.laight.linux@gmail.com> wrote:

...
> > @@ -575,7 +575,8 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
> >  {
> >  	if (unlikely(i->count < size))
> >  		size = i->count;
> > -	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i))) {
> > +	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i)) ||
> > +	    unlikely(iov_iter_is_dmabuf_map(i))) {  
> 
> 
> Doesn't the extra check add more code to all the non-ubuf cases?
> This could be fixed by either making iter_type a bitmask (with one bit set)
> or writing an iter_is_one_of(i, ITER_xxx, ITER_yyy) define that uses
> '(1 << i->iter_type) & ((1 << ITER_xxx) | ...)'

This seems to DTRT:

#define _ITER_IS_ONE_OF(iter, t1, t2, t3, t4, t5, t6, t7, t8, ...) \
    ((1u << (iter)->iter_type) & ((1u << ITER_##t1) | (1u << ITER_##t2) | \
        (1u << ITER_##t3) | (1u << ITER_##t4) | (1u << ITER_##t5) | \
        (1u << ITER_##t6) | (1u << ITER_##t7) | (1u << ITER_##t8)))
#define ITER_IS_ONE_OF(iter, t, ...) \
    _ITER_IS_ONE_OF(iter, t, ## __VA_ARGS__, t, t, t, t, t, t, t)

int foo(void *);
int f(struct iov_iter *i)
{
    return ITER_IS_ONE_OF(i, UBUF, KVEC) ? foo(i) : 0;
}

See https://godbolt.org/z/sMz93zah1

Pasting ITER_ on the front ensures the values are constants of the right type.
OTOH it makes it harder to search for uses of each type.
You could paste _ITER_ on the front, elsewhere define _ITER_ITER_UVEC
to be ITER_UVEC (etc), and require the caller use the full name.

-- David
