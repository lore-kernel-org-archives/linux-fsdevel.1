Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E182F5A34
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 00:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774918466; cv=none; b=WWjIOlei+GqEtZgkd9FSsfB99JKMfQP2tLl2ZH3ZvB91k3CZGTpQrg6I/xMfxWCpyO6nZs+Jd+Tapq3OqbLZkdLTjaehvMnWDJ7jTayfIZrMGxyl3YbCx66ocTG/0qSdBf4pMuOxZVOGS9qEJbYxLpt3SiCq5tNEWd/L9m4WD3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774918466; c=relaxed/simple;
	bh=VlZDjGKWm3koDKb4jX4BnPt5loqtdEhqtRLEoGbreno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIrVcW7+WQoqBJYEbObZZigZWPB0jPVeWE/s1omYsgvAt6gIBRSHSyrsdUrVa5wMCOcsFk03cJYivFefSOA+iXU60L+WRrWUwTch5v5YfPFCm1JQsmZnUQruRWQJ+3DmSoeNsL5Vv2aDcrwa871A32c7/073irU9vPutDzK0g8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lc17gZMx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lc17gZMx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA92C4CEF7;
	Tue, 31 Mar 2026 00:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774918465;
	bh=VlZDjGKWm3koDKb4jX4BnPt5loqtdEhqtRLEoGbreno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lc17gZMxfX6IAMWa4iHJvG1DDArAG0d1fv4vSlNJ+IGwmwHHMpWjiHY6gO3xrF6nw
	 QHimhj97qU+AU+UVizUGdkIHSBaX/x9xWAZBaiwI/XlM+XZWXyxL9Kma39RE7IVZzq
	 HpaSS+eeJRPGmd46THSVZ/nO4iDliGbUTybPMfqYOsxovxBBimAmsPEJZpG49y0Rxk
	 vDdS3gTirwbV/ZDc/TXkjVtqZSt6hlll1n7oY+IlIe1+tKbMvLcosIDOMf8XGyP7JH
	 U4FTuv+aTPcpUb1UZ/g+BnGwk1T9pgXF9PQDqWC7kxNef5GkgS5hwZmFcjGlNV+wxh
	 EfhvVC/fetaUA==
Date: Mon, 30 Mar 2026 17:54:25 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>,
	Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH v2 22/25] Add support for sync-init of unprivileged
 daemons
Message-ID: <20260331005425.GI6202@frogsfrogsfrogs>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
 <20260326-fuse-init-before-mount-v2-22-b1ca8fcbf60f@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-fuse-init-before-mount-v2-22-b1ca8fcbf60f@bsbernd.com>

