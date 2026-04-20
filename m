Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC63D40DFCE
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 00:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776644501; cv=none; b=HZRtTqp1rBnSBdhvSpQT7zNTHqC9US/4+ZJZL17crQPOP//MPcgtXT/utmkiUxmlBG1Ya+SyxyM8jRnw+FTq+ssCcOLKXOXniQUgNWMXXPGFyFp6qcjCMgoLD2Bs/LfD2DEVUnJuD4jxe02OiH8PG0uv8t54sU7WmEVtAEUxY2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776644501; c=relaxed/simple;
	bh=c9mLSNWLXYkPVLvETkygMi7yWmYUyd9peRfCaSZDNSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bg62441o5DOzdGIxedMOPRlsP2tJ3kif01MW16zaLY3V8773268uAsSF3DKgqSULVSy66He0G3gG/cdWvAxHCfy5yk55putS4cV+L6aduD5EnVVixIr+8sD6NK3HaXSKU5V29B/8BFZeZjPVyXuDJBSOA1k3SNsewE90Uwj7XMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=XfDQIUU9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ViPXOrND; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="XfDQIUU9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ViPXOrND"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 030BB140002E;
	Sun, 19 Apr 2026 20:21:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 19 Apr 2026 20:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776644497;
	 x=1776730897; bh=GLrfsUvUwUUm2tnT+n0fdIhr+brWAmxHTvnJwn9k3HA=; b=
	XfDQIUU90390eVRYMAdK/Mb6pnx5QA6Z7dwjmxiWAZ+N6RU/tfXgbc8QefJtOPMK
	yRjDMxz6ozLQHJ0jKVujKeFctkawV2RVb60Xcrw16smcnAUlqq9dfyd8WcUdswOE
	MBwwwFVJ2ZF/rTOoEczJQrVr8+XIcs0MZuPCE0QBbEJE7uhagvAD5gS/oqSbberH
	orQYGOSc4CcX8gvmkeRaHztk138qHWp68NowqSzFVeom5hc9/emdRDVwLaX80nfG
	F6NTm2AMjdbgfiVhHasRfoMnjyql88o35XZC/fleHS4bUvj3YwOlOM1M4bj0CuPp
	KL2RHcBAd0KiDcVshnMOEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776644497; x=
	1776730897; bh=GLrfsUvUwUUm2tnT+n0fdIhr+brWAmxHTvnJwn9k3HA=; b=V
	iPXOrNDM+aFrqEUplenzRwtE7x+CNdMVY8BPdzM1+T+wXqxjlXSIz1dFd2MQ0Yu4
	RdYlyhGHLbguI4KkqWJkxTH1M11yZpXirEMZ4255mzJzz7A2z2r1Q6fGhET7xDjo
	sPkU5zwJ686B4GeZ5jgT4MhTjeKyZqLN3EDEalQz7gnj+BsSn2dff12wsprKM0pv
	z1IBUiAMmqhMTZt/xd07Fhd61hvxfFNVDrqXtIa00U4Yl4NOFOGIHfl3+Jk3f/fE
	7hawB+cI5ucnZ4/lM5MOryH/XKnH3c5gTRxW+e90a7H2A70abobc8UOHAFyjEPUM
	BUh4Iit2vmy2rSqeCV87Q==
X-ME-Sender: <xms:kXHlaUZ3TlUVg7t7pbYXFwduWvIt68SF-6N4Py7F_GA8PYtlz7BxBA>
    <xme:kXHlaWSTRpUUnE0MZrq60fKZeVK61PJ6BZ4ETRRzIdrrJJrpklQf9zWjHnBClfOzW
    eV1PhLpICfs_uefi2Izemro2daBc0Ee4SPy8_7lhfc-YT_yOjk>
X-ME-Received: <xmr:kXHlaXQsuzJ-JPoLtK0pmAwRLW01E8Upk5hIFaZt9ReYr8tlb2_P4rHKzJ7w4qgub66XOGvyIlYxyhsWDoUSaOuxnIVVzG680I55jWBnXZvU09QXtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehjedtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnheptdeuvdeuudeltddukefhueeludduieejvdevveevteduvdefuedvkeffjeel
    ueeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgusegsshgsvghrnhgurdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegujh
    ifohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgv
    lhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhklhhoshesshiivg
    hrvgguihdrhhhupdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepkhgthhgvnhesuggunhdrtghomh
X-ME-Proxy: <xmx:kXHlaaRPM9yLwPjdAmxndbpvXoG8Q1BpLYBJFfSymoMAG12J8ARPiA>
    <xmx:kXHlac79q7MuY-lFIxQ-9IPj3XGUq2JB74qNIHxlHG9VkDknYfipeQ>
    <xmx:kXHlaW1-Jqj0FcbLvbCubkWMuQEOChFQejvA6uxWjDxIgaO39eysNw>
    <xmx:kXHlaXAKr5Zs_9P60Crl5R0ldi2t_hH4uTvt2B4kY0I0x1OMJn0rig>
    <xmx:kXHlab7pEVII7TjM8IKHTtTzYTrAIYCjYq_XI8FANb79xPPr_n1aiIzB>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Apr 2026 20:21:36 -0400 (EDT)
Message-ID: <aead083a-ff23-43b7-8fd5-ce543ea4d969@bsbernd.com>
Date: Mon, 20 Apr 2026 02:21:34 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/25] Add mount and daemonization README documents
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
 <20260326-fuse-init-before-mount-v2-24-b1ca8fcbf60f@bsbernd.com>
 <20260331011740.GJ6202@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr
