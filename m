Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D86226E719
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 08:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770280078; cv=none; b=sErOJcbLootX5FpfEZOrKa0wCyVqgH/nHKLHX7h/ah5Xy3yTidx9z3FhdTKO56nmNVHXpcnoqgtvyZ42lRqtFZ3qv7YnyUu0EbQ7r73znFsBXUB++YukswRgRm3PF36x+jUXInuFKhQh106ZyLRL6wkgyCt9Lcll2xXDItTVA+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770280078; c=relaxed/simple;
	bh=WAFxCt2dmvwkRYa1ZROvHxBbOBPJT3xzQB6cLvtDaOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHOZHq998C5Zo2fCJma+lFbpeSbqFbvEC+6xGTqDydVzk/VBRGDweZUtEnNStnHjH0BO5KNIhGNhTl1ufXg7DlJdYlKCpX71cFh1lKlXHqanLNR3TSR3CEf1ZCvC5Q/nLYm2fvSGobcTdN29hE2rG8xwr4nR8rQHhc3cU2CykJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADTK5344; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADTK5344"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5365C4CEF7;
	Thu,  5 Feb 2026 08:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770280078;
	bh=WAFxCt2dmvwkRYa1ZROvHxBbOBPJT3xzQB6cLvtDaOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ADTK534453o2aqFOPbpnk4YvSRfbcGepiQSh5wvx1HkYoFjQYJTs3FWN/VHhKQOgh
	 Pn3B3G4rmkUbmmqlAALp1aCnLaahvq7Z6xkMbFjx95oFKKdhkiJwDozdZbIxC5zxYR
	 ZXsqrPhijkzzhPiMgT1yq6A/n2HRSaJAMQNo1g5tOTfIUWXFl49aPdDVwF6e3koaN9
	 WuWoONZCo/CdRtFW71okmNjt7ItLl0YKtDfHATBIrMZEyx9Smjp4qqKZpVGPt+SUzO
	 OE+oo54utbqVnFLi5AY7SfDT4lixi2JqCHl7FAQj+9RzIT3Sf8HryIAfglhiC0t1Qz
	 2xx9eXUQOx1XQ==
Date: Thu, 5 Feb 2026 09:27:54 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH][RFC] rust_binderfs: fix a dentry leak (regression from
 tree-in-dcache conversion)
Message-ID: <20260205-surfen-gemerkt-e3601f22535c@brauner>
References: <20260205074342.GR3183987@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260205074342.GR3183987@ZenIV>

On Thu, Feb 05, 2026 at 07:43:42AM +0000, Al Viro wrote:
> [just realized that this one had been sitting in #fixes without being
> posted - sorry]
> 
> Parallel to binderfs patches - 02da8d2c0965 "binderfs_binder_ctl_create():
> kill a bogus check" and the bit of b89aa544821d "convert binderfs" that
> got lost when making 4433d8e25d73 "convert rust_binderfs"; the former is
> a cleanup, the latter is about marking /binder-control persistent, so that
> it would be taken out on umount.
> 
> Fixes: 4433d8e25d73 ("convert rust_binderfs")
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  drivers/android/binder/rust_binderfs.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/android/binder/rust_binderfs.c b/drivers/android/binder/rust_binderfs.c
> index c69026df775c..e36011e89116 100644
> --- a/drivers/android/binder/rust_binderfs.c
> +++ b/drivers/android/binder/rust_binderfs.c
> @@ -391,12 +391,6 @@ static int binderfs_binder_ctl_create(struct super_block *sb)
>  	if (!device)
>  		return -ENOMEM;
>  
> -	/* If we have already created a binder-control node, return. */
> -	if (info->control_dentry) {
> -		ret = 0;
> -		goto out;
> -	}

I thought at some point this was supposed to have a second callpath
which is probably why that check existed. Anyway, thanks for the
cleanup,

Acked-by: Christian Brauner <brauner@kernel.org>
