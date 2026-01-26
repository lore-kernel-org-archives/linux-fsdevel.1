Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4964526B755;
	Mon, 26 Jan 2026 20:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769460058; cv=none; b=lGxXtX6szmWoG9V4mOPwH7xYLjI4elJb1ZgfuNrMSoNsRNfs1OSNc/kbMOJx+vtfnrcFFAjslanOexo9xW7BPQEijn5/4katfIqhwYblKfuh6jZPVVWtI1GBZ01DPA5IPMHkFRFHXcq7NsaH8ndqftyCnQhjgBRau4aKRVuGyMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769460058; c=relaxed/simple;
	bh=hyalMSb8PkIB/y2wTEkvrXTVerDXEWCMzBnanNpHbcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJD3d//LhpkXMkNCBzC2H4ep62yNVwC45t5puw0VPo4X9KnpNqjv79TT31UxrzsZONXqKDUDL6e1SxzPypNqQoYWoLodGWIs7Xy/XhAQYFR0etY5P4Nc+I1hoxsyLErhDT+vDpN38O/nm/LCL0J52vntMDlBZERc8icd3Mp4doM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Oyacvg75; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Oyacvg75"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VYfYU993elGtunsD0W2WH0r2p/2SUda3jsdLQYQD3EA=; b=Oyacvg75LKtsjDOv37VDWNhVPp
	zis4lf5BP+nDmagFci+X/6fike3iOQSw0H6n47gU48W8ZY9JYNcRhSUVNZ5GZy+9BQevh545F6nCA
	xzjeM6C0TVRLIzbldWywJyQeY7i4tGglILFnWtakKFzHrFDQrvSds4mWVPXGVuuhkAotAAUbFsPga
	MO8KKC6wSBwovG9CIfmilaUabdJm1C0Ifwp9CxzLGHpFMBqNMmWpwuG05vi1TiUTClIB8Pw1VG8eJ
	1UNqylNL+2FHNFIVNOZXMZI9W/6dWPhMZaDIbqWyfhJCftpNawrpxBDovBRa6BHUtyCHCFkk3Zs44
	ShPEyclw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkTOE-00000006RuR-3w1z;
	Mon, 26 Jan 2026 20:40:51 +0000
Date: Mon, 26 Jan 2026 20:40:50 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Cong Wang <cwang@multikernel.io>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
	multikernel@lists.linux.dev
Subject: Re: [ANNOUNCE] DAXFS: A zero-copy, dmabuf-friendly filesystem for
 shared memory
Message-ID: <aXfRUlu61nrIqCZS@casper.infradead.org>
References: <CAGHCLaREA4xzP7CkJrpqu4C=PKw_3GppOUPWZKn0Fxom_3Z9Qw@mail.gmail.com>
 <55e3d9f6-50d2-48c0-b7e3-fb1c144cf3e8@linux.alibaba.com>
 <CAGHCLaQbr2Q1KwEJhsZGuaFV=m6WEkxsgurg30+pjSQ4dHQ_1Q@mail.gmail.com>
 <aXe9nhAsK2lzOoxY@casper.infradead.org>
 <CAGHCLaSe8g+BQ5OtRv0_Ft3o-G0gR4oVSOW0DtdsQJdwuJsDCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGHCLaSe8g+BQ5OtRv0_Ft3o-G0gR4oVSOW0DtdsQJdwuJsDCA@mail.gmail.com>

On Mon, Jan 26, 2026 at 11:48:20AM -0800, Cong Wang wrote:
> Specifically for this scenario, struct inode is not compatible. This
> could rule out a lot of existing filesystems, except read-only ones.

I don't think you understand that there's a difference between *on disk*
inode and *in core* inode.  Compare and contrast struct ext2_inode and
struct inode.

> Now back to EROFS, it is still based on a block device, which
> itself can't be shared among different kernels. ramdax is actually
> a perfect example here, its label_area can't be shared among
> different kernels.
> 
> Let's take one step back: even if we really could share a device
> with multiple kernels, it still could not share the memory footprint,
> with DAX + EROFS, we would still get:
> 1) Each kernel creates its own DAX mappings
> 2) And faults pages independently
> 
> There is no cross-kernel page sharing accounting.
> 
> I hope this makes sense.

No, it doesn't.  I'm not suggesting that you use erofs unchanged, I'm
suggesting that you modify erofs to support your needs.
