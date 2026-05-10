Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4856C2D6E44
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 May 2026 23:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778454659; cv=none; b=k46muA7fh09yXYVUPxElLsikoEWrbRdg78jSIpqxEMh9aGNpXh7S6SnRABr6lN8LS70iHj/m+gLA7LOojELvC5GTO+aHiLq8xoW35I5UnxlsJcI4RHBJmZ9oT9M/L8eH1BE20b5UJp1ShMNMNvCg3Gq6m4wZNJAc1+u16P9PnkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778454659; c=relaxed/simple;
	bh=6/c5LqMmAk5VpCdr/Ih3iXfV90miT/TIVykfSYFaE+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c3f2RSJ3n3xBRkROnME3tV5fRANaYMQuGSh3qOjceR3HeN9jjcoOwYWm4PON7sH+t6m7ChD3OL3wTWdQaRIBrv7jFEZxUz2xXoE28L+CzedQ0g4I1YFWt42wukvD8+0WNyKUYZWdZED5ycvAqASbiW3C0lVfFpLrp5dv59u83ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 21B551D490;
	Sun, 10 May 2026 23:10:55 +0000 (UTC)
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id OU4KMH8QAWrSMgMA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Sun, 10 May 2026 23:10:55 +0000
Message-ID: <32708b03-cc11-4154-af4f-d84d5234dfcc@dev.snart.me>
Date: Mon, 11 May 2026 08:10:54 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] exfat: fix memory leak (upcase table)
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20260505122808.728020-1-dxdt@dev.snart.me>
 <20260505122808.728020-3-dxdt@dev.snart.me>
 <PUZPR04MB6316EA20F9C7618B53803AD3813C2@PUZPR04MB6316.apcprd04.prod.outlook.com>
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
In-Reply-To: <PUZPR04MB6316EA20F9C7618B53803AD3813C2@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/26 21:04, Yuezhang.Mo@sony.com wrote:
>> @@ -802,6 +803,7 @@ static int exfat_get_tree(struct fs_context *fc)
>>
>>  static void exfat_free_sbi(struct exfat_sb_info *sbi)
>>  {
>> +       exfat_free_upcase_table(sbi);
> exfat_free_upcase_table() has already been called in delayed_free(), so it is
> not needed here.
Upon further inspection, I realised why exfat_free_upcase_table() is
called in delayed_free() and I'm terrified. With the current
implementation, the upcase table mustn't be freed there. I apologise.

Everyone will agree that leaving stale objects should be avoided if
possible. Yes, there's lock dependency problem, but I think someone has
to fully understand it in order to remove delayed_free(). I'll put it on
my list and revisit this in the future.

The leak condition in fill_super() is legit and needs to be fixed, though.
