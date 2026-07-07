Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017CE3F8240;
	Tue,  7 Jul 2026 10:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783421517; cv=none; b=Cyvzs0iehVpn/4HbbR1Y4nOFslCkOhPJ5RG0X3Cezbd73ljJBZKek1yYNQQbvgYDU2pktU6xZiAZcAx5V+esHr22a+qVDZgrpT3+sOjjv2aowv3Um8341uZMYHdKzNyhqiwGBH15h6M6h6TR+4o+8ESBwRr1mHhqS7+mZmVRa18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783421517; c=relaxed/simple;
	bh=LNdeppuuz/4GWgY6kCsvQgCKRxpUpTVUUPhmRVHH3/0=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=sS+HUG1e+u820tucJrgPGKfC8+D/7AZ4Xb1HyyIMeI4FZ32P4ru2nUl4SUqvnXgMWHfsKXcx3R/4S+X3AWFXO9GGjmLs+ZNSlK5gZn9PeGUA6vBazfD2vqNSaEWeHRAeBLf0aRX+M1IZqw3BvMmw9NUv9fYOkkKiyuis9QtjiYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GF54CK+R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GF54CK+R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50FE1F00A3A;
	Tue,  7 Jul 2026 10:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783421515;
	bh=5YhGZybwXI2mJdTWHoWGVvorQh1v0twSgj9Alzpe6q8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=GF54CK+RN1agHBErn8I/Z88KCJldb3721ugkN8Fi315gDTZ9zgJCRaeFHhjpAXxKF
	 +sJlA6ipj91HvR+UOp7jeVzv2yNeHfAsh060iqLMExokeW6ZkwV2+6EZt2fWOZ5Lr6
	 EVZS2bj6NBG85KyG0s/0/L45Hj4J/ILz06fvSqdHgKDFm/T50e8VTz1iNr7gjtP8PP
	 eP3DsKLGwHZLVt+yJVmXmanyE4ofDlqpyuzha1dBSXubavLl4birIaVUHTx/16vWvx
	 xzIKWmtvcKFfxT05Z+MS6v2r/S68XHNr8CnJQ6t9CpBKD7re2x4Ywt5xD6EAdbBd8W
	 cR0HSpZDeLK3A==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 14/14] selftest: add tests for
 open*(O_CREAT|O_DIRECTORY)
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Jeff Layton <jlayton@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
 Aleksa Sarai <aleksa@amutable.com>, NeilBrown <neil@brown.name>, 
 Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260704164149.3480051-15-jkoolstra@xs4all.nl>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
 <20260704164149.3480051-15-jkoolstra@xs4all.nl>
Date: Tue, 07 Jul 2026 12:51:23 +0200
Message-Id: <20260707-plexiglas-latten-bequem-a6688e299df0@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=6665; i=brauner@kernel.org;
 h=from:subject:message-id; bh=LNdeppuuz/4GWgY6kCsvQgCKRxpUpTVUUPhmRVHH3/0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT53DJIZ31u7XrlS5WtXYb9x3eTVv5y3aJn9MDqJYPXp
 4qJsbG7O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayIIKR4fU+Dc/sctlN15vM
 /nGu+rzralGAbeLulVOso6J2p0Rsvcvw369JlvnC147/u5sMt5snduXLG/PtXbjiFGvMBMbXWZ4
 zOQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> Add some tests for the new valid O_CREAT|O_DIRECTORY flag combination for
> open*(2) to test compliance and to showcase its behaviour.
> 
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>

Thanks for the selftests!

