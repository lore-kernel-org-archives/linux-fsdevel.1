Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EFD36827E
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 09:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777540686; cv=none; b=JBviDbyA8qP0167nJkjh+/5sbxZPwB9o9dmWEoSzHmC3VpOiy4Jc+IrNksaHm8Au8n6rQCic+osFVvXL3Oe4j+oGZc19aSquYBIDwYTtVYdaiTcVvhKKD/+NDaTmdTd6xE9W0JPyN4fN01KMYiO6h6KAlSdJF05Z51LdclNKCeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777540686; c=relaxed/simple;
	bh=hpXLR5KnPpbI43DYCDcYx6+8S9SroRQrmJbGgrAvErI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dwCy8MDzeCn77G634S0qtN2xmhe2kNqb2rnPmwRx/arXUovDqFnK7TbidZxbkE8Kj+pZNpD74rR91BF2zLj82NQPLNR8rwC4WWjqiMnctV07N49zluSnCDNNEVzMqIqNYKKIZY9QQp444L06thXkVURSFIRIqzse2uf42G8Dqbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 82BD51D459;
	Thu, 30 Apr 2026 09:18:02 +0000 (UTC)
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id 6sDXDEoe82nj4AUA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Thu, 30 Apr 2026 09:18:02 +0000
Message-ID: <70c86ffd-b0ff-477f-965b-b144faf80f22@dev.snart.me>
Date: Thu, 30 Apr 2026 18:17:56 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: David Timber <dxdt@dev.snart.me>
Subject: Re: [PATCH v0 1/2] exfat: add volume limit bounds checks
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20260429160824.409881-1-dxdt@dev.snart.me>
 <PUZPR04MB6316951E45F7BC9A02E490FE81352@PUZPR04MB6316.apcprd04.prod.outlook.com>
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
In-Reply-To: <PUZPR04MB6316951E45F7BC9A02E490FE81352@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/30/26 16:52, Yuezhang.Mo@sony.com wrote:
>> +	/* Actually try reading the last sector to see if it's within the blockdev bounds */
>> +	bh = sb_bread(sb, last_sector);
>> +	if (bh == NULL) {
>> +		exfat_err(sb, "last sector read failed : %lld", last_sector);
>> +		return -EIO;
>> +	}
>> +	brelse(bh);
> Instead of checking by reading the last sector, we can use bdev_nr_sectors() to 
> get the actual size of the volume.
Agreed. No need for exFAT to actually inspect the data at the last
sector, unlike XFS. Monkey see, monkey doo.


