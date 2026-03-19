Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209072DC783;
	Thu, 19 Mar 2026 03:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773890969; cv=none; b=L+aD0h5pLJYwrGAVrMM3LubOSjVaSnHf5JZqYIIZTsYwy65BiQSaTiSPqzoxXoRLL736FdjiG9wsoJAGZjDlemc5GmfXmH2zH//7HhntppXplriHk2oeu+wCdXj/CShcXZ4DdajEIhF7uB5Slk2INsZRbeeC1lfm5WavkvKEKx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773890969; c=relaxed/simple;
	bh=ZYZOq7MtKC9pFlTb/PfcwUgZr/OeYcSxEUMcZJpVZ2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r5JmZgzMkWcqQvOKVaWBJkCZj0eRtoIgqraF+J2ED63C+ANuRp5ZZKI4vTayoNJ7dC+v/+3hMz3gW5qF/bXWr8i3WjmSv7RfzabYUZPRaLYF2FT2lwLoHVTD5NEUEliYhPtE0pYPrDvpsDYcRrJwzpxA/LzlYq7zSH6MfCgCQG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=oxoUfi94; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="oxoUfi94"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 6369D1CBC0;
	Thu, 19 Mar 2026 03:29:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me 6369D1CBC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1773890961; bh=ZYZOq7MtKC9pFlTb/PfcwUgZr/OeYcSxEUMcZJpVZ2E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oxoUfi94JMvsrlu7rQGm0RfgpViK5GYgiCoyKsdZTOyey3ILKDlEjtfK6FGj1Z6k5
	 inNa+NcnG14W3dPT9/teBFu3SETtqYuUXFEF9a5sXAj7iNvmmCEFzrT0mKx0zfMAHr
	 5otd0ZpIZeM/tLC5JFC00MMR7DpLg4oOz9WRqutc=
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id qHc1BJBtu2migAcA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Thu, 19 Mar 2026 03:29:20 +0000
Message-ID: <75922591-2b51-439f-9af8-9067ed3a9330@dev.snart.me>
Date: Thu, 19 Mar 2026 12:29:14 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] exfat: EXFAT_IOC_GET_VALID_DATA ioctl
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260311222613.2010177-1-dxdt@dev.snart.me>
 <abIxl8XEftpku8yf@casper.infradead.org>
 <b216af63-f65e-4c26-84bc-2693fad0fdf1@dev.snart.me>
 <abLUQECuMuxHNXjZ@casper.infradead.org>
 <20260312150623.GB1742010@frogsfrogsfrogs>
 <14dc2f67-7916-4990-b1c4-5d442c5d51fc@dev.snart.me>
 <20260313162408.GE6023@frogsfrogsfrogs>
 <898f4927-30a4-4ccb-b080-9e4d2fe3af1e@dev.snart.me>
 <CAKYAXd-ptRdWc9Aot=5+GmRRbc989EY0QaHj14Mhs2wwiWBa8w@mail.gmail.com>
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
In-Reply-To: <CAKYAXd-ptRdWc9Aot=5+GmRRbc989EY0QaHj14Mhs2wwiWBa8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/26 09:51, Namjae Jeon wrote:
> Since SEEK_HOLE will be supported as part of the upcoming iomap work,
> your patch below can be dropped and I won't apply it. And I would be
> very grateful if you could submit your FIEMAP patch after iomap
> support lands.
> Thanks!
Fair enough. As mentioned previously, a bunch of xfstests will fail
because exFAT's SEEK_HOLE doesn't behave like all the other sparse file
systems would. Will have to disable part or all of lseek() test cases.

I had another idea of using FALLOC_FL_ZERO_RANGE as means of truncating
VDL. I'll make that one offical send send them through. Or, if you
already thought of that too, well, sorry to bother you.

Cheers,
Davo
