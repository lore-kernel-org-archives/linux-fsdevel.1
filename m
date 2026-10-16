Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4273EE1FD;
	Fri, 16 Oct 2026 10:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145915; cv=none; b=pGre8FlVcuzeEPP5jsNvL5GkNgwYL3lnZWstNZ6DgCbWASVb9e8074rFm2Akealz1Tv3FYSmfAGpUPFwm0GYh6qyIVO9ump1lTjVRLp5o972U1+vUY4lxmDjiU8QEoZGhTlXjtL5WAhX/RJgz8yyQuo7sH0gleSwY6R4UBU/DJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145915; c=relaxed/simple;
	bh=GsHCHx8d12HeCDK82W/oNF/+aySnlQgqroW3+PtM/2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EKn8pABk6p17GmpdHTm22GKXVFGVf7WdMikB02CxXd5I39xbc2XgpTb5fRVWkmB0QsKPtURALsUYfGwgEO3gALQfIKuxp0NJoVlH1uUMMQNqteC+Z+dJncBzfZGnEhKD0brdsbZaG037BYRXVXQVrVtjbduunej0WKR6WW3/OJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hB7iZJ0d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hB7iZJ0d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8832D1F000C5;
	Fri, 16 Oct 2026 10:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792145913;
	bh=RJRCAjFNMsZFeGLpE0Zkv2w/yRxGkI4gnDbaeL8WNMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hB7iZJ0d9IDkP5yKPtU3ZSMaKVoFpgM8PsxGjoP6U9cxhp0KJ2BweG9ZV+AtmlRxc
	 oBHN6EMrZElkvksDLjun1YnNoxeXMeku+cb0sisRqeb83kuKpD8Liq8b+k2nXECC56
	 /ZShCddhPsOLWsglIJm9UhGHT5FQ5aD9BDpQa4JhMoxp/uyk3pBDFiYV0Lh/wYWkii
	 RpmpeYRGrJvc8tM6ZIZq/EWrrhc3NfRiwe9eWjtKv8A6Jj77ZlvsVKVXV7qsnQe3pI
	 S3Ud5Q+1kEVpAeeDC0GV5h2me9+DIngDc6lGWZkPmS95EH9ctMSGdBkg/f3N4/Lg5S
	 hzCVhYAEx6oEQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 08/19 for v7.4] vfs coredump
Date: Fri, 16 Oct 2026 12:18:00 +0200
Message-ID: <20261016-vfs-7.4-rc1.coredump-5fe9155f7d73@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016-vfs-v74-41eaf6c4712c@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10005; i=brauner@kernel.org; h=from:subject:message-id; bh=GsHCHx8d12HeCDK82W/oNF/+aySnlQgqroW3+PtM/2c=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRd/PnWaHveBfHYBJ9F8b6/tp3rnDy7v3/pLtWLDs/Yd NLksrMmdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzE34vhn25GiP4ziX+Rs4V/ T9b7Jb06IZljp2pLn9hZnh86i0tPTWD4p2F2R2WtVGz4savTvA6l9PEr+fQ9CFk0aXOR2qkt0uv M+QE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This adds sparse coredumps and per-request memory type selection to the
coredump socket protocol.

A coredump sent over the socket transfers every zero of every hole in
every mapping. For a process with 128 threads that's 1 GB of mostly
thread stacks, 8 MB reservations with a few pages touched, and the
holes sit in the middle of the dump rather than at the end. The
coredump_filter bit that was proposed for this stops each PT_LOAD at
the last populated page. But that mask says which kinds of memory to
include and propagates across fork and exec, whereas what is selected
here is an encoding. The usermodehelper isn't salvagable for this
either. The coredump socket already has a handshake for exactly this.

A server that raises COREDUMP_RECORDS in coredump_ack->mask gets the
coredump as a sequence of records, each a struct coredump_record_header
followed by what it describes. The stream ends explicitly with an end
record that reports the size, so a missing one means truncation. With
COREDUMP_SPARSE holes cross the socket as a bare header that says how
many zero bytes were skipped. Reassembling the records gives back the
same coredump, so a debugger and everything else still see an ordinary
core file. Numbers from the selftests: the 128 thread process sends
1424153 bytes for a coredump of 1075150848 bytes, a 256 MB mapping with
the first and the last page touched sends 188793 bytes for 268890112
bytes, and with COREDUMP_RECORDS alone the record overhead is under one
percent. The selftests also simulate a server uploading to a blob store
that can't seek and rewrites the program headers so the object is an
ordinary ELF core file without the holes.

