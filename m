Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD224DEC1E;
	Fri,  2 Oct 2026 13:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949265; cv=none; b=NnHpbQQVY7I3ZZpT6YPgwg7V16pjnUZKxyoPV377osOlvRrqLnQ3DNIaNunXQ/rx6IFlyeVgOMkOBUibry2xSBE2hYxJRQtT0PoUiT2YjLlWOrm4sKsYW+GPy92M+BZAQbqGNTCPTFy0u7jFM07aJ22rU88yPPvWgxfjvXPi/os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949265; c=relaxed/simple;
	bh=eMVNQDHBhsS8n418SK8qWeJaWkwjkfji45j4NHzcOiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZUFnsvHVLHHOuGQcPiIK5Pmge50KuWHDMlcCmR592Y/xWaikLnsl7HfDAH9OEF6yVLlY+uuqLHiVuDe/EpcGV0Ql7AeInxz4JDTkZ9g7Le9QsFwzOuUoi2l7YE8+YLEM1XTn+/73j9LgtvEmOWuEPi2kVAjpSLExwVnznjWVkHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZehBxbz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZehBxbz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624411F00893;
	Fri,  2 Oct 2026 13:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790949264;
	bh=CXlFBKPw/kKqUYL0fAlx1bx+fl4i7V/NhKk5kA50TsY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FZehBxbzNd1SQHHScFmKPmahaVYzu+V536+hGWMI3UcsW29/thBEPozcj674sktT6
	 l+oMoCjxcbX6QMea/gwGlLG7lj8kdfNLT252Q35tfFB013E6NQ0YjBRGOuUDfH3rp2
	 f+QfrqeMK6oTU3rV0Mj0nRD19q2YMtTUjNJxLkTU1WVPJ8/nAU3m3BprTSU9m9kBzU
	 5CPvUD2KeckLqK7O0Szpi0+EcpGr9w0Qx6BdOZrZV9Bxx9X4OBO9VpqOdg6ItGfGOM
	 7ihga7oktoSq+DNbuqZ1pQ/g8q6REfWLU+ll12bW8w01YHfW16FQJ493e9AQfrQTru
	 qXjZcy6FZPtag==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 02 Oct 2026 15:52:51 +0200
Subject: [PATCH 20/21] selftests/filesystems: add a helper that holds a
 readdir in a page fault
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-work-mount-fixes-4-v1-20-dd44b89d44ce@kernel.org>
References: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
In-Reply-To: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Jann Horn <jannh@google.com>, Neil Brown <neil@brown.name>, 
 Amir Goldstein <amir73il@gmail.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=7504; i=brauner@kernel.org;
 h=from:subject:message-id; bh=eMVNQDHBhsS8n418SK8qWeJaWkwjkfji45j4NHzcOiI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt3x49eaLWHN2txxp7jkuKxmZEGsW2qXbkvlLKiGo1Z
 i/1TWLoKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmIiRFyPDP27z1Z4Ce7sCZ2pJ
 XmPMENsgxxqR97/G+Yl4G+/ebLMwRoY3s3//nXptwcflszjPTTQyWB5f5LTCfJe9s++q8L1GT6b
 wAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

A getdents64() whose buffer is a page registered with userfaultfd sits
in handle_userfault() with whatever iterate_dir() took before it copied
the entries. Add readdir_hold.h for tests that want to know what that
blocks: it opens the userfaultfd before the test enters a user
namespace, the fault happens in the kernel and needs CAP_SYS_PTRACE in
the initial one, starts the readdir in a thread, waits until that
thread is stuck, queues a create behind it and waits for it to settle,
then probes a lookup with a watchdog and says whether it came back.
The page is released afterwards so that everything drains on a kernel
that still holds the lock across the copy.

The two users follow.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/filesystems/readdir_hold.h | 224 +++++++++++++++++++++
 1 file changed, 224 insertions(+)

