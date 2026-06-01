Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E472357D07
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 18:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780339984; cv=none; b=ZBJevLQG5gOLujN8ZJFq/ShPsqWkldgOomyEXcCb3nJtq1W4PTR7tQHc2kdiiuF7hX4ptHk12r81lMUkUQMJU5O38qkQDZL2jYb2JQ1+zaO19gJqPQQp2MAj0CUPFNj4EeIhOAOguRLRo4mim94aDFicEw9oYg2AYf3BGo+0LVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780339984; c=relaxed/simple;
	bh=sEBit1Spz6g7VcyImiR8P7cP43Zoj2ADbZZ1dH/ximo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NT06dQQtMyj+ge6Y+4HNP2DigaAY9b3l1ZOjUJ0LgOFBUOpmKgDTcR1pYuI8kRoVH2OFhRCZt0Cm4gKz2aa3Bckss8by/n2xC+ihW1Od+plY16Ro/3rkiEQvSA/mAPMmVDz5xtPGReAwUVFVt+PZ+QU+J7xaSFvqfJK3MA8FEeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rHFcAn66; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rHFcAn66"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bebb72b845aso306185766b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2026 11:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780339981; x=1780944781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EIdVYJu9K4fQfdWSIt/qX+Ktap9LoTUnGmSlIdH+1JQ=;
        b=rHFcAn6625IL6XVVtU8CcXRg5gG+nH0/K3Qe+YAaJB0xMu9x6OLIeJXvzgQX9NT35J
         7BgfwlBw1LlaOJxCW027p7HQPnCry4IukRV+IvD5nfD1YNttBq0lIfCNkEfSFjefi8MA
         fhJ5+/RFHWL7cqI6YfwNEN6kC5jAeaQE4rKkY6iD1W2vJ6cqToeO0BVIR/J9bmOXNyVK
         SxZDxOOMlaHWx0bOJXE3VI6XL8sNL6E/qoump+B3+ymS3r/8pyNb2rObMa3Q5FarK373
         LMVuLBMjJ0UKMzJo2CjLN3JGjBgXVGu2f3mGQldkSv1RbtyrhCqYzoE36ZguCw+f/n0R
         FOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780339981; x=1780944781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIdVYJu9K4fQfdWSIt/qX+Ktap9LoTUnGmSlIdH+1JQ=;
        b=fQ4Yml5SArQ1zq9LeuBMt+LzEOSQnvzKwLQxQzuJDFi/2NIXbhkD5oZuUkQic2z/eY
         o7h3SXo94Z0mUrhPVcnqM95Mf0J6EDDwhABjes7RedFvOIP37ZsDnQVmNvwVpLrv/Ahb
         gkjx9IXIECWxYy+m33OAnx7RDPKo6ndct3Oz1aFr9kNwpFu18soIADAuQIwsL0L9ehPg
         Yn+4CKMKSV4waR5jN+xgM/37xqqvnlxB/oW8hYN4L4SmMBuCigIRzOu8faBRErYWUnEI
         3E3soOTGF0uBm+3gLVIbdoqniCimgv0Sx2B+SQhvIGvowpLIu2MTFmbKB843qBDdhq4z
         MG8Q==
X-Gm-Message-State: AOJu0Yx1BuSy3n50Y0xnmCrE1OFNPC9sM80/wR7uL83anR91fy/3oJNC
	/NVp8S1yYN3WZ4qN0MB9TRdl/poFYpMXTpSjEHnlrBWlxqtZaevxE8YvaBHVq0Y1
X-Gm-Gg: Acq92OE6w8rQfJLudS56nQSP0OHtzIdQ6FLqM+zNMYOXXz4jjf8Iy4gNuoC/M46GuTk
	y/Tgsob36wRZ9THlwH/jmovIPTeqgKw+AUsRX2/+0+gtjHjjTwMAjypV7A37OQiLAwJvXyvqMt2
	xKyEtj1/1ogqBWJPtKhLWHR4K2HBBbsd1fMdN8z9E4qSQiMeoLGgmkg/YpLR4YoojIQejxhAS1F
	420L6umlqMPEIDBA/aQy+CF1jNqA0vlH9NkJT4PKsSemcilUxaUcbeN87JSdBNFSlXH2es45+/U
	I1DkUK8WXlqEvSs6Gg9lVxyL28AHFiRDVmb5M+0Nhk/7vM6eOG5VCz5k4rr6geJXlUVC8YoLL6f
	ESY+q/bwUJpT5viwswFs4ZqVzChN1kJTXrXj36Gzj1Uw4tMXUBe7NYZ/nQ1AnDKOax0gPubLPAz
	GQcs5mbiL7bhj1VDf17MqjoI6OBzubwifwh+ruU2Md9xBy6jP0ap8KmnINlqYTWq7r36bXuI8om
	X9dvXjCshlDhXacZ4Q0gCnhCIX6FgNuKUWQu3c1c38BDT+C4A==
