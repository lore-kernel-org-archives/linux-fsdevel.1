Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0149E279DC9
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Apr 2026 22:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776638168; cv=none; b=fFcoHep9iyWWyWYpczk657pg5HBeVLVezg4TmumJt5o7/aif4HcLU84SHpFsK+aibm9vT0Kjovr4PFwHqUPSSL12ZkPJSyDmGc4G3WZwYAMcyOmf9/yuY4+WbSBmdGZil/EOmG2/tdTkzB+fPuC6TmJqfns3ulfLpxMk0MHMJuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776638168; c=relaxed/simple;
	bh=dednAdIMZUx0TmDeei3CZKc1ivsX4zo+M4efVJ3g6FQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WUM7z8V+3iwNHg7m2NJ4r8xplpfSyFbP1t98rjZqslwjjjb8LkANE47DSxWdwi10TYn0BovWqBbIujnNQ9xGG+eV89usddX9t+30wPYsyTQxUD1fLu1Tg1/TckI5m5sDFq9djWfYKg/QfXju94B4fmGVmd6IcG/rT9jS/kmNHXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=G5xwmGz1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E7w0da4x; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="G5xwmGz1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E7w0da4x"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E3C747A011E;
	Sun, 19 Apr 2026 18:36:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 19 Apr 2026 18:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776638164;
	 x=1776724564; bh=MLX167DXoOMaKjMEB4WKgJXfgeW+HtjBjDTUkzTV4xw=; b=
	G5xwmGz1MtF7cDiv+WweqjuyyQ73SicZtB0kmNtBIgo6UDKet2C8yT6Oqpz7Vack
	Lo+3hWw1vKg4HKByOejBtMWi1qpBpWHN6rVWoU0T56mYYI3SecXv9wIoZjK730Kj
	PhV195YQH0JIGYl2SXynBVDcG+60pMNHpLmLSXfa0FA65XyAxKS+CdyR/UF/TzDz
	pBxkzA2BK8pNBXqU1Ygs5eIkhxXpMRNUVLsafEeSKChbedFD7lOzQVA5ZmEjgyxL
	qm/j1hWSSRqfBE60p7cND+fTEzlU2HEtDMitT2r4gUmE+gUJ+RMT7hO8v5XipQR7
	b8YlfnwXN/mNDaW9oQorMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776638164; x=
	1776724564; bh=MLX167DXoOMaKjMEB4WKgJXfgeW+HtjBjDTUkzTV4xw=; b=E
	7w0da4xFZF5ZdqknaXcXA60fsgljgTOoFUq1bevrFNGNdfYKEwo5Gt1nZ7JUJrCd
	pkwhkr9C2C0rNq0ZRDw8ybtExaa+yGEU8U+KNG3/6J9wq9uzams4uqKVdthqNkPs
	0h3aI5LltunHUAT/bJF7qTS/coNxtMBUTEBvZXQF2/iwFSaxTBuiE0lWKYAI9/f1
	SX0RvQcvlvfgzfhTOR8bu5n/flQJhiqJ+husooJF04C0KP76FRuRZDSjG7IiEhHO
	jUUNcJPSk5tGtBl2xrsNnGR0aFx0QDJJKHlytKm4o4k6m7omMExuBKL07qCZJsFr
	X221+YOc2e0DsIi2EOFtQ==
X-ME-Sender: <xms:1Fjlafos7xEe05L5sGuXkWXoc7BwmZyDHNSya78sLA3q7heeg9zjIg>
    <xme:1FjladUDKL_ifXaP8_WbJvibDmPyBToh1MmWGJChA9IKhxUYaWrLQYWAKGSZKPKJa
    ARX8mUQQg1ILqIHOrXAlsuCzFXS7JaZjtksgGf6yDNe0_o2f904>
X-ME-Received: <xmr:1FjlaWBamt6zpdaNK0NuYWnPijpw8tceRlMSnIFMGyl9BRSoz07259LEabuEgzGgPaNRCJ-1BJuQBuQ8YsNGdHuM3jvvdm8HQp8YsKd-IZG9NJt8BA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehieekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhepfeeggeefffekudduleefheelleehgfffhedujedvgfetvedvtdefieehfeel
    gfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    gvrhhnugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepughjfihonhhgsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehjohgrnh
    hnvghlkhhoohhnghesghhmrghilhdrtghomhdprhgtphhtthhopehktghhvghnseguughn
    rdgtohhmpdhrtghpthhtohepsghstghhuhgsvghrthesuggunhdrtghomh