In-Reply-To: <20260331011740.GJ6202@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/31/26 03:17, Darrick J. Wong wrote:
> On Thu, Mar 26, 2026 at 10:34:57PM +0100, Bernd Schubert wrote:
>> These are useful to
>>
>> Signed-off-by: Bernd Schubert <bernd@bsbernd.com>
>> ---
>>  doc/README.daemonize  | 197 +++++++++++++++++++++++++++
>>  doc/README.fusermount | 362 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  doc/README.mount      |  86 ++++++++++++
>>  doc/README.sync-init  | 184 +++++++++++++++++++++++++
>>  4 files changed, 829 insertions(+)
>>
>> diff --git a/doc/README.daemonize b/doc/README.daemonize
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..7b56c33077f29edbd335a2778120d9b6db6022ad
>> --- /dev/null
>> +++ b/doc/README.daemonize
>> @@ -0,0 +1,197 @@
>> +FUSE Daemonization API
>> +======================
>> +
>> +This document describes the FUSE daemonization APIs, including the legacy
>> +fuse_daemonize() function and the new fuse_daemonize_start()/signal() API
>> +introduced in libfuse 3.19.
>> +
>> +
>> +Overview
>> +--------
>> +
>> +FUSE filesystems often need to run as background daemons. Daemonization
>> +involves forking the process, creating a new session, and redirecting
>> +standard file descriptors. The challenge is properly reporting initialization
>> +failures to the parent process.
> 
> But why is it important to report init failures to the parent?
> 
> "The parent can, in turn, pass those errors up to whichever process
> started the fuse server."?
> 
>> +
>> +
>> +Old API: fuse_daemonize()
>> +--------------------------
>> +
>> +Function signature:
>> +    int fuse_daemonize(int foreground);
>> +
>> +Location: lib/helper.c
>> +
>> +This is the legacy daemonization API, primarily used with the high-level
>> +fuse_main() interface.
>> +
>> +Behavior:
>> +- If foreground=0: forks the process, creates a new Unix session,
>> +  redirects stdio
>> +- If foreground=1: only changes directory to "/"
>> +- Parent waits for a single byte on a pipe before exiting
>> +- Child writes completion byte immediately after redirecting stdio
>> +- Always changes directory to "/"
>> +
>> +Limitations:
>> +1. No failure reporting: The parent receives notification immediately after
>> +   fork/setsid, before any meaningful initialization (like mounting the
>> +   filesystem or starting threads).
>> +
>> +2. Timing constraint: Must be called AFTER fuse_session_mount() in existing
>> +   examples, because there's no way to report mount failures to the parent.
> 
> "...to report mount() failures...", specifically.
> 
>> +
>> +3. Thread initialization: Cannot report failures from complex initialization
>> +   steps like:
>> +   - Starting worker threads
>> +   - Network connection setup
>> +   - RDMA memory registration
>> +   - Resource allocation
>> +
>> +4. FUSE_SYNC_INIT incompatibility: With the FUSE_SYNC_INIT feature, FUSE_INIT
>> +   happens at mount time and may start io_uring threads. This requires
>> +   daemonization BEFORE mount, which the old API cannot handle properly.
>> +
>> +Example usage (old API):
>> +    fuse = fuse_new(...);
>> +    fuse_mount(fuse, mountpoint);
>> +    fuse_daemonize(opts.foreground);  // After mount, can't report mount failure
>> +    fuse_set_signal_handlers(se);
>> +    fuse_session_loop(se);
>> +
>> +
>> +New API: fuse_daemonize_start() / fuse_daemonize_success() / fuse_daemonize_fail()
>> +---------------------------------------------------------------------------------
>> +
>> +Functions:
>> +    int fuse_daemonize_start(unsigned int flags);
>> +    void fuse_daemonize_success(void);
>> +    void fuse_daemonize_fail(void);
>> +    bool fuse_daemonize_active(void);
>> +
>> +Location: lib/fuse_daemonize.c, include/fuse_daemonize.h
>> +Available since: libfuse 3.19
>> +
>> +This new API solves the limitations of fuse_daemonize() by splitting
>> +daemonization into two phases:
>> +
>> +1.   fuse_daemonize_start() - Fork and setup, but parent waits
>> +2.1. fuse_daemonize_fail() - Signal failure to parent
>> +2.2  fuse_daenmize_success() - Signal startup to success to the parent
> 
> fuse_daemonize_success()
> 
>> +     See below for an important detail.
>> +
>> +
>> +fuse_daemonize_start()
>> +----------------------
>> +
>> +Flags:
>> +- FUSE_DAEMONIZE_NO_CHDIR: Don't change directory to "/"
>> +- FUSE_DAEMONIZE_NO_BACKGROUND: Don't fork (foreground mode)
>> +
>> +Behavior:
>> +- Unless NO_BACKGROUND: forks the process
>> +- Parent waits for status signal from child
>> +- Child creates new session and continues
>> +- Unless NO_CHDIR: changes directory to "/"
>> +- Closes stdin immediately in child
>> +- Starts a watcher thread to detect parent death
>> +- Returns 0 in child on success, negative errno on error
>> +
>> +Parent death detection:
>> +- Uses a "death pipe" - parent keeps write end open
>> +- Child's watcher thread polls the read end
>> +- When parent dies, pipe gets POLLHUP and child exits
> 
> "If parent dies"?  Using the word "when" make it sound like the parent
> is supposed to die before the child.
> 
>> +- Prevents orphaned daemons if parent is killed
> 
> If the child dies unexpectedly, the read(signal_pipe[0], ...) call
> returns zero, so the parent will also exit, right?  I think that should
> be mentioned here.
> 
>> +
>> +
>> +fuse_daemonize_fail(int err)
>> +----------------------------
>> +
>> +Behavior:
>> +- Signals the parent about the provided error
>> +- Parent will exit with that error
>> +
>> +fuse_daemonize_success()
>> +------------------------
>> +- Signals the parent process with succes
>> +- On success: redirects stdout/stderr to /dev/null
> 
> For systemd service mode, it'd be nice to have a third flag that
> disables stdout/stderr redirection too, since it's expected in systemd
> land that stdout goes to journald/syslog.  I can add that in my own
> patchset.

