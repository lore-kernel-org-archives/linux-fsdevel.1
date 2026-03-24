Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FA8800
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 00:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774310631; cv=none; b=VEKYLo1/gQERyLJBQ6IEuX+XSl2VjKcRXP3Jl8V0qM5IDyKC+dSz1Y21zb9iZyHET4aIFHI79s8TeXbOxoNr3QEVNZFKFdoGG7Ty6amdBfGo9QwqIzMgRlrqAOye36j6x/ughN1r/6K+q3sM+8OzIJRSbP5KlI63d2i9ygYaRFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774310631; c=relaxed/simple;
	bh=Fi0l3PKkzeY6i/DsLhlQejnUlV0zUIVFm5hc88Y0E+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0gHXjliL25v+nv2SPx0vl1nX7rt8/rFKkU5r+v8F11gC0B3IKOWdSQTEZ6GiFXx+bcepoYnnuHDIHgvQMyx4XFEadQdDItepWNNPDWFPbAxjYTFpBBzD8/fLqhkrRNMOxCbXI1qFVx3XMbQjRgoIeBa2H1CC8ihxBiLiHwEvqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxxboSW2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxxboSW2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8E8C2BC9E;
	Tue, 24 Mar 2026 00:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774310630;
	bh=Fi0l3PKkzeY6i/DsLhlQejnUlV0zUIVFm5hc88Y0E+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oxxboSW2J4TDRXCHdgm0gqRgnrB3Mca5lDDN5PomEctgBgvmPcmBIvfQxaCTfOi8J
	 j492XDAbeL4Z9JMDAvTk2MKrnu6F0zuxr02JonGd26Qo1Bmz+rFuRGKz3sakcCUcFl
	 b8gTRaZlPRoalDpenXUn5RL5rM5D05+B4rtrWi57/La2X/EXTtyabiSZ87ggbNxit9
	 H5PYuprrhj7LGAWdnaUuR/eC/CDadRluK7fZQ5qBDc4M1w+NXOOw2DY8MMGkK5Htq9
	 LRgCdZouyhYu93SRcuaXQqVudjCetx6SE/Uh5uNEzmxY2yOWYRwCHzPd+I1xpBHNht
	 0zsbrnquPKF8g==
Date: Mon, 23 Mar 2026 17:03:50 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH 12/19] fuse mount: Support synchronous FUSE_INIT
 (privileged daemon)
Message-ID: <20260324000350.GM6202@frogsfrogsfrogs>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
 <20260323-fuse-init-before-mount-v1-12-a52d3040af69@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260323-fuse-init-before-mount-v1-12-a52d3040af69@bsbernd.com>

On Mon, Mar 23, 2026 at 06:45:07PM +0100, Bernd Schubert wrote:
> From: Bernd Schubert <bschubert@ddn.com>
> 
> Add synchronous FUSE_INIT processing during mount() to
> enable early daemonization with proper error reporting
> to the parent process.
> 
> A new mount thread is needed that handles FUSE_INIT and
> possible other requests at mount time (like getxattr for selinux).
> The kernel sends FUSE_INIT during the mount() syscall. Without a thread
> to process it, mount() blocks forever.
> 
> Mount thread lifetime:
> Created before mount() syscall in fuse_start_sync_init_worker()
> Processes requests until se->mount_finished is set (after mount() returns)
> Joined after successful mount in fuse_wait_sync_init_completion()
> Cancelled if mount fails (direct → fusermount3 fallback)

Hrmm, so the main thread (of the child process after daemonization)
calls mount(), having started a child thread to read and process
FUSE_INIT + any other mount-related fuse requests?

Later I see an eventfd being used to signal this background thread that
it should exit and (presumably) let the real request processing queues
take over.  I'm curious why an eventfd here when pipes were used
earlier?

