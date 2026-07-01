Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6600824DCF6
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782898280; cv=none; b=kv5JB09OZOLvOYKjjfcWcydxIOZ2pERwm4oAQjNlknTupzRWJ8dLy5K+3dURr90PbCxC2K8TwL+xmMkDEgHZ73VM6G+aurp+Ur1OBOkvZOoGlG+aItl7S5JosDmZGjx4/yFIzqJTaHts+V3wNfqlP2IEIHwRRtJqJHnQiMlW+60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782898280; c=relaxed/simple;
	bh=4Bu7DWsBxSyx4e2vtkSpxLp0Q2Am/sM8AG1rEg2Y6dM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=cmT+188tYWl9zpywUB/2EgeBE2IlZAKj2UwfhV0qJieNTwVPL0WaofZHY9ssbsC5fqC/SZLW9B/hi1YJYFsyw1vABcZ9LySZGR+1S+lW7SWY97oLztQbiPId4og4cll+eK3v0brn5JkS1VBvbBzjFq72wwL4lXHnP4d8ihUBTjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=AQ9ucjkA; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="AQ9ucjkA"
X-KPN-MessageId: 984a675c-752f-11f1-8f53-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 984a675c-752f-11f1-8f53-005056992ed3;
	Wed, 01 Jul 2026 11:31:10 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 98490546-752f-11f1-91ab-00505699891e;
	Wed, 01 Jul 2026 11:31:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=tLwus2Z9SHB/2dEYbgbr6ka8rzE4SPYBz1p950DKNCA=;
	b=AQ9ucjkAD1nktGKQ4PEH183hlPxzCOwAXO9wSPpjRdEnfmyUCUcqHNxY+wsh03QmRhSXB+S142nyE
	 cidac8MBYPx0JBfImz1P5qQZCAwklY5w88TkDZHS7n21cD5EZTXT1i8kJrADObWP1F4TTTnJe+PhCb
	 DJ4TNg9nq48eZ7frva5jsbe5wcD+4w0qZNYv9ymNdJtgJmLHDCk2sQ2fOAwRi7kHNdQwWHh7aIm8Cm
	 km/hteWZvcQYMKg9a+YsW5n9y3SwEeJreSUL0dTpkgzBJwPWIWobvP9QiF+7CqzVKdpZEUH5C+2ERZ
	 KwQTU8VPWvsD2rUBlcfeKT1O8fvu6Kw==
X-KPN-MID: 33|YUU32CqV37goJ+ohMNXmFuus5fLBFklWXleDZmHWBhHrO3iY8e3T+7N7VuO0xrm
 pE+pIkbmk9XO7h2+2/heGhrbD1vqvRN2DvyWSPFdPdrA=
X-CMASSUN: 33|kv2oYt4LwQtno3a++u2D/ia5PC6BC0vMT133ArgPoj5L5wUohptDWdnl3ZwTI9k
 FhwAlzTjvakaAqQSCsQZ82g==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh07 (cpxoxapps-mh07.personalcloud.so.kpn.org [10.128.135.213])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 983c0ba5-752f-11f1-916a-005056995d6c;
	Wed, 01 Jul 2026 11:31:10 +0200 (CEST)
Date: Wed, 1 Jul 2026 11:31:10 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <66991303.3605710.1782898270313@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260701-malen-gutmachen-stengel-2c70ad5d2971@brauner>
References: <20260629194327.2270798-1-jkoolstra@xs4all.nl>
 <20260629194327.2270798-6-jkoolstra@xs4all.nl>
 <20260630071701.6b583d1e@kernel.org>
 <1957659940.3537950.1782830112890@kpc.webmail.kpnmail.nl>
 <20260701-malen-gutmachen-stengel-2c70ad5d2971@brauner>
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


> Op 01-07-2026 09:38 CEST schreef Christian Brauner <brauner@kernel.org>:
> 
> > 
> > I just need some LSM to trigger the reject of security_file_receive()
> > and Smack was the easiest to get going. The series is totally agnostic
> > to the used LSM. I am fine with moving the tests elsewhere or porting
> > them to SELinux if that is really necessary. We could also drop them
> > altogether.
> > 
> > What do you propose?
> 
> I'm pretty sure the easiest will be to use a tiny bpf program to reject
> security_file_receive().

Ah. Well, that's a testament to how much there's still to learn for me. 
I didn't even know that bpf could hook into LSM calls :)
