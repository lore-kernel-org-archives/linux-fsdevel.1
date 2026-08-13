Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C35A495029
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786638607; cv=none; b=ijtsaobOLme6xqEIxcZ6WbcWFl3Cgy5CHWfdPdnkngHlInur9OxZQRORjZXINv4Tea7OkVIcNE/3s80R0ZnPISS1l9q8UyjEaPfMqOnXr7P0vt+pjdGi2HNXkNBD/eMiGz8aA+Jv7EtpC+AG4Xs3eOnywNdKgf1+PtQu1xULOKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786638607; c=relaxed/simple;
	bh=TvufEA+4TpROP2VByeF2Ne6kR/YAoILmteI+xZe7ZPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mhOeUDEpxTt0XhtpuIIxY+YF95q7bjO/9wXNRYFO4iY6pr6omlWigxAzOmeoW9BDbOfT+JpC9tIFlqrgl6dlBa/B4vai1c+huMQU8z07zTazqGjzl0pj+yEZfP6V80C3QfJoC2YGSWsXqcqvtR59HTWShkmlsyZ5B9dsk34alSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=Fd+bYVG3; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="Fd+bYVG3"
X-KPN-MessageId: 13e4090b-9734-11f1-83b3-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 13e4090b-9734-11f1-83b3-005056ab378f;
	Thu, 13 Aug 2026 18:28:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=ay9yRwJ1F1nl0FRA9ZelfxVFL+qHEGmYSiOEvmwFc80=;
	b=Fd+bYVG3K+Bd6e2aehMUQZmRSBL/3eQMYSOysDqtKL0CVJVdvUqrRay59Wvydjhenp4o7wolycf8d
	 1IvhKU/tgYY3daL+PX7yZQIupNgMc4bhLPQbuh7PDiCKh/vu4KvYJiM3J59J1Pmncw8m9msAMR61HD
	 1hRck1YuEMqdqulTqy9OW+174dBsF1jXIEfMfjpgYBwHzBq8Om1o3ddAZosSpxbwPwftAiwYDiifcp
	 Hg1pOB6QCBJw8HUtlxYVp0F+K1qwP5qW95EMtBvhS8V1E4nLwpW2AjGP8fZ0MzXOL8FcjnegQbUBXi
	 QX+JaUE5oampKnCIGVsE+Hv9u00p76w==
X-KPN-MID: 33|WYZGE0miuAL0ug0mYVx/LKN8ubXIwOrRme/4VGQSY/JGMdxKo+bhnTgD+NKzlhq
 dDhL2OPCwCoySAIVg+c0iPosCvjkuxVOKuLQ+KfBhHK8=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|fFntdYvrqJ43MS6tfTuu/262Ilov3JVhyX42oLa3bMHy4hwzeBqtUZiRA/tDo3L
 7oE72XRXF0Hgh+lVQ+vYpJg==
Received: from fedora (unknown [223.38.86.53])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 08cd33be-9734-11f1-a8bc-005056ab7447;
	Thu, 13 Aug 2026 18:28:53 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: brauner@kernel.org,
	cyphar@cyphar.com,
	kuniyu@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jkoolstra@xs4all.nl
Subject: [PATCH net-next v7 0/4] net: af_unix: useful handling of LSM denials on SCM_RIGHTS 
Date: Thu, 13 Aug 2026 12:28:14 -0400
Message-ID: <20260813162818.149248-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Right now if some LSM denies an AF_UNIX socket peer to receive a
SCM_RIGHTS fd, the SCM_RIGHTS fd array will be cut short at
that point, and MSG_CTRUNC is set on return of recvmsg(2). This is
highly problematic behaviour, because it leaves the receiver
wondering what happened. As per man page MSG_CTRUNC is supposed to
indicate that the control buffer was sized too short, but suddenly
a permission error might result in the exact same flag being set.
Moreover, the receiver has no chance to determine how many fds got
originally sent and how many were suppressed.[1]

Add a SO_RIGHTS_NOTRUNC option to UNIX sockets to enable more useful
handling of LSM denials when receiving SCM_RIGHTS messages: instead of
truncating the message at the first blocked fd, keep every fd slot
and store the LSM errno in the blocked slot. This option is inherited
by the accept()-ed socket when set on the listen() socket.

[1]: https://github.com/uapi-group/kernel-features#useful-handling-of-lsm-denials-on-scm_rights

Changes:
v7:
  - block first selftests did not check other slots
  - READ_ONCE() for scm_rights_notrunc field
v6:
  - Let accept()-ed sockets inherit the SO_RIGHTS_NOTRUNC option from
    the listen() socket, so that you don't need to set it for every
    child. 
v5:
  - Enable SO_RIGHTS_NOTRUNC on all AF_UNIX socket types.
  - Added required BPF CONFIG_ options to
    tools/testing/selftests/net/af_unix/config.
v4: https://lore.kernel.org/netdev/20260705123826.3818443-1-jkoolstra@xs4all.nl/
  - Removed the __receive_fd() helper and moved logic into
    scm_recv_one_fd() directly (suggested by Brauner).
  - Moved selftest from Smack to BPF (LLM assisted).
  - Add arch specific socket option values for SO_RIGHTS_NOTRUNC.
  - Undo patch that replaced copy_from_sockptr() with
    copy_safe_from_sockptr().
v3:
  - Separated net and vfs changes.
  - Use kselftest_harness.h and system() to call the test script.
v2: https://lore.kernel.org/netdev/20260616143020.3458085-2-jkoolstra@xs4all.nl/
  - Reimplemented as a UNIX socket option instead of a per recvmsg(2) flag.
v1: https://lore.kernel.org/netdev/20260428175125.2705296-1-jkoolstra@xs4all.nl/

*** BLURB HERE ***

Jori Koolstra (4):
  net: af_unix: enable custom setsockopt for all socket types
  net: scm: move scm_detach_fds() from common path to scm_recv_unix()
  net: af_unix: useful handling of LSM denials on SCM_RIGHTS
  selftest: Add tests for useful handling of LSM denials on SCM_RIGHTS

 arch/alpha/include/uapi/asm/socket.h          |   2 +
 arch/mips/include/uapi/asm/socket.h           |   2 +
 arch/parisc/include/uapi/asm/socket.h         |   2 +
 arch/sparc/include/uapi/asm/socket.h          |   2 +
 include/net/af_unix.h                         |   1 +
 include/net/scm.h                             |  13 +-
 include/uapi/asm-generic/socket.h             |   2 +
 net/compat.c                                  |   4 +-
 net/core/scm.c                                |  40 ++-
 net/unix/af_unix.c                            |  22 +-
 .../testing/selftests/net/af_unix/.gitignore  |   2 +
 tools/testing/selftests/net/af_unix/Makefile  |   8 +
 tools/testing/selftests/net/af_unix/config    |   7 +
 .../net/af_unix/scm_rights_denial_lsm.bpf.c   |  36 +++
 .../net/af_unix/scm_rights_denial_lsm.c       | 292 ++++++++++++++++++
 15 files changed, 413 insertions(+), 22 deletions(-)
 create mode 100644 tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.bpf.c
 create mode 100644 tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.c


base-commit: 3205699d79f262412c1be7fc1c04066610d3cd52
-- 
2.55.0

