Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F43443F0BC
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 21:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784150402; cv=none; b=Bbe//zEwNzYiKxk0SxY9LMQ31w8DnI0orpIO3MdU4EllfOpU+fLgmFlrS5unWGSsyuvARQVrCj7oFlu3Dc9aHFw/bX/zVnBDnVVFTAVcGfTNdG4ATN+usXmwyV74q7zrNZKIdItvY4MZGCtKdibYR+Tuek7BGh9KbwjlVRMjnCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784150402; c=relaxed/simple;
	bh=BOdZl3cq00AzYeW8z996EYPmcGSofztCT/Ahs+iayr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzZbV7eM04xl6fBFoBLUlIa5gYjpt7x8DVr7rS963zgUW/JF7QaWbbJ2RyaD8v+u8LznbSeIWDFaJ9Vq0GuNg1isLtv7zgsVbfmYPk7wfyniTXeyXYxRV1ubh3rCaTyIeR2m7g6aBluIkCZoKY/HVByM7DHnH9kMVfQ0cUt7RuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ndcNodN9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ndcNodN9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=F4Wch7h5bGb2mJ7phUTBuKN4sBgWUpS//Phrn4g4iYY=; b=ndcNodN9bX18zzzSX7ez/6W5VV
	1L7shNryZ52R9d/L70Yw6Ch+Tw8EN5wFoANpRVRsx05HEhBRTfxfB5q4nWa1z5vacmyLf+ALLcqGV
	RIIHKiztXxUuABPuQrpmEIZgkLn3xs5LQVHBnAQ47Ma+Ywfu2ZMeqDVq0RGHbdP3oG/mI8h3QJRYI
	oMb2R9+V91DE4JHARBpdZAmIkDdzNSPsS11wLK+GoGBroEV3jiFvOEpVRYRon+Mp836bRtCW5cr8A
	KEPylQj2k6ojeeYXQw1geIqsUJZ/FqkDIMDXKtCpbdsveosFLJ8WafOoPX4vH/bFq0vfX3f6d/rPg
	sy5Yxy9Q==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wk711-00000000yiu-2mZq;
	Wed, 15 Jul 2026 21:19:39 +0000
Date: Wed, 15 Jul 2026 22:19:39 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Usama Arif <usama.arif@linux.dev>, Jiaqi Yan <jiaqiyan@google.com>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>
Subject: Re: [PATCH v2 06/10] memory-failure: Prevent UAF in raw_hwp_page list
Message-ID: <alf5a0HI-vkEGUEz@casper.infradead.org>
References: <20260709184740.1286561-7-willy@infradead.org>
 <20260710150204.1887475-1-usama.arif@linux.dev>
 <alEpBqExnyvBnnxi@casper.infradead.org>
 <alZw5EdYVYCRNyj4@casper.infradead.org>
 <3251bb16-be46-f752-a6ff-a6c3181f49b2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3251bb16-be46-f752-a6ff-a6c3181f49b2@huawei.com>

On Wed, Jul 15, 2026 at 11:19:59AM +0800, Miaohe Lin wrote:
> > Since we don't have a refcount on the folio, it can be freed at any
> > time, and the hwpoison list head can be reused for literally anything.
> 
> Sorry for late but could we hold hugetlb_lock here so hugetlb folio won't be freed
> after we fetch the lock? We can recheck that the folio is still hugetlb and hwpoisoned
> once we've got the hugetlb_lock.

Hm, but we still take the mf_mutex in is_raw_hwpoison_page_in_hugepage(),
and we don't usually like to sleep in predicates like this.

We could introduce a spinlock to protect the raw_hwp_page list.  Any
objection to that?
