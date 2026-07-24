Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5593B71C7
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 16:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784911217; cv=pass; b=JJjc8IuTK3Gq70ROp/QvtjFw2EzjZfRbNcuA4HDj4zW2zofdExC0WrXPzg4/0u/a1ftNZ0GPfNxtGYb/XTNkaD4BMfssEn+LENIfDjHge9bZ6zW4e6Z54gfq5IcKmsXTW5nygdjy6rayu5EtcigAMAohRZqoPUjKpsgEPLM0Hd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784911217; c=relaxed/simple;
	bh=weW8VsYTYn9oe+SdkOtmnnv9F9A8TJbBNcTCmR119lk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rf9cqczNB5dr26jAHVv60tNqee7CNRTpQO4khfdoP65/ZFETLEcAYpA0C+Nj+y+sgxyV1d1JJCFrm9GefGS78x6jjf3S8eGgPh1lnD+7/6bscE+W4WW4ArzHYOilf8EzQ82341TRk70p46IukMEyE2Y/2wJOnVWPdr72hiMZE8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MPPiMd3c; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MPPiMd3c"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so632102a91.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 09:40:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784911215; cv=none;
        d=google.com; s=arc-20260327;
        b=k8hZE1vlAMJrcddQ7IUzHhkc+ECdm2KS4FUm7fP8b5kUw0qZEGS4HznvKFxYNIU52E
         DMQvel7RO9qpV8Dj2qs7t1n2Qe3cFZcEU3ol0KghSY7QXihXfzqo3k9mTX/ballknhbt
         I25Kq3oAdpwcQTn1uGy+3pR3te4fdl5dPH5R/gnY6lZAxcZtlD6xnaw7k30ktYHepx4d
         nVl44hSflJdT9fqYXbbGdr6H2j/whPnsng3mukg5McFCstWPz48OEkmWMmwTeFMBu0yL
         fjmjTi9clYVB51sOeVcv9vd5w5Rsdd/sFih3fSP2LZ6HHHuFcAi7ItJWMWwqEsyO7xMb
         aZuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=QR0nGvYgKRecGnQysmdmyOrVg4xxkcSJ1B86xgHnGNM=;
        fh=lF6YefdOuxifw72rLyqsvdkVqcCA+1GFaSX5039nxWE=;
        b=UNNV5i/a3ECblJJPFruc8PW2g6+6+M9BPm6RaiCnGZgSFl9Y7r/yE2aAc/NAWwmFpX
         G0Zb6+LRBIXtN1E8wgxWf5FlzCJenHKfM1Yt8SSnZublOOu5U2O8bCEBNf4PMrN9x0rS
         eawR9csSHYwEBL9G82dCDmGcVp8p7rJ6sc9Dd7K7eG0eOtCF+0KnD5KdXLHzF83SEOww
         Qum+IALAFTjSmXDLmhZuJ09PLl/bdM589gTsuAod0BrOeY6vznUujZxHT+qRiQTlxgT0
         gN31CNRfOCyz8zikMy0EAzKIT/028nFFMiJgHf4V1ER76AElqhH/YlFmfqiWkFr48XjO
         cvUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784911215; x=1785516015; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QR0nGvYgKRecGnQysmdmyOrVg4xxkcSJ1B86xgHnGNM=;
        b=MPPiMd3cEL0ExvKan/70fGFlB2kYVAARE2Co39A2XZfwniP6/eFR9RdsgwECDXLDCg
         n1cWX6W5BzuF2fbvK+A6W156zP4Y122ycLRwjocWvBDQ5wGYPD4RJ/bi4XAVp+mVzPhV
         HE8AfxLati6BK20gQ1mb0lmzwrYcuLnNM/avhDuw5aR17KoNgzwh8fF9zma2DECO/F+Z
         8G1RBstUM48LlxKZcuwMwpa8IupX+hfeTiUDjFuz2jWH+KPvTemgChQKXowMpACS0xsK
         dxNPGw3NaYzInUf/P9k3GBiUEakN5i+ySId0LsjGOfYKnyKni+jhMy/aBOV5Bu5CHEPA
         X/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784911215; x=1785516015;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QR0nGvYgKRecGnQysmdmyOrVg4xxkcSJ1B86xgHnGNM=;
        b=UesajKRMGrc3ZLsSgIA9z4OPNI7ulnb2w0hWDdGkJo2ihJutvGfOWrY6/IOLhzXjjQ
         uSHJYLaINMsfw/n8IkUTryLn7WEhzsmnmbKWK4NVgLoGWfRCfB53Fn7tdDjvBKXpPXtF
         aKIFv8Pankd1JLbbU5r78GwQkrWxs9FjGkwDuCPJyIY4ReWUA/rrazbJf+FbzmtdEaRI
         2N5KDbNGaTFN1dszHmWrCVq5XF6B046QYOcCt8j7qCvJ5A/4bxmoC+YBPPz1cTV2g27X
         LiPXGjoR/Yv33kLZItyAf1u8bp2xaOMMNtIUIgkhjAlfzlyjcgzcFA3stP0Jsio78jSG
         5ZeQ==
