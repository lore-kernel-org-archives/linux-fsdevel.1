Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792663510;
	b=sgaFw0wLNpRp3CA0/yydcTQb9DZiq2xV6Qrd1ry3RgPVHW9Ch1PNcV7h1D1GuT0D/vbP
	 WXtP6uvRksacUJrSbN9ymGTN/qcv4Ja/EgvJU4mpPQ6xvMGYOHC6a+1S1tnfOpCq1WBjm
	 wAxjlYRZBHUtvg9xBJ9c4gvHmwyMuzpoC5LmkHWPrO1ex0rK8Iv/xJyZ7Hp7DaMevq1zG
	 b4AjYkBBljCFsotsaJaLkhSJTeAgalsCs+reb5ADBwpdEHscgJ2LsXCBDTD11z+6SVhr0
	 7eDqS8K6NqkrsgPPkU1xOTw4fRzLCGUyO3fBEjp7ogeyOIyFbgDGImRPbcuGdHc25Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792663510;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=HBcrsTQj+ChTMLEjPVL/5a4IvsApD+7lG/v0lSRD6Vo=;
	b=IjibwDWbavH1SGru9uphFjb653E/GmJbHSWdff3jHtlRoZ1ekmj9bbEebTn5+yxYVBxd
	 RTScAWYXzSILYgT2woBq05yT2DUPZBOAu8wWAb9ErmgLGjYRyX9NtftKaUUK1hPEs51Yx
	 sRNYLIqj8Rs9su3LcZY5o68ZashXTRQabX/3BAarGdxqlTcf0nQnq08IXSM6ed8O5SE6h
	 /wu1ruUFkL3PWg3rGZa/uoeZ+IIh7tZETNQv2uiNRTDHMcp8mUTb1Wns+c8Kfngs3UwiW
	 DQ5idXIqjp0EFxllgw+XvvkH4OHBj/mUfm9YRk6RtUC24e8a5ah3sMFxE4yu1bMfqrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="GlXDjk/i";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="ka/pMLzp";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="GlXDjk/i";
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="ka/pMLzp";
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC49606A319
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 10:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DC49606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=GlXDjk/i;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ka/pMLzp;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=GlXDjk/i;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ka/pMLzp
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 52E0421ED8;
	Thu, 22 Oct 2026 10:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792663507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HBcrsTQj+ChTMLEjPVL/5a4IvsApD+7lG/v0lSRD6Vo=;
	b=GlXDjk/i5GlFd1XbglAvjx81zp70gmQ5kNJWIH9BrsyNZqdFkSAVznzGnUoVSlo2W9cKOP
	PIPGjG4HCWFCzJA2lDwyvnU09YM24jkiz6s3kYTE+V5zNQ7CJU2sCdDASGnhJkDMO39FlI
	42yta5sVJDK6qXd7TuXPMei0dnA3yw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792663507;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HBcrsTQj+ChTMLEjPVL/5a4IvsApD+7lG/v0lSRD6Vo=;
	b=ka/pMLzpiPFZID14dWY0IKnqLiId8p/Xy4jFUa3Ny6XzDpN4rwKciwS9R1+cWOBBuaVUon
	1GQINDtPZIbr85Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792663507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HBcrsTQj+ChTMLEjPVL/5a4IvsApD+7lG/v0lSRD6Vo=;
	b=GlXDjk/i5GlFd1XbglAvjx81zp70gmQ5kNJWIH9BrsyNZqdFkSAVznzGnUoVSlo2W9cKOP
	PIPGjG4HCWFCzJA2lDwyvnU09YM24jkiz6s3kYTE+V5zNQ7CJU2sCdDASGnhJkDMO39FlI
	42yta5sVJDK6qXd7TuXPMei0dnA3yw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792663507;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HBcrsTQj+ChTMLEjPVL/5a4IvsApD+7lG/v0lSRD6Vo=;
	b=ka/pMLzpiPFZID14dWY0IKnqLiId8p/Xy4jFUa3Ny6XzDpN4rwKciwS9R1+cWOBBuaVUon
	1GQINDtPZIbr85Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2775B134E6;
	Thu, 22 Oct 2026 10:05:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g7bDNdLf2WotEQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 22 Oct 2026 10:05:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1D555A1417; Thu, 22 Oct 2026 12:04:58 +0200 (CEST)
