Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EC1420868
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2026 08:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438647; cv=none; b=lKrs9vXH3KzJo8HACAyMmlGkiep/gsf66Gfr532dYgE4saR7dpejIyTeD3EP0hjlLy2viqodSbnUvhGKCRvGRHOOaGuyOhw+ENZKDTvfvCVoHYRrGa2AElgqi5s/jMRbgaMlf8rIov+CdkUzAMdmnR88lp9EuWt6h1ZIkAOfozo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438647; c=relaxed/simple;
	bh=i580t56jSth0zHKP0gBFR0tvBDR41UR2xsqtzvxFhjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdEHOM0fBe4htRfhyuWCzBGg9bOhnLxuaj49YrS3HpHVkPTicJGfgDfB2Bi9fMZzJFL3YEIaJpW5Ax3hzEayMCLCzloQsT8E5rASzFZ0EyLl4xXLfTAsOW/GbKKZg6Y174lSPvHNVShNqGzig26hSfq4yWqVjg6UfnYc+vtyApU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ms+NzDGe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ms+NzDGe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C1F1F00A3A;
	Tue, 11 Aug 2026 08:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786438645;
	bh=7JoTrvYpn+Upg0subkHUPiI4UyBukemX5Y3bwNb0a5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ms+NzDGegNM78esdie4ooZ5IfcwsxjXndd6Cv7hNkdSYlLLGfieQPLlTNSZoxB18o
	 nL5EIrR49c3FwFj7TJ5by0lk9ccTLFYMSz4kRR161GMzKRhjxd7izyhc5GjtAWmFjN
	 xbFMyxRoCcYEO5sQi+ncKdrJ5kyj1IgHUduD0qh6ESsqcGr41xHZmGQBejlkL2ZZHD
	 SyV7/cW07eubc3ag8nVKeTdAeQQaGKx1T1DEfNv1Ehm2dyAvlocxySCPH1IeF+7Wb0
	 EvnlZz7bT3mT9AHtsWKQCpCRzPltUxnlAuHrlTeDlAl+N1KeQ0sTehTGq+CUCmfb+M
	 N2+yaeQVNC05Q==
Date: Tue, 11 Aug 2026 10:57:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] VFS: prepare for changes to directory locking
Message-ID: <20260811-worte-ergotherapie-aggregat-37e626a98182@brauner>
References: <20260723015330.3093207-1-neilb@ownmail.net>
 <178589951580.3252194.4525601427061509874@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <178589951580.3252194.4525601427061509874@noble.neil.brown.name>

On Wed, Aug 05, 2026 at 01:11:55PM +1000, NeilBrown wrote:
> On Thu, 23 Jul 2026, NeilBrown wrote:
> > Thanks a lot to Christian for the review.  I have address all this
> > issues found.
> 
> Hi,
>  has anyone had a chance to review?  Is there any change this could land
>  in the next -rc1 ??

I haven't gotten around to it and we're kinda cutting it very close.
I have reviewed prior versions so I'm not unfamiliar with it. If there
are no real costs to pushing it to next cycle I'd prefer that.
