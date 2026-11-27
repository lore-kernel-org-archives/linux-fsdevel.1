Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795767892;
	b=nUVRFtGo8MWoSdh6ofbD01PRD1Wbv/qXdH2K3Fm0GJF9kT1koT71NSleMFbx3AKUrjib
	 utlwo8DytBG2iAZWYk7h3Pi4ghmwh7OlLZxAKkouO2JNUmdTLwvXA65cGyiWISY8x8xe8
	 Lmyl2hW+VGr2BBbmhLK35epsZnTMNxJ+4MUVwv4NmFZglltdhSg3hYuJ50LP4WBOpXR7M
	 BwRsHbLiBh6Ztz8o3T1IiS0HN/0hw2Y+5qz+Mq3Hu401eWyZYQahzxXeYTVcISk5YGeRU
	 AYsk6KcG6I6BS+wYplsvQzhOfIYCNA0CXSfAAWSx4wnkJRjO+9Zmfq9C1oKMZEKwfpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795767892;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=JgiVmx+NK1QLKsDVdDnKtm8tjF9/ZjpNlQJXP2KbaR8=;
	b=ggi9Z1zrsH1bwCGG2h+YDOhpy055sLSCPOppId9EfN9AuASUnn+QKqvHuyNqS3py0MbE
	 GeL7ApdsZ5Mv0/TP87O9dNk3+nA1if+EI6WCLrMu6tYRT9grIEB2cfgzD9Ha+Hz2HG1io
	 olebo8y4xEUrL7nvlNZPtgIj8JPNi4LigRUL4U59REDh/RyEmvfFQiFoOGYT4w4cKQhzg
	 ND28w7sK6S0WRSshSH9INb4P9VqSWzaJG1Xnr2iVGypGK16AEzHEOvaG5AYZ7vcZDXqnP
	 gCYXR/MXAXNWWZ+U06iorVRgHtjLr3/igv5NRQ/cIbwcnKP4g/fnsz2BYR03JEwSMAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=NnEj+abY;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5389606A321
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 08:24:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5389606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=NnEj+abY
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb77a462c6so63309005e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 00:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795767890; x=1796372690; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JgiVmx+NK1QLKsDVdDnKtm8tjF9/ZjpNlQJXP2KbaR8=;
        b=NnEj+abYt26u7OERrZ4ENrDHubZikK8rTliC8jNleu+I3s1UeRmd7Y7Wbfd7Ei8PJl
         X2x1v8lk8QFS0wAT12dyY8DTcBOmvgL5Tc+EO3WPPCtYMeYTgv7y+U+nRvKez2UdiipJ
         x4WyT9ntnbTZ7uaxiSAzPkNIeA9LUK6bENWlTXBrbBoaYrh+Z4MpKirLfPCCjZ7nd4N+
         YBMqr3tGPedZf7RAiGThed2JQrUpQUpOvw8fNUvaElHDdUXdRZSoHeEOW8dKyA7PyFs7
         jPUUK216owfJFx7Gb7GyZKngQizyJtqpeJPAsKmHtp4lLC1Znm/QAjW/f7hGe3HrsFeE
         tv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795767890; x=1796372690;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JgiVmx+NK1QLKsDVdDnKtm8tjF9/ZjpNlQJXP2KbaR8=;
        b=uuKOAZf54Wef3a11GpAXu3N18gwOYohp7vtLQPUFCqHqpENdBrtTf1O8l05pqwjVIj
         vlPJO23S5sJf3J6NV9ZHt/G4qHmxBDMes40hcxbu0zVH0VQKMW0+jjZ0GAa5VR58HCAa
         RyYFpcd4GhS9jp1GFxfz/AmSJ441G0xHdaNJx21fyHHgc2yGyl/C1QPLjTZMpmCqkFf0
         NG7K96bMhOxUZfKmd8AKU29iMyPaVIfvc+vlVqY0dPialUGyHmcOoyfKdQUhX7JSmNmc
         HtMS/wXgHUIT3ZvxaTcMaNu/zz34XOzJVw2kARL7oDc0/1JPJs54BPQlOxcCZgoywMr1
         isGg==
