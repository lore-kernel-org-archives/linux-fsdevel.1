Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E7C3AAF53
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 23:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789084112; cv=none; b=p6uMYtK7UfFFWKNxKDGEeADcFZ1M/R883Aie/hzBV7Sma3GXkBV7Xm+11i82C2wYLBTzeCNDtDRC4sBzb4Z3+U3SNs7uzqlCSf5XTGQ2HCUsCAGZwR//+k93Aw3m4sqry6fd/L0hG3P9zLirOnYAw8l9wyRoyOorc3DgdnhV8KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789084112; c=relaxed/simple;
	bh=1krA5LAnUkFBCgN8SLYhZTihW2S+lEggZsD06+PREcI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=YH1bWghDuJPsmXcVIfvSl1Qsbgqg8jm1UWvEP3gPIOB9oX9LEH3RqujUdmkHpn3+NXdGYTUZfnFl+KpJTKkpQGzGNJFxQfFhJApM9dGreM/wzLngMet1kfwwHy9bkt+E6qBq8M9zL+FI9O9qTfZfWzI9vrwBwoxUrxqfY15vfj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Op3hJl7k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xrSU2wpP; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Op3hJl7k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xrSU2wpP"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id EE9D0EC0316;
	Thu, 10 Sep 2026 19:48:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 10 Sep 2026 19:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1789084108; x=1789170508; bh=XBVHY4NMzOD80fVc37iPrfypoWyBNsC8v2M
	qfdE0l40=; b=Op3hJl7kaC0cKrh/Aa8QRpYxsGjdA9R4fUJOeiz2FAs/wVuu2GV
	VYRnoxpus4jiOroYd91UhxVtyCT604pev1SuQa5RO7duRmaidMzgLctbY3LfrjQm
	60DkYC4MM167kF/LeFoijXfl6L5d8Z+KkBSvSU6Bi5frBjPtEKkjJdWB3GF059S6
	H2oO17n30FJcEKR3o078qRGEYud8Z7jg+Gk8ujCViv8BGdJUejL0Aj603J9cgS7p
	KVqcmJD6ZXa5dHJ8JKTdIArdiDtOkAEwEOdgizbDWGdXSkpjYoPcWqKO531g13QT
	tUDdKerJU+PWu73JXtW4XRb0TjXLbVS0y3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789084108; x=
	1789170508; bh=XBVHY4NMzOD80fVc37iPrfypoWyBNsC8v2MqfdE0l40=; b=x
	rSU2wpPbhV01VMMPyBQO2L9tMNo0nkYJniaGJ0I/KrSUlHARmsG7Or6LRUa4z7Ld
	pP3fbCQGAt0zlEeIOruvMPoC34sQHBL1TbeCtlN9GQitqKuY/9gAsQ24UYPaYjZG
	tT6hqM8C2SzErVzBjPFEL9E7l8K42QLO5osd3EPaYhJioNXze+d9A18i7vUHRy+l
	Qz2YEGAG3Ke76quOpnU5kKtc1QGnyb5i0TUupigspz28v19cJMktZE+R4CqkJnVN
	P+F1XIU+ezEInZyqdj+Ps76+3W0h40+xQYNdDWpPfgwoXMYJGDBPvJ+2IekvRbPh
	S0MkC8xNOY/6r4ise8s0Q==
X-ME-Sender: <xms:zEGjauNZpb7x75QAGz_JOqR11FoX9tncyzLhV4KAfx90AwJ3xg5Q3A>
    <xme:zEGjai-vb0vMgDossFAsCpKwna-B9w40OaK2ElFdVpvOyNEaeICAKWhoAEbym8xT9
    x8Ezva1ZrOyTeyuxPM7JMBN61PMUbu4gGvWn1KHZPpTU6vo-g>
