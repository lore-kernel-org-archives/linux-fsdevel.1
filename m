Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6286130BB94
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 21:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774389206; cv=none; b=D53HCUYARjsm49TLY++bFfLYOuuvxerQH1OcV+EjHSGhzaXyU5B5ag8H9O+dUasx0CFcmfT1q19b9aMmICfV7BDDMDOYbUG7t1BsJkjfMlQpm301O1NpWkst8Om9udWuRDcIOOVYcji2HG28tsDcY15h/21Tzrjqtt+fC5lindY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774389206; c=relaxed/simple;
	bh=ghETktIySLhhK8MFc+brBtVo5lVTA1K0hyL+za53R+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=afEzvNp12NMXL7+IaBKobQKjVd8bSZ+p4L5AZi4ZGrEvqVXShbl4L3papO1ZClXRQ+rJAKAPRveTtSZdO0nYtVj6wEdB1Z3qOgHPHr27hK0EL6Oz0MIvkaQ4W6jBclpHxetaaAvrzc4Pea/tuEzeVc4C0gys5xgOqqluMeg2S/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=bckpyj+8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fFzbQfQo; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="bckpyj+8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fFzbQfQo"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 98966EC01DF;
	Tue, 24 Mar 2026 17:53:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 24 Mar 2026 17:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774389203;
	 x=1774475603; bh=R/a9gVUQNTLfRwQrqk20i0RQlqx5GV7sKgerlAYCyvU=; b=
	bckpyj+85y2a4QgKy1Nj/cc8Md63liegc+TU+I0apffdTIpCPLVK5wmnQ/pciBDB
	xrdJESr0jsAlcYnTzLUCPanVYkpbYB6G0EqHgsKlzQwHk0bMiCPhvJCtZYTmaGqr
	O2EY7Mc1ZNG4JqW0d0bOp51nh2lBUYh9OZtvyX3FoGntjPylsVClFX3EjYxdT+Jn
	DdVrjf4ZSPnywzuTWDTY1sd3/6xdUtTBxtvHoWbSVjRnlyGtkLELJU/nrMwsbOA/
	IC/1vk+3qbtgoZZ84y5DeR61+FXf840hp3J7/7H1UIyFTY3qAiMsNlQcU7Mt2BxC
	88hMailh6qs4ApG4Chr1yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774389203; x=
	1774475603; bh=R/a9gVUQNTLfRwQrqk20i0RQlqx5GV7sKgerlAYCyvU=; b=f
	FzbQfQoozEz5P2xd8XO6/lcOeqR9YBSDdi9UgDM3LNWWntONiWeaIExjXCidjfN+
	KN09lSUqjix9AqdjvOgLIcK6dnprL+jIfeCpCDSQWGIxAIBd/BqWjXMrPE1CpK1u
	VUqwA94e498nuLjiA3EpikOCrlZgg5KUEo8ENkXgdsexKCvFlP+2JAycqcmy0lUK
	bTbTmf6HHg4IDAD33slQ0Sg9/Ew+k242DDxFo0EIh96wGPqVVZAhso9SQKkr9aXe
	EbwoA1EFgj7xRHlbEFdLIH7OSAYdHgSUXE3s9/pi5owOWK/mZ4TNWM8b+2SEjnfv
	2wOKikDt8b346nlnkeZDg==
X-ME-Sender: <xms:0wfDaTk3CZ7b1zGSNFHoZm5Lh3kIH-ogxL-P-w-tAACigD71mxUc6w>
    <xme:0wfDadufQgNA0bGaXqTcjGtStlptCXzeWqdP6EmeSvzsQc7DiG1Hxc4leMMrwoaBj
    ueeUNC7A2itlCrcxhp0rOT8Y7QjAnbRxqF87MC7YO7XMKYaD88w>
X-ME-Received: <xmr:0wfDaR9l8ynYWkC1BFnwYZWntgiiRnDtimu1m_jLyu48VOpM-S0JwTWvAj5A-hHyqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddvjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeefgeegfeffkeduudelfeehleelhefgffehudejvdfgteevvddtfeeiheef
    lefgvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepjhhorg
    hnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghstghhuhgsvghr
    thesuggunhdrtghomh
