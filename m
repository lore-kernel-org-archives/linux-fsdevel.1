Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8434F32BF5C
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 22:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774390833; cv=none; b=dGOBG+7uYoLOcu8NeWwfqa0ZIA5/t+XlxzQkgfE4TkiKpxqa0YFHDrsWLBhgCD3J2XQCQDF0KaF4uLG/S6a/i/1OWtgpbgi2jPvW17Zpm5xsnLgEY186sth93Z7nwV6K8YtUpFI7esMGkCg1MTeSRQUmiaLW22SHF3FBICIhyUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774390833; c=relaxed/simple;
	bh=A/pXvqJJmcCqmMzpqt68RQlJ4fW68Cja+N7HjHDSY3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJy5BlydWRHBK6dxxxRwalr5Nlb6QPtJceBmqmEJGlOt402EAF/e1UxijfdlRmh1RUqVF55V8SHDjXBOPQL9lplv+ksptwQcuR3wj0m8oW3ZP9GiJBl2HZtHu6MVoMFGWfr1YBj8QXg0tujLfhbYLn6oKpjoIfWNwTgtC5od9l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyt+m2Wc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyt+m2Wc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2621DC19424;
	Tue, 24 Mar 2026 22:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774390833;
	bh=A/pXvqJJmcCqmMzpqt68RQlJ4fW68Cja+N7HjHDSY3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fyt+m2WcHyR/+D4ZFpCCH6EeGbE1N076pu3C/Ky6hhf6JnFhQLd4cbnm15cbk5li6
	 WepAZ2NMAUsu+HnJMud5D+Z7b8evcpR11BgbYVeHG2yL8aKGJUYh22oSpPt37tP9b9
	 FYwJjIuSgxdXI73WKztnzT6gXD6x1ITgm44vYi/0df5K5Ut5pGCf6lz9sZARIpJ8oS
	 bJvShvDUQ6sQC6+74wEngl8V3TH1jxAaCWuYsoAUdk7tTDURtZUgWa8dW4nSdhQiQW
	 pX0lsPD7wk7oUd23i0vH38/sEjaHMmsJFko42hMaY1iKVSk69HFHM5CSozCQD7R2xX
	 KsS/wSeuoudSA==
Date: Tue, 24 Mar 2026 15:20:32 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH 04/19] Add a new daemonize API
Message-ID: <20260324222032.GW6202@frogsfrogsfrogs>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
 <20260323-fuse-init-before-mount-v1-4-a52d3040af69@bsbernd.com>
 <20260323222839.GG6202@frogsfrogsfrogs>
 <0b985fc9-222f-4676-9616-cab37409d002@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b985fc9-222f-4676-9616-cab37409d002@bsbernd.com>

On Tue, Mar 24, 2026 at 06:36:49PM +0100, Bernd Schubert wrote:
> 
> 
> On 3/23/26 23:28, Darrick J. Wong wrote:
> > On Mon, Mar 23, 2026 at 06:44:59PM +0100, Bernd Schubert wrote:
> >> In complex fuse file systems one often wants
> >> a) fork
> >> b) start extra threads and system initialization (like network
> >> connection and RDMA memory registration).
> >> c) Start the fuse session
> >>
> >> With fuse_daemonize() there is no way to return a notification
> >> if step b) or c) failed. Therefore exising examples do
> >> the fuse_daemonize() after fuse_session_mount().
> >> Step, i.e. starting extra threads and possible failures are
> >> do not exist in these examples - unhandled use case.
> > 
> > Er, this sentence is a little garbled.  Is this supposed to say "The
> > example servers do not cover step b.  This is an un-demonstrated use
> > case"?
> 
> Oops sorry. How about
> 
> Existing example/ file systems do the fuse_daemonize() after
> fuse_session_mount() - i.e. after the mount point is already
> established. Though, these example/ daemons do not start
> extra threads and do not need network initialization either.
> 
> fuse_daemonize() also does not allow to return notification
> from the forked child to the parent.
> 
> Complex fuse file system daemons often want the order of
> 1) fork - parent watches, child does the work
> 
> Child:
>     2) start extra threads and system initialization (like network
>        connection and RDMA memory registration) from the fork child.
>     3) Start the fuse session after everything else succeeded
> 
> Parent:
>     Report child initialization success or failure

