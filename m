Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153C93C277B
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 09:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776851958; cv=none; b=edEEF2EDl2hGyT5jdY5Eqxmb8E8x1UkrGtgZLX5Q67fo8GW2DHV39V6970svIV71vgz3hug/cmWc5XBYL1kouV4iAxq7JY7/KSG+hmcGCRmDtASVyfDBd17RSI+M3ryilVlb4PZYDE5913Q3EVMsKHqh0hp36jiR1p2R+2r/7q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776851958; c=relaxed/simple;
	bh=qdTdoKTlhVu86bDuyPkOaG5VtZiyVVLX9VSgFPv2CkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8otd3NeHbgfK7jzVHUdVyDWDf5tekMfN21gP85xy0LAVfHiCnWDapSbZ66lVlSU31p4GgdViUTU1qcOocwwrGT4K6qOaiLM//eFV1K9dBaFzqRdiXh2mg26H4AoKm8Vfqgh7KiRr++/PjbzCjtmNcEoKls+w7ZUaLou0AM/rsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QOu1lDi6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JBE8rlhG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QOu1lDi6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JBE8rlhG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776851956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QVpt6cL/XFUpoSbUgEFsp9E/b8gj4ghVTxVOycpPEPQ=;
	b=QOu1lDi6VUFBgOsXhgnJG+Df4lJek8huCUy/k3Qh9pCXS+3ZUh/+cwNQ3X5qJRWw6TJYHn
	uWi9XX6eTozNyQFR8VshXHDw90Oc9b611BG/TKQqMECUGC+An/bshBFsC6M/NtoAvr505j
	bsUpA1Hk0uUiuUpv7YBycMCbfRvswbg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-y8324YHZPLGDvH7exfnPMQ-1; Wed, 22 Apr 2026 05:59:14 -0400
X-MC-Unique: y8324YHZPLGDvH7exfnPMQ-1
X-Mimecast-MFC-AGG-ID: y8324YHZPLGDvH7exfnPMQ_1776851954
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488c2a4e257so38915905e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 02:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776851954; x=1777456754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QVpt6cL/XFUpoSbUgEFsp9E/b8gj4ghVTxVOycpPEPQ=;
        b=JBE8rlhGQ2Hn4b93hBQ0u+xvUXg7aktY146nU8sbznDNmGI/U3W9R6KdzTpt+HUQ+v
         ZmCiz1ZgCnF83ZpCpZv3rUv8hsEX5urJfoRqrwD5Jfn7z+jSbCac4tw6GS83t+6zp5Ma
         YRMz4cAJ72xeX1cipWl94+KEVEs1mrvFu+dTMvASA983NrKgUbHtCzWsz/9ZzB0ZpI7S
         V8PGt5PBA2zwQGpyU+EAxnTVtUs9hVP48K9hNuY/t7LqSM2sXrJ0aneYavkM1CIQz89C
         Rl49gZKRgoT0e51Qo2OhZel+tw4T115rwkpSnA+Gk+3wHhNIh839Vqfc+u0I/gAPqeJU
         rslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776851954; x=1777456754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVpt6cL/XFUpoSbUgEFsp9E/b8gj4ghVTxVOycpPEPQ=;
        b=q+3Fp2KXFZV2nP+a4JjXK0G9OgAWoQEg3+dURiZUX4zo10CEYrCis2e6WIQ/1W3PEo
         ShEpVhUhlT2Y5ShdesePNGv2cJDIMSD58k7RyRSYlqWAGEk4JdRSQLWxKCYPUB5nZPO/
         OuzNqvmBCA4NK2sHHw52EDekLqDn4ArsA7Q+2uiaMykKfQksBzrnPLHjcX3hjvubYAU2
         oqiqKMdX5e2sUb1H89Gbmmy3/2BtIuWnMLZxq95diC7fujrMTqQCuwBmO0Gvg8SnVweJ
         L8aF4Sk4NZUrgnjkvCIB1Zi1gQYuvQv7byhA5GggJIwwWExpl1HlWLRgWvh074VNqbLl
         DSmg==
