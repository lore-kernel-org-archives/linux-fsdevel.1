Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C912D0603
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Apr 2026 14:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775141260; cv=none; b=OO2mmX/YLRqs2LnIjqxqIwKaRXwWz6Hr5/Xq6FFUc1a9y9UaKRvxYi++05NkgOmQ3FzpmTCf6+9d8QugzZmWC7e1OeNQvFPyLcM9vkuZo+5iPoeJEuze9lyupD7/jbUAeb/K+ga9LMlN5pGLADl+zK+5oNeEuJ9HKQIOzwutVfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775141260; c=relaxed/simple;
	bh=2WZAl71Kpx10jrC0rD91KnwDq7ibd6Y9Z5cgd6zClas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3KAYa2QCet5ghD74yCvQrSuWC5TLULiPH6k+fw3g40Hbtu5AYyGQuCFFAaGyDlvhJMgsBu+HGp/eCi+CORd8zHgoOvX49VrAkheMZugyOpi9L++oemxQwzNCqAoPGfIPwN9VnQ/Zy0OLhCsaDl0vPVNe2+M88m2A1Tl7GIXTn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WH3gkPAA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SM8xYtAf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WH3gkPAA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SM8xYtAf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775141258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1BejI4IFPYpJVG1OzBmEzwBIMK85H2fS4YLiIwk6ibs=;
	b=WH3gkPAAR1OoViRH9k8Tgcpg5SR7Wce9poeJyr/BrxKo6uDJCFobNW+GYf0aeX3whU9xOw
	d4lXZLXIgdQDAegpU7HzBHqx30Lz0bsxOO0YnXMjqo3xyIPKwDC38Y6da923RkrX+lr1Vk
	kWIJHpDPXPwy9wK75T70t1GcCbzMOWE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-LQ0e7eTMMTWH2QeMPIycIw-1; Thu, 02 Apr 2026 10:47:37 -0400
X-MC-Unique: LQ0e7eTMMTWH2QeMPIycIw-1
X-Mimecast-MFC-AGG-ID: LQ0e7eTMMTWH2QeMPIycIw_1775141256
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-66c165a7a8cso852190a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2026 07:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775141256; x=1775746056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1BejI4IFPYpJVG1OzBmEzwBIMK85H2fS4YLiIwk6ibs=;
        b=SM8xYtAfPoWUNXzWB84BqYhsecbDJxtCvYnbqA4xd9GdNkR3xLI174XcAQWxbeSmRl
         zQDd+RP49qfg9rE4zocQjlPVMS2Kg4cGWj4klDQ5FlbUvhGz8Fi4zgEpMq5o3301pmiY
         /Sdf8cd+ee+R3YE+2t84U6BFUdfIxSDcMASoCpF+LsJWbGxw1ERDOGljfy5CWG2uRfTZ
         OPj2j9rwT/MrLWUo484hSsEEdCQB+7b9mqHIDGcOu2CA87wAbjXTMU7VesEjNlp1CxQR
         IziNPSQ9i7V7/jlwY8qtixwlQs1miRzFl9gLhounqW0ZhQx2GgTwrHqsOOt3WzpkDnAG
         vv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775141256; x=1775746056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1BejI4IFPYpJVG1OzBmEzwBIMK85H2fS4YLiIwk6ibs=;
        b=Z2/eYC7drskcvKA32sbiMgdFbW3g1pvyvGLjOwIuxvLD89XlxOSVe1jk+JbUSQ2yp2
         oq34a3SfWw+6WUl3P0guMAkEjQxwEJkuTFlEoMajcKQXBwNFM+DZ/mIp68ME7GEnAbZb
         MmFdfH+uqOGOZKPCDX0kpHHMSC7ZaJCLfj3W+ghtJemqr2ytnUcwj70MjnBISnO/VOgB
         sG8k85pMC/6hifbYFEZ8TonEbd8a24iRsGzJoy3c9gFttm9pL6271VS2C2elVKSJygt3
         GjgfsilfY/qEDrI12nunGfWz9UmQquHUAkyhSzKyJpnFnuxQynNzIfBWeYGQsm3T6fI1
         6YHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUng8kVLFFB7a5e3gShQ6z3wWLEi6KusjkLMnoZ872SZ43lacP5A1oEo0ayPy52EO0zm/urM3N3gN5ir9D+@vger.kernel.org
X-Gm-Message-State: AOJu0YyQMOwXE6S6w+s6MaWVJa18I0tX16lieLrkpaiu7gj3fngwwzke
	OrFLlJYCxUA1FYap3x9YmkTO+3A/kcigPAN3RL4lUa/q+YI5gRMFfaOb+DHf8uV+s2FB5OtQaxO
	LeF6m98gtMdvXiKJQwV1iqZH2PdPhQewAzZkXAWVEb6uSkOw1TQAq3ObCG36gt7mX8Q==
X-Gm-Gg: AeBDietXCgUN37iw70nYFffrv88/HGDneIGEO+bWH0v6QAdMA1z/h4O4gfGlGaS0j8K
	4/7B1dJPjQdKq2om2pDt5bfiudxDDxnQOLnHqh+9Rlqmq+xQQ9G4xRyCaO37jwMBN8Pyzrg2NmP
	fcxqTmfAb0RZeiZbyLQCSg9/veWDlZCwUtf6IyxDZLzgFlO53a71GCqMACjG9vGw9eqRrWgjBTk
	zEMJOrPYtFPhIH6lIvryvlqafdQhpacqBo4etafKQl2y48TzMFkcjifj9D8yN9nUy4fbFwSfl+f
	5KBarIwR+ppYeoJ2cow3bWyiwtdjOWf2suzYKJXkR/dRX7T44TAQC4a8qhqthj48GBOBd0cSX7L
	PmB+hRkJEN7nSsg==