Yeah, that's much clearer. :)

> >> With the FUSE_SYNC_INIT feature, which does FUSE_INIT at mount time
> >> and not after the mount anymore, it becomes even more complex
> >> as FUSE_INIT triggers startup of fuse_io_uring threads. That
> >> means for FUSE_SYNC_INIT forking/daemonization has to be done
> >> _before_ the fuse_session_mount().
> > 
> > Hey, that /is/ a neat trick!
> > 
> >> A new API is introduced to overcome the limitations of
> >> fuse_daemonize()
> >>
> >> fuse_daemonize_start() - fork, but foreground process does not
> >> terminate yet and watches the background.
> >>
> >> fuse_daemonize_signal() - background daemon signals to
> >> the foreground process success or failure.
> >>
> >> fuse_daemonize_active() - helper function for the high level
> >> interface, which needs to handle both APIs. fuse_daemonize()
> >> is called within fuse_main(), which now needs to know if the caller
> >> actually already used the new API itself.
> >>
> >> The object 'struct fuse_daemonize *' is allocated dynamically
> >> and stored a global variable in fuse_daemonize.c, because
> >> - high level fuse_main_real_versioned() needs to know
> >> if already daemonized
> >> - high level daemons do not have access to struct fuse_session
> >> - FUSE_SYNC_INIT in later commits can only be done if the new
> >> API (or a file system internal) daemonization is used.
> >>
> >> Signed-off-by: Bernd Schubert <bernd@bsbernd.com>
> >> ---
> >>  doc/README.daemonize        | 186 +++++++++++++++++++++++++++++
> >>  example/passthrough_hp.cc   |  18 ++-
> >>  include/fuse_daemonize.h    |  71 +++++++++++
> >>  include/meson.build         |   3 +-
> >>  lib/fuse_daemonize.c        | 284 ++++++++++++++++++++++++++++++++++++++++++++
> >>  lib/fuse_i.h                |   4 +-
> >>  lib/fuse_lowlevel.c         |   1 +
> >>  lib/fuse_versionscript      |   3 +
> >>  lib/helper.c                |  13 +-
> >>  lib/meson.build             |   3 +-
> >>  test/test_want_conversion.c |   1 +
> >>  11 files changed, 576 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/doc/README.daemonize b/doc/README.daemonize
> >> new file mode 100644
> >> index 0000000000000000000000000000000000000000..f7473361b3a39369291e9401dfc5f7928ff4160b
> >> --- /dev/null
> >> +++ b/doc/README.daemonize
> >> @@ -0,0 +1,186 @@
> >> +FUSE Daemonization API
> >> +======================
> >> +
> >> +This document describes the FUSE daemonization APIs, including the legacy
> >> +fuse_daemonize() function and the new fuse_daemonize_start()/signal() API
> >> +introduced in libfuse 3.19.
> >> +
> >> +
> >> +Overview
> >> +--------
> >> +
> >> +FUSE filesystems often need to run as background daemons. Daemonization
> >> +involves forking the process, creating a new session, and redirecting
> >> +standard file descriptors. The challenge is properly reporting initialization
> >> +failures to the parent process.
> > 
> > Yeah, I found this part pretty murky when writing fuse[24]fs -- the
> > internal library failures are fuse_log()'d, but then what if the fuse
> > server has its own logging library?  libext2fs has its own, and there's
> > rather a lot of shenanigans that go on to make sure that libfuse and
> > libext2fs print to the same streams.
> 
> Did you find fuse_set_log_func()

I didn't, actually.  In the end there were enough twists that I decided
it would be cleaner to go scorched earth --  open whatever logfile I
wanted and use dup2+fdreopen to make sure that both the stdio streams
and fd 1&2 actually write to wherever they're supposed to go.

