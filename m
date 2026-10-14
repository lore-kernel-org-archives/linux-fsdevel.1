Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3C73093CB;
	Wed, 14 Oct 2026 20:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792008076; cv=none; b=L+RWNY7C407SK7YkFspTlc6NnWREdtdrKSz2KezE2M4gEDgfjgDCEXDl545DYa0RmYcVdSofEeV6c7HrVXLLVRxHGDRmfHzhbS6Fr5mdIG7UzOt/fHY4reXffZd/9b+nw4Xr4hFcGf5U7MIqV1lUB8COfsPnyN4Z9AULq5f/4E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792008076; c=relaxed/simple;
	bh=nqru1Dp754lXLQGb+OD3sj/VPp0l00Da3zJWJXY25TY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6LpyeJcvCYwnq0VlYfTRnpfxwKlAxdxxPm0BaOx8T0KApOBtQnv6EpxXbOwV0agl6rZCMqQ4LW70ZtwfldR6QNpYtu5WdHAXU2scw74XzpEpm3AFh8YfyOJNQ84Ms5WMsDKaD4CIsKiEj9IlxCensouUu3AExllgKPfykHyJsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2B1+Cwo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2B1+Cwo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AD81F000C4;
	Wed, 14 Oct 2026 20:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792008074;
	bh=MohkZbaM2ad7IuG57seeIoOLeuXk7eLC9FCZomuF6Zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z2B1+CwoTMTsvyY6xHuaDq9hug/4FaKoOUD2oth/ykKruDGobcdgpWlyb1zxrpHPn
	 KyZKLfzy0+xiuyih8fi+BJNpeyxO+I/NN/85O+7frm1cByGua8/dhBHVuTZwIGegos
	 rpzc3frHB9ZGPzE4DaOZ2eJpYr6z32m9FvLjj1fECgmlWWGKhzoj9ei4Eb5Z/zVBWJ
	 bn7uIREbQTK3qKd7a+PcpGqR7cxq5RdIZpObowkaXpbD3Nz6/uSFUnUq1Av8VB89ci
	 FIOeYXzLJKy0DdWq9etU1Du3cNE1li7wtHiUQ7nhNNSCvvJEV3JvqmPWS1XAczD8ev
	 tcF1RYkTCQctw==
From: Sasha Levin <sashal@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Sasha Levin <sashal@kernel.org>,
	Jimmy Zuber <jamz@amazon.com>,
	Shuah Khan <shuah@kernel.org>,
	fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] selftests/fuse: add the missing FUSE_HAS_SYNCFS privilege test