On Thu, Mar 26, 2026 at 10:34:55PM +0100, Bernd Schubert wrote:
> From: Bernd Schubert <bschubert@ddn.com>
> 
> This makes use of the bidirectional fusermount. Added is
> doc/README.mount, which explains the new bidirectional
> communication with fusermount.
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  example/passthrough_hp.cc |   5 +-
>  include/fuse_daemonize.h  |  16 ++++--
>  include/fuse_lowlevel.h   |   8 +++
>  lib/fuse_daemonize.c      |  14 ++++--
>  lib/fuse_i.h              |   1 +
>  lib/fuse_lowlevel.c       | 121 ++++++++++++++++++++++++++++++++++++--------
>  lib/mount.c               | 126 +++++++++++++++++++++++++++++++++++++++++++++-
>  lib/mount_i_linux.h       |   7 +++
>  util/fusermount.c         |   2 -
>  9 files changed, 266 insertions(+), 34 deletions(-)
> 
> diff --git a/example/passthrough_hp.cc b/example/passthrough_hp.cc
> index bad435077697e8832cf5a5195c17f2f873f2dfe6..cca865973ab5e8e9c1faa0fa28eb292a172a4812 100644
> --- a/example/passthrough_hp.cc
> +++ b/example/passthrough_hp.cc
> @@ -245,7 +245,7 @@ static void sfs_init(void *userdata, fuse_conn_info *conn)
>  	/* Try a large IO by default */
>  	conn->max_write = 4 * 1024 * 1024;
>  
> -	/* Signal successful init to parent */
> +	/* required here for async init */
>  	fuse_daemonize_success();
>  }
>  
> @@ -1661,6 +1661,9 @@ int main(int argc, char *argv[])
>  	if (teardown_watchog == NULL)
>  		goto err_out4;
>  
> +	/* required here for sync init */
> +	fuse_daemonize_success();
> +
>  	if (options.count("single"))
>  		ret = fuse_session_loop(se);
>  	else
> diff --git a/include/fuse_daemonize.h b/include/fuse_daemonize.h
> index 6215e42c635ba5956cb23ba0832dfc291ab8dede..6d3c4a6134f408d0f0a08b87495bde65d491286d 100644
> --- a/include/fuse_daemonize.h
> +++ b/include/fuse_daemonize.h
> @@ -42,6 +42,16 @@ int fuse_daemonize_start(unsigned int flags);
>  
>  /**
>   * Signal daemonization success to parent and cleanup.
> + *
> + * Note: For synchronous FUSE_INIT, this must be called after
> + *       fuse_session_mount() and before the first call to
> + *       fuse_session_loop*(). For asynchronous FUSE_INIT, this should
> + *       be called in the file system ->init() callback.
> + *
> + *       In order to simplify application code, this should be called from
> + *       the file system ->init() callback *and* after fuse_session_mount.
> + *       Libfuse knows internally if this is a sync or async FUSE_INIT
> + *       and will only signal the parent if the mount was completed.
>   */
>  void fuse_daemonize_success(void);

I wonder, could libfuse itself call fuse_daemonize_success from do_init
after the ->init function returns if !se->is_sync_init; or from the
end of fuse_session_mount otherwise?  In other words, hide this
particular detail from the fuse server?

Or are there things that a fuse server might want to do prior to calling
fuse_daemonize_success/fail?