X-Received: by 2002:a17:907:2810:b0:bec:ab0c:243c with SMTP id a640c23a62f3a-becab0c2da1mr301923766b.21.1780339980769;
        Mon, 01 Jun 2026 11:53:00 -0700 (PDT)
Received: from localhost (2001-1c00-570d-ee00-fb4a-4b87-a6e0-eb91.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:fb4a:4b87:a6e0:eb91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-be9cfc8557csm374637466b.0.2026.06.01.11.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 11:53:00 -0700 (PDT)
Date: Mon, 1 Jun 2026 20:52:59 +0200
From: Amir Goldstein <amir73il@gmail.com>
To: Russ Fellows <russ.fellows@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu,
	linux-kernel@vger.kernel.org, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 1/2] fuse: fix FOPEN_PARALLEL_DIRECT_WRITES being ignored
 for passthrough writes
Message-ID: <ah3VCxciXhS0CFdP@amir-ThinkPad-T480>
References: <20260529031918.7361-1-russ.fellows@gmail.com>
 <20260529031918.7361-2-russ.fellows@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529031918.7361-2-russ.fellows@gmail.com>

Removing stable list - this is definetly NOT a bug fix
Please CC fuse-devel@lists.linux.dev for future fuse patches

On Fri, May 29, 2026 at 03:19:15AM +0000, Russ Fellows wrote:
> FOPEN_PARALLEL_DIRECT_WRITES has no effect on passthrough-backed FUSE
> files due to two independent bugs that each prevent it from working.
> Both must be fixed to restore parallel write concurrency.
> 
> Bug 1: fuse_passthrough_write_iter() acquires the exclusive inode lock
> directly:
> 
>     inode_lock(inode);
>     ret = backing_file_write_iter(...);
>     inode_unlock(inode);
> 
> This serializes all concurrent writers regardless of whether the server
> set FOPEN_PARALLEL_DIRECT_WRITES.  The flag is checked by
> fuse_dio_wr_exclusive_lock(), called from fuse_dio_lock(), called from
> fuse_direct_write_iter() -- the non-passthrough O_DIRECT path.
> fuse_file_write_iter() routes passthrough opens to
> fuse_passthrough_write_iter() instead, bypassing the flag check entirely.
> 
> Bug 2: fuse_file_io_open() in iomode.c strips FOPEN_PARALLEL_DIRECT_WRITES
> from any open that lacks FOPEN_DIRECT_IO:
> 
>     if (!(ff->open_flags & FOPEN_DIRECT_IO))
>         ff->open_flags &= ~FOPEN_PARALLEL_DIRECT_WRITES;
> 
> This is correct for regular direct-IO opens where FOPEN_DIRECT_IO ensures
> O_DIRECT is actually in effect.  It is wrong for passthrough opens: a
> passthrough file already bypasses the FUSE page cache by definition, so
> FOPEN_DIRECT_IO is redundant and should not be required to preserve the
> parallel-writes flag.
> 
> Note: adding FOPEN_DIRECT_IO to the daemon's open flags is not a valid
> workaround.  fuse_file_write_iter() checks FOPEN_DIRECT_IO before
> FOPEN_PASSTHROUGH, so setting both causes writes to be routed through
> fuse_direct_write_iter() (requiring a userspace round-trip) instead of
> fuse_passthrough_write_iter() (zero-copy kernel path).
> 
> Combined effect: a daemon that opens with FOPEN_PASSTHROUGH |
> FOPEN_PARALLEL_DIRECT_WRITES (without FOPEN_DIRECT_IO) has the parallel
> flag stripped by Bug 2 before Bug 1 is even reached.  Both bugs must be
> fixed together.
> 
> Fix Bug 1: make fuse_dio_lock() and fuse_dio_unlock() non-static and call
> them from fuse_passthrough_write_iter(), replacing the open-coded
> inode_lock/inode_unlock.  This reuses the existing logic that handles
> FOPEN_PARALLEL_DIRECT_WRITES, append writes, writes past EOF, and
> page-cache IO mode transitions.
> 
> Fix Bug 2: skip the FOPEN_PARALLEL_DIRECT_WRITES strip when
> FOPEN_PASSTHROUGH is set.  The flag remains stripped for non-passthrough
> opens without FOPEN_DIRECT_IO, preserving existing behaviour.
> 
> Safety: backing_file_write_iter() calls into the backing filesystem's
> write_iter (e.g. xfs_file_write_iter), which acquires the backing inode's
> own lock independently.  The FUSE inode lock and the backing inode lock are
> entirely separate; using inode_lock_shared on the FUSE inode does not
> affect the backing filesystem's concurrency control.
> 
> Fixes: 4d99ff8f6b85 ("fuse: implement open/create with FOPEN_PASSTHROUGH")

Not a fix, because this was very intentional.
It is a new feature that you are proposing to support parallel
passthrough dio.

Anyway, this patch has many problems

