Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1C430567F;
	Sun, 14 Jun 2026 20:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781468394; cv=none; b=ii7bosfXQ/TbKoziNLvxPsF6izgZwUY6e1IsiQRtRtOH0dhN/6YqAGYfs+QYVFgFtQ6yqDZeujoZa3BFxKoNMywy6bkRW7MBpQEEAhEP2NVG3K6JJchZVm/c4XfAt5bZGMpD4YsjVqTiiCRZV8IAk6U28TpmywI385hhDOHVJbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781468394; c=relaxed/simple;
	bh=IF7IcIdW2iU0HAWainJnzzMQCj3e9FXQQ6pmdtqFHpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5CzEJbgBdOFMPxeJxP9uCc+BsFiN/ujls4pzbaoGx2yzQK+RS6szXDOm6a7wko+y7ftwAvfyHwQDTaiLc/dE2lcIlrt1IcI34Kv4wwvjJcvOg/kip7WpwBGjRgfp6ZFR56qV7fdNmQ0pJdPukGgvPOFX8jQCDMQ7/M86S99/Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DKkIiY1j; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DKkIiY1j"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cgJok8Id0xUqnOeKyobSoTNQmZ6AspFok40mF44jVJs=; b=DKkIiY1jNpGaJSmiRZ7rpHXHHb
	W8CaPS/nlt/SgZyulQLNx2clCPOFnBrmAWPyTHr4QSYhuZTPORAXXl5DUtvdpGiEdBKpJWV3g9/ZB
	iAUad6Ces0XQGRL5IylyXTyHM6r2tvKGYjh4Pcwlsim9b58fZm1+6Ji7+BGJRZwHWrofCS9Mp8AzH
	QGn5Y8vxF75d2MUpoDZWTVsIG0JPPVJDtiwWOAayU2+/izRJDDZDj3fyVz/yrkmWyqKde2AVB2YYH
	QnpLvbmfaJkzEtoAcMDrP7qo2CAEVHObtzoVBuu7wNqOztUxmwhe2Rp1Rl0pVNuyo0pHuzImtmXXN
	MoyJyFMA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYrIu-00000007atd-45UU;
	Sun, 14 Jun 2026 20:19:37 +0000
Date: Sun, 14 Jun 2026 21:19:36 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Hans de Goede <hans@hansg.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: MAINTAINERS: take over vboxsf from Hans de Goede
Message-ID: <ai8M2PK5vH7FPj3d@casper.infradead.org>
References: <20260614191040.3007723-1-jkoolstra@xs4all.nl>
 <198160170.1699942.1781464305401@kpc.webmail.kpnmail.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <198160170.1699942.1781464305401@kpc.webmail.kpnmail.nl>

On Sun, Jun 14, 2026 at 09:11:45PM +0200, Jori Koolstra wrote:
> > Op 14-06-2026 21:10 CEST schreef Jori Koolstra <jkoolstra@xs4all.nl>:
> > I have no major plans for vboxsf, but I do want to support passing
> > physical addresses to the host; the communication protocol seems to
> > allow for it and it would mean we can get rid of some kmap calls.

I would love that.  I looked at doing it when I did e300830fcc40
(convert to writepages), but it was a little beyond me.  I really didn't
want to try to do it without having a way to test it.

Any chance you could also add large folio support?  I don't think it
should be much extra work once you've done physical address support.
