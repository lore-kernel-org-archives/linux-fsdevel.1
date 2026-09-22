Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B58648988D;
	Tue, 22 Sep 2026 05:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790055699; cv=none; b=F2NZEDYoxPrtXtgSQPJddn4ESWXOtgXHrXTROWsE6ZsOMB6IlXlYgsd+YXMkA+cgAhdhy1U1TB6KjtGMmVbatdx/6A8AqclcaSvNgP1o8lRkuelnfJ+hxlHDMofjfKVSniJ56YFTwOhqkf7DbB/3SXCkeZ9w4v9cy0oOaBY60rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790055699; c=relaxed/simple;
	bh=kBntcYY1ny8V/wR9eYtrRZ1aTNtH6ws2Zz3TN/WvUbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFEdzQDH7dkHbSgIrju/IMt05N+QRPjV4I8+03K6agkPCMv09ZOwuRSzortf/0N2yQarSfHqMzX5hkXXMULFNzTi8Mj+ki8brXOVrXl2mFAM+nWPjDbOyJ/euQlmgxO3R3PK6m10NmrZX6V3Wp5sslmP9/4okUbl8caiZNUOmN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zwnsc3N2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zwnsc3N2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lD++dEEXrmisCOCiz9QZ2EX55PzdxN3asJnjkDV58CY=; b=zwnsc3N2WvX4AOi5oNQNBw+UWw
	ik9dNEl6S17e2+GakyZ/ZS8JZg3rITNfYxkl8XCsUjOxnuGJYR5ui9i2YvD3qld3IOkoFAz0R9A9f
	GoKjEjBhwL1241Oa5MmARplMgEmW1eFRnBvun8r2qxxyXxMXq6UpOEcK+hYqkfevkrD1HsSe69bcP
	55kwpgZBRyLX7RoHgAj3xxzpd6pwl9FZ0OXBDAg4rLNCYSrwiRvVYPdILbOVPZMMhhv1ZFDzmqP6H
	Bef/ALQ2xYwpkh3UfMwmCu7P1uK+bjXDhdKtjNJlKtvxP5m6a/FF1TdF3lw/i/e1myXmmQVqoa1JS
	W4f1gF+Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8tFu-00000004GQO-25oV;
	Tue, 22 Sep 2026 05:41:26 +0000
Date: Mon, 21 Sep 2026 22:41:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Huang Shijie <huangsj@hygon.cn>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, zhongyuan@hygon.cn,
	fangbaoshun@hygon.cn, yingzhiwei@hygon.cn, jack@suse.cz,
	dev.jain@arm.com, ljs@kernel.org, adobriyan@gmail.com,
	akpm@linux-foundation.org, hpa@zytor.com, ryan.roberts@arm.com,
	mjguzik@gmail.com, joel.granados@kernel.org, jannh@google.com,
	oleg@redhat.com, aleksa@amutable.com, legion@kernel.org,
	kees@kernel.org, joannelkoong@gmail.com, tj@kernel.org,
	libaokun@linux.alibaba.com, ebiggers@kernel.org, sandeen@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/3] fs/drop_caches: skip filesystems without page
 cache
Message-ID: <arIVBpMZk5-O2AZc@infradead.org>
References: <20260920072811.2064247-1-huangsj@hygon.cn>
 <20260920072811.2064247-2-huangsj@hygon.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920072811.2064247-2-huangsj@hygon.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Sep 20, 2026 at 03:28:09PM +0800, Huang Shijie wrote:
> Add a new flag SB_I_NO_PAGECACHE for superblock.
> 
> Skip scanning the inode lists of filesystems that have no page cache
> in drop_pagecache_sb(), as indicated by the SB_I_NO_PAGECACHE flag.

I don't think we need a new flag.  This can check for

	sb->s_bdi == &noop_backing_dev_info

which is actually the more relevant concept - not if a file system
uses the page cache, but if it supports page cache writeback.
E.g. for ramfs there is page cache, but it is the only data store.
For shmemfs, there is writeback, but it is driven in a different
way (through the anonymous memory code and not fs writeback).

And most importantly it just work, no need to mark file systems,
as you're currently missing a lot of those that can have a fair
number of inodes, e.g., sysfs, kernfs, cgroupfs or configfs.
