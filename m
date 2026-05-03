Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEDD7260F
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 May 2026 08:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777795389; cv=none; b=gL6RSJUHpx/WntcLvZjyn/0u/miqZ9e+/S9LF3M1bTdoze01g0p9R51QY0P+Oqy0eZxQZhU4Fdy2p8XzYZwyXGpHtC2ku5R2mwKz18eWt/hUEhvCqTxSJbosqj2snIBdEfJlffUyIEdEvrkjL9J51MgTSuOus75qdoc44U755q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777795389; c=relaxed/simple;
	bh=EcKGVC9lhGQR0aaXeQ7l53HeJ32fr/haxG6oZhNp/lI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=isHKw6aQzjAB+Jh9h4dJhiGdiDGDkbNmWYl81TKdu3pN9iWm0kK//wUb6g1CFKfOGOlrL6Ys05nIvNAK86ecaY2ZoH0JavBQoV7yEO9YrvoDgQ3aXoBVck7wj2fnlpGi8NFAWoskIM6eBieDhNWaZdnq0pMJ5hfuiPAadpH3/oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id CBAAC1D490;
	Sun,  3 May 2026 08:03:05 +0000 (UTC)
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id CY/ZHjkB92lymwAA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Sun, 03 May 2026 08:03:05 +0000
Message-ID: <bd7379db-dc8b-43f6-9c56-dd229a5fb1bc@dev.snart.me>
Date: Sun, 3 May 2026 17:03:04 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: David Timber <dxdt@dev.snart.me>
Subject: Re: [PATCH v1 1/4] exfat: refactor nls.c (tables)
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20260428235038.93816-1-dxdt@dev.snart.me>
 <20260428235038.93816-2-dxdt@dev.snart.me>
 <PUZPR04MB631683CFF8B30FE0C5EC106181352@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <04c4213b-0918-4736-b736-238490322880@dev.snart.me>
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
In-Reply-To: <04c4213b-0918-4736-b736-238490322880@dev.snart.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/30/26 18:22, David Timber wrote:
> On 4/30/26 16:53, Yuezhang.Mo@sony.com wrote:
>>> +/* exfat/tables.c */
>>> +/* Upcase table macro */
>>> +#define EXFAT_NUM_UPCASE     (2918)
>>> +#define EXFAT_UTBL_COUNT     (0x10000)
>>> +
>>> +extern const unsigned short exfat_uni_def_upcase[EXFAT_NUM_UPCASE];
>>> +extern const unsigned short exfat_bad_uni_chars[];
>> The global variable exfat_bad_uni_chars[] is unnecessary, as is the 
>> generic function exfat_wstrchr().
>>
>> We can implement a dedicated function `exfat_is_bad_uni_char()`, in
>> which we can define static `exfat_bad_uni_chars`, or we can use a
>> switch...case... statement.
> I agree.
>
> I too think that switch a case statement is suitable here because
> there's only a few __u16's to compare so there's really no need to leave
> room for cache misses. Let the CPU prefetch the characters along with
> the instructions.
>
> Will make a separate commit if no objection.
Did some fiddling and found out that that could risk performance
regression. But it's a problem specific to Clang, which is not so
popular choice of compiler in the embedded world where it could have a
significant impact.

If it doesn't bother anyone, I'll send out the reroll.

https://github.com/llvm/llvm-project/issues/127365#issuecomment-4362781091