X-Forwarded-Encrypted: i=1; AL+hErF6MbGcuYvvUaoBIlIE+vb8FQBPiOeJpIReEvna0KdZ+dzfbNMehXHEZV380iHi9LbIpi6ZXQ2s7x1hDPi/@vger.kernel.org
X-Gm-Message-State: APuU4Z/CStKXXsPQjPFoUtRl1JPtwQGLa+yggqTgAd+DQahuBPPdh+cl
	+40mXzFQ2cQcDsuoFc2TnW9xUY5q6bLnK8A1Wcm3ZK/5xCs9VFEYhdok3R+F6FS7X3MxwKda2s/
	4xQ/lnEbQ
X-Gm-Gg: AZFdTZeG7bVi+PnuaG9fann+QYgfe10E7+onIgFWUgp+41qJxbebO1h1CuFhh9txoE0
	DWY5P/V0GrIOQPqhfoJmS9Z+xsP8BGPVYv/pgg1MNgaPlWGOzBxzPyImemHfpKS4Pf6RCM/vV2I
	q/gdReSWMHSVzjUIHBskcaaEo1LNf9g7bYEiLgzkIgsTopSXw0VrW42SgJfZhjrr5MV7+kVRCmA
	+JCidXwVIqcOZ+AoHODuqA9soEICvNUiTO896cgMmOcE9ib/VTweUBMVgbokQmkN6w7wnUXC664
	c46aLa6CGKO7MirktfTgbiMofFq1CHYWnXG6I8ePlsUFR3qP6F5YKJcxlj550/sg+RVrhPco5m5
	V9yEzgezqzvoAzhBnmOnqMLkYeWZbY3u4RrjjPAzc3ZH2D5NuTfJVJ7MPhNyGOAgnMWRAAt+05h
	8ITYSts8fZJSghQ0FFpKB2v38D0mRrIavY6apga+PwqDpPi3ko17lollnJLXmoUSqVIuXZLgMz1
	3BfLiJZgAf1mbJLz5+xvuPhBQhOUa3SrW2aBYF7NqejaUPhWcm0/uNXVDr2+9ffFCHOWJwo9MrG
	5tXJCIs3OJ/gU0VMexFtunTO6IcuJkmcV+e3+7VNN91+YINpZYtRKpUmtGGBy6gOAQ==
X-Received: by 2002:a05:600c:4f81:b0:4bb:5e8c:13bc with SMTP id 5b1f17b1804b1-4bb88805902mr453179825e9.7.1795767889640;
        Fri, 27 Nov 2026 00:24:49 -0800 (PST)
