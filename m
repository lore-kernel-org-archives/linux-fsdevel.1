Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B035D3C2779;
	Fri, 20 Mar 2026 15:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774019110; cv=none; b=qx+//sKyRlsuQIxkloxWwonjr2DygyNMrA8wAolU1mh5zbmEz+ZKdo/wkXxQ2gTk4wNf7RWJHttmS+HvIa+Rc0rof2UNZ7J3Ajsm5LmjCkYWZQPWxwCQ6C2T1DpwKH0yLt1CVqVa8/4RxiP8WBIqYUQcYJUpLn3URWypA1GbGcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774019110; c=relaxed/simple;
	bh=AcaXStWFsIewIYnGceHou6xqh7Tg08T6lSiroDlTfZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhJgR6TirDChrndGFnVQRMJK/eiXZ8egfd4hs+F7AY3zMz0ysBGRcxfgUGnKKC85oKEVvIWaegQ9rSihOlHoaXWEJ7v1MHlMFPLwNnoM/fYzg2jdRyKRRn3ZQpQS2tCdmrV2NnXHuENdE4m8Y2XDMKiFXTADlLZEVe1hjdyZik8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O+HaXRHh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O+HaXRHh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3D6C2BC87;
	Fri, 20 Mar 2026 15:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774019110;
	bh=AcaXStWFsIewIYnGceHou6xqh7Tg08T6lSiroDlTfZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O+HaXRHhSDEyhMsTaOp+IjMPZPSQVCB79IiTfVevM3y1DXiKri382cD/Di1QnFXGI
	 hrbJq8fSgJeXG0VzJJ8lvMCJYVtWDPUFVIdEvK0uoIhqebu/a0Ne26VQRESm8H62Bx
	 jm1v3/cwiqsJRTkgRx4SiofZx3FXhyYYvIxgn9Vk=
Date: Fri, 20 Mar 2026 16:05:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bae Yeonju <iwasbaeyz@gmail.com>, stable <stable@kernel.org>,
	Kees Cook <kees@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] adfs: validate nzones in adfs_read_map()
Message-ID: <2026032021-renewable-control-9c81@gregkh>
References: <2026032055-abstain-ending-6acc@gregkh>
 <ab1bmzFTIGB2o-zO@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab1bmzFTIGB2o-zO@shell.armlinux.org.uk>

On Fri, Mar 20, 2026 at 02:37:15PM +0000, Russell King (Oracle) wrote:
> On Fri, Mar 20, 2026 at 03:23:56PM +0100, Greg Kroah-Hartman wrote:
> > From: Bae Yeonju <iwasbaeyz@gmail.com>
> > 
> > adfs_read_map() reads the zone count from the on-disk disc record
> > without validation:
> > 
> >   nzones = dr->nzones | dr->nzones_high << 8;
> > 
> > When nzones is 0, the subsequent kmalloc_array(0, ...) returns
> > ZERO_SIZE_PTR (0x10), and adfs_map_layout() writes to dm[-1],
> > causing an out-of-bounds write before the allocated buffer.
> > 
> > This can be triggered by mounting a crafted ADFS filesystem image
> > with nzones set to 0 in the disc record. It leads to kernel heap
> > corruption and a NULL pointer dereference during mount.
> > 
> > Add a check to reject disc records with nzones == 0 before the
> > allocation.
> > 
> > Found by syzkaller.
> 
> I didn't see this patch.

This is the first time it has been sent in public.

> This is a silly place to put the check - it should be done while
> validating the disc record, in adfs_validate_bblk(), not when trying
> to use it.
> 
> Note that adfs_validate_dr0() already validates the number of zones.

But then why is this check also needed?  I'm all for moving it
elsewhere, Bae has the reproducer, they can check if moving it fixes
their issue or not.

thanks,

greg k-h
