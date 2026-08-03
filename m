Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698DE40DB2D
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Aug 2026 17:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777977; cv=pass; b=aJbLwCWtvIt+CX9Dp9ak7y6aHvez0rhyCL1Gni+1vfgooTTwKsbFkCqYnHunyPh2Sa77aiJ/RYojSEyZerFPfDkpyy6izwWqZSf4gGEx0/fClrLBijikC+nuelOaxRzRdkBFxH6KNTHa6doC8jgV34gKIVNNXVYXTyPyN2grl1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777977; c=relaxed/simple;
	bh=YYFMeC+FN3YZg0BN049Gx/irP3ROKki5oZBGZ8LfupU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sDWLgYXD3A5kc3zl2k/QHNxlcZ5GReNYX/GHOjaSfNUfW5BOcRwnjOai/LXtNLpcMPPS1z/T3rZDEo8SLgW+tX2eibFWBIeFaNn7UqvcJIJ8RY16GEDLHK0DzKN5rYjfr1G0vmKcv01QYnHr1AT1Gjw5b57k1kDtK+5+nIh0sTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQi8MLg4; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQi8MLg4"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c1c50c1e29bso517145666b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Aug 2026 10:26:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785777975; cv=none;
        d=google.com; s=arc-20260327;
        b=hrHlRODIf+h3VQF0miKILa+tIMLjND8NwQmlm1dNQOvtTZhSiiLCgVo/f1yyw8YGLi
         wia1eOHVI9opZdRQw4bbDcWwrVmm3VNNYbFmCaY5PFKhsCMpFinMgVZ07Yr+mcC+MFrg
         6TEIVAaotwpgIIpjRQp2FKc5pGR6auKRc944G9r0zby7FqQPLZ4VVZF/yiB5WM8hY9iB
         2ilRhTD6xpbCKXPGFtUIa/wta2vF9QLbU3VAQLovBKvEcD0ITBH7RI3nJqvjr4T2v+WQ
         1rUD+3asY+sTXZ3TPVfsRGzhm9qbVol7rFXBYTutQsLVF1Znjj5SeqfCdDZQ/1BycjxM
         2FcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EEAN21CbnYulWRvHH3VOFW9BXSHzD7GgPZMrbMx7rZk=;
        fh=VFHemT6FUtMwlLr46R9z2SbXvNcY800LEGT9WHtNRq4=;
        b=V0t3ee1tBnILFWsUymO36TF9v7J3T7Z/gPXQIMZ7nDyjvfnoh6zSG31QTdg91sgvEj
         TDrW+FW06CI9xaFvq8OIyhtqldekcKi1WWl0q7+aPTLTF8E0pq7ZxuqsKWfOQvxHz7gU
         rGkqNpW8adenTB72wZ5GYddLfrSj7UxZyyoxiMYNOsUTGXGcws6GyDJHKWSksfUdbeNa
         rEBbSYAOYZqL9f8RkFSgcWpPVbt68sg769f1/GgYFb2eh692Pl85v9zZpIVRpVM+2Xiu
         gW3mgc7VnNos8LET3eZvY2drrKp9UlU8WtvMIz+Q/pdAtgRAppV3IQLImyFbxduFRjhl
         uubA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785777975; x=1786382775; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EEAN21CbnYulWRvHH3VOFW9BXSHzD7GgPZMrbMx7rZk=;
        b=kQi8MLg4uIRUgS3AewnFSVAviz0Q5TSy9WjhMvOY+W4f6vKGSiPwQrTYADIX1x27we
         Q7FtQdNBL5NKcTwbvFdbr48bCA7zWARprpmUSm8gn0piNpZMWlJ1TMqJjKIqQ8Q1Uu4O
         SThJ66Ewi86/sackVANbdbdx2Pug485s3/f1LTwd+nwJCPfbfikgEkaKceSxhdJrPGsH
         T50WReDy1sV926yT0D285JCD0OCuUOFqlGB5H0GEqw4FshyDDyooL6blAlgVxsjPGlUT
         z7enG+612dJMA0XxN4zxhQB1E3XbIYAwFVO9q8V8OXAvigkuVFWP3lC18pI2930PqJVQ
         a2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785777975; x=1786382775;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EEAN21CbnYulWRvHH3VOFW9BXSHzD7GgPZMrbMx7rZk=;
        b=DRl0kiprdc5iJm5uAqKcJG3j+uQO/sIpO+I2Ewo1gBA4MLGQLoH8yF/iVomDQf/zpL
         TtRjvYASSqGeENaLMNuLTd4kRLNTmByb1vFUMpdO1ytlNvmeDxqrk0b9FtRAZnmSzqlL
         Xo5IXyne/owXy5Pfw5tmj5yBeWURnBfWyjHpXhbXgTFLl+tb7EASw/lHthjT8onwWiS+
         i0YnWLgpvJrfRyyt2Z2eCtRJ6PqRku5A32Vb6umEjnDGPNdV24hmVt49sJYztoWLp7zu
         b5w8j0mOeVm4qT1y0TVILea2g9uLiMqrpxl6LGIDe9yq0XjO49Nzwfk8XKqQMJ4Hp0nt
         NLqg==
