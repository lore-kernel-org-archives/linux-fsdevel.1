Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACC638A29A
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 18:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779129310; cv=pass; b=lfkqTIxLcHXgUSiZbCMfAhSTCrncAmsfko1g2YuQwMON6N9x7qYempe5aqSex7YFu/yhi+YPD0zamSOGgPZ5hCDwSijO9oPtDedXgUDqAChk//WnwPV1UnGQGMBm/MngpZ+oOgUoPeGseJwsw7FSstXTsSPB6YntkiVwBcT/fGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779129310; c=relaxed/simple;
	bh=zfBc4eLvgZETNVCwaMjtmiLlWfDM9HXuPjNpKwFyRoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P69IotDXSJRTVjPIIyQnDX53we2WPhSKN4dMNoT/b2Yk1ksGuGo3kTxmJdSBaYd930wsLDMH/qTJaPz7zSL38Xyn9wpdY5YjaKm2qFem4BgTA9K7ZcAwhf+cY+IUSPLschzJ/U6EyfvkJ+TGRIqVBknhQS5cYCyY1bNiwGi9bmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdR80rO4; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdR80rO4"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48909558b3aso28193535e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 11:35:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779129307; cv=none;
        d=google.com; s=arc-20240605;
        b=YzP1D7k/VysoPhzW4MlV0rB/KHw3UCVyj8u0Wo4bFswmqYV9LGitlAqTsBJ+5p71at
         hQ/5T3tsZlnsTWS6MXCWuQTGdcpQ61rFZvAZ2GDPStIjvG6U0HuPHzuzXSU3MBkQdznp
         aVcxnbW42Twt9rvD/n7puUStLp6ZARqzJqFiDT+SswvxR2+J2OxIb3hm/Qdtb0Ky0tFX
         7J7z4/IiYVyzXNhFZlDth5Y3xcoZw0vkhAd0sp2vJJHKJocqtpJg1lb6mvht8kciUvES
         lsrVWORxu1erfy0tES4KBr+RAMyIuJygIi1nXK0ObKR6WK+LXGvFKdeJWE+nQlTmN6n7
         k0zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E8btY24TAcxNFeMHHWwcrKm/g35Z5vhN3GDcpOLQS4U=;
        fh=c473iD3pqox2Anw+paqGnYRfvyCNrw+gAz1UDu3iip4=;
        b=H4fm3UJB0qRWMb2UijR87lYbfCL/iat0cMODlN3mlcw+GDd9MqM53dQ2bgvViD+O1H
         7NzPVNQrmvNJlnDzqLTleajFYIZqTy2NK/jExKuA0dtdMbcg0cCfRO/uzr9QK2tJXHc9
         SnK6pz5FIeggOWVxsadV6PzZiDcwAVO1HI6kGKXpuU9B4rAvWqcP2ZkVJZAOewcVmZoj
         eTGP2BFQ+0fo5epeD4WB8TSeS55wdUaYETBlhlTf2FL2sgdQYZNdJWOdiTHELlsXwh5w
         pGe/uUXHciPcI+QAUlThk/Aay1zS12ODUEMZjil0awt8jjA2xpdZO14uDgVLDiuDPSo+
         6DaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779129307; x=1779734107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8btY24TAcxNFeMHHWwcrKm/g35Z5vhN3GDcpOLQS4U=;
        b=jdR80rO4BjRcbOCWaEbrRxJWS261dlaD1bKeW5/1lZW0eI922o2+oPuOXPN5U2BK3L
         h3R5QiYda2+fVBekWbVg0JC/rUUzBq0RstW5gx/KrYLkm8Ofpj2LIgYAiKxik3I2VVKd
         4+VVVfmXCkvUvznsm5r2w/Dx99/wFOWEu5EQgRgm5DRaPRLggJrPE5oW09utVgIk9GB0
         0h5zXUnxhY2lM/KL0F18GdbfnlbX/rfgK3LeuJ7B/tprKMvfeoOWq/o8Yva12Scv3iYV
         /VYCffMbten2P6oFgxSeaeDB+FxUpXaKq/anHP+ZOP+kZHxgZGQiaYC/7RBI3K3PBs7x
         0J9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779129307; x=1779734107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E8btY24TAcxNFeMHHWwcrKm/g35Z5vhN3GDcpOLQS4U=;
        b=Se7pIbROPVzCU9FgpsE0GZX35Q7FzQG3XlJLDBsm8D630xvJICNgt2F2ehDsh/lTkZ
         /WDACYmBDB8urp2nmiCU3FoU4UCcVIdOf8Ubgv/rLkrvBhHgldgqJymvcffd1QLIliPL
         NB/IbxGm4C6Tp8SBJxjBaI9ZTtDUYh1twKr5urCkOpFVDTZm/xNmoY5ZQb8q6pmjBTiw
         8m4vQVTVCd/pTDn++BR2xUFjvabq7U6PUTTAoWMp8o3c3xHaPTkaZYYGzzZww5c95D+h
         bs8rsk0np2D4QFdtNt/DVfEkfrMvnt40X6yvJqueeaAm289wgbMGipQ21LY0r0iOggtk
         pggQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ji+u1PYYA07B3zVdYhruNun5lez4KvC7jkWrwmUkSN27n3zvZM07UfqMr/+aouFTKNk7hr7JUIS8VA4HU@vger.kernel.org
X-Gm-Message-State: AOJu0YwZOUl2jWbUfBwa38X7DQUnMSiDxxU0lQBRXgRNr5o0JD0Opvf5
	DsBO0/2LZvkEUSxKF8320Kx9wWMHRIylKnde25RS8Hq4xEw/d2rv4RHRRfbNjymfzbhTqrebBG5
	hpQwIxFvkPwDB5lelx0U7vUmUhP61p08=