X-ME-Proxy: <xmx:0wfDaXMSsSl0vpeLFvhZeljGaN2buwWP68ioi5pGwD78mXVt0gEHiA>
    <xmx:0wfDafHpEcian2ObRw12dNv59Om-HC5oyhnPzf20Qdk1HDgIVzx84Q>
    <xmx:0wfDaVR79_MKVYRLDkWePvbaIUaWNEpO34lnVuSsyX0j91p7GAwcmg>
    <xmx:0wfDactC1hiU4tmg7UiIHAPoawGI3BuD96v1Y0aAtb_XqIQJ0wbc-Q>
    <xmx:0wfDaTk9FbA7rhmbHRO4qS6iVwvucix0Ief27PHHc9Y2U8z30pVEZ4Ar>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 17:53:22 -0400 (EDT)
Message-ID: <7890fe12-5061-490d-b666-821259461540@bsbernd.com>
Date: Tue, 24 Mar 2026 22:53:21 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/19] Add support for sync-init of unprivileged daemons
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bschubert@ddn.com>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
 <20260323-fuse-init-before-mount-v1-19-a52d3040af69@bsbernd.com>
 <20260324202125.GV6202@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US
In-Reply-To: <20260324202125.GV6202@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/24/26 21:21, Darrick J. Wong wrote:
> On Mon, Mar 23, 2026 at 06:45:14PM +0100, Bernd Schubert wrote:
>> From: Bernd Schubert <bschubert@ddn.com>
>>
>> This makes use of the bidirectional fusermount. Added is
>> doc/README.mount, which explains the new bidirectional
>> communication with fusermount.
>>
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> 
> All right, last patch before I go have some lunch and circle back to
> your recent replies :)
> 
>> ---
>>  doc/README.mount     |  86 ++++++++++++++++++++++++
>>  doc/README.sync-init | 184 +++++++++++++++++++++++++++++++++++++++++++++++++++
> 
> These new readmes feel like they ought to go at the beginning (or at
> least a separate patch) to argue for why synchronous init is needed
> in libfuse?  I do appreciate the flow diagrams though.

These new READMEs are kind of used by myself to understand and remember
the flow graph and reasoning. Given the frequency I jump between
projects, I prefer to have some files that help me to remember.
I had asked for AI help to create these flow graphs, simple to give the
right commands when one is in the middle of the code...
I can move these files into a separate patch if you prefer.

