Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914EB1386C9
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 00:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780964556; cv=pass; b=ShRylikkIpMsWAwtGrivWtnVJ0vP+AKjF8IFdKXTgOYL8cyLShycna0yrAeoE1pEKfNtYeU9DsK4k10oDjS9tkLQ7AExOKx4VLYjIW+DwwUhT0UNHwiZU7M3qCltiFjyVKIgigZAu5vhCzFkXjS0SxBAc+sKHPGa6RqIVLx3hpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780964556; c=relaxed/simple;
	bh=AxNIqGYg4pe0/GuEywHxmuRF7MsEy4C7HF5Jad75V0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ApJDz6nx2whLHxdj8jHuTMfmfXnTOKHIj7xrhgrwWHwav9kUbZirdiuoWX0UOd0uPKuacePLJmjKB+6WdoWl7xKC+5P4P65pCnxM9nHvZ+SgnuX9C5klXceGrWO9YwlmBvVstGH69RlyS/pi0dZQUPFGG4aQLgKme4h16k1112I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCPgk2BL; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCPgk2BL"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aa5edf347eso3236586e87.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jun 2026 17:22:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780964554; cv=none;
        d=google.com; s=arc-20240605;
        b=kENoDwSTOu+6U5u9rV+bCqdXdAeH3FSeZ/kpnPvc96K2UURm0R/dCwqzHfYc1a6cMc
         TcwWuf/T/h5BPbjTSvUzuL/A2NL0g/eijDQanbNRm2yJZ/tKi0mExull9cQe2r0Mf2F0
         9KC1f3JNrtDoDE98FfNLHad6xrfznMlxtGTk1ey8+Htluvl/U47PaXUEXcr5uoemT9vR
         HkHCJfCiJKXJyUhiYuXRMlHDVzyJn94OmwJ0jXIPO9kR0om7uX31brj7YNLGIXklzdPR
         K2FKtXfOjP7KMOkzQ5tPgyM9iRgcliohTl756vcRRO6n/Nqu1HjX1UGB1EdG3S0DSwb6
         MG4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/r868swnwk6b4PbmCC02knXswyUVMKeggBBbPSgTEpM=;
        fh=gCfGKPnoBfdCkxIr7IK4klFz24wmynCVE4Ij11xjkgY=;
        b=gUm4Dq2c2ERQfnonXhfwv20s0I0iITFYya/mpEDxoIEKX0xORbAJgFyKQ5+G3j/kRe
         jAqecAc/HDs6m9wxYBrjYe6z5eQAyG+BMzGNwOSXExN+RrbkqzxPIQuvkVTMv2XZ9FaC
         eqIjAxWG/Oibo4YXlG5V/8OtgPMLGUHqbx9QIEKht/tBJ+szYTkj3hg6pnBdDr7HuUg4
         8vDTfGo++6JJR1+EswByAg6CFGrRDwjFaj0IEKtanbVrutnHC8HrIsn4cqReZogmlFJv
         o7oZmCN5f45WvSdW9PmG6iWVqvzx5F3SRxvaWWy5rmwUJJ8e6HwliEHTCIBE6jGQOrNe
         2Frg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780964554; x=1781569354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/r868swnwk6b4PbmCC02knXswyUVMKeggBBbPSgTEpM=;
        b=SCPgk2BLKPREEXlA1uIyXb6Qt/G+4gtmaajUltYSSHKWYCBDrz0x2A9x1HSccZB4IO
         hbWZ/vHqsmtEdoAmp4533ZARZ6hU3lZPNgtRaHooYeuq7ExFVwMiwhyoEWJxteHdRLQC
         yScQgG5hnDKFrNoiBCli2slTFhMWZZdcQzKbPMPqfYVdXhoSIRjMGLx3Bv88eJmpS2rE
         bTcS+hMlWsCJFjD2COKsd6uLHx3x73u1a63CnbtNHZfPHrQc5cYKc935mp02t8ofHj/E
         AIstaX7IwUXes27a+XnKwPG9dHnPtCDikY4ly5Im99b6wLO+IZPBQjhXy55QQI9UwuDO
         up9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780964554; x=1781569354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/r868swnwk6b4PbmCC02knXswyUVMKeggBBbPSgTEpM=;
        b=AOL7UKD1bU+7geY9MpjcwQRABEiMzW+L5dZlyLE+awESjUDUSvqY8iOHRsWkwDO//R
         ILVfg2q5HaGTr9JkspHzuD0325g/sVSquSiUK+QWKTrOC7o+g7ynOQzshepRWoJq4lIX
         Cop7gi2VDcCaz12BJDMfXVCFhR1ibkTm9XEar51zPL1agRoiCAabTXhUBk/7q8W7r4O8
         2LKzvvEXrlraTB8Vd8J/ROmB+K2myrfJUceFElHCYs4TQsR9Dhbgurc1JAb9mTBjgUF5
         O6dPHPfW1iYxSoO4g/V3hXxk2ENDLQCH/TjDdN6e73gOhqya6/K2kiX+xDhV/6rGLiQG
         a7AQ==