X-ME-Received: <xmr:zEGjagE6BkuOjNUXAkg_-ANx1sLF7viUiBR16mTHtkGaD250N_-IMe7XhlPMsDSDwH3ZSt7Httx3g2mx1lIKKsZeqLiMOuo>
X-ME-Proxy-Cause: dmFkZTGhvFpeFgAN7ywu5oWUvg/JwNHd9wUJ4crh/BsRF1iFjPgLbtqj0PSBdBhOu7AMSo
    y7szkRwKSadIaA6rdQyDW1GYLb6MUh4KUDbLrXoiHD6SCq7if3uZ3Bx/bm5+o0lBVt2/Au
    qGRb2yX9ZCQmFQGISn5/RIpsbCKce7s5Abzy6uuonKaiRERz2MzH17aEizIc2HOIYwv7B1
    6Qu2bTwBTx2Uu7m/XzkNcH9+wa5xnlTI95dyaLeEaIIXMDfuMoK9Q0543lrTFhMTwJ13IY
    QqR/C+nPjLij8zZg+i5rqogsUgB2Wyf6/3u3hGO1g7Tmljq7d2HFeKrZU80tsgM8R8TEbS
    +C2L2efw/Y3AKvqt7YOPJ+twLLWuaAE8JTk/Qq1qhN9EyHb3N/5kEPdkYQR5xSskLgNARP
    CkrzpczgKr4FKtoaB3ADSKysCBkmv2b2HKkt4FkzefxCO/Hh0Y1JIs0Gh/cJuIBrTHiw3x
    U0Hl0Twq5J/mSDlkLgJyiEyv7Apago9bze4uYwc3uPejDHxkDCfjZAA7m2B97mF+5L+79e
    dHa0GpmoLc+2wHPqiHBX/hrRbQJxWui7f+Yur9PhIaHJqrGcNRiLSqKKXCMz+EClXAgEww
    w+DP4jnsVGFKTvD4++QIz5LvN+lcMgH+gOK2TVIbpDsBnSBcKhdGQz+ohQuw
X-ME-Proxy: <xmx:zEGjahipIaOl9UqhieJYPh_j09MrNPYSBzCZWgAbNgRjPuVN-FgKDQ>
    <xmx:zEGjaltR2-6-GoxQY2GXxmd1PqT41ApuhUZS1yUqbTjB6IJ2vMIKQw>
    <xmx:zEGjasvr1Qqus-2S1ACEGhg3S9q4bMO4A_2Qqc7jr96hPR8981WunA>
    <xmx:zEGjaiELYC-CWMIoZtwxAoBiQ8ZUP7cVnIyXnMQRMhPmxhz7JDAeLA>
    <xmx:zEGjasZCRI7D_m1X0JsCvVMsWyM6uhxCvo1TDN1T3FZP0Qk8ysgkuws3>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 19:48:25 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Oleg Nesterov" <oleg@redhat.com>, linux-fsdevel@vger.kernel.org,
 "Jann Horn" <jannh@google.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Jan Kara" <jack@suse.cz>, "Xin Zhao" <jackzxcui1989@163.com>,
 "Mateusz Guzik" <mjguzik@gmail.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Jens Axboe" <axboe@kernel.dk>,
 "Christian Brauner (Amutable)" <brauner@kernel.org>
