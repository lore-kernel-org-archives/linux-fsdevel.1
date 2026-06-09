Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2557E31197C
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 12:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781006846; cv=none; b=hsNKzTZzf98S0d936B2nzRJddBMvL9DSXkGA3Cjx1ih2RMgaj5Kh1YOG49U9+7IcdU1FSkc849XjoVulejNZDUBcSYkDQhGanr4ZloL1YXhMaijex/5hrAQiV+hblgie08rBfdlbuSG5LLtznvipX4SrPjFZxnQezUH3QDg87e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781006846; c=relaxed/simple;
	bh=ksd1/Smph24qSi5AaUUSqL9KjsRU4ExpyevgbIMyaiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHkN8zCjoE/aNtX50JKQd+KNTkadTR6SW8wnPN93XHhoy3RZA13Mc21iaUGQMr2yus7o46Dh4xMwWKKPfe5y8SQmfi6wK6xkDdAKAJqYxcFlsez/ahgsbEt7ftLaOF240jGntvj1Yt++t/D4afnIxOFCvioJ+YFyxOkZbm949UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WZrwDR1d; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WZrwDR1d"
Message-ID: <cff57120-f2b6-44ec-b4cf-b7d5d8637723@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781006843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oQV1qTMhPd4s+f85QfPCGgKH/8NH/n1/pSa26JOffws=;
	b=WZrwDR1dbDAxxV3rcVSBtMHFC0p79DyleGzg3tzrI3PDp9bc98p5olVHu4Gyo+iSI3YUPy
	QhfFwYhx7YBdF6WxhgJs3ZHexNJuNQlDKm2JHuILHC+ERL2XwPCmO0Kvcpl5hORriOJx0b
	37tyfmeCWOwMbGalha94x4Wcsde3Gs0=
Date: Tue, 9 Jun 2026 20:06:31 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] Remove __folio_index again
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20260601192626.150804-1-willy@infradead.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <20260601192626.150804-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2026/6/2 03:26, Matthew Wilcox (Oracle) 写道:
> I renamed page->index to page->__folio_index a year ago.  That proved to
> be insufficient to prevent people from using it, so take more extreme
> measures.  This breaks tools/mm/show_page_info.py (I expect) but since I
> don't know python and have no interest in running this script myself,
> I invite the author to fix it.
I am the maintainer of the show_page_info.py tool.
I've been quite busy lately, so I apologize for not replying in time.
I noticed that you have already fixed it in the v2 version,
and I have reviewed the change.
> Matthew Wilcox (Oracle) (3):
>   ntfs: Correct use of folios in handle_bounds_compressed_page()
>   ntfs: Remove references to page->__folio_index
>   mm: Remove __folio_index
>
>  fs/ntfs/compress.c       | 54 +++++++++++++++++-----------------------
>  include/linux/mm_types.h |  9 +++----
>  mm/zpdesc.h              |  2 --
>  3 files changed, 26 insertions(+), 39 deletions(-)
>
-- 
Thanks,
Ye Liu

