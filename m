Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E013A875A
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 May 2026 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777816412; cv=none; b=GJLGyId7rvPFHg+ze2n3w96If9tWM7XhlY7QNecPtznNJo/TwbJmYom03xf9tFiIQrBv5se02E3i8KQU9rKNwyZ2S5kdjAxFEEE5DNTpYXwmWDt2KWfxV+QMxIf1fnA1bp1pUE/rlRUdb3pdHI3M+FlhirMFLTn9Ob1qXOTYHqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777816412; c=relaxed/simple;
	bh=tQsA1PM+dKTuEIPPt4nJnLS3mUX5G0TCq5ohttwrp/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A5FO6g9UV+HdktmjxNMtEJR4Vxfg1zYpkPgtBly3QZIc44f+osl3P5QsjuMTWUA1ri1yL8XIJKcrT2Du9LI/okV+Fn3HzG3Tt9KUnbMo8PbLelaLJXXWXTN67CeB2KHK7HPbzAEQ3enRuHbhEPZLrmN+64tQxxZZ7XK8IgY3q4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ubmkI4RK; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ubmkI4RK"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4g7mT26gsRz9vGF;
	Sun,  3 May 2026 15:53:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1777816406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+0hw2mMUJbCqQL61RqW8ZH++K1WRxx7PfQpqTJju0GE=;
	b=ubmkI4RK/3+pGsyChH/9tUEsO3xSkk+h5htfxhS++DdnNiaf/VavCYhD3HpD+08fuFTAv8
	jX9yYoMHgDdV1jqWb41eXYO+GBOobHgQtie0tGGBwX9pjTG6F4A5V0zW4U+3evGPM8DtNe
	sjc2pKcHS79Uk1B2GG5n78R1AdOzypkFRzuJMq0Mc8DXoUUtU9CvDX+84buEqbAmctsDjU
	TKyHERGK3BE6mKPVClJxP+n4LFroPh1xdT/6y3r8wKiODMHY43xOGwR/p9JB0ypLx5VRGC
	AvDTsjYraFd1yPv4MOo8xeH4etlzH9+/nWOxUB2A17ThvlL1IZckG7S4aUkKMg==
Message-ID: <b4a08cd3-4ea5-43cf-aa9d-2748f33de3ed@mailbox.org>
Date: Sun, 3 May 2026 15:53:25 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Meaning of struct statx->stx_blksize field
To: Andreas Dilger <adilger@dilger.ca>
Cc: linux-fsdevel@vger.kernel.org
References: <FAE1F98E-276A-4D61-86D4-47AE39F2E7E8@dilger.ca>
Content-Language: en-US
From: Zeno Endemann <zeno.endemann@mailbox.org>
Autocrypt: addr=zeno.endemann@mailbox.org; keydata=
 xjMEaQTnsRYJKwYBBAHaRw8BAQdAaM0iP7BM4cim48CUrxLA/GL1pYCCEzcWwMWZpif6rNXN
 M1plbm8gU2ViYXN0aWFuIEVuZGVtYW5uIDx6ZW5vLmVuZGVtYW5uQG1haWxib3gub3JnPsKW
 BBMWCgA+FiEEmC5dRIssSc8usW9ctw5fyLMNvKkFAmkE57ECGwMFCQWjmoAFCwkIBwIGFQoJ
 CAsCBBYCAwECHgECF4AACgkQtw5fyLMNvKlmYgD+LcbsvEZxyegeAcyvZXvpZBEjHXqkdM90
 C9QVC1CsW3IA/jqxTNUPJZ26XR3/d7XcWMFg5JRZyJdL7dP+7crJeMkGzjgEaQTnsRIKKwYB
 BAGXVQEFAQEHQHFzaxdORLfIxXTm1tjSnTbboFXL9tw5GgcNA4Nz0AQiAwEIB8J+BBgWCgAm
 FiEEmC5dRIssSc8usW9ctw5fyLMNvKkFAmkE57ECGwwFCQWjmoAACgkQtw5fyLMNvKmYmgEA
 xY2IpTWenWoXXSyhGUWu/ZfdRUsUBtYM5wSj7XeayCUA/0/dEWSKHsuxuFgvaetZE92+qjb8
 HkxusIwKIh1rafYI
In-Reply-To: <FAE1F98E-276A-4D61-86D4-47AE39F2E7E8@dilger.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: h8ycdfqzfqtduymqcaojptxneinetmyb
X-MBO-RS-ID: e139ead7acdb4ae2080

Andreas Dilger wrote on 03.05.26 14:41:
> ﻿On Apr 27, 2026, at 06:41, Zeno Endemann <zeno.endemann@mailbox.org> wrote:
>>
>> Hi,
>>
>> The man page of statx(2) describes the stx_blksize like so:
>>
>>> The "preferred" block size for efficient filesystem I/O.
>>> (Writing to a file in smaller chunks may cause an
>>> inefficient read-modify-rewrite.)
> 
> The statx(2) interface is meant to be able to emulate the stat(2)
> interface, where 'stx_blksize' is reporting the same information
> as 'st_blksize' exactly as documented (preferred IO size),
> 
>> However, from observation it rather looks like that field
>> is set to the "block size" (meaning the allocation unit) of
>> the file system the given file resides on - at least for
>> ext4 and vfat.
> 
> IIRC, ext2/ext3/ext4 have always returned the blocksize for stat(2)
> st_blksize, so that doesn't prevent the two from being the same.
> 
>> To my understanding that value is fairly unrelated to a good
>> IO transfer size and for the most part not really relevant
>> for userspace apps. For avoiding inefficient read-modify
>> rewrite the actual relevant thing is writing in multiples of
>> the page size (unless the page cache is bypassed, in which
>> case I guess stx_dio_offset_align is the value to use).
> 
> That is probably more an effect of history rather than anything
> related to statx() itself.  ext4 doesn't really have any other
> preference on the IO size other than the blocksize.

Sorry if I'm being a bit pedantic here, but if we are talking
about the filesystem as the underlying data structure, then there
really is no preferred IO size, as long as there is no filesystem-
level block checksumming/encryption (or something to that effect)
in place. Reading or writing single bytes would be just fine from
purely the filesystem perspective regardless of fs blocksize then.

But if we're talking about the filesystem as the filesystem driver,
then I believe it would make sense for it to rather report the page
size than the block size (at least when the block size is smaller),
since the driver is using the page cache to read and write to the
device.

Anyway, I'm not suggesting to change the behavior, just to change
the man page to state that this actually reports the filesystem
block size, which may or may not be a good IO transfer size. So I
wanted to get an approval for that here.


Cheers,

> 
>>
>> Can someone confirm my interpretation, so the man page can be
>> corrected? Or do I misunderstand or overlook something?
>>
>> Thanks,
>>
>> Zeno Endemann
> 
> 
> Cheers, Andreas
> 
> 
> 
> 
> 

