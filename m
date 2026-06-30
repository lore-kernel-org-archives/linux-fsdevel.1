Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2FF3ED105
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782830117; cv=none; b=nd8vhVoue12MEiGCSK5cLnRLCIFAeUpYa4DdLsmQdkvvfq563hVgXfk8MBRsXz+bfktn8HshGGiNQf+B+3Amw8O6oXetYVMZPnBPg0pSLAem+SrNW6eJnnZ0KV10Yr+9I32qg+Jlv+MMS5vSNQ6dUbviBL/bPzW+cbUzcBsBKck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782830117; c=relaxed/simple;
	bh=syIFj3dnT+vu8yV67l35OQIk58IffG0GkJCIZ2dSX/Y=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=RYmgtp2G2aSr5Ajo/2q5z63zI9fRh2p4LYvF3mIVwsmQy0bKQV4mwnYd5H7AOa4jY9G1C016g5ZYRcW/5k62HKIJV3ajIHn3VlIY7R8Qjv/OrWDHGz65WrGzvn/KFHCRcUGjvi3Sa35mfUbX/k5nB0IYhtait66xcdM2TWSEoIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=V2RJGhEP; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="V2RJGhEP"
X-KPN-MessageId: e74dc8d3-7490-11f1-9e8e-005056999439
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id e74dc8d3-7490-11f1-9e8e-005056999439;
	Tue, 30 Jun 2026 16:35:13 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id e74a87e9-7490-11f1-ae64-0050569981f5;
	Tue, 30 Jun 2026 16:35:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=TjzXyiXQBaP8cNOqRLIY5/tvFQIkJLfO/ns8OpZQ9Rg=;
	b=V2RJGhEPqE9hl0ErDxfinTx1Yiz4WJr+a9PfTdhX/Xf2KSUHPyZCU1gqt0MOH3TdW30dx0k4avcvK
	 vjwEFZ/SsLjE5FBSRd5qJsKCeLpzbmNd4OHO9JTNpc0pzi8idMSTYEf5J4Mnz5whCHTCESaMk0+Iks
	 XNlNaYiKW3BJyb8ZHCIluwXwrSZ/b1jvGs+qEa120+OB5KpEhqrQbdNUO7wMVtVMMPKNUpz5GMrBjd
	 qCgalF28GMM6TeIiaBcbjGRfx9R7Sik/HrEa7im5fYkTwGVoZN44be6NxKE5e7NA9aHn3mrbRkH5Zm
	 nfs3IOVPGNyrGYV8u/zGnrDaZGutfjw==
X-KPN-MID: 33|Wyxj2yOXeQ9EiNecu55SyyhZt9juzPw7cawEmVJ4k52u+KD7VN8xwPuo+Scx7XD
 1Ei9laQmvKI2CnORN6nUqX80n3sFPfmG/CnLhOW+Cx1s=
X-CMASSUN: 33|uN6Rh33OM6VrmcC9/Nx1kkTdP3nWWB1jh0tU96HEAj8FUq7hC952geOcafvetPR
 c+KdsezALWEStcWfuQl8pyQ==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh05 (cpxoxapps-mh05.personalcloud.so.kpn.org [10.128.135.211])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id e73e677c-7490-11f1-8edb-00505699eff2;
	Tue, 30 Jun 2026 16:35:12 +0200 (CEST)
Date: Tue, 30 Jun 2026 16:35:12 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1957659940.3537950.1782830112890@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260630071701.6b583d1e@kernel.org>
References: <20260629194327.2270798-1-jkoolstra@xs4all.nl>
 <20260629194327.2270798-6-jkoolstra@xs4all.nl>
 <20260630071701.6b583d1e@kernel.org>
Subject: Re: [PATCH net-next v3 5/5] selftest: Add tests for useful handling
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


> Op 30-06-2026 16:17 CEST schreef Jakub Kicinski <kuba@kernel.org>:
> 
>  
> On Mon, 29 Jun 2026 21:43:27 +0200 Jori Koolstra wrote:
> > The test uses the following Smack labels:
> > 
> >    "Sender"   - label for the sending process
> >    "Receiver" - label for the receiving process
> >    "SecretX"   - labels for the files being passed
> 
> Not sure this test belongs in net/
> 99.9% of people running this test do not use Smack.
> At the very least you need to use XFAIL instead of SKIP
> we use skip for problems with the env which are fixable,
> like a command missing.

Ah, right, because you can only use one of these LSMs at a time?
I mean one of AppArmour, SELinux, Smack, TOMOYO.

I just need some LSM to trigger the reject of security_file_receive()
and Smack was the easiest to get going. The series is totally agnostic
to the used LSM. I am fine with moving the tests elsewhere or porting
them to SELinux if that is really necessary. We could also drop them
altogether.

What do you propose?

Thanks,
Jori.
