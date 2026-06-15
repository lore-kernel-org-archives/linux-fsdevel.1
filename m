Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3053329B764
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 13:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781530417; cv=none; b=NQkJww07EEgMP6S3F9miKsUKbYe+ZR1J24axSqBQ3KxVzTckV20oPYdz3FjIZal1cxzDOKMgbSHiL35PP8Eufa2oo1bUgzmXQ2X47gO6rQ6jbHvqcXTBKeGoO3iUUgqDo1NlnSVLesy35XVt64xfUyFVCie/ywoN+6fVK8GKkdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781530417; c=relaxed/simple;
	bh=O89cySwwY67CB+/u2T7NqnBepmZAVdyL/BkHjjuPWNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6yDcShBYBO5Q0qEOr5x7pG42psPuo1LnSF99uUvfCmsBhtJ9lP9ME5YsdpIcw0OQoWJohShviP1t0eujNXJJWIAV0sAjV/2/TLRdIUm4ymaTyi4Y7PMN3C5zX3FOTkKPKqOdt/nbhJCH+1NOY3p2LLIf5GlfkVz2OeDc1oJc+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IkHnckR/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5GB6r+Fr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IkHnckR/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5GB6r+Fr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IkHnckR/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5GB6r+Fr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IkHnckR/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5GB6r+Fr"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 578707586A;
	Mon, 15 Jun 2026 13:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1781530414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j6ZryZm7PFYYrhbiKhhnqmWUrCQWixeYE1VgParaAtU=;
	b=IkHnckR/0TuopLXVMATFiR2ifxIeU8RRTj+mjQG9BS+vDQI4EvnODdrOD0EwR7kbz6Fs9M
	UXPgoSGqAdK5feLvOpQiV513h8IfZInMJ9ICoOlifPwKjhu4YOxxbFTQ+R1xUovDC+l5SA
	awAUNQ1+/d3Mo3BSJxgtHngbLiLa3oM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1781530414;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j6ZryZm7PFYYrhbiKhhnqmWUrCQWixeYE1VgParaAtU=;
	b=5GB6r+FrT4+lY42RBXiE0/Us5ATFDn1ZzWoGsdQ8K9sxxVUFH0LeMe7O3Su8v9/tKhZXh4
	enGZvQ1Xs7qsB2Bg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="IkHnckR/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5GB6r+Fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1781530414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j6ZryZm7PFYYrhbiKhhnqmWUrCQWixeYE1VgParaAtU=;
	b=IkHnckR/0TuopLXVMATFiR2ifxIeU8RRTj+mjQG9BS+vDQI4EvnODdrOD0EwR7kbz6Fs9M
	UXPgoSGqAdK5feLvOpQiV513h8IfZInMJ9ICoOlifPwKjhu4YOxxbFTQ+R1xUovDC+l5SA
	awAUNQ1+/d3Mo3BSJxgtHngbLiLa3oM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1781530414;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j6ZryZm7PFYYrhbiKhhnqmWUrCQWixeYE1VgParaAtU=;
	b=5GB6r+FrT4+lY42RBXiE0/Us5ATFDn1ZzWoGsdQ8K9sxxVUFH0LeMe7O3Su8v9/tKhZXh4
	enGZvQ1Xs7qsB2Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A76D779AC;
	Mon, 15 Jun 2026 13:33:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id s0InEi7/L2o3NgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Jun 2026 13:33:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DD6A1A12D2; Mon, 15 Jun 2026 15:33:33 +0200 (CEST)
Date: Mon, 15 Jun 2026 15:33:33 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 2/2] selftests/filesystems: test O_TMPFILE creation on
 idmapped mounts
