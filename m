Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2013B7B7D
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2026 09:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778144760; cv=none; b=seChRBZ1H9uEgfwrkz/lBdIbp3eUOvdlewDRn/z0SHMoKZiYNvI+gIK/seEeYSk9/Vm1Ie4lg2gCoA5/RjOrAIkb6cD4q6uC28RybhP6vehL/8V34fSZ8HH45crm+tqfsp51DoflhGDh2Wl2mO3hnJcxr6KrzHEq6vJxi6wen+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778144760; c=relaxed/simple;
	bh=A+3i0XN4AFBZ9dfIkXaceiFKk0CPD1o3v5yJg5xyhHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAeSIKK5nFLJ8VtVGztv81VYrvuIiG56q8T4ZGTF1OhBqelPRZri50Zzm9jA31Ej/POYER5tnngFg/RZKVvHiup/hIfGPBkXwVIdsQWKLLE18aD4aL1DpGakBka4LJ14fFLZnb6o+BQaWuAqvVHLFmCwu/ccCXA0T0JMvBgxgds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0jqewB9G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0jqewB9G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9339C2BCB2;
	Thu,  7 May 2026 09:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778144759;
	bh=A+3i0XN4AFBZ9dfIkXaceiFKk0CPD1o3v5yJg5xyhHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0jqewB9GFglbbb+Dhy45VTjzfvZm67rR66m47zRkHBJ0oRs2hEPpM0rFM3C9d2Bkc
	 pFS5jUVPZ1pFOgGL89jiFJXpGAjBmnBvV2r6Cv3vQwYdAKsB+b5t8zr/l8cGjIl/bY
	 oWs/voHyWFyNMrhwDOGBHcA8GD7ylakW92NITxlA=
Date: Thu, 7 May 2026 11:05:16 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sysfs: upgrade OOB write by buggy .show hook into WARNing
Message-ID: <2026050720-plating-cling-153a@gregkh>
References: <5f794f46-5afd-405c-9747-76f2c95d4598@p183>
 <3cc3e8c6-c6e8-4625-a88f-f5708b935dab@p183>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cc3e8c6-c6e8-4625-a88f-f5708b935dab@p183>

On Thu, May 07, 2026 at 12:01:43PM +0300, Alexey Dobriyan wrote:
> Buggy .show hook will get just 1 line of dmesg:
> 
> 	fill_read_buffer: ext4_attr_show+0x0/0x600 returned bad count
> 
> It may or may not oops later in some unrelated process.
> 
> But buggy .show hook most likely is corrupting random memory past sysfs
> buffer therefore deserving more. WARN, make it more visible and let
> QA machines panic earlier.
> 
> Also, delete useless cast -- "count" is >=0 at this point.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  fs/sysfs/file.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

The first was fine, no need for [PATCH] :)

> --- a/fs/sysfs/file.c
> +++ b/fs/sysfs/file.c
> @@ -70,9 +70,8 @@ static int sysfs_kf_seq_show(struct seq_file *sf, void *v)
>  	 * The code works fine with PAGE_SIZE return but it's likely to
>  	 * indicate truncated result or overflow in normal use cases.
>  	 */
> -	if (count >= (ssize_t)PAGE_SIZE) {
> -		printk("fill_read_buffer: %pS returned bad count\n",
> -				ops->show);
> +	if (count >= PAGE_SIZE) {
> +		WARN(1, "OOB write or bad count %zd at %pS\n", count, ops->show);

This is going to be interesting to see what triggers, so I'll go queue
this up soon.

And this implies you did hit this on ext4?  What sysfs file for ext4 is
doing this?  That should not be a valid sysfs file at all.

thanks,

greg k-h
