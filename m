Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9BD3DE45A;
	Fri, 10 Apr 2026 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834483; cv=none; b=YvFwsj4nb5sRI0BBfUF3PnSBKLByguU9TZN8L0gn3kVEYxDF7275cnrhgN2sGgU6kqP0IBZRfQ1sLxHq7scoNHMTjlPjSp3orJUwfabjwWv6iGvRK1sSwUgpuBWQK5t42zlGTzIsvpONo0nKcAFrEkIkDM0qU3SY9SlRCkVhjT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834483; c=relaxed/simple;
	bh=V9BB4+EE5S2fRNiIi0lwtnNutslbnfd7oNA6wRwYZo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JC3YiKSy9iekOwWr+xhIj3upx9JDMoQ0ZiwoEd1jGyJLOA3SedMWr2Up5DKITeGS5aIU20Q5iaNIdFSpPB8ymspEqqoJrT985+wcjZCVOH+CDdKCr3fl1AiogqVMql3qM6k5Y4TodfFUqOi6IMu7qHClq6DrKCU66Rq1zeiDHtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrYPRZ9o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrYPRZ9o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5148BC2BC87;
	Fri, 10 Apr 2026 15:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775834482;
	bh=V9BB4+EE5S2fRNiIi0lwtnNutslbnfd7oNA6wRwYZo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XrYPRZ9oawfYz/xzpVy9e5Hhi4ustrU4OPEb9jnFaE7Ps/ztXYmClLGWrEnMCxlfj
	 /aFNdxBkHDZKf9NI8GO4iLScmeHYphBALeq620Df1pj39HjoFMACFcoDuwQaOMRmpe
	 wuhgXTgA/df1CJp5imqdZSw+SSF7QLyLbcd2KszZYnoh+ZZb+BiCOYQkDxQWjko84k
	 Rg3FPJEc7wbGu6yMoiKNuS2V5eUnBpPnEbQUncIBRQtEp1Dlfa6V36ZTDiIcMMeqgB
	 BmWFFniHRusP/Ty9FmkySJjey2Gv6xioMHPXIgCLVG0XK9Xm01mYiaRL2+iH+hxL3S
	 khG/CZtlj4Iew==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 10/12 for v7.1] vfs pidfs
Date: Fri, 10 Apr 2026 17:21:05 +0200
Message-ID: <20260410-vfs-pidfs-v71-b736f79a20b9@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260410-vfs-v71-b055f260060c@brauner>
References: <20260410-vfs-v71-b055f260060c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6750; i=brauner@kernel.org; h=from:subject:message-id; bh=V9BB4+EE5S2fRNiIi0lwtnNutslbnfd7oNA6wRwYZo8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTeFM26EftOdrHjHH1Oz4T3FpESjiY287WzkuMnPDvTv Ucs8at2RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETaIhgZTmWZ7m5ZUpCg12XF FZH2urz3mG/u8XWpblN/lIZzPF/5h+F/kvu8C8IFzbNO7zsUkqy1SYqnJTZi4dGcvC0y1Y2Nj+K YAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

Add three new clone3() flags for pidfd-based process lifecycle
management.

=== CLONE_AUTOREAP ===

CLONE_AUTOREAP makes a child process auto-reap on exit without ever
becoming a zombie. This is a per-process property in contrast to the
existing auto-reap mechanism via SA_NOCLDWAIT or SIG_IGN for SIGCHLD
which applies to all children of a given parent.

Currently the only way to automatically reap children is to set
SA_NOCLDWAIT or SIG_IGN on SIGCHLD. This is a parent-scoped property
affecting all children which makes it unsuitable for libraries or
applications that need selective auto-reaping of specific children
while still being able to wait() on others.

CLONE_AUTOREAP stores an autoreap flag in the child's signal_struct.
When the child exits do_notify_parent() checks this flag and causes
exit_notify() to transition the task directly to EXIT_DEAD. Since the
flag lives on the child it survives reparenting: if the original
parent exits and the child is reparented to a subreaper or init the
child still auto-reaps when it eventually exits. This is cleaner than
forcing the subreaper to get SIGCHLD and then reaping it. If the
parent doesn't care the subreaper won't care. If there's a subreaper
that would care it would be easy enough to add a prctl() that either
just turns back on SIGCHLD and turns off auto-reaping or a prctl()
that just notifies the subreaper whenever a child is reparented to it.

