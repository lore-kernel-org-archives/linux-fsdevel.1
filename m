Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B57D446043
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 09:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785318773; cv=none; b=Fhy5LwxKhcZF0MivALlccK41T0D/Eq7HzKKX0YdFW6K6d9ZzvaoQMunpNVz6YMyjdD/+cghOYQyAsVuXTjrPPvPklUUppnREbxEYZghFPJSx/pHBSn5JSDRSjXVpOMgE2SHocw6Sr5lJyHmdU1HRSWETvtpCliOB7QGbdhAkg+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785318773; c=relaxed/simple;
	bh=npoQEiDvN1yxH7BsBNSL0UIpLQBvzsgp7LVJ168Zdig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VO7OWNe+D3qV3BfkWXjqEO1Gf9TdQVBZZWjlCLmA4sI5+wC0heO0HEWaebJmPQhgqRmTNgIke8ycXNQpSOdswQMZU0n8/disqnreDiDCbYQMZcWEiCICaW2anOn8ynKcGgO0SCv18U+nl6hAWoAb8MlrxVp2yie3rEzEYYNkm2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XfJ92Aw2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OQqBU48v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XfJ92Aw2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OQqBU48v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785318770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IMtixXml2fd5ko/LMxKKst4tpZQdQmsUb4+nyDRXP5s=;
	b=XfJ92Aw27PlsrJV49FZmxupQOegn7Pbit+lN4GDMJeyXMB0nKsySjvh/nMLwoORBb9DkFr
	Qmac4qtjHg2gi5pxtAwOBbj3dylU95BQXz0MifZvvwNiappNuTF+heiwj03d4JfWH65AWA
	xRff0Iqvo/yKyzqPbDnGXhYqPI4inAw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-8S-ml1_TPfqXnxKljLWRdw-1; Wed, 29 Jul 2026 05:52:49 -0400
X-MC-Unique: 8S-ml1_TPfqXnxKljLWRdw-1
X-Mimecast-MFC-AGG-ID: 8S-ml1_TPfqXnxKljLWRdw_1785318768
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f83450a8eso720116f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 02:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785318768; x=1785923568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IMtixXml2fd5ko/LMxKKst4tpZQdQmsUb4+nyDRXP5s=;
        b=OQqBU48vEentkiII+pi+dE9cttvh79Std+RmKv+C7icrMLs4qfqaaabp8KhGpXnP2i
         zp3n+9aQIwZmdA+iq8ihLg939goND5Y/ZLDxE7RNSXsk73vsSKQUBOfsSungu8chdRB8
         cMOCnhh4c3o8YdSfFxQ6/TzKspq2rYrPg5VTxJRnoXJsjuXnEG0AU+WwBfV0cg68NbB/
         d42TCvCWoyx0hj0cVlxNC2AgC4BU/xHvnmvG/WVbgaiCJiYZYAaeI6/5Jm1kflSzLIzd
         WASIXhBhWlI0P3MNaHU/C3ZigLYmSY+qNMHwGCKk5BeKfvm2IITuAQkiQ4pl4X95C3b8
         Lmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785318768; x=1785923568;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IMtixXml2fd5ko/LMxKKst4tpZQdQmsUb4+nyDRXP5s=;
        b=fZR91KI4kLE8D+dEfhgcw96YOYYsuh+VMDRvD3BVtDwno8DSHlCJwGl9KerrrU1Xmu
         1Ie1gSnQT1M9UT0RXtAff+eR9rAJbS1y7BVCOeaWNBXzFuTVQ4Irn+V71lgooCtOBrr0
         Dvod22xAfwf8c6y6FX61Vm2BtZMD2qQ4fQX9mqJTrLNQNQ54nykvbWJQHRA5hY8FtV/A
         aT0cHJJ60czAIG4hPoN3hpQYjPgSGp4FEUQq2gSgVpIbotDjiIEb+jqSfJ5w5riR0B5S
         7ZqoR47BvR8ZkhxNeL2jHuRJOXBPpqGxcNEJlm0dib8JLdQYt5fnCMe5n0JfrniPQsCr
         F04w==
X-Forwarded-Encrypted: i=1; AHgh+RojcKwdriPvqsUxu22bJZGrUlF/icO0hq9xgsVFaxMmowEuYi3En0mecUTEgLSU3qfBj0ss0zNESMhhK1rw@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5lUaTFnJnRPt2L82f/FBtvcDXNdhg71R0XPbniGn2QK2cvh+O
	hRMZFE53KzIaknCMny6QO+tUxJp531FoJu4hH2OvFWsHrCzFAix0OfJoyc0Sy6NuihXSPxFe7pf
	0BtYN0A0hlDywPlUaeBdbQuT8MZ/lkth8MW7kzi/f1L33LPe37j3EXo2YTsBax4dEzw==
