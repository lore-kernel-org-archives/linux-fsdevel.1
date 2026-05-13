Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFE5389E18
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 10:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778666764; cv=none; b=NwVFjYK4wBhlWLXyF4NzDPRDNqdm5eQf3eVtskiSPVYakOFV3e2+QUNp/hhwmOoSdMLJz0Uagsze2+K4wvRPG6Yz15OVk5cn91S2bZBwThekbR7lTTzbnkRgOaPgw8/vdtCW5TOn87RvRrx3B3Gr2PqjQwfWdHqnTH+8kSRQEwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778666764; c=relaxed/simple;
	bh=CfUsDrF5ylNvxQAC5m07A4hEbvmSGmwJUzmCib0VNCs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ppBIOUavsNuIppXSHZ+Md0TK/ak1KUh2lB1m+yf/FWue90SXI3bybUyM7sYLOadrzIMF0pKWrFcLIcjNAxymX2JZtCfrOb4I+HsvEprwDtdCDbgTvsDvA8UtNnq9Cz3M2z/nbWH0hXt32O19rEWaA8TTSExyFMTz9rTNgsCsBEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYiQ/0MW; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYiQ/0MW"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bd21ffaca79so379740766b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 03:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778666761; x=1779271561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8agHE2UtR+0v8hUNRpGN3/NHmgQczj9TZKmKbKc+JU=;
        b=nYiQ/0MWx9zqnzz8qzzGMzyLjhAbZWS6PTm/379VNMshJcLtpIu5kxF6cnraFj1DbO
         BlzU1fL4lAJVK+xJyT+t0C2pgU0zXoRNRBJDuoDV7aRAV8/BXPrXurjZhhbFPRP66G4B
         IJsfO+VD/5yKfUDzBtYj/qCOyb/VG1WmTK1QWVOgt5y86ToAS0jGu5rCD0iTU4ZwdKbt
         PGSxd6voPOYFRhsskQZ2JVQRddLAKGHuQPOZVZK0jJea0/IaUCVN2Tich+MDh3mSnq/3
         vJA4Hf9G9AHe9O8fkuLzpoR2r1IZWqWqTZZsA1X2Vx2+bgVyylnlQ272ERqYKRVGESq0
         DC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778666761; x=1779271561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y8agHE2UtR+0v8hUNRpGN3/NHmgQczj9TZKmKbKc+JU=;
        b=No4ajlqoIrfyEijZqTlr2qun8Ig60EQ8EqTkNgWvLfWDGtQKb67D8koGiiDNqkQRHu
         C+FnD5MHy2P7WRBsBHvKKXfkzYL1NTHSButc9T+KBZ7pyRvBBnSKIm0dk3sGQi+SGvwq
         2aTokllH/VDR4l4m4iu4lFkblev4/F6TyIMsSz4uiPa6+46KJpWJeZTDWaSc0Ys+Z4mT
         csyzNX/5RqXN6hwT3AH/r8lAy/4WPOfKcF6My9t/w1LNn6xw3s0l/NAY/FpTLMYQho5Q
         GnEpJHlwHp0th2cKsJzjOlHhRCraQReH7SRLYHxF+TTf38MVLAh0zWNNXYg1Oz6IWco2
         HwRg==
X-Forwarded-Encrypted: i=1; AFNElJ8aUEeuef7dlbmmxnXXPV6WTJLlFKlvEmF0w7bNsNM28o0RESlJ+5iFytldYOk59Yx1I5m+AbMDLFGeQDIQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtd9dNSWrvSF8gqNvBOVPG7Vp8D40TcEYC3D97vG/bBEvm6JfG
	hI1p9Fxjm3lWivTlPfQyfc/0i8N1MskezyfPJogSb4CNCXzqxizeFRSG