X-Gm-Gg: Acq92OFX/ki7IPJwH6U+zQ/SYFUgbHMx4LuydwUA+IWRQLSQ/3Lps73UrX2Vx8t8pED
	DfEd2PYZWqIifm/hTMKu32C12SQxV0vNLKueYc9wnQ+cLrmAvxUGekC6Wwrz4sKll9oL+nck/qO
	wuM2BuOvdQg2c9vTqvY4JqmnxmDAAe8qm8EQz399TzelninY9iBwnultN5lnYaj3cui1XcwHr5F
	CVcOCb0cRLBuwo6lY1g5bq05qd250BWjljPSBlJDzlRwrjX+bNn9SESupbN+97f+lDNS5XPQyP1
	0PUN9Q==
X-Received: by 2002:a05:600c:3e1b:b0:48d:46a:6e5b with SMTP id
 5b1f17b1804b1-48fe60de6b2mr247664865e9.7.1779129306765; Mon, 18 May 2026
 11:35:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518182602.3107764-1-vlad.wing@gmail.com>
In-Reply-To: <20260518182602.3107764-1-vlad.wing@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 18 May 2026 11:34:55 -0700
X-Gm-Features: AVHnY4J3xr2Gvp52xK2OIEcQt9FQCDBFKVIWkl5crcafzqFIXkmK8ZECoQZjAbQ
Message-ID: <CAJnrk1b9ZDH11+0Eq9ZqkoeiU3t_qxs1SUGTmPUB==gmyENZ-Q@mail.gmail.com>
Subject: Re: [PATCH 6.18.y] fuse: avoid 0x10 fault in fuse_readahead when
 max_pages == 0
To: Vlad Poenaru <vlad.wing@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Breno Leitao <leitao@debian.org>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	fuse-devel <fuse-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[adding fuse-devel list to cc]

On Mon, May 18, 2026 at 11:26=E2=80=AFAM Vlad Poenaru <vlad.wing@gmail.com>=
 wrote:
>
> When fc->max_read is smaller than PAGE_SIZE (common on aarch64 with
> 64K base pages if the FUSE server advertises a small max_read in INIT),
> max_pages =3D min(fc->max_pages, fc->max_read / PAGE_SIZE) is 0, so
> cur_pages is 0 on every outer iteration.
>
> fuse_io_alloc(NULL, 0) then calls fuse_folios_alloc(0, ...), which
> calls kzalloc(0, ...) and gets back ZERO_SIZE_PTR =3D=3D (void *)16.
> The "if (!ia->ap.folios)" guard in fuse_io_alloc does not catch
> ZERO_SIZE_PTR, so fuse_io_alloc happily returns an ia whose
> ap.folios is 0x10.
>
> The inner "while (pages < cur_pages)" loop runs zero times, then
> fuse_send_readpages(ia, ...) dereferences ap->folios[0] in
> folio_pos(), faulting at virtual address 0x10:
>
>   Unable to handle kernel NULL pointer dereference at virtual address
>   0000000000000010
>    fuse_readahead+0x14c/0x490
>    read_pages+0x80/0x318
>    page_cache_ra_unbounded+0x1c0/0x2b0
>    page_cache_ra_order+0xb8/0x368
>    page_cache_sync_ra+0x210/0x320
>    filemap_get_pages+0x290/0xdb0
>    generic_file_read_iter+0xd0/0x540
>    fuse_file_read_iter+0x8c/0x158
>    __arm64_sys_read+0x1a0/0x488
>
> addr2line on the aarch64 vmlinux maps fuse_readahead+0x14c to
> fs/fuse/file.c:897 inlined into :999, i.e. "folio_pos(ap->folios[0])"
> inside fuse_send_readpages.  The faulting instruction "ldr x8, [x8]"
> loads ap->folios[0]; ap->folios was previously loaded as 0x10
> (ZERO_SIZE_PTR).
>
> Without this fix the function would also spin forever, since
> "nr_pages -=3D pages" makes no progress when pages stays 0; in practice
> the NULL deref masks the spin.
>
> Bail out of the outer loop if cur_pages is 0 -- there is no work we
> can issue via FUSE in this iteration, and remaining folios will be
> handled by read_pages() falling back to ->read_folio.
>
> Note: this code was rewritten in mainline by commit 4ea907108a5c
> ("fuse: use iomap for readahead"), which switched fuse_readahead to
> iomap and removed the buggy loop entirely.  This patch therefore
> applies only to stable branches that still carry the pre-iomap
> readahead path.
>
> Fixes: 3eab9d7bc2f4 ("fuse: convert readahead to use folios")
> Reported-by: Breno Leitao <leitao@debian.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Vlad Poenaru <vlad.wing@gmail.com>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  fs/fuse/file.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 6014d588845c..782178124512 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -974,6 +974,16 @@ static void fuse_readahead(struct readahead_control =
*rac)
>                 unsigned cur_pages =3D min(max_pages, nr_pages);
>                 unsigned int pages =3D 0;
>
> +               /*
> +                * If max_pages =3D=3D 0 (e.g. fc->max_read < PAGE_SIZE o=
n a
> +                * 64K-page kernel), cur_pages is 0 and we cannot make
> +                * progress.  Bailing here avoids passing 0 to fuse_io_al=
loc,
> +                * which would return an ia whose ap.folios is ZERO_SIZE_=
PTR
> +                * (0x10) -- later dereferenced by fuse_send_readpages.
> +                */
> +               if (!cur_pages)
> +                       break;
> +
>                 if (fc->num_background >=3D fc->congestion_threshold &&
>                     rac->ra->async_size >=3D readahead_count(rac))
>                         /*
> --
> 2.53.0-Meta
>
