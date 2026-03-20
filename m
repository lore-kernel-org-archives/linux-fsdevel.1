Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8596436EA9E;
	Fri, 20 Mar 2026 14:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017449; cv=none; b=N61heWPNSNUTNs8EPkyAI7AonhzZul4SnDTOIDAQxOsCP1NrPOs1pVf3MLZ1eG837J1ZmLsmRIIJ97aiXn++WCw1jXdZbbE3e3g3T1W5AzYO6/hHhBwOlbGoV+V1glquWUiX+bEPzoq1ZksgNIqnMtUqT004yUDt8rfDlWnL/1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017449; c=relaxed/simple;
	bh=UpXfUGx0yHpc4xkYU8LSP6v8FBoRnAIHnvY3rPQGylA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mlcuwd80+ZWwO3ctqib7GiP9COMf8d6lJjI19tYdUyZ55m2WjpYUm0RjSA12G6XbHNIVry501xNWdRZlsHpYE62VWEQ03AyTIIMl8kGCBrrbp6KujxkmRn909m2AN3EyygVnan7AfhUuQwUgAcfYB9AoEHhl81ZBieXtr/xqPN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Ayy5FruN; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Ayy5FruN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hO25abO4Mqp+RHuF1ujwrX62yx+qmxVDHmEeiKftMQ8=; b=Ayy5FruNymVPtrkZwzxRps/mG9
	njLNeA+7RqSWpves7q9tAydloU+gYAW4fWAkHh5tKX+BXZlhptJoEU6iAxZNBFDCV0YQqsI51BVdC
	0oXApbagTN1d4w/m4fNugZgmi/Zbl7sE8MB85QbMrRXg7xG6yRGLftfr50Ih2X9q5Kr9Y02Ftjcxh
	GJXbl0dIfwhT1lFW47HfCG/AR6sCxhIUZDiJrmCy9pIXPHLvA3gqQzY0VE4tDfHXof54TUecRihuW
	85PO1plXty+dA+D1DdS3N+3x2hYIXIQXQwWL8Ulo8BVLJHLcyxXvvYByDNZa+rlLbwvpTNxeX5vAB
	IEPpqI6g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33116)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w3ayT-0000000069k-2FcV;
	Fri, 20 Mar 2026 14:37:17 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w3ayS-000000000sw-0T1T;
	Fri, 20 Mar 2026 14:37:16 +0000
Date: Fri, 20 Mar 2026 14:37:15 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bae Yeonju <iwasbaeyz@gmail.com>, stable <stable@kernel.org>,
	Kees Cook <kees@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] adfs: validate nzones in adfs_read_map()
Message-ID: <ab1bmzFTIGB2o-zO@shell.armlinux.org.uk>
References: <2026032055-abstain-ending-6acc@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026032055-abstain-ending-6acc@gregkh>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Mar 20, 2026 at 03:23:56PM +0100, Greg Kroah-Hartman wrote:
> From: Bae Yeonju <iwasbaeyz@gmail.com>
> 
> adfs_read_map() reads the zone count from the on-disk disc record
> without validation:
> 
>   nzones = dr->nzones | dr->nzones_high << 8;
> 
> When nzones is 0, the subsequent kmalloc_array(0, ...) returns
> ZERO_SIZE_PTR (0x10), and adfs_map_layout() writes to dm[-1],
> causing an out-of-bounds write before the allocated buffer.
> 
> This can be triggered by mounting a crafted ADFS filesystem image
> with nzones set to 0 in the disc record. It leads to kernel heap
> corruption and a NULL pointer dereference during mount.
> 
> Add a check to reject disc records with nzones == 0 before the
> allocation.
> 
> Found by syzkaller.

I didn't see this patch.

This is a silly place to put the check - it should be done while
validating the disc record, in adfs_validate_bblk(), not when trying
to use it.

Note that adfs_validate_dr0() already validates the number of zones.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
