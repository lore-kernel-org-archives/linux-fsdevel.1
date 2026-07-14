Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B473A3624B8
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 10:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784026215; cv=none; b=kHHW2Tju2YjOrIwKDIIGlPQS9MHGejW+Os5Q9QTupuQRksgkLTm1m2/cY/kaaPLzmG/Bfqcr6Fw1YCuPTuwJ5k13oXEsy+wE3/1Fn4xXsMpAfkOfgyELSxSQ8fGc99VRwsoflJB6n7mzznm8UJLklQc4EJfw/cPPqo5gWMjFcIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784026215; c=relaxed/simple;
	bh=6d7j9WQ38H+pPZbQN4typtv0yHwZo4JRLgUj3IOapWM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=FAfWCRzuFi5M38LB0NDPd0Vnjk0G8ufhKfPOacwkGJrHstacarTe3n6f73YgWlMLGfKopEThgBbeJWPy+RnuRMxpQ8BCT9zboIAFck5qobZ4st13o0+A7Kts4ckOofM3ojhtCC7fgqZAkZq+N7QFC39P/pnHL+vnymsLjZA3VTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=epzIkf/B; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="epzIkf/B"
X-KPN-MessageId: c9767c2c-7f71-11f1-bfba-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id c9767c2c-7f71-11f1-bfba-00505699b430;
	Tue, 14 Jul 2026 12:50:11 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id c9751462-7f71-11f1-ae77-0050569981f5;
	Tue, 14 Jul 2026 12:50:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=KtB/UCjk7km11pGYlr3+yQzXuQmAKvvh7pn1+4FUtMY=;
	b=epzIkf/Bf0ZF6dFGn9TEgRwV5JX5kaQf/XhzuHM4UodF4PJc2PxgTQKydXL7kVzH459Bl3A7jjHKr
	 B1TFvwrIQgbYATG1sv6+eD7QdAHPYiI8AZP0tzXd5nsD+AtIjl1HLeGxDFcVTuezHy9msUWZvACYZ7
	 +Z4HHM05Um8CDoG/TwD/fjnKBxviEBWgbYISwVIT1F7mxN9BaHmZiDtsjfg08+qi1chuunfNIuUAYz
	 A4RCurWiaci90Ld4K9f2JEP9vaG5U6f2BwVzqzOLqjhBn7QfwA6VPLD2AyLzI076/6B68WiBWd/h0N
	 mXOR2I2gLiN+3H1Z9yBhShoHSrBWp/Q==
X-KPN-MID: 33|ceBqH3w4AqMFht8G4vk8kQZcyRUcIKOW9xnaJkiP4cwAvh3YZe9s3Lq5uaVggq+
 cRflemM7YL+LdCNIcvdceEKf0if/ktWfZxCCldNhUiaY=
X-CMASSUN: 33|2QoMjFSyCv2rGjr7ZEkhaApN1A7J8oGVPuctfxGz4AgD5d74gCWWSsoXLwZr1ij
 Tb3WMNUASnTh6D/TF/B1Ccw==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh03 (cpxoxapps-mh03.personalcloud.so.kpn.org [10.128.135.209])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id c9693498-7f71-11f1-8edb-00505699eff2;
	Tue, 14 Jul 2026 12:50:11 +0200 (CEST)
Date: Tue, 14 Jul 2026 12:50:11 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christoph Hellwig <hch@infradead.org>, NeilBrown <neil@brown.name>,
	Aleksa Sarai <aleksa@amutable.com>
Cc: Christian Brauner <brauner@kernel.org>, Pedro Falcato <pfalcato@suse.de>,
	Jeff Layton <jlayton@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <885328508.965342.1784026211216@kpc.webmail.kpnmail.nl>
In-Reply-To: <alXE3cOXcJm-uDNs@infradead.org>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
 <20260704164149.3480051-10-jkoolstra@xs4all.nl>
 <akyyqnv9EpY7xVdC@pedro-suse.lan>
 <20260707-vorteil-unhaltbar-apotheke-47bb105161ff@brauner>
 <alS10NN_OduZEqvt@infradead.org>
 <178397852844.3371781.6900199568039042534@noble.neil.brown.name>
 <alXE3cOXcJm-uDNs@infradead.org>
Subject: Re: [PATCH v3 09/14] vfs: add O_CREAT|O_DIRECTORY to open*(2)
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


> Op 14-07-2026 07:10 CEST schreef Christoph Hellwig <hch@infradead.org>:
> 
>  
> On Tue, Jul 14, 2026 at 07:35:28AM +1000, NeilBrown wrote:
> > So let's add OPENAT2_NEW_COMBINATION which instructs openat2() to reject
> > unrecognised combinations.  Old kernels will simply reject that.
> > New kernels can start using previously unsupported combinations safely.
> 
> Yes.  Also the name OPENAT2_NEW_COMBINATION feels a bit clunky :)
> 
> > Maybe OPENAT2_NEW_COMBINATION could just reject *everything* at first,
> > then incrementally allow new combinations as they are defined.
> 
> Yes, absolutely.

If we really want this we could add a flag to openat2(2) OPENAT2_FLAG_TEST
which just returns success if whatever other flags are passed in can be
combined or -EINVAL otherwise.

@Aleksa: if you are reading along, what do you think?
