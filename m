Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F282E5B21
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 21:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774387450; cv=none; b=EOGr3WQtMfHWpfL6xk6OCe1cQ70ZN+dTplTwogUA6+CzUnWL9RLvL1Rt62pKxDsftIjyTFSvcv/34Uw7nFG6dzdbSwQSk4K0Hbp+02U8AabO6Wx2W9dRNVk6JACrgTQQk5r/r+p82Zd96Eiw1lxq5o2NAwzQUOWSxseSTFGHEbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774387450; c=relaxed/simple;
	bh=uWGtgKptn1MxCPVM46Ymc+VAC41cLsMeEVtf5QvZYFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CnouwA0LD9OH3GNU0TLuS6Il3Wq/WHq0rlRctYyQ5IUUEoOBJTYkUsUkkNCoFZHfR97AuVZhpL43IyNTtYy9c+i6itSv2lT57MnAzA6l2qBtoC5oG4GQszlqdLRnyHVTFCLrozQ4GcuczJm/NumY579vPS/eWlALm/O+PnWeaOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=LBlvNQI+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j+Bnwv62; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="LBlvNQI+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j+Bnwv62"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D387BEC01E3;
	Tue, 24 Mar 2026 17:24:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 24 Mar 2026 17:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774387446;
	 x=1774473846; bh=/3Ef14mLGbY6i4cepXA0QQkM+t2Hz9kqxFQOP7XjA/Q=; b=
	LBlvNQI+cDfG6oaa80knpy1EHGdBm5vVO1O4XNPgMNH44iQ7sTTe6Urk9aa0/agv
	ZJPJ4UD4KrNTlxnQ+2nxJvhKozn2bO87uD0py2yQMC2/9t307DHmpseH5WhnrLgb
	UnI2h8W0PO+Py4W4RPDka6uvXS7OS4Stl/CnXQCAu9U7PrNI/wI6dx321acmKLAy
	Ub3Df3KhCwA71vGXqB6vcYFD4efCOl23vg6yphMOcessYujVW447fe93xf/fMxQO
	qVl2HE9G5iNUIOKxqLwesfHAcjdQNv90Gc3LtK7rX4HaaA/zhoeQQPL8yBTVYGRu
	Se7CvHXbBJ70RBTv0+pOkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774387446; x=
	1774473846; bh=/3Ef14mLGbY6i4cepXA0QQkM+t2Hz9kqxFQOP7XjA/Q=; b=j
	+Bnwv62FH5h8znGaFcdu1bMEAMeB2eTqK1PXLB6dTJQEp0MokrfUQXUq3BhEJNEy
	+sYHywDuQMYPSKSqKtsOQmRBbllRECvn0pV8Rzrg8OUlyAN7qhC/gR4Yr8PNfBAI
	/siKth+ApNEtoAK5tDqT7gTF/hX5+lFjR6vJ6xi678eeZYbDwNjvZgmXRjG8HN5O
	RKeCMD3pNjBIFG5pglrQU4RrfXdM41/nrC+AVim8E0dWfqJ1uKeU3l1myjKrbBb2
	VRaBazcXdfWgUfvSGD/EyFbC8eqQzPa1PRCDcd59oBxb6zoNCFIlOXc1Gw6RlZmJ
	awRFijlrEhHRgz7sTwwfQ==
X-ME-Sender: <xms:9gDDaV7FCDIIKONPhs-wHIZi7djc-ScUGEt35sPJxBUDdeJAAEm2UQ>
    <xme:9gDDaZxj48BhNQ-2BmKPfNP4pJcMFowqkxjsDs0cllGDJQdWPfC8nmc2ejA2VFTV1
    JOp6wddA-iglswHHP9xa5lcoLbnCQGmVxaX6TJ6lERGZXgacPSa>
