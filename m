Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1767E1AAE28
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2026 04:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781324270; cv=none; b=oAOwQkqo2IGkM36Nku7ImM4FBBPFpzj60ZpB24Un7ca1skXkUzWoSps+4ko353r6jS/871OUrat+0gbfIJkC+b82rIG0S5tWdHy3BataD9gkWETz0lAWEGfm2k2oT27d90uvKH/n2IBxFpCc68B15TEZqTjy6zZKElLfd/MoCoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781324270; c=relaxed/simple;
	bh=oZKGiGlPYCg8I+ID3TpyrCLGRnGdcxdWBfokegTJqo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ec2v2BQ/dPBquneBhn0QWPRN08fWou9qWMe0OkqLpOGrAxBQpG+IGYYDFjNRaYJAk9Y3wMH9rVHFGAair9t9E94K3BmbdnfjGBSkOE6SFOjiZTKAHEtcL/DzjXT1j/gi/QSxLwysi6/rEM2TX6CTeGMtj6Kl9gAjV6wrTOG6pZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xJza6x1T; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xJza6x1T"
Message-ID: <661b47de-af1a-488f-a691-82df7add1f49@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781324266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lcQKZ3Zx433YnbmCCBs9ea4yshxodmQHfHdKd6s7mwY=;
	b=xJza6x1T5OLJx+L4ldxhJ8F/UUA3Cmze9+E8XxRLhbAltPSM7Lg3gqn1gccCAvQ0KTXj6v
	eTvbvyWlk7mXNOH1AA1jhha5L7nIh2ELAYX8PUJ31Nbzume6UXYMTxplNl/YyYkx2htjZD
	rdqoS/ucZjITP2QQHjZvtoZockmzkZM=
Date: Sat, 13 Jun 2026 12:16:38 +0800
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <aizL_QrL4dNWMJ8Y@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2026/6/13 11:18, Matthew Wilcox 写道:
> On Sat, Jun 13, 2026 at 11:02:06AM +0800, Ye Liu wrote:
>> 在 2026/6/11 04:02, Matthew Wilcox 写道:
>>> Thanks, but could you explain why you don't just call dump_page()?
>>> It's more comprehensive and will continue to be maintained.
>>
>> This script is based on the drgn tool, but the drgn tool does not
>> have a dump_page helper. What kind of method do you mean by      
>> directly calling it?                                             
> 
> void dump_page(const struct page *page, const char *reason)
> 
> in mm/debug.c

I’m aware of this kernel function, but could you please clarify
how to call it from a user program?               
Or how to achieve the direct call you mentioned?

-- 
Thanks,
Ye Liu

