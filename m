Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C39E488D92
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 17:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786728579; cv=none; b=I4VeAhR74PZPfGbqHteaSihDw1xPm8YLSn4LIF5EEpdF4+4qrbhfom3Mzr0XbdbdHG4+TEhdmg7Ito1hRJwjHZn5KPpWc07tfd/H0B4nOKL5wlZGb+kLLdF/mUk4ZP89PlLdQQJo/qo462I0EcqpOnq+NC3aT2wnbvqeeTBVhD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786728579; c=relaxed/simple;
	bh=qRP6Fzrjzx581TLe+ODwZowV0EVL4ovgm7DtoSn/IK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b80cBqxZ+XGh+qBV82GxatJVpuUKVbUu3/ltnlIbPn6YXyPFnSya0fAg3pdNrXPUcNRv3kSNuGyzMKJCWJ6vHDSCjgvaa8zG5PZEiRlKdczNPg/J7PLXrjEaqF0JBBxB5Se9eV10i9BeopyFIYMnQrCF88nH0rlkN5jYAT9uVOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=KGLCyum5; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="KGLCyum5"
X-KPN-MessageId: b39acb9e-9805-11f1-bfbb-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id b39acb9e-9805-11f1-bfbb-00505699b430;
	Fri, 14 Aug 2026 19:29:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=yuhW5fo8gy1KkAMB4l09VmCtFZcOuXgv/fiRdg5ZL1E=;
	b=KGLCyum53+XmV5S6ATj7uHO9TLhn2Kn0gS4xKSiVEFVp0WbEbLX2cPwDX9ELqy4KrjyncWeDXUnek
	 coJXce0CddFWuxfq1e8fLrmQTgzhk0/YF+qUH+4q80oWHBMteNY2E5Ivla2s19vKbrEmQwdK/QW1Nm
	 KFzF+0cFi7v5qyqXbDp9jm44nsqx4OngRBK2eCMkaoZo9x0jC3y5+Nmtt9voX+alQ50t5itUpGJcv2
	 e1Y2VjhHa8xJWZ536SWEytjPwWV1YMfMrEZ5vppH+t4s3S7GM9nmJWD8Ur/QLTIVDp+fsaJcXtcmRO
	 IuiNy1hhYdd3gVGZvUVSUBQCgcsZSCA==
X-KPN-MID: 33|z2VfLob3x0ZwACcXMDEtiWbjkvvHAVYu/HytlrEhyimL1vnwAJ/bD6LRSGFc97t
 7xAMk/dNHaT3Pa/rrSOnH8JeK0GYXaY0b3u9ye8x0wAQ=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|V/RJD6lPIMVNghFN/+E8FZFhK/71A3hofhx5fDF61az3ubWBpgh5s9Xx2qrKUYb
 USXWJhGcxb4jNuOletpvRBQ==
Received: from fedora (unknown [27.1.3.178])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 906404dc-9805-11f1-8ddb-00505699d6e5;
	Fri, 14 Aug 2026 19:29:25 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: brauner@kernel.org,
	cyphar@cyphar.com,
	kuniyu@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jkoolstra@xs4all.nl
Subject: [PATCH net-next v7 4/4] selftest: Add tests for useful handling of LSM denials on SCM_RIGHTS
Date: Fri, 14 Aug 2026 13:28:06 -0400
Message-ID: <20260814172806.158954-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813162818.149248-1-jkoolstra@xs4all.nl>
References: <20260813162818.149248-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tests SCM_RIGHTS fd passing on a socket with the new socket option
SO_RIGHTS_NOTRUNC turned on. To hook into the security_file_receive()
call, BPF is used. The BPF program shares a hashmap with userspace that
lists the inos to be blocked (of the receiver tgid).

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 .../testing/selftests/net/af_unix/.gitignore  |   2 +
 tools/testing/selftests/net/af_unix/Makefile  |   8 +
 tools/testing/selftests/net/af_unix/config    |   7 +
 .../net/af_unix/scm_rights_denial_lsm.bpf.c   |  36 +++
 .../net/af_unix/scm_rights_denial_lsm.c       | 292 ++++++++++++++++++
 5 files changed, 345 insertions(+)
 create mode 100644 tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.bpf.c
 create mode 100644 tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.c

diff --git a/tools/testing/selftests/net/af_unix/.gitignore b/tools/testing/selftests/net/af_unix/.gitignore
index 973176644103..954f0958dd03 100644
--- a/tools/testing/selftests/net/af_unix/.gitignore
+++ b/tools/testing/selftests/net/af_unix/.gitignore
@@ -3,6 +3,8 @@ msg_oob
 scm_inq
 scm_pidfd
 scm_rights