X-Forwarded-Encrypted: i=1; AHgh+RqgBvUjIErOJNkQwCBx810Z1IoPAAz+yiDNp/9kbhVD+/KU+32C/HO1wO/3X2+auYG/x2OefzswwRXTHmRm@vger.kernel.org
X-Gm-Message-State: AOJu0YwZAPR4oOMWy2Ctzd0a9l7m+5kPM/CwQ3N6lAkUzrS+OCIIeEn3
	wWCRjA7RATus6+1iAOvEzLGYoVtU4BNprkRkyO+57+KnHJmAOo4sBTToefDVaRGctKNu/aS54op
	JmF95/UMjIjMD3DKV6reQdz4PMTHg4ro=
X-Gm-Gg: AR+sD11JopTCEstjUztSXm726lwGFpnCt7YLfxeNdXsHChu4L8SXW+Es6HE6JkaRfWc
	u2Z7rfEwCroXvPSJ7F2UgXMgYzINcKgvDfpt5lWk1dtrFavNdorLwks0Tug6PNVqXlc3G8InAjA
	dkmXMUKaXnWMojhJ5bm4q1CJRJEakwNLvAYWILE/3KEI0sarkdgEPFB5RcPlYQSpvPGLG4+ux1b
	FR03vNAraIsLuuJ7v+D9Hk2U9KAbsEKAseZ61Wl2mtfO2PKVh1/90XppPV7QLzY2zWe9Xe9rBsO
	ifjoLqhNjFdgaGEqv4hpvcJqxLfyViXQnVbi/CEpnW05SE623IzyeS0j0e/JMSyUFtO3ADQrItR
	gGg==
X-Received: by 2002:a17:906:fe4d:b0:c19:5a94:411e with SMTP id
 a640c23a62f3a-c1fe7f9ec8amr1056858766b.15.1785777974228; Mon, 03 Aug 2026
 10:26:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730-add-gfp_account-to-xas_split_alloc-v2-0-5a56c2361d85@nvidia.com>
 <20260730-add-gfp_account-to-xas_split_alloc-v2-1-5a56c2361d85@nvidia.com>
 <am28pV2PEfHsi4p-@lucifer> <DKFEEI2EDS4F.1AHGKB1EL6XRG@nvidia.com>
 <anCtxQE5hDUH5N6a@lucifer> <DKFEUPDED2AF.22PKCFTWTG6G5@nvidia.com>
In-Reply-To: <DKFEUPDED2AF.22PKCFTWTG6G5@nvidia.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 4 Aug 2026 01:25:37 +0800
X-Gm-Features: AUfX_mx1M6m7_LvJBKtV1764_tGRnsG4N-gDuqyCqQSvzFO3b_VTSjTaLVFxSCE
Message-ID: <CAMgjq7CHDG8JhesSPMkn1kzG8jKb0BXO756BvxMQC_MCn2eTyA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm/huge_memory: use folio's memcg inside __folio_split()
To: Zi Yan <ziy@nvidia.com>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	William Kucharski <william.kucharski@oracle.com>, David Hildenbrand <david@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 12:53=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
>
> On Mon Aug 3, 2026 at 11:07 AM EDT, Lorenzo Stoakes (ARM) wrote:
> > No __folio_split().
> >
> > Comment about cleanup.h really was the whole pattern of goto xxx for va=
rious
> > levels of unwinding things.
> >
> > But really I mean the folio splitting code in general, there's a lot of
> > massive-complicated-functions with a million things going on at once,
> > __folio_freeze_and_split_unmapped() is another.
> >
> > Feels like we should really have this stuff in something like mm/folio.=
c anyway
> > too now that's renamed :)
> >
>
> I agree that __folio_split() is handling multiple cases, anon, shmem,
> pagecache, all together. Do you prefer:
>
> 1. split __folio_split() to handle each case in a separate function with
> some code duplication, like xarray for pagecache and shmem,
> freeze/unfreeze folio for all;

Hi all,

Do you like a __folio_freeze_split_unmap /
__folio_freeze_split_unmap_file split? :),  I'm asking this as I'm
currently trying to sort up the mess about swap cache in huge_memory.c
and found it will be much cleaner if we move file related code into
__folio_freeze_split_unmap_file, and let __folio_freeze_split_unmap
handle anon and swap cache, and then saw the discussion here. (A bit
more detail on this, I think we ca just assume we just don't need or
want shmem swapcache split, because shmem swap cache is meant to be an
intermediate state during IO, and shmem drops swap cache once IO
compete, and hybrid half-tmpfs-half-swap state is really ugly and
should be avoided competely, swap cache lookup is still fine for shmem
just make sure the folio is not in shmem's mapping).

LOC seems lower with the split and swap part cleaned, they really
don't share much logic anyway, except for a for loop for putting the
splitted folio back to filemapping / swap cache, and a folio freeze
check.

And after doing that, for swap, splitting clean swap cache and
splitting swap cache to higher order are easily supported, a few ugly
checks are gone, we can't do that now partly because the code there is
really complex.