X-Received: by 2002:a05:6402:4349:b0:66e:3754:618a with SMTP id 4fb4d7f45d1cf-66e3754684dmr8241a12.22.1775141255718;
        Thu, 02 Apr 2026 07:47:35 -0700 (PDT)
X-Received: by 2002:a05:6402:4349:b0:66e:3754:618a with SMTP id 4fb4d7f45d1cf-66e3754684dmr8227a12.22.1775141255235;
        Thu, 02 Apr 2026 07:47:35 -0700 (PDT)
Received: from thinky ([91.245.205.131])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66e033b9df1sm812760a12.21.2026.04.02.07.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:47:34 -0700 (PDT)
Date: Thu, 2 Apr 2026 16:47:33 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, hch@lst.de, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-btrfs@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH v6 03/22] fsverity: generate and store zero-block hash
Message-ID: <cw2kmcrrd6a3rsk37jnchxxom565nzn64f6u7h56dozqa42z6e@zrxdtpdg25ie>
References: <20260331212827.2631020-1-aalbersh@kernel.org>
 <20260331212827.2631020-4-aalbersh@kernel.org>
 <20260401222717.GH2466@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401222717.GH2466@quark>

On 2026-04-01 15:27:17, Eric Biggers wrote:
> On Tue, Mar 31, 2026 at 11:28:04PM +0200, Andrey Albershteyn wrote:
> > Compute the hash of one filesystem block's worth of zeros. A filesystem
> > implementation can decide to elide merkle tree blocks containing only
> > this hash and synthesize the contents at read time.
> > 
> > Let's pretend that there's a file containing six data blocks and whose
> > merkle tree looks roughly like this:
> > 
> > root
> >  +--leaf0
> >  |   +--data0
> >  |   +--data1
> >  |   `--data2
> >  `--leaf1
> >      +--data3
> >      +--data4
> >      `--data5
> > 
> > If data[0-2] are sparse holes, then leaf0 will contain a repeating
> > sequence of @zero_digest.  Therefore, leaf0 need not be written to disk
> > because its contents can be synthesized.
> > 
> > A subsequent xfs patch will use this to reduce the size of the merkle
> > tree when dealing with sparse gold master disk images and the like.
> > 
> > Add a helper to pre-fill folio with hashes of empty blocks. This will be
> > used by iomap to synthesize blocks full of zero hashes on the fly.
> > 
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > ---
> >  fs/verity/fsverity_private.h |  3 +++
> >  fs/verity/open.c             |  3 +++
> >  fs/verity/pagecache.c        | 22 ++++++++++++++++++++++
> >  include/linux/fsverity.h     |  8 ++++++++
> >  4 files changed, 36 insertions(+)
> 
> Acked-by: Eric Biggers <ebiggers@kernel.org>
> 
> The example given in the commit message is a bit misleading, though.
> Usually there are actually 128 hashes per block, and a block of hashes
> covers 512 KiB.  So this optimization applies only where there is a hole
> in the file's data of size (at least) 512 KiB, aligned to the same
> amount.
> 
> It's also worth noting that this optimization is being done only for the
> first level.  The levels above that are still being stored.  So, this
> doesn't really enable e.g. exabyte sized sparse regions, as a block will
> still be stored for each 64 MiB (instead of every 512 KiB).
> 
> I'm okay with this if you want to do this, but I just want to make sure
> its limitations are well-understood.

Sure, I will fix the example and add a note that this is only for
data level. 

I think for higher levels it could be later added transparently.
Old tree blocks will be read by iomap if exist, and for new format
block will be generated.

-- 
- Andrey

> 
> > +	/* the hash of a merkle block-sized buffer of zeroes */
> > +	u8 zero_digest[FS_VERITY_MAX_DIGEST_SIZE];
> 
> "the hash of an all-zeroes block" would be clearer.  This is the hash
> from fsverity_hash_block() which includes the optional salt, not the
> hash from fsverity_hash_buffer() which does not include the salt.
> 
> > +/**
> > + * fsverity_fill_zerohash() - fill folio with hashes of zero data block
> > + * @folio:	folio to fill
> > + * @poff:	offset in the folio to start
> > + * @plen:	length of the range to fill with hashes
> 
> Maybe go with (len, offset) for consistency with
> fsverity_verify_blocks().  (I assume the "p" prefix stands for "page",
> which is misleading since this works with a folio.)
> 
> > +void fsverity_fill_zerohash(struct folio *folio, size_t poff, size_t plen,
> > +			      struct fsverity_info *vi)
> > +{
> > +	size_t offset = poff;
> > +
> > +	WARN_ON_ONCE(!IS_ALIGNED(poff, vi->tree_params.digest_size));
> > +	WARN_ON_ONCE(!IS_ALIGNED(plen, vi->tree_params.digest_size));
> > +
> > +	for (; offset < (poff + plen); offset += vi->tree_params.digest_size)
> > +		memcpy_to_folio(folio, offset, vi->tree_params.zero_digest,
> > +				vi->tree_params.digest_size);
> 
> This could be done more efficiently, especially on HIGHMEM.  Probably
> fine for now though, especially since the intersection of anyone wanting
> XFS && fsverity && HIGHMEM is likely to be extremely small.
> 
> - Eric
> 

