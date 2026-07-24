Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB543BD629
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784911029; cv=none; b=m35EGc6q4inTiFEd7aRd1McaPyCKtkUMyyWTpM2mEvXFoBeYjWti+oCyeQFExWz/x0/MnEwMffnyTv1dQyAzWBXYblQmQccuaYC9JWg9kBtgu5JYMXVHXwJicbgAkYMOyaOGV3x0lFvu1lf2C+aGBt4+280QXUQ1rw9mbMO0DlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784911029; c=relaxed/simple;
	bh=uxJe9WdMixn6k2qpUgoe6ZJy8Nr+Gq24YeAx3VHkQZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbVDldpZFggHzlQkvmOk6qVL1Ah/JhRI96WFBUWWCIbzERW8fKZRPr35cX/0L9W4XgCXntLXJ/g62CWq6Ep6/liaq3+Nf0RRxg8XoFCNPqouXoGY8zaEIChCQm/qdqK1piyqeU6l498ulFf77uqaCar74fvsngkW5KuUJxTDMrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mKYOehCD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mKYOehCD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uxJe9WdMixn6k2qpUgoe6ZJy8Nr+Gq24YeAx3VHkQZg=; b=mKYOehCDV+zJ2Q9gEsebdo9Pfr
	TLx5bfwKed1Kbdna4aebNWZMLyioGLhE9I/JvjKqOOGbxFyhPYdUmYCYmdhcKRDi+dj/lK+yxoqNn
	Jg0eKoKFzWGksrpCKuKAsbveIRJ4MUrmMOHy/ZGmlV6Wfivr0w86pDBkYM/2rFEoVNHMwfcQxE+Wc
	50GCj+O0/D3IVRiRHcybTQE+3suU6BvhQwIdfYB7ipf9YNFVstFKAyIYATKNX6y51dDaILY33S9m3
	aJVGPUz1TFCPgPAGxQp6MPZ+ZYFNcBgQhA5Yqul70bmBAxDdTn49BtpjNlY8XULQhNfxOhHJqTeh1
	L4T7oQaw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnItQ-00000003vYD-0Y2N;
	Fri, 24 Jul 2026 16:37:00 +0000
Date: Fri, 24 Jul 2026 17:36:59 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>
Subject: Re: [PATCH v4 14/14] hugetlb: replace hugetlbfs_read_iter() with
 generic_file_read_iter()
Message-ID: <amOUq8dF-H4bfbAx@casper.infradead.org>
References: <20260723143034.175661-1-willy@infradead.org>
 <20260723143034.175661-15-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723143034.175661-15-willy@infradead.org>

The Sashiko review finds two problems which are already addressed in
earlier patches.
