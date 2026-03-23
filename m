Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4BE37B032
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 22:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774304920; cv=none; b=YgpXX3sLkLZoYdmpNOZ1cpEIDywL1ySpWSjEmcAr4aBs6Z+32MrxBu+/scXPKdI++jYyF/IuUFk9oG2R6CE4cOypB6pipXXRYLTH0UAs+Czd4SCfNoLXUz5iAjGXI7nhCro1Iale+9CcgHcvC+I793ccKkhN/RuAS6Ux/75EIk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774304920; c=relaxed/simple;
	bh=LtTo5/tlIRgKr6vUwShHOPwVgi15sZBQyDzDJ2Hw3aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfDutEgLdbNpjg4SrL1IgF65RW8agZGQ+kpEBvdV/HCMVbURWkOdHFzvH6Flf1l5zZkp61CYOvZuBzUKO3pJ8GfYWyyKZHSUMWybu4TnZ6MJ+ZrnvbOa0wYSuCXxDVJOXOk1IUc7bZ1pNOBNFeCMyQl3W+rH2uwWGhWAPk4XrwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnD6Bkk5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnD6Bkk5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F99C4CEF7;
	Mon, 23 Mar 2026 22:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774304920;
	bh=LtTo5/tlIRgKr6vUwShHOPwVgi15sZBQyDzDJ2Hw3aQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AnD6Bkk5s/uDmxF3J63f/SJisQR7J5EkuXJZlvrBkdmj0BA+eowUDFzO5nEi03XmJ
	 U0/EXyNxUbrL30Pz628RdRrBC13xE0TgyTOXhZUMUTZTZeBsuzdutCIHqTP65+r9Gm
	 7vvtHesP2VEcEPICdgPJ+58ORDUG2JLiT4QbPWPhVUKPTtSeJ0JUy0CqFw3hQcvcFu
	 9NYGyz6hPajYe4/uCJeeGAK+XZb2o6qoZFEfwJIWverd3D4OQ4zNUP/J1cyJxrTjqd
	 4PsY9j1xmOkphDFSvM2If56MpxtSCSHmj2eRVnBpjRt3ArwhCtq4b6nVO5hNlvhCCc
	 WVjg+UtiaiMDQ==
Date: Mon, 23 Mar 2026 15:28:39 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH 04/19] Add a new daemonize API
Message-ID: <20260323222839.GG6202@frogsfrogsfrogs>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
 <20260323-fuse-init-before-mount-v1-4-a52d3040af69@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323-fuse-init-before-mount-v1-4-a52d3040af69@bsbernd.com>

On Mon, Mar 23, 2026 at 06:44:59PM +0100, Bernd Schubert wrote:
> In complex fuse file systems one often wants
> a) fork
> b) start extra threads and system initialization (like network
> connection and RDMA memory registration).
> c) Start the fuse session
> 
> With fuse_daemonize() there is no way to return a notification
> if step b) or c) failed. Therefore exising examples do
> the fuse_daemonize() after fuse_session_mount().
> Step, i.e. starting extra threads and possible failures are
> do not exist in these examples - unhandled use case.

Er, this sentence is a little garbled.  Is this supposed to say "The
example servers do not cover step b.  This is an un-demonstrated use
case"?

> With the FUSE_SYNC_INIT feature, which does FUSE_INIT at mount time
> and not after the mount anymore, it becomes even more complex
> as FUSE_INIT triggers startup of fuse_io_uring threads. That
> means for FUSE_SYNC_INIT forking/daemonization has to be done
> _before_ the fuse_session_mount().

Hey, that /is/ a neat trick!