Date: Thu, 22 Oct 2026 12:04:58 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/15] selftests/filesystems: add quotactl() tests for
 frozen superblocks
Message-ID: <x2hc6knmjcxplmh7uglzdm2v6g4ik63jxpnlbbph6wlvlhx6qa@j3djp7n3dsym>
References: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
 <20261011-work-super-fixes-core-v1-4-c727176c5b53@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011-work-super-fixes-core-v1-4-c727176c5b53@kernel.org>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

On Sun 11-10-26 17:56:04, Christian Brauner wrote:
> Add tests for quotactl() waiting on a frozen superblock:
> 
> - a waiter on a frozen read-only superblock can be killed
> - a waiter on a frozen read-write superblock can be killed
> - the waiters are woken up when the superblock is thawed
> 
> The tests need root, loop devices and mkfs.ext4.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

IMO this would deserve to be written as a test in fstests (and it would
also be much simpler that way).

								Honza

> ---
>  tools/testing/selftests/Makefile                   |   1 +
>  .../selftests/filesystems/freeze/.gitignore        |   2 +
>  .../testing/selftests/filesystems/freeze/Makefile  |   7 +
>  tools/testing/selftests/filesystems/freeze/config  |   3 +
>  .../selftests/filesystems/freeze/loop_util.h       |  64 ++++++
>  .../selftests/filesystems/freeze/quotactl_test.c   | 256 +++++++++++++++++++++
>  6 files changed, 333 insertions(+)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index bc4fdb6f5337..a60778626c8c 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -38,6 +38,7 @@ TARGETS += filesystems/epoll
>  TARGETS += filesystems/eventfd
>  TARGETS += filesystems/failfs
>  TARGETS += filesystems/fat
> +TARGETS += filesystems/freeze
>  TARGETS += filesystems/openat2
>  TARGETS += filesystems/open_tree_ns
>  TARGETS += filesystems/overlayfs
> diff --git a/tools/testing/selftests/filesystems/freeze/.gitignore b/tools/testing/selftests/filesystems/freeze/.gitignore
> new file mode 100644
> index 000000000000..36fb6eaaf7eb
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/freeze/.gitignore
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +quotactl_test
> diff --git a/tools/testing/selftests/filesystems/freeze/Makefile b/tools/testing/selftests/filesystems/freeze/Makefile
> new file mode 100644
> index 000000000000..f9e731412c56
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/freeze/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES)
> +LOCAL_HDRS += loop_util.h
> +
> +TEST_GEN_PROGS := quotactl_test
> +
> +include ../../lib.mk
> diff --git a/tools/testing/selftests/filesystems/freeze/config b/tools/testing/selftests/filesystems/freeze/config
> new file mode 100644
> index 000000000000..5e0b39a87a05
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/freeze/config
> @@ -0,0 +1,3 @@
> +CONFIG_BLK_DEV_LOOP=y
> +CONFIG_EXT4_FS=y
> +CONFIG_QUOTA=y
> diff --git a/tools/testing/selftests/filesystems/freeze/loop_util.h b/tools/testing/selftests/filesystems/freeze/loop_util.h
> new file mode 100644
> index 000000000000..fcea5be6030d
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/freeze/loop_util.h
> @@ -0,0 +1,64 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __SELFTESTS_FILESYSTEMS_FREEZE_LOOP_UTIL_H
> +#define __SELFTESTS_FILESYSTEMS_FREEZE_LOOP_UTIL_H
> +
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <linux/loop.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <sys/ioctl.h>
> +#include <unistd.h>
> +
> +/* How often to retry when somebody else binds the free device first. */
> +#define LOOP_BIND_TRIES 64
> +
> +/* Bind a free loop device to @fd; its number or -errno. */
> +static inline int loop_bind(int fd)
> +{
> +	for (int i = 0; i < LOOP_BIND_TRIES; i++) {
> +		char dev[32];
> +		int cfd, lfd, n, err;
> +
> +		cfd = open("/dev/loop-control", O_RDWR | O_CLOEXEC);
> +		if (cfd < 0)
> +			return -errno;
> +		n = ioctl(cfd, LOOP_CTL_GET_FREE);
> +		err = errno;
> +		close(cfd);
> +		if (n < 0)
> +			return -err;
> +		snprintf(dev, sizeof(dev), "/dev/loop%d", n);
> +		lfd = open(dev, O_RDWR | O_CLOEXEC);
> +		if (lfd < 0)
> +			return -errno;
> +		err = ioctl(lfd, LOOP_SET_FD, fd) ? errno : 0;
> +		close(lfd);
> +		if (!err)
> +			return n;
> +		if (err != EBUSY)
> +			return -err;
> +	}
> +	return -EBUSY;
> +}
> +
> +/* Did loop_bind() fail because there are no loop device nodes or no driver? */
> +static inline bool loop_missing(int ret)
> +{
> +	return ret == -ENOENT || ret == -ENODEV;
> +}
> +
> +static inline void loop_clear(int n)
> +{
> +	char dev[32];
> +	int fd;
> +
> +	snprintf(dev, sizeof(dev), "/dev/loop%d", n);
> +	fd = open(dev, O_RDWR | O_CLOEXEC);
> +	if (fd < 0)
> +		return;
> +	ioctl(fd, LOOP_CLR_FD, 0);
> +	close(fd);
> +}
> +
> +#endif /* __SELFTESTS_FILESYSTEMS_FREEZE_LOOP_UTIL_H */
> diff --git a/tools/testing/selftests/filesystems/freeze/quotactl_test.c b/tools/testing/selftests/filesystems/freeze/quotactl_test.c
> new file mode 100644
> index 000000000000..24772e531eb4
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/freeze/quotactl_test.c
> @@ -0,0 +1,256 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * quotactl(2) on a frozen superblock.
> + *
> + * Commands that modify quota wait in quotactl_block() for a frozen
> + * superblock to be thawed. A read-only superblock is frozen without
> + * taking s_writers so that wait can't be built on sb_start_write(). Check
> + * that a caller waiting on a frozen read-only or read-write superblock can
> + * be killed and that it is woken up when the superblock is thawed.
> + */
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <linux/fs.h>
> +#include <sched.h>
> +#include <signal.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/ioctl.h>
> +#include <sys/mount.h>
> +#include <sys/quota.h>
> +#include <sys/stat.h>
> +#include <sys/wait.h>
> +#include <time.h>
> +#include <unistd.h>
> +
> +#include "../../kselftest_harness.h"
> +#include "loop_util.h"
> +
> +#define IMG_SIZE (64 << 20)
> +#define POLL_MS 10
> +/* How long the child gets to block in quotactl() or to go away. */
> +#define WAIT_MS 3000
> +
> +FIXTURE(frozen) {
> +	char dir[64];
> +	char img[96];
> +	char mnt[96];
> +	char dev[32];
> +	int loop;
> +	int mntfd;
> +	pid_t pid;
> +	bool frozen;
> +};
> +
> +FIXTURE_VARIANT(frozen) {
> +	unsigned long flags;
> +};
> +
> +FIXTURE_VARIANT_ADD(frozen, ro) {
> +	.flags = MS_RDONLY,
> +};
> +
> +FIXTURE_VARIANT_ADD(frozen, rw) {
> +	.flags = 0,
> +};
> +
> +/* Fork a child that calls quotactl(Q_SETQUOTA) on @dev and exits. */
> +static pid_t quotactl_child(const char *dev)
> +{
> +	pid_t pid;
> +
> +	pid = fork();
> +	if (pid == 0) {
> +		struct if_dqblk dq = {};
> +
> +		quotactl(QCMD(Q_SETQUOTA, USRQUOTA), dev, 0, (void *)&dq);
> +		_exit(0);
> +	}
> +	return pid;
> +}
> +
> +/* Reap @pid within @ms milliseconds; true if it went away. */
> +static bool reap(pid_t pid, int *status, int ms)
> +{
> +	struct timespec ts = { .tv_nsec = POLL_MS * 1000 * 1000 };
> +
> +	for (int i = 0; i < ms / POLL_MS; i++) {
> +		pid_t ret = waitpid(pid, status, WNOHANG);
> +
> +		if (ret == pid)
> +			return true;
> +		if (ret < 0)
> +			return false;
> +		nanosleep(&ts, NULL);
> +	}
> +	return false;
> +}
> +
> +/* Wait up to @ms milliseconds for @pid to sleep in the kernel. */
> +static bool blocked(pid_t pid, int ms)
> +{
> +	struct timespec ts = { .tv_nsec = POLL_MS * 1000 * 1000 };
> +	char path[64], buf[512], *p, state;
> +
> +	snprintf(path, sizeof(path), "/proc/%d/stat", pid);
> +	for (int i = 0; i < ms / POLL_MS; i++) {
> +		ssize_t n;
> +		int fd;
> +
> +		fd = open(path, O_RDONLY | O_CLOEXEC);
> +		if (fd < 0)
> +			return false;
> +		n = read(fd, buf, sizeof(buf) - 1);
> +		close(fd);
> +		if (n <= 0)
> +			return false;
> +		buf[n] = '\0';
> +		/* "pid (comm) state ..." */
> +		p = strrchr(buf, ')');
> +		if (p && sscanf(p, ") %c", &state) == 1 &&
> +		    (state == 'D' || state == 'S'))
> +			return true;
> +		nanosleep(&ts, NULL);
> +	}
> +	return false;
> +}
> +
> +static void frozen_cleanup(FIXTURE_DATA(frozen) *self)
> +{
> +	int status;
> +
> +	if (self->pid > 0)
> +		kill(self->pid, SIGKILL);
> +	/* The thaw also lets a waiter go that ignored SIGKILL. */
> +	if (self->frozen)
> +		ioctl(self->mntfd, FITHAW, 0);
> +	if (self->pid > 0)
> +		reap(self->pid, &status, WAIT_MS);
> +	if (self->mntfd >= 0) {
> +		close(self->mntfd);
> +		umount2(self->mnt, MNT_DETACH);
> +	}
> +	if (self->loop >= 0)
> +		loop_clear(self->loop);
> +	unlink(self->img);
> +	rmdir(self->mnt);
> +	rmdir(self->dir);
> +}
> +
> +FIXTURE_SETUP(frozen)
> +{
> +	char cmd[160];
> +	int fd, ret;
> +
> +	self->loop = -1;
> +	self->mntfd = -1;
> +	self->pid = -1;
> +	self->frozen = false;
> +
> +	if (geteuid() != 0)
> +		SKIP(return, "test requires CAP_SYS_ADMIN");
> +	if (access("/dev/loop-control", R_OK | W_OK))
> +		SKIP(return, "test requires loop devices");
> +	/* Without a device this fails with ENODEV, or ENOSYS without quotactl(). */
> +	if (quotactl(QCMD(Q_GETINFO, USRQUOTA), NULL, 0, NULL) && errno == ENOSYS)
> +		SKIP(return, "kernel lacks quotactl()");
> +
> +	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
> +	ASSERT_EQ(mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL), 0);
> +
> +	snprintf(self->dir, sizeof(self->dir), "/tmp/freeze_quotactl.XXXXXX");
> +	ASSERT_NE(mkdtemp(self->dir), NULL);
> +	snprintf(self->img, sizeof(self->img), "%s/img", self->dir);
> +	snprintf(self->mnt, sizeof(self->mnt), "%s/mnt", self->dir);
> +	/* The harness doesn't run the teardown when the setup fails. */
> +	ASSERT_EQ(mkdir(self->mnt, 0700), 0)
> +		frozen_cleanup(self);
> +
> +	fd = open(self->img, O_RDWR | O_CREAT | O_CLOEXEC, 0600);
> +	ASSERT_GE(fd, 0)
> +		frozen_cleanup(self);
> +	ASSERT_EQ(ftruncate(fd, IMG_SIZE), 0)
> +		frozen_cleanup(self);
> +
> +	snprintf(cmd, sizeof(cmd), "mkfs.ext4 -q -F %s >/dev/null 2>&1", self->img);
> +	ret = system(cmd);
> +	if (ret) {
> +		close(fd);
> +		frozen_cleanup(self);
> +		SKIP(return, "mkfs.ext4 failed or is not available");
> +	}
> +
> +	self->loop = loop_bind(fd);
> +	close(fd);
> +	if (loop_missing(self->loop)) {
> +		frozen_cleanup(self);
> +		SKIP(return, "test requires loop devices");
> +	}
> +	ASSERT_GE(self->loop, 0)
> +		frozen_cleanup(self);
> +	snprintf(self->dev, sizeof(self->dev), "/dev/loop%d", self->loop);
> +
> +	if (mount(self->dev, self->mnt, "ext4", variant->flags, NULL)) {
> +		if (errno == ENODEV) {
> +			frozen_cleanup(self);
> +			SKIP(return, "kernel lacks ext4");
> +		}
> +		ASSERT_EQ(errno, 0)
> +			frozen_cleanup(self);
> +	}
> +	self->mntfd = open(self->mnt, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
> +	ASSERT_GE(self->mntfd, 0)
> +		frozen_cleanup(self);
> +}
> +
> +FIXTURE_TEARDOWN(frozen)
> +{
> +	frozen_cleanup(self);
> +}
> +
> +TEST_F(frozen, waiter_is_killable)
> +{
> +	int status;
> +
> +	ASSERT_EQ(ioctl(self->mntfd, FIFREEZE, 0), 0);
> +	self->frozen = true;
> +
> +	self->pid = quotactl_child(self->dev);
> +	ASSERT_GT(self->pid, 0);
> +	ASSERT_TRUE(blocked(self->pid, WAIT_MS))
> +		TH_LOG("quotactl() doesn't wait on a frozen superblock");
> +
> +	ASSERT_EQ(kill(self->pid, SIGKILL), 0);
> +	ASSERT_TRUE(reap(self->pid, &status, WAIT_MS))
> +		TH_LOG("quotactl() waiter survived SIGKILL on a frozen superblock");
> +	self->pid = -1;
> +	ASSERT_TRUE(WIFSIGNALED(status));
> +	ASSERT_EQ(WTERMSIG(status), SIGKILL);
> +}
> +
> +TEST_F(frozen, waiter_wakes_on_thaw)
> +{
> +	int status;
> +
> +	ASSERT_EQ(ioctl(self->mntfd, FIFREEZE, 0), 0);
> +	self->frozen = true;
> +
> +	self->pid = quotactl_child(self->dev);
> +	ASSERT_GT(self->pid, 0);
> +	ASSERT_TRUE(blocked(self->pid, WAIT_MS))
> +		TH_LOG("quotactl() doesn't wait on a frozen superblock");
> +
> +	ASSERT_EQ(ioctl(self->mntfd, FITHAW, 0), 0);
> +	self->frozen = false;
> +
> +	ASSERT_TRUE(reap(self->pid, &status, WAIT_MS))
> +		TH_LOG("quotactl() waiter wasn't woken by the thaw");
> +	self->pid = -1;
> +	ASSERT_TRUE(WIFEXITED(status));
> +	ASSERT_EQ(WEXITSTATUS(status), 0);
> +}
> +
> +TEST_HARNESS_MAIN
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
