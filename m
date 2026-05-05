Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED173EFD30;
	Tue,  5 May 2026 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778014821; cv=none; b=c60747M+C/Z+ZV9gf09bysxaX0/OqI0XHFwtBVf8jeX4JC2Q1WjOVrxYEWrGE+4P3I4Bsb14PSPGoRoSnSVrX02eKetcq1cXxwAXoQg2GJTod19oWLcubtus+onLvDv2ghN9PVIHp6yzPovDZ5Iq3ymkBxBxFdMZNDBj13UdCjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778014821; c=relaxed/simple;
	bh=M1EULEHUjdnkQykduF0+PVxhMQpk8F8v4jxC+DrYfJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEBuPHg0HvFo6OkmR0jdiSGRA4dWVznAG11M1O+P94V8of0tmUr07MofvuU4PLIpyxtrq046w5fdrhyHX0+fzDZXsv2gl100LOShD7R1wQGSOZal115lUPI+fLmqAK9dE49jIvdF/QDcoJBO0NQ3mog705XAjeEs53ZxoXCRfy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vN4fl2WW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vN4fl2WW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406A3C2BCB4;
	Tue,  5 May 2026 21:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778014820;
	bh=M1EULEHUjdnkQykduF0+PVxhMQpk8F8v4jxC+DrYfJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vN4fl2WWIcUwnYi4h0+Hq2iysUfx9bd9YflB+YELzAAjswbiVv4dVWNuiD8I8qenJ
	 9Xg6V5F0EsmU5s2mDZinbzwN/zdkBgiuHiA+R+NeXVpLYX2MlZbbzrWJT0cO8d9HMz
	 MgZ8d0rSn0Gj+5FNgpWP+f9TbAHLJCz+X2LTI6jpvRTNrmey7uhIfTg4xMLMa+ygms
	 MmWhNb+tgWjY54ld9148z0YGqeC17tL9IRbsBzJ7em7ZlIBPMM7L5Sgkp9Zo3R79yW
	 lWE8eru0709pZbgQ4gphrkfN0RvqCj6uvuVHXdHkfXr9aRvfkk6KrvX4fd5Ma4DFSz
	 qgaHC3tlbVQTg==
Date: Tue, 5 May 2026 14:00:16 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Colin Walters <walters@verbum.org>
Cc: fsverity@lists.linux.dev,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] ovl: fix verity lazy-load guard broken by
 fsverity_active() semantic change
Message-ID: <20260505210016.GA3895@quark>
References: <6630d44f-967d-41f0-81ce-6958b371465a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6630d44f-967d-41f0-81ce-6958b371465a@app.fastmail.com>

On Tue, May 05, 2026 at 02:15:58PM -0400, Colin Walters wrote:
> Commit f77f281b6118 ("fsverity: use a hashtable to find the fsverity_info")
> that broke `ovl_ensure_verity_loaded` in the case when the inode was not in core.
> 
> The APIs here are in my opinion now confusing, but this patch intentionally
> aims for a minimized fix by using `fsverity_get_info()` which ensures
> the hash table is loaded.
> 
> Fixes: f77f281b6118 ("fsverity: use a hashtable to find the fsverity_info")
> Cc: stable@vger.kernel.org
> Link: https://github.com/bootc-dev/bootc/issues/2174
> Signed-off-by: Colin Walters <walters@verbum.org>

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

I can take this through the fsverity tree as a fix for 7.1.  Amir, let
me know if you'd prefer to take it instead.

- Eric