> > 
> > If you want to run as a systemd service, stdout/stderr are usually
> > routed to journald so there's no need to mess with stdout/stderr.  But
> > then if you're running as a system service you don't want daemonize
> > anyway.
> > 
> > Ok enough rambling about my thing.  I appreciate you documenting the old
> > fuse_daemonize in detail:
> > 
> >> +Old API: fuse_daemonize()
> >> +--------------------------
> >> +
> >> +Function signature:
> >> +    int fuse_daemonize(int foreground);
> >> +
> >> +Location: lib/helper.c
> >> +
> >> +This is the legacy daemonization API, primarily used with the high-level
> >> +fuse_main() interface.
> >> +
> >> +Behavior:
> >> +- If foreground=0: forks the process, creates new session, redirects stdio
> > 
> > It creates a new session?  I see that a pipe gets created between parent
> > and child, but I don't see a new fuse_session or ... oh, you meant a new
> > *Unix* session via setsid().  Can you say "creates new Unix session"?
> > 
> >> +- If foreground=1: only changes directory to "/"
> >> +- Parent waits for a single byte on a pipe before exiting
> >> +- Child writes completion byte immediately after redirecting stdio
> >> +- Always changes directory to "/"
> >> +
> >> +Limitations:
> >> +1. No failure reporting: The parent receives notification immediately after
> >> +   fork/setsid, before any meaningful initialization (like mounting the
> >> +   filesystem or starting threads).
> > 
> > <nod> and I gather that's what fuse_daemonize_signal() is for.
> > 
> >> +2. Timing constraint: Must be called AFTER fuse_session_mount() in existing
> >> +   examples, because there's no way to report mount failures to the parent.
> >> +
> >> +3. Thread initialization: Cannot report failures from complex initialization
> >> +   steps like:
> >> +   - Starting worker threads
> > 
> > Where do those errors go?  It looks like by default they go to stderr,
> > which is /dev/null after daemonization, right?
> 
> Yeah, one way for fuse_log() is fuse_log_enable_syslog().
> 
> > 
> >> +   - Network connection setup
> >> +   - RDMA memory registration
> >> +   - Resource allocation
> >> +
> >> +4. FUSE_SYNC_INIT incompatibility: With the FUSE_SYNC_INIT feature, FUSE_INIT
> >> +   happens at mount time and may start io_uring threads. This requires
> >> +   daemonization BEFORE mount, which the old API cannot handle properly.
> > 
> > (For anyone following at home, fuse-containers cannot use synchronous
> > init because the new fuservicemount helper opens /dev/fuse and calls
> > mount() at the behest of the fuse server, so I'm mostly interested in
> > this as an exercise in getting to know libfuse.)
> 
> Hmm, that is a pity. And many many thanks for your reviews!

Now that I've seen how you're using them in fusermount, I've changed my
mind; I think fuse services actually *can* use synchronous mounts.  The
aspect that convinced me is seeing how libfuse creates that background
thread to handle the fuse requests until FUSE_INIT is complete.

0) fuse server tells libfuse to start the background FUSE_INIT reply
   thread
1) fuse server sends a packet through the AF_UNIX socket to initiate
   mounting process

2) fuservicemount asking it to enable sync_init and call fsmount(2)
   (Note that fuservicemount runs with the same mount ns as whatever
    wants to mount the filesystem; the systemd service can be configured
    with a private mountns)
3) kernel sets up the filesystem, initiates FUSE_INIT, waits
4) the FUSE_INIT thread sees the request, does stuff, replies
5) kernel returns to fuservicemount (and presumably move_mounts)
6) fuservicemount sends a reply back to the fuse server

7) fuse server sees the fuservicemount reply, shuts down the background
   thread
8) fuse server starts the real event handler threads, starts serving
   requests

