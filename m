Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F166C3C7E03;
	Fri, 20 Mar 2026 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774022716; cv=none; b=VdHLOsDvLaSk2kyTrALM2KRZOoYvRAGPzs/nAb0LKGuWIpzNbOziZwp2q4WZRZXjziw0fLWAtcjITbO1XHFTFpPYrlxRB0006/asEpwLTymGpAcAFC3VGaF97QSWcMxJ0hIEsIrBtfP2sp+7tIL0bIMMM1NZUlgMTmbpekYfA7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774022716; c=relaxed/simple;
	bh=2KRdRCRXFua9bz+4DMCxsIXb0PWbtsNy4avYubffQ9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NyoUDCrvpmL6Qbti/rATVTiprzs/EIVWyefjWw9SFRZU9UIEMAFQXE76gYojK17RkjFiyKjPzmKLRwXzC5BDaPAPhAC+b7HKElgI2JG88Onny47JRHNYvugvvtLPLP9Nf806WI+SgvRlruaUEyk9n6tl5DHHWB621K/QQRuU7yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HPh6SeQG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HPh6SeQG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sNEID8Zy0xzfD2UjkdMP9gTmJjNh4CDCy/yUCC1Fag4=; b=HPh6SeQGWKjv2L/A1gxzSd5LBi
	zJsOrLlVLFOWqjdd4uod71leJscFIHOILkPkkeGX6voCTpjmurQ0gCSWAu1OXE06x6q1h+vIlVls/
	INzZcYQC9jOxwoG9CcaWokkvw7Kjdkg03H0BhvKQd+9UvPWSEHLsOpJG3rmeHMW0OWKJLPsJIpRP8
	a65HflCjKpVFGaas2F/wYKU1tU1BydmeXCbSR/dxmCB2vQHHqBNTFJGz255sbPaiVJssb/85HUh0M
	TmLnhWYpHk0K9whJFyHWf2eJzjF2BdqDaW5/Tb12I4vOhIQebAV4Ddku9bUkGaNAapWTW8yF1BCyF
	lKEHUOkg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54396)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w3cLX-000000006GP-4APQ;
	Fri, 20 Mar 2026 16:05:12 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w3cLW-000000000wa-3olA;
	Fri, 20 Mar 2026 16:05:10 +0000
Date: Fri, 20 Mar 2026 16:05:10 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: paeyz <iwasbaeyz@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@kernel.org,
	Kees Cook <kees@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] adfs: validate nzones in adfs_read_map()
Message-ID: <ab1wNgL7VI9iyN_h@shell.armlinux.org.uk>
References: <2026032021-renewable-control-9c81@gregkh>
 <20260320152131.34551-1-iwasbaeyz@gmail.com>
 <2026032039-agility-ferocity-6ee0@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026032039-agility-ferocity-6ee0@gregkh>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Mar 20, 2026 at 04:40:57PM +0100, Greg KH wrote:
> On Sat, Mar 21, 2026 at 12:21:31AM +0900, paeyz wrote:
> > From: Bae Yeonju <iwasbaeyz@gmail.com>
> > 
> > Hi,
> > 
> > I tested moving the nzones validation to adfs_validate_bblk() on
> > 6.12.36 with KASAN enabled.
> > 
> > With this change, a crafted image with nzones=0 is rejected during
> > validation:
> > 
> >   ADFS-fs (loop0): error: can't find an ADFS filesystem on dev loop0.
> > 
> > mount() returns -EINVAL, and no crash or KASAN report is observed.
> > 
> > So the issue can be prevented by validating nzones earlier in the
> > validation path.
> > 
> > Tested-by: Bae Yeonju <iwasbaeyz@gmail.com>
> 
> Great, can you rework your patch to move the check to that location and
> send it?

... great, giving me no chance to reply to your previous email...

In netdev land, we have a rule: wait 24 hours between posting updates,
so that discussion has a chance of completing. I suggest that would
have been good here.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
