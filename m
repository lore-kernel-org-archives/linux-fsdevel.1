Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77F230C147;
	Fri, 15 May 2026 18:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778869846; cv=none; b=ZH5EQLjAF7ClFx4VzWwJhZY77OgXD1A1bo7rgUqWsiYBRvJ2JBzNiYzrukghBBWZ44tyzjSfSBBJDmAceZDka4p1dX/RVr8tE2Xs64Ltcy+KLIxq115InMuu4XK85jzsEihredFMAnxWmd5MC46Bt3A6iKjs2dCgPyrO+bM72GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778869846; c=relaxed/simple;
	bh=VVgMBHzBmbZFR9fUtweL0fPc+KsxWnNFpYFGvzf2ork=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vgs89zOUoVGtaC6LFwfvoDErjIQf6y1NInRPvXeCqyWWNVn9Gdur4vSJiAZlZIqudqYsNqfnYwXUrz1bVtP3F/DsoKtKmMXfhhblxaV6zJHwx9jyj2hgy59pGzymy/c+xTzFTsSV6g4jJb0DaCHnN6JP6ipM4ueTk6R3Sglp2kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzG7uS3x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzG7uS3x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836C9C2BCB0;
	Fri, 15 May 2026 18:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778869845;
	bh=VVgMBHzBmbZFR9fUtweL0fPc+KsxWnNFpYFGvzf2ork=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XzG7uS3xX+am72yzWFfdfBCW50fbJIwtCulJSpc0BJKHKRXO4zYVnqyDkli5/Q5x0
	 KUJERq9zTkW2dfjU1jVCvn/sgJwNiwQL7u70/N2dgQzcVqg5GA2y5bzsiLlhdmWQDa
	 hciB4EOqvFjOw0NrG7uxRH9XmiEisxOmGBYUG+tC0jpVTFp1o4cN+RQ6SmQYWktV5t
	 I4/8H25s+RZOEPxszHSVh6nRzEhWClpz6g/6XKllaVD73RdGQ/9pj6xr0VjU1/WH0j
	 pA8z2zH8Hisgi/b/SlckrYMjlVv+hU2gnB8OzrVgtRtlLs06YbR7/rxOC1wla7xUx0
	 WFGZZFSiibifg==
Date: Fri, 15 May 2026 11:30:44 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Subject: Re: [PATCH 02/25] libfuse: wait in do_destroy until all open files
 are closed
Message-ID: <20260515183044.GT9544@frogsfrogsfrogs>
References: <177747211463.4104686.1151865355399948078.stgit@frogsfrogsfrogs>
 <177747211602.4104686.4871515875765008225.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177747211602.4104686.4871515875765008225.stgit@frogsfrogsfrogs>