X-ME-Proxy: <xmx:1FjlaZ0qWOlClXvIuTv2_llcP-UV39Y53JCIw2VyWPvVMbC-cvPXGQ>
    <xmx:1FjlaQ0CBWb-_A6dSCkCoLI9iQnikFtv-fnE9rs0Dz16RuKociz74Q>
    <xmx:1FjlaWCsJakHsKeLuCrmj3uh6fACzXfZtZSarOafhHIQelWTrZM69Q>
    <xmx:1FjlaX4bcRSaKUPV78FJxEOCosyPT6kzVC4rASOKgNaY2G8Kk-3flA>
    <xmx:1Fjlaa7S64Wp3LlG8aBhKsDx9CV3Q62euenSjNV3hkFJTugCBE5L5wpa>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Apr 2026 18:36:03 -0400 (EDT)
Message-ID: <dbcae738-b675-491e-b8f8-e3ad0928b47f@bsbernd.com>
Date: Mon, 20 Apr 2026 00:36:01 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/25] fuse mount: Support synchronous FUSE_INIT
 (privileged daemon)
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>,
 Bernd Schubert <bschubert@ddn.com>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
 <20260326-fuse-init-before-mount-v2-14-b1ca8fcbf60f@bsbernd.com>
 <20260330184418.GX6202@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US
In-Reply-To: <20260330184418.GX6202@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/30/26 20:44, Darrick J. Wong wrote:
> On Thu, Mar 26, 2026 at 10:34:47PM +0100, Bernd Schubert wrote:
>> From: Bernd Schubert <bschubert@ddn.com>
>>
>> Add synchronous FUSE_INIT processing during mount() to
>> enable early daemonization with proper error reporting
>> to the parent process.
>>
>> A new mount thread is needed that handles FUSE_INIT and
>> possible other requests at mount time (like getxattr for selinux).
>> The kernel sends FUSE_INIT during the mount() syscall. Without a thread
>> to process it, mount() blocks forever.
>>
>> Mount thread lifetime:
>> Created before mount() syscall in fuse_start_sync_init_worker()
>> Processes requests until se->mount_finished is set (after mount() returns)
>> Joined after successful mount in fuse_wait_sync_init_completion()
>> Cancelled if mount fails (direct → fusermount3 fallback)
>> Key changes:
>>
>> Add init_thread, init_error, mount_finished to struct fuse_session
>> Use FUSE_DEV_IOC_SYNC_INIT ioctl for kernel support
>> Fall back to async FUSE_INIT if unsupported
>> Auto-enabled when fuse_daemonize_active() or via
>> fuse_session_want_sync_init()
>> Allows parent to report mount/init failures instead of
>> exiting immediately after fork.
>>
>> Note: For now synchronous FUSE_INIT is only supported for privileged
>> mounts.
>>
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>> ---
>>  include/fuse_daemonize.h |   7 ++
>>  include/fuse_lowlevel.h  |  12 +++
>>  lib/fuse_daemonize.c     |   6 ++
>>  lib/fuse_i.h             |  15 ++++
>>  lib/fuse_lowlevel.c      | 190 ++++++++++++++++++++++++++++++++++++++++++++++-
>>  lib/mount.c              |   5 +-
>>  6 files changed, 230 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/fuse_daemonize.h b/include/fuse_daemonize.h
>> index c35dddd668b399535c53b44ab06c65fc0b3ddefa..6215e42c635ba5956cb23ba0832dfc291ab8dede 100644
>> --- a/include/fuse_daemonize.h
>> +++ b/include/fuse_daemonize.h
>> @@ -66,6 +66,13 @@ bool fuse_daemonize_is_active(void);
>>   */
>>  void fuse_daemonize_set_mounted(void);
>>  
>> +/**
>> + * Check if daemonization is used.
>> + *
>> + * @return true if used, false otherwise
>> + */
>> +bool fuse_daemonize_is_used(void);
> 
> These new fuse_daemonize_* function names are confusing --
> if fuse_daemonize_is_used() then I should be calling everything *but*
> fuse_daemonize().
> 
> I wonder if a better name would be fuse_daemonize_early_* for the new
> functions?

I don't have a strong opinion on either, renamed to your suggestions.
Just lets avoid further renames as part of the introduction patch, takes
too much of my time to fix merge conflicts with later changes. Not
diffcult to solve, just time consuming. If we decide before the next
libfuse release to rename again - not beautiful but takes much less time.

