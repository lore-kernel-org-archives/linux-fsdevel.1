Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCE535DA41;
	Wed, 26 Aug 2026 04:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787717622; cv=none; b=BXaP7NXtR3QjaVp7keln4R6vKdVB2MrvoLj9+gaY0KVsxfeIwD/gNpc5NSPhzzkj5fFIr+yazHRIo1GDq6WVYXIyce1BnyA5XP8MMpeP/psePjyks8+sSfwloHeas3fylb7fCdVAuJoJFtEUFDhXEGMA4g1sRS4toaj1AE3cmq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787717622; c=relaxed/simple;
	bh=83nyYQ/MYSRw34D2ayj4CVHpjasvvdcL2gEFKQYctcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QQpZ/EeyXvV2adcfxtbFDaT5tbqoR5xDpi/wq+HVUbPiePgEIAHL+f/DgiW9auPfCBGzklG49FS4aCW3qDF3d4iF9wDKj9j/7n2ohvqV9fERN941eIHuvmW2/bxVESCylSCLxWHs+317NEKekvx5AsqBcFbV4bo258c7MiHiomk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=dc03A3aE; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="dc03A3aE"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id DC3E11D472;
	Wed, 26 Aug 2026 04:13:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me DC3E11D472
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1787717613; bh=83nyYQ/MYSRw34D2ayj4CVHpjasvvdcL2gEFKQYctcY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dc03A3aEbN9gQ8OnXepSiohTIvtzeBDmd2KB9nwLAooiC3EZwo0m3dT7f4WNOVfSJ
	 YQruoh79VQZqEvRczwu7PMYUYAl+Ayalwtw/RTvesPLOK60oyB8RrQJ+NScJAcU2x9
	 yb702VfGDxfVgH1Xs9fRJ2SertMcTNVeNamAKUt8=
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id bqL9IuxnjmqK9QEA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Wed, 26 Aug 2026 04:13:32 +0000
Message-ID: <aa36b1de-70d9-4234-a240-770fe66aa19b@dev.snart.me>
Date: Wed, 26 Aug 2026 13:13:29 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fat: add noflush mount option
To: Christoph Hellwig <hch@infradead.org>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20260822173732.10230-1-dxdt@dev.snart.me>
 <ao0tUKyhsm1wNYCx@infradead.org>
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
In-Reply-To: <ao0tUKyhsm1wNYCx@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/26 14:51, Christoph Hellwig wrote:
> On Sun, Aug 23, 2026 at 02:37:32AM +0900, David Timber wrote:
>> On most distros, udisks manages users' removable volume mount requests.
>> Udisks is configured to always mount FAT volumes with the 'flush' mount
>> option. This is largely okay for populating directory in small sizes,
> No, it's not.  It is an amaingly stupid idea that leads to horrible
> performance and flash wearout.  I'm not objecting to your patch, but
It probably had something to do with DOS and/or Windows implementation,
maybe a "monkey see, monkey do" situation. I think this is why FAT on
Windows is quite slow to this day(again, I might be wrong so don't quote
me on this).

Whoever first came up with the idea was probably worried too much about
users(who are not familiar with UNIX systems) unplugging removable
devices without giving the OS an opportunity to sync. I have to say
that, compared to Windows' default behaviour, the default 5 seconds of
vm.dirty_writeback is quite aggressive and that's why we have the flush
option in the first place...

But I still think being able to flip the option on the fly should come
in really handy in embedded systems that just can't afford to do
explicit sync. I think this is the main use case of the flush mount
option. For storing small metadata, it's really not that bad of an idea,
even in terms of hardware degradation.

> if you care about the usability of FAT volumes in this scenario, the
> more important thing is to fix this default.
I'll go to udisks devs to ask why they did this.

Davo
