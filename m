Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C44374739
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771945093; cv=none; b=ATVoBXcotvXeO7jMyTDD1twmH+hYixmZbGS/wvnK+ZrHAQBH6wdOUeyXhu1NTN/km24wIosG+vq+yfmkvFSvioX689Q26AGpb0DByjDm93j/rA8RoygnLIQGdJPaA3G80ZWtS5aJMXH4GieDNBCCz2Z/c/RuvUBmKCz32/d9CW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771945093; c=relaxed/simple;
	bh=fPIpOCMyu32nI1GWwfiGfNKzBR03Yr/196BEdi8T9rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIm764u/zo4YWA523lL3IoxPFfOFGhsQEja5Q9h5lVupSDo0QWwdLVOeI+a5Uli5FLHonc3tXm5oGYC/EPg9rX9/MbQeLo2jUIfCbKDnjMGsDxUeBIMauSw/fOyq8Js1g8rbWbZ5kuMCq+Drgt3Rm/66jAuWVxVI55c6bwgKNH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0w7Q7ge1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0w7Q7ge1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+kPiVgs61kan1klqtEdKEojeJEKKIFclyhcImosTr/s=; b=0w7Q7ge159WS78y1lDSdUIEGPO
	IXbH/bntfVEFyZwx3XgiCnoqHxKWsRLNEc+3djr8SsvDpvQrW7FaQNDbGF9idi8rcIcPEORrbwfl5
	C/RqUNzDopy4gg6uaZN9thwMUh6PXsC8dA4DVEXjycbqXsLhIfmJpY5qC/i3tBMG9xoyeOY0vQEQ1
	GyUC+2uALn+oBGsuGqLxIvx64wc9lGOZOXD3YHk6Kmenai/wv9Tw5UnLWVCSCGTnH5SbI4WNG5f4a
	tIvVGdKioN6ggXdMwTwdgtHbZ81HRwAESgWjv29NcxwHOF2wtQKlpNaMtpA+YPlpn66XDIiMWhw39
	1P7gIIvw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vutrU-00000002Hb8-3HUs;
	Tue, 24 Feb 2026 14:58:08 +0000
Date: Tue, 24 Feb 2026 06:58:08 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>, Nanzhe Zhao <nzzhao@126.com>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	willy@infradead.org, yi.zhang@huaweicloud.com, jaegeuk@kernel.org,
	Chao Yu <chao@kernel.org>, Barry Song <21cnbao@gmail.com>,
	Kundan Kumar <kundan.kumar@samsung.com>
Subject: Re: Iomap and compression? (Was "Re: [LSF/MM/BPF TOPIC] Large folio
 support: iomap framework changes versus filesystem-specific
 implementations")
Message-ID: <aZ28gDfzOd1CSb6M@infradead.org>
References: <75f43184.d57.19c7b2269dd.Coremail.nzzhao@126.com>
 <8a66f4d4-601c-4e1c-97f0-0ba7781d6ae8@suse.com>
 <aZxQ0kwaDqknE8Gq@infradead.org>
 <a89cc9a0-37d1-431c-ab98-eed58d5bd93c@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a89cc9a0-37d1-431c-ab98-eed58d5bd93c@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Feb 24, 2026 at 08:23:35AM +1030, Qu Wenruo wrote:
> > I still think btrfs would benefit greatly from killing the async
> > submission workqueue,
> 
> That's for sure. Although without that workqueue, where should the
> compression workload happen?

In the additional writeback threads mentioned below.

> > and I hope that the multiple writeback thread
> > work going on currently will help with this.  I think you really should
> > talk to Kundan.
> 
> Mind to CC him/her?

Added.

