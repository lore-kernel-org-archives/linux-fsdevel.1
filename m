Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323E8201004;
	Tue,  5 May 2026 22:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778021166; cv=none; b=Mb82XQYGLXsTYiq5A0xb7bBSKoGrUDkIQKsxMyLn9pS9tnGr3O8hahP9ju81QA5R0Rd4dbz5mxsB6x9oiA16WG1Qkk2rVhNMRWRibdVCLSmzxzlkfHyDDyFRZwT6ukUFrV9Kytruiw0uIwRp6rsI7nfceESd5EFfZlafmA3jkfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778021166; c=relaxed/simple;
	bh=vmHtcRuBrceXbDXxeVILCEbos+XXRgxNwu4CotlMf/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfKpRWvENWjumDrQaIsdDpRlz1WEihHHPLrJnqOVETdRzCzp2j4HdC93VGGf2rJNjJbiL4eghYXSX4JISR0dkhfCDmKIvUwWcajprMo+pfOKtjWg+yEVw1a+f5/hTxH5lbAIlR+meqPQJj573OTfIlcOjcrW9Z94cFbbhff4sts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/bvUqYB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/bvUqYB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CEFEC2BCB4;
	Tue,  5 May 2026 22:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778021165;
	bh=vmHtcRuBrceXbDXxeVILCEbos+XXRgxNwu4CotlMf/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M/bvUqYBngTsMoxBG6csKagWUdXH88dHQW7nYBDO6C9EMxc2AOW66GELUucBtg4k0
	 nJZdkM0uyHGx4h8p5ZpHBx4CsWUN8OE7J2VNAtH+lBwgjii2TrYUhsvKzIu6ECCxvB
	 mktprgDpROqnpBZpNObch0RRBIZV8xHJ4ntu2eUJ6aOgS6Ouj83QQteed8FdDl901v
	 Y5Rbtr20uG31gs3GJ7zGJ40jrvmyTWVCPgwIzA27D6skJEXO0XEZOmAVVlUjxLLECd
	 u5myUb1NHj1xEDrPs552WNU2IU5dv04H2tgejqDgehohJ2IycGSrAYCOIEEsiSRSsZ
	 7ki/LqzjG3i0A==
Date: Tue, 5 May 2026 15:46:03 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Colin Walters <walters@verbum.org>
Cc: fsverity@lists.linux.dev,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] ovl: fix verity lazy-load guard broken by
 fsverity_active() semantic change
Message-ID: <20260505224603.GB10301@quark>
References: <6630d44f-967d-41f0-81ce-6958b371465a@app.fastmail.com>
 <20260505210016.GA3895@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505210016.GA3895@quark>

On Tue, May 05, 2026 at 02:00:16PM -0700, Eric Biggers wrote:
> On Tue, May 05, 2026 at 02:15:58PM -0400, Colin Walters wrote:
> > Commit f77f281b6118 ("fsverity: use a hashtable to find the fsverity_info")
> > that broke `ovl_ensure_verity_loaded` in the case when the inode was not in core.
> > 
> > The APIs here are in my opinion now confusing, but this patch intentionally
> > aims for a minimized fix by using `fsverity_get_info()` which ensures
> > the hash table is loaded.
> > 
> > Fixes: f77f281b6118 ("fsverity: use a hashtable to find the fsverity_info")
> > Cc: stable@vger.kernel.org
> > Link: https://github.com/bootc-dev/bootc/issues/2174
> > Signed-off-by: Colin Walters <walters@verbum.org>
> 
> Reviewed-by: Eric Biggers <ebiggers@kernel.org>
> 
> I can take this through the fsverity tree as a fix for 7.1.  Amir, let
> me know if you'd prefer to take it instead.

I'll take this fix, but reading the commit message again, the
explanation makes no sense.  The issue has nothing to do with whether
the *inode* is in core or not.  And we aren't "loading a hash table".
The change in the order that we do the checks isn't mentioned, either.

I sent a v2 with an explanation that is much clearer, IMO.

I'll apply that version if there isn't any objection.

- Eric
