Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12B313B7A3
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 00:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780964393; cv=pass; b=SnmDvd04A3LHDNWqArzMF4r9f5vXS88pcfR/zTiUwBdF7GbC0+p5tTk1nTdZKh4gMxwf1zfySxvCQGwcUhGZfWl+zRyKwa/r7sGBisCBr9LfVWXVMnc5Md/Tz9wOXf/oMUDObmTeJOJj6mNa0H2VgcuBuNJ/r2Kkmayz0f7C99k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780964393; c=relaxed/simple;
	bh=w14+/cxYVhcBwMPGM30O71HhzxA7wu3cNT+Nu7yJG6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=APgcN1Du5E8rlcc5lKyJuZLnWqYP3rNIQnjt77HAbFU4QbDSPM4wLz5WWy3YOB+P0p/UcxO8A1FJGSHiKEIUxxWC2KuSIBz91lgkmpBnYoz4FhsmhFjbrp89qOb5Kf4mKaLsKJtPdpwY7G/JJvR6odoYxNzjT7XoiYpCmzxmKD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhWQ6pnw; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhWQ6pnw"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-396aacc5bcfso48519701fa.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jun 2026 17:19:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780964390; cv=none;
        d=google.com; s=arc-20240605;
        b=ei/PzvsGP0RkgwrQBTTVskXbX0xskDgAySgcYYoFdMyJ+ei6SaOfIg5aHJUFsISSW4
         niFYdxwBtACUo49LDI0DVn0FHc3IXIAzLIaY7pGXE6/wAtsUbSDDeJ4mtt3S0SGb8V9u
         hhZsKV5nxpap75xCor/tkXYu7BRQgsAFZs8D3Icn+JeAFSncs2sH9Lh3g9I9p4zfTaMN
         +nA0jZM15fPeVafNKIPl0vgNJJavbxdY/3ncjdfB244WMStq0pDG3ghUFrVcR33yXmNn
         JIvibOtR9tvoET7SKMQLHA+tdmpaPRum/N8XwngtJxSPBFj5hC+fEahP80QBc+3rdU3I
         Zq9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d98c6s2kvLtGQyL/fPqKwrvfQEsZ3E8WA771oxSRxZc=;
        fh=KqFxD6IwGF2TyOLeyEnkxbS4d1RGAUULp5o/cGqlVJs=;
        b=BAmQzJq+yJ5KfMBl5dBl/YoX9eIApwLPcKQn2zkwfAFBGVji2QhG5KqDlXXoBcO+at
         NzZo1C8y45WX+mWfsg/VOg5NUkAOiOPUo9RZhGI3n54/Zx0pRi6/joz9Nb9X/YalbUI0
         LyTYhoSyiu2DBK9m0+j0OodxX+//YIalWn4qhFBsYDPV+rQfKnOP/8wo0p5TbFjO4uk8
         6K8gHaoP5aR/m7ElNjrSsqE0a92sDmp0Eh9E8KZXaAiyWkEDBblHmuh9ZNRmnc5z4Zg9
         xjUPC8ErbLP3LrUDQGzj3kcCSgrZarWHwRVhGnXVO68P6vuFOWnYPAgis9i922B/s6Q8
         HvXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780964390; x=1781569190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d98c6s2kvLtGQyL/fPqKwrvfQEsZ3E8WA771oxSRxZc=;
        b=MhWQ6pnwGE/m5Lvtl+pmU/UmaQvABW+TjhnbGj1dUH44l3VpBQ0a5Uy/qR0Ylb0Gim
         7BEPPepc0JLrgoxbVz2ePFRDuGXWXwQFO+vTcLSzJPo7Vw9iH/uDYj6VQnjcW/PaXuE8
         3xfd+Rx1s30YlRDaPokCFu1AXs/pDhW2wu8o/R0GIE+Ub/uXFffbVVfUwTvqoKYBszrM
         kSFDEvfs4DiR13RfZQV4IJKRclLI5FP9dtvDrlPee2gW4mzTtJgYseLo6eHupsOGriGR
         mo4N+hfg6zxHxV8pIgNCL5CElutXKd8X1usBi6/bo7HML1Qpwri6ReruA2Rfz5IYb3Uw
         41aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780964390; x=1781569190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d98c6s2kvLtGQyL/fPqKwrvfQEsZ3E8WA771oxSRxZc=;
        b=r7DkUGFCr14rj3/T8+NE/OnZVO2jIqNLqOzAFjF/jyZLJV1L8Hd6vq21Zp2D4Pgdzg
         oveyjXBUDSWJwz8jrjm8ugtShlUy4L7AtIy7clOwBakW4Pz0qiRwezvsac+ZqSyEBQdN
         bQE4v1K1nWl6w9qWIMBNUs6UrPUP2JwvkxJn2clkFWIFgaceyciKeadwE4jrXcDMYs6M
         SJOFqst6hf+hSQs1WddS5WSHMIJZL5m+/A43k00YHFCluJTDjYOaudqJUIQVwxWsDHAD
         AnZLnceD/6eEW21o+c0DT8brBoUOcCLKz1LaM5LMi/hGgDC5BLiZeAF8sim14yQy0vSh
         PWbg==
