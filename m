Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822783115AF
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 May 2026 22:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778453924; cv=none; b=Wy/fha1xV0luWSabUHlG7yKPmd/pUPVUniItBupkUKH5YZ5s6fxv0PHZkr5ANlIA2bjjDYlkfJUIyQm7/LmEQXeb3LdnDJoMBSFRULhgm2heTwiQiFSnbayhchywcMytuM3qUc8kOxhj2DF7lfe1vneyBXwUOugFJmrSgVF1FJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778453924; c=relaxed/simple;
	bh=qAHOtAgNceqBfUPVmqWDFR0iHUrKuFs1Mp9iN+JfYug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PZmGgA7R33tLkTslx7EvZNtMuPwhPiShLp5s8kdhNxWVjUm+gLsJfmvzC/SoIlRqo1X4OgTcPWMgkJZW8hzdV0Iw6W3D1TSn75NO6H+S9WnClsxk2EloGIjc71xQdEojT/DF1XXecbY8IZZ/4QbCSw3GjGai57EzaHg3AMlqYRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 7408B1D490;
	Sun, 10 May 2026 22:58:41 +0000 (UTC)
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id 9H67CaENAWoGMgMA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Sun, 10 May 2026 22:58:41 +0000
Message-ID: <9a4f44b0-ec1a-4bb0-bd58-37f470b6a595@dev.snart.me>
Date: Mon, 11 May 2026 07:58:40 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] exfat: optimise and refactor filename up-case
 conversion
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20260505123144.730782-1-dxdt@dev.snart.me>
 <20260505123144.730782-3-dxdt@dev.snart.me>
 <PUZPR04MB631684B809F703C8D62D3B59813C2@PUZPR04MB6316.apcprd04.prod.outlook.com>
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
In-Reply-To: <PUZPR04MB631684B809F703C8D62D3B59813C2@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/26 21:03, Yuezhang.Mo@sony.com wrote:
>> +static inline bool exfat_illegal_chr(const unsigned short wchar)
>>  {
>> -	while (*str) {
>> -		if (*(str++) == wchar)
>> -			return str;
>> +	switch (wchar) {
>> +	/*
>> +	 * Control characters
>> +	 *
>> +	 * This saves some cmp instructions if the compiler does its job correctly
>> +	 */
>> +	case 0x0000: case 0x0001: case 0x0002: case 0x0003:
>> +	case 0x0004: case 0x0005: case 0x0006: case 0x0007:
>> +	case 0x0008: case 0x0009: case 0x000A: case 0x000B:
>> +	case 0x000C: case 0x000D: case 0x000E: case 0x000F:
>> +	case 0x0010: case 0x0011: case 0x0012: case 0x0013:
>> +	case 0x0014: case 0x0015: case 0x0016: case 0x0017:
>> +	case 0x0018: case 0x0019: case 0x001A: case 0x001B:
>> +	case 0x001C: case 0x001D: case 0x001E: case 0x001F:
>> +
>> +	case 0x0022: /* QUOTATION MARK:    (") */
>> +	case 0x002A: /* ASTERISK:          (*) */
>> +	case 0x002F: /* FORWARD SLASH:     (/) */
>> +	case 0x003A: /* COLON:             (:) */
>> +	case 0x003C: /* LESS-THAN SIGN:    (<) */
>> +	case 0x003E: /* GREATER-THAN SIGN: (>) */
>> +	case 0x003F: /* QUESTION MARK:     (?) */
>> +	case 0x005C: /* BACKSLASH:         (\) */
>> +	case 0x007C: /* PIPE:              (|) */
>> +		return true;
> For the continuous range 0x0000 to 0x001F, I think it's better to
> handle it like below, which avoids the large jump table, and may be
> just as fast(or even faster).
>
> 	default:
> 		return wchar < 0x0020;
I guess you're right.

That costs one extra cmp instructions but still fits under a cache
granularity on modern hardware(64 bytes) so it wouldn't really show up
in profiling. Better to avoid risking compiler mindlessly producing a
huge jump table.

Either way, still a win since the processor no longer has to iterate
over the array.
