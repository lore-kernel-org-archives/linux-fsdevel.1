Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD2E370D52;
	Fri, 13 Mar 2026 07:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773388780; cv=none; b=ML1qUDuOtS/F7u7YvJwXt45avvS+Z5vRn7XMmd7LeSeYd94Ab3SJqTskO9Y6YGtRFFwmRBJHVVdNBklpCpCqH6ghcAO9V98eeqgfSvhT7eakZidSLzwOVGa4WdPo2hsKgp6IjjfLKGN5ft4jvWhMoyMu/eZwlpyeQ1397WohvpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773388780; c=relaxed/simple;
	bh=oW9f38Qw78fkugs9oryUq3up4CW8os8vAaN4KWEerFM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PkiGf1WVgMgVOvyqnMANwKqjJ0gOEBPAvQVoM9icmCYS38Zm7SySjmdo0usOyilQv82d+RnAVIdeHi1JXb1wl+kn/njg5JPWNiCkz+i7rEZg5Tajrw00vIeC8/LkGR6mOW1Kl0IRBnVwYKgfBRr5q1d1NnfdRxq21qI+8vYqzRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=jf6ktrJF; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="jf6ktrJF"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id A14DE1CBC0;
	Fri, 13 Mar 2026 07:59:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me A14DE1CBC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1773388771; bh=oW9f38Qw78fkugs9oryUq3up4CW8os8vAaN4KWEerFM=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=jf6ktrJFyk6TDEugjFwagUKF44b/saxnMMS8G4nUlSRAycyc58g8gVT6jdxFYNSLb
	 MnO+cbgSftCa9/7JZrCmtSXsaJ7E9VDXJ3fL2mr2onRGQbH0im5wAan3l/wlzinABf
	 DfB5vPUkUTgmIFJBt03OYZixTaL79fH9V1mRKVLI=
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id QMAZE+LDs2myPwUA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Fri, 13 Mar 2026 07:59:30 +0000
Message-ID: <14dc2f67-7916-4990-b1c4-5d442c5d51fc@dev.snart.me>
Date: Fri, 13 Mar 2026 16:59:27 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: David Timber <dxdt@dev.snart.me>
Subject: Re: [PATCH v3 2/2] exfat: EXFAT_IOC_GET_VALID_DATA ioctl
To: "Darrick J. Wong" <djwong@kernel.org>,
 Matthew Wilcox <willy@infradead.org>
Cc: linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260311222613.2010177-1-dxdt@dev.snart.me>
 <abIxl8XEftpku8yf@casper.infradead.org>
 <b216af63-f65e-4c26-84bc-2693fad0fdf1@dev.snart.me>
 <abLUQECuMuxHNXjZ@casper.infradead.org>
 <20260312150623.GB1742010@frogsfrogsfrogs>
Content-Language: en-US, ko
Autocrypt: addr=dxdt@dev.snart.me; keydata=
 xjMEYmJg1hYJKwYBBAHaRw8BAQdAf5E+ri1XLtjqYbZdHOyc8oS+1/XJ5bSlbx5WHXmVBZzN
 IERhdmlkIFRpbWJlciA8ZHhkdEBkZXYuc25hcnQubWU+wpQEExYKADwWIQQn/Jn96EMUaIoF
 X+T/ldyyrZpWaAUCYmJg1gIbAwULCQgHAgMiAgEGFQoJCAsCBBYCAwECHgcCF4AACgkQ/5Xc
 sq2aVmjJZwD8COjPlUwccrlRvbNQ6f87DWchtYO0o8W2DNRM3RLps0EA/jEhIbRV6AsyC8jr
 30Ut3aJ3/mO/6G4sLj7OvkEEBH0MzjgEYmJg1hIKKwYBBAGXVQEFAQEHQFpgtIgaByv9lIEY
 EmpavMO0pYjtu7TMJynwdnGYkN9LAwEIB8J4BBgWCgAgFiEEJ/yZ/ehDFGiKBV/k/5Xcsq2a
 VmgFAmJiYNYCGwwACgkQ/5Xcsq2aVmhFCwEA0kM9VyYB4bLCM7+SuXUUH+5Ec99Nj4RXxFad
 Key9GuwA/2BZK6bNyrLSfEk2JDRoskqf7OIL0wa6JOD5SrBnMe8E
In-Reply-To: <20260312150623.GB1742010@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/26 00:06, Darrick J. Wong wrote:
> /me wonders if the problem here is that the "unwritten" post-VDL range
> is worse than a regular unwritten range in the sense that you have to
> write zeroes to all the space between the VDL and wherever your write()
> starts, e.g. if the VDL is set to 1G and I pwrite a single byte at 8GB,
> that turns into a 7-billion-x write amplification.
Yes. That's the problem being addressed here.

Again, imho, VDL is NOT a hole. It should be treated differently. VDL is
not required to be aligned to the block/extent/cluster size(holes in
sparse files tend to be albeit not a requirement). You can't punch or
dig holes in exFAT. Using SEEK_*HOLE* to find *VDL* doesn't make any
sense(to me, at least).

thb, I don't really care if the ioctl patch is accepted or not. If
SEEK_HOLE/SEEK_DATA is really what maintainers see fit despite these
deviations, I'd have to honour that decision and bring iomap to exFAT, I
guess. That'd be a lot of work though because it mean will the rework of
the entire exFAT code base. Not saying exFAT doesn't deserve iomap but
that might be a little over my paygrade since there are thousands of
embedded devices already using in-kernel exFAT.

I retract the patches regarding the ioctl. For the time being, the focus
should be on making exFAT and NTFS useable and stable before introducing
ioctls. Sorry for my poor judgement.

Davo

