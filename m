Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3056D2EAB82
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 07:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782286590; cv=none; b=Qi+xuAev4tKQ5kT+PSQdV+lQKp9QbO+z4sXUC3+Zz9trx1vc/Yrsyg7uGm8fFlX9AHKCgmEH5JEmt9MCI6B7jLqsovtzOGe5cCyrDyfdJO7fjlahvFDpoHmX/vxXdEQ94o141hTJBPphqRD54FP6Gw4m5IsJKcTHuLCoGSggr/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782286590; c=relaxed/simple;
	bh=EbD/fmrNJTk/UnDSwcUNXAu6GoXi94Dmy1WGK8PHZI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gaxwcaUGomfQwwbq909stMTbV0keycDasSGyriL4YMP2zZHpAd9h17GQBVE7rDlJTNzRwB+f3rVCgPzTv25x/klaV3yCCGTZqtTDpZHNyynDaT86nHRo9Djhecrf1tbqVH4yg3gf1IT3fxAVRJkAvhTipI5QXMgj30sUmuOQRNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 81ABA68BEB; Wed, 24 Jun 2026 09:36:25 +0200 (CEST)
Date: Wed, 24 Jun 2026 09:36:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, brauner@kernel.org, hch@lst.de,
	djwong@kernel.org, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev
Subject: Re: [PATCH v1 2/2] fuse: use iomap helpers to update folio
 uptodate state
Message-ID: <20260624073625.GB12359@lst.de>
References: <20260623202843.2064992-1-joannelkoong@gmail.com> <20260623202843.2064992-3-joannelkoong@gmail.com> <ajtPMgO65FA1TXhi@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajtPMgO65FA1TXhi@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jun 24, 2026 at 04:29:54AM +0100, Matthew Wilcox wrote:
> I believe this to be a bug.  I talked about this a bit as LSFMM, but the
> fundamental problem is that the folio uptodate flag DOES NOT BELONG TO THE
> FILESYSTEM (unlike the buffer_head uptodate flag, which definitely does).
> 
> The MM has a number of sanity checks that make sure we haven't
> done something awful like mapping a !uptodate folio into userspace.
> That would potentially leak confidential information to userspace.
> So when a filesystem clears the uptodate flag, the MM can come along
> and bring down the whole machine because the mapped folio is now !uptodate.
> 
> I know we have a terrible writeback error handling story.  But I think
> the right thing to do is just take out the calls to clear uptodate.
> In all filesystems.  Darrick took it out of iomap in e9c3a8e820ed but
> it's time to purge it everywhere.

Yeah.  We're not going to fix everything at once, but we should
slowly move to stop clearing the folio uptodate bit.  And I suspect
the same is trye for the sub-folio uptodate bits.
