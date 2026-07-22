Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327D5357CE1;
	Wed, 22 Jul 2026 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784725830; cv=none; b=ea3KFF4B+GtcpaVMFd22MHpydTmpynWesHmCea1nMT9gBqsVL2MZv8C1h36Cp097agwOQBbj1UNM1gfb2ex5L/XnIgpBEIga6ZS3/n8GfNQ25plBB8stPbj1rKdtT7Xc8esjxGkphhGsDU1adt6a7ljByyuQwaokTSu1KZ3DozI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784725830; c=relaxed/simple;
	bh=QZFTl7CwbayTzaG32iP3LhEtM7k2p3p0QXesNKVWOfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRT0j9u3ylvei5581caC7GvlUfmYhdofq+waVtJlH/DaHmvLND//0lmWIr/lspV646lgCFWZ1M2i7jNy3UyrMuHFpFidTfxbuy9vGUM6hh7622QZ9TLcGH4zuDwM/0qodZluPHpPQZINKEz2Qblc9MN8TMqtPlPBHN9PS1ORsUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=20w6BQHv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="20w6BQHv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LC0Mr1QYXQvTtjtBcYeQw+t2VJzHYjVLUDhnXs0jB78=; b=20w6BQHvSRquJWBV5W6rpB9Si3
	l8cBm2HvvYLjAen0X3j4UNa2uIOUbwzatvvilXyBG97WA9po7lJG8u7DygLSmgKoTI2yQoApj0Bgp
	udmlPsmuLHK0mFYjrSfKWQl21SdvWn+45msMlGmGEpwJpUzShqKNqpj/fQSGZZxeklrsIKt+SnoMA
	SfAw9lAVChoUncLzeNt+PGvQHFcVxETcwu7Hqt5N22wZ23kzzeQlk2Nf2016+pDhSahPDmLB4SeSd
	rcq5kAKbEyhDIKVesp5auK2mSqRzxa/st/c5nT2qHVg8WOyjSBPKJCF/D/B1GpIOP2v8dxFr+Px1L
	UJaYV5jw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmWiO-0000000BrWK-1Aof;
	Wed, 22 Jul 2026 13:10:24 +0000
Date: Wed, 22 Jul 2026 06:10:24 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Pedro Falcato <pfalcato@suse.de>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Jeff Layton <jlayton@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>, NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/14] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Message-ID: <amDBQN5lCGbRxGWm@infradead.org>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
 <20260704164149.3480051-10-jkoolstra@xs4all.nl>
 <akyyqnv9EpY7xVdC@pedro-suse.lan>
 <20260707-vorteil-unhaltbar-apotheke-47bb105161ff@brauner>
 <alS10NN_OduZEqvt@infradead.org>
 <20260722-mundpropaganda-vorwahl-funkverkehr-48efdde92a00@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722-mundpropaganda-vorwahl-funkverkehr-48efdde92a00@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 22, 2026 at 02:51:54PM +0200, Christian Brauner wrote:
> > No, we can't rely on something being backport to old enterprise/cloud
> > kernel.  Doing so makes the interface unusable for actual applications.
> 
> It's backported to all LTS kernels for multiple years and this
> nonsensical theory of using a software version with O_DIRECTORY |
> O_CREAT on a pre-LTS kernel from years ago is just flimsy.

the kernel has always ignored unknown open flags, or unchecked
combinations and you can't just silently give them a meaning unless
it is backwars compatible.  That has nothing to do with this particular
combination.

> 
> Even just the mere fact that I was able to just backport that bugfix
> that started returning hard errors to all LTS kernels with absolutely
> zero regression reports defeats that argument. We've done way more
> invasive changes. This is a strawman really. 

Of course it didn't break anything yet because no one used it yet.
One we give it a meaning it will be used and break.  And if you like
it or not, a lot o Linux deployment is not using recent stable releases
or even tracking the -stable releases at all.

Just like we've always done in the past we'll need to APIs that don't
accidentally do the wrong thing on any old kernel.  We've survived doing
it this way the last 25 years (maybe longer, but that's about how long
I've been around) and there is no reason to magically change this now.

