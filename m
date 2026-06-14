Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358DF29B79B
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 19:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781464308; cv=none; b=W/3mpgPa6j9zI1jLi7HGcvCyCcM+Z8ai9jzaHkz8rLvdkk0wSzxN7cot/mTY3fwCiQj0wH2VJU8QXfZmo32Hpz1zNm62cUZfpzJPJleJsjXLg6k17Y8wI/mhU8iJGZ6kUMnoCWO8hhX3HpGhqP3w6OyKkgNQePny8Khkh9aYeo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781464308; c=relaxed/simple;
	bh=5tRAuwQpQzPxD6LlMUIIY/+3vXf1oTUI4btsPXnh5Ao=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Nx6Jgrr1+/y/JPAuwNpX1fztAMl10jrNOMffrANisg7ZbZJkCRkZOA577PZ2/6E5Z+OuH3Lfvp2ISIKh2QWVYOEXZOaWq/6AIKWb+U21e28difxDU22HieooaXbxfE1SKdKhjUNStmS6UoDkN8IOe0bebAV3ONReWA0wj2FQFHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=DSThIGYI; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="DSThIGYI"
X-KPN-MessageId: e29642ab-6824-11f1-beab-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.188])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id e29642ab-6824-11f1-beab-005056992ed3;
	Sun, 14 Jun 2026 21:11:45 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id e2955602-6824-11f1-8109-00505699693e;
	Sun, 14 Jun 2026 21:11:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=FetkUx96ove500HaBIidvjUavwl1SqIMwWuyCZ8ni/4=;
	b=DSThIGYIXoCDqjKlzgeMqtONzpG432GQRFrLDyKn/eueh8tM2XCiOFBh6UyaHErZ7NpkV7MJ5orkG
	 EqZf3+IYWDfP4SJ9wU5jfnp8guIlPb7zWssll90+p+su7m/hTvTy1rGf80LW0NczTdpNrBFz9sFACi
	 tfXjITy1y1Dx9MWhCGj/oxY9IyIKdBLlyBrdapxNtz/UWl9MvgN1x/LY0kS/Q67s5wk/Sec99b+5Il
	 ORvauWEevQTg2FMWUOmaKTllRs3RGeVufmodmX9v4baLHDNfJBIgmkQpLh1c0H8zMzWzJn5iZbm1Nn
	 2NjtmFUE5Z/YVByyYk/O+KmNRhPcjVQ==
X-KPN-MID: 33|E8sVt6v3mcESm/XweoNzqIeT3JfJJWHnAsFhLWaok4PbU5t2H4pCmMTvi53CsxF
 GIlcfMnrU5XUUHkAhpyyh/FL1e4uNEKCl72xB6T6Nur0=
X-CMASSUN: 33|hDkvNZUYM/zXGExdijtBDhbps+J79MleGou9V/sha+aC8ZcCEMZrEciDfUUmLxm
 zdcUR6dIxWNR6hnqQ6UY17A==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh07 (cpxoxapps-mh07.personalcloud.so.kpn.org [10.128.135.213])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id e28ac8a5-6824-11f1-94b1-00505699eff2;
	Sun, 14 Jun 2026 21:11:45 +0200 (CEST)
Date: Sun, 14 Jun 2026 21:11:45 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Hans de Goede <hans@hansg.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Message-ID: <198160170.1699942.1781464305401@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260614191040.3007723-1-jkoolstra@xs4all.nl>
References: <20260614191040.3007723-1-jkoolstra@xs4all.nl>
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


> Op 14-06-2026 21:10 CEST schreef Jori Koolstra <jkoolstra@xs4all.nl>:
> 
>  
> I talked to Hans de Goede about two weeks ago in person. He expressed he
> would rather have someone else maintain vboxsf and was thinking about
> orphaning it. Since I am already doing filesystem stuff anyway, I am
> fine with doing this. (vboxsf is a thin layer between the vfs and the
> Virtual Box guest device driver).
> 
> I have no major plans for vboxsf, but I do want to support passing
> physical addresses to the host; the communication protocol seems to
> allow for it and it would mean we can get rid of some kmap calls.
> 
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c8d4b913f26c..0b75202eb9c6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -28390,7 +28390,7 @@ F:	include/linux/vbox_utils.h
>  F:	include/uapi/linux/vbox*.h
>  
>  VIRTUAL BOX SHARED FOLDER VFS DRIVER
> -M:	Hans de Goede <hansg@kernel.org>
> +M:	Jori Koolstra <jkoolstra@xs4all.nl>
>  L:	linux-fsdevel@vger.kernel.org
>  S:	Maintained
>  F:	fs/vboxsf/*
> -- 
> 2.54.0

Forgot to cc this to linux-fsdevel@vger.kernel.org, my apologies.
