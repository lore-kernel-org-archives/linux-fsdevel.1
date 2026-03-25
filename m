Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3B3329C57
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 22:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774476213; cv=none; b=FQKk1SiiqAkR8Ix/UXspsA8RbsFnyd9/3cvSANS4DJ3AqtRV2FhwjLDhCb6gJ2MH8stgZo5z3y8YNUUIIQHoHbSUHBCKkpKxqckGmg8UNHF8l/MPMBt+fRWhPJT8O4o1QpNL/CGiMtYltINHZjA/pe5brRib0pOz0yfvx3of9GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774476213; c=relaxed/simple;
	bh=AojvHZuGho6xKqFX+bSm430/P0xFjcmPl6gvLMD3ZDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtMOs5dsb9yTkrOwUeewBQMBAj22ElCKJx63+2qgBj994D4gqIrSf7QwJBs73Fm6HXtZQibxhr7gTGACQsCZT8elJmVieF6n7YddUmxxFCo9W22b9b4zIPdzEiv77YehkfO4/19vlOzZXUI2y0NH8qxkx5stil5Wr/RZE/2rdXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CB+UyMQ4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CB+UyMQ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21CCC4CEF7;
	Wed, 25 Mar 2026 22:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774476213;
	bh=AojvHZuGho6xKqFX+bSm430/P0xFjcmPl6gvLMD3ZDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CB+UyMQ4k9tTZc/5tRGBg2G/5hl6WNtXp79UpsoSLiPBOngDzeB7YSl+AD+LG2jxy
	 ogFmQ4Yqjq7803DEyaM7Era+xBBn/ARLuDE9I9Cu/vEUdkjnlAaW5NEN3JTRImWmC/
	 cLw8f7JrsMsb6aHijepdl9VEFiwfJt74/42qBazpTuqWs1JKOYr2Eo6kX1EV4nq3od
	 qdFs3AQ3pLan5UyCRIsDaR5RSJQFpZ8CR3GEoHSI72oQZ06NtamWGSBCxDqlwGwH+M
	 cbq/U6FypT8Fy3JZYviV+3k+2umWX8FKAtr2Oug6+rVlpCniME7fMQTGq/yvX7KZnG
	 JAgrbRAEbzXFg==
Date: Wed, 25 Mar 2026 15:03:32 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH 17/19] Make fusermount work bidirectional for sync init
Message-ID: <20260325220332.GF6202@frogsfrogsfrogs>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
 <20260323-fuse-init-before-mount-v1-17-a52d3040af69@bsbernd.com>
 <20260324193536.GT6202@frogsfrogsfrogs>
 <6ae9be78-9607-42db-92d1-1650aa5b7aa4@bsbernd.com>
 <20260324225952.GA6202@frogsfrogsfrogs>
 <06495513-d8bb-4e5a-97fb-19a10693db20@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06495513-d8bb-4e5a-97fb-19a10693db20@bsbernd.com>

