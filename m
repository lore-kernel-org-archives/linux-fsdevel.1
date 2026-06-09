Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84327190462
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 00:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780964473; cv=pass; b=fFRcKsOcj6NGd8mLEQdPhqPv3X1YA99bmF7aNj5ZmOs+qr9gOu6Cv9HjP5rSn1QvmAdbl9rXH0J/XZowERC9tFcOgDrHXAHcFFCPOCK8gyUaqE5RSX/pruSd++w4LjD3Ib5w8QZbDB8eGwy+r0KjJ2ZQbyGFqAxUgJu6sR5w/Pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780964473; c=relaxed/simple;
	bh=QABH8jzSt/aXWncmWu3vB4DHHIug5dSmO2eSPEX3UFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OtJYDcxBejcyRY49jwVrBLvMCEsfUYGkz7DkRzyoF453NRE5w5bX+2/b6X59No9XWMuQqCEYYaAhtuGxVUX7pCiRJ2gznwGalWeOyaUsTryewQt0y2LebrfdtE8fPnRW9shlabyqNf9/vP/nV+9dXMz/1aZrrdwbyYnZdunvppQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2NOPs1H; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2NOPs1H"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aa68e66128so5007429e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jun 2026 17:21:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780964470; cv=none;
        d=google.com; s=arc-20240605;
        b=Z37TD5D+PQRaQMO49D45UoAaHDCRyHy3fI/Bbp0LhS+s6J1zqyOLUKTFZusRqAtF4m
         E9sIhfpq49TxUFUR26jFn0gZ/3u5KnR5vrmajkSVun0ACkyB9ZwmGJWHmccbmfs53hHO
         b03hfl8IR/4NXCwwSZTgxjaL/5BFXixuV3/pPXPcglLL5Qs1PE55CoipW4tPxX0Zab0o
         wKZDVCTXD6jrmftUaDNu7nyLzdvVFRZmeJVlHt2DftEK8aZwvarrTYxvP654EFaJmr2F
         6xSUDwkBAQYN4JrqM61x8U4mfRSLw04s0b4MVjNq41URrX0z9sFR8wT1r0SsY73Nd33z
         s/Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nMxKF71adannrd63C7MsvxGSgfSWBTtH/nWzNGXKxjQ=;
        fh=LwcfcAYM1pAT+JPpdoRP3XnctuORLRU4EMu4dj3GMdg=;
        b=G55mnb3gOEMAn/y9JOsNgEdy6TQkm2mmdIKoHWHPmlAe22zHXHR4aweEo5BqpZUVVP
         sQ81mfDNKUeO/bwALyauzR35Gz/KEcvzBw1nqpUUXQraUeWlxkOUImztWhj8TSOfH7Mz
         zxs5SlSz+4iFIiOgxDLa2LhvGJAXYbw7+nbPzDxWsi3XiSb2dT4+y+HJ8z0r+bDVYeDh
         gpeVCqR/xo7/cUotHhM8ucmmMAA5fZUx0Pvl9qTEJAvlHE3bsBw1klz4PVayjx1vQcHy
         CfjPejMYm0wrhpY3bWNc8CRUFLS1+pTw+5gHsgMySLGT4pZxuj0mjGYZZu1ZvqBq63Ma
         sDHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780964470; x=1781569270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMxKF71adannrd63C7MsvxGSgfSWBTtH/nWzNGXKxjQ=;
        b=B2NOPs1HQknuJ/cPTnXwviVfQ3IGnLRurFGvrZiFmn+dFjWWGbJ93nvuUfwuTfxqMF
         R5v5PqjUTWqzlAyOSpLCISg1ogxP/5usC4QDvQDNSLmArFcY2/Lo5MD6HMpt1WWROn1Y
         6R8B2vBSFub6efFfX0N1096h9TAlj1IpnrVjhNqoMVweKN0ZwUgXjtMqiTHpbVC9unr/
         94azaLNHHBpngkY74Ib9copVJWNEHXarvUrAWsCKx59aC9rRxTUsbVmMEew1KMxwElR9
         wmo5QFKzw+dikbq1l82NlwtA4MuUu6lpN24vbL3KEk+y2VX7id9eg8APBCM9x1t+vEuW
         ualw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780964470; x=1781569270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nMxKF71adannrd63C7MsvxGSgfSWBTtH/nWzNGXKxjQ=;
        b=iiVAXDki+lIEO89uQ/zWf5bDqqSC3NMHpOC0T8XmbmQn3nOc75+MkROX9Xi6pyZsUG
         rdYE2ZMcMYJh5xF8WL+2gx7t/pzkJMzSYHIuv4+4Pc921Ld3iSU9Zg2Nk+6XLBjLuv8v
         ewD6FiI6dbjbOao8nS4rOSkzJk4WVkHe9QypTku5r2l/IW7K/umAzUG+E+UXj/d73ENe
         eKMAMKyNDJ6QS41TP7uWzzCGalfqWze83uKi4dAdj1YLRW6fuY1NZ1lo36PkskCDpwq5
         N9SsPnfuO+oAg0fAdGDMekq4YcNTdvn1P2Fv95MlFHLx8+ObrIGe2kGTzwJlY61ulHEP
         dH/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/ZtfUcJUQ/NozUzHDkSz88O0ppyRbV/FZVAv3PpiEMKzmyrmnwj9C058dznvYseLsPi3/xYUO4t9EtJcqS@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2i8ZTJJuylPtDWot8zbMnTqw9yWA0pz9KCEORFt3CgSJpK9R7
	fSaMivu/s5SLMRppiSx3xtyeUwNOmA6O5LLX3SRVQGdG0SqfeeXhZBDfiMbyvAe7EPj2gl0EF0E
	Sw+BVA+r223AURfjt9S4IeJsSja7NX6M=