> A new API is introduced to overcome the limitations of
> fuse_daemonize()
> 
> fuse_daemonize_start() - fork, but foreground process does not
> terminate yet and watches the background.
> 
> fuse_daemonize_signal() - background daemon signals to
> the foreground process success or failure.
> 
> fuse_daemonize_active() - helper function for the high level
> interface, which needs to handle both APIs. fuse_daemonize()
> is called within fuse_main(), which now needs to know if the caller
> actually already used the new API itself.
> 
> The object 'struct fuse_daemonize *' is allocated dynamically
> and stored a global variable in fuse_daemonize.c, because
> - high level fuse_main_real_versioned() needs to know
> if already daemonized
> - high level daemons do not have access to struct fuse_session
> - FUSE_SYNC_INIT in later commits can only be done if the new
> API (or a file system internal) daemonization is used.
> 
> Signed-off-by: Bernd Schubert <bernd@bsbernd.com>
> ---
>  doc/README.daemonize        | 186 +++++++++++++++++++++++++++++
>  example/passthrough_hp.cc   |  18 ++-
>  include/fuse_daemonize.h    |  71 +++++++++++
>  include/meson.build         |   3 +-
>  lib/fuse_daemonize.c        | 284 ++++++++++++++++++++++++++++++++++++++++++++
>  lib/fuse_i.h                |   4 +-
>  lib/fuse_lowlevel.c         |   1 +
>  lib/fuse_versionscript      |   3 +
>  lib/helper.c                |  13 +-
>  lib/meson.build             |   3 +-
>  test/test_want_conversion.c |   1 +
>  11 files changed, 576 insertions(+), 11 deletions(-)
> 
> diff --git a/doc/README.daemonize b/doc/README.daemonize
> new file mode 100644
> index 0000000000000000000000000000000000000000..f7473361b3a39369291e9401dfc5f7928ff4160b
> --- /dev/null
> +++ b/doc/README.daemonize
> @@ -0,0 +1,186 @@
> +FUSE Daemonization API
> +======================
> +
> +This document describes the FUSE daemonization APIs, including the legacy
> +fuse_daemonize() function and the new fuse_daemonize_start()/signal() API
> +introduced in libfuse 3.19.
> +
> +
> +Overview
> +--------
> +
> +FUSE filesystems often need to run as background daemons. Daemonization
> +involves forking the process, creating a new session, and redirecting
> +standard file descriptors. The challenge is properly reporting initialization
> +failures to the parent process.

Yeah, I found this part pretty murky when writing fuse[24]fs -- the
internal library failures are fuse_log()'d, but then what if the fuse
server has its own logging library?  libext2fs has its own, and there's
rather a lot of shenanigans that go on to make sure that libfuse and
libext2fs print to the same streams.

If you want to run as a systemd service, stdout/stderr are usually
routed to journald so there's no need to mess with stdout/stderr.  But
then if you're running as a system service you don't want daemonize
anyway.

Ok enough rambling about my thing.  I appreciate you documenting the old
fuse_daemonize in detail:

> +Old API: fuse_daemonize()
> +--------------------------
> +
> +Function signature:
> +    int fuse_daemonize(int foreground);
> +
> +Location: lib/helper.c
> +
> +This is the legacy daemonization API, primarily used with the high-level
> +fuse_main() interface.
> +
> +Behavior:
> +- If foreground=0: forks the process, creates new session, redirects stdio

It creates a new session?  I see that a pipe gets created between parent
and child, but I don't see a new fuse_session or ... oh, you meant a new
*Unix* session via setsid().  Can you say "creates new Unix session"?

> +- If foreground=1: only changes directory to "/"
> +- Parent waits for a single byte on a pipe before exiting
> +- Child writes completion byte immediately after redirecting stdio
> +- Always changes directory to "/"
> +
> +Limitations:
> +1. No failure reporting: The parent receives notification immediately after
> +   fork/setsid, before any meaningful initialization (like mounting the
> +   filesystem or starting threads).

<nod> and I gather that's what fuse_daemonize_signal() is for.

> +2. Timing constraint: Must be called AFTER fuse_session_mount() in existing
> +   examples, because there's no way to report mount failures to the parent.
> +
> +3. Thread initialization: Cannot report failures from complex initialization
> +   steps like:
> +   - Starting worker threads

Where do those errors go?  It looks like by default they go to stderr,
which is /dev/null after daemonization, right?

> +   - Network connection setup
> +   - RDMA memory registration
> +   - Resource allocation
> +
> +4. FUSE_SYNC_INIT incompatibility: With the FUSE_SYNC_INIT feature, FUSE_INIT
> +   happens at mount time and may start io_uring threads. This requires
> +   daemonization BEFORE mount, which the old API cannot handle properly.

(For anyone following at home, fuse-containers cannot use synchronous
init because the new fuservicemount helper opens /dev/fuse and calls
mount() at the behest of the fuse server, so I'm mostly interested in
this as an exercise in getting to know libfuse.)