> 
>>  lib/fuse_lowlevel.c  | 115 ++++++++++++++++++++++++++------
>>  lib/mount.c          | 126 ++++++++++++++++++++++++++++++++++-
>>  lib/mount_i_linux.h  |   7 ++
>>  util/fusermount.c    |   2 -
>>  6 files changed, 494 insertions(+), 26 deletions(-)
>>
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
> 
> Especially this part which explains why we care about sync init :)
> 
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
>> +
>> diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
>> index a7293a3898c37c3877eadf965d310ae2aa5cc2d1..da966217ed841744a20bee60de8ae615d1015b47 100644
>> --- a/lib/fuse_lowlevel.c
>> +++ b/lib/fuse_lowlevel.c
>> @@ -41,6 +41,7 @@
>>  #include <assert.h>
>>  #include <sys/file.h>
>>  #include <sys/ioctl.h>
>> +#include <sys/wait.h>
>>  #include <stdalign.h>
>>  #include <poll.h>
>>  
>> @@ -4551,6 +4552,8 @@ static int session_wait_sync_init_completion(struct fuse_session *se)
>>  		se->init_wakeup_fd = -1;
>>  	}
>>  
>> +	se->init_thread = 0;
>> +
>>  	if (se->init_error != 0) {
>>  		fuse_log(FUSE_LOG_ERR, "fuse: init worker failed: %d\n", se->init_error);
>>  		return -1;
>> @@ -4564,56 +4567,125 @@ static int session_wait_sync_init_completion(struct fuse_session *se)
>>  	return 0;
>>  }
>>  
>> -/* Only linux supports sync FUSE_INIT so far */
>> +/*
>> + * Mount using the new Linux mount API (fsopen/fsconfig/fsmount/move_mount)
>> + * Sync-init is only supported with the new API, as the mount might hang
>> + * in case of daemon crash during FUSE_INIT. That also means once the sync init
>> + * ioctl succeed fallback is not allowed anymore.
>> + * Returns: fd on success, -1 on failure
>> + */
>>  static int fuse_session_mount_new_api(struct fuse_session *se,
>> -				      const char *mountpoint)
>> +				      const char *mountpoint, bool *fall_back)
>>  {
>>  	int fd = -1;
>> +	int sock_fd = -1;
>> +	pid_t fusermount_pid = -1;
>>  	int res, err;
>>  	char *mnt_opts = NULL;
>>  	char *mnt_opts_with_fd = NULL;
>>  	char fd_opt[32];
>>  
>>  	res = fuse_kern_mount_get_base_mnt_opts(se->mo, &mnt_opts);
>> +	err = -EIO;
>>  	if (res == -1) {
>>  		fuse_log(FUSE_LOG_ERR, "fuse: failed to get base mount options\n");
>> -		err = -EIO;
> 
> Odd churn in this function...
> 
>>  		goto err;
>>  	}
>>  
>>  	fd = fuse_kern_mount_prepare(mountpoint, se->mo);
>>  	if (fd == -1) {
>>  		fuse_log(FUSE_LOG_ERR, "Mount preparation failed.\n");
>> -		err = -EIO;
>>  		goto err;
>>  	}
>>  
>> -	/*
>> -	 * Enable synchronous FUSE_INIT and start worker thread, sync init
>> -	 * failure is not an error
>> -	 */
>> +	*fall_back = true;
>>  	se->fd = fd;
>>  	err = session_start_sync_init(se, fd);
>>  	if (err) {
>>  		/* ENOTTY means kernel doesn't support sync init - not an error */
>>  		if (err != -ENOTTY)
>>  			goto err;
>> +	} else {
>> +		*fall_back = false;
>>  	}
>> +
>> +
>>  	snprintf(fd_opt, sizeof(fd_opt), "fd=%i", fd);
>> +	err = -ENOMEM;
>>  	if (fuse_opt_add_opt(&mnt_opts_with_fd, mnt_opts) == -1 ||
>>  	    fuse_opt_add_opt(&mnt_opts_with_fd, fd_opt) == -1) {
>> -		err = -ENOMEM;
>>  		goto err;
>>  	}
>>  
>> +	/* Try to mount directly */
>>  	err = fuse_kern_fsmount_mo(mountpoint, se->mo, mnt_opts_with_fd);
>> +
>> +	/* If mount failed with EPERM, fall back to fusermount3 with sync-init */
> 
> 
> ...since this is the new "actually use bidirectional fusermount3" code
> mentioned in the commit message.

Here I'm lost what you mean., bidirectional fusermount3 only follows below.

> 
>> +	if (err < 0 && errno == EPERM) {
>> +		if (se->debug)
>> +			fuse_log(FUSE_LOG_DEBUG,
>> +				 "fuse: privileged mount failed with EPERM, falling back to fusermount3\n");
>> +
>> +		/* Terminate worker thread with wrong fd */
>> +		if (session_wait_sync_init_completion(se) < 0)
>> +			fuse_log(FUSE_LOG_ERR, "fuse: sync init completion failed\n");
>> +
>> +		/* Close the privileged fd */
>> +		close(fd);
>> +		fd = -1;
>> +		se->fd = -1;
>> +
>> +		/* Call fusermount3 with --sync-init */
>> +		err = -ENOTSUP;
>> +		fd = mount_fusermount_obtain_fd(mountpoint, se->mo, mnt_opts,
>> +						&sock_fd, &fusermount_pid);
>> +		if (fd < 0) {
>> +			fuse_log(
>> +				FUSE_LOG_ERR,
>> +				"fuse: fusermount3 sync-init failed\n");
>> +			goto err;
>> +		}
>> +
>> +		/* Start worker thread with correct fd from fusermount3 */
>> +		se->fd = fd;
>> +		err = session_start_sync_init(se, fd);
>> +		if (err) {
>> +			if (err != -ENOTTY) {
>> +				fuse_log(
>> +					FUSE_LOG_ERR,
>> +					"fuse: failed to start sync init worker\n");
>> +				goto err_with_sock;
>> +			}
>> +		} else {
>> +			*fall_back = false;
> 
> We already set *fall_back to false above, didn't we?  I'm slightly
> confused -- should we set *fall_back=true any time this function returns
> nonzero?

Already updated, because there was merge conflict since
session_start_sync_init() doesn't return ENOTTY anymore. fall_back is
possible as long as the ioctl doesn't succeed.

> 
>> +		}
>> +
>> +		/* Send proceed signal and wait for mount result */
>> +		err = fuse_fusermount_proceed_mnt(sock_fd);
>> +		if (err < 0) {
>> +			err = -EIO;
>> +			goto err_with_sock;
>> +		}
>> +	} else if (err < 0) {
>> +		/* Mount failed with non-EPERM error, bail out */
>> +		goto err;
>> +	}
>> +
>> +err_with_sock:
>> +	if (sock_fd >= 0) {
>> +		close(sock_fd);
>> +		/* Reap fusermount3 child process to prevent zombie */
>> +		if (fusermount_pid > 0)
>> +			waitpid(fusermount_pid, NULL, 0);
>> +	}
>>  err:
>>  	if (err < 0) {
>> +		/* Close fd first to unblock worker thread */
>>  		if (fd >= 0)
>>  			close(fd);
>>  		fd = -1;
>>  		se->fd = -1;
>> -		se->error = -errno;
>> +		se->error = err;
>>  	}
>>  	/* Wait for synchronous FUSE_INIT to complete */
>>  	if (session_wait_sync_init_completion(se) < 0)
>> @@ -4625,10 +4697,11 @@ err:
>>  }
>>  #else
>>  static int fuse_session_mount_new_api(struct fuse_session *se,
>> -				      const char *mountpoint)
>> +				      const char *mountpoint, bool *fall_back)
>>  {
>>  	(void) se;
>>  	(void) mountpoint;
>> +	(void) fall_back;
>>  
>>  	return -1;
>>  }
>> @@ -4638,6 +4711,7 @@ int fuse_session_mount(struct fuse_session *se, const char *_mountpoint)
>>  {
>>  	int fd;
>>  	char *mountpoint;
>> +	bool fall_back;
>>  
>>  	if (_mountpoint == NULL) {
>>  		fuse_log(FUSE_LOG_ERR, "Invalid null-ptr mountpoint!\n");
>> @@ -4681,21 +4755,18 @@ int fuse_session_mount(struct fuse_session *se, const char *_mountpoint)
>>  		return 0;
>>  	}
>>  
>> -	/* new linux mount api */
>> -	fd = fuse_session_mount_new_api(se, mountpoint);
>> -	if (fd >= 0)
>> -		goto out;
>> +	/* new linux mount api (and sync init) */
>> +	fd = fuse_session_mount_new_api(se, mountpoint, &fall_back);
>>  
>>  	/* fall back to old API */
>> -	se->error = 0; /* reset error of new api */
>> -	fd = fuse_kern_mount(mountpoint, se->mo);
>> -	if (fd < 0)
>> -		goto error_out;
>> +	if (fall_back && fd < 0) {
>> +		se->error = 0; /* reset error of new api */
>> +		fd = fuse_kern_mount(mountpoint, se->mo);
>> +		if (fd < 0)
>> +			goto error_out;
>> +	}
>>  
>> -out:
>>  	se->fd = fd;
>> -
>> -	/* Save mountpoint */
>>  	se->mountpoint = mountpoint;
>>  
>>  	return 0;
>> diff --git a/lib/mount.c b/lib/mount.c
>> index 263b05051c236458b830c40181bce7f494803800..985938ea0be3e1affad19adad527a31ac2ca6034 100644
>> --- a/lib/mount.c
>> +++ b/lib/mount.c
>> @@ -41,6 +41,7 @@
>>  #define FUSERMOUNT_PROG		"fusermount3"
>>  #define FUSE_COMMFD_ENV		"_FUSE_COMMFD"
>>  #define FUSE_COMMFD2_ENV	"_FUSE_COMMFD2"
>> +#define ARG_FD_ENTRY_SIZE	30
> 
> Thirty seems a bit much for an integer, especially one that can't go
> above 1 million.  Eh, it's just stack space. :)

I just made it a define. We can change it later, though userspace stack
space is not that limited.

> 
>>  enum {
>>  	KEY_KERN_FLAG,
>> @@ -313,7 +314,7 @@ static int setup_auto_unmount(const char *mountpoint, int quiet)
>>  		return -1;
>>  	}
>>  
>> -	char arg_fd_entry[30];
>> +	char arg_fd_entry[ARG_FD_ENTRY_SIZE];
>>  	snprintf(arg_fd_entry, sizeof(arg_fd_entry), "%i", fds[0]);
>>  	setenv(FUSE_COMMFD_ENV, arg_fd_entry, 1);
>>  	/*
>> @@ -386,7 +387,7 @@ static int fuse_mount_fusermount(const char *mountpoint, struct mount_opts *mo,
>>  		return -1;
>>  	}
>>  
>> -	char arg_fd_entry[30];
>> +	char arg_fd_entry[ARG_FD_ENTRY_SIZE];
>>  	snprintf(arg_fd_entry, sizeof(arg_fd_entry), "%i", fds[0]);
>>  	setenv(FUSE_COMMFD_ENV, arg_fd_entry, 1);
>>  	/*
>> @@ -446,6 +447,127 @@ static int fuse_mount_fusermount(const char *mountpoint, struct mount_opts *mo,
>>  	return fd;
>>  }
>>  
>> +/*
>> + * Mount using fusermount3 with --sync-init flag for bidirectional fd exchange
>> + * Used by new mount API when privileged mount fails with EPERM
>> + *
>> + * Returns: fd on success, -1 on failure
>> + * On success, *sock_fd_out contains the socket fd for signaling fusermount3
>> + */
>> +int mount_fusermount_obtain_fd(const char *mountpoint, struct mount_opts *mo,
>> +			       const char *opts, int *sock_fd_out,
>> +			       pid_t *pid_out)
>> +{
>> +	int fds[2];
>> +	pid_t pid;
>> +	int res;
>> +	char arg_fd_entry[ARG_FD_ENTRY_SIZE];
>> +	posix_spawn_file_actions_t action;
>> +	int fd, status;
>> +
>> +	(void)mo;
>> +
>> +	if (!mountpoint) {
>> +		fuse_log(FUSE_LOG_ERR, "fuse: missing mountpoint parameter\n");
>> +		return -1;
>> +	}
>> +
>> +	res = socketpair(PF_UNIX, SOCK_STREAM, 0, fds);
>> +	if (res == -1) {
>> +		fuse_log(FUSE_LOG_ERR, "Running %s: socketpair() failed: %s\n",
>> +			 FUSERMOUNT_PROG, strerror(errno));
>> +		return -1;
>> +	}
>> +
>> +	snprintf(arg_fd_entry, sizeof(arg_fd_entry), "%i", fds[0]);
>> +	setenv(FUSE_COMMFD_ENV, arg_fd_entry, 1);
> 
> Oh!  /me realizes that FUSE_COMMFD{,2}_ENV can convey different things!
> 
> If you're trying to get fusermount to *mount* a filesystem, then it's
> the AF_UNIX socket that is used to pass the /dev/fuse fd to the fuse
> server and then to trigger the mount.
> 
> If you pass --auto-unmount/-U then fusermount waits for the socket to
> close and then unmounts the mount.
> 
>> +	snprintf(arg_fd_entry, sizeof(arg_fd_entry), "%i", fds[1]);
>> +	setenv(FUSE_COMMFD2_ENV, arg_fd_entry, 1);
> 
> ...and I guess you can pass the fds on the cli instead of goofy
> environment variables?  I wonder if you should be passing them via CLI
> since you know fusermount supports it.  OTOH I don't really care either
> way ;)

I had added the parameter to fusermount to avoid the env, issue is that
an old fusermount might be used with a new libfuse. I did that in the
past myself. For the new mount API and sync init, yeah, we can switch to
parameter, requires all the new functionality anyway.

> 
>> +
>> +	char const *const argv[] = {
>> +		FUSERMOUNT_PROG,
>> +		"--sync-init",
>> +		"-o", opts ? opts : "",
>> +		"--",
>> +		mountpoint,
>> +		NULL,
>> +	};
>> +
>> +	posix_spawn_file_actions_init(&action);
>> +	posix_spawn_file_actions_addclose(&action, fds[1]);
>> +	status = fusermount_posix_spawn(&action, argv, &pid);
>> +	posix_spawn_file_actions_destroy(&action);
>> +
>> +	if (status != 0) {
>> +		close(fds[0]);
>> +		close(fds[1]);
>> +		return -1;
>> +	}
>> +
>> +	close(fds[0]);
>> +
>> +	fd = receive_fd(fds[1]);
>> +	if (fd < 0) {
>> +		close(fds[1]);
>> +		waitpid(pid, NULL, 0);
>> +		return -1;
>> +	}
>> +
>> +	fcntl(fd, F_SETFD, FD_CLOEXEC);
>> +
>> +	/* Return socket fd for later signaling */
>> +	*sock_fd_out = fds[1];
>> +	*pid_out = pid;
>> +
>> +	return fd;
>> +}
>> +
>> +/*
>> + * Send proceed signal to fusermount3 and wait for mount result
>> + * Returns: 0 on success, -1 on failure
>> + */
>> +int fuse_fusermount_proceed_mnt(int sock_fd)
>> +{
>> +	char buf = '\0';
>> +	ssize_t res;
>> +
>> +	/* Send proceed signal */
>> +	do {
>> +		res = send(sock_fd, &buf, 1, 0);
>> +	} while (res == -1 && errno == EINTR);
> 
> I wonder if all the pipe/socket communications ought to have been turned
> into a bunch of wrappers like what I did for
> mount_service.c/fuse_service.c?
> 
> That said, it looks like most of the fusermount/sync-init communcations
> are single ints so maybe it doesn't matter.  The communications for the
> fuse servers is much more complex and hence needs more structure.

Maybe we can look into that after merging the series and before making a
3.19 release? I don't want to make this series any longer than
absolutely neded.


Thanks,
Bernd