> Cc: stable@vger.kernel.org
> Signed-off-by: Russ Fellows <russ.fellows@gmail.com>
> ---
>  fs/fuse/file.c        |  6 +++---
>  fs/fuse/fuse_i.h      |  2 ++
>  fs/fuse/iomode.c      |  8 ++++++--
>  fs/fuse/passthrough.c |  6 +++---
>  4 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index f94f3dc082c6..602c3f18676e 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1428,8 +1428,8 @@ static bool fuse_dio_wr_exclusive_lock(struct kiocb *iocb, struct iov_iter *from
>  	return false;
>  }
>  
> -static void fuse_dio_lock(struct kiocb *iocb, struct iov_iter *from,
> -			  bool *exclusive)
> +void fuse_dio_lock(struct kiocb *iocb, struct iov_iter *from,
> +		   bool *exclusive)
>  {
>  	struct inode *inode = file_inode(iocb->ki_filp);
>  	struct fuse_inode *fi = get_fuse_inode(inode);
> @@ -1455,7 +1455,7 @@ static void fuse_dio_lock(struct kiocb *iocb, struct iov_iter *from,
>  	}
>  }
>  
> -static void fuse_dio_unlock(struct kiocb *iocb, bool exclusive)
> +void fuse_dio_unlock(struct kiocb *iocb, bool exclusive)
>  {
>  	struct inode *inode = file_inode(iocb->ki_filp);
>  	struct fuse_inode *fi = get_fuse_inode(inode);
> @@ -1469,7 +1469,7 @@ static void fuse_dio_unlock(struct kiocb *iocb, bool exclusive)
>  	}
>  }
>  
> -static const struct iomap_write_ops fuse_iomap_write_ops = {
> +static const struct iomap_write_ops fuse_iomap_write_ops = {	/* unchanged */
>  	.read_folio_range = fuse_iomap_read_folio_range,
>  };
>  
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 17423d4e3cfa..120de517cea0 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1541,6 +1541,8 @@ int fuse_file_io_open(struct file *file, struct inode *inode);
>  void fuse_file_io_release(struct fuse_file *ff, struct inode *inode);
>  
>  /* file.c */
> +void fuse_dio_lock(struct kiocb *iocb, struct iov_iter *from, bool *exclusive);
> +void fuse_dio_unlock(struct kiocb *iocb, bool exclusive);
>  struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
>  				 unsigned int open_flags, bool isdir);
>  void fuse_file_release(struct inode *inode, struct fuse_file *ff,
> diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
> index c99e285f3..b3f51e3d1 100644
> --- a/fs/fuse/iomode.c
> +++ b/fs/fuse/iomode.c
> @@ -214,10 +214,14 @@ int fuse_file_io_open(struct file *file, struct inode *inode)
>  	if (fuse_inode_backing(fi) && !(ff->open_flags & FOPEN_PASSTHROUGH))
>  		goto fail;
>  
> -	/*
> -	 * FOPEN_PARALLEL_DIRECT_WRITES requires FOPEN_DIRECT_IO.
> -	 */
> -	if (!(ff->open_flags & FOPEN_DIRECT_IO))
> +	/*
> +	 * FOPEN_PARALLEL_DIRECT_WRITES requires FOPEN_DIRECT_IO, except for
> +	 * passthrough opens which bypass the page cache regardless and do not
> +	 * need FOPEN_DIRECT_IO to guarantee direct I/O semantics.
> +	 */
> +	if (!(ff->open_flags & FOPEN_DIRECT_IO) &&
> +	    !(ff->open_flags & FOPEN_PASSTHROUGH))
>  		ff->open_flags &= ~FOPEN_PARALLEL_DIRECT_WRITES;
>  
>  	/*
> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> index f2d08ac2459b..f83d0a27cfb9 100644
> --- a/fs/fuse/passthrough.c
> +++ b/fs/fuse/passthrough.c
> @@ -54,11 +54,11 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *iocb,
>  				    struct iov_iter *iter)
>  {
>  	struct file *file = iocb->ki_filp;
> -	struct inode *inode = file_inode(file);
>  	struct fuse_file *ff = file->private_data;
>  	struct file *backing_file = fuse_file_passthrough(ff);
>  	size_t count = iov_iter_count(iter);
>  	ssize_t ret;
> +	bool exclusive;
>  	struct backing_file_ctx ctx = {
>  		.cred = ff->cred,
>  		.end_write = fuse_passthrough_end_write,
> @@ -70,10 +70,10 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *iocb,
>  	if (!count)
>  		return 0;
>  
> -	inode_lock(inode);
> +	fuse_dio_lock(iocb, iter, &exclusive);

You can't just use fuse_dio_lock() like this
it plays nasty games with the iomode.
It does not even check for O_DIRECT mode, so this would do
parallel buffered write (at least until it meets the filesystem lock
but its not something we would want.
You should study this code better.

>  	ret = backing_file_write_iter(backing_file, iter, iocb, iocb->ki_flags,
>  				      &ctx);

The problem is that while backing_file_write_iter() does not seem to
directly require an exclusive lock (apart from maybe file_remove_privs)
the fuse_passthrough_end_write() callback does I think rely on this
exclusive lock.

So proving that this can work will require more research and more effort
and I am not really sure how that is going to work out.

Thanks,
Amir.
