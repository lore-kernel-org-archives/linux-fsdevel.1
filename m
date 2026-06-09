Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3601406831
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 11:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781006384; cv=none; b=cWVTO2GhSpgB325e6NkEpRyQRGdjAm0tCZH6jcV6GUjJNCUTnTnnYrFyPn15SHCH67jr+PYVjxAp6zB3STSRF4OFH9q9iiG8BOcyf/hFmMLf5IeKH294zPpOQxstDhy1AcOgKnMvcueC5tTmVCT5ABX5JQYzax/17qOeeqAAHUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781006384; c=relaxed/simple;
	bh=Y1XBy/XKlXfPSyfzlua43AGQHQa4DWkXRzOD3IFCAiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lmUuiT4lc99cJUpj1r5mAR3bZAQVJJ4Jnbpbg3R3JGtQka+fvDydaUlRQ/FYNyhIqArUjO/DZuGLknObn2Ihn3niOi85G6PV+hnzZOrp/WCHOmYGdKRs92dSMAIl1kDeg1b2Qgn0M7IKENifNqbyvE/m/QbSD50GqfrewR/qrmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cIpcJ107; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cIpcJ107"
Message-ID: <20a5a752-3ed6-4fde-96c9-e8369b15524c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781006377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PsVnYhIRaQyLsI7wGZnt+j8rEmItGadYiQfITht1l40=;
	b=cIpcJ1072g3I1dKqv0Ca69HML96nJElqAoZ8z4AVUqYSYFsvIBHxr8BwtOAlSIVne2rW75
	zDmSS7paluzm4H1qdvSGWBUv8bkZydbVqTI3ymojalBokgUP0npFKUnkHRUhjh7GR9hvBo
	DpSns+Pw7KvtyFE+ixabb6PtUYL0TQk=
Date: Tue, 9 Jun 2026 19:59:28 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 5/6] show_page_info: Remove printing of page index
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20260608210618.3437216-1-willy@infradead.org>
 <20260608210618.3437216-6-willy@infradead.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <20260608210618.3437216-6-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2026/6/9 05:06, Matthew Wilcox (Oracle) 写道:
> Pages don't have indexes, folios have indexes.  Just delete it.  This
> script is going to become increasingly barren unless somebody steps up
> to maintain it.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Ye Liu <liuye@kylinos.cn>
> ---
>  tools/mm/show_page_info.py | 1 -
>  1 file changed, 1 deletion(-)
LGTM, thanks for cleaning this up.
Reviewed-by: Ye Liu <liuye@kylinos.cn>
>
> diff --git a/tools/mm/show_page_info.py b/tools/mm/show_page_info.py
> index c46d8ea283d7..69094ef50719 100644
> --- a/tools/mm/show_page_info.py
> +++ b/tools/mm/show_page_info.py
> @@ -91,7 +91,6 @@ def show_page_state(page, addr, mm, pid, task):
>              "Page Virtual": hex(page_to_virt(page).value_()),
>              "Page Refcount": page._refcount.counter.value_(),
>              "Page Mapcount": page._mapcount.counter.value_(),
> -            "Page Index": hex(page.__folio_index.value_()),
>              "Page Memcg Data": hex(page.memcg_data.value_()),
>          }
>  

-- 
Thanks,
Ye Liu