> diff --git a/tools/testing/selftests/filesystems/.gitignore b/tools/testing/selftests/filesystems/.gitignore
> index a78f894157de..d779a7945cf8 100644
> --- a/tools/testing/selftests/filesystems/.gitignore
> +++ b/tools/testing/selftests/filesystems/.gitignore
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +open_o_creat_o_dir
>  dnotify_test
>  devpts_pts
>  fclog
> diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing/selftests/filesystems/Makefile
> index a7ec2ba2dd83..b60950f8b15c 100644
> --- a/tools/testing/selftests/filesystems/Makefile
> +++ b/tools/testing/selftests/filesystems/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  CFLAGS += $(KHDR_INCLUDES)
> -TEST_GEN_PROGS := devpts_pts file_stressor anon_inode_test kernfs_test fclog
> +TEST_GEN_PROGS := open_o_creat_o_dir devpts_pts file_stressor anon_inode_test kernfs_test fclog
>  TEST_GEN_PROGS += idmapped_tmpfile
>  TEST_GEN_PROGS_EXTENDED := dnotify_test
>  
> diff --git a/tools/testing/selftests/filesystems/open_o_creat_o_dir.c b/tools/testing/selftests/filesystems/open_o_creat_o_dir.c
> new file mode 100644
> index 000000000000..df3cdbae2c85
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/open_o_creat_o_dir.c
> @@ -0,0 +1,197 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <sys/stat.h>
> +#include <sys/syscall.h>
> +#include <errno.h>
> +#include <limits.h>
> +#include <fcntl.h>
> +
> +#include "kselftest_harness.h"
> +
> +static inline int open_o_creat_o_dir(int dfd, const char *pathname,
> +				     mode_t mode, unsigned int flags)
> +{
> +	return syscall(__NR_openat, dfd, pathname,
> +		       flags | O_DIRECTORY | O_CREAT, mode);
> +}

I'm not going to insist on it but this should probably move into a
shared header. Possibly wrappers.h which already has a bunch of similar
stuff.