I have definitely planned that, but please feel free to add it. I
frequently need stdout/err in syslog for ASAN runs.
I had patch/PR for passthrough_hp, but didn't like it and recently
closed the PR, because can be generalized with new daemonize API.

> 
>> +- Stops the parent watcher thread
>> +- Cleans up pipes and internal state
>> +- Safe to call multiple times
>> +- Safe to call even if fuse_daemonize_start() failed
>> +- *Important*: Should be called twice, once from ->init
>> +  (struct fuse_lowlevel_ops::init or for high level interface
>> +   struct fuse_operations::init) and after fuse_session_mount().
>> +  It will internally figure out which of these two calls will
>> +  actually signal the parent about success. Reason is that
>> +  sucess must only be signaled when the mount is complete and
> 
> success ^^^
> 
>> +  that depends on if synchronous or asynchronous FUSE_INIT is
>> +  used. 
>> +
>> +
>> +fuse_daemonize_active()
>> +-----------------------
>> +
>> +Returns true if daemonization is active and waiting for signal.
>> +
>> +Used by the high-level fuse_main() to detect if the application already
>> +called the new API, avoiding double-daemonization.
>> +
>> +
>> +Example usage (new API):
>> +-------------------------
>> +
>> +    // Start daemonization BEFORE mount
>> +    unsigned int daemon_flags = 0;
>> +    if (foreground)
>> +        daemon_flags |= FUSE_DAEMONIZE_NO_BACKGROUND;
>> +
>> +    if (fuse_daemonize_start(daemon_flags) != 0)
>> +        goto error;
>> +
>> +    // Complex initialization can fail and be reported
>> +    if (setup_threads() != 0)
>> +        goto error_signal;
>> +
>> +    if (setup_network() != 0)
>> +        goto error_signal;
>> +    // Mount can now fail and be reported to parent
>> +    if (fuse_session_mount(se, mountpoint) != 0)
>> +        goto error_signal;
>> +
>> +    // Signal success - parent exits with EXIT_SUCCESS
>> +    // This is typically done in the init() callback after FUSE_INIT
>> +    fuse_daemonize_signal(FUSE_DAEMONIZE_SUCCESS);
>> +
>> +    // Run main loop
>> +    fuse_session_loop(se);
>> +
>> +    return 0;
>> +
>> +error_signal:
>> +    // Signal failure - parent exits with EXIT_FAILURE
>> +    fuse_daemonize_signal(FUSE_DAEMONIZE_FAILURE);
>> +error:
>> +    return 1;
>> +
>> +
>> +When to signal success
>> +----------------------
>> +
>> +The success signal should be sent after all critical initialization is
>> +complete. For FUSE filesystems, this is typically in the init() callback,
>> +after FUSE_INIT has been processed successfully.
>> +
>> +Example (from passthrough_hp.cc):
>> +    static void sfs_init(void *userdata, fuse_conn_info *conn) {
>> +        // ... initialization ...
>> +        fuse_daemonize_signal(FUSE_DAEMONIZE_SUCCESS);
>> +    }
>> +
>> +This ensures the parent only exits after:
>> +- Mount succeeded
>> +- FUSE_INIT completed
>> +- All threads started
>> +- Filesystem is ready to serve requests
>> +
>> diff --git a/doc/README.fusermount b/doc/README.fusermount
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..5b81651c8690aa25fef12db322af977c9cba1d31
>> --- /dev/null
>> +++ b/doc/README.fusermount
>> @@ -0,0 +1,362 @@
>> +Synchronous FUSE_INIT Protocol
>> +================================
> 
> Hm.  I thought I just got done reading a documnet about how synchronous
> FUSE_INIT works?  Looking at the copious references to fusermount3 under
> "Protocol Flow", is this the doc for how it works when fusermount is
> involved?
> 
>> +
>> +Overview
>> +--------
>> +
>> +The sync-init feature enables the FUSE library to start worker threads and
>> +perform initialization ioctl calls BEFORE the actual mount() syscall happens.
>> +This is required for the kernel's synchronous FUSE_INIT feature, where the
>> +mount() syscall blocks until the FUSE daemon processes the INIT request.
>> +
>> +Without this feature, there would be a deadlock:
>> +- mount() blocks waiting for INIT response
>> +- Worker threads can't start because mount() hasn't returned
>> +- INIT request can't be processed because worker threads aren't running
>> +
>> +
>> +Protocol Flow
>> +-------------
>> +
>> +Traditional mount flow:
>> +  1. Library calls fusermount3
>> +  2. fusermount3 opens /dev/fuse
>> +  3. fusermount3 performs mount() syscall
>> +  4. fusermount3 sends fd to library
>> +  5. Library starts worker threads
>> +  6. Worker threads process FUSE requests
>> +
>> +Sync-init mount flow:
>> +  1. Library calls fusermount3 with --sync-init flag
>> +  2. fusermount3 opens /dev/fuse
>> +  3. fusermount3 sends fd to library
>> +  4. Library receives fd
>> +  5. Library performs FUSE_DEV_IOC_SYNC_INIT ioctl
>> +  6. Library starts worker threads
>> +  7. Library sends "proceed" signal to fusermount3
>> +  8. fusermount3 performs mount() syscall (blocks until INIT completes)
>> +  9. Worker threads process INIT request
>> +  10. mount() syscall completes
>> +  11. fusermount3 exits
>> +
>> +
>> +Implementation Details
>> +----------------------
>> +
>> +Bidirectional Communication:
>> +  - Uses the existing unix socket (_FUSE_COMMFD environment variable)
>> +  - Simple 1-byte protocol for signaling
>> +  - Library signals fusermount3 when ready to proceed with mount
>> +
>> +fusermount3 Changes:
>> +  - New --sync-init command-line option
>> +  - Split mount operation into two phases:
>> +    * mount_fuse_prepare(): Opens device, prepares parameters
>> +    * mount_fuse_finish_fsmount(): Performs actual mount() syscall
>> +  - wait_for_signal(): Waits for library to signal readiness
>> +  - struct mount_context: Preserves state between phases
>> +
>> +Library Changes:
>> +  - fuse_session_mount_new_api(): Uses new protocol when available
>> +  - Sends "proceed" signal after worker thread is ready
>> +  - Handles both old and new mount protocols for compatibility
>> +
>> +
>> +Backward Compatibility
>> +----------------------
>> +
>> +The implementation maintains full backward compatibility:
>> +  - Old library + new fusermount3: Works (uses traditional flow)
>> +  - New library + old fusermount3: Falls back to traditional flow
> 
> "traditional", as in async FUSE_INIT?
> 
>> +  - New library + new fusermount3: Uses sync-init flow when appropriate
>> +
>> +
>> +Error Handling
>> +--------------
>> +
>> +If any step fails during the sync-init flow:
>> +  - fusermount3 closes the fd and exits with error
>> +  - Library detects failure and cleans up
>> +  - No mount is left in inconsistent state
>> +
>> +Connection closure:
>> +  - If library closes socket before signaling, fusermount3 detects and exits
>> +  - If fusermount3 crashes, library detects closed socket
>> +
>> +
>> +Security Considerations
>> +-----------------------
>> +
>> +The sync-init protocol does not introduce new security concerns:
>> +  - Uses the same privilege separation as traditional mount
>> +  - Socket communication is already established and trusted
>> +  - No new privileged operations are added
>> +  - File descriptor passing uses existing SCM_RIGHTS mechanism
>> +
>> +
>> +Performance Impact
>> +------------------
>> +
>> +Minimal performance impact:
>> +  - One additional recv() call in fusermount3
>> +  - One additional send() call in library
>> +  - Total overhead: ~2 context switches
>> +  - Only affects mount time, not runtime performance
>> +
>> +
>> +Future Enhancements
>> +-------------------
>> +
>> +Potential improvements:
>> +  - Extended protocol for more complex initialization sequences
>> +  - Support for multiple worker threads coordination
>> +  - Enhanced error reporting through the socket
>> +  - Timeout mechanisms for detecting hung initialization
> 
> Is that for libfuse detecting that a fusermount has hung?  Or for
> fusermount detecting that the fuse server hasn't responded to FUSE_INIT
> and giving up?  I suspect the former.
> 
>> +
>> +
>> +ASCII Workflow Diagrams
>> +========================
>> +
>> +1. Traditional Mount Flow (without --sync-init, async INIT)
>> +------------------------------------------------------------
>> +
>> +Library                   fusermount3              Kernel
>> +   |                           |                      |
>> +   |--- spawn fusermount3 ---->|                      |
>> +   |                           |                      |
>> +   |                      [open /dev/fuse]            |
>> +   |                           |------- open -------->|
>> +   |                           |<------ fd ---------- |
>> +   |                           |                      |
>> +   |                      [mount() syscall]           |
>> +   |                           |------ mount -------->|
>> +   |                           |<----- success ------ | [mount returns immediately]
>> +   |                           |                      | [INIT queued in kernel]
>> +   |                      [send_fd(fd)]               |
>> +   |<------- fd --------------|                      |
>> +   |                           |                      |
>> +   |                      [fusermount3 exits]         |
>> +   |                                                  |
>> +   |  [start worker thread]                          |
>> +   |  [worker reads /dev/fuse]                       |
>> +   |---------------------------------------- read -->|
>> +   |<--------------------------------------- INIT ---| [dequeued from kernel]
>> +   |                                                  |
>> +   | OK: INIT was queued, worker reads it later      |
>> +   |     Works fine for async INIT                   |
>> +
>> +
>> +1b. Problem: Synchronous INIT without --sync-init
>> +--------------------------------------------------
>> +
>> +Library                   fusermount3              Kernel
>> +   |                           |                      |
>> +   |--- spawn fusermount3 ---->|                      |
>> +   |                           |                      |
>> +   |                      [open /dev/fuse]            |
>> +   |                           |------- open -------->|
>> +   |                           |<------ fd ---------- |
>> +   |                           |                      |
>> +   |                      [mount() syscall]           |
>> +   |                           |------ mount -------->|
>> +   |                           |                      | [mount BLOCKS waiting for INIT]
>> +   |                           | (BLOCKED)            | [needs worker to process INIT]
>> +   |                           |                      |
>> +   |  [waiting for fd...]      |                      |
>> +   |                           |                      |
>> +   |                           |                      |
>> +   | DEADLOCK: mount() waits for INIT response       |
>> +   |           but worker thread not started yet     |
>> +   |           because we're waiting for fd          |
>> +
>> +
>> +2. Sync-Init Mount Flow (with --sync-init)
>> +-------------------------------------------
>> +
>> +Library                   fusermount3              Kernel
>> +   |                           |                      |
>> +   |--- spawn fusermount3 ---->|                      |
>> +   |    with --sync-init       |                      |
>> +   |                           |                      |
>> +   |                      [open /dev/fuse]            |
>> +   |                           |------- open -------->|
>> +   |                           |<------ fd ---------- |
>> +   |                           |                      |
>> +   |                      [send_fd(fd)]               |
>> +   |<------- fd --------------|                      |
>> +   |                           |                      |
>> +   |                      [wait_for_signal()]         |
>> +   |                           | (BLOCKED)            |
>> +   |                           |                      |
>> +   |  [ioctl SYNC_INIT]        |                      |
>> +   |---------------------------------------- ioctl -->|
>> +   |                                                  |
>> +   |  [start worker thread]                          |
>> +   |  [worker ready]                                 |
>> +   |                           |                      |
>> +   |--- "proceed" signal ----->|                      |
>> +   |                      [signal received]           |
>> +   |                           |                      |
>> +   |                      [mount() syscall]           |
>> +   |                           |------ mount -------->|
>> +   |                           |                      | [mount blocks]
>> +   |                           |                      | [sends INIT]
>> +   |<------------------------------------------------ |
>> +   |                           |                      |
>> +   | [worker processes INIT]   |                      |
>> +   |------------------------------------------------->|
>> +   |                           |                      | [mount unblocks]
>> +   |                           |<----- success ------ |
>> +   |                           |                      |
>> +   |                      [fusermount3 exits]         |
>> +   |                                                  |
>> +   | SUCCESS: Worker ready before mount()            |
>> +   |          INIT processed synchronously           |
>> +
>> +
>> +3. Error Scenario: Library Crashes Before Signaling
>> +----------------------------------------------------
>> +
>> +Library                   fusermount3              Kernel
>> +   |                           |                      |
>> +   |--- spawn fusermount3 ---->|                      |
>> +   |    with --sync-init       |                      |
>> +   |                           |                      |
>> +   |                      [open /dev/fuse]            |
>> +   |                           |------- open -------->|
>> +   |                           |<------ fd ---------- |
>> +   |                           |                      |
>> +   |                      [send_fd(fd)]               |
>> +   |<------- fd --------------|                      |
>> +   |                           |                      |
>> +   |                      [wait_for_signal()]         |
>> +   |                           | (BLOCKED)            |
>> +   |                           |                      |
>> +   X  [library crashes]        |                      |
>> +   |                           |                      |
>> +   |                      [recv() returns 0]          |
>> +   |                      [socket closed]             |
>> +   |                           |                      |
>> +   |                      [cleanup and exit]          |
>> +   |                           X                      |
>> +   |                                                  |
>> +   | RESULT: Clean failure, no mount performed       |
>> +
>> +
>> +4. Detailed Function Call Flow
>> +-------------------------------
>> +
>> +Library (lib/fuse_lowlevel.c):
>> +fuse_session_mount_new_api()
>> +   |
>> +   +-- fuse_kern_mount_prepare()  [lib/mount.c]
>> +   |      |
>> +   |      +-- fuse_mount_fusermount()  [lib/mount_util.c]
>> +   |             |
>> +   |             +-- socketpair()  [create comm socket]
>> +   |             |
>> +   |             +-- fork()
>> +   |             |
>> +   |             +-- [child] execl("fusermount3", "--sync-init", ...)
>> +   |             |
>> +   |             +-- [parent] receive_fd()  <--- BLOCKS until fd arrives
>> +   |                    |
>> +   |                    +-- recvmsg(SCM_RIGHTS)
>> +   |                    |
>> +   |                    +-- return fd
>> +   |
>> +   +-- session_start_sync_init()  [lib/fuse_lowlevel.c]
>> +   |      |
>> +   |      +-- ioctl(fd, FUSE_DEV_IOC_SYNC_INIT)
>> +   |      |
>> +   |      +-- pthread_create(worker_thread)
>> +   |      |
>> +   |      +-- return
>> +   |
>> +   +-- fuse_fusermount_proceed_mnt(socket)  [lib/mount.c] <--- NEW: Bidirectional handshake
>> +          |
>> +          +-- send(socket, "proceed", 1)  <--- Signal fusermount3 to proceed
>> +          |
>> +          +-- recv(socket, &status, 1)  <--- BLOCKS until mount result arrives
>> +          |      |
>> +          |      +-- [fusermount3 performs mount and sends status byte]
>> +          |
>> +          +-- if (status != 0) return -1  <--- Mount failed
>> +          |
>> +          +-- return 0  <--- Mount succeeded
>> +
>> +
>> +Utility (util/fusermount.c):
>> +fusermount3 main() with --sync-init
>> +   |
>> +   +-- mount_fuse_sync_init()  [util/fusermount.c]
>> +          |
>> +          +-- mount_fuse_prepare()  [util/fusermount.c]
>> +          |      |
>> +          |      +-- open("/dev/fuse")
>> +          |      |
>> +          |      +-- check_perm()  [util/fusermount.c]
>> +          |      |
>> +          |      +-- return fd
>> +          |
>> +          +-- send_fd(socket, fd)  [util/fusermount.c]
>> +          |      |
>> +          |      +-- sendmsg(SCM_RIGHTS)
>> +          |
>> +          +-- wait_for_signal(socket)  [util/fusermount.c] <--- BLOCKS until library signals
>> +          |      |
>> +          |      +-- recv(socket, buf, 1)
>> +          |      |
>> +          |      +-- return 0
>> +          |
>> +          +-- mount_fuse_finish_fsmount()  [util/fusermount.c]
>> +          |      |
>> +          |      +-- fuse_kern_fsmount()  [lib/mount_fsmount.c]
>> +          |      |      |
>> +          |      |      +-- fsopen("fuse", FSOPEN_CLOEXEC)
>> +          |      |      |      |
>> +          |      |      |      +-- [kernel creates filesystem context]
>> +          |      |      |
>> +          |      |      +-- fsconfig(fsfd, SET_STRING, "source", ...)
>> +          |      |      +-- fsconfig(fsfd, SET_STRING, "fd", fd_value, ...)
>> +          |      |      +-- fsconfig(fsfd, ...) [apply mount options]
>> +          |      |      +-- fsconfig(fsfd, CMD_CREATE, ...)
>> +          |      |      |
>> +          |      |      +-- fsmount(fsfd, FSMOUNT_CLOEXEC, mount_attrs)
>> +          |      |      |      |
>> +          |      |      |      +-- [kernel sends FUSE_INIT here]
>> +          |      |      |      |
>> +          |      |      |      +-- [worker thread processes INIT]
>> +          |      |      |      |
>> +          |      |      |      +-- [fsmount returns mntfd]
>> +          |      |      |
>> +          |      |      +-- move_mount(mntfd, "", AT_FDCWD, target, ...)
>> +          |      |      |      |
>> +          |      |      |      +-- [attach mount to target directory]
>> +          |      |      |      |
>> +          |      |      |      +-- [no blocking - INIT already processed]
>> +          |      |      |
>> +          |      |      +-- add_mount()  [lib/mount_fsmount.c - update /etc/mtab]
>> +          |      |      |
>> +          |      |      +-- return 0 on success, -1 on failure
>> +          |      |
>> +          |      +-- if mount failed: return -1
>> +          |      +-- if mount succeeded: continue
>> +          |
>> +          +-- send_status_byte(socket)  [util/fusermount.c] <--- NEW: Send result to library
>> +          |      |
>> +          |      +-- status = (mount_result == 0) ? 0 : 1
>> +          |      +-- send(socket, &status, 1)
>> +          |      |
>> +          |      +-- return
>> +          |
>> +          +-- return 0
>> +
>> +
>> +Note: The new mount API (fsopen/fsconfig/fsmount/move_mount) is REQUIRED
>> +      for sync-init because fsmount() triggers FUSE_INIT before the mount
>> +      is attached. This allows the worker thread to process INIT before
>> +      move_mount() completes, preventing deadlock.
>> +      And also so we don't expose the directory tree to the mountns until we
>> +      know that FUSE_INIT didn't crash the server.
> 
> Question: Can libfuse call fuse_reply_err in response to an ->init call
> if the fuse server wants to fail a synchronous mount?  Right now it
> looks as if it always calls fuse_reply_ok, but I'm curious because that
> might be a more graceful way for a fuse server to fail than just
> terminating.

