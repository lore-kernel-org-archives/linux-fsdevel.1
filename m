Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3B73655CB
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2026 09:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781861787; cv=none; b=OEU1bFUSoVc51Nufxvj56pcYMo7IEuZnEHITDnNA2NUe0iHY3es3DJjmMzggYdvwvaXjgSlguPJVvErmRmMvXkETKRLhSs61SBRY5YOiGAsNH7suaVzKhCJZCDEyLljuXAKRkpcYn09BtX7VDTOXccny5WyS8rpJT3hBuDR+QOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781861787; c=relaxed/simple;
	bh=dLw0jP0T+p6J/04ZcK5m7P0N4MPtuz997gX9m+ifT/c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=KK9tQ+MY81w4zKfCmpF4SumnsDt6Y4SgzkA5P//9hK5FPXG4ZvAUVS1wx06O4dQ5bjcBhPtf2wW+Gv/Z6SvPj5IQMExD+9XDolRPz59yVg/LBtV7+tyuSXupW1QPlQJPJO4dwemWWDoWB6+oC8wxSGegcN2qmCJ8nimeNUmlcew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=IEHX9pRe; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="IEHX9pRe"
X-KPN-MessageId: 52a15775-6bc2-11f1-a59f-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.190])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 52a15775-6bc2-11f1-a59f-005056994fde;
	Fri, 19 Jun 2026 11:36:17 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 52a04fe6-6bc2-11f1-b2ea-0050569977a2;
	Fri, 19 Jun 2026 11:36:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=KibVJ5LuoBcA/qEB56SUrJpOMsCf0W74wuOLa9cal7E=;
	b=IEHX9pReCJRwByBHukYn2+Nw19h38uP5mzOxEimPCbDEIASAxDKITG1DG9jKMR3sYzli2oR/FeOy6
	 BDy2d6MJE2rtX5emQjMIsUIn4iZ1QXXrwD1uIyuCHNAnTq1TjEjOpEGgqBxS6XUmPVkEi/dK3sGUVx
	 YBW+g4OziPdhiLEws6Ul1KYjkVCxjZqr9HrqnPGDWNgA0K4czimp9APDocdzISxvxeDS4cBdCXZ7lk
	 NLigZ7g2kJ1IVZCZfThEKHiki10tYhXERg2760IRhBPf1eINK1F73UJE+JoV6++8GWENiPvC4x+KtV
	 54IsMHRN/mPdvFtHH4beMf5UqPEnsvA==
X-KPN-MID: 33|JxvJALUcdjQuozS6QUv8MKSn3MffWTZsbaBeNfPx2XLCgjTgZspzdweK1BP9TSn
 AaMr6I0Lg4VLunN3cY/SUMk4S42WxYg8e6+gf/j/7H9A=
X-CMASSUN: 33|u8rXP72L1Y3OsrsCi3RQxJIm7HFGyRfcPuu7ac2yQ3Qo2h8cVv21LOnoZmFq72B
 iZOW6sgh9SsdMLmsiKD/P8Q==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh05 (cpxoxapps-mh05.personalcloud.so.kpn.org [10.128.135.211])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 5290dc5c-6bc2-11f1-8edb-00505699eff2;
	Fri, 19 Jun 2026 11:36:17 +0200 (CEST)
Date: Fri, 19 Jun 2026 11:36:17 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Hans de Goede <hans@hansg.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Message-ID: <2123052165.2290469.1781861777821@kpc.webmail.kpnmail.nl>
In-Reply-To: <ai8M2PK5vH7FPj3d@casper.infradead.org>
References: <20260614191040.3007723-1-jkoolstra@xs4all.nl>
 <198160170.1699942.1781464305401@kpc.webmail.kpnmail.nl>
 <ai8M2PK5vH7FPj3d@casper.infradead.org>
Subject: Re: MAINTAINERS: take over vboxsf from Hans de Goede
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


> Op 14-06-2026 22:19 CEST schreef Matthew Wilcox <willy@infradead.org>:
> 
>  
> On Sun, Jun 14, 2026 at 09:11:45PM +0200, Jori Koolstra wrote:
> > > Op 14-06-2026 21:10 CEST schreef Jori Koolstra <jkoolstra@xs4all.nl>:
> > > I have no major plans for vboxsf, but I do want to support passing
> > > physical addresses to the host; the communication protocol seems to
> > > allow for it and it would mean we can get rid of some kmap calls.
> 
> I would love that.  I looked at doing it when I did e300830fcc40
> (convert to writepages), but it was a little beyond me.  I really didn't
> want to try to do it without having a way to test it.

I have a Windows and Linux box with VBox installed, and I have created a
simple Alpine bootstrapper on which to run basic tests within VBox. I use
the vboxsf to move the host compiled modules to the guest (the driver and
vboxsf itself). I still have to think a bit if there is any reasonable
automated way to run tests on the guest side. xfstests probably aren't 
very suitable here, because we don't control how VBox itself responds to
incoming requests. But maybe it has some sub-collection that will run. I
have to look into that.

> 
> Any chance you could also add large folio support?  I don't think it
> should be much extra work once you've done physical address support.

Yes, I'll look into that as well. If I have any memory related questions
can I ask you?

Thanks!
Jori.
