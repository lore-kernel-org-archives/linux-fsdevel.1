Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4064224A078;
	Sun, 27 Sep 2026 15:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790521291; cv=none; b=FIzok506tXta0WT5/OQn1wCxcpCMWw2Z8RPpezNKtxRS+Tgk/N5tPFC9N0aNNn1GjT5gsvACD5Wu4fwEy0GNg/gn9pILNvR8bJb2weTeAVeuz1hkoopF3NLGV6z8JjWGuJt2LHJwEG9qA/sYX4zKavQp1/6QO0aYfbsgHPIDGiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790521291; c=relaxed/simple;
	bh=AeMIRYFusMVRfswpqJtznNvwx3aMmkDbS85bKabFBo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVTV/z5CXoX0BQnkBXPujF2Vw4GxhvSp0dN39iWfYoXLTPAODZU/nItu6+F0oM+HeNW37PxL/M7NstIsfDvOo3X8oURf2RIfneCmRp4e5kerHT4G16NCm7b65O/JHDhLuIH8+mKZImUxAo++bhx8mS3DiQ+fNc4cQtPYYKfkQQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyavYK7d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyavYK7d"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C589F1F000FF;
	Sun, 27 Sep 2026 15:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790521289;
	bh=7SEKkFkETHcFFSB3GwBb5Sdwu46tSVH9N/BZ4CakyGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KyavYK7dDsLVPlMHH2fyeauH8kcQMCtlgWOq4PMO5Idg4joND1ZztHuZFqk8KxAsB
	 8F/SXzKTta5D6Il84py/gpBRaDvf+Pt9NhenN6Qtdx+0bUMztXDz1zumBA85zjmauI
	 IPuiaD4jxi97f2w9wV2pua9Psdj1yA1D7D2f9jUD3rwhgtiZyvo4uqhFbNFbNJU0yB
	 MM7EdqE1tMs36J4mzG4VnKhBYvb6S86dbOzfMJMoouQSuq3d03T1lbly3/HGiAysOt
	 ocu47eZmUzVgqcAB4C4IJWp24iTNC/yV8aM4GLHrqLqQxELyIJnhZAFmoZwRrVZvmG
	 fg4FSF+EsmPkQ==
Date: Sun, 27 Sep 2026 08:01:29 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	hch@infradead.org, david@fromorbit.com, amir73il@gmail.com,
	ansgar.loesser@kom.tu-darmstadt.de
Subject: Re: [PATCH v5 1/2] dax: return the comparison error from
 dax_dedupe_file_range_compare()
Message-ID: <20260927150129.GE6244@frogsfrogsfrogs>
References: <20260926043836.3301898-1-matthias.goergens@gmail.com>
 <20260926043836.3301898-2-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926043836.3301898-2-matthias.goergens@gmail.com>

On Sat, Sep 26, 2026 at 12:38:35PM +0800, Matthias Goergens wrote:
> dax_dedupe_file_range_compare() returns ret, the positive result of the
> last iomap_iter() call, when dax_range_compare_iter() fails. The caller
> treats any non-zero return as the result of the range preparation, and
> xfs_file_remap_range() returns it as the remap result, so a failed
> comparison on a DAX file reports success with a small positive length
> instead of the error.
> 
> Return the error itself.
> 
> Fixes: 0e79e3736d54 ("fsdax: dedupe: iter two files at the same time")
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>

That seems like a bug, I'm sorta surprised nobody noticed...

Cc: <stable@vger.kernel.org> # v6.2
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/dax.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 1fbba0d21c13..de11bbbb6a38 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -2264,7 +2264,7 @@ int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
>  		status = dax_range_compare_iter(&src_iter, &dst_iter,
>  				min(src_iter.len, dst_iter.len), same);
>  		if (status < 0)
> -			return ret;
> +			return status;
>  		src_iter.status = dst_iter.status = status;
>  	}
>  	return ret;
> -- 
> 2.55.0
> 
> 
