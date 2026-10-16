Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7410C36167F;
	Fri, 16 Oct 2026 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146391; cv=none; b=jxAuKdg4QZhl1gl5+9DtjGyTmPwsBW9lij774/63FkCEn2CqG/sudvSxx0tmrWKAs36JXMyZrqrZDdYOMSfdM/B8VQ2cP2s9tHDNqpd6hHC5etpZCHZ/QxvqbR8GrkfRijt6TMS9j0S+Wz9GSZZzzkQvbFyLLOS3tUFJ0lWVGhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146391; c=relaxed/simple;
	bh=Q+JPrqYf9xqFEDP/JN3D2kUXfdL4fnGGMjA0r4uoHxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QGjCY4auqQ5OwpQy3bs1iuffItoM5ZEANQVhb6Tq7+uEaNP11vswnd0CinKPXgKlX54Lp0QHhTnmufu5p4+Xr1yY5y3ntRwjpu7GXKAfNXXRMWW/MEdNfEBSpyJkPlRW3IwQC5jE5uXF8MitGFQkdeimGsaRBn9TKkvdBUtH5y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sa3QdOfS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sa3QdOfS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D6F1F000C4;
	Fri, 16 Oct 2026 10:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792146385;
	bh=Dt2gQR7eXZVVtRZmwpw7jZMmpfzT0//4PDDaiSsP8Wk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sa3QdOfSzEpSUopstnsR5KOH9m18JHiIP6FVHJ+YqjoCNiDybaamxxrMwphMmZVgg
	 rgNwjkIVaO2vG1dt0Irf85IY25ZSg0cbF23gQUVSGa1W07myYcOHmODujbv/4Sx/T9
	 XytnyMgIIN338mNqtvrJFs1AAhAFGN7Xh8ISwz1be1Ss/lWWiK3j9sH/8dk34mjceO
	 DLG3IbZ8XrlsqkHhezl7eRLgX1sXBBK8qA3Uh8eTpdQF0d5IPvuHUNxUKAsyfjIgZz
	 +ESkYglSLNR8W/PR/J3N4r50vkmUoZcAMxSTJUlrCk2Z5cmYZ/JBZfyHyz3T1JJ+aS
	 SMpqutkVlSKDw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 17/19 for v7.4] vfs shared net-next pidfd
Date: Fri, 16 Oct 2026 12:26:08 +0200
Message-ID: <20261016-vfs-7.4-rc1.shared.net-next.pidfd-c9630b566d79@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016-vfs-v74-41eaf6c4712c@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7948; i=brauner@kernel.org; h=from:subject:message-id; bh=Q+JPrqYf9xqFEDP/JN3D2kUXfdL4fnGGMjA0r4uoHxg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRd/H10R4XubKuimpRzP/6nLw6wUPY6EtIevFWOXbxN5 cmHd/IrO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYiKM3I8HfSnOS/JiuOv2u8 Vzijgn3LjS81Njznzv+INSvn7N1+Zh/D/8KNkbnnbjiuudV/L3TZBe37Xw4VvLrIdndSO8/q5Yl B+WwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This adds thread specific pidfds to af_unix sockets.

SO_PASSPIDFD and SO_PEERPIDFD hand out a pidfd for the thread-group
leader. A coredump server on the coredump socket can't get a handle on
the thread that took the signal and is writing the dump, and anything
doing per-thread authentication has the same problem. The sending and
the connecting thread are recorded in addition to the thread-group
leader and sk_peer_pid becomes an array indexed by pid type.

SO_PASSPIDFD_THREAD works like SO_PASSPIDFD but delivers an
SCM_PIDFD_THREAD cmsg for the sending thread. Both options are
independent so a receiver can ask for both. On SOCK_STREAM sockets
recvmsg() only stops merging data at a thread boundary when the
receiver asked for a thread pidfd. SO_PEERPIDFD_THREAD returns a pidfd
for the thread that called connect(), listen() or socketpair(). pidfs
records the coredump on the dumping thread's struct pid too so its
pidfd reports it like the leader's does. Selftests for af_unix and the
coredump socket are included.

This is a branch shared with net-next so these changes may also reach
you through the networking pull request.

/* Testing */

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

