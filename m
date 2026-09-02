Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26BD4A99D6
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 15:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364721; cv=none; b=LmhqhkLJ9ZO1z+m8wdKQnxQj1bh50jPkaLVW+6qvtUZlygvoQ34WaPMweUmf15pIRIHIKQwBJkdfcgKlRWwTjfp014CyrZ02gjfJeKSLN/Wmy63gfB85J1ZwbHD5Yi7cDSLm7mTKgnCudexiJHWudxBntlpyk99PEgghtUtaIS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364721; c=relaxed/simple;
	bh=e8OEk/kaUfPgF2V60DtHw7Z8fCaZ20Vusl9G/0KKlEg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jayI0mCotsuMaWbi5fXvcXivTFhavjJxD6x2ZPeRtZqddTNXm8gt6WeM8WXm6GAwOPXgBIlQttYBkC2KBIrEhcvd1kTdG35tcerdPIwlZNaflWqqNZyVemvE9X6bBQLO19JvfxsIvB4soNTTZnbnpGlTDUkTFrzyfJ4/aNzFqtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cz58Hh/O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cz58Hh/O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303651F00ADB;
	Wed,  2 Sep 2026 15:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788364719;
	bh=7cR7JYfeouotnNbLDff73ZrBd4bHNkZnYDufYHWmg9g=;
	h=From:Subject:Date:To:Cc;
	b=cz58Hh/Og9y4z8RX/tlgzOIAJ+CS8yLjYfksMU1lxSNiv5KE7FLJkAHFCZrURZ3XS
	 t51e+tl5Pv+9/f3t+NscdM7WwLnZVSDsTBj9T6DH8bcsPSU1nb0k77qUtJBn085HOB
	 hYrDnpR0gLaBKakEFB5cEkPDyBchXqYyIG431uj0wLRb88dsjD1JdWG6baZmFY2Nok
	 5ytOpiqf2te5vqJxLsZf4yaNfjtlJWwk1Vzm3gn1qZv9ZkNVY2dE/tEPfWV2b/nTW8
	 ZF9Y5Hr7YA2FlXR1cpFZbMsu9tNRQVO5ZrgD3lzIE6SoDo6p3+mbbBSnMTvgtsBj7F
	 OeDLL8IzWqYiw==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC v2 00/16] coredump, files: exit files on request
Date: Wed, 02 Sep 2026 17:58:18 +0200
Message-Id: <20260902-work-coredump-unlock-self-v2-0-1bece368cbb1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OwQ6CMBBEf8Xs2SVQiRRPJiZ+gFfjobQLVLAlW
 0GN4d8FjHePM5l5M28IxJYC7FZvYBpssN5NQqxXoGvlKkJrJg0iFttYihQfnhvUnsn0tw5713r
 dYKC2xO1GyVzmiZBZDFO/Yyrtc2Gf4XQ8wOVrhr64kr7P1DlWqEBYsHK6nq2hDJhFafSbmCO1D
 XfPr+XkkCy8P/4MCcaYytIkWquMjNo3xI7ayHMFl3EcPxkNcQf9AAAA
X-Change-ID: 20260824-work-coredump-unlock-self-63a898912870
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Xin Zhao <jackzxcui1989@163.com>, Mateusz Guzik <mjguzik@gmail.com>, 
 Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=8941; i=brauner@kernel.org;
 h=from:subject:message-id; bh=e8OEk/kaUfPgF2V60DtHw7Z8fCaZ20Vusl9G/0KKlEg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTNcF8+S0j1uegZ4bb0Sff972tz73h8U7x3btW5zXJaF
 dk2QlJvO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZS9ZbhJ2NYrtWsd/bnk1bp
 6yYZ2q9T3sO5efMbUbWYpVO4q3/MW8fI0Bg68ZzN5bXeM6Tj7GtT3+VsOxAU0X85+Leph4e64Gc
 lVgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We've had quite a few proposal for exiting files before generating the
coredump (see [1]-[8]). The various proposed solution were quite
unacceptable. So I took some time to look what a _remotely_ acceptable
version of this could look like. Here it is.