+scm_rights_denial_lsm
+scm_rights_denial_lsm.bpf.o
 so_peek_off
 unix_connect
 unix_connreset
diff --git a/tools/testing/selftests/net/af_unix/Makefile b/tools/testing/selftests/net/af_unix/Makefile
index 57d159803a3a..a66f10fb0c23 100644
--- a/tools/testing/selftests/net/af_unix/Makefile
+++ b/tools/testing/selftests/net/af_unix/Makefile
@@ -11,10 +11,18 @@ TEST_GEN_PROGS := \
 	scm_inq \
 	scm_pidfd \
 	scm_rights \
+	scm_rights_denial_lsm \
 	so_peek_off \
 	unix_connect \
 	unix_connreset \
 	unix_listen \
 # end of TEST_GEN_PROGS
 
+TEST_GEN_FILES := scm_rights_denial_lsm.bpf.o
+
 include ../../lib.mk
+include ../bpf.mk
+
+$(OUTPUT)/scm_rights_denial_lsm: $(BPFOBJ)
+$(OUTPUT)/scm_rights_denial_lsm: CFLAGS += -I$(SCRATCH_DIR)/include
+$(OUTPUT)/scm_rights_denial_lsm: LDLIBS += -lelf -lz
diff --git a/tools/testing/selftests/net/af_unix/config b/tools/testing/selftests/net/af_unix/config
index 41dbb03c747e..46450fea8407 100644
--- a/tools/testing/selftests/net/af_unix/config
+++ b/tools/testing/selftests/net/af_unix/config
@@ -1,4 +1,11 @@
 CONFIG_AF_UNIX_OOB=y
+CONFIG_BPF=y
+CONFIG_BPF_EVENTS=y
+CONFIG_BPF_JIT=y
+CONFIG_BPF_LSM=y
+CONFIG_BPF_SYSCALL=y
+CONFIG_DEBUG_INFO_BTF=y
+CONFIG_SECURITY=y
 CONFIG_UNIX=y
 CONFIG_UNIX_DIAG=m
 CONFIG_USER_NS=y