> +
> +#define open_o_creat_o_dir_checked_flags(dfd, pathname, flags) ({	\
> +	struct stat __st;						\
> +	int __fd = open_o_creat_o_dir(dfd, pathname, S_IRWXU, flags);	\
> +	ASSERT_GE(__fd, 0);						\
> +	ASSERT_EQ(fstat(__fd, &__st), 0);				\
> +	EXPECT_TRUE(S_ISDIR(__st.st_mode));				\
> +	__fd;								\
> +})
> +
> +#define open_o_creat_o_dir_checked(dfd, pathname) \
> +	open_o_creat_o_dir_checked_flags(dfd, pathname, 0)
> +
> +FIXTURE(open_o_creat_o_dir) {
> +	char dirpath[PATH_MAX];
> +	int dfd;
> +};
> +
> +FIXTURE_SETUP(open_o_creat_o_dir)
> +{
> +	strcpy(self->dirpath, "/tmp/open_o_creat_o_dir_test.XXXXXX");
> +	ASSERT_NE(mkdtemp(self->dirpath), NULL);
> +	self->dfd = open(self->dirpath, O_DIRECTORY);
> +	ASSERT_GE(self->dfd, 0);
> +}
> +
> +FIXTURE_TEARDOWN(open_o_creat_o_dir)
> +{
> +	close(self->dfd);
> +	rmdir(self->dirpath);
> +}
> +
> +/* Does open_o_creat_o_dir return a fd at all? */
> +TEST_F(open_o_creat_o_dir, returns_fd)
> +{
> +	int fd = open_o_creat_o_dir_checked(self->dfd, "newdir");
> +	EXPECT_EQ(close(fd), 0);
> +	EXPECT_EQ(unlinkat(self->dfd, "newdir", AT_REMOVEDIR), 0);
> +}
> +
> +/* The fd must refer to the directory that was just created. */
> +TEST_F(open_o_creat_o_dir, fd_is_created_dir)
> +{
> +	int fd;
> +	struct stat st_via_fd, st_via_path;
> +	char path[PATH_MAX];
> +
> +	fd = open_o_creat_o_dir_checked(self->dfd, "checkdir");
> +
> +	ASSERT_EQ(fstat(fd, &st_via_fd), 0);
> +
> +	snprintf(path, sizeof(path), "%s/checkdir", self->dirpath);
> +	ASSERT_EQ(stat(path, &st_via_path), 0);
> +
> +	EXPECT_EQ(st_via_fd.st_ino, st_via_path.st_ino);
> +	EXPECT_EQ(st_via_fd.st_dev, st_via_path.st_dev);
> +
> +	EXPECT_EQ(close(fd), 0);
> +	EXPECT_EQ(rmdir(path), 0);
> +}
> +
> +/* Missing parent component must fail with ENOENT. */
> +TEST_F(open_o_creat_o_dir, enoent_missing_parent)
> +{
> +	EXPECT_EQ(open_o_creat_o_dir(self->dfd, "nonexistent/child", S_IRWXU, 0), -1);
> +	EXPECT_EQ(errno, ENOENT);
> +}
> +
> +/* An invalid dfd must fail with EBADF. */
> +TEST_F(open_o_creat_o_dir, ebadf)
> +{
> +	EXPECT_EQ(open_o_creat_o_dir(-42, "badfdir", S_IRWXU, 0), -1);

Use FD_INVALID which is a uapi constant.

> +	EXPECT_EQ(errno, EBADF);
> +}
> +
> +/* A dfd that points to a file (not a directory) must fail with ENOTDIR. */
> +TEST_F(open_o_creat_o_dir, enotdir_dfd)
> +{
> +	int file_fd;
> +
> +	file_fd = openat(self->dfd, "file",
> +			 O_CREAT | O_WRONLY, S_IRWXU);
> +	ASSERT_GE(file_fd, 0);
> +
> +	EXPECT_EQ(open_o_creat_o_dir(file_fd, "subdir", S_IRWXU, 0), -1);
> +	EXPECT_EQ(errno, ENOTDIR);
> +
> +	EXPECT_EQ(close(file_fd), 0);
> +	EXPECT_EQ(unlinkat(self->dfd, "file", 0), 0);
> +}
> +
> +/*
> + * O_EXCL together with O_CREAT|O_DIRECTORY must fail with EEXIST when
> + * the target directory already exists.
> + */
> +TEST_F(open_o_creat_o_dir, o_excl_eexist)
> +{
> +	int fd;
> +
> +	fd = open_o_creat_o_dir_checked_flags(self->dfd, "excldir", O_EXCL);
> +	EXPECT_EQ(close(fd), 0);
> +
> +	EXPECT_EQ(open_o_creat_o_dir(self->dfd, "excldir", S_IRWXU, O_EXCL), -1);
> +	EXPECT_EQ(errno, EEXIST);

I assume this only ran on non-atomic-open filesystems.

> +
> +	EXPECT_EQ(unlinkat(self->dfd, "excldir", AT_REMOVEDIR), 0);
> +}
> +
> +/*
> + * O_CREAT|O_DIRECTORY on a path that already exists as a regular file
> + * must fail with ENOTDIR.
> + */
> +TEST_F(open_o_creat_o_dir, existing_file_enotdir)
> +{
> +	int file_fd;
> +
> +	file_fd = openat(self->dfd, "regfile",
> +			 O_CREAT | O_WRONLY, S_IRWXU);
> +	ASSERT_GE(file_fd, 0);
> +	EXPECT_EQ(close(file_fd), 0);
> +
> +	EXPECT_EQ(open_o_creat_o_dir(self->dfd, "regfile", S_IRWXU, 0), -1);
> +	EXPECT_EQ(errno, ENOTDIR);
> +
> +	EXPECT_EQ(unlinkat(self->dfd, "regfile", 0), 0);
> +}
> +
> +/*
> + * O_CREAT|O_DIRECTORY combined with a writable access mode must be
> + * rejected: a directory cannot be opened for writing.
> + */
> +TEST_F(open_o_creat_o_dir, rejects_writable_acc_mode)
> +{
> +	EXPECT_EQ(open_o_creat_o_dir(self->dfd, "rdwrdir", S_IRWXU, O_RDWR), -1);
> +	EXPECT_EQ(errno, ENOTDIR);
> +	/* Clean up if the kernel created the directory anyway. */
> +	unlinkat(self->dfd, "rdwrdir", AT_REMOVEDIR);
> +}
> +
> +/*
> + * openat(O_CREAT) with a trailing slash but without O_DIRECTORY
> + * must fail with EISDIR and must not create anything at the path.

Do you also have a test _with_ trailing slash?

-- 
Christian Brauner <brauner@kernel.org>
