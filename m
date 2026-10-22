Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792665303;
	b=HTLrWYKH1Af4iJVs3P48dVn6tNJMnhlUQa/kPCzCSRlxwgM1xLd9/Dja42ck/cLOm5tF
	 UOc0fbqA807QOhsXrepHjng9NUFXBh/+I/LFpu6+tytI8w9z21KqkRV5mfFqEt2BmfMdz
	 UBM4My5UA9VzeRL0MPZbZc2SolZdJDXWCJvLAC7HjmvMUGc3CpXLienSZWcldbu183FHz
	 8abbwg7AyDH+b53Jv0MtCgmb4NTuwQwtALW57i6j7EQD/cGKhBX8fwYL8RBztg+Tf3wu1
	 E3ki4tZOKU5iwWplya68X8Z66/Xjg83KEgNEgDqOcLBBJ/Wgy309xJ5taIAemQgl5HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792665303;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=YMOl/zbW5S9qoAodFchVhvR4FQgVBM4i/ENXOLub6Pw=;
	b=m4n8rzOG+PSPK+xYKlq3/Qqc5JwP7Fv4iY4mDUocT0ji+zda8cQKhtWmDqbUyBZczlez
	 28qJFFzOFJavxXg7q0Q/wXcl7m9GqF8Py+VBMzGf7QfiWy0vzTrPZW3apZccc4u7h5HHH
	 BD+SXfJwkj6ve/lmoMw40g1ebfzxY12csT/mWmbfQJ8dUZ57QAnU9IG8F+04DJ+MLF3qw
	 FH7WXtGP1H7L4vZYPSgmpKdoUkGjWB7URyo+EOomwijE596AafenGJGB+6WHU8mO9yki/
	 1Fr4xxU9LQbPTUZm2rHCRWR14kskZWwZ3SJ4S4oscBZXuJ90a5Ex2/+OOZQnxQmA2Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=TqcOLuAk;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=S3rY1JOD;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=TqcOLuAk;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=S3rY1JOD;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6FB606A31B
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 10:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B6FB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=TqcOLuAk;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=S3rY1JOD;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=TqcOLuAk;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=S3rY1JOD
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AD7231FB1C;
	Thu, 22 Oct 2026 10:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792665300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YMOl/zbW5S9qoAodFchVhvR4FQgVBM4i/ENXOLub6Pw=;
	b=TqcOLuAkl4n517Aybb+aNZDARWIT2T4Yh09+l2JL9EfHUfpVCxmvjvzyTIML5r64fR8T2W
	t64Ypo+6PCE8xeJvIiMCa4yI0k+G/ln3Tpv4ywexGzRn3GDR4a0iefO5C6agGvKaIRi3+d
	njXKO2g9grcjaGCxWAmhynpJQnRxiyE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792665300;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YMOl/zbW5S9qoAodFchVhvR4FQgVBM4i/ENXOLub6Pw=;
	b=S3rY1JODigR6lNNr3Up7WH0qbVOuqWJF1lM83TfOTR/YhbYEy58vAeBvLmXJa2FioVacXp
	jOC5Xs0I2+pWlYDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792665300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YMOl/zbW5S9qoAodFchVhvR4FQgVBM4i/ENXOLub6Pw=;
	b=TqcOLuAkl4n517Aybb+aNZDARWIT2T4Yh09+l2JL9EfHUfpVCxmvjvzyTIML5r64fR8T2W
	t64Ypo+6PCE8xeJvIiMCa4yI0k+G/ln3Tpv4ywexGzRn3GDR4a0iefO5C6agGvKaIRi3+d
	njXKO2g9grcjaGCxWAmhynpJQnRxiyE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792665300;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YMOl/zbW5S9qoAodFchVhvR4FQgVBM4i/ENXOLub6Pw=;
	b=S3rY1JODigR6lNNr3Up7WH0qbVOuqWJF1lM83TfOTR/YhbYEy58vAeBvLmXJa2FioVacXp
	jOC5Xs0I2+pWlYDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9121B134E6;
	Thu, 22 Oct 2026 10:34:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZHJMG9Pm2Wo0MQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 22 Oct 2026 10:34:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 39199A1417; Thu, 22 Oct 2026 12:34:51 +0200 (CEST)
Date: Thu, 22 Oct 2026 12:34:51 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 10/15] selftests/filesystems: add a test for thawing
 behind a device freeze
Message-ID: <br5glbeyzx2blibxigz3425xizslyc6o7gkrk252y27gdaio3i@kvhiihzmvmph>
References: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
 <20261011-work-super-fixes-core-v1-10-c727176c5b53@kernel.org>
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
In-Reply-To: <20261011-work-super-fixes-core-v1-10-c727176c5b53@kernel.org>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.80