X-Forwarded-Encrypted: i=1; AFNElJ9QFL/yQYyqhLRO5IQlmmeEdfXhVmPMRBLG8re/jQJG6oWXZdSolGJs1V6t08nkCZhfoJTm4TJFNwppRZOe@vger.kernel.org
X-Gm-Message-State: AOJu0YyjfCQa4cahwz1hGGNn9oaoUjkIV80itgRH6Cmc4H3Emiblj1kg
	gbh8GOutvzJsPi2wcHTiuprvuhKzN+Ja3YVJA1DAwh2FGoW9z6AUyKm0Al0/yL3CeqNg4rZV+Bk
	xGdE+C9jSjzpu0P3p8y42wiBXoe+u2aQ=
X-Gm-Gg: Acq92OFQqrbPWSn7d9facnjsi1BwiQMHly0PM3Iuosk4muU/kNvlfLU9dPDYAt5dqVs
	IAPlq+kURLmKrmbS/5xAQgC12Kxud/DTwqsJ4fTjuRQVpXUcQuQUsTgBu6x8c0zPzVsFqEk4gCK
	o5rU+yN8myKSDq961lKzunNHPx6O02LnYakVmPpVblXBDaTC8Y8tYrFiT8NJ6fJB8Y/VyE2junA
	SN9WhU0/nLqvAIcPHNZErZo3oMvMADBS1akV4uiIu074bh13jujur8s3ucFHzV6f+RDWEP13D09
	xwm1XfuT2rBdjRVlvE02beaTvaoa
X-Received: by 2002:a05:6512:3092:b0:5aa:6a12:7d58 with SMTP id
 2adb3069b0e04-5aa87bc8f89mr6724065e87.30.1780964553687; Mon, 08 Jun 2026
 17:22:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608210618.3437216-1-willy@infradead.org> <20260608210618.3437216-5-willy@infradead.org>
In-Reply-To: <20260608210618.3437216-5-willy@infradead.org>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Tue, 9 Jun 2026 09:22:21 +0900
X-Gm-Features: AVVi8CdVNgx7JSzQmEQ4hsGBApI4RlpcIiwPoZ_I7mM019Hx_PxCkgAVfMUqQzE
Message-ID: <CANFS6bYejoz4cuX1n4h=En1RhzmNb6urJdFGw9df1qNxdpD-0A@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] ntfs: Remove references to page->__folio_index
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>, Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 6=EC=9B=94 9=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 6:06, Ma=
tthew Wilcox (Oracle) <willy@infradead.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
>
> Pages don't have indexes, folios have indexes.  Correct this in
> ntfs_read_compressed_block() and also remove a use of page->mapping
> while I'm in here.  Also convert the calls to unlock_page() and
> flush_dcache_page().
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> Fixes: 495e90fa3348 (ntfs: update attrib operations)
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hyunchul Lee <hyc.lee@gmail.com>
> Cc: Namjae Jeon <linkinjeon@kernel.org>
> ---
>  fs/ntfs/compress.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
> index 89067fecf5a0..eae0339a8518 100644
> --- a/fs/ntfs/compress.c
> +++ b/fs/ntfs/compress.c
> @@ -455,14 +455,14 @@ int ntfs_read_compressed_block(struct folio *folio)
>         struct page *page =3D &folio->page;
>         loff_t i_size;
>         s64 initialized_size;
> -       struct address_space *mapping =3D page->mapping;
> +       struct address_space *mapping =3D folio->mapping;
>         struct ntfs_inode *ni =3D NTFS_I(mapping->host);
>         struct ntfs_volume *vol =3D ni->vol;
>         struct super_block *sb =3D vol->sb;
>         struct runlist_element *rl;
>         unsigned long flags;
>         u8 *cb, *cb_pos, *cb_end;
> -       unsigned long offset, index =3D page->__folio_index;
> +       unsigned long offset, index =3D folio->index;
>         u32 cb_size =3D ni->itype.compressed.block_size;
>         u64 cb_size_mask =3D cb_size - 1UL;
>         s64 vcn;
> @@ -811,14 +811,16 @@ int ntfs_read_compressed_block(struct folio *folio)
>         for (cur_page =3D 0; cur_page < max_page; cur_page++) {
>                 page =3D pages[cur_page];
>                 if (page) {
> +                       folio =3D page_folio(page);
> +
>                         ntfs_error(vol->sb,
>                                 "Still have pages left! Terminating them =
with extreme prejudice.  Inode 0x%llx, page index 0x%lx.",
> -                               ni->mft_no, page->__folio_index);
> -                       flush_dcache_page(page);
> +                               ni->mft_no, folio->index);
> +                       flush_dcache_folio(folio);
>                         kunmap_local(page_address(page));
> -                       unlock_page(page);
> +                       folio_unlock(folio);
>                         if (cur_page !=3D xpage)
> -                               put_page(page);
> +                               folio_put(folio);
>                         pages[cur_page] =3D NULL;
>                 }
>         }
> --
> 2.47.3
>


--=20
Thanks,
Hyunchul