Subject: Re: [PATCH RFC v4 00/18] coredump, files: exit files on request
In-reply-to: <20260910-work-coredump-unlock-self-v4-0-a5c1800dc930@kernel.org>
References: <20260910-work-coredump-unlock-self-v4-0-a5c1800dc930@kernel.org>
Date: Fri, 11 Sep 2026 09:48:21 +1000
Message-id: <178908410155.207413.6420376177654694393@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 11 Sep 2026, Christian Brauner wrote:
> We've had quite a few proposal for exiting files before generating the
> coredump (see [1]-[8]). The various proposed solution were quite
> unacceptable. So I took some time to look what a _remotely_ acceptable
> version of this could look like. Here it is.
>=20
> The gist is that we allow the coredump socket to request the
> thread-group shed the various fdtables closed synchronously before
> generating the coredump.
>=20
> The intricate task is that this requires us to add a primitive to close
> fdtables synchronously. Coredump is not enough to justify this but
> performance numbers for this look pretty convincing. For tasks exiting
> with a large file descriptor table this means getting rid of _a lot_ of
> cmpxchg()s and hammering on task->pi_lock. The cost of this was
> mentioned in various threads over the years. I found at least recent
> comments by Oleg and Neil.
>=20
> The obvious problematic case are kernel threads. fput() punts their
> final __fput() to a workqueue. kthreads never return to userspace to run
> task work and some of them may need to finish a umount and so cannot
> ->release() inline. No path we change is taken by a kthread. They don't
> own a descriptor table and kthreadd is created with CLONE_FILES and
> every kthread inherits it. So all of them share init_files and init_task
> pins that forever. Their exit_files() never drops the last reference.
>=20
> kernel_execve() refuses PF_KTHREAD outright. Usermodehelpers are spawned
> without the kthread flag. close_range() is a syscall. The one indirect
> way is a failing copy_process() calling exit_files() on a
> child from a kthread parent. A dup_fd() in copy_process() cannot hold
> the last reference to any of its files while the source table is alive.
>=20
> Worker threads such as io_uring workers are user threads without
> PF_KTHREAD that share the fdtable. One of them can be the last to put
> the fdtable at exit. Today fput() hands their final __fput()s to task
> work. The worker runs that itself in exit_task_work() a few lines later.
> Now the same thread does the same work in exit_files() instead. vhost
> workers are created without a descriptor table at all, so they never
> even put an fdtable. Neither kind ever execs or calls close_range().
>=20
> Now the performance numbers. I measured this on a 64 vCPU KVM guest (AMD
> EPYC 9754) on top of vfs-7.4.coredump with and without the series and
> the same x86_64_defconfig for both. The benchmark opens N files in a
> forked worker, moves them to random positions in the descriptor table so
> that the table order has nothing to do with the allocation order, and
> times the teardown:
>=20
> - process exit
> - execve() with N close-on-exec descriptors
> - close_range() with and without CLOSE_RANGE_UNSHARE
>=20
> Here are the medians over two boots which agree within 2%. With
> /dev/null as the file and 4096, 65536 and 1M descriptors:
>=20
>                          4096 fds        65536 fds        1M fds
>   ----------------------------------------------------------------------
>   exit                   1045 -> 895 us  18.9 -> 14.9 ms  429 -> 306 ms
>                           -14.4%         -21.2%           -28.7%
>   ----------------------------------------------------------------------
>   execve, close-on-exec  1393 -> 1190 us 21.4 -> 16.9 ms  471 -> 325 ms
>                           -14.6%         -21.0%           -31.1%
>   ----------------------------------------------------------------------
>   close_range()          1179 -> 988 us  21.9 -> 17.4 ms  484 -> 337 ms
>                           -16.1%         -20.6%           -30.3%
>   ----------------------------------------------------------------------
>   close_range(UNSHARE)   1118 -> 958 us  22.1 -> 17.8 ms  487 -> 333 ms
>                           -14.3%         -19.8%           -31.7%
>=20
> So that's a 16-21% win or 40-150 ns per closed file. This sheds
> init_task_work() and task_work_add() per file with its cmpxchg() and the
> TIF_NOTIFY_RESUME test-and-set, the list walk with the indirect call
> in the path out, and then a second pass over every struct file that
> isn't cache-hot anymore by then.
>=20
> The performance boost holds from 256 to 1M descriptors and is largest
> at 1M. Note the thread count doesn't matter since one thread does the
> close anyway.
>=20
> So with eight processes tearing down 65536 descriptors each at the same
> time the win is 16-21% (34.9 -> 29.5 ms for exit, 34.4 -> 27.0 ms
> for execve). The old code walks the table once to queue the task work
> and then walks all 16 MB of struct file a second time from
> task_work_run().
>=20
> So once eight CPUs compete for the cache that second pass gets
> very expensive. With 32 or 64 processes at once both kernels are bound
> by pushing millions of files through slab and RCU. So then the
> difference shrinks to 4-8%. Still though...
>=20
> Files whose own release dominates the cleanup gain a little less. 13%
> for eventfds, 11% for pipes, 6% for AF_UNIX sockets and 7% for distinct
> tmpfs inodes. For them a release costs about 2 us per descriptor anyway.
>=20
> Using function profiling a 65536 descriptor exit spends 4.6 ms in
> exit_files() and 11.1 ms in task_work_run() before and now 13.7 ms in
> exit_files() and nothing in task_work_run() after.
>=20
> close(2) is untouched and measures the same. will-it-scale (open1,
> open3, dup1, eventfd1, unix1, pipe1, signal1, processes and threads)
> is within 2% either way. dup1_threads at 16 tasks and getppid1 at 64
> tasks a few percent better which I'd put down to layout.
>=20
> So, back to coredumps. With COREDUMP_CLOSE_FILES coredumps switch to an
> empty file descriptor table before generating the coredump. That
> requires a bit of synchronization but I think I got the basics down.
>=20
> The coredumping thread allocates a new empty file descriptor table. It
> then wakes all threads in the thread-group and tells them to switch to
> the empty file descriptor table and get rid of the old one. They report
> back once they're done.
>=20
> So that handles most cases where locks would be held for an unreasonable
> time until the coredump is generated but since files can be shared
> between completely unrelated processes that's not a guarantee and we
> can't give one. But it solves the reported issue without resorting to
> even grosser hacks.
>=20
> Link: https://lore.kernel.org/20260618030700.2511668-1-jackzxcui1989@163.co=
m [1]
> Link: https://lore.kernel.org/20260618150301.3226517-1-jackzxcui1989@163.co=
m [2]
> Link: https://lore.kernel.org/20260619122419.3954581-1-jackzxcui1989@163.co=
m [3]
> Link: https://lore.kernel.org/20260624145552.70143-1-jackzxcui1989@163.com =
[4]
> Link: https://lore.kernel.org/20260630075604.52533-1-jackzxcui1989@163.com =
[5]
> Link: https://lore.kernel.org/20260804001703.1340667-1-jackzxcui1989@163.co=
m [6]
> Link: https://lore.kernel.org/20260807040124.1706927-1-jackzxcui1989@163.co=
m [7]
> Link: https://lore.kernel.org/20260808052732.2589657-1-jackzxcui1989@163.co=
m [8]
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> Changes in v4:
> - Fix performance number variations. It said variable within 4%. It's
>   actually just 2%.
> - Make various simplifications and add wait_var_event_state().
> - Link to v3: https://patch.msgid.link/20260909-work-coredump-unlock-self-v=
3-0-04f907687563@kernel.org

