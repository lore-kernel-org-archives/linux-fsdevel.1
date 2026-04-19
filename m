Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81EB7260F
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Apr 2026 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776620746; cv=none; b=eJoXcdJ14Yt6QO+zBXPed7jKdEDu9wL9weNeTU5LGZpO1Z3utiAHtK/rCi08JuqQn9LJARjxnCfz5fPo5iR+smJvFW7NwSKgZsXIR6GF7BL1N0sUUSDWVjDJauODz7RpKrsBbgOYY5kllhy4GhxrKq7+LclHBMGdnTgGcHjIo7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776620746; c=relaxed/simple;
	bh=w/NJUTofAqC+cYOk+sU86W3HaVYi1TCQUQ9ZRrVM2wo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IKs8pcnbQ7ZFAbMYkZXj3LUVk0MoNF/SOrj9S90eJIGUhnxJkomMin96MorcEAUGS5deUZOFP6IMNLtYo046SRwWjQW4LKdjRav3t6XQlnzAt0SWN/xBmJQj18xzZG0N2jpmg86J4vyv6Jk/X2T4MO68Rp8WGfYLQr4RKEdM9e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=Dm7EKdjz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d9Ue44l7; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="Dm7EKdjz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d9Ue44l7"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id D69D51D00064;
	Sun, 19 Apr 2026 13:45:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 19 Apr 2026 13:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776620742;
	 x=1776707142; bh=YfscX6tI6keU9HnZyhMwZ5HB+Lau5DDFQTjkig9wpXE=; b=
	Dm7EKdjzWCMJ35KmE4d5zrF6hAwpc3EVHVtr7jU9vvFU4ejMLA99+LQxS9N7X2nd
	rf+YgUZCFgZzczY41XiVP6zlMPgs/BUV93BYPaXJ3PvlBZ2kFaCtjoZ3X3gNSSsS
	vLo4QshotrTYlW5T0CNLnC8GjJ04u6pYIpKxX3INCqpAzkH1hXYDPoTCMmtNar4p
	GiZkzt0GD/SjRdBLDx93CS6WhVwJDA+Z3iwj/yWFEU2qLfklja/8IfRXQ8eIwEi7
	jvs8IooiuDEUZ1UjOYFvnolTmj6Ao5utDbIO3AgLm9NI3j0phGcCyzqr9rAg1iog
	Q9aK1eag8UBTL97EOb1XBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776620742; x=
	1776707142; bh=YfscX6tI6keU9HnZyhMwZ5HB+Lau5DDFQTjkig9wpXE=; b=d
	9Ue44l7wHcsy2lJYQPoR5AZe6cjfkymo5ToJMaQamHDAVWrtsYFQaDwfGD5Os4BR
	9guWVB1AsxfqzV6MNGZDcnz7vymUUf0rT4XKQsiCJYZdF533LqCPdtrB/GZIgquJ
	qctuOofHx/pS7v5fT5VxoV8AnleivPliYxXaQnJ0qtOMKbmFHNS5PsMB4DJAIKva
	13HHsfQDgb35goPTZlau/k57PwwyuaFCz+WCfnJrrkc2NBma5SUaE1oRONuZjZmg
	3aqClSXQ0y6ph5gMLnWAJlNq1SnhKS69bQVgXFcrkBNtbMCE4tO5SMnSfzBAtq0q
	8Kct7enGWY/f2vH4z5f7A==
X-ME-Sender: <xms:xhTlaZ_mcgBcZCXrykqLb0aL1BV67vlR8hk_1D2yfro9Wl9qs8UOlA>
    <xme:xhTlaRZNJODnEXmB1PAIlv4DuJc1kUHyh5g4cSbYCXB7dTvwI1pToNvfALBOF1iVe
    -zmjZaxqUoqPRfOrHg0batmKUD3bO_fXrFXO1ZNvT1TZV9rurw->
X-ME-Received: <xmr:xhTlaQ3xwXlHsxE7jMQvgS1gXUY5TRgk8QoUmi_nByZrdz8J4uHm4IN-8e59fGshInJk9QXkjjtCeM_Hq9Y_3WgULOrBPLOo-yOGz5T9mwWVYzY3Lw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehiedvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhephefhjeeujeelhedtheetfedvgfdtleffuedujefhheegudefvdfhheeuvedu
    ueegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    gvrhhnugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepughjfihonhhgsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehjohgrnh
    hnvghlkhhoohhnghesghhmrghilhdrtghomhdprhgtphhtthhopehktghhvghnseguughn
    rdgtohhmpdhrtghpthhtohepsghstghhuhgsvghrthesuggunhdrtghomh
