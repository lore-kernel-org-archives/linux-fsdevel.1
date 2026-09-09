Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AF4576ED2
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 15:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969180; cv=none; b=JVTwJ+PEv9rKCG4itVY7N4158TmleOyKVcMLm34LHaZzQkSzIt+K9O0d+jKivZ8dss2NtC+GZ5+MoYqni8u2sQCdjRrJZijF12v3oI7V2RK4q6TQeRkw/qtWqJw0lOSKREqor/uJo9SHAyInjqyM3krefzCAecDpTE96+KMq0ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969180; c=relaxed/simple;
	bh=Wpr1ztSMIP4YrF+biBe+xPNMlF2tVNTFD3vib3TeIfU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=M2x74dP++L54IbwkeC/Xejxm3lPZKOf+HumSSZK29536xvYDcv7Ix8F5GCPl5J2tG+UjUsyuKYMJA0smOpOcUZsgKuw1o6Uzq4wWy9kOOEg46CZirt9nMx3y54myD5YRECG21yCfbd7N0WYe8jnANPlrFLyRF/PhTtoVLEncFB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+QjyCEu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+QjyCEu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DA01F00A3D;
	Wed,  9 Sep 2026 15:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788969178;
	bh=wY6HDRVpmOVaout77ViBbFbskq21rshSWjtaZsgYYkE=;
	h=From:Subject:Date:To:Cc;
	b=O+QjyCEunmZZP1I2MtJcNuxsNrASv155aHuETKzPvKjFhmz+O4GQql6e69wqx9bko
	 INH6e8/1mWqdFhKdqqkJ3R04EQmEqlTp2Vx6+G9bkSlTjI4UG7ZaXyjcfbdxu6zj6+
	 9BY0rH5TiNykOm5Cxz35WXHGEtxqHMtziUtJhA+mCvbWPbxMgwBesYo7sn3IL/sEnJ
	 YryZSZMuHxuxfHWmQ52oa3xAFcVl8B/yajRvk1BPOhbed7SBiSDGFb/pWN+CFbLFTd
	 oPiDjOpC16kJEa/zVge8HPVlIAMkB5qqGkizO2TNME7VNJpwZzq14H4vb2wYptO9jq
	 ZEZ9njZzbNRow==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC v3 00/15] coredump, files: exit files on request
Date: Wed, 09 Sep 2026 17:52:43 +0200
Message-Id: <20260909-work-coredump-unlock-self-v3-0-04f907687563@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43O0WrDIBQG4FcpXk9RU1Kzq8FgD7DbMYqenDQ2T
 os2rqXk3asZY+xm7PI/+H/+N5IwWkzkcXMjEbNNNvgSmocNgVH7A1Lbl0wkly1Xcks/Q5wohIj
 9/HGis3cBJprQDbRttOpUJ6TacVL6p4iDvaz2G3l9eSbvX8c0myPCuar1mdEJqYnaw1hP1WffP
 gMXEu4H6zAx52w6s9yw2qjNseQQr+v2LNZv/jEzC8rpVg29ANA77PXThNGjYyEe1olZ/lAdl39
 RslDCIGDTKjBG/KKWZbkDa7TNJl8BAAA=
X-Change-ID: 20260824-work-coredump-unlock-self-63a898912870
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Xin Zhao <jackzxcui1989@163.com>, 
 Mateusz Guzik <mjguzik@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=9084; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Wpr1ztSMIP4YrF+biBe+xPNMlF2tVNTFD3vib3TeIfU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtbLjqpC92vu2Ap2Lnwb2N2TnCKW195k63Gov2zryad
 PlA2K+4jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlYNzAy7JdZvCw3fIHNLK6V
 9dbJdqHmvd8eCSb33/xcPu+eVX9pBCND2/3pUZ9PvvRJ6zqma6aYYBF1eerluzbflr7cIFXLZmr
 DAQA=
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
forked worker, moves them to random positions in the descriptor table so
that the table order has nothing to do with the allocation order, and
times the teardown:

- process exit
- execve() with N close-on-exec descriptors
- close_range() with and without CLOSE_RANGE_UNSHARE

