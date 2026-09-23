Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62E9569F3A
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 19:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790192089; cv=none; b=JflmtC+G628SAPsmnKUxrNrkK8m+5pFTDnAcW2sM1uiJ3NfLhYnq2xftUxtbM/y8C0zXYFpsxqV7xCSfqSlwbEKwaEQ89FinKIiBu9ayRUz9X9l7ZlECglPB3bSmGKShccG2lwh8Dc2FbGpZP1wr3xAaKkzqaMFW//2A68Abqdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790192089; c=relaxed/simple;
	bh=MF9MFC2iO3jESf5ilTutVGneXV2XkgYAeSP4AI9HvVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PO6EwEkbw/GJT9CuwSDh/BAWYxH/7TDt6BsaSEoxYihuJ//QdUzrkamdGNAtm2wcg9RAp3xsA1sjzJo9PbTBUtQiqL09ZdM2e72u7+Cf9obl/zA3vnS2sO5mITIL5P746m9Yw1uelCtBC6jWf++VOhwSRrOO1hGMhbaGFHwUR+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=blR1CfZ/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="blR1CfZ/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MC7bV1KDRC3HAA0Rfk68aX2zLG1AyMKOviMoLr6oKFE=; b=blR1CfZ/ar4yWsnTXxlRiOfmqL
	wcUAcB+fSXQGdvYzGqfCtXoSj/AowUSXI+fw0u4iXUftBNriZzYVBRA+RZovC9aiV2RAuAw9XyRnG
	ZPwdXA887Gbu2lqgB7XCh/7nATWVn4CGY90jT/Re7CgbPl0cXGFTCN9LdLZqv2bcyrBCVVW1hCqcU
	FR1xZ087BQPFlcLIQkrzp9Ajxj1Fq2BhqoGjDwNfTO6SMf12IrPkrdqKv9ksZvDTBO9rHQ4LVRFKz
	6OZosb1GC1v+FXYgXWesG9xUPNIUD4PVWs2dFmf1uZo/w+GGj/qQDA34tjicCSgFh1eFnLUIUcDaq
	kAXOCoiA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9Sjl-0000000EFZU-0Xhc;
	Wed, 23 Sep 2026 19:34:37 +0000
Date: Wed, 23 Sep 2026 20:34:36 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>,
	"Gregory Price (Meta)" <gourry@gourry.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org
Subject: Re: [PATCH v9 09/15] mm: Remove locking mf_mutex in
 is_raw_hwpoison_page_in_hugepage()
Message-ID: <arQpzFI6KzFNWk5w@casper.infradead.org>
References: <20260805210557.1118966-1-willy@infradead.org>
 <20260805210557.1118966-10-willy@infradead.org>
 <6c6968e8-b644-86d1-97d1-236170e9dc3c@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c6968e8-b644-86d1-97d1-236170e9dc3c@huawei.com>

On Fri, Sep 04, 2026 at 02:35:25PM +0800, Miaohe Lin wrote:
> > @@ -499,7 +499,7 @@ struct folio {
> >  			void *_hugetlb_subpool;
> >  			void *_hugetlb_cgroup;
> >  			void *_hugetlb_cgroup_rsvd;
> > -			void *_hugetlb_hwpoison;
> > +			struct hwp_page *hugetlb_hwpoison;
> 
> It might be better to rename it as _hugetlb_hwpoison, i.e. with "_" prefix,
> to keep the naming style consistant. Anyway:

The '_' prefix means "don't use directly", but there's no reason not to
use it directly.

> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> Thanks.
> .
