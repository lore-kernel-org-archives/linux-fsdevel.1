Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CC1389452
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782235810; cv=pass; b=S4ZpBNX/sMDmStOsDOf3rb4cki4/xoe5NFTxHBAmPva/Bd+TW2HlL6M72cb7EpY2NfhD9jrZoIGMv9JSpKxoYPItfyQ4xnsz2o9irTTRCI35AK2xoc4gKBRHcU1JLS9Ik6GpXWmbJNfEQN3d8lXSnVmqC5rnUbuBbZN5gSqsN+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782235810; c=relaxed/simple;
	bh=1XpXzTFHWJsw8C2JyfoXebC5Ni6jg74rJbCKW4Yfwc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eBua06NS6EKsOkMbJxHUJiMrxstYnEBJ+Vczcn4sSKVYzP1KJkjtTiH10af+ji2OCEhpOjJwibau96Egm1D3uX3hE45R1al1Dis/Iag6fiLVeAyiMndiFalyAamW0MnjRbICKVwXHQTa5vWf+EAcD25reX/TpipY/baArmFe3s4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WytVRz8n; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WytVRz8n"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4633193af19so128986f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 10:30:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782235807; cv=none;
        d=google.com; s=arc-20240605;
        b=kO0PPW0l+fJGQewRKpzyNQYj4hYCji3yGhdkOxu6nxIq8j6+/xEHpUUrnmJLWajDDn
         dl91vcvBpTgH6YocfYe78YFe4NfWkAFDULheCK18mSHAyv1aAOLa3wubnMlavS1gLG5R
         5izZQ/52P6J1WiVJBRIo2hGbyTMjjOOal3/psqQ0ESbM5/M2OeF2l6nsqOYq+gzSbeVC
         yVpTj/rS2vMsPnpHIL2N169z1IknZF0wnzILkNr+oFMGGZ5p4X660hs6zsZaLqS0n8nV
         Cb3bQzf0rp0vmcSxE9EUz0SE0lnAUGMuY687Bb7KXpeC+BOnr+nkyAbqisRkEuDCyvxo
         /4/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RzrzEGZb0ltwNCVmNPEJth41Ktgi1EiQYCAOhqDS73Y=;
        fh=E72xanbPIlUtNUTgWpStiPA3LiVGamh19+b8dnTvxbw=;
        b=eZw3EMxkhr9T9BBJrJ532UopKAQuev5ilAQE2x5RNlAl2GUbKlafSnvZB2MWje1+ln
         DtUqSg2GNl0vgBdRYnPd7xod42rPCLSBW2jiyleCVGe5r9ZDXSNUhiPE7rYAm/zowGZH
         qDGvVwln0/g2BZWhoMovK+fP987jQY0+1G/TBzd7cNwBNB+INHB9DtiHmTgaI9ziRY+R
         zlZM918sqwwkt/YWoOJ9d76EGSdGsuBLOxNhgwyWPeZY/q1bZ2HE+Le/TzQ3znFRjBaD
         /OSnC4gSMCr/CXKK6D+ly4CPfCL4sNVL1XaVGGhKEOKA0rnDOKnsm+e7yS17o+WvVnou
         bIKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782235807; x=1782840607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzrzEGZb0ltwNCVmNPEJth41Ktgi1EiQYCAOhqDS73Y=;
        b=WytVRz8nYLB3avlW/jLj3IVXga/m71X/04RLBmvfCJvqQ2DeXyImIDE/DcHN5Nn1JO
         Xr/WpSFz/6fp7RO+Ri0Ne+YIpLZsrwnIg3xHrAQ9jeqQRF4FRkc9emusRIpBzK/rEiIi
         xtUIT4dRqYXQsb62fhxzwHhhpMZppJeV7OvvJZ+JCaJRrNmT8Id4LdjvrUBawr5Wd6vQ
         Cu2kVDyLAPb2r4Rm7sypv0NCOUu6H8BSfsqnG8xXsTDjnWIRiaYRAu5kW21xA6j8srQZ
         XECISBlds4LZ8cTdKAYK1rS7Lh4mkb5RKfMUxmfH6WACSS4B9L1UK5WFB7lCYf8TeGyV
         Npng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782235807; x=1782840607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RzrzEGZb0ltwNCVmNPEJth41Ktgi1EiQYCAOhqDS73Y=;
        b=GjQp7vRV/1Bv2nGXOZODfhJxopltu1CViN2i5zIjyqdoRv1hnNVnR3scuC6xpb/4hX
         wVpevJ7DGDZOaTBrOmVB7ZBBhpFrW+HINEAOahHLoIlixwBDJ7JLDkUYR5qPoIESUKSI
         SUhFLBPxicVQmfZO8YmEqswLXc1YTXNDzZ/H+/FQ8q28WWkAl8vsFjauz5Usif+0fkiG
         Zbxb+qqPxkdl5ok6ag2ZLAyAwodLu9AwW4miavx65HXOgEjRFYptgaeRYZ1Wg5xRr6Zr
         rQ9MFkngATfiuIMa0IAzU37ya66hPEJBfo1BvZBLSYS5lko8k1iZxNjeD+b/fdUh4ORc
         kIfA==
X-Forwarded-Encrypted: i=1; AHgh+Rry4Fnpz404WHC6ccZgwBhNV5DO9ugcqD0dJ1MGCmXxjqioIlPB5c3o0dSMToVEXQdcCmntyIIV2r/+Xm67@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk46MwPxVQ0AqAuigY7XObK+rb4UIFA57iXENYg1c3OGFMFYww
	lDukQgoVvSEp9YXbC8Noln1fXGMSp9SRDBR2aSVOFSEr+CTnpXJJDIC+Gb7wtLnP7mTaSSxXrtE
	gsKHD/2NnHXT1r/5HU/x0GqnJMYaU200=
