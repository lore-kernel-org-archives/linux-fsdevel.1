Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648503DEACB
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 18:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774896259; cv=none; b=kxoHwuVLS8La2HM0TobaWc+BWT1wqGBF1t42nEQVASFsGCMPV7j9L0LeoFyBoj3/soylfU4vQvwG8xqZdrlKuhhzx9NiA2DnZ45tP9ITmaSlQZUODCoyUCj8nmgcdW5TRXu3p3/GpEZ/6TD6N/lXZ7ZNncCF43nGEupHqm/zLTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774896259; c=relaxed/simple;
	bh=Bcn8o8JyG8j+ie93Idt4xFNtYn48e78AfVvJg2pdpC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGnekPHK5y94korni1xbaKsNVMl98oLlz6hT65pd8hKWR4sowEVRFmAnf2JSpVTPWYed0IR8X0u87Y5F+z1tTQ8x6w2uzaGkJm3jMR+359FUZAQnXfz7p11FhWbgxetFKjgmsNa6eaOkLxOIMfdCsiYDQ0lDbCZXp7NZ3sQQgw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aK9Pd1PX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aK9Pd1PX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F65C4CEF7;
	Mon, 30 Mar 2026 18:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774896259;
	bh=Bcn8o8JyG8j+ie93Idt4xFNtYn48e78AfVvJg2pdpC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aK9Pd1PXP7tBqkGB08eQQe0VDD1uymGVfn3uVi8TYiYr/AY4DP+eDAVghLQk/8Gxs
	 rUlEU7XYCAhfpzsK/eAyoL3LUa1vd0qkeR0mnB3Z8vwmO6fKxPktQDV8BXT51nPBhY
	 BvX0YC/HhRYf4HlF0Gkhf/yRs51jbKZs/WJLiAT7tdgPJOH77rXu51BAZ6DrdBt0dK
	 F9UsHVQISWQLmWsnPdzu5JddGte6r1ZZd8hqgFLxN7mmNiC+slJDmvnDxfWk61/x7y
	 aApv31PNE7KL19oQ2rn5917gOuRqzkrl9rrcids4K6pJi/qcNcgSdxZn8NSo6JU6tf
	 zf+DTdx+gWsbQ==
Date: Mon, 30 Mar 2026 11:44:18 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>,
	Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH v2 14/25] fuse mount: Support synchronous FUSE_INIT
 (privileged daemon)
Message-ID: <20260330184418.GX6202@frogsfrogsfrogs>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
 <20260326-fuse-init-before-mount-v2-14-b1ca8fcbf60f@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260326-fuse-init-before-mount-v2-14-b1ca8fcbf60f@bsbernd.com>

On Thu, Mar 26, 2026 at 10:34:47PM +0100, Bernd Schubert wrote:
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
>  include/fuse_daemonize.h |   7 ++
>  include/fuse_lowlevel.h  |  12 +++
>  lib/fuse_daemonize.c     |   6 ++
>  lib/fuse_i.h             |  15 ++++
>  lib/fuse_lowlevel.c      | 190 ++++++++++++++++++++++++++++++++++++++++++++++-
>  lib/mount.c              |   5 +-
>  6 files changed, 230 insertions(+), 5 deletions(-)
> 
> diff --git a/include/fuse_daemonize.h b/include/fuse_daemonize.h
> index c35dddd668b399535c53b44ab06c65fc0b3ddefa..6215e42c635ba5956cb23ba0832dfc291ab8dede 100644
> --- a/include/fuse_daemonize.h
> +++ b/include/fuse_daemonize.h
> @@ -66,6 +66,13 @@ bool fuse_daemonize_is_active(void);
>   */
>  void fuse_daemonize_set_mounted(void);
>  
> +/**
> + * Check if daemonization is used.
> + *
> + * @return true if used, false otherwise
> + */
> +bool fuse_daemonize_is_used(void);

These new fuse_daemonize_* function names are confusing --
if fuse_daemonize_is_used() then I should be calling everything *but*
fuse_daemonize().

I wonder if a better name would be fuse_daemonize_early_* for the new
functions?