On Sun 11-10-26 17:56:10, Christian Brauner wrote:
> Add a test for a filesystem that is thawed while device-mapper holds a
> freeze on it:
> 
> - mount ext4 read-only on a dm-linear device
> - suspend the device with lockfs
> - FITHAW the filesystem
> - resume the device
> - the device can be mounted again after the umount
> 
> The test needs root, loop devices, device-mapper and mkfs.ext4.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

This would be trivial to write as fstest and as a bonus it would get
executed for multiple different filesystems...

								Honza

> ---
>  .../selftests/filesystems/freeze/.gitignore        |   1 +
>  .../testing/selftests/filesystems/freeze/Makefile  |   2 +-
>  .../selftests/filesystems/freeze/bdev_thaw_test.c  | 251 +++++++++++++++++++++
>  tools/testing/selftests/filesystems/freeze/config  |   2 +
>  4 files changed, 255 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/filesystems/freeze/.gitignore b/tools/testing/selftests/filesystems/freeze/.gitignore
> index bc6fc0fbb2a0..28f1fe73f19b 100644
> --- a/tools/testing/selftests/filesystems/freeze/.gitignore
> +++ b/tools/testing/selftests/filesystems/freeze/.gitignore
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  quotactl_test
>  bdev_freeze_test
> +bdev_thaw_test
> diff --git a/tools/testing/selftests/filesystems/freeze/Makefile b/tools/testing/selftests/filesystems/freeze/Makefile
> index 53c8a373223f..acd246e1b14b 100644
> --- a/tools/testing/selftests/filesystems/freeze/Makefile
> +++ b/tools/testing/selftests/filesystems/freeze/Makefile
> @@ -3,6 +3,6 @@ CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES)
>  LOCAL_HDRS += loop_util.h
>  
>  TEST_GEN_PROGS := quotactl_test
> -TEST_GEN_PROGS += bdev_freeze_test
> +TEST_GEN_PROGS += bdev_freeze_test bdev_thaw_test
>  
>  include ../../lib.mk
> diff --git a/tools/testing/selftests/filesystems/freeze/bdev_thaw_test.c b/tools/testing/selftests/filesystems/freeze/bdev_thaw_test.c
> new file mode 100644
> index 000000000000..9bb21293093c
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/freeze/bdev_thaw_test.c
> @@ -0,0 +1,251 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Thawing a superblock behind the block layer's back.
> + *
> + * A device-mapper suspend freezes the filesystem on the device through
> + * bdev_freeze() with the same userspace holder FIFREEZE uses, so FITHAW can
> + * drop that freeze while the device is still suspended. The resume then
> + * finds nothing left to thaw. Check that it still thaws the device so that
> + * it can be mounted again afterwards. The filesystem is mounted read-only
> + * so the freeze and the thaw don't need to write to the suspended device.
> + */
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <linux/dm-ioctl.h>
> +#include <linux/fs.h>
> +#include <sched.h>
> +#include <stdbool.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/ioctl.h>
> +#include <sys/mount.h>
> +#include <sys/stat.h>
> +#include <sys/sysmacros.h>
> +#include <unistd.h>
> +
> +#include "../../kselftest_harness.h"
> +#include "loop_util.h"
> +
> +#define IMG_SIZE (64 << 20)
> +
> +FIXTURE(bdev_thaw) {
> +	char dir[64];
> +	char img[96];
> +	char mnt[96];
> +	char node[96];
> +	char name[32];
> +	int loop;
> +	int mntfd;
> +	bool tmpfs;
> +	bool dm;
> +	bool suspended;
> +	bool mounted;
> +};
> +
> +static int dm_ioctl(unsigned long cmd, const char *name, uint32_t flags, dev_t *dev)
> +{
> +	struct dm_ioctl dmi = {
> +		.version = { DM_VERSION_MAJOR, 0, 0 },
> +		.data_size = sizeof(dmi),
> +		.data_start = sizeof(dmi),
> +		.flags = flags,
> +	};
> +	int fd, ret = 0;
> +
> +	strncpy(dmi.name, name, sizeof(dmi.name) - 1);
> +	fd = open("/dev/mapper/control", O_RDWR | O_CLOEXEC);
> +	if (fd < 0)
> +		return -errno;
> +	if (ioctl(fd, cmd, &dmi))
> +		ret = -errno;
> +	else if (dev)
> +		*dev = makedev((dmi.dev >> 8) & 0xfff,
> +			       (dmi.dev & 0xff) | ((dmi.dev >> 12) & 0xfff00));
> +	close(fd);
> +	return ret;
> +}
> +
> +/* Remove @name now, or on its last close if udev still has it open. */
> +static int dm_remove(const char *name)
> +{
> +	return dm_ioctl(DM_DEV_REMOVE, name, DM_DEFERRED_REMOVE, NULL);
> +}
> +
> +/* Create @name as a linear mapping of all of @backing and make it live. */
> +static int dm_create_linear(const char *name, dev_t backing, uint64_t sectors,
> +			    dev_t *dev)
> +{
> +	struct {
> +		struct dm_ioctl dmi;
> +		struct dm_target_spec spec;
> +		char params[64];
> +	} __attribute__((aligned(8))) t = {};
> +	int fd, ret;
> +
> +	ret = dm_ioctl(DM_DEV_CREATE, name, 0, NULL);
> +	if (ret)
> +		return ret;
> +
> +	t.dmi.version[0] = DM_VERSION_MAJOR;
> +	t.dmi.data_size = sizeof(t);
> +	t.dmi.data_start = sizeof(t.dmi);
> +	t.dmi.target_count = 1;
> +	strncpy(t.dmi.name, name, sizeof(t.dmi.name) - 1);
> +	t.spec.length = sectors;
> +	strcpy(t.spec.target_type, "linear");
> +	snprintf(t.params, sizeof(t.params), "%u:%u 0", major(backing), minor(backing));
> +
> +	fd = open("/dev/mapper/control", O_RDWR | O_CLOEXEC);
> +	if (fd >= 0) {
> +		ret = ioctl(fd, DM_TABLE_LOAD, &t) ? -errno : 0;
> +		close(fd);
> +	} else {
> +		ret = -errno;
> +	}
> +	/* Resuming makes the loaded table live. */
> +	if (!ret)
> +		ret = dm_ioctl(DM_DEV_SUSPEND, name, 0, dev);
> +	if (ret)
> +		dm_remove(name);
> +	return ret;
> +}
> +
> +static void bdev_thaw_cleanup(FIXTURE_DATA(bdev_thaw) *self)
> +{
> +	if (self->suspended)
> +		dm_ioctl(DM_DEV_SUSPEND, self->name, 0, NULL);
> +	if (self->mntfd >= 0)
> +		close(self->mntfd);
> +	if (self->mounted)
> +		umount2(self->mnt, MNT_DETACH);
> +	if (self->dm)
> +		dm_remove(self->name);
> +	if (self->loop >= 0)
> +		loop_clear(self->loop);
> +	unlink(self->node);
> +	unlink(self->img);
> +	rmdir(self->mnt);
> +	if (self->tmpfs)
> +		umount2(self->dir, MNT_DETACH);
> +	rmdir(self->dir);
> +}
> +
> +FIXTURE_SETUP(bdev_thaw)
> +{
> +	char cmd[160], dev[32];
> +	struct stat st;
> +	dev_t dmdev;
> +	int fd, ret;
> +
> +	self->loop = -1;
> +	self->mntfd = -1;
> +	self->tmpfs = false;
> +	self->dm = false;
> +	self->suspended = false;
> +	self->mounted = false;
> +
> +	if (geteuid() != 0)
> +		SKIP(return, "test requires CAP_SYS_ADMIN");
> +	if (access("/dev/loop-control", R_OK | W_OK))
> +		SKIP(return, "test requires loop devices");
> +	if (access("/dev/mapper/control", R_OK | W_OK))
> +		SKIP(return, "test requires device-mapper");
> +
> +	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
> +	ASSERT_EQ(mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL), 0);
> +
> +	snprintf(self->dir, sizeof(self->dir), "/tmp/bdev_thaw.XXXXXX");
> +	ASSERT_NE(mkdtemp(self->dir), NULL);
> +	/* /tmp may be mounted nodev, the dm node needs a tmpfs of our own. */
> +	ASSERT_EQ(mount("tmpfs", self->dir, "tmpfs", MS_NOSUID | MS_NOEXEC, NULL), 0)
> +		rmdir(self->dir);
> +	self->tmpfs = true;
> +	snprintf(self->img, sizeof(self->img), "%s/img", self->dir);
> +	snprintf(self->mnt, sizeof(self->mnt), "%s/mnt", self->dir);
> +	snprintf(self->node, sizeof(self->node), "%s/dm", self->dir);
> +	snprintf(self->name, sizeof(self->name), "bdev_thaw_%d", getpid());
> +	/* The harness doesn't run the teardown when the setup fails. */
> +	ASSERT_EQ(mkdir(self->mnt, 0700), 0)
> +		bdev_thaw_cleanup(self);
> +
> +	fd = open(self->img, O_RDWR | O_CREAT | O_CLOEXEC, 0600);
> +	ASSERT_GE(fd, 0)
> +		bdev_thaw_cleanup(self);
> +	ASSERT_EQ(ftruncate(fd, IMG_SIZE), 0)
> +		bdev_thaw_cleanup(self);
> +
> +	snprintf(cmd, sizeof(cmd), "mkfs.ext4 -q -F %s >/dev/null 2>&1", self->img);
> +	ret = system(cmd);
> +	if (ret) {
> +		close(fd);
> +		bdev_thaw_cleanup(self);
> +		SKIP(return, "mkfs.ext4 failed or is not available");
> +	}
> +
> +	self->loop = loop_bind(fd);
> +	close(fd);
> +	if (loop_missing(self->loop)) {
> +		bdev_thaw_cleanup(self);
> +		SKIP(return, "test requires loop devices");
> +	}
> +	ASSERT_GE(self->loop, 0)
> +		bdev_thaw_cleanup(self);
> +	snprintf(dev, sizeof(dev), "/dev/loop%d", self->loop);
> +	ASSERT_EQ(stat(dev, &st), 0)
> +		bdev_thaw_cleanup(self);
> +
> +	ASSERT_EQ(dm_create_linear(self->name, st.st_rdev, IMG_SIZE >> 9, &dmdev), 0)
> +		bdev_thaw_cleanup(self);
> +	self->dm = true;
> +	ASSERT_EQ(mknod(self->node, S_IFBLK | 0600, dmdev), 0)
> +		bdev_thaw_cleanup(self);
> +
> +	if (mount(self->node, self->mnt, "ext4", MS_RDONLY, NULL)) {
> +		if (errno == ENODEV) {
> +			bdev_thaw_cleanup(self);
> +			SKIP(return, "kernel lacks ext4");
> +		}
> +		ASSERT_EQ(errno, 0)
> +			bdev_thaw_cleanup(self);
> +	}
> +	self->mounted = true;
> +	self->mntfd = open(self->mnt, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
> +	ASSERT_GE(self->mntfd, 0)
> +		bdev_thaw_cleanup(self);
> +}
> +
> +FIXTURE_TEARDOWN(bdev_thaw)
> +{
> +	bdev_thaw_cleanup(self);
> +}
> +
> +TEST_F(bdev_thaw, fithaw_during_dm_suspend)
> +{
> +	/* A suspend with lockfs freezes the filesystem through bdev_freeze(). */
> +	ASSERT_EQ(dm_ioctl(DM_DEV_SUSPEND, self->name, DM_SUSPEND_FLAG, NULL), 0);
> +	self->suspended = true;
> +
> +	/* FITHAW drops the freeze the suspend holds. */
> +	if (ioctl(self->mntfd, FITHAW, 0)) {
> +		ASSERT_EQ(errno, EINVAL);
> +		SKIP(return, "FITHAW doesn't drop a device-mapper freeze");
> +	}
> +
> +	/* The resume's bdev_thaw() finds nothing left to thaw. */
> +	ASSERT_EQ(dm_ioctl(DM_DEV_SUSPEND, self->name, 0, NULL), 0);
> +	self->suspended = false;
> +
> +	close(self->mntfd);
> +	self->mntfd = -1;
> +	ASSERT_EQ(umount2(self->mnt, 0), 0);
> +	self->mounted = false;
> +
> +	ASSERT_EQ(mount(self->node, self->mnt, "ext4", MS_RDONLY, NULL), 0)
> +		TH_LOG("device still frozen after the resume: %s", strerror(errno));
> +	self->mounted = true;
> +}
> +
> +TEST_HARNESS_MAIN
> diff --git a/tools/testing/selftests/filesystems/freeze/config b/tools/testing/selftests/filesystems/freeze/config
> index 09d86d9bc7d7..d03720cda9a9 100644
> --- a/tools/testing/selftests/filesystems/freeze/config
> +++ b/tools/testing/selftests/filesystems/freeze/config
> @@ -1,7 +1,9 @@
> +CONFIG_BLK_DEV_DM=y
>  CONFIG_BLK_DEV_LOOP=y
>  CONFIG_DEBUG_FS=y
>  CONFIG_EXT4_FS=y
>  CONFIG_FAIL_MAKE_REQUEST=y
>  CONFIG_FAULT_INJECTION=y
>  CONFIG_FAULT_INJECTION_DEBUG_FS=y
> +CONFIG_MD=y
>  CONFIG_QUOTA=y
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
