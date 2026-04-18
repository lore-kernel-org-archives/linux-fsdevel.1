Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC8522B8C5
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2026 18:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776536775; cv=none; b=bTVDo0mwNJ7rafXt8YDFCwwADuXh6HLpSokwg0lXbx2gVDa8o/tNprybqEg84KJAZ0/9hkIb3YWuAnPgFXviMXClW7SWaLDLgokOYDUSLpHv/eavfDJho0IC14MMQ+kupDts73a4QH6UAmHfNtIJrQS0c5aVgpl6xcDiVuIRma8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776536775; c=relaxed/simple;
	bh=JfmaLou/cfAsZujOdr+VNvLUh0Du6z4Rzfkk4Tn73ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oo3TrC/hy5wXmpW6AsDVmCT8s+0ORb2W7MuZcXH9XZBlWFIfLjga/rpgULwQYiB+bzGhJgpfuoDvM2WhBkTvhwTaAx62Z21s3Ft+bEwmH84b68JvOmxOiqm3I2TRK0qRZRNB2ClNgpxFjHgrBeQGu7y6cEL2iyAq194c2Fl08U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=qGEckIpJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oGYZ6PT4; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="qGEckIpJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oGYZ6PT4"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D5686140008A;
	Sat, 18 Apr 2026 14:26:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sat, 18 Apr 2026 14:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776536771;
	 x=1776623171; bh=iC9RZXEWMKoxV/q/srq4U/MV3628n/Ftvwx71N7NGkw=; b=
	qGEckIpJYoK7BV6n1lEFXO+taScO0MGLclcCFAxtzF3P6mjAnFvSgR2VMtKa10r2
	diMQfjC8IpHFz4fAUMD7jTxGCwxg7Na4DAMGPQjW9CQCtN/7ra5uKJ0pQbF34Gcz
	NGI4pmHEXiFdqkR0VK80dGdF1gR4KDAp212VdOCfcDHo+xGRgDhhl+mBDA+zv6xt
	oJJEeqAwWBtEe5t2A6aoYPlwYXrLJhIq9Uh6GacqeKH4Y/B7aunzjY1QcLrl3AEU
	+7Koz/atCU7X92R8JiAReEQ7o46+FkyyCLjfcNEwiMmFHVe+nm3PMN9pxjxZQacP
	Xmwyc/YI1+GMR3AFnihNqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776536771; x=
	1776623171; bh=iC9RZXEWMKoxV/q/srq4U/MV3628n/Ftvwx71N7NGkw=; b=o
	GYZ6PT4G0Yv8DOmCviOP12ezp9amzmYGdDlPtU4bVWcMZorMGoXQStjvcRQcyPpU
	JnCS2UkoU2wJn77Vl1A6pR2QvfTjZgmWmE808bzbbIfy+RLSfMb1wW+GUtPXvLjs
	z48xBm7tRmpfTroc91Q8k245jWK5LkILta3dRHFEEhv5+sknW0jbYcZUplRwTOHD
	nphmK4yacuYUvBQEYQ5ZTjQslkwKx6+/hNqIqNc1OhrQbPajXuSMG1KGlLujZG/h
	jxWov3HrBXs+TIqi/6RPyXTarhUhUfi/n6fP6GEOQMyCJH7DNCNka/Ak/STkU4tF
	s0uNWIht+b6tUZZR6urkQ==
X-ME-Sender: <xms:w8zjaegJboIIqUAuJ-8XSuPgKt2fd8KvZflvcw5DhUQUkC9_bIFPGQ>
    <xme:w8zjaV6OzdIwzSZtjf_kylx6D0W8dzqjalDJb1o7xI6-GcFp8YsLNdMlEu6EIEEnH
    uJ0aJFWu7BrOrwHrJPY77YXGb8UNT1zmeLoscH9b-aJfwcpc0_H>