There are some more nice improvement here in v4.
I'm happy to offer a
  Reviewed-by: NeilBrown <neil@brown.name>
for 1 thru 14.  I don't think I have the background to properly assess
the last 4, though I see nothing that might be problematic.

Thanks,
NeilBrown


>=20
> Changes in v3:
> - Drop the llist. This brings yet another performance boost.
> - Link to v2: https://patch.msgid.link/20260902-work-coredump-unlock-self-v=
2-0-1bece368cbb1@kernel.org
>=20
> Changes in v2:
> - Revamp.
> - Link to v1: https://patch.msgid.link/20260824-work-coredump-unlock-self-v=
1-0-48fd1cca7eda@kernel.org
>=20
> ---
> Christian Brauner (18):
>       fs: don't open-code file_close_fd() in close_fd()
>       fs: add switch_files_struct()
>       fs: move unshare_fd() to fs/file.c
>       fs: remove unshare_files()
>       fs: add filp_close_sync()
>       fs: make close_files() synchronous
>       fs: make close_range() synchronous
>       fs: rename do_close_on_exec() to close_cloexec_files()
>       fs: make close_cloexec_files() synchronous
>       coredump: drop core_state->dumper
>       sched: add wait_var_event_state()
>       coredump: replace the startup completion with a thread count
>       coredump: factor out coredump_wait_inactive()
>       fs: add alloc_files_struct()
>       coredump: add COREDUMP_CLOSE_FILES
>       coredump: cancel io_uring requests before closing files
>       tools: sync coredump.h header
>       selftests/coredump: test COREDUMP_CLOSE_FILES
>=20
>  fs/binfmt_elf.c                                    |   2 +-
>  fs/binfmt_elf_fdpic.c                              |   2 +-
>  fs/coredump.c                                      |  91 +++-
>  fs/exec.c                                          |  13 +-
>  fs/file.c                                          | 107 ++--
>  fs/internal.h                                      |   1 +
>  fs/open.c                                          |  17 +-
>  include/linux/fdtable.h                            |   6 +-
>  include/linux/sched/signal.h                       |   8 +-
>  include/linux/wait_bit.h                           |  26 +
>  include/uapi/linux/coredump.h                      |   8 +
>  kernel/exit.c                                      |  22 +-
>  kernel/fork.c                                      |  48 +-
>  tools/include/uapi/linux/coredump.h                |   8 +
>  tools/testing/selftests/coredump/Makefile          |   4 +-
>  .../selftests/coredump/coredump_close_files_test.c | 592 +++++++++++++++++=
++++
>  .../coredump/coredump_socket_protocol_test.c       |   6 +
>  .../selftests/coredump/coredump_test_helpers.c     |   3 +-
>  18 files changed, 840 insertions(+), 124 deletions(-)
> ---
> base-commit: a5625efa7a0e77c26e857de147284a21d53fa3ad
> change-id: 20260824-work-coredump-unlock-self-63a898912870
>=20
>=20

