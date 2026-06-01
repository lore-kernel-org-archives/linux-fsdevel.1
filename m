Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C27C3D79E3
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780326208; cv=none; b=U1WecCvvSXFjVsBlg9XzyrqacTJm8BmafenaY9mRMrtV227Vet6bHi2sc21DSIHl+A5NVq41stQBNNGWA81oMxs4JgpOqc0npuhajbW2eJxk9cX3m/WLb9O1xFU0FSFpHR29TSV3yPHcj0WX/39tip87NIQ0bDKjmjP7XHAajNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780326208; c=relaxed/simple;
	bh=p+PS6KHp/v2XKzx8ndFaB06eEGaGyvrKArkkPi9DrhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpO2WuMSUmOhj1p9LJWCAFgABl4qelBhHcqGpNDilf1LOizQ9wCwskoZqJ28XOKyrwIUL8ggIDlS3ytKivGlAzuUe8TBKgRPYij7vFDZ/nUkiw70wcbNExlsEglCe8HjgnBln8R1W7OCnrUotU5uBRXlpiIkbFouyXLnX+0E+Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnwBs0m1; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnwBs0m1"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45fe59255beso847934f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2026 08:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780326205; x=1780931005; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jOPuvve0GGHfgoNvEY/UT1iUdehbmxAd3MGizN3iksE=;
        b=RnwBs0m1hpb2y/Jjf472t1lRHbREWU+seO1ciUK1wX+UjwUK3iOmTSkrmYU8s4RPiD
         dgG6eByyqmv/oZNB5AVLl4swdSwZCowsE8HeelO+WcwNloU26Q4PNHmpcwluy/X/Jit8
         2NtMTzsY9HYV21xzgdPq+0R4w2xONHsO2U0x90E8D05k7VistwdFf8S5cicBRyqG0f8V
         nPu3KMOXg70Y2UDHxiXC5nMUqDfgf7dievYrL2HHcguScF62r2rEYbtRU+LHy8320viI
         HMefXyFKb55m0TfM67X1XYlv47MSh3S4AqOIkC3M1vhdBjkSJJZu69D8/jNCZvOuCLWK
         +b2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780326205; x=1780931005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOPuvve0GGHfgoNvEY/UT1iUdehbmxAd3MGizN3iksE=;
        b=MHweJhUaB30/d0SZi03SgcLx1AajzxQ5EIxZYJvmW6qrmlW3xyuuurzVT1sp9wiIJj
         vC/oaqrpTGygqdiobCC3098GwocAVfWN4PKypKjRlfy3r0s7xEvwwJKPxxbQmF2AtOAh
         Zi1J7vJHTS8Cj0PWm9SSodisflMKSUmLtQSxrZUp2WJqTYdTiW1VsW1uFtnE5h97ChLE
         tOewXjNP/iplK9T/WKTopCzClPOmkz1+1IH7zxWa4+E/r1PSdWDcJDlEYYgPZLv+f3eS
         qZ9vA+QQCAIxjPAk47/LBBEbTa5YweB865ZF8PXFhngE6aqg7tInMOsIuJz+KZfu4Rpd
         eybw==
X-Forwarded-Encrypted: i=1; AFNElJ/FcsoWiesDsJbXuIOi9m1sPHoECZQW9c+PfPJGR5z/hPXBKXjFlMgGTVYHop+FFfuKYfO2dUbyGZIUoqOn@vger.kernel.org
X-Gm-Message-State: AOJu0YzvaiPqcJtTcaIparpQhZsrDYKOXmgsjALDSw/lvehlRXjWdm+T
	tCHkUcasuawHBfLf2x2+zPlbYkQlIHeaZVTTrWXqct1Vd29Tx+o2ZcRC