On Wed, Mar 25, 2026 at 08:48:32PM +0100, Bernd Schubert wrote:
> 
> 
> On 3/24/26 23:59, Darrick J. Wong wrote:
> > On Tue, Mar 24, 2026 at 10:24:04PM +0100, Bernd Schubert wrote:
> >>
> >>
> >> On 3/24/26 20:35, Darrick J. Wong wrote:
> >>> On Mon, Mar 23, 2026 at 06:45:12PM +0100, Bernd Schubert wrote:
> >>>> From: Bernd Schubert <bschubert@ddn.com>
> >>>>
> >>>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> >>>> ---
> >>>>  doc/README.fusermount | 359 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >>>>  util/fusermount.c     | 317 ++++++++++++++++++++++++++++++++++++++++++--
> >>>>  util/meson.build      |   2 +-
> >>>>  3 files changed, 665 insertions(+), 13 deletions(-)
> >>>>
> >>>> diff --git a/doc/README.fusermount b/doc/README.fusermount
> >>>> new file mode 100644
> >>>> index 0000000000000000000000000000000000000000..54a3bac4f58964a4ed312d6f6bc15606fed1e647
> >>>> --- /dev/null
> >>>> +++ b/doc/README.fusermount
> >>>> @@ -0,0 +1,359 @@
> >>>> +Synchronous FUSE_INIT Protocol
> >>>> +================================
> >>>> +
> >>>> +Overview
> >>>> +--------
> >>>> +
> >>>> +The sync-init feature enables the FUSE library to start worker threads and
> >>>> +perform initialization ioctl calls BEFORE the actual mount() syscall happens.
> >>>> +This is required for the kernel's synchronous FUSE_INIT feature, where the
> >>>> +mount() syscall blocks until the FUSE daemon processes the INIT request.
> >>>> +
> >>>> +Without this feature, there would be a deadlock:
> >>>> +- mount() blocks waiting for INIT response
> >>>> +- Worker threads can't start because mount() hasn't returned
> >>>> +- INIT request can't be processed because worker threads aren't running
> >>>> +
> >>>> +
> >>>> +Protocol Flow
> >>>> +-------------
> >>>> +
> >>>> +Traditional mount flow:
> >>>> +  1. Library calls fusermount3
> >>>
> >>> Heh.  I haven't looked much at fusermount until recently.  I gather that
> >>> fuservicemount has somewhat similar goals to fusermount3?  fusermount3
> >>> seems to be a helper subprocess that libfuse can invoke on behalf of an
> >>> unprivileged fuse server.  The helper is responsible for:
> >>>
> >>> 1) opening /dev/fuse
> >>> 2) sending it to the fuse server via the FUSE_COMMFD_ENV fd which is
> >>>    supposed to be an AF_UNIX socket
> >>> 3) calling mount()
> >>> 4) waiting for the parent to die
> >>> 5) maybe calling unmount()
> >>>
> >>> and it's really 1, 3, and 5 that need to be privileged, so that's why
> >>> it's a setuid program.
> >>>
> >>>> +  2. fusermount3 opens /dev/fuse
> >>>> +  3. fusermount3 performs mount() syscall
> >>>> +  4. fusermount3 sends fd to library
> >>>> +  5. Library starts worker threads
> >>>> +  6. Worker threads process FUSE requests
> >>>
> >>> Ah, yes.  Thanks for adding this description!  fuservicemount is I think
> >>> an upside-down version of fusermount -- fuservicemount runs in the
> >>> user's mount namespace, so it
> >>>
> >>> 1) connects to a named AF_UNIX socket to start an instance of the fuse
> >>>    server
> >>> 2) opens /dev/fuse and a memfd to pass cli arguments
> >>> 3) passes those to the fuse server
> >>> 4) the fuse server asks fuservicemount to open resources and pass them
> >>>    over the socket
> >>> 5) the fuse server passes source/type/mount options to fuservicemount
> >>> 6) fuservicemount mounts the fs and exits
> >>> 7) at some point the user unmounts, so the fuse server exits
> >>>
> >>>> +Sync-init mount flow:
> >>>> +  1. Library calls fusermount3 with --sync-init flag
> >>>> +  2. fusermount3 opens /dev/fuse
> >>>> +  3. fusermount3 sends fd to library
> >>>> +  4. Library receives fd
> >>>> +  5. Library performs FUSE_DEV_IOC_SYNC_INIT ioctl
> >>>> +  6. Library starts worker threads
> >>>> +  7. Library sends "proceed" signal to fusermount3
> >>>> +  8. fusermount3 performs mount() syscall (blocks until INIT completes)
> >>>> +  9. Worker threads process INIT request
> >>>> +  10. mount() syscall completes
> >>>> +  11. fusermount3 exits
> >>>> +
> >>>> +
> >>>> +Implementation Details
> >>>> +----------------------
> >>>> +
> >>>> +Bidirectional Communication:
> >>>> +  - Uses the existing unix socket (_FUSE_COMMFD environment variable)
> >>>> +  - Simple 1-byte protocol for signaling
> >>>> +  - Library signals fusermount3 when ready to proceed with mount
> >>>> +
> >>>> +fusermount3 Changes:
> >>>> +  - New --sync-init command-line option
> >>>> +  - Split mount operation into two phases:
> >>>> +    * mount_fuse_prepare(): Opens device, prepares parameters
> >>>> +    * mount_fuse_finish_fsmount(): Performs actual mount() syscall
> >>>> +  - wait_for_signal(): Waits for library to signal readiness
> >>>> +  - struct mount_context: Preserves state between phases
> >>>> +
> >>>> +Library Changes:
> >>>> +  - fuse_session_mount_new_api(): Uses new protocol when available
> >>>> +  - Sends "proceed" signal after worker thread is ready
> >>>> +  - Handles both old and new mount protocols for compatibility
> >>>> +
> >>>> +
> >>>> +Backward Compatibility
> >>>> +----------------------
> >>>> +
> >>>> +The implementation maintains full backward compatibility:
> >>>> +  - Old library + new fusermount3: Works (uses traditional flow)
> >>>> +  - New library + old fusermount3: Falls back to traditional flow
> >>>> +  - New library + new fusermount3: Uses sync-init flow when appropriate
> >>>> +
> >>>> +
> >>>> +Error Handling
> >>>> +--------------
> >>>> +
> >>>> +If any step fails during the sync-init flow:
> >>>> +  - fusermount3 closes the fd and exits with error
> >>>> +  - Library detects failure and cleans up
> >>>> +  - No mount is left in inconsistent state
> >>>> +
> >>>> +Connection closure:
> >>>> +  - If library closes socket before signaling, fusermount3 detects and exits
> >>>> +  - If fusermount3 crashes, library detects closed socket
> >>>> +
> >>>> +
> >>>> +Security Considerations
> >>>> +-----------------------
> >>>> +
> >>>> +The sync-init protocol does not introduce new security concerns:
> >>>> +  - Uses the same privilege separation as traditional mount
> >>>> +  - Socket communication is already established and trusted
> >>>> +  - No new privileged operations are added
> >>>> +  - File descriptor passing uses existing SCM_RIGHTS mechanism
> >>>> +
> >>>> +
> >>>> +Performance Impact
> >>>> +------------------
> >>>> +
> >>>> +Minimal performance impact:
> >>>> +  - One additional recv() call in fusermount3
> >>>> +  - One additional send() call in library
> >>>> +  - Total overhead: ~2 context switches
> >>>> +  - Only affects mount time, not runtime performance
> >>>> +
> >>>> +
> >>>> +Future Enhancements
> >>>> +-------------------
> >>>> +
> >>>> +Potential improvements:
> >>>> +  - Extended protocol for more complex initialization sequences
> >>>> +  - Support for multiple worker threads coordination
> >>>> +  - Enhanced error reporting through the socket
> >>>> +  - Timeout mechanisms for detecting hung initialization
> >>>> +
> >>>> +
> >>>> +ASCII Workflow Diagrams
> >>>> +========================
> >>>> +
> >>>> +1. Traditional Mount Flow (without --sync-init, async INIT)
> >>>> +------------------------------------------------------------
> >>>> +
> >>>> +Library                   fusermount3              Kernel
> >>>> +   |                           |                      |
> >>>> +   |--- spawn fusermount3 ---->|                      |
> >>>> +   |                           |                      |
> >>>> +   |                      [open /dev/fuse]            |
> >>>> +   |                           |------- open -------->|
> >>>> +   |                           |<------ fd ---------- |
> >>>> +   |                           |                      |
> >>>> +   |                      [mount() syscall]           |
> >>>> +   |                           |------ mount -------->|
> >>>> +   |                           |<----- success ------ | [mount returns immediately]
> >>>> +   |                           |                      | [INIT queued in kernel]
> >>>> +   |                      [send_fd(fd)]               |
> >>>> +   |<------- fd --------------|                      |
> >>>> +   |                           |                      |
> >>>> +   |                      [fusermount3 exits]         |
> >>>> +   |                                                  |
> >>>> +   |  [start worker thread]                          |
> >>>> +   |  [worker reads /dev/fuse]                       |
> >>>> +   |---------------------------------------- read -->|
> >>>> +   |<--------------------------------------- INIT ---| [dequeued from kernel]
> >>>> +   |                                                  |
> >>>> +   | OK: INIT was queued, worker reads it later      |
> >>>> +   |     Works fine for async INIT                   |
> >>>
> >>> Hmm, looking at this, perhaps it /is/ possible for fuservicemount to
> >>> employ synchronous init.  The fuse server would start that background
> >>> init-only request handler thread before telling fuservicemount to call
> >>> mount().  That blocks while the kernel sends FUSE_INIT to the fuse
> >>> server, it processes everything up to the init request, and returns.
> >>>
> >>>> +
> >>>> +
> >>>> +1b. Problem: Synchronous INIT without --sync-init
> >>>> +--------------------------------------------------
> >>>> +
> >>>> +Library                   fusermount3              Kernel
> >>>> +   |                           |                      |
> >>>> +   |--- spawn fusermount3 ---->|                      |
> >>>> +   |                           |                      |
> >>>> +   |                      [open /dev/fuse]            |
> >>>> +   |                           |------- open -------->|
> >>>> +   |                           |<------ fd ---------- |
> >>>> +   |                           |                      |
> >>>> +   |                      [mount() syscall]           |
> >>>> +   |                           |------ mount -------->|
> >>>> +   |                           |                      | [mount BLOCKS waiting for INIT]
> >>>> +   |                           | (BLOCKED)            | [needs worker to process INIT]
> >>>> +   |                           |                      |
> >>>> +   |  [waiting for fd...]      |                      |
> >>>> +   |                           |                      |
> >>>> +   |                           |                      |
> >>>> +   | DEADLOCK: mount() waits for INIT response       |
> >>>> +   |           but worker thread not started yet     |
> >>>> +   |           because we're waiting for fd          |
> >>>> +
> >>>> +
> >>>> +2. Sync-Init Mount Flow (with --sync-init)
> >>>> +-------------------------------------------
> >>>> +
> >>>> +Library                   fusermount3              Kernel
> >>>> +   |                           |                      |
> >>>> +   |--- spawn fusermount3 ---->|                      |
> >>>> +   |    with --sync-init       |                      |
> >>>> +   |                           |                      |
> >>>> +   |                      [open /dev/fuse]            |
> >>>> +   |                           |------- open -------->|
> >>>> +   |                           |<------ fd ---------- |
> >>>> +   |                           |                      |
> >>>> +   |                      [send_fd(fd)]               |
> >>>> +   |<------- fd --------------|                      |
> >>>> +   |                           |                      |
> >>>> +   |                      [wait_for_signal()]         |
> >>>> +   |                           | (BLOCKED)            |
> >>>> +   |                           |                      |
> >>>> +   |  [ioctl SYNC_INIT]        |                      |
> >>>> +   |---------------------------------------- ioctl -->|
> >>>> +   |                                                  |
> >>>> +   |  [start worker thread]                          |
> >>>> +   |  [worker ready]                                 |
> >>>> +   |                           |                      |
> >>>> +   |--- "proceed" signal ----->|                      |
> >>>> +   |                      [signal received]           |
> >>>> +   |                           |                      |
> >>>> +   |                      [mount() syscall]           |
> >>>> +   |                           |------ mount -------->|
> >>>> +   |                           |                      | [mount blocks]
> >>>> +   |                           |                      | [sends INIT]
> >>>> +   |<------------------------------------------------ |
> >>>> +   |                           |                      |
> >>>> +   | [worker processes INIT]   |                      |
> >>>> +   |------------------------------------------------->|
> >>>> +   |                           |                      | [mount unblocks]
> >>>> +   |                           |<----- success ------ |
> >>>> +   |                           |                      |
> >>>> +   |                      [fusermount3 exits]         |
> >>>> +   |                                                  |
> >>>> +   | SUCCESS: Worker ready before mount()            |
> >>>> +   |          INIT processed synchronously           |
> >>>> +
> >>>> +
> >>>> +3. Error Scenario: Library Crashes Before Signaling
> >>>> +----------------------------------------------------
> >>>> +
> >>>> +Library                   fusermount3              Kernel
> >>>> +   |                           |                      |
> >>>> +   |--- spawn fusermount3 ---->|                      |
> >>>> +   |    with --sync-init       |                      |
> >>>> +   |                           |                      |
> >>>> +   |                      [open /dev/fuse]            |
> >>>> +   |                           |------- open -------->|
> >>>> +   |                           |<------ fd ---------- |
> >>>> +   |                           |                      |
> >>>> +   |                      [send_fd(fd)]               |
> >>>> +   |<------- fd --------------|                      |
> >>>> +   |                           |                      |
> >>>> +   |                      [wait_for_signal()]         |
> >>>> +   |                           | (BLOCKED)            |
> >>>> +   |                           |                      |
> >>>> +   X  [library crashes]        |                      |
> >>>> +   |                           |                      |
> >>>> +   |                      [recv() returns 0]          |
> >>>> +   |                      [socket closed]             |
> >>>> +   |                           |                      |
> >>>> +   |                      [cleanup and exit]          |
> >>>> +   |                           X                      |
> >>>> +   |                                                  |
> >>>> +   | RESULT: Clean failure, no mount performed       |
> >>>> +
> >>>> +
> >>>> +4. Detailed Function Call Flow
> >>>> +-------------------------------
> >>>> +
> >>>> +Library (lib/fuse_lowlevel.c):
> >>>> +fuse_session_mount_new_api()
> >>>> +   |
> >>>> +   +-- fuse_kern_mount_prepare()  [lib/mount.c]
> >>>> +   |      |
> >>>> +   |      +-- fuse_mount_fusermount()  [lib/mount_util.c]
> >>>> +   |             |
> >>>> +   |             +-- socketpair()  [create comm socket]
> >>>> +   |             |
> >>>> +   |             +-- fork()
> >>>> +   |             |
> >>>> +   |             +-- [child] execl("fusermount3", "--sync-init", ...)
> >>>> +   |             |
> >>>> +   |             +-- [parent] receive_fd()  <--- BLOCKS until fd arrives
> >>>> +   |                    |
> >>>> +   |                    +-- recvmsg(SCM_RIGHTS)
> >>>> +   |                    |
> >>>> +   |                    +-- return fd
> >>>> +   |
> >>>> +   +-- session_start_sync_init()  [lib/fuse_lowlevel.c]
> >>>> +   |      |
> >>>> +   |      +-- ioctl(fd, FUSE_DEV_IOC_SYNC_INIT)
> >>>> +   |      |
> >>>> +   |      +-- pthread_create(worker_thread)
> >>>> +   |      |
> >>>> +   |      +-- return
> >>>> +   |
> >>>> +   +-- fuse_fusermount_proceed_mnt(socket)  [lib/mount.c] <--- NEW: Bidirectional handshake
> >>>> +          |
> >>>> +          +-- send(socket, "proceed", 1)  <--- Signal fusermount3 to proceed
> >>>> +          |
> >>>> +          +-- recv(socket, &status, 1)  <--- BLOCKS until mount result arrives
> >>>> +          |      |
> >>>> +          |      +-- [fusermount3 performs mount and sends status byte]
> >>>> +          |
> >>>> +          +-- if (status != 0) return -1  <--- Mount failed
> >>>> +          |
> >>>> +          +-- return 0  <--- Mount succeeded
> >>>> +
> >>>> +
> >>>> +Utility (util/fusermount.c):
> >>>> +fusermount3 main() with --sync-init
> >>>> +   |
> >>>> +   +-- mount_fuse_sync_init()  [util/fusermount.c]
> >>>> +          |
> >>>> +          +-- mount_fuse_prepare()  [util/fusermount.c]
> >>>> +          |      |
> >>>> +          |      +-- open("/dev/fuse")
> >>>> +          |      |
> >>>> +          |      +-- check_perm()  [util/fusermount.c]
> >>>> +          |      |
> >>>> +          |      +-- return fd
> >>>> +          |
> >>>> +          +-- send_fd(socket, fd)  [util/fusermount.c]
> >>>> +          |      |
> >>>> +          |      +-- sendmsg(SCM_RIGHTS)
> >>>> +          |
> >>>> +          +-- wait_for_signal(socket)  [util/fusermount.c] <--- BLOCKS until library signals
> >>>> +          |      |
> >>>> +          |      +-- recv(socket, buf, 1)
> >>>> +          |      |
> >>>> +          |      +-- return 0
> >>>> +          |
> >>>> +          +-- mount_fuse_finish_fsmount()  [util/fusermount.c]
> >>>> +          |      |
> >>>> +          |      +-- fuse_kern_fsmount()  [lib/mount_fsmount.c]
> >>>> +          |      |      |
> >>>> +          |      |      +-- fsopen("fuse", FSOPEN_CLOEXEC)
> >>>> +          |      |      |      |
> >>>> +          |      |      |      +-- [kernel creates filesystem context]
> >>>> +          |      |      |
> >>>> +          |      |      +-- fsconfig(fsfd, SET_STRING, "source", ...)
> >>>> +          |      |      +-- fsconfig(fsfd, SET_STRING, "fd", fd_value, ...)
> >>>> +          |      |      +-- fsconfig(fsfd, ...) [apply mount options]
> >>>> +          |      |      +-- fsconfig(fsfd, CMD_CREATE, ...)
> >>>> +          |      |      |
> >>>> +          |      |      +-- fsmount(fsfd, FSMOUNT_CLOEXEC, mount_attrs)
> >>>> +          |      |      |      |
> >>>> +          |      |      |      +-- [kernel sends FUSE_INIT here]
> >>>> +          |      |      |      |
> >>>> +          |      |      |      +-- [worker thread processes INIT]
> >>>> +          |      |      |      |
> >>>> +          |      |      |      +-- [fsmount returns mntfd]
> >>>> +          |      |      |
> >>>> +          |      |      +-- move_mount(mntfd, "", AT_FDCWD, target, ...)
> >>>> +          |      |      |      |
> >>>> +          |      |      |      +-- [attach mount to target directory]
> >>>> +          |      |      |      |
> >>>> +          |      |      |      +-- [no blocking - INIT already processed]
> >>>> +          |      |      |
> >>>> +          |      |      +-- add_mount()  [lib/mount_fsmount.c - update /etc/mtab]
> >>>> +          |      |      |
> >>>> +          |      |      +-- return 0 on success, -1 on failure
> >>>> +          |      |
> >>>> +          |      +-- if mount failed: return -1
> >>>> +          |      +-- if mount succeeded: continue
> >>>> +          |
> >>>> +          +-- send_status_byte(socket)  [util/fusermount.c] <--- NEW: Send result to library
> >>>> +          |      |
> >>>> +          |      +-- status = (mount_result == 0) ? 0 : 1
> >>>> +          |      +-- send(socket, &status, 1)
> >>>> +          |      |
> >>>> +          |      +-- return
> >>>> +          |
> >>>> +          +-- return 0
> >>>> +
> >>>> +
> >>>> +Note: The new mount API (fsopen/fsconfig/fsmount/move_mount) is REQUIRED
> >>>> +      for sync-init because fsmount() triggers FUSE_INIT before the mount
> >>>> +      is attached. This allows the worker thread to process INIT before
> >>>> +      move_mount() completes, preventing deadlock.
> >>>
> >>> ...and so we don't expose the directory tree to the mountns until we
> >>> know that FUSE_INIT didn't crash the server.
> >>
> >> Added that as well.
> >>
> >>>
> >>>> diff --git a/util/fusermount.c b/util/fusermount.c
> >>>> index 80b42a594e89cdc2f43824f5e274892522fd8cce..808b4afd89ceb49273c944d43bffe5033e27549b 100644
> >>>> --- a/util/fusermount.c
> >>>> +++ b/util/fusermount.c
> >>>> @@ -957,6 +957,7 @@ static void free_mount_params(struct mount_params *mp)
> >>>>  	free(mp->source);
> >>>>  	free(mp->type);
> >>>>  	free(mp->mnt_opts);
> >>>> +	memset(mp, 0, sizeof(*mp));
> >>>>  }
> >>>>  
> >>>>  /*
> >>>> @@ -1378,6 +1379,179 @@ static int open_fuse_device(const char *dev)
> >>>>  	return fd;
> >>>>  }
> >>>>  
> >>>> +#ifdef HAVE_NEW_MOUNT_API
> >>>> +/* Forward declaration from lib/mount_fsmount.c */
> >>>> +int fuse_kern_fsmount(const char *mnt, unsigned long flags, int blkdev,
> >>>> +		      const char *fsname, const char *subtype,
> >>>> +		      const char *source_dev, const char *kernel_opts,
> >>>> +		      const char *mnt_opts);
> >>>> +#endif
> >>>
> >>> Shouldn't this be included from a header file somewhere?
> >>
> >> Fixed, included from mount_i_linux.h
> >>
> >>>
> >>>> +
> >>>> +/*
> >>>> + * Context for split mount operation (sync-init mode)
> >>>> + */
> >>>> +struct mount_context {
> >>>> +	int fd;
> >>>> +	const char *dev;
> >>>> +	struct stat stbuf;
> >>>> +	char *source;
> >>>> +	char *mnt_opts;
> >>>> +	char *x_opts;
> >>>> +	const char *type;
> >>>> +};
> >>>> +
> >>>> +/*
> >>>> + * Phase 1: Open device and prepare for mount (sync-init mode)
> >>>> + * Returns fd on success, -1 on failure
> >>>> + */
> >>>> +static int mount_fuse_prepare(const char *mnt, const char *opts,
> >>>> +			      struct mount_context *ctx)
> >>>> +{
> >>>> +	int res;
> >>>> +	int mountpoint_fd = -1;
> >>>> +	char *do_mount_opts = NULL;
> >>>> +	const char *real_mnt = mnt;
> >>>> +
> >>>> +	memset(ctx, 0, sizeof(*ctx));
> >>>> +	ctx->dev = getenv(FUSE_KERN_DEVICE_ENV) ?: FUSE_DEV;
> >>>> +
> >>>> +	ctx->fd = open_fuse_device(ctx->dev);
> >>>> +	if (ctx->fd == -1)
> >>>> +		return -1;
> >>>> +
> >>>> +	drop_privs();
> >>>> +	read_conf();
> >>>> +
> >>>> +	if (getuid() != 0 && mount_max != -1) {
> >>>> +		int mount_count = count_fuse_fs();
> >>>> +
> >>>> +		if (mount_count >= mount_max) {
> >>>> +			fprintf(stderr,
> >>>> +				"%s: too many FUSE filesystems mounted; mount_max=N can be set in %s\n",
> >>>> +				progname, FUSE_CONF);
> >>>> +			goto fail_close_fd;
> >>>> +		}
> >>>> +	}
> >>>
> >>> /me notes that he's refactored this configuration file related function
> >>> into fuser_conf.c though that's in the fuse-services v4 that I'll send
> >>> you soon.
> >>>
> >>>> +
> >>>> +	res = extract_x_options(opts, &do_mount_opts, &ctx->x_opts);
> >>>> +	if (res)
> >>>> +		goto fail_close_fd;
> >>>> +
> >>>> +	res = check_perm(&real_mnt, &ctx->stbuf, &mountpoint_fd);
> >>>> +	restore_privs();
> >>>> +
> >>>> +	if (mountpoint_fd != -1)
> >>>> +		close(mountpoint_fd);
> >>>> +
> >>>> +	if (res == -1)
> >>>> +		goto fail_close_fd;
> >>>> +
> >>>> +	free(do_mount_opts);
> >>>> +	return ctx->fd;
> >>>> +
> >>>> +fail_close_fd:
> >>>> +	close(ctx->fd);
> >>>> +	free(do_mount_opts);
> >>>> +	free(ctx->x_opts);
> >>>> +	ctx->fd = -1;
> >>>> +	return -1;
> >>>> +}
> >>>> +
> >>>> +#ifdef HAVE_NEW_MOUNT_API
> >>>> +/*
> >>>> + * Phase 2: Perform the actual mount using new mount API (sync-init mode)
> >>>> + * Returns 0 on success, -1 on failure
> >>>> + */
> >>>> +static int mount_fuse_finish_fsmount(const char *mnt, const char *opts,
> >>>> +				     struct mount_context *ctx,
> >>>> +				     const char **type)
> >>>> +{
> >>>> +	int res;
> >>>> +	char *do_mount_opts = NULL;
> >>>> +	char *x_prefixed_opts = NULL;
> >>>> +	struct mount_params mp = { .fd = ctx->fd };
> >>>> +	char *final_mnt_opts = NULL;
> >>>> +
> >>>> +	/* Extract x-options */
> >>>> +	res = extract_x_options(opts, &do_mount_opts, &x_prefixed_opts);
> >>>> +	if (res)
> >>>> +		goto fail;
> >>>> +
> >>>> +	/* Prepare mount parameters */
> >>>> +	mp.rootmode = ctx->stbuf.st_mode & S_IFMT;
> >>>> +	mp.dev = ctx->dev;
> >>>
> >>> I think those could be set in the mp variable definition?
> >>
> >> Absolutely.
> >>
> >>>
> >>>> +
> >>>> +	res = prepare_mount(do_mount_opts, &mp);
> >>>> +	if (res == -1)
> >>>> +		goto fail;
> >>>> +
> >>>> +	/* Merge x-options if running as root */
> >>>> +	final_mnt_opts = mp.mnt_opts;
> >>>> +	if (geteuid() == 0 && ctx->x_opts && strlen(ctx->x_opts) > 0) {
> >>>> +		size_t mnt_opts_len = strlen(mp.mnt_opts);
> >>>> +		size_t x_mnt_opts_len = mnt_opts_len + strlen(ctx->x_opts) + 2;
> >>>> +		char *x_mnt_opts = calloc(1, x_mnt_opts_len);
> >>>> +
> >>>> +		if (!x_mnt_opts)
> >>>> +			goto fail_free_params;
> >>>> +
> >>>> +		if (mnt_opts_len) {
> >>>> +			strcpy(x_mnt_opts, mp.mnt_opts);
> >>>> +			strncat(x_mnt_opts, ",", 2);
> >>>> +		}
> >>>> +		strncat(x_mnt_opts, ctx->x_opts,
> >>>> +			x_mnt_opts_len - mnt_opts_len - 2);
> >>>> +
> >>>> +		final_mnt_opts = x_mnt_opts;
> >>>> +	}
> >>>
> >>> Curious, I thought the x- options were edited out by /sbin/mount so fuse
> >>> would never see them?  Does the x- option handling in fusermount.c exist
> >>> to handle the case where someone passes them directly to the fuse
> >>> server, aka
> >>>
> >>> $ sshfs <whatever> /mnt -o x-systemd-hahaha=1
> >>>
> >>> and now you need to ensure that x-systemd-hahaha doesn't get sent to the
> >>> kernel but does get seen by the fuse server?
> >>
> >> https://github.com/libfuse/libfuse/issues/651
> >>
> >> So specially added as mount option to to go into mtab/utab and to
> >> suppress some 3rd party (gnome) actions.
> > 
> > Huh, I wouldn't have thought that would work since /etc/mtab has been
> > a symlink to /proc/self/mounts for a while now.  Of course GNOME
> > abstracts mount options behind some g_unix_mount_entry_get_options
> > function call which ... doesn't document where it gets its mount options
> > from.
> 
> Problem is that these don't go into /proc/self/mounts at all, but into
> /run/mount/utab with recent mount utils. With /etc/mtab not being a
> symlink it would have worked as well.
> 
> bernd@e7270 ~>cat /run/mount/utab
> SRC=/dev/loop0 TARGET=/snap/chromium/3375 ROOT=/ OPTS=x-gdu.hide,x-gvfs-hide
> SRC=/dev/loop1 TARGET=/snap/bare/5 ROOT=/ OPTS=x-gdu.hide,x-gvfs-hide
> SRC=/dev/loop2 TARGET=/snap/chromium/3390 ROOT=/ OPTS=x-gdu.hide,x-gvfs-hide
> ...

Ahah, I didn't realize that util-linux is actually still updating mount
table flat files, at least if you feed it magic x- options.  Apparently
mount.nfs does too.

/me updates the mountservice branch to call fuse_mnt_add_mount() so that
this continues to work.  Thanks for cluing me into that!

--D
