Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F5A42AFB2
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 20:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784838904; cv=pass; b=jNMdyTFOQuz+hva+QPiSdBUCpHBR1ZkU5ZcYGCK/jkAqFUFMM6gP58BmYam/pQoF8b7TBEbnGtKKRbt4icDeX2YhD+SFx6R00C/ELGqSRbwf31DjkcOixN6OHfNqiwj7a4IzvMUusVPB42XgW1F1wzlkpmCzHc0MIbz7m40YMy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784838904; c=relaxed/simple;
	bh=R3ZBRQeLdAV+uLNkFaWvtnsFjrlD96P8SX9cas7gHFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6eI/W/QM7dZCodu+6LvfHZ+9KK2eQvKg/UNVl5nrUYUFOk1UoYKXq8vj7weEuOn3N+N1RU8icLumi428P9LnMYLm+YqpCO2d22yKWWtC5MaZykkXsfKXSvj/7ihgJ93yguS9GLQBM+xle45EJ6Dh6IKKG8X23I+ZKxsG+c8L8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V9SaCYWL; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V9SaCYWL"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b0129cf6ffso2486e87.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 13:34:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784838892; cv=none;
        d=google.com; s=arc-20260327;
        b=hKemJOWhh9XrTsHsLLhawK69kDIA09CFMBjyWylf8h3ypZz5HUYplEBhrxs231zGr2
         vFoOmP1pEX/MddTLGpuAwH7kSYLaiz/wQy9CIGjIDQC7UUNI5kCrr6wPKRMoXF53WDwc
         gKKYuad3B2Gw1Q2OAsUI6lctOx9iPV5kbyBv/vZVwduaZy8z5T9RDx5Q8QZKEYO0afdo
         FFgpXDxjWf3Nscxgsm4B9uQRXZyguioSsIDsBJWHJpsAwDxRC4tjF0nXmEN9eK9BuSOR
         pN38IWpx5obHZiRwlewxWgwJkiw8f/SsoOyM/nQiENtQNjeYaBbseB0V2SSkBNba4RCh
         f1tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kEd5Z19QO9gSWI1pJHRYKW58SP1uRktgGVYqFC8ZvOg=;
        fh=eNfPAEzTKaEojuEEk2EHDSMB4NL99kzQHtZUz5ty1xs=;
        b=aL4v3RLo0214EX2lzMSHCdMgpZMJ3Kp4x42TwtbtLE2HY0BBqUgtzePzHrbYVnXbVU
         H1fa+r13n8cEm9eV2PxxOb0SUco9xwbhJxa2ntW73tGK+bBKKA0qqtdpyUYWYpWfVZaw
         1+LbBkn6zmvpGKB8UmPk+6PNacJX95sUXPV/fUMxoD9zOuRLPgk23/UubEDHC8a5ex5c
         DAit9XimOoHl5G2LLIVwmx/XwYXRgI9KJq68cKr8zOXoFE0if8WglDUUGlr7mt4fDdrP
         6NDjzSc6Ty9D1Ux55wJ+aPcfAUch7h7FKIkyJifpFSKD0pd+U/OHaK6EFNZkklalJUrS
         8oAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784838892; x=1785443692; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kEd5Z19QO9gSWI1pJHRYKW58SP1uRktgGVYqFC8ZvOg=;
        b=V9SaCYWLzq2zSdmwo12BuJqBkoYa9r/15eXwatAPmI6uhOxUO6iyfqi58kj4y3S8a3
         OJH8duIwNvXJ/6FjOAwRy3+LneFmVjZVeYt4zNk45Db0to27kX7NczvZ/nJZJh+DQvSL
         khkvKfVveHYj4MjUuelRN7yNb+mpFabHOXclVX52TJhjU98tTX18N2AdIEy8k82CO+aH
         976RslimTJyz96VlhqxZpjdpRuSluAkfYcKNSqd7SPF4F53WAXa9D1G/GmNgqbNN0ESh
         2XXR+BGhg9wR32iCvNKLbAUsvQnII/QTpAICm+npfTFMCAvO5HzrJVNePY01JQAuG/Co
         +J5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784838892; x=1785443692;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kEd5Z19QO9gSWI1pJHRYKW58SP1uRktgGVYqFC8ZvOg=;
        b=eTTo9dRZl7mes/dr8FmRLjCE/y9KfSi4E7a7YbSCkCqXz8rQZZwWOPDfb0FrAgtMwx
         KdJYJTxwR/VSq5LMMPoInyRIh5xuyykC+5rpXmS30gfW4MwSSY1B6T+YUX6owEDxC8PM
         UXPgCLkcR3zyzdLvAh2Pt1ULqaVddSodH9IA1qJDzl0GotUlL1WRrtUeMbtsdnzzKca9
         iMkW3dydoQhPfxBaH9e0RFibWAVYF1pRJiGIhSLcXaghZ9eEYhqL1ixMwCwjOx8UaPw7
         yGfbhwyjsMZ9aF0GSoK10skbKf8z9G9gnXOa0nKSikaMH2pfH1AmEk1FO56ekx2Unevn
         RZsw==