> @@ -60,12 +70,12 @@ void fuse_daemonize_fail(int err);
>  bool fuse_daemonize_is_active(void);
>  
>  /**
> - * Set mounted flag.
> - *
> - * Called from fuse_session_mount().
> + * Set mounted flag. Called from fuse_session_mount().
>   */
>  void fuse_daemonize_set_mounted(void);
>  
> +void fuse_daemonize_set_got_init(void);
> +
>  /**
>   * Check if daemonization is used.
>   *
> diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
> index d85929e291a77de8caad7d6b3d9ac5b092ce0e62..ba7c4b3ac788f19f30fbf120fe8f6ae5851b425e 100644
> --- a/include/fuse_lowlevel.h
> +++ b/include/fuse_lowlevel.h
> @@ -2441,6 +2441,14 @@ int fuse_session_receive_buf(struct fuse_session *se, struct fuse_buf *buf);
>   */
>  void fuse_session_want_sync_init(struct fuse_session *se);
>  
> +/**
> + * Check if the connection / session is using synchronous FUSE_INIT
> + *
> + * @param conn the connection
> + * @return true if using synchronous FUSE_INIT, false otherwise
> + */
> +bool fuse_conn_is_sync_init(struct fuse_conn_info *conn);
> +
>  /**
>   * Enable debug output
>   *
> diff --git a/lib/fuse_daemonize.c b/lib/fuse_daemonize.c
> index 97cfad7be879beacf69b020b7af78d512a224fd5..d4a34da15114fc0742394e72510946b63a98a252 100644
> --- a/lib/fuse_daemonize.c
> +++ b/lib/fuse_daemonize.c
> @@ -40,7 +40,8 @@ struct fuse_daemonize {
>  	bool watcher_started;
>  	_Atomic bool active;
>  	_Atomic bool daemonized;
> -	_Atomic bool mounted;
> +	_Atomic bool mounted;  /* fuse_session_mount() completed */
> +	_Atomic bool got_init; /* got FUSE_INIT */
>  };
>  
>  /* Global daemonization object pointer */
> @@ -238,9 +239,9 @@ static void fuse_daemonize_signal(int status)
>  	struct fuse_daemonize *dm = &daemonize;
>  	int rc;
>  
> -	/* Warn because there might be races */
> -	if (status == FUSE_DAEMONIZE_SUCCESS && !dm->mounted)
> -		fprintf(stderr, "fuse daemonize success without being mounted\n");
> +	/* The file system is not mounted yet - don't signal parent */
> +	if (status == FUSE_DAEMONIZE_SUCCESS && (!dm->mounted || !dm->got_init))
> +		return;
>  
>  	dm->active = false;
>  
> @@ -292,6 +293,11 @@ void fuse_daemonize_set_mounted(void)
>  	daemonize.mounted = true;
>  }
>  
> +void fuse_daemonize_set_got_init(void)
> +{
> +	daemonize.got_init = true;
> +}
> +
>  bool fuse_daemonize_is_used(void)
>  {
>  	return daemonize.active;
> diff --git a/lib/fuse_i.h b/lib/fuse_i.h
> index 164401e226eb727192a49e1cc7b38a75f031643b..20e9c275cbffade69d3fd440d1b48b371135bd84 100644
> --- a/lib/fuse_i.h
> +++ b/lib/fuse_i.h
> @@ -75,6 +75,7 @@ struct fuse_timeout_thread;
>  struct fuse_session {
>  	_Atomic(char *)mountpoint;
>  	int fd;
> +	_Atomic bool is_sync_init;
>  	struct fuse_custom_io *io;
>  	struct mount_opts *mo;
>  	int debug;
> diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
> index 4445e134a7ff5be508306f74db9d9c56e3582070..c4bb227b51a5226543adf7f037fb2c4604a5f978 100644
> --- a/lib/fuse_lowlevel.c
> +++ b/lib/fuse_lowlevel.c
> @@ -41,6 +41,7 @@
>  #include <assert.h>
>  #include <sys/file.h>
>  #include <sys/ioctl.h>
> +#include <sys/wait.h>
>  #include <stdalign.h>
>  #include <poll.h>
>  
> @@ -3024,6 +3025,7 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
>  	 * over the thread scheduling.
>  	 */
>  	se->got_init = 1;
> +	fuse_daemonize_set_got_init();
>  	send_reply_ok(req, &outarg, outargsize);
>  	if (enable_io_uring)
>  		fuse_uring_wake_ring_threads(se);
> @@ -4456,7 +4458,8 @@ static void *session_sync_init_worker(void *data)
>  }
>  
>  /* Enable synchronous FUSE_INIT and start worker thread */
> -static int session_start_sync_init(struct fuse_session *se, int fd)
> +static int session_start_sync_init(struct fuse_session *se, int fd,
> +				   bool *fall_back)
>  {
>  	int err, res;
>  
> @@ -4491,6 +4494,12 @@ static int session_start_sync_init(struct fuse_session *se, int fd)
>  		return err;
>  	}
>  
> +	/*
> +	 * If we get here, we know that sync init is enabled and fall back
> +	 * to the old mount API is not allowed
> +	 */
> +	*fall_back = false;
> +
>  	if (se->debug)
>  		fuse_log(FUSE_LOG_DEBUG,
>  				"fuse: synchronous FUSE_INIT enabled\n");
> @@ -4553,6 +4562,8 @@ static int session_wait_sync_init_completion(struct fuse_session *se)
>  		se->init_wakeup_fd = -1;
>  	}
>  
> +	se->init_thread = 0;
> +
>  	if (se->init_error != 0) {
>  		fuse_log(FUSE_LOG_ERR, "fuse: init worker failed: %s\n",
>  			 strerror(-se->init_error));
> @@ -4567,10 +4578,19 @@ static int session_wait_sync_init_completion(struct fuse_session *se)
>  	return 0;
>  }
>  
> +/*
> + * Mount using the new Linux mount API (fsopen/fsconfig/fsmount/move_mount)
> + * Sync-init is only supported with the new API, as the mount might hang
> + * in case of daemon crash during FUSE_INIT. That also means once the sync init
> + * ioctl succeed fallback is not allowed anymore.
> + * Returns: fd on success, -1 on failure
> + */
>  static int fuse_session_mount_new_api(struct fuse_session *se,
> -				      const char *mountpoint)
> +				      const char *mountpoint, bool *fall_back)
>  {
>  	int fd = -1;
> +	int sock_fd = -1;
> +	pid_t fusermount_pid = -1;
>  	int res, err;
>  	char *mnt_opts = NULL;
>  	char *mnt_opts_with_fd = NULL;
> @@ -4587,34 +4607,85 @@ static int fuse_session_mount_new_api(struct fuse_session *se,
>  	fd = fuse_kern_mount_prepare(mountpoint, se->mo);
>  	if (fd == -1) {
>  		fuse_log(FUSE_LOG_ERR, "Mount preparation failed.\n");
> -		err = -EIO;
>  		goto err;
>  	}
>  
> -	/*
> -	 * Enable synchronous FUSE_INIT and start worker thread, sync init
> -	 * failure is not an error
> -	 */
> +	*fall_back = true;
>  	se->fd = fd;
> -	err = session_start_sync_init(se, fd);
> +	err = session_start_sync_init(se, fd, fall_back);
>  	if (err)
>  		goto err;
>  
>  	snprintf(fd_opt, sizeof(fd_opt), "fd=%i", fd);
> +	err = -ENOMEM;
>  	if (fuse_opt_add_opt(&mnt_opts_with_fd, mnt_opts) == -1 ||
>  	    fuse_opt_add_opt(&mnt_opts_with_fd, fd_opt) == -1) {
> -		err = -ENOMEM;
>  		goto err;
>  	}
>  
> +	/* Try to mount directly */
>  	err = fuse_kern_fsmount_mo(mountpoint, se->mo, mnt_opts_with_fd);
> +
> +	/* If mount failed with EPERM, fall back to fusermount3 with sync-init */
> +	if (err < 0 && errno == EPERM) {
> +		if (se->debug)
> +			fuse_log(FUSE_LOG_DEBUG,
> +				 "fuse: privileged mount failed with EPERM, falling back to fusermount3\n");
> +
> +		/* Terminate worker thread with wrong fd */
> +		if (session_wait_sync_init_completion(se) < 0)
> +			fuse_log(FUSE_LOG_ERR, "fuse: sync init completion failed\n");
> +
> +		/* Close the privileged fd */
> +		close(fd);
> +		fd = -1;
> +		se->fd = -1;
> +		*fall_back = true; /* reset */
> +
> +		/* Call fusermount3 with --sync-init */
> +		err = -ENOTSUP;
> +		fd = mount_fusermount_obtain_fd(mountpoint, se->mo, mnt_opts,
> +						&sock_fd, &fusermount_pid);
> +		if (fd < 0) {
> +			fuse_log(
> +				FUSE_LOG_ERR,
> +				"fuse: fusermount3 sync-init failed\n");
> +			goto err;
> +		}
> +
> +		/* Start worker thread with correct fd from fusermount3 */
> +		se->fd = fd;
> +		err = session_start_sync_init(se, fd, fall_back);
> +		if (err)
> +			fuse_log(FUSE_LOG_ERR,
> +				"fuse: failed to start sync init worker\n");
> +
> +		/* Send proceed signal and wait for mount result */
> +		err = fuse_fusermount_proceed_mnt(sock_fd);
> +		if (err < 0) {
> +			err = -EIO;
> +			goto err_with_sock;
> +		}
> +	} else if (err < 0) {
> +		/* Mount failed with non-EPERM error, bail out */
> +		goto err;
> +	}

I wonder if you could reduce the indent levels with

	if (err == 0 || (err < 0 && errno == EPERM))
		goto err;

	/* all the fallback code */

It's really a pity that C makes us do all this boilerplate.  Though it's
also a little funny to have a library that prints error messages.

Eh, that's a stylistic preference.  The logic looks correct. :)

> +
> +err_with_sock:
> +	if (sock_fd >= 0) {
> +		close(sock_fd);
> +		/* Reap fusermount3 child process to prevent zombie */
> +		if (fusermount_pid > 0)
> +			waitpid(fusermount_pid, NULL, 0);
> +	}
>  err:
>  	if (err < 0) {
> +		/* Close fd first to unblock worker thread */
>  		if (fd >= 0)
>  			close(fd);
>  		fd = -1;
>  		se->fd = -1;
> -		se->error = -errno;
> +		se->error = err;
>  	}
>  	/* Wait for synchronous FUSE_INIT to complete */
>  	if (session_wait_sync_init_completion(se) < 0)
> @@ -4626,10 +4697,11 @@ err:
>  }
>  #else
>  static int fuse_session_mount_new_api(struct fuse_session *se,
> -				      const char *mountpoint)
> +				      const char *mountpoint, bool *fall_back)
>  {
>  	(void) se;
>  	(void) mountpoint;
> +	(void) fall_back;
>  
>  	return -1;
>  }
> @@ -4639,6 +4711,7 @@ int fuse_session_mount(struct fuse_session *se, const char *_mountpoint)
>  {
>  	int fd;
>  	char *mountpoint;
> +	bool fall_back;
>  
>  	if (_mountpoint == NULL) {
>  		fuse_log(FUSE_LOG_ERR, "Invalid null-ptr mountpoint!\n");
> @@ -4682,21 +4755,18 @@ int fuse_session_mount(struct fuse_session *se, const char *_mountpoint)
>  		return 0;
>  	}
>  
> -	/* new linux mount api */
> -	fd = fuse_session_mount_new_api(se, mountpoint);
> -	if (fd >= 0)
> -		goto out;
> +	/* new linux mount api (and sync init) */
> +	fd = fuse_session_mount_new_api(se, mountpoint, &fall_back);
>  
>  	/* fall back to old API */
> -	se->error = 0; /* reset error of new api */
> -	fd = fuse_kern_mount(mountpoint, se->mo);
> -	if (fd < 0)
> -		goto error_out;
> +	if (fall_back && fd < 0) {
> +		se->error = 0; /* reset error of new api */
> +		fd = fuse_kern_mount(mountpoint, se->mo);
> +		if (fd < 0)
> +			goto error_out;
> +	}
>  
> -out:
>  	se->fd = fd;
> -
> -	/* Save mountpoint */
>  	se->mountpoint = mountpoint;
>  
>  	fuse_daemonize_set_mounted();
> @@ -5015,3 +5085,10 @@ void fuse_session_set_debug(struct fuse_session *se)
>  {
>  	se->debug = 1;
>  }
> +
> +bool fuse_conn_is_sync_init(struct fuse_conn_info *conn)
> +{
> +	struct fuse_session *se = container_of(conn, struct fuse_session, conn);
> +
> +	return se->is_sync_init;
> +}
> diff --git a/lib/mount.c b/lib/mount.c
> index 408e9d36896048fc167e264c95b6f6e31d86679f..f0d12525310a9ad239c0f447af60bd49b105a091 100644
> --- a/lib/mount.c
> +++ b/lib/mount.c
> @@ -37,6 +37,7 @@
>  #define FUSERMOUNT_PROG		"fusermount3"
>  #define FUSE_COMMFD_ENV		"_FUSE_COMMFD"
>  #define FUSE_COMMFD2_ENV	"_FUSE_COMMFD2"
> +#define ARG_FD_ENTRY_SIZE	30
>  
>  	enum { KEY_KERN_FLAG,
>  	       KEY_KERN_OPT,
> @@ -306,7 +307,7 @@ static int setup_auto_unmount(const char *mountpoint, int quiet)
>  		return -1;
>  	}
>  
> -	char arg_fd_entry[30];
> +	char arg_fd_entry[ARG_FD_ENTRY_SIZE];
>  	snprintf(arg_fd_entry, sizeof(arg_fd_entry), "%i", fds[0]);
>  	setenv(FUSE_COMMFD_ENV, arg_fd_entry, 1);
>  	/*
> @@ -379,7 +380,7 @@ static int fuse_mount_fusermount(const char *mountpoint, struct mount_opts *mo,
>  		return -1;
>  	}
>  
> -	char arg_fd_entry[30];
> +	char arg_fd_entry[ARG_FD_ENTRY_SIZE];
>  	snprintf(arg_fd_entry, sizeof(arg_fd_entry), "%i", fds[0]);
>  	setenv(FUSE_COMMFD_ENV, arg_fd_entry, 1);
>  	/*
> @@ -439,6 +440,127 @@ static int fuse_mount_fusermount(const char *mountpoint, struct mount_opts *mo,
>  	return fd;
>  }
>  
> +/*
> + * Mount using fusermount3 with --sync-init flag for bidirectional fd exchange
> + * Used by new mount API when privileged mount fails with EPERM
> + *
> + * Returns: fd on success, -1 on failure

What fd is in the return value?  The /dev/fuse that fusermount opened,
right?

> + * On success, *sock_fd_out contains the socket fd for signaling fusermount3
> + */
> +int mount_fusermount_obtain_fd(const char *mountpoint, struct mount_opts *mo,
> +			       const char *opts, int *sock_fd_out,
> +			       pid_t *pid_out)
> +{
> +	int fds[2];
> +	pid_t pid;
> +	int res;
> +	char arg_fd_entry[ARG_FD_ENTRY_SIZE];
> +	posix_spawn_file_actions_t action;
> +	int fd, status;
> +
> +	(void)mo;
> +
> +	if (!mountpoint) {
> +		fuse_log(FUSE_LOG_ERR, "fuse: missing mountpoint parameter\n");
> +		return -1;
> +	}
> +
> +	res = socketpair(PF_UNIX, SOCK_STREAM, 0, fds);
> +	if (res == -1) {
> +		fuse_log(FUSE_LOG_ERR, "Running %s: socketpair() failed: %s\n",
> +			 FUSERMOUNT_PROG, strerror(errno));
> +		return -1;
> +	}
> +
> +	snprintf(arg_fd_entry, sizeof(arg_fd_entry), "%i", fds[0]);
> +	setenv(FUSE_COMMFD_ENV, arg_fd_entry, 1);
> +	snprintf(arg_fd_entry, sizeof(arg_fd_entry), "%i", fds[1]);
> +	setenv(FUSE_COMMFD2_ENV, arg_fd_entry, 1);
> +
> +	char const *const argv[] = {
> +		FUSERMOUNT_PROG,
> +		"--sync-init",
> +		"-o", opts ? opts : "",
> +		"--",
> +		mountpoint,
> +		NULL,
> +	};
> +
> +	posix_spawn_file_actions_init(&action);
> +	posix_spawn_file_actions_addclose(&action, fds[1]);
> +	status = fusermount_posix_spawn(&action, argv, &pid);
> +	posix_spawn_file_actions_destroy(&action);

Huh.  Would have been nice to have known about posix_spawn when I was
writing xfs_healer.

> +
> +	if (status != 0) {
> +		close(fds[0]);
> +		close(fds[1]);
> +		return -1;
> +	}
> +
> +	close(fds[0]);
> +
> +	fd = receive_fd(fds[1]);
> +	if (fd < 0) {
> +		close(fds[1]);
> +		waitpid(pid, NULL, 0);
> +		return -1;
> +	}
> +
> +	fcntl(fd, F_SETFD, FD_CLOEXEC);
> +
> +	/* Return socket fd for later signaling */
> +	*sock_fd_out = fds[1];
> +	*pid_out = pid;
> +
> +	return fd;
> +}
> +
> +/*
> + * Send proceed signal to fusermount3 and wait for mount result
> + * Returns: 0 on success, -1 on failure
> + */
> +int fuse_fusermount_proceed_mnt(int sock_fd)
> +{
> +	char buf = '\0';
> +	ssize_t res;
> +
> +	/* Send proceed signal */
> +	do {
> +		res = send(sock_fd, &buf, 1, 0);
> +	} while (res == -1 && errno == EINTR);

Hrmm, I probably need to wrap the sendmsg/recvmsg calls in my own
patches to do this loop, don't I?

--D

> +
> +	if (res != 1) {
> +		fuse_log(FUSE_LOG_ERR, "fuse: failed to send proceed signal: %s\n",
> +			 strerror(errno));
> +		return -1;
> +	}
> +
> +	/* Wait for mount result from fusermount3 (4-byte error code) */
> +	int32_t status;
> +
> +	do {
> +		res = recv(sock_fd, &status, sizeof(status), 0);
> +	} while (res == -1 && errno == EINTR);
> +
> +	if (res != sizeof(status)) {
> +		if (res == 0)
> +			fuse_log(FUSE_LOG_ERR, "fuse: fusermount3 closed connection\n");
> +		else
> +			fuse_log(FUSE_LOG_ERR, "fuse: failed to receive mount status: %s\n",
> +				 strerror(errno));
> +		return -1;
> +	}
> +
> +	if (status != 0) {
> +		if (status != -EPERM)
> +			fuse_log(FUSE_LOG_ERR, "fuse: fusermount3 mount failed: %s\n",
> +				 strerror(-status));
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
>  #ifndef O_CLOEXEC
>  #define O_CLOEXEC 0
>  #endif
> diff --git a/lib/mount_i_linux.h b/lib/mount_i_linux.h
> index 597b380076fccc1d38fd4d0b9108fc92a1adfa62..ae98296a334a2aa39c4f3e5c3e4e3c136ae38cd3 100644
> --- a/lib/mount_i_linux.h
> +++ b/lib/mount_i_linux.h
> @@ -43,4 +43,11 @@ int fuse_kern_fsmount_mo(const char *mnt, struct mount_opts *mo,
>  
>  char *fuse_mnt_build_source(const struct mount_opts *mo);
>  char *fuse_mnt_build_type(const struct mount_opts *mo);
> +int mount_fusermount_obtain_fd(const char *mountpoint,
> +					   struct mount_opts *mo,
> +					   const char *opts, int *sock_fd_out,
> +					   pid_t *pid_out);
> +
> +int fuse_fusermount_proceed_mnt(int sock_fd);
> +
>  #endif /* FUSE_MOUNT_I_LINUX_H_ */
> diff --git a/util/fusermount.c b/util/fusermount.c
> index 31bf959024ae0cd2a4e50974589bfab30a100b0a..bf442416c83d6da3f80eca5c9814df29f61bec56 100644
> --- a/util/fusermount.c
> +++ b/util/fusermount.c
> @@ -1323,7 +1323,6 @@ struct mount_context {
>  	char *source;
>  	char *mnt_opts;
>  	char *x_opts;
> -	const char *type;
>  };
>  
>  /*
> @@ -1447,7 +1446,6 @@ static int mount_fuse_finish_fsmount(const char *mnt, const char *opts,
>  
>  	/* Store results in context */
>  	ctx->source = mp.source;
> -	ctx->type = mp.type;
>  	ctx->mnt_opts = final_mnt_opts;
>  	*type = mp.type;
>  
> 
> -- 
> 2.43.0
> 
> 
