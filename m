Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22671FBC8E
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784994081; cv=none; b=AKR6bK+dkluzh99NdSleVQsz6wN3y+NxUSytb7iNpaL0aBi6KwOq1YhVlYjA1OH3kve0SCxIuPFExBTVFK+P68ugcOXns/hOU8OvThkWkSz1K+uqzncPwRU/uzTNl2752e4qAAdbBOrLw8kHIBMPjUQ5BlFNFFcTtetL/dG9bII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784994081; c=relaxed/simple;
	bh=sF6v1IDuQq939BWpVkK1+YyCt8GInJ0taks92LpLtnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtXelKZL21B2vyDxNvywrrg0oQyC7WzjTl+72Eib5a8QcIVKgM4WYG9tBLdIZLxHwSLA8IEctVKTp7BvquQJBylMaMdfKSNqeTPAzN3JlLAwBjLeN1g5OPQsJ80PjL2MTKVODB2WEviPSN0zk+mCIMEfOUfX8rksn74DvEVcYyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=EIzzS/ba; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="EIzzS/ba"
X-KPN-MessageId: 42d1a85e-883f-11f1-83b3-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 42d1a85e-883f-11f1-83b3-005056ab378f;
	Sat, 25 Jul 2026 17:41:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=Wx81lLP7hXUWJpNdKKWFqKhuIhTVDLNbjdJ9wFEaxLo=;
	b=EIzzS/baclYUtjbi85CgVcJ5z+eHVCEbguPJgpwcY6++LfzI+siTqga1+hJPWFTkH7ClTsy5C/XEB
	 EgQStG1c25atbX6CDS3kd18ZBVCcNn52a0e0aZyMAxTKnWgd4m1bYW8M5Sc+D1b7t67c9zcU/HV/E8
	 bWIKvqrm1T6DidkCYPYCnSXlx2I+i3uVGq7S8FdQiVUS18/HpalhTcYnwwenYVV7IceeouluGEnbQa
	 Pp+2nQdLkB+vKHKYxKkqjrruls1Fmxovcjz11QxQ+D6DRVX3FHGGKzbPnkFSziMVhyOGq0YEWKCPJ1
	 69HTr84TmvVqwKparVgh/MB6Kno9ZAg==
X-KPN-MID: 33|/G2fYnTMOZHzL+r5C9Db6iGAbSG9KRCSRqjNnjWqdsxzswG9vmrKNvd6tvj/bhm
 K7E85B8/mh9AIIkUJOn5sBitaUnaR5laP9ZRQP+dmvTg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|OssebP6AExbBwggMlszUqMGSp/bjpyczuxoWEXW51He5UrF6ucVvSqnUVaap1OA
 gBGthrxEvHScrvF3L6Vp2sg==
Received: from localhost (142-169-144-85.ftth.glasoperator.nl [85.144.169.142])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 429a2b98-883f-11f1-86b1-005056ab7584;
	Sat, 25 Jul 2026 17:41:10 +0200 (CEST)
Date: Sat, 25 Jul 2026 17:41:09 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com
Subject: Re: [PATCH v3 10/24] binfmt_misc: remove the VERBOSE_STATUS toggle
Message-ID: <amTZBngsF-_vbJHi@lt-jori.localdomain>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
 <20260710-work-binfmt_misc-locking-v3-10-a162f7cb58d6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-10-a162f7cb58d6@kernel.org>

On Fri, Jul 10, 2026 at 11:33:11AM +0200, Christian Brauner wrote:
> VERBOSE_STATUS is a compile-time constant that has been fixed to 1
> for as long as git history reaches. Turning it off requires editing
> the source and yields entry files that only ever report
> "enabled"/"disabled", a format nothing has ever seen in the wild.
> Remove the pretend knob and the dead branch it guards.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/binfmt_misc.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index 9be57f387524..96f9ac752511 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -38,10 +38,6 @@
>  # define USE_DEBUG 0
>  #endif
>  
> -enum {
> -	VERBOSE_STATUS = 1 /* make it zero to save 400 bytes kernel memory */
> -};
> -
>  /* Entry status and match type bit numbers. */
>  enum binfmt_misc_entry_bits {
>  	MISC_FMT_ENABLED_BIT	= 0,
> @@ -611,11 +607,6 @@ static void entry_status(struct binfmt_misc_entry *e, char *page)
>  	if (test_bit(MISC_FMT_ENABLED_BIT, &e->flags))
>  		status = "enabled";
>  
> -	if (!VERBOSE_STATUS) {
> -		sprintf(page, "%s\n", status);
> -		return;
> -	}
> -
>  	dp += sprintf(dp, "%s\ninterpreter %s\n", status, e->interpreter);
>  
>  	/* print the special flags */
> 
> -- 
> 2.53.0
> 

Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>
