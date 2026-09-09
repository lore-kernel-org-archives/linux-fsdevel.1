Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E182952BE20;
	Wed,  9 Sep 2026 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950595; cv=none; b=aUrdy0hX5/5a3UV2bwc/WRmWCqS0VrbASqdGcuSJRktlTCn+Hd4vKXqJwGk9LzlI/AkFAT1qoTcwmO7x8yppzLXkN8zFMeaYxi3Xiri2hmwu9CZg8CgTGfE9JteWmkSOuhFHPZNBH2k3UrAVodTT01K/j/prXI7iZX7+LiMbbdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950595; c=relaxed/simple;
	bh=IFaG9oK69pGnqIWHMIJIFCAIO83YFM743Lqw1GbiJ4o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=L/bTuAY3Mp/S2yOFgmM8s9eE9uL9v5aD7dkK15T0nmX8LCTHdqE04bvpe01AhICDi1iyBP2eHyg8J6QpBcQ+E0OYYcuLCXffgjiMU1KmeM4jDfGPImZgqNa7qmSwJb6dKaz3Md72w1PY56uVGSO/YK99GxCc5t2RPjk2sRoJixg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxH1xb8i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxH1xb8i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285251F00A3A;
	Wed,  9 Sep 2026 10:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788950593;
	bh=mnkxRHXHyGgfz+c94gtF+q/a69edcwnh/cXIisA6SGk=;
	h=From:Subject:Date:To:Cc;
	b=GxH1xb8iDWJAz5zp+TA2YNvuVEFcFQWdCVqORGOFqiI6jWfQ3KOYvqI43QDULRNlV
	 O/2OM+XVJ395eh8bipZuJlGMPMSOGdkSFKZqtrSvh0Phvp5KP2GZW9sEpBkVt2tmgO
	 FhpqPjpZiTMieblq6kTFjAlcvUozUONKLHgV4HAdPirsqbhJwS4TPIpojwjCXriqQs
	 8Hw0aJIa/rHOqEU8w8Trj1VKcFk23NnsO/lQx+Did8O/9Er//+8s+zfSavr2jpubtf
	 SgehfRqVREk3BqEkLoMeq0DMed9y3DXQV3WAfBs0m9eqvsQ999X2i50os7snklIKBR
	 B2sEG0nL/QV9A==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 00/10] net: support thread-specific pidfds for send and
 connect
Date: Wed, 09 Sep 2026 12:42:59 +0200
Message-Id: <20260909-work-unix-passpidfd-v2-0-7bd342abb2d1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22OQQ6CMBBFr0K6tk1bI6Ar72FYTNsBKqYlLSCGc
 HcpGlcu3+TPy1tIxGAxkku2kICTjda7DeQhI7oF1yC1ZmMiucx5KU/06UNHR2dn2kOMvTW1obz
 MQaDmZyyBbJ99wNrOu/VWfTiO6o56SKq0UBCRqgBOt+mUpCxJ2U/K0iRNWxsHH1574SSS8htzF
 H9jJkE5LbhWtQGuCwXXDoPDB/OhIdW6rm+dmP0u9AAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3881; i=brauner@kernel.org;
 h=from:subject:message-id; bh=IFaG9oK69pGnqIWHMIJIFCAIO83YFM743Lqw1GbiJ4o=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQttLC2P+6pFFIorLvRrTz2p8rHjCVHG+YzXRQpTJju5
 vDlyTTFjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIksWMvwk1E1xNSyvC54vn/M
 /Yu3N7yNPub3s/CDk2Xdk+SAeqn6dwz/XVVuifO2MCeu+JYwodLiglZZ2ZIfScYfLhknLbONqN3
 MBgA=
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
Changes in v2:
- Fix a few documentation issues.
- Link to v1: https://patch.msgid.link/20260831-work-unix-passpidfd-v1-0-70cbfda0c7ba@kernel.org

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
 include/trace/events/landlock.h                    |   2 +-
 include/uapi/asm-generic/socket.h                  |   4 +
 net/bluetooth/af_bluetooth.c                       |   6 +-
 net/bluetooth/hci_sock.c                           |   8 +-
 net/bluetooth/l2cap_sock.c                         |   2 +-
 net/core/scm.c                                     |  36 +-
 net/core/sock.c                                    | 120 ++++---
 net/unix/af_unix.c                                 |  67 ++--
 net/unix/af_unix.h                                 |   3 +-
 tools/lib/python/kdoc/xforms_lists.py              |   1 +
 .../selftests/coredump/coredump_socket_test.c      | 175 ++++++++++
 tools/testing/selftests/coredump/coredump_test.h   |   2 +
 .../selftests/coredump/coredump_test_helpers.c     |  49 +++
 tools/testing/selftests/net/af_unix/Makefile       |   2 +
 tools/testing/selftests/net/af_unix/scm_pidfd.c    | 366 +++++++++++++++++++++
 28 files changed, 907 insertions(+), 110 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260825-work-unix-passpidfd-086a1ec09e8a

