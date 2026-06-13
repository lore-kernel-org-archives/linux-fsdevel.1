Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF3B3FCC
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2026 03:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781319737; cv=none; b=iQEo4B+ML5WWUqn+r+kBruj4XFjsB0JGwta5sbn/oWCscvXmcriBGRGRHwUng3YvRD4726Xt8I0rtaJu8GH6iSYhbcHdn6H7dFJQj0UXMfI0rrEyBt2pLaygNSRmlrnOXpl26nsfFHvQxooKvJrvV1FdkTi+4lv8HhDWvrr9B8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781319737; c=relaxed/simple;
	bh=vYszFaKvRIyYVB4zBTlAZN78JCe2QvUNipgr9IDE5Ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=umN5OJnzIZkUAPUmw8EO6dZuEBC6PWp0qSA+wnFLLny12bz3drxrKkwNfvU0RjNQFzMIyh1I3hJeKJwAh4ZD5X0+8g1uokFZ4ZaEReouAYvW1mAY82/eJpy/FamQCdDBbqIraOqqj27nTNo2vJ5TJ3EKMYnWDnxgXNQ/23BYNDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xbwJYM1o; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xbwJYM1o"
Message-ID: <11cc4dca-7841-4897-8665-e27d7555f246@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781319732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jVF7Nd9sgnw6E/OlYL+ByO7ePMRW+XqPGuLnJaLouec=;
	b=xbwJYM1omO378wP9o0JnW/erUDrv/d8m/bFHUTCTOwwN0krhSGZDZl29z1bPEscLuryVsI
	8LnWDI9J/kyRYVDz7dAczCccGUeUVJ5tM6fK9NFiJOoLweW5hkSSY21iyjLl2niMdmk5OR
	N0s3aXDAMGn9kypBurlbT8CInmZvXEA=
Date: Sat, 13 Jun 2026 11:02:06 +0800
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <ainCu2HZTTdP4skd@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2026/6/11 04:02, Matthew Wilcox 写道:
> On Tue, Jun 09, 2026 at 07:59:28PM +0800, Ye Liu wrote:
>>
>> 在 2026/6/9 05:06, Matthew Wilcox (Oracle) 写道:
>>> Pages don't have indexes, folios have indexes.  Just delete it.  This
>>> script is going to become increasingly barren unless somebody steps up
>>> to maintain it.
>>>
>>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>>> Cc: Ye Liu <liuye@kylinos.cn>
>>> ---
>>>  tools/mm/show_page_info.py | 1 -
>>>  1 file changed, 1 deletion(-)
>> LGTM, thanks for cleaning this up.
> 
> Thanks, but could you explain why you don't just call dump_page()?
> It's more comprehensive and will continue to be maintained.

This script is based on the drgn tool, but the drgn tool does not
have a dump_page helper. What kind of method do you mean by      
directly calling it?                                             

-- 
Thanks,
Ye Liu