> > 
> >> +
> >> +Example usage (old API):
> >> +    fuse = fuse_new(...);
> >> +    fuse_mount(fuse, mountpoint);
> >> +    fuse_daemonize(opts.foreground);  // After mount, can't report mount failure
> >> +    fuse_set_signal_handlers(se);
> >> +    fuse_session_loop(se);
> >> +
> >> +
> >> +New API: fuse_daemonize_start() / fuse_daemonize_signal()
> >> +----------------------------------------------------------
> >> +
> >> +Functions:
> >> +    int fuse_daemonize_start(unsigned int flags);
> >> +    void fuse_daemonize_signal(int status);
> >> +    bool fuse_daemonize_active(void);
> >> +
> >> +Location: lib/fuse_daemonize.c, include/fuse_daemonize.h
> >> +Available since: libfuse 3.19
> >> +
> >> +This new API solves the limitations of fuse_daemonize() by splitting
> >> +daemonization into two phases:
> >> +
> >> +1. fuse_daemonize_start() - Fork and setup, but parent waits
> >> +2. fuse_daemonize_signal() - Signal success/failure to parent
> >> +
> >> +
> >> +fuse_daemonize_start()
> >> +----------------------
> >> +
> >> +Flags:
> >> +- FUSE_DAEMONIZE_NO_CHDIR: Don't change directory to "/"
> >> +- FUSE_DAEMONIZE_NO_BACKGROUND: Don't fork (foreground mode)
> >> +
> >> +Behavior:
> >> +- Unless NO_BACKGROUND: forks the process
> >> +- Parent waits for status signal from child
> >> +- Child creates new session and continues
> >> +- Unless NO_CHDIR: changes directory to "/"
> >> +- Closes stdin immediately in child
> >> +- Starts a watcher thread to detect parent death
> >> +- Returns 0 in child on success, negative errno on error
> >> +
> >> +Parent death detection:
> >> +- Uses a "death pipe" - parent keeps write end open
> >> +- Child's watcher thread polls the read end
> >> +- When parent dies, pipe gets POLLHUP and child exits
> >> +- Prevents orphaned daemons if parent is killed
> >> +
> >> +
> >> +fuse_daemonize_signal()
> >> +-----------------------
> >> +
> >> +Status values:
> >> +- FUSE_DAEMONIZE_SUCCESS (0): Initialization succeeded
> >> +- FUSE_DAEMONIZE_FAILURE (1): Initialization failed
> >> +
> >> +Behavior:
> >> +- Signals the parent process with success or failure status
> > 
> > Does this get written back through the death pipe?  Or does it use
> > process signals?
> 
> /* Private/internal data  */
> struct fuse_daemonize {
> 	unsigned int flags;
> 	int signal_pipe_wr;	/* write end for signaling parent */
> 	int death_pipe_rd;	/* read end, POLLHUP when parent dies */
> 
> 
> I.e. it writes through signal_pipe_wr. I probably could simplify it and
> just use a single pipe. Although from my point of view, these are
> details that can be improved later. I'm quite under time pressure...

Ah, ok.  How about changing the wording "Send the success or failure
status to the parent process" ?

> > 
> >> +- Parent exits with EXIT_SUCCESS or EXIT_FAILURE accordingly
> >> +- On success: redirects stdout/stderr to /dev/null
> >> +- Stops the parent watcher thread
> >> +- Cleans up pipes and internal state
> > 
> > I think these might be better called fuse_daemonize_success() and
> > fuse_daemonize_fail() since one of them does more than just signal the
> > parent process.
> 
> Absolutely and thanks a lot! The API functions are the main reason why I
> sent it to the list - once the API is in place I cann change it anymore
> after a libfuse
> release.

<nod>

> > 
> >> +- Safe to call multiple times
> >> +- Safe to call even if fuse_daemonize_start() failed
> >> +
> >> +
> >> +fuse_daemonize_active()
> >> +-----------------------
> >> +
> >> +Returns true if daemonization is active and waiting for signal.
> >> +
> >> +Used by the high-level fuse_main() to detect if the application already
> >> +called the new API, avoiding double-daemonization.
> >> +
> >> +
> >> +Example usage (new API):
> >> +-------------------------
> >> +
> >> +    // Start daemonization BEFORE mount
> >> +    unsigned int daemon_flags = 0;
> >> +    if (foreground)
> >> +        daemon_flags |= FUSE_DAEMONIZE_NO_BACKGROUND;
> >> +
> >> +    if (fuse_daemonize_start(daemon_flags) != 0)
> >> +        goto error;
> >> +
> >> +    // Mount can now fail and be reported to parent
> >> +    if (fuse_session_mount(se, mountpoint) != 0)
> >> +        goto error_signal;
> >> +
> >> +    // Complex initialization can fail and be reported
> >> +    if (setup_threads() != 0)
> >> +        goto error_signal;
> >> +
> >> +    if (setup_network() != 0)
> >> +        goto error_signal;
> > 
> > Hrmm, interesting, this solves the problem of fuse2fs having to wait
> > until FUSE_INIT to create background threads.
> 
> So exactly what the new API for.
> 
> I turned the order around in the example above, though. I think one
> first wants to set up threads and network and then mount.

<nod> fuse4fs does all the important setup pieces (opening the block
device, parsing the ext4 superblock, etc) before starting on the libfuse
part, so FUSE_INIT is mostly just setting feature bits and opening a few
things (like PSI stall monitors and background flush threads) that are
either optional or actually have to happen after daemonize().

> >> +
> >> +    // Signal success - parent exits with EXIT_SUCCESS
> >> +    // This is typically done in the init() callback after FUSE_INIT
> >> +    fuse_daemonize_signal(FUSE_DAEMONIZE_SUCCESS);
> >> +
> >> +    // Run main loop
> >> +    fuse_session_loop(se);
> >> +
> >> +    return 0;
> >> +
> >> +error_signal:
> >> +    // Signal failure - parent exits with EXIT_FAILURE
> >> +    fuse_daemonize_signal(FUSE_DAEMONIZE_FAILURE);
> >> +error:
> >> +    return 1;
> >> +
> >> +
> >> +When to signal success
> >> +----------------------
> >> +
> >> +The success signal should be sent after all critical initialization is
> >> +complete. For FUSE filesystems, this is typically in the init() callback,
> >> +after FUSE_INIT has been processed successfully.
> >> +
> >> +Example (from passthrough_hp.cc):
> >> +    static void sfs_init(void *userdata, fuse_conn_info *conn) {
> >> +        // ... initialization ...
> >> +        fuse_daemonize_signal(FUSE_DAEMONIZE_SUCCESS);
> >> +    }
> >> +
> >> +This ensures the parent only exits after:
> >> +- Mount succeeded
> >> +- FUSE_INIT completed
> >> +- All threads started
> >> +- Filesystem is ready to serve requests
> > 
> > Very nice!  Does this new daemonization work for async-init servers?
> 
> Sure. See passthrough_hp.cc - it does the fuse_daemonize_success() in
> sfs_init(). With async-init that is long after the mount, with sync-init
> that is as part of the mount.

<nod>

> > 
> >> diff --git a/example/passthrough_hp.cc b/example/passthrough_hp.cc
> >> index 9f795c5546ee8312e1393c5b8fcebfd77724fb49..a0da5c7e6ab07f921df65db9c700e7de77fe1598 100644
> >> --- a/example/passthrough_hp.cc
> >> +++ b/example/passthrough_hp.cc
> >> @@ -55,6 +55,7 @@
> >>  #include <errno.h>
> >>  #include <ftw.h>
> >>  #include <fuse_lowlevel.h>
> >> +#include <fuse_daemonize.h>
> >>  #include <inttypes.h>
> >>  #include <string.h>
> >>  #include <sys/file.h>
> >> @@ -243,6 +244,9 @@ static void sfs_init(void *userdata, fuse_conn_info *conn)
> >>  
> >>  	/* Try a large IO by default */
> >>  	conn->max_write = 4 * 1024 * 1024;
> >> +
> >> +	/* Signal successful init to parent */
> >> +	fuse_daemonize_signal(FUSE_DAEMONIZE_SUCCESS);
> >>  }
> >>  
> >>  static void sfs_getattr(fuse_req_t req, fuse_ino_t ino, fuse_file_info *fi)
> >> @@ -1580,6 +1584,7 @@ int main(int argc, char *argv[])
> >>  {
> >>  	struct fuse_loop_config *loop_config = NULL;
> >>  	void *teardown_watchog = NULL;
> >> +	unsigned int daemon_flags = 0;
> >>  
> >>  	// Parse command line options
> >>  	auto options{ parse_options(argc, argv) };
> >> @@ -1638,10 +1643,14 @@ int main(int argc, char *argv[])
> >>  
> >>  	fuse_loop_cfg_set_clone_fd(loop_config, fs.clone_fd);
> >>  
> >> -	if (fuse_session_mount(se, argv[2]) != 0)
> >> +	/* Start daemonization before mount so parent can report mount failure */
> >> +	if (fs.foreground)
> >> +		daemon_flags |= FUSE_DAEMONIZE_NO_BACKGROUND;
> >> +	if (fuse_daemonize_start(daemon_flags) != 0)
> >>  		goto err_out3;
> >>  
> >> -	fuse_daemonize(fs.foreground);
> >> +	if (fuse_session_mount(se, argv[2]) != 0)
> >> +		goto err_out4;
> >>  
> >>  	if (!fs.foreground)
> >>  		fuse_log_enable_syslog("passthrough-hp", LOG_PID | LOG_CONS,
> >> @@ -1650,7 +1659,7 @@ int main(int argc, char *argv[])
> >>  	teardown_watchog = fuse_session_start_teardown_watchdog(
> >>  		se, fs.root.stop_timeout_secs, NULL, NULL);
> >>  	if (teardown_watchog == NULL)
> >> -		goto err_out3;
> >> +		goto err_out4;
> >>  
> >>  	if (options.count("single"))
> >>  		ret = fuse_session_loop(se);
> >> @@ -1659,6 +1668,9 @@ int main(int argc, char *argv[])
> >>  
> >>  	fuse_session_unmount(se);
> >>  
> >> +err_out4:
> >> +	if (fuse_daemonize_active())
> >> +		fuse_daemonize_signal(FUSE_DAEMONIZE_FAILURE);
> >>  err_out3:
> >>  	fuse_remove_signal_handlers(se);
> >>  err_out2:
> >> diff --git a/include/fuse_daemonize.h b/include/fuse_daemonize.h
> >> new file mode 100644
> >> index 0000000000000000000000000000000000000000..f49f6aa580a93547198e7dabe65498708e65d024
> >> --- /dev/null
> >> +++ b/include/fuse_daemonize.h
> >> @@ -0,0 +1,71 @@
> >> +/*
> >> + * FUSE: Filesystem in Userspace
> >> + * Copyright (C) 2026 Bernd Schubert <bsbernd.com>
> >> + *
> >> + * This program can be distributed under the terms of the GNU LGPLv2.
> >> + * See the file COPYING.LIB.
> >> + *
> >> + */
> >> +
> >> +#ifndef FUSE_DAEMONIZE_H_
> >> +#define FUSE_DAEMONIZE_H_
> >> +
> >> +#include <stdint.h>
> >> +#include <stdbool.h>
> >> +
> >> +#ifdef __cplusplus
> >> +extern "C" {
> >> +#endif
> >> +
> >> +/**
> >> + * Flags for fuse_daemonize_start()
> >> + */
> >> +#define FUSE_DAEMONIZE_NO_CHDIR      (1 << 0)
> >> +#define FUSE_DAEMONIZE_NO_BACKGROUND (1 << 1)
> >> +
> >> +/**
> >> + * Status values for fuse_daemonize_signal()
> >> + */
> >> +#define FUSE_DAEMONIZE_SUCCESS 0
> >> +#define FUSE_DAEMONIZE_FAILURE 1
> > 
> > What if fuse_daemonize_signal() took an exitcode and passed it directly
> > to the parent process via the death pipe, and the parent process can
> > pass that to exit()?  IOWs, what if fuse_daemonize_signal writes @status
> > into signal_pipe_wr instead of flattening it to EXIT_SUCCESS/FAILURE?
> > 
> > Or, if you want to constrain the values to binary, then why not use
> > 
> > #define FUSE_DAEMONIZE_SUCCESS (EXIT_SUCCESS) ?
> 
> Good idea. Updated to
> 
> /**
>  * Signal daemonization failure to parent and cleanup.
>  *
>  * @param err error code to pass to parent
>  */
> void fuse_daemonize_fail(int err);

Cool!

> 
> > 
> >> +
> >> +/**
> >> + * Start daemonization process.
> >> + *
> >> + * Unless FUSE_DAEMONIZE_NO_BACKGROUND is set, this forks the process.
> >> + * The parent waits for a signal from the child via fuse_daemonize_signal().
> >> + * The child returns from this call and continues setup.
> >> + *
> >> + * Unless FUSE_DAEMONIZE_NO_CHDIR is set, changes directory to "/".
> >> + *
> >> + * Must be called before fuse_session_mount().
> >> + *
> >> + * @param flags combination of FUSE_DAEMONIZE_* flags
> >> + * @return 0 on success, negative errno on error
> >> + */
> >> +int fuse_daemonize_start(unsigned int flags);
> >> +
> >> +/**
> >> + * Signal daemonization status to parent and cleanup.
> >> + *
> >> + * The child calls this after setup is complete (or failed).
> >> + * The parent receives the status and exits with it.
> >> + * Safe to call multiple times or if start failed.
> >> + *
> >> + * @param status FUSE_DAEMONIZE_SUCCESS or FUSE_DAEMONIZE_FAILURE
> >> + */
> >> +void fuse_daemonize_signal(int status);
> >> +
> >> +/**
> >> + * Check if daemonization is active and waiting for signal.
> >> + *
> >> + * @return true if active, false otherwise
> >> + */
> >> +bool fuse_daemonize_active(void);
> >> +
> >> +#ifdef __cplusplus
> >> +}
> >> +#endif
> >> +
> >> +#endif /* FUSE_DAEMONIZE_H_ */
> >> +
> >> diff --git a/include/meson.build b/include/meson.build
> >> index bf671977a5a6a9142bd67aceabd8a919e3d968d0..cfbaf52ac5d84369e92948c631e2fcfdd04ac2eb 100644
> >> --- a/include/meson.build
> >> +++ b/include/meson.build
> >> @@ -1,4 +1,5 @@
> >>  libfuse_headers = [ 'fuse.h', 'fuse_common.h', 'fuse_lowlevel.h',
> >> -	            'fuse_opt.h', 'cuse_lowlevel.h', 'fuse_log.h' ]
> >> +	            'fuse_opt.h', 'cuse_lowlevel.h', 'fuse_log.h',
> >> +	            'fuse_daemonize.h' ]
> >>  
> >>  install_headers(libfuse_headers, subdir: 'fuse3')
> >> diff --git a/lib/fuse_daemonize.c b/lib/fuse_daemonize.c
> >> new file mode 100644
> >> index 0000000000000000000000000000000000000000..5d191e7d737d04876d02ef6bd526061c003d2ab7
> >> --- /dev/null
> >> +++ b/lib/fuse_daemonize.c
> >> @@ -0,0 +1,284 @@
> >> +/*
> >> + * FUSE: Filesystem in Userspace
> >> + * Copyright (C) 2026 Bernd Schubert <bsbernd.com>
> >> + *
> >> + * This program can be distributed under the terms of the GNU LGPLv2.
> >> + * See the file COPYING.LIB.
> >> + */
> >> +
> >> +#define _GNU_SOURCE
> >> +
> >> +#include "fuse_daemonize.h"
> >> +
> >> +#include <fcntl.h>
> >> +#include <poll.h>
> >> +#include <pthread.h>
> >> +#include <stdatomic.h>
> >> +#include <stdio.h>
> >> +#include <stdlib.h>
> >> +#include <string.h>
> >> +#include <sys/types.h>
> >> +#include <unistd.h>
> >> +#include <stdbool.h>
> >> +#include <errno.h>
> >> +
> >> +/* Private/internal data  */
> >> +struct fuse_daemonize {
> >> +	unsigned int flags;
> >> +	int signal_pipe_wr;	/* write end for signaling parent */
> > 
> > Hrm.  Ok, so signal_pipe[2] is the pipe through which the child writes
> > an int back to the parent, and then the parent can convey that outcome
> > to whatever started the parent.
> > 
> >> +	int death_pipe_rd;	/* read end, POLLHUP when parent dies */
> > 
> > death_pipe[2] is a different pipe.  The parent closes its end of the
> > pipe and the child treats POLLHUP as a message that the parent died.
> 
> Yeah, let's say network initialization takes a long time or never
> succeeds, the user wants to abort the mount and kills the parent. In
> that case client should not continue to run in the background/

<nod>

> > 
> >> +	int stop_pipe_rd;	/* read end for stop signal */
> >> +	int stop_pipe_wr;	/* write end for stop signal */
> > 
> > and this third pipe exist so that the child can wake its own "parent
> > watcher" thread and have it abort.
> > 
> >> +	pthread_t watcher;
> >> +	int watcher_started;
> > 
> > Hm.  So watcher_started is initialized to 0 in the parent, gets set to 1
> > in the child's copy of memory when it starts the parent-watcher thread,
> > and later becomes zero when the child shuts down the parent-watcher
> > thread.
> > 
> >> +	_Atomic bool active;
> > 
> > active is set in the parent process, copied to the child process, and
> > cleared in fuse_daemonize_signal in the child.
> > 
> >> +	_Atomic bool daemonized;
> > 
> > and daemonized is set in the child upon creation of the child; and
> > read by fuse_daemonize_signal.  The parent never accesses its copy of
> > the variable.
> > 
> >> +};
> >> +
> >> +/* Global daemonization object pointer */
> >> +static _Atomic(struct fuse_daemonize *) daemonize;
> >> +
> >> +/* Watcher thread: polls for parent death or stop signal */
> >> +static void *parent_watcher_thread(void *arg)
> >> +{
> >> +	struct fuse_daemonize *di = arg;
> >> +	struct pollfd pfd[2];
> >> +
> >> +	pfd[0].fd = di->death_pipe_rd;
> >> +	pfd[0].events = POLLIN;
> >> +	pfd[1].fd = di->stop_pipe_rd;
> >> +	pfd[1].events = POLLIN;
> >> +
> >> +	while (1) {
> >> +		int rc = poll(pfd, 2, -1);
> >> +
> >> +		if (rc < 0)
> >> +			continue;
> >> +
> >> +		/* Parent died - death pipe write end closed */
> >> +		if (pfd[0].revents & (POLLHUP | POLLERR))
> >> +			_exit(EXIT_FAILURE);
> >> +
> >> +		/* Stop signal received */
> >> +		if (pfd[1].revents & POLLIN)
> >> +			break;
> >> +	}
> >> +	return NULL;
> >> +}
> >> +
> >> +static int start_parent_watcher(struct fuse_daemonize *daemonize)
> >> +{
> >> +	int rc;
> >> +
> >> +	rc = pthread_create(&daemonize->watcher, NULL, parent_watcher_thread,
> >> +			    daemonize);
> >> +	if (rc != 0) {
> >> +		perror("fuse_daemonize: pthread_create");
> > 
> > pthread functions return positive error numbers and do not set errno, so
> > you can't use perror().
> 
> 
> Thanks, updated.
> 
> > 
> >> +		return -1;
> >> +	}
> >> +	daemonize->watcher_started = 1;
> > 
> > Isn't this a bool value?
> 
> Already just updated it before even reading this :)
> 
> > 
> > FWIW the rest of the logic below looks correct, though I think the
> > daemonize object itself would need a pthread_mutex_t to coordinate
> > access if it's possible or desirable for multiple threads to access it.
> > 
> > I think that's not the case, and any fuse server that did need that
> > could implement the locking on its own.
> 
> Yeah, I had thought about it, but I can't find a real use case yet.
> Maybe with sync-init fuse_daemonize_success() needs to be called twice,
> although I still assume that calling it in the FUSE_INIT handler should
> be ok, because the mount then succeeded. I need to think about it
> another night.
> Hmm, actually ->init() needs to know if sync or async init used, i.e.
> the ->init() function should only call fuse_daemonize_success() with
> async-init. With sync-init that should be done after
> fuse_session_mount(). I'm going to add another new patch at the end of
> the series in the next patch version.

<nod> Thanks for bearing with my unfamiliarity! :)

--D

> 
> Thanks,
> Bernd
> 
