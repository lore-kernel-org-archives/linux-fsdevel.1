Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5A0283FE5
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Apr 2026 03:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775185267; cv=none; b=VlA5FJgG7gXZr3UuAvNMm5JRMHu5Z4puTEyJ7tGAChI136JbDWAQdvWfZj1tgaD2SHULsMqdH4e5PESrS4+yD1NBQKJ4Jy+ingNoC6ft6vhINTYdV/tdKVUPi7HRH1543OuU5EFeIN8a6hIgFAIuJSe5Wj1nDxG32jh2vLm5d6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775185267; c=relaxed/simple;
	bh=X98tnEe3wxemZAXCC7XmYyfva93Moq/XlEfvNWPjQ3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bLNvI/1497YY5uuQ9NwqgS1QMH5QlZF9ParYqh7acJxCjB/5osY+fpb/8qvHYbElI+ta2pnAqQj3yKI8g3ten9MMWKlrqJKSg4C4yHAJWD2eUcfAHBANzu2v3+PgczmWqmOCHVweuMu9uRJGGbtwYzewqP5mgVhHMr1fSHjF5f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=HtB70j5t; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="HtB70j5t"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id D39B21CBC3;
	Fri,  3 Apr 2026 02:55:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me D39B21CBC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1775184950; bh=X98tnEe3wxemZAXCC7XmYyfva93Moq/XlEfvNWPjQ3k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HtB70j5tx1wdbBjnH53tSYux+Z/nUVE0d1zlE/OUhkyHjETsZgpOUyJrAI5qJjk8r
	 TNbtBqh0TLPvITj0bZeRBnGrdh7VoVlkMUjPz6oFQ19wQZjiTf4cWlT5g+fA4ClGOV
	 Z7bRir0K+FOyULJAjb1SJ0ONBk9WUwIWfOBSsAbs=
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id WO4SITUsz2kpHg0A8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Fri, 03 Apr 2026 02:55:49 +0000
Message-ID: <9e82ba4e-506e-4f00-ad06-67c0d541cace@dev.snart.me>
Date: Fri, 3 Apr 2026 11:55:45 +0900
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
In-Reply-To: <CAKYAXd_0TeNuruJznXjs+MT8cW2zwOiuNGwztF=A7t8ZgKiKQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/1/26 16:12, Namjae Jeon wrote:
> Why is this limited FALLOC_FL_ZERO_RANGE support actually needed in
> applications?
> What are the practical use cases or benefits for applications?
Please see the original cover letter at
https://lore.kernel.org/linux-fsdevel/20260319043553.301185-1-dxdt@dev.snart.me/

To answer the question: zeroing out entire file leaving the cluster
chain intact to avoid I/O and flash wear

>>         /* No support for dir */
>>         if (!S_ISREG(inode->i_mode))
>> -               return -EOPNOTSUPP;
>> +               return mode & FALLOC_FL_ZERO_RANGE ? -EINVAL : -EOPNOTSUPP;
> Why should we return -EINVAL specifically when FALLOC_FL_ZERO_RANGE is used ?
The reason why a different errno SHOULD be returned could be found in
fallocate(2):

    EINVAL mode is FALLOC_FL_COLLAPSE_RANGE, *FALLOC_FL_ZERO_RANGE*, or
FALLOC_FL_INSERT_RANGE, but the file referred to by fd is not a regular
file.

Again, (circling back to the xfstests EFBIG issue at hand) this is more
of correctness in behaviour.

> There are already the checks for non-regular files in vfs_fallocate().
Yes and no. I understand the check might seem meaningless in exFAT
because the types of files it support are just directories and regular
files. It might seem as a leftover from the vfat codebase, but only the
cases of ENODEV, ESPIPE and EISDIR are covered in vfs_fallocate().
fallocate() on "exotic" files like unix socket is
implementation-defined. Such edge cases could slip through, so the check
is not enirely meaningless.

As per the EINVAL, the case is not covered in vfs_fallocate() so it has
to be returned by the fs that supports FALLOC_FL_ZERO_RANGE.

I'd like to add that relying on the checks in the abstraction layer is
not a good practice especially when implementing a non-UNIX filesystem
like exFAT and NTFS. The POSIX spec will evolve over time and things
will get added to the spec(SEEK_HOLE being the prime example).

Davo
