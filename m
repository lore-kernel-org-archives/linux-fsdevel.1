Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892810;
	b=NRV/qOMGLaEbzW7kloTeHNYNpx9BUorgVx8OceLBp0pOtBePTCgznRlg8G4vRy38tvqo
	 lUABiVoWffhJEkPHvqp5DU6owe1KT6GaVZHGvLqxqLuJQ8Pw3EKFjhlS99V73ck2hXKwp
	 5KPfNJXTi8Nj8TGOD6ncz0yKUIxCMmNnzPoK5w2G3JxIVHr0SwzrLJZQG8DK8lSq7N4v+
	 2BjxBWWMGNHWAc63T+WNPPQoF2AvnKolvb7qndMHved6mHZXhe0XV9csfQdCyLuupM+Mw
	 NKR0hHqPyTt+hvYgL0Y3rgtA3PXRheP3odCndzcMOI+KQgQStIjrvRwEKL1eAHZIrjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892810;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=ebpvCnkokZ8ZNIVT6Z4xIIWs0TE5IM/aJAv+i7NfYeY=;
	b=E4xiIlFP8a3rE/hKdEhNgJl6P3hipLvUwbg9u75SZz4b/gns30vP2f/MP2Bb8p57jGpR
	 1rWZAT97ZDlPUwV3yuKKV3EYc+g7Z2cAd+jaRXtIhGj35fOMedsSAWFhbcU/K3uKm5duz
	 DdeFq2DmdKboUM/GxyvI7C/lhwLOu6QlP9SKsgsUtMdVqjisQE57bN58w/SbZD8c6GAse
	 xwwnolhU7QuK+vPejCOj1z1Yh+7lOkJaqUihYUR/BnfaK4tqEszceyZlnBYTFqq2HX7BA
	 v8/NMsVZU8o+0PSxEPO1p4ZOvKePTxDRBpqfiNA0aKYUillW7YCW6sybN3H9UzY3qcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=YoEvjbqH;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB21606D806
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:33:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CB21606D806
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=YoEvjbqH
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91e7fc8265aso23634946d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793892805; x=1794497605; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ebpvCnkokZ8ZNIVT6Z4xIIWs0TE5IM/aJAv+i7NfYeY=;
        b=YoEvjbqHCSGj8a/1AiXEGoyHh6YGQvkHxoePpaOil/H1Z+nNt5TbNSJgT5rw+goQzu
         w2Cxj5rKAjzbv4K0L9/T3oR+6FHppghUzYIcstf8bb1ASJ0zxf8XUaD8OH3yeEp5pA1V
         WBjHmNR0eXru7UDMhGwYTqKz5+iPStPgFKpq96Ps+PRGfxdzsG8k8nbiuhC7pjbbadij
         R0Cgygqiacnl/L75wFEPd6aTXW/1T4FuemsttlQxTsL3gaNbJEWv7GktLMf5BcNQgGDK
         aC4JYilFIwuN+PhPBWNd8NfvnM6Vq5yugSlX60yCmlOb+RR1zDJ3O3oooYXm4U4a8B4z
         Irbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892805; x=1794497605;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ebpvCnkokZ8ZNIVT6Z4xIIWs0TE5IM/aJAv+i7NfYeY=;
        b=I9wnjHH9gcDQxHmn3J5HkaLN0tLmFfEpwVrNcripkP+F2SP7UASjI5qgp81HigndXK
         FbzRZ1cNDWGHQ53mnCjspw3I+FjcMUTqT2gXlj1Dwl4rd9hV4VrQeCZH+YJSDxvdnpjL
         qWZpFqxcClyzPmq+RrJ5G6jlgeq5+CJ4l5W2gITdxFli7v2yzc/mRlcXYJgGM4L5zyWA
         2fZCH1uQ8FEt2dqH18AHNvbMtbSfQRakbTvuJYlZTCaukXpOqU1okVs4GEINrJuC1qVH
         4nPaR1dBrSs4U4dnhxFLYwhImPnyziS7FCAH3FcAsL6lKLa9+9ZqAVgF/fhk+LaQKQmQ
         8Vzw==
X-Gm-Message-State: APuU4Z8l784xnWl2HHMaDBLPfScpmUXfMq3xbg58C7TyCj2FTN2st28Z
	KD9eFU/3k6Doyp8SkVx0qx5bFI3W/BRq4NWH8W3DpfURFM89gLEwQbZvw+juM4asCK4=
X-Gm-Gg: AYBFou0toifhjHKZVUaBFJr+v2pTMLz28mC4RAGEfGITiic48trTolTjoThMyJviF9R
	DYvoxN+OqRz4N+ZJsBs1k/jNBZoCjs0FDfYs8O5oH6tj6gaigN5q3n1ebqNtb6rmsOLW7zFV5pY
	w5C/EJGbKJZLbaDdZH0pjAnde1NCSgyILPmV7NakpNwpouHZ4DKKBNiAYjhkQ2ply6A6vnaeka7
	+zEQ8J/NZx297qfbroqFB4QuJWKPHSfaWKa7nmZZs/HqkwIJZeAmJlRz4BfyG+yXz/z8IbMm5Mc
	Jpjmyi//JxuZN8R67yuwo2mMXvJ00Xpp7gBWfCZzUz7S3epva7hW/OX6DxClw4toE7PuH/QPJW9
	CX7ftfCZ7cJrsUNakJd6CsOO1GVV6ffrYbWbrdJCNBzA2Usmxc6SGFLZZlXKOq3jDfMN7+msvLU
	MMezW71pNQGFLtVvIqbxkNGiEaIKG4gIg7hd0DlnpBxfJv7x/+J2O05lIgd6rg47W5iRj+811FM
	a6RyS912Xgh2Goo1LfD70wpU/8hhqNUmMl/XJfTnBmikXw/WW0VYLQpkhsx8ggM9H29trq4OiKG
	V0JfTL3gDrLB8V9QQhzolB0+CyFhgvI=
X-Received: by 2002:a05:6214:2425:b0:91e:9679:55f with SMTP id 6a1803df08f44-91e9679098emr40041926d6.10.1793892802145;
        Thu, 05 Nov 2026 07:33:22 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.241])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7e70f84dsm49707396d6.32.2026.11.05.07.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:33:20 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:03:22 +0000
Subject: [PATCH RFC v3 90/90] selftests: add tests for cells
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-b4-cells-v3-90-bc9095937a84@toxicpanda.com>
References: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
In-Reply-To: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Andrew Halaney <andrew@amutable.com>, Jeremy Bingham <jbingham@gmail.com>, 
 Tahera Fahimi <taherafahimi@linux.microsoft.com>, 
 Serge Hallyn <sergeh@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890936; l=231452;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=ACIWhQ1RCOgG49XtdjUSNtx/sB+aWPocuwj2Y0EAlgM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QF6+cGj0I1E75RrnMTk3cKPTCkJFLijMvVFXUQn48Y7SVtd13JV+mIc20HNQbBF/tpPbEX0hXcy
 M47b99RbjKQg=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

The tests build cells, run programs in them, kill them, and try the things
that are not supposed to work.

There are seven test programs, one per topic: the life of a cell,
spawning, the slots, ids, the boundary, the network and cgroups. Each of
them acts as a builder, and cell_test.h holds the code that they share.
cell_child is a statically linked program that is copied into the
otherwise empty tree of each cell. It reports what it finds from the
inside.

The tests cover:

  - the states of a cell, and that it is not reported dead early
  - empty pidfds, and what a new task does and does not inherit
  - capabilities: a task has what the builder named and never gains more
  - setns(), unshare() and related calls, refused from both sides
  - set-id bits and file capabilities
  - unix sockets between a cell and the host
  - the id window, ids that must not reach a filesystem of the host, mount
    options, overlayfs, and that the builder is told the block
  - device nodes and supplementary groups
  - the permission checks on the slots, and every allocation in the seal
    failing in turn
  - what can and cannot get into a budget, what a cell and its builder can
    do below it, and what a cell cannot do to the budget itself
  - a network that is set up from the outside, no network at all, the
    rights of a cell over its network, and that the network goes away with
    the cell
  - what seccomp does and does not cover
  - that the host runs no program and takes no core dump for a cell
  - an unprivileged builder, and a pod made of several cells
  - a kill, a close and a start racing with spawns in flight

