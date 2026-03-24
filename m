Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364DE347516
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774383368; cv=none; b=cpJBkk6mBN66jhqCAmImxM+4+8f+zFYMlgxGlL3bJ93XQodYVoIKpC7DY7JOjzQ1VKRV0Y72XLSn8U/dH6yQk5YMIcQXniiMilfStMIq5zrb9yIudUY+YTWAgnb3XjzpO58m8/xPR7INe2pjG8/PsaU3o3dKhtyZkN2e5WemfyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774383368; c=relaxed/simple;
	bh=yMaaB7Z7gwoBDYHxpVVMYhZgQ5+PqtVomB02aoG2loQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VSk5EkhwyC/gGCxo/lXzsd/QKPcJ5ofL08xHVOK/fwoDScBREiyaCTxcXMioc0nPJKGGInNS/+emfBV3hZ0x31ld05XaGPy2Blkt3ubDxXiuDYjXGXdwRYUjnh/732F8L5gUVaHqjfgeTHveltcZvbg2aDP5Wn3gXrEF56k+dWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=ayWkE/ju; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tbi1qrzb; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="ayWkE/ju";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tbi1qrzb"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 521871400049;
	Tue, 24 Mar 2026 16:16:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 24 Mar 2026 16:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774383365;
	 x=1774469765; bh=RkuVkLPKmSUbWonYQyHcO6ZPgEX3/5NrFz9kmC+kYHc=; b=
	ayWkE/juDOuZh7MJi4N1fksVVcmCH7GhV8s1qAxspUkM4U1BkbNSERmMU1mjwYBx
	cGfaqNa9KTFDdxqIJOSgoHwWuJ6Kpl1nmHiIVP9XoQYhHm3EVzdXvqbdqChpbYIM
	r0B2hTRFy7qavH1zWrub4kBlXnTKE0QmsWRaGXzNyd0uHsIQOxTmmU23uH1XvRfJ
	BY1EcNjiN9VoJBOrRqc9SYbKkQJXQH/ddMaH/ACc3JCEmc5NG1kCONXQmuQie5Z/
	uFB7QukngfJFYuzMlpq6dABLQC7z36UqR/9jm2mRLahzUe0z5mdeR/F1gX+2kN5l
	bNOMGY+oQOxNV3WPRwrLuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774383365; x=
	1774469765; bh=RkuVkLPKmSUbWonYQyHcO6ZPgEX3/5NrFz9kmC+kYHc=; b=T
	bi1qrzbz929+SMEE1IPXICG6xiO280KVNAb9XUeHSx9voIYPJXdCZ+YVv7NV6uxC
	XWgOtVLUlIxzouLSH2Qq10uKLq5tlmyeMD/9lGXRXhoCz+hPtFGmED0H3WXZuxTC
	EQCv6MJorFCdbgIekX81qbPeNNbmcyzirX5jDel+pc8uMuMwBN5fJFIX/FAPQK9z
	jsR1xP189IOa4IdOHueVCA14mo9GbNqwC6lZ3E0F205Hqe+KrusPgZGgu0C551j/
	qdLw8exH/WfJ03UpG3jIBOG0GOnlcaYpbh6gN3dNYD3mQzEdKcr0mpSqeD6IfTLt
	bjSl86OIW8PlfpQqLwrBQ==
X-ME-Sender: <xms:BfHCaVKLLhmZBNr0WTwyXoFDC1UOYlGOoF-F1UvZgpUJARAU_iKajw>
    <xme:BfHCaYDkwTBECcn73S_3fQzgoK5FZgdw8HC7EBdxzkAgb4XKf-7GWD9Iwyhswv3zz
    gfVyNhqIKw4xBd9WeaEr7nKkSnNsSnpIr01tSDjF88MVfvenbq7>
X-ME-Received: <xmr:BfHCaWDd6z7Z6b5mJKkvDsqE4FrvRubV9AxpGbXpkjhCk_8Amff6WhvrlsZQOSdIxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddvheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeejueefhfeikeejheelgfdvjedvieejheduieefueekleeufedulefgueeh
    feejudenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgu
    segsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepjhhorghnnhgvlhhk
    ohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghstghhuhgsvghrthesuggunh
    drtghomh
X-ME-Proxy: <xmx:BfHCaSCsco1tQJvBOoDD16ABzuiFMI-WjQK_EmlQ6jm4Om8j8JgSCA>
    <xmx:BfHCaZrGDePWFDblB1YFkhYgHm037fgjWoaE8zO7PRa1srL18ISZhQ>
    <xmx:BfHCaUlFQLPV71zEg81-uwLQdnajnkyAauwKlFeKdGDdB5NRBXJVuA>
    <xmx:BfHCaRxeIpTosKj6X3jE-g_mDNQEdxDg-Q2I3uYcpQ9U8qp4-cbUDQ>
    <xmx:BfHCaYx4uocxBbgvHhsxyohJgt8Z-WjS-uFoWBKBie-cSe23iWXMWHi2>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 16:16:04 -0400 (EDT)
