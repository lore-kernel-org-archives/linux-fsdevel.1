Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794932243;
	b=J0MfV8tJM8MSNyIcWoegkJ2iaoLQ1J8kjLl9U73gR9HeulqpdvQamHLx4OPY0qn7elJ4
	 fHDzvA/sXgYpv7+9DwXFCQH8tF3FrzxdljhqiK39kgEAxQwhwEtVaerckczNYk3pyNINp
	 TG8D9FlODPD9r2teCOlzEZZqtTDzqWuc+mSatuqprCt69Sf1Ettmrll2lvMDi8m9M3Cap
	 xIQxZI0go8eFYsBFKyyQXWyYadYI3Efmf4vja66oLoawFxUdgFNsKLTEum1lwtvXNwZBB
	 0rOWLXzUhG1307RFv0xf6BvnqoILuq59tL1yfzIplk2rg+GFDNIlr+gGaYPpjHVizzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794932243;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Y/ijzipXaXnoXOLHV52Sh9vsSMoQjLwzHp6q5TSfpno=;
	b=WwECCtch6gBJtxfkDT8yul/5m2jy9yPUE/cJ59KKshyJ2DTBiC/yV3ta3lVOeMub9axw
	 IPLaOQizEBeCAOT6KwshbXfVVY/XdexqI72/0kXiR2vL4WcxGSoOZ3SXm2wsrmXPZLNcZ
	 FC1vSTDmaAMvLacv2T3ko83ALM5sVmnPwKGseYeUAy91gmb5RndFeK1yvH6e0fr9cSUPB
	 k68Qm9Y36a92z8u3sua0oGCv4GzxLu5+B8JVTBKm6nzX8MLeq1+EV7e3M2sjcwBQjLE28
	 x7bmyrhLXd40bt8uCgsXajsOPkOoPgZjKLzsx2qQjl4PKeSaAWZ7jCkU7EvEG8l0E6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b="v/loGHrK";
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD1F606A32C;
	Tue, 17 Nov 2026 16:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CD1F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=v/loGHrK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794932241;
	bh=Y/ijzipXaXnoXOLHV52Sh9vsSMoQjLwzHp6q5TSfpno=;
	h=From:To:Cc:Subject:Date:From;
	b=v/loGHrKnnGsv0sMIlOTpNV9tuB/Zn+gINtQpAYdGamDd/kFJ5UAS5mWDUYeEVEF7
	 3ag6Uty5k/BEUOV/S9xW7MaT9vJPWlZUCKdpD97gOqyaia2Tsd0GvlKL08whypTaoj
	 VCBvfl1GHcPfNYNqNIy5dpNCdIPUAVi3DcVSLFgpHozrFVInrHnOJzRuhvn3qa/Bul
	 SXXD2W4RFiuiP8EKXR5pqdNy3/CVrTnxua2HHPH/8mUqXPn/JX/i33OLz82zo1PXs3
	 hWVhLACdkUiq6Ilohsu2ixlICroZX6ZoPbQSNY+qAODWMzwx3j/JH/7OFwz1DrEE1T
	 ZBkmTkD8Nj02g==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jTVHj2dxpzR8M;
	Tue, 17 Nov 2026 11:17:21 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: tglx@kernel.org,
	peterz@infradead.org
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	paulmck@kernel.org,
	boqun@kernel.org,
	shuah@kernel.org,
	kees@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	oleg@redhat.com,
	bestswngs@gmail.com,
	xmei5@asu.edu,
	xujiakai24@mails.ucas.ac.cn,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 00/17] sched/mmcid: fixes for execve, mode switches and affinity
Date: Tue, 17 Nov 2026 11:17:00 -0500
Message-Id: <cover.1794932121.git.mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Thomas, Peter,

This series fixes six problems of the rseq concurrency IDs (mm_cid),
and adds selftests for them. I looked for cases the existing tests do
not reach:
- a thread count that goes up and down;
- exit, fork and a failed execve();
- affinity changes made by another process.

