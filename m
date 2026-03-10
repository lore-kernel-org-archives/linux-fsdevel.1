Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D88330149F
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773153780; cv=none; b=H+eMT9aI4JrHffjyb+rNVU+Txuqy/xxw8vzmRx9evys+D1R/s/f2pyumhsz3DFW+M5gbTdvul/dWo6qxSkrEt9uVLha4wUnGFl/vIwr2eGKx59D2mNFDS+8wOXc6WfSl5zGF2pdfYRkBcAKmf5OAiyGwiis6kjUItCmvW189rHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773153780; c=relaxed/simple;
	bh=ulN49Zz6Uvce5EQ9S9G5wrSA/FkX6ZfXtBj/b3XcPks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkJI/0X/1wuUlpi25BW7HCuzjIMbLFT5uQFml8NU0eDwltFVTDW4ZaN/p27+VMxXvAyKVLG3H4Bw2nb5wwu/OvQc5E1wyYDcvVqjCYiLBVrUIsIJD/mVEnXhWs8gVBnRIyWjQKqRDpeAuM02bVJ8sHEuFi4nMAGln43AuYRIj2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wu6auwHR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mGu88KJC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wu6auwHR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mGu88KJC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773153778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BMpkjIBAlArWoSNA1cagHtqrYddD4BAtLIKx0zMiI/c=;
	b=Wu6auwHR35+CvewBNjz4Y2soT3YOiRe29xV2QAAMRWj9PiGDJlsxAAZaH5fGBHFNdl1IKR
	q9KQc53P0Rc8iySp3DxwSVVP9xiXv30K+31Z1DLJM2lUkC+6hjpO2ixSBua24aGGPWQ4ro
	qR2NWFS6iW3AxnmukJ3sK6SFcZqC1SE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-hsOc98ONM9WjlvUPDeSOKQ-1; Tue, 10 Mar 2026 10:42:57 -0400
X-MC-Unique: hsOc98ONM9WjlvUPDeSOKQ-1
X-Mimecast-MFC-AGG-ID: hsOc98ONM9WjlvUPDeSOKQ_1773153776
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b94062e85f9so588134666b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 07:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773153776; x=1773758576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BMpkjIBAlArWoSNA1cagHtqrYddD4BAtLIKx0zMiI/c=;
        b=mGu88KJCD10p+zEzHwQJiTHmPvdzGKjcPI2EcpKLWCrWxbis4LERltzsUCqJYjTl1m
         GqwiVllxDhd+4s4hwxfhij1/vmhF2xBzxq0NVN81PHa0c7VRoGb3czdVIg1tsXKA/2BW
         +q8IdjTlhd4zwjRbia+k7GIf6Jx8OEfyy6Jkdk8KQi7Xu+kUkr5p4Db+gkVgiAP9eLRl
         f4OAt35S7zmS/REn6Tz8Sh1xTgtnZawQVZlbtlSEAG82DsTKhulEFMZJHxhdIUbX3HH0
         o1dL4mzFApXbdP/RJy8r9MipvSzb5XkCoaq/bnGrP//18RpXAAxzGGIYiLBuDJRQSQBu
         GnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773153776; x=1773758576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BMpkjIBAlArWoSNA1cagHtqrYddD4BAtLIKx0zMiI/c=;
        b=T7oCvjzPYL8wVBemhr7IYzEBiCe8ZdkbqCvVJIs68mPvHd6XqQBcZ5M/qioHDnPOf9
         tKL54v3BjBaeoy0cXYsiPun5+UJ0tYTUL7Pc8zZjyaT+I4moIECYBdcG/yuoGABvRyKV
         JKyiSRIovtBvNMbrfJfm4HbLgbm2MW+Js9Lze8X5FGq9aiI1PNtl9LFU/eb/RiapuWnM
         xLfEfgR/GpcG6q2Hpo325gEMZsbI9T8NmyiZrwXts81gXeneY5zTUrIgD4yr0FKSyn5+
         p82IAdjgmDZjQ60zLdnOuGCq4+retZJz2TsmQI2NpumteRJA+FqS+ZTYBrzaVzetvS/c
         1P8g==
