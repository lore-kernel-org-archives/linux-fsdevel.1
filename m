Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1D026C39F;
	Thu, 12 Mar 2026 14:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773324157; cv=none; b=LJXg1wjGGdku8j8oA2i69/Zz32C+Kr+Ra4EhTdFDWayaneQghlka873IdzY2Nss0DJyP7S+lpg4j35D+77S8R+2jFoU/UYzN0yIRK62h7T6uDJx0QvD2IbXzxXN+XK2R8wh3W/PotgcA00vpDuR0XNYVa/4AqzxsjqoM846ef8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773324157; c=relaxed/simple;
	bh=o2ayR+Vcxt71NlcuR3GaeCC8Bd3uR0aPgVqLzHfLTWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fyijn+Sfdi+mo9zceLOGjUMsxGl+Or59CcDw7ZKR+DwyEEUqzrlYKxA9ajXZlRYZueravLvJYiGP0xHjn1vOegjs5IDW6iOU7+XzR/JzEXUXpDzlW73O2Cs7kDMv7xM8hu5H1g6I1DQTrni87JHO8ABjwGujapnaoe5ePfGC48I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=MivdtdVF; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="MivdtdVF"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 973E31CBC0;
	Thu, 12 Mar 2026 14:02:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me 973E31CBC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1773324154; bh=o2ayR+Vcxt71NlcuR3GaeCC8Bd3uR0aPgVqLzHfLTWI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MivdtdVFODXd5ejLqczUWtgiUjCKmdT3e8K/RzGSZG/5nrDmzDp9FhiovO2HBL8ze
	 eKySUJei0gfCzcnbBXat3ujoSvo4jDkMw/TeldewhANiIV5gcRHMlg9Gqu2Gd2lj2/
	 lF5DcsKJb/rDXRa32WCgJffL8Qhphl5jBfyzdUVI=
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id bfh+E3nHsmmD7QQA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Thu, 12 Mar 2026 14:02:33 +0000
Message-ID: <b216af63-f65e-4c26-84bc-2693fad0fdf1@dev.snart.me>
Date: Thu, 12 Mar 2026 23:02:29 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] exfat: EXFAT_IOC_GET_VALID_DATA ioctl
To: Matthew Wilcox <willy@infradead.org>
Cc: linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260311222613.2010177-1-dxdt@dev.snart.me>
 <abIxl8XEftpku8yf@casper.infradead.org>
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
In-Reply-To: <abIxl8XEftpku8yf@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/26 12:23, Matthew Wilcox wrote:
> We already have two interfaces for this on Linux.  One is SEEK_HOLE /
> SEEK_DATA and the other is fiemap (Documentation/filesystems/fiemap.rst)
> Why are both of these interfaces unsuitable?
https://lore.kernel.org/linux-fsdevel/cf6c2b08-b7ff-4f70-95f4-cdb12ef5a666@dev.snart.me/

Because exFAT is not a sparse file system. The VDL is only a shorthand
for fast cluster allocation without writing actual data to them. In
other words, the range between the VDL and isize is not actually a hole.
The blocks in the range are actually allocated, filled with garbage data
on the disk. The kernel has to be careful not to return it to userspace,
which is something Linux kernel actually does.

Suporting SEEK_DATA in exFAT will certainly give a wrong impression that
it is a sparse fs. On the other hand, FALLOC_FL_PUNCH_HOLE on an
arbitrary range(other than docking to EOF) is not possible. Therefore,
it wouldn't make sense if a fs could do SEEK_HOLE, but not punch holes.
That would most likely confuse many userland programs like cp. That's
why I thought lseek() is not a good fit for querying VDL.

Truncating up a file in sparse file systems does not change st_blksize,
but exFAT does. I have to say this is rather an unfortunate digergence,
certainly not POSIX compliant, but the behaviour existed for a long time
now and no one is coming forward to say that something caught on fire yet.

I don't understand why people keep bringing up FIEMAP. It is a debugging
interface and it should stay that way. It's simply not the right tool to
find holes in files. SEEK_DATA and SEEK_HOLE became POSIX, so using
FIEMAP to find holes and data shouldn't even be an option at this point.

Davo