Message-ID: <4c5f026f-e5ea-4af0-91f0-389bcc666d3f@bsbernd.com>
Date: Tue, 24 Mar 2026 21:16:03 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/19] Add support for the new linux mount API
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bschubert@ddn.com>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
 <20260323-fuse-init-before-mount-v1-11-a52d3040af69@bsbernd.com>
 <20260323234243.GL6202@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US
In-Reply-To: <20260323234243.GL6202@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/24/26 00:42, Darrick J. Wong wrote:
> On Mon, Mar 23, 2026 at 06:45:06PM +0100, Bernd Schubert wrote:
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
>>  lib/fuse_lowlevel.c |  75 +++++++++-
>>  lib/meson.build     |   3 +
>>  lib/mount.c         |  27 +++-
>>  lib/mount_fsmount.c | 405 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  lib/mount_i_linux.h |  14 ++
>>  meson.build         |  19 ++-
>>  6 files changed, 535 insertions(+), 8 deletions(-)
>>
>> diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
>> index 4a1c7c4c02a05706e077a7ea89fab3c81bfe22cd..626233df20f49fa89cd9327f94340169d7061f75 100644
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
>> @@ -4398,6 +4401,64 @@ int fuse_session_custom_io_30(struct fuse_session *se,
>>  			offsetof(struct fuse_custom_io, clone_fd), fd);
>>  }
>>  
>> +#if defined(HAVE_NEW_MOUNT_API)
>> +/* Only linux supports sync FUSE_INIT so far */
> 
> What does synchronous FUSE_INIT have to do with fsmount()?
> Does it not work with the old mount(2)?

So we had this discussion with Miklos in the earlier version of the
patches here https://github.com/libfuse/libfuse/pull/1367
where Miklos has noticed the possible deadlock and suggested the new 
mount API. I think Miklos kernel patch solves that, without the new 
mount API, but then I'm now hesitating to make the code even more
complex by supported old and new API. Until BSD gains that sync-fuse
init, this is a Linux only feature and was added after new the new mount
api. 

The comment is not right for this commit, though.

> 
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
>> +	if (res == -1) {
>> +		fuse_log(FUSE_LOG_ERR,
>> +			 "fuse: failed to get base mount options\n");
>> +		err = -EIO;
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
>> @@ -4425,6 +4486,8 @@ int fuse_session_mount(struct fuse_session *se, const char *_mountpoint)
>>  			close(fd);
>>  	} while (fd >= 0 && fd <= 2);
>>  
>> +	/* Open channel */
>> +
>>  	/*
>>  	 * To allow FUSE daemons to run without privileges, the caller may open
>>  	 * /dev/fuse before launching the file system and pass on the file
>> @@ -4443,10 +4506,18 @@ int fuse_session_mount(struct fuse_session *se, const char *_mountpoint)
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
>> index b3ee9ba4c0a74c1d0d55f916e7046e064f8468b0..30fd4d2f9bbb84c817b2363b2075456acd1c1255 100644
>> --- a/lib/mount.c
>> +++ b/lib/mount.c
>> @@ -449,8 +449,8 @@ static int fuse_mount_fusermount(const char *mountpoint, struct mount_opts *mo,
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
>> @@ -500,6 +500,26 @@ out_close:
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
>> @@ -643,8 +663,7 @@ void destroy_mount_opts(struct mount_opts *mo)
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
>> index 0000000000000000000000000000000000000000..cba998bc60c783a5edc0c16570f7e5512b7f1253
>> --- /dev/null
>> +++ b/lib/mount_fsmount.c
>> @@ -0,0 +1,405 @@
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
>> +/* Mount attribute flags for fsmount() - from linux/mount.h */
>> +#ifndef MOUNT_ATTR_RDONLY
>> +#define MOUNT_ATTR_RDONLY       0x00000001
>> +#endif
>> +#ifndef MOUNT_ATTR_NOSUID
>> +#define MOUNT_ATTR_NOSUID       0x00000002
>> +#endif
>> +#ifndef MOUNT_ATTR_NODEV
>> +#define MOUNT_ATTR_NODEV        0x00000004
>> +#endif
>> +#ifndef MOUNT_ATTR_NOEXEC
>> +#define MOUNT_ATTR_NOEXEC       0x00000008
>> +#endif
>> +#ifndef MOUNT_ATTR__ATIME
>> +#define MOUNT_ATTR__ATIME       0x00000070
>> +#endif
>> +#ifndef MOUNT_ATTR_RELATIME
>> +#define MOUNT_ATTR_RELATIME     0x00000000
>> +#endif
>> +#ifndef MOUNT_ATTR_NOATIME
>> +#define MOUNT_ATTR_NOATIME      0x00000010
>> +#endif
>> +#ifndef MOUNT_ATTR_STRICTATIME
>> +#define MOUNT_ATTR_STRICTATIME  0x00000020
>> +#endif
>> +#ifndef MOUNT_ATTR_NODIRATIME
>> +#define MOUNT_ATTR_NODIRATIME   0x00000080
>> +#endif
>> +#ifndef MOUNT_ATTR_NOSYMFOLLOW
>> +#define MOUNT_ATTR_NOSYMFOLLOW  0x00200000
>> +#endif
> 
> /me notes that all MOUNT_ATTR_ before NOSYMFOLLOW were introduced in the
> initial commit so if the meson test thinks the new fsmount api is
> present then you can rely on flags being defined.

