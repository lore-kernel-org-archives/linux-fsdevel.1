Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078A826B2CE;
	Sat, 21 Feb 2026 06:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771654669; cv=none; b=ReIOy3+VzMddupRhkP9+RCVYul4vlAex+y12jFjvfZk7hZL0my4c6WZGTLfc6X/v7JrITfJOtIKqD4xno7qv4k+bNt8AsPm2IRNtvNEU9wMz7QOLWmtZ+qUahiJIhvQNuGXGhtwPhB8OPyPHQb0mFkKz3GQaIwXPYknvQekC5r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771654669; c=relaxed/simple;
	bh=4K12sFwbZfdR5jpMfVZuyMl6bSiEXGLPP8LAuL0/De4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KOMhHxfK1iCcVXPcP07rrxYim5TKhbYcbvLkMpkDED3nr0YJL44BCL0XLNBMr3HsVNk6bddvB2UcqjnV1zNQtnhJIMEweXTZL/RlYpB7/1VtqgL7jSXfKzQri6Xf114sgvq4YWm9DbNUnPF41MuJvLyl4gS+M6Pl7vOVinRwk78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=gqHMN/iM; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="gqHMN/iM"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 45B9D1D49A;
	Sat, 21 Feb 2026 06:17:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me 45B9D1D49A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1771654659; bh=4K12sFwbZfdR5jpMfVZuyMl6bSiEXGLPP8LAuL0/De4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gqHMN/iMXCSrBr3KysQz0Il8BHkz3mwE3icYr/G0JKREcE/gS4sWflO4yaztZ//ek
	 DBryKaKvPeUwtHJvPQx55fH/6WDSOdkpMSHeWdyNymSlznXFQI07C7IB815spqyVrF
	 +X9A6mVCDWqb+75fE0DYNGzoQ7WmHnihWiEw5ZFQ=
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id AaqgNwJOmWkZ+gIA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Sat, 21 Feb 2026 06:17:39 +0000
Message-ID: <144a192d-1298-4aa4-891d-cf5e2ad6b8e6@dev.snart.me>
Date: Sat, 21 Feb 2026 15:17:30 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/17] fs: add generic FS_IOC_SHUTDOWN definitions
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260213081804.13351-1-linkinjeon@kernel.org>
 <20260213081804.13351-3-linkinjeon@kernel.org>
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
In-Reply-To: <20260213081804.13351-3-linkinjeon@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> +/*
> + * Shutdown the filesystem.
> + */
> +#define FS_IOC_SHUTDOWN _IOR('X', 125, __u32)
Should've been _IOW, not _IOR. This is rather unfortunate.

Documentation/userspace-api/ioctl/ioctl-number.rst:
>     ====== ===========================
>     macro  parameters
>     ====== ===========================
>     _IO    none
>     _IOW   write (read from userspace)
>     _IOR   read (write to userspace)
>     _IOWR  write and read
>     ====== ===========================
>
> 'Write' and 'read' are from the user's point of view, just like the
> system calls 'write' and 'read'.  For example, a SET_FOO ioctl would
> be _IOW, although the kernel would actually read data from user space;
> a GET_FOO ioctl would be _IOR, although the kernel would actually write
> data to user space.
All the *_ioctl_shutdown() do get_user(..., arg).