X-Gm-Gg: Acq92OHvZppb1GoGZ0pAz3ObcGLml/Fqu+oagL1g511r7/N0b8KQf8A1V9PH5I50XgE
	iy60F4zaCgHUpU+CNMxeRPWqfU7Tt10md4gnbNQVNTvU7lu9C4fBaagkSiHA2RA2dJ+mCn+DiLk
	vMANjMhg34OIFFhdVmp9UsFy8ZpzwbtGBtckeB2vs8s5Qn8/bJNxSsRt2ZKK+OJOwxMT3dq5zW9
	H/wcRAsXRDNkNHARFOYSGj3kIENfOE/j+d/ytSbzwO24ey13ncyfavVfZQ/Gs75opGEp4nxEROT
	32sp3QS2+WD4+jAbmA==
X-Received: by 2002:a05:6512:1596:b0:5aa:8824:156a with SMTP id
 2adb3069b0e04-5aa88241616mr4463116e87.46.1780964469559; Mon, 08 Jun 2026
 17:21:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608210618.3437216-1-willy@infradead.org> <20260608210618.3437216-4-willy@infradead.org>
In-Reply-To: <20260608210618.3437216-4-willy@infradead.org>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Tue, 9 Jun 2026 09:20:58 +0900
X-Gm-Features: AVVi8CcEVGKC8OwDulcWh78ICZQdlZ03a8-9zWvTs7VbPspvNDE-uJyVOZ8fkyo
Message-ID: <CANFS6bbCV7L2spgNPNQTn+uMNaT1259yhbVvH75+5bzt77LKxg@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] ntfs: Use zero_user_segment() in handle_bounds_compressed_page()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 6=EC=9B=94 9=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 6:06, Ma=
tthew Wilcox (Oracle) <willy@infradead.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
>
> This fixes handle_bounds_compressed_page() on highmem memory
> as page_address() does not work on memory which has been kmap_local(),
> only on kmap() memory.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
>  fs/ntfs/compress.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
> index b279f38636d6..89067fecf5a0 100644
> --- a/fs/ntfs/compress.c
> +++ b/fs/ntfs/compress.c
> @@ -108,16 +108,16 @@ static inline void handle_bounds_compressed_page(st=
ruct page *page,
>         loff_t pos =3D page_offset(page);
>
>         if ((pos >=3D initialized_size) && (initialized_size < i_size)) {
> -               u8 *kp =3D page_address(page);
> -               unsigned int kp_ofs;
> +               size_t offset;
>
>                 ntfs_debug("Zeroing page region outside initialized size.=
");
> -               if (pos >=3D initialized_size) {
> -                       clear_page(kp);
> -                       return;
> -               }
> -               kp_ofs =3D initialized_size & ~PAGE_MASK;
> -               memset(kp + kp_ofs, 0, PAGE_SIZE - kp_ofs);
> +               if (pos >=3D initialized_size)
> +                       offset =3D 0;
> +               else
> +                       offset =3D offset_in_page(initialized_size);
> +               zero_user_segment(page, offset, PAGE_SIZE);
> +       } else {
> +               flush_dcache_page(page);
>         }
>  }
>
> @@ -222,7 +222,6 @@ static int ntfs_decompress(struct page *dest_pages[],=
 int completed_pages[],
>                                  */
>                                 handle_bounds_compressed_page(dp, i_size,
>                                                 initialized_size);
> -                               flush_dcache_page(dp);
>                                 kunmap_local(page_address(dp));
>                                 SetPageUptodate(dp);
>                                 unlock_page(dp);
> @@ -758,7 +757,6 @@ int ntfs_read_compressed_block(struct folio *folio)
>                                  */
>                                 handle_bounds_compressed_page(page, i_siz=
e,
>                                                 initialized_size);
> -                               flush_dcache_page(page);
>                                 kunmap_local(page_address(page));
>                                 SetPageUptodate(page);
>                                 unlock_page(page);
> --
> 2.47.3
>
>


--=20
Thanks,
Hyunchul