On Wed, Apr 29, 2026 at 07:39:35AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> This patch complements the Linux kernel patch "fuse: flush pending fuse
> events before aborting the connection".
> 
> This test opens a large number of files, unlinks them (which really just
> renames them to fuse hidden files), closes the program, unmounts the
> filesystem, and runs fsck to check that there aren't any inconsistencies
> in the filesystem.
> 
> Unfortunately, the 488.full file shows that there are a lot of hidden
> files left over in the filesystem, with incorrect link counts.  Tracing
> fuse_request_* shows that there are a large number of FUSE_RELEASE
> commands that are queued up on behalf of the unlinked files at the time
> that fuse_conn_destroy calls fuse_abort_conn.  Had the connection not
> aborted, the fuse server would have responded to the RELEASE commands by
> removing the hidden files; instead they stick around.
> 
> For upper-level fuse servers that don't use fuseblk mode this isn't a
> problem because libfuse responds to the connection going down by pruning
> its inode cache and calling the fuse server's ->release for any open
> files before calling the server's ->destroy function.
> 
> For fuseblk servers this is a problem, however, because the kernel sends
> FUSE_DESTROY to the fuse server, and the fuse server has to write all of
> its pending changes to the block device before replying to the DESTROY
> request because the kernel releases its O_EXCL hold on the block device.
> This means that the kernel must flush all pending FUSE_RELEASE requests
> before issuing FUSE_DESTROY.
> 
> For fuse-iomap servers this will also be a problem because iomap servers
> are expected to release all exclusively-held resources before unmount
> returns from the kernel.
> 
> Create a function to push all the background requests to the queue
> before sending FUSE_DESTROY.  That way, all the pending file release
> events are processed by the fuse server before it tears itself down, and
> we don't end up with a corrupt filesystem.
> 
> Note that multithreaded fuse servers will need to track the number of
> open files and defer a FUSE_DESTROY request until that number reaches
> zero.  An earlier version of this patch made the kernel wait for the
> RELEASE acknowledgements before sending DESTROY, but the kernel people
> weren't comfortable with adding blocking waits to unmount.
> 
> This patch implements the deferral for the multithreaded libfuse
> backend.  However, we must implement this deferral by starting a new
> background thread because libfuse in io_uring mode starts up a bunch of
> threads, each of which submit batches of SQEs to request fuse commands,
> and then waits for the kernel to mark some CQEs to note which slots now
> have fuse commands to process.  Each uring thread processes the fuse
> comands in the CQE serially, which means that _do_destroy can't just
> wait for the open file counter to hit zero; it has to start a new
> background thread to do that, so that it can continue to process pending
> fuse commands.
> 
> [Aside: is this bad for fuse command processing latency?  Suppose we get
> two CQE completions, then the second command won't even be looked at
> until the first one is done.]
> 
> Non-uring fuse by contrast reads one fuse command and processes it
> immediately, so one command taking a long time won't stall any other
> commands.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  lib/fuse_i.h        |    4 ++
>  lib/fuse_lowlevel.c |  107 ++++++++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 104 insertions(+), 7 deletions(-)
> 
> 
> diff --git a/lib/fuse_i.h b/lib/fuse_i.h
> index 1710a872e19c72..17175e4454f90f 100644
> --- a/lib/fuse_i.h
> +++ b/lib/fuse_i.h
> @@ -122,6 +122,10 @@ struct fuse_session {
>  	 */
>  	uint32_t conn_want;
>  	uint64_t conn_want_ext;
> +
> +	/* destroy has to wait for all the open files to go away */
> +	pthread_cond_t zero_open_files;
> +	uint64_t open_files;
>  };
>  
>  struct fuse_chan {
> diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
> index 7e7ad683bccb50..487fd72420cdf1 100644
> --- a/lib/fuse_lowlevel.c
> +++ b/lib/fuse_lowlevel.c
> @@ -54,6 +54,22 @@
>  #define PARAM(inarg) (((char *)(inarg)) + sizeof(*(inarg)))
>  #define OFFSET_MAX 0x7fffffffffffffffLL
>  
> +static inline void inc_open_files(struct fuse_session *se)
> +{
> +	pthread_mutex_lock(&se->lock);
> +	se->open_files++;
> +	pthread_mutex_unlock(&se->lock);
> +}
> +
> +static inline void dec_open_files(struct fuse_session *se)
> +{
> +	pthread_mutex_lock(&se->lock);
> +	se->open_files--;
> +	if (!se->open_files)
> +		pthread_cond_broadcast(&se->zero_open_files);
> +	pthread_mutex_unlock(&se->lock);
> +}
> +
>  struct fuse_pollhandle {
>  	uint64_t kh;
>  	struct fuse_session *se;
> @@ -549,12 +565,17 @@ int fuse_reply_create(fuse_req_t req, const struct fuse_entry_param *e,
>  		FUSE_COMPAT_ENTRY_OUT_SIZE : sizeof(struct fuse_entry_out);
>  	struct fuse_entry_out *earg = (struct fuse_entry_out *) buf;
>  	struct fuse_open_out *oarg = (struct fuse_open_out *) (buf + entrysize);
> +	struct fuse_session *se = req->se;
> +	int error;
>  
>  	memset(buf, 0, sizeof(buf));
>  	fill_entry(earg, e);
>  	fill_open(oarg, f);
> -	return send_reply_ok(req, buf,
> +	error = send_reply_ok(req, buf,
>  			     entrysize + sizeof(struct fuse_open_out));
> +	if (!error)
> +		inc_open_files(se);

Codex complains that this is racy -- if this thread stalls out after
send_reply_ok but before inc_open_files, then the open count could sit
at zero even though there's an open file that could get FUSE_RELEASE'd.

One way to fix this is to inc_open_files before the send_reply_ok, and
decrement it if the reply fails.

> +	return error;
>  }
>  
>  int fuse_reply_attr(fuse_req_t req, const struct stat *attr,
> @@ -605,10 +626,15 @@ int fuse_passthrough_close(fuse_req_t req, int backing_id)
>  int fuse_reply_open(fuse_req_t req, const struct fuse_file_info *f)
>  {
>  	struct fuse_open_out arg;
> +	struct fuse_session *se = req->se;
> +	int error;
>  
>  	memset(&arg, 0, sizeof(arg));
>  	fill_open(&arg, f);
> -	return send_reply_ok(req, &arg, sizeof(arg));
> +	error = send_reply_ok(req, &arg, sizeof(arg));
> +	if (!error)
> +		inc_open_files(se);
> +	return error;
>  }
>  
>  static int do_fuse_reply_write(fuse_req_t req, size_t count)
> @@ -1876,6 +1902,7 @@ static void _do_release(fuse_req_t req, const fuse_ino_t nodeid,
>  {
>  	(void)in_payload;
>  	const struct fuse_release_in *arg = op_in;
> +	struct fuse_session *se = req->se;
>  	struct fuse_file_info fi;
>  
>  	memset(&fi, 0, sizeof(fi));
> @@ -1894,6 +1921,7 @@ static void _do_release(fuse_req_t req, const fuse_ino_t nodeid,
>  		req->se->op.release(req, nodeid, &fi);
>  	else
>  		fuse_reply_err(req, 0);
> +	dec_open_files(se);

The other thing it complained about is that ->release isn't required to
reply synchronously to the fuse request.  If a fuse server did this,
then the dec_open_files could occur before the server even tries to
reply to this message.

This is a more intense fix -- it involves storing the opcode in the
fuse_req object, and fixing fuse_reply_err to call dec_open_files if the
request was for RELEASE or RELEASEDIR.

--D

>  }
>  
>  static void do_release(fuse_req_t req, const fuse_ino_t nodeid,
> @@ -1998,6 +2026,7 @@ static void _do_releasedir(fuse_req_t req, const fuse_ino_t nodeid,
>  {
>  	(void)in_payload;
>  	const struct fuse_release_in *arg = (const struct fuse_release_in *)op_in;
> +	struct fuse_session *se = req->se;
>  	struct fuse_file_info fi;
>  
>  	memset(&fi, 0, sizeof(fi));
> @@ -2008,6 +2037,7 @@ static void _do_releasedir(fuse_req_t req, const fuse_ino_t nodeid,
>  		req->se->op.releasedir(req, nodeid, &fi);
>  	else
>  		fuse_reply_err(req, 0);
> +	dec_open_files(se);
>  }
>  
>  static void do_releasedir(fuse_req_t req, const fuse_ino_t nodeid,
> @@ -3030,14 +3060,20 @@ do_init(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
>  	_do_init(req, nodeid, inarg, NULL);
>  }
>  
> -static void _do_destroy(fuse_req_t req, const fuse_ino_t nodeid,
> -			const void *op_in, const void *in_payload)
> +static void *__fuse_destroy_sync(void *arg)
>  {
> +	struct fuse_req *req = arg;
>  	struct fuse_session *se = req->se;
>  
> -	(void) nodeid;
> -	(void)op_in;
> -	(void)in_payload;
> +	/*
> +	 * Wait for all the FUSE_RELEASE requests to work their way through the
> +	 * other worker threads, if any.
> +	 */
> +	pthread_mutex_lock(&se->lock);
> +	se->open_files--;
> +	while (se->open_files > 0)
> +		pthread_cond_wait(&se->zero_open_files, &se->lock);
> +	pthread_mutex_unlock(&se->lock);
>  
>  	{
>  		char *mountpoint = atomic_exchange(&se->mountpoint, NULL);
> @@ -3051,6 +3087,54 @@ static void _do_destroy(fuse_req_t req, const fuse_ino_t nodeid,
>  		se->op.destroy(se->userdata);
>  
>  	send_reply_ok(req, NULL, 0);
> +	return NULL;
> +}
> +
> +/*
> + * Destroy the fuse session asynchronously.
> + *
> + * If we have any open files, then we want to kick the actual destroy call to a
> + * new detached background thread that can wait for the open file count to
> + * reach zero without blocking processing of the rest of the commands that are
> + * pending in the fuse thread's cqe.  For non-uring multithreaded mode, we also
> + * use the detached thread to avoid blocking a fuse worker from processing
> + * other commands.
> + *
> + * If the kernel sends us an explicit FUSE_DESTROY command then it won't tear
> + * down the fuse fd until it receives the reply, so fuse_session_destroy
> + * doesn't need to wait for this thread.
> + */
> +static int __fuse_destroy_try_async(fuse_req_t req)
> +{
> +	pthread_t destroy_thread;
> +	pthread_attr_t destroy_attr;
> +	int ret;
> +
> +	ret = pthread_attr_init(&destroy_attr);
> +	if (ret)
> +		return ret;
> +
> +	ret = pthread_attr_setdetachstate(&destroy_attr,
> +			PTHREAD_CREATE_DETACHED);
> +	if (ret)
> +		return ret;
> +
> +	return pthread_create(&destroy_thread, &destroy_attr,
> +			__fuse_destroy_sync, req);
> +}
> +
> +static void _do_destroy(fuse_req_t req, const fuse_ino_t nodeid,
> +			const void *op_in, const void *in_payload)
> +{
> +	struct fuse_session *se = req->se;
> +
> +	(void) nodeid;
> +	(void)op_in;
> +	(void)in_payload;
> +
> +	if (se->open_files > 0 && __fuse_destroy_try_async(req) == 0)
> +		return;
> +	__fuse_destroy_sync(req);
>  }
>  
>  static void do_destroy(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
> @@ -3896,6 +3980,7 @@ void fuse_session_destroy(struct fuse_session *se)
>  		fuse_ll_pipe_free(llp);
>  	pthread_key_delete(se->pipe_key);
>  	sem_destroy(&se->mt_finish);
> +	pthread_cond_destroy(&se->zero_open_files);
>  	pthread_mutex_destroy(&se->mt_lock);
>  	pthread_mutex_destroy(&se->lock);
>  	free(se->cuse_data);
> @@ -4283,9 +4368,16 @@ fuse_session_new_versioned(struct fuse_args *args,
>  	list_init_nreq(&se->notify_list);
>  	se->notify_ctr = 1;
>  	pthread_mutex_init(&se->lock, NULL);
> +	pthread_cond_init(&se->zero_open_files, NULL);
>  	sem_init(&se->mt_finish, 0, 0);
>  	pthread_mutex_init(&se->mt_lock, NULL);
>  
> +	/*
> +	 * Bias the open file counter by 1 so that we only wake the condition
> +	 * variable once FUSE_DESTROY has been seen.
> +	 */
> +	se->open_files = 1;
> +
>  	err = pthread_key_create(&se->pipe_key, fuse_ll_pipe_destructor);
>  	if (err) {
>  		fuse_log(FUSE_LOG_ERR, "fuse: failed to create thread specific key: %s\n",
> @@ -4310,6 +4402,7 @@ fuse_session_new_versioned(struct fuse_args *args,
>  
>  out5:
>  	sem_destroy(&se->mt_finish);
> +	pthread_cond_destroy(&se->zero_open_files);
>  	pthread_mutex_destroy(&se->mt_lock);
>  	pthread_mutex_destroy(&se->lock);
>  out4:
> 
> 
