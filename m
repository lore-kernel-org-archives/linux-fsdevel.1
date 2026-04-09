Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3511A6836
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 10:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775731960; cv=none; b=LVTnLj9R8eWdMPhhICpssUHtnE21bIL8W0KLTLiCkp6yh34wjDT+iiZfWPHJubCP1V4/jcfaUg2qqELD5Muh4iq/yo3f6YmDUbepu7i74bxe2YBxrfbk/Bkv6powRlo1atiEIW2NT1as/AyqHSKd02xaLOZoWUbpRNgLXts50n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775731960; c=relaxed/simple;
	bh=GF8gLXBQWBt+QKJwrvGXYEtsVEu+WDotWoiXX15y2tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CBm8CyKmoHZrJUrKbdPZKXgqThqdta8WkJvRtfs0hdwsR9k/NLZAn2FmouZYQGNkonn5v2Z4+ysij3AQw0+kUIdWt5FPVWySR3i9RQgxaMI5c0c1n2j8j0+HzQG/u4MIUwhw91AFIE588+IQeeiNXVlwLo+TaYOo10GzrIrx7WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Epj5NLKY; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Epj5NLKY"
Message-ID: <408fc657-94a2-4832-b5cd-7013c002403d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775731956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NuouJ5hGuPj+8OpBucBQO1REDxTAFBbB4iqEVWsSckY=;
	b=Epj5NLKYJdYGHLWGVI8zpsduF26q6pYl4ej9eTFU/B3+gZxA1v4rwN7MLujQuwBE8esvkA
	HTM0IoMJKDHP0rXcpUdW0MlNFVMt2U53vEFGsbTASJddvtITIWvpZrZ0dzmI0WgekvpsJD
	S9g/7V92JP6VFOspZsB+htVa4GUFg4Y=
Date: Thu, 9 Apr 2026 11:52:12 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH] userfaultfd: allow registration of ranges below
 mmap_min_addr
Content-Language: en-GB
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: "Denis M. Karpov" <komlomal@gmail.com>, rppt@kernel.org,
 akpm@linux-foundation.org, Liam.Howlett@oracle.com, vbabka@kernel.org,
 jannh@google.com, peterx@redhat.com, pfalcato@suse.de, brauner@kernel.org,
 viro@zeniv.linux.org.uk, jack@suse.cz, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260407081442.6256-1-komlomal@gmail.com>
 <20260408123700.1596800-1-usama.arif@linux.dev> <addcUpxfuR2llaiW@lucifer>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <addcUpxfuR2llaiW@lucifer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 09/04/2026 09:01, Lorenzo Stoakes wrote:
> On Wed, Apr 08, 2026 at 05:36:59AM -0700, Usama Arif wrote:
>> On Tue,  7 Apr 2026 11:14:42 +0300 "Denis M. Karpov" <komlomal@gmail.com> wrote:
>>
>>> The current implementation of validate_range() in fs/userfaultfd.c
>>> performs a hard check against mmap_min_addr without considering
>>> capabilities, but the mmap() syscall uses security_mmap_addr()
>>> which allows privileged processes (with CAP_SYS_RAWIO) to map below
>>> mmap_min_addr. Furthermore, security_mmap_addr()->cap_mmap_addr() uses
>>> dac_mmap_min_addr variable which can be changed with
>>> /proc/sys/vm/mmap_min_addr.
>>>
>>> Because userfaultfd uses a different check, UFFDIO_REGISTER may fail
>>> with -EINVAL for valid memory areas that were successfully mapped
>>> below mmap_min_addr even with appropriate capabilities.
>>>
>>> This prevents apps like binary compilers from using UFFD for valid memory
>>> regions mapped by application.
>>>
>>> Replace the rigid mmap_min_addr check with security_mmap_addr() to align
>>> userfaultfd with the standard kernel memory mapping security policy.
>>>
>>> Signed-off-by: Denis M. Karpov <komlomal@gmail.com>
>>>
>>> ---
>>> Initial RFC following the discussion on the [BUG] thread.
>>> Link: https://lore.kernel.org/all/CADtiZd0tWysx5HMCUnOXfSHB7PXAuXg1Mh4eY_hUmH29S=sejg@mail.gmail.com/
>>> ---
>>>  fs/userfaultfd.c | 4 +---
>>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
>>> index bdc84e521..dbfe5b2a0 100644
>>> --- a/fs/userfaultfd.c
>>> +++ b/fs/userfaultfd.c
>>> @@ -1238,15 +1238,13 @@ static __always_inline int validate_unaligned_range(
>>>  		return -EINVAL;
>>>  	if (!len)
>>>  		return -EINVAL;
>>> -	if (start < mmap_min_addr)
>>> -		return -EINVAL;
>>>  	if (start >= task_size)
>>>  		return -EINVAL;
>>>  	if (len > task_size - start)
>>>  		return -EINVAL;
>>>  	if (start + len <= start)
>>>  		return -EINVAL;
>>> -	return 0;
>>> +	return security_mmap_addr(start);
>>
>> Is this introducing an ABI change?
>>
>> The old code returned -EINVAL when start was below mmap_min_addr.
>> The new code calls security_mmap_addr() which returns -EPERM when
>> the caller lacks CAP_SYS_RAWIO. Existing userspace callers checking
>> specifically for -EINVAL would see different behavior start is
>> below mmap_min_addr.
> 
> You mean API change? :) we don't guarantee ABI for kernel stuff anyway.
> 

Ah no, I meant ABI, I hope :)

The return value of validate_unaligned_range() flows directly back to the
ioctl() return value, which is visible to userspace. The error code a program
sees from ioctl(fd, UFFDIO_REGISTER, ...) changes from -EINVAL to -EPERM for
the same input, right? Its probably not an issue, but we would need to update
https://man7.org/linux/man-pages/man2/ioctl_userfaultfd.2.html
right?
