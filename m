Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4228C2D77FF;
	Fri, 20 Mar 2026 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774022913; cv=none; b=o4znQJwzLxzW/hFrzqxOgU4BjqnIbVc8lk++4FCRSrm45wwp2nuZ5u0cIZk2GH2hUcfdW9x4LGnJD2g4J9YJTMljrk4ydyHR+Sjl+WGAMO7A15UmCW6n/dZQPru1uBSXbQYAxdSEAUK7vcHauNazJXG/lBbqz2vWeSWJxZFN1iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774022913; c=relaxed/simple;
	bh=f9+bODSEYxKCHUsSEPA+cvQQaHwuU2a0Yq/vyxAyz6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7SNVQGeHMJn26X/J3IXIhA/6VSbkL9o/+0D3eQ52XVvXJSK50xAMAUqxICdnACjChLsRFM6AuRvhMpvNXgVesx30prRPeRjLkHDkXeGBxP5EGB3HrPxfEjp9ZoVbwwi9Avn3AWryW9XWxP877c9/j0//tuhDtIjoo6W1qMQr4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KobWcZnG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KobWcZnG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=H2UlUlzgWxS/X/51N/fQGDHUcW87gGbhdtAkEk5JyKs=; b=KobWcZnG7RftiClrXGlxoyzDMI
	GCtdR67Oxfq4KOob/UjwoBbR1ZG/HoFRY9OBGn1bddHeMTZJuvbviQWerO+FsfPP83cG7lq5Oe26s
	oDYyJ2GNeKD+pEyVSgQLAthK7Mp+xHDZ8lhT0bhFfmym440XDk0MsBMuGrOzRhYEFr9MrAiRHghgc
	gnRD37DPTnNsUeaNrTCYGbFWjFPTsRiKpuTDGzRLVn8PgKucqBnk1Bu36k9OkXDtNCBYhCwCExHhO
	teUg3DPdAJZwuySrnCVSDcxoO9f2ZGiCuTbVsAk111eDtEgklESWmfsTgmHHL4ZnnbBt1dOMdV4Od
	u8KTHs+w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38036)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w3cOi-000000006Gl-2umE;
	Fri, 20 Mar 2026 16:08:28 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w3cOg-000000000wi-46xL;
	Fri, 20 Mar 2026 16:08:27 +0000
Date: Fri, 20 Mar 2026 16:08:26 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: paeyz <iwasbaeyz@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@kernel.org,
	Kees Cook <kees@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] adfs: validate nzones in adfs_validate_bblk()
Message-ID: <ab1w-qScoY8mnAT4@shell.armlinux.org.uk>
References: <2026032039-agility-ferocity-6ee0@gregkh>
 <20260320155213.2812-1-iwasbaeyz@gmail.com>
 <2026032011-encrypt-embattled-1a25@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026032011-encrypt-embattled-1a25@gregkh>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Mar 20, 2026 at 05:04:07PM +0100, Greg KH wrote:
> On Sat, Mar 21, 2026 at 12:52:13AM +0900, paeyz wrote:
> > From: Bae Yeonju <iwasbaeyz@gmail.com>
> > 
> > Reject ADFS disc records with a zero zone count during boot block
> > validation, before the disc record is used.
> > 
> > When nzones is 0, adfs_read_map() passes it to kmalloc_array(0, ...)
> > which returns ZERO_SIZE_PTR, and adfs_map_layout() then writes to
> > dm[-1], causing an out-of-bounds write before the allocated buffer.
> > 
> > adfs_validate_dr0() already rejects nzones != 1 for old-format
> > images.  Add the equivalent check to adfs_validate_bblk() for
> > new-format images so that a crafted image with nzones == 0 is
> > rejected at probe time.
> > 
> > Found by syzkaller.
> > 
> > Fixes: f6f14a0d71b0 ("fs/adfs: map: move map-specific sb initialisation to map.c")
> > Tested-by: Bae Yeonju <iwasbaeyz@gmail.com>
> > Signed-off-by: Bae Yeonju <iwasbaeyz@gmail.com>
> 
> Nit, no need for Tested-by if you sign off on the change :)
> 
> > ---
> >  fs/adfs/super.c | 3 +++
> >  1 file changed, 3 insertions(+)
> 
> The version info from what changed goes below the --- line.
> 
> Anyway, who takes adfs changes these days?  Russell do you?  There's no
> MAINTAINERS entry that I can find.  If no one else, I can take it
> through one of my trees.

I have done, as I'm the author of this fs driver.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