> +
>  #ifdef __cplusplus
>  }
>  #endif
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
> index 865acad7db56dbe5ed8a1bee52e7353627e89b75..97cfad7be879beacf69b020b7af78d512a224fd5 100644
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
> @@ -290,3 +291,8 @@ void fuse_daemonize_set_mounted(void)
>  {
>  	daemonize.mounted = true;
>  }
> +
> +bool fuse_daemonize_is_used(void)
> +{
> +	return daemonize.active;
> +}
> diff --git a/lib/fuse_i.h b/lib/fuse_i.h
> index 6d63c9fd2149eb4ae3b0e0170640a4ce2eed4705..164401e226eb727192a49e1cc7b38a75f031643b 100644
> --- a/lib/fuse_i.h
> +++ b/lib/fuse_i.h
> @@ -112,6 +112,9 @@ struct fuse_session {
>  
>  	/* synchronous FUSE_INIT support */
>  	bool want_sync_init;
> +	pthread_t init_thread;
> +	int init_error;
> +	int init_wakeup_fd;
>  
>  	/* io_uring */
>  	struct fuse_session_uring uring;
> @@ -221,7 +224,11 @@ void fuse_chan_put(struct fuse_chan *ch);
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
> @@ -255,6 +262,14 @@ int fuse_session_loop_mt_312(struct fuse_session *se, struct fuse_loop_config *c
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
> index a7be40cbb012361ad664a9ced3d38042ba52c681..0dd10e0ed53508e4716703f2f82aa35ad853b247 100644
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
> @@ -4402,6 +4403,170 @@ int fuse_session_custom_io_30(struct fuse_session *se,
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
> +	while (true) {
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
> +	int err, res;
> +
> +	if (!se->want_sync_init &&
> +		(se->uring.enable && !fuse_daemonize_is_used())) {
> +		if (se->debug)
> +			fuse_log(FUSE_LOG_DEBUG,
> +					"fuse: sync init not enabled\n");
> +		return 0;
> +	}
> +
> +	/* Try to enable synchronous FUSE_INIT */
> +	res = ioctl(fd, FUSE_DEV_IOC_SYNC_INIT);
> +	if (res) {
> +		err = -errno;
> +		if (err != ENOTTY) {
> +			fuse_log(
> +				FUSE_LOG_ERR,
> +				"fuse: failed to enable sync init: %s\n",
> +				strerror(errno));
> +		} else {
> +			/*
> +			 * ENOTTY means kernel doesn't support sync init,not an
> +			 * error
> +			 */
> +			if (se->debug)
> +				fuse_log(
> +					FUSE_LOG_DEBUG,
> +					"fuse: kernel doesn't support sync init\n");
> +			err = 0;
> +		}
> +		return err;
> +	}
> +
> +	if (se->debug)
> +		fuse_log(FUSE_LOG_DEBUG,
> +				"fuse: synchronous FUSE_INIT enabled\n");
> +
> +	se->init_error = 0;
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
> +	if (se->init_wakeup_fd == -1)
> +		return 0;
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
> +		fuse_log(FUSE_LOG_ERR, "fuse: init worker failed: %s\n",
> +			 strerror(-se->init_error));
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
>  static int fuse_session_mount_new_api(struct fuse_session *se,
>  				      const char *mountpoint)
>  {
> @@ -4426,6 +4591,15 @@ static int fuse_session_mount_new_api(struct fuse_session *se,
>  		goto err;
>  	}
>  
> +	/*
> +	 * Enable synchronous FUSE_INIT and start worker thread, sync init
> +	 * failure is not an error
> +	 */
> +	se->fd = fd;
> +	err = session_start_sync_init(se, fd);
> +	if (err)
> +		goto err;
> +
>  	snprintf(fd_opt, sizeof(fd_opt), "fd=%i", fd);
>  	if (fuse_opt_add_opt(&mnt_opts_with_fd, mnt_opts) == -1 ||
>  	    fuse_opt_add_opt(&mnt_opts_with_fd, fd_opt) == -1) {
> @@ -4435,13 +4609,16 @@ static int fuse_session_mount_new_api(struct fuse_session *se,
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

Should fuse_session_mount_new_api return a nonzero value if waiting
doesn't work?

>  
>  	free(mnt_opts);
>  	free(mnt_opts_with_fd);
> @@ -4451,8 +4628,8 @@ err:
>  static int fuse_session_mount_new_api(struct fuse_session *se,
>  				      const char *mountpoint)
>  {
> -	(void)se;
> -	(void)mountpoint;
> +	(void) se;
> +	(void) mountpoint;

Unrelated change?

--D

>  
>  	return -1;
>  }
> @@ -4826,3 +5003,10 @@ void fuse_session_stop_teardown_watchdog(void *data)
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
> index e8c65363d36a56f483f82434f642e785da4d0341..f19817e2675713e988bb91fc658c52b36468462b 100644
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
> @@ -522,8 +523,8 @@ int fuse_kern_fsmount_mo(const char *mnt, struct mount_opts *mo,
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
> 
> -- 
> 2.43.0
> 
> 