X-Forwarded-Encrypted: i=1; AFNElJ8eb2bFpsycL+lurOsF6zO7guAPqRoPfhB5eYV0afEhNMwweS3y47/s+TDKe6mmOMYd2hMjtPnLmjUYyQJq@vger.kernel.org
X-Gm-Message-State: AOJu0YzBcSFaZEz1t03iz2tv74iNWC3Tw10QVqiUwHF0XliotdOBqSW0
	gf8Cch69bkL9tq6XENgZJwH2pReiwoirxqKpuMdILX5JaoikcFiRuZOZFjMKhctokf5vZGD4x1N
	gr8TyCNFof3NNXkT45ltWW/LfDquAsPVyHk13GII=
X-Gm-Gg: Acq92OHMcN+9krp0tcgVG/JQ0XjDIbDHEt7XC+wvFHw8z1eWIHQeorA4CEqxj8wRjqJ
	/NT2h0Q7J1eiumlD89hIhEvRG9sZyiJSoEOPpOCbbhRAd7ut8NVNc4SJpxzW6XrxoF9w1Y9LF/y
	h5LrvByHiRDCD2L++P4ZFZgaGeCDFLBYNcSXh4nsve2qpgFvYzqAKZhdqvQAepApjZXJfsCUY9G
	XgAfNUr6Q8ya8v8y8qMLOuXhTJ4FjUywa1BtrTctZEpA8QeIgQySDdKdZkQkPyhksT+1DMkMQGF
	O6n+daUUicQ5jeX+KA==
X-Received: by 2002:a2e:a5c6:0:b0:396:746d:a985 with SMTP id
 38308e7fff4ca-396d0909e45mr49447141fa.27.1780964389837; Mon, 08 Jun 2026
 17:19:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608210618.3437216-1-willy@infradead.org> <20260608210618.3437216-3-willy@infradead.org>
In-Reply-To: <20260608210618.3437216-3-willy@infradead.org>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Tue, 9 Jun 2026 09:19:37 +0900
X-Gm-Features: AVVi8CfNYybqeEpp46RIwFhqYlePCm1gyn4zUKznk7FbjqXZt8we5ivClHmKorU
Message-ID: <CANFS6bahb-gXNWhtoTAxnf8cx+iV0hsAr6zzrSh9q1BmvR=HQQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] ntfs: Remove use of __folio_index in handle_bounds_compressed_page()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 6=EC=9B=94 9=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 6:06, Ma=
tthew Wilcox (Oracle) <willy@infradead.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
>
> Nobody is supposed to use page->__folio_index.  Use page_offset()
> instead, and simplify by working exclusively in loff_t instead of mixing
> up loff_t and pgoff_t.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
>  fs/ntfs/compress.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
> index c904858dff3d..b279f38636d6 100644
> --- a/fs/ntfs/compress.c
> +++ b/fs/ntfs/compress.c
> @@ -105,13 +105,14 @@ void free_compression_buffers(void)
>  static inline void handle_bounds_compressed_page(struct page *page,
>                 const loff_t i_size, const s64 initialized_size)
>  {
> -       if ((page->__folio_index >=3D (initialized_size >> PAGE_SHIFT)) &=
&
> -                       (initialized_size < i_size)) {
> +       loff_t pos =3D page_offset(page);
> +
> +       if ((pos >=3D initialized_size) && (initialized_size < i_size)) {
>                 u8 *kp =3D page_address(page);
>                 unsigned int kp_ofs;
>
>                 ntfs_debug("Zeroing page region outside initialized size.=
");
> -               if (((s64)page->__folio_index << PAGE_SHIFT) >=3D initial=
ized_size) {
> +               if (pos >=3D initialized_size) {
>                         clear_page(kp);
>                         return;
>                 }
> --
> 2.47.3
>
>


--=20
Thanks,
Hyunchul
