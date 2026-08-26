Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCFA3B6C1D;
	Wed, 26 Aug 2026 08:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731211; cv=none; b=tXL+awfIl/UzVeG+NlE3BwTQ3OVbRe4mZRE/lxpjEdGr7XLjA+DsObIrdMysOfD4D7EuGBNfxhPxickUsEi8S5cNq7EajIZWNQcI1MP/EBLqkRq/n7bfGJh9wh0eUIXdLaPMtn6TSIhONOdAUBuRTyQJ1jQXtfLHB+89RftTuD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731211; c=relaxed/simple;
	bh=AnXK1cN6ryASgSV4QtNON5u0yVtFlupfDStQ66Vw9Fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eb4i2jWdMfBFRBGIcDYwUVvHk4d7dvPkuGe0pEwO7aYCD/OrI6dEmQR52/uCqkr+vuKSuKAIP1uuMxXRPtTO3q9ufMUE0DWdfr93ZG+7nL6ZRDCKZChHyM2yxmC41fdDzBKbSPXqxIFZzrrVQCfEdC6YqoAQ5B3EwvMwr89zt90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=Msm6PKhT; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="Msm6PKhT"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id CC9D01D472;
	Wed, 26 Aug 2026 08:00:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me CC9D01D472
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1787731208; bh=AnXK1cN6ryASgSV4QtNON5u0yVtFlupfDStQ66Vw9Fg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Msm6PKhT/U8OMi8EO/wYmffjit/fYtSjIaSm/Bf7qr8+sn/V0jVwgam9VOUt/jF1o
	 AqhNxXphVjxfidSlF3lufu4Dl16CiEAv9de0sEvuvhCMBQ4sT4ZWBmK63krF8lRiFJ
	 hvoBnQpxPaKP0UnkA8mPCITNwmmwfVb6kaP0X1Ro=
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id LY2FIAedjmoIAwIA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Wed, 26 Aug 2026 08:00:07 +0000
Message-ID: <75c9377d-33ee-472c-911f-33a3e1f661d6@dev.snart.me>
Date: Wed, 26 Aug 2026 17:00:04 +0900
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
 <b451b5af-adf4-4b2b-9056-641ae26158c9@dev.snart.me>
 <875x0xpcsr.fsf@mail.parknet.co.jp>
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
In-Reply-To: <875x0xpcsr.fsf@mail.parknet.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/26/26 16:21, OGAWA Hirofumi wrote:
> David Timber <dxdt@dev.snart.me> writes:
>
>> On 8/25/26 13:31, OGAWA Hirofumi wrote:
>>> Well, with a your patch, just remounting without "flush" option doesn't
>>> remove flush?
>> fat_parse_param() doesn't behave like other fs. The current
>> implementation only accepts rw and ro for reconfig. So the option cannot
>> be flipped up and down at will.
> I meant with your patch. With your patch, it updates flush to current
> option set, right? And default flush=false, I may missing something
> though.
Of course. It shouldn't change the default behaviour. When mounting, if
"flush" is in the mount options, it must be honored UNLESS "noflush" is
also specified later in the sequences. If neither "flush" or "noflush"
is specified, then it's not set at all. Specifying "noflush" only should
be no-op.

If the patch doesn't behave like that, that'd be my mistake and should
be fixed.

When doing "mount -o remount,..." the patch changes the existing
behaviour so that "flush" and "noflush" are now honored. Regardless of
the previous sbi config, for "-o remount,flush" -> it always sets flush.
For "-o remount,noflush" -> always clear flush.

Hope that cleared things up.