X-Gm-Gg: Acq92OGZzmew/mNCwsv1oJHDgreEWH/jJ08/AEOsoy8bm/St6j/sXXpqHor9qm8Ou2o
	2RSlHSbQzG5S1Up69njBfdPz8acvTipNYrcZmZrpworo4HeahsjIdORkAaxnbRLji/7Gx7cnAje
	LYb/WtsCsL1K+W375TqH0ntnkkm5aHexTbQ5YlwEiLd9SW+ZOGuxvwA7ovAbORLzi7oMPOhpQb0
	S24yrZRh3l5Ny9fxborJlmbHdIQ9I8EdFiLCSvvyh7nN9tqWP8+rXukWRy/71xuPY3bCXEXSkWj
	ZNzxRqCBpdvvtj/4Z1ijuk1Lm1n6WLRDoXk35IpVphWP86ZVSUHv2T7gva6p2Q4EH6OKkc4X2gN
	OUgxDcXs5LSrdtlsaPj/hlCHFRaeyblaiM7q+b1kbvVOKmmo/J6bXXaKN2m0/mgC1ilVzlHVie4
	883T/6WWuL0OtTjUTGbXxFe5hUGJ/je/+2NlMkAUjG0rrfhQcvOZ1+uXX0dLwb
X-Received: by 2002:a17:907:9493:b0:bc5:2352:555c with SMTP id a640c23a62f3a-bd3add39c4bmr174356866b.14.1778666759127;
        Wed, 13 May 2026 03:05:59 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd2dba8fd22sm216615666b.16.2026.05.13.03.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 03:05:58 -0700 (PDT)
Date: Wed, 13 May 2026 11:05:57 +0100
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
Message-ID: <20260513110557.705bdeed@pumpkin>
In-Reply-To: <20a233d2f35274817aa643cc0fe113707eb47e72.1777475843.git.asml.silence@gmail.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
	<20a233d2f35274817aa643cc0fe113707eb47e72.1777475843.git.asml.silence@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Apr 2026 16:25:48 +0100
Pavel Begunkov <asml.silence@gmail.com> wrote:

