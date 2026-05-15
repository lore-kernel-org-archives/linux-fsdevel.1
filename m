Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7373EBF3A;
	Fri, 15 May 2026 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879240; cv=none; b=WE2ri7JbcpJgSJJLBRto43HhlpNX/HmIosA+T3RiNEzerX5Lbd3zwaggC9gx6G5c7rXnuv7mqULklg0gnHrNVF5aBBD4Lbo/y1Mvj92YYIJIt1PGfjZleYGbDzhQxtM4eBvopU4V+vWXhTx+f5lGP+f95+i++D06+XIYCynxr9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879240; c=relaxed/simple;
	bh=SAMvtSwxui9rx4WzJhguZTO0mUfAbW7D5AefAauZFSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4DYMeaLH0xCEVy7EmhvQTbN3GMbw716/m+qZjLOlcnZWT8Soj9P6bzzZTED64C6AYrnKqWsVqWfA+qOi9pa/PHWmk7uCq+4ReKmlN6ZKBkzKw2pqe+cTs+Ck7pvlGRFZInlEKwrqvDqWilcSM1OOHi1kefaIO6gen3J6gXyC7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9vai1pS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9vai1pS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174A2C2BCB0;
	Fri, 15 May 2026 21:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778879240;
	bh=SAMvtSwxui9rx4WzJhguZTO0mUfAbW7D5AefAauZFSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I9vai1pScdqJsj/HQhye63V623+psB7ww1UA8ynVYpYRNEhYv/Y4WTbtWow2GrNNe
	 9Vqe7n2MNbLjKskmfs0CmP3Mdm1tjcGxw+3EeVwNTr2PXk4oV/APJFY7DC+LxgntBi
	 WQEPmFi7Ov7lXVLKPW3BsNkh3mK7QyooIfu/LeDGSz1vwb3jRRDwmLPRo2pOMQMzD6
	 eoG9Z0Qi1BzCMtZH+NNKvz3XjRdZxHhb9/43iuZwjD92OPmjW46JH7luAgmk+hUO4u
	 SdOvNLC4nT763p+5u8kIXD8DC6k1j5YtQCGR9+r3pY8tJfO8HcRz9/WXiwD4F2lfS4
	 mmoGYNOEhOUPQ==
Date: Fri, 15 May 2026 14:07:19 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, yangerkun@huawei.com,
	yi.zhang@huawei.com, fuse-devel <fuse-devel@lists.linux.dev>
Subject: Re: [PATCH] fuse: virtiofs: fix illegal inode address access in
 fuse_release_end
Message-ID: <20260515210719.GD9568@frogsfrogsfrogs>
References: <20260514124102.2703313-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514124102.2703313-1-chengzhihao1@huawei.com>

[add fuse-devel]

On Thu, May 14, 2026 at 08:41:02PM +0800, Zhihao Cheng wrote:
> When a submount (e.g. virtiofs with fc->auto_submounts=true) is umounted
> while an async RELEASE request is still pending, an illegal inode address
> accessing occurs in fuse_release_end()->iput().
> 
> Trigger process:
>  1. virtiofs has a submount; user opens and closes a file under it
>  2. Close calls fuse_file_put() with sync=false, sending RELEASE
>     asynchronously
>  3. fuse_release_end() is scheduled to run later via igrab() holding
>     inode ref
>  4. File is freed, mount/dentry refcounts are released
>  5. User umounts the submount; fuse connection detects remaining
>     superblock and does NOT flush the connection's requests
>  6. generic_shutdown_super() destroys the superblock and poisons busy
>     inodes' inode->i_sb = VFS_PTR_POISON
>  7. Later, fuse_request_end() calls fuse_release_end() which does
>     iput(inode)
>  8. iput() accesses inode->i_sb->s_op at the poisoned address, crash!
> 
> There are two solutions to fix it:
>  Solution A: Hold path reference in fuse_file_put, and put path
>  synchronously, which could reintroduce the issue fixed by commit
>  5a18ec176c934 ("fuse: fix hang of single threaded fuseblk filesystem").
> 
>  Solution B (chosen): Use synchronous RELEASE for auto_submounts (which
>  is only supported by virtiofs). The virtiofsd(fuse daemon) and virtiofs
>  won't work together under one same kernel instance, so the problem fixed
>  by commit 26e5c67deb2e ("fuse: fix livelock in synchronous file put from
>  fuseblk workers") won't be brought back in virtiofs.

Does the weird AIO "kernel breaks if you close the fd before all the IOs
complete" behavior happen on virtiofsd?

--D

> 
> Fetch a reproducer in https://bugzilla.kernel.org/show_bug.cgi?id=221519.
> 
> Fixes: 26e5c67deb2e ("fuse: fix livelock in synchronous file put from fuseblk workers")
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
>  fs/fuse/file.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index c59452d60b8d..a6192b96d861 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -375,13 +375,20 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
>  	 * synchronous RELEASE is allowed (and desirable) in this case
>  	 * because the server can be trusted not to screw up.
>  	 *
> -	 * Always use the asynchronous file put because the current thread
> -	 * might be the fuse server.  This can happen if a process starts some
> -	 * aio and closes the fd before the aio completes.  Since aio takes its
> -	 * own ref to the file, the IO completion has to drop the ref, which is
> -	 * how the fuse server can end up closing its clients' files.
> +	 * For auto_submounts (e.g. virtiofs), always use synchronous
> +	 * release to avoid illegal inode address access when umount
> +	 * happens before async release completes. The async release
> +	 * holds inode reference via igrab(), but umount can shutdown
> +	 * superblock and poison inode->i_sb before release ends,
> +	 * causing crash in fuse_release_end()->iput(). Otherwise,
> +	 * always use the asynchronous file put because the current
> +	 * thread might be the fuse server. This can happen if a
> +	 * process starts some aio and closes the fd before the aio
> +	 * completes. Since aio takes its own ref to the file, the IO
> +	 * completion has to drop the ref, which is how the fuse server
> +	 * can end up closing its clients' files.
>  	 */
> -	fuse_file_put(ff, false);
> +	fuse_file_put(ff, ff->fm->fc->auto_submounts);
>  }
>  
>  void fuse_release_common(struct file *file, bool isdir)
> -- 
> 2.52.0
> 