The gist is that we allow the coredump socket to request the
thread-group shed the various fdtables closed synchronously before
generating the coredump.

The intricate task is that this requires us to add a primitive to close
fdtables synchronously. Coredump is not enough to justify this but
performance numbers for this look pretty convincing. For tasks exiting
with a large file descriptor table this means getting rid of _a lot_ of
cmpxchg()s and hammering on task->pi_lock. The cost of this was
mentioned in various threads over the years. I found at least recent
comments by Oleg and Neil.

The obvious problematic case are kernel threads. fput() punts their
final __fput() to a workqueue. kthreads never return to userspace to run
task work and some of them may need to finish a umount and so cannot
->release() inline. No path we change is taken by a kthread. They don't
own a descriptor table and kthreadd is created with CLONE_FILES and
every kthread inherits it. So all of them share init_files and init_task
pins that forever. Their exit_files() never drops the last reference.

kernel_execve() refuses PF_KTHREAD outright. Usermodehelpers are spawned
without the kthread flag. close_range() is a syscall. The one indirect
way is a failing copy_process() calling exit_files() on a 
child from a kthread parent. A dup_fd() in copy_process() cannot hold
the last reference to any of its files while the source table is alive.

Worker threads such as io_uring workers are user threads without
PF_KTHREAD that share the fdtable. One of them can be the last to put
the fdtable at exit. Today fput() hands their final __fput()s to task
work. The worker runs that itself in exit_task_work() a few lines later.
Now the same thread does the same work in exit_files() instead. vhost
workers are created without a descriptor table at all, so they never
even put an fdtable. Neither kind ever execs or calls close_range().

Now the performance numbers. I measured this on a 64 vCPU KVM guest (AMD
EPYC 9754) on top of vfs-7.4.coredump with and without the series and
the same x86_64_defconfig for both. The benchmark opens N files in a
forked worker and times the teardown:

- process exit
- execve() with N close-on-exec descriptors
- close_range() with and without CLOSE_RANGE_UNSHARE

Here are the medians over two or three boots which agree within 2%. With
/dev/null as the file and 4096, 65536 and 1M descriptors:

                         4096 fds        65536 fds        1M fds
  ----------------------------------------------------------------------
  exit                    890 -> 826 us  13.5 -> 12.4 ms  221 -> 203 ms
                          -7.2%          -7.9%            -8.3%
  ----------------------------------------------------------------------
  execve, close-on-exec  1215 -> 1113 us 15.9 -> 14.2 ms  247 -> 224 ms
                          -8.4%          -10.1%           -9.0%
  ----------------------------------------------------------------------
  close_range()           984 -> 909 us  17.3 -> 15.3 ms  268 -> 245 ms
                          -7.6%          -11.5%           -8.7%
  ----------------------------------------------------------------------
  close_range(UNSHARE)    990 -> 912 us  17.1 -> 15.3 ms  267 -> 245 ms
                          -7.9%          -10.3%           -8.4%

So that's a 7-11% win or a constant 15-25 ns per closed file. This sheds
init_task_work() and task_work_add() per file with its cmpxchg() and the
TIF_NOTIFY_RESUME test-and-set, the list walk with the indirect call
in the path our, and then a second pass over every struct file that
isn't cache-hot anymore by then.

The performance boost is linear in the number of descriptors from 256 to
1M. Note the thread count doesn't matter since one thread does the close
anyway.

So with eight processes tearing down 65536 descriptors each at the same
time the win grows to 13-15% (20.1 -> 17.4 ms for exit, 20.5 -> 17.4 ms
for execve). The old code walks the table once to queue the task work
and then walks all 16 MB of struct file a second time from
task_work_run().

So once eight CPUs compete for the cache that second pass gets
very expensive. With 32 or 64 processes at once both kernels are bound
by pushing millions of files through slab and RCU. So then the
difference shrinks to 1-4%. Still though...

Files whose own release dominates the cleanup gain a little less. 4% for
eventfds, 7% for pipes, about 1% for AF_UNIX sockets and distinct tmpfs
inodes. For them a release costs 1.25 us per descriptor anyway.

