Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A219368D7F;
	Fri, 12 Jun 2026 15:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781277155; cv=none; b=hXnp5Zo5kpOgb2EnZiIBsjgcfa9WW1dmG8dWou5+Jg8SL5wNESuDpP98NVbuO4NijVNV/i0YYxW3PEPvO5A10l+lKXj/eKLkL7cBKOrKhJqhlsKO+0mSpEKSnkOXfz6jUSjqu/vZRCFuurccPEoiHn3sHiLdijTLzBDBrc+/5QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781277155; c=relaxed/simple;
	bh=MxFYZuH58LQwkZCRVXvEx1evORUv97cp2jq60FfCArM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0tic6PnjhGBcHRXTHt4nQteNdPPzaD1v5Vu9tCdbsWgqVViQvZACoGVhM/niwDDQOpnkQxN8e4E/xz6Z3VG6xNzv29Y4Dh54pXkmNARFrcKD4c/qXObBRj9WoKZziCya9RUBdcsqJrfvNJwwljR6Sbfth4/v35be5yTF9uFf+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D684LUDf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D684LUDf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE4D1F000E9;
	Fri, 12 Jun 2026 15:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781277153;
	bh=TEzIHvGvbuhPiTPSRAQEiIK/XcLRmxZhs+OIvzkPWDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D684LUDfAwlw/4e168gDBsPnLRbBoxf29z7ufo2M7R9spl0T1U2olHFnO8NRX/1Vw
	 TMVlCGK1Vi/XYf20LriZ/z0/ep+hJrBOXeBDzbyP/XQFyUJRfUWoK9QsilH44Hd0lF
	 Tyo3hWKE2mddSeKeoJS1M7l5t/1TFauFnGmjCYfOOyLqI+KuIKe+UdhzbOj9wbceps
	 rwhJy33HKN5FTbjhUICS+hAcWNBeNtiH8Cyf2KMop/xl119hjVoesDABuS+NapbNSZ
	 2cLfgeIjeB4WgCrhAxPV17m6kKAuokzTitfgER34ZZ7cbCp6sL0f1lYmH2eC1NK3iC
	 17C+stGbLbCGw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 04/16 for v7.2] vfs directory delegations
Date: Fri, 12 Jun 2026 17:12:28 +0200
Message-ID: <20260612-vfs-directory-delegations-v72-6a98c8961ec4@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260612-vfs-v72-20facee87e19@brauner>
References: <20260612-vfs-v72-20facee87e19@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3565; i=brauner@kernel.org; h=from:subject:message-id; bh=MxFYZuH58LQwkZCRVXvEx1evORUv97cp2jq60FfCArM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTpKN6dyuml+uUry+H9kcuSS6O0j5scmf/QVLeq/kjP/ UXCSmVRHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMpi2FkWN0fEKara6Xmx6mb KzAjombSothzDxICJ14LrbaySQ+IY2RYmir7VPhqws3rSg6LC+9L3v4wI2vrjcmzxeafW5Ghd24 PHwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains the VFS prerequisites for supporting directory
delegations in nfsd via CB_NOTIFY callbacks.

The filelock core gains support for ignoring delegation breaks for
directory change events together with an inode_lease_ignore_mask()
helper, and fsnotify gains fsnotify_modify_mark_mask() and a
FSNOTIFY_EVENT_RENAME data type. With this in place nfsd can request
delegations on directories and set up inotify watches to trigger
sending CB_NOTIFY events to clients instead of having every directory
change break the delegation. New tracepoints are added to fsnotify()
and to the start of break_lease(), and trace_break_lease_block() is
passed the currently blocking lease instead of the new one.

A follow-up fix moves the LEASE_BREAK_* flags out of
#ifdef CONFIG_FILE_LOCKING to fix the build for CONFIG_FILE_LOCKING=n
configurations.

Note that the nfsd tree is based on a merge of this branch so these
changes may also reach you through the nfsd pull request.

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

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.directory.delegations

for you to fetch changes up to 246bc86d0fd891273a8502314f158eab23af823c:

  filelock: move LEASE_BREAK_* flags out of #ifdef CONFIG_FILE_LOCKING (2026-05-16 17:05:52 +0200)

----------------------------------------------------------------
vfs-7.2-rc1.directory.delegations

Please consider pulling these changes from the signed vfs-7.2-rc1.directory.delegations tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "VFS changes for nfsd CB_NOTIFY callbacks in directory delegations"

Jeff Layton (8):
      filelock: pass current blocking lease to trace_break_lease_block() rather than "new_fl"
      filelock: add support for ignoring deleg breaks for dir change events
      filelock: add a tracepoint to start of break_lease()
      filelock: add an inode_lease_ignore_mask helper
      fsnotify: new tracepoint in fsnotify()
      fsnotify: add fsnotify_modify_mark_mask()
      fsnotify: add FSNOTIFY_EVENT_RENAME data type
      filelock: move LEASE_BREAK_* flags out of #ifdef CONFIG_FILE_LOCKING

 fs/attr.c                        |   2 +-
 fs/locks.c                       | 118 ++++++++++++++++++++++++++++++---------
 fs/namei.c                       |  31 +++++-----
 fs/notify/fsnotify.c             |   5 ++
 fs/notify/mark.c                 |  29 ++++++++++
 fs/posix_acl.c                   |   4 +-
 fs/xattr.c                       |   4 +-
 include/linux/filelock.h         |  66 ++++++++++++++--------
 include/linux/fsnotify.h         |   8 ++-
 include/linux/fsnotify_backend.h |  21 +++++++
 include/trace/events/filelock.h  |  38 ++++++++++++-
 include/trace/events/fsnotify.h  |  51 +++++++++++++++++
 include/trace/misc/fsnotify.h    |  35 ++++++++++++
 13 files changed, 341 insertions(+), 71 deletions(-)
 create mode 100644 include/trace/events/fsnotify.h
 create mode 100644 include/trace/misc/fsnotify.h