X-ME-Proxy: <xmx:xhTlaUbADniFSR4oBxk44D7vVZT6BKBtZqVllM4_cay8T3-Jm1aFXA>
    <xmx:xhTlaQKRBLqXV4TzHpthav7cVTIgH_s4yeBLeUXr10bo3GaITc8oSQ>
    <xmx:xhTlabGoQUdiF7ZoGm8e88EMtyovysHWiCARtUBknz4-hivmEeebLg>
    <xmx:xhTlaftPuGM6_Wo0G6HwftXCYXhxV6nLT3ICZx7BNu4JEidjCrg3Mw>
    <xmx:xhTlaQuFJftVRI9xf2ntmh26xBGZYq1PCC63F8w39pCq7cC8K-Mp1LvU>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Apr 2026 13:45:41 -0400 (EDT)
Message-ID: <a83cb254-2b7f-4957-9e88-6f5d1dbc716a@bsbernd.com>
Date: Sun, 19 Apr 2026 19:45:39 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/25] Add support for the new linux mount API
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>,
 Bernd Schubert <bschubert@ddn.com>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
 <20260326-fuse-init-before-mount-v2-13-b1ca8fcbf60f@bsbernd.com>
 <20260330182731.GW6202@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr
In-Reply-To: <20260330182731.GW6202@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/30/26 20:27, Darrick J. Wong wrote:
> On Thu, Mar 26, 2026 at 10:34:46PM +0100, Bernd Schubert wrote:
>> From: Bernd Schubert <bschubert@ddn.com>
>>
>> So far only supported for fuse_session_mount(), which is called
>> from high and low level API, but not yet supported for
>> fuse_open_channel(), which used for privilege drop through
>> mount.fuse. Main goal for the new API is support for synchronous
>> FUSE_INIT and I don't think that is going to work with
>> fuse_open_channel(). At least not with io-uring support as long
>> as it is started from FUSE_INIT.
>>
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>> ---
>>  lib/fuse_lowlevel.c |  74 ++++++++-
>>  lib/meson.build     |   3 +
>>  lib/mount.c         |  27 +++-
>>  lib/mount_fsmount.c | 454 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  lib/mount_i_linux.h |  14 ++
>>  meson.build         |  19 ++-
>>  6 files changed, 583 insertions(+), 8 deletions(-)
>>
>> diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
>> index ccff6a768f0b8c32469abda9405ff29623f3fff7..a7be40cbb012361ad664a9ced3d38042ba52c681 100644
>> --- a/lib/fuse_lowlevel.c
>> +++ b/lib/fuse_lowlevel.c
>> @@ -20,6 +20,9 @@
>>  #include "util.h"
>>  #include "fuse_uring_i.h"
>>  #include "fuse_daemonize.h"
>> +#if defined(__linux__)
>> +#include "mount_i_linux.h"
>> +#endif
>>  
>>  #include <pthread.h>
>>  #include <stdatomic.h>
>> @@ -4398,6 +4401,63 @@ int fuse_session_custom_io_30(struct fuse_session *se,
>>  			offsetof(struct fuse_custom_io, clone_fd), fd);
>>  }
>>  
>> +#if defined(HAVE_NEW_MOUNT_API)
>> +static int fuse_session_mount_new_api(struct fuse_session *se,
>> +				      const char *mountpoint)
>> +{
>> +	int fd = -1;
>> +	int res, err;
>> +	char *mnt_opts = NULL;
>> +	char *mnt_opts_with_fd = NULL;
>> +	char fd_opt[32];
>> +
>> +	res = fuse_kern_mount_get_base_mnt_opts(se->mo, &mnt_opts);
>> +	err = -EIO;
>> +	if (res == -1) {
>> +		fuse_log(FUSE_LOG_ERR,
>> +			 "fuse: failed to get base mount options\n");
>> +		goto err;
>> +	}
>> +
>> +	fd = fuse_kern_mount_prepare(mountpoint, se->mo);
>> +	if (fd == -1) {
>> +		fuse_log(FUSE_LOG_ERR, "Mount preparation failed.\n");
>> +		err = -EIO;
>> +		goto err;
>> +	}
>> +
>> +	snprintf(fd_opt, sizeof(fd_opt), "fd=%i", fd);
>> +	if (fuse_opt_add_opt(&mnt_opts_with_fd, mnt_opts) == -1 ||
>> +	    fuse_opt_add_opt(&mnt_opts_with_fd, fd_opt) == -1) {
>> +		err = -ENOMEM;
>> +		goto err;
>> +	}
>> +
>> +	err = fuse_kern_fsmount_mo(mountpoint, se->mo, mnt_opts_with_fd);
>> +err:
>> +	if (err) {
>> +		if (fd >= 0)
>> +			close(fd);
>> +		fd = -1;
>> +		se->fd = -1;
>> +		se->error = -errno;
>> +	}
>> +
>> +	free(mnt_opts);
>> +	free(mnt_opts_with_fd);
>> +	return fd;
>> +}
>> +#else
>> +static int fuse_session_mount_new_api(struct fuse_session *se,
>> +				      const char *mountpoint)
>> +{
>> +	(void)se;
>> +	(void)mountpoint;
>> +
>> +	return -1;
>> +}
>> +#endif
>> +
>>  int fuse_session_mount(struct fuse_session *se, const char *_mountpoint)
>>  {
>>  	int fd;
>> @@ -4425,6 +4485,8 @@ int fuse_session_mount(struct fuse_session *se, const char *_mountpoint)
>>  			close(fd);
>>  	} while (fd >= 0 && fd <= 2);
>>  
>> +	/* Open channel */
>> +
>>  	/*
>>  	 * To allow FUSE daemons to run without privileges, the caller may open
>>  	 * /dev/fuse before launching the file system and pass on the file
>> @@ -4443,10 +4505,18 @@ int fuse_session_mount(struct fuse_session *se, const char *_mountpoint)
>>  		return 0;
>>  	}
>>  
>> -	/* Open channel */
>> +	/* new linux mount api */
>> +	fd = fuse_session_mount_new_api(se, mountpoint);
>> +	if (fd >= 0)
>> +		goto out;
>> +
>> +	/* fall back to old API */
>> +	se->error = 0; /* reset error of new api */
>>  	fd = fuse_kern_mount(mountpoint, se->mo);
>> -	if (fd == -1)
>> +	if (fd < 0)
>>  		goto error_out;
>> +
>> +out:
>>  	se->fd = fd;
>>  
>>  	/* Save mountpoint */
>> diff --git a/lib/meson.build b/lib/meson.build
>> index 5bd449ebffe7c9229df904d647d990c6c47f80b5..5fd738a589c5aba97a738d5eedbf0f9962e4adfc 100644
>> --- a/lib/meson.build
>> +++ b/lib/meson.build
>> @@ -7,6 +7,9 @@ libfuse_sources = ['fuse.c', 'fuse_i.h', 'fuse_loop.c', 'fuse_loop_mt.c',
>>  
>>  if host_machine.system().startswith('linux')
>>     libfuse_sources += [ 'mount.c' ]
>> +   if private_cfg.get('HAVE_NEW_MOUNT_API', false)
>> +      libfuse_sources += [ 'mount_fsmount.c' ]
>> +   endif
>>  else
>>     libfuse_sources += [ 'mount_bsd.c' ]
>>  endif
>> diff --git a/lib/mount.c b/lib/mount.c
>> index 43920a06ac03747595bde95441252e9cac77ce88..e8c65363d36a56f483f82434f642e785da4d0341 100644
>> --- a/lib/mount.c
>> +++ b/lib/mount.c
>> @@ -442,8 +442,8 @@ static int fuse_mount_fusermount(const char *mountpoint, struct mount_opts *mo,
>>  #define O_CLOEXEC 0
>>  #endif
>>  
>> -static int fuse_kern_mount_prepare(const char *mnt,
>> -				   struct mount_opts *mo)
>> +int fuse_kern_mount_prepare(const char *mnt,
>> +			    struct mount_opts *mo)
>>  {
>>  	char tmp[128];
>>  	const char *devname = fuse_mnt_get_devname();
>> @@ -493,6 +493,26 @@ out_close:
>>  	return -1;
>>  }
>>  
>> +#if defined(HAVE_NEW_MOUNT_API)
>> +/**
>> + * Wrapper for fuse_kern_fsmount that accepts struct mount_opts
>> + * @mnt: mountpoint
>> + * @mo: mount options
>> + * @mnt_opts: mount options to pass to the kernel
>> + *
>> + * Returns: 0 on success, -1 on failure with errno set
>> + */
>> +int fuse_kern_fsmount_mo(const char *mnt, struct mount_opts *mo,
>> +			 const char *mnt_opts)
>> +{
>> +	const char *devname = fuse_mnt_get_devname();
>> +
>> +	return fuse_kern_fsmount(mnt, mo->flags, mo->blkdev, mo->fsname,
>> +				 mo->subtype, devname, mo->kernel_opts,
>> +				 mnt_opts);
>> +}
>> +#endif
>> +
>>  /**
>>   * Complete the mount operation with an already-opened fd
>>   * @mnt: mountpoint
>> @@ -636,8 +656,7 @@ void destroy_mount_opts(struct mount_opts *mo)
>>  	free(mo);
>>  }
>>  
>> -static int fuse_kern_mount_get_base_mnt_opts(struct mount_opts *mo,
>> -					     char **mnt_optsp)
>> +int fuse_kern_mount_get_base_mnt_opts(struct mount_opts *mo, char **mnt_optsp)
>>  {
>>  	if (get_mnt_flag_opts(mnt_optsp, mo->flags) == -1)
>>  		return -1;
>> diff --git a/lib/mount_fsmount.c b/lib/mount_fsmount.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..fbe3647a8923828dba819458b815c21bbd2beaad
>> --- /dev/null
>> +++ b/lib/mount_fsmount.c
>> @@ -0,0 +1,454 @@
>> +/*
>> + *  FUSE: Filesystem in Userspace
>> + *  Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
>> + *                2026 Bernd Schubert <bernd@bsbernd.com>
>> + *
>> + * New Linux mount API (fsopen/fsconfig/fsmount/move_mount) support.
>> + *
>> + *  This program can be distributed under the terms of the GNU LGPLv2.
>> + *  See the file LGPL2.txt.
>> + */
>> +
>> +#define _GNU_SOURCE
>> +
>> +#include "fuse_config.h"
>> +#include "fuse_misc.h"
>> +#include "mount_util.h"
>> +#include "mount_i_linux.h"
>> +
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <unistd.h>
>> +#include <string.h>
>> +#include <fcntl.h>
>> +#include <errno.h>
>> +#include <sys/mount.h>
>> +#include <sys/syscall.h>
>> +
>> +/*
>> + * Mount attribute flags for fsmount() - from linux/mount.h
>> + * This file is only compiled conditionally when support for the new
>> + * mount API is detected - only flags that were not in the initial linux
>> + * commit introducing that API are defined here.
>> + */
>> +#ifndef MOUNT_ATTR_NOSYMFOLLOW
>> +#define MOUNT_ATTR_NOSYMFOLLOW  0x00200000
>> +#endif
>> +
>> +/*
>> + * Convert MS_* mount flags to MOUNT_ATTR_* mount attributes.
>> + * These flags are passed to fsmount(), not fsconfig().
>> + * Mount attributes control mount-point level behavior.
>> + */
>> +static unsigned long ms_flags_to_mount_attrs(unsigned long flags)
>> +{
>> +	unsigned long attrs = 0;
>> +
>> +	if (flags & MS_NOSUID)
>> +		attrs |= MOUNT_ATTR_NOSUID;
>> +	if (flags & MS_NODEV)
>> +		attrs |= MOUNT_ATTR_NODEV;
>> +	if (flags & MS_NOEXEC)
>> +		attrs |= MOUNT_ATTR_NOEXEC;
>> +	if (flags & MS_NOATIME)
>> +		attrs |= MOUNT_ATTR_NOATIME;
>> +	else if (flags & MS_RELATIME)
>> +		attrs |= MOUNT_ATTR_RELATIME;
>> +	else if (flags & MS_STRICTATIME)
>> +		attrs |= MOUNT_ATTR_STRICTATIME;
>> +	if (flags & MS_NODIRATIME)
>> +		attrs |= MOUNT_ATTR_NODIRATIME;
>> +	if (flags & MS_NOSYMFOLLOW)
>> +		attrs |= MOUNT_ATTR_NOSYMFOLLOW;
>> +
>> +	return attrs;
>> +}
>> +
>> +/*
>> + * Read and print kernel error messages from fsopen fd.
>> + * The kernel can provide detailed error/warning/info messages via the
>> + * filesystem context fd that are more informative than strerror(errno).
>> + */
>> +static void log_fsconfig_kmsg(int fd)
>> +{
>> +	char buf[4096];
>> +	int err, sz = 0;
>> +
>> +	err = errno;
>> +
>> +	while ((sz = read(fd, buf, sizeof(buf) - 1)) != -1) {
>> +		if (sz <= 0)
>> +			continue;
>> +		if (buf[sz - 1] == '\n')
>> +			buf[--sz] = '\0';
>> +		else
>> +			buf[sz] = '\0';
>> +
>> +		if (!*buf)
>> +			continue;
>> +
>> +		switch (buf[0]) {
>> +		case 'e':
>> +			fprintf(stderr, " Error: %s\n", buf + 2);
>> +			break;
>> +		case 'w':
>> +			fprintf(stderr, " Warning: %s\n", buf + 2);
>> +			break;
>> +		case 'i':
>> +			fprintf(stderr, " Info: %s\n", buf + 2);
>> +			break;
>> +		default:
>> +			fprintf(stderr, " %s\n", buf);
>> +			break;
>> +		}
>> +	}
>> +
>> +	errno = err;
>> +}
>> +
>> +/*
>> + * Apply VFS superblock flags to the filesystem context.
>> + * Only handles flags that are filesystem parameters (ro, sync, dirsync).
>> + * Mount attributes (nosuid, nodev, etc.) are handled separately via fsmount().
>> + */
>> +static int apply_mount_flags(int fsfd, unsigned long flags)
>> +{
>> +	int res, save_errno;
>> +
>> +	/* Handle read-only flag */
>> +	if (flags & MS_RDONLY) {
>> +		const char *flag = "ro";
>> +
>> +		res = fsconfig(fsfd, FSCONFIG_SET_FLAG, flag, NULL, 0);
>> +		if (res == -1) {
>> +			save_errno = errno;
>> +			fprintf(stderr, "fuse: fsconfig SET_FLAG %s failed:", flag);
>> +			log_fsconfig_kmsg(fsfd);
>> +			return -save_errno;
>> +		}
>> +	}
>> +
>> +	/* Handle sync flag */
>> +	if (flags & MS_SYNCHRONOUS) {
>> +		const char *flag = "sync";
>> +
>> +		res = fsconfig(fsfd, FSCONFIG_SET_FLAG, flag, NULL, 0);
>> +		if (res == -1) {
>> +			save_errno = errno;
>> +			fprintf(stderr, "fuse: fsconfig SET_FLAG %s failed:", flag);
>> +			log_fsconfig_kmsg(fsfd);
>> +			return -save_errno;
>> +		}
>> +	}
>> +
>> +#ifndef __NetBSD__
> 
> This is always true, right?  Only Linux has fsmount.
> 
>> +	/* Handle dirsync flag */
>> +	if (flags & MS_DIRSYNC) {
>> +		const char *flag = "dirsync";
>> +
>> +		res = fsconfig(fsfd, FSCONFIG_SET_FLAG, flag, NULL, 0);
>> +		if (res == -1) {
>> +			save_errno = errno;
>> +			fprintf(stderr, "fuse: fsconfig SET_FLAG %s failed:", flag);
>> +			log_fsconfig_kmsg(fsfd);
>> +			return -save_errno;
>> +		}
>> +	}
>> +#endif
>> +
>> +	return 0;
> 
> I did this a bit differently:
> 
> 
> static const struct ms_to_str_map strflags[] = {
> 	{ MS_SYNCHRONOUS,	"sync" },
> 	{ MS_DIRSYNC,		"dirsync" },
> 	{ MS_LAZYTIME,		"lazytime" },
> 	{ 0, 0 },
> };
> 
> static int set_ms_flags(struct mount_service *mo, unsigned long ms_flags)
> {
> 	const struct ms_to_str_map *i;
> 	int ret;
> 
> 	for (i = strflags; i->ms_flag != 0; i++) {
> 		if (!(ms_flags & i->ms_flag))
> 			continue;
> 
> 		ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_FLAG, i->string,
> 			       NULL, 0);
> 		if (ret) {
> 			int error = errno;
> 
> 			fprintf(stderr, "%s: set %s option: %s\n",
> 				mo->msgtag, i->string, strerror(error));
> 			emit_fsconfig_messages(mo);
> 
> 			errno = error;
> 			return -1;
> 		}
> 		ms_flags &= ~i->ms_flag;
> 	}
> 
> 	/*
> 	 * We can't translate all the supplied MS_ flags into MOUNT_ATTR_ flags
> 	 * or string flags!  Return a magic code so the caller will fall back
> 	 * to regular mount(2).
> 	 */
> 	return ms_flags ? -2 : 0;
> }
> 
> That way you can always fall back to classic mount() instead of quietly
> dropping an MS_ flag here if one ever gets added without a corresponding
> MOUNT_ATTR_ flag.  AFAICT there aren't any that *would* get dropped and
> you can verify via code inspection, but why not avoid the logic bomb?

I took your function, just slightly modified it, like we can always fall
back from new mount api to classic.

> 
>> +}
>> +
>> +static int apply_opt_fd(int fsfd, const char *value)
>> +{
>> +	int res, save_errno;
>> +
>> +	/* The fd parameter is a u32 value, not a file descriptor to pass */
>> +	res = fsconfig(fsfd, FSCONFIG_SET_STRING, "fd", value, 0);
>> +	if (res == -1) {
>> +		save_errno = errno;
>> +		fprintf(stderr, "fuse: fsconfig SET_STRING fd=%s failed:",
>> +			value);
>> +		log_fsconfig_kmsg(fsfd);
>> +		return -save_errno;
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int apply_opt_string(int fsfd, const char *key, const char *value)
>> +{
>> +	int res, save_errno;
>> +
>> +	res = fsconfig(fsfd, FSCONFIG_SET_STRING, key, value, 0);
>> +	save_errno = errno;
>> +	if (res == -1) {
>> +		log_fsconfig_kmsg(fsfd);
>> +		fprintf(stderr, "fuse: fsconfig SET_STRING %s=%s failed: ",
>> +			key, value);
>> +		return -save_errno;
> 
> I think this function should call fprintf and log_fsconfig_kmsg in the
> same order as the other two apply_opt_* functions.
> 
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int apply_opt_flag(int fsfd, const char *opt)
>> +{
>> +	int res, save_errno;
>> +
>> +	res = fsconfig(fsfd, FSCONFIG_SET_FLAG, opt, NULL, 0);
>> +	if (res == -1) {
>> +		save_errno = errno;
>> +		fprintf(stderr, "fuse: fsconfig SET_FLAG %s failed:", opt);
>> +		log_fsconfig_kmsg(fsfd);
>> +		return -save_errno;
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int apply_opt_key_value(int fsfd, char *opt)
>> +{
>> +	char *eq;
>> +	const char *key;
>> +	const char *value;
>> +
>> +	eq = strchr(opt, '=');
>> +	if (!eq)
>> +		return apply_opt_flag(fsfd, opt);
>> +
>> +	*eq = '\0';
>> +	key = opt;
>> +	value = eq + 1;
>> +
>> +	if (strcmp(key, "fd") == 0)
>> +		return apply_opt_fd(fsfd, value);
>> +
>> +	return apply_opt_string(fsfd, key, value);
>> +}
>> +
>> +/**
>> + * Check if an option is a mount attribute (handled by fsmount, not fsconfig)
>> + */
>> +static int is_mount_attr_opt(const char *opt)
>> +{
>> +	/* These options are mount attributes passed to fsmount(), not fsconfig() */
>> +	return strcmp(opt, "nosuid") == 0 ||
>> +	       strcmp(opt, "suid") == 0 ||
>> +	       strcmp(opt, "nodev") == 0 ||
>> +	       strcmp(opt, "dev") == 0 ||
>> +	       strcmp(opt, "noexec") == 0 ||
>> +	       strcmp(opt, "exec") == 0 ||
>> +	       strcmp(opt, "noatime") == 0 ||
>> +	       strcmp(opt, "atime") == 0 ||
>> +	       strcmp(opt, "nodiratime") == 0 ||
>> +	       strcmp(opt, "diratime") == 0 ||
>> +	       strcmp(opt, "relatime") == 0 ||
>> +	       strcmp(opt, "norelatime") == 0 ||
>> +	       strcmp(opt, "strictatime") == 0 ||
>> +	       strcmp(opt, "nostrictatime") == 0 ||
>> +	       strcmp(opt, "nosymfollow") == 0 ||
>> +	       strcmp(opt, "symfollow") == 0;
> 
> /me wonders if this should be walking the mount_flags array instead of
> opencoding the strings here?

Yes, much better, encoded into

const struct mount_flags mount_flags[] = {
	/*   opt              flag        on  safe  fsconfig/fsmount */
	{"rw",           MS_RDONLY,        0,  1,    0},  /* fsconfig */
	{"ro",           MS_RDONLY,        1,  1,    0},  /* fsconfig */
	{"suid",         MS_NOSUID,        0,  0,    1},  /* fsmount  */
...

as preparation patch.


Thanks,
Bernd