> Key changes:
> 
> Add init_thread, init_error, mount_finished to struct fuse_session
> Use FUSE_DEV_IOC_SYNC_INIT ioctl for kernel support
> Fall back to async FUSE_INIT if unsupported
> Auto-enabled when fuse_daemonize_active() or via
> fuse_session_want_sync_init()
> Allows parent to report mount/init failures instead of
> exiting immediately after fork.
> 
> Note: For now synchronous FUSE_INIT is only supported for privileged
> mounts.
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  include/fuse_lowlevel.h |  12 +++
>  lib/fuse_daemonize.c    |   8 ++
>  lib/fuse_i.h            |  16 ++++
>  lib/fuse_lowlevel.c     | 192 ++++++++++++++++++++++++++++++++++++++++++++++--
>  lib/mount.c             |   5 +-
>  lib/mount_fsmount.c     |   5 +-
>  6 files changed, 229 insertions(+), 9 deletions(-)
> 
> diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
> index ee0bd8d71d95e4d57ebb4873dca0f2b36e22a649..d8626f85bdaf497534cd2835a589e30f1f4e2466 100644
> --- a/include/fuse_lowlevel.h
> +++ b/include/fuse_lowlevel.h
> @@ -2429,6 +2429,18 @@ void fuse_session_process_buf(struct fuse_session *se,
>   */
>  int fuse_session_receive_buf(struct fuse_session *se, struct fuse_buf *buf);
>  
> +/**
> + * Request synchronous FUSE_INIT, i.e. FUSE_INIT is handled by the
> + * kernel before mount is returned.
> + *
> + * As FUSE_INIT also starts io-uring ring threads, fork() must not be
> + * called after this if io-uring is enabled. Also see
> + * fuse_session_daemonize_start().
> + *
> + * This must be called before fuse_session_mount() to have any effect.
> + */
> +void fuse_session_want_sync_init(struct fuse_session *se);
> +
>  /**
>   * Check if the request is submitted through fuse-io-uring
>   */
> diff --git a/lib/fuse_daemonize.c b/lib/fuse_daemonize.c
> index 5d191e7d737d04876d02ef6bd526061c003d2ab7..1a32ef74093f231091b4f541e5b9136bff72024f 100644
> --- a/lib/fuse_daemonize.c
> +++ b/lib/fuse_daemonize.c
> @@ -9,6 +9,7 @@
>  #define _GNU_SOURCE
>  
>  #include "fuse_daemonize.h"
> +#include "fuse_i.h"
>  
>  #include <fcntl.h>
>  #include <poll.h>
> @@ -282,3 +283,10 @@ bool fuse_daemonize_active(void)
>  
>  	return dm != NULL && (dm->daemonized || dm->active);
>  }
> +
> +bool fuse_daemonize_set(void)
> +{
> +	struct fuse_daemonize *dm = atomic_load(&daemonize);
> +
> +	return dm != NULL;
> +}
> diff --git a/lib/fuse_i.h b/lib/fuse_i.h
> index 6d63c9fd2149eb4ae3b0e0170640a4ce2eed4705..93ab7ac2fadf9395af70487c7626cc57c2948d56 100644
> --- a/lib/fuse_i.h
> +++ b/lib/fuse_i.h
> @@ -112,6 +112,10 @@ struct fuse_session {
>  
>  	/* synchronous FUSE_INIT support */
>  	bool want_sync_init;
> +	pthread_t init_thread;
> +	int init_error;
> +	_Atomic bool terminate_mount_worker;
> +	int init_wakeup_fd;
>  
>  	/* io_uring */
>  	struct fuse_session_uring uring;
> @@ -221,7 +225,11 @@ void fuse_chan_put(struct fuse_chan *ch);
>  /* Mount-related functions */
>  void fuse_mount_version(void);
>  void fuse_kern_unmount(const char *mountpoint, int fd);
> +int fuse_kern_mount_get_base_mnt_opts(struct mount_opts *mo, char **mnt_optsp);
>  int fuse_kern_mount(const char *mountpoint, struct mount_opts *mo);
> +int fuse_kern_mount_prepare(const char *mountpoint, struct mount_opts *mo);
> +int fuse_kern_do_mount(const char *mountpoint, struct mount_opts *mo,
> +		       const char *mnt_opts);
>  
>  int fuse_send_reply_iov_nofree(fuse_req_t req, int error, struct iovec *iov,
>  			       int count);
> @@ -255,6 +263,14 @@ int fuse_session_loop_mt_312(struct fuse_session *se, struct fuse_loop_config *c
>   */
>  int fuse_loop_cfg_verify(struct fuse_loop_config *config);
>  
> +/**
> + * Check if daemonization is set.
> + *
> + * @return true if set, false otherwise
> + */
> +bool fuse_daemonize_set(void);
> +
> +
>  
>  /*
>   * This can be changed dynamically on recent kernels through the
> diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
> index 626233df20f49fa89cd9327f94340169d7061f75..b10def03f3666757d312f87f177a560483691d6f 100644
> --- a/lib/fuse_lowlevel.c
> +++ b/lib/fuse_lowlevel.c
> @@ -4230,6 +4230,7 @@ fuse_session_new_versioned(struct fuse_args *args,
>  		goto out1;
>  	}
>  	se->fd = -1;
> +	se->init_wakeup_fd = -1;
>  	se->conn.max_write = FUSE_DEFAULT_MAX_PAGES_LIMIT * getpagesize();
>  	se->bufsize = se->conn.max_write + FUSE_BUFFER_HEADER_SIZE;
>  	se->conn.max_readahead = UINT_MAX;
> @@ -4402,6 +4403,167 @@ int fuse_session_custom_io_30(struct fuse_session *se,
>  }
>  
>  #if defined(HAVE_NEW_MOUNT_API)
> +
> +/* Worker thread for synchronous FUSE_INIT */
> +static void *session_sync_init_worker(void *data)
> +{
> +	struct fuse_session *se = (struct fuse_session *)data;
> +	struct fuse_buf fbuf = {
> +		.mem = NULL,
> +	};
> +	struct pollfd pfds[2];
> +	int res;
> +
> +	pfds[0].fd = se->fd;
> +	pfds[0].events = POLLIN;
> +	pfds[0].revents = 0;
> +	pfds[1].fd = se->init_wakeup_fd;
> +	pfds[1].events = POLLIN;
> +	pfds[1].revents = 0;
> +
> +	/*
> +	 * Process requests until mount completes. With SELinux there may be
> +	 * additional requests (like getattr) after FUSE_INIT before mount
> +	 * returns.
> +	 */
> +	while (!atomic_load(&se->terminate_mount_worker)) {

We don't ever *read* the init_wakeup_fd event, so I wonder if the
_Atomic flag here is really needed?  I gather we need acquire semantics
or something?

> +		res = poll(pfds, 2, -1);
> +		if (res == -1) {
> +			if (errno == EINTR)
> +				continue;
> +			se->init_error = -errno;
> +			break;
> +		}
> +
> +		if (pfds[1].revents & POLLIN)
> +			break;
> +
> +		if (pfds[0].revents & POLLIN) {
> +			res = fuse_session_receive_buf_internal(se, &fbuf, NULL);
> +			if (res == -EINTR)
> +				continue;
> +			if (res <= 0) {
> +				se->init_error = res < 0 ? res : -EINVAL;
> +				break;
> +			}
> +
> +			fuse_session_process_buf_internal(se, &fbuf, NULL);
> +		}
> +	}
> +
> +	fuse_buf_free(&fbuf);
> +	return NULL;
> +}
> +
> +/* Enable synchronous FUSE_INIT and start worker thread */
> +static int session_start_sync_init(struct fuse_session *se, int fd)
> +{
> +	int err;
> +	int res;
> +
> +	if (!se->want_sync_init &&
> +		(se->uring.enable && !fuse_daemonize_set())) {
> +		if (se->debug)
> +			fuse_log(FUSE_LOG_DEBUG,
> +					"fuse: sync init not enabled\n");
> +		return 0;
> +	}
> +
> +	/* Try to enable synchronous FUSE_INIT */
> +	res = ioctl(fd, FUSE_DEV_IOC_SYNC_INIT);
> +	if (res) {
> +		/* ENOTTY means kernel doesn't support sync init - not an error */
> +		if (errno != ENOTTY) {
> +			fuse_log(
> +				FUSE_LOG_ERR,
> +				"fuse: failed to enable sync init: %s\n",
> +				strerror(errno));
> +		} else if (se->debug) {
> +			fuse_log(
> +				FUSE_LOG_DEBUG,
> +				"fuse: kernel doesn't support sync init\n");
> +		}
> +		return -ENOTTY;
> +	}
> +
> +	if (se->debug)
> +		fuse_log(FUSE_LOG_DEBUG,
> +				"fuse: synchronous FUSE_INIT enabled\n");
> +
> +	se->init_error = 0;
> +	se->terminate_mount_worker = false;
> +
> +	se->init_wakeup_fd = eventfd(0, EFD_CLOEXEC);
> +	if (se->init_wakeup_fd == -1) {
> +		fuse_log(
> +			FUSE_LOG_ERR,
> +			"fuse: failed to create eventfd for init worker: %s\n",
> +			strerror(errno));
> +		return -EIO;
> +	}
> +
> +	err = pthread_create(&se->init_thread, NULL,
> +				session_sync_init_worker, se);
> +	if (err != 0) {
> +		fuse_log(
> +			FUSE_LOG_ERR,
> +			"fuse: failed to create init worker thread: %s\n",
> +			strerror(err));
> +		close(se->init_wakeup_fd);
> +		se->init_wakeup_fd = -1;
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Wait for synchronous FUSE_INIT to complete */
> +static int session_wait_sync_init_completion(struct fuse_session *se)
> +{
> +	void *retval;
> +	int err;
> +	uint64_t val = 1;
> +
> +	if (se->init_thread == 0)

pthread_t is supposed to be an opaque datatype, so "0" could be a valid
value for a running thread.  For that matter, it could be a struct.  I
think you have to have a separate flag (or just use init_wakeup_fd >= 0)
to determine if we're doing a synchronous init.

> +		return 0;
> +
> +	se->terminate_mount_worker = true;
> +
> +	if (se->init_wakeup_fd != -1) {
> +		ssize_t res = write(se->init_wakeup_fd, &val, sizeof(val));
> +
> +		if (res != sizeof(val)) {
> +			fuse_log(FUSE_LOG_ERR,
> +				 "fuse: failed to signal init worker: %s\n",
> +				 strerror(errno));
> +		}
> +	}
> +
> +	err = pthread_join(se->init_thread, &retval);
> +	if (err != 0) {
> +		fuse_log(FUSE_LOG_ERR, "fuse: failed to join init worker thread: %s\n",
> +			 strerror(err));
> +		return -1;
> +	}
> +
> +	if (se->init_wakeup_fd != -1) {
> +		close(se->init_wakeup_fd);
> +		se->init_wakeup_fd = -1;
> +	}
> +
> +	if (se->init_error != 0) {
> +		fuse_log(FUSE_LOG_ERR, "fuse: init worker failed: %d\n", se->init_error);

Could you strerror(-se->init_error) to give the user a real error
message?

> +		return -1;
> +	}
> +
> +	if (fuse_session_exited(se)) {
> +		fuse_log(FUSE_LOG_ERR, "FUSE_INIT failed: session exited\n");
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
>  /* Only linux supports sync FUSE_INIT so far */
>  static int fuse_session_mount_new_api(struct fuse_session *se,
>  				      const char *mountpoint)
> @@ -4414,8 +4576,7 @@ static int fuse_session_mount_new_api(struct fuse_session *se,
>  
>  	res = fuse_kern_mount_get_base_mnt_opts(se->mo, &mnt_opts);
>  	if (res == -1) {
> -		fuse_log(FUSE_LOG_ERR,
> -			 "fuse: failed to get base mount options\n");
> +		fuse_log(FUSE_LOG_ERR, "fuse: failed to get base mount options\n");

Unrelated change?

>  		err = -EIO;
>  		goto err;
>  	}
> @@ -4427,6 +4588,17 @@ static int fuse_session_mount_new_api(struct fuse_session *se,
>  		goto err;
>  	}
>  
> +	/*
> +	 * Enable synchronous FUSE_INIT and start worker thread, sync init
> +	 * failure is not an error
> +	 */
> +	se->fd = fd;
> +	err = session_start_sync_init(se, fd);
> +	if (err) {
> +		/* ENOTTY means kernel doesn't support sync init - not an error */
> +		if (err != -ENOTTY)
> +			goto err;
> +	}

Perhaps session_start_sync_init should not return ENOTTY, since you
already check in session_wait_sync_init_completion if the synchronous
init worker has been started?

>  	snprintf(fd_opt, sizeof(fd_opt), "fd=%i", fd);
>  	if (fuse_opt_add_opt(&mnt_opts_with_fd, mnt_opts) == -1 ||
>  	    fuse_opt_add_opt(&mnt_opts_with_fd, fd_opt) == -1) {
> @@ -4436,13 +4608,16 @@ static int fuse_session_mount_new_api(struct fuse_session *se,
>  
>  	err = fuse_kern_fsmount_mo(mountpoint, se->mo, mnt_opts_with_fd);
>  err:
> -	if (err) {
> +	if (err < 0) {
>  		if (fd >= 0)
>  			close(fd);
>  		fd = -1;
>  		se->fd = -1;
>  		se->error = -errno;
>  	}
> +	/* Wait for synchronous FUSE_INIT to complete */
> +	if (session_wait_sync_init_completion(se) < 0)
> +		fuse_log(FUSE_LOG_ERR, "fuse: sync init completion failed\n");
>  
>  	free(mnt_opts);
>  	free(mnt_opts_with_fd);
> @@ -4452,8 +4627,8 @@ err:
>  static int fuse_session_mount_new_api(struct fuse_session *se,
>  				      const char *mountpoint)
>  {
> -	(void)se;
> -	(void)mountpoint;
> +	(void) se;
> +	(void) mountpoint;
>  
>  	return -1;
>  }
> @@ -4825,3 +5000,10 @@ void fuse_session_stop_teardown_watchdog(void *data)
>  	pthread_join(tt->thread_id, NULL);
>  	fuse_tt_destruct(tt);
>  }
> +
> +void fuse_session_want_sync_init(struct fuse_session *se)
> +{
> +	if (se == NULL)
> +		return;
> +	se->want_sync_init = true;
> +}
> diff --git a/lib/mount.c b/lib/mount.c
> index 30fd4d2f9bbb84c817b2363b2075456acd1c1255..12df49d9109cf918cc41aa75c5fdf84231d4d5ff 100644
> --- a/lib/mount.c
> +++ b/lib/mount.c
> @@ -30,6 +30,7 @@
>  #include <sys/socket.h>
>  #include <sys/un.h>
>  #include <sys/wait.h>
> +#include <sys/ioctl.h>
>  
>  #include "fuse_mount_compat.h"
>  
> @@ -529,8 +530,8 @@ int fuse_kern_fsmount_mo(const char *mnt, struct mount_opts *mo,
>   * Returns: 0 on success, -1 on failure,
>   *          FUSE_MOUNT_FALLBACK_NEEDED if fusermount should be used
>   */
> -static int fuse_kern_do_mount(const char *mnt, struct mount_opts *mo,
> -				  const char *mnt_opts)
> +int fuse_kern_do_mount(const char *mnt, struct mount_opts *mo,
> +		       const char *mnt_opts)
>  {
>  	char *source = NULL;
>  	char *type = NULL;
> diff --git a/lib/mount_fsmount.c b/lib/mount_fsmount.c
> index cba998bc60c783a5edc0c16570f7e5512b7f1253..f1fec790bb80f8815d485a068dc7efdff1746309 100644
> --- a/lib/mount_fsmount.c
> +++ b/lib/mount_fsmount.c
> @@ -287,8 +287,9 @@ int fuse_kern_fsmount(const char *mnt, unsigned long flags, int blkdev,
>  	/* Try to open filesystem context */
>  	fsfd = fsopen(type, FSOPEN_CLOEXEC);
>  	if (fsfd == -1) {
> -		fprintf(stderr, "fuse: fsopen(%s) failed: %s\n", type,
> -			strerror(errno));
> +		if (errno != EPERM)
> +			fprintf(stderr, "fuse: fsopen(%s) failed: %s\n", type,
> +				strerror(errno));

More unrelated changes?

--D

>  		return -1;
>  	}
>  
> 
> -- 
> 2.43.0
> 
> 
