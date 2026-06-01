Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE85374E46;
	Mon,  1 Jun 2026 14:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324839; cv=none; b=PuwizmII3ZZJ06eOC6ExIE/7gpwt13i2mM3gZWrPUWzg+ugSSMrMTSc7xNkHKpIuJ/C9Ce3G9WmQW7s5vzl/G+RQ3NT5S75chhT2UHZB0J2FXRDAvdaENjOY21YxDtqL1CV3x5G4ARtzCphDjAEjAHeexFQwey2z0JqCaXuZC94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324839; c=relaxed/simple;
	bh=n4K0F6hT/suZTqp9Y4qRaK1zjvLuAK7b16Mjd/xBuSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D512ZiT/hLJfAbZunBoCF83LCqFu1LqDqqrBRN3mC+dGPoGBlVu46oyTruTW2AX2yrbFczK3ARYIM4PrAjSWN/dW+JIZ/M877Z8S/BdgMXCgcq65PSN0jX3q9jibvRkXbnzwk/H+tB3xB7iblMbhMusHWF0lewYF5cDt6eyDa7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fgGD4KVC; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fgGD4KVC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=cK3Gvdkr36jX3698KQfjB7612HPZkiyqbqTCq+0O2Zo=;
	b=fgGD4KVC/pxxMfdfYdAGu3GTLt3YblGkg7TREETQGp6bT1xHZG8S4t4ykXLseU
	/JJEUPTchNKRdzrkTFYDA5aPKt7xHvev9XrnZxzxjAvJV1hsFWgGpy1LRYRU+iMW
	59qTYhZ26lDAjAodQVsMdrM+uhrDFTsifquxSA4ZQ8PS0=
Received: from [192.168.5.171] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCX9fmymR1qF8kFAw--.654S2;
	Mon, 01 Jun 2026 22:39:46 +0800 (CST)
Message-ID: <c6d65420-c4f9-4211-b9d8-1040d99379d0@163.com>
Date: Mon, 1 Jun 2026 22:39:46 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] mm/filemap: reduce unnecessary xarray lookups when
 read cached pages
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chi Zhiling <chizhiling@kylinos.cn>
References: <20260601055704.167436-1-chizhiling@163.com>
 <20260601055704.167436-2-chizhiling@163.com>
 <ah2ARWo_EiVOaWDI@casper.infradead.org>
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <ah2ARWo_EiVOaWDI@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wCX9fmymR1qF8kFAw--.654S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF1DuryUXFW7KrWruFyxGrg_yoW8WFyxpr
	Z8Ka4kCrWUtayakrnxtF1fZa4F934Fqay5Aa4Ig34SvFn8JFnIkr97Ka45Jan8Zr4kJF1x
	Xa18Za40ga15t3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UI_M-UUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC3BJ0EmodmbIWBwAA3l

Hi, Matthew

On 6/1/26 8:51 PM, Matthew Wilcox wrote:
> On Mon, Jun 01, 2026 at 01:57:00PM +0800, Chi Zhiling wrote:
>> From: Chi Zhiling <chizhiling@kylinos.cn>
>>
>> When reading small amounts of data from the page cache, only a single
>> folio is typically returned from filemap_read_get_batch(). In this case,
>> calling xas_advance() or xas_next() after adding the folio to the batch
>> is unnecessary and only introduces extra branches.
> 
> I don't think xas_advance() is all that expensive.  The expensive part
> is going to be calling xas_next() and realising that the folio now lies
> beyond the required range.  I think you'll get just as much benefit from
> doing this:
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 4e636647100c..578b03bd5514 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2459,11 +2459,14 @@ static void filemap_get_read_batch(struct address_space *mapping,
>   	XA_STATE(xas, &mapping->i_pages, index);
>   	struct folio *folio;
>   
> +	if (index > max)
> +		return;
> +
>   	rcu_read_lock();
>   	for (folio = xas_load(&xas); folio; folio = xas_next(&xas)) {
>   		if (xas_retry(&xas, folio))
>   			continue;
> -		if (xas.xa_index > max || xa_is_value(folio))
> +		if (xa_is_value(folio))
>   			break;
>   		if (xa_is_sibling(folio))
>   			break;
> @@ -2480,6 +2483,8 @@ static void filemap_get_read_batch(struct address_space *mapping,
>   		if (folio_test_readahead(folio))
>   			break;
>   		xas_advance(&xas, folio_next_index(folio) - 1);
> +		if (xas.index >= max)
> +			break;
>   		continue;
>   put_folio:
>   		folio_put(folio);
>>

Looks good. I'll include it in the next version and make the same change 
in patch 2/5.

Thanks!

