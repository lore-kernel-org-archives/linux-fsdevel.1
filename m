Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35353C063F
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Aug 2026 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785683474; cv=none; b=TiROPTYl8dD7R0xqFIXvTEucFVpjlH4ACh/5tmnMvkqIlodImUrzEbqv4YfPDOcS+B94ZxVRrr3KgTG2lQsYQH4qwiesoTkYjSlLe7qJ0v0y/uFay8OKGUFV/1aGyvQ+o/4pacIKSMZvvcthbRRxzkCk2Y5b3Mq0XbivjKuHSFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785683474; c=relaxed/simple;
	bh=3m2t7slrPSaEgJU7/zweIu4e36eHJZCgVmK0ASemOi8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z5QnxSSzWaWFLvU/SD3sBd/LhQqjVaKm/IXp/hc5FOV6kNGFEWVIP5+jy7p8gzeeLQScajrHm5o5uzrDU0B4cPr2WUEobRVAe36ztwsxp5oGy1nGU58np/7O+RgovtTP3PqWSzoZhl0+niw9wr+cgv3wRlk+pqDK8B5W7GFrYQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=bGDXPHDS; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="bGDXPHDS"
X-KPN-MessageId: 5e44f50a-8e84-11f1-8f54-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 5e44f50a-8e84-11f1-8f54-005056992ed3;
	Sun, 02 Aug 2026 17:10:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=6epRzrJH1V1juOLMNG3faPmMn914y5NSPjgOS26WMuI=;
	b=bGDXPHDS+MhpqFuMGcFaUDhXOZ+3XMOUjDljTNKeV7Q+TOx2jbm61frzF9P0XM08GlUHvio4ACYcd
	 lM480Bw4PCjVoyzP0Yf9ufJms16IFkS9CL6Q9y2L2ptc21g2E9kBkxuCgBAm2YAfzK6Bdh7IBlajOb
	 Mbm7EkoQ/Ocjyvyys/uxEsIgTdRnS6WNPfNH4S1R7OFILxUFZiN76lfOzUC906DmXCMeslceIMCG9h
	 RE4sPmvHBuCXoDmrCH+q9cgNx1KJnLRX7f52T8UpQncdjhq7X3ZTK7wKtUfAIzNYV8xEJq9k6qOP9b
	 EI4d3dui4UFzVbOiJ6SWngnRkvVLO6w==
X-KPN-MID: 33|l/SzEB/wHRNH775VKVsRAuKuFPRscPHems4xEO368mBnFWs2m2bUghghivBGb5H
 w/6RS3FAWvfsQjvkmBCcbZ0xDM3mJNlTeTpBekD0Efnc=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|gwYEXoYSaPCLCYjc2imkcCtcB7OO+bPFu4AGGaVJJd9S2QJLbGd6TFVhwk8UaOV
 Bz6Nvw/T+9fSiGM+bQqYB6Q==
Received: from daedalus.home (unknown [178.231.250.148])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 5bd5cf54-8e84-11f1-8dd8-00505699d6e5;
	Sun, 02 Aug 2026 17:10:59 +0200 (CEST)
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
Subject: [PATCH net-next v6 0/4] net: af_unix: useful handling of LSM denials on SCM_RIGHTS
Date: Sun,  2 Aug 2026 17:12:08 +0200
Message-ID: <20260802151212.3294591-1-jkoolstra@xs4all.nl>
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
 .../net/af_unix/scm_rights_denial_lsm.c       | 285 ++++++++++++++++++
 15 files changed, 406 insertions(+), 22 deletions(-)
 create mode 100644 tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.bpf.c
 create mode 100644 tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.c


base-commit: 69963a0678a347d57c4ac8b16939dba216eb95ce
-- 
2.55.0

