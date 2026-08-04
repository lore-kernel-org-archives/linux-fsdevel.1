Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9C947011D
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 16:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785859473; cv=none; b=dCZTCDyWSSl/lFVuN1Mlawi7+L8HwG2hcQNj9qclWlPzffj6dx42mICPe9rXier8xTDHL2IFqhUF2mhqYAWoGVk8If0eYGePic02CLa4HnPAy5cuchvAHXK9Qnw8FWnVkPeVbgVtigrvo6gPtFgpId1yZ5YVEsnigclSscsq+aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785859473; c=relaxed/simple;
	bh=VmO0ctnM70SsrstgIW4MoOKZ6VNpWbLYtRvUpH91VQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0jIUVg0c5hKQRzLqgNIv/9l+otwjiid4GDvDc/ipfTtOD8C4zZsD1D//Qd3uSacPolTN15Gy/00HFFJ+3lXaBvk0TZKxvYBtp3qeHZjjeg1kodGMxnQFzr4Aho85J7raNJ8Md0N3XkRHiGcaCC7VqVOmABHlyocGJrWPz8GSuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bEnrVsf1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bEnrVsf1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HPGFb2a9ru0laCvBoo6NIQpxhSh82ifg8Ri5BJ3BrHg=; b=bEnrVsf1XukxCxreZq9cQGE+LE
	Ludn6I9vlnB/S8i/onQ8Z5/SkgETu7b7vTu3bYKER3eXURLZ2xkpCKIJHURo1OopyZ0v3zjqoTvO7
	e5oleAWNXgWfg+Eetrfms2qwlAJOQ+pBa4u9s//NSJA3LuFxzSMEu3utdH7KCfuWCFvkiVs0O8rwB
	9cN8rVZtUipgZfE/oBB5ld7T42HbZFFgTWJSXT15IkMl8xsg6kOcbj5fNgY0P/2shxMamFnAZhcex
	O8AJgrSAx4603J0IWRP99BjIMPreQl7yJeIr+pq3+Tu/vPxKe//ooAhzAM+PO+iVrMikYsTOC4DB/
	gUDMi2gg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrHcm-00000004Dkw-0qDA;
	Tue, 04 Aug 2026 16:04:16 +0000
Date: Tue, 4 Aug 2026 17:04:15 +0100
From: Matthew Wilcox <willy@infradead.org>
To: jane.chu@oracle.com
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>
Subject: Re: [PATCH v8 08/15] hugetlb: Use the has_hwpoisoned flag
Message-ID: <anINf2GGBz0vADPI@casper.infradead.org>
References: <20260731200802.574821-1-willy@infradead.org>
 <20260731200802.574821-9-willy@infradead.org>
 <9b2cd903-7800-4c45-bc07-dca0ee40331d@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b2cd903-7800-4c45-bc07-dca0ee40331d@oracle.com>

On Mon, Aug 03, 2026 at 11:51:42PM -0700, jane.chu@oracle.com wrote:
> So, we now have two sets keeping track of folio level hugetlb hwpoison
> status: one with PG_has_hwpoison, another with (PGTY_hugetlb + bit23) in the
> .page_type field.  I don't see a better way though.

Yep, we end up marking the folio two different ways.  I don't love it
either, but I haven't come up with anything better.

> Reviewed-by: Jane Chu <jane.chu@oracle.com>
> 
> thanks,
> -jane