> 
>> +
>>  #ifdef __cplusplus
>>  }
>>  #endif
>> diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
>> index ee0bd8d71d95e4d57ebb4873dca0f2b36e22a649..d8626f85bdaf497534cd2835a589e30f1f4e2466 100644
>> --- a/include/fuse_lowlevel.h
>> +++ b/include/fuse_lowlevel.h
>> @@ -2429,6 +2429,18 @@ void fuse_session_process_buf(struct fuse_session *se,
>>   */
>>  int fuse_session_receive_buf(struct fuse_session *se, struct fuse_buf *buf);
>>  
>> +/**
>> + * Request synchronous FUSE_INIT, i.e. FUSE_INIT is handled by the
>> + * kernel before mount is returned.
>> + *
>> + * As FUSE_INIT also starts io-uring ring threads, fork() must not be
>> + * called after this if io-uring is enabled. Also see
>> + * fuse_session_daemonize_start().
>> + *
>> + * This must be called before fuse_session_mount() to have any effect.
>> + */
>> +void fuse_session_want_sync_init(struct fuse_session *se);
>> +
>>  /**
>>   * Check if the request is submitted through fuse-io-uring
>>   */
>> diff --git a/lib/fuse_daemonize.c b/lib/fuse_daemonize.c
>> index 865acad7db56dbe5ed8a1bee52e7353627e89b75..97cfad7be879beacf69b020b7af78d512a224fd5 100644
>> --- a/lib/fuse_daemonize.c
>> +++ b/lib/fuse_daemonize.c
>> @@ -9,6 +9,7 @@
>>  #define _GNU_SOURCE
>>  
>>  #include "fuse_daemonize.h"
>> +#include "fuse_i.h"
>>  
>>  #include <fcntl.h>
>>  #include <poll.h>
>> @@ -290,3 +291,8 @@ void fuse_daemonize_set_mounted(void)
>>  {
>>  	daemonize.mounted = true;
>>  }
>> +
>> +bool fuse_daemonize_is_used(void)
>> +{
>> +	return daemonize.active;
>> +}
>> diff --git a/lib/fuse_i.h b/lib/fuse_i.h
>> index 6d63c9fd2149eb4ae3b0e0170640a4ce2eed4705..164401e226eb727192a49e1cc7b38a75f031643b 100644
>> --- a/lib/fuse_i.h
>> +++ b/lib/fuse_i.h
>> @@ -112,6 +112,9 @@ struct fuse_session {
>>  
>>  	/* synchronous FUSE_INIT support */
>>  	bool want_sync_init;
>> +	pthread_t init_thread;
>> +	int init_error;
>> +	int init_wakeup_fd;
>>  
>>  	/* io_uring */
>>  	struct fuse_session_uring uring;
>> @@ -221,7 +224,11 @@ void fuse_chan_put(struct fuse_chan *ch);
>>  /* Mount-related functions */
>>  void fuse_mount_version(void);
>>  void fuse_kern_unmount(const char *mountpoint, int fd);
>> +int fuse_kern_mount_get_base_mnt_opts(struct mount_opts *mo, char **mnt_optsp);
>>  int fuse_kern_mount(const char *mountpoint, struct mount_opts *mo);
>> +int fuse_kern_mount_prepare(const char *mountpoint, struct mount_opts *mo);
>> +int fuse_kern_do_mount(const char *mountpoint, struct mount_opts *mo,
>> +		       const char *mnt_opts);
>>  
>>  int fuse_send_reply_iov_nofree(fuse_req_t req, int error, struct iovec *iov,
>>  			       int count);
>> @@ -255,6 +262,14 @@ int fuse_session_loop_mt_312(struct fuse_session *se, struct fuse_loop_config *c
>>   */
>>  int fuse_loop_cfg_verify(struct fuse_loop_config *config);
>>  
>> +/**
>> + * Check if daemonization is set.
>> + *
>> + * @return true if set, false otherwise
>> + */
>> +bool fuse_daemonize_set(void);
>> +
>> +
>>  
>>  /*
>>   * This can be changed dynamically on recent kernels through the
>> diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
>> index a7be40cbb012361ad664a9ced3d38042ba52c681..0dd10e0ed53508e4716703f2f82aa35ad853b247 100644
>> --- a/lib/fuse_lowlevel.c
>> +++ b/lib/fuse_lowlevel.c
>> @@ -4230,6 +4230,7 @@ fuse_session_new_versioned(struct fuse_args *args,
>>  		goto out1;
>>  	}
>>  	se->fd = -1;
>> +	se->init_wakeup_fd = -1;
>>  	se->conn.max_write = FUSE_DEFAULT_MAX_PAGES_LIMIT * getpagesize();
>>  	se->bufsize = se->conn.max_write + FUSE_BUFFER_HEADER_SIZE;
>>  	se->conn.max_readahead = UINT_MAX;
>> @@ -4402,6 +4403,170 @@ int fuse_session_custom_io_30(struct fuse_session *se,
>>  }
>>  
>>  #if defined(HAVE_NEW_MOUNT_API)
>> +
>> +/* Worker thread for synchronous FUSE_INIT */
>> +static void *session_sync_init_worker(void *data)
>> +{
>> +	struct fuse_session *se = (struct fuse_session *)data;
>> +	struct fuse_buf fbuf = {
>> +		.mem = NULL,
>> +	};
>> +	struct pollfd pfds[2];
>> +	int res;
>> +
>> +	pfds[0].fd = se->fd;
>> +	pfds[0].events = POLLIN;
>> +	pfds[0].revents = 0;
>> +	pfds[1].fd = se->init_wakeup_fd;
>> +	pfds[1].events = POLLIN;
>> +	pfds[1].revents = 0;
>> +
>> +	/*
>> +	 * Process requests until mount completes. With SELinux there may be
>> +	 * additional requests (like getattr) after FUSE_INIT before mount
>> +	 * returns.
>> +	 */
>> +	while (true) {
>> +		res = poll(pfds, 2, -1);
>> +		if (res == -1) {
>> +			if (errno == EINTR)
>> +				continue;
>> +			se->init_error = -errno;
>> +			break;
>> +		}
>> +
>> +		if (pfds[1].revents & POLLIN)
>> +			break;
>> +
>> +		if (pfds[0].revents & POLLIN) {
>> +			res = fuse_session_receive_buf_internal(se, &fbuf, NULL);
>> +			if (res == -EINTR)
>> +				continue;
>> +			if (res <= 0) {
>> +				se->init_error = res < 0 ? res : -EINVAL;
>> +				break;
>> +			}
>> +
>> +			fuse_session_process_buf_internal(se, &fbuf, NULL);
>> +		}
>> +	}
>> +
>> +	fuse_buf_free(&fbuf);
>> +	return NULL;
>> +}
>> +
>> +/* Enable synchronous FUSE_INIT and start worker thread */
>> +static int session_start_sync_init(struct fuse_session *se, int fd)
>> +{
>> +	int err, res;
>> +
>> +	if (!se->want_sync_init &&
>> +		(se->uring.enable && !fuse_daemonize_is_used())) {
>> +		if (se->debug)
>> +			fuse_log(FUSE_LOG_DEBUG,
>> +					"fuse: sync init not enabled\n");
>> +		return 0;
>> +	}
>> +
>> +	/* Try to enable synchronous FUSE_INIT */
>> +	res = ioctl(fd, FUSE_DEV_IOC_SYNC_INIT);
>> +	if (res) {
>> +		err = -errno;
>> +		if (err != ENOTTY) {
>> +			fuse_log(
>> +				FUSE_LOG_ERR,
>> +				"fuse: failed to enable sync init: %s\n",
>> +				strerror(errno));
>> +		} else {
>> +			/*
>> +			 * ENOTTY means kernel doesn't support sync init,not an
>> +			 * error
>> +			 */
>> +			if (se->debug)
>> +				fuse_log(
>> +					FUSE_LOG_DEBUG,
>> +					"fuse: kernel doesn't support sync init\n");
>> +			err = 0;
>> +		}
>> +		return err;
>> +	}
>> +
>> +	if (se->debug)
>> +		fuse_log(FUSE_LOG_DEBUG,
>> +				"fuse: synchronous FUSE_INIT enabled\n");
>> +
>> +	se->init_error = 0;
>> +
>> +	se->init_wakeup_fd = eventfd(0, EFD_CLOEXEC);
>> +	if (se->init_wakeup_fd == -1) {
>> +		fuse_log(
>> +			FUSE_LOG_ERR,
>> +			"fuse: failed to create eventfd for init worker: %s\n",
>> +			strerror(errno));
>> +		return -EIO;
>> +	}
>> +
>> +	err = pthread_create(&se->init_thread, NULL,
>> +				session_sync_init_worker, se);
>> +	if (err != 0) {
>> +		fuse_log(
>> +			FUSE_LOG_ERR,
>> +			"fuse: failed to create init worker thread: %s\n",
>> +			strerror(err));
>> +		close(se->init_wakeup_fd);
>> +		se->init_wakeup_fd = -1;
>> +		return -EIO;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/* Wait for synchronous FUSE_INIT to complete */
>> +static int session_wait_sync_init_completion(struct fuse_session *se)
>> +{
>> +	void *retval;
>> +	int err;
>> +	uint64_t val = 1;
>> +
>> +	if (se->init_wakeup_fd == -1)
>> +		return 0;
>> +
>> +	if (se->init_wakeup_fd != -1) {
>> +		ssize_t res = write(se->init_wakeup_fd, &val, sizeof(val));
>> +
>> +		if (res != sizeof(val)) {
>> +			fuse_log(FUSE_LOG_ERR,
>> +				 "fuse: failed to signal init worker: %s\n",
>> +				 strerror(errno));
>> +		}
>> +	}
>> +
>> +	err = pthread_join(se->init_thread, &retval);
>> +	if (err != 0) {
>> +		fuse_log(FUSE_LOG_ERR, "fuse: failed to join init worker thread: %s\n",
>> +			 strerror(err));
>> +		return -1;
>> +	}
>> +
>> +	if (se->init_wakeup_fd != -1) {
>> +		close(se->init_wakeup_fd);
>> +		se->init_wakeup_fd = -1;
>> +	}
>> +
>> +	if (se->init_error != 0) {
>> +		fuse_log(FUSE_LOG_ERR, "fuse: init worker failed: %s\n",
>> +			 strerror(-se->init_error));
>> +		return -1;
>> +	}
>> +
>> +	if (fuse_session_exited(se)) {
>> +		fuse_log(FUSE_LOG_ERR, "FUSE_INIT failed: session exited\n");
>> +		return -1;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static int fuse_session_mount_new_api(struct fuse_session *se,
>>  				      const char *mountpoint)
>>  {
>> @@ -4426,6 +4591,15 @@ static int fuse_session_mount_new_api(struct fuse_session *se,
>>  		goto err;
>>  	}
>>  
>> +	/*
>> +	 * Enable synchronous FUSE_INIT and start worker thread, sync init
>> +	 * failure is not an error
>> +	 */
>> +	se->fd = fd;
>> +	err = session_start_sync_init(se, fd);
>> +	if (err)
>> +		goto err;
>> +
>>  	snprintf(fd_opt, sizeof(fd_opt), "fd=%i", fd);
>>  	if (fuse_opt_add_opt(&mnt_opts_with_fd, mnt_opts) == -1 ||
>>  	    fuse_opt_add_opt(&mnt_opts_with_fd, fd_opt) == -1) {
>> @@ -4435,13 +4609,16 @@ static int fuse_session_mount_new_api(struct fuse_session *se,
>>  
>>  	err = fuse_kern_fsmount_mo(mountpoint, se->mo, mnt_opts_with_fd);
>>  err:
>> -	if (err) {
>> +	if (err < 0) {
>>  		if (fd >= 0)
>>  			close(fd);
>>  		fd = -1;
>>  		se->fd = -1;
>>  		se->error = -errno;
>>  	}
>> +	/* Wait for synchronous FUSE_INIT to complete */
>> +	if (session_wait_sync_init_completion(se) < 0)
>> +		fuse_log(FUSE_LOG_ERR, "fuse: sync init completion failed\n");
> 
> Should fuse_session_mount_new_api return a nonzero value if waiting
> doesn't work?

I debated that internally forth and back already, came to the conclusion
that if that happens the mount actually succeeded. I don't have a strong
onion here. And assert would work, but would not be beautiful either.

> 
>>  
>>  	free(mnt_opts);
>>  	free(mnt_opts_with_fd);
>> @@ -4451,8 +4628,8 @@ err:
>>  static int fuse_session_mount_new_api(struct fuse_session *se,
>>  				      const char *mountpoint)
>>  {
>> -	(void)se;
>> -	(void)mountpoint;
>> +	(void) se;
>> +	(void) mountpoint;
> 
> Unrelated change?

Removed, must have been introduced by clangd/-format.


Thanks,
Bernd
