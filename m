Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6DB2F1FF4;
	Mon, 22 Jun 2026 12:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782130817; cv=none; b=WRYvGXwo4BfJxZkzgLGpQWs+BdWl6Jf6Wn7pER+xDyX/r4JoJfA7uP2gY4dm0IJGExTq2uWdEwExAeRlVJFihIKwdC11LlVfpUuwmgmfRYLbgYhuNwG/k4giCtm7ZuRrxNo7ZLYcc5whlhf19IOibbQr8qA1c+Bo/T0yS88mVIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782130817; c=relaxed/simple;
	bh=OrQXfx7uDMhRKWVSEdkG0//atS5bKeZfGc7UyIlpxqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JH9vaWxxYfh3lkq5LqJKUDKNad24fCemB/9xj1T0B2bf2D17f8wyrIIwnd3u7lXmBE6IlzCjhgspWqB1NUdjvN5q51QZmTAXUNlf7JqjNyC+9UAX39VuXtDfqG5WNknVnOAJL4xjaKVkl8yaK2zvfYj9ZDpDwKyMZwWDX1kaHuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luy7boXg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luy7boXg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6F11F000E9;
	Mon, 22 Jun 2026 12:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782130815;
	bh=z+jtKgtQRID1XboOt93fMS9cJd+U+n9q6G3fzyc6a1M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=luy7boXgMRCgMq/tUfI1wfzfmcive9UU4DJ19R0fpFwYoTGnBsq5p3nIGX0jldpNc
	 K/c9+uIFkBZ2omHr3NfuqAtxFqEZN0jOM7dZ9zTcuiGyCcqlc3d3vrBY+1RRJed3hN
	 mmk5vfNWLv/rYyQ8H0qL4YECc+9MbWqyAcSvZvmQXn/fqcPFrvKJMNLkmec8T5txn3
	 8DY/Rz+CW0FFmcgT/+lFVsKiId+KAayti49xdhx5dbmNbctn8GZqnzf10H//k2Cj+z
	 gC1VZdvIlST0XPAf5x2PnBGkx3FJ/yHGvurnCBNWbPnrLfLSjLf94IX0ZCuyGoYk6V
	 Meo+f/Q8gtkPg==
Message-ID: <eba18827-5ef5-464c-90f0-2444a996acac@kernel.org>
Date: Mon, 22 Jun 2026 14:20:07 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/31] Introduce SCMI Telemetry FS support
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, arm-scmi@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 sudeep.holla@kernel.org, james.quinlan@broadcom.com, f.fainelli@gmail.com,
 vincent.guittot@linaro.org, etienne.carriere@st.com, peng.fan@oss.nxp.com,
 michal.simek@amd.com, d-gole@ti.com, jic23@kernel.org, elif.topuz@arm.com,
 lukasz.luba@arm.com, philip.radford@arm.com, souvik.chakravarty@arm.com,
 leitao@kernel.org, kas@kernel.org, puranjay@kernel.org,
 usama.arif@linux.dev, kernel-team@meta.com
References: <20260612223802.1337232-1-cristian.marussi@arm.com>
 <20260617-waten-allabendlich-zueinander-93d4b1367b8c@brauner>
 <ajLVW1eHzbGDm4yn@pluto> <29a304f0-1e62-418a-b84f-aabdc4c0de8d@kernel.org>
 <ajR_FBWOoXJKSeoH@pluto> <0025b907-27b9-4a51-b78f-f8ad413644d0@kernel.org>
 <ajU7UqwPZBlwRGkf@pluto>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzS5EYXZpZCBIaWxk
 ZW5icmFuZCAoQ3VycmVudCkgPGRhdmlkQGtlcm5lbC5vcmc+wsGQBBMBCAA6AhsDBQkmWAik
 AgsJBBUKCQgCFgICHgUCF4AWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaYJt/AIZAQAKCRBN
 3hD3AP+DWriiD/9BLGEKG+N8L2AXhikJg6YmXom9ytRwPqDgpHpVg2xdhopoWdMRXjzOrIKD
 g4LSnFaKneQD0hZhoArEeamG5tyo32xoRsPwkbpIzL0OKSZ8G6mVbFGpjmyDLQCAxteXCLXz
 ZI0VbsuJKelYnKcXWOIndOrNRvE5eoOfTt2XfBnAapxMYY2IsV+qaUXlO63GgfIOg8RBaj7x
 3NxkI3rV0SHhI4GU9K6jCvGghxeS1QX6L/XI9mfAYaIwGy5B68kF26piAVYv/QZDEVIpo3t7
 /fjSpxKT8plJH6rhhR0epy8dWRHk3qT5tk2P85twasdloWtkMZ7FsCJRKWscm1BLpsDn6EQ4
 jeMHECiY9kGKKi8dQpv3FRyo2QApZ49NNDbwcR0ZndK0XFo15iH708H5Qja/8TuXCwnPWAcJ
 DQoNIDFyaxe26Rx3ZwUkRALa3iPcVjE0//TrQ4KnFf+lMBSrS33xDDBfevW9+Dk6IISmDH1R
 HFq2jpkN+FX/PE8eVhV68B2DsAPZ5rUwyCKUXPTJ/irrCCmAAb5Jpv11S7hUSpqtM/6oVESC
 3z/7CzrVtRODzLtNgV4r5EI+wAv/3PgJLlMwgJM90Fb3CB2IgbxhjvmB1WNdvXACVydx55V7
 LPPKodSTF29rlnQAf9HLgCphuuSrrPn5VQDaYZl4N/7zc2wcWM7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <ajU7UqwPZBlwRGkf@pluto>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

