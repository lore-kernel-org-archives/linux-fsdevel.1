Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613A93D6CD9;
	Fri, 17 Jul 2026 10:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784284399; cv=none; b=bwtVDzLkZPrenKH2lKE3a+BtxdA9nxFxwfuxxLqPzusDL7Irhggg3Zp8KmxPRceAdjV4uiXTFImvDoRwqCnuClO6BIyJn61TqyttRe/CD+iwQjLyN5u7rCKYj4GVNpBH3ide63ZHw1WJToNGtydRPtc6nBGPQAhZHyMONoUb2y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784284399; c=relaxed/simple;
	bh=D2mJYdA02noCO9SqsfdoaHkU4bPaXLhIMZuAlYK09x4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I+mCtY5Ba4lLK8yXUgATaWPK/+tpxJgra/VhO/orV1nIt9y4xjQtKJiE0l+cR5aFp6kleoLZ+y76j81M1aVbUHZGgatL3UGahGcnGrR67UDLX4Um4T7VKoOlufSdozKNsP5xsBCetj/Nqk1rimNikfUo9Tbvn38gJMlwjzC/AXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1kDfPvB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1kDfPvB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE621F000E9;
	Fri, 17 Jul 2026 10:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784284396;
	bh=P0cm1hwFVHhD37uYmsyMG9dA/5yRr65R7XPvICUAfQo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=S1kDfPvBpZQQs9uOE445K6iDJajL4DVc38dR52RDTXOvXg31MarfTsjhsXw8QS9kr
	 9T92PE/rKmvMCGMcv8ZIe8H5iBflX1LWvommv57Yi8/bqE7HlGi5Vhjj113TWsMvtR
	 uF5oiJ9NZ59l5j8l3bPrdkVXJuZsK2OXq+qdGvtkYd9p2c5fnT9gEZY3BVIQu7+Aac
	 gQQ6AH2cSaGdO+S5jgidO80pSpT93I0BD3k33ETYFQsWVrSfANxR6Q5V918ZHoMyvm
	 4GYriLWAEo7t3YODJJkq3BcD9csczqFuRtypm6JdqlwQ2oLXNvy1ujQYV00ZxxTEhb
	 48BAAZisNDmGw==
Message-ID: <2a109ef0-76b6-4e25-878f-b779ce09a1ed@kernel.org>
Date: Fri, 17 Jul 2026 11:33:13 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm/mseal: remove superfluous comments, fix confusion
 around mm
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20260716-mseal-fixups-v1-0-3a9609bf041b@kernel.org>
 <20260716-mseal-fixups-v1-1-3a9609bf041b@kernel.org>
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
In-Reply-To: <20260716-mseal-fixups-v1-1-3a9609bf041b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/26 15:43, Lorenzo Stoakes (ARM) wrote:
> Remove comment blocks that don't add value and eliminate any confusion
> about whether or not we permit mseal()'ing of remote mm's by explicitly
> referencing current->mm consistently.
> 
> Also avoid ugly goto by using an else branch.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  mm/mseal.c | 48 ++++++++----------------------------------------
>  1 file changed, 8 insertions(+), 40 deletions(-)
> 
> diff --git a/mm/mseal.c b/mm/mseal.c
> index 9781647483d1..207fea89c61e 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -16,28 +16,7 @@
>  #include <linux/sched.h>
>  #include "internal.h"
>  
> -/*
> - * mseal() disallows an input range which contain unmapped ranges (VMA holes).
> - *
> - * It disallows unmapped regions from start to end whether they exist at the
> - * start, in the middle, or at the end of the range, or any combination thereof.
> - *
> - * This is because after sealing a range, there's nothing to stop memory mapping
> - * of ranges in the remaining gaps later, meaning that the user might then
> - * wrongly consider the entirety of the mseal()'d range to be sealed when it
> - * in fact isn't.
> - */
> -
> -/*
> - * Does the [start, end) range contain any unmapped memory?
> - *
> - * We ensure that:
> - * - start is part of a valid VMA.
> - * - end is part of a valid VMA.
> - * - no gap (unallocated memory) exists between start and end.
> - */
> -static bool range_contains_unmapped(struct mm_struct *mm,
> -		unsigned long start, unsigned long end)
> +static bool range_contains_unmapped(unsigned long start, unsigned long end)
>  {
>  	struct vm_area_struct *vma;
>  	unsigned long prev_end = start;
> @@ -53,11 +32,10 @@ static bool range_contains_unmapped(struct mm_struct *mm,
>  	return prev_end < end;
>  }
>  
> -static int mseal_apply(struct mm_struct *mm,
> -		unsigned long start, unsigned long end)
> +static int mseal_apply(unsigned long start, unsigned long end)
>  {
>  	struct vm_area_struct *vma, *prev;

I guess using

struct mm_struct *mm = current->mm;

would reduce the churn?


Anyhow

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
