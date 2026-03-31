Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1943BE17C;
	Tue, 31 Mar 2026 09:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774949958; cv=none; b=u9T5Tp5Pan1OxQ6O9SJuMxTm28Xgvo6ED2fuqWCAjiVMU0kDcSMGnWtxEHjwOyGhDk0Og7ius6XCIgJ+OVzUP5QxUU7ywsTgg4y5XaIX4XEWhCn6eFr4jYs0z7lHJH98+6zyOUGdu+N+Lr/1xrEyKgLeM3yi5QHkzBUwsxglza4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774949958; c=relaxed/simple;
	bh=ayeSPJmHZOcHrPB9/5+wkpjNjYwSLOFhYj4hNTaneQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GS3oiSunaSb/TUu+5M2OA6aqtgqoeDzDrn/MyKLuLxhLmULL13VxqtNeQu2u5bag3XNJOio+NVcIiL06R9b8Qjr9zRFC8jQ2zhe1GnHO9UN8R01bed9fYgk+N9ygjiJS6j+3FkhrkPVGcD8qml/rNFcAPJlFTRwEEe97noz86Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=et5IUoL5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="et5IUoL5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAC8C19423;
	Tue, 31 Mar 2026 09:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774949958;
	bh=ayeSPJmHZOcHrPB9/5+wkpjNjYwSLOFhYj4hNTaneQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=et5IUoL55TA/a+xqkoIA5L3R8x4kQ1s+Sh/3kWSyZDzz6DpWEep87yfQtx70fM5jX
	 twNYMS5E5BHK73ZCyUyOBvL1Nj5q3t6+Q6o6uLCBA/4+ykHJeNBT6L3I5i+snW+I9J
	 gBX5z6O0a36zonJe+VQt46pgLFId+8SKBObdMsYl9lrlac9o11pntRBbi2F/EJsR0I
	 NswVycfFX8PZrl4EfiGY4WUH6SBeRd4/FrNxav/Sv5ivxV0Y3f3IoswEpaEr56EoU9
	 fu46SJ3KjvOOVtK8o5kMGFTJUSSgnDP/b/T3GTl1CyepveTf0Wc5bmNdYCICP6RvQp
	 odHm2xJus4UqQ==
Date: Tue, 31 Mar 2026 11:39:12 +0200
From: Christian Brauner <brauner@kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, 
	Eric Sandeen <sandeen@sandeen.net>, Frank Sorenson <fsorenso@redhat.com>, 
	Jay Shin <jaeshin@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Yafang Shao <laoar.shao@gmail.com>, Jan Kara <jack@suse.cz>, Waiman Long <longman@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Wangkai <wangkai86@huawei.com>, 
	Colin Walters <walters@verbum.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] vfs: limit directory child dentry retention
Message-ID: <20260331-engste-raushalten-f66cd264ce77@brauner>
References: <20260331012925.74840-1-raven@themaw.net>
 <20260331012925.74840-2-raven@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260331012925.74840-2-raven@themaw.net>

On Tue, Mar 31, 2026 at 09:29:09AM +0800, Ian Kent wrote:
> If there's a very large number of children present in a directory dentry
> then the benifit from retaining stale child dentries for re-use can
> become ineffective. Even hashed lookup can become ineffective as hash
> chains grow, time taken to umount a file system can increase a lot, as
> well as child dentry traversals resulting in lock held too long log
> messages.

Fwiw, there's also e6957c99dca5 ("vfs: Add a sysctl for automated deletion of dentry")

This patch introduces the concept conditionally, where the associated
dentry is deleted only when the user explicitly opts for it during file
removal. A new sysctl fs.automated_deletion_of_dentry is added for this
purpose. Its default value is set to 0.

I have no massive objections to your approach. It feels a bit hacky tbh
as it seems to degrade performance for new workloads in favor old
workloads. The LRU should sort this out though.

> But when a directory dentry has a very large number of children the
> parent dentry reference count is dominated by the contribution of its
> children. So it makes sense to not retain dentries if the parent
> reference count is large.
> 
> Setting some large high water mark (eg. 500000) over which dentries
> are discarded instead of retained on final dput() would help a lot
> by preventing dentry caching contributing to the problem.
> 
> Signed-off-by: Ian Kent <raven@themaw.net>
> ---
>  Documentation/admin-guide/sysctl/fs.rst |  7 +++++++
>  fs/dcache.c                             | 28 +++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
> index 9b7f65c3efd8..7649254f2d0d 100644
> --- a/Documentation/admin-guide/sysctl/fs.rst
> +++ b/Documentation/admin-guide/sysctl/fs.rst
> @@ -75,6 +75,13 @@ negative dentries which do not map to any files. Instead,
>  they help speeding up rejection of non-existing files provided
>  by the users.
>  
> +dir-stale-max
> +-------------
> +
> +Used to limit the number of stale child dentries retained in a
> +directory before the benifit of caching the dentry is negated by
> +the cost of traversing hash buckets during lookups or enumerating
> +the directory children. Initially set to 500000.
>  
>  file-max & file-nr
>  ------------------
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 7ba1801d8132..298b4c3b1493 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -86,6 +86,14 @@ __cacheline_aligned_in_smp DEFINE_SEQLOCK(rename_lock);
>  
>  EXPORT_SYMBOL(rename_lock);
>  
> +static long dsm_zero = 0;
> +static long dsm_max = ULONG_MAX/2;
> +
> +/* Highwater mark for number of stale entries in a directory (loosely
> + * measured by parent dentry reference count).
> + */
> +static unsigned long dir_stale_max __read_mostly = 500000;
> +
>  static struct kmem_cache *__dentry_cache __ro_after_init;
>  #define dentry_cache runtime_const_ptr(__dentry_cache)
>  
> @@ -216,6 +224,15 @@ static const struct ctl_table fs_dcache_sysctls[] = {
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_ONE,
>  	},
> +	{
> +		.procname	= "dir-stale-max",
> +		.data		= &dir_stale_max,
> +		.maxlen		= sizeof(dir_stale_max),
> +		.mode		= 0644,
> +		.proc_handler	= proc_doulongvec_minmax,
> +		.extra1		= &dsm_zero,
> +		.extra2		= &dsm_max,
> +	},
>  };
>  
>  static const struct ctl_table vm_dcache_sysctls[] = {
> @@ -768,6 +785,17 @@ static inline bool retain_dentry(struct dentry *dentry, bool locked)
>  	if (unlikely(d_flags & DCACHE_DONTCACHE))
>  		return false;
>  
> +	if (dir_stale_max) {
> +		unsigned long p_count;
> +
> +		// If the parent reference count is higher than some large value
> +		// its dominated by the contribution of its children so there's
> +		// no benefit caching the dentry over re-allocating it.
> +		p_count = READ_ONCE(dentry->d_parent->d_lockref.count);
> +		if (unlikely(p_count > dir_stale_max))
> +			return false;
> +	}
> +
>  	// At this point it looks like we ought to keep it.  We also might
>  	// need to do something - put it on LRU if it wasn't there already
>  	// and mark it referenced if it was on LRU, but not marked yet.
> -- 
> 2.53.0
> 