X-Gm-Gg: AR+sD11xI6wfA8vXyzTLXEbNcMQsF2h5//izNDfzdzRVfkRnTIy+eb/yt62QmdRC5Qn
	wwVhTeHczGIvgWigar/O9HJJFV+cBEZxbwbYZvi3HnQCBH2NBTLN0HFV4GMDcb/kAl4A2Lb/TwZ
	6bZ7wki5Fa0NfC544RO48INEHrlUlZ9bBKQwNZIcGjcARd2gMKbEJhiNK2qzWKjM094DOn2Pbdo
	Ek+nM9CZxym1VpHM2IgDzlyInchBqKRi6zn0tWt5H3kCHDxd12XWWKRibPgrATWXzv8wq7DUDZC
	PM9ObXkNhcz92Zk/6UzBmd+K8+MxYUEEth9qemzKpdAVZf1KZR2VZqkgO6F62BC00g1H12xF3y5
	QdvFFdHwDAxa2QKIsOY0cKc+p3hSQggPHyZw=
X-Received: by 2002:a05:6000:5c2:b0:47f:7aee:ed3c with SMTP id ffacd0b85a97d-47fb1ec81eamr8509535f8f.5.1785318768173;
        Wed, 29 Jul 2026 02:52:48 -0700 (PDT)
X-Received: by 2002:a05:6000:5c2:b0:47f:7aee:ed3c with SMTP id ffacd0b85a97d-47fb1ec81eamr8509465f8f.5.1785318767507;
        Wed, 29 Jul 2026 02:52:47 -0700 (PDT)
Received: from aalbersh-thinkpadx1carbongen13.rmtcz.csb ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6b1cf09sm6907867f8f.31.2026.07.29.02.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 02:52:47 -0700 (PDT)
Date: Wed, 29 Jul 2026 11:52:46 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
	Tal Zussman <tz2294@columbia.edu>, Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/22] block,iomap: fix protection information
 verification with initial bvec offset
Message-ID: <amnJ0rFnXTcfmcVJ@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20260723145000.116419-1-hch@lst.de>
 <20260723145000.116419-7-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723145000.116419-7-hch@lst.de>

