Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E3F2253EB
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 15:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783955320; cv=none; b=ONRbTUtU53KEWu6QEsLxWTJGQ7KDLPJ2yQQUUjUA6x4+dwPWu7s10wDyihWNlqHDZF2xehgX7nlBjUt6/0U5jTt3Etd1vS7PMVbZuJV6Yvjg4emmL5vqZlf9pxPNDoOA68n0FoE/ut9J1C6f+3Dzk3RpSw6Pv9iwsk24QdIShn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783955320; c=relaxed/simple;
	bh=toBpdXGBHWYpiLujW2oOVAT9P85XBd7XoB8Fs3oiCC0=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=Qwrv6vZ4Z6920UIeJVszjtL6JfvQcK/cTFPy2QGuofdl+sOtNZ0Yx/oBNTpWjRK1MVq+H9J7CBARFbNjOWlg8f0bTMGMG2z8V6ADZBPl0SFzAQjNe+wNvrXk1zoUHXmOn3dTxQ04lAnmVIuqvviaBrrViYWr7xBQoEFbrUeWy9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=QcjuKIwC; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="QcjuKIwC"
X-KPN-MessageId: b78b5c73-7ecc-11f1-8f54-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.188])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id b78b5c73-7ecc-11f1-8f54-005056992ed3;
	Mon, 13 Jul 2026 17:08:34 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id b78a21c4-7ecc-11f1-9b0c-00505699693e;
	Mon, 13 Jul 2026 17:08:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=bi9qlU8nFWGfauPcGhxB44CMzNrIyZ7W0UY5AXEndUE=;
	b=QcjuKIwCfkR8kGJI9lOqksMLoq9Gf2VuRhHwC8hjZQu9rc6LCeHikMd3P7iCVoRtNTa9TbpDlqoVO
	 NXED7fp/rp6lronYnt57osGKIkZ/bysG1YJyee1Aym4uy7N7q88n60syQ03waWOn7HQsfMx5T3Fpq3
	 +qW/X7OokLwiGGphAy+VpOxHSdutVlWfJyQ3qWioxNuHJ36T6FUNDFV3h8H+x540b9E2Fqd/ea5h5w
	 iDo9RoVKgAhBei+jxJkItrmiWIdO2ptUonKC9FVtdwAQKYd0A3gOjnsjUF9aNDgVbGDvEMzolt96IS
	 72px4S+MdYuLGu0YqrnFWsp5CvxWRhg==
X-KPN-MID: 33|QzMzZCuH7XDnURVDbtXPDo2/eYn/QpAbfssaKBTu2uFoegWElrXqonjhEpVvLfe
 7qSUOVleETqYhsYJtg9AjARdNKn2C+inwtqNc+umwohk=
X-CMASSUN: 33|T1zfVBcLR4FjE4IA5fiWzvAQH62e5E5Yx3CRNRXHwjPo1BIESGBW6fL8TcLCuJO
 QomJbLesE5yAt0cBsMRQjlA==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh04 (cpxoxapps-mh04.personalcloud.so.kpn.org [10.128.135.210])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id b77f2cc1-7ecc-11f1-8edb-00505699eff2;
	Mon, 13 Jul 2026 17:08:34 +0200 (CEST)
Date: Mon, 13 Jul 2026 17:08:34 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
	Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com
Message-ID: <208270655.874218.1783955314215@kpc.webmail.kpnmail.nl>
Subject: Re: [PATCH v3 11/24] binfmt_misc: use print_hex_dump_debug() for
 the register debug output
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal

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

You might use pr_fmt() instead of KBUILD_MODNAME to stay consistent, but
that's a very minor point only.

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

Good, this addresses some of the worst nesting in this function as
well.

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