X-Forwarded-Encrypted: i=1; AHgh+RplueBSKCyDUsdJOBanpsE6AJEH4n6dbIVI9zCJ5et5JQJVXXYLd9cuTt4OJb9ognwiK6Dom0tTB2pwZ0Ux@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9lil9T5B+rhDLpWwVMTt6Xyw8WN0Sh+ycf92hHNx5pN0wAde3
	GQrxIinbqzvHsz+UEKlNzb5qmOT/msy/YhEVxGzVyC9o+McZ9oWdDs4leps72jsMwt9RkBP9q60
	rvoGbWwv+22w8YKdsedDTdh5ytAgSXXm6l1o/bHxe
X-Gm-Gg: AR+sD10jRzdvR+h8drm+g4se0+6IUgzC39ok8e4v/1j/0q/RsGy4benGhVihRCFru6F
	AbQP+X5ObqvTHPI82BKNlWKIzP3pvpRrG0na4+ntFDEtW3a78rTKa5Hbe9ck6lYNHQ6O7xfxCVR
	hfbh+ua7w7BzSk/+KXgbM2caJWvo1iAeIW7aazjOjgUD079gGpsd3TpTp8E408H0XORri7LA/rz
	NkzoodVKX/+5sB8O/nDlL9LSsLrCK5pGxVreJg/MKNeObGzJEFB553m1rDj71klaDHclFPl530O
	KW4lkR0L/5+qYUXlnKJIsvvIfoDzDajt8gFD4n/TGXFySTs8
X-Received: by 2002:a17:90b:314a:b0:38e:712a:bb38 with SMTP id
 98e67ed59e1d1-38ec65ed982mr8187972a91.24.1784911214011; Fri, 24 Jul 2026
 09:40:14 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jul 2026 09:40:13 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jul 2026 09:40:13 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260723143034.175661-6-willy@infradead.org>
References: <20260723143034.175661-1-willy@infradead.org> <20260723143034.175661-6-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 24 Jul 2026 09:40:13 -0700
X-Gm-Features: AUfX_mwTvn3TL_REn-pj_NwgsA3C7Q4eLFAVFbwA733yc00SoA8wGHsmRDLESEg
Message-ID: <CAEvNRgG04hWKkf8F-fq2PbRfG3WdPb9dzvJd079UEwC9AQkR=Q@mail.gmail.com>
Subject: Re: [PATCH v4 05/14] guest_memfd: Use folio_has_hwpoisoned_page()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <christian@brauner.io>, Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

"Matthew Wilcox (Oracle)" <willy@infradead.org> writes:

> folio_test_hwpoison() only works on hugetlb folios today and will give
> the wrong answer for other large folios.  folio_has_hwpoisoned_page()
> works on both.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  virt/kvm/guest_memfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index db57c5766ab6..94eedcc7f1a9 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -774,7 +774,7 @@ static struct folio *__kvm_gmem_get_pfn(struct file *file,
>  	if (IS_ERR(folio))
>  		return folio;
>
> -	if (folio_test_hwpoison(folio)) {
> +	if (folio_has_hwpoisoned_page(folio)) {
>  		folio_unlock(folio);
>  		folio_put(folio);
>  		return ERR_PTR(-EHWPOISON);
> --
> 2.47.3

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