X-Forwarded-Encrypted: i=1; AJvYcCXtpdk/VpqddJjZrmifw17wbEpLPe8grMnXuOFPE/J8p0xbZVK6Ub5PE0vVdaaKswULeTP6H9HqKCjgtQXb@vger.kernel.org
X-Gm-Message-State: AOJu0YyOVWSk66fBF+VORCZOPSo3IdS9hRdG4dorOzogEUpqpxvLFS/L
	zeoQbxxn7mBuFYMbMySutfQpMAEGKKJpTqPSiZe2O0ZvutXDum2DFRfB1og/MPELYeMSjw6XgqK
	RkddQt1X0I77uuDCkov1UtRx910y+ZBXB4ag37zyWmz6p2PZ+vFi92etafwjM8TihoA==
X-Gm-Gg: ATEYQzzdfMe2Jq7Cg+p2J2cAYYoZLs1uMOIJtC7osP0ve8PvZFbMcwMfTry3P0iJpvD
	hb3n5Dg2Qigt/k8c+7bh8OBEHDfyiHb5+I7lHLlzwcHBOOh28qETkL/lReGsjeQXf2Eywt6JeR/
	WpEhjTP4Zy6y/zjOzexBxCh3g5N95MoLlIxngGncC4nEWUfj+sxyXrvSaVSEbqLR5YTdBtnZK1b
	mnzkNHhofOkPXUkmbDJuOzzXT1YGqdXBtkpiW1ZIiky3mgu3DoyuJpNHEx8ZIjymiaQxo8jbJ+k
	CD11N9zu05m90ormWnAEnO2VvlqY8Dl53DIf5/Os1EECHI+SiscyB6Sir28TwGZRyNaS+UGTNJK
	oE08txDg67Dg=
X-Received: by 2002:a17:907:98d:b0:b93:edc0:e2e8 with SMTP id a640c23a62f3a-b942e02c34cmr869671566b.48.1773153776097;
        Tue, 10 Mar 2026 07:42:56 -0700 (PDT)
X-Received: by 2002:a17:907:98d:b0:b93:edc0:e2e8 with SMTP id a640c23a62f3a-b942e02c34cmr869668766b.48.1773153775426;
        Tue, 10 Mar 2026 07:42:55 -0700 (PDT)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b94dad4271esm420956866b.32.2026.03.10.07.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 07:42:55 -0700 (PDT)
Date: Tue, 10 Mar 2026 15:42:54 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 10/25] iomap: teach iomap to handle fsverity holes and
 verify data holes
Message-ID: <usl6wrms76zioxpq7xqzo26plpvw642pqrb2zxe4nysnmipm2o@ntl5ml3okjyq>
References: <20260309192355.176980-1-aalbersh@kernel.org>
 <20260309192355.176980-11-aalbersh@kernel.org>
 <20260310010502.GB1105363@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310010502.GB1105363@frogsfrogsfrogs>

On 2026-03-09 18:05:02, Darrick J. Wong wrote:
> > +		/*
> > +		 * Handling of fsverity "holes". We hit this for two case:
> > +		 *   1. No need to go further, the hole after fsverity
> > +		 *	descriptor is the end of the fsverity metadata.
> > +		 *
> > +		 *   2. This folio contains merkle tree blocks which need to be
> > +		 *	synthesized. If we already have fsverity info (ctx->vi)
> > +		 *	synthesize these blocks.
> > +		 */
> > +		if ((iomap->flags & IOMAP_F_FSVERITY) &&
> > +		    iomap->type == IOMAP_HOLE) {
> > +			/*
> > +			 * Don't cause lookup if we already have fsverity
> > +			 * context from the previous tree hole
> > +			 */
> > +			if (!ctx->vi)
> > +				ctx->vi = fsverity_get_info(iter->inode);
> > +			if (ctx->vi)
> 
> Is it an error if ctx->vi isn't set here? 

no

> We won't fill the folio
> with the zerohash, but we'll set uptodate anyway...
> 
> > +				fsverity_folio_zero_hash(folio, poff, plen,
> > +							 ctx->vi);
> > +			iomap_set_range_uptodate(folio, poff, plen);
> 
> ...though I suppose it's the case that the uninitialized folio contents
> will most likely cause fsverity to report data corruption so at least
> it's obvious.
> 
> OTOH it does seem a little strange to set uptodate having not
> initialized the folio contents.

This the first case described in the comment above:

+		 * Handling of fsverity "holes". We hit this for two case:
+		 *   1. No need to go further, the hole after fsverity
+		 *	descriptor is the end of the fsverity metadata.

fsverity will not read this part of the folio. I think this can be
zeroed, but I don't really see the point to do so as no one will
read it and we use this folio once, for reading the descriptor.

-- 
- Andrey

