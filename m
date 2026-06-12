Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755AD33F399;
	Fri, 12 Jun 2026 15:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781277189; cv=none; b=buK6PzWfJk+/xCE4/US2yJV8rc0Ax3Kr3Sz/4rB5EI8B6KvgnXhlTaGbJhjRMskB5mGtfiwEtyS+sw9sePJWOmBmxgsy4yFgBwN1ybDUFcaLi6mgzw+m4WOlCEABgIemc8xH+q+dCkKJH0HxHTaD9GpvQe5rQlLoAhRVEqIuePQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781277189; c=relaxed/simple;
	bh=9YJgUbKOZKoXER6EcpxStUVal32IUnLQPi/ZzrlHp04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TA8fIsUC6kOsQoxszzofTNY9do+nI6m5UZxMQyxaiVjAtYq5gQkL62b7KPl9rzuR5s1yGZEULn2YNBQWI7oq0h0NLoHztbWVXcgRyiYrz2jfEysxIoVMXf+zY/BBpPLtudycZXwKLbxXrlW0mDp3uX4iqIB8TO7l0ddPemHhRi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ry2MRqKf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ry2MRqKf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F3B1F000E9;
	Fri, 12 Jun 2026 15:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781277188;
	bh=sUX2Xa6XK2ZjGoNc9RZv1Gq2EDGeCDmMjJu8p+Zi3V8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ry2MRqKf/NW7YYpVf1sU36ibrZu0bUqFSVgIgC8pJAYqnV0otSC0f5S+UAohvh1pM
	 kSDLmEyx1056f/hoYmCOWkvgBnliHdpCGRP+jnJyfS5yxvSyIvCM5B9z5RlkbWsKV3
	 +x91OIgLHbarGZXkV44asoXTubpzpDsblUUqV02EqMcNMKdnZG0YBX/xhbi1ReqhEq
	 2U09+n1QwU8XSU3aBdy60uO7EH1ZLxTsAZaYI3Q9A5QDMTUeDMGvh90YYJV4Q0Cbfd
	 CgAKsZhLNc20hdYPTgG7xY/lBr1e+LiLxVF69bU1Jnazs3OXyQ0hEuQIZz4bOKgrOY
	 x2rtYE8819+rw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 06/16 for v7.2] kernel task_exec_state
Date: Fri, 12 Jun 2026 17:13:03 +0200
Message-ID: <20260612-kernel-task_exec_state-v72-c39ca82510c0@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260612-vfs-v72-20facee87e19@brauner>
References: <20260612-vfs-v72-20facee87e19@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5247; i=brauner@kernel.org; h=from:subject:message-id; bh=9YJgUbKOZKoXER6EcpxStUVal32IUnLQPi/ZzrlHp04=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTpKDG0yf84/kGldi5bWm9izTOJ/7rNFjafOprvScpc4 jjAfyyzo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJCNQz/c+bL2L2e4+4dr3/G LHeLRKbNqgSLa70X/n+2qBTK/TjnDCPDkSnTw5Zxxv2LXjD596fUcqGfM/axXFzvGmYTv8z+qY8 8FwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This introduces a new per-task task_exec_state structure and relocates
the dumpable mode and the user namespace captured at execve() from
mm_struct onto it. It stays attached to the task for its full
lifetime.

__ptrace_may_access() and several /proc owner and visibility checks
need to consult two pieces of state for any observable task, including
zombies that have already gone through exit_mm(): the dumpable mode
and the user namespace captured at execve(). Both live on mm_struct
today, which exit_mm() clears from the task long before the task is
reaped. A reader that races with do_exit() observes task->mm == NULL
and either fails the check or falls back to init_user_ns - which
denies legitimate access to non-dumpable zombies that were running in
a nested user namespace.

mm_struct loses ->user_ns and the dumpability bits in ->flags.
MMF_DUMPABLE_BITS is reserved so the MMF_DUMP_FILTER_* layout exposed
via /proc/<pid>/coredump_filter stays stable. task->user_dumpable and
its exit_mm() snapshot are removed.

task_exec_state is the privilege domain established by an execve().
Within a thread group it is shared via refcount; across thread groups
each task has its own:

- CLONE_VM siblings (thread-group members, io_uring workers)
  refcount-share the parent's exec_state.

- Non-CLONE_VM clones (fork(), vfork() without CLONE_VM) allocate a
  fresh exec_state inheriting the parent's dumpable mode and user_ns.

- execve() in the child allocates a fresh instance and installs it
  under task_lock + exec_update_lock via task_exec_state_replace().

- Credential changes (setresuid, capset, ...) and
  prctl(PR_SET_DUMPABLE) update dumpability on the current task's
  exec_state, i.e., on the thread group's shared instance.

On top of this exec_mmap() no longer tears down the old mm while
holding exec_update_lock for writing and cred_guard_mutex. Neither
lock is needed for that: exec_update_lock only exists to make the mm
swap atomic with the later commit_creds() and all its readers operate
on the new mm; none looks at the detached old mm. The cost was real:
__mmput() runs exit_mmap() over the entire old address space and can
block in exit_aio() waiting for in-flight AIO, so execve() of a large
process blocked ptrace_attach() and every exec_update_lock reader for
the duration of the teardown. The old mm is now stashed in
bprm->old_mm and released from setup_new_exec() after both locks are
dropped, with a backstop in free_bprm() for the error paths.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

The following changes since commit 5200f5f493f79f14bbdc349e402a40dfb32f23c8:

  Linux 7.1-rc4 (2026-05-17 13:59:58 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/kernel-7.2-rc1.task_exec_state

for you to fetch changes up to 38205ecbe6b6dc47968ad4e9c978e2117720969e:

  exec: free the old mm outside the exec locks (2026-05-26 11:02:02 +0200)

----------------------------------------------------------------
kernel-7.2-rc1.task_exec_state

Please consider pulling these changes from the signed kernel-7.2-rc1.task_exec_state tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (2):
      Merge patch series "exec: introduce task_exec_state for exec-time metadata"
      exec: free the old mm outside the exec locks

Christian Brauner (Amutable) (4):
      sched/coredump: introduce enum task_dumpable
      exec: introduce struct task_exec_state
      ptrace: add ptracer_access_allowed()
      exec_state: relocate dumpable information

 arch/arm64/kernel/mte.c          |   6 +-
 drivers/firmware/efi/efi.c       |   1 -
 fs/coredump.c                    |  22 +++-----
 fs/exec.c                        |  65 +++++++++++++--------
 fs/pidfs.c                       |  23 +++-----
 fs/proc/base.c                   |  39 ++++++-------
 include/linux/binfmts.h          |   3 +
 include/linux/coredump.h         |   4 ++
 include/linux/mm_types.h         |   9 ++-
 include/linux/ptrace.h           |   1 +
 include/linux/sched.h            |   6 +-
 include/linux/sched/coredump.h   |  47 ++++------------
 include/linux/sched/exec_state.h |  31 ++++++++++
 init/init_task.c                 |  10 ++++
 kernel/Makefile                  |   2 +-
 kernel/cred.c                    |   3 +-
 kernel/exec_state.c              | 119 +++++++++++++++++++++++++++++++++++++++
 kernel/exit.c                    |   1 -
 kernel/fork.c                    |  33 +++++++++--
 kernel/kthread.c                 |   1 -
 kernel/ptrace.c                  |  51 +++++++++++------
 kernel/sys.c                     |   6 +-
 mm/init-mm.c                     |   1 -
 23 files changed, 329 insertions(+), 155 deletions(-)
 create mode 100644 include/linux/sched/exec_state.h
 create mode 100644 kernel/exec_state.c