diff --git a/tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.bpf.c b/tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.bpf.c
new file mode 100644
index 000000000000..4f2414465bfd
--- /dev/null
+++ b/tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.bpf.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <linux/errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct inode {
+	unsigned long i_ino;
+} __attribute__((preserve_access_index));
+
+struct file {
+	struct inode *f_inode;
+} __attribute__((preserve_access_index));
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 16);
+	__type(key, __u64);	/* inode number */
+	__type(value, __u32);	/* tgid of the receiver being tested */
+} denied_inodes SEC(".maps");
+
+SEC("lsm/file_receive")
+int BPF_PROG(scm_rights_deny, struct file *file)
+{
+	__u32 tgid = bpf_get_current_pid_tgid() >> 32;
+	__u64 ino = file->f_inode->i_ino;
+	__u32 *owner;
+
+	owner = bpf_map_lookup_elem(&denied_inodes, &ino);
+	if (owner && *owner == tgid)
+		return -EPERM;
+
+	return 0;
+}
diff --git a/tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.c b/tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.c
new file mode 100644
index 000000000000..55c7ecdbb5fe
--- /dev/null
+++ b/tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.c
@@ -0,0 +1,292 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+
+#include "kselftest_harness.h"
+
+#ifndef SO_RIGHTS_NOTRUNC
+#define SO_RIGHTS_NOTRUNC 85
+#endif
+
+#define NR_FILES 2
+
+/* Per-file content, so a received fd can be matched to the file sent */
+#define SECRET(n) "secret %d", (n)
+
+/* Indices into the socketpair */
+#define SK_SENDER 0
+#define SK_RECEIVER 1
+
+FIXTURE(scm_rights_denial_bpf)
+{
+	struct bpf_object *obj;
+	struct bpf_link *link;
+	int map_fd;
+	int sk[2];
+	int files[NR_FILES];
+	__u64 inos[NR_FILES];
+	char paths[NR_FILES][64];
+};
+
+FIXTURE_VARIANT(scm_rights_denial_bpf)
+{
+	int sock_type;
+};
+
+FIXTURE_VARIANT_ADD(scm_rights_denial_bpf, stream)
+{
+	.sock_type = SOCK_STREAM,
+};
+
+FIXTURE_VARIANT_ADD(scm_rights_denial_bpf, dgram)
+{
+	.sock_type = SOCK_DGRAM,
+};
+
+FIXTURE_VARIANT_ADD(scm_rights_denial_bpf, seqpacket)
+{
+	.sock_type = SOCK_SEQPACKET,
+};
+
+FIXTURE_SETUP(scm_rights_denial_bpf)
+{
+	struct bpf_program *prog;
+	char lsms[256] = {};
+	int i, fd;
+
+	if (geteuid() != 0)
+		SKIP(return, "requires root");
+
+	fd = open("/sys/kernel/security/lsm", O_RDONLY);
+	ASSERT_GE(fd, 0);
+	ASSERT_LT(0, read(fd, lsms, sizeof(lsms) - 1));
+	close(fd);
+
+	if (!strstr(lsms, "bpf"))
+		SKIP(return, "BPF LSM not active (boot with lsm=...,bpf)");
+
+	self->obj = bpf_object__open_file("scm_rights_denial_lsm.bpf.o", NULL);
+	ASSERT_NE(NULL, self->obj);
+	ASSERT_EQ(0, bpf_object__load(self->obj));
+
+	prog = bpf_object__find_program_by_name(self->obj, "scm_rights_deny");
+	ASSERT_NE(NULL, prog);
+
+	self->link = bpf_program__attach_lsm(prog);
+	ASSERT_NE(NULL, self->link);
+
+	self->map_fd = bpf_object__find_map_fd_by_name(self->obj,
+						       "denied_inodes");
+	ASSERT_GE(self->map_fd, 0);
+
+	ASSERT_EQ(0, socketpair(AF_UNIX, variant->sock_type, 0, self->sk));
+
+	for (i = 0; i < NR_FILES; i++) {
+		struct stat st;
+
+		snprintf(self->paths[i], sizeof(self->paths[i]),
+			 "/tmp/scm_rights_denial_bpf.%d.XXXXXX", i);
+		self->files[i] = mkstemp(self->paths[i]);
+		ASSERT_GE(self->files[i], 0);
+
+		ASSERT_LT(0, dprintf(self->files[i], SECRET(i)));
+
+		ASSERT_EQ(0, fstat(self->files[i], &st));
+		self->inos[i] = st.st_ino;
+	}
+}
+
+FIXTURE_TEARDOWN(scm_rights_denial_bpf)
+{
+	bpf_link__destroy(self->link);
+	bpf_object__close(self->obj);
+
+	for (int i = 0; i < NR_FILES; i++) {
+		if (self->files[i] >= 0) {
+			close(self->files[i]);
+			unlink(self->paths[i]);
+		}
+	}
+
+	close(self->sk[SK_SENDER]);
+	close(self->sk[SK_RECEIVER]);
+}
+
+static int deny_inode(int map_fd, __u64 ino)
+{
+	__u32 tgid = getpid();
+
+	return bpf_map_update_elem(map_fd, &ino, &tgid, BPF_ANY);
+}
+
+static int set_notrunc(int sk)
+{
+	int one = 1;
+
+	return setsockopt(sk, SOL_SOCKET, SO_RIGHTS_NOTRUNC,
+			  &one, sizeof(one));
+}
+
+static int send_fds(int sk, int *fds, int n)
+{
+	char ctrl[CMSG_SPACE(NR_FILES * sizeof(int))] = {};
+	char data = 'x';
+	struct iovec iov = {
+		.iov_base = &data,
+		.iov_len = sizeof(data),
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+		.msg_control = ctrl,
+		.msg_controllen = CMSG_SPACE(n * sizeof(int)),
+	};
+	struct cmsghdr *cmsg = CMSG_FIRSTHDR(&msg);
+	int ret;
+
+	cmsg->cmsg_level = SOL_SOCKET;
+	cmsg->cmsg_type = SCM_RIGHTS;
+	cmsg->cmsg_len = CMSG_LEN(n * sizeof(int));
+	memcpy(CMSG_DATA(cmsg), fds, n * sizeof(int));
+
+	ret = sendmsg(sk, &msg, 0);
+	if (ret != 1)
+		return -1;
+
+	return 0;
+}
+
+static int recv_fd_slots(int sk, int *slots, int *msg_flags)
+{
+	int nr_slots;
+	char ctrl[CMSG_SPACE(NR_FILES * sizeof(int))];
+	char data;
+	struct iovec iov = {
+		.iov_base = &data,
+		.iov_len = sizeof(data),
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+		.msg_control = ctrl,
+		.msg_controllen = sizeof(ctrl),
+	};
+	struct cmsghdr *cmsg;
+
+	if (recvmsg(sk, &msg, 0) < 0)
+		return -1;
+
+	*msg_flags = msg.msg_flags;
+
+	cmsg = CMSG_FIRSTHDR(&msg);
+	if (!cmsg)
+		return 0;
+
+	nr_slots = (cmsg->cmsg_len - CMSG_LEN(0)) / sizeof(int);
+	memcpy(slots, CMSG_DATA(cmsg), nr_slots * sizeof(int));
+
+	return nr_slots;
+}
+
+/* Prove a received fd works by reading back the file's content. */
+static int check_secret(int fd, int idx)
+{
+	char want[32], got[32] = {};
+
+	snprintf(want, sizeof(want), SECRET(idx));
+	if (pread(fd, got, sizeof(got) - 1, 0) < 0)
+		return -1;
+
+	return strcmp(want, got);
+}
+
+TEST_F(scm_rights_denial_bpf, all_allowed)
+{
+	int slots[NR_FILES], nr_slots, flags;
+
+	ASSERT_EQ(0, set_notrunc(self->sk[SK_RECEIVER]));
+	ASSERT_EQ(0, send_fds(self->sk[SK_SENDER], self->files, NR_FILES));
+	nr_slots = recv_fd_slots(self->sk[SK_RECEIVER], slots, &flags);
+
+	ASSERT_EQ(NR_FILES, nr_slots);
+	EXPECT_EQ(0, flags & MSG_CTRUNC);
+
+	for (int i = 0; i < nr_slots; i++) {
+		ASSERT_GE(slots[i], 0);
+		EXPECT_EQ(0, check_secret(slots[i], i));
+		close(slots[i]);
+	}
+}
+
+TEST_F(scm_rights_denial_bpf, first_denied)
+{
+	int slots[NR_FILES], nr_slots, flags;
+
+	ASSERT_EQ(0, deny_inode(self->map_fd, self->inos[0]));
+
+	ASSERT_EQ(0, set_notrunc(self->sk[SK_RECEIVER]));
+	ASSERT_EQ(0, send_fds(self->sk[SK_SENDER], self->files, NR_FILES));
+	nr_slots = recv_fd_slots(self->sk[SK_RECEIVER], slots, &flags);
+
+	ASSERT_EQ(NR_FILES, nr_slots);
+	EXPECT_EQ(0, flags & MSG_CTRUNC);
+	
+	EXPECT_EQ(-EPERM, slots[0]);
+	for (int i = 1; i < nr_slots; i++) {
+		ASSERT_GE(slots[i], 0);
+		EXPECT_EQ(0, check_secret(slots[i], i));
+		close(slots[i]);
+	}
+}
+
+TEST_F(scm_rights_denial_bpf, all_denied)
+{
+	int slots[NR_FILES], nr_slots, flags, i;
+
+	for (i = 0; i < NR_FILES; i++)
+		ASSERT_EQ(0, deny_inode(self->map_fd, self->inos[i]));
+
+	ASSERT_EQ(0, set_notrunc(self->sk[SK_RECEIVER]));
+	ASSERT_EQ(0, send_fds(self->sk[SK_SENDER], self->files, NR_FILES));
+	nr_slots = recv_fd_slots(self->sk[SK_RECEIVER], slots, &flags);
+
+	ASSERT_EQ(NR_FILES, nr_slots);
+	EXPECT_EQ(0, flags & MSG_CTRUNC);
+
+	for (i = 0; i < nr_slots; i++)
+		EXPECT_EQ(-EPERM, slots[i]);
+}
+
+TEST_F(scm_rights_denial_bpf, denied_without_notrunc)
+{
+	int slots[NR_FILES], nr_slots, flags;
+
+	/*
+	 * Baseline behaviour without SO_RIGHTS_NOTRUNC: the fd array is
+	 * truncated at the first denied fd and MSG_CTRUNC is set.
+	 */
+	ASSERT_EQ(0, deny_inode(self->map_fd, self->inos[1]));
+
+	ASSERT_EQ(0, send_fds(self->sk[SK_SENDER], self->files, NR_FILES));
+	nr_slots = recv_fd_slots(self->sk[SK_RECEIVER], slots, &flags);
+
+	ASSERT_EQ(1, nr_slots);
+	EXPECT_NE(0, flags & MSG_CTRUNC);
+
+	ASSERT_GE(slots[0], 0);
+	EXPECT_EQ(0, check_secret(slots[0], 0));
+	close(slots[0]);
+}
+
+TEST_HARNESS_MAIN
-- 
2.55.0