X-ME-Received: <xmr:9gDDaUwkMitIeBhrRzxSOD5uy5mZkhLHnX4LIMXhrArUfz-01ZHIPa2TtMgTuE4jtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddvieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeeugfevvdeggeeutdelgffgiefgffejheffkedtieduffehledvfeevgeej
    hedtjeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugessghssggvrhhnugdrtgho
    mhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepug
    hjfihonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghv
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhikhhlohhssehsii
    gvrhgvughirdhhuhdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdr
    tghomhdprhgtphhtthhopegsshgthhhusggvrhhtseguughnrdgtohhm
X-ME-Proxy: <xmx:9gDDaZzmplRRQipbDIhD0DM8MpVLjTT8mH0Iuw5Snb-vBpcXI_SzPw>
    <xmx:9gDDaWYVJhPpMfHyzqrrSyX0MZkKCtq3RlBl9-NuchDl6nU8UZN9_Q>
    <xmx:9gDDaSUadZCtK0On4jBWgDOGplAISKJIfOCFtcwsgF-i5dUwL08LzA>
    <xmx:9gDDacinrj26CTtxFdQegI3Vvf8_32daUz658_Xe3z1mJviBon-4UQ>
    <xmx:9gDDaejTlUH3PsQqqk_D2Wt0u-kDX3KQ8gOV2fBNEarqybut-nHuRrs1>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 17:24:05 -0400 (EDT)
Message-ID: <6ae9be78-9607-42db-92d1-1650aa5b7aa4@bsbernd.com>
Date: Tue, 24 Mar 2026 22:24:04 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/19] Make fusermount work bidirectional for sync init
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bschubert@ddn.com>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
 <20260323-fuse-init-before-mount-v1-17-a52d3040af69@bsbernd.com>
 <20260324193536.GT6202@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US
In-Reply-To: <20260324193536.GT6202@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/24/26 20:35, Darrick J. Wong wrote:
> On Mon, Mar 23, 2026 at 06:45:12PM +0100, Bernd Schubert wrote:
>> From: Bernd Schubert <bschubert@ddn.com>
>>
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>> ---
>>  doc/README.fusermount | 359 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  util/fusermount.c     | 317 ++++++++++++++++++++++++++++++++++++++++++--
>>  util/meson.build      |   2 +-
>>  3 files changed, 665 insertions(+), 13 deletions(-)
>>
>> diff --git a/doc/README.fusermount b/doc/README.fusermount
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..54a3bac4f58964a4ed312d6f6bc15606fed1e647
>> --- /dev/null
>> +++ b/doc/README.fusermount
>> @@ -0,0 +1,359 @@
>> +Synchronous FUSE_INIT Protocol
>> +================================
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
> 
> Heh.  I haven't looked much at fusermount until recently.  I gather that
> fuservicemount has somewhat similar goals to fusermount3?  fusermount3
> seems to be a helper subprocess that libfuse can invoke on behalf of an
> unprivileged fuse server.  The helper is responsible for:
> 
> 1) opening /dev/fuse
> 2) sending it to the fuse server via the FUSE_COMMFD_ENV fd which is
>    supposed to be an AF_UNIX socket
> 3) calling mount()
> 4) waiting for the parent to die
> 5) maybe calling unmount()
> 
> and it's really 1, 3, and 5 that need to be privileged, so that's why
> it's a setuid program.
> 
>> +  2. fusermount3 opens /dev/fuse
>> +  3. fusermount3 performs mount() syscall
>> +  4. fusermount3 sends fd to library
>> +  5. Library starts worker threads
>> +  6. Worker threads process FUSE requests
> 
> Ah, yes.  Thanks for adding this description!  fuservicemount is I think
> an upside-down version of fusermount -- fuservicemount runs in the
> user's mount namespace, so it
> 
> 1) connects to a named AF_UNIX socket to start an instance of the fuse
>    server
> 2) opens /dev/fuse and a memfd to pass cli arguments
> 3) passes those to the fuse server
> 4) the fuse server asks fuservicemount to open resources and pass them
>    over the socket
> 5) the fuse server passes source/type/mount options to fuservicemount
> 6) fuservicemount mounts the fs and exits
> 7) at some point the user unmounts, so the fuse server exits
> 
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
> 
> Hmm, looking at this, perhaps it /is/ possible for fuservicemount to
> employ synchronous init.  The fuse server would start that background
> init-only request handler thread before telling fuservicemount to call
> mount().  That blocks while the kernel sends FUSE_INIT to the fuse
> server, it processes everything up to the init request, and returns.
> 
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
> 
> ...and so we don't expose the directory tree to the mountns until we
> know that FUSE_INIT didn't crash the server.

