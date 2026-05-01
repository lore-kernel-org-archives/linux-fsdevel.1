Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C151E1024
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 May 2026 12:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777639632; cv=none; b=Sb1kI51tcbJyQT77gSW7D5IyeBW6L4Y0W7xjInOyB2GvE75CPjtq2Nvol11OKIITDvXGb4qVoNu/9ytKLr9fFOnynlPcB5iVCduwGuOu3BXwg32g1kzHOP00Tq1PW558g6uIZEkEwnKy44FsheZFE6cLyX6NcwNZMMZnvimTjnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777639632; c=relaxed/simple;
	bh=JRdAIbEd8Sih0praIIu5xO9MV2oSKjhDSo8+TYN+5jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cd55arK1H/4x2/vH93c5RoVEDf8f8H+6QfpfkZzmJkLmw4+RtMVDVaTv6l4Y5ch/iscWpdDq+RNfdQIg8lAEs7bHUtAdG7xkjorYfTv6lgt5layuBH5kA72bG7McpcrOXHK4ca7sOZxsLhPFtrlMi7qc3KCp3n6rWNcK7uIwvik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k9plhMvp; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k9plhMvp"
Date: Fri, 1 May 2026 14:46:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777639618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P2DQ7lVTQGdAyrhQUfdOOsiMFPtIk6TyVGXTF4nXjsU=;
	b=k9plhMvpl9eb1QNqbmbWFa/4XQzTVJtH4stAOwfwPNKu2RuuJ5S/2ha4Q8weCX9JHJmtma
	98uVFVbz3E5Ae4pA0jd4ogf6ri8Ec03NZ52voIDyVC4ghNRab4VVNVxVcOtLMyEVJ4WBN4
	H1KTa+aIoy78L+HX9EMiasnYlEF+YD0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Pankaj Raghav (Samsung)" <pankaj.raghav@linux.dev>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] block: pass a minsize argument to bio_iov_iter_bounce
Message-ID: <jgzzl7e6qzea5ohma2tdma2rndlaj4ouohsiwohpz22w3aiqvp@czndpvnggd3q>
References: <20260430132019.312405-1-hch@lst.de>
 <20260430132019.312405-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430132019.312405-2-hch@lst.de>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 30, 2026 at 03:20:04PM +0200, Christoph Hellwig wrote:
> When bouncing for block size > PAGE_SIZE file systems, the bio needs to
> be big enough to fit an entire block.

We set the alignment to fs_block_size when IOMAP_DIO_FSBLOCK_ALIGNED is
set. And we always set IOMAP_DIO_FSBLOCK_ALIGNED in btrfs for dio 
reads/writes. IIUC, it was added to support bs > PS block sizes in btrfs.
But in XFS, we set it only for CoW inodes (xfs_is_always_cow_inode is true).

The commit message seems to indicate this is needed for all filesystems
that support bs > PS configurations. Am I missing something here?

Otherwise the patch looks good to me.

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bio.c          | 23 +++++++++++++----------
>  fs/iomap/direct-io.c |  2 +-
>  include/linux/bio.h  |  3 ++-
>  3 files changed, 16 insertions(+), 12 deletions(-)
> 
-- 
Pankaj
