Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E23A2877F7
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 May 2026 12:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777638015; cv=none; b=IXS858uyfey151SXF7wp9nLXfWUGoocH2ymLEMECenlugsGJmxcSzivko4nnnwDcvA5jNNQzuG/Ae9pScSyWYyVlrimQuMtBZT0C4oHxOdHKoVuiPBkswkkifInvBcM9Px8wUpIpQ/YhKJgVg7lPKAsAr5dlFear3WHDjxAbDgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777638015; c=relaxed/simple;
	bh=3hTPEO4P5unEpU7JSUdozo+MFvhEY856+ChHFp1RRH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Km4nPgZG+Dxkn+BBMA0PuTiwskzwan4FFzEhWSKHoB97MFLV3GEDyIp+vLk7VMOW6QvEkQfrVuHllmstqMjaLzKFucjvl8sS+P9W7opnNma7YyDLEpWyXxzjC6letM+JKJYf1rIfqfWTapyPZT8V4Foniy8iPzqt+JpB2HmUcxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 04C121D459;
	Fri,  1 May 2026 12:20:05 +0000 (UTC)
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id DCOHKXWa9Gk+TQYA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Fri, 01 May 2026 12:20:05 +0000
Message-ID: <54be304b-828a-4b79-8607-5004dbf78003@dev.snart.me>
Date: Fri, 1 May 2026 21:20:01 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] exfat: more pedantic upcase table validity check
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
 Sungjong Seo <sj1557.seo@samsung.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20260428235038.93816-1-dxdt@dev.snart.me>
 <20260428235038.93816-5-dxdt@dev.snart.me>
 <PUZPR04MB631687B9E5BF6066086C7F5E81352@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <383f2d82-5f31-49df-9c00-b76b6fa45370@dev.snart.me>
 <CAKYAXd8_9EpQw5w_0YNJ8FGZXmY7QsF6-6rRt5SjW==DSeYTUg@mail.gmail.com>
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
In-Reply-To: <CAKYAXd8_9EpQw5w_0YNJ8FGZXmY7QsF6-6rRt5SjW==DSeYTUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/1/26 20:27, Namjae Jeon wrote:
> On Thu, Apr 30, 2026 at 6:24 PM David Timber <dxdt@dev.snart.me> wrote:
>> On 4/30/26 16:58, Yuezhang.Mo@sony.com wrote:
>>>>  static int exfat_load_upcase_table(struct super_block *sb,
>>>> -             sector_t sector, unsigned long long num_sectors,
>>>> -             unsigned int utbl_checksum)
>>>> +             unsigned long long tbl_size, sector_t sector,
>>>> +             unsigned long long num_sectors, unsigned int utbl_checksum)
>>> After adding the parameter tbl_size, the parameter num_sectors is no
>>> longer needed.
>> Change the func signature? I'd like to hear Jeon's opinion on this.
> I agree. It is cleaner to remove num_sectors from the arguments and
> calculate it inside exfat_load_upcase_table() using tbl_size and
> sb->s_blocksize_bits.
Ack'd

