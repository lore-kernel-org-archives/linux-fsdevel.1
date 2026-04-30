Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D2E39FCD8
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777540968; cv=none; b=t4SHgNMTUqxJ0VpjyD6zMGTLoYL8TRg6Xqfd8e0kYRd4HbHiO3ON7gEEqsNLEvMbCrFP9t3zXx85H8PNUjxATfznGEv0cV2HbSTCTpCFXUEqQBETU24YP1g+1e33res8tbTRpGinK+Ew+xSVpmA2Ehr8oydG7UzfAfFvBhLGYy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777540968; c=relaxed/simple;
	bh=/tiESWr8KGXs40FEnCVCkObVZRzCKW8IQsK0oVyrIMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KnGF85biw+hJO8T+pdATtQQQJQi9FsreZL+5/Kwm/gYyVkeq6aXsptq/DIsgnDxmC/EawANgF0I5HVjz9oGnsG6D5KqhCWobD7jv6zk2qjkZN7Ax4L1xThlpt6fGPmsl0Xk/pv8/RqQ7soussK2KQLT3pCJhe8y7YJxMiEIXPVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 730FE1D459;
	Thu, 30 Apr 2026 09:22:45 +0000 (UTC)
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id VCv6CmUf82lQ4QUA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Thu, 30 Apr 2026 09:22:45 +0000
Message-ID: <04c4213b-0918-4736-b736-238490322880@dev.snart.me>
Date: Thu, 30 Apr 2026 18:22:44 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] exfat: refactor nls.c (tables)
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20260428235038.93816-1-dxdt@dev.snart.me>
 <20260428235038.93816-2-dxdt@dev.snart.me>
 <PUZPR04MB631683CFF8B30FE0C5EC106181352@PUZPR04MB6316.apcprd04.prod.outlook.com>
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
In-Reply-To: <PUZPR04MB631683CFF8B30FE0C5EC106181352@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/30/26 16:53, Yuezhang.Mo@sony.com wrote:
>> +/* exfat/tables.c */
>> +/* Upcase table macro */
>> +#define EXFAT_NUM_UPCASE     (2918)
>> +#define EXFAT_UTBL_COUNT     (0x10000)
>> +
>> +extern const unsigned short exfat_uni_def_upcase[EXFAT_NUM_UPCASE];
>> +extern const unsigned short exfat_bad_uni_chars[];
> The global variable exfat_bad_uni_chars[] is unnecessary, as is the 
> generic function exfat_wstrchr().
>
> We can implement a dedicated function `exfat_is_bad_uni_char()`, in
> which we can define static `exfat_bad_uni_chars`, or we can use a
> switch...case... statement.
I agree.

I too think that switch a case statement is suitable here because
there's only a few __u16's to compare so there's really no need to leave
room for cache misses. Let the CPU prefetch the characters along with
the instructions.

Will make a separate commit if no objection.