Message-ID: <zsvkvvafqqjewdvmgzdnqusiijvuh3vvajcq76mq3kpyy54xyv@a73qrwq3qex5>
References: <20260615-work-idmapped-tmpfile-v1-0-754a94d81f83@kernel.org>
 <20260615-work-idmapped-tmpfile-v1-2-754a94d81f83@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-work-idmapped-tmpfile-v1-2-754a94d81f83@kernel.org>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 578707586A
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Mon 15-06-26 14:52:19, Christian Brauner wrote:
> Add a regression test for the fsuidgid_has_mapping() check in
> vfs_tmpfile().  It idmaps a detached tmpfs mount so that the
> caller-visible id range [0, 10000) maps onto the on-disk range
> [10000, 20000) and checks that:
> 
>   - a caller whose fsuid/fsgid fall outside that range cannot create an
>     O_TMPFILE through the mount and gets -EOVERFLOW instead of an inode
>     owned by (uid_t)-1;
> 
>   - a mapped caller can create an O_TMPFILE, link it into the namespace,
>     and the ownership round-trips through the mount idmap: it is reported
>     as 0 through the mount and stored as 10000 on the underlying tmpfs.
> 
> The test runs entirely as root and uses setfsuid()/setfsgid() to become
> the unmapped caller, so it needs no helper user.  The layer directory is
> world-writable so that an unmapped caller still clears the directory
> permission check and reaches the fsuidgid_has_mapping() test.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  tools/testing/selftests/filesystems/.gitignore     |   1 +
>  tools/testing/selftests/filesystems/Makefile       |   4 +
>  .../selftests/filesystems/idmapped_tmpfile.c       | 168 +++++++++++++++++++++
>  3 files changed, 173 insertions(+)
> 
> diff --git a/tools/testing/selftests/filesystems/.gitignore b/tools/testing/selftests/filesystems/.gitignore
> index 64ac0dfa46b7..a78f894157de 100644
> --- a/tools/testing/selftests/filesystems/.gitignore
> +++ b/tools/testing/selftests/filesystems/.gitignore
> @@ -5,3 +5,4 @@ fclog
>  file_stressor
>  anon_inode_test
>  kernfs_test
> +idmapped_tmpfile
> diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing/selftests/filesystems/Makefile
> index 85427d7f19b9..a7ec2ba2dd83 100644
> --- a/tools/testing/selftests/filesystems/Makefile
> +++ b/tools/testing/selftests/filesystems/Makefile
> @@ -2,6 +2,10 @@
>  
>  CFLAGS += $(KHDR_INCLUDES)
>  TEST_GEN_PROGS := devpts_pts file_stressor anon_inode_test kernfs_test fclog
> +TEST_GEN_PROGS += idmapped_tmpfile
>  TEST_GEN_PROGS_EXTENDED := dnotify_test
>  
>  include ../lib.mk
> +
> +$(OUTPUT)/idmapped_tmpfile: LDLIBS += -lcap
> +$(OUTPUT)/idmapped_tmpfile: utils.c
> diff --git a/tools/testing/selftests/filesystems/idmapped_tmpfile.c b/tools/testing/selftests/filesystems/idmapped_tmpfile.c
> new file mode 100644
> index 000000000000..bc411ab8281e
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/idmapped_tmpfile.c
> @@ -0,0 +1,168 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <limits.h>
> +#include <sched.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <sys/fsuid.h>
> +#include <sys/stat.h>
> +#include <sys/syscall.h>
> +
> +#include <linux/mount.h>
> +#include <linux/types.h>
> +
> +#include "kselftest_harness.h"
> +#include "wrappers.h"
> +#include "utils.h"
> +
> +/*
> + * The test mount maps caller-visible ids [0, MAP_RANGE) onto the on-disk range
> + * [MAP_HOST, MAP_HOST + MAP_RANGE).  An id outside [0, MAP_RANGE) therefore has
> + * no mapping in the mount and is not representable in the filesystem.
> + */
> +#define MAP_HOST  10000
> +#define MAP_RANGE 10000
> +#define UNMAPPED  50000
> +
> +#ifndef MOUNT_ATTR_IDMAP
> +#define MOUNT_ATTR_IDMAP 0x00100000
> +#endif
> +
> +#ifndef __NR_mount_setattr
> +#define __NR_mount_setattr 442
> +#endif
> +
> +static inline int sys_mount_setattr(int dfd, const char *path,
> +				    unsigned int flags,
> +				    struct mount_attr *attr, size_t size)
> +{
> +	return syscall(__NR_mount_setattr, dfd, path, flags, attr, size);
> +}
> +
> +/*
> + * Clone @path into a detached mount idmapped so that caller-visible ids
> + * [0, MAP_RANGE) map onto the on-disk ids [MAP_HOST, MAP_HOST + MAP_RANGE).
> + * Returns the mount fd, or -1 if idmapped mounts are not available.
> + */
> +static int idmapped_clone(const char *path)
> +{
> +	struct mount_attr attr = {
> +		.attr_set = MOUNT_ATTR_IDMAP,
> +	};
> +	int fd_tree, userns_fd, ret;
> +
> +	fd_tree = sys_open_tree(AT_FDCWD, path,
> +				OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC);
> +	if (fd_tree < 0)
> +		return -1;
> +
> +	userns_fd = get_userns_fd(MAP_HOST, 0, MAP_RANGE);
> +	if (userns_fd < 0) {
> +		close(fd_tree);
> +		return -1;
> +	}
> +
> +	attr.userns_fd = userns_fd;
> +	ret = sys_mount_setattr(fd_tree, "", AT_EMPTY_PATH, &attr, sizeof(attr));
> +	close(userns_fd);
> +	if (ret) {
> +		close(fd_tree);
> +		return -1;
> +	}
> +
> +	return fd_tree;
> +}
> +
> +FIXTURE(idmapped_tmpfile) {
> +	char dir[64];	/* non-idmapped path to the layer directory */
> +};
> +
> +FIXTURE_SETUP(idmapped_tmpfile)
> +{
> +	/* Private mount namespace so test mounts need no cleanup. */
> +	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
> +	ASSERT_EQ(sys_mount(NULL, "/", NULL, MS_SLAVE | MS_REC, NULL), 0);
> +	ASSERT_EQ(sys_mount("tmpfs", "/tmp", "tmpfs", 0, NULL), 0);
> +
> +	snprintf(self->dir, sizeof(self->dir), "/tmp/d");
> +	ASSERT_EQ(mkdir(self->dir, 0777), 0);
> +	/* World-writable so an unmapped caller still passes permission(). */
> +	ASSERT_EQ(chmod(self->dir, 0777), 0);
> +}
> +
> +FIXTURE_TEARDOWN(idmapped_tmpfile)
> +{
> +}
> +
> +/*
> + * A caller whose fsuid/fsgid have no mapping in the idmapped mount must not be
> + * able to create an O_TMPFILE.  Without the check in vfs_tmpfile() the inode
> + * would be created owned by (uid_t)-1 and could then be linked into the
> + * namespace.
> + */
> +TEST_F(idmapped_tmpfile, unmapped_caller_is_refused)
> +{
> +	int mfd, fd;
> +
> +	mfd = idmapped_clone(self->dir);
> +	if (mfd < 0)
> +		SKIP(return, "idmapped mounts not supported");
> +
> +	/* Become a caller outside the mount's [0, MAP_RANGE) range. */
> +	setfsgid(UNMAPPED);
> +	setfsuid(UNMAPPED);
> +	ASSERT_EQ(setfsuid(-1), UNMAPPED);
> +
> +	fd = openat(mfd, ".", O_TMPFILE | O_WRONLY, 0644);
> +	ASSERT_LT(fd, 0);
> +	EXPECT_EQ(errno, EOVERFLOW);
> +	if (fd >= 0)
> +		close(fd);
> +
> +	EXPECT_EQ(close(mfd), 0);
> +}
> +
> +/*
> + * A mapped caller can create an O_TMPFILE and link it into the namespace; the
> + * ownership round-trips through the mount idmap.  This is what makes refusing
> + * the unmapped case above necessary in the first place.
> + */
> +TEST_F(idmapped_tmpfile, mapped_caller_creates_and_links)
> +{
> +	char path[PATH_MAX];
> +	struct stat st;
> +	int mfd, fd;
> +
> +	mfd = idmapped_clone(self->dir);
> +	if (mfd < 0)
> +		SKIP(return, "idmapped mounts not supported");
> +
> +	/* Caller is uid/gid 0, which maps to MAP_HOST through the mount. */
> +	fd = openat(mfd, ".", O_TMPFILE | O_RDWR, 0600);
> +	ASSERT_GE(fd, 0);
> +
> +	ASSERT_EQ(fstat(fd, &st), 0);
> +	EXPECT_EQ(st.st_uid, 0);
> +	EXPECT_EQ(st.st_gid, 0);
> +
> +	/* The tmpfile is linkable: splice it into the directory. */
> +	ASSERT_EQ(linkat(fd, "", mfd, "linked", AT_EMPTY_PATH), 0);
> +	EXPECT_EQ(close(fd), 0);
> +
> +	ASSERT_EQ(fstatat(mfd, "linked", &st, 0), 0);
> +	EXPECT_EQ(st.st_uid, 0);
> +	EXPECT_EQ(st.st_gid, 0);
> +
> +	/* On the underlying, non-idmapped tmpfs it is stored as MAP_HOST. */
> +	snprintf(path, sizeof(path), "%s/linked", self->dir);
> +	ASSERT_EQ(stat(path, &st), 0);
> +	EXPECT_EQ(st.st_uid, MAP_HOST);
> +	EXPECT_EQ(st.st_gid, MAP_HOST);
> +
> +	EXPECT_EQ(close(mfd), 0);
> +}
> +
> +TEST_HARNESS_MAIN
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
