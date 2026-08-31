Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0387F39EF0A;
	Mon, 31 Aug 2026 11:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788175288; cv=none; b=jVT8i3PRB4U4RMGfHa5tLs53KaTqdILq5AlW7BCSytMrXpjBj6ESM0giewwD+4rQp6OA9xo/VRfkWRe3KMxe6Gy77MJ+uOVj7JJD4sbN7MUW4wMQUBs+i+JoaFOW9fJzxpYcFamxBn/k+6bjedD8lqjw3rGw3uPAHNeYhPIdSPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788175288; c=relaxed/simple;
	bh=XJW+4wN639tZ0O/cHPCM0FmwkLsGrOrQ7NWSTg6T48o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UWg8UlfqIvDoEDDU+ODHslhTY8emLTCUtlLS7GHzRc5gBVGRodtX41niBkpZim4OuxlDC80MFQxHpN8I9iiG+W2wNaJYf+eSGo90QhZj1PSU9V+dUchihxhvO3CcKFfq8TTJoHdiGTx8O5a54KnEvtCbH7qF0ylhE++UqdyKjwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLHYPF8W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLHYPF8W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906701F000E9;
	Mon, 31 Aug 2026 11:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788175286;
	bh=xcRJQqkbbjssWqrS0+xsz4j8CMY2DHt3MSX34j0LBYw=;
	h=From:Subject:Date:To:Cc;
	b=BLHYPF8WGMp/1ivAuuDsr15JULQde9c3TcXvaaDb/n7h1xIlTocn8Y0F90Liaahi4
	 vOPrqOLWuI3r2hIE6ct1QvW8ar6rzIBXKyMQ5hwP7ciHe7LjHWbBhe8ArMBzQIcr+A
	 DhxGMA5OC/N1C7RSczfkAuwp84xXl9LmR9Nscq+ukftZgAK9wn/NSqesTnZqeSGA6P
	 5qCbo1PHFZ5GbulYcIIu9UYdlAVAKjqGQNN/O7aX12kzycjhZLjVmK9O0ckasB6YYY
	 Wk37kPqe/uVkPgy7gkR2f+LNLiB9SkhOQtpM8LgvivMqfoiGeVg/FNwcPWvEvT6bjJ
	 vWzlf8JpzbqRw==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 00/10] net: support thread-specific pidfds for send and
 connect
Date: Mon, 31 Aug 2026 13:21:12 +0200
Message-Id: <20260831-work-unix-passpidfd-v1-0-70cbfda0c7ba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/z3M3QrCMAyG4VsZOTalKziqtyIe9CdzUehK43Qwd
 u+2Ch6+4cuzgVBhEjh3GxR6sfCcavSHDsLk0o2QY20w2gzamiO+5/LAJfGK2YlkjmNEbQfXU9A
 nsg7qZy408vpVL9dfy+LvFJ6NagvvhNAXl8LUTg1VDVV/VLUJ7PsH/eazBqIAAAA=
X-Change-ID: 20260825-work-unix-passpidfd-086a1ec09e8a
To: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Oleg Nesterov <oleg@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=3602; i=brauner@kernel.org;
 h=from:subject:message-id; bh=XJW+4wN639tZ0O/cHPCM0FmwkLsGrOrQ7NWSTg6T48o=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRNTd7wJklr01GluYcDctYuW71yy64HNTLP3/quvbdKL
 3/bh1Id/Y5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJ8GswMlyM7734P9/x9QWp
 n9vPfXN60ORocvz6paYC9vKqeMag7+kMf6XlJWRCkxVll2kGPfppqb7HycbQ9ZBuoEvjl7SFie9
 fcwMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

SO_PASSPIDFD/SCM_PIDFD and SO_PEERPIDFD allow to retrieve a pidfd for
the thread-group leader. The coredump server using the coredump socket
cannot get a handle on the task that took the signal and is writing the
coredump easily. Workloads interested in per-thread authentification
have similar problems.

Add SO_PASSPIDFD_THREAD and SO_PEERPIDFD_THREAD. We record the sending
and the connecting thread in addition to the thread-group leader.

SO_PASSPIDFD_THREAD functions like SO_PASSPIDFD but instead of an
SCM_PIDFD message for the thread-group leader, SCM_PIDFD sends a pidfd
for the specific thread. SO_PASSPIDFD_THREAD is mutually exclusive with
SO_PASSPIDFD. The last one set takes precedence and disables the other
one. Both SO_PASSCRED and SO_PASSPIDFD receivers see one writer per
process as before.

SO_PEERPIDFD_THREAD allows to retrieve a pidfd for the specific thread
that called connect(), listen(), or socketpair().

pidfs_coredump() now also stamps the dumping thread's struct pid so a
pidfd for that thread reports the coredump like the pidfd of the
thread-group leader does.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (10):
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

 arch/alpha/include/uapi/asm/socket.h               |   4 +
 arch/mips/include/uapi/asm/socket.h                |   4 +
 arch/parisc/include/uapi/asm/socket.h              |   4 +
 arch/sparc/include/uapi/asm/socket.h               |   4 +
 fs/coredump.c                                      |  22 +-
 fs/pidfs.c                                         |  27 +-
 include/linux/coredump.h                           |   4 +-
 include/linux/pid.h                                |  53 +++
 include/linux/pid_types.h                          |   8 +
 include/linux/pidfs.h                              |   5 +
 include/linux/sched/signal.h                       |  18 +
 include/net/scm.h                                  |   7 +-
 include/net/sock.h                                 |  14 +-
 include/uapi/asm-generic/socket.h                  |   4 +
 net/bluetooth/af_bluetooth.c                       |   6 +-
 net/bluetooth/hci_sock.c                           |   8 +-
 net/bluetooth/l2cap_sock.c                         |   2 +-
 net/core/scm.c                                     |  36 +-
 net/core/sock.c                                    | 120 ++++---
 net/unix/af_unix.c                                 |  67 ++--
 net/unix/af_unix.h                                 |   3 +-
 .../selftests/coredump/coredump_socket_test.c      | 175 ++++++++++
 tools/testing/selftests/coredump/coredump_test.h   |   2 +
 .../selftests/coredump/coredump_test_helpers.c     |  49 +++
 tools/testing/selftests/net/af_unix/Makefile       |   2 +
 tools/testing/selftests/net/af_unix/scm_pidfd.c    | 366 +++++++++++++++++++++
 26 files changed, 905 insertions(+), 109 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260825-work-unix-passpidfd-086a1ec09e8a

