Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2833D352035;
	Tue,  2 Jun 2026 07:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780384656; cv=none; b=HAAzRnBEunv5KqTl0Pj28foa2J03VMfGePbrk9sCxbQPb00WOWOxU3htPyh9vtfS5090bM8HqFHitCM28JtJiILmDpJT5qJ9FxcZIzygto149GOFT3Ed4N5cdHNmJOpEMeJU58LDGq48W+OIU9TYyXtF6/N4DQazu6IFbOTVmvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780384656; c=relaxed/simple;
	bh=El3+TjXEr7FJO3HYLS8thfLVpxG93Hen1fpeiRJB0Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFL83ozLRChu+ymFHZB37CPP6YOYS+VFzPUd9AliTcfvUda2liMxviFOUMEB/cx481q5x2kzyIafGQB/P0e1i5kz3AI6bN4LiTDLRLmmMZlYEwBN9SlF28jpkGzAfoO8PwIS+Nfj/6tF/Wp2TtimzqAyYpGu0zt7J2BboukZ/gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=alaiCOmR; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="alaiCOmR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zIEGCvg9vI/rXCyGBdSSGD7TJh7MNFGvQ1sybkYqrRw=; b=alaiCOmRSWP+Dc7Ix9cmrwXoRj
	wJWTgo+TzwFEsjUsU6QnwfP4m8CgJHGoudQU2iTms1T7YOc2OoTYu6BSS6v+H83UHuPdNnTtf+CrD
	rCpbLQ891jNUI5axE/H0cPkb/eMHI5/c7emXWnC4gdgWDKYI+oDdmhvONpSScx73Aobde6+IZgEJG
	GIzW4tSOK0j62BDs9HAxWPyrLcjatelnmTcSiSlkbMy8d2tHp+nxjVprTTFaQfSNnRrTSiI3rKFQx
	lhhMsTtizu+KsDcOKW2Y1NE+IZAQKDdarOf6vFIMp8tbYTTsZFqyi01oRfBhXq09lthSMfYm+sv5B
	uUneKQCw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUJNT-00000006h7s-36zw;
	Tue, 02 Jun 2026 07:17:32 +0000
Date: Tue, 2 Jun 2026 08:17:31 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Breno Leitao <leitao@debian.org>
Cc: Farhad Alemi <farhad.alemi@berkeley.edu>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] configfs: slab-use-after-free in configfs_drop_dentry() on
 rmdir
Message-ID: <20260602071731.GR2636677@ZenIV>
References: <CA+0ovCjv-VYvn-4jUj3wDn+DuP9FSv-GL+yPAHbR=ZGKU0wmGg@mail.gmail.com>
 <ahbG94EFLD5ntnYr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahbG94EFLD5ntnYr@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, May 27, 2026 at 11:27:57AM +0100, Breno Leitao wrote:
> +				/*
> +				 * configfs_create() failed (e.g. -ENOMEM
> +				 * from new_inode()).  The dentry will be
> +				 * dput()ed by the caller and freed via RCU;
> +				 * because it never gained an inode,
> +				 * configfs_d_iput() will not run to clear
> +				 * sd->s_dentry.  Drop the linkage here so a
> +				 * later detach_attrs() walking the parent's
> +				 * s_children list does not dereference a
> +				 * freed dentry in configfs_drop_dentry().
> +				 */
> +				spin_lock(&configfs_dirent_lock);
> +				if (sd->s_dentry == dentry)

Don't need that comparison - to get a different ->s_dentry you'd need a lookup
on the same name in the same parent since having dropped configfs_dirent_lock,
and VFS locking guarantees that it won't happen.

IOW, the variant in
https://lore.kernel.org/all/20260519070633.2025485-2-viro@zeniv.linux.org.uk/
should be fine.
