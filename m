Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C9232571A;
	Fri,  6 Feb 2026 07:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770363745; cv=none; b=bJNLxue7/LWgLjOkQiIzkMQYWr67ArpQKd5uVmikunP1TR15JXYfsPDAL+Xshg+zRvynZH5eA6gB2FzzYRYrXOD/2627hVvdjG9YQV7w1eeKxygrPmL7MGUDWdDzppBN4lhlM4sQ/OTR74YgHoKpLpYlIWTaWpOjMRtlDlOsDhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770363745; c=relaxed/simple;
	bh=WeVmhn33iwZYsaBPkxpYtNiRgSAWxahrvzcjNmwtGhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvSfqW/9g7H6Hp6SUbVzQ1LemMLiU2RZSnAlMw27m9WRgDLtgA+1NzFPIU9lgog9i7GZfytRijkgU546zVZutgX1W0keIFXZIKxmmSlj+nV5voPREXtWDWDYp8gA4KJJV7AC3yQRg8Kf3zqM30Jq/hCmPWmecFis1S2v/O9iRmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1l4a5UiE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1l4a5UiE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9Zu5Sn8tUPbS51W0jfTqrezTHnrJClgJeJJdhVN8z+Q=; b=1l4a5UiE4ghuKYHlKJdllioTt7
	ACusxxnnbzdcxSjFuLZD7lfcYlOSSKxdH8Ibk+tN9sXuTG9/aKNA5c54WCnlyErJFzRAB+9Zcrjg1
	COit7Ud0+mefdU+6Zht2Gp0p1JHLgw7sdgSWbIFU42RuKrjbR1M3ipyIXrhTIH8rFjRp9hTERSCyJ
	+m2Lc4a5yje6NwZ5RxxvtSh3Sn0b7B98YyCXBFjIhXRFwigTNYlyglxR7zRS/uTBkRgUo+OXPYQ4N
	KogCialo1FJGIitsThI/4xRmot+jwaJX1Y+/1Hr2IMmy3l9U+fYzENmubwkPksfoLzkbhLe9CFgRW
	iAAtSdaw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voGTt-0000000B08t-2jaW;
	Fri, 06 Feb 2026 07:42:21 +0000
Date: Thu, 5 Feb 2026 23:42:21 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: axboe@kernel.dk, miklos@szeredi.hu, bschubert@ddn.com,
	csander@purestorage.com, krisman@suse.de, io-uring@vger.kernel.org,
	asml.silence@gmail.com, xiaobing.li@samsung.com,
	safinaskar@gmail.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 00/25] fuse/io-uring: add kernel-managed buffer rings
 and zero-copy
Message-ID: <aYWbXV9pfyLwfy-t@infradead.org>
References: <20260116233044.1532965-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116233044.1532965-1-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jan 16, 2026 at 03:30:19PM -0800, Joanne Koong wrote:
> This series adds buffer ring and zero-copy capabilities to fuse over io-uring.
> This requires adding a new kernel-managed buf (kmbuf) ring type to io-uring
> where the buffers are provided and managed by the kernel instead of by
> userspace.
> 
> On the io-uring side, the kmbuf interface is basically identical to pbufs.
> They differ mostly in how the memory region is set up and whether it is
> userspace or kernel that recycles back the buffer. Internally, the
> IOBL_KERNEL_MANAGED flag is used to mark the buffer ring as kernel-managed. 

Can you split that series out as it also has other applications
and smaller series might be easier to review?