Here are the medians over two boots which agree within 4%. With
/dev/null as the file and 4096, 65536 and 1M descriptors:

                         4096 fds        65536 fds        1M fds
  ----------------------------------------------------------------------
  exit                   1045 -> 895 us  18.9 -> 14.9 ms  429 -> 306 ms
                          -14.4%         -21.2%           -28.7%
  ----------------------------------------------------------------------
  execve, close-on-exec  1393 -> 1190 us 21.4 -> 16.9 ms  471 -> 325 ms
                          -14.6%         -21.0%           -31.1%
  ----------------------------------------------------------------------
  close_range()          1179 -> 988 us  21.9 -> 17.4 ms  484 -> 337 ms
                          -16.1%         -20.6%           -30.3%
  ----------------------------------------------------------------------
  close_range(UNSHARE)   1118 -> 958 us  22.1 -> 17.8 ms  487 -> 333 ms
                          -14.3%         -19.8%           -31.7%

So that's a 16-21% win or 40-150 ns per closed file. This sheds
init_task_work() and task_work_add() per file with its cmpxchg() and the
TIF_NOTIFY_RESUME test-and-set, the list walk with the indirect call
in the path out, and then a second pass over every struct file that
isn't cache-hot anymore by then.

The performance boost holds from 256 to 1M descriptors and is largest
at 1M. Note the thread count doesn't matter since one thread does the
close anyway.

So with eight processes tearing down 65536 descriptors each at the same
time the win is 16-21% (34.9 -> 29.5 ms for exit, 34.4 -> 27.0 ms
for execve). The old code walks the table once to queue the task work
and then walks all 16 MB of struct file a second time from
task_work_run().

So once eight CPUs compete for the cache that second pass gets
very expensive. With 32 or 64 processes at once both kernels are bound
by pushing millions of files through slab and RCU. So then the
difference shrinks to 4-8%. Still though...

Files whose own release dominates the cleanup gain a little less. 13%
for eventfds, 11% for pipes, 6% for AF_UNIX sockets and 7% for distinct
tmpfs inodes. For them a release costs about 2 us per descriptor anyway.

Using function profiling a 65536 descriptor exit spends 4.6 ms in
exit_files() and 11.1 ms in task_work_run() before and now 13.7 ms in
exit_files() and nothing in task_work_run() after.

close(2) is untouched and measures the same. will-it-scale (open1,
open3, dup1, eventfd1, unix1, pipe1, signal1, processes and threads)
is within 2% either way. dup1_threads at 16 tasks and getppid1 at 64
tasks a few percent better which I'd put down to layout.

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
Changes in v3:
- Drop the llist. This brings yet another performance boost.
- Link to v2: https://patch.msgid.link/20260902-work-coredump-unlock-self-v2-0-1bece368cbb1@kernel.org

Changes in v2:
- Revamp.
- Link to v1: https://patch.msgid.link/20260824-work-coredump-unlock-self-v1-0-48fd1cca7eda@kernel.org

---
Christian Brauner (15):
      fs: don't open-code file_close_fd() in close_fd()
      fs: add switch_files_struct()
      fs: move unshare_fd() to fs/file.c
      fs: remove unshare_files()
      fs: move filp_flush() to other file helpers
      fs: make close_files() synchronous
      fs: make close_range() synchronous
      fs: rename do_close_on_exec() to close_cloexec_files()
      fs: make close_cloexec_files() synchronous
      coredump: s/startup/done/g
      coredump: factor out coredump_wait_inactive()
      fs: add alloc_files_struct()
      coredump: add COREDUMP_CLOSE_FILES
      tools: sync coredump.h header
      selftests/coredump: test COREDUMP_CLOSE_FILES

 fs/coredump.c                                      |  91 +++-
 fs/exec.c                                          |  13 +-
 fs/file.c                                          | 115 ++--
 fs/internal.h                                      |   1 +
 fs/open.c                                          |   2 +-
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
 15 files changed, 810 insertions(+), 108 deletions(-)
---
base-commit: a5625efa7a0e77c26e857de147284a21d53fa3ad
change-id: 20260824-work-coredump-unlock-self-63a898912870