On 2026-07-23 16:49:31, Christoph Hellwig wrote:
> When reconstructing a bvec_iter from an ioend for protection information
> verification, iomap currently ignores the offset into the initial
> bio_vec.
> 
> This can't happen for buffered I/O an direct I/O to user addresses, but
> is exercised by split on O_DIRECT file descriptors or when using the loop
> driver.
> 
> Fortunately the only file system PI user (XFS) currently always bounce
> buffers, so this can't actually be triggered yet.  But we'll want to make
> the bounce buffering conditional soon, for which this needs to be fixed.
> 
> Store the initial offset in struct iomap_ioend, and pass a
> pre-constructed bvec_iter to fs_bio_integrity_verify.  For the
> synchronous read case the fix is even simpler as this path can
> simply stash away the original bvec_iter.
> 
> Fixes: 0bde8a12b554 ("block: add fs_bio_integrity helpers")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bio-integrity-fs.c      | 13 +++++--------
>  fs/iomap/bio.c                |  4 +++-
>  fs/iomap/ioend.c              | 14 ++++++++++----
>  include/linux/bio-integrity.h |  3 +--
>  include/linux/iomap.h         |  8 ++++++++
>  5 files changed, 27 insertions(+), 15 deletions(-)
> 
> diff --git a/block/bio-integrity-fs.c b/block/bio-integrity-fs.c
> index 692403dfa047..dd6c85530913 100644
> --- a/block/bio-integrity-fs.c
> +++ b/block/bio-integrity-fs.c
> @@ -52,14 +52,10 @@ void fs_bio_integrity_generate(struct bio *bio)
>  }
>  EXPORT_SYMBOL_GPL(fs_bio_integrity_generate);
>  
> -int fs_bio_integrity_verify(struct bio *bio, sector_t sector, unsigned int size)
> +int fs_bio_integrity_verify(struct bio *bio, struct bvec_iter *data_iter)
>  {
>  	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
>  	struct bio_integrity_payload *bip = bio_integrity(bio);
> -	struct bvec_iter data_iter = {
> -		.bi_sector	= sector,
> -		.bi_size	= size,
> -	};
>  
>  	if (!bip || !(bip->bip_flags & BIP_CHECK_FLAGS))
>  		return 0;
> @@ -71,9 +67,10 @@ int fs_bio_integrity_verify(struct bio *bio, sector_t sector, unsigned int size)
>  	 * bio.  Requires the submitter to remember the sector and the size.
>  	 */
>  	memset(&bip->bip_iter, 0, sizeof(bip->bip_iter));
> -	bip->bip_iter.bi_sector = sector;
> -	bip->bip_iter.bi_size = bio_integrity_bytes(bi, size >> SECTOR_SHIFT);
> -	return blk_status_to_errno(bio_integrity_verify(bio, &data_iter));
> +	bip->bip_iter.bi_sector = data_iter->bi_sector;
> +	bip->bip_iter.bi_size =
> +		bio_integrity_bytes(bi, data_iter->bi_size >> SECTOR_SHIFT);
> +	return blk_status_to_errno(bio_integrity_verify(bio, data_iter));
>  }
>  
>  static int __init fs_bio_integrity_init(void)
> diff --git a/fs/iomap/bio.c b/fs/iomap/bio.c
> index 30ef78a66b4f..813002b2299d 100644
> --- a/fs/iomap/bio.c
> +++ b/fs/iomap/bio.c
> @@ -169,6 +169,7 @@ int iomap_bio_read_folio_range_sync(const struct iomap_iter *iter,
>  {
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>  	sector_t sector = iomap_sector(srcmap, pos);
> +	struct bvec_iter saved_iter;
>  	struct bio_vec bvec;
>  	struct bio bio;
>  	int error;
> @@ -178,10 +179,11 @@ int iomap_bio_read_folio_range_sync(const struct iomap_iter *iter,
>  	bio_add_folio_nofail(&bio, folio, len, offset_in_folio(folio, pos));
>  	if (srcmap->flags & IOMAP_F_INTEGRITY)
>  		fs_bio_integrity_alloc(&bio);
> +	saved_iter = bio.bi_iter;
>  	error = submit_bio_wait(&bio);
>  	if (bio_integrity(&bio)) {
>  		if (!error)
> -			error = fs_bio_integrity_verify(&bio, sector, len);
> +			error = fs_bio_integrity_verify(&bio, &saved_iter);
>  		fs_bio_integrity_free(&bio);
>  	}
>  	return error;
> diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
> index 2ec755a89228..d43e6229900c 100644
> --- a/fs/iomap/ioend.c
> +++ b/fs/iomap/ioend.c
> @@ -25,6 +25,7 @@ struct iomap_ioend *iomap_init_ioend(struct inode *inode,
>  	ioend->io_parent = NULL;
>  	INIT_LIST_HEAD(&ioend->io_list);
>  	ioend->io_flags = ioend_flags;
> +	ioend->io_bvec_offset = bio->bi_iter.bi_bvec_done;
>  	ioend->io_inode = inode;
>  	ioend->io_offset = file_offset;
>  	ioend->io_size = bio->bi_iter.bi_size;
> @@ -311,6 +312,13 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
>  }
>  EXPORT_SYMBOL_GPL(iomap_add_to_ioend);
>  
> +static int iomap_ioend_integrity_verify(struct iomap_ioend *ioend)
> +{
> +	struct bvec_iter data_iter = BVEC_ITER_IOEND(ioend);
> +
> +	return fs_bio_integrity_verify(&ioend->io_bio, &data_iter);
> +}
> +
>  static u32 iomap_finish_ioend(struct iomap_ioend *ioend, int error)
>  {
>  	if (ioend->io_parent) {
> @@ -328,10 +336,8 @@ static u32 iomap_finish_ioend(struct iomap_ioend *ioend, int error)
>  
>  	if (!ioend->io_error &&
>  	    bio_integrity(&ioend->io_bio) &&
> -	    bio_op(&ioend->io_bio) == REQ_OP_READ) {
> -		ioend->io_error = fs_bio_integrity_verify(&ioend->io_bio,
> -			ioend->io_sector, ioend->io_size);
> -	}
> +	    bio_op(&ioend->io_bio) == REQ_OP_READ)
> +		ioend->io_error = iomap_ioend_integrity_verify(ioend);
>  
>  	if (ioend->io_flags & IOMAP_IOEND_DIRECT)
>  		return iomap_finish_ioend_direct(ioend);
> diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
> index 0ea2a8bf7efb..a954c97be0b3 100644
> --- a/include/linux/bio-integrity.h
> +++ b/include/linux/bio-integrity.h
> @@ -151,7 +151,6 @@ void bio_integrity_setup_default(struct bio *bio);
>  unsigned int fs_bio_integrity_alloc(struct bio *bio);
>  void fs_bio_integrity_free(struct bio *bio);
>  void fs_bio_integrity_generate(struct bio *bio);
> -int fs_bio_integrity_verify(struct bio *bio, sector_t sector,
> -		unsigned int size);
> +int fs_bio_integrity_verify(struct bio *bio, struct bvec_iter *data_iter);

shouldn't this have a static inline stub if BLK_DEV_INTEGRITY=no?
linker fails to resolve this in ioend.c

not sure why _generate and rest are apparently fine

-- 
- Andrey

