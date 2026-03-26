Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47EF389DE6
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 16:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542198; cv=none; b=Wp0C2urTy45L0tFyatf2I0NZnC41PgcmqzwTvGzFb7k5UmCoW6Zy45rNScsyycJwghD4fl7xGzoXyKx4u+m2B8t3Asmlntw8jeNNzdQ5HMpOPFXbazj+0BVp/bq26Dh08CTGnqH+YezEGdc8nOycG4zVDTiCktKD2s8Vz7eph9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542198; c=relaxed/simple;
	bh=WrKWIQ4eRHoS0rLfsKG8Xw8V+AfIWGAnYB7QvEHG1Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJ283pgfGNmGALIpvaO8fPEeRN/j+Hue4PG77K526mEiwSSLH6n1kFReL6Tf5s7FmHO9f77Kpg1HMwLdndV1Qnp8PJqz4hBb9VS/WQcXQHPNHEE78ltaZju3is1UotaU+4KgqdZLPMFmBuJI+PiPO2zD9TiVktas0mTUDvvDrFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BvN5aQBA; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BvN5aQBA"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-486fd27754bso11141735e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 09:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774542194; x=1775146994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=98fA588IY0WznoEF0+AcBsZZZe2OdsWIRGMXaYNdr/k=;
        b=BvN5aQBAjKuVJF+w1vec7KBa4J/6Yo9eVdliGPXt8AW1sI3L6B3ksFICfiPhyGPHwI
         jhsJ/M5tY5kwom1T4cJUDsgE7jscCcsR6jsJdygq5W2YlfgQT3B8nI4ydxm27NmrjkjW
         jMIaMAWdDzFscJuRS+2hNdl7eWBfEdu9G0Zvea+PFgNYdgtqYowj/HNjY6FKZQZX8bka
         Mah36awTHuBUHB/sOtxgAlpm7IAHni/FrmLrhvBiyjlkr3vgT1p3yIaV7OHdXs+OEhWC
         5URs/1CR8sXptGBqfDwzusX+Gx+BKPiML2RRK/PgB97frjvRiuiDXVRSPqMP2xlP15IF
         QZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774542194; x=1775146994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98fA588IY0WznoEF0+AcBsZZZe2OdsWIRGMXaYNdr/k=;
        b=k266p3z4APV8hW6drLnlsOdPbXNfPpjZo2T8VudOvbXDS4AOnETJor/hWD/qliua4F
         vgnggQSsyxap/FLb0jhAUXojsB2YhsHDm6DXL+DIQf7JOdtp6pJl4phc+/PFVq+hjt9O
         HJk4RvjoVn2lWSA5fwCxx8GSFPdSwb4r7G22ilOWUc4DNWST1FRuLYwsXX822odvau5s
         MZeLiqj0ti+XyXLireLnZYgFRCHwvv50Pqi1hEO80mMTeLgSM1fpRmX/U0smP40g4t6a
         KuPmK/lUkhhqnskayu2BlZiZZYPTnPhKzITXfYX9PAhaJ2schZ4bon5RcsIPIjL9kxrY
         X4hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJsUB06sTgh7USSHWPcDVR6BPoKaxk7zsMQXpxnHqujJTCajBqnjpN/6Ly+S0B5saw+py934ENazN3yRdY@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4U1uAdEKJPY6sw+JUyPEo/Hd+5tNNRyBekIEPduS0DDQ6oySf
	Q4SE98fxEQSsnjzmvhBm9U+jJRYToRIo6MsxeL5FqhQ1+Ccx+PxiIGj4lgVI4AYgDBw=
X-Gm-Gg: ATEYQzyJddMPSq0SV0M+SBytScO1SOMU8OOO/wXG2zWAZ0NuQZFdjb/ELnz5pSltTSl
	qq5bc2d5RF9+GTYOYDj+efBkRlKl4cNPM4/7BQkH5ecI5awzktmnnqPaommcXNDvpGf8iqJecPi
	EA4VHGa/WM+9vw25qzwf8BF0nS94s3nyBjf3gRuMCD4v6qja+T2h+W7r8J6/wrQyHWhiEEcegVU
	BOyMWTT1mdqCm67CiNYXFN+c3W/kfc6ljUAdcY6kRQXc63loV+ITkAWh4iEKJRm803tQr/8p7xB
	/Yg9xd5Of/XsRAH+WICdlXamZ6jyGiZg334VjHp/YCxVXOos04H3vzHDyIvZyiBQr/4IwrvGLWS
	bexkCwAR3ht+sP6YxT4ga90v/6RdDHRx8Zxae/hrzPfz1k/zWkAfFLQj9+b4oNohC2vnBncvolt
	Bxc+xItdPFQaP9uQi+hRZWzgezEQ==
X-Received: by 2002:a05:600c:6287:b0:487:1108:48af with SMTP id 5b1f17b1804b1-48715fd4ab1mr128556895e9.4.1774542193719;
        Thu, 26 Mar 2026 09:23:13 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722ca344dsm33569545e9.12.2026.03.26.09.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 09:23:13 -0700 (PDT)
Date: Thu, 26 Mar 2026 17:23:11 +0100
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Disseldorp <ddiss@suse.de>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 1/6] initramfs_test: add fill_cpio() format parameter
Message-ID: <acVdb6wb5GuEpb3x@pathway.suse.cz>
References: <20260323150054.3587083-1-andriy.shevchenko@linux.intel.com>
 <20260323150054.3587083-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323150054.3587083-2-andriy.shevchenko@linux.intel.com>

On Mon 2026-03-23 15:54:17, Andy Shevchenko wrote:
> From: David Disseldorp <ddiss@suse.de>
> 
> fill_cpio() uses sprintf() to write out the in-memory cpio archive from
> an array of struct initramfs_test_cpio. This change allows callers to
> override the cpio sprintf() format string so that future tests can
> intentionally corrupt the header with non-hex values.
> 
> --- a/init/initramfs_test.c
> +++ b/init/initramfs_test.c
> @@ -27,7 +27,10 @@ struct initramfs_test_cpio {
>  	char *data;
>  };
>  
> -static size_t fill_cpio(struct initramfs_test_cpio *cs, size_t csz, char *out)
> +#define CPIO_HDR_FMT "%s%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%s"
> +
> +static size_t fill_cpio(struct initramfs_test_cpio *cs, size_t csz, char *fmt,
> +			char *out)

This should be "const char *fmt" as pointed out by
https://sashiko.dev/#/patchset/20260323150054.3587083-1-andriy.shevchenko%40linux.intel.com

>  {
>  	int i;
>  	size_t off = 0;
> @@ -38,9 +41,7 @@ static size_t fill_cpio(struct initramfs_test_cpio *cs, size_t csz, char *out)
>  		size_t thislen;
>  
>  		/* +1 to account for nulterm */
> -		thislen = sprintf(pos, "%s"
> -			"%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x"
> -			"%s",
> +		thislen = sprintf(pos, fmt,
>  			c->magic, c->ino, c->mode, c->uid, c->gid, c->nlink,
>  			c->mtime, c->filesize, c->devmajor, c->devminor,
>  			c->rdevmajor, c->rdevminor, c->namesize, c->csum,

The compiler is not longer able to check whether the number/type of
parameters match the given printf format. It was poitned out by
Sashiko.dev AI and I agree that it makes it harder to maintain.

A solution might be to split this sprintf out into a macro.
Or add some "bool inject_ox" parameter and keep the format
hardcoded here.

I did not found any other problems ;-)

Best Regards,
Petr