The tests need root, cgroup2 with the memory and pids controllers, and
tmpfs. Some need more and are skipped otherwise. CELL_TEST_EXT4_IMG names
an ext4 image that can be frozen. CELL_TEST_9P_TAG names a writable 9p
share, for ->atomic_open(). /dev/vhost-net is used if it exists.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tools/testing/selftests/Makefile                  |    1 +
 tools/testing/selftests/cell/.gitignore           |    2 +
 tools/testing/selftests/cell/Makefile             |   14 +
 tools/testing/selftests/cell/cell_boundary_test.c |  535 +++++++
 tools/testing/selftests/cell/cell_cgroup_test.c   |  546 +++++++
 tools/testing/selftests/cell/cell_child.c         | 1626 +++++++++++++++++++++
 tools/testing/selftests/cell/cell_ids_test.c      |  762 ++++++++++
 tools/testing/selftests/cell/cell_life_test.c     |  446 ++++++
 tools/testing/selftests/cell/cell_net_test.c      |  915 ++++++++++++
 tools/testing/selftests/cell/cell_slots_test.c    |  748 ++++++++++
 tools/testing/selftests/cell/cell_spawn_test.c    |  559 +++++++
 tools/testing/selftests/cell/cell_test.h          |  586 ++++++++
 tools/testing/selftests/cell/cell_util.h          |  108 ++
 tools/testing/selftests/cell/config               |   35 +
 14 files changed, 6883 insertions(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 07c3719f8b04..45b78a73fa2e 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -8,6 +8,7 @@ TARGETS += bpf
 TARGETS += breakpoints
 TARGETS += cachestat
 TARGETS += capabilities
+TARGETS += cell
 TARGETS += cgroup
 TARGETS += clone3
 TARGETS += connector
diff --git a/tools/testing/selftests/cell/.gitignore b/tools/testing/selftests/cell/.gitignore
new file mode 100644
index 000000000000..585ed8e41c1c
--- /dev/null
+++ b/tools/testing/selftests/cell/.gitignore
@@ -0,0 +1,2 @@
+cell_*_test
+cell_child
diff --git a/tools/testing/selftests/cell/Makefile b/tools/testing/selftests/cell/Makefile
new file mode 100644
index 000000000000..ccf1fa3c6565
--- /dev/null
+++ b/tools/testing/selftests/cell/Makefile
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0
+CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES)
+
+TEST_GEN_PROGS := cell_life_test cell_spawn_test cell_slots_test cell_ids_test
+TEST_GEN_PROGS += cell_boundary_test cell_net_test cell_cgroup_test
+TEST_GEN_FILES := cell_child
+
+include ../lib.mk
+
+# Runs inside a cell, whose tree holds nothing else.
+$(OUTPUT)/cell_child: cell_child.c cell_util.h
+	$(CC) $(CFLAGS) -static -o $@ $<
+
+$(TEST_GEN_PROGS): cell_test.h cell_util.h
diff --git a/tools/testing/selftests/cell/cell_boundary_test.c b/tools/testing/selftests/cell/cell_boundary_test.c
new file mode 100644
index 000000000000..483a5e642ebf
--- /dev/null
+++ b/tools/testing/selftests/cell/cell_boundary_test.c
@@ -0,0 +1,535 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Tests for cells, the boundary: nobody enters, a uid means nothing across it,
+ * and sockets carry bytes.
+ */
+#include "cell_test.h"
+
+TEST_F(cell, membership)
+{
+	RUN_IN_CELL("membership");
+}
+
+TEST_F(cell, nobody_enters)
+{
+	static const char * const ns[] = { "user", "mnt", "pid", "ipc", "uts", "cgroup" };
+	char path[64];
+	unsigned int i;
+	pid_t pid;
+	int pidfd, fd;
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536 }), 0);
+	pidfd = spawn(self->c.cfd, &pid, "pause", NULL, NULL);
+	ASSERT_GE(pidfd, 0);
+
+	for (i = 0; i < ARRAY_SIZE(ns); i++) {
+		snprintf(path, sizeof(path), "/proc/%d/ns/%s", pid, ns[i]);
+		fd = open(path, O_RDONLY);
+		ASSERT_GE(fd, 0);
+		EXPECT_EQ(setns(fd, 0), -1) TH_LOG("entered %s", ns[i]);
+		EXPECT_EQ(errno, EPERM) TH_LOG("%s", ns[i]);
+		close(fd);
+	}
+	EXPECT_EQ(setns(pidfd, CLONE_NEWIPC), -1);
+	EXPECT_EQ(errno, EPERM);
+	close(pidfd);
+}
+
+/* Not while it is built either. Whoever got in could become the init of the cell. */
+TEST_F(cell, nobody_enters_while_it_is_built)
+{
+	int fd;
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536, .no_seal = true }), 0);
+	fd = cell_open(self->c.cfd, CELL_OPEN_SLOT, "pids", NULL, 0);
+	ASSERT_GE(fd, 0);
+	EXPECT_EQ(setns(fd, CLONE_NEWPID), -1);
+	EXPECT_EQ(errno, EPERM);
+	close(fd);
+}
+
+static int drop_caps(void)
+{
+	struct __user_cap_header_struct hdr = { .version = _LINUX_CAPABILITY_VERSION_3 };
+	struct __user_cap_data_struct data[2] = {};
+
+	return syscall(SYS_capset, &hdr, data);
+}
+
+/* A one-id cell runs on the kuid of whoever made it. That must not count. */
+/* Have the kernel send @pid a SIGUSR1 on behalf of the caller. */
+static int sigio_to(pid_t pid)
+{
+	int sp[2], ret = -1;
+
+	if (socketpair(AF_UNIX, SOCK_STREAM, 0, sp))
+		return -1;
+	if (!fcntl(sp[0], F_SETOWN, pid) && !fcntl(sp[0], F_SETSIG, SIGUSR1) &&
+	    !fcntl(sp[0], F_SETFL, O_ASYNC) && write(sp[1], "x", 1) == 1)
+		ret = 0;
+	close(sp[0]);
+	close(sp[1]);
+	return ret;
+}
+
+#define V1ROOT	"/tmp/cell-test-v1"
+
+TEST_F(cell, equal_uid_means_nothing)
+{
+	int pidfd, status;
+	pid_t pid, plain, prober;
+	bool v1;
+
+	/* A cgroup v1 hierarchy with a group that uid 1000 may write to. */
+	mkdir(V1ROOT, 0755);
+	v1 = !mount("none", V1ROOT, "cgroup", 0, "none,name=celltest");
+	if (v1) {
+		ASSERT_EQ(mkdir(V1ROOT "/sub", 0755), 0);
+		ASSERT_EQ(chown(V1ROOT "/sub/cgroup.procs", 1000, 1000), 0);
+	} else {
+		TH_LOG("no cgroup v1, that part is skipped");
+	}
+
+	/* Made by uid 1000, with the privilege the mount work takes. */
+	ASSERT_EQ(prctl(PR_SET_KEEPCAPS, 1, 0, 0, 0), 0);
+	plain = fork();
+	ASSERT_GE(plain, 0);
+	if (!plain) {
+		if (setresgid(1000, 1000, 1000) || setresuid(1000, 1000, 1000) ||
+		    drop_caps() || prctl(PR_SET_DUMPABLE, 1, 0, 0, 0))
+			_exit(1);
+		pause();
+		_exit(0);
+	}
+
+	ASSERT_EQ(setresgid(-1, 1000, -1), 0);
+	ASSERT_EQ(setresuid(-1, 1000, -1), 0);
+	self->c.cfd = cell_create(CELL_SELF, 0);
+	ASSERT_EQ(setresuid(-1, 0, -1), 0);
+	ASSERT_EQ(setresgid(-1, 0, -1), 0);
+	ASSERT_GE(self->c.cfd, 0);
+	close(self->c.cfd);
+	self->c.cfd = -1;
+
+	/* cell_build() makes its own: do all of it as euid 1000. */
+	prober = fork();
+	ASSERT_GE(prober, 0);
+	if (!prober) {
+		struct __user_cap_header_struct hdr = { .version = _LINUX_CAPABILITY_VERSION_3 };
+		struct __user_cap_data_struct data[2];
+		struct pollfd pfd = { .events = POLLIN };
+		struct sched_param sp = { 0 };
+		struct rlimit rl;
+		struct cellctx c;
+		cpu_set_t cpus;
+		pid_t victim;
+		char buf[32];
+		int step;
+
+		if (chown(CGROOT, 1000, 1000) || chown(CGROOT "/cgroup.procs", 1000, 1000))
+			_exit(10);
+		if (setgroups(2, (gid_t[]){ 2000, 2001 }))
+			_exit(11);
+		if (setresgid(1000, 1000, 1000) || setresuid(1000, 1000, 1000))
+			_exit(11);
+		if (syscall(SYS_capget, &hdr, data))
+			_exit(12);
+		data[0].effective = data[0].permitted;
+		data[1].effective = data[1].permitted;
+		if (syscall(SYS_capset, &hdr, data))
+			_exit(13);
+
+		step = cell_build(&c, &(struct build){ .ids = 1 });
+		if (step)
+			_exit(20 + step);
+		pidfd = spawn(c.cfd, &pid, "oneid", "1000", NULL);
+		if (pidfd < 0)
+			_exit(14);
+		if (cell_wait(c.cfd))
+			_exit(15);
+		close(pidfd);
+		cell_cleanup(&c);
+
+		/* It would lose a capability with its first exec, so it gets none. */
+		step = cell_build(&c, &(struct build){ .ids = 1, .caps = CAP(CHOWN),
+						       .no_seal = true });
+		if (step)
+			_exit(80 + step);
+		if (!cell_configure(c.cfd, CELL_CMD_SEAL, NULL, NULL, 0) || errno != EINVAL)
+			_exit(16);
+		cell_cleanup(&c);
+
+		step = cell_build(&c, &(struct build){ .ids = 1 });
+		if (step)
+			_exit(50 + step);
+		pidfd = spawn(c.cfd, &pid, "usr1", NULL, NULL);
+		if (pidfd < 0)
+			_exit(16);
+		if (host_uid(pid) != 1000)
+			_exit(17);
+
+		/* Now be nobody in particular, with the very same uid. */
+		if (drop_caps())
+			_exit(18);
+		if (kill(plain, 0))
+			_exit(19);		/* an equal uid at home counts */
+		if (kill(pid, 0) != -1 || errno != EPERM)
+			_exit(2);
+		if (kill(pid, SIGKILL) != -1 || errno != EPERM)
+			_exit(3);
+		if (setpriority(PRIO_PROCESS, pid, 5) != -1 || errno != EPERM)
+			_exit(4);
+		/* IOPRIO_WHO_PROCESS, IOPRIO_CLASS_IDLE */
+		if (syscall(SYS_ioprio_set, 1, plain, 3 << 13))
+			_exit(7);
+		if (syscall(SYS_ioprio_set, 1, pid, 3 << 13) != -1 || errno != EPERM)
+			_exit(8);
+		CPU_ZERO(&cpus);
+		CPU_SET(0, &cpus);
+		if (sched_setaffinity(plain, sizeof(cpus), &cpus))
+			_exit(100);
+		if (sched_setaffinity(pid, sizeof(cpus), &cpus) != -1 || errno != EPERM)
+			_exit(101);
+		if (sched_setscheduler(plain, SCHED_BATCH, &sp))
+			_exit(102);
+		if (sched_setscheduler(pid, SCHED_BATCH, &sp) != -1 || errno != EPERM)
+			_exit(103);
+		if (prlimit(plain, RLIMIT_NOFILE, NULL, &rl))
+			_exit(104);
+		if (prlimit(pid, RLIMIT_NOFILE, NULL, &rl) != -1 || errno != EPERM)
+			_exit(105);
+		if (v1) {
+			snprintf(buf, sizeof(buf), "%d", plain);
+			if (write_file(V1ROOT "/sub/cgroup.procs", buf))
+				_exit(106);
+			snprintf(buf, sizeof(buf), "%d", pid);
+			if (write_file(V1ROOT "/sub/cgroup.procs", buf) != -1 ||
+			    errno != EACCES)
+				_exit(107);
+		}
+		/* SIGIO: fatal at home, never sent across. It would end the cell. */
+		victim = fork();
+		if (victim < 0)
+			_exit(108);
+		if (!victim) {
+			pause();
+			_exit(0);
+		}
+		if (sigio_to(victim) || waitpid(victim, &step, 0) != victim ||
+		    !WIFSIGNALED(step) || WTERMSIG(step) != SIGUSR1)
+			_exit(109);
+		if (sigio_to(pid))
+			_exit(110);
+		pfd.fd = pidfd;
+		if (poll(&pfd, 1, 200) != 0)
+			_exit(111);
+		/*
+		 * Last, since a traced task takes its signals differently. The
+		 * capability LSM refuses this one too, for the user namespace.
+		 */
+		if (ptrace(PTRACE_SEIZE, plain, 0, 0))
+			_exit(112);
+		if (ptrace(PTRACE_SEIZE, pid, 0, 0) != -1 || errno != EPERM)
+			_exit(113);
+		/* The handle is what counts. */
+		if (cell_kill(c.cfd, 0))
+			_exit(5);
+		if (cell_wait(c.cfd) != SIGKILL)
+			_exit(6);
+		_exit(0);
+	}
+	ASSERT_EQ(waitpid(prober, &status, 0), prober);
+	EXPECT_EQ(WIFEXITED(status) ? WEXITSTATUS(status) : -1, 0);
+
+	kill(plain, SIGKILL);
+	waitpid(plain, NULL, 0);
+	if (v1) {
+		EXPECT_EQ(rmdir(V1ROOT "/sub"), 0);
+		EXPECT_EQ(umount(V1ROOT), 0);
+	}
+	rmdir(V1ROOT);
+	EXPECT_EQ(chown(CGROOT, 0, 0), 0);
+	EXPECT_EQ(chown(CGROOT "/cgroup.procs", 0, 0), 0);
+}
+
+/* A hard boundary: the uid of root on the host counts for no more than any other. */
+TEST_F(cell, uid_0_means_nothing_either)
+{
+	struct pollfd pfd = { .events = POLLIN };
+	char buf[32];
+	int ready[2];
+	pid_t pid;
+	bool v1;
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536 }), 0);
+	ASSERT_EQ(pipe(ready), 0);
+	pfd.fd = prepare(self->c.cfd, "usr1", NULL, NULL);
+	ASSERT_GE(pfd.fd, 0);
+	ASSERT_EQ(pidfd_configure(pfd.fd, PIDFD_SET_FD, "3", NULL, ready[1]), 0);
+	ASSERT_EQ(pidfd_configure(pfd.fd, PIDFD_CMD_START, NULL, NULL, 0), 0);
+	pid = pidfd_nr(pfd.fd);
+	ASSERT_GT(pid, 0);
+	close(ready[1]);
+	/* Until it has its handler an init does not get the signal anyway. */
+	ASSERT_EQ(read(ready[0], buf, 1), 1);
+	close(ready[0]);
+
+	/* It would end the cell. */
+	ASSERT_EQ(sigio_to(pid), 0);
+	EXPECT_EQ(poll(&pfd, 1, 200), 0);
+
+	mkdir(V1ROOT, 0755);
+	v1 = !mount("none", V1ROOT, "cgroup", 0, "none,name=celltest");
+	if (v1) {
+		ASSERT_EQ(mkdir(V1ROOT "/sub", 0755), 0);
+		snprintf(buf, sizeof(buf), "%d", pid);
+		EXPECT_EQ(write_file(V1ROOT "/sub/cgroup.procs", buf), -1);
+		EXPECT_EQ(errno, EACCES);
+		EXPECT_EQ(rmdir(V1ROOT "/sub"), 0);
+		EXPECT_EQ(umount(V1ROOT), 0);
+	} else {
+		TH_LOG("no cgroup v1, that part is skipped");
+	}
+	rmdir(V1ROOT);
+	close(pfd.fd);
+}
+
+TEST_F(cell, sockets_carry_bytes)
+{
+	struct sockaddr_un addr = { .sun_family = AF_UNIX };
+	char ctl[CMSG_SPACE(sizeof(int))] = {}, c = 'h';
+	struct iovec iov = { .iov_base = &c, .iov_len = 1 };
+	struct msghdr msg = {
+		.msg_iov = &iov, .msg_iovlen = 1,
+		.msg_control = ctl, .msg_controllen = sizeof(ctl),
+	};
+	struct cmsghdr *cmsg = CMSG_FIRSTHDR(&msg);
+	int pidfd, sv[2], lsock, conn, zero = 0, cwd;
+	struct ucred uc;
+	socklen_t len;
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536, .no_seal = true }), 0);
+
+	/* A listener of the host's that the cell can reach by name. */
+	lsock = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
+	cwd = open(".", O_RDONLY | O_DIRECTORY);
+	ASSERT_EQ(fchdir(self->c.raw), 0);
+	strcpy(addr.sun_path, "tmp/sock");
+	ASSERT_EQ(bind(lsock, (struct sockaddr *)&addr, sizeof(addr)), 0);
+	ASSERT_EQ(chmod("tmp/sock", 0777), 0);
+	ASSERT_EQ(fchdir(cwd), 0);
+	ASSERT_EQ(listen(lsock, 1), 0);
+	ASSERT_EQ(cell_configure(self->c.cfd, CELL_CMD_SEAL, NULL, NULL, 0), 0);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, sv), 0);
+	pidfd = prepare(self->c.cfd, "unix", NULL, NULL);
+	ASSERT_GE(pidfd, 0);
+
+	/* A file in flight from before the socket is given away. */
+	cmsg->cmsg_level = SOL_SOCKET;
+	cmsg->cmsg_type = SCM_RIGHTS;
+	cmsg->cmsg_len = CMSG_LEN(sizeof(int));
+	memcpy(CMSG_DATA(cmsg), &zero, sizeof(int));
+	c = 'q';
+	ASSERT_EQ(sendmsg(sv[0], &msg, 0), 1);
+	c = 'h';
+
+	ASSERT_EQ(pidfd_configure(pidfd, PIDFD_SET_FD, "3", NULL, sv[1]), 0);
+	close(sv[1]);
+	ASSERT_EQ(pidfd_configure(pidfd, PIDFD_CMD_START, NULL, NULL, 0), 0);
+
+	/* From the moment it was given away. */
+	EXPECT_EQ(sendmsg(sv[0], &msg, 0), -1);
+	EXPECT_EQ(errno, EPERM);
+
+	ASSERT_EQ(read(sv[0], &c, 1), 1);
+	EXPECT_EQ(c, 'a');
+	ASSERT_EQ(read(sv[0], &c, 1), 1);
+	EXPECT_EQ(c, 'b');
+	ASSERT_EQ(write(sv[0], "h", 1), 1);
+
+	ASSERT_EQ(wait_for(lsock, pidfd), 0);
+	conn = accept(lsock, NULL, NULL);
+	ASSERT_GE(conn, 0);
+	len = sizeof(uc);
+	EXPECT_EQ(getsockopt(conn, SOL_SOCKET, SO_PEERCRED, &uc, &len), -1);
+	EXPECT_EQ(errno, ENODATA);
+	c = 'h';
+	EXPECT_EQ(sendmsg(conn, &msg, 0), -1);
+	EXPECT_EQ(errno, EPERM);
+	ASSERT_EQ(read(conn, &c, 1), 1);
+	EXPECT_EQ(c, 'c');
+
+	EXPECT_EQ(cell_wait(self->c.cfd), 0);
+	close(conn);
+	close(lsock);
+	close(sv[0]);
+	close(pidfd);
+	close(cwd);
+}
+
+/* See check_peer_race(). */
+TEST_F(cell, peer_is_checked_and_read_at_once)
+{
+	struct sockaddr_un addr = { .sun_family = AF_UNIX };
+	int lsock, cwd, pidfd, status;
+	pid_t pid;
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536, .no_seal = true }), 0);
+	lsock = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
+	ASSERT_GE(lsock, 0);
+	cwd = open(".", O_RDONLY | O_DIRECTORY);
+	ASSERT_EQ(fchdir(self->c.raw), 0);
+	strcpy(addr.sun_path, "tmp/sock");
+	ASSERT_EQ(bind(lsock, (struct sockaddr *)&addr, sizeof(addr)), 0);
+	ASSERT_EQ(chmod("tmp/sock", 0777), 0);
+	ASSERT_EQ(fchdir(cwd), 0);
+	close(cwd);
+	ASSERT_EQ(listen(lsock, 128), 0);
+	ASSERT_EQ(cell_configure(self->c.cfd, CELL_CMD_SEAL, NULL, NULL, 0), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (!pid) {
+		for (;;) {
+			int conn = accept(lsock, NULL, NULL);
+
+			if (conn >= 0)
+				close(conn);
+		}
+	}
+	pidfd = spawn(self->c.cfd, NULL, "peer-race", NULL, NULL);
+	ASSERT_GE(pidfd, 0);
+	EXPECT_EQ(cell_wait(self->c.cfd), 0);
+	close(pidfd);
+	kill(pid, SIGKILL);
+	waitpid(pid, &status, 0);
+	close(lsock);
+}
+
+#define HELPER_RAN	"/tmp/cell_test_helper_ran"
+#define CORE_SOCK	"/tmp/cell_test_core.sock"
+
+static int read_line(const char *path, char *buf, size_t len)
+{
+	int fd = open(path, O_RDONLY | O_CLOEXEC);
+	ssize_t n = fd < 0 ? -1 : read(fd, buf, len - 1);
+
+	close(fd);
+	if (n < 0)
+		return -1;
+	buf[n] = 0;
+	buf[strcspn(buf, "\n")] = 0;
+	return 0;
+}
+
+/* Has the kernel run the helper with @arg among its arguments? It may take a moment. */
+static char helper_log[4096];
+
+static bool helper_ran(const char *arg)
+{
+	char *buf = helper_log;
+	int i, fd;
+
+	for (i = 0; i < 20; i++) {
+		fd = open(HELPER_RAN, O_RDONLY | O_CLOEXEC);
+		memset(buf, 0, sizeof(helper_log));
+		if (fd >= 0 && read(fd, buf, sizeof(helper_log) - 1) > 0 && strstr(buf, arg)) {
+			close(fd);
+			return true;
+		}
+		close(fd);
+		usleep(50000);
+	}
+	return false;
+}
+
+/*
+ * There are things a task can do that make the kernel run a program: as root, on the
+ * host, in no namespace but the first. Not for a task of a cell.
+ */
+TEST_F(cell, host_runs_no_program_for_a_cell)
+{
+	char self_path[256] = {}, child[300], pattern[340], modprobe[256], core[256];
+	struct sockaddr_un addr = { .sun_family = AF_UNIX, .sun_path = CORE_SOCK };
+	bool request_key = false;
+	int pidfd, status, lsock;
+	struct pollfd pfd;
+	pid_t pid;
+
+	if (read_line("/proc/sys/kernel/modprobe", modprobe, sizeof(modprobe)) ||
+	    read_line("/proc/sys/kernel/core_pattern", core, sizeof(core)))
+		SKIP(return, "no modules or no core dumps");
+	ASSERT_GT(readlink("/proc/self/exe", self_path, sizeof(self_path) - 1), 0);
+	*strrchr(self_path, '/') = 0;
+	snprintf(child, sizeof(child), "%s/cell_child", self_path);
+	snprintf(pattern, sizeof(pattern), "|%s core %%p", child);
+	ASSERT_EQ(write_file("/proc/sys/kernel/modprobe", child), 0);
+	ASSERT_EQ(write_file("/proc/sys/kernel/core_pattern", pattern), 0);
+	/* The path of this one is fixed. Leave a real one alone. */
+	mkdir("/sbin", 0755);
+	request_key = !symlink(child, "/sbin/request-key");
+
+	/* They do tell: this is what it looks like for a task of the host. */
+	unlink(HELPER_RAN);
+	EXPECT_EQ(socket(AF_ECONET, SOCK_DGRAM, 0), -1);
+	EXPECT_TRUE(helper_ran("net-pf-19"));
+	if (request_key) {
+		syscall(SYS_request_key, "user", "cell:test", "make it", KEY_SPEC_PROCESS_KEYRING);
+		EXPECT_TRUE(helper_ran("request-key"));
+	}
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (!pid)
+		raise(SIGSEGV);
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_TRUE(helper_ran(" core "));
+
+	unlink(HELPER_RAN);
+	EXPECT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536, .net_str = "new" }), 0);
+	pidfd = spawn(self->c.cfd, NULL, "helpers", NULL, NULL);
+	EXPECT_GE(pidfd, 0);
+	/* Killed by the signal, and nothing was dumped. */
+	EXPECT_EQ(cell_wait(self->c.cfd), SIGILL);
+	close(pidfd);
+	usleep(300000);
+	EXPECT_EQ(access(HELPER_RAN, F_OK), -1) {
+		helper_ran("\n\n");
+		TH_LOG("it ran: %s", helper_log);
+	}
+	cell_cleanup(&self->c);
+
+	/* A core dump can go to a socket as well, where a daemon of the host listens. */
+	unlink(CORE_SOCK);
+	lsock = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
+	ASSERT_GE(lsock, 0);
+	ASSERT_EQ(bind(lsock, (struct sockaddr *)&addr, sizeof(addr)), 0);
+	ASSERT_EQ(listen(lsock, 4), 0);
+	pfd = (struct pollfd){ .fd = lsock, .events = POLLIN };
+	if (!write_file("/proc/sys/kernel/core_pattern", "@" CORE_SOCK)) {
+		pid = fork();
+		ASSERT_GE(pid, 0);
+		if (!pid)
+			raise(SIGSEGV);
+		EXPECT_EQ(poll(&pfd, 1, 5000), 1);
+		close(accept(lsock, NULL, NULL));
+		ASSERT_EQ(waitpid(pid, &status, 0), pid);
+
+		EXPECT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536 }), 0);
+		pidfd = spawn(self->c.cfd, NULL, "helpers", NULL, NULL);
+		EXPECT_GE(pidfd, 0);
+		EXPECT_EQ(cell_wait(self->c.cfd), SIGILL);
+		close(pidfd);
+		EXPECT_EQ(poll(&pfd, 1, 300), 0);
+	}
+	close(lsock);
+	unlink(CORE_SOCK);
+
+	unlink(HELPER_RAN);
+	if (request_key)
+		unlink("/sbin/request-key");
+	EXPECT_EQ(write_file("/proc/sys/kernel/modprobe", modprobe), 0);
+	EXPECT_EQ(write_file("/proc/sys/kernel/core_pattern", core), 0);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/cell/cell_cgroup_test.c b/tools/testing/selftests/cell/cell_cgroup_test.c
new file mode 100644
index 000000000000..6bd4f21a3fec
--- /dev/null
+++ b/tools/testing/selftests/cell/cell_cgroup_test.c
@@ -0,0 +1,546 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cells: cgroups below the budget. Whoever built the cell lays them out, and so
+ * does the cell itself, as an init that manages cgroups will. The budget is what
+ * bounds the cell, so its own limits are not the cell's.
+ */
+#include "cell_test.h"
+
+static int at(const struct cellctx *c, const char *name, char *path, size_t len)
+{
+	return snprintf(path, len, "%s/%s", c->cg, name);
+}
+
+static int cg_mkdir(const struct cellctx *c, const char *name)
+{
+	char path[256];
+
+	at(c, name, path, sizeof(path));
+	return mkdir(path, 0755);
+}
+
+static int cg_write(const struct cellctx *c, const char *name, const char *val)
+{
+	char path[256];
+
+	at(c, name, path, sizeof(path));
+	return write_file(path, val);
+}
+
+static int cg_move(const struct cellctx *c, const char *name, pid_t pid)
+{
+	char path[256], nr[16];
+
+	snprintf(path, sizeof(path), "%s/%s/cgroup.procs", c->cg, name);
+	snprintf(nr, sizeof(nr), "%d", pid);
+	return write_file(path, nr);
+}
+
+/* Where a task is, below the budget of @c: "" for the budget itself. */
+static const char *cg_of(const struct cellctx *c, pid_t pid)
+{
+	static char buf[256];
+	const char *budget = c->cg + strlen(CGROOT);
+	char path[64];
+	FILE *f;
+
+	snprintf(path, sizeof(path), "/proc/%d/cgroup", pid);
+	f = fopen(path, "r");
+	if (!f)
+		return "?";
+	/* There may be legacy hierarchies about. */
+	while (fgets(buf, sizeof(buf), f)) {
+		if (!strncmp(buf, "0::", 3))
+			break;
+	}
+	fclose(f);
+	buf[strcspn(buf, "\n")] = 0;
+	if (strncmp(buf, "0::", 3) || strncmp(buf + 3, budget, strlen(budget)))
+		return buf;
+	return buf + 3 + strlen(budget);
+}
+
+/* How many cgroups there are below the budget. */
+static int cg_children(const struct cellctx *c)
+{
+	struct dirent *e;
+	int n = 0;
+	DIR *d;
+
+	d = opendir(c->cg);
+	if (!d)
+		return -1;
+	while ((e = readdir(d)))
+		n += e->d_type == DT_DIR && e->d_name[0] != '.';
+	closedir(d);
+	return n;
+}
+
+/* Has all of a cgroup come to a halt? */
+static int cg_frozen(const struct cellctx *c, const char *name)
+{
+	char path[256], buf[128] = {};
+	int fd, i;
+
+	snprintf(path, sizeof(path), "%s/%s/cgroup.events", c->cg, name);
+	for (i = 0; i < 100; i++) {
+		fd = open(path, O_RDONLY | O_CLOEXEC);
+		if (fd < 0 || read(fd, buf, sizeof(buf) - 1) <= 0)
+			return -1;
+		close(fd);
+		if (strstr(buf, "populated 1") && strstr(buf, "frozen 1"))
+			return 1;
+		usleep(20000);
+	}
+	return 0;
+}
+
+/* Controllers for the budgets to pass on. */
+static int controllers(void)
+{
+	return write_file(CGROOT "/cgroup.subtree_control", "+memory +pids");
+}
+
+struct inside {
+	int pidfd;
+	int ready;	/* the task writes to this */
+	int go;		/* and then waits for this */
+};
+
+/* Run @what with the budget as fd 3. @fd4, or else a pipe each way as fd 4 and 5. */
+static int start_inside(struct cellctx *c, struct inside *in, const char *what,
+			const char *arg, int fd4)
+{
+	int up[2] = { -1, -1 }, down[2] = { -1, -1 };
+
+	in->ready = in->go = -1;
+	in->pidfd = prepare(c->cfd, what, arg, NULL);
+	if (in->pidfd < 0 || pidfd_configure(in->pidfd, PIDFD_SET_FD, "3", NULL, c->cgfd))
+		return -1;
+	if (fd4 >= 0) {
+		if (pidfd_configure(in->pidfd, PIDFD_SET_FD, "4", NULL, fd4))
+			return -1;
+	} else {
+		if (pipe2(up, O_CLOEXEC) || pipe2(down, O_CLOEXEC) ||
+		    pidfd_configure(in->pidfd, PIDFD_SET_FD, "4", NULL, up[1]) ||
+		    pidfd_configure(in->pidfd, PIDFD_SET_FD, "5", NULL, down[0]))
+			return -1;
+		close(up[1]);
+		close(down[0]);
+		in->ready = up[0];
+		in->go = down[1];
+	}
+	return pidfd_configure(in->pidfd, PIDFD_CMD_START, NULL, NULL, 0);
+}
+
+static int wait_ready(struct inside *in)
+{
+	char c;
+
+	return read(in->ready, &c, 1) == 1 ? 0 : -1;
+}
+
+static void done_inside(struct inside *in)
+{
+	close(in->pidfd);
+	if (in->ready >= 0)
+		close(in->ready);
+	if (in->go >= 0)
+		close(in->go);
+}
+
+/* Run @fn as uid 1000, in a user namespace of its own, as who builds a one-id cell. */
+static int unprivileged(int (*fn)(void))
+{
+	int status, ret = -1;
+	pid_t pid;
+
+	if (chown(CGROOT, 1000, 1000) || chown(CGROOT "/cgroup.procs", 1000, 1000))
+		return -1;
+	pid = fork();
+	if (!pid) {
+		if (setgroups(0, NULL) || setresgid(1000, 1000, 1000) ||
+		    setresuid(1000, 1000, 1000) || prctl(PR_SET_DUMPABLE, 1, 0, 0, 0))
+			_exit(101);
+		if (unshare(CLONE_NEWUSER | CLONE_NEWNS))
+			_exit(102);
+		if (write_file("/proc/self/setgroups", "deny") ||
+		    write_file("/proc/self/uid_map", "1000 1000 1") ||
+		    write_file("/proc/self/gid_map", "1000 1000 1"))
+			_exit(103);
+		_exit(fn());
+	}
+	if (pid > 0 && waitpid(pid, &status, 0) == pid)
+		ret = WIFEXITED(status) ? WEXITSTATUS(status) : -1;
+	if (chown(CGROOT, 0, 0) || chown(CGROOT "/cgroup.procs", 0, 0))
+		return -1;
+	return ret;
+}
+
+/*
+ * The budget has no children when the slot is filled. From then on whoever built
+ * the cell makes what it likes in there and moves the tasks of the cell about.
+ */
+TEST_F(cell, builder_lays_out_the_budget)
+{
+	pid_t pid;
+	int p;
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536, .no_seal = true }), 0);
+	EXPECT_EQ(cg_mkdir(&self->c, "a"), 0);
+	ASSERT_EQ(cell_configure(self->c.cfd, CELL_CMD_SEAL, NULL, NULL, 0), 0);
+	EXPECT_EQ(cg_mkdir(&self->c, "b"), 0);
+
+	p = spawn(self->c.cfd, &pid, "pause", NULL, NULL);
+	ASSERT_GE(p, 0);
+	EXPECT_STREQ(cg_of(&self->c, pid), "");
+	EXPECT_EQ(cg_move(&self->c, "a", pid), 0);
+	EXPECT_STREQ(cg_of(&self->c, pid), "/a");
+	EXPECT_EQ(cg_move(&self->c, "b", pid), 0);
+	EXPECT_STREQ(cg_of(&self->c, pid), "/b");
+
+	/* Within the budget, and only what is the cell's. */
+	EXPECT_EQ(cg_move(&self->c, "..", pid), -1);
+	EXPECT_EQ(errno, EPERM);
+	EXPECT_EQ(cg_move(&self->c, "a", getpid()), -1);
+	EXPECT_EQ(errno, EPERM);
+	EXPECT_STREQ(cg_of(&self->c, pid), "/b");
+
+	/* All of it goes with the cell, whoever made it. */
+	EXPECT_EQ(cell_kill(self->c.cfd, 0), 0);
+	cell_wait(self->c.cfd);
+	EXPECT_EQ(cg_children(&self->c), 0);
+	close(p);
+}
+
+/* Have a task of the cell say where it is, started in the cgroup @name. */
+static int run_in_cgroup(struct cellctx *c, const char *name, const char *seen)
+{
+	int cgfd = openat(c->cgfd, name, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	int pidfd = prepare(c->cfd, "in-cgroup", seen, NULL), st = -99;
+
+	if (cgfd >= 0 && pidfd >= 0 &&
+	    !pidfd_configure(pidfd, PIDFD_SET_FD, "cgroup", NULL, cgfd) &&
+	    !pidfd_configure(pidfd, PIDFD_CMD_START, NULL, NULL, 0))
+		st = task_wait(pidfd);
+	close(pidfd);
+	close(cgfd);
+	return st;
+}
+
+/* One cgroup with a limit for each of what runs in the cell. */
+TEST_F(cell, builder_sets_limits_below_the_budget)
+{
+	pid_t pid;
+	int p;
+
+	ASSERT_EQ(controllers(), 0);
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536 }), 0);
+	ASSERT_EQ(cg_mkdir(&self->c, "a"), 0);
+	p = spawn(self->c.cfd, &pid, "pause", NULL, NULL);
+	ASSERT_GE(p, 0);
+
+	/* A cgroup that passes a controller on has no tasks of its own. */
+	EXPECT_EQ(cg_write(&self->c, "cgroup.subtree_control", "+memory"), -1);
+	EXPECT_EQ(errno, EBUSY);
+	EXPECT_EQ(cg_move(&self->c, "a", pid), 0);
+	EXPECT_EQ(cg_write(&self->c, "cgroup.subtree_control", "+memory +pids"), 0);
+	EXPECT_EQ(cg_write(&self->c, "a/pids.max", "5"), 0);
+	EXPECT_EQ(cg_write(&self->c, "a/memory.max", "67108864"), 0);
+
+	/* That goes for a new task as well, which starts in the budget. */
+	EXPECT_EQ(spawn(self->c.cfd, NULL, "pause", NULL, NULL), -1);
+	EXPECT_EQ(errno, EBUSY);
+	/* Unless it is told where else. */
+	EXPECT_EQ(run_in_cgroup(&self->c, "a", "/a"), 0);
+	close(p);
+}
+
+/* Start @what in the cgroup @cgfd. Returns a pidfd, or -1 with what START had to say. */
+static int spawn_in(struct cellctx *c, int cgfd, const char *what, const char *arg)
+{
+	int pidfd = prepare(c->cfd, what, arg, NULL), e;
+
+	if (pidfd < 0)
+		return -1;
+	if (pidfd_configure(pidfd, PIDFD_SET_FD, "cgroup", NULL, cgfd) ||
+	    pidfd_configure(pidfd, PIDFD_CMD_START, NULL, NULL, 0)) {
+		e = errno;
+		close(pidfd);
+		errno = e;
+		return -1;
+	}
+	return pidfd;
+}
+
+/* It is within the budget of the cell, there, and can hold a task. Or there is no task. */
+TEST_F(cell, spawn_names_no_other_cgroup)
+{
+	struct cellctx other;
+	int init, fd, pidfd;
+
+	ASSERT_EQ(controllers(), 0);
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536 }), 0);
+	ASSERT_EQ(cell_build(&other, &(struct build){ .ids = 65536 }), 0);
+	ASSERT_EQ(cg_mkdir(&self->c, "a"), 0);
+	ASSERT_EQ(cg_mkdir(&self->c, "a/leaf"), 0);
+	ASSERT_EQ(cg_mkdir(&self->c, "gone"), 0);
+	ASSERT_EQ(cg_mkdir(&other, "theirs"), 0);
+	fd = openat(self->c.cgfd, "a/leaf", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_GE(fd, 0);
+	init = spawn_in(&self->c, fd, "pause", NULL);
+	ASSERT_GE(init, 0);
+	close(fd);
+
+	/* Above the budget, beside it, and in that of another cell. */
+	fd = open(CGROOT, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	EXPECT_EQ(spawn_in(&self->c, fd, "pause", NULL), -1);
+	EXPECT_EQ(errno, EPERM);
+	close(fd);
+	EXPECT_EQ(spawn_in(&self->c, other.cgfd, "pause", NULL), -1);
+	EXPECT_EQ(errno, EPERM);
+	fd = openat(other.cgfd, "theirs", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	EXPECT_EQ(spawn_in(&self->c, fd, "pause", NULL), -1);
+	EXPECT_EQ(errno, EPERM);
+	close(fd);
+
+	/* Removed since it was named, and since it was opened. */
+	fd = openat(self->c.cgfd, "gone", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	pidfd = prepare(self->c.cfd, "pause", NULL, NULL);
+	ASSERT_GE(pidfd, 0);
+	ASSERT_EQ(pidfd_configure(pidfd, PIDFD_SET_FD, "cgroup", NULL, fd), 0);
+	ASSERT_EQ(unlinkat(self->c.cgfd, "gone", AT_REMOVEDIR), 0);
+	EXPECT_EQ(pidfd_configure(pidfd, PIDFD_CMD_START, NULL, NULL, 0), -1);
+	EXPECT_EQ(errno, ENODEV);
+	close(pidfd);
+	EXPECT_EQ(spawn_in(&self->c, fd, "pause", NULL), -1);
+	EXPECT_EQ(errno, ENOENT);
+	close(fd);
+
+	/* Passes a controller on. */
+	ASSERT_EQ(cg_write(&self->c, "cgroup.subtree_control", "+memory"), 0);
+	ASSERT_EQ(cg_write(&self->c, "a/cgroup.subtree_control", "+memory"), 0);
+	fd = openat(self->c.cgfd, "a", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	EXPECT_EQ(spawn_in(&self->c, fd, "pause", NULL), -1);
+	EXPECT_EQ(errno, EBUSY);
+	close(fd);
+
+	/* No cgroup at all. */
+	pidfd = prepare(self->c.cfd, "pause", NULL, NULL);
+	ASSERT_GE(pidfd, 0);
+	fd = open("/tmp", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	EXPECT_EQ(pidfd_configure(pidfd, PIDFD_SET_FD, "cgroup", NULL, fd), -1);
+	EXPECT_EQ(errno, EBADF);
+	close(fd);
+	/* The last word counts, and an O_PATH file will do. */
+	EXPECT_EQ(pidfd_configure(pidfd, PIDFD_SET_FD, "cgroup", NULL, other.cgfd), 0);
+	fd = openat(self->c.cgfd, "a/leaf", O_PATH | O_CLOEXEC);
+	EXPECT_EQ(pidfd_configure(pidfd, PIDFD_SET_FD, "cgroup", NULL, fd), 0);
+	close(fd);
+	EXPECT_EQ(pidfd_configure(pidfd, PIDFD_CMD_START, NULL, NULL, 0), 0);
+	EXPECT_STREQ(cg_of(&self->c, pidfd_nr(pidfd)), "/a/leaf");
+	close(pidfd);
+
+	/* A kill finds them wherever they are. */
+	EXPECT_EQ(cell_kill(self->c.cfd, 0), 0);
+	cell_wait(self->c.cfd);
+	EXPECT_EQ(cell_state(self->c.cfd), CELL_DEAD);
+	EXPECT_EQ(cg_children(&self->c), 0);
+	close(init);
+	cell_cleanup(&other);
+}
+
+/* What the ids of the cell own below the budget, as the host sees it. */
+TEST_F(cell, manages_its_cgroups)
+{
+	struct inside in;
+	struct stat st;
+	char path[256];
+	long first;
+
+	ASSERT_EQ(controllers(), 0);
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536, .caps = CAP(CHOWN) }), 0);
+	ASSERT_EQ(fstat(self->c.cgfd, &st), 0);
+	first = st.st_uid;
+	ASSERT_GE(first, (long)CELL_WINDOW_FIRST);
+
+	ASSERT_EQ(start_inside(&self->c, &in, "cg-manage", "block", -1), 0);
+	ASSERT_EQ(wait_ready(&in), 0);
+
+	ASSERT_EQ(fstatat(self->c.cgfd, "init.scope", &st, 0), 0);
+	EXPECT_EQ(st.st_uid, first);
+	ASSERT_EQ(fstatat(self->c.cgfd, "svc", &st, 0), 0);
+	EXPECT_EQ(st.st_uid, first + 1000);
+	EXPECT_EQ(st.st_gid, first + 1000);
+	ASSERT_EQ(fstatat(self->c.cgfd, "svc/pids.max", &st, 0), 0);
+	EXPECT_EQ(st.st_uid, first);
+
+	/* That is for a task of the cell to do. Nobody else names its ids. */
+	at(&self->c, "svc", path, sizeof(path));
+	EXPECT_EQ(chown(path, first + 5, first + 5), -1);
+	EXPECT_EQ(errno, EOVERFLOW);
+	EXPECT_EQ(chown(CGROOT, first, first), -1);
+	EXPECT_EQ(errno, EOVERFLOW);
+
+	/* The init has taken over. Another task goes where it made room for one. */
+	EXPECT_EQ(spawn(self->c.cfd, NULL, "pause", NULL, NULL), -1);
+	EXPECT_EQ(errno, EBUSY);
+	EXPECT_EQ(run_in_cgroup(&self->c, "init.scope", "/init.scope"), 0);
+	EXPECT_EQ(run_in_cgroup(&self->c, "svc", "/svc"), 0);
+
+	ASSERT_EQ(write(in.go, "g", 1), 1);
+	EXPECT_EQ(cell_wait(self->c.cfd), 0);
+	done_inside(&in);
+
+	/* Nothing is left that belongs to them. */
+	EXPECT_EQ(cg_children(&self->c), 0);
+	ASSERT_EQ(fstat(self->c.cgfd, &st), 0);
+	EXPECT_EQ(st.st_uid, 0);
+}
+
+static int one_id_manages(void)
+{
+	struct build b = { .ids = 1 };
+	struct inside in;
+	struct cellctx c;
+	int st;
+
+	if (cell_build(&c, &b))
+		return 1;
+	if (start_inside(&c, &in, "cg-manage", "one", -1) || wait_ready(&in))
+		return 2;
+	if (write(in.go, "g", 1) != 1)
+		return 3;
+	st = cell_wait(c.cfd);
+	done_inside(&in);
+	cell_cleanup(&c);
+	return st ? 4 : 0;
+}
+
+TEST_F(cell, one_id_cell_manages_its_cgroups)
+{
+	ASSERT_EQ(controllers(), 0);
+	EXPECT_EQ(unprivileged(one_id_manages), 0);
+}
+
+/*
+ * Holding the cellfd is all it takes. What the init of the cell made belongs to
+ * ids that nobody outside of the cell has, whoever built it included.
+ */
+static int spawns_where_it_owns_nothing(void)
+{
+	struct build b = { .ids = 65536, .caps = CAP(CHOWN) };
+	struct inside in;
+	struct cellctx c;
+	struct stat st;
+	int ret = 0;
+
+	if (cell_build(&c, &b))
+		return 1;
+	if (start_inside(&c, &in, "cg-manage", "block", -1) || wait_ready(&in))
+		return 2;
+	/* It has not even a name for them. */
+	if (fstatat(c.cgfd, "svc", &st, 0) || st.st_uid != 65534)
+		ret = 3;
+	else if (!faccessat(c.cgfd, "svc/cgroup.procs", W_OK, 0))
+		ret = 4;
+	else if (run_in_cgroup(&c, "svc", "/svc"))
+		ret = 5;
+	if (write(in.go, "g", 1) != 1 || cell_wait(c.cfd))
+		ret = ret ?: 6;
+	done_inside(&in);
+	cell_cleanup(&c);
+	return ret;
+}
+
+TEST_F(cell, unprivileged_builder_spawns_where_the_cell_made_room)
+{
+	ASSERT_EQ(controllers(), 0);
+	EXPECT_EQ(unprivileged(spawns_where_it_owns_nothing), 0);
+}
+
+static int own_limits(unsigned int ids)
+{
+	struct build b = { .ids = ids };
+	struct inside in;
+	struct cellctx c;
+	char buf[16] = {};
+	int max, st;
+
+	if (cell_build(&c, &b))
+		return 1;
+	if (cg_write(&c, "pids.max", "7"))
+		return 2;
+	max = openat(c.cgfd, "pids.max", O_RDWR | O_CLOEXEC);
+	if (max < 0 || start_inside(&c, &in, "cg-own", NULL, max))
+		return 3;
+	st = cell_wait(c.cfd);
+	done_inside(&in);
+	if (pread(max, buf, sizeof(buf) - 1, 0) <= 0 || strcmp(buf, "7\n"))
+		st = 5;
+	close(max);
+	cell_cleanup(&c);
+	return st ? (st == 5 ? 5 : 4) : 0;
+}
+
+static int own_limits_one_id(void)
+{
+	return own_limits(1);
+}
+
+/* The limits of the budget stay with whoever is above. */
+TEST_F(cell, limits_of_the_budget_are_not_the_cells)
+{
+	ASSERT_EQ(controllers(), 0);
+	EXPECT_EQ(own_limits(65536), 0);
+}
+
+/* A cell of one id owns what its maker owns, and its maker made the budget. */
+TEST_F(cell, limits_of_the_budget_are_not_a_one_id_cells)
+{
+	ASSERT_EQ(controllers(), 0);
+	EXPECT_EQ(unprivileged(own_limits_one_id), 0);
+}
+
+/* What it is in the middle of making goes as well. */
+TEST_F_TIMEOUT(cell, killed_while_it_makes_cgroups, 300)
+{
+	struct inside in;
+	struct stat st;
+	int i;
+
+	for (i = 0; i < 10; i++) {
+		ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536 }), 0);
+		ASSERT_EQ(start_inside(&self->c, &in, "cg-churn", NULL, -1), 0);
+		ASSERT_EQ(wait_ready(&in), 0);
+		usleep(50000);
+		EXPECT_EQ(cell_kill(self->c.cfd, 0), 0);
+		cell_wait(self->c.cfd);
+		EXPECT_EQ(cell_state(self->c.cfd), CELL_DEAD);
+		EXPECT_EQ(cg_children(&self->c), 0);
+		ASSERT_EQ(fstat(self->c.cgfd, &st), 0);
+		EXPECT_EQ(st.st_uid, 0);
+		done_inside(&in);
+		cell_cleanup(&self->c);
+		self->c.cfd = self->c.tree = self->c.raw = self->c.cgfd = -1;
+		self->c.rootfd = self->c.layers = -1;
+	}
+}
+
+/* A task that the cell has frozen is killed like any other. */
+TEST_F(cell, kill_takes_what_the_cell_has_frozen)
+{
+	struct inside in;
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536 }), 0);
+	ASSERT_EQ(start_inside(&self->c, &in, "cg-freeze", NULL, -1), 0);
+	ASSERT_EQ(wait_ready(&in), 0);
+	EXPECT_EQ(cg_frozen(&self->c, "cold"), 1);
+	EXPECT_EQ(cell_kill(self->c.cfd, 0), 0);
+	cell_wait(self->c.cfd);
+	EXPECT_EQ(cell_state(self->c.cfd), CELL_DEAD);
+	EXPECT_EQ(cg_children(&self->c), 0);
+	done_inside(&in);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/cell/cell_child.c b/tools/testing/selftests/cell/cell_child.c
new file mode 100644
index 000000000000..2f2d205ce9d3
--- /dev/null
+++ b/tools/testing/selftests/cell/cell_child.c
@@ -0,0 +1,1626 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * What runs inside a cell for cell_test. Statically linked: the tree of the
+ * cell holds this file and nothing else.
+ *
+ * Usage: cell_child <check>. Complains on stderr, exits 0 if all is well.
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <grp.h>
+#include <netinet/in.h>
+#include <pthread.h>
+#include <time.h>
+#include <sys/ioctl.h>
+#include <sys/mount.h>
+#include <sys/resource.h>
+#include <sys/prctl.h>
+#include <sys/ptrace.h>
+#include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/sysmacros.h>
+#include <sys/un.h>
+#include <sys/wait.h>
+#include <sys/xattr.h>
+#include <linux/capability.h>
+#include <linux/keyctl.h>
+#include <linux/if_tun.h>
+#include <linux/netfilter/nfnetlink.h>
+#include <linux/netfilter/nf_tables.h>
+#include <linux/netlink.h>
+#include <linux/rtnetlink.h>
+#include <linux/sockios.h>
+#include <net/if.h>
+#include <net/route.h>
+
+#include "cell_util.h"
+
+#define ARRAY_SIZE(a) (sizeof(a) / sizeof((a)[0]))
+
+extern char **environ;
+static int failures;
+
+#define CHECK(cond, fmt, ...) do {						\
+	if (!(cond)) {								\
+		fprintf(stderr, "cell_child: %s:%d: " fmt "\n", __func__,	\
+			__LINE__, ##__VA_ARGS__);				\
+		failures++;							\
+	}									\
+} while (0)
+
+#define CHECK_ERRNO(call, err) do {						\
+	errno = 0;								\
+	long __r = (long)(call);						\
+	CHECK(__r == -1 && errno == (err), "%s: returned %ld, errno %d, wanted %d", \
+	      #call, __r, errno, (err));					\
+} while (0)
+
+static unsigned long long status_caps(const char *field)
+{
+	unsigned long long val = ~0ULL;
+	char line[256];
+	FILE *f = fopen("/proc/self/status", "r");
+
+	while (f && fgets(line, sizeof(line), f)) {
+		if (!strncmp(line, field, strlen(field)))
+			val = strtoull(line + strlen(field) + 1, NULL, 16);
+	}
+	if (f)
+		fclose(f);
+	return val;
+}
+
+static void check_caps_are(unsigned long long has, unsigned long long bound)
+{
+	CHECK(status_caps("CapPrm") == has, "permitted %llx", status_caps("CapPrm"));
+	CHECK(status_caps("CapEff") == has, "effective %llx", status_caps("CapEff"));
+	CHECK(status_caps("CapBnd") == bound, "bounding set %llx", status_caps("CapBnd"));
+	CHECK(status_caps("CapInh") == 0, "inheritable %llx", status_caps("CapInh"));
+	CHECK(status_caps("CapAmb") == 0, "ambient %llx", status_caps("CapAmb"));
+}
+
+static int set_caps_to(unsigned long long effective, unsigned long long permitted)
+{
+	struct __user_cap_header_struct hdr = { .version = _LINUX_CAPABILITY_VERSION_3 };
+	struct __user_cap_data_struct data[2] = {
+		{ .effective = effective, .permitted = permitted },
+		{ .effective = effective >> 32, .permitted = permitted >> 32 },
+	};
+
+	return syscall(SYS_capset, &hdr, data);
+}
+
+static int set_caps(unsigned long long caps)
+{
+	return set_caps_to(caps, caps);
+}
+
+/* Run @fn in a task of its own, which may do to itself what it likes. */
+static void in_a_fork(void (*fn)(unsigned long long), unsigned long long caps)
+{
+	int status = -1;
+	pid_t pid = fork();
+
+	if (!pid) {
+		failures = 0;
+		fn(caps);
+		_exit(!!failures);
+	}
+	CHECK(waitpid(pid, &status, 0) == pid && !status, "status %x", status);
+}
+
+#define CAP(x)	(1ULL << CAP_##x)
+
+static void become_somebody(unsigned long long caps)
+{
+	if (!(caps & CAP(SETGID))) {
+		CHECK_ERRNO(setgroups(0, NULL), EPERM);
+		CHECK_ERRNO(setgid(33), EPERM);
+	} else {
+		CHECK(!setgroups(0, NULL) && !setgid(33), "setgid: %d", errno);
+	}
+	if (!(caps & CAP(SETUID))) {
+		CHECK_ERRNO(setuid(33), EPERM);
+		return;
+	}
+	CHECK(!setuid(33), "setuid: %d", errno);
+	/* Which costs them, as ever. */
+	check_caps_are(0, caps);
+}
+
+/* Letting go takes nothing, CAP_SETPCAP included. */
+static void shrink_the_bounding_set(unsigned long long caps)
+{
+	CHECK(!prctl(PR_CAPBSET_DROP, CAP_CHOWN, 0, 0, 0), "drop: %d", errno);
+	check_caps_are(caps, caps & ~CAP(CHOWN));
+	CHECK(!prctl(PR_CAPBSET_DROP, CAP_SYS_ADMIN, 0, 0, 0), "drop: %d", errno);
+	check_caps_are(caps, caps & ~(CAP(CHOWN) | CAP(SYS_ADMIN)));
+	CHECK_ERRNO(prctl(PR_CAPBSET_DROP, 63, 0, 0, 0), EINVAL);
+}
+
+/*
+ * What the builder named and nothing else, through an exec and for good: a task
+ * can let go of a capability, and nothing brings one back.
+ */
+static void check_caps(char **argv)
+{
+	unsigned long long caps = strtoull(argv[2], NULL, 16);
+	const char *stage = argv[3] ?: "first";
+	int fd;
+
+	if (!strcmp(stage, "first")) {
+		check_caps_are(caps, caps);
+
+		fd = open("/tmp/c", O_CREAT | O_WRONLY, 0644);
+		CHECK(fd >= 0, "create: %d", errno);
+		if (caps & CAP(CHOWN))
+			CHECK(!fchown(fd, 33, 33), "chown: %d", errno);
+		else
+			CHECK_ERRNO(fchown(fd, 33, 33), EPERM);
+		close(fd);
+		/* What goes by a capability over the host stays out of reach. */
+		CHECK_ERRNO(mknod("/tmp/n", S_IFCHR | 0600, makedev(1, 3)), EPERM);
+		in_a_fork(become_somebody, caps);
+		in_a_fork(shrink_the_bounding_set, caps);
+		CHECK_ERRNO(set_caps(caps | CAP(SETFCAP)), EPERM);
+		stage = "again";
+	} else if (!strcmp(stage, "again")) {
+		/* Uid 0 ran a program. */
+		check_caps_are(caps, caps);
+		CHECK(!set_caps(0), "capset: %d", errno);
+		check_caps_are(0, caps);
+		stage = "dropped";
+	} else if (!strcmp(stage, "dropped")) {
+		/* It did so again, and has nothing to show for it. */
+		check_caps_are(0, caps);
+		CHECK_ERRNO(set_caps(caps ?: CAP(CHOWN)), EPERM);
+		stage = "gain";
+	} else {
+		/* Set-uid root, with a file capability. */
+		check_caps_are(0, caps);
+		return;
+	}
+	if (failures)
+		return;
+	execl(strcmp(stage, "gain") ? "/cell_child" : "/gain", "cell_child", "caps", argv[2],
+	      stage, NULL);
+	CHECK(0, "exec for %s: %d", stage, errno);
+}
+
+/* Nothing but what was given. */
+static void check_basic(void)
+{
+	struct cell_info info = { .mask = CELL_INFO_ID };
+	char buf[256];
+	int fd, nr = 0;
+
+	CHECK(getpid() == 1, "pid %d", getpid());
+	CHECK(getppid() == 0, "ppid %d", getppid());
+	CHECK(getuid() == 0 && geteuid() == 0, "uid %d euid %d", getuid(), geteuid());
+	CHECK(getgid() == 0 && getegid() == 0, "gid %d egid %d", getgid(), getegid());
+	CHECK(getgroups(0, NULL) == 0, "%d groups", getgroups(0, NULL));
+	CHECK(getsid(0) == 1, "sid %d", getsid(0));
+	CHECK(getpgrp() == 1, "pgrp %d", getpgrp());
+	CHECK(getcwd(buf, sizeof(buf)) && !strcmp(buf, "/"), "cwd %s", buf);
+	CHECK(!gethostname(buf, sizeof(buf)) && !strcmp(buf, "celltest"),
+	      "hostname %s", buf);
+	CHECK(umask(0) == 022, "umask");
+	CHECK(open("/dev/tty", O_RDWR) == -1, "has a controlling terminal");
+
+	for (fd = 0; fd < 1024; fd++) {
+		if (fcntl(fd, F_GETFD) != -1)
+			nr++;
+	}
+	CHECK(nr == 3, "%d open files", nr);
+
+	CHECK(environ[0] && !strcmp(environ[0], "CELL=yes") && !environ[1],
+	      "environment");
+
+	CHECK(prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0) == 1, "no_new_privs is off");
+	check_caps_are(0, 0);
+
+	CHECK(!cell_info(CELL_SELF, &info, sizeof(info), 0) && info.id != 0,
+	      "own cell id %llu", (unsigned long long)info.id);
+
+	/* The "spawn" slot is empty, whatever the file descriptor is. */
+	CHECK_ERRNO(cell_create(CELL_SELF, 0), EPERM);
+	for (fd = -1; fd < 8; fd++)
+		CHECK_ERRNO(pidfd_open_empty(fd, 0), EPERM);
+	CHECK_ERRNO(pidfd_open_empty(-EBADF, 0), EPERM);
+}
+
+/* A task has no say in its namespaces. */
+static void check_membership(void)
+{
+	static const int flags[] = {
+		CLONE_NEWUSER, CLONE_NEWNS, CLONE_NEWPID, CLONE_NEWNET,
+		CLONE_NEWIPC, CLONE_NEWUTS, CLONE_NEWCGROUP, 0x80 /* NEWTIME */,
+	};
+	static const char * const ns[] = {
+		"user", "mnt", "pid", "net", "ipc", "uts", "cgroup", "time",
+	};
+	char path[64];
+	unsigned int i;
+	int fd;
+
+	for (i = 0; i < ARRAY_SIZE(flags); i++)
+		CHECK_ERRNO(unshare(flags[i]), EPERM);
+
+	for (i = 0; i < ARRAY_SIZE(ns); i++) {
+		snprintf(path, sizeof(path), "/proc/self/ns/%s", ns[i]);
+		fd = open(path, O_RDONLY);
+		CHECK(fd >= 0, "open %s: %d", path, errno);
+		if (fd < 0)
+			continue;
+		CHECK_ERRNO(setns(fd, 0), EPERM);
+		close(fd);
+	}
+
+	CHECK_ERRNO(syscall(SYS_clone, CLONE_NEWUSER | SIGCHLD, 0, 0, 0, 0), EPERM);
+	CHECK_ERRNO(syscall(SYS_clone, CLONE_NEWNET | SIGCHLD, 0, 0, 0, 0), EPERM);
+	CHECK_ERRNO(syscall(SYS_open_tree, AT_FDCWD, "/", 2 /* OPEN_TREE_NAMESPACE */),
+		    EPERM);
+	CHECK_ERRNO(mount("none", "/tmp", "tmpfs", 0, NULL), EPERM);
+	CHECK_ERRNO(umount2("/proc", MNT_DETACH), EPERM);
+}
+
+/* Nothing a cell writes imparts privilege. */
+static void check_setid(void)
+{
+	/* VFS_CAP_REVISION_2, cap_net_raw permitted and effective. */
+	static const unsigned char cap[20] = {
+		0x01, 0x00, 0x00, 0x02, 0x00, 0x20, 0x00, 0x00,
+	};
+	/* VFS_CAP_REVISION_3, the same, with uid 0 for the root. */
+	static const unsigned char cap3[24] = {
+		0x01, 0x00, 0x00, 0x03, 0x00, 0x20, 0x00, 0x00,
+	};
+	struct stat st;
+	char buf[64];
+	int fd;
+
+	fd = open("/tmp/a", O_CREAT | O_WRONLY, 06755);
+	CHECK(fd >= 0, "create: %d", errno);
+	CHECK(!fstat(fd, &st) && !(st.st_mode & (S_ISUID | S_ISGID)),
+	      "created with mode %o", st.st_mode);
+	CHECK(st.st_uid == 0 && st.st_gid == 0, "owned by %d:%d", st.st_uid, st.st_gid);
+
+	CHECK(!fchmod(fd, 06755), "fchmod: %d", errno);
+	CHECK(!fstat(fd, &st) && (st.st_mode & 07777) == 0755,
+	      "chmod gave mode %o", st.st_mode);
+	CHECK(!chmod("/tmp/a", 04711), "chmod: %d", errno);
+	CHECK(!stat("/tmp/a", &st) && (st.st_mode & 07777) == 0711,
+	      "chmod gave mode %o", st.st_mode);
+
+	CHECK_ERRNO(fsetxattr(fd, "security.capability", cap, sizeof(cap), 0), EPERM);
+	/*
+	 * Nor one for the root of the cell only. On disk that is uid 0, so whoever
+	 * else looks at the filesystem would take it for one of its own.
+	 */
+	CHECK_ERRNO(fsetxattr(fd, "security.capability", cap3, sizeof(cap3), 0), EPERM);
+	close(fd);
+
+	CHECK(!mknod("/tmp/f", S_IFIFO | 06644, 0), "mknod: %d", errno);
+	CHECK(!stat("/tmp/f", &st) && !(st.st_mode & (S_ISUID | S_ISGID)),
+	      "mknod gave mode %o", st.st_mode);
+
+	/*
+	 * A set-uid file that came with the tree. A store through a shared
+	 * mapping would leave the bits alone, so being able to write is enough
+	 * to lose them.
+	 */
+	CHECK(!stat("/su", &st) && (st.st_mode & 07777) == 06755, "mode %o", st.st_mode);
+	fd = open("/su", O_RDONLY);
+	CHECK(fd >= 0 && !fstat(fd, &st) && (st.st_mode & 07777) == 06755,
+	      "reading cost the bits: %o", st.st_mode);
+	CHECK(fgetxattr(fd, "security.capability", buf, sizeof(buf)) > 0,
+	      "reading cost the file capability: %d", errno);
+	close(fd);
+	fd = open("/su", O_RDWR);
+	CHECK(fd >= 0 && !fstat(fd, &st) && (st.st_mode & 07777) == 0755,
+	      "still mode %o when open for writing", st.st_mode);
+	CHECK_ERRNO(fgetxattr(fd, "security.capability", buf, sizeof(buf)), ENODATA);
+	close(fd);
+
+	/* On a directory setgid is about inheritance, not privilege. */
+	CHECK(!mkdir("/tmp/d", 0755) && !chmod("/tmp/d", 02755), "mkdir: %d", errno);
+	CHECK(!stat("/tmp/d", &st) && (st.st_mode & S_ISGID), "mode %o", st.st_mode);
+
+	/* Ids work as ever otherwise. */
+	CHECK(!chown("/tmp/a", 33, 33), "chown: %d", errno);
+	CHECK(!stat("/tmp/a", &st) && st.st_uid == 33 && st.st_gid == 33,
+	      "owned by %d:%d", st.st_uid, st.st_gid);
+}
+
+static int send_fd(int sock, int fd)
+{
+	char data = 'x', ctl[CMSG_SPACE(sizeof(int))] = {};
+	struct iovec iov = { .iov_base = &data, .iov_len = 1 };
+	struct msghdr msg = {
+		.msg_iov = &iov, .msg_iovlen = 1,
+		.msg_control = ctl, .msg_controllen = sizeof(ctl),
+	};
+	struct cmsghdr *cmsg = CMSG_FIRSTHDR(&msg);
+
+	cmsg->cmsg_level = SOL_SOCKET;
+	cmsg->cmsg_type = SCM_RIGHTS;
+	cmsg->cmsg_len = CMSG_LEN(sizeof(int));
+	memcpy(CMSG_DATA(cmsg), &fd, sizeof(int));
+	return sendmsg(sock, &msg, 0);
+}
+
+static void check_peer_queries(int sock)
+{
+	struct ucred uc;
+	socklen_t len;
+	gid_t groups[8];
+	int pidfd;
+
+	len = sizeof(uc);
+	CHECK_ERRNO(getsockopt(sock, SOL_SOCKET, SO_PEERCRED, &uc, &len), ENODATA);
+	len = sizeof(groups);
+	CHECK_ERRNO(getsockopt(sock, SOL_SOCKET, SO_PEERGROUPS, groups, &len), ENODATA);
+	len = sizeof(pidfd);
+	CHECK_ERRNO(getsockopt(sock, SOL_SOCKET, 77 /* SO_PEERPIDFD */, &pidfd, &len),
+		    ENODATA);
+}
+
+/*
+ * Between cells a socket carries bytes. fd 3 is one end of a socketpair the
+ * host made, /tmp/sock a listener of the host's.
+ */
+static void check_unix(void)
+{
+	struct sockaddr_un addr = { .sun_family = AF_UNIX, .sun_path = "/tmp/sock" };
+	char ctl[256], c;
+	struct iovec iov = { .iov_base = &c, .iov_len = 1 };
+	struct msghdr msg = {
+		.msg_iov = &iov, .msg_iovlen = 1,
+		.msg_control = ctl, .msg_controllen = sizeof(ctl),
+	};
+	int one = 1, sock, sv[2];
+	struct ucred uc;
+	socklen_t len;
+
+	/*
+	 * The host queued a file on the socket while both ends were still its
+	 * own. Nobody could have refused that. It must not arrive.
+	 */
+	CHECK(recvmsg(3, &msg, MSG_PEEK) == 1 && c == 'q', "peek: %d", errno);
+	CHECK(msg.msg_controllen == 0, "peeked %zu bytes of ancillary data",
+	      (size_t)msg.msg_controllen);
+	msg.msg_controllen = sizeof(ctl);
+	CHECK(recvmsg(3, &msg, 0) == 1 && c == 'q', "recvmsg: %d", errno);
+	CHECK(msg.msg_controllen == 0, "got %zu bytes of ancillary data",
+	      (size_t)msg.msg_controllen);
+	CHECK(fcntl(4, F_GETFD) == -1, "a file arrived");
+	msg.msg_controllen = sizeof(ctl);
+
+	check_peer_queries(3);
+	CHECK_ERRNO(send_fd(3, 0), EPERM);
+	CHECK(write(3, "a", 1) == 1, "plain bytes: %d", errno);
+
+	/* The host sends a byte, with SO_PASSCRED on at this end. */
+	CHECK(!setsockopt(3, SOL_SOCKET, SO_PASSCRED, &one, sizeof(one)), "passcred");
+	CHECK(write(3, "b", 1) == 1, "plain bytes: %d", errno);
+	CHECK(recvmsg(3, &msg, 0) == 1 && c == 'h', "recvmsg: %d", errno);
+	CHECK(msg.msg_controllen == 0, "got %zu bytes of ancillary data",
+	      (size_t)msg.msg_controllen);
+
+	sock = socket(AF_UNIX, SOCK_STREAM, 0);
+	CHECK(!connect(sock, (struct sockaddr *)&addr, sizeof(addr)), "connect: %d", errno);
+	check_peer_queries(sock);
+	CHECK_ERRNO(send_fd(sock, 0), EPERM);
+	CHECK(write(sock, "c", 1) == 1, "plain bytes: %d", errno);
+	close(sock);
+
+	/* Within the cell everything is as it always was. */
+	CHECK(!socketpair(AF_UNIX, SOCK_STREAM, 0, sv), "socketpair");
+	len = sizeof(uc);
+	CHECK(!getsockopt(sv[0], SOL_SOCKET, SO_PEERCRED, &uc, &len) &&
+	      uc.pid == getpid() && uc.uid == 0, "SO_PEERCRED at home: %d", errno);
+	CHECK(send_fd(sv[0], 0) == 1, "SCM_RIGHTS at home: %d", errno);
+	msg.msg_controllen = sizeof(ctl);
+	CHECK(recvmsg(sv[1], &msg, 0) == 1 && msg.msg_controllen >= CMSG_LEN(sizeof(int)),
+	      "no fd arrived at home");
+}
+
+/* fd 3 is a directory of a filesystem of the host that is not idmapped. */
+static void check_dirfd(void)
+{
+	CHECK_ERRNO(openat(3, "x", O_CREAT | O_WRONLY, 0644), EOVERFLOW);
+	CHECK_ERRNO(mkdirat(3, "d", 0755), EOVERFLOW);
+	CHECK_ERRNO(fchownat(3, "world", 0, 0, 0), EOVERFLOW);
+}
+
+/* /data is a real filesystem, with a set-uid file that came with it. */
+static void check_data(const char *create)
+{
+	struct stat st;
+	int fd;
+
+	fd = open("/data/su", O_RDWR);
+	CHECK(fd >= 0, "open: %d", errno);
+	CHECK(!fstat(fd, &st) && !(st.st_mode & (S_ISUID | S_ISGID)),
+	      "still mode %o when open for writing", st.st_mode);
+	close(fd);
+
+	if (!create)
+		return;
+	/* With ->atomic_open() this opens under the lock of the directory. */
+	fd = open("/data/new", O_CREAT | O_EXCL | O_RDWR, 06755);
+	CHECK(fd >= 0, "create: %d", errno);
+	CHECK(!fstat(fd, &st) && !(st.st_mode & (S_ISUID | S_ISGID)),
+	      "created with mode %o", st.st_mode);
+	CHECK(write(fd, "x", 1) == 1, "write: %d", errno);
+	close(fd);
+	CHECK(!unlink("/data/new"), "unlink: %d", errno);
+}
+
+/* /data is an overlay, and writing to a file of the lower layer copies it up. */
+static void check_copy_up(void)
+{
+	struct stat st;
+	int fd;
+
+	CHECK(!stat("/data/file", &st) && !st.st_uid && !st.st_gid,
+	      "belongs to %u:%u", st.st_uid, st.st_gid);
+	fd = open("/data/file", O_WRONLY);
+	CHECK(fd >= 0, "open: %d", errno);
+	CHECK(write(fd, "upper", 5) == 5, "write: %d", errno);
+	fd = open("/data/new", O_CREAT | O_EXCL | O_WRONLY, 0644);
+	CHECK(fd >= 0, "create: %d", errno);
+}
+
+/*
+ * fd 3 is /dev/vhost-net. In its kthread mode vhost puts a kernel thread into
+ * the cgroups of the owner. A kill could not take that with it.
+ */
+static void check_vhost(void)
+{
+	unsigned char mode = 0;		/* VHOST_FORK_OWNER_KTHREAD */
+
+	CHECK(!ioctl(3, _IOW(0xAF, 0x84, unsigned char), &mode),
+	      "VHOST_SET_FORK_FROM_OWNER: %d", errno);
+	/* vhost makes ENOMEM of whatever went wrong with its worker. */
+	CHECK(ioctl(3, _IO(0xAF, 0x01) /* VHOST_SET_OWNER */) == -1,
+	      "VHOST_SET_OWNER worked");
+}
+
+/* The spawner ignores, handles and blocks signals. None of that is ours. */
+static void check_signals(void)
+{
+	struct sigaction sa;
+	sigset_t set;
+	int sig;
+
+	for (sig = 1; sig < _NSIG; sig++) {
+		/* The C library keeps a few to itself. */
+		if (sigaction(sig, NULL, &sa))
+			continue;
+		CHECK(sa.sa_handler == SIG_DFL, "signal %d is not at its default", sig);
+	}
+	CHECK(!sigprocmask(SIG_BLOCK, NULL, &set), "sigprocmask: %d", errno);
+	for (sig = 1; sig < _NSIG; sig++)
+		CHECK(sigismember(&set, sig) != 1, "signal %d is blocked", sig);
+	CHECK(!sigpending(&set), "sigpending: %d", errno);
+	for (sig = 1; sig < _NSIG; sig++)
+		CHECK(sigismember(&set, sig) != 1, "signal %d is pending", sig);
+}
+
+/* The spawner has a filter that fails getrusage() with EACCES. */
+static void check_seccomp(void)
+{
+	struct rusage ru;
+
+	CHECK_ERRNO(getrusage(RUSAGE_SELF, &ru), EACCES);
+}
+
+static void on_usr1(int sig)
+{
+	_exit(0);
+}
+
+/*
+ * An init only gets the signals it has a handler for, so without one nobody
+ * could tell a signal that was refused from one that was dropped.
+ */
+static void wait_for_usr1(void)
+{
+	signal(SIGUSR1, on_usr1);
+	/* Whoever wants to know that we are ready put a pipe there. */
+	if (write(3, "x", 1) < 0)
+		;
+	for (;;)
+		pause();
+}
+
+/* Spawned into a running cell: the parent is somebody outside. */
+static void check_second(void)
+{
+	CHECK(getpid() != 1 && getppid() == 0, "pid %d ppid %d", getpid(), getppid());
+	CHECK_ERRNO(ptrace(PTRACE_TRACEME, 0, 0, 0), EPERM);
+}
+
+static void check_oneid(const char *uid)
+{
+	CHECK((int)getuid() == atoi(uid), "uid %d", getuid());
+	check_caps_are(0, 0);
+	CHECK_ERRNO(setuid(getuid() + 1), EINVAL);
+	CHECK_ERRNO(setgroups(0, NULL), EPERM);
+	/* The groups of whoever made the cell, denials and all. */
+	CHECK(getgroups(0, NULL) == 2, "%d groups", getgroups(0, NULL));
+
+	/* The parent has the very same uid. It is not in this cell. */
+	CHECK(syscall(SYS_keyctl, 1 /* JOIN_SESSION_KEYRING */, NULL) > 0,
+	      "join session keyring: %d", errno);
+	CHECK_ERRNO(syscall(SYS_keyctl, 18 /* SESSION_TO_PARENT */), EPERM);
+	CHECK_ERRNO(ptrace(PTRACE_TRACEME, 0, 0, 0), EPERM);
+}
+
+static int write_str(const char *path, const char *val)
+{
+	int fd = open(path, O_WRONLY), ret;
+
+	if (fd < 0)
+		return -1;
+	ret = write(fd, val, strlen(val)) < 0 ? -1 : 0;
+	close(fd);
+	return ret;
+}
+
+/* As "echo val > path" does it, which truncates the file. */
+static int write_at(int dir, const char *path, const char *val)
+{
+	int fd = openat(dir, path, O_WRONLY | O_TRUNC), ret;
+
+	if (fd < 0)
+		return -1;
+	ret = write(fd, val, strlen(val)) < 0 ? -1 : 0;
+	close(fd);
+	return ret;
+}
+
+static void check_in_cgroup(const char *want)
+{
+	char buf[512] = {}, line[256];
+	int fd = open("/proc/self/cgroup", O_RDONLY);
+
+	/* There may be legacy hierarchies about. */
+	snprintf(line, sizeof(line), "0::%s\n", want);
+	CHECK(fd >= 0 && read(fd, buf, sizeof(buf) - 1) > 0 && strstr(buf, line),
+	      "in %s and not in %s", buf, want);
+	close(fd);
+}
+
+/* Tell whoever is outside, on fd 4, and wait for it to have had a look, on fd 5. */
+static void show_the_host(void)
+{
+	char c;
+
+	CHECK(write(4, "r", 1) == 1 && read(5, &c, 1) == 1, "the host went away");
+}
+
+/*
+ * fd 3 is the budget. What an init that manages cgroups does: get out of the
+ * root, enable controllers there, and make a cgroup with a limit per service.
+ */
+static void check_cg_manage(const char *ids)
+{
+	struct stat st;
+	int status;
+	pid_t pid;
+
+	CHECK(!mkdirat(3, "init.scope", 0755), "mkdir: %d", errno);
+	CHECK(!write_at(3, "init.scope/cgroup.procs", "0"), "move: %d", errno);
+	check_in_cgroup("/init.scope");
+	CHECK(!write_at(3, "cgroup.subtree_control", "+memory +pids"), "enable: %d", errno);
+
+	CHECK(!mkdirat(3, "svc", 0755), "mkdir: %d", errno);
+	CHECK(!write_at(3, "svc/pids.max", "5"), "pids.max: %d", errno);
+	CHECK(!write_at(3, "svc/memory.max", "67108864"), "memory.max: %d", errno);
+	pid = fork();
+	if (!pid) {
+		failures = 0;
+		CHECK(!write_at(3, "svc/cgroup.procs", "0"), "move: %d", errno);
+		check_in_cgroup("/svc");
+		_exit(!!failures);
+	}
+	CHECK(waitpid(pid, &status, 0) == pid && !status, "the service: %x", status);
+
+	CHECK(!mkdirat(3, "svc/deeper", 0755), "mkdir: %d", errno);
+	CHECK(!unlinkat(3, "svc/deeper", AT_REMOVEDIR), "rmdir: %d", errno);
+
+	/* Hand a cgroup to somebody in here. */
+	if (!strcmp(ids, "block")) {
+		CHECK(!fchownat(3, "svc", 1000, 1000, 0), "chown: %d", errno);
+		CHECK(!fchownat(3, "svc/cgroup.procs", 1000, 1000, 0), "chown: %d", errno);
+		CHECK(!fstatat(3, "svc", &st, 0) && st.st_uid == 1000 && st.st_gid == 1000,
+		      "belongs to %u:%u", st.st_uid, st.st_gid);
+		CHECK_ERRNO(fchownat(3, "svc", 70000, 70000, 0), EINVAL);
+	}
+	show_the_host();
+}
+
+/*
+ * fd 3 is the budget, fd 4 its pids.max, which somebody outside opened. The cell
+ * makes cgroups in the budget and puts tasks there. The rest of it is not the
+ * cell's, whoever it belongs to: that is what bounds the cell.
+ */
+static void check_cg_own(void)
+{
+	static const char * const not_ours[] = {
+		"pids.max", "memory.max", "memory.high", "cgroup.freeze", "cgroup.kill",
+		"cgroup.type", "cgroup.max.depth", "cgroup.max.descendants",
+	};
+	static const char * const ours[] = {
+		"cgroup.procs", "cgroup.threads", "cgroup.subtree_control",
+	};
+	struct timespec now[2] = { { .tv_nsec = UTIME_NOW }, { .tv_nsec = UTIME_NOW } };
+	unsigned int i;
+	int fd;
+
+	for (i = 0; i < ARRAY_SIZE(not_ours); i++) {
+		fd = openat(3, not_ours[i], O_WRONLY);
+		CHECK(fd == -1 && errno == EPERM, "%s: %d, %d", not_ours[i], fd, errno);
+		fd = openat(3, not_ours[i], O_WRONLY | O_TRUNC);
+		CHECK(fd == -1 && errno == EPERM, "%s: %d, %d", not_ours[i], fd, errno);
+	}
+	CHECK_ERRNO(ftruncate(4, 0), EPERM);
+	CHECK_ERRNO(write(4, "max", 3), EPERM);
+
+	for (i = 0; i < ARRAY_SIZE(ours); i++) {
+		fd = openat(3, ours[i], O_WRONLY);
+		CHECK(fd >= 0, "%s: %d", ours[i], errno);
+		close(fd);
+		/* Truncating a file is writing to it, and a shell does. */
+		fd = openat(3, ours[i], O_WRONLY | O_TRUNC);
+		CHECK(fd >= 0, "%s, truncating: %d", ours[i], errno);
+		close(fd);
+		/* To write to, and not to hand on. */
+		CHECK_ERRNO(fchmodat(3, ours[i], 0666, 0), EPERM);
+	}
+
+	CHECK_ERRNO(fchmodat(3, "pids.max", 0666, 0), EPERM);
+	CHECK_ERRNO(fchownat(3, "pids.max", getuid(), getgid(), 0), EPERM);
+	CHECK_ERRNO(utimensat(3, "pids.max", now, 0), EPERM);
+	CHECK_ERRNO(fchmod(3, 0777), EPERM);
+	CHECK_ERRNO(fchown(3, getuid(), getgid()), EPERM);
+	CHECK_ERRNO(fsetxattr(3, "user.cell", "c", 1, 0), EPERM);
+
+	/* What it makes is its own, limits and all. */
+	CHECK(!mkdirat(3, "mine", 0755), "mkdir: %d", errno);
+	CHECK(!write_at(3, "mine/cgroup.max.depth", "3"), "a limit below: %d", errno);
+	CHECK(!fchmodat(3, "mine", 0700, 0), "chmod below: %d", errno);
+	CHECK(!unlinkat(3, "mine", AT_REMOVEDIR), "rmdir: %d", errno);
+}
+
+/* fd 3 is the budget. Make and remove cgroups until killed. */
+static void cg_churn(void)
+{
+	char a[32], b[48];
+	int i;
+
+	for (i = 0; i < 3; i++) {
+		if (!fork())
+			break;
+	}
+	snprintf(a, sizeof(a), "c%d", getpid());
+	snprintf(b, sizeof(b), "%s/x", a);
+	/* Not before it is known to work. */
+	if (!i && (mkdirat(3, a, 0755) || write(4, "r", 1) != 1))
+		_exit(1);
+	for (;;) {
+		mkdirat(3, a, 0755);
+		mkdirat(3, b, 0755);
+		unlinkat(3, b, AT_REMOVEDIR);
+		unlinkat(3, a, AT_REMOVEDIR);
+	}
+}
+
+/* fd 3 is the budget. Freeze a cgroup with a task in it, and wait to be killed. */
+static void cg_freeze(void)
+{
+	CHECK(!mkdirat(3, "cold", 0755), "mkdir: %d", errno);
+	if (!fork()) {
+		write_at(3, "cold/cgroup.procs", "0");
+		for (;;)
+			pause();
+	}
+	usleep(100000);
+	CHECK(!write_at(3, "cold/cgroup.freeze", "1"), "freeze: %d", errno);
+	show_the_host();
+}
+
+/*
+ * All of cgroupfs is at /data, and /data/open and its files are there for
+ * anybody to write. It is not within the budget.
+ */
+static void check_outside_the_budget(void)
+{
+	CHECK_ERRNO(write_str("/data/open/cgroup.subtree_control", "+pids"), EPERM);
+	CHECK_ERRNO(write_str("/data/open/cgroup.procs", "0"), EPERM);
+	CHECK_ERRNO(write_str("/data/open/pids.max", "1"), EPERM);
+	CHECK_ERRNO(rmdir("/data/open/empty"), EPERM);
+	CHECK_ERRNO(chmod("/data/open", 0700), EPERM);
+	/* These may not get that far: the id of the caller cannot be stored here. */
+	CHECK(mkdir("/data/open/mine", 0755) && (errno == EPERM || errno == EOVERFLOW),
+	      "mkdir: %d", errno);
+	CHECK(rename("/data/open/empty", "/data/open/other") &&
+	      (errno == EPERM || errno == EOVERFLOW), "rename: %d", errno);
+	CHECK(chown("/data/open", 0, 0) && (errno == EPERM || errno == EOVERFLOW),
+	      "chown: %d", errno);
+	/* Neither of these asks cgroup anything. */
+	CHECK_ERRNO(setxattr("/data/open", "user.cell", "x", 1, 0), EPERM);
+	CHECK_ERRNO(setxattr("/data/open", "user.host", "x", 1, 0), EPERM);
+	CHECK_ERRNO(removexattr("/data/open", "user.host"), EPERM);
+	CHECK_ERRNO(utimensat(AT_FDCWD, "/data/open", NULL, 0), EPERM);
+	CHECK_ERRNO(open("/data/open/cgroup.procs", O_WRONLY), EPERM);
+	CHECK(open("/data/open/cgroup.procs", O_RDONLY) >= 0, "open to read: %d", errno);
+}
+
+/* A legacy hierarchy has no budget on it, and it can rename. */
+static void check_legacy_hierarchy(void)
+{
+	CHECK_ERRNO(rename("/data/open/empty", "/data/open/other"), EPERM);
+	CHECK_ERRNO(rmdir("/data/open/empty"), EPERM);
+	CHECK_ERRNO(write_str("/data/open/cgroup.procs", "0"), EPERM);
+	CHECK_ERRNO(write_str("/data/open/notify_on_release", "1"), EPERM);
+	CHECK_ERRNO(setxattr("/data/open", "user.cell", "x", 1, 0), EPERM);
+	CHECK(mkdir("/data/open/mine", 0755) && (errno == EPERM || errno == EOVERFLOW),
+	      "mkdir: %d", errno);
+}
+
+/*
+ * A cell of one id runs on the id of its maker, so it owns what its maker owns.
+ * File descriptor 3 is on a cgroup of the maker's that is not within the budget.
+ */
+static void check_outside_but_its_own(void)
+{
+	struct stat st;
+
+	CHECK(!fstat(3, &st) && st.st_uid == getuid(), "owner %u", st.st_uid);
+	CHECK_ERRNO(fchmod(3, 0700), EPERM);
+	CHECK_ERRNO(fchown(3, -1, getgid()), EPERM);
+	CHECK_ERRNO(futimens(3, NULL), EPERM);
+	CHECK_ERRNO(fsetxattr(3, "user.cell", "x", 1, 0), EPERM);
+	CHECK_ERRNO(fremovexattr(3, "user.host"), EPERM);
+	CHECK_ERRNO(mkdirat(3, "mine", 0755), EPERM);
+	CHECK_ERRNO(unlinkat(3, "empty", AT_REMOVEDIR), EPERM);
+	CHECK_ERRNO(openat(3, "cgroup.procs", O_WRONLY), EPERM);
+	CHECK_ERRNO(fchmodat(3, "cgroup.procs", 0666, 0), EPERM);
+	/* File descriptor 4 was opened for writing by the maker. */
+	CHECK_ERRNO(write(4, "5", 1), EPERM);
+	/* File descriptor 5, if there is one, is the same on a legacy hierarchy. */
+	if (fstat(5, &st))
+		return;
+	CHECK(st.st_uid == getuid(), "owner %u", st.st_uid);
+	CHECK_ERRNO(renameat(5, "empty", 5, "other"), EPERM);
+	CHECK_ERRNO(mkdirat(5, "mine", 0755), EPERM);
+	CHECK_ERRNO(unlinkat(5, "empty", AT_REMOVEDIR), EPERM);
+	CHECK_ERRNO(fchmod(5, 0700), EPERM);
+	CHECK_ERRNO(fsetxattr(5, "user.cell", "x", 1, 0), EPERM);
+}
+
+#ifndef SO_PEERPIDFD
+#define SO_PEERPIDFD	77
+#endif
+
+static int race_sock = -1, race_stop, race_hits;
+
+static void *peer_race_ask(void *arg)
+{
+	while (!__atomic_load_n(&race_stop, __ATOMIC_RELAXED)) {
+		int s = __atomic_load_n(&race_sock, __ATOMIC_RELAXED), fd = -1;
+		socklen_t len = sizeof(int);
+
+		if (s >= 0 && !getsockopt(s, SOL_SOCKET, SO_PEERPIDFD, &fd, &len)) {
+			__atomic_fetch_add(&race_hits, 1, __ATOMIC_RELAXED);
+			close(fd);
+		}
+	}
+	return NULL;
+}
+
+/*
+ * Who the peer is must be checked and read in one go. One thread connects a
+ * fresh socket to a listener of the host's, over and over, while another asks
+ * each of them for a pidfd on its peer. There is no moment at which it gets one.
+ */
+static void check_peer_race(void)
+{
+	struct sockaddr_un addr = { .sun_family = AF_UNIX, .sun_path = "/tmp/sock" };
+	time_t end = time(NULL) + 8;
+	pthread_t ask[2];
+	int i, s, connected = 0;
+
+	for (i = 0; i < 2; i++)
+		CHECK(!pthread_create(&ask[i], NULL, peer_race_ask, NULL), "thread");
+	while (time(NULL) < end) {
+		s = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
+		if (s < 0)
+			break;
+		__atomic_store_n(&race_sock, s, __ATOMIC_RELAXED);
+		if (!connect(s, (struct sockaddr *)&addr, sizeof(addr)))
+			connected++;
+		__atomic_store_n(&race_sock, -1, __ATOMIC_RELAXED);
+		close(s);
+	}
+	__atomic_store_n(&race_stop, 1, __ATOMIC_RELAXED);
+	for (i = 0; i < 2; i++)
+		pthread_join(ask[i], NULL);
+	CHECK(connected > 100, "only %d connected", connected);
+	CHECK(!race_hits, "%d pidfds on a task of the host in %d connects",
+	      race_hits, connected);
+}
+
+static const struct sockaddr_in pod_addr = {
+	.sin_family = AF_INET,
+	.sin_port = __builtin_bswap16(7777),
+	.sin_addr = { __builtin_bswap32(INADDR_LOOPBACK) },
+};
+
+/* One container of a pod: leaves a file on the volume and serves on localhost. */
+static void pod_serve(void)
+{
+	int one = 1, fd, lsock, conn;
+	char c = 0;
+
+	fd = open("/data/from-a", O_CREAT | O_WRONLY, 0600);
+	CHECK(fd >= 0, "create on the volume: %d", errno);
+	close(fd);
+	lsock = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
+	CHECK(lsock >= 0, "socket: %d", errno);
+	setsockopt(lsock, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one));
+	CHECK(!bind(lsock, (const struct sockaddr *)&pod_addr, sizeof(pod_addr)),
+	      "bind: %d", errno);
+	CHECK(!listen(lsock, 1), "listen: %d", errno);
+	/* Ready. */
+	CHECK(write(3, "r", 1) == 1, "ready: %d", errno);
+	conn = accept(lsock, NULL, NULL);
+	CHECK(conn >= 0, "accept: %d", errno);
+	CHECK(read(conn, &c, 1) == 1 && c == 'p', "read '%c': %d", c, errno);
+	CHECK(write(conn, "q", 1) == 1, "write: %d", errno);
+}
+
+/* Another one: finds the file, as its own root's, and talks to the first. */
+static void pod_connect(void)
+{
+	struct stat st;
+	char c = 0;
+	int sock;
+
+	CHECK(!stat("/data/from-a", &st), "stat on the volume: %d", errno);
+	CHECK(st.st_uid == 0 && st.st_gid == 0, "owner %u:%u", st.st_uid, st.st_gid);
+	sock = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
+	CHECK(sock >= 0, "socket: %d", errno);
+	CHECK(!connect(sock, (const struct sockaddr *)&pod_addr, sizeof(pod_addr)),
+	      "connect: %d", errno);
+	CHECK(write(sock, "p", 1) == 1, "write: %d", errno);
+	CHECK(read(sock, &c, 1) == 1 && c == 'q', "read '%c': %d", c, errno);
+}
+
+/* The network. */
+
+static bool has_cap(int cap)
+{
+	struct __user_cap_header_struct hdr = { .version = _LINUX_CAPABILITY_VERSION_3 };
+	struct __user_cap_data_struct data[2] = {};
+
+	return !syscall(SYS_capget, &hdr, data) && (data[cap / 32].effective & (1U << (cap % 32)));
+}
+
+static int dev_flags(const char *dev, int set, int clear)
+{
+	struct ifreq ifr = {};
+	int s = socket(AF_INET, SOCK_DGRAM | SOCK_CLOEXEC, 0), was, r;
+
+	strcpy(ifr.ifr_name, dev);
+	r = ioctl(s, SIOCGIFFLAGS, &ifr);
+	was = (unsigned short)ifr.ifr_flags;
+	if (!r && (set || clear)) {
+		ifr.ifr_flags = (was | set) & ~clear;
+		r = ioctl(s, SIOCSIFFLAGS, &ifr);
+	}
+	r = r ? -errno : was;
+	close(s);
+	return r;
+}
+
+static int dev_set_addr(const char *dev, unsigned int ip)
+{
+	struct ifreq ifr = {};
+	struct sockaddr_in *sin = (void *)&ifr.ifr_addr;
+	int s = socket(AF_INET, SOCK_DGRAM | SOCK_CLOEXEC, 0), r;
+
+	strcpy(ifr.ifr_name, dev);
+	sin->sin_family = AF_INET;
+	sin->sin_addr.s_addr = __builtin_bswap32(ip);
+	r = ioctl(s, SIOCSIFADDR, &ifr) ? -errno : 0;
+	close(s);
+	return r;
+}
+
+static int try_bind(int port)
+{
+	struct sockaddr_in a = { .sin_family = AF_INET, .sin_port = __builtin_bswap16(port) };
+	int s = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0), r;
+
+	r = bind(s, (void *)&a, sizeof(a)) ? -errno : 0;
+	close(s);
+	return r;
+}
+
+static int try_connect(unsigned int ip, int port)
+{
+	struct sockaddr_in a = { .sin_family = AF_INET, .sin_port = __builtin_bswap16(port),
+				 .sin_addr = { __builtin_bswap32(ip) } };
+	int s = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
+
+	if (connect(s, (void *)&a, sizeof(a))) {
+		int err = errno;
+
+		close(s);
+		return -err;
+	}
+	return s;
+}
+
+/*
+ * One request on a netlink socket. Returns what the kernel made of it. NLM_F_ECHO, which
+ * means nothing here, stands for a plain write(): whoever says where a message is to go
+ * knows what it is writing to, and whoever opened the socket is then not asked about.
+ */
+static int nl_poke_on(int s, int type, int flags, const void *body, size_t len)
+{
+	struct sockaddr_nl sa = { .nl_family = AF_NETLINK };
+	bool plain = flags & NLM_F_ECHO;
+	struct {
+		struct nlmsghdr h;
+		char body[64];
+	} req = { .h = { sizeof(req), type, NLM_F_REQUEST | NLM_F_ACK | (flags & ~NLM_F_ECHO) } };
+	char buf[4096];
+	struct nlmsghdr *h = (void *)buf;
+	int n;
+
+	if (body) {
+		memcpy(req.body, body, len);
+		req.h.nlmsg_len = NLMSG_LENGTH(len);
+	}
+	if ((plain ? write(s, &req, req.h.nlmsg_len) :
+		     sendto(s, &req, req.h.nlmsg_len, 0, (void *)&sa, sizeof(sa))) < 0)
+		return -errno;
+	n = recv(s, buf, sizeof(buf), 0);
+	if (n < (int)sizeof(*h))
+		return -EPROTO;
+	return h->nlmsg_type == NLMSG_ERROR ? ((struct nlmsgerr *)NLMSG_DATA(h))->error : 0;
+}
+
+static int nl_poke(int proto, int type, const void *body, size_t len)
+{
+	int s = socket(AF_NETLINK, SOCK_RAW | SOCK_CLOEXEC, proto), r;
+
+	if (s < 0)
+		return -errno;
+	r = nl_poke_on(s, type, 0, body, len);
+	close(s);
+	return r;
+}
+
+/* Allowed or not is all that is asked: a request that is let through may well be nonsense. */
+#define MAY(right, r, refused, fmt, ...) \
+	CHECK((rights & (right)) ? (r) != (refused) : (r) == (refused), \
+	      "%s " fmt ": %d", (rights & (right)) ? "refused" : "allowed", ##__VA_ARGS__, (int)(r))
+
+/*
+ * What the cell may do to its network is what the builder named, @granted, and who in
+ * the cell may do it is whoever has the capability that it takes anywhere else.
+ */
+static void check_net_config(const char *dev, unsigned long long granted)
+{
+	static const struct { int type; unsigned long long right; } rtnl[] = {
+		{ RTM_SETLINK, CELL_NET_LINK }, { RTM_DELLINK, CELL_NET_LINK_NEW },
+		{ RTM_NEWADDR, CELL_NET_ADDR }, { RTM_DELADDR, CELL_NET_ADDR },
+		{ RTM_NEWROUTE, CELL_NET_ROUTE }, { RTM_DELROUTE, CELL_NET_ROUTE },
+		{ RTM_NEWNEIGH, CELL_NET_ROUTE }, { RTM_NEWRULE, CELL_NET_ROUTE },
+		{ RTM_NEWQDISC, CELL_NET_TC }, { RTM_NEWTFILTER, CELL_NET_TC },
+		/* Nobody has said what these are for. */
+		{ RTM_NEWNSID, 0 }, { RTM_NEWNETCONF, 0 }, { RTM_SETDCB, 0 },
+	};
+	struct ifinfomsg lo = { .ifi_index = 1 }, none = {};
+	struct nfgenmsg nfg = { .nfgen_family = AF_INET };
+	struct ifreq ifr = { .ifr_flags = IFF_TAP | IFF_NO_PI };
+	unsigned long long rights = 0;
+	struct rtentry rt = {};
+	socklen_t len = 84;
+	char info[84] = "filter";
+	int one = 1, r, s;
+	unsigned int i;
+
+	if (has_cap(CAP_NET_ADMIN))
+		rights |= granted & ~CELL_NET_RAW;
+	if (has_cap(CAP_NET_RAW))
+		rights |= granted & CELL_NET_RAW;
+
+	for (i = 0; i < ARRAY_SIZE(rtnl); i++) {
+		r = nl_poke(NETLINK_ROUTE, rtnl[i].type, NULL, 0);
+		MAY(rtnl[i].right, r, -EPERM, "rtnetlink %d", rtnl[i].type);
+	}
+	/* The one request is for a device that is there and for one that is to be. */
+	r = nl_poke(NETLINK_ROUTE, RTM_NEWLINK, &lo, sizeof(lo));
+	MAY(CELL_NET_LINK, r, -EPERM, "RTM_NEWLINK for lo");
+	s = socket(AF_NETLINK, SOCK_RAW | SOCK_CLOEXEC, NETLINK_ROUTE);
+	r = nl_poke_on(s, RTM_NEWLINK, NLM_F_CREATE | NLM_F_EXCL, &none, sizeof(none));
+	MAY(CELL_NET_LINK_NEW, r, -EPERM, "RTM_NEWLINK for a new device");
+	close(s);
+
+	r = dev_flags(dev, IFF_UP, 0);
+	MAY(CELL_NET_LINK, r, -EPERM, "%s up", dev);
+	r = dev_flags(dev, 0, IFF_UP);
+	MAY(CELL_NET_LINK, r, -EPERM, "%s down", dev);
+	r = dev_set_addr(dev, 0x0a0900fe);
+	MAY(CELL_NET_ADDR, r, -EPERM, "address on %s", dev);
+	s = socket(AF_INET, SOCK_DGRAM | SOCK_CLOEXEC, 0);
+	r = ioctl(s, SIOCADDRT, &rt) ? -errno : 0;
+	MAY(CELL_NET_ROUTE, r, -EPERM, "SIOCADDRT");
+
+	r = setsockopt(s, SOL_SOCKET, SO_MARK, &one, sizeof(one)) ? -errno : 0;
+	MAY(CELL_NET_SOCKOPT | CELL_NET_RAW, r, -EPERM, "SO_MARK");
+	r = setsockopt(s, IPPROTO_IP, IP_TRANSPARENT, &one, sizeof(one)) ? -errno : 0;
+	MAY(CELL_NET_SOCKOPT | CELL_NET_RAW, r, -EPERM, "IP_TRANSPARENT");
+
+	/* Both ways into netfilter, where it is built. */
+	r = nl_poke(NETLINK_NETFILTER, NFNL_SUBSYS_NFTABLES << 8 | NFT_MSG_GETGEN, &nfg,
+		    sizeof(nfg));
+	if (r != -EPROTONOSUPPORT) {
+		MAY(CELL_NET_FILTER, r, -EPERM, "nftables");
+		/* What these keep is not per network namespace. Not with any right. */
+		r = nl_poke(NETLINK_NETFILTER, NFNL_SUBSYS_OSF << 8 | 0 /* OSF_MSG_ADD */, &nfg,
+			    sizeof(nfg));
+		CHECK(r == -EPERM || ((rights & CELL_NET_FILTER) && r == -EINVAL), "osf: %d", r);
+		r = nl_poke(NETLINK_NETFILTER, NFNL_SUBSYS_CTHELPER << 8 | 0 /* NEW */, &nfg,
+			    sizeof(nfg));
+		CHECK(r == -EPERM || ((rights & CELL_NET_FILTER) && r == -EINVAL),
+		      "cthelper: %d", r);
+	}
+	r = getsockopt(s, IPPROTO_IP, 64 /* IPT_SO_GET_INFO */, info, &len) ? -errno : 0;
+	if (r != -ENOPROTOOPT)
+		MAY(CELL_NET_FILTER, r, -EPERM, "iptables");
+	close(s);
+
+	s = socket(AF_INET, SOCK_RAW | SOCK_CLOEXEC, IPPROTO_ICMP);
+	MAY(CELL_NET_RAW, s < 0 ? -errno : 0, -EPERM, "raw socket");
+	close(s);
+	s = socket(AF_PACKET, SOCK_RAW | SOCK_CLOEXEC, 0);
+	MAY(CELL_NET_RAW, s < 0 ? -errno : 0, -EPERM, "packet socket");
+	close(s);
+
+	r = write_str("/proc/sys/net/ipv4/ip_forward", "1") ? -errno : 0;
+	MAY(CELL_NET_SYSCTL, r, -EACCES, "net sysctl");
+
+	s = open("/tun", O_RDWR | O_CLOEXEC);
+	if (s >= 0) {
+		strcpy(ifr.ifr_name, "tap%d");
+		r = ioctl(s, TUNSETIFF, &ifr) ? -errno : 0;
+		MAY(CELL_NET_TUN, r, -EPERM, "TUNSETIFF");
+		close(s);
+	}
+
+	/* There is no right for these, so far or at all. */
+	r = try_bind(80);
+	CHECK(r == -EACCES, "port 80: %d", r);
+	r = nl_poke(NETLINK_XFRM, 0x10 /* XFRM_MSG_NEWSA */, NULL, 0);
+	CHECK(r == -EPERM || r == -EPROTONOSUPPORT, "xfrm: %d", r);
+}
+
+/* @arg: the rights in hex, then a device if it is not to be lo. */
+static void check_net_rights(const char *hex, const char *dev)
+{
+	unsigned long long granted = strtoull(hex, NULL, 16), caps = status_caps("CapPrm");
+	int s;
+
+	check_net_config(dev ?: "lo", granted);
+
+	/*
+	 * A request by netlink is also held against whoever opened the socket, lest
+	 * somebody has another write to a socket of its own making.
+	 */
+	CHECK(!set_caps_to(0, caps), "capset: %d", errno);
+	s = socket(AF_NETLINK, SOCK_RAW | SOCK_CLOEXEC, NETLINK_ROUTE);
+	CHECK(!set_caps_to(caps, caps), "capset: %d", errno);
+	CHECK(nl_poke_on(s, RTM_SETLINK, NLM_F_ECHO, NULL, 0) == -EPERM, "a socket opened without");
+	close(s);
+	/* It does tell: the same on a socket of its own. */
+	if ((granted & CELL_NET_LINK) && has_cap(CAP_NET_ADMIN)) {
+		s = socket(AF_NETLINK, SOCK_RAW | SOCK_CLOEXEC, NETLINK_ROUTE);
+		CHECK(nl_poke_on(s, RTM_SETLINK, NLM_F_ECHO, NULL, 0) != -EPERM, "its own socket");
+		close(s);
+	}
+
+	/* Who lets go of the capability is like anybody else in here. */
+	CHECK(!set_caps(0), "capset: %d", errno);
+	check_net_config(dev ?: "lo", granted);
+	CHECK(!has_cap(CAP_NET_ADMIN) && !has_cap(CAP_NET_RAW), "still has them");
+}
+
+/*
+ * The rights are over the network of the cell. Files 3 and 4 are an inet and a
+ * rtnetlink socket that somebody made in another one.
+ */
+static void check_net_foreign(void)
+{
+	struct ifreq ifr = { .ifr_name = "lo", .ifr_flags = IFF_UP };
+	int one = 1;
+
+	CHECK_ERRNO(setsockopt(3, SOL_SOCKET, SO_MARK, &one, sizeof(one)), EPERM);
+	CHECK_ERRNO(ioctl(3, SIOCSIFFLAGS, &ifr), EPERM);
+	CHECK(nl_poke_on(4, RTM_SETLINK, 0, NULL, 0) == -EPERM, "RTM_SETLINK elsewhere");
+	CHECK(nl_poke_on(4, RTM_NEWADDR, 0, NULL, 0) == -EPERM, "RTM_NEWADDR elsewhere");
+	/* They do work at home. */
+	check_net_config("lo", ~0ULL);
+}
+
+/* Nobody has set it up: there is a loopback device that is down, and that is that. */
+static void check_net_bare(void)
+{
+	struct if_nameindex *ni = if_nameindex();
+	int r;
+
+	CHECK(ni && ni[0].if_name && !strcmp(ni[0].if_name, "lo") && !ni[1].if_index,
+	      "more than lo");
+	r = dev_flags("lo", 0, 0);
+	CHECK(r >= 0 && !(r & IFF_UP), "lo: %x", r);
+	r = try_connect(INADDR_LOOPBACK, 7777);
+	CHECK(r == -ENETUNREACH, "connect: %d", r);
+	check_net_config("lo", 0);
+}
+
+/*
+ * The slot was left empty, so there is no network: no socket but a unix socket,
+ * and nothing to be learned about a network through any socket. File descriptor
+ * 3 is a socket of the host's that listens on its loopback device. What is handed
+ * to the cell works.
+ */
+static void check_net_none(void)
+{
+	static const int families[] = {
+		AF_INET, AF_INET6, AF_NETLINK, AF_PACKET, AF_ALG, AF_VSOCK, AF_KEY, AF_XDP,
+		AF_BLUETOOTH, AF_CAN, AF_TIPC,
+	};
+	static const unsigned long about_the_net[] = {
+		SIOCGIFCONF, SIOCGIFFLAGS, SIOCSIFFLAGS, SIOCGIFADDR, SIOCSIFADDR, SIOCGIFINDEX,
+		SIOCGIFNAME, SIOCGIFHWADDR, SIOCADDRT, SIOCDELRT, SIOCGARP, SIOCGIFBR,
+		SIOCBRADDBR, SIOCGIFVLAN, SIOCDEVPRIVATE, SIOCGSKNS, 0x8B01 /* SIOCGIWNAME */,
+	};
+	struct sockaddr_un addr = { .sun_family = AF_UNIX, .sun_path = "\0cell-test" };
+	int sp[2], socks[2], s, l, n, pending;
+	unsigned int i, j;
+	char c = 0;
+
+	for (i = 0; i < ARRAY_SIZE(families); i++) {
+		CHECK_ERRNO(socket(families[i], SOCK_DGRAM | SOCK_CLOEXEC, 0), EAFNOSUPPORT);
+		CHECK_ERRNO(socket(families[i], SOCK_STREAM | SOCK_CLOEXEC, 0), EAFNOSUPPORT);
+		CHECK_ERRNO(socket(families[i], SOCK_RAW | SOCK_CLOEXEC, 0), EAFNOSUPPORT);
+		CHECK_ERRNO(socketpair(families[i], SOCK_STREAM, 0, sp), EAFNOSUPPORT);
+	}
+	CHECK(!if_nameindex(), "there are devices to be listed");
+
+	/* Unix sockets are not the network. */
+	CHECK(!socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, sp), "socketpair: %d", errno);
+	l = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
+	CHECK(l >= 0 && !bind(l, (void *)&addr, sizeof(sa_family_t) + 10) && !listen(l, 1),
+	      "an abstract unix socket: %d", errno);
+	s = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
+	CHECK(!connect(s, (void *)&addr, sizeof(sa_family_t) + 10), "connect to it: %d", errno);
+
+	/* What was handed over works, new sockets that come of it included. */
+	n = accept4(3, NULL, NULL, SOCK_CLOEXEC);
+	CHECK(n >= 0, "accept: %d", errno);
+	CHECK(read(n, &c, 1) == 1 && c == 'h' && write(n, "c", 1) == 1,
+	      "talk to the host: '%c', %d", c, errno);
+
+	/* About the socket: fine. About the network it is in: there is none. */
+	socks[0] = s;
+	socks[1] = n;
+	for (j = 0; j < ARRAY_SIZE(socks); j++) {
+		CHECK(!ioctl(socks[j], FIONREAD, &pending), "FIONREAD on %u: %d", j, errno);
+		CHECK(!ioctl(socks[j], SIOCGPGRP, &pending), "SIOCGPGRP on %u: %d", j, errno);
+		/* In among those that are about devices, by its number. */
+		if (j)
+			CHECK(!ioctl(socks[j], SIOCOUTQNSD, &pending), "SIOCOUTQNSD: %d", errno);
+		for (i = 0; i < ARRAY_SIZE(about_the_net); i++) {
+			struct ifreq ifr = { .ifr_name = "lo" };
+
+			errno = 0;
+			CHECK(ioctl(socks[j], about_the_net[i], &ifr) == -1 && errno == ENODEV,
+			      "ioctl %#lx on %u: %d", about_the_net[i], j, errno);
+		}
+	}
+}
+
+/* "new", and whoever built the cell has brought lo up before sealing it. */
+static void check_net_lo(void)
+{
+	int r = dev_flags("lo", 0, 0);
+
+	CHECK(r >= 0 && (r & IFF_UP), "lo: %x", r);
+	r = try_connect(INADDR_LOOPBACK, 7777);
+	CHECK(r == -ECONNREFUSED, "connect: %d", r);
+	check_net_config("lo", 0);
+}
+
+/*
+ * One end of a veth pair, with an address. The host listens at the other end.
+ * File descriptors 3 and 4 are for telling the host to add an address meanwhile.
+ */
+static void check_net_given(void)
+{
+	char c = 0;
+	int s;
+
+	s = try_connect(0x0a090001, 7777);
+	CHECK(s >= 0, "connect to the host: %d", s);
+	CHECK(write(s, "c", 1) == 1 && read(s, &c, 1) == 1 && c == 'h',
+	      "talk to the host: '%c', %d", c, errno);
+	close(s);
+	CHECK(!try_bind(8080), "port 8080");
+
+	CHECK(try_connect(0x0a090003, 9) == -ENETUNREACH ||
+	      try_connect(0x0a090003, 9) == -EHOSTUNREACH, "the address is there already");
+	CHECK(write(3, "a", 1) == 1 && read(4, &c, 1) == 1, "handshake: %d", errno);
+	s = try_connect(0x0a090003, 9);
+	CHECK(s == -ECONNREFUSED, "the address that was added from the outside: %d", s);
+
+	check_net_config("vc0", 0);
+}
+
+/* Low ports and ping are settings of the network namespace. */
+static void check_net_settings(const char *when)
+{
+	struct sockaddr_in lo = { .sin_family = AF_INET,
+				  .sin_addr = { __builtin_bswap32(INADDR_LOOPBACK) } };
+	struct {
+		unsigned char type, code;
+		unsigned short sum, id, seq;
+	} echo = { .type = 8 }, reply = { .type = 0xff };
+	bool after = !strcmp(when, "after");
+	int r, s;
+
+	r = try_bind(80);
+	CHECK(after ? !r : r == -EACCES, "port 80: %d", r);
+	s = socket(AF_INET, SOCK_DGRAM | SOCK_CLOEXEC, IPPROTO_ICMP);
+	CHECK(after ? s >= 0 : (s == -1 && errno == EACCES), "ping socket: %d, %d", s, errno);
+	if (s >= 0) {
+		CHECK(sendto(s, &echo, sizeof(echo), 0, (void *)&lo, sizeof(lo)) == sizeof(echo),
+		      "echo: %d", errno);
+		CHECK(recv(s, &reply, sizeof(reply), 0) == sizeof(reply) && !reply.type,
+		      "echo reply: type %d, %d", reply.type, errno);
+		close(s);
+	}
+	/* They are not the cell's to change back. */
+	CHECK_ERRNO(write_str("/proc/sys/net/ipv4/ip_unprivileged_port_start", "1024"), EACCES);
+	CHECK_ERRNO(write_str("/proc/sys/net/ipv4/ping_group_range", "1 0"), EACCES);
+}
+
+/* Is there a network at all? */
+static void check_net_at_all(const char *want)
+{
+	int s = socket(AF_INET, SOCK_DGRAM | SOCK_CLOEXEC, 0);
+
+	if (!strcmp(want, "yes"))
+		CHECK(s >= 0, "socket: %d", errno);
+	else
+		CHECK(s == -1 && errno == EAFNOSUPPORT, "socket: %d, %d", s, errno);
+}
+
+/* The id that the network namespace of @dev has for the one its other end is in. */
+static int link_netnsid(const char *dev)
+{
+	struct sockaddr_nl sa = { .nl_family = AF_NETLINK };
+	struct {
+		struct nlmsghdr h;
+		struct ifinfomsg ifi;
+	} req = {
+		.h = { sizeof(req), RTM_GETLINK, NLM_F_REQUEST },
+		.ifi = { .ifi_index = if_nametoindex(dev) },
+	};
+	int s = socket(AF_NETLINK, SOCK_RAW | SOCK_CLOEXEC, NETLINK_ROUTE), n, left;
+	struct nlmsghdr *h;
+	struct rtattr *a;
+	char buf[8192];
+
+	if (s < 0 || sendto(s, &req, sizeof(req), 0, (void *)&sa, sizeof(sa)) < 0)
+		return -errno;
+	n = recv(s, buf, sizeof(buf), 0);
+	close(s);
+	h = (void *)buf;
+	if (n < (int)sizeof(*h) || h->nlmsg_type != RTM_NEWLINK)
+		return -EPROTO;
+	left = h->nlmsg_len - NLMSG_LENGTH(sizeof(req.ifi));
+	for (a = IFLA_RTA(NLMSG_DATA(h)); RTA_OK(a, left); a = RTA_NEXT(a, left)) {
+		if (a->rta_type == IFLA_LINK_NETNSID)
+			return *(int *)RTA_DATA(a);
+	}
+	return -ENOENT;
+}
+
+/*
+ * A veth device whose peer is elsewhere gives the network namespace it is in an id for
+ * the other one, and a request can name that as the place for a device to go to, to be
+ * made in, or to be linked to. @dev is such a device, and the other end is the host's.
+ */
+static void check_net_no_way_out(const char *dev)
+{
+	struct {
+		struct ifinfomsg ifi;
+		struct nlattr a;
+		int nsid;
+		struct nlattr n;
+		char name[8];
+		struct nlattr li;
+		struct nlattr k;
+		char kind[8];
+	} req = {
+		.a = { NLA_HDRLEN + 4, IFLA_TARGET_NETNSID },
+		.n = { NLA_HDRLEN + 5, IFLA_IFNAME }, .name = "esc0",
+		.li = { 2 * NLA_HDRLEN + 8, IFLA_LINKINFO | NLA_F_NESTED },
+		.k = { NLA_HDRLEN + 5, IFLA_INFO_KIND }, .kind = "veth",
+	};
+	int s = socket(AF_NETLINK, SOCK_RAW | SOCK_CLOEXEC, NETLINK_ROUTE), r, nsid;
+
+	/* Anybody can look it up. Without one, what follows would say nothing. */
+	nsid = link_netnsid(dev);
+	CHECK(nsid >= 0, "no id for where the other end of %s is: %d", dev, nsid);
+	if (failures)
+		return;
+
+	req.nsid = nsid;
+	r = nl_poke_on(s, RTM_NEWLINK, NLM_F_CREATE | NLM_F_EXCL, &req, sizeof(req));
+	CHECK(r == -EPERM, "a device made elsewhere: %d", r);
+	req.nsid = nsid + 77;
+	r = nl_poke_on(s, RTM_NEWLINK, NLM_F_CREATE | NLM_F_EXCL, &req, sizeof(req));
+	CHECK(r == -EINVAL, "an id that there is not: %d", r);
+	req.nsid = nsid;
+
+	req.a.nla_type = IFLA_LINK_NETNSID;
+	r = nl_poke_on(s, RTM_NEWLINK, NLM_F_CREATE | NLM_F_EXCL, &req, sizeof(req));
+	CHECK(r == -EPERM, "a device linked to elsewhere: %d", r);
+
+	req.a.nla_type = IFLA_TARGET_NETNSID;
+	req.ifi.ifi_index = if_nametoindex(dev);
+	r = nl_poke_on(s, RTM_SETLINK, 0, &req, offsetof(typeof(req), n));
+	CHECK(r == -EPERM, "%s moved elsewhere: %d", dev, r);
+	CHECK(if_nametoindex(dev), "%s is gone", dev);
+	close(s);
+
+	/* At home all of that works. */
+	req.a.nla_type = IFLA_UNSPEC;
+	req.ifi.ifi_index = 0;
+	s = socket(AF_NETLINK, SOCK_RAW | SOCK_CLOEXEC, NETLINK_ROUTE);
+	r = nl_poke_on(s, RTM_NEWLINK, NLM_F_CREATE | NLM_F_EXCL, &req, sizeof(req));
+	CHECK(!r && if_nametoindex("esc0"), "a device made at home: %d", r);
+	close(s);
+}
+
+/* Attaches to a tap device, or makes it. With an owner or a group it is made to stay. */
+static int tun_attach_as(const char *dev, int owner, int group)
+{
+	struct ifreq ifr = { .ifr_flags = IFF_TAP | IFF_NO_PI };
+	int fd = open("/bound", O_RDWR | O_CLOEXEC), r;
+
+	if (fd < 0)
+		fd = open("/tun", O_RDWR | O_CLOEXEC);
+	if (fd < 0)
+		return -errno;
+	strcpy(ifr.ifr_name, dev);
+	r = ioctl(fd, TUNSETIFF, &ifr) ? -errno : 0;
+	if (!r && owner >= 0 && ioctl(fd, TUNSETOWNER, owner))
+		r = -errno;
+	if (!r && group >= 0 && ioctl(fd, TUNSETGROUP, group))
+		r = -errno;
+	if (!r && (owner >= 0 || group >= 0) && ioctl(fd, TUNSETPERSIST, 1))
+		r = -errno;
+	close(fd);
+	return r;
+}
+
+static int tun_attach(const char *dev)
+{
+	return tun_attach_as(dev, -1, -1);
+}
+
+/*
+ * A tun device can have an owner and a group, who may attach to it without further ado.
+ * Those of tapu and tapg are the uid and the gid of whoever made this cell, which are also
+ * what a cell of one id runs on. They mean the maker. tapn has neither, which takes what
+ * it takes to make one.
+ */
+static void check_tun_owner(void)
+{
+	CHECK(tun_attach("tapu") == -EPERM, "the maker's, by uid: %d", tun_attach("tapu"));
+	CHECK(tun_attach("tapg") == -EPERM, "the maker's, by gid: %d", tun_attach("tapg"));
+	CHECK(tun_attach("tapn") == -EPERM, "nobody's: %d", tun_attach("tapn"));
+}
+
+/*
+ * Within a cell an owner is what it is anywhere. This one may make tun devices, and makes
+ * tapc for its uid 1000 and tapd for its gid 1000. taph was made on the outside, for the
+ * very same kuid, and that means nothing in here: it takes the right, as for a device of
+ * anybody else.
+ */
+static void check_tun_owner_within(void)
+{
+	int status;
+	pid_t pid;
+
+	CHECK(!tun_attach_as("tapc", 1000, -1), "making one for uid 1000: %d", errno);
+	CHECK(!tun_attach_as("tapd", -1, 1000), "making one for gid 1000: %d", errno);
+	CHECK(!tun_attach("taph"), "with the right");
+	if (failures)
+		return;
+
+	pid = fork();
+	if (!pid) {
+		if (setresgid(1000, 1000, 1000) || setresuid(1000, 1000, 1000))
+			_exit(1);
+		if (has_cap(CAP_NET_ADMIN))
+			_exit(2);
+		if (tun_attach("tapc"))
+			_exit(3);
+		if (tun_attach("tapd"))
+			_exit(5);
+		_exit(tun_attach("taph") == -EPERM ? 0 : 4);
+	}
+	CHECK(waitpid(pid, &status, 0) == pid && WIFEXITED(status) && !WEXITSTATUS(status),
+	      "as uid 1000: %x", status);
+}
+
+static void pause_for_good(void)
+{
+	for (;;)
+		pause();
+}
+
+static void fork_for_good(void)
+{
+	for (;;)
+		fork();
+}
+
+#define HELPER_RAN	"/tmp/cell_test_helper_ran"
+
+/* Run by the kernel, on the host: as modprobe, as request-key, or for a core dump. */
+static int note_helper(int argc, char **argv)
+{
+	int fd = open(HELPER_RAN, O_CREAT | O_WRONLY | O_APPEND, 0600), i;
+
+	for (i = 0; i < argc; i++)
+		dprintf(fd, "%s ", argv[i]);
+	dprintf(fd, "\n");
+	close(fd);
+	return 1;
+}
+
+/* What makes the kernel run a program, as root and outside of every namespace. */
+static void check_helpers(void)
+{
+	/* A protocol that nobody has: the kernel goes looking for a module. */
+	CHECK_ERRNO(socket(AF_ECONET, SOCK_DGRAM, 0), EAFNOSUPPORT);
+	/* A key that is not there, and something to tell whoever is to make it. */
+	CHECK_ERRNO(syscall(SYS_request_key, "user", "cell:test", "make it",
+			    KEY_SPEC_PROCESS_KEYRING), EPERM);
+	if (failures)
+		return;
+	/* And a crash. A real one: an init does not take a signal from itself. */
+	__builtin_trap();
+}
+
+int main(int argc, char **argv)
+{
+	const char *what = argc > 1 ? argv[1] : "";
+
+	if (!strcmp(what, "-q") || !strcmp(what, "core") || strstr(argv[0], "request-key"))
+		return note_helper(argc, argv);
+	if (!strcmp(what, "basic"))
+		check_basic();
+	else if (!strcmp(what, "helpers"))
+		check_helpers();
+	else if (!strcmp(what, "caps"))
+		check_caps(argv);
+	else if (!strcmp(what, "membership"))
+		check_membership();
+	else if (!strcmp(what, "setid"))
+		check_setid();
+	else if (!strcmp(what, "unix"))
+		check_unix();
+	else if (!strcmp(what, "dirfd"))
+		check_dirfd();
+	else if (!strcmp(what, "oneid"))
+		check_oneid(argv[2]);
+	else if (!strcmp(what, "pause"))
+		pause_for_good();
+	else if (!strcmp(what, "usr1"))
+		wait_for_usr1();
+	else if (!strcmp(what, "seccomp"))
+		check_seccomp();
+	else if (!strcmp(what, "signals"))
+		check_signals();
+	else if (!strcmp(what, "forkbomb"))
+		fork_for_good();
+	else if (!strcmp(what, "exit"))
+		return atoi(argv[2]);
+	else if (!strcmp(what, "in-cgroup"))
+		check_in_cgroup(argv[2]);
+	else if (!strcmp(what, "cg-manage"))
+		check_cg_manage(argv[2]);
+	else if (!strcmp(what, "cg-own"))
+		check_cg_own();
+	else if (!strcmp(what, "cg-churn"))
+		cg_churn();
+	else if (!strcmp(what, "cg-freeze"))
+		cg_freeze();
+	else if (!strcmp(what, "opens")) {
+		int fd = open(argv[2], O_RDWR);
+
+		if (!strcmp(argv[3], "yes"))
+			CHECK(fd >= 0, "%s: %d", argv[2], errno);
+		else
+			CHECK(fd == -1 && errno == EACCES, "%s: %d, %d", argv[2], fd, errno);
+	} else if (!strcmp(what, "exists"))
+		CHECK(!access(argv[2], F_OK), "%s: %d", argv[2], errno);
+	else if (!strcmp(what, "copy-up"))
+		check_copy_up();
+	else if (!strcmp(what, "vhost"))
+		check_vhost();
+	else if (!strcmp(what, "data"))
+		check_data(argv[2]);
+	else if (!strcmp(what, "second"))
+		check_second();
+	else if (!strcmp(what, "outside"))
+		check_outside_the_budget();
+	else if (!strcmp(what, "net-none"))
+		check_net_none();
+	else if (!strcmp(what, "net-at-all"))
+		check_net_at_all(argv[2]);
+	else if (!strcmp(what, "net-bare"))
+		check_net_bare();
+	else if (!strcmp(what, "net-lo"))
+		check_net_lo();
+	else if (!strcmp(what, "net-given"))
+		check_net_given();
+	else if (!strcmp(what, "net-settings"))
+		check_net_settings(argv[2]);
+	else if (!strcmp(what, "net-rights"))
+		check_net_rights(argv[2], argv[3]);
+	else if (!strcmp(what, "net-foreign"))
+		check_net_foreign();
+	else if (!strcmp(what, "tun-owner"))
+		check_tun_owner();
+	else if (!strcmp(what, "tun-owner-within"))
+		check_tun_owner_within();
+	else if (!strcmp(what, "net-no-way-out"))
+		check_net_no_way_out(argv[2]);
+	else if (!strcmp(what, "legacy"))
+		check_legacy_hierarchy();
+	else if (!strcmp(what, "outside-own"))
+		check_outside_but_its_own();
+	else if (!strcmp(what, "peer-race"))
+		check_peer_race();
+	else if (!strcmp(what, "pod-serve"))
+		pod_serve();
+	else if (!strcmp(what, "pod-connect"))
+		pod_connect();
+	else if (!strcmp(what, "uid"))
+		return ((int)getuid() == atoi(argv[2]) && (int)getgid() == atoi(argv[3])) ? 0 : 1;
+	else
+		return 99;
+
+	return failures ? 1 : 0;
+}
diff --git a/tools/testing/selftests/cell/cell_ids_test.c b/tools/testing/selftests/cell/cell_ids_test.c
new file mode 100644
index 000000000000..4178c80f8f63
--- /dev/null
+++ b/tools/testing/selftests/cell/cell_ids_test.c
@@ -0,0 +1,762 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Tests for cells, ids: the window, the blocks, and that nothing a cell writes
+ * imparts privilege.
+ */
+#include "cell_test.h"
+
+/* Root does not get a cell on kuid 0, least of all by default. */
+TEST_F(cell, no_cell_on_uid_0)
+{
+	EXPECT_EQ(cell_build(&self->c, &(struct build){ .ids = 1 }), 4);
+	EXPECT_EQ(errno, EPERM);
+	cell_cleanup(&self->c);
+	EXPECT_EQ(cell_build(&self->c, &(struct build){ .ids = 0 }), 18);
+	EXPECT_EQ(errno, EPERM);
+}
+
+/* The window is the kernel's. A one-id cell is not made of an id in it. */
+TEST_F(cell, no_cell_on_an_id_of_the_window)
+{
+	int status;
+	pid_t pid;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (!pid) {
+		unsigned int ids = 1;
+		int cfd;
+
+		if (setresuid(CELL_WINDOW_FIRST + 0x1234, CELL_WINDOW_FIRST + 0x1234, -1))
+			_exit(1);
+		cfd = cell_create(CELL_SELF, 0);
+		if (cfd < 0)
+			_exit(2);
+		if (cell_configure(cfd, CELL_SET_BINARY, "ids", &ids, sizeof(ids)) != -1 ||
+		    errno != EPERM)
+			_exit(3);
+		_exit(0);
+	}
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(WIFEXITED(status) ? WEXITSTATUS(status) : -1, 0);
+}
+
+TEST_F(cell, window_is_the_kernels)
+{
+	char path[64];
+	int sync[2];
+	pid_t pid;
+	char c;
+
+	ASSERT_EQ(pipe(sync), 0);
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (!pid) {
+		if (unshare(CLONE_NEWUSER))
+			_exit(1);
+		if (write(sync[1], "x", 1) != 1)
+			_exit(1);
+		pause();
+		_exit(0);
+	}
+	ASSERT_EQ(read(sync[0], &c, 1), 1);
+
+	snprintf(path, sizeof(path), "/proc/%d/uid_map", pid);
+	EXPECT_EQ(write_file(path, "0 2147483648 1"), -1);
+	EXPECT_EQ(errno, EPERM);
+	EXPECT_EQ(write_file(path, "0 2147483000 1000"), -1);
+	EXPECT_EQ(errno, EPERM);
+	EXPECT_EQ(write_file(path, "0 4294900000 10"), -1);
+	EXPECT_EQ(errno, EPERM);
+	EXPECT_EQ(write_file(path, "0 2147483000 648"), 0);
+	snprintf(path, sizeof(path), "/proc/%d/gid_map", pid);
+	EXPECT_EQ(write_file(path, "0 3000000000 1"), -1);
+	EXPECT_EQ(errno, EPERM);
+
+	kill(pid, SIGKILL);
+	waitpid(pid, NULL, 0);
+}
+
+static int set_option(int fs, const char *key, const char *val)
+{
+	return sys_fsconfig(fs, FSCONFIG_SET_STRING, key, val, 0);
+}
+
+/* Nor is it for a mount option to put one on the files of a filesystem. */
+TEST_F(cell, no_mount_option_names_an_id_of_the_window)
+{
+	static const char * const types[] = { "tmpfs", "bpf", "devpts", "hugetlbfs" };
+	static const char * const keys[] = { "uid", "gid" };
+	unsigned int t, k, seen = 0;
+
+	for (t = 0; t < ARRAY_SIZE(types); t++) {
+		int fs = sys_fsopen(types[t], FSOPEN_CLOEXEC);
+
+		if (fs < 0)
+			continue;
+		seen++;
+		for (k = 0; k < ARRAY_SIZE(keys); k++) {
+			TH_LOG("%s %s", types[t], keys[k]);
+			EXPECT_EQ(set_option(fs, keys[k], "2147483648"), -1);
+			EXPECT_EQ(errno, EINVAL);
+			EXPECT_EQ(set_option(fs, keys[k], "4294901759"), -1);
+			EXPECT_EQ(errno, EINVAL);
+			EXPECT_EQ(set_option(fs, keys[k], "2147483647"), 0);
+		}
+		close(fs);
+	}
+	EXPECT_GE(seen, 2);
+}
+
+/* Is anything below @dirfd owned by an id of the window? */
+static int window_ids_below(int dirfd)
+{
+	struct dirent *e;
+	struct stat st;
+	int n = 0, sub;
+	DIR *d;
+
+	d = fdopendir(openat(dirfd, ".", O_RDONLY | O_DIRECTORY | O_CLOEXEC));
+	if (!d)
+		return -1;
+	while ((e = readdir(d))) {
+		if (!strcmp(e->d_name, ".") || !strcmp(e->d_name, ".."))
+			continue;
+		if (fstatat(dirfd, e->d_name, &st, AT_SYMLINK_NOFOLLOW))
+			continue;
+		if (st.st_uid >= CELL_WINDOW_FIRST || st.st_gid >= CELL_WINDOW_FIRST)
+			n++;
+		if (!S_ISDIR(st.st_mode))
+			continue;
+		sub = openat(dirfd, e->d_name, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+		if (sub >= 0) {
+			n += window_ids_below(sub);
+			close(sub);
+		}
+	}
+	closedir(d);
+	return n;
+}
+
+static int run_in(struct cellctx *c, const char *what, const char *arg)
+{
+	int pidfd = spawn(c->cfd, NULL, what, arg, NULL), st;
+
+	if (pidfd < 0)
+		return -99;
+	st = cell_wait(c->cfd);
+	close(pidfd);
+	return st;
+}
+
+/* An overlay that is idmapped for the cell stores the ids on disk, copying up included. */
+TEST_F(cell, overlay_for_a_cell)
+{
+	struct stat st;
+	int r;
+
+	r = cell_build(&self->c, &(struct build){ .ids = 65536, .overlay = OVL_IDMAPPED });
+	if (r == 22 && sys_fsopen("overlay", FSOPEN_CLOEXEC) < 0)
+		SKIP(return, "no overlayfs");
+	ASSERT_EQ(r, 0);
+	EXPECT_EQ(run_in(&self->c, "copy-up", NULL), 0);
+	ASSERT_EQ(fstatat(self->c.layers, "rw/upper/file", &st, 0), 0);
+	EXPECT_EQ(st.st_uid, 0);
+	EXPECT_EQ(st.st_gid, 0);
+	ASSERT_EQ(fstatat(self->c.layers, "rw/upper/new", &st, 0), 0);
+	EXPECT_EQ(st.st_uid, 0);
+	EXPECT_EQ(window_ids_below(self->c.layers), 0);
+}
+
+/*
+ * A stacking filesystem stores with the credentials of whoever mounted it, so the
+ * rule goes by the value of the id. Here a file of the lower layer belongs to an
+ * id of the window, and the upper layer is as the host has it.
+ */
+TEST_F(cell, copy_up_stores_no_id_of_the_window)
+{
+	struct stat st;
+	int r, fd;
+
+	r = cell_build(&self->c, &(struct build){ .ids = 65536, .no_seal = true,
+						  .overlay = OVL_LOWER_IDMAPPED });
+	if (r == 22 && sys_fsopen("overlay", FSOPEN_CLOEXEC) < 0)
+		SKIP(return, "no overlayfs");
+	ASSERT_EQ(r, 0);
+	ASSERT_EQ(fstatat(self->c.tree, "data/file", &st, 0), 0);
+	ASSERT_GE(st.st_uid, CELL_WINDOW_FIRST);
+
+	fd = openat(self->c.tree, "data/file", O_WRONLY | O_CLOEXEC);
+	EXPECT_EQ(fd, -1);
+	EXPECT_EQ(errno, EOVERFLOW);
+	EXPECT_EQ(fstatat(self->c.layers, "rw/upper/file", &st, 0), -1);
+	EXPECT_EQ(window_ids_below(self->c.layers), 0);
+
+	/* No cell is made of that to begin with. */
+	EXPECT_EQ(cell_configure(self->c.cfd, CELL_CMD_SEAL, NULL, NULL, 0), -1);
+	EXPECT_EQ(errno, EOVERFLOW);
+}
+
+/* Does a task of the cell with these ids get to open @path? */
+static int opens(struct cellctx *c, const char *path, unsigned int id, unsigned int group,
+		 const char *want)
+{
+	struct pidfd_cred cred = { .uid = id, .gid = id, .ngroups = !!group,
+				   .groups = (unsigned long)&group };
+	int pidfd = prepare(c->cfd, "opens", path, want), st = -99;
+
+	if (pidfd >= 0 &&
+	    !pidfd_configure(pidfd, PIDFD_SET_BINARY, "cred", &cred, sizeof(cred)) &&
+	    !pidfd_configure(pidfd, PIDFD_CMD_START, NULL, NULL, 0))
+		st = task_wait(pidfd);
+	close(pidfd);
+	return st;
+}
+
+#define KVM_GID		36
+
+/*
+ * A device is its number. Whoever builds a cell makes a node for it in the tree of
+ * the cell, and who in the cell may open that is a matter of the ids on disk, which
+ * the idmapping of the tree makes the ids of the cell. So several cells use one
+ * device, each by a node of its own, and none of them has an id of the host's.
+ */
+TEST_F(cell, device_by_a_node_of_its_own)
+{
+	struct cellctx cells[2];
+	struct stat st;
+	int init[2], i;
+
+	for (i = 0; i < 2; i++) {
+		ASSERT_EQ(cell_build(&cells[i], &(struct build){ .ids = 65536 }), 0);
+		/* /dev/null, for want of a /dev/kvm. */
+		ASSERT_EQ(mknodat(cells[i].raw, "kvm", S_IFCHR | 0660, makedev(1, 3)), 0);
+		ASSERT_EQ(fchownat(cells[i].raw, "kvm", 0, KVM_GID, 0), 0);
+		ASSERT_EQ(fchmodat(cells[i].raw, "kvm", 0660, 0), 0);
+		init[i] = spawn(cells[i].cfd, NULL, "pause", NULL, NULL);
+		ASSERT_GE(init[i], 0);
+	}
+	for (i = 0; i < 2; i++) {
+		EXPECT_EQ(opens(&cells[i], "/kvm", 0, 0, "yes"), 0);
+		EXPECT_EQ(opens(&cells[i], "/kvm", 1000, KVM_GID, "yes"), 0);
+		EXPECT_EQ(opens(&cells[i], "/kvm", 1000, 0, "no"), 0);
+		EXPECT_EQ(opens(&cells[i], "/kvm", 1000, KVM_GID + 1, "no"), 0);
+		/* Nothing of the window is on disk. */
+		ASSERT_EQ(fstatat(cells[i].raw, "kvm", &st, 0), 0);
+		EXPECT_EQ(st.st_gid, KVM_GID);
+		close(init[i]);
+		cell_cleanup(&cells[i]);
+	}
+}
+
+/*
+ * The node of the host's own /dev belongs to ids of the host, which nobody in a
+ * cell has, its root included. What is left is what the mode has for everybody.
+ */
+TEST_F(cell, device_by_the_node_of_the_host)
+{
+	struct stat was;
+	int init;
+
+	ASSERT_EQ(stat("/dev/full", &was), 0);
+	ASSERT_EQ(chown("/dev/full", 0, KVM_GID), 0);
+	ASSERT_EQ(chmod("/dev/full", 0660), 0);
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536,
+							.bind_file = "/dev/full" }), 0);
+	init = spawn(self->c.cfd, NULL, "pause", NULL, NULL);
+	ASSERT_GE(init, 0);
+
+	EXPECT_EQ(opens(&self->c, "/bound", 0, 0, "no"), 0);
+	EXPECT_EQ(opens(&self->c, "/bound", 1000, KVM_GID, "no"), 0);
+	ASSERT_EQ(chmod("/dev/full", 0666), 0);
+	EXPECT_EQ(opens(&self->c, "/bound", 1000, 0, "yes"), 0);
+
+	close(init);
+	EXPECT_EQ(chown("/dev/full", was.st_uid, was.st_gid), 0);
+	EXPECT_EQ(chmod("/dev/full", was.st_mode & 07777), 0);
+}
+
+TEST_F(cell, blocks_do_not_overlap)
+{
+	struct cellctx other;
+	long a, b;
+	pid_t pid;
+	int p1, p2;
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536 }), 0);
+	ASSERT_EQ(cell_build(&other, &(struct build){ .ids = 65536 }), 0);
+	p1 = spawn(self->c.cfd, &pid, "pause", NULL, NULL);
+	ASSERT_GE(p1, 0);
+	a = host_uid(pid);
+	p2 = spawn(other.cfd, &pid, "pause", NULL, NULL);
+	ASSERT_GE(p2, 0);
+	b = host_uid(pid);
+
+	EXPECT_GE(a, (long)CELL_WINDOW_FIRST);
+	EXPECT_LE(a, (long)CELL_WINDOW_LAST);
+	EXPECT_EQ(a % 65536, 0);
+	EXPECT_EQ(b % 65536, 0);
+	EXPECT_NE(a, b);
+
+	close(p1);
+	close(p2);
+	cell_cleanup(&other);
+}
+
+/* What cell_info() has for the first id of the block, or -1 if it has nothing. */
+static long ids_first(int cfd)
+{
+	struct cell_info info = { .mask = CELL_INFO_IDS_FIRST };
+
+	if (cell_info(cfd, &info, sizeof(info), 0))
+		return -2;
+	return info.mask & CELL_INFO_IDS_FIRST ? (long)info.ids_first : -1;
+}
+
+/*
+ * The kernel picks the block. Whoever builds the cell can ask which one it was, as
+ * soon as there is one, to say who in the cell is meant where a rule goes by an id:
+ * in a packet filter, in a routing rule.
+ */
+TEST_F(cell, builder_is_told_the_block)
+{
+	unsigned int ids = 65536, one = 1;
+	struct stat st;
+	int cfd, pidfd, status;
+	long first;
+	pid_t pid;
+
+	cfd = cell_create(CELL_SELF, 0);
+	ASSERT_GE(cfd, 0);
+	EXPECT_EQ(ids_first(cfd), -1);
+	ASSERT_EQ(cell_configure(cfd, CELL_SET_BINARY, "ids", &ids, sizeof(ids)), 0);
+	first = ids_first(cfd);
+	EXPECT_GE(first, (long)CELL_WINDOW_FIRST);
+	EXPECT_LE(first, (long)CELL_WINDOW_LAST);
+	EXPECT_EQ(first % 65536, 0);
+
+	/* It is what everything else says, later on. */
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536 }), 0);
+	EXPECT_NE(ids_first(self->c.cfd), first);
+	first = ids_first(self->c.cfd);
+	ASSERT_EQ(stat(self->c.cg, &st), 0);
+	EXPECT_EQ((long)st.st_uid, first);
+	EXPECT_EQ((long)st.st_gid, first);
+	pidfd = spawn(self->c.cfd, &pid, "pause", NULL, NULL);
+	ASSERT_GE(pidfd, 0);
+	EXPECT_EQ(host_uid(pid), first);
+	close(pidfd);
+	close(cfd);
+
+	/* The block goes back with the cell. */
+	ASSERT_EQ(cell_kill(self->c.cfd, 0), 0);
+	cell_wait(self->c.cfd);
+	EXPECT_EQ(ids_first(self->c.cfd), -1);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (!pid) {
+		if (setgroups(0, NULL) || setresgid(1000, 1000, 1000) ||
+		    setresuid(1000, 1000, 1000) || prctl(PR_SET_DUMPABLE, 1, 0, 0, 0))
+			_exit(1);
+		/* One id is no block, and the builder knows its own. */
+		cfd = cell_create(CELL_SELF, 0);
+		if (cfd < 0 || cell_configure(cfd, CELL_SET_BINARY, "ids", &one, sizeof(one)))
+			_exit(2);
+		if (ids_first(cfd) != -1)
+			_exit(3);
+		close(cfd);
+		/* No privilege is needed to be told. */
+		cfd = cell_create(CELL_SELF, 0);
+		if (cfd < 0 || cell_configure(cfd, CELL_SET_BINARY, "ids", &ids, sizeof(ids)))
+			_exit(4);
+		if (ids_first(cfd) < (long)CELL_WINDOW_FIRST)
+			_exit(5);
+		close(cfd);
+		/* But a name for it is: in here there is one for uid 1000 and no other. */
+		if (unshare(CLONE_NEWUSER) || write_file("/proc/self/setgroups", "deny") ||
+		    write_file("/proc/self/uid_map", "1000 1000 1") ||
+		    write_file("/proc/self/gid_map", "1000 1000 1"))
+			_exit(6);
+		cfd = cell_create(CELL_SELF, 0);
+		if (cfd < 0 || cell_configure(cfd, CELL_SET_BINARY, "ids", &ids, sizeof(ids)))
+			_exit(7);
+		_exit(ids_first(cfd) == -1 ? 0 : 8);
+	}
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(WIFEXITED(status) ? WEXITSTATUS(status) : -1, 0);
+}
+
+/* There are only so many blocks, and no one user gets them all. */
+TEST_F(cell, blocks_are_counted)
+{
+	unsigned int ids = 65536;
+	int status;
+	pid_t pid;
+
+	ASSERT_EQ(write_file("/proc/sys/user/max_cell_id_blocks", "1"), 0);
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (!pid) {
+		int a, b;
+
+		/*
+		 * They are counted by user, and a block goes on counting until
+		 * the user namespace it was lent to is freed, some time after
+		 * the cell is dead. So as a user that never had one.
+		 */
+		if (setresgid(54321, 54321, 54321) || setresuid(54321, 54321, 54321))
+			_exit(1);
+		a = cell_create(CELL_SELF, 0);
+		b = cell_create(CELL_SELF, 0);
+		if (a < 0 || b < 0)
+			_exit(2);
+		if (cell_configure(a, CELL_SET_BINARY, "ids", &ids, sizeof(ids)))
+			_exit(3);
+		if (cell_configure(b, CELL_SET_BINARY, "ids", &ids, sizeof(ids)) != -1 ||
+		    errno != ENOSPC)
+			_exit(4);
+		_exit(0);
+	}
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(WIFEXITED(status) ? WEXITSTATUS(status) : -1, 0);
+	ASSERT_EQ(write_file("/proc/sys/user/max_cell_id_blocks", "4095"), 0);
+}
+
+TEST_F(cell, ids_never_reach_a_disk)
+{
+	int pidfd, host, fd;
+
+	/* A filesystem of the host's, wide open, and a way to it past the tree. */
+	fd = new_tmpfs();
+	ASSERT_GE(fd, 0);
+	host = openat(fd, ".", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_GE(host, 0);
+	close(fd);
+	ASSERT_EQ(fchmod(host, 0777), 0);
+	fd = openat(host, "world", O_CREAT | O_WRONLY, 0666);
+	ASSERT_GE(fd, 0);
+	close(fd);
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536 }), 0);
+	pidfd = prepare(self->c.cfd, "dirfd", NULL, NULL);
+	ASSERT_GE(pidfd, 0);
+	ASSERT_EQ(pidfd_configure(pidfd, PIDFD_SET_FD, "3", NULL, host), 0);
+	ASSERT_EQ(pidfd_configure(pidfd, PIDFD_CMD_START, NULL, NULL, 0), 0);
+	EXPECT_EQ(cell_wait(self->c.cfd), 0);
+
+	/* Nor by the hand of the host. */
+	EXPECT_EQ(fchownat(host, "world", CELL_WINDOW_FIRST + 5, -1, 0), -1);
+	EXPECT_EQ(errno, EOVERFLOW);
+	EXPECT_EQ(fchownat(host, "world", -1, CELL_WINDOW_LAST, 0), -1);
+	EXPECT_EQ(errno, EOVERFLOW);
+	EXPECT_EQ(fchownat(host, "world", CELL_WINDOW_FIRST - 1, CELL_WINDOW_FIRST - 1, 0), 0);
+	close(host);
+	close(pidfd);
+}
+
+/* A mount that was idmapped for a cell names its ids, so it holds on to them. */
+TEST_F(cell, idmapped_mount_pins_the_block)
+{
+	struct mount_attr attr = { .attr_set = MOUNT_ATTR_IDMAP };
+	unsigned int ids = 65536;
+	int a, b, mnt, i, ret = -1;
+
+	ASSERT_EQ(write_file("/proc/sys/user/max_cell_id_blocks", "1"), 0);
+	a = cell_create(CELL_SELF, 0);
+	ASSERT_GE(a, 0);
+	ASSERT_EQ(cell_configure(a, CELL_SET_BINARY, "ids", &ids, sizeof(ids)), 0);
+	mnt = new_tmpfs();
+	ASSERT_GE(mnt, 0);
+	attr.userns_fd = a;
+	ASSERT_EQ(sys_mount_setattr(mnt, "", AT_EMPTY_PATH, &attr, sizeof(attr)), 0);
+
+	/* The cell is gone. The mount is not. */
+	ASSERT_EQ(cell_kill(a, 0), 0);
+	close(a);
+	usleep(500000);
+	b = cell_create(CELL_SELF, 0);
+	ASSERT_GE(b, 0);
+	EXPECT_EQ(cell_configure(b, CELL_SET_BINARY, "ids", &ids, sizeof(ids)), -1);
+	EXPECT_EQ(errno, ENOSPC);
+
+	close(mnt);
+	for (i = 0; i < 100 && ret; i++) {
+		usleep(50000);
+		ret = cell_configure(b, CELL_SET_BINARY, "ids", &ids, sizeof(ids));
+	}
+	EXPECT_EQ(ret, 0);
+	close(b);
+	ASSERT_EQ(write_file("/proc/sys/user/max_cell_id_blocks", "4095"), 0);
+}
+
+/* Every capability there is but the one that no cell can have. */
+static __u64 all_caps(void)
+{
+	char buf[16] = {};
+	int fd = open("/proc/sys/kernel/cap_last_cap", O_RDONLY);
+
+	if (fd < 0 || read(fd, buf, sizeof(buf) - 1) <= 0)
+		return 0;
+	close(fd);
+	return ((2ULL << atoi(buf)) - 1) & ~CAP(SETFCAP);
+}
+
+/* A program that is set-uid root and comes with cap_net_raw, for the cell to run. */
+static int add_gain(struct cellctx *c)
+{
+	int fd;
+
+	if (copy_child(c->raw, "gain"))
+		return -1;
+	fd = openat(c->raw, "gain", O_RDONLY);
+	if (fd < 0 || fchmod(fd, 06755) ||
+	    fsetxattr(fd, "security.capability", fscap_v2, sizeof(fscap_v2), 0))
+		return -1;
+	return close(fd);
+}
+
+/* Being uid 0 of a cell comes with nothing. The builder names what it comes with. */
+TEST_F(cell, capabilities_are_what_the_builder_named)
+{
+	__u64 caps[] = {
+		0, CAP(CHOWN), CAP(SETUID) | CAP(SETGID), CAP(SETPCAP) | CAP(CHOWN),
+		CAP(NET_RAW), all_caps(),
+	};
+	struct cellctx c;
+	char hex[32];
+	unsigned int i;
+	int init, pidfd;
+
+	ASSERT_NE(caps[ARRAY_SIZE(caps) - 1], 0);
+	for (i = 0; i < ARRAY_SIZE(caps); i++) {
+		snprintf(hex, sizeof(hex), "%llx", caps[i]);
+		ASSERT_EQ(cell_build(&c, &(struct build){ .ids = 65536, .caps = caps[i] }), 0);
+		ASSERT_EQ(add_gain(&c), 0);
+		pidfd = spawn(c.cfd, NULL, "caps", hex, NULL);
+		ASSERT_GE(pidfd, 0);
+		EXPECT_EQ(cell_wait(c.cfd), 0) {
+			TH_LOG("with %s", hex);
+		}
+		close(pidfd);
+		cell_cleanup(&c);
+	}
+
+	/* For every task that is started, not just the first. */
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536, .caps = CAP(KILL) }), 0);
+	ASSERT_EQ(add_gain(&self->c), 0);
+	init = spawn(self->c.cfd, NULL, "pause", NULL, NULL);
+	ASSERT_GE(init, 0);
+	pidfd = spawn(self->c.cfd, NULL, "caps", "20", NULL);
+	ASSERT_GE(pidfd, 0);
+	EXPECT_EQ(task_wait(pidfd), 0);
+	close(pidfd);
+	close(init);
+}
+
+TEST_F(cell, files_impart_no_privilege)
+{
+	struct stat st;
+	char buf[64];
+	int fd;
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536, .caps = CAP(CHOWN) }), 0);
+	fd = spawn(self->c.cfd, NULL, "setid", NULL, NULL);
+	ASSERT_GE(fd, 0);
+	EXPECT_EQ(cell_wait(self->c.cfd), 0);
+	close(fd);
+
+	/* And this is what the host finds. */
+	ASSERT_EQ(fstatat(self->c.raw, "tmp/a", &st, 0), 0);
+	EXPECT_EQ(st.st_mode & (S_ISUID | S_ISGID), 0);
+	/* On disk the ids of the cell count from 0. No kuid of its block got there. */
+	EXPECT_EQ(st.st_uid, 33);
+	ASSERT_EQ(fstatat(self->c.raw, "su", &st, 0), 0);
+	EXPECT_EQ(st.st_mode & 07777, 0755);
+	EXPECT_EQ(st.st_uid, 0);
+	fd = openat(self->c.raw, "su", O_RDONLY | O_CLOEXEC);
+	ASSERT_GE(fd, 0);
+	EXPECT_EQ(fgetxattr(fd, "security.capability", buf, sizeof(buf)), -1);
+	EXPECT_EQ(errno, ENODATA);
+	close(fd);
+	fd = openat(self->c.raw, "tmp/a", O_RDONLY | O_CLOEXEC);
+	ASSERT_GE(fd, 0);
+	EXPECT_EQ(fgetxattr(fd, "security.capability", buf, sizeof(buf)), -1);
+	EXPECT_EQ(errno, ENODATA);
+	close(fd);
+}
+
+/* The kernel wrote the maps of a cell, once. Nobody writes them again. */
+TEST_F(cell, maps_are_the_kernels)
+{
+	static const char * const maps[] = { "uid_map", "gid_map" };
+	char path[64];
+	unsigned int i;
+	pid_t pid;
+	int p;
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536 }), 0);
+	p = spawn(self->c.cfd, &pid, "pause", NULL, NULL);
+	ASSERT_GE(p, 0);
+	for (i = 0; i < ARRAY_SIZE(maps); i++) {
+		snprintf(path, sizeof(path), "/proc/%d/%s", pid, maps[i]);
+		EXPECT_EQ(write_file(path, "0 0 1"), -1);
+		EXPECT_EQ(errno, EPERM);
+		EXPECT_EQ(write_file(path, "0 100000 65536"), -1);
+		EXPECT_EQ(errno, EPERM);
+	}
+	close(p);
+}
+
+static int mount_source(const char *fstype, const char *source, const char *opt,
+			const char *val)
+{
+	int fs, mnt;
+
+	fs = sys_fsopen(fstype, FSOPEN_CLOEXEC);
+	if (fs < 0)
+		return -1;
+	if (sys_fsconfig(fs, FSCONFIG_SET_STRING, "source", source, 0) ||
+	    (opt && sys_fsconfig(fs, FSCONFIG_SET_STRING, opt, val, 0)) ||
+	    sys_fsconfig(fs, FSCONFIG_CMD_CREATE, NULL, NULL, 0)) {
+		close(fs);
+		return -1;
+	}
+	mnt = sys_fsmount(fs, FSMOUNT_CLOEXEC, 0);
+	close(fs);
+	return mnt;
+}
+
+static int make_su(int dirfd)
+{
+	int fd = openat(dirfd, "su", O_CREAT | O_WRONLY, 0755);
+
+	if (fd < 0 || fchmod(fd, 06755))
+		return -1;
+	close(fd);
+	return 0;
+}
+
+/*
+ * Dropping the bits changes the inode, so on a frozen filesystem the open has to
+ * wait. Needs CELL_TEST_EXT4_IMG to name an ext4 image.
+ */
+TEST_F(cell, drop_privs_waits_for_thaw)
+{
+	const char *img = getenv("CELL_TEST_EXT4_IMG");
+	int ctl, nr, loop, back, mnt, raw, pidfd;
+	struct pollfd pfd;
+	struct stat st;
+	char dev[32];
+
+	if (!img)
+		SKIP(return, "CELL_TEST_EXT4_IMG is not set");
+	ctl = open("/dev/loop-control", O_RDWR | O_CLOEXEC);
+	if (ctl < 0)
+		SKIP(return, "no loop devices");
+	nr = ioctl(ctl, LOOP_CTL_GET_FREE);
+	ASSERT_GE(nr, 0);
+	snprintf(dev, sizeof(dev), "/dev/loop%d", nr);
+	loop = open(dev, O_RDWR | O_CLOEXEC);
+	back = open(img, O_RDWR | O_CLOEXEC);
+	ASSERT_GE(loop, 0);
+	ASSERT_GE(back, 0);
+	ASSERT_EQ(ioctl(loop, LOOP_SET_FD, back), 0);
+
+	mnt = mount_source("ext4", dev, NULL, NULL);
+	ASSERT_GE(mnt, 0);
+	ASSERT_EQ(make_su(mnt), 0);
+	raw = sys_open_tree(mnt, "", AT_EMPTY_PATH | OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC);
+	ASSERT_GE(raw, 0);
+	raw = openat(raw, ".", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_GE(raw, 0);
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536, .data = mnt }), 0);
+	ASSERT_EQ(ioctl(raw, FIFREEZE, 0), 0);
+
+	pidfd = spawn(self->c.cfd, NULL, "data", NULL, NULL);
+	ASSERT_GE(pidfd, 0);
+	pfd = (struct pollfd){ .fd = self->c.cfd, .events = POLLIN };
+	EXPECT_EQ(poll(&pfd, 1, 1500), 0);
+	ASSERT_EQ(fstatat(raw, "su", &st, 0), 0);
+	EXPECT_EQ(st.st_mode & 07777, 06755);
+
+	ASSERT_EQ(ioctl(raw, FITHAW, 0), 0);
+	EXPECT_EQ(cell_wait(self->c.cfd), 0);
+	ASSERT_EQ(fstatat(raw, "su", &st, 0), 0);
+	EXPECT_EQ(st.st_mode & 07777, 0755);
+
+	close(pidfd);
+	close(raw);
+	close(mnt);
+	cell_cleanup(&self->c);
+	self->c.cfd = self->c.tree = self->c.raw = self->c.cgfd = -1;
+	ioctl(loop, LOOP_CLR_FD, 0);
+	close(loop);
+	close(back);
+	close(ctl);
+}
+
+/*
+ * A filesystem with ->atomic_open() opens a file it creates with the directory
+ * locked, a path tmpfs does not have. Needs CELL_TEST_9P_TAG to name a writable
+ * 9p share over virtio.
+ */
+TEST_F(cell, drop_privs_with_atomic_open)
+{
+	const char *tag = getenv("CELL_TEST_9P_TAG");
+	int status;
+	pid_t pid;
+
+	if (!tag)
+		SKIP(return, "CELL_TEST_9P_TAG is not set");
+
+	/* 9p cannot be idmapped, so a one-id cell, so not as root. */
+	ASSERT_EQ(prctl(PR_SET_KEEPCAPS, 1, 0, 0, 0), 0);
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (!pid) {
+		struct __user_cap_header_struct hdr = { .version = _LINUX_CAPABILITY_VERSION_3 };
+		struct __user_cap_data_struct data[2];
+		struct cellctx c;
+		int mnt, pidfd, step;
+
+		mnt = mount_source("9p", tag, "trans", "virtio");
+		if (mnt < 0)
+			_exit(77);
+		if (fchmodat(mnt, "", 0777, AT_EMPTY_PATH) && errno != ENOTSUP && errno != EINVAL)
+			_exit(9);
+		if (chown(CGROOT, 1000, 1000) || chown(CGROOT "/cgroup.procs", 1000, 1000))
+			_exit(10);
+		if (setresgid(1000, 1000, 1000) || setresuid(1000, 1000, 1000))
+			_exit(11);
+		if (syscall(SYS_capget, &hdr, data))
+			_exit(12);
+		data[0].effective = data[0].permitted;
+		data[1].effective = data[1].permitted;
+		if (syscall(SYS_capset, &hdr, data))
+			_exit(13);
+		unlinkat(mnt, "su", 0);
+		if (make_su(mnt))
+			_exit(14);
+
+		step = cell_build(&c, &(struct build){ .ids = 1, .data = mnt });
+		if (step)
+			_exit(20 + step);
+		pidfd = spawn(c.cfd, NULL, "data", "create", NULL);
+		if (pidfd < 0)
+			_exit(15);
+		if (cell_wait(c.cfd))
+			_exit(16);
+		cell_cleanup(&c);
+		_exit(0);
+	}
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(chown(CGROOT, 0, 0), 0);
+	EXPECT_EQ(chown(CGROOT "/cgroup.procs", 0, 0), 0);
+	if (WIFEXITED(status) && WEXITSTATUS(status) == 77)
+		SKIP(return, "cannot mount the 9p share");
+	EXPECT_EQ(WIFEXITED(status) ? WEXITSTATUS(status) : -1, 0);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/cell/cell_life_test.c b/tools/testing/selftests/cell/cell_life_test.c
new file mode 100644
index 000000000000..e00cbacebc49
--- /dev/null
+++ b/tools/testing/selftests/cell/cell_life_test.c
@@ -0,0 +1,446 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Tests for cells, the life of a cell: building one, killing one, handles, and
+ * the races between them.
+ */
+#include "cell_test.h"
+
+TEST_F(cell, life)
+{
+	struct cell_info info = { .mask = ~0ULL };
+	struct pollfd pfd;
+	pid_t pid;
+	int pidfd;
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536, .no_seal = true }), 0);
+	EXPECT_EQ(cell_state(self->c.cfd), CELL_BUILDING);
+
+	/* Not before it is sealed. */
+	EXPECT_EQ(pidfd_open_empty(self->c.cfd, 0), -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	ASSERT_EQ(cell_configure(self->c.cfd, CELL_CMD_SEAL, NULL, NULL, 0), 0);
+	EXPECT_EQ(cell_state(self->c.cfd), CELL_SEALED);
+
+	/* Sealed is sealed. */
+	EXPECT_EQ(cell_configure(self->c.cfd, CELL_SET_STRING, "hostname", "x", 0), -1);
+	EXPECT_EQ(errno, EBUSY);
+	EXPECT_EQ(cell_configure(self->c.cfd, CELL_CMD_SEAL, NULL, NULL, 0), -1);
+	EXPECT_EQ(errno, EBUSY);
+	EXPECT_EQ(cell_open(self->c.cfd, CELL_OPEN_SLOT, "net", NULL, 0), -1);
+	EXPECT_EQ(errno, EBUSY);
+
+	pidfd = spawn(self->c.cfd, &pid, "exit", "7", NULL);
+	ASSERT_GE(pidfd, 0);
+
+	pfd = (struct pollfd){ .fd = self->c.cfd, .events = POLLIN };
+	EXPECT_EQ(poll(&pfd, 1, 10000), 1);
+	EXPECT_EQ(cell_state(self->c.cfd), CELL_DEAD);
+	EXPECT_EQ(cell_wait(self->c.cfd), 7 << 8);
+	/* Repeatable. */
+	EXPECT_EQ(cell_wait(self->c.cfd), 7 << 8);
+
+	ASSERT_EQ(cell_info(self->c.cfd, &info, sizeof(info), 0), 0);
+	EXPECT_NE(info.id, 0);
+	EXPECT_EQ(info.parent_id, 0);
+	EXPECT_EQ(info.ids_count, 65536);
+	EXPECT_EQ(info.exit_status, 7 << 8);
+	EXPECT_NE(info.budget_cgroupid, 0);
+	/* All there is to know, but for the block of ids, which has gone back. */
+	EXPECT_EQ(info.mask, info.supported_mask & ~CELL_INFO_IDS_FIRST);
+
+	/* Nothing goes into a dead cell. */
+	EXPECT_EQ(pidfd_open_empty(self->c.cfd, 0), -1);
+	EXPECT_EQ(errno, ESRCH);
+	EXPECT_EQ(cg_populated(self->c.cg), 0);
+	close(pidfd);
+}
+
+/* A read of the cellfd waits for the end of the cell, if it may. */
+TEST_F(cell, read_waits_for_the_end)
+{
+	int pidfd, status = -1, fl;
+	pid_t pid;
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536 }), 0);
+	pidfd = spawn(self->c.cfd, NULL, "pause", NULL, NULL);
+	ASSERT_GE(pidfd, 0);
+
+	fl = fcntl(self->c.cfd, F_GETFL);
+	ASSERT_EQ(fcntl(self->c.cfd, F_SETFL, fl | O_NONBLOCK), 0);
+	EXPECT_EQ(read(self->c.cfd, &status, sizeof(status)), -1);
+	EXPECT_EQ(errno, EAGAIN);
+	ASSERT_EQ(fcntl(self->c.cfd, F_SETFL, fl), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (!pid) {
+		usleep(200000);
+		_exit(!!cell_kill(self->c.cfd, 0));
+	}
+	/* Not for ever, should it not come. */
+	alarm(20);
+	EXPECT_EQ(read(self->c.cfd, &status, sizeof(status)), sizeof(status));
+	alarm(0);
+	EXPECT_EQ(status, SIGKILL);
+	EXPECT_EQ(cell_state(self->c.cfd), CELL_DEAD);
+	waitpid(pid, NULL, 0);
+	close(pidfd);
+}
+
+TEST_F(cell, bad_arguments)
+{
+	unsigned int ids;
+	char path[64];
+	int cfd;
+
+	EXPECT_EQ(cell_create(CELL_SELF, 1), -1);
+	EXPECT_EQ(errno, EINVAL);
+	EXPECT_EQ(cell_create(0, 0), -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	cfd = cell_create(CELL_SELF, 0);
+	ASSERT_GE(cfd, 0);
+	EXPECT_EQ(fcntl(cfd, F_GETFD) & FD_CLOEXEC, FD_CLOEXEC);
+
+	/* A handle is passed on, not opened again. */
+	snprintf(path, sizeof(path), "/proc/self/fd/%d", cfd);
+	EXPECT_EQ(open(path, O_RDONLY), -1);
+	EXPECT_EQ(errno, ENXIO);
+	EXPECT_EQ(open(path, O_RDWR), -1);
+	EXPECT_EQ(errno, EPERM);
+
+	EXPECT_EQ(cell_configure(cfd, 99, NULL, NULL, 0), -1);
+	EXPECT_EQ(errno, EOPNOTSUPP);
+	EXPECT_EQ(cell_configure(cfd, CELL_SET_STRING, "nonsense", "x", 0), -1);
+	EXPECT_EQ(errno, EINVAL);
+	EXPECT_EQ(cell_configure(cfd, CELL_SET_FD, "root", NULL, cfd), -1);
+	EXPECT_EQ(errno, EINVAL);
+	EXPECT_EQ(cell_configure(0, CELL_CMD_SEAL, NULL, NULL, 0), -1);
+	EXPECT_EQ(errno, EINVAL);
+	ids = 1000;
+	EXPECT_EQ(cell_configure(cfd, CELL_SET_BINARY, "ids", &ids, sizeof(ids)), -1);
+	EXPECT_EQ(errno, EINVAL);
+	ids = 65536;
+	EXPECT_EQ(cell_configure(cfd, CELL_SET_BINARY, "ids", &ids, sizeof(ids)), 0);
+	EXPECT_EQ(cell_configure(cfd, CELL_SET_BINARY, "ids", &ids, sizeof(ids)), -1);
+	EXPECT_EQ(errno, EBUSY);
+	/* No root, no budget. */
+	EXPECT_EQ(cell_configure(cfd, CELL_CMD_SEAL, NULL, NULL, 0), -1);
+	EXPECT_EQ(errno, EINVAL);
+	close(cfd);
+}
+
+TEST_F(cell, kill_while_building)
+{
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536, .no_seal = true }), 0);
+	ASSERT_EQ(cell_kill(self->c.cfd, 0), 0);
+	EXPECT_EQ(cell_state(self->c.cfd), CELL_DEAD);
+	EXPECT_EQ(cell_wait(self->c.cfd), SIGKILL);
+	EXPECT_EQ(cell_configure(self->c.cfd, CELL_CMD_SEAL, NULL, NULL, 0), -1);
+	EXPECT_EQ(errno, EBUSY);
+	/* Idempotent. */
+	EXPECT_EQ(cell_kill(self->c.cfd, 0), 0);
+}
+
+/* What cell_kill() takes, and that it works whatever state the cell is in. */
+TEST_F(cell, kill_in_every_state)
+{
+	struct pollfd pfd;
+	int fd, pidfd;
+
+	EXPECT_EQ(cell_kill(-1, 0), -1);
+	EXPECT_EQ(errno, EBADF);
+	fd = open("/dev/null", O_RDONLY | O_CLOEXEC);
+	ASSERT_GE(fd, 0);
+	EXPECT_EQ(cell_kill(fd, 0), -1);
+	EXPECT_EQ(errno, EINVAL);
+	close(fd);
+
+	/* Sealed, nothing spawned. */
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536 }), 0);
+	EXPECT_EQ(cell_state(self->c.cfd), CELL_SEALED);
+	EXPECT_EQ(cell_kill(self->c.cfd, 1), -1);
+	EXPECT_EQ(errno, EINVAL);
+	EXPECT_EQ(cell_state(self->c.cfd), CELL_SEALED);
+	/* It is a system call of its own and no command of cell_configure(). */
+	EXPECT_EQ(cell_configure(self->c.cfd, 5, NULL, NULL, 0), -1);
+	EXPECT_EQ(errno, EOPNOTSUPP);
+	EXPECT_EQ(cell_state(self->c.cfd), CELL_SEALED);
+	EXPECT_EQ(cell_kill(self->c.cfd, 0), 0);
+	EXPECT_EQ(cell_state(self->c.cfd), CELL_DEAD);
+	/* Dead. */
+	EXPECT_EQ(cell_kill(self->c.cfd, 0), 0);
+	EXPECT_EQ(cell_state(self->c.cfd), CELL_DEAD);
+	cell_cleanup(&self->c);
+
+	/* Running. */
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536 }), 0);
+	pidfd = spawn(self->c.cfd, NULL, "pause", NULL, NULL);
+	ASSERT_GE(pidfd, 0);
+	EXPECT_EQ(cell_state(self->c.cfd), CELL_RUNNING);
+	EXPECT_EQ(cell_kill(self->c.cfd, 0), 0);
+	/* Dying, or dead already. It does not wait. */
+	EXPECT_EQ(cell_kill(self->c.cfd, 0), 0);
+	pfd = (struct pollfd){ .fd = self->c.cfd, .events = POLLIN };
+	EXPECT_EQ(poll(&pfd, 1, 10000), 1);
+	EXPECT_EQ(cell_state(self->c.cfd), CELL_DEAD);
+	close(pidfd);
+}
+
+TEST_F(cell, kill_fork_bomb)
+{
+	int pidfd;
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536 }), 0);
+	ASSERT_EQ(write_file(({ static char p[192];
+				snprintf(p, sizeof(p), "%s/pids.max", self->c.cg); p; }),
+			     "200") == 0 || errno == ENOENT, 1);
+	pidfd = spawn(self->c.cfd, NULL, "forkbomb", NULL, NULL);
+	ASSERT_GE(pidfd, 0);
+	usleep(300000);
+	EXPECT_EQ(cell_state(self->c.cfd), CELL_RUNNING);
+
+	ASSERT_EQ(cell_kill(self->c.cfd, 0), 0);
+	EXPECT_EQ(cell_wait(self->c.cfd), SIGKILL);
+	/* DEAD means gone. */
+	EXPECT_EQ(cg_populated(self->c.cg), 0);
+	close(pidfd);
+}
+
+/* A cell lives for as long as somebody holds a handle on it, and no longer. */
+TEST_F(cell, dies_with_its_last_handle)
+{
+	struct pollfd pfd;
+	int pidfd, second;
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536 }), 0);
+	pidfd = spawn(self->c.cfd, NULL, "pause", NULL, NULL);
+	ASSERT_GE(pidfd, 0);
+	pfd = (struct pollfd){ .fd = pidfd, .events = POLLIN };
+
+	/* Any handle will do, so a cell can be handed on. */
+	second = dup(self->c.cfd);
+	ASSERT_GE(second, 0);
+	close(self->c.cfd);
+	self->c.cfd = -1;
+	EXPECT_EQ(poll(&pfd, 1, 300), 0);
+
+	close(second);
+	EXPECT_EQ(poll(&pfd, 1, 10000), 1);
+	close(pidfd);
+}
+
+/* Whoever made a cell is killed, and had told nobody about it. */
+TEST_F(cell, dies_with_its_maker)
+{
+	char cg[sizeof(self->c.cg)] = {};
+	int p[2], i, populated = -1;
+	pid_t pid;
+
+	ASSERT_EQ(pipe(p), 0);
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (!pid) {
+		struct build b = { .ids = 65536 };
+		struct cellctx c;
+
+		if (cell_build(&c, &b) ||
+		    spawn(c.cfd, NULL, "pause", NULL, NULL) < 0 ||
+		    write(p[1], c.cg, sizeof(c.cg)) != sizeof(c.cg))
+			_exit(1);
+		for (;;)
+			pause();
+	}
+	close(p[1]);
+	ASSERT_EQ(read(p[0], cg, sizeof(cg)), sizeof(cg));
+	close(p[0]);
+	EXPECT_EQ(cg_populated(cg), 1);
+
+	ASSERT_EQ(kill(pid, SIGKILL), 0);
+	ASSERT_EQ(waitpid(pid, NULL, 0), pid);
+	for (i = 0; i < 200 && populated; i++) {
+		usleep(50000);
+		populated = cg_populated(cg);
+	}
+	EXPECT_EQ(populated, 0);
+	for (i = 0; i < 100 && rmdir(cg) && errno == EBUSY; i++)
+		usleep(20000);
+}
+
+/* The name is taken, and there is nothing to fill the slot with yet. */
+TEST_F(cell, spawn_slot_is_reserved)
+{
+	unsigned int one = 1;
+	int cfd;
+
+	cfd = cell_create(CELL_SELF, 0);
+	ASSERT_GE(cfd, 0);
+	EXPECT_EQ(cell_configure(cfd, CELL_SET_FLAG, "spawn", NULL, 0), -1);
+	EXPECT_EQ(errno, EOPNOTSUPP);
+	EXPECT_EQ(cell_configure(cfd, CELL_SET_STRING, "spawn", "yes", 0), -1);
+	EXPECT_EQ(errno, EOPNOTSUPP);
+	EXPECT_EQ(cell_configure(cfd, CELL_SET_BINARY, "spawn", &one, sizeof(one)), -1);
+	EXPECT_EQ(errno, EOPNOTSUPP);
+	EXPECT_EQ(cell_configure(cfd, CELL_SET_FD, "spawn", NULL, cfd), -1);
+	EXPECT_EQ(errno, EOPNOTSUPP);
+	close(cfd);
+}
+
+/*
+ * DEAD means gone. The init of a cell is still on its way out when the kernel
+ * learns of its exit, and the cell must not be reported dead before it is off
+ * the cpu for good: that is when it stops counting for cgroup.events.
+ */
+TEST_F(cell, dead_means_gone)
+{
+	int i, pidfd, early = 0;
+
+	for (i = 0; i < 60; i++) {
+		struct cellctx c;
+
+		ASSERT_EQ(cell_build(&c, &(struct build){ .ids = 65536 }), 0);
+		pidfd = spawn(c.cfd, NULL, "exit", "0", NULL);
+		ASSERT_GE(pidfd, 0);
+		ASSERT_EQ(cell_wait(c.cfd), 0);
+		if (cg_populated(c.cg))
+			early++;
+		close(pidfd);
+		cell_cleanup(&c);
+	}
+	EXPECT_EQ(early, 0);
+}
+
+/* Make and break a good many, so that leaks and races get a chance. */
+TEST_F(cell, churn)
+{
+	int i;
+
+	for (i = 0; i < 40; i++) {
+		struct cellctx c;
+		int pidfd;
+
+		ASSERT_EQ(cell_build(&c, &(struct build){ .ids = 65536 }), 0);
+		pidfd = spawn(c.cfd, NULL, i % 3 ? "pause" : "exit", "0", NULL);
+		ASSERT_GE(pidfd, 0);
+		if (i % 5 == 0) {
+			int second = prepare(c.cfd, "pause", NULL, NULL);
+
+			if (second >= 0)
+				close(second);
+		}
+		close(pidfd);
+		cell_cleanup(&c);
+	}
+}
+
+/* A kill against spawns in flight: whatever got in is gone when it says DEAD. */
+TEST_F(cell, kill_races_with_spawn)
+{
+	int i, j;
+
+	for (i = 0; i < 25; i++) {
+		pid_t spawners[3];
+		struct cellctx c;
+		int pidfd;
+
+		ASSERT_EQ(cell_build(&c, &(struct build){ .ids = 65536 }), 0);
+		pidfd = spawn(c.cfd, NULL, "pause", NULL, NULL);
+		ASSERT_GE(pidfd, 0);
+
+		for (j = 0; j < 3; j++) {
+			spawners[j] = fork();
+			ASSERT_GE(spawners[j], 0);
+			if (!spawners[j]) {
+				for (;;) {
+					int p = j ? spawn(c.cfd, NULL, "pause", NULL, NULL) :
+						    prepare(c.cfd, "pause", NULL, NULL);
+
+					if (p < 0) {
+						_exit(errno == ESRCH || errno == ENOMEM ||
+						      errno == EINTR || errno == EBUSY ?
+						      0 : 1);
+					}
+					close(p);
+				}
+			}
+		}
+		usleep(1000 * (i % 7) * (i % 5));
+		ASSERT_EQ(cell_kill(c.cfd, 0), 0);
+		EXPECT_EQ(cell_wait(c.cfd), SIGKILL);
+		EXPECT_EQ(cg_populated(c.cg), 0);
+		for (j = 0; j < 3; j++) {
+			int status;
+
+			ASSERT_EQ(waitpid(spawners[j], &status, 0), spawners[j]);
+			EXPECT_EQ(status, 0);
+		}
+		EXPECT_EQ(cg_populated(c.cg), 0);
+		close(pidfd);
+		cell_cleanup(&c);
+	}
+}
+
+/* Starting an embryo while its handle goes away, from two processes. */
+TEST_F(cell, start_races_with_close)
+{
+	int i;
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536 }), 0);
+	ASSERT_GE(spawn(self->c.cfd, NULL, "pause", NULL, NULL), 0);
+
+	for (i = 0; i < 60; i++) {
+		int pidfd = prepare(self->c.cfd, "exit", "0", NULL);
+		int status;
+		pid_t pid;
+
+		ASSERT_GE(pidfd, 0);
+		pid = fork();
+		ASSERT_GE(pid, 0);
+		if (!pid) {
+			/* Both hold the one file. Only one start can win. */
+			int r = pidfd_configure(pidfd, PIDFD_CMD_START, NULL, NULL, 0);
+
+			_exit(!r || errno == EBUSY || errno == ESRCH ? 0 : 1);
+		}
+		if (i & 1)
+			pidfd_configure(pidfd, PIDFD_CMD_START, NULL, NULL, 0);
+		close(pidfd);
+		ASSERT_EQ(waitpid(pid, &status, 0), pid);
+		EXPECT_EQ(status, 0);
+	}
+	EXPECT_EQ(cell_state(self->c.cfd), CELL_RUNNING);
+}
+
+/* The last handle going away against everything else. */
+TEST_F(cell, close_races)
+{
+	int i;
+
+	for (i = 0; i < 40; i++) {
+		struct cellctx c;
+		int status;
+		pid_t pid;
+
+		ASSERT_EQ(cell_build(&c, &(struct build){ .ids = 65536,
+							  .no_seal = i % 4 == 0 }), 0);
+		pid = fork();
+		ASSERT_GE(pid, 0);
+		if (!pid) {
+			int p = spawn(c.cfd, NULL, i % 3 ? "pause" : "exit", "0", NULL);
+
+			if (p >= 0)
+				close(p);
+			_exit(0);		/* drops its copy of the handle */
+		}
+		if (i % 2)
+			usleep(500 * (i % 9));
+		close(c.cfd);
+		c.cfd = -1;
+		ASSERT_EQ(waitpid(pid, &status, 0), pid);
+		cell_cleanup(&c);
+		EXPECT_EQ(access(c.cg, F_OK), -1);
+	}
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/cell/cell_net_test.c b/tools/testing/selftests/cell/cell_net_test.c
new file mode 100644
index 000000000000..297469260cba
--- /dev/null
+++ b/tools/testing/selftests/cell/cell_net_test.c
@@ -0,0 +1,915 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cells: the network. It is set up from the outside and handed to the cell, as
+ * the tree is. A cell configures nothing unless it was built to.
+ */
+#include "cell_test.h"
+#include <netinet/in.h>
+#include <linux/if_tun.h>
+#include <linux/if_link.h>
+#include <linux/netlink.h>
+#include <linux/rtnetlink.h>
+#include <linux/veth.h>
+
+#define HOST_IP		0x0a090001	/* 10.9.0.1 */
+#define CELL_IP		0x0a090002
+#define LATER_IP	0x0a090003
+
+static int set_cred(int pidfd, unsigned int id)
+{
+	struct pidfd_cred cred = { .uid = id, .gid = id };
+
+	return pidfd_configure(pidfd, PIDFD_SET_BINARY, "cred", &cred, sizeof(cred));
+}
+
+/* Build a cell, run one thing in it as @id to its end. Returns its status. */
+static int run(const struct build *b, unsigned int id, const char *what, const char *arg)
+{
+	struct cellctx c;
+	int pidfd, st;
+
+	st = cell_build(&c, b);
+	if (st) {
+		cell_cleanup(&c);
+		return -100 - st;
+	}
+	pidfd = prepare(c.cfd, what, arg, NULL);
+	if (pidfd < 0 || (id && set_cred(pidfd, id)) ||
+	    pidfd_configure(pidfd, PIDFD_CMD_START, NULL, NULL, 0))
+		st = -99;
+	else
+		st = cell_wait(c.cfd);
+	close(pidfd);
+	cell_cleanup(&c);
+	return st;
+}
+
+static int dev_up(const char *dev, unsigned int ip)
+{
+	struct ifreq ifr = {};
+	struct sockaddr_in *sin = (void *)&ifr.ifr_addr;
+	int s = socket(AF_INET, SOCK_DGRAM | SOCK_CLOEXEC, 0), r;
+
+	strcpy(ifr.ifr_name, dev);
+	sin->sin_family = AF_INET;
+	sin->sin_addr.s_addr = htonl(ip);
+	r = ioctl(s, SIOCSIFADDR, &ifr);
+	sin->sin_addr.s_addr = htonl(0xffffff00);
+	r = r ?: ioctl(s, SIOCSIFNETMASK, &ifr);
+	r = r ?: ioctl(s, SIOCGIFFLAGS, &ifr);
+	ifr.ifr_flags |= IFF_UP;
+	r = r ?: ioctl(s, SIOCSIFFLAGS, &ifr);
+	r = r ? -errno : 0;
+	close(s);
+	return r;
+}
+
+/* The same in the network namespace @net. Comes back. */
+static int dev_up_in(int net, const char *dev, unsigned int ip)
+{
+	int old = open("/proc/self/ns/net", O_RDONLY | O_CLOEXEC), r;
+
+	if (setns(net, CLONE_NEWNET))
+		return -errno;
+	r = dev_up(dev, ip);
+	if (setns(old, CLONE_NEWNET))
+		return -errno;
+	close(old);
+	return r;
+}
+
+static int sysctl_in(int net, const char *path, const char *val)
+{
+	int old = open("/proc/self/ns/net", O_RDONLY | O_CLOEXEC), r;
+
+	if (setns(net, CLONE_NEWNET))
+		return -errno;
+	r = write_file(path, val) ? -errno : 0;
+	if (setns(old, CLONE_NEWNET))
+		return -errno;
+	close(old);
+	return r;
+}
+
+/* A network namespace of the caller's own making, with nothing done to it. */
+static int make_netns(void)
+{
+	int old = open("/proc/self/ns/net", O_RDONLY | O_CLOEXEC), net;
+
+	if (old < 0 || unshare(CLONE_NEWNET))
+		return -1;
+	net = open("/proc/self/ns/net", O_RDONLY | O_CLOEXEC);
+	if (setns(old, CLONE_NEWNET))
+		return -1;
+	close(old);
+	return net;
+}
+
+static struct rtattr *put_attr(struct nlmsghdr *h, int type, const void *data, int len)
+{
+	struct rtattr *a = (void *)((char *)h + NLMSG_ALIGN(h->nlmsg_len));
+
+	a->rta_type = type;
+	a->rta_len = RTA_LENGTH(len);
+	if (data)
+		memcpy(RTA_DATA(a), data, len);
+	h->nlmsg_len = NLMSG_ALIGN(h->nlmsg_len) + RTA_ALIGN(a->rta_len);
+	return a;
+}
+
+static void end_nest(struct nlmsghdr *h, struct rtattr *a)
+{
+	a->rta_len = (char *)h + NLMSG_ALIGN(h->nlmsg_len) - (char *)a;
+}
+
+/* vh0 here, vc0 in the network namespace @net. */
+static int make_veth(int net)
+{
+	struct sockaddr_nl sa = { .nl_family = AF_NETLINK };
+	struct {
+		struct nlmsghdr h;
+		struct ifinfomsg i;
+		char attrs[256];
+	} req = {};
+	struct rtattr *info, *data, *peer;
+	struct nlmsghdr *h;
+	char buf[1024];
+	int s, n;
+
+	req.h.nlmsg_type = RTM_NEWLINK;
+	req.h.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE | NLM_F_EXCL;
+	req.h.nlmsg_len = NLMSG_LENGTH(sizeof(req.i));
+	put_attr(&req.h, IFLA_IFNAME, "vh0", 4);
+	info = put_attr(&req.h, IFLA_LINKINFO, NULL, 0);
+	put_attr(&req.h, IFLA_INFO_KIND, "veth", 5);
+	data = put_attr(&req.h, IFLA_INFO_DATA, NULL, 0);
+	peer = put_attr(&req.h, VETH_INFO_PEER, NULL, sizeof(struct ifinfomsg));
+	put_attr(&req.h, IFLA_IFNAME, "vc0", 4);
+	put_attr(&req.h, IFLA_NET_NS_FD, &net, sizeof(net));
+	end_nest(&req.h, peer);
+	end_nest(&req.h, data);
+	end_nest(&req.h, info);
+
+	s = socket(AF_NETLINK, SOCK_RAW | SOCK_CLOEXEC, NETLINK_ROUTE);
+	if (s < 0 || sendto(s, &req, req.h.nlmsg_len, 0, (void *)&sa, sizeof(sa)) < 0)
+		return -errno;
+	n = recv(s, buf, sizeof(buf), 0);
+	close(s);
+	h = (void *)buf;
+	if (n < (int)sizeof(*h) || h->nlmsg_type != NLMSG_ERROR)
+		return -EPROTO;
+	return ((struct nlmsgerr *)NLMSG_DATA(h))->error;
+}
+
+/*
+ * Nothing was said about the network, so there is none. What the cell is handed
+ * works all the same: here a socket that listens in the network of the host.
+ */
+TEST_F(cell, no_net_slot_no_network)
+{
+	static const unsigned int ids[] = { 0, 1000 };
+	struct sockaddr_in a = { .sin_family = AF_INET, .sin_port = htons(7778),
+				 .sin_addr = { htonl(INADDR_LOOPBACK) } };
+	int lsock, conn, pidfd, one = 1;
+	unsigned int i;
+	char c = 0;
+
+	ASSERT_EQ(dev_up("lo", INADDR_LOOPBACK), 0);
+	lsock = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
+	setsockopt(lsock, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one));
+	ASSERT_EQ(bind(lsock, (void *)&a, sizeof(a)), 0);
+	ASSERT_EQ(listen(lsock, 1), 0);
+
+	for (i = 0; i < ARRAY_SIZE(ids); i++) {
+		struct cellctx cell;
+
+		ASSERT_EQ(cell_build(&cell, &(struct build){ .ids = 65536 }), 0);
+		pidfd = prepare(cell.cfd, "net-none", NULL, NULL);
+		ASSERT_GE(pidfd, 0);
+		if (ids[i])
+			ASSERT_EQ(set_cred(pidfd, ids[i]), 0);
+		ASSERT_EQ(pidfd_configure(pidfd, PIDFD_SET_FD, "3", NULL, lsock), 0);
+		ASSERT_EQ(pidfd_configure(pidfd, PIDFD_CMD_START, NULL, NULL, 0), 0);
+
+		conn = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
+		ASSERT_EQ(connect(conn, (void *)&a, sizeof(a)), 0);
+		EXPECT_EQ(write(conn, "h", 1), 1);
+		ASSERT_EQ(wait_for(conn, pidfd), 0);
+		EXPECT_EQ(read(conn, &c, 1), 1);
+		EXPECT_EQ(c, 'c');
+		close(conn);
+
+		EXPECT_EQ(cell_wait(cell.cfd), 0);
+		close(pidfd);
+		cell_cleanup(&cell);
+	}
+	close(lsock);
+}
+
+static int seal(int cfd)
+{
+	return cell_configure(cfd, CELL_CMD_SEAL, NULL, NULL, 0);
+}
+
+static int run_sealed(struct cellctx *c, const char *what, const char *arg)
+{
+	int pidfd = spawn(c->cfd, NULL, what, arg, NULL), st;
+
+	if (pidfd < 0)
+		return -99;
+	st = cell_wait(c->cfd);
+	close(pidfd);
+	return st;
+}
+
+/* A seal that fails before there is a network namespace has decided nothing. */
+TEST_F(cell, failed_seal_leaves_the_net_slot_open)
+{
+	char max[32] = {};
+	int fd;
+
+	fd = open("/proc/sys/user/max_net_namespaces", O_RDONLY);
+	ASSERT_GE(fd, 0);
+	ASSERT_GT(read(fd, max, sizeof(max) - 1), 0);
+	close(fd);
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536, .no_seal = true }), 0);
+	ASSERT_EQ(write_file("/proc/sys/user/max_net_namespaces", "0"), 0);
+	EXPECT_EQ(seal(self->c.cfd), -1);
+	EXPECT_EQ(errno, ENOSPC);
+	ASSERT_EQ(write_file("/proc/sys/user/max_net_namespaces", max), 0);
+
+	ASSERT_EQ(cell_configure(self->c.cfd, CELL_SET_STRING, "net", "new", 0), 0);
+	ASSERT_EQ(seal(self->c.cfd), 0);
+	EXPECT_EQ(run_sealed(&self->c, "net-at-all", "yes"), 0);
+}
+
+/* Makes the next seal fail late, with EBUSY: somebody is in the mount namespace. */
+static pid_t sit_in(int rootfd)
+{
+	int ready[2];
+	pid_t pid;
+	char c;
+
+	if (pipe2(ready, O_CLOEXEC))
+		return -1;
+	pid = fork();
+	if (!pid) {
+		if (setns(rootfd, CLONE_NEWNS) || write(ready[1], "r", 1) != 1)
+			_exit(1);
+		for (;;)
+			pause();
+	}
+	close(ready[1]);
+	if (read(ready[0], &c, 1) != 1)
+		pid = -1;
+	close(ready[0]);
+	return pid;
+}
+
+static int seal_once_free(int cfd, pid_t sitter)
+{
+	int i, r = -1;
+
+	kill(sitter, SIGKILL);
+	waitpid(sitter, NULL, 0);
+	for (i = 0; i < 100 && (r = seal(cfd)) && errno == EBUSY; i++)
+		usleep(20000);
+	return r;
+}
+
+/* One that fails later has filled the slot in. No network is what it stays. */
+TEST_F(cell, failed_seal_then_still_no_network)
+{
+	pid_t sitter;
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536, .no_seal = true,
+							.keep_root = true }), 0);
+	sitter = sit_in(self->c.rootfd);
+	ASSERT_GT(sitter, 0);
+	EXPECT_EQ(seal(self->c.cfd), -1);
+	EXPECT_EQ(errno, EBUSY);
+	EXPECT_EQ(cell_configure(self->c.cfd, CELL_SET_STRING, "net", "new", 0), -1);
+	EXPECT_EQ(errno, EBUSY);
+	ASSERT_EQ(seal_once_free(self->c.cfd, sitter), 0);
+	EXPECT_EQ(run_sealed(&self->c, "net-at-all", "no"), 0);
+}
+
+/* Unless the builder asks for it after all, to set it up. */
+TEST_F(cell, failed_seal_then_a_network_after_all)
+{
+	pid_t sitter;
+	int net;
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536, .no_seal = true,
+							.keep_root = true }), 0);
+	sitter = sit_in(self->c.rootfd);
+	ASSERT_GT(sitter, 0);
+	EXPECT_EQ(seal(self->c.cfd), -1);
+	EXPECT_EQ(errno, EBUSY);
+	net = cell_open(self->c.cfd, CELL_OPEN_SLOT, "net", NULL, 0);
+	ASSERT_GE(net, 0);
+	ASSERT_EQ(dev_up_in(net, "lo", INADDR_LOOPBACK), 0);
+	close(net);
+	ASSERT_EQ(seal_once_free(self->c.cfd, sitter), 0);
+	EXPECT_EQ(run_sealed(&self->c, "net-lo", NULL), 0);
+}
+
+/* "new" is one for whoever builds the cell to set up. Until then there is little to it. */
+TEST_F(cell, new_net_is_the_builders_to_set_up)
+{
+	int net, pidfd;
+
+	EXPECT_EQ(run(&(struct build){ .ids = 65536, .net_str = "new" }, 0, "net-bare", NULL), 0);
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536, .net_str = "new",
+							.no_seal = true }), 0);
+	net = cell_open(self->c.cfd, CELL_OPEN_SLOT, "net", NULL, 0);
+	ASSERT_GE(net, 0);
+	ASSERT_EQ(dev_up_in(net, "lo", INADDR_LOOPBACK), 0);
+	ASSERT_EQ(cell_configure(self->c.cfd, CELL_CMD_SEAL, NULL, NULL, 0), 0);
+	pidfd = spawn(self->c.cfd, NULL, "net-lo", NULL, NULL);
+	ASSERT_GE(pidfd, 0);
+	EXPECT_EQ(cell_wait(self->c.cfd), 0);
+	close(pidfd);
+	close(net);
+}
+
+/*
+ * What an orchestrator does: it makes the network namespace, puts one end of a
+ * veth pair in there, gives it an address, and goes on owning all of it. The cell
+ * uses it, and its root can change nothing about it.
+ */
+TEST_F(cell, net_is_set_up_from_the_outside)
+{
+	struct sockaddr_in a = { .sin_family = AF_INET, .sin_port = htons(7777),
+				 .sin_addr = { htonl(HOST_IP) } };
+	int net, lsock, conn, up[2], down[2], pidfd, one = 1, r;
+	char c = 0;
+
+	net = make_netns();
+	ASSERT_GE(net, 0);
+	r = make_veth(net);
+	if (r == -EOPNOTSUPP) {
+		close(net);
+		SKIP(return, "no veth");
+	}
+	ASSERT_EQ(r, 0);
+	ASSERT_EQ(dev_up("vh0", HOST_IP), 0);
+	ASSERT_EQ(dev_up_in(net, "lo", INADDR_LOOPBACK), 0);
+	ASSERT_EQ(dev_up_in(net, "vc0", CELL_IP), 0);
+
+	lsock = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
+	setsockopt(lsock, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one));
+	ASSERT_EQ(bind(lsock, (void *)&a, sizeof(a)), 0);
+	ASSERT_EQ(listen(lsock, 1), 0);
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536, .net = net }), 0);
+	ASSERT_EQ(pipe2(up, O_CLOEXEC), 0);
+	ASSERT_EQ(pipe2(down, O_CLOEXEC), 0);
+	pidfd = prepare(self->c.cfd, "net-given", NULL, NULL);
+	ASSERT_GE(pidfd, 0);
+	ASSERT_EQ(pidfd_configure(pidfd, PIDFD_SET_FD, "3", NULL, up[1]), 0);
+	ASSERT_EQ(pidfd_configure(pidfd, PIDFD_SET_FD, "4", NULL, down[0]), 0);
+	ASSERT_EQ(pidfd_configure(pidfd, PIDFD_CMD_START, NULL, NULL, 0), 0);
+
+	ASSERT_EQ(wait_for(lsock, pidfd), 0);
+	conn = accept(lsock, NULL, NULL);
+	ASSERT_GE(conn, 0);
+	ASSERT_EQ(wait_for(conn, pidfd), 0);
+	EXPECT_EQ(read(conn, &c, 1), 1);
+	EXPECT_EQ(c, 'c');
+	EXPECT_EQ(write(conn, "h", 1), 1);
+
+	/* The cell is running. Whoever owns the namespace still gets at it. */
+	ASSERT_EQ(wait_for(up[0], pidfd), 0);
+	ASSERT_EQ(read(up[0], &c, 1), 1);
+	EXPECT_EQ(cell_state(self->c.cfd), CELL_RUNNING);
+	EXPECT_EQ(dev_up_in(net, "lo", LATER_IP), 0);
+	ASSERT_EQ(write(down[1], "g", 1), 1);
+
+	EXPECT_EQ(cell_wait(self->c.cfd), 0);
+	close(pidfd);
+	close(conn);
+	close(lsock);
+	close(net);
+}
+
+/* That of the host is no different: it is there to be used. */
+TEST_F(cell, host_net_is_used_and_not_configured)
+{
+	int net = open("/proc/self/ns/net", O_RDONLY | O_CLOEXEC);
+
+	ASSERT_GE(net, 0);
+	ASSERT_EQ(dev_up("lo", INADDR_LOOPBACK), 0);
+	EXPECT_EQ(run(&(struct build){ .ids = 65536, .net = net }, 0, "net-lo", NULL), 0);
+	close(net);
+}
+
+/* What a pod expects takes no capability: it is set on the network namespace. */
+TEST_F(cell, low_ports_and_ping_are_settings)
+{
+	static const unsigned int ids[] = { 0, 1000 };
+	unsigned int i;
+	int net;
+
+	net = make_netns();
+	ASSERT_GE(net, 0);
+	ASSERT_EQ(dev_up_in(net, "lo", INADDR_LOOPBACK), 0);
+	for (i = 0; i < ARRAY_SIZE(ids); i++) {
+		EXPECT_EQ(run(&(struct build){ .ids = 65536, .net = net }, ids[i],
+			      "net-settings", "before"), 0);
+	}
+
+	ASSERT_EQ(sysctl_in(net, "/proc/sys/net/ipv4/ip_unprivileged_port_start", "0"), 0);
+	ASSERT_EQ(sysctl_in(net, "/proc/sys/net/ipv4/ping_group_range", "0 4294967294"), 0);
+	for (i = 0; i < ARRAY_SIZE(ids); i++) {
+		EXPECT_EQ(run(&(struct build){ .ids = 65536, .net = net }, ids[i],
+			      "net-settings", "after"), 0);
+	}
+	close(net);
+}
+
+/* Is there a device of that name in the network namespace? -1 if it cannot be entered. */
+static int dev_in(int net, const char *dev)
+{
+	int status;
+	pid_t pid;
+
+	pid = fork();
+	if (!pid) {
+		if (setns(net, CLONE_NEWNET))
+			_exit(2);
+		_exit(!!if_nametoindex(dev));
+	}
+	if (pid < 0 || waitpid(pid, &status, 0) != pid || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) > 1)
+		return -1;
+	return WEXITSTATUS(status);
+}
+
+/* A network namespace is taken apart in its own time. */
+static bool dev_goes(const char *dev)
+{
+	int i;
+
+	for (i = 0; i < 100 && if_nametoindex(dev); i++)
+		usleep(100000);
+	return !if_nametoindex(dev);
+}
+
+/*
+ * A cell that dies takes its network along: it lets go of the namespace, and that is
+ * the end of whatever is in there.
+ *
+ * Sealed is sealed, so the namespace is not to be had from the cell later on. Whoever
+ * wants to take the network apart in an orderly way keeps the file from when the cell
+ * was built. The namespace is then there for as long as that file is, with all that is
+ * in it and nobody left to use it.
+ */
+TEST_F(cell, net_goes_with_the_cell)
+{
+	struct cellctx c;
+	int net, pidfd, r;
+
+	/* Nobody has kept anything. */
+	ASSERT_EQ(cell_build(&c, &(struct build){ .ids = 65536, .no_seal = true,
+						  .net_str = "new" }), 0);
+	net = cell_open(c.cfd, CELL_OPEN_SLOT, "net", NULL, 0);
+	ASSERT_GE(net, 0);
+	r = make_veth(net);
+	close(net);
+	if (r == -EOPNOTSUPP) {
+		cell_cleanup(&c);
+		SKIP(return, "no veth");
+	}
+	ASSERT_EQ(r, 0);
+	ASSERT_EQ(seal(c.cfd), 0);
+	pidfd = spawn(c.cfd, NULL, "pause", NULL, NULL);
+	ASSERT_GE(pidfd, 0);
+	EXPECT_NE(if_nametoindex("vh0"), 0);
+	ASSERT_EQ(cell_kill(c.cfd, 0), 0);
+	EXPECT_EQ(cell_wait(c.cfd), SIGKILL);
+	close(pidfd);
+	/* The cellfd is still open. It does not hold on to anything. */
+	EXPECT_TRUE(dev_goes("vh0"));
+	cell_cleanup(&c);
+
+	/* Somebody has kept the file. */
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536, .no_seal = true,
+							.net_str = "new" }), 0);
+	net = cell_open(self->c.cfd, CELL_OPEN_SLOT, "net", NULL, 0);
+	ASSERT_GE(net, 0);
+	ASSERT_EQ(make_veth(net), 0);
+	ASSERT_EQ(seal(self->c.cfd), 0);
+	EXPECT_EQ(cell_open(self->c.cfd, CELL_OPEN_SLOT, "net", NULL, 0), -1);
+	EXPECT_EQ(errno, EBUSY);
+	pidfd = spawn(self->c.cfd, NULL, "pause", NULL, NULL);
+	ASSERT_GE(pidfd, 0);
+	EXPECT_EQ(cell_open(self->c.cfd, CELL_OPEN_SLOT, "net", NULL, 0), -1);
+	EXPECT_EQ(errno, EBUSY);
+	ASSERT_EQ(cell_kill(self->c.cfd, 0), 0);
+	EXPECT_EQ(cell_wait(self->c.cfd), SIGKILL);
+	close(pidfd);
+	EXPECT_EQ(cell_open(self->c.cfd, CELL_OPEN_SLOT, "net", NULL, 0), -1);
+	EXPECT_EQ(errno, EBUSY);
+
+	/* Long enough for it to have gone, if it were going to. */
+	usleep(500000);
+	EXPECT_EQ(dev_in(net, "vc0"), 1);
+	EXPECT_NE(if_nametoindex("vh0"), 0);
+
+	close(net);
+	EXPECT_TRUE(dev_goes("vh0"));
+}
+
+#define NET_CAPS	(CAP(NET_ADMIN) | CAP(NET_RAW) | CAP(NET_BIND_SERVICE))
+#define ALL_RIGHTS	((CELL_NET_RAW << 1) - 1)
+
+static int run_rights(__u64 rights, __u64 caps, unsigned int id)
+{
+	struct build b = { .ids = 65536, .net_str = "new", .caps = caps, .net_rights = rights,
+			   .tun = true };
+	char hex[32];
+
+	snprintf(hex, sizeof(hex), "%llx", rights);
+	return run(&b, id, "net-rights", hex);
+}
+
+/*
+ * The network namespace of a cell is never the cell's, so no capability of a task of
+ * the cell counts for it. What such a task may do to it all the same, the builder
+ * names, one thing at a time.
+ */
+TEST_F(cell, net_rights_are_what_the_builder_named)
+{
+	__u64 right;
+
+	EXPECT_EQ(run_rights(0, NET_CAPS, 0), 0);
+	for (right = 1; right <= CELL_NET_RAW; right <<= 1) {
+		EXPECT_EQ(run_rights(right, NET_CAPS, 0), 0) {
+			TH_LOG("with %llx", right);
+		}
+	}
+	EXPECT_EQ(run_rights(ALL_RIGHTS, NET_CAPS, 0), 0);
+}
+
+/* The right says what, the capability says who in the cell. It takes both. */
+TEST_F(cell, net_rights_are_for_who_has_the_capability)
+{
+	EXPECT_EQ(run_rights(ALL_RIGHTS, 0, 0), 0);
+	EXPECT_EQ(run_rights(ALL_RIGHTS, CAP(NET_ADMIN), 0), 0);
+	EXPECT_EQ(run_rights(ALL_RIGHTS, CAP(NET_RAW), 0), 0);
+	/* Somebody else in there, who has left them behind with uid 0. */
+	EXPECT_EQ(run_rights(ALL_RIGHTS, NET_CAPS, 1000), 0);
+}
+
+/* What the "net-rights" slot takes, and from whom. */
+TEST_F(cell, net_rights_slot)
+{
+	struct cell_info info = { .mask = CELL_INFO_NET_RIGHTS };
+	__u64 rights[2] = { CELL_NET_LINK | CELL_NET_ADDR, 0 };
+	int cfd, status;
+	pid_t pid;
+
+	cfd = cell_create(CELL_SELF, 0);
+	ASSERT_GE(cfd, 0);
+	/* Rights over what? */
+	EXPECT_EQ(cell_configure(cfd, CELL_SET_BINARY, "net-rights", rights, 8), -1);
+	EXPECT_EQ(errno, EINVAL);
+	ASSERT_EQ(cell_configure(cfd, CELL_SET_STRING, "net", "new", 0), 0);
+	EXPECT_EQ(cell_configure(cfd, CELL_SET_BINARY, "net-rights", rights, 4), -1);
+	EXPECT_EQ(errno, EINVAL);
+	EXPECT_EQ(cell_configure(cfd, CELL_SET_BINARY, "net-rights", rights, 16), -1);
+	EXPECT_EQ(errno, EINVAL);
+	EXPECT_EQ(cell_configure(cfd, CELL_SET_BINARY, "net-rights", (void *)1, 8), -1);
+	EXPECT_EQ(errno, EFAULT);
+	rights[1] = CELL_NET_RAW << 1;
+	EXPECT_EQ(cell_configure(cfd, CELL_SET_BINARY, "net-rights", &rights[1], 8), -1);
+	EXPECT_EQ(errno, EINVAL);
+	ASSERT_EQ(cell_info(cfd, &info, sizeof(info), 0), 0);
+	EXPECT_EQ(info.mask, CELL_INFO_NET_RIGHTS);
+	EXPECT_EQ(info.net_rights, 0);
+
+	/* The last word counts. */
+	rights[1] = ALL_RIGHTS;
+	EXPECT_EQ(cell_configure(cfd, CELL_SET_BINARY, "net-rights", &rights[1], 8), 0);
+	EXPECT_EQ(cell_configure(cfd, CELL_SET_BINARY, "net-rights", rights, 8), 0);
+	ASSERT_EQ(cell_info(cfd, &info, sizeof(info), 0), 0);
+	EXPECT_EQ(info.net_rights, rights[0]);
+	close(cfd);
+
+	/* Until the seal. */
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536, .net_str = "new",
+							.net_rights = rights[0] }), 0);
+	EXPECT_EQ(cell_configure(self->c.cfd, CELL_SET_BINARY, "net-rights", &rights[1], 8), -1);
+	EXPECT_EQ(errno, EBUSY);
+
+	/* There used to be a network namespace that the cell owns. */
+	cfd = cell_create(CELL_SELF, 0);
+	ASSERT_GE(cfd, 0);
+	EXPECT_EQ(cell_configure(cfd, CELL_SET_STRING, "net", "own", 0), -1);
+	EXPECT_EQ(errno, EINVAL);
+	close(cfd);
+
+	/* Nobody hands out what is not theirs to do. */
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (!pid) {
+		__u64 raw = CELL_NET_RAW, none = 0;
+
+		if (setgroups(0, NULL) || setresgid(1000, 1000, 1000) ||
+		    setresuid(1000, 1000, 1000) || prctl(PR_SET_DUMPABLE, 1, 0, 0, 0))
+			_exit(1);
+		/* This one belongs to the user namespace of the host, where it is nobody. */
+		cfd = cell_create(CELL_SELF, 0);
+		if (cfd < 0 || cell_configure(cfd, CELL_SET_STRING, "net", "new", 0))
+			_exit(2);
+		if (!cell_configure(cfd, CELL_SET_BINARY, "net-rights", rights, 8) ||
+		    errno != EPERM)
+			_exit(3);
+		if (!cell_configure(cfd, CELL_SET_BINARY, "net-rights", &raw, 8) || errno != EPERM)
+			_exit(4);
+		if (cell_configure(cfd, CELL_SET_BINARY, "net-rights", &none, 8))
+			_exit(5);
+		close(cfd);
+		/* And this one to a user namespace of its own. */
+		if (unshare(CLONE_NEWUSER) || write_file("/proc/self/setgroups", "deny") ||
+		    write_file("/proc/self/uid_map", "1000 1000 1") ||
+		    write_file("/proc/self/gid_map", "1000 1000 1"))
+			_exit(6);
+		cfd = cell_create(CELL_SELF, 0);
+		if (cfd < 0 || cell_configure(cfd, CELL_SET_STRING, "net", "new", 0))
+			_exit(7);
+		_exit(cell_configure(cfd, CELL_SET_BINARY, "net-rights", &rights[1], 8) ? 8 : 0);
+	}
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(WIFEXITED(status) ? WEXITSTATUS(status) : -1, 0);
+}
+
+/* They are rights over the network of the cell, and over no other. */
+TEST_F(cell, net_rights_end_at_the_network_of_the_cell)
+{
+	int inet, rtnl, pidfd;
+
+	inet = socket(AF_INET, SOCK_DGRAM | SOCK_CLOEXEC, 0);
+	rtnl = socket(AF_NETLINK, SOCK_RAW | SOCK_CLOEXEC, NETLINK_ROUTE);
+	ASSERT_GE(inet, 0);
+	ASSERT_GE(rtnl, 0);
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536, .net_str = "new",
+							.caps = NET_CAPS, .tun = true,
+							.net_rights = ALL_RIGHTS }), 0);
+	pidfd = prepare(self->c.cfd, "net-foreign", NULL, NULL);
+	ASSERT_GE(pidfd, 0);
+	ASSERT_EQ(pidfd_configure(pidfd, PIDFD_SET_FD, "3", NULL, inet), 0);
+	ASSERT_EQ(pidfd_configure(pidfd, PIDFD_SET_FD, "4", NULL, rtnl), 0);
+	ASSERT_EQ(pidfd_configure(pidfd, PIDFD_CMD_START, NULL, NULL, 0), 0);
+	EXPECT_EQ(cell_wait(self->c.cfd), 0);
+	close(pidfd);
+	close(inet);
+	close(rtnl);
+}
+
+/* Nor does a device leave for another, or come to be there. */
+TEST_F(cell, net_rights_move_nothing_out)
+{
+	int net, r;
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536, .no_seal = true,
+							.net_str = "new", .caps = NET_CAPS,
+							.net_rights = ALL_RIGHTS }), 0);
+	net = cell_open(self->c.cfd, CELL_OPEN_SLOT, "net", NULL, 0);
+	ASSERT_GE(net, 0);
+	r = make_veth(net);
+	close(net);
+	if (r == -EOPNOTSUPP)
+		SKIP(return, "no veth");
+	ASSERT_EQ(r, 0);
+	ASSERT_EQ(seal(self->c.cfd), 0);
+	r = spawn(self->c.cfd, NULL, "net-no-way-out", "vc0", NULL);
+	ASSERT_GE(r, 0);
+	EXPECT_EQ(cell_wait(self->c.cfd), 0);
+	close(r);
+	EXPECT_EQ(if_nametoindex("esc0"), 0);
+	EXPECT_EQ(if_nametoindex("vc0"), 0);
+}
+
+/* The builder hands it a device and the right to run it. The rest is up to the cell. */
+TEST_F(cell, net_rights_run_a_device_that_was_handed_over)
+{
+	char hex[32];
+	int net, r;
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536, .no_seal = true,
+							.net_str = "new", .caps = NET_CAPS,
+							.net_rights = CELL_NET_LINK |
+								      CELL_NET_ADDR }), 0);
+	net = cell_open(self->c.cfd, CELL_OPEN_SLOT, "net", NULL, 0);
+	ASSERT_GE(net, 0);
+	r = make_veth(net);
+	close(net);
+	if (r == -EOPNOTSUPP)
+		SKIP(return, "no veth");
+	ASSERT_EQ(r, 0);
+	ASSERT_EQ(seal(self->c.cfd), 0);
+	snprintf(hex, sizeof(hex), "%llx", CELL_NET_LINK | CELL_NET_ADDR);
+	r = spawn(self->c.cfd, NULL, "net-rights", hex, "vc0");
+	ASSERT_GE(r, 0);
+	EXPECT_EQ(cell_wait(self->c.cfd), 0);
+	close(r);
+}
+
+/*
+ * A network namespace that was made for a cell is not the cell's, so who owns it
+ * may enter it whatever the cell is up to, and may share it with another cell.
+ */
+TEST_F(cell, new_net_belongs_to_the_builder)
+{
+	int net, old, other, pidfd;
+	char path[64];
+	pid_t pid;
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536, .net_str = "new" }), 0);
+	pidfd = spawn(self->c.cfd, &pid, "pause", NULL, NULL);
+	ASSERT_GE(pidfd, 0);
+	snprintf(path, sizeof(path), "/proc/%d/ns/net", pid);
+	net = open(path, O_RDONLY | O_CLOEXEC);
+	ASSERT_GE(net, 0);
+
+	old = open("/proc/self/ns/net", O_RDONLY | O_CLOEXEC);
+	EXPECT_EQ(setns(net, CLONE_NEWNET), 0);
+	ASSERT_EQ(setns(old, CLONE_NEWNET), 0);
+	close(old);
+
+	other = cell_create(CELL_SELF, 0);
+	ASSERT_GE(other, 0);
+	EXPECT_EQ(cell_configure(other, CELL_SET_FD, "net", NULL, net), 0);
+	close(other);
+	close(net);
+	close(pidfd);
+}
+
+/* A builder without privilege works in a user namespace of its own, which owns it. */
+TEST_F(cell, unprivileged_builder_sets_up_the_net)
+{
+	int status;
+	pid_t pid;
+
+	ASSERT_EQ(chown(CGROOT, 1000, 1000), 0);
+	ASSERT_EQ(chown(CGROOT "/cgroup.procs", 1000, 1000), 0);
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (!pid) {
+		struct cellctx c;
+		pid_t helper;
+		int step, net;
+
+		if (setgroups(0, NULL) || setresgid(1000, 1000, 1000) ||
+		    setresuid(1000, 1000, 1000) || prctl(PR_SET_DUMPABLE, 1, 0, 0, 0))
+			_exit(1);
+		if (unshare(CLONE_NEWUSER | CLONE_NEWNS))
+			_exit(2);
+		if (write_file("/proc/self/setgroups", "deny") ||
+		    write_file("/proc/self/uid_map", "1000 1000 1") ||
+		    write_file("/proc/self/gid_map", "1000 1000 1"))
+			_exit(3);
+		step = cell_build(&c, &(struct build){ .ids = 1, .no_seal = true });
+		if (step)
+			_exit(20 + step);
+		net = cell_open(c.cfd, CELL_OPEN_SLOT, "net", NULL, 0);
+		if (net < 0)
+			_exit(4);
+		/* There is no way back to the network namespace of the host. */
+		helper = fork();
+		if (!helper)
+			_exit(setns(net, CLONE_NEWNET) || dev_up("lo", INADDR_LOOPBACK) ? 1 : 0);
+		if (waitpid(helper, &step, 0) != helper || step)
+			_exit(5);
+		if (cell_configure(c.cfd, CELL_CMD_SEAL, NULL, NULL, 0))
+			_exit(6);
+		if (spawn(c.cfd, NULL, "net-lo", NULL, NULL) < 0)
+			_exit(7);
+		_exit(cell_wait(c.cfd) ? 8 : 0);
+	}
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(WIFEXITED(status) ? WEXITSTATUS(status) : -1, 0);
+	EXPECT_EQ(chown(CGROOT, 0, 0), 0);
+	EXPECT_EQ(chown(CGROOT "/cgroup.procs", 0, 0), 0);
+}
+
+#define TUN_NODE	"/tmp/cell-test-tun"
+
+/* A persistent tap device in the network namespace of the caller. -1: nobody's. */
+static int make_tap(const char *dev, long long uid, long long gid)
+{
+	struct ifreq ifr = { .ifr_flags = IFF_TAP | IFF_NO_PI };
+	int fd = open(TUN_NODE, O_RDWR | O_CLOEXEC), r = 0;
+
+	if (fd < 0)
+		return -errno;
+	strcpy(ifr.ifr_name, dev);
+	if (ioctl(fd, TUNSETIFF, &ifr) ||
+	    (uid >= 0 && ioctl(fd, TUNSETOWNER, (unsigned long)uid)) ||
+	    (gid >= 0 && ioctl(fd, TUNSETGROUP, (unsigned long)gid)) ||
+	    ioctl(fd, TUNSETPERSIST, 1))
+		r = -errno;
+	close(fd);
+	return r;
+}
+
+/* A cell of one id runs on the uid of its maker. What is the maker's is not the cell's. */
+TEST_F(cell, tun_device_of_the_maker_is_not_the_cells)
+{
+	int status;
+	pid_t pid;
+
+	unlink(TUN_NODE);
+	ASSERT_EQ(mknod(TUN_NODE, S_IFCHR | 0666, makedev(10, 200)), 0);
+	ASSERT_EQ(chmod(TUN_NODE, 0666), 0);
+	status = open(TUN_NODE, O_RDWR | O_CLOEXEC);
+	if (status < 0) {
+		unlink(TUN_NODE);
+		SKIP(return, "no tun");
+	}
+	close(status);
+	ASSERT_EQ(chown(CGROOT, 1000, 1000), 0);
+	ASSERT_EQ(chown(CGROOT "/cgroup.procs", 1000, 1000), 0);
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (!pid) {
+		struct cellctx c;
+		pid_t helper;
+		int step, net;
+
+		if (setgroups(0, NULL) || setresgid(1000, 1000, 1000) ||
+		    setresuid(1000, 1000, 1000) || prctl(PR_SET_DUMPABLE, 1, 0, 0, 0))
+			_exit(1);
+		if (unshare(CLONE_NEWUSER | CLONE_NEWNS))
+			_exit(2);
+		if (write_file("/proc/self/setgroups", "deny") ||
+		    write_file("/proc/self/uid_map", "1000 1000 1") ||
+		    write_file("/proc/self/gid_map", "1000 1000 1"))
+			_exit(3);
+		step = cell_build(&c, &(struct build){ .ids = 1, .no_seal = true,
+						       .bind_file = TUN_NODE });
+		if (step)
+			_exit(20 + step);
+		net = cell_open(c.cfd, CELL_OPEN_SLOT, "net", NULL, 0);
+		if (net < 0)
+			_exit(4);
+		helper = fork();
+		if (!helper)
+			_exit(setns(net, CLONE_NEWNET) || make_tap("tapu", 1000, -1) ||
+			      make_tap("tapg", -1, 1000) || make_tap("tapn", -1, -1) ? 1 : 0);
+		if (waitpid(helper, &step, 0) != helper || step)
+			_exit(5);
+		if (cell_configure(c.cfd, CELL_CMD_SEAL, NULL, NULL, 0))
+			_exit(6);
+		if (spawn(c.cfd, NULL, "tun-owner", NULL, NULL) < 0)
+			_exit(7);
+		_exit(cell_wait(c.cfd) ? 8 : 0);
+	}
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(WIFEXITED(status) ? WEXITSTATUS(status) : -1, 0);
+	EXPECT_EQ(chown(CGROOT, 0, 0), 0);
+	EXPECT_EQ(chown(CGROOT "/cgroup.procs", 0, 0), 0);
+	unlink(TUN_NODE);
+}
+
+/* An owner counts in the cell that named it, and in no other. Not even if it was meant to. */
+TEST_F(cell, tun_owner_counts_within_a_cell)
+{
+	struct cell_info info = { .mask = CELL_INFO_IDS_FIRST };
+	int net, old, r;
+
+	unlink(TUN_NODE);
+	ASSERT_EQ(mknod(TUN_NODE, S_IFCHR | 0666, makedev(10, 200)), 0);
+	r = open(TUN_NODE, O_RDWR | O_CLOEXEC);
+	if (r < 0) {
+		unlink(TUN_NODE);
+		SKIP(return, "no tun");
+	}
+	close(r);
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536, .no_seal = true, .tun = true,
+							.net_str = "new",
+							.caps = CAP(NET_ADMIN) | CAP(SETUID) |
+								CAP(SETGID),
+							.net_rights = CELL_NET_TUN }), 0);
+	ASSERT_EQ(cell_info(self->c.cfd, &info, sizeof(info), 0), 0);
+	ASSERT_EQ(info.mask, CELL_INFO_IDS_FIRST);
+	net = cell_open(self->c.cfd, CELL_OPEN_SLOT, "net", NULL, 0);
+	ASSERT_GE(net, 0);
+	old = open("/proc/self/ns/net", O_RDONLY | O_CLOEXEC);
+	ASSERT_GE(old, 0);
+	ASSERT_EQ(setns(net, CLONE_NEWNET), 0);
+	r = make_tap("taph", (long long)info.ids_first + 1000, -1);
+	ASSERT_EQ(setns(old, CLONE_NEWNET), 0);
+	close(old);
+	close(net);
+	unlink(TUN_NODE);
+	ASSERT_EQ(r, 0);
+	ASSERT_EQ(seal(self->c.cfd), 0);
+	EXPECT_EQ(run_sealed(&self->c, "tun-owner-within", NULL), 0);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/cell/cell_slots_test.c b/tools/testing/selftests/cell/cell_slots_test.c
new file mode 100644
index 000000000000..58e57e8c1642
--- /dev/null
+++ b/tools/testing/selftests/cell/cell_slots_test.c
@@ -0,0 +1,748 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Tests for cells, the slots: what may fill them, who may fill them, and what
+ * sealing makes of them.
+ */
+#include "cell_test.h"
+
+TEST_F(cell, tree_must_be_for_the_cell)
+{
+	/* A writable tmpfs of the host's, not idmapped. */
+	EXPECT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536, .no_idmap = true }), 18);
+	EXPECT_EQ(errno, EOVERFLOW);
+	EXPECT_EQ(cell_state(self->c.cfd), CELL_BUILDING);
+}
+
+TEST_F(cell, nothing_propagates_in)
+{
+	char path[64], line[512];
+	pid_t pid;
+	int pidfd;
+	FILE *f;
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536, .shared = true }), 0);
+	pidfd = spawn(self->c.cfd, &pid, "pause", NULL, NULL);
+	ASSERT_GE(pidfd, 0);
+
+	snprintf(path, sizeof(path), "/proc/%d/mountinfo", pid);
+	f = fopen(path, "r");
+	ASSERT_NE(f, NULL);
+	while (fgets(line, sizeof(line), f)) {
+		EXPECT_EQ(strstr(line, "shared:"), NULL) TH_LOG("%s", line);
+		EXPECT_EQ(strstr(line, "master:"), NULL) TH_LOG("%s", line);
+	}
+	fclose(f);
+	close(pidfd);
+}
+
+/* Making a mount namespace a cell's takes CAP_SYS_ADMIN over its owner. */
+/*
+ * Somebody who is still in the mount namespace puts another tree in the place of
+ * the one that is there, and leaves, while the cell is being sealed. The tree that
+ * the seal has looked at is the one that the tasks of the cell are in.
+ */
+TEST_F(cell, root_is_what_the_seal_looked_at)
+{
+	struct mount_attr attr = { .attr_set = MOUNT_ATTR_IDMAP };
+	int other, fd, p, i, r = -1, go[2], status;
+	pid_t pid;
+	char c;
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536, .no_seal = true,
+							.keep_root = true }), 0);
+	other = new_tmpfs();
+	ASSERT_GE(other, 0);
+	ASSERT_EQ(copy_child(other, "cell_child"), 0);
+	fd = openat(other, "other", O_CREAT | O_WRONLY, 0644);
+	ASSERT_GE(fd, 0);
+	close(fd);
+	attr.userns_fd = self->c.cfd;
+	ASSERT_EQ(sys_mount_setattr(other, "", AT_EMPTY_PATH, &attr, sizeof(attr)), 0);
+
+	ASSERT_EQ(pipe2(go, O_CLOEXEC), 0);
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (!pid) {
+		if (setns(self->c.rootfd, CLONE_NEWNS))
+			_exit(1);
+		if (read(go[0], &c, 1) != 1)
+			_exit(2);
+		usleep(100000);
+		if (umount2("/", MNT_DETACH))
+			_exit(3);
+		/* Once more, for the root of the namespace that this has laid bare. */
+		if (setns(self->c.rootfd, CLONE_NEWNS))
+			_exit(4);
+		if (sys_move_mount(other, "", AT_FDCWD, "/", MOVE_MOUNT_F_EMPTY_PATH))
+			_exit(5);
+		_exit(0);
+	}
+	usleep(50000);
+	ASSERT_EQ(write(go[1], "g", 1), 1);
+	for (i = 0; i < 200; i++) {
+		r = cell_configure(self->c.cfd, CELL_CMD_SEAL, NULL, NULL, 0);
+		if (!r || errno != EBUSY)
+			break;
+		usleep(10000);
+	}
+	EXPECT_EQ(r, 0);
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	ASSERT_EQ(WIFEXITED(status) ? WEXITSTATUS(status) : -1, 0);
+
+	p = spawn(self->c.cfd, NULL, "exists", "/other", NULL);
+	ASSERT_GE(p, 0);
+	EXPECT_EQ(cell_wait(self->c.cfd), 0);
+	close(p);
+	close(other);
+}
+
+TEST_F(cell, root_takes_permission)
+{
+	int nsfd, status;
+	pid_t pid;
+
+	nsfd = sys_open_tree(AT_FDCWD, "/tmp", OPEN_TREE_NAMESPACE | OPEN_TREE_CLOEXEC);
+	ASSERT_GE(nsfd, 0);
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (!pid) {
+		int cfd;
+
+		if (setresgid(1000, 1000, 1000) || setresuid(1000, 1000, 1000))
+			_exit(1);
+		cfd = cell_create(CELL_SELF, 0);
+		if (cfd < 0)
+			_exit(2);
+		if (cell_configure(cfd, CELL_SET_FD, "root", NULL, nsfd) != -1 || errno != EPERM)
+			_exit(3);
+		_exit(0);
+	}
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(WIFEXITED(status) ? WEXITSTATUS(status) : -1, 0);
+	close(nsfd);
+}
+
+/*
+ * Sharing a network namespace takes CAP_SYS_ADMIN over its owner, which is half
+ * of what setns() asks for. The other half is about the namespaces of the
+ * caller, and those do not change. So a caller without any privilege can share
+ * what a child of its made in a user namespace of its own, and cannot enter it.
+ */
+TEST_F(cell, net_takes_half_of_setns)
+{
+	int status;
+	pid_t pid;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (!pid) {
+		int ready[2], hold[2], cfd, nsfd, host;
+		char path[64], c;
+		pid_t child;
+
+		host = open("/proc/self/ns/net", O_RDONLY | O_CLOEXEC);
+		if (host < 0 || setresgid(1000, 1000, 1000) || setresuid(1000, 1000, 1000))
+			_exit(1);
+		/* /proc/<pid>/ns of the child is gated by ptrace access. */
+		if (prctl(PR_SET_DUMPABLE, 1, 0, 0, 0) || pipe(ready) || pipe(hold))
+			_exit(2);
+		child = fork();
+		if (child < 0)
+			_exit(3);
+		if (!child) {
+			close(hold[1]);
+			if (unshare(CLONE_NEWUSER | CLONE_NEWNET) || write(ready[1], "r", 1) != 1)
+				_exit(1);
+			_exit(read(hold[0], &c, 1));
+		}
+		if (read(ready[0], &c, 1) != 1)
+			_exit(4);
+		snprintf(path, sizeof(path), "/proc/%d/ns/net", child);
+		nsfd = open(path, O_RDONLY | O_CLOEXEC);
+		if (nsfd < 0)
+			_exit(5);
+		if (setns(nsfd, CLONE_NEWNET) != -1 || errno != EPERM)
+			_exit(6);
+		cfd = cell_create(CELL_SELF, 0);
+		if (cfd < 0)
+			_exit(7);
+		/* Not the host's, over whose owner it has nothing. */
+		if (cell_configure(cfd, CELL_SET_FD, "net", NULL, host) != -1 || errno != EPERM)
+			_exit(8);
+		if (cell_configure(cfd, CELL_SET_FD, "net", NULL, nsfd))
+			_exit(9);
+		close(hold[1]);
+		_exit(waitpid(child, &status, 0) == child && !status ? 0 : 10);
+	}
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(WIFEXITED(status) ? WEXITSTATUS(status) : -1, 0);
+}
+
+/* A network namespace of the caller's own making, with lo up. */
+static int new_netns(void)
+{
+	struct ifreq ifr = { .ifr_name = "lo", .ifr_flags = IFF_UP };
+	int old, new = -1, sock;
+
+	old = open("/proc/self/ns/net", O_RDONLY | O_CLOEXEC);
+	if (old < 0 || unshare(CLONE_NEWNET))
+		return -1;
+	sock = socket(AF_INET, SOCK_DGRAM | SOCK_CLOEXEC, 0);
+	if (sock >= 0 && !ioctl(sock, SIOCSIFFLAGS, &ifr))
+		new = open("/proc/self/ns/net", O_RDONLY | O_CLOEXEC);
+	close(sock);
+	if (setns(old, CLONE_NEWNET))
+		return -1;
+	close(old);
+	return new;
+}
+
+/*
+ * A pod is several cells and not one. Each has a tree, ids and a budget of its
+ * own. What they share is filled in from the same file descriptors: a network
+ * namespace that the builder made and still owns, and a volume. One that shows
+ * up later is one more cell. Nothing enters anything.
+ */
+TEST_F(cell, pod)
+{
+	int net, vol, vol_a, vol_b, old, ready[2], pidfd;
+	struct cellctx b;
+	char c;
+
+	net = new_netns();
+	ASSERT_GE(net, 0);
+	vol = new_tmpfs();
+	ASSERT_GE(vol, 0);
+	vol_a = sys_open_tree(vol, "", AT_EMPTY_PATH | OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC);
+	vol_b = sys_open_tree(vol, "", AT_EMPTY_PATH | OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC);
+	ASSERT_GE(vol_a, 0);
+	ASSERT_GE(vol_b, 0);
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536, .net = net,
+							.data = vol_a }), 0);
+	ASSERT_EQ(pipe2(ready, O_CLOEXEC), 0);
+	pidfd = prepare(self->c.cfd, "pod-serve", NULL, NULL);
+	ASSERT_GE(pidfd, 0);
+	ASSERT_EQ(pidfd_configure(pidfd, PIDFD_SET_FD, "3", NULL, ready[1]), 0);
+	ASSERT_EQ(pidfd_configure(pidfd, PIDFD_CMD_START, NULL, NULL, 0), 0);
+	close(pidfd);
+	close(ready[1]);
+	ASSERT_EQ(read(ready[0], &c, 1), 1);
+
+	/* The second one is made while the first is running. */
+	ASSERT_EQ(cell_build(&b, &(struct build){ .ids = 65536, .net = net,
+						  .data = vol_b }), 0);
+
+	/* The builder owns the network namespace, so it can still get in there. */
+	old = open("/proc/self/ns/net", O_RDONLY | O_CLOEXEC);
+	ASSERT_GE(old, 0);
+	EXPECT_EQ(setns(net, CLONE_NEWNET), 0);
+	ASSERT_EQ(setns(old, CLONE_NEWNET), 0);
+	close(old);
+
+	pidfd = spawn(b.cfd, NULL, "pod-connect", NULL, NULL);
+	ASSERT_GE(pidfd, 0);
+	close(pidfd);
+	EXPECT_EQ(cell_wait(b.cfd), 0);
+	EXPECT_EQ(cell_wait(self->c.cfd), 0);
+
+	cell_cleanup(&b);
+	close(ready[0]);
+	close(net);
+	close(vol);
+}
+
+/* The budget is judged against whoever fills the slot. */
+TEST_F(cell, budget_takes_permission)
+{
+	int status;
+	pid_t pid;
+
+	ASSERT_EQ(mkdir(CGROOT "/notyours", 0755), 0);
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (!pid) {
+		int cfd, cg;
+
+		if (setresgid(1000, 1000, 1000) || setresuid(1000, 1000, 1000))
+			_exit(1);
+		cfd = cell_create(CELL_SELF, 0);
+		if (cfd < 0)
+			_exit(2);
+		cg = open(CGROOT "/notyours", O_RDONLY | O_DIRECTORY);
+		if (cg < 0)
+			_exit(3);
+		if (cell_configure(cfd, CELL_SET_FD, "budget", NULL, cg) != -1 ||
+		    (errno != EPERM && errno != EACCES))
+			_exit(4);
+		_exit(0);
+	}
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(WIFEXITED(status) ? WEXITSTATUS(status) : -1, 0);
+	rmdir(CGROOT "/notyours");
+}
+
+/* A kill takes everything in the budget with it, so a budget is one cell's. */
+TEST_F(cell, budget_is_exclusive)
+{
+	char path[192], buf[32];
+	int cfd, cg, status;
+	struct stat st;
+	pid_t pid;
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536 }), 0);
+
+	cfd = cell_create(CELL_SELF, 0);
+	ASSERT_GE(cfd, 0);
+	EXPECT_EQ(cell_configure(cfd, CELL_SET_FD, "budget", NULL, self->c.cgfd), -1);
+	EXPECT_EQ(errno, EBUSY);
+
+	/* Nor one that lies within. */
+	snprintf(path, sizeof(path), "%s/sub", self->c.cg);
+	ASSERT_EQ(mkdir(path, 0755), 0);
+	cg = open(path, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_GE(cg, 0);
+	EXPECT_EQ(cell_configure(cfd, CELL_SET_FD, "budget", NULL, cg), -1);
+	EXPECT_EQ(errno, EBUSY);
+	close(cg);
+
+	/* Nor one that somebody is in. */
+	ASSERT_EQ(mkdir(CGROOT "/busy", 0755), 0);
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (!pid) {
+		pause();
+		_exit(0);
+	}
+	snprintf(buf, sizeof(buf), "%d", pid);
+	ASSERT_EQ(write_file(CGROOT "/busy/cgroup.procs", buf), 0);
+	cg = open(CGROOT "/busy", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_GE(cg, 0);
+	EXPECT_EQ(cell_configure(cfd, CELL_SET_FD, "budget", NULL, cg), -1);
+	EXPECT_EQ(errno, EBUSY);
+	kill(pid, SIGKILL);
+	waitpid(pid, &status, 0);
+	close(cg);
+	close(cfd);
+	rmdir(CGROOT "/busy");
+
+	/* It comes back when the cell is gone, with nothing of the cell's left. */
+	ASSERT_EQ(cell_kill(self->c.cfd, 0), 0);
+	EXPECT_EQ(cell_state(self->c.cfd), CELL_DEAD);
+	ASSERT_EQ(fstat(self->c.cgfd, &st), 0);
+	EXPECT_EQ(st.st_uid, 0);
+	ASSERT_EQ(fstatat(self->c.cgfd, "cgroup.procs", &st, 0), 0);
+	EXPECT_EQ(st.st_uid, 0);
+	EXPECT_EQ(access(path, F_OK), -1);
+}
+
+TEST_F(cell, budget_is_handed_over)
+{
+	struct stat st;
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536 }), 0);
+	ASSERT_EQ(fstat(self->c.cgfd, &st), 0);
+	EXPECT_GE(st.st_uid, CELL_WINDOW_FIRST);
+	ASSERT_EQ(fstatat(self->c.cgfd, "cgroup.procs", &st, 0), 0);
+	EXPECT_GE(st.st_uid, CELL_WINDOW_FIRST);
+	/* Limits stay with whoever is above. */
+	ASSERT_EQ(fstatat(self->c.cgfd, "cgroup.max.depth", &st, 0), 0);
+	EXPECT_EQ(st.st_uid, 0);
+}
+
+/* Who the budget and what is handed over with it belong to, or -1 if not to one. */
+static long budget_owner(const struct cellctx *c)
+{
+	static const char * const names[] = {
+		".", "cgroup.procs", "cgroup.threads", "cgroup.subtree_control",
+	};
+	struct stat st;
+	long uid = -1;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(names); i++) {
+		if (fstatat(c->cgfd, names[i], &st, 0))
+			return -2;
+		if (i && (long)st.st_uid != uid)
+			return -1;
+		uid = st.st_uid;
+	}
+	return uid;
+}
+
+#define FAIL_NTH	"/proc/thread-self/fail-nth"
+
+/*
+ * Have one allocation after the other fail in a seal. It leaves the budget with
+ * whoever it belongs to, all of it, and the cell to be sealed another time.
+ */
+TEST_F_TIMEOUT(cell, seal_that_runs_out_of_memory, 900)
+{
+	char nth[16], left[16] = {};
+	int n, r, e, fd, failed = 0;
+
+	mkdir("/tmp/cell_test.debugfs", 0700);
+	mount("none", "/tmp/cell_test.debugfs", "debugfs", 0, NULL);
+	r = write_file("/tmp/cell_test.debugfs/failslab/ignore-gfp-wait", "N");
+	umount2("/tmp/cell_test.debugfs", MNT_DETACH);
+	rmdir("/tmp/cell_test.debugfs");
+	/* Opening it takes memory as well, so that is done with for good. */
+	fd = open(FAIL_NTH, O_RDWR | O_CLOEXEC);
+	if (r || fd < 0)
+		SKIP(return, "no fault injection");
+
+	for (n = 1; n < 2000; n++) {
+		ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536, .no_seal = true,
+								.net_str = "new" }), 0);
+		ASSERT_EQ(budget_owner(&self->c), 0);
+
+		snprintf(nth, sizeof(nth), "%d", n);
+		ASSERT_GT(pwrite(fd, nth, strlen(nth), 0), 0);
+		r = cell_configure(self->c.cfd, CELL_CMD_SEAL, NULL, NULL, 0);
+		e = errno;
+		ASSERT_GT(pread(fd, left, sizeof(left) - 1, 0), 0);
+		ASSERT_GT(pwrite(fd, "0", 1, 0), 0);
+
+		if (r) {
+			failed++;
+			EXPECT_EQ(e, ENOMEM) TH_LOG("allocation %d", n);
+			EXPECT_EQ(budget_owner(&self->c), 0) TH_LOG("allocation %d", n);
+			EXPECT_EQ(cell_state(self->c.cfd), CELL_BUILDING);
+			EXPECT_EQ(cell_configure(self->c.cfd, CELL_CMD_SEAL, NULL, NULL, 0), 0)
+				TH_LOG("allocation %d", n);
+		}
+		EXPECT_GE(budget_owner(&self->c), (long)CELL_WINDOW_FIRST)
+			TH_LOG("allocation %d", n);
+		cell_cleanup(&self->c);
+		self->c.cfd = self->c.tree = self->c.raw = self->c.cgfd = -1;
+		self->c.rootfd = self->c.layers = -1;
+		/* It got through without reaching the one that was to fail. */
+		if (!r && atoi(left) > 0)
+			break;
+	}
+	close(fd);
+	TH_LOG("%d allocations, %d failed seals", n - 1, failed);
+	EXPECT_GT(failed, 4);
+	EXPECT_LT(n, 2000);
+}
+
+TEST_F(cell, stays_in_its_budget)
+{
+	char buf[32];
+	pid_t pid;
+	int pidfd;
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536 }), 0);
+	pidfd = spawn(self->c.cfd, &pid, "pause", NULL, NULL);
+	ASSERT_GE(pidfd, 0);
+
+	snprintf(buf, sizeof(buf), "%d", pid);
+	EXPECT_EQ(write_file(CGROOT "/cgroup.procs", buf), -1);
+	EXPECT_EQ(errno, EPERM);
+	close(pidfd);
+}
+
+/* Nothing but a spawn gets a task into a budget. */
+TEST_F(cell, nothing_enters_the_budget)
+{
+	struct cell_clone_args ca = { .flags = CLONE_INTO_CGROUP, .exit_signal = SIGCHLD };
+	char path[192], buf[32];
+	int pidfd, vhost;
+	pid_t pid;
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536 }), 0);
+
+	snprintf(path, sizeof(path), "%s/cgroup.procs", self->c.cg);
+	snprintf(buf, sizeof(buf), "%d", getpid());
+	EXPECT_EQ(write_file(path, buf), -1);
+	EXPECT_EQ(errno, EPERM);
+
+	ca.cgroup = self->c.cgfd;
+	pid = syscall(SYS_clone3, &ca, sizeof(ca));
+	if (!pid)
+		_exit(0);
+	EXPECT_EQ(pid, -1);
+	EXPECT_EQ(errno, EPERM);
+
+	/* Nor the kernel on behalf of a task of the cell. */
+	vhost = open("/dev/vhost-net", O_RDWR | O_CLOEXEC);
+	if (vhost < 0) {
+		TH_LOG("no /dev/vhost-net, that part is skipped");
+		return;
+	}
+	pidfd = prepare(self->c.cfd, "vhost", NULL, NULL);
+	ASSERT_GE(pidfd, 0);
+	ASSERT_EQ(pidfd_configure(pidfd, PIDFD_SET_FD, "3", NULL, vhost), 0);
+	ASSERT_EQ(pidfd_configure(pidfd, PIDFD_CMD_START, NULL, NULL, 0), 0);
+	/* With the device still open out here, the cell gets to be DEAD. */
+	EXPECT_EQ(cell_wait(self->c.cfd), 0);
+	EXPECT_EQ(cg_populated(self->c.cg), 0);
+	close(vhost);
+	close(pidfd);
+}
+
+/*
+ * Nobody in particular builds a cell. The mount work takes a user namespace and
+ * a mount namespace of one's own, and nothing else.
+ */
+/*
+ * A task of a cell changes nothing in cgroupfs outside of its budget, even if the
+ * builder gave it all of cgroupfs and somebody left a cgroup open to anybody.
+ * Enabling a controller makes files in the children that belong to whoever asked,
+ * and nothing asks whether their id can be stored: it would outlive the cell.
+ */
+TEST_F(cell, changes_nothing_outside_its_budget)
+{
+	struct stat st;
+	int pidfd;
+	char c = 0;
+
+	write_file(CGROOT "/cgroup.subtree_control", "+pids");
+	ASSERT_EQ(mkdir(CGROOT "/open", 0777), 0);
+	ASSERT_EQ(chmod(CGROOT "/open", 0777), 0);
+	ASSERT_EQ(chmod(CGROOT "/open/cgroup.subtree_control", 0666), 0);
+	ASSERT_EQ(chmod(CGROOT "/open/cgroup.procs", 0666), 0);
+	chmod(CGROOT "/open/pids.max", 0666);
+	ASSERT_EQ(mkdir(CGROOT "/open/kid", 0755), 0);
+	ASSERT_EQ(mkdir(CGROOT "/open/empty", 0755), 0);
+	ASSERT_EQ(setxattr(CGROOT "/open", "user.host", "h", 1, 0), 0);
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536, .cgroupfs = true }), 0);
+	pidfd = spawn(self->c.cfd, NULL, "outside", NULL, NULL);
+	ASSERT_GE(pidfd, 0);
+	EXPECT_EQ(cell_wait(self->c.cfd), 0);
+	close(pidfd);
+
+	/* Nothing was made, so nothing is left that is owned by an id of the cell. */
+	EXPECT_EQ(stat(CGROOT "/open/kid/pids.max", &st), -1);
+	EXPECT_EQ(errno, ENOENT);
+	EXPECT_EQ(stat(CGROOT "/open/empty", &st), 0);
+	EXPECT_EQ(getxattr(CGROOT "/open", "user.host", &c, 1), 1);
+	EXPECT_EQ(c, 'h');
+	EXPECT_EQ(getxattr(CGROOT "/open", "user.cell", &c, 1), -1);
+
+	write_file(CGROOT "/open/cgroup.subtree_control", "-pids");
+	rmdir(CGROOT "/open/kid");
+	rmdir(CGROOT "/open/empty");
+	rmdir(CGROOT "/open");
+}
+
+#define V1ROOT	"/tmp/cell-test-v1"
+
+TEST_F(cell, changes_nothing_on_a_legacy_hierarchy)
+{
+	struct stat st;
+	int pidfd;
+
+	mkdir(V1ROOT, 0755);
+	if (mount("none", V1ROOT, "cgroup", 0, "none,name=celltest")) {
+		rmdir(V1ROOT);
+		SKIP(return, "no legacy hierarchies");
+	}
+	ASSERT_EQ(mkdir(V1ROOT "/open", 0777), 0);
+	ASSERT_EQ(chmod(V1ROOT "/open", 0777), 0);
+	ASSERT_EQ(chmod(V1ROOT "/open/cgroup.procs", 0666), 0);
+	ASSERT_EQ(chmod(V1ROOT "/open/notify_on_release", 0666), 0);
+	ASSERT_EQ(mkdir(V1ROOT "/open/empty", 0777), 0);
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536, .bind = V1ROOT }), 0);
+	pidfd = spawn(self->c.cfd, NULL, "legacy", NULL, NULL);
+	ASSERT_GE(pidfd, 0);
+	EXPECT_EQ(cell_wait(self->c.cfd), 0);
+	close(pidfd);
+	EXPECT_EQ(stat(V1ROOT "/open/empty", &st), 0);
+
+	cell_cleanup(&self->c);
+	self->c.cfd = self->c.tree = self->c.raw = self->c.cgfd = -1;
+	rmdir(V1ROOT "/open/other");
+	rmdir(V1ROOT "/open/empty");
+	EXPECT_EQ(rmdir(V1ROOT "/open"), 0);
+	EXPECT_EQ(umount(V1ROOT), 0);
+	rmdir(V1ROOT);
+}
+
+/* Nor does it help to own the cgroup, as a cell of one id does what its maker owns. */
+TEST_F(cell, changes_nothing_outside_its_budget_that_it_owns)
+{
+	struct stat st;
+	int status;
+	pid_t pid;
+	char c = 0;
+	bool v1;
+
+	ASSERT_EQ(chown(CGROOT, 1000, 1000), 0);
+	ASSERT_EQ(chown(CGROOT "/cgroup.procs", 1000, 1000), 0);
+	ASSERT_EQ(mkdir(CGROOT "/theirs", 0755), 0);
+	ASSERT_EQ(mkdir(CGROOT "/theirs/empty", 0755), 0);
+	ASSERT_EQ(chown(CGROOT "/theirs", 1000, 1000), 0);
+	ASSERT_EQ(chown(CGROOT "/theirs/empty", 1000, 1000), 0);
+	ASSERT_EQ(chown(CGROOT "/theirs/cgroup.procs", 1000, 1000), 0);
+	ASSERT_EQ(chown(CGROOT "/theirs/cgroup.max.depth", 1000, 1000), 0);
+	ASSERT_EQ(setxattr(CGROOT "/theirs", "user.host", "h", 1, 0), 0);
+	mkdir(V1ROOT, 0755);
+	v1 = !mount("none", V1ROOT, "cgroup", 0, "none,name=celltest");
+	if (v1) {
+		ASSERT_EQ(mkdir(V1ROOT "/theirs", 0755), 0);
+		ASSERT_EQ(mkdir(V1ROOT "/theirs/empty", 0755), 0);
+		ASSERT_EQ(chown(V1ROOT "/theirs", 1000, 1000), 0);
+		ASSERT_EQ(chown(V1ROOT "/theirs/empty", 1000, 1000), 0);
+	}
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (!pid) {
+		struct cellctx c;
+		int step, pidfd, dir, procs, legacy;
+
+		if (setgroups(0, NULL) || setresgid(1000, 1000, 1000) ||
+		    setresuid(1000, 1000, 1000) ||
+		    prctl(PR_SET_DUMPABLE, 1, 0, 0, 0))
+			_exit(1);
+		if (unshare(CLONE_NEWUSER | CLONE_NEWNS))
+			_exit(2);
+		if (write_file("/proc/self/setgroups", "deny") ||
+		    write_file("/proc/self/uid_map", "1000 1000 1") ||
+		    write_file("/proc/self/gid_map", "1000 1000 1"))
+			_exit(3);
+		step = cell_build(&c, &(struct build){ .ids = 1 });
+		if (step)
+			_exit(20 + step);
+		dir = open(CGROOT "/theirs", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+		/* Not cgroup.procs, which has more reasons to refuse. */
+		procs = open(CGROOT "/theirs/cgroup.max.depth", O_WRONLY | O_CLOEXEC);
+		pidfd = prepare(c.cfd, "outside-own", NULL, NULL);
+		if (dir < 0 || procs < 0 || pidfd < 0 ||
+		    pidfd_configure(pidfd, PIDFD_SET_FD, "3", NULL, dir) ||
+		    pidfd_configure(pidfd, PIDFD_SET_FD, "4", NULL, procs))
+			_exit(4);
+		legacy = open(V1ROOT "/theirs", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+		if (v1 && (legacy < 0 ||
+			   pidfd_configure(pidfd, PIDFD_SET_FD, "5", NULL, legacy)))
+			_exit(6);
+		if (pidfd_configure(pidfd, PIDFD_CMD_START, NULL, NULL, 0))
+			_exit(7);
+		_exit(cell_wait(c.cfd) ? 5 : 0);
+	}
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(WIFEXITED(status) ? WEXITSTATUS(status) : -1, 0);
+
+	EXPECT_EQ(stat(CGROOT "/theirs", &st), 0);
+	EXPECT_EQ(st.st_mode & 07777, 0755);
+	EXPECT_EQ(stat(CGROOT "/theirs/empty", &st), 0);
+	EXPECT_EQ(getxattr(CGROOT "/theirs", "user.host", &c, 1), 1);
+	EXPECT_EQ(getxattr(CGROOT "/theirs", "user.cell", &c, 1), -1);
+
+	if (v1) {
+		EXPECT_EQ(stat(V1ROOT "/theirs/empty", &st), 0);
+		rmdir(V1ROOT "/theirs/other");
+		rmdir(V1ROOT "/theirs/mine");
+		rmdir(V1ROOT "/theirs/empty");
+		EXPECT_EQ(rmdir(V1ROOT "/theirs"), 0);
+		EXPECT_EQ(umount(V1ROOT), 0);
+	}
+	rmdir(V1ROOT);
+	rmdir(CGROOT "/theirs/mine");
+	rmdir(CGROOT "/theirs/empty");
+	EXPECT_EQ(rmdir(CGROOT "/theirs"), 0);
+	EXPECT_EQ(chown(CGROOT, 0, 0), 0);
+	EXPECT_EQ(chown(CGROOT "/cgroup.procs", 0, 0), 0);
+}
+
+TEST_F(cell, unprivileged_builder)
+{
+	int status;
+	pid_t pid;
+
+	ASSERT_EQ(chown(CGROOT, 1000, 1000), 0);
+	ASSERT_EQ(chown(CGROOT "/cgroup.procs", 1000, 1000), 0);
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (!pid) {
+		struct cellctx c;
+		int step;
+
+		/* Dumpable, or /proc/self is root's. */
+		if (setgroups(0, NULL) || setresgid(1000, 1000, 1000) ||
+		    setresuid(1000, 1000, 1000) ||
+		    prctl(PR_SET_DUMPABLE, 1, 0, 0, 0))
+			_exit(1);
+		if (unshare(CLONE_NEWUSER | CLONE_NEWNS))
+			_exit(2);
+		if (write_file("/proc/self/setgroups", "deny") ||
+		    write_file("/proc/self/uid_map", "1000 1000 1") ||
+		    write_file("/proc/self/gid_map", "1000 1000 1"))
+			_exit(3);
+		step = cell_build(&c, &(struct build){ .ids = 1 });
+		if (step)
+			_exit(20 + step);
+		if (spawn(c.cfd, NULL, "exit", "0", NULL) < 0)
+			_exit(4);
+		_exit(cell_wait(c.cfd) ? 5 : 0);
+	}
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(WIFEXITED(status) ? WEXITSTATUS(status) : -1, 0);
+	EXPECT_EQ(chown(CGROOT, 0, 0), 0);
+	EXPECT_EQ(chown(CGROOT "/cgroup.procs", 0, 0), 0);
+}
+
+/* What the "caps" slot takes. */
+TEST_F(cell, caps_slot)
+{
+	struct cell_info info = { .mask = CELL_INFO_CAPS };
+	__u64 caps[2] = { CAP(CHOWN) | CAP(KILL), 0 };
+	char buf[16] = {};
+	int cfd, fd, last;
+
+	fd = open("/proc/sys/kernel/cap_last_cap", O_RDONLY);
+	ASSERT_GE(fd, 0);
+	ASSERT_GT(read(fd, buf, sizeof(buf) - 1), 0);
+	close(fd);
+	last = atoi(buf);
+	ASSERT_LT(last, 63);
+
+	cfd = cell_create(CELL_SELF, 0);
+	ASSERT_GE(cfd, 0);
+	ASSERT_EQ(cell_info(cfd, &info, sizeof(info), 0), 0);
+	EXPECT_EQ(info.mask & CELL_INFO_CAPS, CELL_INFO_CAPS);
+	EXPECT_EQ(info.caps, 0);
+
+	EXPECT_EQ(cell_configure(cfd, CELL_SET_BINARY, "caps", caps, 4), -1);
+	EXPECT_EQ(errno, EINVAL);
+	EXPECT_EQ(cell_configure(cfd, CELL_SET_BINARY, "caps", caps, 16), -1);
+	EXPECT_EQ(errno, EINVAL);
+	EXPECT_EQ(cell_configure(cfd, CELL_SET_BINARY, "caps", (void *)1, 8), -1);
+	EXPECT_EQ(errno, EFAULT);
+	EXPECT_EQ(cell_configure(cfd, CELL_SET_STRING, "caps", "chown", 0), -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	/* Nothing a cell writes imparts privilege, whatever the builder thinks of it. */
+	caps[1] = caps[0] | CAP(SETFCAP);
+	EXPECT_EQ(cell_configure(cfd, CELL_SET_BINARY, "caps", &caps[1], 8), -1);
+	EXPECT_EQ(errno, EINVAL);
+	/* There is no such capability. */
+	caps[1] = caps[0] | 2ULL << last;
+	EXPECT_EQ(cell_configure(cfd, CELL_SET_BINARY, "caps", &caps[1], 8), -1);
+	EXPECT_EQ(errno, EINVAL);
+	caps[1] = caps[0] | 1ULL << 63;
+	EXPECT_EQ(cell_configure(cfd, CELL_SET_BINARY, "caps", &caps[1], 8), -1);
+	EXPECT_EQ(errno, EINVAL);
+	ASSERT_EQ(cell_info(cfd, &info, sizeof(info), 0), 0);
+	EXPECT_EQ(info.caps, 0);
+
+	/* The last word counts. */
+	caps[1] = 1ULL << last;
+	EXPECT_EQ(cell_configure(cfd, CELL_SET_BINARY, "caps", &caps[1], 8), 0);
+	EXPECT_EQ(cell_configure(cfd, CELL_SET_BINARY, "caps", caps, 8), 0);
+	ASSERT_EQ(cell_info(cfd, &info, sizeof(info), 0), 0);
+	EXPECT_EQ(info.caps, caps[0]);
+	close(cfd);
+
+	/* Until the seal. */
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536, .caps = caps[0] }), 0);
+	caps[1] = 0;
+	EXPECT_EQ(cell_configure(self->c.cfd, CELL_SET_BINARY, "caps", &caps[1], 8), -1);
+	EXPECT_EQ(errno, EBUSY);
+	ASSERT_EQ(cell_info(self->c.cfd, &info, sizeof(info), 0), 0);
+	EXPECT_EQ(info.caps, caps[0]);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/cell/cell_spawn_test.c b/tools/testing/selftests/cell/cell_spawn_test.c
new file mode 100644
index 000000000000..e5f0250be4db
--- /dev/null
+++ b/tools/testing/selftests/cell/cell_spawn_test.c
@@ -0,0 +1,559 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Tests for cells, spawning: empty pidfds, and what a new task does and does
+ * not start out with.
+ */
+#include "cell_test.h"
+
+TEST_F(cell, nothing_inherited)
+{
+	/* Things a fork would have passed on. */
+	int junk = open("/etc/passwd", O_RDONLY);
+
+	ASSERT_GE(junk, 0);
+	ASSERT_EQ(chdir("/etc"), 0);
+	setenv("SECRET", "hunter2", 1);
+	RUN_IN_CELL("basic");
+	close(junk);
+}
+
+/* What pidfd_open() takes with PIDFD_EMPTY. */
+TEST_F(cell, empty_pidfd_open)
+{
+	int fd;
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536 }), 0);
+
+	/* Outside of a cell it makes sense, and is not done yet. */
+	EXPECT_EQ(pidfd_open_empty(-EBADF, 0), -1);
+	EXPECT_EQ(errno, EOPNOTSUPP);
+	EXPECT_EQ(pidfd_open_empty(-1, 0), -1);
+	EXPECT_EQ(errno, EBADF);
+	fd = open("/dev/null", O_RDONLY | O_CLOEXEC);
+	ASSERT_GE(fd, 0);
+	EXPECT_EQ(pidfd_open_empty(fd, 0), -1);
+	EXPECT_EQ(errno, EINVAL);
+	close(fd);
+	EXPECT_EQ(pidfd_open_empty(self->c.cfd, O_EXCL /* PIDFD_THREAD */), -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	fd = pidfd_open_empty(self->c.cfd, 0);
+	ASSERT_GE(fd, 0);
+	EXPECT_EQ(fcntl(fd, F_GETFD), FD_CLOEXEC);
+	close(fd);
+	/* Nothing came of it, and the cell is none the worse. */
+	EXPECT_EQ(cell_state(self->c.cfd), CELL_SEALED);
+}
+
+/* The "Pid:" line of the fdinfo of a pidfd, or -2. */
+static int pidfd_fdinfo_pid(int pidfd)
+{
+	char path[64], line[128];
+	int nr = -2;
+	FILE *f;
+
+	snprintf(path, sizeof(path), "/proc/self/fdinfo/%d", pidfd);
+	f = fopen(path, "r");
+	if (!f)
+		return -2;
+	while (fgets(line, sizeof(line), f)) {
+		if (sscanf(line, "Pid:\t%d", &nr) == 1)
+			break;
+	}
+	fclose(f);
+	return nr;
+}
+
+/* It is a pidfd like any other. There just is no task yet. */
+TEST_F(cell, empty_pidfd)
+{
+	struct pidfd_info_v0 info = {};
+	struct stat st, st_other;
+	struct pollfd pfd;
+	int pidfd, other;
+	siginfo_t si;
+	pid_t pid;
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536 }), 0);
+
+	pidfd = prepare(self->c.cfd, "pause", NULL, NULL);
+	ASSERT_GE(pidfd, 0);
+
+	/* Nothing exists, and nothing has happened to the cell. */
+	EXPECT_EQ(cg_populated(self->c.cg), 0);
+	EXPECT_EQ(cell_state(self->c.cfd), CELL_SEALED);
+
+	/* Whatever it is passed to finds no task. */
+	EXPECT_EQ(syscall(SYS_pidfd_send_signal, pidfd, 0, NULL, 0), -1);
+	EXPECT_EQ(errno, ESRCH);
+	EXPECT_EQ(syscall(SYS_pidfd_getfd, pidfd, 0, 0), -1);
+	EXPECT_EQ(errno, ESRCH);
+	EXPECT_EQ(ioctl(pidfd, PIDFD_GET_INFO_V0, &info), -1);
+	EXPECT_EQ(errno, ESRCH);
+	/* Nor the record of an exit: nothing has exited. */
+	info.mask = PIDFD_INFO_EXIT_V0;
+	EXPECT_EQ(ioctl(pidfd, PIDFD_GET_INFO_V0, &info), -1);
+	EXPECT_EQ(errno, ESRCH);
+	info.mask = 0;
+	/* -1 is for a task that is gone. */
+	EXPECT_EQ(pidfd_fdinfo_pid(pidfd), 0);
+	EXPECT_EQ(setns(pidfd, CLONE_NEWNET), -1);
+	EXPECT_EQ(errno, ESRCH);
+	EXPECT_EQ(waitid(P_PIDFD, pidfd, &si, WEXITED | WNOHANG), -1);
+	EXPECT_EQ(errno, ECHILD);
+	/* No task yet is not the same as no task any more. */
+	pfd = (struct pollfd){ .fd = pidfd, .events = POLLIN };
+	EXPECT_EQ(poll(&pfd, 1, 100), 0);
+	ASSERT_EQ(fstat(pidfd, &st), 0);
+
+	/* What may not be given. */
+	EXPECT_EQ(pidfd_configure(pidfd, PIDFD_SET_FD, "3", NULL, self->c.cfd), -1);
+	EXPECT_EQ(errno, EPERM);
+	other = open("/proc/self/ns/net", O_RDONLY);
+	EXPECT_EQ(pidfd_configure(pidfd, PIDFD_SET_FD, "3", NULL, other), -1);
+	EXPECT_EQ(errno, EPERM);
+	close(other);
+	EXPECT_EQ(pidfd_configure(pidfd, PIDFD_SET_FD, "3", NULL, pidfd), -1);
+	EXPECT_EQ(errno, EPERM);
+	EXPECT_EQ(pidfd_configure(pidfd, PIDFD_SET_FD, "nonsense", NULL, 0), -1);
+	EXPECT_EQ(errno, EINVAL);
+	EXPECT_EQ(pidfd_configure(pidfd, PIDFD_SET_BINARY, "argv", "unterminated", 12), -1);
+	EXPECT_EQ(errno, EINVAL);
+	/* An id the cell does not have. */
+	EXPECT_EQ(pidfd_configure(pidfd, PIDFD_SET_BINARY, "cred",
+				  &(struct pidfd_cred){ .uid = 70000 },
+				  sizeof(struct pidfd_cred)), -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	ASSERT_EQ(pidfd_configure(pidfd, PIDFD_CMD_START, NULL, NULL, 0), 0);
+	EXPECT_EQ(pidfd_configure(pidfd, PIDFD_CMD_START, NULL, NULL, 0), -1);
+	EXPECT_EQ(errno, EBUSY);
+	EXPECT_EQ(pidfd_configure(pidfd, PIDFD_SET_STRING, "exec", "/x", 0), -1);
+	EXPECT_EQ(errno, EBUSY);
+
+	/* Now there is one: in the cell, as the cell's root. */
+	pid = pidfd_nr(pidfd);
+	ASSERT_GT(pid, 0);
+	EXPECT_GE(host_uid(pid), (long)CELL_WINDOW_FIRST);
+	EXPECT_EQ(cg_populated(self->c.cg), 1);
+	EXPECT_EQ(cell_state(self->c.cfd), CELL_RUNNING);
+	EXPECT_EQ(syscall(SYS_pidfd_send_signal, pidfd, 0, NULL, 0), 0);
+	EXPECT_EQ(poll(&pfd, 1, 100), 0);
+	EXPECT_EQ(pidfd_fdinfo_pid(pidfd), pid);
+
+	/* Another pidfd on it is the same inode, which did not change either. */
+	other = sys_pidfd_open(pid, 0);
+	ASSERT_GE(other, 0);
+	ASSERT_EQ(fstat(other, &st_other), 0);
+	EXPECT_EQ(st.st_ino, st_other.st_ino);
+	ASSERT_EQ(fstat(pidfd, &st_other), 0);
+	EXPECT_EQ(st.st_ino, st_other.st_ino);
+	/* But only the file pidfd_open() returned for PIDFD_EMPTY configures. */
+	EXPECT_EQ(pidfd_configure(other, PIDFD_CMD_START, NULL, NULL, 0), -1);
+	EXPECT_EQ(errno, EPERM);
+	close(other);
+	close(pidfd);
+
+	/* A second one, into the running cell. */
+	pidfd = spawn(self->c.cfd, NULL, "second", NULL, NULL);
+	ASSERT_GE(pidfd, 0);
+	EXPECT_EQ(task_wait(pidfd), 0);
+	close(pidfd);
+	EXPECT_EQ(cell_state(self->c.cfd), CELL_RUNNING);
+}
+
+/*
+ * An empty pidfd reserves nothing in the cell. Whichever is started first is
+ * the init, and one that is left empty keeps the cell from nothing.
+ */
+TEST_F(cell, empty_pidfd_reserves_nothing)
+{
+	int a, b, c;
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536 }), 0);
+
+	/* "basic" insists on being pid 1, "second" on not being it. */
+	a = prepare(self->c.cfd, "second", NULL, NULL);
+	b = prepare(self->c.cfd, "pause", NULL, NULL);
+	c = prepare(self->c.cfd, "pause", NULL, NULL);
+	ASSERT_GE(a, 0);
+	ASSERT_GE(b, 0);
+	ASSERT_GE(c, 0);
+	ASSERT_EQ(pidfd_configure(b, PIDFD_CMD_START, NULL, NULL, 0), 0);
+	ASSERT_EQ(pidfd_configure(a, PIDFD_CMD_START, NULL, NULL, 0), 0);
+	EXPECT_EQ(task_wait(a), 0);
+
+	/* The cell dies with @c still there, and then nothing comes of @c. */
+	ASSERT_EQ(cell_kill(self->c.cfd, 0), 0);
+	EXPECT_EQ(cell_wait(self->c.cfd), SIGKILL);
+	EXPECT_EQ(cell_state(self->c.cfd), CELL_DEAD);
+	EXPECT_EQ(pidfd_configure(c, PIDFD_CMD_START, NULL, NULL, 0), -1);
+	EXPECT_EQ(errno, ESRCH);
+	close(a);
+	close(b);
+	close(c);
+}
+
+/*
+ * A start that fails before there is a task. The pidfd then says that there is
+ * none and never will be, every way it can be asked, and the cell is as it was.
+ */
+TEST_F(cell, start_fails_without_a_task)
+{
+	struct pidfd_info_v0 info = { .mask = PIDFD_INFO_EXIT_V0 };
+	struct pollfd pfd;
+	char path[192];
+	int pidfd;
+
+	write_file(CGROOT "/cgroup.subtree_control", "+pids");
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536 }), 0);
+	snprintf(path, sizeof(path), "%s/pids.max", self->c.cg);
+	if (write_file(path, "0")) {
+		TH_LOG("no pids controller, skipped");
+		return;
+	}
+
+	pidfd = prepare(self->c.cfd, "pause", NULL, NULL);
+	ASSERT_GE(pidfd, 0);
+	EXPECT_EQ(pidfd_configure(pidfd, PIDFD_CMD_START, NULL, NULL, 0), -1);
+	EXPECT_EQ(errno, EAGAIN);
+	EXPECT_EQ(cg_populated(self->c.cg), 0);
+
+	/* It can be tried only once. */
+	EXPECT_EQ(pidfd_configure(pidfd, PIDFD_CMD_START, NULL, NULL, 0), -1);
+	EXPECT_EQ(errno, EBUSY);
+	pfd = (struct pollfd){ .fd = pidfd, .events = POLLIN };
+	EXPECT_EQ(poll(&pfd, 1, 1000), 1);
+	EXPECT_EQ(ioctl(pidfd, PIDFD_GET_INFO_V0, &info), -1);
+	EXPECT_EQ(errno, ESRCH);
+	EXPECT_EQ(pidfd_fdinfo_pid(pidfd), -1);
+	EXPECT_EQ(syscall(SYS_pidfd_send_signal, pidfd, 0, NULL, 0), -1);
+	EXPECT_EQ(errno, ESRCH);
+	close(pidfd);
+
+	/* Nothing ever ran, so the next one is the init of the cell. */
+	EXPECT_EQ(cell_state(self->c.cfd), CELL_SEALED);
+	ASSERT_EQ(write_file(path, "max"), 0);
+	pidfd = spawn(self->c.cfd, NULL, "basic", NULL, NULL);
+	ASSERT_GE(pidfd, 0);
+	EXPECT_EQ(cell_wait(self->c.cfd), 0);
+	close(pidfd);
+}
+
+/* The pidfd may be kept for long. What was configured is not kept with it. */
+static int usr1_seen;
+
+static void on_usr1(int sig)
+{
+	__atomic_fetch_add(&usr1_seen, 1, __ATOMIC_RELAXED);
+}
+
+/*
+ * A fork is started over if a signal is pending for whoever forks, and nobody gets
+ * to see that. A start is no different, and it has not been tried by then.
+ */
+TEST_F_TIMEOUT(cell, start_is_started_over_after_a_signal, 120)
+{
+	struct sigaction sa = { .sa_handler = on_usr1, .sa_flags = SA_RESTART };
+	pid_t me = getpid(), pest;
+	int init, p, i, seen, failed = 0;
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536 }), 0);
+	init = spawn(self->c.cfd, NULL, "pause", NULL, NULL);
+	ASSERT_GE(init, 0);
+	ASSERT_EQ(sigaction(SIGUSR1, &sa, NULL), 0);
+	pest = fork();
+	ASSERT_GE(pest, 0);
+	if (!pest) {
+		for (;;) {
+			kill(me, SIGUSR1);
+			usleep(300);
+		}
+	}
+
+	for (i = 0; i < 300; i++) {
+		p = prepare(self->c.cfd, "exit", "0", NULL);
+		ASSERT_GE(p, 0);
+		if (pidfd_configure(p, PIDFD_CMD_START, NULL, NULL, 0)) {
+			failed++;
+			TH_LOG("start %d: errno %d", i, errno);
+		}
+		close(p);
+	}
+	kill(pest, SIGKILL);
+	waitpid(pest, NULL, 0);
+	signal(SIGUSR1, SIG_DFL);
+
+	seen = __atomic_load_n(&usr1_seen, __ATOMIC_RELAXED);
+	TH_LOG("%d signals", seen);
+	EXPECT_GT(seen, 100);
+	EXPECT_EQ(failed, 0);
+	close(init);
+}
+
+TEST_F(cell, pidfd_keeps_no_file)
+{
+	int p[2], pidfd;
+	char c;
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536 }), 0);
+	ASSERT_EQ(pipe2(p, O_CLOEXEC), 0);
+	pidfd = prepare(self->c.cfd, "exit", "0", NULL);
+	ASSERT_GE(pidfd, 0);
+	ASSERT_EQ(pidfd_configure(pidfd, PIDFD_SET_FD, "3", NULL, p[1]), 0);
+	close(p[1]);
+	ASSERT_EQ(pidfd_configure(pidfd, PIDFD_CMD_START, NULL, NULL, 0), 0);
+	EXPECT_EQ(cell_wait(self->c.cfd), 0);
+	/* The last writer is gone, though the pidfd is not. */
+	ASSERT_EQ(fcntl(p[0], F_SETFL, O_NONBLOCK), 0);
+	EXPECT_EQ(read(p[0], &c, 1), 0);
+	close(p[0]);
+	close(pidfd);
+}
+
+TEST_F(cell, exec_failure_is_reported)
+{
+	int pidfd;
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536 }), 0);
+	pidfd = prepare(self->c.cfd, "basic", NULL, NULL);
+	ASSERT_GE(pidfd, 0);
+	ASSERT_EQ(pidfd_configure(pidfd, PIDFD_SET_STRING, "exec", "/no/such/file", 0), 0);
+	EXPECT_EQ(pidfd_configure(pidfd, PIDFD_CMD_START, NULL, NULL, 0), -1);
+	EXPECT_EQ(errno, ENOENT);
+	/* That was the cell's init. */
+	EXPECT_EQ(cell_wait(self->c.cfd), SIGKILL);
+	close(pidfd);
+}
+
+TEST_F(cell, cred)
+{
+	int pidfd;
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536 }), 0);
+	pidfd = prepare(self->c.cfd, "uid", "33", "44");
+	ASSERT_GE(pidfd, 0);
+	ASSERT_EQ(pidfd_configure(pidfd, PIDFD_SET_BINARY, "cred",
+				 &(struct pidfd_cred){ .uid = 33, .gid = 44 },
+				 sizeof(struct pidfd_cred)), 0);
+	ASSERT_EQ(pidfd_configure(pidfd, PIDFD_CMD_START, NULL, NULL, 0), 0);
+	EXPECT_EQ(cell_wait(self->c.cfd), 0);
+	close(pidfd);
+}
+
+/* Send @fd over @sock, by SCM_RIGHTS. */
+static int send_one_fd(int sock, int fd)
+{
+	char buf[CMSG_SPACE(sizeof(int))] = {};
+	struct iovec iov = { .iov_base = "x", .iov_len = 1 };
+	struct msghdr msg = {
+		.msg_iov = &iov, .msg_iovlen = 1,
+		.msg_control = buf, .msg_controllen = sizeof(buf),
+	};
+	struct cmsghdr *cmsg = CMSG_FIRSTHDR(&msg);
+
+	cmsg->cmsg_level = SOL_SOCKET;
+	cmsg->cmsg_type = SCM_RIGHTS;
+	cmsg->cmsg_len = CMSG_LEN(sizeof(int));
+	memcpy(CMSG_DATA(cmsg), &fd, sizeof(int));
+	return sendmsg(sock, &msg, 0) == 1 ? 0 : -1;
+}
+
+/*
+ * A socket that was to go to a task which then never started is nobody's but
+ * the host's, and goes on working as it did.
+ */
+TEST_F(cell, failed_start_leaves_a_socket_alone)
+{
+	int sp[2], pidfd;
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536 }), 0);
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, sp), 0);
+	ASSERT_EQ(send_one_fd(sp[0], sp[0]), 0);
+
+	pidfd = prepare(self->c.cfd, "exit", "0", NULL);
+	ASSERT_GE(pidfd, 0);
+	ASSERT_EQ(pidfd_configure(pidfd, PIDFD_SET_FD, "3", NULL, sp[1]), 0);
+	ASSERT_EQ(pidfd_configure(pidfd, PIDFD_SET_STRING, "exec", "/no-such-file", 0), 0);
+	ASSERT_EQ(pidfd_configure(pidfd, PIDFD_CMD_START, NULL, NULL, 0), -1);
+	ASSERT_EQ(errno, ENOENT);
+	close(pidfd);
+
+	EXPECT_EQ(send_one_fd(sp[0], sp[0]), 0);
+	close(sp[0]);
+	close(sp[1]);
+}
+
+static void no_handler(int sig)
+{
+}
+
+/* Nothing is inherited: not what the spawner ignores, handles or blocks. */
+TEST_F(cell, signals_start_from_scratch)
+{
+	int status;
+	pid_t pid;
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536 }), 0);
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (!pid) {
+		sigset_t set;
+
+		signal(SIGPIPE, SIG_IGN);
+		signal(SIGHUP, SIG_IGN);
+		signal(SIGCHLD, SIG_IGN);
+		signal(SIGUSR2, no_handler);
+		sigemptyset(&set);
+		sigaddset(&set, SIGUSR1);
+		sigaddset(&set, SIGTERM);
+		if (sigprocmask(SIG_BLOCK, &set, NULL) || raise(SIGUSR1))
+			_exit(1);
+		if (spawn(self->c.cfd, NULL, "signals", NULL, NULL) < 0)
+			_exit(2);
+		_exit(cell_wait(self->c.cfd) ? 3 : 0);
+	}
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(WIFEXITED(status) ? WEXITSTATUS(status) : -1, 0);
+}
+
+/* From here on system call @nr fails with EACCES, for the caller and its issue. */
+static int seccomp_deny(int nr)
+{
+	struct sock_filter insns[] = {
+		BPF_STMT(BPF_LD | BPF_W | BPF_ABS, offsetof(struct seccomp_data, nr)),
+		BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, nr, 0, 1),
+		BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ERRNO | EACCES),
+		BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW),
+	};
+	struct sock_fprog prog = { .len = ARRAY_SIZE(insns), .filter = insns };
+
+	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0))
+		return -1;
+	return prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog);
+}
+
+/* What a confined task spawns is confined as it is itself. */
+TEST_F(cell, seccomp_filters_are_inherited)
+{
+	int status;
+	pid_t pid;
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536 }), 0);
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (!pid) {
+		if (seccomp_deny(SYS_getrusage))
+			_exit(1);
+		if (spawn(self->c.cfd, NULL, "seccomp", NULL, NULL) < 0)
+			_exit(2);
+		_exit(cell_wait(self->c.cfd) ? 3 : 0);
+	}
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(WIFEXITED(status) ? WEXITSTATUS(status) : -1, 0);
+}
+
+/*
+ * A listener on a filter stays with the spawner, outside. It can answer for the
+ * system calls of a task of the cell. It cannot put a file into it.
+ */
+TEST_F(cell, seccomp_listener_adds_no_file)
+{
+	int status;
+	pid_t pid;
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536 }), 0);
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (!pid) {
+		struct sock_filter insns[] = {
+			BPF_STMT(BPF_LD | BPF_W | BPF_ABS, offsetof(struct seccomp_data, nr)),
+			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, SYS_getrusage, 0, 1),
+			BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_USER_NOTIF),
+			BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW),
+		};
+		struct sock_fprog prog = { .len = ARRAY_SIZE(insns), .filter = insns };
+		struct seccomp_notif_addfd addfd = {};
+		struct seccomp_notif_resp resp = {};
+		struct seccomp_notif req = {};
+		int listener, round, task;
+		pid_t home;
+
+		if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0))
+			_exit(1);
+		listener = syscall(SYS_seccomp, SECCOMP_SET_MODE_FILTER,
+				   SECCOMP_FILTER_FLAG_NEW_LISTENER, &prog);
+		if (listener < 0)
+			_exit(2);
+
+		/* First at home, where it works, then into the cell. */
+		for (round = 0; round < 2; round++) {
+			if (!round) {
+				home = fork();
+				if (home < 0)
+					_exit(3);
+				if (!home) {
+					struct rusage ru;
+
+					_exit(getrusage(RUSAGE_SELF, &ru) == -1 &&
+					      errno == EACCES ? 0 : 1);
+				}
+				task = syscall(SYS_pidfd_open, home, 0);
+			} else {
+				task = spawn(self->c.cfd, NULL, "seccomp", NULL, NULL);
+			}
+			if (task < 0)
+				_exit(4);
+
+			/* Nothing shows on a listener when the task is gone. */
+			if (wait_for(listener, task))
+				_exit(11);
+			close(task);
+			memset(&req, 0, sizeof(req));
+			if (ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req))
+				_exit(5);
+			addfd.id = req.id;
+			addfd.srcfd = self->c.cfd;
+			if (!round) {
+				if (ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd) < 0)
+					_exit(6);
+			} else if (ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd) != -1 ||
+				   errno != EPERM) {
+				_exit(7);
+			}
+			resp.id = req.id;
+			resp.error = -EACCES;
+			if (ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp))
+				_exit(8);
+			if (!round && (waitpid(home, &status, 0) != home || status))
+				_exit(9);
+		}
+		_exit(cell_wait(self->c.cfd) ? 10 : 0);
+	}
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(WIFEXITED(status) ? WEXITSTATUS(status) : -1, 0);
+}
+
+/* The exec of an embryo is no system call. This is how a filter prevents it. */
+TEST_F(cell, seccomp_can_deny_a_start)
+{
+	int status;
+	pid_t pid;
+
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536 }), 0);
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (!pid) {
+		if (seccomp_deny(__NR_pidfd_configure))
+			_exit(1);
+		if (spawn(self->c.cfd, NULL, "exit", "0", NULL) >= 0)
+			_exit(2);
+		_exit(errno == EACCES ? 0 : 3);
+	}
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(WIFEXITED(status) ? WEXITSTATUS(status) : -1, 0);
+	/* Nothing ever ran. */
+	EXPECT_EQ(cg_populated(self->c.cg), 0);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/cell/cell_test.h b/tools/testing/selftests/cell/cell_test.h
new file mode 100644
index 000000000000..fdd3a55358dd
--- /dev/null
+++ b/tools/testing/selftests/cell/cell_test.h
@@ -0,0 +1,586 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Cells: build them, run things in them, kill them, and try everything that is
+ * not supposed to work. This is what the tests share: how to build a cell, how
+ * to spawn into one, and the fixture.
+ *
+ * They need root, cgroup2 and tmpfs. cell_child must sit next to the binaries.
+ */
+#ifndef CELL_TEST_H
+#define CELL_TEST_H
+
+#define _GNU_SOURCE
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <poll.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/auxv.h>
+#include <sys/mount.h>
+#include <grp.h>
+#include <net/if.h>
+#include <sys/ioctl.h>
+#include <sys/prctl.h>
+#include <sys/ptrace.h>
+#include <sys/resource.h>
+#include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/sysmacros.h>
+#include <sys/un.h>
+#include <sys/wait.h>
+#include <sys/xattr.h>
+#include <linux/capability.h>
+#include <linux/keyctl.h>
+#include <linux/filter.h>
+#include <linux/fs.h>
+#include <linux/loop.h>
+#include <linux/mount.h>
+#include <linux/seccomp.h>
+
+#include "../kselftest_harness.h"
+#include "cell_util.h"
+
+#ifndef OPEN_TREE_NAMESPACE
+#define OPEN_TREE_NAMESPACE	(1 << 1)
+#endif
+#ifndef MOUNT_ATTR_IDMAP
+#define MOUNT_ATTR_IDMAP	0x00100000
+#endif
+
+static inline int sys_fsopen(const char *fs, unsigned int flags)
+{
+	return syscall(SYS_fsopen, fs, flags);
+}
+
+static inline int sys_fsconfig(int fd, unsigned int cmd, const char *key, const void *val, int aux)
+{
+	return syscall(SYS_fsconfig, fd, cmd, key, val, aux);
+}
+
+static inline int sys_fsmount(int fd, unsigned int flags, unsigned int attr)
+{
+	return syscall(SYS_fsmount, fd, flags, attr);
+}
+
+static inline int sys_move_mount(int from, const char *fp, int to, const char *tp,
+				 unsigned int flags)
+{
+	return syscall(SYS_move_mount, from, fp, to, tp, flags);
+}
+
+static inline int sys_open_tree(int dfd, const char *path, unsigned int flags)
+{
+	return syscall(SYS_open_tree, dfd, path, flags);
+}
+
+static inline int sys_mount_setattr(int dfd, const char *path, unsigned int flags,
+			     struct mount_attr *attr, size_t size)
+{
+	return syscall(SYS_mount_setattr, dfd, path, flags, attr, size);
+}
+
+static inline int sys_pidfd_open(pid_t pid, unsigned int flags)
+{
+	return syscall(SYS_pidfd_open, pid, flags);
+}
+
+#define CGROOT	"/tmp/cell_test.cgroup"
+
+static int child_fd = -1;
+static int cg_seq;
+
+/* What goes into a cell. */
+#define CAP(x)	(1ULL << CAP_##x)
+
+struct build {
+	unsigned int	ids;		/* 0: leave alone */
+	__u64		caps;		/* likewise */
+	bool		no_idmap;	/* leave the tree as it is */
+	bool		shared;		/* make the tree a peer of something */
+	bool		no_seal;
+	int		data;		/* a detached mount to put at /data, or 0 */
+	int		net;		/* a network namespace to share, or 0 */
+	const char	*net_str;	/* or "new" */
+	__u64		net_rights;	/* CELL_NET_* */
+	bool		tun;		/* a node for /dev/net/tun, at /tun */
+	bool		keep_root;	/* leave a file descriptor on the mount namespace */
+	bool		cgroupfs;	/* all of cgroupfs at /data, not just the budget */
+	const char	*bind;		/* or this, as it is */
+	int		overlay;	/* or an overlay, see OVL_* */
+	const char	*bind_file;	/* a file of the host's, as it is, at /bound */
+};
+
+#define OVL_IDMAPPED		1	/* the overlay is idmapped for the cell, as it should be */
+#define OVL_LOWER_IDMAPPED	2	/* its lower layer is, and nothing else */
+
+struct cellctx {
+	int	cfd;
+	int	tree;		/* the detached tmpfs that becomes "/" */
+	int	raw;		/* the same filesystem as the host sees it */
+	int	cgfd;
+	int	rootfd;		/* see keep_root */
+	int	layers;		/* what an overlay is made of, as the host sees it */
+	char	cg[128];
+};
+
+static inline int copy_child(int dirfd, const char *name)
+{
+	static char buf[65536];
+	off_t off = 0;
+	ssize_t n;
+	int out;
+
+	out = openat(dirfd, name, O_CREAT | O_WRONLY, 0755);
+	if (out < 0)
+		return -1;
+	while ((n = pread(child_fd, buf, sizeof(buf), off)) > 0) {
+		if (write(out, buf, n) != n)
+			return -1;
+		off += n;
+	}
+	close(out);
+	return n;
+}
+
+static inline int new_tmpfs(void)
+{
+	int fs, mnt;
+
+	fs = sys_fsopen("tmpfs", FSOPEN_CLOEXEC);
+	if (fs < 0)
+		return -1;
+	if (sys_fsconfig(fs, FSCONFIG_CMD_CREATE, NULL, NULL, 0))
+		return -1;
+	mnt = sys_fsmount(fs, FSMOUNT_CLOEXEC, 0);
+	close(fs);
+	return mnt;
+}
+
+/* Returns 0, or the step that failed with errno set. */
+/* VFS_CAP_REVISION_2, cap_net_raw permitted and effective. */
+static const unsigned char fscap_v2[20] = {
+	0x01, 0x00, 0x00, 0x02, 0x00, 0x20, 0x00, 0x00,
+};
+
+static inline int put_file(int dirfd, const char *name)
+{
+	int fd = openat(dirfd, name, O_CREAT | O_WRONLY, 0644);
+
+	if (fd < 0 || write(fd, "lower", 5) != 5)
+		return -1;
+	return close(fd);
+}
+
+/* An overlay at /data. Its layers are in a tmpfs of the host's, c->layers. */
+static inline int add_overlay(struct cellctx *c, int how)
+{
+	struct mount_attr attr = { .attr_set = MOUNT_ATTR_IDMAP, .userns_fd = c->cfd };
+	int lower, rw, upper, work, fs, mnt;
+
+	c->layers = new_tmpfs();
+	if (c->layers < 0 || mkdirat(c->layers, "lower", 0755) || mkdirat(c->layers, "rw", 0755) ||
+	    mkdirat(c->layers, "rw/upper", 0755) || mkdirat(c->layers, "rw/work", 0755) ||
+	    put_file(c->layers, "lower/file"))
+		return -1;
+	lower = sys_open_tree(c->layers, "lower", OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC);
+	rw = sys_open_tree(c->layers, "rw", OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC);
+	if (lower < 0 || rw < 0)
+		return -2;
+	if (how == OVL_LOWER_IDMAPPED &&
+	    sys_mount_setattr(lower, "", AT_EMPTY_PATH, &attr, sizeof(attr)))
+		return -3;
+	upper = openat(rw, "upper", O_PATH | O_DIRECTORY | O_CLOEXEC);
+	work = openat(rw, "work", O_PATH | O_DIRECTORY | O_CLOEXEC);
+	fs = sys_fsopen("overlay", FSOPEN_CLOEXEC);
+	if (fs < 0)
+		return -ENODEV;
+	if (sys_fsconfig(fs, FSCONFIG_SET_FD, "lowerdir+", NULL, lower) ||
+	    sys_fsconfig(fs, FSCONFIG_SET_FD, "upperdir", NULL, upper) ||
+	    sys_fsconfig(fs, FSCONFIG_SET_FD, "workdir", NULL, work) ||
+	    sys_fsconfig(fs, FSCONFIG_CMD_CREATE, NULL, NULL, 0))
+		return -4;
+	mnt = sys_fsmount(fs, FSMOUNT_CLOEXEC, 0);
+	if (mnt < 0)
+		return -5;
+	if (how == OVL_IDMAPPED &&
+	    sys_mount_setattr(mnt, "", AT_EMPTY_PATH, &attr, sizeof(attr)))
+		return -6;
+	if (sys_move_mount(mnt, "", c->tree, "data", MOVE_MOUNT_F_EMPTY_PATH))
+		return -7;
+	close(mnt);
+	close(fs);
+	close(work);
+	close(upper);
+	close(rw);
+	close(lower);
+	return 0;
+}
+
+static inline int cell_build(struct cellctx *c, const struct build *b)
+{
+	struct mount_attr attr = { .attr_set = MOUNT_ATTR_IDMAP };
+	int pidns, fs, proc, nsfd;
+
+	memset(c, 0, sizeof(*c));
+	c->cfd = c->tree = c->raw = c->cgfd = c->rootfd = c->layers = -1;
+
+	snprintf(c->cg, sizeof(c->cg), CGROOT "/cell.%d.%d", getpid(), cg_seq++);
+	if (mkdir(c->cg, 0755))
+		return 1;
+	c->cgfd = open(c->cg, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	if (c->cgfd < 0)
+		return 2;
+
+	c->cfd = cell_create(CELL_SELF, 0);
+	if (c->cfd < 0)
+		return 3;
+	if (b->ids && cell_configure(c->cfd, CELL_SET_BINARY, "ids", &b->ids, sizeof(b->ids)))
+		return 4;
+	if (b->caps && cell_configure(c->cfd, CELL_SET_BINARY, "caps", &b->caps, sizeof(b->caps)))
+		return 4;
+
+	/* The tree, from scratch, one mount at a time. */
+	c->tree = new_tmpfs();
+	if (c->tree < 0)
+		return 5;
+	if (copy_child(c->tree, "cell_child") || mkdirat(c->tree, "proc", 0755) ||
+	    mkdirat(c->tree, "data", 0755) ||
+	    mkdirat(c->tree, "tmp", 01777) || fchmodat(c->tree, "tmp", 01777, 0))
+		return 6;
+	c->raw = sys_open_tree(c->tree, "", AT_EMPTY_PATH | OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC);
+	if (c->raw < 0)
+		return 6;
+	if (b->bind_file && put_file(c->tree, "bound"))
+		return 6;
+	if (b->tun && (mknodat(c->tree, "tun", S_IFCHR | 0666, makedev(10, 200)) ||
+		       fchmodat(c->tree, "tun", 0666, 0)))
+		return 6;
+	pidns = openat(c->tree, "su", O_CREAT | O_WRONLY, 0755);
+	if (pidns < 0 || fchmod(pidns, 06755) ||
+	    fsetxattr(pidns, "security.capability", fscap_v2, sizeof(fscap_v2), 0))
+		return 6;
+	close(pidns);
+	if (!b->no_idmap && b->ids > 1) {
+		attr.userns_fd = c->cfd;
+		if (sys_mount_setattr(c->tree, "", AT_EMPTY_PATH, &attr, sizeof(attr)))
+			return 7;
+	}
+
+	pidns = cell_open(c->cfd, CELL_OPEN_SLOT, "pids", NULL, 0);
+	if (pidns < 0)
+		return 8;
+	fs = sys_fsopen("proc", FSOPEN_CLOEXEC);
+	if (fs < 0 || sys_fsconfig(fs, FSCONFIG_SET_FD, "pidns", NULL, pidns) ||
+	    sys_fsconfig(fs, FSCONFIG_CMD_CREATE, NULL, NULL, 0))
+		return 9;
+	proc = sys_fsmount(fs, FSMOUNT_CLOEXEC, 0);
+	if (proc < 0)
+		return 10;
+	if (sys_move_mount(proc, "", c->tree, "proc", MOVE_MOUNT_F_EMPTY_PATH))
+		return 11;
+	close(pidns);
+	close(fs);
+	close(proc);
+
+	if (b->data) {
+		if (b->ids > 1 &&
+		    sys_mount_setattr(b->data, "", AT_EMPTY_PATH, &attr, sizeof(attr)))
+			return 19;
+		if (sys_move_mount(b->data, "", c->tree, "data", MOVE_MOUNT_F_EMPTY_PATH))
+			return 20;
+	}
+
+	if (b->cgroupfs || b->bind) {
+		int dir = open(b->bind ?: CGROOT, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+		int mnt = sys_open_tree(dir, "", AT_EMPTY_PATH | OPEN_TREE_CLONE |
+					OPEN_TREE_CLOEXEC);
+
+		if (mnt < 0 ||
+		    sys_move_mount(mnt, "", c->tree, "data", MOVE_MOUNT_F_EMPTY_PATH))
+			return 21;
+		close(mnt);
+		close(dir);
+	}
+
+	if (b->overlay && add_overlay(c, b->overlay))
+		return 22;
+
+	if (b->bind_file) {
+		int mnt = sys_open_tree(AT_FDCWD, b->bind_file,
+					OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC);
+
+		if (mnt < 0 ||
+		    sys_move_mount(mnt, "", c->tree, "bound", MOVE_MOUNT_F_EMPTY_PATH))
+			return 23;
+		close(mnt);
+	}
+
+	if (b->shared) {
+		struct mount_attr sh = { .propagation = MS_SHARED };
+
+		if (sys_mount_setattr(c->tree, "", AT_EMPTY_PATH | AT_RECURSIVE, &sh, sizeof(sh)))
+			return 12;
+	}
+
+	nsfd = sys_open_tree(c->tree, "", AT_EMPTY_PATH | AT_RECURSIVE |
+			     OPEN_TREE_NAMESPACE | OPEN_TREE_CLOEXEC);
+	if (nsfd < 0)
+		return 13;
+
+	if (cell_configure(c->cfd, CELL_SET_FD, "root", NULL, nsfd))
+		return 14;
+	if (b->keep_root)
+		c->rootfd = nsfd;
+	else
+		close(nsfd);
+	if (cell_configure(c->cfd, CELL_SET_FD, "budget", NULL, c->cgfd))
+		return 15;
+	if (cell_configure(c->cfd, CELL_SET_STRING, "hostname", "celltest", 0))
+		return 16;
+	if (b->net && cell_configure(c->cfd, CELL_SET_FD, "net", NULL, b->net))
+		return 17;
+	if (b->net_str && cell_configure(c->cfd, CELL_SET_STRING, "net", b->net_str, 0))
+		return 17;
+	if (b->net_rights && cell_configure(c->cfd, CELL_SET_BINARY, "net-rights", &b->net_rights,
+					    sizeof(b->net_rights)))
+		return 23;
+	if (!b->no_seal && cell_configure(c->cfd, CELL_CMD_SEAL, NULL, NULL, 0))
+		return 18;
+	return 0;
+}
+
+static inline void cell_cleanup(struct cellctx *c)
+{
+	int i;
+
+	if (c->cfd >= 0) {
+		cell_kill(c->cfd, 0);
+		close(c->cfd);
+	}
+	if (c->tree >= 0)
+		close(c->tree);
+	if (c->raw >= 0)
+		close(c->raw);
+	if (c->cgfd >= 0)
+		close(c->cgfd);
+	if (c->rootfd > 0)
+		close(c->rootfd);
+	if (c->layers > 0)
+		close(c->layers);
+	for (i = 0; i < 100 && rmdir(c->cg) && errno == EBUSY; i++)
+		usleep(20000);
+}
+
+/* <linux/pidfd.h> does not get along with <fcntl.h>. */
+struct pidfd_info_v0 {
+	__u64 mask, cgroupid;
+	__u32 pid, tgid, ppid, ruid, rgid, euid, egid, suid, sgid, fsuid, fsgid;
+	__s32 exit_code;
+};
+#define PIDFD_GET_INFO_V0	_IOWR(0xFF, 11, struct pidfd_info_v0)
+#define PIDFD_INFO_EXIT_V0	(1 << 3)
+
+/* The pid of what a pidfd is on, as the caller sees it, or -1. */
+static inline pid_t pidfd_nr(int pidfd)
+{
+	struct pidfd_info_v0 info = {};
+
+	if (ioctl(pidfd, PIDFD_GET_INFO_V0, &info))
+		return -1;
+	return info.pid;
+}
+
+/* argv as a block of NUL terminated strings: "cell_child\0<a>\0<b>\0<c>\0" */
+static inline int set_argv(int pidfd, const char *a, const char *b, const char *c)
+{
+	char blk[256];
+	int len = 0;
+
+	len += sprintf(blk + len, "cell_child") + 1;
+	if (a)
+		len += sprintf(blk + len, "%s", a) + 1;
+	if (b)
+		len += sprintf(blk + len, "%s", b) + 1;
+	if (c)
+		len += sprintf(blk + len, "%s", c) + 1;
+	return pidfd_configure(pidfd, PIDFD_SET_BINARY, "argv", blk, len);
+}
+
+/* There is no task, and so no pid, before it is started. */
+static inline int prepare(int cfd, const char *a, const char *b, const char *c)
+{
+	int pidfd = pidfd_open_empty(cfd, 0);
+	int null;
+
+	if (pidfd < 0)
+		return -1;
+	null = open("/dev/null", O_RDWR | O_CLOEXEC);
+	if (pidfd_configure(pidfd, PIDFD_SET_STRING, "exec", "/cell_child", 0) ||
+	    set_argv(pidfd, a, b, c) ||
+	    pidfd_configure(pidfd, PIDFD_SET_BINARY, "envp", "CELL=yes", 9) ||
+	    pidfd_configure(pidfd, PIDFD_SET_FD, "0", NULL, null) ||
+	    pidfd_configure(pidfd, PIDFD_SET_FD, "1", NULL, STDERR_FILENO) ||
+	    pidfd_configure(pidfd, PIDFD_SET_FD, "2", NULL, STDERR_FILENO)) {
+		close(pidfd);
+		return -1;
+	}
+	close(null);
+	return pidfd;
+}
+
+static inline int spawn(int cfd, pid_t *pid, const char *a, const char *b, const char *c)
+{
+	int pidfd = prepare(cfd, a, b, c);
+
+	if (pidfd >= 0 && pidfd_configure(pidfd, PIDFD_CMD_START, NULL, NULL, 0)) {
+		close(pidfd);
+		return -1;
+	}
+	if (pidfd >= 0 && pid)
+		*pid = pidfd_nr(pidfd);
+	return pidfd;
+}
+
+/*
+ * Wait for there to be something to read or to accept on @fd. Not for longer than
+ * there is the task of @pidfd to provide it: its death need not show on @fd.
+ */
+static inline int wait_for(int fd, int pidfd)
+{
+	struct pollfd p[2] = {
+		{ .fd = fd, .events = POLLIN }, { .fd = pidfd, .events = POLLIN },
+	};
+
+	if (poll(p, 2, 20000) <= 0)
+		return -1;
+	return p[0].revents & POLLIN ? 0 : -1;
+}
+
+/*
+ * How the task of @pidfd ended, or -99. A pidfd is readable once the task has
+ * exited. How it did is on record only once it has been reaped, which nobody has to
+ * do for a task that was spawned, and which is when the pidfd hangs up.
+ */
+static inline int task_wait(int pidfd)
+{
+	struct pidfd_info_v0 info = { .mask = PIDFD_INFO_EXIT_V0 };
+	struct pollfd p = { .fd = pidfd };
+
+	if (poll(&p, 1, 20000) != 1 || !(p.revents & POLLHUP))
+		return -99;
+	if (ioctl(pidfd, PIDFD_GET_INFO_V0, &info) || !(info.mask & PIDFD_INFO_EXIT_V0))
+		return -99;
+	return info.exit_code;
+}
+
+/* How the cell ended, once it is dead, or -2 if that takes too long. */
+static inline int cell_wait(int cfd)
+{
+	struct pollfd pfd = { .fd = cfd, .events = POLLIN };
+	int status = -1;
+
+	if (poll(&pfd, 1, 20000) != 1)
+		return -2;
+	if (read(cfd, &status, sizeof(status)) != sizeof(status))
+		return -1;
+	return status;
+}
+
+static inline unsigned int cell_state(int cfd)
+{
+	struct cell_info info = { .mask = CELL_INFO_STATE };
+
+	if (cell_info(cfd, &info, sizeof(info), 0) || !(info.mask & CELL_INFO_STATE))
+		return ~0U;
+	return info.state;
+}
+
+/* Not by cgroup.procs, which does not list a task that is on its way out. */
+static inline int cg_populated(const char *cg)
+{
+	char path[192], buf[256] = {};
+	int fd;
+
+	snprintf(path, sizeof(path), "%s/cgroup.events", cg);
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return -1;
+	if (read(fd, buf, sizeof(buf) - 1) < 0)
+		buf[0] = 0;
+	close(fd);
+	if (strstr(buf, "populated 0"))
+		return 0;
+	return strstr(buf, "populated 1") ? 1 : -1;
+}
+
+/* The kuid the host sees @pid run as. */
+static inline long host_uid(pid_t pid)
+{
+	char path[64];
+	struct stat st;
+
+	snprintf(path, sizeof(path), "/proc/%d", pid);
+	if (stat(path, &st))
+		return -1;
+	return st.st_uid;
+}
+
+static inline int write_file(const char *path, const char *val)
+{
+	int fd = open(path, O_WRONLY), ret;
+
+	if (fd < 0)
+		return -1;
+	ret = write(fd, val, strlen(val)) < 0 ? -1 : 0;
+	close(fd);
+	return ret;
+}
+
+FIXTURE(cell) {
+	struct cellctx c;
+};
+
+FIXTURE_SETUP(cell)
+{
+	char path[PATH_MAX], *slash;
+
+	if (geteuid())
+		SKIP(return, "needs root");
+	if (cell_create(-1, 0) == -1 && errno == ENOSYS)
+		SKIP(return, "no cells in this kernel");
+
+	/* Next to this binary. */
+	snprintf(path, sizeof(path) - 16, "%s", (char *)getauxval(AT_EXECFN));
+	slash = strrchr(path, '/');
+	strcpy(slash ? slash + 1 : path, "cell_child");
+	child_fd = open(path, O_RDONLY | O_CLOEXEC);
+	ASSERT_GE(child_fd, 0);
+
+	mkdir(CGROOT, 0755);
+	if (mount("none", CGROOT, "cgroup2", 0, NULL) && errno != EBUSY)
+		SKIP(return, "no cgroup2");
+	self->c.cfd = self->c.tree = self->c.raw = self->c.cgfd = -1;
+}
+
+FIXTURE_TEARDOWN(cell)
+{
+	cell_cleanup(&self->c);
+	umount2(CGROOT, MNT_DETACH);
+	close(child_fd);
+}
+
+#define RUN_IN_CELL(what) do {							\
+	int pidfd;								\
+	ASSERT_EQ(cell_build(&self->c, &(struct build){ .ids = 65536 }), 0);	\
+	pidfd = spawn(self->c.cfd, NULL, what, NULL, NULL);			\
+	ASSERT_GE(pidfd, 0);							\
+	EXPECT_EQ(cell_wait(self->c.cfd), 0);					\
+	close(pidfd);								\
+} while (0)
+
+#endif /* CELL_TEST_H */
diff --git a/tools/testing/selftests/cell/cell_util.h b/tools/testing/selftests/cell/cell_util.h
new file mode 100644
index 000000000000..7a0946d87e5a
--- /dev/null
+++ b/tools/testing/selftests/cell/cell_util.h
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef CELL_UTIL_H
+#define CELL_UTIL_H
+
+#include <fcntl.h>
+#include <stdint.h>
+#include <stddef.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <linux/types.h>
+
+#include "../../../../include/uapi/linux/cell.h"
+
+#ifndef CELL_SELF
+#define CELL_SELF		-10005
+#endif
+
+#ifndef __NR_cell_create
+#define __NR_cell_create	473
+#define __NR_cell_configure	474
+#define __NR_cell_info		475
+#define __NR_cell_open		476
+#define __NR_cell_kill		477
+#define __NR_pidfd_configure	478
+#endif
+
+/* <linux/pidfd.h> does not get along with <fcntl.h>. */
+#ifndef PIDFD_EMPTY
+#define PIDFD_EMPTY		O_NOCTTY
+
+enum pidfd_configure_cmd {
+	PIDFD_SET_STRING	= 0,
+	PIDFD_SET_BINARY	= 1,
+	PIDFD_SET_FD		= 2,
+	PIDFD_CMD_START		= 3,
+};
+
+struct pidfd_cred {
+	__u32 uid;
+	__u32 gid;
+	__u32 ngroups;
+	__u32 __spare;
+	__aligned_u64 groups;
+};
+#endif
+
+#ifndef CLONE_INTO_CGROUP
+#define CLONE_INTO_CGROUP	(1ULL << 33)
+#endif
+
+#define CELL_WINDOW_FIRST	0x80000000U
+#define CELL_WINDOW_LAST	0xfffeffffU
+
+struct cell_clone_args {
+	__aligned_u64 flags;
+	__aligned_u64 pidfd;
+	__aligned_u64 child_tid;
+	__aligned_u64 parent_tid;
+	__aligned_u64 exit_signal;
+	__aligned_u64 stack;
+	__aligned_u64 stack_size;
+	__aligned_u64 tls;
+	__aligned_u64 set_tid;
+	__aligned_u64 set_tid_size;
+	__aligned_u64 cgroup;
+};
+
+static inline int cell_create(int parent, unsigned int flags)
+{
+	return syscall(__NR_cell_create, parent, flags);
+}
+
+static inline int cell_configure(int cfd, unsigned int cmd, const char *key,
+				 const void *value, int aux)
+{
+	return syscall(__NR_cell_configure, cfd, cmd, key, value, aux);
+}
+
+static inline int cell_info(int cfd, struct cell_info *info, size_t size,
+			    unsigned int flags)
+{
+	return syscall(__NR_cell_info, cfd, info, size, flags);
+}
+
+static inline int cell_open(int cfd, unsigned int what, const char *key,
+			    const void *arg, unsigned int flags)
+{
+	return syscall(__NR_cell_open, cfd, what, key, arg, flags);
+}
+
+static inline int cell_kill(int cfd, unsigned int flags)
+{
+	return syscall(__NR_cell_kill, cfd, flags);
+}
+
+/* A pidfd that no task is attached to yet, for one in the cell @cfd. */
+static inline int pidfd_open_empty(int cfd, unsigned int flags)
+{
+	return syscall(SYS_pidfd_open, cfd, PIDFD_EMPTY | flags);
+}
+
+static inline int pidfd_configure(int pidfd, unsigned int cmd, const char *key,
+				  const void *value, int aux)
+{
+	return syscall(__NR_pidfd_configure, pidfd, cmd, key, value, aux);
+}
+
+#endif /* CELL_UTIL_H */
diff --git a/tools/testing/selftests/cell/config b/tools/testing/selftests/cell/config
new file mode 100644
index 000000000000..262912e589d6
--- /dev/null
+++ b/tools/testing/selftests/cell/config
@@ -0,0 +1,35 @@
+CONFIG_CELLS=y
+CONFIG_USER_NS=y
+CONFIG_PID_NS=y
+CONFIG_NET_NS=y
+CONFIG_VETH=y
+CONFIG_IPC_NS=y
+CONFIG_UTS_NS=y
+CONFIG_CGROUPS=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_XATTR=y
+CONFIG_OVERLAY_FS=y
+CONFIG_DEBUG_FS=y
+CONFIG_FAULT_INJECTION=y
+CONFIG_FAULT_INJECTION_DEBUG_FS=y
+CONFIG_FAILSLAB=y
+CONFIG_MEMCG=y
+CONFIG_CGROUP_PIDS=y
+CONFIG_IPV6=y
+CONFIG_NETFILTER=y
+CONFIG_NETFILTER_ADVANCED=y
+CONFIG_NETFILTER_NETLINK=y
+CONFIG_NETFILTER_NETLINK_OSF=y
+CONFIG_NETFILTER_XTABLES=y
+CONFIG_NF_CONNTRACK=y
+CONFIG_NF_CT_NETLINK=y
+CONFIG_NETFILTER_NETLINK_QUEUE=y
+CONFIG_NETFILTER_NETLINK_GLUE_CT=y
+CONFIG_NF_CT_NETLINK_HELPER=y
+CONFIG_NF_TABLES=y
+CONFIG_NF_TABLES_INET=y
+CONFIG_IP_NF_IPTABLES=y
+CONFIG_IP_NF_FILTER=y
+CONFIG_PACKET=y
+CONFIG_TUN=y
+CONFIG_XFRM_USER=y

-- 
2.55.0