X-ME-Received: <xmr:w8zjaeakKNXU_Q8WJbchUSik-e1Vkv92wm1LviWUPueT3lEF77ZjCxy3eqeoKqPyhcjevl87rIJakfBK6QHa1R9JdLb6W2rxdeT3wqcFd2OCjGmvfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehfeegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhephefhjeeujeelhedtheetfedvgfdtleffuedujefhheegudefvdfhheeuvedu
    ueegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    gvrhhnugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepughjfihonhhgsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehjohgrnh
    hnvghlkhhoohhnghesghhmrghilhdrtghomhdprhgtphhtthhopehktghhvghnseguughn
    rdgtohhm
X-ME-Proxy: <xmx:w8zjaS4EHkTqjb34rj2cWQb0YPiQA0LROsZPP-teZge_UazmKTaZ6A>
    <xmx:w8zjaZDYBuyAUA-qi9GvKyHZmbFSkIU4-dvMZOEhyWHeFDdBE-8MlQ>
    <xmx:w8zjaQfvNy5jO1EfXJ7QNIh2-i_uo_WUa-OD8b7oKfRyj_ZveOvN4w>
    <xmx:w8zjaQJYPrGQ_36By9qDS8_H4pjeym1PMOrHW2AOY0FAGCeViKXQMA>
    <xmx:w8zjaRD0WhvBMzsvQbzlC7rX-7U7TNgcroKq46X2-kN4uWxQptgfiEmJ>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Apr 2026 14:26:10 -0400 (EDT)
Message-ID: <08b7f421-aa13-4527-a2e1-0fcf1e5035d8@bsbernd.com>
Date: Sat, 18 Apr 2026 20:26:09 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/25] Add a new daemonize API
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
 <20260326-fuse-init-before-mount-v2-4-b1ca8fcbf60f@bsbernd.com>
 <20260330175548.GS6202@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr
In-Reply-To: <20260330175548.GS6202@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/30/26 19:55, Darrick J. Wong wrote:
> On Thu, Mar 26, 2026 at 10:34:37PM +0100, Bernd Schubert wrote:
>> Existing example/ file systems do the fuse_daemonize() after
>> fuse_session_mount() - i.e. after the mount point is already
>> established. Though, these example/ daemons do not start
>> extra threads and do not need network initialization either.
>>
>> fuse_daemonize() also does not allow to return notification
>> from the forked child to the parent.
>>
>> Complex fuse file system daemons often want the order of
>> 1) fork - parent watches, child does the work
>>
>> Child:
>>     2) start extra threads and system initialization (like network
>>        connection and RDMA memory registration) from the fork child.
>>     3) Start the fuse session after everything else succeeded
>>
>> Parent:
>>     Report child initialization success or failure
>>
>> A new API is introduced to overcome the limitations of
>> fuse_daemonize()
>>
>> fuse_daemonize_start() - fork, but foreground process does not
>> terminate yet and watches the background.
>>
>> fuse_daemonize_success() / fuse_daemonize_fail() - background
>> daemon signals to the foreground process success or failure.
>>
>> fuse_daemonize_active() - helper function for the high level
>> interface, which needs to handle both APIs. fuse_daemonize()
>> is called within fuse_main(), which now needs to know if the caller
>> actually already used the new API itself.
>>
>> The object 'struct fuse_daemonize *' is allocated dynamically
>> and stored a global variable in fuse_daemonize.c, because
>> - high level fuse_main_real_versioned() needs to know
>> if already daemonized
>> - high level daemons do not have access to struct fuse_session
>> - FUSE_SYNC_INIT in later commits can only be done if the new
>> API (or a file system internal) daemonization is used.
>>
>> Signed-off-by: Bernd Schubert <bernd@bsbernd.com>
> 
> Only a couple nitpicks now...
> 
>> ---
>>  example/passthrough_hp.cc   |  18 ++-
>>  include/fuse_daemonize.h    |  74 +++++++++++
>>  include/meson.build         |   3 +-
>>  lib/fuse_daemonize.c        | 292 ++++++++++++++++++++++++++++++++++++++++++++
>>  lib/fuse_i.h                |   4 +-
>>  lib/fuse_lowlevel.c         |   3 +
>>  lib/fuse_versionscript      |   4 +
>>  lib/helper.c                |  13 +-
>>  lib/meson.build             |   3 +-
>>  test/test_want_conversion.c |   1 +
>>  10 files changed, 404 insertions(+), 11 deletions(-)
>>
>> diff --git a/example/passthrough_hp.cc b/example/passthrough_hp.cc
>> index 9f795c5546ee8312e1393c5b8fcebfd77724fb49..bad435077697e8832cf5a5195c17f2f873f2dfe6 100644
>> --- a/example/passthrough_hp.cc
>> +++ b/example/passthrough_hp.cc
>> @@ -55,6 +55,7 @@
>>  #include <errno.h>
>>  #include <ftw.h>
>>  #include <fuse_lowlevel.h>
>> +#include <fuse_daemonize.h>
>>  #include <inttypes.h>
>>  #include <string.h>
>>  #include <sys/file.h>
>> @@ -243,6 +244,9 @@ static void sfs_init(void *userdata, fuse_conn_info *conn)
>>  
>>  	/* Try a large IO by default */
>>  	conn->max_write = 4 * 1024 * 1024;
>> +
>> +	/* Signal successful init to parent */
>> +	fuse_daemonize_success();
>>  }
>>  
>>  static void sfs_getattr(fuse_req_t req, fuse_ino_t ino, fuse_file_info *fi)
>> @@ -1580,6 +1584,7 @@ int main(int argc, char *argv[])
>>  {
>>  	struct fuse_loop_config *loop_config = NULL;
>>  	void *teardown_watchog = NULL;
>> +	unsigned int daemon_flags = 0;
>>  
>>  	// Parse command line options
>>  	auto options{ parse_options(argc, argv) };
>> @@ -1638,10 +1643,14 @@ int main(int argc, char *argv[])
>>  
>>  	fuse_loop_cfg_set_clone_fd(loop_config, fs.clone_fd);
>>  
>> -	if (fuse_session_mount(se, argv[2]) != 0)
>> +	/* Start daemonization before mount so parent can report mount failure */
>> +	if (fs.foreground)
>> +		daemon_flags |= FUSE_DAEMONIZE_NO_BACKGROUND;
>> +	if (fuse_daemonize_start(daemon_flags) != 0)
>>  		goto err_out3;
>>  
>> -	fuse_daemonize(fs.foreground);
> 
> Should the old fuse_daemonize() no-op (or complain) if the client has
> already called fuse_daemonize_start()?  You've done something like that
> in fuse_main_real_versioned, so maybe it should be automatic.

Good point! I made it an error code in , but kept it graceful in
fuse_main_real_versioned(), because daemon has no good control if
fuse_main_real_versioned wants to daemonize. The option can be used by
both APIs.
Also going to add another commit that moves fuse_daemonize() from
helper.c to fuse_daemonize.c

> 
>> +	if (fuse_session_mount(se, argv[2]) != 0)
>> +		goto err_out4;
>>  
>>  	if (!fs.foreground)
>>  		fuse_log_enable_syslog("passthrough-hp", LOG_PID | LOG_CONS,
>> @@ -1650,7 +1659,7 @@ int main(int argc, char *argv[])
>>  	teardown_watchog = fuse_session_start_teardown_watchdog(
>>  		se, fs.root.stop_timeout_secs, NULL, NULL);
>>  	if (teardown_watchog == NULL)
>> -		goto err_out3;
>> +		goto err_out4;
>>  
>>  	if (options.count("single"))
>>  		ret = fuse_session_loop(se);
>> @@ -1659,6 +1668,9 @@ int main(int argc, char *argv[])
>>  
>>  	fuse_session_unmount(se);
>>  
>> +err_out4:
>> +	if (fuse_daemonize_is_active())
>> +		fuse_daemonize_fail(ret);
>>  err_out3:
>>  	fuse_remove_signal_handlers(se);
>>  err_out2:
>> diff --git a/include/fuse_daemonize.h b/include/fuse_daemonize.h
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..c35dddd668b399535c53b44ab06c65fc0b3ddefa
>> --- /dev/null
>> +++ b/include/fuse_daemonize.h
>> @@ -0,0 +1,74 @@
>> +/*
>> + * FUSE: Filesystem in Userspace
>> + * Copyright (C) 2026 Bernd Schubert <bsbernd.com>
>> + *
>> + * This program can be distributed under the terms of the GNU LGPLv2.
>> + * See the file COPYING.LIB.
>> + *
>> + */
>> +
>> +#ifndef FUSE_DAEMONIZE_H_
>> +#define FUSE_DAEMONIZE_H_
>> +
>> +#include <stdint.h>
>> +#include <stdbool.h>
>> +
>> +#ifdef __cplusplus
>> +extern "C" {
>> +#endif
>> +
>> +/**
>> + * Flags for fuse_daemonize_start()
>> + */
>> +#define FUSE_DAEMONIZE_NO_CHDIR      (1 << 0)
>> +#define FUSE_DAEMONIZE_NO_BACKGROUND (1 << 1)
>> +
>> +/**
>> + * Start daemonization process.
>> + *
>> + * Unless FUSE_DAEMONIZE_NO_BACKGROUND is set, this forks the process.
>> + * The parent waits for a signal from the child via fuse_daemonize_success()
>> + * or fuse_daemonize_fail().
>> + * The child returns from this call and continues setup.
>> + *
>> + * Unless FUSE_DAEMONIZE_NO_CHDIR is set, changes directory to "/".
>> + *
>> + * Must be called before fuse_session_mount().
>> + *
>> + * @param flags combination of FUSE_DAEMONIZE_* flags
>> + * @return 0 on success, negative errno on error
>> + */
>> +int fuse_daemonize_start(unsigned int flags);
>> +
>> +/**
>> + * Signal daemonization success to parent and cleanup.
>> + */
>> +void fuse_daemonize_success(void);
>> +
>> +/**
>> + * Signal daemonization failure to parent and cleanup.
>> + *
>> + * @param err error code to pass to parent
> 
> I think this should say explicitly that @err will become the exit code
> of the parent process.
> 
> It might also be useful to state that except for fuse_daemonize_start,
> all the other APIs must only be called from the child process.

Updated, also added fuse_daemonize_i.h, which has
fuse_daemonize_set_mounted() and for now also fuse_daemonize_success().
The latter is called at the end of _do_init() (FUSE_INIT handler) in
fuse_lowlevel.c now, instead of manually calling in the ->init() handlers.


> 
> --D
> 
>> + */
>> +void fuse_daemonize_fail(int err);
>> +
>> +/**
>> + * Check if daemonization is active and waiting for signal.
>> + *
>> + * @return true if active, false otherwise
>> + */
>> +bool fuse_daemonize_is_active(void);
>> +
>> +/**
>> + * Set mounted flag.
>> + *
>> + * Called from fuse_session_mount().
>> + */
>> +void fuse_daemonize_set_mounted(void);
>> +
>> +#ifdef __cplusplus
>> +}
>> +#endif
>> +
>> +#endif /* FUSE_DAEMONIZE_H_ */
>> +
>> diff --git a/include/meson.build b/include/meson.build
>> index bf671977a5a6a9142bd67aceabd8a919e3d968d0..cfbaf52ac5d84369e92948c631e2fcfdd04ac2eb 100644
>> --- a/include/meson.build
>> +++ b/include/meson.build
>> @@ -1,4 +1,5 @@
>>  libfuse_headers = [ 'fuse.h', 'fuse_common.h', 'fuse_lowlevel.h',
>> -	            'fuse_opt.h', 'cuse_lowlevel.h', 'fuse_log.h' ]
>> +	            'fuse_opt.h', 'cuse_lowlevel.h', 'fuse_log.h',
>> +	            'fuse_daemonize.h' ]
>>  
>>  install_headers(libfuse_headers, subdir: 'fuse3')
>> diff --git a/lib/fuse_daemonize.c b/lib/fuse_daemonize.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..865acad7db56dbe5ed8a1bee52e7353627e89b75
>> --- /dev/null
>> +++ b/lib/fuse_daemonize.c
>> @@ -0,0 +1,292 @@
>> +/*
>> + * FUSE: Filesystem in Userspace
>> + * Copyright (C) 2026 Bernd Schubert <bsbernd.com>
>> + *
>> + * This program can be distributed under the terms of the GNU LGPLv2.
>> + * See the file COPYING.LIB.
>> + */
>> +
>> +#define _GNU_SOURCE
>> +
>> +#include "fuse_daemonize.h"
>> +
>> +#include <fcntl.h>
>> +#include <poll.h>
>> +#include <pthread.h>
>> +#include <stdatomic.h>
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <sys/types.h>
>> +#include <unistd.h>
>> +#include <stdbool.h>
>> +#include <errno.h>
>> +
>> +/**
>> + * Status values for fuse_daemonize_success() and fuse_daemonize_fail()
>> + */
>> +#define FUSE_DAEMONIZE_SUCCESS 0
>> +#define FUSE_DAEMONIZE_FAILURE 1
>> +
>> +/* Private/internal data  */
>> +struct fuse_daemonize {
>> +	unsigned int flags;
>> +	int signal_pipe_wr;	/* write end for signaling parent */
>> +	int death_pipe_rd;	/* read end, POLLHUP when parent dies */
>> +	int stop_pipe_rd;	/* read end for stop signal */
>> +	int stop_pipe_wr;	/* write end for stop signal */
>> +	pthread_t watcher;
>> +	bool watcher_started;
>> +	_Atomic bool active;
>> +	_Atomic bool daemonized;
>> +	_Atomic bool mounted;
>> +};
>> +
>> +/* Global daemonization object pointer */
>> +static struct fuse_daemonize daemonize = {
>> +	.signal_pipe_wr = -1,
>> +	.death_pipe_rd = -1,
>> +	.stop_pipe_rd = -1,
>> +	.stop_pipe_wr = -1,
>> +};
>> +
>> +/* Watcher thread: polls for parent death or stop signal */
>> +static void *parent_watcher_thread(void *arg)
>> +{
>> +	struct fuse_daemonize *di = arg;
>> +	struct pollfd pfd[2];
>> +
>> +	pfd[0].fd = di->death_pipe_rd;
>> +	pfd[0].events = POLLIN;
>> +	pfd[1].fd = di->stop_pipe_rd;
>> +	pfd[1].events = POLLIN;
>> +
>> +	while (1) {
>> +		int rc = poll(pfd, 2, -1);
>> +
>> +		if (rc < 0)
>> +			continue;
>> +
>> +		/* Parent died - death pipe write end closed */
>> +		if (pfd[0].revents & (POLLHUP | POLLERR))
>> +			_exit(EXIT_FAILURE);
>> +
>> +		/* Stop signal received */
>> +		if (pfd[1].revents & POLLIN)
>> +			break;
>> +	}
>> +	return NULL;
>> +}
>> +
>> +static int start_parent_watcher(struct fuse_daemonize *daemonize)
>> +{
>> +	int rc;
>> +
>> +	rc = pthread_create(&daemonize->watcher, NULL, parent_watcher_thread,
>> +			    daemonize);
>> +	if (rc != 0) {
>> +		fprintf(stderr, "fuse_daemonize: pthread_create: %s\n",
>> +			strerror(rc));
>> +		return -rc;
>> +	}
>> +	daemonize->watcher_started = true;
>> +	return 0;
>> +}
>> +
>> +static void stop_parent_watcher(struct fuse_daemonize *daemonize)
>> +{
>> +	char byte = 0;
>> +
>> +	if (daemonize && daemonize->watcher_started) {
>> +		/* Signal watcher to stop */
>> +		if (write(daemonize->stop_pipe_wr, &byte, 1) != 1)
>> +			perror("fuse_daemonize: stop write");
>> +		pthread_join(daemonize->watcher, NULL);
>> +		daemonize->watcher_started = false;
>> +	}
>> +}
>> +
>> +static int daemonize_child(struct fuse_daemonize *daemonize)
>> +{
>> +	int stop_pipe[2], err = 0;
>> +
>> +	if (pipe(stop_pipe) == -1) {
>> +		err = -errno;
>> +		perror("fuse_daemonize_start: stop pipe");
>> +		return err;
>> +	}
>> +	daemonize->stop_pipe_rd = stop_pipe[0];
>> +	daemonize->stop_pipe_wr = stop_pipe[1];
>> +
>> +	if (setsid() == -1) {
>> +		err = -errno;
>> +		perror("fuse_daemonize_start: setsid");
>> +		goto err_close_stop;
>> +	}
>> +
>> +	/* Close stdin immediately */
>> +	int nullfd = open("/dev/null", O_RDWR, 0);
>> +
>> +	if (nullfd != -1) {
>> +		(void)dup2(nullfd, 0);
>> +		if (nullfd > 0)
>> +			close(nullfd);
>> +	}
>> +
>> +	/* Start watcher thread to detect parent death */
>> +	err = start_parent_watcher(daemonize);
>> +	if (err)
>> +		goto err_close_stop;
>> +
>> +	daemonize->daemonized = true;
>> +	return 0;
>> +
>> +err_close_stop:
>> +	close(daemonize->stop_pipe_rd);
>> +	close(daemonize->stop_pipe_wr);
>> +	return err;
>> +}
>> +
>> +/* Fork and daemonize. Returns 0 in child, never returns in parent. */
>> +static int do_daemonize(struct fuse_daemonize *daemonize)
>> +{
>> +	int signal_pipe[2], death_pipe[2], err;
>> +
>> +	if (pipe(signal_pipe) == -1) {
>> +		err = -errno;
>> +		perror("fuse_daemonize_start: signal pipe");
>> +		return err;
>> +	}
>> +
>> +	if (pipe(death_pipe) == -1) {
>> +		err = -errno;
>> +		perror("fuse_daemonize_start: death pipe");
>> +		close(signal_pipe[0]);
>> +		close(signal_pipe[1]);
>> +		return err;
>> +	}
>> +
>> +	switch (fork()) {
>> +	case -1:
>> +		err = -errno;
>> +		perror("fuse_daemonize_start: fork");
>> +		close(signal_pipe[0]);
>> +		close(signal_pipe[1]);
>> +		close(death_pipe[0]);
>> +		close(death_pipe[1]);
>> +		return err;
>> +
>> +	case 0:
>> +		/* Child: signal write end, death read end */
>> +		close(signal_pipe[0]);
>> +		close(death_pipe[1]);
>> +		daemonize->signal_pipe_wr = signal_pipe[1];
>> +		daemonize->death_pipe_rd = death_pipe[0];
>> +		return daemonize_child(daemonize);
>> +
>> +	default: {
>> +		/* Parent: signal read end, death write end (kept open) */
>> +		int status;
>> +		ssize_t res;
>> +
>> +		close(signal_pipe[1]);
>> +		close(death_pipe[0]);
>> +
>> +		res = read(signal_pipe[0], &status, sizeof(status));
>> +		close(signal_pipe[0]);
>> +		close(death_pipe[1]);
>> +
>> +		if (res != sizeof(status))
>> +			_exit(EXIT_FAILURE);
>> +		_exit(status);
>> +	}
>> +	}
>> +}
>> +
>> +int fuse_daemonize_start(unsigned int flags)
>> +{
>> +	struct fuse_daemonize *dm = &daemonize;
>> +	int err = 0;
>> +
>> +	dm->flags = flags;
>> +	dm->signal_pipe_wr = -1;
>> +	dm->death_pipe_rd = -1;
>> +	dm->stop_pipe_rd = -1;
>> +	dm->stop_pipe_wr = -1;
>> +	dm->active = true;
>> +
>> +	if (!(flags & FUSE_DAEMONIZE_NO_CHDIR))
>> +		(void)chdir("/");
>> +
>> +	if (!(flags & FUSE_DAEMONIZE_NO_BACKGROUND))
>> +		err = do_daemonize(dm);
>> +
>> +	return err;
>> +}
>> +
>> +static void close_if_valid(int *fd)
>> +{
>> +	if (*fd != -1) {
>> +		close(*fd);
>> +		*fd = -1;
>> +	}
>> +}
>> +
>> +static void fuse_daemonize_signal(int status)
>> +{
>> +	struct fuse_daemonize *dm = &daemonize;
>> +	int rc;
>> +
>> +	/* Warn because there might be races */
>> +	if (status == FUSE_DAEMONIZE_SUCCESS && !dm->mounted)
>> +		fprintf(stderr, "fuse daemonize success without being mounted\n");
>> +
>> +	dm->active = false;
>> +
>> +	/* Stop watcher before signaling - parent will exit after this */
>> +	stop_parent_watcher(dm);
>> +
>> +	/* Signal status to parent */
>> +	if (dm->signal_pipe_wr != -1) {
>> +		rc = write(dm->signal_pipe_wr, &status, sizeof(status));
>> +		if (rc != sizeof(status))
>> +			fprintf(stderr, "%s: write failed\n", __func__);
>> +	}
>> +
>> +	/* Redirect stdout/stderr to /dev/null on success */
>> +	if (status == FUSE_DAEMONIZE_SUCCESS && dm->daemonized) {
>> +		int nullfd = open("/dev/null", O_RDWR, 0);
>> +
>> +		if (nullfd != -1) {
>> +			(void)dup2(nullfd, 1);
>> +			(void)dup2(nullfd, 2);
>> +			if (nullfd > 2)
>> +				close(nullfd);
>> +		}
>> +	}
>> +
>> +	close_if_valid(&dm->signal_pipe_wr);
>> +	close_if_valid(&dm->death_pipe_rd);
>> +	close_if_valid(&dm->stop_pipe_rd);
>> +	close_if_valid(&dm->stop_pipe_wr);
>> +}
>> +
>> +void fuse_daemonize_success(void)
>> +{
>> +	fuse_daemonize_signal(FUSE_DAEMONIZE_SUCCESS);
>> +}
>> +
>> +void fuse_daemonize_fail(int err)
>> +{
>> +	fuse_daemonize_signal(err);
>> +}
>> +
>> +bool fuse_daemonize_is_active(void)
>> +{
>> +	return daemonize.daemonized || daemonize.active;
>> +}
>> +
>> +void fuse_daemonize_set_mounted(void)
>> +{
>> +	daemonize.mounted = true;
>> +}
>> diff --git a/lib/fuse_i.h b/lib/fuse_i.h
>> index 65d2f68f7f30918a3c3ee4d473796cb013428a8f..9e3c5dc5021e210a2778e975a37ab609af324010 100644
>> --- a/lib/fuse_i.h
>> +++ b/lib/fuse_i.h
>> @@ -17,7 +17,6 @@
>>  #include <semaphore.h>
>>  #include <stdint.h>
>>  #include <stdbool.h>
>> -#include <errno.h>
>>  #include <stdatomic.h>
>>  
>>  #define MIN(a, b) \
>> @@ -110,6 +109,9 @@ struct fuse_session {
>>  	/* true if reading requests from /dev/fuse are handled internally */
>>  	bool buf_reallocable;
>>  
>> +	/* synchronous FUSE_INIT support */
>> +	bool want_sync_init;
>> +
>>  	/* io_uring */
>>  	struct fuse_session_uring uring;
>>  
>> diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
>> index 3234f0ce3b246a4c2c40dc0757177de91b6608b2..ccff6a768f0b8c32469abda9405ff29623f3fff7 100644
>> --- a/lib/fuse_lowlevel.c
>> +++ b/lib/fuse_lowlevel.c
>> @@ -19,6 +19,7 @@
>>  #include "mount_util.h"
>>  #include "util.h"
>>  #include "fuse_uring_i.h"
>> +#include "fuse_daemonize.h"
>>  
>>  #include <pthread.h>
>>  #include <stdatomic.h>
>> @@ -4451,6 +4452,8 @@ int fuse_session_mount(struct fuse_session *se, const char *_mountpoint)
>>  	/* Save mountpoint */
>>  	se->mountpoint = mountpoint;
>>  
>> +	fuse_daemonize_set_mounted();
>> +
>>  	return 0;
>>  
>>  error_out:
>> diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
>> index cce09610316f4b0b1d6836dd0e63686342b70037..dc6ed0135fb8d82937c756c3fb04a7fcb48fe1f4 100644
>> --- a/lib/fuse_versionscript
>> +++ b/lib/fuse_versionscript
>> @@ -227,6 +227,10 @@ FUSE_3.19 {
>>  		fuse_session_start_teardown_watchdog;
>>  		fuse_session_stop_teardown_watchdog;
>>  		fuse_lowlevel_notify_prune;
>> +		fuse_daemonize_start;
>> +		fuse_daemonize_success;
>> +		fuse_daemonize_fail;
>> +		fuse_daemonize_is_active;
>>  } FUSE_3.18;
>>  
>>  # Local Variables:
>> diff --git a/lib/helper.c b/lib/helper.c
>> index 5c13b93a473181f027eba01e0bfefd78875ede3e..35285be19aa0cc390a432d16701b9eefa16ec12a 100644
>> --- a/lib/helper.c
>> +++ b/lib/helper.c
>> @@ -15,6 +15,7 @@
>>  #include "fuse_misc.h"
>>  #include "fuse_opt.h"
>>  #include "fuse_lowlevel.h"
>> +#include "fuse_daemonize.h"
>>  #include "mount_util.h"
>>  
>>  #include <stdio.h>
>> @@ -352,17 +353,19 @@ int fuse_main_real_versioned(int argc, char *argv[],
>>  		goto out1;
>>  	}
>>  
>> +	struct fuse_session *se = fuse_get_session(fuse);
>>  	if (fuse_mount(fuse,opts.mountpoint) != 0) {
>>  		res = 4;
>>  		goto out2;
>>  	}
>>  
>> -	if (fuse_daemonize(opts.foreground) != 0) {
>> -		res = 5;
>> -		goto out3;
>> +	if (!fuse_daemonize_is_active()) {
>> +		/* Avoid daemonizing if we are already daemonized by the newer API */
>> +		if (fuse_daemonize(opts.foreground) != 0) {
>> +			res = 5;
>> +			goto out3;
>> +		}
>>  	}
>> -
>> -	struct fuse_session *se = fuse_get_session(fuse);
>>  	if (fuse_set_signal_handlers(se) != 0) {
>>  		res = 6;
>>  		goto out3;
>> diff --git a/lib/meson.build b/lib/meson.build
>> index fcd95741c9d3748fa01d9ec52b417aca66745f26..5bd449ebffe7c9229df904d647d990c6c47f80b5 100644
>> --- a/lib/meson.build
>> +++ b/lib/meson.build
>> @@ -2,7 +2,8 @@ libfuse_sources = ['fuse.c', 'fuse_i.h', 'fuse_loop.c', 'fuse_loop_mt.c',
>>                     'fuse_lowlevel.c', 'fuse_misc.h', 'fuse_opt.c',
>>                     'fuse_signals.c', 'buffer.c', 'cuse_lowlevel.c',
>>                     'helper.c', 'modules/subdir.c', 'mount_util.c',
>> -                   'fuse_log.c', 'compat.c', 'util.c', 'util.h' ]
>> +                   'fuse_log.c', 'compat.c', 'util.c', 'util.h',
>> +                   'fuse_daemonize.c' ]
>>  
>>  if host_machine.system().startswith('linux')
>>     libfuse_sources += [ 'mount.c' ]
>> diff --git a/test/test_want_conversion.c b/test/test_want_conversion.c
>> index db731edbfe1be8230ae16b422f798603b4a3bb82..48e6dd2dc6084425a0462bba000563c6083160be 100644
>> --- a/test/test_want_conversion.c
>> +++ b/test/test_want_conversion.c
>> @@ -8,6 +8,7 @@
>>  #include <inttypes.h>
>>  #include <stdbool.h>
>>  #include <err.h>
>> +#include <errno.h>
>>  
>>  static void print_conn_info(const char *prefix, struct fuse_conn_info *conn)
>>  {
>>
>> -- 
>> 2.43.0
>>
>>