> +
> +Example usage (old API):
> +    fuse = fuse_new(...);
> +    fuse_mount(fuse, mountpoint);
> +    fuse_daemonize(opts.foreground);  // After mount, can't report mount failure
> +    fuse_set_signal_handlers(se);
> +    fuse_session_loop(se);
> +
> +
> +New API: fuse_daemonize_start() / fuse_daemonize_signal()
> +----------------------------------------------------------
> +
> +Functions:
> +    int fuse_daemonize_start(unsigned int flags);
> +    void fuse_daemonize_signal(int status);
> +    bool fuse_daemonize_active(void);
> +
> +Location: lib/fuse_daemonize.c, include/fuse_daemonize.h
> +Available since: libfuse 3.19
> +
> +This new API solves the limitations of fuse_daemonize() by splitting
> +daemonization into two phases:
> +
> +1. fuse_daemonize_start() - Fork and setup, but parent waits
> +2. fuse_daemonize_signal() - Signal success/failure to parent
> +
> +
> +fuse_daemonize_start()
> +----------------------
> +
> +Flags:
> +- FUSE_DAEMONIZE_NO_CHDIR: Don't change directory to "/"
> +- FUSE_DAEMONIZE_NO_BACKGROUND: Don't fork (foreground mode)
> +
> +Behavior:
> +- Unless NO_BACKGROUND: forks the process
> +- Parent waits for status signal from child
> +- Child creates new session and continues
> +- Unless NO_CHDIR: changes directory to "/"
> +- Closes stdin immediately in child
> +- Starts a watcher thread to detect parent death
> +- Returns 0 in child on success, negative errno on error
> +
> +Parent death detection:
> +- Uses a "death pipe" - parent keeps write end open
> +- Child's watcher thread polls the read end
> +- When parent dies, pipe gets POLLHUP and child exits
> +- Prevents orphaned daemons if parent is killed
> +
> +
> +fuse_daemonize_signal()
> +-----------------------
> +
> +Status values:
> +- FUSE_DAEMONIZE_SUCCESS (0): Initialization succeeded
> +- FUSE_DAEMONIZE_FAILURE (1): Initialization failed
> +
> +Behavior:
> +- Signals the parent process with success or failure status

Does this get written back through the death pipe?  Or does it use
process signals?

> +- Parent exits with EXIT_SUCCESS or EXIT_FAILURE accordingly
> +- On success: redirects stdout/stderr to /dev/null
> +- Stops the parent watcher thread
> +- Cleans up pipes and internal state

I think these might be better called fuse_daemonize_success() and
fuse_daemonize_fail() since one of them does more than just signal the
parent process.

> +- Safe to call multiple times
> +- Safe to call even if fuse_daemonize_start() failed
> +
> +
> +fuse_daemonize_active()
> +-----------------------
> +
> +Returns true if daemonization is active and waiting for signal.
> +
> +Used by the high-level fuse_main() to detect if the application already
> +called the new API, avoiding double-daemonization.
> +
> +
> +Example usage (new API):
> +-------------------------
> +
> +    // Start daemonization BEFORE mount
> +    unsigned int daemon_flags = 0;
> +    if (foreground)
> +        daemon_flags |= FUSE_DAEMONIZE_NO_BACKGROUND;
> +
> +    if (fuse_daemonize_start(daemon_flags) != 0)
> +        goto error;
> +
> +    // Mount can now fail and be reported to parent
> +    if (fuse_session_mount(se, mountpoint) != 0)
> +        goto error_signal;
> +
> +    // Complex initialization can fail and be reported
> +    if (setup_threads() != 0)
> +        goto error_signal;
> +
> +    if (setup_network() != 0)
> +        goto error_signal;

Hrmm, interesting, this solves the problem of fuse2fs having to wait
until FUSE_INIT to create background threads.

> +
> +    // Signal success - parent exits with EXIT_SUCCESS
> +    // This is typically done in the init() callback after FUSE_INIT
> +    fuse_daemonize_signal(FUSE_DAEMONIZE_SUCCESS);
> +
> +    // Run main loop
> +    fuse_session_loop(se);
> +
> +    return 0;
> +
> +error_signal:
> +    // Signal failure - parent exits with EXIT_FAILURE
> +    fuse_daemonize_signal(FUSE_DAEMONIZE_FAILURE);
> +error:
> +    return 1;
> +
> +
> +When to signal success
> +----------------------
> +
> +The success signal should be sent after all critical initialization is
> +complete. For FUSE filesystems, this is typically in the init() callback,
> +after FUSE_INIT has been processed successfully.
> +
> +Example (from passthrough_hp.cc):
> +    static void sfs_init(void *userdata, fuse_conn_info *conn) {
> +        // ... initialization ...
> +        fuse_daemonize_signal(FUSE_DAEMONIZE_SUCCESS);
> +    }
> +
> +This ensures the parent only exits after:
> +- Mount succeeded
> +- FUSE_INIT completed
> +- All threads started
> +- Filesystem is ready to serve requests

Very nice!  Does this new daemonization work for async-init servers?