Date: Wed, 14 Oct 2026 16:01:12 -0400
Message-ID: <20261014200112.1363344-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820130158.254808-3-jamz@amazon.com>
References: <20260820130158.254808-3-jamz@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit a6ca1a573e1f ("selftests/fuse: add test for FUSE_HAS_SYNCFS
privilege gating") registered test_syncfs in the fuse selftest Makefile
and .gitignore, but the test source was not part of the applied commit,
so building the fuse selftests fails:

  make[1]: *** No rule to make target '.../test_syncfs', needed by 'all'.

Add test_syncfs.c as posted in Jimmy Zuber's v3 submission. The test
talks the raw FUSE protocol over /dev/fuse, so it can choose whether to
advertise FUSE_HAS_SYNCFS and directly observe whether the kernel
forwards a FUSE_SYNCFS request. It covers three cases:

  T1: host-root mount, server sets FUSE_HAS_SYNCFS
      -> FUSE_SYNCFS must reach the server.
  T2: host-root mount, server does not opt in
      -> FUSE_SYNCFS must not be sent (back-compat).
  T3: server opts in but opened /dev/fuse without CAP_SYS_ADMIN while
      still in the initial user namespace
      -> FUSE_SYNCFS must be withheld.

Fixes: a6ca1a573e1f ("selftests/fuse: add test for FUSE_HAS_SYNCFS privilege gating")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202609021808.5OxsIter-lkp@intel.com/
Closes: https://lore.kernel.org/r/202609230913.G4keWCG7-lkp@intel.com/
Link: https://lore.kernel.org/r/20260820130158.254808-3-jamz@amazon.com
Originally-by: Jimmy Zuber <jamz@amazon.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/filesystems/fuse/test_syncfs.c  | 309 ++++++++++++++++++
 1 file changed, 309 insertions(+)
 create mode 100644 tools/testing/selftests/filesystems/fuse/test_syncfs.c

diff --git a/tools/testing/selftests/filesystems/fuse/test_syncfs.c b/tools/testing/selftests/filesystems/fuse/test_syncfs.c
new file mode 100644
index 0000000000000..d3ca2613b45c2
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fuse/test_syncfs.c
@@ -0,0 +1,309 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test that FUSE_SYNCFS is propagated to a userspace server only when the
+ * server opts in with FUSE_HAS_SYNCFS *and* opened /dev/fuse with
+ * CAP_SYS_ADMIN in the initial user namespace.
+ *
+ * Unlike the libfuse-based selftests, this talks the raw FUSE wire protocol
+ * over /dev/fuse so it can (a) choose whether to advertise FUSE_HAS_SYNCFS in
+ * the INIT reply and (b) observe directly whether a FUSE_SYNCFS opcode arrives.
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <poll.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/eventfd.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/uio.h>
+#include <sys/wait.h>
+#include <linux/capability.h>
+#include <linux/fuse.h>
+
+#include "../../kselftest.h"
+
+#define FUSE_ROOT_ID 1
+
+/*
+ * Add or drop CAP_SYS_ADMIN in the effective set via raw capget/capset
+ * (avoids a libcap dependency).  Used to construct a server that opens
+ * /dev/fuse without the privilege FUSE_HAS_SYNCFS requires.
+ */
+static int set_sysadmin(int on)
+{
+	struct __user_cap_header_struct hdr = {
+		.version = _LINUX_CAPABILITY_VERSION_3,
+		.pid = 0,
+	};
+	struct __user_cap_data_struct data[_LINUX_CAPABILITY_U32S_3] = {};
+	unsigned int idx = CAP_SYS_ADMIN >> 5;
+	__u32 bit = 1U << (CAP_SYS_ADMIN & 31);
+
+	if (syscall(SYS_capget, &hdr, data))
+		return -1;
+	if (on)
+		data[idx].effective |= bit;
+	else
+		data[idx].effective &= ~bit;
+	return syscall(SYS_capset, &hdr, data);
+}
+
+/*
+ * eventfd the server child writes once when it receives FUSE_SYNCFS; the
+ * parent poll()s it to observe (or rule out) propagation.
+ */
+static int syncfs_evfd;
+
+static void reply(int fd, uint64_t unique, int error, void *data, size_t len)
+{
+	struct fuse_out_header oh = {
+		.len = sizeof(oh) + len,
+		.error = error,
+		.unique = unique,
+	};
+	struct iovec iov[2] = {
+		{ &oh, sizeof(oh) },
+		{ data, len },
+	};
+
+	if (writev(fd, iov, data ? 2 : 1) < 0)
+		ksft_print_msg("server writev failed: %s\n", strerror(errno));
+}
+
+static void fill_attr(struct fuse_attr *a, uint64_t ino, uint32_t mode,
+		      uint32_t nlink)
+{
+	memset(a, 0, sizeof(*a));
+	a->ino = ino;
+	a->mode = mode;
+	a->nlink = nlink;
+	a->blksize = 4096;
+}
+
+/*
+ * Minimal FUSE server.  Advertises FUSE_HAS_SYNCFS in its INIT reply iff
+ * @advertise is set.  Signals syncfs_evfd when a FUSE_SYNCFS opcode arrives.
+ */
+#define SERVER_MAX_WRITE 65536
+static void run_server(int fd, int advertise)
+{
+	/*
+	 * The kernel rejects reads (EINVAL) whose buffer is smaller than
+	 * max_write + header, so size generously for the max_write we
+	 * advertise in the INIT reply below.
+	 */
+	static char buf[SERVER_MAX_WRITE + 4096];
+
+	for (;;) {
+		ssize_t n = read(fd, buf, sizeof(buf));
+		struct fuse_in_header *ih = (void *)buf;
+
+		if (n < 0) {
+			if (errno == EINTR || errno == EAGAIN)
+				continue;
+			return;		/* device closed on unmount/abort */
+		}
+		if (n < (ssize_t)sizeof(*ih))
+			continue;
+
+		switch (ih->opcode) {
+		case FUSE_INIT: {
+			struct fuse_init_in *in = (void *)(ih + 1);
+			struct fuse_init_out out = {0};
+			uint64_t flags = FUSE_INIT_EXT;
+
+			out.major = FUSE_KERNEL_VERSION;
+			out.minor = FUSE_KERNEL_MINOR_VERSION;
+			out.max_readahead = in->max_readahead;
+			out.max_write = SERVER_MAX_WRITE;
+			out.max_background = 16;
+			out.congestion_threshold = 12;
+			if (advertise)
+				flags |= FUSE_HAS_SYNCFS;
+			out.flags = flags;
+			out.flags2 = flags >> 32;
+			reply(fd, ih->unique, 0, &out, sizeof(out));
+			break;
+		}
+		case FUSE_GETATTR: {
+			struct fuse_attr_out out = {0};
+
+			fill_attr(&out.attr, FUSE_ROOT_ID, S_IFDIR | 0755, 2);
+			reply(fd, ih->unique, 0, &out, sizeof(out));
+			break;
+		}
+		case FUSE_SYNCFS: {
+			uint64_t one = 1;
+
+			if (write(syncfs_evfd, &one, sizeof(one)) < 0)
+				ksft_print_msg("server eventfd write failed: %s\n",
+					       strerror(errno));
+			reply(fd, ih->unique, 0, NULL, 0);
+			break;
+		}
+		default:
+			/*
+			 * Anything else (e.g. OPENDIR from opening the mount
+			 * root) is not needed to drive this test; -ENOSYS lets
+			 * the kernel proceed.
+			 */
+			reply(fd, ih->unique, -ENOSYS, NULL, 0);
+			break;
+		}
+	}
+}
+
+/*
+ * Mount a fuse fs backed by a forked server, issue syncfs(), and report
+ * whether the server observed FUSE_SYNCFS.  Returns 0 on success, -1 if the
+ * environment could not support the test (caller should skip).
+ *
+ * If @unpriv_open is set, /dev/fuse is opened with CAP_SYS_ADMIN dropped
+ * (regained only for the mount() syscall), so the device opener -- the
+ * server principal FUSE_HAS_SYNCFS is gated on -- lacks the privilege even
+ * though it remains in the initial user namespace.
+ */
+static int do_mount_and_syncfs(const char *mnt, int advertise, int unpriv_open,
+			       int *seen)
+{
+	struct pollfd pfd = { .events = POLLIN };
+	char opts[256];
+	int fd, mfd = -1, i;
+	pid_t pid;
+
+	syncfs_evfd = eventfd(0, EFD_CLOEXEC);
+	if (syncfs_evfd < 0)
+		return -1;
+
+	if (unpriv_open && set_sysadmin(0))
+		goto out_evfd;
+	fd = open("/dev/fuse", O_RDWR);
+	if (unpriv_open && set_sysadmin(1)) {
+		if (fd >= 0)
+			close(fd);
+		goto out_evfd;
+	}
+	if (fd < 0)
+		goto out_evfd;
+
+	mkdir(mnt, 0755);
+	snprintf(opts, sizeof(opts),
+		 "fd=%d,rootmode=40000,user_id=%d,group_id=%d",
+		 fd, getuid(), getgid());
+
+	if (mount("fuse", mnt, "fuse", 0, opts) < 0)
+		goto out_fd;
+
+	pid = fork();
+	if (pid < 0)
+		goto out_umount;
+	if (pid == 0) {
+		run_server(fd, advertise);
+		_exit(0);
+	}
+
+	/*
+	 * The parent does not service the fuse fd; the child does.  Close our
+	 * copy so the kernel sees a single server, and so that if the child
+	 * dies the connection aborts instead of hanging us forever.
+	 */
+	close(fd);
+
+	/*
+	 * mount() returns before the server has answered FUSE_INIT, so the
+	 * first open() can race and fail with ENOTCONN; retry until the
+	 * handshake settles.
+	 */
+	for (i = 0; i < 1000; i++) {
+		mfd = open(mnt, O_RDONLY | O_DIRECTORY);
+		if (mfd >= 0)
+			break;
+		usleep(1000);
+	}
+	if (mfd >= 0) {
+		syncfs(mfd);
+		close(mfd);
+	}
+
+	/*
+	 * No waiting is needed: the server writes syncfs_evfd before it replies
+	 * to FUSE_SYNCFS, and that reply is what unblocks the synchronous
+	 * syncfs() above.  So once syncfs() has returned, the eventfd is already
+	 * signalled if the opcode was propagated, and will never be otherwise.
+	 * poll() with a zero timeout therefore decides both cases immediately.
+	 */
+	pfd.fd = syncfs_evfd;
+	*seen = poll(&pfd, 1, 0) > 0 && (pfd.revents & POLLIN);
+
+	kill(pid, SIGKILL);
+	waitpid(pid, NULL, 0);
+	umount2(mnt, MNT_DETACH);
+	close(syncfs_evfd);
+	return 0;
+
+out_umount:
+	umount2(mnt, MNT_DETACH);
+out_fd:
+	close(fd);
+out_evfd:
+	close(syncfs_evfd);
+	return -1;
+}
+
+int main(void)
+{
+	char mnt[] = "/tmp/fuse_syncfs_XXXXXX";
+	int seen, ret;
+
+	ksft_print_header();
+	ksft_set_plan(3);
+
+	/* Hard watchdog: never let a stuck syncfs hang the test runner. */
+	signal(SIGALRM, SIG_DFL);
+	alarm(60);
+
+	if (geteuid() != 0)
+		ksft_exit_skip("test requires root to mount fuse\n");
+
+	if (!mkdtemp(mnt))
+		ksft_exit_fail_msg("mkdtemp failed\n");
+
+	/* T1: host-root mount, server opts in -> syncfs must reach server. */
+	ret = do_mount_and_syncfs(mnt, 1, 0, &seen);
+	if (ret < 0)
+		ksft_test_result_skip("T1: could not mount fuse\n");
+	else
+		ksft_test_result(seen,
+				 "T1 host-root + FUSE_HAS_SYNCFS: server receives FUSE_SYNCFS\n");
+
+	/* T2: host-root mount, server does NOT opt in -> no FUSE_SYNCFS. */
+	ret = do_mount_and_syncfs(mnt, 0, 0, &seen);
+	if (ret < 0)
+		ksft_test_result_skip("T2: could not mount fuse\n");
+	else
+		ksft_test_result(!seen,
+				 "T2 host-root, no opt-in: server does NOT receive FUSE_SYNCFS\n");
+
+	/*
+	 * T3: server opts in but opened /dev/fuse without CAP_SYS_ADMIN while
+	 * still in the initial user namespace -> kernel must withhold
+	 * FUSE_SYNCFS.  This is the case that distinguishes gating on the
+	 * server's privilege from gating on the mount's user namespace.
+	 */
+	ret = do_mount_and_syncfs(mnt, 1, 1, &seen);
+	if (ret < 0)
+		ksft_test_result_skip("T3: could not mount fuse unprivileged\n");
+	else
+		ksft_test_result(!seen,
+				 "T3 init_userns, opener lacks CAP_SYS_ADMIN: FUSE_SYNCFS withheld\n");
+
+	rmdir(mnt);
+	ksft_finished();
+}

base-commit: 4eb2586bd40db27d77cc5b724ca9386ed0c71d53
-- 
2.53.0