>>>
>>> There is more stuff that indeed is configurable per the SCMI spec
>>> but these additional params are hidden into the SCMI Telemetry protocol
>>> layer (the initial patches in this series) and NOT made available to
>>> the driver/users of the protocol (like the SCMI FS driver that sits on
>>> top)
>>
>> Do you assume that there will get significantly more config options added in the
>> future for user space to configure?
> 
> No, I dont think so...the only planned extensions were to support more
> performant read access mechanisms, i.e. direct mmap'ability of FW/Kernel
> SCMI Telemetry shared memory areas...BUT that will immediately dump all
> the bulk of the lower layer protocol work into the tools domain...and

Right. I guess you would hide that in library code, and provide a stable API
towards tools such that they won't have to worry about the implementation
details regarding how the values are obtained exactly.

[...]

>>>
>>> ...most of the other entries in the tree are simply RO properties of the DEs
>>> that have been discovered at enumeration time.
>>
>> Is this bulk-reading relevant for performance or just a "nice to have" ?
>>
> 
> I suppose depends on your usage pattern: it is definitely relevant
> because the main collection mechanism are shared memory areas (SHMTIs)
> between the platform firmware and the Kernel: such areas being accessed
> from 2 differnt worlds concurrently come with a SCMI-specified
> synchro/consistency mechanism based simply on a pair of sequence numbers
> placed at the start and at the end of the SHMTI, so that the FW increases
> such magic numbers in a well-known way before and after updating the SHMTI
> values, so that the kernel can detect (without any interlocking mechanism)
> if a platform write happened in the middle of its reads...

Okay, so sequence counters to detect concurrent changes and retry.

> 
> ...so if you read one single DE 64bit value, under the hood the kernel
> would have had to really perform at leats 3 reads from the SHMTI to check
> the consistecy of that single read...
> 
> ... while if you do a bulk_read the overhead due to the consistecy
> checks gets 'spread' across a number of DEs because the kernel will snapshot
> the whole SHMTIs (potentially KBytes) between the 2 consistency reads

That makes sense.

I guess a user space library could implement some kind of caching (bulk-read,
then provide clean access to individual DEs) to hide the details from the tools?

> 
> ...the good side effect of all of this is that I can leverage such
> sequence number to optimize reads..i.e. do NOT even try to read anything
> if the new sequnce number is unchanged from the last one I cached on the
> last successfull read of this value...

Right.

> 
> So at the end I would say it is NOT simply a nice to have BUT it is
> certainly only the first step towards a more performant alternative access
> (like with mmaps)...it depends on the usage pattern...I am not sure what
> mechanism is used by our tools more...

Okay.

>>
>> Yes. How high-priority is the fs side? Or would a tool using a library to access
>> this information also work in the first step?
>>
> 
> I have to sync with tools on this...because they are stiil probably
> using currently the FS, but it was already planned for the future to move to
> a more low level access (ioctl/mmap)...
> 
> ...my aim would be, at this point, to favour this transition without sudden
> breaking their current world (and have to expatriate :P)
> 
> ..from my personal point of view, I would certainly like to still have the
> FUSE layer for ease of testing and verification on my side...but it is just
> a nice to have... 

Okay, what I thought. I assume the most important part is to be able to grab
telemetry data in an efficient way on a system to then share it with some
monitoring agent. Manually digging through the FS to inspect data (debugging,
..) is probably less relevant for the target use case.

>> Okay, so a single writer (admin) changing stuff could get picked up my possibly
>> many concurrent readers?
> 
> Mmm...not sure what you mean here...
> 
> If you configure your Telemetry as you desire and start collecting data via
> readers, BUT then some other process changes configs under your belt, that is
> allowed as said, and so your analisys could be impacted...(something turned off
> as an example, or update interval changed)...

I was rather wondering about "turning on more" concurrently. But yeah, makes sense.

(it's the same situation other system-wide settings. If one app enables KSM and
the another one disables KSM, inconsistency is unavoidable)

>>
> 
> Thanks a lot, David !

Let's hope for some guidance regarding the FS side soon.

But yeah, avoiding the in-kernel FS sounds completely reasonable at this point.

-- 
Cheers,

David
