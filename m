Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08AE198A17;
	Fri, 20 Mar 2026 16:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774022579; cv=none; b=IDww6X+5Nhg+cM67Yiz1reC1PqQKbss7+ONPu46wC1aDfBJQVko+aIaDY1GqE8UYVDtrTn/yZ7YnMLaefVXsUUdYZiluxh5Fptqq7wJZajiUKXEibqYxI8ffEXW8BvPDnhHY59o98hFIo3hrc6GJkkDeS3ZRpfUQ5BeLLsZoDv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774022579; c=relaxed/simple;
	bh=ZXHYy6ic4h3excpKxVlER7/XYj41w0TNo3cwM8zVt/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6/hX58rqyFP41nITI0J2CXYx+usO47+yz5ZW5JRJx4TlDSgNdvRlVjbkqffMgPahk+Uy2QtPbjqOnJTR70IALtu07tFZC45NVRhc62fIebcja7Xcr1+6j1vt3GC7E2m9LlhQg6+WUnvB3s+ulspsbZqRXK3JHfN2Gji9MlsP7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=JTtxtfIL; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JTtxtfIL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MYk6xHX+bOcO5Ox1RTE19VuklJ+xeWIGeK5mXs4pd7E=; b=JTtxtfILNW+EbUVOugntreeTA4
	SO2zOvqxiZzXUDD/JU0XGCKdEh5Urj54GGdODou9pgqWaEpWtflhcLqx3wZxmF5zfqwdo0/GOheWG
	3QzGDI3DUTWYWuk8sIhRQWVYX+PKG8XeoqlctrjQvbv0NSyXjBSNeOjOqNUHzPLRoE3i603DVQRHO
	pm5uN1Sr0fTRfMKoSRL1yb0PkuIDwBHYHat2hTowK4IKczQwIKHdnXyXgQBMesEUjCkUAqJerm+Xt
	oPg5r+zkBQjMGzhHl7U8v7+oznJSxsJWulUFiaIE/Ey/BSIazYwue4NFSijt67cFAW52aB/22/7US
	DnBTgFeQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59674)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w3cJL-000000006G8-1ghF;
	Fri, 20 Mar 2026 16:02:55 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w3cJK-000000000wS-08Pq;
	Fri, 20 Mar 2026 16:02:54 +0000
Date: Fri, 20 Mar 2026 16:02:53 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bae Yeonju <iwasbaeyz@gmail.com>, stable <stable@kernel.org>,
	Kees Cook <kees@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] adfs: validate nzones in adfs_read_map()
Message-ID: <ab1vrTs2k6Q9_lsy@shell.armlinux.org.uk>
References: <2026032055-abstain-ending-6acc@gregkh>
 <ab1bmzFTIGB2o-zO@shell.armlinux.org.uk>
 <2026032021-renewable-control-9c81@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026032021-renewable-control-9c81@gregkh>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Mar 20, 2026 at 04:05:03PM +0100, Greg Kroah-Hartman wrote:
> But then why is this check also needed?  I'm all for moving it
> elsewhere, Bae has the reproducer, they can check if moving it fixes
> their issue or not.

There are two variants of the disc format.

adfs_validate_bblk() which is used for hard disc formats where the
number of zones is greater than zero, and ADFS F format on floppy
disks which should have four zones.) This doesn't validate the
number of zones, but it should - and this is where it should be
added, not in the map reading code.

The other uses adfs_validate_dr0(), which is for the ADFS E floppy
format images. This already validates that the number of zones is
equal to one.

Reference:
https://www.riscosopen.org/wiki/documentation/show/FileCore%20Overview#laylogic

Only "new map" is supported by adfs under Linux.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
