Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794396074;
	b=poBQgIXx1R+hYKXsPS1uvumXFhHiP148UQSbTE5dAddVA1YECf06xk4KO5idF9opvu+a
	 4rgBD/lq+Z6in9wz+hXp1PKLaaOuTPSyMJX5rC9IQCf1eNy4goFxejQ6gEG6nM5kqtBPW
	 URG2TCrOKoTS5r6bwVNDuPC4F41EHLsLS5k1DKraVCahPkH44HUt2kG9sio8qJt10NF4M
	 yHdgJhg3IDaBEz4DyU8wtkUrdJfUAdMhAyOEYS+o9nwLVRJpxup35TIaag4IkSZjg0i9z
	 r0o48tnw8BaA7Luzuvfjfg7HNpzSO5ZIerRHRR1d6rYTMPPdm+PBx3U0q+qoGPTtP5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794396074;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=kBXKsT9ZCsjDhkyFEPBUIYke5NN6Zkrm34ssQPKm0Vs=;
	b=Y30Q23ClQVGhEZPUPiDuXCqAJhP70AniFIoLnNzlZStl2TQKslPOPrE64NK7qxmzhJLL
	 M8tB2m1GkWkt8O63gxfVJeA9+IvPgTZ1Zk/AR/o3iCwDJx95DtVa6dFraLg/VSS/oYSwz
	 NIJX67eqaWBZHic9JqGWSBK4psH+9keM7+EVp6TmwyhRztHOGJbNaQicmXCXru8OOFT7/
	 JOHe8mOn640LzcPj8TO4MYMiwIeNACUOLN8jGelTVrEi8r91hv7jxw7vM2k/lyyIxZnMf
	 I9l1G98S+PpquEcHaenUCSDdcB1WHyEDKUVPtC55fa9NJQkhOT7qzLveWBYiFRs62Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JPqK4sky;
	arc=none smtp.remote-ip=95.215.58.39
Received: from mta1.migadu.com (out-39.mta1.migadu.com [95.215.58.39])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A37606A31C
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 11:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0A37606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JPqK4sky
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5QkVrf7bCPT9Dzg1aMldKaFYsjGVxzBELewsYgxXRuk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794396071; v=1; x=1795000871;
 b=JPqK4skyMoy0I4q8XrgPgM2j18jVdVO/nlMxdwBzZCwTjyG0fCgh5u4D5bWflgEHCCeeqNn7
 CbLdn3KlvmX7hc5BOBjJJmRVqgnQ4brZTvqNyCAo6SEStAJwhbcraCyHC9ZiahGeQhucPSwZpDg
 ogBfabGud07lP0bjHSgrHQ0o=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3defb7f018b5929e;
	Wed, 11 Nov 2026 11:21:11 +0000
X-Mizu-Trace-ID: 3defb7f018b5929e
X-Migadu-Flow: FLOW_OUT
Date: Wed, 11 Nov 2026 12:21:07 +0100
From: "Pankaj Raghav (Samsung)" <pankaj.raghav@linux.dev>
To: Christoph Hellwig <hch@lst.de>
Cc: Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/25] iomap: add support for data checksumming
Message-ID: <avRO_O8jx3zrccGq@quentin>
References: <20261104085929.317544-1-hch@lst.de>
 <20261104085929.317544-3-hch@lst.de>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104085929.317544-3-hch@lst.de>

On Wed, Nov 04, 2026 at 09:57:06AM +0100, Christoph Hellwig wrote:
> Add a new refcounted structure for a data checksum attached to

I don't see any new refcounted structure. Probably the commit message is
stale?

> an iomap_ioend, and helpers to allocate, split and access it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
>  
>  /*
>   * Flags that if set on either ioend prevent the merge of two ioends.
> @@ -522,14 +529,31 @@ static inline u16 iomap_ioend_flags(const struct iomap *iomap)
>  struct iomap_ioend {
>  	struct list_head	io_list;	/* next ioend in chain */
>  	u16			io_flags;	/* IOMAP_IOEND_* */
> +	u8			io_csum_shift;	/* ilog(2) of csum size */
>  	u32			io_bvec_offset;	/* offset into first bvec */
>  	struct inode		*io_inode;	/* file being written to */
>  	size_t			io_size;	/* size of the extent */
>  	atomic_t		io_remaining;	/* completetion defer count */
>  	int			io_error;	/* stashed away status */
> -	struct iomap_ioend	*io_parent;	/* parent for completions */
> +
> +	/*
> +	 * There are two kinds of ioend, the original ones submitted by iomap,
> +	 * and thus split of for I/O size limitations.  For the latter,

s/thus split of/those split off

> +	 * io_parent points to the original ioend.  For the original ioends,
> +	 * the space used by the parent pointer is reused by the checksum
> +	 * pointer when data checksum are used.  Split ioends always point
> +	 * into the original allocation with their io_csum pointer.  As a
> +	 * special case tiny checksum use the pointer as actual checksum
> +	 * storage if that fits.
> +	 */
> +	union {
> +		struct iomap_ioend *io_parent;	/* parent for completions */
> +		void		*io_csum_alloc; /* original csum allocation. */
> +		u8		io_csum_inline[sizeof(void *)];
> +	};
>  	loff_t			io_offset;	/* offset in the file */
>  	sector_t		io_sector;	/* start sector of ioend */
> +	void			*io_csum;	/* data checksum */
>  	void			*io_private;	/* file system private data */
>  	struct fsverity_info	*io_vi;		/* fsverity info */
>  	struct bio		io_bio;		/* MUST BE LAST! */
> @@ -547,6 +571,22 @@ static inline struct iomap_ioend *iomap_ioend_from_bio(struct bio *bio)
>  	.bi_offset	= (_ioend)->io_bvec_offset,	\
>  }
>  

-- 
Pankaj
