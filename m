Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99F43CE4BB;
	Wed, 22 Apr 2026 13:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776863211; cv=none; b=Omj1nd+TbfokxwKE0nqrUONqhUdzTGlkqS003/AP5v52yFXSii1DgzEoNiOIfVt3iLUM3t5h+7BPXzbyGfPqitOz0EZbhG1ZS4o2a/SZiRFHV9te1lkQ9YMSFGWJfenQyrt+XcH0uS9OOxt0PwNw8pelPXrMhkTKXUdmrJsFY+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776863211; c=relaxed/simple;
	bh=kB9JzBds6IDSE9WxYg+/3C1bMrFn8n7v0bBZmIr4aqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqnXLRagKe/L6fFfZhffwFm7ke8DXXQu2Vcn7FasLM9Jqy5/v45LF5zOXVuQxfAdXG9EmFZSSvUPGq849cTadlc7PkrvyT/CiRyAXPpjiaurCgjQoc/gg5YFrp884oohbidzdUOXpbAJJgrr4/tjxTLVnHUurI6R7ZdOhY0RpO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cx7oCsU1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cx7oCsU1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6CAC19425;
	Wed, 22 Apr 2026 13:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776863211;
	bh=kB9JzBds6IDSE9WxYg+/3C1bMrFn8n7v0bBZmIr4aqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cx7oCsU1oIIND9owOZ7/T9b+Dzxt1Up8ewh6OnPGYSmqMks84p3dPM702afylCSV8
	 A9ItBCKnbLPxV0ThFNkX/UzH9A9cQCv8qkIltpw8re49c2KKuwILJpP77EueayJ233
	 BmuE6uCct8ylFMVEIklTBPSODaBm8luqcNaLwvBBbmIWCjtnBPtEQfXOoW46jwLIlG
	 Vp9PrHWge2C74whb74u1iAaXxXgrEHhS4DFEJDUr59q8MKyZezbkPCZeB1resiCZOX
	 w4bVCaY7OCo8WxMWXx7j0BXbU2LJdFjspTqCTWXdqAtV1Wm93wmFZQdQjbTCvt9UgY
	 zIrYgEV1ty0Mg==
Date: Wed, 22 Apr 2026 15:06:47 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dcache: add extra sanity checks of the dentry in
 dentry_free()
Message-ID: <20260422-modebranche-vierundzwanzig-f4e000dee32c@brauner>
References: <20260422-dcache-warn-v1-1-50155e1b40b6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260422-dcache-warn-v1-1-50155e1b40b6@kernel.org>

On Wed, Apr 22, 2026 at 07:29:48AM -0400, Jeff Layton wrote:
> If d_flags isn't what we expect, then it's good to display it. Add a new
> DENTRY_WARN_ONCE() macro that also displays d_flags for the dentry.
> Change D_FLAG_VERIFY() to call that instead of a generic WARN_ON_ONCE().
> 
> Change the existing hlist_unhashed() check in dentry_free() to use the
> new macro, and add checks for other invariants of a dead dentry. Notably:
> 
> 1) Ensure that DCACHE_LRU_LIST and DCACHE_SHRINK_LIST are not set.
> 
> 2) Ensure that d_lockref is negative
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> While chatting with Al about this elusive UAF problem, we both noted
> that it would be nice to know what d_flags are when these warnings pop.
> This adds that, and checks for some other invariants in dentry_free().
> ---
>  fs/dcache.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 2c61aeea41f4..210df5c0a1f0 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -426,9 +426,16 @@ static inline void __d_clear_type_and_inode(struct dentry *dentry)
>  		this_cpu_inc(nr_dentry_negative);
>  }
>  
> +#define DENTRY_WARN_ONCE(condition, dentry) \
> +	WARN_ONCE((condition), "dentry=%p d_flags=0x%x\n", (dentry), (dentry)->d_flags)
> +#define D_FLAG_VERIFY(dentry, x) \
> +	DENTRY_WARN_ONCE(((dentry)->d_flags & (DCACHE_LRU_LIST | DCACHE_SHRINK_LIST)) != (x), (dentry))

Would be nice if we had a bunch of dentry debug assert macros in
vfsdebug.h like we have for VFS_BUG_ON_INODE()/VFS_WARN_ON_INODE() in
general imo.