X-Forwarded-Encrypted: i=1; AFNElJ86kwBu00ME0p0cHGJ1zND725kfr4GQbSXlYRyxu0K06Sg8zZQfPySqrK6XUrvkrbbQOzwFfnlExsmf8GM5@vger.kernel.org
X-Gm-Message-State: AOJu0YwJiabTvospc8cuB26KB9e0dwpZ1i/g1g1JM6hPrQXzBzCdE2MO
	SQhirp/P60Ads/q7U6sOhwZeaVXhggtIFsehMxl1ZjE/C59Gc5pJLJ1RmX71OxO3+20HjnktmFO
	VHD9t2rkYP064VIHK9C6qKFykLmqRwmcg/cQB8wWUuqLUWkdWkcY5ozletR1SjrCobw==
X-Gm-Gg: AeBDieu454gJr/vOdb+GBfw8iqONz7SQwAcsVJ16uSsBmvFAAIdHXLTSsEcC0F4CwH5
	vNrjg6EdSOueevoGA9/rk33WA+DoNytmgfJYcNbHHU5poDObF5vWNqHT4fVg7d8vZY/BPu/9wgp
	84HKg3tKgH2H+vkJjcmONpI6DFCLqRx8kFqHpzc4i2EVMo5Zy97fgY1lGA56+henEJLz/PuwAk7
	R0gBhmCPiim6PAdsqDsM2i99LMtsWdMmNdy79e0haIumVzBe7TGNAbxOPNlB64e+yaIkGdGK2TM
	PqUSQ4x0BTwDlcyAw3Az2sxwmsLOSWjCtCmFee8PvQVR995hdpk+PrxYRZY08Djb7MMOJhnHQLi
	krIVUZo7zGgI7UIjN5KgCIQ==
X-Received: by 2002:a05:600c:8b8a:b0:489:149a:f9e7 with SMTP id 5b1f17b1804b1-489149afa2bmr214250925e9.27.1776851953567;
        Wed, 22 Apr 2026 02:59:13 -0700 (PDT)
X-Received: by 2002:a05:600c:8b8a:b0:489:149a:f9e7 with SMTP id 5b1f17b1804b1-489149afa2bmr214250425e9.27.1776851953134;
        Wed, 22 Apr 2026 02:59:13 -0700 (PDT)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ffc5e3f4sm222129625e9.2.2026.04.22.02.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 02:59:12 -0700 (PDT)
Date: Wed, 22 Apr 2026 11:59:11 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, hch@lst.de, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-btrfs@vger.kernel.org, linux-unionfs@vger.kernel.org, djwong@kernel.org, 
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v8 03/22] ovl: use core fsverity ensure info interface
Message-ID: <gpmgtg2wkoo4vozzaaouhdp2df6zlifwi6gy4jvq7xc22zo7om@t3f2bl374nlr>
References: <20260420114714.1621982-1-aalbersh@kernel.org>
 <20260420114714.1621982-4-aalbersh@kernel.org>
 <20260421214457.GC37143@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421214457.GC37143@quark>

On 2026-04-21 14:44:57, Eric Biggers wrote:
> On Mon, Apr 20, 2026 at 01:46:50PM +0200, Andrey Albershteyn wrote:
> >  int ovl_ensure_verity_loaded(const struct path *datapath)
> >  {
> >  	struct inode *inode = d_inode(datapath->dentry);
> > -	struct file *filp;
> >  
> > -	if (!fsverity_active(inode) && IS_VERITY(inode)) {
> > -		/*
> > -		 * If this inode was not yet opened, the verity info hasn't been
> > -		 * loaded yet, so we need to do that here to force it into memory.
> > -		 */
> > -		filp = kernel_file_open(datapath, O_RDONLY, current_cred());
> > -		if (IS_ERR(filp))
> > -			return PTR_ERR(filp);
> > -		fput(filp);
> > -	}
> > +	if (fsverity_active(inode))
> > +		return fsverity_ensure_verity_info(inode);
> 
> Not sure whether I should review this version or the version in git, but
> both seem wrong.  

Sorry, I forgot to push, this one is the latest, the one on git is
v7. I will push v8 now.

> The 'if (!fsverity_active(inode) && IS_VERITY(inode)) {' condition
> should stay

Why? With recent changes, the fsverity_active() now checks for
IS_VERITY() instead of verity_descriptor.

> , but fsverity_ensure_verity_info() will need to
> gain a !CONFIG_FS_VERITY stub to fix the build error.

With "if (fsverity_active(inode))" I think this is not necessary as
this fsverity_active() will be always false, and this if-case is
optimized.

-- 
- Andrey