COREDUMP_MEMORY_TYPES lets the server choose what memory to dump per
request instead of relying on the static /proc/<pid>/coredump_filter
of the crashing task. The request carries the default types and a mask
of every type the kernel knows about, the ack carries the selection.
Zero is valid and dumps the program headers and notes and nothing but
the mappings that are always dumped.

Preparatory cleanups refuse negative skips in dump_skip_to(), chunk
every write at a page so a pipe or a socket never takes a short write
in the middle of a record, make the dump helpers return bool and
replace the core_dumped integer with COREDUMP_STATE_STARTED and
COREDUMP_STATE_TRUNCATED flags.

Also included is a fix for coredump_parse() reading core_pattern while
it is being modified. The sysctl handler now validates a copy and
publishes it under a spinlock and the parser works on a snapshot, so a
rejected pattern is never visible and the rollback logic goes away.
And to_kthread()'s lockless flags read is annotated with READ_ONCE().

/* Testing */

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

This conflicts with the kernel-7.4-rc1.signal tag in
tools/testing/selftests/coredump/coredump_test.h and
tools/testing/selftests/coredump/coredump_test_helpers.c between commit
7ac8d57a436c8 ("selftests/coredump: test that TIF_NOTIFY_SIGNAL doesn't
truncate a coredump") from that tag and commit eec8727ba2730
("selftests/coredump: add a separate helper header") from this tag. The
signal tag is merged before this one. The signal tag adds the
coredump_notify_signal.h and sys/syscall.h includes and this tag moves
everything else the two files shared into coredump_test_helpers.h:

diff --cc tools/testing/selftests/coredump/coredump_test.h
index 06f997ba47fd,8d99b5cb2f12..000000000000
--- a/tools/testing/selftests/coredump/coredump_test.h
+++ b/tools/testing/selftests/coredump/coredump_test.h
@@@ -3,19 -3,9 +3,10 @@@
  #ifndef __COREDUMP_TEST_H
  #define __COREDUMP_TEST_H
  
- #include <stdbool.h>
- #include <sys/types.h>
- #include <linux/coredump.h>
- 
  #include "../kselftest_harness.h"
- #include "../pidfd/pidfd.h"
 +#include "coredump_notify_signal.h"
  
- #ifndef PAGE_SIZE
- #define PAGE_SIZE 4096
- #endif
- 
- #define NUM_THREAD_SPAWN 128
+ #include "coredump_test_helpers.h"
  
  /* Coredump fixture */
  FIXTURE(coredump)
diff --cc tools/testing/selftests/coredump/coredump_test_helpers.c
index f8d416180d5b,4e36e3e4fb78..000000000000
--- a/tools/testing/selftests/coredump/coredump_test_helpers.c
+++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
@@@ -22,32 -17,22 +22,24 @@@
  #include <sys/ioctl.h>
  #include <sys/mman.h>
  #include <sys/socket.h>
+ #include <sys/stat.h>
 +#include <sys/syscall.h>
  #include <sys/types.h>
  #include <sys/un.h>
  #include <sys/wait.h>
  #include <unistd.h>
  
  #include "../filesystems/wrappers.h"
- #include "../pidfd/pidfd.h"
 +#include "coredump_notify_signal.h"
  
- /* Forward declarations to avoid including harness header */
- struct __test_metadata;
+ #include "coredump_test_helpers.h"
  
- /* Match the fixture definition from coredump_test.h */
- struct _fixture_coredump_data {
- 	char original_core_pattern[256];
- 	pid_t pid_coredump_server;
- 	int fd_tmpfs_detached;
- };
- 
- #ifndef PAGE_SIZE
- #define PAGE_SIZE 4096
+ #if __ELF_NATIVE_CLASS == 64
+ #define COREDUMP_ELFCLASS ELFCLASS64
+ #else
+ #define COREDUMP_ELFCLASS ELFCLASS32
  #endif
  
- #define NUM_THREAD_SPAWN 128
- 
  void *do_nothing(void *arg)
  {
  	(void)arg;

Merge conflicts with other trees
================================

This conflicts with the mm tree in fs/coredump.c between commit
e2f895dd2f8cb ("mm: rename is_vm_hugetlb_page() to vma_is_hugetlb()")
from the mm tree and commit 757ebc30a3725 ("coredump: select memory
types to include") from this tree:

diff --cc fs/coredump.c
index 5820cb8ec88e,357f0774d5a1..5b657770f154
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@@ -1608,10 -1850,12 +1850,12 @@@ static unsigned long vma_dump_size(stru
  	}
  
  	/* Hugetlb memory check */
 -	if (is_vm_hugetlb_page(vma)) {
 +	if (vma_is_hugetlb(vma)) {
- 		if ((vma->vm_flags & VM_SHARED) && FILTER(HUGETLB_SHARED))
+ 		if ((vma->vm_flags & VM_SHARED) &&
+ 		    COREDUMP_MEMORY_TYPE_INCLUDE(memory_types, HUGETLB_SHARED))
  			goto whole;
- 		if (!(vma->vm_flags & VM_SHARED) && FILTER(HUGETLB_PRIVATE))
+ 		if (!(vma->vm_flags & VM_SHARED) &&
+ 		    COREDUMP_MEMORY_TYPE_INCLUDE(memory_types, HUGETLB_PRIVATE))
  			goto whole;
  		return 0;
  	}

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.coredump

for you to fetch changes up to fd00a46e36a12c5279d3d163f0d0c8f83d12dc09:

  kthread: Annotate lockless to_kthread() flags access (2026-09-25 11:33:50 +0200)

----------------------------------------------------------------
vfs-7.4-rc1.coredump

Please consider pulling these changes from the signed vfs-7.4-rc1.coredump tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (30):
      coredump: refuse negative skips
      coredump: set the minimum send buffer size
      selftests/coredump: discard the right amount after the coredump request
      selftests/coredump: collapse the expected request check into the helper
      selftests/coredump: add a separate helper header
      coredump: pin the protocol struct sizes
      coredump: move the negotiated mask into struct coredump_params
      coredump: deduplicate the to_skip flush
      coredump: make the dump helper return bool
      coredump: always chunk writes
      coredump: clean up coredump state handling
      coredump: add COREDUMP_RECORDS to the coredump socket protocol
      coredump: add COREDUMP_SPARSE to the coredump socket protocol
      tools: sync coredump.h header
      coredump: send the coredump in records if requested
      coredump: describe the holes when COREDUMP_SPARSE is negotiated
      selftests/coredump: test COREDUMP_RECORDS and COREDUMP_SPARSE
      selftests/coredump: hand the record stream to a sink
      selftests/coredump: put a hole in the middle of a sparse mapping
      selftests/coredump: simulate a blob store
      selftests/coredump: show how to inspect the task to decide how the coredump should be sent
      Merge patch series "coredump: allow to create sparse coredumps on the coredump socket"
      coredump: select memory types to include
      tools: sync coredump.h header
      selftests/coredump: simplify the refusal tests
      selftests/coredump: test COREDUMP_MEMORY_TYPES
      selftests/coredump: improve coredump size negotiation tests
      selftests/coredump: test failed handshakes
      Merge patch series "coredump: select memory types per request"
      coredump: parse a snapshot of core_pattern

Kunwu Chan (1):
      kthread: Annotate lockless to_kthread() flags access

 Documentation/filesystems/proc.rst                 |    4 +
 fs/binfmt_elf.c                                    |   12 +-
 fs/binfmt_elf_fdpic.c                              |   12 +-
 fs/coredump.c                                      |  490 ++++--
 include/linux/binfmts.h                            |    3 +-
 include/linux/coredump.h                           |   37 +-
 include/uapi/linux/coredump.h                      |  149 +-
 kernel/kthread.c                                   |    2 +-
 tools/include/uapi/linux/coredump.h                |  149 +-
 .../coredump/coredump_socket_protocol_test.c       | 1829 +++++++++++++++-----
 tools/testing/selftests/coredump/coredump_test.h   |   31 +-
 .../selftests/coredump/coredump_test_helpers.c     | 1432 ++++++++++++++-
 .../selftests/coredump/coredump_test_helpers.h     |   79 +
 13 files changed, 3597 insertions(+), 632 deletions(-)
 create mode 100644 tools/testing/selftests/coredump/coredump_test_helpers.h
