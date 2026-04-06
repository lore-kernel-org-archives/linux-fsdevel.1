Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9BF4C6C
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Apr 2026 10:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775469680; cv=none; b=imHnSI8x2/sjwjC94BZ7nRczlHcrUXmDf/wOpGS0uTb4rMgqXb2gwb7WAU0Rg4EX+mRBysCBxwidqWM/M7eJUtvvFrYXGxfteqszn5Hdsg6Hx7P6U7JeMgY5i4lown+r9nbnm12vv8y6fSJXcqHku4o/N3W4ObHcXv1NZGw+Jg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775469680; c=relaxed/simple;
	bh=pwv8Kpr/NLtx3ur62jKb0rNh3cnXOM0NjB/z4omBGIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pQAeSHC1QCRSN1yVFK9Ffe7rY9OQj0oNpjymq3JqUQSXnCtFmZYrHVzCvJj+2mHRDmTCPGmEynY9fNCIkuaVvK6vqeSTrd5ifpkcSEoXmNbfM56PS/+aSBfWPLp85fgi0IEhjDJ70RdDYXwUh6pQ0U7y80pbN1qMw6v5pdy4MTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=NmJ9CFpr; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="NmJ9CFpr"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id B2DAA1CBC3;
	Mon,  6 Apr 2026 10:01:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me B2DAA1CBC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1775469672; bh=pwv8Kpr/NLtx3ur62jKb0rNh3cnXOM0NjB/z4omBGIU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NmJ9CFpr/Xp5rnVX1yK8tbR08edRVuMux7etBYMCeNiyldwwod0MkEsH7IKfrvLIA
	 QV+rqZlrJfRDrj9JZs8xxBoJKlNXKw+HIOmE9a5LqOEc5fbBu3lPum1Jr6N/WX+AtX
	 hg0HVYtrdfd4HAJ9i0We+/2U3yCOZzFwRDEru7qM=
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id LojHF2eE02mFWQ4A8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Mon, 06 Apr 2026 10:01:11 +0000
Message-ID: <2c8aa91a-184f-44fd-97fc-c02b0cee1b08@dev.snart.me>
Date: Mon, 6 Apr 2026 19:01:07 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] exfat: add limited FALLOC_FL_ZERO_RANGE support
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo
 <yuezhang.mo@sony.com>, linux-fsdevel@vger.kernel.org
References: <20260322125944.48541-1-dxdt@dev.snart.me>
 <20260322125944.48541-2-dxdt@dev.snart.me>
 <CAKYAXd_0TeNuruJznXjs+MT8cW2zwOiuNGwztF=A7t8ZgKiKQA@mail.gmail.com>
 <9e82ba4e-506e-4f00-ad06-67c0d541cace@dev.snart.me>
 <CAKYAXd9fENATzE7abUGMZ1uYARhFW=oG_7yvUSWvoX+25nv_Aw@mail.gmail.com>
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
In-Reply-To: <CAKYAXd9fENATzE7abUGMZ1uYARhFW=oG_7yvUSWvoX+25nv_Aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/26 15:19, Namjae Jeon wrote:
> I have some concerns about adding this limited FALLOC_FL_ZERO_RANGE
> support to exfat. It is already possible to achieve a very similar
> result using ftruncate() and fallocate(FALLOC_FL_ALLOCATE_RANGE).
> First, call ftruncate(fd, 0) to adjust the file size and Valid Data
> Length (VDL). Then, call ftruncate(fd, new_size) or use
> fallocate(FALLOC_FL_ALLOCATE_RANGE, newsize) to preallocate clusters.
The method you've described involves destruction and reconstruction of
the FAT chain. With the current cluster allocation scheme(just return
the next one available doing O(N) search), the chance of the newly
constructed file end up having NO_FAT_CHAIN is quite low. FAT chain
construction is not particularly good on flash.
> Additionally, The proposed implementation is quite restricted. It only
> works when the range covers EOF unlike the standard
> FALLOC_FL_ZERO_RANGE behavior documented in the man page and
> implemented in other filesystems. This may confuse userspace tools.
Yes. Fair point.

I spent some time decompiling the exfat.sys driver, basically an
implementation copied-and-pasted from FASTFAT, in Windows and realised
that the problem being addressed here will simply go away if the Linux
in-kernel exFAT would employ an allocation algorithm somewhat on par
with that of Windows(which prioritises the use of contiguous runs of
clusters).

It was just an idea but rather a cheap one. Ultimately, the
fragmentation issue has to be solved by applying a salient cluster
allocation algorithm.

Davo
