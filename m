Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.121.94.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795644150;
	b=TNyQobmn7HLbqlfsJQBLviIRbb9euBT+wBtDCNiADLIPAMcieKt+j8kUHNkqn3syKuMR
	 KpkXURnpjyKShm04ET/iXQJ3K1qUa6oWFXBcCQsmRzu0sQ3UA9URFSq1jI1MxzwWI8yhr
	 KBkjCWqj6jUNZMqxGlm7baUCIxE+nmHbKo+8M2hnjUo0lrjTN8CZXasbf+lAKm5XX/7hV
	 ntJDE+wMVgTkg/ZdyKljq5wJwgQXsvBeT4oPFgXBEAimziSCr2Pq8ilvetAPnrEGM3j8e
	 iqZFa4V5cp/D0V6zOBoZ0W2Ff1s6ZD8APSxgl42a1baA2ncM+2IFXKif9WpJZCJjXfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795644150;
	h=DMARC-Filter:X-KPN-MessageId:Received:Received:DKIM-Signature:
	 X-KPN-MID:X-CMASSUN:X-KPN-VerifiedSender:Received:Date:From:To:Cc:
	 Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Priority:Importance:X-Originating-IP;
	bh=c2ucA1euV+R8ODwbxe9jfB2W2c87Tit7wapu+gok7v4=;
	b=5AexOZTR2bogCsdzoDSyx/ZCG9zeqLMlfXeDisusgP5Q5YvxVq1ugiFtxZlHT7hZy4+6
	 SQpREp9h1BKJDYOrlxgTDkYcJm2PQpvlIrntSJo9ipPLYGPDaHYtEshH+kcZ5KRAxNPa0
	 kOTn25x20AXnEFCmV535BkBnKzzMlqj4DJIEVStm+cXN2waDeBjDkG/ZRjDfp2hXRvx10
	 8UCI0b62vr3/uKK9RDbWpd1qeX5lR8lULmbAbOCez+jtivKKGeyWHFG6N0DVNFUb9VJU0
	 mCMdcBkkn6uXVBzNzoA/c+0/jZQQyiZVj2s3OtxEDl6riR1UD6O7QzRoaOuVXF+Xg4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xs4all.nl;
	spf=pass smtp.mailfrom=xs4all.nl;
	dkim=pass header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=b1gOZUTR;
	arc=none smtp.remote-ip=195.121.94.184
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1998606A326
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 22:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1998606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=b1gOZUTR
X-KPN-MessageId: e6c29041-e91b-11f1-98a9-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id e6c29041-e91b-11f1-98a9-005056994fde;
	Wed, 25 Nov 2026 23:02:27 +0100 (CET)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id e6c1659c-e91b-11f1-b795-0050569981f5;
	Wed, 25 Nov 2026 23:02:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=c2ucA1euV+R8ODwbxe9jfB2W2c87Tit7wapu+gok7v4=;
	b=b1gOZUTRmHFRwcwOy+nEip0DmLmqZUXQ8OZiqD7CGmW/i4D+4WCCFJ1yMPI+3xSjpElyfjDxkq6iG
	 IxpfwBxjyK1NLzT05y2RDjX93pUJXXS/bBO0Mx6borBLni8KIF1pHlD63gDGKCR0z4W1gOuNXOFd/l
	 Fwd6rotEFZ+SFwet7FxIOETx5gBzw0GBJrRSjP692oNzzcPHwsAWJ8mW0m38zC7JPOyUlDTtBHneii
	 loyxCp7O7On7NxzSpuZuXI+eNSuOfftWTDRzwEefb3I4e0fWjyPFXM7rergF//ZcidJktWimb0QoVF
	 BeYiR8tD6vCujrNW+vf5w/R7NBcExyA==
X-KPN-MID: 33|Xhr4CeQe8pHfgk3+KrDZf6RvLpQUw+dILX124qCDPdze/VbrZsdLc8dSLVKtRTh
 8iJTUea46Tkwbl65os9vbjIhxA91sk5up0TwQXdS8D30=
X-CMASSUN: 33|g0vKsP9VCv83CvR/FYQAqoRjguJVOUyXSKxFBZV9y44hK12nKxm6f/Uh5SDLNfW
 KMaK4xvFJfIQ6q6sqxprIWw==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh05 (cpxoxapps-mh05.personalcloud.so.kpn.org [10.128.135.211])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id e6b69b89-e91b-11f1-94bb-005056995d6c;
	Wed, 25 Nov 2026 23:02:26 +0100 (CET)
Date: Wed, 25 Nov 2026 23:02:26 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Jens Axboe <axboe@kernel.dk>, Hengyu Liang <hengyul@cs.unc.edu>
Cc: Christian Brauner <brauner@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-ID: <805466896.2784291.1795644146928@kpc.webmail.kpnmail.nl>
In-Reply-To: <86fea5ad-43d5-46d6-b2e5-f93b8a6afb8f@kernel.dk>
References: <20261125180817.3682397-1-hengyul@cs.unc.edu>
 <170898867.2781789.1795642036410@kpc.webmail.kpnmail.nl>
 <86fea5ad-43d5-46d6-b2e5-f93b8a6afb8f@kernel.dk>
Subject: Re: [PATCH] io_uring/openclose: allow an empty path with
 O_EMPTYPATH
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


> Op 25-11-2026 22:47 CET schreef Jens Axboe <axboe@kernel.dk>:
> 
> > 
> > Reviewed-by: Jori Koolstra (CIQ) <jkoolstra@xs4all.nl>
> > 
> > @Jens - You've pulled this already, I don't know if io_uring appreciates reviews
> > after pull. Let me know if not.
> 
> Always appreciate that, the link is in the commit too so it'll be
> discoverable after the fact as well.
> 

All right, good to know ;) .

I know Christian does some magic with pulling in the tags even much later,
but I don't know what he does exactly.

Best,
Jori.