Added that as well.

> 
>> diff --git a/util/fusermount.c b/util/fusermount.c
>> index 80b42a594e89cdc2f43824f5e274892522fd8cce..808b4afd89ceb49273c944d43bffe5033e27549b 100644
>> --- a/util/fusermount.c
>> +++ b/util/fusermount.c
>> @@ -957,6 +957,7 @@ static void free_mount_params(struct mount_params *mp)
>>  	free(mp->source);
>>  	free(mp->type);
>>  	free(mp->mnt_opts);
>> +	memset(mp, 0, sizeof(*mp));
>>  }
>>  
>>  /*
>> @@ -1378,6 +1379,179 @@ static int open_fuse_device(const char *dev)
>>  	return fd;
>>  }
>>  
>> +#ifdef HAVE_NEW_MOUNT_API
>> +/* Forward declaration from lib/mount_fsmount.c */
>> +int fuse_kern_fsmount(const char *mnt, unsigned long flags, int blkdev,
>> +		      const char *fsname, const char *subtype,
>> +		      const char *source_dev, const char *kernel_opts,
>> +		      const char *mnt_opts);
>> +#endif
> 
> Shouldn't this be included from a header file somewhere?

Fixed, included from mount_i_linux.h

> 
>> +
>> +/*
>> + * Context for split mount operation (sync-init mode)
>> + */
>> +struct mount_context {
>> +	int fd;
>> +	const char *dev;
>> +	struct stat stbuf;
>> +	char *source;
>> +	char *mnt_opts;
>> +	char *x_opts;
>> +	const char *type;
>> +};
>> +
>> +/*
>> + * Phase 1: Open device and prepare for mount (sync-init mode)
>> + * Returns fd on success, -1 on failure
>> + */
>> +static int mount_fuse_prepare(const char *mnt, const char *opts,
>> +			      struct mount_context *ctx)
>> +{
>> +	int res;
>> +	int mountpoint_fd = -1;
>> +	char *do_mount_opts = NULL;
>> +	const char *real_mnt = mnt;
>> +
>> +	memset(ctx, 0, sizeof(*ctx));
>> +	ctx->dev = getenv(FUSE_KERN_DEVICE_ENV) ?: FUSE_DEV;
>> +
>> +	ctx->fd = open_fuse_device(ctx->dev);
>> +	if (ctx->fd == -1)
>> +		return -1;
>> +
>> +	drop_privs();
>> +	read_conf();
>> +
>> +	if (getuid() != 0 && mount_max != -1) {
>> +		int mount_count = count_fuse_fs();
>> +
>> +		if (mount_count >= mount_max) {
>> +			fprintf(stderr,
>> +				"%s: too many FUSE filesystems mounted; mount_max=N can be set in %s\n",
>> +				progname, FUSE_CONF);
>> +			goto fail_close_fd;
>> +		}
>> +	}
> 
> /me notes that he's refactored this configuration file related function
> into fuser_conf.c though that's in the fuse-services v4 that I'll send
> you soon.
> 
>> +
>> +	res = extract_x_options(opts, &do_mount_opts, &ctx->x_opts);
>> +	if (res)
>> +		goto fail_close_fd;
>> +
>> +	res = check_perm(&real_mnt, &ctx->stbuf, &mountpoint_fd);
>> +	restore_privs();
>> +
>> +	if (mountpoint_fd != -1)
>> +		close(mountpoint_fd);
>> +
>> +	if (res == -1)
>> +		goto fail_close_fd;
>> +
>> +	free(do_mount_opts);
>> +	return ctx->fd;
>> +
>> +fail_close_fd:
>> +	close(ctx->fd);
>> +	free(do_mount_opts);
>> +	free(ctx->x_opts);
>> +	ctx->fd = -1;
>> +	return -1;
>> +}
>> +
>> +#ifdef HAVE_NEW_MOUNT_API
>> +/*
>> + * Phase 2: Perform the actual mount using new mount API (sync-init mode)
>> + * Returns 0 on success, -1 on failure
>> + */
>> +static int mount_fuse_finish_fsmount(const char *mnt, const char *opts,
>> +				     struct mount_context *ctx,
>> +				     const char **type)
>> +{
>> +	int res;
>> +	char *do_mount_opts = NULL;
>> +	char *x_prefixed_opts = NULL;
>> +	struct mount_params mp = { .fd = ctx->fd };
>> +	char *final_mnt_opts = NULL;
>> +
>> +	/* Extract x-options */
>> +	res = extract_x_options(opts, &do_mount_opts, &x_prefixed_opts);
>> +	if (res)
>> +		goto fail;
>> +
>> +	/* Prepare mount parameters */
>> +	mp.rootmode = ctx->stbuf.st_mode & S_IFMT;
>> +	mp.dev = ctx->dev;
> 
> I think those could be set in the mp variable definition?

Absolutely.

> 
>> +
>> +	res = prepare_mount(do_mount_opts, &mp);
>> +	if (res == -1)
>> +		goto fail;
>> +
>> +	/* Merge x-options if running as root */
>> +	final_mnt_opts = mp.mnt_opts;
>> +	if (geteuid() == 0 && ctx->x_opts && strlen(ctx->x_opts) > 0) {
>> +		size_t mnt_opts_len = strlen(mp.mnt_opts);
>> +		size_t x_mnt_opts_len = mnt_opts_len + strlen(ctx->x_opts) + 2;
>> +		char *x_mnt_opts = calloc(1, x_mnt_opts_len);
>> +
>> +		if (!x_mnt_opts)
>> +			goto fail_free_params;
>> +
>> +		if (mnt_opts_len) {
>> +			strcpy(x_mnt_opts, mp.mnt_opts);
>> +			strncat(x_mnt_opts, ",", 2);
>> +		}
>> +		strncat(x_mnt_opts, ctx->x_opts,
>> +			x_mnt_opts_len - mnt_opts_len - 2);
>> +
>> +		final_mnt_opts = x_mnt_opts;
>> +	}
> 
> Curious, I thought the x- options were edited out by /sbin/mount so fuse
> would never see them?  Does the x- option handling in fusermount.c exist
> to handle the case where someone passes them directly to the fuse
> server, aka
> 
> $ sshfs <whatever> /mnt -o x-systemd-hahaha=1
> 
> and now you need to ensure that x-systemd-hahaha doesn't get sent to the
> kernel but does get seen by the fuse server?

https://github.com/libfuse/libfuse/issues/651

So specially added as mount option to to go into mtab/utab and to
suppress some 3rd party (gnome) actions.

> 
>> +
>> +	/* Use new mount API */
>> +	res = fuse_kern_fsmount(mnt, mp.flags, mp.blkdev,
>> +				mp.fsname, mp.subtype, ctx->dev,
>> +				mp.optbuf, final_mnt_opts);
>> +	if (res == -1)
>> +		goto fail_free_merged;
>> +
>> +	/* Change to root directory */
>> +	res = chdir("/");
>> +	if (res == -1) {
>> +		fprintf(stderr, "%s: failed to chdir to '/'\n", progname);
>> +		goto fail_free_merged;
>> +	}
>> +
>> +	/* Store results in context */
>> +	ctx->source = mp.source;
>> +	ctx->type = mp.type;
>> +	ctx->mnt_opts = final_mnt_opts;
>> +	*type = mp.type;
>> +
>> +	res = 0;
>> +
>> +	/* Only free what is not assigned to ctx */
>> +	free(mp.fsname);
>> +	free(mp.subtype);
>> +	free(mp.optbuf);
>> +	if (final_mnt_opts != mp.mnt_opts)
>> +		free(mp.mnt_opts);
>> +
>> +out:
>> +	free(do_mount_opts);
>> +	free(x_prefixed_opts);
>> +
>> +	return res;
>> +
>> +fail_free_merged:
>> +	if (final_mnt_opts != mp.mnt_opts)
>> +		free(final_mnt_opts);
>> +fail_free_params:
>> +	free_mount_params(&mp);
>> +fail:
>> +	res = -1;
>> +	goto out;
>> +}
>> +#endif /* HAVE_NEW_MOUNT_API */
>> +
>> +
>>  static int mount_fuse(const char *mnt, const char *opts, const char **type)
>>  {
>>  	int res;
>> @@ -1473,6 +1647,75 @@ fail_close_fd:
>>  	goto out_free;
>>  }
>>  
>> +/* Forward declarations for helper functions */
>> +static int send_fd(int sock_fd, int fd);
>> +static int wait_for_signal(int sock_fd);
>> +
>> +#ifdef HAVE_NEW_MOUNT_API
>> +/*
>> + * Perform sync-init mount using new mount API
>> + * Returns 0 on success, -1 on failure
>> + */
>> +static int mount_fuse_sync_init(const char *mnt, const char *opts,
>> +				int cfd, const char **type)
>> +{
>> +	struct mount_context ctx;
>> +	int fd, res;
>> +	int32_t status, send_res;
>> +
>> +	/* Phase 1: Open device and prepare */
>> +	fd = mount_fuse_prepare(mnt, opts, &ctx);
>> +	if (fd == -1)
>> +		return -1;
>> +
>> +	/* Send fd to caller so it can start worker thread */
>> +	res = send_fd(cfd, fd);
>> +	if (res != 0) {
>> +		close(fd);
>> +		free(ctx.x_opts);
>> +		return -1;
>> +	}
>> +
>> +	/* Wait for caller to signal that worker thread is ready */
>> +	res = wait_for_signal(cfd);
>> +	if (res != 0) {
>> +		close(fd);
>> +		free(ctx.x_opts);
>> +		return -1;
>> +	}
>> +
>> +	/* Phase 2: Perform the actual mount using new API */
>> +	res = mount_fuse_finish_fsmount(mnt, opts, &ctx, type);
>> +
>> +	/* Send mount result back to caller (4-byte error code) */
>> +	status = (res == 0) ? 0 : -(int32_t)errno;
>> +	do {
>> +		send_res = send(cfd, &status, sizeof(status), 0);
>> +	} while (send_res == -1 && errno == EINTR);
>> +	if (send_res != sizeof(status)) {
>> +		fprintf(stderr, "%s: failed to send mount status: %s\n",
>> +			progname, strerror(errno));
>> +	}
>> +
>> +	if (res == -1) {
>> +		close(fd);
>> +		free(ctx.source);
>> +		free(ctx.mnt_opts);
>> +		free(ctx.x_opts);
>> +		return -1;
>> +	}
>> +
>> +	close(fd);
>> +
>> +	/* Cleanup */
>> +	free(ctx.source);
>> +	free(ctx.mnt_opts);
>> +	free(ctx.x_opts);
>> +
>> +	return 0;
> 
> Err... these cleanups are identical, so I think you can get rid of the
> "if (res == -1)" chunk and just return res at the end.

Oh yeah, fixed.


Thanks,
Bernd