This conflicts with the vfs-7.4-rc1.coredump tag in
tools/testing/selftests/coredump/coredump_test.h and
tools/testing/selftests/coredump/coredump_test_helpers.c between commit
eec8727ba2730 ("selftests/coredump: add a separate helper header") from
that tag and commit 1f47b275d5d5a ("selftests/coredump: check the
dumping thread's pidfd") from this tag. The coredump tag is merged
before this one. In coredump_test.h the coredump tag's version wins
since it moved every declaration into coredump_test_helpers.h. In
coredump_test_helpers.c the SO_PEERPIDFD_THREAD fallback define and the
crashing_child_thread() and get_peer_pidfd_thread() helpers from this
tag are kept on top of the coredump tag's rewrite of the file. The
first hunk is the interesting one, the rest of the combined diff is a
1200 line wall of one-sided context:

diff --cc tools/testing/selftests/coredump/coredump_test_helpers.c
index 91607e09127f,36306069f62e..000000000000
--- a/tools/testing/selftests/coredump/coredump_test_helpers.c
+++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
@@@ -30,16 -21,28 +30,20 @@@
  #include <unistd.h>
  
  #include "../filesystems/wrappers.h"
 -#include "../pidfd/pidfd.h"
 +#include "coredump_notify_signal.h"
  
 -/* Forward declarations to avoid including harness header */
 -struct __test_metadata;
 +#include "coredump_test_helpers.h"
  
 -/* Match the fixture definition from coredump_test.h */
 -struct _fixture_coredump_data {
 -	char original_core_pattern[256];
 -	pid_t pid_coredump_server;
 -	int fd_tmpfs_detached;
 -};
 -
 -#ifndef PAGE_SIZE
 -#define PAGE_SIZE 4096
 +#if __ELF_NATIVE_CLASS == 64
 +#define COREDUMP_ELFCLASS ELFCLASS64
 +#else
 +#define COREDUMP_ELFCLASS ELFCLASS32
  #endif
  
 -#define NUM_THREAD_SPAWN 128
 -
+ #ifndef SO_PEERPIDFD_THREAD
+ #define SO_PEERPIDFD_THREAD 87
+ #endif
+ 
  void *do_nothing(void *arg)
  {
  	(void)arg;

With that the two declarations this tag added to coredump_test.h are
gone and coredump_socket_test.c fails to build with implicit
declarations of both helpers until they are declared in
coredump_test_helpers.h. rerere doesn't record this part, it is a
separate change on top of the merge:

diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.h b/tools/testing/selftests/coredump/coredump_test_helpers.h
index 3f2f87837558..e7f0998347ca 100644
--- a/tools/testing/selftests/coredump/coredump_test_helpers.h
+++ b/tools/testing/selftests/coredump/coredump_test_helpers.h
@@ -39,6 +39,7 @@
 /* Shared helper function declarations */
 void *do_nothing(void *arg);
 void crashing_child(void);
+void crashing_child_thread(void);
 void crashing_child_sparse(size_t size);
 void crashing_child_memory(__u64 task_filter, int fd_addr);
 bool find_coredump_segment(int fd, __u64 vaddr, ElfW(Phdr) *segment);
@@ -59,6 +60,7 @@ int create_detached_tmpfs(void);
 int create_and_listen_unix_socket(const char *path);
 bool set_core_pattern(const char *pattern);
 int get_peer_pidfd(int fd);
+int get_peer_pidfd_thread(int fd);
 bool get_pidfd_info(int fd_peer_pidfd, struct pidfd_info *info);
 
 /* Protocol helper function declarations */

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907:

  Linux 7.3-rc7 (2026-10-11 20:04:55 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.shared.net-next.pidfd

for you to fetch changes up to 96bd708bdab49bea550070d935198ad4f2028a73:

  Merge patch series "net: support thread-specific pidfds for send and connect" (2026-10-12 10:58:36 +0200)

----------------------------------------------------------------
vfs-7.4-rc1.shared.net-next.pidfd

Please consider pulling these changes from the signed vfs-7.4-rc1.shared.net-next.pidfd tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (11):
      pid: add helpers to operate on a struct pid array
      af_unix: record the pid of the sending thread
      net: add SO_PASSPIDFD_THREAD to get a thread-specific SCM_PIDFD
      selftests/net: SO_PASSPIDFD_THREAD
      net: turn sk_peer_pid into an array indexed by pid type
      af_unix: record the pid of the connecting thread
      net: add SO_PEERPIDFD_THREAD to get a thread-specific pidfd
      selftests/net: SO_PEERPIDFD_THREAD
      pidfs: record the coredump on the dumping thread's pid too
      selftests/coredump: check the dumping thread's pidfd
      Merge patch series "net: support thread-specific pidfds for send and connect"

 arch/alpha/include/uapi/asm/socket.h               |   4 +
 arch/mips/include/uapi/asm/socket.h                |   4 +
 arch/parisc/include/uapi/asm/socket.h              |   4 +
 arch/sparc/include/uapi/asm/socket.h               |   4 +
 fs/coredump.c                                      |  22 +-
 fs/pidfs.c                                         |  27 +-
 include/linux/coredump.h                           |   4 +-
 include/linux/pid.h                                |  53 ++
 include/linux/pid_types.h                          |   8 +
 include/linux/pidfs.h                              |   5 +
 include/linux/sched/signal.h                       |  18 +
 include/linux/socket.h                             |   9 +-
 include/net/scm.h                                  |  10 +-
 include/net/sock.h                                 |   8 +-
 include/trace/events/landlock.h                    |   2 +-
 include/uapi/asm-generic/socket.h                  |   4 +
 net/bluetooth/af_bluetooth.c                       |   6 +-
 net/bluetooth/hci_sock.c                           |   8 +-
 net/bluetooth/l2cap_sock.c                         |   2 +-
 net/core/scm.c                                     |  40 +-
 net/core/sock.c                                    | 108 ++--
 net/unix/af_unix.c                                 |  66 +--
 net/unix/af_unix.h                                 |   3 +-
 tools/lib/python/kdoc/xforms_lists.py              |   1 +
 .../selftests/coredump/coredump_socket_test.c      | 175 ++++++
 tools/testing/selftests/coredump/coredump_test.h   |   2 +
 .../selftests/coredump/coredump_test_helpers.c     |  49 ++
 tools/testing/selftests/net/af_unix/Makefile       |   2 +
 tools/testing/selftests/net/af_unix/scm_pidfd.c    | 602 +++++++++++++++++++++
 29 files changed, 1137 insertions(+), 113 deletions(-)
