Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141D83D566D;
	Mon,  1 Jun 2026 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780326088; cv=none; b=icgGUGKl++tPkxwLXGBeqDj1G0ht9h0VCBXwM3pgBlz2k1yhBYBuSCJkpZIABNLQhjv7HyzCftqrOoawdgGrgKDTnrRq2HgUj8gYl8gwd9qAKI+YvSTbV8Lo+haSH15ci6XTJvPpNXeaKKZmUGY+GQF0sLztefb24cX2rws/S1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780326088; c=relaxed/simple;
	bh=T+9OidaIUilLTsX/Ppu7NzNK5qHjeUEsUqBeF8ygZNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S8bY30Lef4owSOqTeWIhDgcZu7j5kzyp5/+yGxq7mH8q5cWmu+XCBNtTGgtNsidA/GBkraAiy2yEQkxxL/NODMYRll3IcC6AbBTqhYXxCPQilbDozI4HJ4AvgW3S3+EvhzwvYE7bOi8FNvMmuuppFvzKDSBHFYXWSb6NPM/def0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pyMrlwCt; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pyMrlwCt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=gs1LnQHwscIGOezLFRdkXnucnz6eylm4BeP9xClXfcw=;
	b=pyMrlwCtkrR3IwqfKd3dRm0ws7iTb7jxKulkntCU9nuTIenpcDtTPEY+bTxRMf
	LhaI7TWZ/AClxIjTKhpPw20G2ppc0L1cNiDZTmaPzc1kDPYvbJ9e7DYBYIuaQMFF
	m506Z+HEN3NXzszU8+YJOYkfNz9VGKz8kEDKelpWylSe4=
Received: from [192.168.5.171] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDHj1iQnh1qRxFoAw--.64263S2;
	Mon, 01 Jun 2026 23:00:32 +0800 (CST)
Message-ID: <a5a3b691-0613-4731-8850-1cfadb5afbc3@163.com>
Date: Mon, 1 Jun 2026 23:00:32 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] mm/shmem: optimize file read with folio batching
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chi Zhiling <chizhiling@kylinos.cn>
References: <20260601055704.167436-1-chizhiling@163.com>
 <20260601055704.167436-6-chizhiling@163.com>
 <ah2QKCFWdzXIW448@casper.infradead.org>
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <ah2QKCFWdzXIW448@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDHj1iQnh1qRxFoAw--.64263S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUYL05UUUUU
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC+BCtS2odnpAZBwAA3p

On 6/1/26 9:59 PM, Matthew Wilcox wrote:
> On Mon, Jun 01, 2026 at 01:57:04PM +0800, Chi Zhiling wrote:
>> +			if (folio_batch_count(&fbatch)) {
>> +				for (int i = 0; i < folio_batch_count(&fbatch); i++)
>> +					folio_put(fbatch.folios[i]);
>> +				folio_batch_reinit(&fbatch);
>> +			}
> 
> folios_put().
> 
>> +	for (int i = 0; i < folio_batch_count(&fbatch); i++)
>> +		folio_put(fbatch.folios[i]);
> 
> Also folios_put().

Thanks, I'll replace it in v3.