X-Gm-Gg: AfdE7cmlWcTarsjQWihWw4WSWMQ9s29uYyK6C8/M5fkQzspqwtZ/KHcqHtsZApdr3q7
	LuatnZALDSzTtKBzsKYQJKRgDEBBv1XBx7vsDY/1p5mg/huV+85zlSe8VBBWmwnsuyuAapHMYA9
	oAr8F3TJpgzizb5GLBqB0GPh9Atj/x4MLS+3BB4ZJSjhZYHmkXtpFoNbJCxlGeb32/6/AUD1QKP
	WKefSQ0QQ9LaaSYUA1QytNaucxnWuglZjs45QIrFaCzzhTjNZDAugObQhex2OKkpo+upCc6aEPf
	G6e4rQymVOwpI5M2nLaumIN9sLWNgopOPXJ4DL8JpeXMK84abMtb
X-Received: by 2002:a05:6000:22c6:b0:460:3233:beed with SMTP id
 ffacd0b85a97d-4666348bb1dmr24453136f8f.41.1782235807180; Tue, 23 Jun 2026
 10:30:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623135208.1812933-1-hch@lst.de> <20260623135208.1812933-3-hch@lst.de>
In-Reply-To: <20260623135208.1812933-3-hch@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 23 Jun 2026 10:29:54 -0700
X-Gm-Features: AVVi8Ccm_eFaYYj-vQlgAXEMOrnUjeoeLhiRjoMn01eUhrTiB_xWHROB6LeYb7s
Message-ID: <CAJnrk1agx-qUizNzCnzvZ6Marf7u-K4EtKOak4c2MQN1sJfgNA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iomap: submit read bio after each extent
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, Kelu Ye <yekelu1@huawei.com>, 
	Yifan Zhao <zhaoyifan28@huawei.com>, Ritesh Harjani <ritesh.list@gmail.com>, 
	Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Hyunchul Lee <hyc.lee@gmail.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 6:52=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Currently the iomap buffered read path tries to build up read context
> (i.e. bios for the typical block based case) over multiple iomaps as
> long as the sector matches.  This does not take into account files
> that can map to multiple different devices.  While this could be fixed
> by a bdev check in iomap_bio_read_folio_range, the building up of I/O
> over iomaps actually was a problem for the not yet merged ext2 iomap
> port, as that does want to send out I/O at the end of an indirect
> block mapped range.
>
> So instead of adding more checks move over to a model where a bio only
> spans a single iomap.  Change ->submit_read to be called after each
> iteration, and pass a force argument to indicate that the bio must
> be submitted set on the last iteration.  Switch the bio based users
> to always submit, while keeping the single submit for fuse.
>
> Fixes: dfeab2e95a75 ("erofs: add multiple device support")
> Reported-by: Kelu Ye <yekelu1@huawei.com>
> Reported-by: Yifan Zhao <zhaoyifan28@huawei.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/exfat/iomap.c       |  4 ++--
>  fs/fuse/file.c         |  6 +++++-
>  fs/iomap/bio.c         | 11 +++++++----
>  fs/iomap/buffered-io.c | 23 +++++++++++++++--------
>  fs/ntfs/aops.c         |  4 ++--
>  fs/ntfs3/inode.c       |  4 ++--
>  fs/xfs/xfs_aops.c      |  5 +++--
>  include/linux/iomap.h  |  5 +++--
>  8 files changed, 39 insertions(+), 23 deletions(-)
>
> diff --git a/fs/iomap/bio.c b/fs/iomap/bio.c
> index 0f31e35567b4..f71aaaf60301 100644
> --- a/fs/iomap/bio.c
> +++ b/fs/iomap/bio.c
> @@ -79,7 +79,8 @@ u32 iomap_finish_ioend_buffered_read(struct iomap_ioend=
 *ioend)
>  }
>
>  void iomap_bio_submit_read_endio(const struct iomap_iter *iter,
> -               struct iomap_read_folio_ctx *ctx, bio_end_io_t end_io)
> +               struct iomap_read_folio_ctx *ctx, bool force,

nit: might simplify things to drop the unused force arg

> +               bio_end_io_t end_io)
>  {
>         struct bio *bio =3D ctx->read_ctx;
>
> @@ -87,13 +88,15 @@ void iomap_bio_submit_read_endio(const struct iomap_i=
ter *iter,
>         if (iter->iomap.flags & IOMAP_F_INTEGRITY)
>                 fs_bio_integrity_alloc(bio);
>         submit_bio(bio);
> +
> +       ctx->read_ctx =3D NULL;
>  }
>  EXPORT_SYMBOL_GPL(iomap_bio_submit_read_endio);
>
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 8d4806dc46d4..06a216d37548 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
>
> @@ -642,12 +649,12 @@ void iomap_read_folio(const struct iomap_ops *ops,
>                 fsverity_readahead(ctx->vi, folio->index,
>                                    folio_nr_pages(folio));
>
> -       while ((ret =3D iomap_iter(&iter, ops)) > 0)
> +       while ((ret =3D iomap_iter(&iter, ops)) > 0) {
> +               iomap_submit_read(&iter, ctx, false);
>                 iter.status =3D iomap_read_folio_iter(&iter, ctx,
>                                 &bytes_submitted);

should the submit_read happen after the iomap_read_folio_iter() /
iomap_readahead_iter() instaed of before? From what I see, it looks
like iomap_submit_read() would hold the iter state of the next
mapping. It seems like in iomap_bio_submit_read_endio(), the
iter->iomap.flags would be the next extent's flags instead of the one
that needs to be submitted?

Thanks,
Joanne
