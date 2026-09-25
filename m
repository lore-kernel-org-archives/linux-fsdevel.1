Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AC44078F5;
	Fri, 25 Sep 2026 07:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790320511; cv=none; b=tV7gntmFVYCCO74Hm1D9gYcGnS8bGiXY3e68P0aIvhtZkro//YVpTtPoAwJhDVQXApthbVtvD/l98r3J9irDpq8EovcIdJkGS/l3/GUjC7aCC654mUbb/37Z5JgjIwxLkRoogwut1LVQO4YXdPThTwBQ8KlYAdi0SaM8az3M2Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790320511; c=relaxed/simple;
	bh=kmE9rTO8lqX/1gSCnt91CrW/t/SKrlww2JwJUgNTZSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWRR1IPVCSEhZP6pZBANSPVdZ+Qd77gUaVcHsygwnPK6axJMEQCuHEddE9Ke7Kyy7+1pIyY67PnQCEWzABmvfKVYy5HliTw1z8sp1lFr+NYFXRxDzDvgLU4/jv11vSqnghN/nAWBFrEBzJ/wGMvXFPGIeJt3f/wwrlDRorOvxP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1A74368C4E; Fri, 25 Sep 2026 09:15:04 +0200 (CEST)
Date: Fri, 25 Sep 2026 09:15:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Christoph Hellwig <hch@lst.de>, glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, vdubeyko@coreweave.com,
	willy@infradead.org, brauner@kernel.org, djwong@kernel.org
Subject: Re: [PATCH v4 6/7] hfsplus: introduce iomap-based file_operations
Message-ID: <20260925071503.GA4737@lst.de>
References: <20260914233941.2966421-1-slava@dubeyko.com> <20260914233941.2966421-7-slava@dubeyko.com> <20260918133935.GF18107@lst.de> <1056cf9f4393443de00137bc8937922d6ab40202.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1056cf9f4393443de00137bc8937922d6ab40202.camel@dubeyko.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Sep 24, 2026 at 05:07:11PM -0700, Viacheslav Dubeyko wrote:
> On Fri, 2026-09-18 at 15:39 +0200, Christoph Hellwig wrote:
> > On Mon, Sep 14, 2026 at 04:39:40PM -0700, Viacheslav Dubeyko wrote:
> > > This patch
> > 
> > Patch descriptions are not supposed to start with "this patch".
> > By the time this fets into git, it isn't a patch any more :)
> 
> It depends on how we can defines a patch. From my point of view, patch
> is a piece of code that can be applied on some state of git tree. But
> even if this piece of code was adopted and applied into the git tree,
> then it could be extracted as patch again. So, it exists as patch
> forever in the git tree because it is incremental change of the tree.

Either way the kernel style asks this not to be done.  See
Documentation/process/submitting-patches.rst.