Using function profiling a 65536 descriptor exit spends 4.0 ms in
exit_files() and 10.4 ms in task_work_run() before and now 12.5 ms in
exit_files() and nothing in task_work_run() after.

close(2) is untouched and measures the same. will-it-scale (open1,
open3, dup1, eventfd1, unix1, pipe1, signal1, processes and threads)
is within 2% either way. dup1 a few percent better which I'd put down
to layout.

So, back to coredumps. With COREDUMP_CLOSE_FILES coredumps switch to an
empty file descriptor table before generating the coredump. That
requires a bit of synchronization but I think I got the basics down.

The coredumping thread allocates a new empty file descriptor table. It
then wakes all threads in the thread-group and tells them to switch to
the empty file descriptor table and get rid of the old one. They report
back once they're done.

So that handles most cases where locks would be held for an unreasonable
time until the coredump is generated but since files can be shared
between completely unrelated processes that's not a guarantee and we
can't give one. But it solves the reported issue without resorting to
even grosser hacks.

Link: https://lore.kernel.org/20260618030700.2511668-1-jackzxcui1989@163.com [1]
Link: https://lore.kernel.org/20260618150301.3226517-1-jackzxcui1989@163.com [2]
Link: https://lore.kernel.org/20260619122419.3954581-1-jackzxcui1989@163.com [3]
Link: https://lore.kernel.org/20260624145552.70143-1-jackzxcui1989@163.com [4]
Link: https://lore.kernel.org/20260630075604.52533-1-jackzxcui1989@163.com [5]
Link: https://lore.kernel.org/20260804001703.1340667-1-jackzxcui1989@163.com [6]
Link: https://lore.kernel.org/20260807040124.1706927-1-jackzxcui1989@163.com [7]
Link: https://lore.kernel.org/20260808052732.2589657-1-jackzxcui1989@163.com [8]

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Changes in v2:
- Revamp.
- Link to v1: https://patch.msgid.link/20260824-work-coredump-unlock-self-v1-0-48fd1cca7eda@kernel.org

---
Christian Brauner (16):
      fs: don't open-code file_close_fd() in close_fd()
      fs: add fput_close_list() and fput_list()
      fs: rename do_close_on_exec() to close_cloexec_files()
      fs: defer the final fput of close-on-exec files past the exec locks
      fs: add switch_files_struct()
      fs: move unshare_fd() to fs/file.c
      fs: remove unshare_files()
      exec: release fdtable after exec locks drop
      fs: make close_files() synchronous
      fs: make close_range() synchronous
      coredump: s/startup/done/g
      coredump: factor out coredump_wait_inactive()
      fs: add alloc_files_struct()
      coredump: add COREDUMP_CLOSE_FILES
      tools: sync coredump.h header
      selftests/coredump: test COREDUMP_CLOSE_FILES

 fs/coredump.c                                      |  91 +++-
 fs/exec.c                                          |  11 +-
 fs/file.c                                          | 124 +++--
 fs/file_table.c                                    |  25 +-
 fs/internal.h                                      |   3 +
 fs/open.c                                          |   2 +-
 include/linux/binfmts.h                            |   6 +
 include/linux/fdtable.h                            |   7 +-
 include/linux/sched/signal.h                       |   5 +-
 include/uapi/linux/coredump.h                      |   8 +
 kernel/exit.c                                      |  15 +-
 kernel/fork.c                                      |  48 +-
 tools/include/uapi/linux/coredump.h                |   8 +
 tools/testing/selftests/coredump/Makefile          |   4 +-
 .../selftests/coredump/coredump_close_files_test.c | 592 +++++++++++++++++++++
 .../coredump/coredump_socket_protocol_test.c       |   6 +
 .../selftests/coredump/coredump_test_helpers.c     |   3 +-
 17 files changed, 847 insertions(+), 111 deletions(-)
---
base-commit: 582e5e0d99ac356fac9656767070269bb4ffc1b2
change-id: 20260824-work-coredump-unlock-self-63a898912870