The fixes come first, and all six are marked for stable:

  1  Give a CID to a task that joins its mm while running. A failed
     execve() then no longer returns to user space with an mm_cid of
     0x80000000.
  2  Give no CID to io_uring and vhost workers, so that they do not
     take IDs from the threads of the process.
  3  Reset the stale per CPU state of an mm when its first user joins.
     A machine with two or three CPUs no longer locks up after a failed
     execve().
  4  Keep a running joiner inactive until the fixups are done, so that
     it cannot loop in mm_get_cid() while it holds mm_cid.mutex.
  5  Add the allowed CPUs of the first user to the mm when it joins.
     An affinity change by another task during execve() is then not
     lost.
  6  Fix the use after free of the old mm in set_cpus_allowed_common().

The tests, all in tools/testing/selftests/rseq. Tests 7, 8, 12 and 17
fail without the fix they check:

  7  mm_cid_execve_test: the mm_cid after a failed execve(). For patch
     1.
  8  The last user fails execve() on another CPU. For patch 3, on
     guests with 2 and 3 CPUs.
  9  mm_cid_transition_test: threads count per mm_cid while the thread
     count crosses the mode thresholds.
 10  mm_cid_bound_test: the largest mm_cid stays below the possible
     CPUs. It prints how far the IDs go above the max_cids target.
 11  A transition case: affinity changes made by another process.
 12  mm_cid_exec_affinity_test. For patch 5, on guests with 4 to 64
     CPUs.
 13  Transition cases: threads created by several threads at once, and
     threads migrated by another process.
 14  A bound case: the IDs after the affinity is widened. It prints
     when they are not compact.
 15  mm_cid_window_test: two directed cases for mode switch windows.
     For patch 4, see the last point below.
 16  mm_cid_teardown_test, for patch 6.
 17  A second case for patch 3, see the first point below.

Points I would like your opinion on:
- Patch 3. Thomas, this is your cleanup from the thread "[PATCH]
  sched/mmcid: Bound the CID allocation busy wait", which you preferred
  to my fix. I wrote its subject and changelog. Change them as you see
  fit. Without your Signed-off-by, the patch carries my name, with an
  Originally-by: tag for you. If you send your Signed-off-by, I will
  make you its author. Three remarks on the code:
  - From patch 5 on, the cleanup runs in sched_mm_cid_add_first_user(),
    under t->pi_lock and mm_cid.lock. Its loop over the possible CPUs
    then runs with interrupts off. It could move out of the raw locks:
    mm_cid.mutex is held and the mm has no user.
  - The cleanup copies the allowed CPUs of the task when the mode is
    not 0. Patch 5 adds them at every first join. One of the two is
    enough.
  - The stale state is not limited to two or three possible CPUs.
    mm_cid_calc_pcpu_thrs() also returns 1 when the mm counts one
    allowed CPU. Test 17 gets a CID leaked that way on guests with 4, 8
    and 64 CPUs. It needs an affinity change that the mm missed during
    an execve(). So it fails only without both patch 3 and patch 5. I
    reproduced the lockup itself with two and three possible CPUs only.
  I did not show that this lockup is the splat of that thread.
