Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA5630D414
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 15:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784994143; cv=none; b=QQPVNCPtys5atJNA3FfBIwVw6xqUov3PySiUyuDYkWhza0JJcpA4gPq3zdk2arhgg9WgAZWZMtHQqPTFImfSLTfgQ29+Sj1hLv9lTqCB55B/vZpClSqN+CS1kUDG/dd2LAKQf1Vw5AtybiCLSTsMzrM271tK0u6CuDtnHfxXvEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784994143; c=relaxed/simple;
	bh=KV/jGw9TvuAJoqiRFGR2QuupG5XCFhwlufQ3cy+qg6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQ0j7704KaLqnpUkVdUpjGk2jF+78jCyiOx8XXmS1OLaP9MiXCVW1zoTFPSe9Gh0TZDogsZOkZIIvMIFNR++fJk3gaP6BjRcEr6lovEIfkrci8XdFCotAE5ZlF2IddPfiP+4rcYMh/Sjq+TeoAO7hqqSbxjHfe/MLQyE/uFnXhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=ifIAvxqX; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="ifIAvxqX"
X-KPN-MessageId: 6a1bcd6e-883f-11f1-83b3-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 6a1bcd6e-883f-11f1-83b3-005056ab378f;
	Sat, 25 Jul 2026 17:42:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=aFH6L6TDEG8NMLi73+H0H0u9v9NQ3v3cVv7BpAPvt0E=;
	b=ifIAvxqXTZqj+/DvB5kbWy16jxjv62/RjZY4DJtqMn6xYp/bINP7LLzNviWXSW2a2xazWAoBBkJtA
	 1Wi2A/xwtEeKjFdMpL8hmxJ+nSSwdQ3HYivl+QKT3vohoWjpAmb7az+t1PllzOiT0jEzeljLho0+UC
	 qMWwaUOzQlDLGNaPL3y3UbMmqoCXnkggHK3Q+9t9MZbqkN372a2Rah0F4bcjqFDStw2DQLUio6oCX/
	 Jnan5H5ohSW5q23sTGpxYK25PMr/4NLHGK4YB5XSKg/2mRtkZhWwbX6IZ/PbSR4qjhmh8qMcOO63O3
	 peS928BA2ima+hf275FlSKlmmMkYUYA==
X-KPN-MID: 33|dH2tP463fCT0O+caNWDM/in+Ldj6cpgfqLQQBoT+2Pm8u7vRKRaDFJq2/grCWpR
 hzCAOe7ZQvmL5Pl9KcIa4iR4eQmm8CBluEEsCjAA69KI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|LLpRSe7cTKJnryiIwk0Cfvus/MgiK/i1gjAA3uPyXWeXv+sKgjqYbU618imsgNg
 Ah8MAUOuW2+rMODbXZdCzhg==
Received: from localhost (142-169-144-85.ftth.glasoperator.nl [85.144.169.142])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 69d930f0-883f-11f1-9226-005056ab1411;
	Sat, 25 Jul 2026 17:42:16 +0200 (CEST)
Date: Sat, 25 Jul 2026 17:42:15 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com
Subject: Re: [PATCH v3 11/24] binfmt_misc: use print_hex_dump_debug() for the
 register debug output
Message-ID: <amTZTrd-dp9rS4to@lt-jori.localdomain>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
 <20260710-work-binfmt_misc-locking-v3-11-a162f7cb58d6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-11-a162f7cb58d6@kernel.org>

On Fri, Jul 10, 2026 at 11:33:12AM +0200, Christian Brauner wrote:
> The hex dumps in create_entry() are compiled out unless someone edits
> the file to define DEBUG while the pr_debug() calls right next to
> them are dynamic-debug aware. Switch the dumps to
> print_hex_dump_debug() which follows the same rules as pr_debug() so
> the register parsing debug output is uniformly controlled through
> dynamic debug, and remove the USE_DEBUG machinery.
> 
> Drop the magic[masked] dump instead of converting it: it printed the
> bitwise AND of two buffers dumped right above it and required a
> temporary allocation on every registration just to recompute what
> the reader can derive from the magic and mask dumps directly.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/binfmt_misc.c | 52 +++++++++++++++-------------------------------------
>  1 file changed, 15 insertions(+), 37 deletions(-)
> 
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index 96f9ac752511..252e1f2a8347 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -32,12 +32,6 @@
>  
>  #include "internal.h"
>  
> -#ifdef DEBUG
> -# define USE_DEBUG 1
> -#else
> -# define USE_DEBUG 0
> -#endif
> -
>  /* Entry status and match type bit numbers. */
>  enum binfmt_misc_entry_bits {
>  	MISC_FMT_ENABLED_BIT	= 0,
> @@ -460,10 +454,9 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
>  			goto einval;
>  		if (!e->magic[0])
>  			goto einval;
> -		if (USE_DEBUG)
> -			print_hex_dump_bytes(
> -				KBUILD_MODNAME ": register: magic[raw]: ",
> -				DUMP_PREFIX_NONE, e->magic, p - e->magic);
> +		print_hex_dump_debug(
> +			KBUILD_MODNAME ": register: magic[raw]: ",
> +			DUMP_PREFIX_NONE, 16, 1, e->magic, p - e->magic, true);
>  
>  		/* Parse the 'mask' field. */
>  		e->mask = p;
> @@ -473,10 +466,12 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
>  		if (!e->mask[0]) {
>  			e->mask = NULL;
>  			pr_debug("register:  mask[raw]: none\n");
> -		} else if (USE_DEBUG)
> -			print_hex_dump_bytes(
> +		} else {
> +			print_hex_dump_debug(
>  				KBUILD_MODNAME ": register:  mask[raw]: ",
> -				DUMP_PREFIX_NONE, e->mask, p - e->mask);
> +				DUMP_PREFIX_NONE, 16, 1, e->mask, p - e->mask,
> +				true);
> +		}
>  
>  		/*
>  		 * Decode the magic & mask fields.
> @@ -492,30 +487,13 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
>  		    BINPRM_BUF_SIZE - e->size < e->offset)
>  			goto einval;
>  		pr_debug("register: magic/mask length: %i\n", e->size);
> -		if (USE_DEBUG) {
> -			print_hex_dump_bytes(
> -				KBUILD_MODNAME ": register: magic[decoded]: ",
> -				DUMP_PREFIX_NONE, e->magic, e->size);
> -
> -			if (e->mask) {
> -				int i;
> -				char *masked = kmalloc(e->size, GFP_KERNEL_ACCOUNT);
> -
> -				print_hex_dump_bytes(
> -					KBUILD_MODNAME ": register:  mask[decoded]: ",
> -					DUMP_PREFIX_NONE, e->mask, e->size);
> -
> -				if (masked) {
> -					for (i = 0; i < e->size; ++i)
> -						masked[i] = e->magic[i] & e->mask[i];
> -					print_hex_dump_bytes(
> -						KBUILD_MODNAME ": register:  magic[masked]: ",
> -						DUMP_PREFIX_NONE, masked, e->size);
> -
> -					kfree(masked);
> -				}
> -			}
> -		}
> +		print_hex_dump_debug(
> +			KBUILD_MODNAME ": register: magic[decoded]: ",
> +			DUMP_PREFIX_NONE, 16, 1, e->magic, e->size, true);
> +		if (e->mask)
> +			print_hex_dump_debug(
> +				KBUILD_MODNAME ": register:  mask[decoded]: ",
> +				DUMP_PREFIX_NONE, 16, 1, e->mask, e->size, true);
>  	} else {
>  		/* Handle the 'E' (extension) format. */
>  
> 
> -- 
> 2.53.0
> 

Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>
