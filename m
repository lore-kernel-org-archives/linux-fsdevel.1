Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099B037DEAF
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Apr 2026 14:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775484820; cv=none; b=GA7oecwNtcxGhW9jqQScItn6HieTstgeuSPuqXK3TcT9OtPr8EDEDs6KVjfyucMQhmXyJqnC/zqcErwlrCSMnHtT1m12f8FK2xt/K/LL6E6SmzbPs7o7wxYGHR+ra+SPPDDCFEitMmnF9FGee8n6cHQFlSmA5RslQX7fCShiBVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775484820; c=relaxed/simple;
	bh=RO0alQgotlZHmts1jegpCZHepWg3lJbSg6mKOaL2Jsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oQyeNFUmpXYEPd3KBya/9HBbUr8fYjpIeGN35tOEffdtytNigVRQUo0ZX0D+igS7nDMrbkAYrLYuZhre9NxLC/xMTgkwPcLA19WsvYjp8i5Sb8/Ab5J32Iw9faWHu0Jbnt2E0W7lMsBcsRrd3t2QJht//3/PGcu3tpzlnbvszZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=tnmNDgb5; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="tnmNDgb5"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 738331CBC2;
	Mon,  6 Apr 2026 14:13:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me 738331CBC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1775484817; bh=RO0alQgotlZHmts1jegpCZHepWg3lJbSg6mKOaL2Jsc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tnmNDgb5Tk7b+0H3FP6MoU9slVW9Ht8U5oZwH1UFS4H66nFMBocDIjEGzpJ0jHKju
	 219m9M0q7hOzS5yKlHj8Mwacq+HzVRryVpZJmRbqEDi9Z6lptrKemqd91OB33tyjJB
	 28GvNH9WCRtkYCU5g4TjrsBgzytvYWIPA4l9Xbg0=
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id K7GmCZC/02kyaw4A8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Mon, 06 Apr 2026 14:13:36 +0000
Message-ID: <0a90abe1-846c-4ef3-a798-a919792064e4@dev.snart.me>
Date: Mon, 6 Apr 2026 23:13:34 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] exfat: add iomap support
To: Namjae Jeon <linkinjeon@kernel.org>, sj1557.seo@samsung.com,
 yuezhang.mo@sony.com
Cc: linux-fsdevel@vger.kernel.org, anmuxixixi@gmail.com,
 chizhiling@kylinos.cn, hch@lst.de
References: <20260326115045.9525-1-linkinjeon@kernel.org>
 <20260326115045.9525-2-linkinjeon@kernel.org>
From: David Timber <dxdt@dev.snart.me>
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
In-Reply-To: <20260326115045.9525-2-linkinjeon@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/26/26 20:50, Namjae Jeon wrote:
> +int exfat_extend_valid_size(struct inode *inode, loff_t off, bool bsync);

Since exFAT is fully embracing bool from now on, would you consider
refactoring the entire exFAT codebase to using bool where fit to cut
down on stack usage and for better readibility?

int and unsigned char being used as bool in the code copied and pasted
from vfat has been bugging me for a while.
