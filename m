Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3673812FB
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 10:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778754911; cv=none; b=ALEpHsrVmnFnWlFm4RFfI1ux+M9ythq7n65R6GrLnjIi5Ml8IY0pW4F6/I+XrvlSVGN6gptqhBbSGqswQAWQCuBLYmRPkmMTH8bqmtIvfxTvyNscBWd9Px6Iji/BZEwHYfZmBgL3nldGR9igxTB5oHRlhfX8Xi6+XT5QOpqjxZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778754911; c=relaxed/simple;
	bh=NI+7Bou7o+DUd9YJOluyD9Fsi9LcjhphRq5CkXHAn+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mjfCBIjcEVuZjlkprIL3CRJgpYD0ZTi0lc+8b+xyuobT7Ijv8shGuOrL69TXSxj/MtREA1N428Fu2y3AKdp3YxcSR3LqayKn4y9NpUq63t5LSiPozL0pVqPJ1f5QPk5WBTA3dMHTFy879nXxNa+4wne6TQMmC7WAzP0q1MJMCs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id EF64C1D490;
	Thu, 14 May 2026 10:35:00 +0000 (UTC)
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id r9O9JlSlBWrNWgQA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Thu, 14 May 2026 10:35:00 +0000
Message-ID: <71590543-ff2e-4f27-9be4-debc6157eba1@dev.snart.me>
Date: Thu, 14 May 2026 19:34:55 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] exfat: use upcase_ptable and upcase_range_info to
 reduce memory footprint
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@oracle.com>, Jonathan Corbet <corbet@lwn.net>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20260505123144.730782-1-dxdt@dev.snart.me>
 <20260505123144.730782-2-dxdt@dev.snart.me>
 <PUZPR04MB6316AD038BC864209E256243813C2@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <258feba8-a4fd-4c31-9553-691ab375858b@dev.snart.me>
 <PUZPR04MB6316CE26A44D001F933B14B581062@PUZPR04MB6316.apcprd04.prod.outlook.com>
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
In-Reply-To: <PUZPR04MB6316CE26A44D001F933B14B581062@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/14/26 19:04, Yuezhang.Mo@sony.com wrote:
> A single bail label might seem simpler, but it obscures the pairing of
> resource allocation and release. Using multiple goto labels (e.g.,
> `err_free_upcase`, `err_shutdown_cache`), each cleanup operation perfectly
> matches an allocation step, and the reverse order is explicit.
>
> A unified bail approach enforces that each cleanup function can be safely
> called even if the resource was never allocated; while this is currently
> true, future additions of new cleanup functions might overlook this.
I dug further into this rabbit hole.

Turns out, this debate goes way back to early 2000s. A quick LLM prompt
revealed that numberous kernel devs already pointed it out and different
parts of the kernel have their own agenda(especially ARM and Netfilter
devs). I was just rediscovering it. A simple fs like exFAT will probably
never grow that much complexity (hopefully) so it wouldn't make much
difference on this matter.

I'm in no position to demand such changes to exFAT, but I'd be voicing a
different opinions on the projects I maintain. I will report back with
additional error labels in the fill_super() and module init function.

> I understand your point that currently known formatters all use default
> tables, and I agree that in practice, the probability of a non-default
> table unexpectedly matching the default checksum is extremely low, and
> such conflicts are extremely rare. However, theoretically, simply checking 
> `utbl_checksum == EXFAT_DEF_UTBL_CHKSUM`, even with checking
> `tbl_size == EXFAT_NUM_UPCASE * 2`, is not rigorous.
Well, if we really want a rigorous one... I really don't know what we're
trying to prove here, but that I can probably whip out some sort of
algorithm to make sure all the 874 default entries are covered only once
using hasing, bit test or bitmap tricks. It could come out fairly
obsecure, but, well, as long as it's documented somewhere.

Stay tuned.

Davo