X-Gm-Gg: Acq92OGE0TxZUESBsCcXLGgDc+nUiDiI0jSFelFrMTfssvJgxFOeTaUBdw4J78/nRPt
	R0FQaW2n8SiNmV3vHdvrKZ3UKrjgo4sV3EI8NA4vrlTilDV+YAsrOso2enqKkKzOnRpkM65mBCb
	vDHDdbm78ZTefZKF6lxNf4KkRpJOy+CTO4m961UwiGAN7PRthDArMagjQzbXE6XspLT4jpOoeeW
	oC83iKiA8RLixwTFmYiMoOv12MMCsjaeaSUPs0ezUIHcWpPzv9HHEW19pzGp/cR4ZyZeNEvoZS4
	sfL/7BL1Zd+/5O5OQ+mFbi9oXmrB/80PhMQzCH3UVYLvMbYkTVrRqzO3G3de2RoI5UWleLkxD6b
	LtnlV23/yAwjLGREAAuN1cZN/3MoYZK2fWFB3pfUzs8fSiW8KuF5nW8UQUnApkU5KgE6jMHcXAr
	3XqpB1X9t5OA3AdTCALqNw24JclljwXETLuO4Ou5Ap3faPXDFLf2Slj2WKdFZM6yLoeKuWLgeJN
	PdmuMkJhg==
X-Received: by 2002:a05:600c:8b30:b0:490:adb6:7957 with SMTP id 5b1f17b1804b1-490adb67fafmr48270735e9.33.1780326204677;
        Mon, 01 Jun 2026 08:03:24 -0700 (PDT)
Received: from f (cst-prg-92-135.cust.vodafone.cz. [46.135.92.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c127befsm80837185e9.31.2026.06.01.08.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:03:23 -0700 (PDT)
Date: Mon, 1 Jun 2026 17:02:01 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Chi Zhiling <chizhiling@163.com>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chi Zhiling <chizhiling@kylinos.cn>
Subject: Re: [PATCH v2 3/5] mm/shmem: introduce copy_zero_to_iter() for large
 zeroing
Message-ID: <rvvwfa4dp2wovn4vlglajxwpumiudvcgbnrj6fwh4dxtxemawh@rbav4cliyraj>
References: <20260601055704.167436-1-chizhiling@163.com>
 <20260601055704.167436-4-chizhiling@163.com>
 <ah2HfH3jJZDiNAQc@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ah2HfH3jJZDiNAQc@casper.infradead.org>

On Mon, Jun 01, 2026 at 02:22:04PM +0100, Matthew Wilcox wrote:
> On Mon, Jun 01, 2026 at 01:57:02PM +0800, Chi Zhiling wrote:
> > Currently, holes larger than PAGE_SIZE cannot be handled because
> > ZERO_PAGE is limited to a single page. Add copy_zero_to_iter() as a
> > wrapper to support copying larger zero ranges to the iterator.
> 
> I think Hugh put this optimisation in the wrong place, and you're
> perpetuating that ;-)
> 
> So perhaps we can start by moving this optimisation to lib/iov_iter.c?
> And then you can redo your optimisation on top of that.
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 243662af1af7..06c54d719fcd 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -451,7 +451,23 @@ static __always_inline
>  size_t zero_to_user_iter(void __user *iter_to, size_t progress,
>  			 size_t len, void *priv, void *priv2)
>  {
> -	return clear_user(iter_to, len);
> +	/*
> +	 * it is noticeably faster to copy the zero page instead of
> +	 * calling clear_user().  Shame.
> +	 */


This is a rather suspicious claim. If clear_user is indeed so terrible
that it is faster to copy, the routine needs to get unfucked instead of
the problem being worked around.

I can't speak for arm64 or other non-amd64 archs, maybe these are
horrendeously broken.

On amd64 some archeology shows the following:
1. 0db7058e8e23e6bb ("x86/clear_user: Make it faster")

2022 vintage, replaces thoroughly terrible 8-byte per-iteration write
with rep stos usage

2. 8c9b6a88b7e2f33c ("x86: improve on the non-rep 'clear_user' function")

inlines rep stosb at the callsite if the CPU has FSRS, otherwise
fallsback to a new routine which does 64-byte writes per loop iteration.

FSRS is reasonably popular by now and chances are decent the test jig
used by Chi has it.

For a size like 4096 bytes, the 64-byte loop will be slower than rep
movsb and even rep stosq. This needs to be patched and maybe I'll get
around to doing the needful(tm) in few days (it's not hard to write, but
some care with testing is needed).

I could not be bothered to check how the workaround showed up, but it
definitely needs to be removed as opposed to being perpetuated.
