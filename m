Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48D926B95B;
	Wed, 26 Aug 2026 04:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787718157; cv=none; b=d0YO6JTcN52iT5oV6txseyoBbRPcGsQo5LJSBYUSZ8wsi4Io77ox6RIucIYELwXSFICUPyN+nOWLf8teS9u0CnVGzXaXQubwsEOdpfnlN0GSvkE9jp6jyl0GDf68Jb4Ybn3H8wxXPmMpmWHI3xA1zOo3n1EVr+wDd0nYSIhjEPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787718157; c=relaxed/simple;
	bh=SD7hhQDUH2wCoa/LN1T16MWWMsxv+imzJE63fWqfgPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RfrruF8vdfMgDciOzpYKbQoWfJ/dmFqa3ot8UqabjGZIpJoQxVXiLSs1YLMUGsDK3HilDmxfZqHhD0G06yVwJpN+KuPyqgJMx8WhTjZxN36B7SfdXS+xOMxiSQy97yiMrn1nyY2Bp8X/+fQjr3SCYOOuG4zwdoe/PQAnpMH97Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=QNy3bSx0; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="QNy3bSx0"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 877BD1D472;
	Wed, 26 Aug 2026 04:22:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me 877BD1D472
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1787718154; bh=SD7hhQDUH2wCoa/LN1T16MWWMsxv+imzJE63fWqfgPY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QNy3bSx05dHTD6IbxysM87Ipp0OQs6sFdhXKCaSfHBfb7wjHWP+d+ZHxnUvfv50xL
	 Ibk0PvpUoPwI0Q5Z9lY4FwfX+oXVVzK/YD8z29ncAGfhKvJjRDzmnI+rg1ESaixwws
	 fAStD2OUOS8i8/zjOrqvjjbGgchGSyJ15WKeuyHA=
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id MKAODglqjmoZ9gEA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Wed, 26 Aug 2026 04:22:33 +0000
Message-ID: <b451b5af-adf4-4b2b-9056-641ae26158c9@dev.snart.me>
Date: Wed, 26 Aug 2026 13:22:32 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fat: add noflush mount option
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20260822173732.10230-1-dxdt@dev.snart.me>
 <871pbn6edz.fsf@mail.parknet.co.jp>
 <787aea79-beb0-4f29-bb67-ee57f6c654c4@dev.snart.me>
 <87ecfmrfb9.fsf@mail.parknet.co.jp>
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
In-Reply-To: <87ecfmrfb9.fsf@mail.parknet.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/26 13:31, OGAWA Hirofumi wrote:
> Well, with a your patch, just remounting without "flush" option doesn't
> remove flush?
fat_parse_param() doesn't behave like other fs. The current
implementation only accepts rw and ro for reconfig. So the option cannot
be flipped up and down at will.

> And this is a user visible change more or less, so if
> there is an objection from users, then it will be dropped.
No worries at all. I'll just sit on the patch for now and see if anyone
comes to say they have a problem with it.

Davo