diff --git a/tools/testing/selftests/filesystems/readdir_hold.h b/tools/testing/selftests/filesystems/readdir_hold.h
new file mode 100644
index 000000000000..57eee1bef470
--- /dev/null
+++ b/tools/testing/selftests/filesystems/readdir_hold.h
@@ -0,0 +1,224 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Hold a readdir of a directory in the page fault of its buffer and see
+ * whether a create and a lookup in that directory wait for it. For a
+ * directory that is permanently empty they must not.
+ */
+#ifndef __SELFTESTS_READDIR_HOLD_H
+#define __SELFTESTS_READDIR_HOLD_H
+
+#include <errno.h>
+#include <fcntl.h>
+#include <poll.h>
+#include <pthread.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <linux/userfaultfd.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+
+#define HOLD_FAULT_MS	5000	/* for the reader to reach the fault */
+#define HOLD_QUEUE_MS	2000	/* for the create to queue up behind it */
+#define HOLD_LOOKUP_MS	5000	/* for the lookup to come back */
+
+struct readdir_hold {
+	int uffd;
+	int taskdir;		/* /proc/self/task, from before any namespace change */
+	long page_size;
+	char *page;		/* faults until released */
+	int dfd;
+	pid_t creator_tid;
+	int created;
+	int done[2];		/* the finder writes a byte when it is back */
+};
+
+/*
+ * The fault happens in the kernel, so the userfaultfd needs CAP_SYS_PTRACE
+ * in the initial user namespace or vm.unprivileged_userfaultfd. Call this
+ * before entering a user namespace.
+ */
+static inline int readdir_hold_init(struct readdir_hold *h)
+{
+	struct uffdio_api api = { .api = UFFD_API };
+
+	h->page = MAP_FAILED;
+	h->page_size = sysconf(_SC_PAGESIZE);
+	h->taskdir = open("/proc/self/task", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	h->uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
+	if (h->uffd < 0 || h->taskdir < 0 || ioctl(h->uffd, UFFDIO_API, &api)) {
+		if (h->uffd >= 0)
+			close(h->uffd);
+		if (h->taskdir >= 0)
+			close(h->taskdir);
+		h->uffd = h->taskdir = -1;
+		return -1;
+	}
+	return 0;
+}
+
+static inline void readdir_hold_destroy(struct readdir_hold *h)
+{
+	if (h->uffd >= 0)
+		close(h->uffd);
+	if (h->taskdir >= 0)
+		close(h->taskdir);
+	h->uffd = h->taskdir = -1;
+}
+
+static inline void *readdir_hold_reader(void *arg)
+{
+	struct readdir_hold *h = arg;
+
+	/* the first byte written to the buffer faults until released */
+	syscall(__NR_getdents64, h->dfd, h->page, h->page_size);
+	return NULL;
+}
+
+static inline void *readdir_hold_creator(void *arg)
+{
+	struct readdir_hold *h = arg;
+
+	h->creator_tid = syscall(__NR_gettid);
+	/* takes the directory lock exclusive before it fails */
+	mkdirat(h->dfd, "x", 0755);
+	__atomic_store_n(&h->created, 1, __ATOMIC_RELEASE);
+	return NULL;
+}
+
+static inline void *readdir_hold_finder(void *arg)
+{
+	struct readdir_hold *h = arg;
+	int fd;
+
+	/* a lookup that misses the dcache takes the lock shared */
+	fd = openat(h->dfd, "no_such_name", O_RDONLY | O_CLOEXEC);
+	if (fd >= 0)
+		close(fd);
+	if (write(h->done[1], "x", 1) != 1)
+		perror("readdir_hold: finder");
+	return NULL;
+}
+
+/* the creator is back, or waits in the kernel for the lock */
+static inline bool readdir_hold_creator_settled(struct readdir_hold *h)
+{
+	char path[32], buf[256], *p;
+	ssize_t n;
+	int fd;
+
+	if (__atomic_load_n(&h->created, __ATOMIC_ACQUIRE))
+		return true;
+	if (!h->creator_tid)
+		return false;
+	snprintf(path, sizeof(path), "%d/stat", h->creator_tid);
+	fd = openat(h->taskdir, path, O_RDONLY | O_CLOEXEC);
+	if (fd < 0)
+		return false;
+	n = read(fd, buf, sizeof(buf) - 1);
+	close(fd);
+	if (n <= 0)
+		return false;
+	buf[n] = 0;
+	/* "pid (comm) state ..." */
+	p = strrchr(buf, ')');
+	return p && p[1] == ' ' && p[2] == 'D';
+}
+
+static inline bool readdir_hold_faulted(struct readdir_hold *h)
+{
+	struct pollfd pfd = { .fd = h->uffd, .events = POLLIN };
+	struct uffd_msg msg;
+
+	if (poll(&pfd, 1, HOLD_FAULT_MS) != 1)
+		return false;
+	if (read(h->uffd, &msg, sizeof(msg)) != sizeof(msg))
+		return false;
+	return msg.event == UFFD_EVENT_PAGEFAULT;
+}
+
+/* let the reader go on */
+static inline void readdir_hold_release(struct readdir_hold *h)
+{
+	struct uffdio_copy cp = {
+		.dst = (unsigned long)h->page,
+		.len = h->page_size,
+	};
+	void *zero;
+
+	zero = calloc(1, h->page_size);
+	if (!zero)
+		return;
+	cp.src = (unsigned long)zero;
+	if (ioctl(h->uffd, UFFDIO_COPY, &cp) && errno != EEXIST)
+		perror("readdir_hold: UFFDIO_COPY");
+	free(zero);
+}
+
+/*
+ * A readdir of @dfd that sticks in the fault of its buffer, then a create
+ * and a lookup in @dfd. Whether the lookup came back while the readdir was
+ * still stuck goes to @stalled. Returns -1 when that could not be found
+ * out.
+ */
+static inline int readdir_hold_check(struct readdir_hold *h, int dfd,
+				     bool *stalled)
+{
+	pthread_t reader, creator, finder;
+	struct uffdio_register reg = {};
+	struct pollfd pfd;
+	int ret = -1, i;
+
+	h->dfd = dfd;
+	h->created = 0;
+	h->creator_tid = 0;
+	h->page = mmap(NULL, h->page_size, PROT_READ | PROT_WRITE,
+		       MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (h->page == MAP_FAILED)
+		return -1;
+	reg.range.start = (unsigned long)h->page;
+	reg.range.len = h->page_size;
+	reg.mode = UFFDIO_REGISTER_MODE_MISSING;
+	if (ioctl(h->uffd, UFFDIO_REGISTER, &reg) || pipe2(h->done, O_CLOEXEC))
+		goto out_page;
+
+	if (pthread_create(&reader, NULL, readdir_hold_reader, h))
+		goto out_pipe;
+	if (!readdir_hold_faulted(h))
+		goto out_reader;
+	if (pthread_create(&creator, NULL, readdir_hold_creator, h))
+		goto out_reader;
+	for (i = 0; i < HOLD_QUEUE_MS / 10 && !readdir_hold_creator_settled(h); i++)
+		usleep(10000);
+	if (pthread_create(&finder, NULL, readdir_hold_finder, h))
+		goto out_creator;
+
+	pfd.fd = h->done[0];
+	pfd.events = POLLIN;
+	*stalled = poll(&pfd, 1, HOLD_LOOKUP_MS) != 1;
+	ret = 0;
+
+	readdir_hold_release(h);
+	pthread_join(finder, NULL);
+out_creator:
+	if (ret)
+		readdir_hold_release(h);
+	pthread_join(creator, NULL);
+out_reader:
+	if (ret)
+		readdir_hold_release(h);
+	pthread_join(reader, NULL);
+out_pipe:
+	close(h->done[0]);
+	close(h->done[1]);
+out_page:
+	munmap(h->page, h->page_size);
+	h->page = MAP_FAILED;
+	return ret;
+}
+
+#endif /* __SELFTESTS_READDIR_HOLD_H */

-- 
2.53.0

