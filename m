Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C0C8BE9
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 01:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781402289; cv=none; b=c6iKVhcAuuuRMaD92JX6z7WhTQV5TEVEWI4/UCcGfYHAW6Hmmo6JgNV4vCG4pfemLbOYYYSJ+nUKF3QMjyAH/jXv6XryQnlEpHLjYB7GNkr1Zz1YDaA5Tcv3dHO7n2aIKT/ZVw627Ucdx8AFnvWxgqsI8/61X9rgiP9xuV+qRyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781402289; c=relaxed/simple;
	bh=62NVENJ5eFkJ3TNaw/bfOLiLqBBgTzSL84fgzwHMp1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ipncYHo7p4tnjOR+OkdaVsXSD8GcFZoZ9L6WCP1W5M43RSbJrZNW7Q8HK5xGykY4Prdb6OWyjyp8vJprjgpEue8y5x/won24moPWJ7N3pVMwPgKkL9X9c3h4pCDLvVt1jT/8qXmsh3vK/Rll6WZkkj1y+mZdWLOWhNQ18wN5AR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uV+74kii; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uV+74kii"
Message-ID: <7e57e99b-865c-43d9-9f84-2df3f318d03a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781402286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=unvZVA01RCOsE6OHH2kWfSGkp8R7E0svliMMATKZkqc=;
	b=uV+74kiiC8O0Ll78QiLSnyimuryVlqv+vtUZli3RT7nv9VQ4YcfkHCOLL1GDr0qIVdXw56
	xOT2JhAUExDugrj6ZI0SzwQ3/R2x8j6BUnIkYMwBpQ7nppJx3lM+PQE/MiGSjAGbai2G6x
	OA24y1udqeviPhlXS/0JaLsIirPkauA=
Date: Sun, 14 Jun 2026 09:57:58 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 5/6] show_page_info: Remove printing of page index
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
References: <20260608210618.3437216-1-willy@infradead.org>
 <20260608210618.3437216-6-willy@infradead.org>
 <20a5a752-3ed6-4fde-96c9-e8369b15524c@linux.dev>
 <ainCu2HZTTdP4skd@casper.infradead.org>
 <11cc4dca-7841-4897-8665-e27d7555f246@linux.dev>
 <aizL_QrL4dNWMJ8Y@casper.infradead.org>
 <661b47de-af1a-488f-a691-82df7add1f49@linux.dev>
 <ai2CIGzlCeqbOz5o@casper.infradead.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <ai2CIGzlCeqbOz5o@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2026/6/14 00:15, Matthew Wilcox 写道:
> On Sat, Jun 13, 2026 at 12:16:38PM +0800, Ye Liu wrote:
>> 在 2026/6/13 11:18, Matthew Wilcox 写道:
>>> On Sat, Jun 13, 2026 at 11:02:06AM +0800, Ye Liu wrote:
>>>> 在 2026/6/11 04:02, Matthew Wilcox 写道:
>>>>> Thanks, but could you explain why you don't just call dump_page()?
>>>>> It's more comprehensive and will continue to be maintained.
>>>>
>>>> This script is based on the drgn tool, but the drgn tool does not
>>>> have a dump_page helper. What kind of method do you mean by      
>>>> directly calling it?                                             
>>>
>>> void dump_page(const struct page *page, const char *reason)
>>>
>>> in mm/debug.c
>>
>> I’m aware of this kernel function, but could you please clarify
>> how to call it from a user program?               
>> Or how to achieve the direct call you mentioned?
> 
> https://drgn.readthedocs.io/en/latest/release_highlights/0.0.28.html

Note that this feature is currently experimental, only supported on x86-64.
Furthermore, I tried calling_function() a long time ago,
which caused the system to crash, so I haven't used it since.

-- 
Thanks,
Ye Liu

