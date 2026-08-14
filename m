Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AC8486BB4
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 17:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786727493; cv=none; b=QB8nhqghM3UAxOVF2bZ5qusK3Ya5z+Jzgz/HPoWmJTbbuTYngBG1rlC2eiw3pKCf/ldAfiUqZSGpzahqWhWTr5JKf9gM06eXPPfrHNeKWQWZU8sn6NTYYTODCjnUHaK3S1C5JTzgJjuiTnFFlhFfVyOUA5DHlTDOUuNj6ygJ3ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786727493; c=relaxed/simple;
	bh=FhEtj15wjnMeErkkmMqpImECkf4rarJWJJl67l4mdmM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=WdNEKnwlhKyoioEwAU2J0W9xYW01Lg5AdBh4+hNsssn9VVM4zAMBjL/NXAdpN/jSrPpSa7Tl8/PtVq5HNLOTU60ChtzmSCU5s5FM8RxZdRjFMZTnNqtoVsC6Y6gMYnpN/XObEZihRsg9KmMWFP0+mH/2t5SDCWLiTsxBs8mgyUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=kdLs6o5C; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="kdLs6o5C"
X-KPN-MessageId: 06dbf0d1-9803-11f1-a5a2-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.188])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 06dbf0d1-9803-11f1-a5a2-005056994fde;
	Fri, 14 Aug 2026 19:10:19 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 06dad6fb-9803-11f1-ac0a-00505699693e;
	Fri, 14 Aug 2026 19:10:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=AzP2lR0vTf8TmxPBEWtjcvGIt6IQe1WpxGHRhjuSXkk=;
	b=kdLs6o5CX9yOjFKHoR/yN8rhBgqhK9w0WQfhRKTcZ17OeBKzaSbwInElVWDrhIXigWIdkNPWzEfvL
	 voyQg8bRVn9IbRV5WUiynisxgzHZns6Ypskbi81Z2LiQZeTMAdS9pGXJnzlcAm1my5AYITYJ4+gJFt
	 vljfixpK4Bx6q06mczb2BAYlgQt6t2ZvQok1jZ4cr2UHdZ8bYkDtPcvqnGN6X2XMWkMZq78C0hzfHd
	 gfYHemR29kDRfFzqLefCRc2R33GSDAWKiDh7JNKRRPP7+7P7DAQxe1/EybzqMYog5Hiv8sN16BGCPG
	 J10Ul+efteYLFrFTbGUFO5J1bXZfH4w==
X-KPN-MID: 33|VX9fPnJFxnxchsqyrKvMP7wq8iM3Sc0nmBKB+IjQGnv/ES9inkdiDRFvmNEOBg2
 A5sUlGR1+iPwuske83kQfGDANnNQS/zChZzLunVM9fbs=
X-CMASSUN: 33|EhVoIpc83iWIixecPhQtDljQWoDQSz/BVE6+GddXAM0yXB6ClUZrMMptLNEr8s9
 wNGXUD/5SX7xyZY6SXg+v8w==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh03 (cpxoxapps-mh03.personalcloud.so.kpn.org [10.128.135.209])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 06cd2fd7-9803-11f1-916a-005056995d6c;
	Fri, 14 Aug 2026 19:10:19 +0200 (CEST)
Date: Fri, 14 Aug 2026 19:10:19 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Jakub Kicinski <kuba@kernel.org>
Cc: brauner@kernel.org, cyphar@cyphar.com, kuniyu@google.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <68018741.501644.1786727419159@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260814095511.4e302a24@kernel.org>
References: <20260814121131.151003-1-jkoolstra@xs4all.nl>
 <20260814095511.4e302a24@kernel.org>
Subject: Re: [PATCH net-next v7 4/4] selftest: Add tests for useful handling
 of LSM denials on SCM_RIGHTS
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


> Op 14-08-2026 12:55 EDT schreef Jakub Kicinski <kuba@kernel.org>:
> 
>  
> On Fri, 14 Aug 2026 08:11:31 -0400 Jori Koolstra wrote:
> > Tests SCM_RIGHTS fd passing on a socket with the new socket option
> > SO_RIGHTS_NOTRUNC turned on. To hook into the security_file_receive()
> > call, BPF is used. The BPF program shares a hashmap with userspace that
> > lists the inos to be blocked (of the receiver tgid).
> 
> Sigh. You are ccing netdev@ only on the selftest.
> I think that this is a clear indication that the selftest 
> does not belong under tools/testing/selftests/net

Oh no it absolutely should and this series has gone through several iterations
at this point through the netdev list.

Sorry about this, I am abroad and my email provider apparently has some ridiculous
rate limiting for foreign IPs, so I sent the series and only the first 3 got through.[1]
I contacted them and they basically said "screw you." I wanted to attach this message to
the other ones, but apparently that didn't go as intended.

Can this be taken like this, or does it screw with the CI? Basically it was some
minor fixes and everything has been reviewed by Brauner and Iwashima already.

Thanks,
Jori.

[1]: https://lore.kernel.org/linux-fsdevel/1036785927.390839.1786639504241@kpc.webmail.kpnmail.nl/T/#m4faa7ec5fea0e075b3db9113fa3d9faf7e2cd1d6