- Patch 5 has Fixes: b0c3d51b54f8. Part of its window is older and
  dates from commit 7e019dcc470f ("sched: Improve cache locality of
  RSEQ concurrency IDs for intermittent workloads").
- Test 15 passes on a kernel without the two fixes it targets: its
  windows are a few instructions wide. It fails there only when the
  kernel makes the chosen thread sleep in the window. I did that with a
  local debug prctl(), which is not in this series. The test marks the
  places with "Delay injection" comments. Would you want such delay
  points upstream, for instance as fault injection?

Testing
=======

All tests pass in x86-64 QEMU guests with lockdep, with 2 to 64 CPUs.
Also:
- Without patch 4 and without delay injection, the sequence of test 15
  hangs a guest with 2 CPUs when a SCHED_FIFO task preempts the joiner.
- Patch 2 has no test.
- I did not reproduce the use after free that patch 6 fixes. Its exec
  case needs CONFIG_FUTEX=n. Test 16 passes on a KASAN guest with
  CONFIG_FUTEX=n and the fix, with no report.
- Tests 11, 13 and 16 are stress tests. They found no bug.

A Spin model of the mode switches found the problem of patch 4. It is
not part of the series.

How this was developed
======================

An LLM coding assistant reviewed the mm_cid code under my direction. It
wrote all the patches, their messages and the tests, which I reviewed.
There are two exceptions. The code of patch 3 is Thomas's. Patch 6 is
Weiming Shi's, carried as he posted it. Test 16 follows the shape of his
reproducer, and takes no code from it.
A reproducer that stops failing shows that the symptom goes away. It
does not show that the fix is the one you would have written, so I ask
for a careful reading.

Based on tip sched/urgent, 006991aa8997.

Links:
- Weiming Shi, "[PATCH v3] sched/mmcid: Synchronize MM teardown with
  affinity updates":
  https://lore.kernel.org/all/20261110183809.3308868-1-bestswngs@gmail.com/
- "[PATCH] sched/mmcid: Bound the CID allocation busy wait":
  https://lore.kernel.org/all/87mrs8bhp4.ffs@fw13/
- My reply in that thread, with my variant of patch 3 and the
  reproducer:
  https://lore.kernel.org/all/bd4c03e6-7ea6-4a21-9a3e-74ea9d36fe17@efficios.com/
- Thomas's answer, which prefers the cleanup:
  https://lore.kernel.org/all/87eccossye.ffs@fw13/

Mathieu Desnoyers (16):
  sched/mmcid: Give a CID to a task that joins its mm while running
  sched/mmcid: Give no concurrency ID to user workers
  sched/mmcid: Reset stale state when the first user joins an mm
  sched/mmcid: Let a running joiner take its CID after the fixups
  sched/mmcid: Take the allowed CPUs of the first user when it joins
  selftests/rseq: Test the concurrency ID after a failed execve
  selftests/rseq: Test the concurrency ID after the last user fails
    execve
  selftests/rseq: Test the concurrency IDs across ownership mode
    switches
  selftests/rseq: Test the upper bound of the concurrency IDs
  selftests/rseq: Test affinity changes made by another process
  selftests/rseq: Test an affinity change by another process during
    execve
  selftests/rseq: Test concurrent thread creation and forced migration
  selftests/rseq: Test the concurrency IDs after the affinity is widened
  selftests/rseq: Test two race windows of the concurrency ID mode
    switches
  selftests/rseq: Test affinity changes while a task replaces or drops
    its mm
  selftests/rseq: Test the last user after an affinity change during
    execve

Weiming Shi (1):
  sched/mmcid: Synchronize MM teardown with affinity updates

 fs/exec.c                                     |   1 +
 include/linux/sched.h                         |   2 +
 kernel/exit.c                                 |   1 +
 kernel/kthread.c                              |   1 +
 kernel/sched/core.c                           | 151 +++-
 tools/testing/selftests/rseq/.gitignore       |   5 +
 tools/testing/selftests/rseq/Makefile         |   5 +-
 .../selftests/rseq/mm_cid_bound_test.c        | 441 +++++++++++
 .../rseq/mm_cid_exec_affinity_test.c          | 283 ++++++++
 .../selftests/rseq/mm_cid_execve_test.c       | 685 ++++++++++++++++++
 .../selftests/rseq/mm_cid_teardown_test.c     | 396 ++++++++++
 .../selftests/rseq/mm_cid_transition_test.c   | 511 +++++++++++++
 .../selftests/rseq/mm_cid_window_test.c       | 485 +++++++++++++
 13 files changed, 2942 insertions(+), 25 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/mm_cid_bound_test.c
 create mode 100644 tools/testing/selftests/rseq/mm_cid_exec_affinity_test.c
 create mode 100644 tools/testing/selftests/rseq/mm_cid_execve_test.c
 create mode 100644 tools/testing/selftests/rseq/mm_cid_teardown_test.c
 create mode 100644 tools/testing/selftests/rseq/mm_cid_transition_test.c
 create mode 100644 tools/testing/selftests/rseq/mm_cid_window_test.c


base-commit: 006991aa89974378ee579416dba87adc22cd60fd
-- 
2.47.3

