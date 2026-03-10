Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4046399379
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 12:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773147252; cv=none; b=qBSLMst7EtQY55wff/mfRf++5EIin1k+bD+ndrVDEe4Ts8e5ZAQOjjqptKK1hNYPrFIbu5lFHE8MhBaYr/GjsU0NcsAoHtybXWPQGNWr549adT6wrlySyJ2LQPkrcehcvoqAg4DIH7MzOamsF8gutd3KLnQfJv5VeAZNW4dgYvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773147252; c=relaxed/simple;
	bh=TgoJchP8+G/BTHDKgmEWupOwORUqE0/FZPIUEYu9Z9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asfQ/K/ent1JbF/QutyLNIJLFI1Rzhz775m9ZJZbgaWcVPtV8KOaNfkkp9tzFWvKDl2H2CKdD4hahAk/2CW1O7lQEmm7nReHUVaVegm9iOzV+N94L+PiOIDhG0fQ1+QY32opExhQvfxMP3PzHukA4h96JAP56dXmHCqWtojgLWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0+cOK+VW; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0+cOK+VW"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2aeab6ff148so1505ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 05:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773147248; x=1773752048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mm6hm+LHoMGo5Ew01sq1dP9YSITnoqIDxYFDqmtgvh0=;
        b=0+cOK+VWVXA7uE31Sh5y2bmP9hRSr0LFsM2f3kDgfCZ6lyHaVbAytIQCv+2vF+eTEx
         oUic6e9ZAVnZqnGzIPB8kHUyMA2zwpMw5U/9RUdKEhoG2/xX9/VKIHC9XNEBOVXeDKo9
         mU/QEMBf02iFKn4H5erDKYU3pW/pqjbI7j+6ZcB0Qt9z/KGqBlkshVJTzzKx2oXtAxlL
         E18h73O/s3dn+xBEwK308w7agQS5m2RYZzHNrLUdhfdZKeG/e+Dr27X21QpoIwd1KCAl
         PxttLdZl6PZf2goM/cRw6Bbw12/00xnTFdgSr8ytAWjU88JMxI5kTd4reOjRdKpNjh+N
         Ix/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773147248; x=1773752048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mm6hm+LHoMGo5Ew01sq1dP9YSITnoqIDxYFDqmtgvh0=;
        b=MX+mGNo+wRVeHLvaXnbRMcNh/7etnIuYkDRx47//SVtqbz3r30Z9kVb7wTo8gV1nOi
         MVH3lP8gsVztL+cwf3yj88l8J/6Yl+TMNxk3WfblZTG9PBS9xqT0UypqcHBOfjThvaUg
         0zVm+sXRCHFh6HkNbvpd6J1NwojA1wfLoedSpo8KPfOyMNZSmMR6VMFcmeD5F5LJ34IN
         +sIunUJ9KTaWZ3d2Oe36CPAKDUJ62EttU9bVcS1w+Bio4zVlTlKjJNZ0n8El8GKd2/lT
         5+zHxaRetn803o1C5FEYfk2C3FfCdVHakYKkjAUM07bETeNzK3FT+ME+PSSvh/tK957E
         2VVw==
X-Forwarded-Encrypted: i=1; AJvYcCX7eJDzVFT7foa2mNBNACp+a42uLgi1KCgp46/IVoZcPa2o3dNLPjsbiHZ5DfF4DTTbYOcSWTr67Zkn5KzM@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/cIFQUSvdsqmvskXjRm/q8qG5ggkZB47JQB6mbQIuvWgDSik9
	MNpk4B72s2ZmsYGHepBeyunBRyqfeY7rDaT6qPR5YBVjA4l4nYP2PRxTyEnwg0K2CA==
X-Gm-Gg: ATEYQzzSl9bAShKb0nAnF2jk0HzVNzgrMFUBNSY9PmYvR5ok+gwA23U6wvq/xo1+i1v
	VNy0EOC7Cn1yhAWHPXNdj+Or1PwsYIYriciajYuv5agbHpGYPnZ+dUwixcZURBbBQS7wak7xSTP
	+rY42RucT3kU4GuXH11gUGpgmWe3Lqep5dpmreU4tRiHqu7q2eDojKNJ4eIx4JCHY53e2euYqoK
	k9ymO/9Qr1ot1bxKACkbzXZ9Dsg+jc2DvttP44W67Kd3eEWzdLD4p64mgwoSmprD1CQJp7W8Qkt
	IM9LRego7Zr5zAJGrCFzAs2Cl7KwtDMLjEQUdFvj87nLDPqT6/v0L9ZCp07filBMA08JQHLQhO5
	GRBdDp/umqreStaOpimPAdH+VROj+6/nThAjo4Z0Uqhydxjut15tSvQ5iopxHQkg1oRaexVl8zQ
	kBGga5ZuFFoxwj2E1L64KNgy0/KvWHzwcILk6s/Blqa0nZYGXfA5SbURqyHQ==
X-Received: by 2002:a17:902:ebd2:b0:2ae:45bb:bc4e with SMTP id d9443c01a7336-2aea30ebe48mr3008685ad.24.1773147247400;
        Tue, 10 Mar 2026 05:54:07 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e0cb73dsm12445679a12.11.2026.03.10.05.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 05:54:06 -0700 (PDT)
Date: Tue, 10 Mar 2026 12:53:54 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
	sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH 46/61] vfio: Prefer IS_ERR_OR_NULL over manual NULL check
Message-ID: <abAUYvx6VEdSmInm@google.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-46-bd63b656022d@avm.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310-b4-is_err_or_null-v1-46-bd63b656022d@avm.de>

On Tue, Mar 10, 2026 at 12:49:12PM +0100, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Change generated with coccinelle.
> 
> To: Alex Williamson <alex@shazbot.org>
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  drivers/vfio/vfio_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 742477546b15d4dbaf9ebcfb2e67627db71521e0..d71922dfde5885967398deddec3e9e04b05adfec 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -923,7 +923,7 @@ vfio_ioctl_device_feature_mig_device_state(struct vfio_device *device,
>  
>  	/* Handle the VFIO_DEVICE_FEATURE_SET */
>  	filp = device->mig_ops->migration_set_state(device, mig.device_state);
> -	if (IS_ERR(filp) || !filp)
> +	if (IS_ERR_OR_NULL(filp))
>  		goto out_copy;
>  
>  	return vfio_ioct_mig_return_fd(filp, arg, &mig);
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

The cleanup alone looks fine, but I'm not sure if the maintainers would
be happy about the tree-wide spam, since each patch might go through a
different tree. I'd wait for Alex's preference/ack on that.

Thanks,
Praan