Thanks, removed those flags and added a comment.

> 
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
>> + * Apply VFS superblock flags to the filesystem context.
>> + * Only handles flags that are filesystem parameters (ro, sync, dirsync).
>> + * Mount attributes (nosuid, nodev, etc.) are handled separately via fsmount().
>> + */
>> +static int apply_mount_flags(int fsfd, unsigned long flags)
>> +{
>> +	int res;
>> +
>> +	/* Handle read-only flag */
>> +	if (flags & MS_RDONLY) {
>> +		res = fsconfig(fsfd, FSCONFIG_SET_FLAG, "ro", NULL, 0);
>> +		if (res == -1) {
>> +			fprintf(stderr,
>> +				"fuse: fsconfig SET_FLAG ro failed: %s\n",
>> +				strerror(errno));
>> +			return -errno;
>> +		}
>> +	}
>> +
>> +	/* Handle sync flag */
>> +	if (flags & MS_SYNCHRONOUS) {
>> +		res = fsconfig(fsfd, FSCONFIG_SET_FLAG, "sync", NULL, 0);
>> +		if (res == -1) {
>> +			fprintf(stderr,
>> +				"fuse: fsconfig SET_FLAG sync failed: %s\n",
>> +				strerror(errno));
>> +			return -errno;
>> +		}
>> +	}
>> +
>> +#ifndef __NetBSD__
>> +	/* Handle dirsync flag */
>> +	if (flags & MS_DIRSYNC) {
>> +		res = fsconfig(fsfd, FSCONFIG_SET_FLAG, "dirsync", NULL, 0);
>> +		if (res == -1) {
>> +			fprintf(stderr,
>> +				"fuse: fsconfig SET_FLAG dirsync failed: %s\n",
>> +				strerror(errno));
>> +			return -errno;
>> +		}
>> +	}
>> +#endif
>> +
>> +	return 0;
>> +}
> 
> Oh, nice treatment of the MS_ flags that don't have a corresponding
> MOUNT_ATTR_ flag.  I should incorporate that into mount_service.c.
> 
>> +
>> +static int apply_opt_fd(int fsfd, const char *value)
>> +{
>> +	int res;
>> +
>> +	/* The fd parameter is a u32 value, not a file descriptor to pass */
>> +	res = fsconfig(fsfd, FSCONFIG_SET_STRING, "fd", value, 0);
>> +	if (res == -1) {
>> +		fprintf(stderr, "fuse: fsconfig SET_STRING fd=%s failed: %s\n",
>> +			value, strerror(errno));
>> +		return -errno;
> 
> Did you know that you can read the kernel's error messages from the
> fsopen fd?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/libfuse.git/tree/util/mount_service.c?h=fuse-service-container&id=d02bbab680ab4689bbd5e274735e91bd38e5f47f#n693

Ah nice, I kind of copied over this function now.

> 
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int apply_opt_string(int fsfd, const char *key, const char *value)
>> +{
>> +	int res;
>> +
>> +	res = fsconfig(fsfd, FSCONFIG_SET_STRING, key, value, 0);
>> +	if (res == -1) {
>> +		fprintf(stderr,
>> +			"fuse: fsconfig SET_STRING %s=%s failed: %s\n",
>> +			key, value, strerror(errno));
>> +		return -errno;
> 
> I think you have to save errno explicitly here, because fprintf and
> strerror could fail and set errno to something else.  For example, if
> fsconfig returns EINVAL but stderr points to a file on a completely full
> filesystem, the ENOSPC from the fprintf call (or more likely the write()
> underneath it) will obliterate the EINVAL.

Absolutely, had slipped through. Thank you!

> 
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int apply_opt_flag(int fsfd, const char *opt)
>> +{
>> +	int res;
>> +
>> +	res = fsconfig(fsfd, FSCONFIG_SET_FLAG, opt, NULL, 0);
>> +	if (res == -1) {
>> +		fprintf(stderr, "fuse: fsconfig SET_FLAG %s failed: %s\n",
>> +			opt, strerror(errno));
>> +		return -errno;
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
>> +}
>> +
>> +/*
>> + * Parse kernel options string and apply via fsconfig
>> + * Options are comma-separated key=value pairs
>> + */
>> +static int apply_mount_opts(int fsfd, const char *opts)
>> +{
>> +	char *opts_copy;
>> +	char *opt;
>> +	char *saveptr;
>> +	int res;
>> +
>> +	if (!opts || !*opts)
>> +		return 0;
>> +
>> +	opts_copy = strdup(opts);
>> +	if (!opts_copy) {
>> +		fprintf(stderr, "fuse: failed to allocate memory\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	opt = strtok_r(opts_copy, ",", &saveptr);
>> +	while (opt) {
>> +		/* Skip mount attributes - they're handled by fsmount(), not fsconfig() */
>> +		if (!is_mount_attr_opt(opt)) {
>> +			res = apply_opt_key_value(fsfd, opt);
> 
> Does fuse_session_new_versioned convert those magic string flags from
> is_mount_attr_opt into their MS_* equivalents such that apply_mount_opts
> won't see the string versions?

Comment updated to

		/*
		 * Skip mount attributes, they're handled by fsmount()
		 * not fsconfig().
		 *
		 * These string options (nosuid, nodev, etc.) are reconstructed
		 * from MS_* flags by get_mnt_flag_opts() in lib/mount.c and
		 * get_mnt_opts() in util/fusermount.c. Both the library path
		 * (via fuse_kern_mount_get_base_mnt_opts) and fusermount3 path
		 * rebuild these strings from the flags bitmask and pass them in
		 * mnt_opts. They must be filtered here because they are mount
		 * attributes (passed to fsmount via MOUNT_ATTR_*), not
		 * filesystem parameters (which would be passed to fsconfig).
		 */
		if (!is_mount_attr_opt(opt)) {


> 
>> +			if (res < 0) {
>> +				free(opts_copy);
>> +				return res;
>> +			}
>> +		}
>> +		opt = strtok_r(NULL, ",", &saveptr);
>> +	}
>> +
>> +	free(opts_copy);
>> +	return 0;
>> +}
>> +
>> +
>> +/**
>> + * Mount using the new Linux mount API (fsopen/fsconfig/fsmount/move_mount)
>> + * @mnt: mountpoint
>> + * @flags: mount flags (MS_NOSUID, MS_NODEV, etc.)
>> + * @blkdev: 1 for fuseblk, 0 for fuse
>> + * @fsname: filesystem name (or NULL)
>> + * @subtype: filesystem subtype (or NULL)
>> + * @source_dev: device name for building source string
>> + * @kernel_opts: kernel mount options string
>> + * @mnt_opts: additional mount options to pass to the kernel
>> + *
>> + * Returns: 0 on success, -1 on failure with errno set
>> + */
>> +int fuse_kern_fsmount(const char *mnt, unsigned long flags, int blkdev,
>> +		      const char *fsname, const char *subtype,
>> +		      const char *source_dev, const char *kernel_opts,
>> +		      const char *mnt_opts)
>> +{
>> +	const char *type;
>> +	char *source = NULL;
>> +	int fsfd = -1;
>> +	int mntfd = -1;
>> +	int err, res;
>> +	unsigned long mount_attrs;
>> +
>> +	/* Determine filesystem type */
>> +	type = blkdev ? "fuseblk" : "fuse";
>> +
>> +	/* Try to open filesystem context */
>> +	fsfd = fsopen(type, FSOPEN_CLOEXEC);
>> +	if (fsfd == -1) {
>> +		fprintf(stderr, "fuse: fsopen(%s) failed: %s\n", type,
>> +			strerror(errno));
>> +		return -1;
>> +	}
>> +
>> +	/* Build source string */
>> +	source = malloc((fsname ? strlen(fsname) : 0) +
>> +			(subtype ? strlen(subtype) : 0) +
>> +			strlen(source_dev) + 32);
>> +	err = -ENOMEM;
>> +	if (!source) {
>> +		fprintf(stderr, "fuse: failed to allocate memory\n");
>> +		goto out_close_fsfd;
>> +	}
>> +
>> +	strcpy(source, fsname ? fsname : (subtype ? subtype : source_dev));
> 
> This is almost fuse_mnt_build_source()

Yeah, we don't have struct mount_opts that fuse_mnt_build_source() takes.
Going to improve that in a later patch.


Thanks,
Bernd