X-Forwarded-Encrypted: i=1; AHgh+RrrINXTsXpA47s8Yxz05yOaENBGsMu7qbRill9mGSPf/KFo8zHniW7ms1K1fuoa/bfuFSrpmQV0sYvXi+Dn@vger.kernel.org
X-Gm-Message-State: AOJu0YwtNp9sab7o8fn9yN1NQfqW4LaJVwCaiRCEMQB8CGQBFqQ7ipG4
	Q/kHEjfDMfg1Gts0EccfYlVm5/Qs85uizNLfVM5+WlzdPzLCEGTEraa5g4mjN2oE1vZZGis6TKM
	Z69j2TGcN2xhdbe07A4drIDZI9o9cfYGMRbCDV8dD
X-Gm-Gg: AR+sD139LAuDN40iSJshTelyUdRXNUYwPavlharJOrCiD/5fgzo+ck35i5NXMuE1OWh
	rc5/5TSmoSfS2sMWSkFw4g48pwmegiOtcQOUuUh/8mlqhi7GLKDCaO268wwJQxrkYmDuRubhSXY
	njc+kOxaqMswohASKgKY/mtRX4KfWK6FkNVDHKDS1DDIoDndLSIWdlZS7ZFFprtnIHZPadxzIsZ
	jY21mu4u9+k3aD+gDKcu8z7IDxldZSDQpAuCVd+k0gIvbRc0y5zccbXuEErQjWpcdItpki/yodr
	PjYvCw+2KXtMOEM=
X-Received: by 2002:a05:6512:2256:b0:5aa:79d6:b559 with SMTP id
 2adb3069b0e04-5b2b831579fmr41528e87.0.1784838891615; Thu, 23 Jul 2026
 13:34:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202606181547.617a6967-lkp@intel.com> <20260723024527.2822383-1-zhangbo56@xiaomi.com>
In-Reply-To: <20260723024527.2822383-1-zhangbo56@xiaomi.com>
From: Frederick Mayle <fmayle@google.com>
Date: Thu, 23 Jul 2026 13:34:38 -0700
X-Gm-Features: AUfX_my81u5Yiwnp3_sx2Jz9uaienneHL8ShgZjQXkoLqlzrqkAMEhV1zQf24kc
Message-ID: <CAHCxdc64d-6qNBwwSZX8mdz4-V+88No2x0wG4mex5WPXBDE9AA@mail.gmail.com>
Subject: Re: [linux-next:master] [mm] 7b32f64bc5: pts.svt-av1.Preset13.Bosphorus4K.frames_per_second
 45.8% regression
To: Bo Zhang <zhangbo0325@gmail.com>
Cc: oliver.sang@intel.com, jack@suse.cz, akpm@linux-foundation.org, 
	david@kernel.org, kaleshsingh@google.com, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, ljs@kernel.org, lkp@intel.com, oe-lkp@lists.linux.dev, 
	surenb@google.com, willy@infradead.org, baohua@kernel.org, 
	zhangbo56 <zhangbo56@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 7:46=E2=80=AFPM Bo Zhang <zhangbo0325@gmail.com> wr=
