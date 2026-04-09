Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149E6239E75
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 20:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775767150; cv=none; b=D021VJM0/wxw9esLc9ANIcIZYAppLQBNcoVHLtmoP1qJpA42isR4RijYZWFdbYY5s86gcYrrAN9pKzXQTETxc2OOw39lZ7iHxj9igtfvI1Dv+68oohRgvOlbI+MxvQZ/sKuHdbvd46ORqIWzuOtc36dZtEXcNKWrmQDdhi0ANTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775767150; c=relaxed/simple;
	bh=vkFMKAE+p4HWbfJawW4HNMRPdEzbViVIWe5EilClkd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pagnUFKlQJpXqgzRFs0GVLcv/A1I1Zv/ejrLhhjDZTWhlinAGcQqUJzfIj8qOhz+QHVMjWPoc7MLnJ/l/xCIKjWunGO6HjZ8pu5OJwl3uZUyCedbNeTn/RfJH/mZIqJCHCxbXxdzw1EmJSraTsmwiYwFoWDJKlNXQB/8AxtHHdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EBAMrbrY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EBAMrbrY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=e+34jg3Tc1cAOq2VG9ePh2ikhel8hzpDfd6tWSVvepI=; b=EBAMrbrYaPjGRUi9kRwsbPxgbe
	R6B7EZw7ZTEhMe3Dei/Ag+nxK01Nwn4gm0lyUGtPXiDW+xu/G+wx8UeW2KyeiG7EvGpDMxD7fHq2e
	p5GuYvuCWyEF1J4SCjWEbwzQ2HAKwIVpwN9vJqGXoyqoayTxShijE0ki6hQfDuJxUo2M417EU5Cc2
	KoKYbxOBQj4hYzA2QS+mL8BxIW+B+ms05YRqoH9p0XWyF0ShhO84HojHaOoeUz46Pq9Uh6ipdTt+3
	5MEBBc1nnzDrE4f+5zgWVin4UWXpR7+cjQa6b5EdJygqzmT9WZXJr2fy9ZB6Pg2+aZz65cjTw0tve
	lOQHrksQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAw9W-00000007X0O-1GC3;
	Thu, 09 Apr 2026 20:39:02 +0000
Date: Thu, 9 Apr 2026 21:39:02 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	David Hildenbrand <david@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <ljs@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH RFC] fs: drop_caches: introduce per-node drop_caches
 interface
Message-ID: <adgOZgCfSeWjwreX@casper.infradead.org>
References: <20260409063503.3475420-1-wangkefeng.wang@huawei.com>
 <addP4MKmA8zfSN1o@tiehlicka>
 <dbb92553-58ba-42e1-b7df-b8450bd69d33@huawei.com>
 <20260409081619.34f172dad0e5a56923b7eb2d@linux-foundation.org>
 <adgA2IKrdStZJ6AX@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adgA2IKrdStZJ6AX@tiehlicka>

On Thu, Apr 09, 2026 at 09:41:12PM +0200, Michal Hocko wrote:
> <rant>
> Our caching strategies might not be fitting all existing usecases but as
> usual we are targetting as many of them as viable. The problem with
> drop_caches is that it has grown unproportianal amount of cargo cult and
> grown into "solution for any performance problems" magic pill. Even when
> proven to cause more problems than it solves so many times. Again and
> again. That is really sad. Same as THP causes more problems than it
> solves and that you should be using 2GB of swap space or that swap out
> is a signal of a disaster. There are more and they are hard to die.
> </rant>

I get a kick out of seeing articles like this still being published:

https://kb.netapp.com/on-prem/ontap/da/NAS/NAS-KBs/What_are_the_differences_between_hard_mount_and_soft_mount

'intr' and 'nointr' have been no-ops since 2007 -- eighteen years before
this article was last updated.  We should make more things no-ops.
