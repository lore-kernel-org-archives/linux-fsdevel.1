Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893203624AB
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777569225; cv=none; b=mfOuovWkMS93573yO+0yx3prgCUQhnJmVQh5ZyBRAQjH0aIU31hJOfR2T140QAYq8YM9nMLqk6UmGDf0Qnl201LMSTWCKEXvDHJeaZ2v7rViVqJ25SMBsnJ6HCEi9V7CtRiyAS2lViKH94Y7ktNpO2+xSXu+NFRbq5/BLpT54b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777569225; c=relaxed/simple;
	bh=u9igQu7L4jttEwgevjC7layK3UABUkK2r0IbPGG3omM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tOnwoQRvrlvqc2TLyATsbJYiaf/ZFlb7lMqKjsOQxsxPd9Pmui3J5rDxXEcvGjCfRqrtAbHTBe3soa+BwLSnAzqImdTHa9EhBByzLZEbv4FdWXUOuyCdeuacDdQQa7nnqbwOjMXCvfSQLw05vWTeAJ7kNCe6ltEAJ1t50VCVkSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 6298A1D459;
	Thu, 30 Apr 2026 17:13:42 +0000 (UTC)
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id AGlKBcaN82mWAAYA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Thu, 30 Apr 2026 17:13:42 +0000
Message-ID: <adf3e3cb-3990-4026-9144-61d8dc168054@dev.snart.me>
Date: Fri, 1 May 2026 02:13:38 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] exfat: use upcase_ptable and upcase_range_info to
 reduce memory footprint
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20260428235038.93816-1-dxdt@dev.snart.me>
 <20260428235038.93816-3-dxdt@dev.snart.me>
 <PUZPR04MB6316657C9EB764F8A3A119AB81352@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <79b70927-e766-4487-bbda-2481288a0f31@dev.snart.me>
 <PUZPR04MB63163EE1D4CAB693180948A581352@PUZPR04MB6316.apcprd04.prod.outlook.com>
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
In-Reply-To: <PUZPR04MB63163EE1D4CAB693180948A581352@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/30/26 20:48, Yuezhang.Mo@sony.com wrote:
> What I mean is that if the subsequent operations fail, such as
> exfat_cache_init() returning an error, exfat_free_default_upcase_ptable()
> needs to be called to release default_upcase_ptable.
Oh, you're right. Totally missed that. Thank you for being patient and
clearing that out. Disaster averted.

>
>> exfat_populate_upcase_ptable() as a separate function to use it on my
>> test cases. The compiler inlines the function anyway(although
>> appropriate attributes are missing in the original patch, my bad) so
>> there's no ELF overhead either. I'd like to leave it as it is, if that's
>> okay.
> Your test cases are only for the current development phase and will not
> be needed later, right?
>
> If not, keeping it is fine. Otherwise, we should try to keep the code as
> concise as possible.
I'll just get rid of exfat_init_default_upcase_ptable() and see if I can
just open code it in init_exfat_fs(). That should get rid of the problem
above as well.

Thanks,
Davo