ote:
>
> From: zhangbo56 <zhangbo56@xiaomi.com>
>
> On Thu 18-06-26 16:00:42, kernel test robot wrote:
> > kernel test robot noticed a 45.8% regression of
> > pts.svt-av1.Preset13.Bosphorus4K.frames_per_second on:
> >
> > commit: 7b32f64bc512b40b268776c5ac4d354b325b3197
> > ("mm: limit filemap_fault readahead to VMA boundaries")
> >
> >     169.95 +/- 6%     -45.8%      92.15 +/- 10%  pts.svt-av1.Preset13.B=
osphorus4K.frames_per_second
> >     220.57 +/- 3%    +870.9%       2141        pts.time.major_page_faul=
ts
>
> Hi Oliver,
>
> Could you help test if the below patch fixes the regression?
>
> The 870% increase in major faults suggests that readahead is being cut
> short too aggressively. The current approach unconditionally sets
> _max_index on every fault, which likely prevents readahead from
> prefetching ahead effectively for sequential access patterns.
>
> The fix: only limit readahead when the fault is close to the VMA end --
> if there are fewer pages remaining in the VMA than ra_pages, set
> _max_index. Otherwise, do nothing.
>
> For a 4MB VMA with ra_pages=3D32, only faults in the last 32 pages (128KB=
)
> trigger the limit. The other 99.9% of faults see no change at all.
>
> Similarly, only clamp the read-around start when the fault is near the
> VMA beginning.
>
> This applies on top of 7b32f64bc512 and can be applied with git am.
>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Bo Zhang <zhangbo56@xiaomi.com>
> ---
>  mm/filemap.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 97772a05a18e..9f1e1c9ea6df 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3313,8 +3313,11 @@ static struct file *do_sync_mmap_readahead(struct =
vm_fault *vmf)
>         vm_flags_t vm_flags =3D vmf->vma->vm_flags;
>         bool force_thp_readahead =3D false;
>         unsigned short mmap_miss;
> +       unsigned long vma_end_pgoff =3D vmf->vma->vm_pgoff + vma_pages(vm=
f->vma);
> +       unsigned long vma_pages_left =3D vma_end_pgoff - vmf->pgoff;
>
> -       ractl._max_index =3D vmf->vma->vm_pgoff + vma_pages(vmf->vma) - 1=
;
> +       if (vma_pages_left < ra->ra_pages)
> +               ractl._max_index =3D vma_end_pgoff - 1;
>
>         /* Use the readahead code, even if readahead is disabled */
>         if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> @@ -3398,7 +3401,8 @@ static struct file *do_sync_mmap_readahead(struct v=
m_fault *vmf)
>                  * mmap read-around
>                  */
>                 ra->start =3D max_t(long, 0, vmf->pgoff - ra->ra_pages / =
2);
> -               ra->start =3D max(ra->start, vmf->vma->vm_pgoff);
> +               if (vmf->pgoff - vmf->vma->vm_pgoff < ra->ra_pages / 2)
> +                       ra->start =3D max(ra->start, vmf->vma->vm_pgoff);
>                 ra->size =3D ra->ra_pages;
>                 ra->async_size =3D ra->ra_pages / 4;
>                 ra->order =3D 0;
> @@ -3441,7 +3445,12 @@ static struct file *do_async_mmap_readahead(struct=
 vm_fault *vmf,
>         }
>
>         if (folio_test_readahead(folio)) {
> -               ractl._max_index =3D vmf->vma->vm_pgoff + vma_pages(vmf->=
vma) - 1;
> +               unsigned long vma_end_pgoff =3D vmf->vma->vm_pgoff +
> +                                            vma_pages(vmf->vma);
> +               unsigned long vma_pages_left =3D vma_end_pgoff - vmf->pgo=
ff;
> +
> +               if (vma_pages_left < ra->ra_pages)
> +                       ractl._max_index =3D vma_end_pgoff - 1;
>                 fpin =3D maybe_unlock_mmap_for_io(vmf, fpin);
>                 page_cache_async_ra(&ractl, folio, ra->ra_pages);
>         }
> --
> 2.34.1
>

I maybe missing something subtle, but, I think you've changed it from "don'=
t
read beyond the VMA" to "if there is a chance we could read beyond the VMA,
don't read beyond the VMA", which seems like a more complex expression of t=
he
same behavior.
