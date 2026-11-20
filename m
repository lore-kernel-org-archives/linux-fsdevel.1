Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795173548;
	b=H0wo4Og2kx7E60NHRFikDi2e6N/Am/ZnWPMCZ5RywH4EJJmx/ozckBeEV2s8AvwJeqR4
	 k/UBZ0utEw8ZZXZlxG5uwrncjebFeV476XxE0aUH237L3a90TNP9Ei/yacDUgqlnHkcem
	 1EGNw7JLGXXy7BUHIpOD5JW/zjVqmzhD34uTrxLFhE8XDdoPQhghpMaYnP5S7sIYmVbCW
	 2OPFUXuklC9jlSoU0HQytH1lFh8z1IoJ3EyqFrm3uWxLaIZ+kAC4hMIbpLKzSj7PxS2t1
	 qv79NAvfyidJhdn1a9eSoqT/FWckBWMTGAGZQnRtGAxbGDOQZ80jjHNyL2webRkd0Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795173548;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jNhasqcl3/2+gu9SZ9NYc2vIUcbgEHQXO5UU6309jn8=;
	b=0bxT9SQzZGeS41Ch67RMJFSoYYPAnpAAmJdV6pXBSu2DSodFoptG9f4wwVhocb++CKmX
	 6vOl4HId+LflvqqersJEmxheiyaFkgqy7hiVTSJ05e0oGh1uGEhOXwOtAnqsEXx8NsQ3S
	 JHUEIbq2+Oq4npoSSfLiPUvUbbipbEUqzQiEdhu/dDt/on/fdQcP7yflwWCi5Mnd51x+g
	 2I26A4CwJnLyDBJhvv5qyPiw+dsTUKkQ/xE52OxN0Dh3ms3XguClusbx/INLRuHKBUddH
	 9hBzEYrCmg42FmJ1WZ0hm/U8+jPvX5giwXCMC6rjQeBUFUTeufHi+fZs4aTQd8sWQiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OE3CaUOI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8397606A32C
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 11:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OE3CaUOI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205311F000D2;
	Fri, 20 Nov 2026 11:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795173547;
	bh=jNhasqcl3/2+gu9SZ9NYc2vIUcbgEHQXO5UU6309jn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OE3CaUOIwnI5bkJ7z8xTgLOc6dqqjEiF3igf/HnZuuL5190BoSSr5ICy4iKvuEXJz
	 BBCZDws7UpUNEDwO3XHU98l/ZebmP+qoQ2thi7nqCAL9bKIVS9A2wJX9AcdRRuDbPB
	 NURmytbtgpKuPDJsTpgvUg2gnEQSuDKRq2Px73jLYp8Kk6xdCReG6uHN6NkGv1+Hag
	 wqexsExFZ+yX6oihxsmiXqPiikul5kV6jvJMbV1eS68d9oeYZpyOZ2Y9dYNH0hLAcD
	 YQDSABz/0vPRdqFIcWPxPKcFaHcGrMXy9om3zQAE7TXr1OARLkqWV0pSLW0t9VNrpr
	 nSDTkOWE9JfXw==
Date: Fri, 20 Nov 2026 12:19:03 +0100
From: Christian Brauner <brauner@kernel.org>
To: Ye Bin <yebin@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: hold freeze protection across writable regular file
 ->open()
Message-ID: <20261120-zehnfach-flugfeld-textil-72ab74773d45@brauner>
References: <20261112135245.3347102-1-yebin@huaweicloud.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261112135245.3347102-1-yebin@huaweicloud.com>

On Thu, Nov 12, 2026 at 09:52:45PM +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> A writable open of a regular file reaches the filesystem's ->open()
> callback without holding any superblock write (freeze) protection.
> ->open() can nevertheless write to the filesystem: ext4_file_open() ->
> dquot_file_open() -> dquot_initialize() may acquire a dquot and write
> the quota file, which starts a jbd2 transaction.  If the filesystem
> reaches SB_FREEZE_COMPLETE in that window, ext4_journal_check_start()
> hits
> 
> 	WARN_ON(sb->s_writers.frozen == SB_FREEZE_COMPLETE);
> 
> and the open then sleeps in jbd2 until the filesystem is thawed.
> 
> The hole was created over time:
> 
>   - Commit 907f4554e252 ("dquot: move dquot initialization responsibility
>     into the filesystem") moved quota initialization into ->open() and
>     introduced dquot_file_open(), making ->open() a potentially writing
>     operation for writable opens.
> 
>   - Commit eb04c28288bb ("fs: Add freezing handling to mnt_want_write() /
>     mnt_drop_write()") added sb_start_write() to mnt_want_write() but
>     deliberately kept the write reference held by an open file on the
>     non-freezing __mnt_want_write() variant, so the file's own write
>     reference does not protect its ->open().
> 
>   - Commit 64894cf84327 ("simplify lookup_open()/atomic_open() - do the
>     temporary mnt_want_write() early") moved the temporary write count
>     into do_last() and dropped it before finish_open(), so a writable
>     open that is not O_TRUNC reaches ->open() with no sb write count at
>     all.
> 
> Since then only O_TRUNC opens take mnt_want_write() in do_open().
> 
> Fix this by taking mnt_want_write() for any writable open of a regular
> file and holding it across vfs_open()/->open().  Regular files are
> checked explicitly so that opening device nodes on a read-only mount is
> not newly rejected.  Read-only opens are unaffected.
> 
> Fixes: eb04c28288bb ("fs: Add freezing handling to mnt_want_write() / mnt_drop_write()")
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/namei.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index f573fd0aacaf..0ee4cf282cf5 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4906,6 +4906,7 @@ static int do_open(struct nameidata *nd,
>  	const struct mnt_idmap *idmap;
>  	int open_flag = op->open_flag;
>  	bool do_truncate;
> +	bool got_write;
>  	int acc_mode;
>  	int error;
>  
> @@ -4935,12 +4936,23 @@ static int do_open(struct nameidata *nd,
>  		return -ENOTDIR;
>  
>  	do_truncate = false;
> +	got_write = false;
>  	acc_mode = op->acc_mode;
>  	if (file->f_mode & FMODE_CREATED) {
>  		/* Don't check for write permission, don't truncate */
>  		open_flag &= ~O_TRUNC;
>  		acc_mode = 0;
>  	} else if (d_is_reg(nd->path.dentry) && open_flag & O_TRUNC) {
> +		do_truncate = true;
> +	}
> +
> +	/*
> +	 * ->open() can write to the filesystem, e.g. when it initializes
> +	 * quota, so writable opens of regular files need freeze protection
> +	 * as well.  O_TRUNC opens already need it for handle_truncate().
> +	 */
> +	if (do_truncate ||
> +	    (d_is_reg(nd->path.dentry) && (file->f_mode & FMODE_WRITE))) {
>  		error = mnt_want_write(nd->path.mnt);

No, I don't think that's the right thing to do. Every
open(O_WRONLY|O_RDWR) would now block for a regular file on a frozen
filesystem even if it never writes. That's not acceptable. Log files,
editors, backup tools, they all would hang rather than fail on write.
It's a drastic uapi change.

The write in ->open() is from the quota stuff. So that should be a quota
fix and not penalize the whole VFS layer.