CLONE_AUTOREAP can be combined with CLONE_PIDFD to allow the parent to
monitor the child's exit via poll() and retrieve exit status via
PIDFD_GET_INFO. Without CLONE_PIDFD it provides a fire-and-forget
pattern. No exit signal is delivered so exit_signal must be zero.
CLONE_THREAD and CLONE_PARENT are rejected: CLONE_THREAD because
autoreap is a process-level property, and CLONE_PARENT because an
autoreap child reparented via CLONE_PARENT could become an invisible
zombie under a parent that never calls wait().

The flag is not inherited by the autoreap process's own children. Each
child that should be autoreaped must be explicitly created with
CLONE_AUTOREAP.

=== CLONE_NNP ===

CLONE_NNP sets no_new_privs on the child at clone time. Unlike
prctl(PR_SET_NO_NEW_PRIVS) which a process sets on itself, CLONE_NNP
allows the parent to impose no_new_privs on the child at creation
without affecting the parent's own privileges. CLONE_THREAD is
rejected because threads share credentials. CLONE_NNP is useful on its
own for any spawn-and-sandbox pattern but was specifically introduced
to enable unprivileged usage of CLONE_PIDFD_AUTOKILL.

=== CLONE_PIDFD_AUTOKILL ===

This flag ties a child's lifetime to the pidfd returned from clone3().
When the last reference to the struct file created by clone3() is
closed the kernel sends SIGKILL to the child. A pidfd obtained via
pidfd_open() for the same process does not keep the child alive and
does not trigger autokill - only the specific struct file from
clone3() has this property. This is useful for container runtimes,
service managers, and sandboxed subprocess execution - any scenario
where the child must die if the parent crashes or abandons the pidfd
or just wants a throwaway helper process.

CLONE_PIDFD_AUTOKILL requires both CLONE_PIDFD and CLONE_AUTOREAP. It
requires CLONE_PIDFD because the whole point is tying the child's
lifetime to the pidfd. It requires CLONE_AUTOREAP because a killed
child with no one to reap it would become a zombie - the primary use
case is the parent crashing or abandoning the pidfd so no one is
around to call waitpid(). CLONE_THREAD is rejected because autokill
targets a process not a thread.

If CLONE_NNP is specified together with CLONE_PIDFD_AUTOKILL an
unprivileged user may spawn a process that is autokilled. The child
cannot escalate privileges via setuid/setgid exec after being spawned.
If CLONE_PIDFD_AUTOKILL is specified without CLONE_NNP the caller must
have have CAP_SYS_ADMIN in its user namespace.

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

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc1.pidfs

for you to fetch changes up to d29eb5f0ce674cfe71b93f8ff67dc0f66e6a9371:

  Merge patch series "pidfds: add coredump_code field to pidfd_info" (2026-03-23 16:29:22 +0100)

----------------------------------------------------------------
vfs-7.1-rc1.pidfs

Please consider pulling these changes from the signed vfs-7.1-rc1.pidfs tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (8):
      clone: add CLONE_AUTOREAP
      clone: add CLONE_NNP
      pidfd: add CLONE_PIDFD_AUTOKILL
      selftests/pidfd: add CLONE_AUTOREAP tests
      selftests/pidfd: add CLONE_NNP tests
      selftests/pidfd: add CLONE_PIDFD_AUTOKILL tests
      Merge patch series "pidfd: add CLONE_AUTOREAP, CLONE_NNP, and CLONE_PIDFD_AUTOKILL"
      Merge patch series "pidfds: add coredump_code field to pidfd_info"

Emanuele Rocca (3):
      kselftest/coredump: reintroduce null pointer dereference
      pidfds: add coredump_code field to pidfd_info
      selftests: check pidfd_info->coredump_code correctness

 fs/pidfs.c                                         |  50 +-
 include/linux/sched/signal.h                       |   1 +
 include/uapi/linux/pidfd.h                         |   5 +
 include/uapi/linux/sched.h                         |   7 +-
 kernel/fork.c                                      |  52 +-
 kernel/ptrace.c                                    |   3 +-
 kernel/signal.c                                    |   4 +
 .../coredump/coredump_socket_protocol_test.c       |  26 +
 .../selftests/coredump/coredump_socket_test.c      |  32 +
 .../selftests/coredump/coredump_test_helpers.c     |   6 +-
 tools/testing/selftests/pidfd/.gitignore           |   1 +
 tools/testing/selftests/pidfd/Makefile             |   2 +-
 tools/testing/selftests/pidfd/pidfd.h              |   5 +
 .../testing/selftests/pidfd/pidfd_autoreap_test.c  | 900 +++++++++++++++++++++
 tools/testing/selftests/pidfd/pidfd_info_test.c    |   1 +
 15 files changed, 1075 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/selftests/pidfd/pidfd_autoreap_test.c