> diff --git a/example/passthrough_hp.cc b/example/passthrough_hp.cc
> index 9f795c5546ee8312e1393c5b8fcebfd77724fb49..a0da5c7e6ab07f921df65db9c700e7de77fe1598 100644
> --- a/example/passthrough_hp.cc
> +++ b/example/passthrough_hp.cc
> @@ -55,6 +55,7 @@
>  #include <errno.h>
>  #include <ftw.h>
>  #include <fuse_lowlevel.h>
> +#include <fuse_daemonize.h>
>  #include <inttypes.h>
>  #include <string.h>
>  #include <sys/file.h>
> @@ -243,6 +244,9 @@ static void sfs_init(void *userdata, fuse_conn_info *conn)
>  
>  	/* Try a large IO by default */
>  	conn->max_write = 4 * 1024 * 1024;
> +
> +	/* Signal successful init to parent */
> +	fuse_daemonize_signal(FUSE_DAEMONIZE_SUCCESS);
>  }
>  
>  static void sfs_getattr(fuse_req_t req, fuse_ino_t ino, fuse_file_info *fi)
> @@ -1580,6 +1584,7 @@ int main(int argc, char *argv[])
>  {
>  	struct fuse_loop_config *loop_config = NULL;
>  	void *teardown_watchog = NULL;
> +	unsigned int daemon_flags = 0;
>  
>  	// Parse command line options
>  	auto options{ parse_options(argc, argv) };
> @@ -1638,10 +1643,14 @@ int main(int argc, char *argv[])
>  
>  	fuse_loop_cfg_set_clone_fd(loop_config, fs.clone_fd);
>  
> -	if (fuse_session_mount(se, argv[2]) != 0)
> +	/* Start daemonization before mount so parent can report mount failure */
> +	if (fs.foreground)
> +		daemon_flags |= FUSE_DAEMONIZE_NO_BACKGROUND;
> +	if (fuse_daemonize_start(daemon_flags) != 0)
>  		goto err_out3;
>  
> -	fuse_daemonize(fs.foreground);
> +	if (fuse_session_mount(se, argv[2]) != 0)
> +		goto err_out4;
>  
>  	if (!fs.foreground)
>  		fuse_log_enable_syslog("passthrough-hp", LOG_PID | LOG_CONS,
> @@ -1650,7 +1659,7 @@ int main(int argc, char *argv[])
>  	teardown_watchog = fuse_session_start_teardown_watchdog(
>  		se, fs.root.stop_timeout_secs, NULL, NULL);
>  	if (teardown_watchog == NULL)
> -		goto err_out3;
> +		goto err_out4;
>  
>  	if (options.count("single"))
>  		ret = fuse_session_loop(se);
> @@ -1659,6 +1668,9 @@ int main(int argc, char *argv[])
>  
>  	fuse_session_unmount(se);
>  
> +err_out4:
> +	if (fuse_daemonize_active())
> +		fuse_daemonize_signal(FUSE_DAEMONIZE_FAILURE);
>  err_out3:
>  	fuse_remove_signal_handlers(se);
>  err_out2:
> diff --git a/include/fuse_daemonize.h b/include/fuse_daemonize.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..f49f6aa580a93547198e7dabe65498708e65d024
> --- /dev/null
> +++ b/include/fuse_daemonize.h
> @@ -0,0 +1,71 @@
> +/*
> + * FUSE: Filesystem in Userspace
> + * Copyright (C) 2026 Bernd Schubert <bsbernd.com>
> + *
> + * This program can be distributed under the terms of the GNU LGPLv2.
> + * See the file COPYING.LIB.
> + *
> + */
> +
> +#ifndef FUSE_DAEMONIZE_H_
> +#define FUSE_DAEMONIZE_H_
> +
> +#include <stdint.h>
> +#include <stdbool.h>
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +/**
> + * Flags for fuse_daemonize_start()
> + */
> +#define FUSE_DAEMONIZE_NO_CHDIR      (1 << 0)
> +#define FUSE_DAEMONIZE_NO_BACKGROUND (1 << 1)
> +
> +/**
> + * Status values for fuse_daemonize_signal()
> + */
> +#define FUSE_DAEMONIZE_SUCCESS 0
> +#define FUSE_DAEMONIZE_FAILURE 1

What if fuse_daemonize_signal() took an exitcode and passed it directly
to the parent process via the death pipe, and the parent process can
pass that to exit()?  IOWs, what if fuse_daemonize_signal writes @status
into signal_pipe_wr instead of flattening it to EXIT_SUCCESS/FAILURE?

Or, if you want to constrain the values to binary, then why not use

#define FUSE_DAEMONIZE_SUCCESS (EXIT_SUCCESS) ?

> +
> +/**
> + * Start daemonization process.
> + *
> + * Unless FUSE_DAEMONIZE_NO_BACKGROUND is set, this forks the process.
> + * The parent waits for a signal from the child via fuse_daemonize_signal().
> + * The child returns from this call and continues setup.
> + *
> + * Unless FUSE_DAEMONIZE_NO_CHDIR is set, changes directory to "/".
> + *
> + * Must be called before fuse_session_mount().
> + *
> + * @param flags combination of FUSE_DAEMONIZE_* flags
> + * @return 0 on success, negative errno on error
> + */
> +int fuse_daemonize_start(unsigned int flags);
> +
> +/**
> + * Signal daemonization status to parent and cleanup.
> + *
> + * The child calls this after setup is complete (or failed).
> + * The parent receives the status and exits with it.
> + * Safe to call multiple times or if start failed.
> + *
> + * @param status FUSE_DAEMONIZE_SUCCESS or FUSE_DAEMONIZE_FAILURE
> + */
> +void fuse_daemonize_signal(int status);
> +
> +/**
> + * Check if daemonization is active and waiting for signal.
> + *
> + * @return true if active, false otherwise
> + */
> +bool fuse_daemonize_active(void);
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif /* FUSE_DAEMONIZE_H_ */
> +
> diff --git a/include/meson.build b/include/meson.build
> index bf671977a5a6a9142bd67aceabd8a919e3d968d0..cfbaf52ac5d84369e92948c631e2fcfdd04ac2eb 100644
> --- a/include/meson.build
> +++ b/include/meson.build
> @@ -1,4 +1,5 @@
>  libfuse_headers = [ 'fuse.h', 'fuse_common.h', 'fuse_lowlevel.h',
> -	            'fuse_opt.h', 'cuse_lowlevel.h', 'fuse_log.h' ]
> +	            'fuse_opt.h', 'cuse_lowlevel.h', 'fuse_log.h',
> +	            'fuse_daemonize.h' ]
>  
>  install_headers(libfuse_headers, subdir: 'fuse3')
> diff --git a/lib/fuse_daemonize.c b/lib/fuse_daemonize.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..5d191e7d737d04876d02ef6bd526061c003d2ab7
> --- /dev/null
> +++ b/lib/fuse_daemonize.c
> @@ -0,0 +1,284 @@
> +/*
> + * FUSE: Filesystem in Userspace
> + * Copyright (C) 2026 Bernd Schubert <bsbernd.com>
> + *
> + * This program can be distributed under the terms of the GNU LGPLv2.
> + * See the file COPYING.LIB.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include "fuse_daemonize.h"
> +
> +#include <fcntl.h>
> +#include <poll.h>
> +#include <pthread.h>
> +#include <stdatomic.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <stdbool.h>
> +#include <errno.h>
> +
> +/* Private/internal data  */
> +struct fuse_daemonize {
> +	unsigned int flags;
> +	int signal_pipe_wr;	/* write end for signaling parent */

Hrm.  Ok, so signal_pipe[2] is the pipe through which the child writes
an int back to the parent, and then the parent can convey that outcome
to whatever started the parent.

> +	int death_pipe_rd;	/* read end, POLLHUP when parent dies */

death_pipe[2] is a different pipe.  The parent closes its end of the
pipe and the child treats POLLHUP as a message that the parent died.

> +	int stop_pipe_rd;	/* read end for stop signal */
> +	int stop_pipe_wr;	/* write end for stop signal */

and this third pipe exist so that the child can wake its own "parent
watcher" thread and have it abort.

> +	pthread_t watcher;
> +	int watcher_started;

Hm.  So watcher_started is initialized to 0 in the parent, gets set to 1
in the child's copy of memory when it starts the parent-watcher thread,
and later becomes zero when the child shuts down the parent-watcher
thread.

> +	_Atomic bool active;

active is set in the parent process, copied to the child process, and
cleared in fuse_daemonize_signal in the child.

> +	_Atomic bool daemonized;

and daemonized is set in the child upon creation of the child; and
read by fuse_daemonize_signal.  The parent never accesses its copy of
the variable.

> +};
> +
> +/* Global daemonization object pointer */
> +static _Atomic(struct fuse_daemonize *) daemonize;
> +
> +/* Watcher thread: polls for parent death or stop signal */
> +static void *parent_watcher_thread(void *arg)
> +{
> +	struct fuse_daemonize *di = arg;
> +	struct pollfd pfd[2];
> +
> +	pfd[0].fd = di->death_pipe_rd;
> +	pfd[0].events = POLLIN;
> +	pfd[1].fd = di->stop_pipe_rd;
> +	pfd[1].events = POLLIN;
> +
> +	while (1) {
> +		int rc = poll(pfd, 2, -1);
> +
> +		if (rc < 0)
> +			continue;
> +
> +		/* Parent died - death pipe write end closed */
> +		if (pfd[0].revents & (POLLHUP | POLLERR))
> +			_exit(EXIT_FAILURE);
> +
> +		/* Stop signal received */
> +		if (pfd[1].revents & POLLIN)
> +			break;
> +	}
> +	return NULL;
> +}
> +
> +static int start_parent_watcher(struct fuse_daemonize *daemonize)
> +{
> +	int rc;
> +
> +	rc = pthread_create(&daemonize->watcher, NULL, parent_watcher_thread,
> +			    daemonize);
> +	if (rc != 0) {
> +		perror("fuse_daemonize: pthread_create");

pthread functions return positive error numbers and do not set errno, so
you can't use perror().

> +		return -1;
> +	}
> +	daemonize->watcher_started = 1;

Isn't this a bool value?

FWIW the rest of the logic below looks correct, though I think the
daemonize object itself would need a pthread_mutex_t to coordinate
access if it's possible or desirable for multiple threads to access it.

I think that's not the case, and any fuse server that did need that
could implement the locking on its own.

--D

> +	return 0;
> +}
> +
> +static void stop_parent_watcher(struct fuse_daemonize *daemonize)
> +{
> +	char byte = 0;
> +
> +	if (daemonize && daemonize->watcher_started) {
> +		/* Signal watcher to stop */
> +		if (write(daemonize->stop_pipe_wr, &byte, 1) != 1)
> +			perror("fuse_daemonize: stop write");
> +		pthread_join(daemonize->watcher, NULL);
> +		daemonize->watcher_started = 0;
> +	}
> +}
> +
> +static int daemonize_child(struct fuse_daemonize *daemonize)
> +{
> +	int stop_pipe[2];
> +
> +	if (pipe(stop_pipe) == -1) {
> +		perror("fuse_daemonize_start: stop pipe");
> +		return -1;
> +	}
> +	daemonize->stop_pipe_rd = stop_pipe[0];
> +	daemonize->stop_pipe_wr = stop_pipe[1];
> +
> +	if (setsid() == -1) {
> +		perror("fuse_daemonize_start: setsid");
> +		goto err_close_stop;
> +	}
> +
> +	/* Close stdin immediately */
> +	int nullfd = open("/dev/null", O_RDWR, 0);
> +
> +	if (nullfd != -1) {
> +		(void)dup2(nullfd, 0);
> +		if (nullfd > 0)
> +			close(nullfd);
> +	}
> +
> +	/* Start watcher thread to detect parent death */
> +	if (start_parent_watcher(daemonize) != 0)
> +		goto err_close_stop;
> +
> +	daemonize->daemonized = true;
> +	return 0;
> +
> +err_close_stop:
> +	close(daemonize->stop_pipe_rd);
> +	close(daemonize->stop_pipe_wr);
> +	return -1;
> +}
> +
> +/* Fork and daemonize. Returns 0 in child, never returns in parent. */
> +static int do_daemonize(struct fuse_daemonize *daemonize)
> +{
> +	int signal_pipe[2];
> +	int death_pipe[2];
> +
> +	if (pipe(signal_pipe) == -1) {
> +		perror("fuse_daemonize_start: signal pipe");
> +		return -1;
> +	}
> +
> +	if (pipe(death_pipe) == -1) {
> +		perror("fuse_daemonize_start: death pipe");
> +		close(signal_pipe[0]);
> +		close(signal_pipe[1]);
> +		return -1;
> +	}
> +
> +	switch (fork()) {
> +	case -1:
> +		perror("fuse_daemonize_start: fork");
> +		close(signal_pipe[0]);
> +		close(signal_pipe[1]);
> +		close(death_pipe[0]);
> +		close(death_pipe[1]);
> +		return -1;
> +
> +	case 0:
> +		/* Child: signal write end, death read end */
> +		close(signal_pipe[0]);
> +		close(death_pipe[1]);
> +		daemonize->signal_pipe_wr = signal_pipe[1];
> +		daemonize->death_pipe_rd = death_pipe[0];
> +		return daemonize_child(daemonize);
> +
> +	default: {
> +		/* Parent: signal read end, death write end (kept open) */
> +		unsigned char status;
> +		ssize_t res;
> +
> +		close(signal_pipe[1]);
> +		close(death_pipe[0]);
> +
> +		res = read(signal_pipe[0], &status, sizeof(status));
> +		close(signal_pipe[0]);
> +		close(death_pipe[1]);
> +
> +		if (res != sizeof(status))
> +			_exit(EXIT_FAILURE);
> +		_exit(status);
> +	}
> +	}
> +}
> +
> +int fuse_daemonize_start(unsigned int flags)
> +{
> +	struct fuse_daemonize *dm;
> +	struct fuse_daemonize *expected = NULL;
> +
> +	dm = calloc(1, sizeof(*dm));
> +	if (dm == NULL) {
> +		fprintf(stderr, "%s: calloc failed\n", __func__);
> +		return -ENOMEM;
> +	}
> +
> +	dm->flags = flags;
> +	dm->signal_pipe_wr = -1;
> +	dm->death_pipe_rd = -1;
> +	dm->stop_pipe_rd = -1;
> +	dm->stop_pipe_wr = -1;
> +	dm->active = true;
> +
> +	if (!(flags & FUSE_DAEMONIZE_NO_CHDIR))
> +		(void)chdir("/");
> +
> +	if (!(flags & FUSE_DAEMONIZE_NO_BACKGROUND)) {
> +		if (do_daemonize(dm) != 0) {
> +			free(dm);
> +			return -errno;
> +		}
> +	}
> +
> +	/* Set global pointer using CAS - fail if already set */
> +	if (!atomic_compare_exchange_strong(&daemonize, &expected, dm)) {
> +		fprintf(stderr, "%s: already active\n", __func__);
> +		free(dm);
> +		return -EEXIST;
> +	}
> +
> +	return 0;
> +}
> +
> +static void close_if_valid(int *fd)
> +{
> +	if (*fd != -1) {
> +		close(*fd);
> +		*fd = -1;
> +	}
> +}
> +
> +void fuse_daemonize_signal(int status)
> +{
> +	struct fuse_daemonize *dm;
> +	unsigned char st;
> +
> +	dm = atomic_load(&daemonize);
> +	if (dm == NULL || !dm->active)
> +		return;
> +
> +	dm->active = false;
> +
> +	/* Stop watcher before signaling - parent will exit after this */
> +	stop_parent_watcher(dm);
> +
> +	/* Signal status to parent */
> +	if (dm->signal_pipe_wr != -1) {
> +		st = (status != 0) ? EXIT_FAILURE : EXIT_SUCCESS;
> +		if (write(dm->signal_pipe_wr, &st, sizeof(st)) != sizeof(st))
> +			fprintf(stderr, "%s: write failed\n", __func__);
> +	}
> +
> +	/* Redirect stdout/stderr to /dev/null on success */
> +	if (status == 0 && dm->daemonized) {
> +		int nullfd = open("/dev/null", O_RDWR, 0);
> +
> +		if (nullfd != -1) {
> +			(void)dup2(nullfd, 1);
> +			(void)dup2(nullfd, 2);
> +			if (nullfd > 2)
> +				close(nullfd);
> +		}
> +	}
> +
> +	close_if_valid(&dm->signal_pipe_wr);
> +	close_if_valid(&dm->death_pipe_rd);
> +	close_if_valid(&dm->stop_pipe_rd);
> +	close_if_valid(&dm->stop_pipe_wr);
> +
> +	/* Clear global pointer using CAS and free */
> +	if (atomic_compare_exchange_strong(&daemonize, &dm, NULL))
> +		free(dm);
> +}
> +
> +bool fuse_daemonize_active(void)
> +{
> +	struct fuse_daemonize *dm = atomic_load(&daemonize);
> +
> +	return dm != NULL && (dm->daemonized || dm->active);
> +}
> diff --git a/lib/fuse_i.h b/lib/fuse_i.h
> index 65d2f68f7f30918a3c3ee4d473796cb013428a8f..9e3c5dc5021e210a2778e975a37ab609af324010 100644
> --- a/lib/fuse_i.h
> +++ b/lib/fuse_i.h
> @@ -17,7 +17,6 @@
>  #include <semaphore.h>
>  #include <stdint.h>
>  #include <stdbool.h>
> -#include <errno.h>
>  #include <stdatomic.h>
>  
>  #define MIN(a, b) \
> @@ -110,6 +109,9 @@ struct fuse_session {
>  	/* true if reading requests from /dev/fuse are handled internally */
>  	bool buf_reallocable;
>  
> +	/* synchronous FUSE_INIT support */
> +	bool want_sync_init;
> +
>  	/* io_uring */
>  	struct fuse_session_uring uring;
>  
> diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
> index 3234f0ce3b246a4c2c40dc0757177de91b6608b2..4a1c7c4c02a05706e077a7ea89fab3c81bfe22cd 100644
> --- a/lib/fuse_lowlevel.c
> +++ b/lib/fuse_lowlevel.c
> @@ -19,6 +19,7 @@
>  #include "mount_util.h"
>  #include "util.h"
>  #include "fuse_uring_i.h"
> +#include "fuse_daemonize.h"
>  
>  #include <pthread.h>
>  #include <stdatomic.h>
> diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
> index cce09610316f4b0b1d6836dd0e63686342b70037..f1765d39e13bc9b1f53e625b9a091c5fa53f5afd 100644
> --- a/lib/fuse_versionscript
> +++ b/lib/fuse_versionscript
> @@ -227,6 +227,9 @@ FUSE_3.19 {
>  		fuse_session_start_teardown_watchdog;
>  		fuse_session_stop_teardown_watchdog;
>  		fuse_lowlevel_notify_prune;
> +		fuse_daemonize_start;
> +		fuse_daemonize_signal;
> +		fuse_daemonize_active;
>  } FUSE_3.18;
>  
>  # Local Variables:
> diff --git a/lib/helper.c b/lib/helper.c
> index 5c13b93a473181f027eba01e0bfefd78875ede3e..e6ec74364d000a6e091e0596fc74954b11cc51ab 100644
> --- a/lib/helper.c
> +++ b/lib/helper.c
> @@ -15,6 +15,7 @@
>  #include "fuse_misc.h"
>  #include "fuse_opt.h"
>  #include "fuse_lowlevel.h"
> +#include "fuse_daemonize.h"
>  #include "mount_util.h"
>  
>  #include <stdio.h>
> @@ -352,17 +353,19 @@ int fuse_main_real_versioned(int argc, char *argv[],
>  		goto out1;
>  	}
>  
> +	struct fuse_session *se = fuse_get_session(fuse);
>  	if (fuse_mount(fuse,opts.mountpoint) != 0) {
>  		res = 4;
>  		goto out2;
>  	}
>  
> -	if (fuse_daemonize(opts.foreground) != 0) {
> -		res = 5;
> -		goto out3;
> +	if (!fuse_daemonize_active()) {
> +		/* Avoid daemonizing if we are already daemonized by the newer API */
> +		if (fuse_daemonize(opts.foreground) != 0) {
> +			res = 5;
> +			goto out3;
> +		}
>  	}
> -
> -	struct fuse_session *se = fuse_get_session(fuse);
>  	if (fuse_set_signal_handlers(se) != 0) {
>  		res = 6;
>  		goto out3;
> diff --git a/lib/meson.build b/lib/meson.build
> index fcd95741c9d3748fa01d9ec52b417aca66745f26..5bd449ebffe7c9229df904d647d990c6c47f80b5 100644
> --- a/lib/meson.build
> +++ b/lib/meson.build
> @@ -2,7 +2,8 @@ libfuse_sources = ['fuse.c', 'fuse_i.h', 'fuse_loop.c', 'fuse_loop_mt.c',
>                     'fuse_lowlevel.c', 'fuse_misc.h', 'fuse_opt.c',
>                     'fuse_signals.c', 'buffer.c', 'cuse_lowlevel.c',
>                     'helper.c', 'modules/subdir.c', 'mount_util.c',
> -                   'fuse_log.c', 'compat.c', 'util.c', 'util.h' ]
> +                   'fuse_log.c', 'compat.c', 'util.c', 'util.h',
> +                   'fuse_daemonize.c' ]
>  
>  if host_machine.system().startswith('linux')
>     libfuse_sources += [ 'mount.c' ]
> diff --git a/test/test_want_conversion.c b/test/test_want_conversion.c
> index db731edbfe1be8230ae16b422f798603b4a3bb82..48e6dd2dc6084425a0462bba000563c6083160be 100644
> --- a/test/test_want_conversion.c
> +++ b/test/test_want_conversion.c
> @@ -8,6 +8,7 @@
>  #include <inttypes.h>
>  #include <stdbool.h>
>  #include <err.h>
> +#include <errno.h>
>  
>  static void print_conn_info(const char *prefix, struct fuse_conn_info *conn)
>  {
> 
> -- 
> 2.43.0
> 
> 