> Introduce a new iterator type for dmabuf maps. The map in an opaque
> object with internals and format specific to the subsystem / driver, and
> only it can use that subsystem / driver for issuing IO. The task of the
> middle layers is to pass the map / iterator further down, maybe doing
> basic splitting and length checking. The iterator can only be used by
> operations of the file the associated map was created for.
> 
> Suggested-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  include/linux/uio.h | 11 +++++++++++
>  lib/iov_iter.c      | 29 +++++++++++++++++++++++------
>  2 files changed, 34 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/uio.h b/include/linux/uio.h
> index a9bc5b3067e3..75051aed70de 100644
> --- a/include/linux/uio.h
> +++ b/include/linux/uio.h
> @@ -12,6 +12,7 @@
>  
>  struct page;
>  struct folio_queue;
> +struct io_dmabuf_map;
>  
>  typedef unsigned int __bitwise iov_iter_extraction_t;
>  
> @@ -29,6 +30,7 @@ enum iter_type {
>  	ITER_FOLIOQ,
>  	ITER_XARRAY,
>  	ITER_DISCARD,
> +	ITER_DMABUF_MAP,
>  };
>  
>  #define ITER_SOURCE	1	// == WRITE
> @@ -71,6 +73,7 @@ struct iov_iter {
>  				const struct folio_queue *folioq;
>  				struct xarray *xarray;
>  				void __user *ubuf;
> +				struct io_dmabuf_map *dmabuf_map;
>  			};
>  			size_t count;
>  		};
> @@ -155,6 +158,11 @@ static inline bool iov_iter_is_xarray(const struct iov_iter *i)
>  	return iov_iter_type(i) == ITER_XARRAY;
>  }
>  
> +static inline bool iov_iter_is_dmabuf_map(const struct iov_iter *i)
> +{
> +	return iov_iter_type(i) == ITER_DMABUF_MAP;
> +}
> +
>  static inline unsigned char iov_iter_rw(const struct iov_iter *i)
>  {
>  	return i->data_source ? WRITE : READ;
> @@ -300,6 +308,9 @@ void iov_iter_folio_queue(struct iov_iter *i, unsigned int direction,
>  			  unsigned int first_slot, unsigned int offset, size_t count);
>  void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *xarray,
>  		     loff_t start, size_t count);
> +void iov_iter_dmabuf_map(struct iov_iter *i, unsigned int direction,
> +			struct io_dmabuf_map *map,
> +			loff_t off, size_t count);
>  ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
>  			size_t maxsize, unsigned maxpages, size_t *start);
>  ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, struct page ***pages,
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 243662af1af7..e2253684b991 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -575,7 +575,8 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
>  {
>  	if (unlikely(i->count < size))
>  		size = i->count;
> -	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i))) {
> +	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i)) ||
> +	    unlikely(iov_iter_is_dmabuf_map(i))) {


Doesn't the extra check add more code to all the non-ubuf cases?
This could be fixed by either making iter_type a bitmask (with one bit set)
or writing an iter_is_one_of(i, ITER_xxx, ITER_yyy) define that uses
'(1 << i->iter_type) & ((1 << ITER_xxx) | ...)'
(look at the the nolibc printf code for an example).

>  		i->iov_offset += size;
>  		i->count -= size;
>  	} else if (likely(iter_is_iovec(i) || iov_iter_is_kvec(i))) {
> @@ -631,7 +632,8 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
>  		return;
>  	}
>  	unroll -= i->iov_offset;
> -	if (iov_iter_is_xarray(i) || iter_is_ubuf(i)) {
> +	if (iov_iter_is_xarray(i) || iter_is_ubuf(i) ||

iter_is_ubuf() should have been first here.

-- David

> +	    iov_iter_is_dmabuf_map(i)) {
>  		BUG(); /* We should never go beyond the start of the specified
>  			* range since we might then be straying into pages that
>  			* aren't pinned.
> @@ -775,6 +777,20 @@ void iov_iter_xarray(struct iov_iter *i, unsigned int direction,
>  }
>  EXPORT_SYMBOL(iov_iter_xarray);
>  
> +void iov_iter_dmabuf_map(struct iov_iter *i, unsigned int direction,
> +			 struct io_dmabuf_map *map,
> +			 loff_t off, size_t count)
> +{
> +	WARN_ON(direction & ~(READ | WRITE));
> +	*i = (struct iov_iter){
> +		.iter_type = ITER_DMABUF_MAP,
> +		.data_source = direction,
> +		.dmabuf_map = map,
> +		.count = count,
> +		.iov_offset = off,
> +	};
> +}
> +
>  /**
>   * iov_iter_discard - Initialise an I/O iterator that discards data
>   * @i: The iterator to initialise.
> @@ -841,7 +857,7 @@ static unsigned long iov_iter_alignment_bvec(const struct iov_iter *i)
>  
>  unsigned long iov_iter_alignment(const struct iov_iter *i)
>  {
> -	if (likely(iter_is_ubuf(i))) {
> +	if (likely(iter_is_ubuf(i)) || iov_iter_is_dmabuf_map(i)) {
>  		size_t size = i->count;
>  		if (size)
>  			return ((unsigned long)i->ubuf + i->iov_offset) | size;
> @@ -872,7 +888,7 @@ unsigned long iov_iter_gap_alignment(const struct iov_iter *i)
>  	size_t size = i->count;
>  	unsigned k;
>  
> -	if (iter_is_ubuf(i))
> +	if (iter_is_ubuf(i) || iov_iter_is_dmabuf_map(i))
>  		return 0;
>  
>  	if (WARN_ON(!iter_is_iovec(i)))
> @@ -1469,11 +1485,12 @@ EXPORT_SYMBOL_GPL(import_ubuf);
>  void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
>  {
>  	if (WARN_ON_ONCE(!iov_iter_is_bvec(i) && !iter_is_iovec(i) &&
> -			 !iter_is_ubuf(i)) && !iov_iter_is_kvec(i))
> +			 !iter_is_ubuf(i) && !iov_iter_is_kvec(i) &&
> +			 !iov_iter_is_dmabuf_map(i)))
>  		return;
>  	i->iov_offset = state->iov_offset;
>  	i->count = state->count;
> -	if (iter_is_ubuf(i))
> +	if (iter_is_ubuf(i) || iov_iter_is_dmabuf_map(i))
>  		return;
>  	/*
>  	 * For the *vec iters, nr_segs + iov is constant - if we increment

