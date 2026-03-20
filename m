Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71D93AC0E9;
	Fri, 20 Mar 2026 16:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774023166; cv=none; b=BKu83ofpmbDcRoSuDvJomSVKBN1hNyLwhFkSgWf7fweN5lVFRKlV9BzrSHCk1Gl02zeM0tOa+B+iegzL1MZMtD1x+S1gQtlC33uUOu5PubeuJMYABuBvVqdPtbmylaSNgZUjQQAnP13rp/EifGlkAl0Jwx5Lf+1lbjaAY1v6ov8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774023166; c=relaxed/simple;
	bh=qyTL7W3TK6baiNaJSSE5FkbdM7ijykvwr+Bqle1rP/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaymfB7fK1Rx/u6UrFIycf3LvoIcebuvluXAyKpUV/R4l9N6xUGWfMlh5IhXeh/RdUzItRbPw8bP2iHfsJ6LQ6MEvQ74Zn7Vw+js9VXL+xHr18kDJvGkKucuOlZys54x0hzEMDa/froGmKhveDOE+XzE/ekCxPLVfkac7jTKImE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bEryAoPh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bEryAoPh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F497C4CEF7;
	Fri, 20 Mar 2026 16:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774023166;
	bh=qyTL7W3TK6baiNaJSSE5FkbdM7ijykvwr+Bqle1rP/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bEryAoPhau5IkJxBPUdrJ8TPuPsY2oTqCr9rgGFBNujxCBwazIZsuQ13mk798c9kv
	 E2ed5X+oSqc+Lzp1XiWdbdVhTqEp3jlnL97mwQD2IHdC1/9vFW7zUM9cs6qSCsgO00
	 dvX5p9LUlvreAMFzyxb5ZwYfKKdpNPdTLXmcdduI=
Date: Fri, 20 Mar 2026 17:11:34 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: paeyz <iwasbaeyz@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@kernel.org,
	Kees Cook <kees@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] adfs: validate nzones in adfs_validate_bblk()
Message-ID: <2026032025-mouse-gestation-876a@gregkh>
References: <2026032039-agility-ferocity-6ee0@gregkh>
 <20260320155213.2812-1-iwasbaeyz@gmail.com>
 <2026032011-encrypt-embattled-1a25@gregkh>
 <ab1w-qScoY8mnAT4@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab1w-qScoY8mnAT4@shell.armlinux.org.uk>

On Fri, Mar 20, 2026 at 04:08:26PM +0000, Russell King (Oracle) wrote:
> On Fri, Mar 20, 2026 at 05:04:07PM +0100, Greg KH wrote:
> > On Sat, Mar 21, 2026 at 12:52:13AM +0900, paeyz wrote:
> > > From: Bae Yeonju <iwasbaeyz@gmail.com>
> > > 
> > > Reject ADFS disc records with a zero zone count during boot block
> > > validation, before the disc record is used.
> > > 
> > > When nzones is 0, adfs_read_map() passes it to kmalloc_array(0, ...)
> > > which returns ZERO_SIZE_PTR, and adfs_map_layout() then writes to
> > > dm[-1], causing an out-of-bounds write before the allocated buffer.
> > > 
> > > adfs_validate_dr0() already rejects nzones != 1 for old-format
> > > images.  Add the equivalent check to adfs_validate_bblk() for
> > > new-format images so that a crafted image with nzones == 0 is
> > > rejected at probe time.
> > > 
> > > Found by syzkaller.
> > > 
> > > Fixes: f6f14a0d71b0 ("fs/adfs: map: move map-specific sb initialisation to map.c")
> > > Tested-by: Bae Yeonju <iwasbaeyz@gmail.com>
> > > Signed-off-by: Bae Yeonju <iwasbaeyz@gmail.com>
> > 
> > Nit, no need for Tested-by if you sign off on the change :)
> > 
> > > ---
> > >  fs/adfs/super.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > 
> > The version info from what changed goes below the --- line.
> > 
> > Anyway, who takes adfs changes these days?  Russell do you?  There's no
> > MAINTAINERS entry that I can find.  If no one else, I can take it
> > through one of my trees.
> 
> I have done, as I'm the author of this fs driver.

Great, thanks!

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