I guess so, see fs/fuse/dev.c fuse_request_end()

	if (test_bit(FR_ASYNC, &req->flags))
		req->args->end(fm, req->args, req->out.h.error);


> 
> (Granted the kernel still has to handle the fuse server blowing up
> unintentionally.)
> 
>> +
>> diff --git a/doc/README.mount b/doc/README.mount
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..526382ad8a5f6b405a7cb1927b79bacd6c2c2c5c
>> --- /dev/null
>> +++ b/doc/README.mount
>> @@ -0,0 +1,86 @@
>> +FUSE Mount API Flowcharts
>> +=========================
>> +
>> +Old Mount API
>> +-------------
>> +
>> +fuse_kern_mount()
>> +  |
>> +  +-- fuse_mount_sys()
>> +  |     +-- Try direct mount → mount() syscall
>> +  |     +-- On EPERM: fuse_mount_fusermount()
>> +  |           +-- socketpair()
>> +  |           +-- spawn fusermount3 (no --sync-init)
>> +  |           +-- fusermount3: open /dev/fuse, mount(), send fd
>> +  |           +-- receive_fd() → return fd
>> +  |
>> +  +-- Worker threads started AFTER mount
>> +  └─> FUSE_INIT asynchronous (queued in kernel)
>> +
>> +
>> +New Mount API - Privileged Mount
>> +---------------------------------
>> +
>> +fuse_session_mount_new_api()
>> +  |
>> +  +-- fuse_kern_mount_prepare() → open /dev/fuse → fd
>> +  |
>> +  +-- session_start_sync_init(se, fd)
>> +  |     +-- ioctl(fd, FUSE_DEV_IOC_SYNC_INIT)
>> +  |     +-- pthread_create(worker) → ready to process FUSE_INIT
>> +  |
>> +  +-- fuse_kern_fsmount_mo()
>> +  |     +-- fsopen/fsconfig/fsmount (BLOCKS until FUSE_INIT completes)
>> +  |     +-- Worker processes FUSE_INIT during fsmount()
>> +  |     +-- move_mount()
>> +  |
>> +  +-- session_wait_sync_init_completion(se) → pthread_join
>> +  └─> return fd
>> +
>> +
>> +New Mount API - EPERM Fallback (fusermount3 with sync-init)
>> +------------------------------------------------------------
>> +
>> +fuse_session_mount_new_api()
>> +  |
>> +  +-- fuse_kern_mount_prepare() → open /dev/fuse → fd1
>> +  |
>> +  +-- session_start_sync_init(se, fd1)
>> +  |     +-- ioctl(fd1, FUSE_DEV_IOC_SYNC_INIT)
>> +  |     +-- pthread_create(worker) → ready with fd1
>> +  |
>> +  +-- fuse_kern_fsmount_mo() → EPERM
>> +  |
>> +  +-- *** FALLBACK TO FUSERMOUNT3 WITH SYNC-INIT ***
>> +  |
>> +  +-- session_wait_sync_init_completion(se)
>> +  |     +-- pthread_cancel/join → terminate worker with wrong fd1
>> +  |
>> +  +-- close(fd1)
>> +  |
>> +  +-- fuse_mount_fusermount_sync_init()  [NEW]
>> +  |     +-- socketpair()
>> +  |     +-- spawn fusermount3 --sync-init
>> +  |     +-- fusermount3: open /dev/fuse → fd2, send fd2
>> +  |     +-- receive_fd() → fd2
>> +  |     +-- fusermount3 waits for signal
>> +  |     └─> return fd2, sock
>> +  |
>> +  +-- session_start_sync_init(se, fd2)
>> +  |     +-- ioctl(fd2, FUSE_DEV_IOC_SYNC_INIT)
>> +  |     +-- pthread_create(worker) → ready with fd2
>> +  |
>> +  +-- send_proceed_signal(sock)  [NEW]
>> +  |     +-- send(sock, "\0", 1) → signal fusermount3
>> +  |
>> +  +-- fusermount3: mount() (BLOCKS)
>> +  |     +-- Kernel sends FUSE_INIT to fd2
>> +  |     +-- Worker processes FUSE_INIT
>> +  |     +-- mount() returns
>> +  |
>> +  +-- close(sock)
>> +  |
>> +  +-- session_wait_sync_init_completion(se) → pthread_join
>> +  |
>> +  └─> return fd2
> 
> I'm not sure how useful it is to mention what's inside these functions,
> since one could read the code and I worry that the code will diverge
> very quickly.
> 
>> +
>> diff --git a/doc/README.sync-init b/doc/README.sync-init
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..44e47a2eef2c45026abaa19562537eef37f256b9
>> --- /dev/null
>> +++ b/doc/README.sync-init
>> @@ -0,0 +1,184 @@
>> +FUSE Synchronous vs Asynchronous FUSE_INIT
>> +============================================
>> +
>> +This document explains the difference between asynchronous and synchronous
>> +FUSE_INIT processing, and when each mode is used.
>> +
>> +
>> +Overview
>> +--------
>> +
>> +FUSE_INIT is the initial handshake between the kernel FUSE module and the
>> +userspace filesystem daemon. During this handshake, the kernel and daemon
>> +negotiate capabilities, protocol version, and various feature flags.
>> +
>> +Asynchronous FUSE_INIT (Traditional Behavior)
>> +----------------------------------------------
>> +
>> +In the traditional asynchronous mode:
>> +
>> +1. mount() syscall completes and returns to caller
>> +2. Filesystem appears mounted to the system
>> +3. FUSE daemon starts worker threads
>> +4. Worker threads process FUSE_INIT request
>> +5. Filesystem becomes fully operational
>> +
>> +Timeline:
>> +    mount() -----> returns
>> +                   |
>> +                   v
>> +            FUSE_INIT sent
>> +                   |
>> +                   v
>> +            daemon processes FUSE_INIT
>> +                   |
>> +                   v
>> +            filesystem ready
>> +
>> +Limitations:
>> +
>> +1. **No early requests**: The kernel cannot send requests (like getxattr)
>> +   during the mount() syscall. This breaks SELinux, which needs to query
>> +   extended attributes on the root inode immediately upon mounting.
>> +
>> +2. **Daemonization timing**: With the old fuse_daemonize() API, the daemon
>> +   must call it AFTER mount, because there's no way to report mount failures
>> +   to the parent process if daemonization happens first.
>> +
>> +3. **No custom root inode**: The root inode ID is hardcoded to FUSE_ROOT_ID (1)
>> +   because FUSE_INIT hasn't been processed yet when the mount completes.
>> +
>> +4. **Thread startup after mount**: io_uring threads and other worker threads
>> +   can only start after mount() returns, not before.
>> +
>> +
>> +Synchronous FUSE_INIT (New Behavior)
>> +-------------------------------------
>> +
>> +Kernel support: Linux kernel commit dfb84c330794 (v6.18+)
>> +libfuse support: libfuse 3.19+
>> +
>> +In synchronous mode:
>> +
>> +1. FUSE daemon opens /dev/fuse
>> +2. Daemon calls ioctl(fd, FUSE_DEV_IOC_SYNC_INIT)
>> +3. Daemon starts worker thread
>> +4. Daemon calls mount() syscall
>> +5. Kernel sends FUSE_INIT during mount() - mount() blocks
>> +6. Worker thread processes FUSE_INIT while mount() is blocked
>> +7. Worker thread may process additional requests (getxattr, etc.)
>> +8. mount() syscall completes and returns
>> +9. Filesystem is fully operational
>> +
>> +Timeline:
>> +    open /dev/fuse
>> +         |
>> +         v
>> +    ioctl(FUSE_DEV_IOC_SYNC_INIT)
>> +         |
>> +         v
>> +    start worker thread
>> +         |
>> +         v
>> +    mount() -----> blocks
>> +         |         |
>> +         |         v
>> +         |    FUSE_INIT sent
>> +         |         |
>> +         |         v
>> +         |    worker processes FUSE_INIT
>> +         |         |
>> +         |         v
>> +         |    (possible getxattr, etc.)
>> +         |         |
>> +         +-------> returns
>> +                   |
>> +                   v
>> +            filesystem ready
>> +
>> +Advantages:
>> +
>> +1. **SELinux support**: The kernel can send getxattr requests during mount()
>> +   to query security labels on the root inode.
>> +
>> +2. **Early daemonization**: The daemon can fork BEFORE mount using the new
>> +   fuse_daemonize_start()/signal() API, and report mount failures to the
>> +   parent process.
>> +
>> +3. **Custom root inode**: The daemon can specify a custom root inode ID
>> +   during FUSE_INIT, before mount() completes.
> 
> Where?  Or are you talking about this?
> https://lore.kernel.org/linux-fsdevel/177188735166.3936993.12658858435281080344.stgit@frogsfrogsfrogs/
> 
> but perhaps the root nodeid can be supplied in the reply from the
> synchronous FUSE_INIT?
> 
>> +
>> +4. **Thread startup before mount**: io_uring threads and worker threads
>> +   start before mount(), ensuring they're ready to handle requests.
>> +
>> +5. **Better error reporting**: Mount failures and initialization errors
>> +   can be properly reported to the parent process when using the new
>> +   daemonization API.
>> +
>> +
>> +When Synchronous FUSE_INIT is Used
>> +-----------------------------------
>> +
>> +libfuse automatically enables synchronous FUSE_INIT when:
>> +
>> +1. The application calls fuse_session_want_sync_init(), OR
>> +2. The new daemonization API is used (fuse_daemonize_start() was called)
>> +
>> +Synchronous FUSE_INIT requires:
>> +- Kernel support (commit dfb84c330794 or later)
>> +- Worker thread started before mount()
>> +- ioctl(FUSE_DEV_IOC_SYNC_INIT) succeeds
>> +
>> +If the kernel doesn't support synchronous FUSE_INIT, libfuse automatically
>> +falls back to asynchronous mode.
>> +
>> +
>> +Implementation Details
>> +----------------------
>> +
>> +The synchronous FUSE_INIT implementation uses a worker thread:
>> +
>> +- **session_sync_init_worker()**: Thread function that polls /dev/fuse
>> +  and processes FUSE_INIT and any subsequent requests until mount completes.
>> +
>> +- **session_start_sync_init()**: Creates the worker thread before mount().
>> +  Calls ioctl(FUSE_DEV_IOC_SYNC_INIT) to enable kernel support.
>> +
>> +- **session_wait_sync_init_completion()**: Waits for the worker thread
>> +  to complete after mount() returns. Checks for errors.
>> +
>> +The worker thread processes requests in a loop until se->terminate_mount_worker
>> +is set, which happens after mount() completes successfully.
> 
> Now that I've looked through this more carefully, I think it's all right
> to do this.
> 
>> +
>> +
>> +Compatibility
>> +-------------
>> +
>> +Synchronous FUSE_INIT is fully backward compatible:
>> +
>> +- Old kernels: ioctl returns ENOTTY, libfuse falls back to async mode
>> +- Old applications: Continue to work with async FUSE_INIT
>> +- New applications on old kernels: Graceful fallback to async mode
>> +- New applications on new kernels: Automatic sync mode when appropriate
>> +
>> +
>> +Example: Enabling Synchronous FUSE_INIT
>> +----------------------------------------
>> +
>> +Explicit request:
>> +    struct fuse_session *se = fuse_session_new(...);
>> +    fuse_session_want_sync_init(se);
>> +    fuse_session_mount(se, mountpoint);
>> +
>> +Automatic (with new daemonization API):
>> +    fuse_daemonize_start(0);  // Triggers sync init automatically
>> +    fuse_session_mount(se, mountpoint);
>> +
>> +
>> +See Also
>> +--------
>> +
>> +- doc/README.daemonize - New daemonization API documentation
>> +- doc/README.fusermount - Synchronous FUSE_INIT protocol with fusermount3
>> +- doc/README.mount - Mount implementation details
> 
> Thanks for splitting out the documentation updates.
> 
> --D
> 
>> +
>>
>> -- 
>> 2.43.0
>>
>>

