Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843F93033CC;
	Wed, 24 Jun 2026 03:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782271802; cv=none; b=NlOjfYNdGdVHualRpCCxwoAHjt6Ljq81h272qNzM3eQHfMy2x5Snm9YeCnX67Rmle8hPQ6lxjreLBj+4JynOfwC42AMX9Au4ukMgUJT5Xo17QqsGScmlGxHvUCItvrp2AS9aAXnTlvclP8vnLbJIbv+WYF36woAhwkkQ77t6xto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782271802; c=relaxed/simple;
	bh=jHfcns92lQwD9FYMHym29aGX3LBccLuOg2GeEwLWfnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzNjsi8sNIlNnTDYVWisZIcuAUAh2vw3qJucEOqjGKB2vdrG9MyfXJAbWYUCM4qVkGhWbRZL5o8TCvSyMN5dq7a76TpGpgyfjOgx4WfMTnOSL8oIiO47KFdLHbYxROoUAQyqxYoNZe+evr3bZLqPRm4SVr39AZNSe5OU0/7ymLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H20ZulC/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H20ZulC/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Cnv9Gjj91d8MyBpBAbGkx6vofuQ/g+L+GIR35ddp+/U=; b=H20ZulC/Z7J/pCWaS2j6eBOmRM
	L+YMTrQGmEudrq3F85oT/cbljMrcbgATj7d4t/S/ANgU6c9b3d3wZ80NslxPlxvaEh1BJP/WLpAh+
	mHGEORuU2jITZhZ9N9tRG5LemKYzjOF0GffKchZOdP2Ay+gj2Qfj/8RDBcSYZEkzOUmXMopw7wDM4
	LKsS6vcaN5IC4dYffg2Z+kP8gbhxPLAfGuizgRfoCad4/cf5cxsRK4uIpcBYMuR2JHVZK4AszYewm
	M+U0HkYBjZEeU7OxiOCX+JvR7GhSOEqk1GxWDqVm9dJeFGsqapqqSasw1r+QDsE+9iTJsqpKzWrLJ
	QKdNAJxg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcEJG-00000007IUa-2m5G;
	Wed, 24 Jun 2026 03:29:54 +0000
Date: Wed, 24 Jun 2026 04:29:54 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, hch@lst.de, djwong@kernel.org, miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
Subject: Re: [PATCH v1 2/2] fuse: use iomap helpers to update folio uptodate
 state
Message-ID: <ajtPMgO65FA1TXhi@casper.infradead.org>
References: <20260623202843.2064992-1-joannelkoong@gmail.com>
 <20260623202843.2064992-3-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623202843.2064992-3-joannelkoong@gmail.com>

On Tue, Jun 23, 2026 at 01:28:42PM -0700, Joanne Koong wrote:
> +++ b/fs/fuse/file.c
> @@ -1250,13 +1250,13 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
>  		struct folio *folio = ap->folios[i];
>  
>  		if (err) {
> -			folio_clear_uptodate(folio);
> +			iomap_folio_clear_uptodate(folio);
>  		} else {
>  			if (count >= folio_size(folio) - offset)
>  				count -= folio_size(folio) - offset;
>  			else {
>  				if (short_write)
> -					folio_clear_uptodate(folio);
> +					iomap_folio_clear_uptodate(folio);
>  				count = 0;

I believe this to be a bug.  I talked about this a bit as LSFMM, but the
fundamental problem is that the folio uptodate flag DOES NOT BELONG TO THE
FILESYSTEM (unlike the buffer_head uptodate flag, which definitely does).

The MM has a number of sanity checks that make sure we haven't
done something awful like mapping a !uptodate folio into userspace.
That would potentially leak confidential information to userspace.
So when a filesystem clears the uptodate flag, the MM can come along
and bring down the whole machine because the mapped folio is now !uptodate.

I know we have a terrible writeback error handling story.  But I think
the right thing to do is just take out the calls to clear uptodate.
In all filesystems.  Darrick took it out of iomap in e9c3a8e820ed but
it's time to purge it everywhere.
