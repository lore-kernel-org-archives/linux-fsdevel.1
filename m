Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250113D16F5
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 12:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774440529; cv=none; b=V4ynyaDH6M5HALHcWFpbLARIcoSjk9uToTdYZ9pwnXH+aw5KmBTsiq+Cc2UDrz+ioPufSycBPQTA72Lqym24S1gX3YNtzMtDDIAmCeaglxWCohT0RymTzTOnaTCzfQvL793whw+pHHKibDVV3xGm+F7JKYotcP/LVXqdcP9fw4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774440529; c=relaxed/simple;
	bh=LbeAqmlJTzsDU2WI+JQRb0J70AEGN7cPn533Ft2zw3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlYvLXnDmIoMID63JUlBEPs0nSCyyDNWYhNXs513Ws7bBn4iXvQGVffvbJzjdCNNvFsEQzp7q78C/yxaejwIO6EBlP7DYfx+zBaGBBriOeqBbuJPyFTwVOKsA2klWBtOlUzO2c+b7Kegut/ASUNEGzfRqNQdF+eVbVIhnx3fXXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=duzdEEoJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=G1yoz54M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="duzdEEoJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="G1yoz54M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774440527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xgQzcNVTgAYMtY/AG+BgYI0+wd9pZeBrIlwhVeuWoe0=;
	b=duzdEEoJL5glagj1MhAj7wlHDna6M37vbGi2G2LFx6oQh1OAAYx456ElckKtbQlIrfFrm0
	G91hBCENiJM+gmkOSyFjys82JFRul37zctORey0kxfMdgR23eJbfuFtS7Z9XzH/CtsRMwW
	RHXhEdsRc17DkToKaZqbTErul2X/5AI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-cRxJTE_dOVW_TuF8ZVBfdA-1; Wed, 25 Mar 2026 08:08:45 -0400
X-MC-Unique: cRxJTE_dOVW_TuF8ZVBfdA-1
X-Mimecast-MFC-AGG-ID: cRxJTE_dOVW_TuF8ZVBfdA_1774440524
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43b4d3919e4so2439272f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 05:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774440524; x=1775045324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xgQzcNVTgAYMtY/AG+BgYI0+wd9pZeBrIlwhVeuWoe0=;
        b=G1yoz54MAUMJ2qpywnQfiM+YoKwm+WbO7U3YMxFsBVjE87pW60nS+9Fhh39YXfiDfL
         iLapvsxdKYIceymdRWKFxXVez0JVDyWdj5FvNWH6sShung2f8VUBoL6BypALZAxjYKmi
         YHlXDM4t64iIAh3zdi/IHyuKTcC/6QG09rJ4yynQ1X7204q8htvzhmKJj+hL0X6Db/Vd
         7oMTWZeIVDnn+kjcWwVJMENAjqB7mLj2djM0aQqSvDXSZSvTYldysXNkd8U6nFbFISAq
         W0VluO3Zn7dBK4vlpJuZf8esRZhiPB4YWxhIkoDVkJ9Brto22z7xDoF18EUze+Xe9QVN
         +r7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774440524; x=1775045324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xgQzcNVTgAYMtY/AG+BgYI0+wd9pZeBrIlwhVeuWoe0=;
        b=ZzdtgtMISOYO8HexwLyo/CNmPrGC3x1puzeNTmih1N03+BXjsl1+D6Fmu78UAYrhu5
         W2lGJNupFRYrCGpDaE9mTZszD2O7LpYn8waeb5fa91+m4397iUlglsze7Z8HAqegtrE4
         a23m3NgaNZUx/p+ME7f3zTSbnhqmiOkGzgViCCtTvPyuEfCfJDrpH0PO+xU50Eic61mK
         vGCSE6UN3OdM2flJysQuwIb2LFKwmzJqZM76uoWflZcPQOQULGmY6vxGk2UJ3H5+zrOF
         6mlXBKBW2e1V+ynWmdJNIchHj8PGNI9TzFK4TUlKbH78MFCxFYfiLv56pki8p9w+oueF
         F4Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUvTzsd3k6encsPcljWFac/pP+vhYLftyQMP80NFNXeioIY1MRWvyTa5Q3kz0xLB0eg9O+E8WyD9ViRAcWt@vger.kernel.org
X-Gm-Message-State: AOJu0YyStkiQCOLHJOFKzpFI4pdMv30XQt1Dukh/cLT6KueRMLmt7NUN
	4TREWtUXIt6ifDLB5eDTApfkrDSadtR5JafbhfjVjJiXS4SWD301svSe322jgGdO2gZLib93Y8g
	y/wBPjZEITLMbxeKkmPeo0ZxzrlEp9OqtoHxXG40tjvvpKqlVo3E5pmtZRaUkkElqtg==
X-Gm-Gg: ATEYQzw0+mVhWyDp7dXMgKizBv+c30Gy16zNFIWABdRvKVo/UN83kVl2ER9aVIVcxxG
	fkfQghuX+fygNUJ1/v+ygegWTBanGWWqaPMgX8A+tf1tG62i24z/PTqichAjChBFTiDUsn6OUFr
	szBpFjgSrm91SmpHjchjX7Ci1uLBln1mvOvi5w2gKNJum/4rzbp/Qq2IXUXsYIt1fWV09ehkSXG
	5YzW1MuZ3p4hjs/ruAPR8Ws4R0Wvdb+cI5c7yWRRhlGuuxWqFBI4H4gVX9skR1iP0FD+nk9UK/V
	TLJpbHOa1ewZwn3BSEoN7tyqcP7bZYGPw9SVRTM6Ns34bgIJl1x+/p6sWLHrfOqKHn2Z/qwyp0P
	zy97HRnF/8CQhEQ==
X-Received: by 2002:a05:6000:2c0c:b0:43b:436d:782a with SMTP id ffacd0b85a97d-43b88a2168cmr4549298f8f.5.1774440524012;
        Wed, 25 Mar 2026 05:08:44 -0700 (PDT)
X-Received: by 2002:a05:6000:2c0c:b0:43b:436d:782a with SMTP id ffacd0b85a97d-43b88a2168cmr4549233f8f.5.1774440523459;
        Wed, 25 Mar 2026 05:08:43 -0700 (PDT)
Received: from thinky ([91.245.205.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b90f17158sm216982f8f.8.2026.03.25.05.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 05:08:42 -0700 (PDT)
Date: Wed, 25 Mar 2026 13:08:41 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-btrfs@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH v5 09/25] iomap: issue readahead for fsverity merkle tree
Message-ID: <nune2zskdoz2buxwj73z652azx4pwwkpsjjluq55mk3odybhym@2lolknvk7ddf>
References: <20260319170231.1455553-1-aalbersh@kernel.org>
 <20260319170231.1455553-10-aalbersh@kernel.org>
 <20260325080407.GG952@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325080407.GG952@lst.de>

On 2026-03-25 09:04:07, Christoph Hellwig wrote:
> On Thu, Mar 19, 2026 at 06:01:56PM +0100, Andrey Albershteyn wrote:
> > Issue reading of fsverity merkle tree on the fsverity inodes. This way
> > metadata will be available at I/O completion time.
> 
> Patches 8 to 10 really look like they should be merged to me.  They
> all add the actual fsverity support to the iomap buffered read path,
> and merging them and having a single explanation of the side seems
> helpful both for review and future archeology

I see, thanks, I will merge them.

-- 
- Andrey