Received: from [10.0.0.233] (tmo-084-240.customers.d1-online.com. [80.187.84.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bbab390cf5sm180219195e9.7.2026.11.27.00.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:24:49 -0800 (PST)
Message-ID: <4bf962e64f7cdc14ceef6dbb070b082126c76d12.camel@amutable.com>
Subject: Re: [PATCH 2/2] selftests/filesystems: check that ephemeral procfs
 files can be bind-mounted
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Aleksa Sarai <cyphar@cyphar.com>
Date: Fri, 27 Nov 2026 09:24:47 +0100
In-Reply-To: <20261126-work-mount-cant_mount-v1-2-781d911a32e1@kernel.org>
References: <20261126-work-mount-cant_mount-v1-0-781d911a32e1@kernel.org>
	 <20261126-work-mount-cant_mount-v1-2-781d911a32e1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, 2026-11-26 at 12:40 +0100, Christian Brauner wrote:
> Check that the ephemeral procfs files can be the source of a mount
> but
> can't be mounted on:
>=20
> - bind mounts of fd, fdinfo and net files, including over
> /proc/self/exe
> =C2=A0 as libpathrs does
> - open_tree() and move_mount() of an fdinfo file
> - moving a mount of an fdinfo file from a slave to its master
> - mounting on top of an fdinfo file
> - moving an fdinfo file beneath a mount
> - a propagated copy that would end up beneath a mount in a slave
> - the same after a peer got its copy
>=20
> The last four have to keep failing with ENOENT.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0.../selftests/filesystems/mount_cycle/.gitignore=C2=A0=C2=A0 |=C2=
=A0=C2=A0 1 +
> =C2=A0.../selftests/filesystems/mount_cycle/Makefile=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0.../filesystems/mount_cycle/procfs_source_test.c=C2=A0=C2=A0 | 283
> +++++++++++++++++++++
> =C2=A03 files changed, 285 insertions(+), 1 deletion(-)
>=20
> diff --git
> a/tools/testing/selftests/filesystems/mount_cycle/.gitignore
> b/tools/testing/selftests/filesystems/mount_cycle/.gitignore
> index 30f7dd071bcbb..514e7295abb4b 100644
> --- a/tools/testing/selftests/filesystems/mount_cycle/.gitignore
> +++ b/tools/testing/selftests/filesystems/mount_cycle/.gitignore
> @@ -6,3 +6,4 @@ mount_cover_test
> =C2=A0locked_handle_test
> =C2=A0nsfs_rbind_loop_test
> =C2=A0overmount_ns_file_test
> +procfs_source_test
> diff --git a/tools/testing/selftests/filesystems/mount_cycle/Makefile
> b/tools/testing/selftests/filesystems/mount_cycle/Makefile
> index fbe8c5e19d424..a2afe7090556a 100644
> --- a/tools/testing/selftests/filesystems/mount_cycle/Makefile
> +++ b/tools/testing/selftests/filesystems/mount_cycle/Makefile
> @@ -1,6 +1,6 @@
> =C2=A0# SPDX-License-Identifier: GPL-2.0
> =C2=A0TEST_GEN_PROGS :=3D loop_cycle_test unmounted_tree_test
> overmount_reparent_test mount_cover_test locked_handle_test
> -TEST_GEN_PROGS +=3D nsfs_rbind_loop_test overmount_ns_file_test
> +TEST_GEN_PROGS +=3D nsfs_rbind_loop_test overmount_ns_file_test
> procfs_source_test
> =C2=A0
> =C2=A0CFLAGS +=3D -Wall -O2 -g $(KHDR_INCLUDES)
> =C2=A0
> diff --git
> a/tools/testing/selftests/filesystems/mount_cycle/procfs_source_test.
> c
> b/tools/testing/selftests/filesystems/mount_cycle/procfs_source_test.
> c
> new file mode 100644
> index 0000000000000..ece21f22e589e
> --- /dev/null
> +++
> b/tools/testing/selftests/filesystems/mount_cycle/procfs_source_test.
> c
> @@ -0,0 +1,283 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * The files in /proc/<pid>/fd, /proc/<pid>/fdinfo and below
> /proc/<pid>/net
> + * can't be mounted on but they can be bind-mounted elsewhere.
> + */
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <sched.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/mount.h>
> +#include <sys/stat.h>
> +
> +#include "../wrappers.h"
> +#include "../../kselftest_harness.h"
> +
> +#ifndef MOVE_MOUNT_BENEATH
> +#define MOVE_MOUNT_BENEATH 0x00000200
> +#endif
> +
> +#define DIR_LEN 64
> +#define PATH_LEN 128
> +
> +/* Open the procfs file itself, not the file it refers to. */
> +static int open_entry(const char *dir, int fd)
> +{
> +	char path[PATH_LEN];
> +
> +	snprintf(path, sizeof(path), "/proc/self/%s/%d", dir, fd);
> +	return open(path, O_PATH | O_NOFOLLOW | O_CLOEXEC);
> +}
> +
> +static int bind_entry(int pfd, const char *target)
> +{
> +	char src[PATH_LEN];
> +
> +	snprintf(src, sizeof(src), "/proc/self/fd/%d", pfd);
> +	return mount(src, target, NULL, MS_BIND, NULL);
> +}
> +
> +/* An fdinfo file starts with the position of the file. */
> +static bool is_fdinfo(const char *path)
> +{
> +	char buf[5] =3D {};
> +	int fd;
> +	bool ret;
> +
> +	fd =3D open(path, O_RDONLY | O_CLOEXEC);
> +	if (fd < 0)
> +		return false;
> +	ret =3D read(fd, buf, 4) =3D=3D 4 && !strcmp(buf, "pos:");
> +	close(fd);
> +	return ret;
> +}
> +
> +/* A shared tmpfs on @dir/a with a slave on @dir/b, both showing a
> file f. */
> +static int setup_slave(const char *dir, char *af, char *bf)
> +{
> +	char a[PATH_LEN], b[PATH_LEN];
> +
> +	snprintf(a, sizeof(a), "%s/a", dir);
> +	snprintf(b, sizeof(b), "%s/b", dir);
> +	snprintf(af, PATH_LEN, "%s/a/f", dir);
> +	snprintf(bf, PATH_LEN, "%s/b/f", dir);
> +	if (mkdir(a, 0755) || mkdir(b, 0755) ||
> +	=C2=A0=C2=A0=C2=A0 mount("tmpfs", a, "tmpfs", 0, NULL) ||
> +	=C2=A0=C2=A0=C2=A0 mount(NULL, a, NULL, MS_SHARED, NULL) ||
> +	=C2=A0=C2=A0=C2=A0 mount(a, b, NULL, MS_BIND, NULL) ||
> +	=C2=A0=C2=A0=C2=A0 mount(NULL, b, NULL, MS_SLAVE, NULL))
> +		return -1;
> +	return mknod(af, S_IFREG | 0644, 0);
> +}
> +
> +FIXTURE(procfs_source) {
> +	char dir[DIR_LEN];
> +	char file[PATH_LEN];
> +	int fd;
> +};
> +
> +FIXTURE_SETUP(procfs_source)
> +{
> +	if (geteuid())
> +		SKIP(return, "test requires root");
> +
> +	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
> +	ASSERT_EQ(mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL),
> 0);
> +	snprintf(self->dir, sizeof(self->dir),
> "/tmp/procfs_source.XXXXXX");
> +	ASSERT_NE(mkdtemp(self->dir), NULL);
> +	ASSERT_EQ(mount("tmpfs", self->dir, "tmpfs", 0, NULL), 0);
> +	snprintf(self->file, sizeof(self->file), "%s/file", self-
> >dir);
> +	self->fd =3D open(self->file, O_RDWR | O_CREAT | O_CLOEXEC,
> 0644);
> +	ASSERT_GE(self->fd, 0);
> +}
> +
> +FIXTURE_TEARDOWN(procfs_source)
> +{
> +	umount2(self->dir, MNT_DETACH);
> +	rmdir(self->dir);
> +}
> +
> +TEST_F(procfs_source, bind_fd)
> +{
> +	struct stat st;
> +	int pfd;
> +
> +	pfd =3D open_entry("fd", self->fd);
> +	ASSERT_GE(pfd, 0);
> +	ASSERT_EQ(bind_entry(pfd, self->file), 0);
> +	ASSERT_EQ(lstat(self->file, &st), 0);
> +	ASSERT_TRUE(S_ISLNK(st.st_mode));
> +	close(pfd);
> +}
> +
> +TEST_F(procfs_source, bind_fdinfo)
> +{
> +	int pfd;
> +
> +	pfd =3D open_entry("fdinfo", self->fd);
> +	ASSERT_GE(pfd, 0);
> +	ASSERT_EQ(bind_entry(pfd, self->file), 0);
> +	ASSERT_TRUE(is_fdinfo(self->file));
> +	close(pfd);
> +}
> +
> +/* An entry below /proc/<pid>/net can't be mounted on either. */
> +TEST_F(procfs_source, bind_net)
> +{
> +	char buf[7] =3D {};
> +	int fd;
> +
> +	if (access("/proc/self/net/dev", F_OK))
> +		SKIP(return, "no /proc/self/net/dev");
> +	ASSERT_EQ(mount("/proc/self/net/dev", self->file, NULL,
> MS_BIND, NULL), 0);
> +	fd =3D open(self->file, O_RDONLY | O_CLOEXEC);
> +	ASSERT_GE(fd, 0);
> +	ASSERT_EQ(read(fd, buf, 6), 6);
> +	ASSERT_STREQ(buf, "Inter-");
> +	close(fd);
> +}
> +
> +/* What libpathrs does to test that it notices overmounts in procfs.
> */
> +TEST_F(procfs_source, bind_fd_on_exe)
> +{
> +	char target[PATH_LEN];
> +	int pfd, exe;
> +
> +	exe =3D open("/proc/self/exe", O_PATH | O_NOFOLLOW |
> O_CLOEXEC);
> +	ASSERT_GE(exe, 0);
> +	pfd =3D open_entry("fd", self->fd);
> +	ASSERT_GE(pfd, 0);
> +	snprintf(target, sizeof(target), "/proc/self/fd/%d", exe);
> +	ASSERT_EQ(bind_entry(pfd, target), 0);
> +	close(pfd);
> +	close(exe);
> +}
> +
> +TEST_F(procfs_source, open_tree_fdinfo)
> +{
> +	int pfd, tfd;
> +
> +	pfd =3D open_entry("fdinfo", self->fd);
> +	ASSERT_GE(pfd, 0);
> +	tfd =3D sys_open_tree(pfd, "", OPEN_TREE_CLONE |
> OPEN_TREE_CLOEXEC | AT_EMPTY_PATH);
> +	ASSERT_GE(tfd, 0);
> +	ASSERT_EQ(sys_move_mount(tfd, "", AT_FDCWD, self->file,
> MOVE_MOUNT_F_EMPTY_PATH), 0);
> +	ASSERT_TRUE(is_fdinfo(self->file));
> +	close(tfd);
> +	close(pfd);
> +}
> +
> +TEST_F(procfs_source, no_mount_on_fdinfo)
> +{
> +	char target[PATH_LEN];
> +	int pfd;
> +
> +	pfd =3D open_entry("fdinfo", self->fd);
> +	ASSERT_GE(pfd, 0);
> +	snprintf(target, sizeof(target), "/proc/self/fd/%d", pfd);
> +	ASSERT_NE(mount(self->file, target, NULL, MS_BIND, NULL),
> 0);
> +	ASSERT_EQ(errno, ENOENT);
> +	close(pfd);
> +}
> +
> +/* Moving beneath would put the existing mount on top of the fdinfo
> file. */
> +TEST_F(procfs_source, no_tuck_beneath_fdinfo)
> +{
> +	char other[PATH_LEN];
> +	int pfd, tfd;
> +
> +	snprintf(other, sizeof(other), "%s/other", self->dir);
> +	ASSERT_EQ(mknod(other, S_IFREG | 0644, 0), 0);
> +	ASSERT_EQ(mount(other, self->file, NULL, MS_BIND, NULL), 0);
> +
> +	pfd =3D open_entry("fdinfo", self->fd);
> +	ASSERT_GE(pfd, 0);
> +	tfd =3D sys_open_tree(pfd, "", OPEN_TREE_CLONE |
> OPEN_TREE_CLOEXEC | AT_EMPTY_PATH);
> +	ASSERT_GE(tfd, 0);
> +	ASSERT_NE(sys_move_mount(tfd, "", AT_FDCWD, self->file,
> +				 MOVE_MOUNT_F_EMPTY_PATH |
> MOVE_MOUNT_BENEATH), 0);
> +	ASSERT_EQ(errno, ENOENT);
> +	ASSERT_FALSE(is_fdinfo(self->file));
> +	ASSERT_EQ(umount2(self->file, 0), 0);
> +	ASSERT_NE(umount2(self->file, 0), 0);
> +	close(tfd);
> +	close(pfd);
> +}
> +
> +/* A copy in a slave would be tucked beneath the slave's own mount.
> */
> +TEST_F(procfs_source, no_tuck_beneath_fdinfo_copy)
> +{
> +	char af[PATH_LEN], bf[PATH_LEN];
> +	int pfd;
> +
> +	ASSERT_EQ(setup_slave(self->dir, af, bf), 0);
> +	ASSERT_EQ(mount(self->file, bf, NULL, MS_BIND, NULL), 0);
> +
> +	pfd =3D open_entry("fdinfo", self->fd);
> +	ASSERT_GE(pfd, 0);
> +	ASSERT_NE(bind_entry(pfd, af), 0);
> +	ASSERT_EQ(errno, ENOENT);
> +	ASSERT_FALSE(is_fdinfo(af));
> +
> +	/* Without the mount in the slave the copy goes there. */
> +	ASSERT_EQ(umount2(bf, 0), 0);
> +	ASSERT_EQ(bind_entry(pfd, af), 0);
> +	ASSERT_TRUE(is_fdinfo(af));
> +	ASSERT_TRUE(is_fdinfo(bf));
> +	close(pfd);
> +}
> +
> +/* A peer gets its copy before the copy for the slave fails. */
> +TEST_F(procfs_source, no_tuck_beneath_fdinfo_after_peer)
> +{
> +	char af[PATH_LEN], bf[PATH_LEN], a[PATH_LEN], c[PATH_LEN],
> cf[PATH_LEN];
> +	int pfd;
> +
> +	ASSERT_EQ(setup_slave(self->dir, af, bf), 0);
> +	snprintf(a, sizeof(a), "%s/a", self->dir);
> +	snprintf(c, sizeof(c), "%s/c", self->dir);
> +	snprintf(cf, sizeof(cf), "%s/c/f", self->dir);
> +	ASSERT_EQ(mkdir(c, 0755), 0);
> +	ASSERT_EQ(mount(a, c, NULL, MS_BIND, NULL), 0);
> +	ASSERT_EQ(mount(self->file, bf, NULL, MS_BIND, NULL), 0);
> +
> +	pfd =3D open_entry("fdinfo", self->fd);
> +	ASSERT_GE(pfd, 0);
> +	ASSERT_NE(bind_entry(pfd, af), 0);
> +	ASSERT_EQ(errno, ENOENT);
> +	ASSERT_FALSE(is_fdinfo(af));
> +	ASSERT_FALSE(is_fdinfo(cf));
> +
> +	ASSERT_EQ(umount2(bf, 0), 0);
> +	ASSERT_EQ(bind_entry(pfd, af), 0);
> +	ASSERT_TRUE(is_fdinfo(af));
> +	ASSERT_TRUE(is_fdinfo(bf));
> +	ASSERT_TRUE(is_fdinfo(cf));
> +	close(pfd);
> +}
> +
> +/* Moved off a slave, its copy goes where the mount came from. */
> +TEST_F(procfs_source, move_fdinfo_off_slave)
> +{
> +	char af[PATH_LEN], bf[PATH_LEN];
> +	int pfd;
> +
> +	ASSERT_EQ(setup_slave(self->dir, af, bf), 0);
> +	pfd =3D open_entry("fdinfo", self->fd);
> +	ASSERT_GE(pfd, 0);
> +	ASSERT_EQ(bind_entry(pfd, bf), 0);
> +	ASSERT_EQ(mount(bf, af, NULL, MS_MOVE, NULL), 0);
> +	ASSERT_TRUE(is_fdinfo(af));
> +	ASSERT_TRUE(is_fdinfo(bf));
> +	/* only the copy is left in the slave */
> +	ASSERT_EQ(umount2(bf, 0), 0);
> +	ASSERT_FALSE(is_fdinfo(bf));
> +	close(pfd);
> +}
> +
> +TEST_HARNESS_MAIN
