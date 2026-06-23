Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7957E390229
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 09:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782206274; cv=none; b=BB79NgzWKjyhE3dwiKR9zkpj1aaTHH7jSsF0OGIRd0qJr55nYjE5xk1ntYR0DQ1mYTb3v3ecxoSQqG1m1WWrMwAKSlDI2Yh0qaF5BNp92nrbgsmXcO9893KWN7Q+xSIRj3+ToxKTyim8/aPDLztlRiZi0M7HMFZXmiUTEbrxiDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782206274; c=relaxed/simple;
	bh=68hqvJRe0b0G8mC8GBU0tbaHmNk5LagitKGKWUfOFVg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Cp1W33N0IjqPT3e0OARnX3vbFo5H1zsvdcAQ9JEhXkiq82kLlsmqKdPWJzKIT+xmN+6VoG+F8RDnPBDaemnDr3s9KeFjiFUx/1wROuYPdmkohSs3longeWVeswwF5csP/msRp7Mv/wHOVMryJx3vLHaGnEGYXsCayIApYCGqfiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=H0awtLiZ; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="H0awtLiZ"
X-KPN-MessageId: 63eea311-6ee4-11f1-8f53-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.190])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 63eea311-6ee4-11f1-8f53-005056992ed3;
	Tue, 23 Jun 2026 11:17:43 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 63ed8ec0-6ee4-11f1-b2ed-0050569977a2;
	Tue, 23 Jun 2026 11:17:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=wcUPaRqlRuUtwva/YFxmTc7tSvauu8oppHHa/H7jJWA=;
	b=H0awtLiZSYmzMJxbaFru1NnIceCsnzHFGhF10Wk7iBdJ69Kt5tHt00Ny1yIdPikFOX7XAgU2qrD1y
	 OEpgJs/iTJxfzURcCWjog8Q/9x5G/FedPoz+wlgNZ4wxVCA8vAxZJniQHoGpQMUAj99I5hAIk4QUho
	 YRu3C3FvldfMq7ZbKP2kSGkzA84Wsnn90xQaWDg/nZkpUlo5YOEmwSv8u0B6LKuuRqvIg2OOpYcuBf
	 03nQUaJiDWGw3Lh4oj0IHkrnzEiLOLbH1UeK5vaa3bheHNQSImpZ7rtJyipqxyVuCHcDrYeKokhsQG
	 h6aqE2ZzHLUoDp8e6/S0K1ixnSZ1CdA==
X-KPN-MID: 33|9DQ9ReohFStdv9edvBGFmOl+Ylv70PWBDn7vZS7Fa7cpq+U93jI8beo+w4qRkx7
 hXtVhtFJdi6OWXEssX5F/QsGkwneKjyb2SVj8iD3qIwY=
X-CMASSUN: 33|ZyDavGSdrfaIFESWo3RmtZjR/fIJQ37vR1iHqAcLRfFK7thKeXqyV6oPm6afgHG
 9IsNezCnf09D13ytdgY2CHQ==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh06 (cpxoxapps-mh06.personalcloud.so.kpn.org [10.128.135.212])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 63da174b-6ee4-11f1-8edb-00505699eff2;
	Tue, 23 Jun 2026 11:17:43 +0200 (CEST)
Date: Tue, 23 Jun 2026 11:17:43 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Matthew Wilcox <willy@infradead.org>
Cc: Pedro Falcato <pfalcato@suse.de>,
	Christian Brauner <christian@brauner.io>,
	linux-fsdevel@vger.kernel.org
Message-ID: <1496529843.2699114.1782206263200@kpc.webmail.kpnmail.nl>
In-Reply-To: <ajhbNJcT8qgqKD70@casper.infradead.org>
References: <20260618211822.3599089-1-willy@infradead.org>
 <ajUIMvi5Nyjp6t2v@lt-jori.localdomain> <ajUSQ30oi-fyh0NH@pedro-suse.lan>
 <2099505714.2289513.1781864378114@kpc.webmail.kpnmail.nl>
 <ajhbNJcT8qgqKD70@casper.infradead.org>
Subject: Re: [PATCH] efs: Remove EFS
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


> Op 21-06-2026 23:44 CEST schreef Matthew Wilcox <willy@infradead.org>:
> 
> > to what degree the arguments used back then apply to all kinda-maintained-but-not-really
> > filesystems. jfs is totally unmaintained, despite its MAINTAINERS file entry. And
> 
> What?  Dave absolutely does maintain it.  Commit 1d51b370a0f8 for
> example.
> 

You're right, I was way too strong in my wording, and I didn't bother to check.
Sorry about that. I just remember trying to merge 2 syzbot fixes for jfs and it
was a frustrating experience to get them merged or rejected. Then again, looking
back at it those were exactly the type of fs corruptions the fs community has
de-prioritized.

> 
> > > We already have one - it's fs/ext2.
> > > (modern API? maybe not so much. still has buffer heads, uses mpage, etc.
> > > alas.)
> > 
> > When I wrote this I was also thinking about ext2, but it is significantly
> > more code. Still, I think you're right. I have a special attachment to fs/minix
> > because it was the first kernel code that I studied in detail :)
> 
> We've had extensive discussions before about converting, eg, ext2 to
> iomap.  Maybe now ext4 has been started, there's finally enough examples
> to get ext2 done.  If you're interested in contributing, that would be a
> great project.

I am definitely interested to get my hands dirty with iomap. I do remember skimming
through the iomap docs, which I found then to be not very helpful, so some examples
would likely be useful. I just saw someone may be willing to do the conversion for
minix too.

That being said, I first want to try to finish O_CREAT|O_DIRECTORY and some other
vfs stuff I've been working on. Also, going to OSS Korea, Recipes, and Plumbers
(maybe give a short talk there), so it's a busy couple on months :)
