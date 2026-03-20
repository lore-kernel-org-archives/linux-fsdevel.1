Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3842939C637;
	Fri, 20 Mar 2026 16:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774022707; cv=none; b=Y+jdP+HXXK1ZhuGoooP1Lwz8ODgQJGvy1f/3+zlgjxti9bax9R/bAfLfSUWzgB8NDcLw6DrWxfo4fwwz46w3gmeL9+1g2yCdG3KtAKNOJMMM5NQoddr6vUTghmIBN1KQsqp+HWYeCS//B5XemfRC5sGY9ZHrSLub0hYRJ0FKgsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774022707; c=relaxed/simple;
	bh=WPl2fyV89ZeuWJPIhVV/EpFZ7Hpeu8A8XWHX1Nuc/hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6mYVPB06Xkgj1Ej05HkS0pwwmKEd5UImRXWFgAqSs9RqTzEiWw+Aho1RtmIyJcWg6DxxnJ8WSUMTVjld3sNhrkzC1/BS+9uvbkQgy8sYa8Dnnr1PjQ4MlcNAnoEU9jk1gKY7QYeGrHv/AKx7CpdMHPK3nNrl4aTNWzSsQSFGu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sRnURy6d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sRnURy6d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77200C4CEF7;
	Fri, 20 Mar 2026 16:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774022706;
	bh=WPl2fyV89ZeuWJPIhVV/EpFZ7Hpeu8A8XWHX1Nuc/hM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sRnURy6dzhAJ4b4X9AWQjNHbfUX9RW3QVwXE3dbl3iSz607xnShK9ygbS5IP5ntCE
	 u2vdw/akRtZmovoRCdZhKlwhaUSuFgFHuGmQ+a552PInHxs5Mq/srxCfOKmMqhoStd
	 qrc71w3gofR/hOdtAmvwkhKaSaKdKxBVEZMk19QQ=
Date: Fri, 20 Mar 2026 17:04:07 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: paeyz <iwasbaeyz@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@kernel.org,
	Kees Cook <kees@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] adfs: validate nzones in adfs_validate_bblk()
Message-ID: <2026032011-encrypt-embattled-1a25@gregkh>
References: <2026032039-agility-ferocity-6ee0@gregkh>
 <20260320155213.2812-1-iwasbaeyz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320155213.2812-1-iwasbaeyz@gmail.com>

On Sat, Mar 21, 2026 at 12:52:13AM +0900, paeyz wrote:
> From: Bae Yeonju <iwasbaeyz@gmail.com>
> 
> Reject ADFS disc records with a zero zone count during boot block
> validation, before the disc record is used.
> 
> When nzones is 0, adfs_read_map() passes it to kmalloc_array(0, ...)
> which returns ZERO_SIZE_PTR, and adfs_map_layout() then writes to
> dm[-1], causing an out-of-bounds write before the allocated buffer.
> 
> adfs_validate_dr0() already rejects nzones != 1 for old-format
> images.  Add the equivalent check to adfs_validate_bblk() for
> new-format images so that a crafted image with nzones == 0 is
> rejected at probe time.
> 
> Found by syzkaller.
> 
> Fixes: f6f14a0d71b0 ("fs/adfs: map: move map-specific sb initialisation to map.c")
> Tested-by: Bae Yeonju <iwasbaeyz@gmail.com>
> Signed-off-by: Bae Yeonju <iwasbaeyz@gmail.com>

Nit, no need for Tested-by if you sign off on the change :)

> ---
>  fs/adfs/super.c | 3 +++
>  1 file changed, 3 insertions(+)

The version info from what changed goes below the --- line.

Anyway, who takes adfs changes these days?  Russell do you?  There's no
MAINTAINERS entry that I can find.  If no one else, I can take it
through one of my trees.

thanks,

greg k-h
