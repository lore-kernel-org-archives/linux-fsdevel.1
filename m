Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44AE45DF67;
	Fri, 14 Aug 2026 13:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786712785; cv=none; b=LE8rI2/q8eP66+R56pS+HNgKEwHRzzJALkjhViFKsLvCWtRrxeXZBs5Oh2sbaGTpz6mBgO8BZakBFZP3BPmKl9FRvLZ67K7oVE7c0+xn2t9NjbQkNespAdcJuL4y20TMlka36xk2aeo9YzE4ELGfLX5eFXJeBTg9TpmewpLRXqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786712785; c=relaxed/simple;
	bh=l7y7BDMWXgbuF6vRJwtKQl87okL3Ze4cBnuLK/5A/QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cARJ7/bRtrkbyLM+7ueFA4RFrskN5gHPJypffE5WAIkyKoSE5Havp+gO6PX6FIf9pBSAPL/IFveXoeyvWCoxUKLHCPh3jiQEazdZ4EtgjpkdCnHRSx8LUieA+a0VubjcgRuj35mxRWyXoVLtxWtFUV2MmCbNQ1XOK4BiW8N/rlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8XBjiV9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8XBjiV9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5461F000E9;
	Fri, 14 Aug 2026 13:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786712780;
	bh=TXvaCX2jJHb+ZOOi+HZ203hKWjK0FJZ4aKtTf2sosZ8=;
	h=From:To:Cc:Subject:Date;
	b=d8XBjiV9dwr28akiV6EJLKGYQgEBm7VcN/VGEblLxRoQNnPhMjTw7VhOT+/cGQjd2
	 LSg1mL4HI0pTwzW/e7RrzuEEaLVi1pkbQ31VaSIFD/WBdI6Ia3/AWApn7QLW8d//5e
	 wEPXurXUCtO0YifTJjDJx3kg6GA0cfKliSO1TK10b0FTum21rm7wu4PrnxkVgpoK0T
	 bh5kPkrGyNv6Hc+5SS/MOoNVlxnleefP6bwZycntSxT3hHbQ4+hm0dwHkkqAp4whz/
	 FbCu3WTUvpPTd3QCUtxFEOWjBMokWxuEvcrjBke1PAxEpmnzlWBgOimiFNXAd1ta3x
	 7l1DfnGgDdE4g==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v7.2] vfs fixes
Date: Fri, 14 Aug 2026 15:05:58 +0200
Message-ID: <20260814-vfs-7.2-rc8.fixes-6d7ba75b0b43@brauner>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3128; i=brauner@kernel.org; h=from:subject:message-id; bh=l7y7BDMWXgbuF6vRJwtKQl87okL3Ze4cBnuLK/5A/QQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTVC+3nmb9128OpGkeLn8w5uyF7t53O9vY3HMnaAm6zl Jk9VjaEd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk5hKGv8KZM74snN/5Tck1 dn4839s5h8P/WP38d8R2pkdw0qGgzw8YGc642asF8zZ89bwtH7U9gkHvufcDobOqhkqrT01rWTn HlhsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains last fixes for the current development cycle:

- Don't warn when a mount is completed from another user namespace.

  fsopen() records the caller's user namespace in fc->user_ns and hands
  back an ordinary file descriptor. The task that calls
  fsconfig(FSCONFIG_CMD_CREATE) doesn't have to be the one that created
  the context, and mount_capable() lets it through as long as the caller
  has CAP_SYS_ADMIN over fc->user_ns, which anyone in an ancestor
  namespace does. So fc->user_ns != current_user_ns() is something an
  unprivileged user can arrange.

  Both overlayfs and binfmt_misc WARN_ON() that. Overlayfs already
  has the same check as a plain error return in ovl_parse_param(). Drop
  the WARN_ON() and just refuse. Add selftests for both cases.

- Reject pid allocations through dead ancestor pid namespaces.

  Require PIDNS_ADDING in every namespace that will receive the pid
  before publishing any of them. That preserves the invariant that
  free_pid() never decrements pid_allocated in a namespace whose
  child_reaper is no longer live. The existing ENOMEM behavior is
  unchanged.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit db2ddb87143519e20a95aa36c60b36107b736a58:

  Linux 7.2-rc7 (2026-08-09 14:54:50 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc8.fixes

for you to fetch changes up to b64a9f67e082e04835ddd69d422a25168d69375b:

  pid: reject allocations through dead ancestor pid namespaces (2026-08-12 12:56:30 +0200)

----------------------------------------------------------------
vfs-7.2-rc8.fixes

Please consider pulling these changes from the signed vfs-7.2-rc8.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (4):
      ovl: don't warn when the mount is completed from another user namespace
      binfmt_misc: don't warn when the mount is completed from another user namespace
      selftests/filesystems: test completing a context from another user namespace
      Merge patch series "fs: don't warn when a mount is completed from another user namespace"

Jérémy Jean (1):
      pid: reject allocations through dead ancestor pid namespaces

 fs/binfmt_misc.c                                   |   3 +-
 fs/overlayfs/super.c                               |   3 +-
 kernel/pid.c                                       |   6 +-
 tools/testing/selftests/Makefile                   |   1 +
 .../selftests/filesystems/fscontext_ns/Makefile    |  10 +
 .../filesystems/fscontext_ns/fscontext_ns_test.c   | 239 +++++++++++++++++++++
 6 files changed, 258 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/fscontext_ns/Makefile
 create mode 100644 tools/testing/selftests/filesystems/fscontext_ns/fscontext_ns_test.c
