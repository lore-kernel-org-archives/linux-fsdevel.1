Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B0D39A04B
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 12:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776427245; cv=none; b=c/tnv5P4U4QwwhNmkMhf4d4Mw280gGZyUnFg2uXCHhMcpdad2/cyAodnHnPacf8NwZuee+cMVoM1pXZbE/Zx1MovneCjTXa64SIHTH2If2ubldKfkCfI5Lwc5AUVjrNtnkpoFmvL2SnR0jD6glQEToFA4giOX7CNffajGigYe6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776427245; c=relaxed/simple;
	bh=/mebf8WZV8v1SYo56S2SN+FCRANMcMZd9ngOBltVzRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrMgBO3yaTiyvu+2lvB5e7mrw3tYD5lpXqE/rV4/e8ObP+sULyt52IYggAJj8fJXse7k/fdkvTyVQ/2FyqB2qcfwFj7AouUBYCWm6qxnZn0xtKAajAEkcfc1ShqlNLfmXB50N+dRUiWF2ReAa3d2wV4B7kjTuaiOPko1nPHszZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=BHWlYUQZ; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="BHWlYUQZ"
X-KPN-MessageId: 09ab1c4c-3a55-11f1-afda-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 09ab1c4c-3a55-11f1-afda-005056994fde;
	Fri, 17 Apr 2026 14:00:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=tQxKHRvCVKwjXO1UPoW8+Q7+QcfnLs46o40cAz7s+no=;
	b=BHWlYUQZrO0+E1VhPVrkC6ck8qUzbjPqJAUpOZydhfZiwvQIIZ4yAA2OYpMoN9+NDiRG315tHU3xG
	 lcNH0/WBVzNAE0aKnBhi1AsIz7VNbjm5sJvMsZnVX/p44mTEDvftzF5DxMb3s7ZombclI2kuTtvYOX
	 2/Hmm/pYWHuC5iMqafbWye7/Q6MPc1erK7q7z8KtMZRO32ZmM9QiePPl6Lov2d1KvM+9Kjw6rOEb8v
	 69tX9qc1FCOk9mQ3yfqt9PO+qpBreElSOPI0YTi3mZblq0pNKsuknq1y2PS+wEDnxnfSdGqfrj7yLa
	 9oPT20iKG6M97R4YlI7dNkmH55Nt37A==
X-KPN-MID: 33|uQ2TWHBv59Dx3f6/BtdXxVS6UQbceuEirV++5Z+T4O6tX3AJ3bkLH4DMUy4ab/D
 kfoXijp7G1/VlzXp/qAeBG0PwTaff8bCqGSwI5KOiyko=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|2flYHlTDSG4yeXNcApby74D+1BOYzWNQNoFzcSV5fwMabnMFVIJTJ1qbMmjAnuR
 /HndmkcpFWJ2N+m8GkOoJlg==
Received: from localhost (142-169-144-85.ftth.glasoperator.nl [85.144.169.142])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 098fb269-3a55-11f1-86d5-005056998788;
	Fri, 17 Apr 2026 14:00:33 +0200 (CEST)
Date: Fri, 17 Apr 2026 14:00:29 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dcache: use kmalloc_flex() in __d_alloc
Message-ID: <aeIdyBAs_uqjlSGk@lt-jori.localdomain>
Mail-Followup-To: Jori Koolstra <jkoolstra@xs4all.nl>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
References: <20260417094238.551114-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417094238.551114-3-thorsten.blum@linux.dev>

On Fri, Apr 17, 2026 at 11:42:40AM +0200, Thorsten Blum wrote:
> Use kmalloc_flex() when allocating a new 'struct external_name' in
> __d_alloc() to replace offsetof() and the open-coded size arithmetic,
> and to keep the size type-safe.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  fs/dcache.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index dbcbd0affb26..4568f9530166 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1753,10 +1753,10 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
>  		name = &slash_name;
>  		dname = dentry->d_shortname.string;
>  	} else if (name->len > DNAME_INLINE_LEN-1) {
> -		size_t size = offsetof(struct external_name, name[1]);
> -		struct external_name *p = kmalloc(size + name->len,
> -						  GFP_KERNEL_ACCOUNT |
> -						  __GFP_RECLAIMABLE);
> +		struct external_name *p;
> +
> +		p = kmalloc_flex(*p, name, name->len + 1,
> +				 GFP_KERNEL_ACCOUNT | __GFP_RECLAIMABLE);
>  		if (!p) {
>  			kmem_cache_free(dentry_cache, dentry); 
>  			return NULL;

Looks reasonable to me. Is the idea to completely outphase this old way
of requesting memory for structs with flexible array members?

Feel free to add:

Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>
