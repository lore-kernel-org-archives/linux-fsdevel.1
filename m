Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42C248F839;
	Fri, 14 Aug 2026 16:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786726516; cv=none; b=lonTfnMmMeJfg5PlUCmLFQJOgw3Mjxqs+yhjgypvgzCgxdAMybcFoBjCESPGdC6bqxU52z9jCMN0SvTWBGWlBKNtA/F8iyGokjPBTyxW3vYQUhmzGMjYevHAQodM5e09y7x1/CVOePZRkUWSZu9DekQbwnecbnUGqBON8gj3a4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786726516; c=relaxed/simple;
	bh=M/nUPqt3mVStzqA3t7XKf7BpNBWAWd7hxhBTVWH5W08=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dkaYd/Lau11atvg6GPqTSZvziwlw+Tn8QIcGMezX8Jepxj5mfoD8GfBU5KCiBktKo8L5JyS5HrJorO93YIIzeNaPdFOlxKlkWcW1btGTY62rALYY8ef9WI3KfN40qpnO0YH9aHkYODIxcIP0nlIm7Npb6vsFhE0aSnTwYRjKNZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/DMFqA5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/DMFqA5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9E11F00A3A;
	Fri, 14 Aug 2026 16:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786726512;
	bh=efaV6qX/Sek/q8NVtS2XtI0j8O57WZtSQvk1688VpgE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=U/DMFqA5B6ASMoYSHXlp9/H8OE/r17sAUPnZ2XbIpFi6jf3RFq/z23iQyoDzexZx/
	 HFghsQqz1GQ0XbBjPnQEUYzzkaAYpWk3oZoSrA/drpYHwCyDlzxM9gGn6JFDYEZGDj
	 yUZqmie6UKCUmSDFuGsVBmXs3qnvupwacqIKGmoGgriszcMEcl41sjWZHxutqzTQGo
	 V6fp+ACcUl2UGWSuL8rCPEdkI4pJgRuABtub4FpILN2hpcHIGyUPLyqZ0dCzfi51lD
	 0uPlQpqDi+xsO4Qo3QO+5joaxrILowcyU175hCDammtf9TmL66cuyuFS3FE375eDxz
	 3XXlKlR9d1mBg==
Date: Fri, 14 Aug 2026 09:55:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: brauner@kernel.org, cyphar@cyphar.com, kuniyu@google.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 4/4] selftest: Add tests for useful handling
 of LSM denials on SCM_RIGHTS
Message-ID: <20260814095511.4e302a24@kernel.org>
In-Reply-To: <20260814121131.151003-1-jkoolstra@xs4all.nl>
References: <20260814121131.151003-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Aug 2026 08:11:31 -0400 Jori Koolstra wrote:
> Tests SCM_RIGHTS fd passing on a socket with the new socket option
> SO_RIGHTS_NOTRUNC turned on. To hook into the security_file_receive()
> call, BPF is used. The BPF program shares a hashmap with userspace that
> lists the inos to be blocked (of the receiver tgid).

Sigh. You are ccing netdev@ only on the selftest.
I think that this is a clear indication that the selftest 
does not belong under tools/testing/selftests/net
