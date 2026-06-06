Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C562F2264D6;
	Sat,  6 Jun 2026 13:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780751874; cv=none; b=Inf+GzcYtvXUVa/JP4yKe7iw9osq+7ULidilOzirNfAgaG6MYgGpWVS3wTufS3Tn7JADf3S0VpeMrcZFBOpCBrNhdRkfe3kSbZT3+JpF/LRwg8gzMThSrLv2U9Vc6tSheGVzuE8+cCEPNmjMNpPpRFZxZSBCV49kMGPYtCtympg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780751874; c=relaxed/simple;
	bh=VSB9IsRB5kKZxJeWZCcsQQTgQheQPyXxHbM3NlDS7Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bIbMhby2Z33I2urQzOqySJMV20Nz8P5vnpst+4A3a9FbV788sQ8V5fZPjF0f5LqhwRyJRs3RJg2YbtAj7V/nsmP9cKEVaWPpHJclevpn56ePgLp0d5/WgCsjqrDfELyayjBIn8eQKSpag/XgjIcZ5TX9h8vGj3skQ8zPNxCKEno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQjcEdNp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQjcEdNp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFBF1F00893;
	Sat,  6 Jun 2026 13:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780751873;
	bh=zpgFHI525t2s+oyOyaQ3ZIzzWjAc+EX5jl7KlqshlXM=;
	h=From:To:Cc:Subject:Date;
	b=YQjcEdNp4EbyLQmP4z5YlE+HxwPXZuGF4qSVEpn7gyy7eJdypH5Q5vjdmJ9R7sNvY
	 H1KG91E1HyTKs+P5MGs7Nr//MQ6A14MLmxqDRB1SMxhfjeQM3ZLNIZbHutp4Blf140
	 JUZd+xXGVnQ/dSCvNluTCb9mPKqkewO1hxGJskgwOOIdRSviyp3MnRqNv2CMHBgki7
	 EJ+saApPJZoDdwQF5XWgwzoDG3SVNiLJpgSmDe3uRie7DK0OCSxfj52CRVTOVU4is3
	 PhXRUv2NVkfEfnhvEvfKVzATbMoFfKoeJYVSJN4NVFReEa6dVoUAdDovvjZGE9k5A+
	 7QMv6WD807wyg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v7.1] vfs fixes
Date: Sat,  6 Jun 2026 15:17:34 +0200
Message-ID: <20260606-vfs-fixes-v7.1-rc7-29c54fc0070e@brauner>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3154; i=brauner@kernel.org; h=from:subject:message-id; bh=VSB9IsRB5kKZxJeWZCcsQQTgQheQPyXxHbM3NlDS7Hc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSpyP5M2/t/x+xFacbr6hY3ha5aw1fQI/X7UPXS8waSd 6YkTF/u3VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR8HWMDC9C+ve83yASe0H+ tmnE9PhtCffeN8RpqdiI7Pv9SJblTDjD/xKlRbyWS+cJL8w3nMDZt1Ryfm/mjtSH2YmS7Ht0O6d VcgIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains a fixes for the current development cycle:

- Fix error handling in ovl_cache_get().

- Tighten access checks for exited tasks in pidfd_getfd().

- Fix selftests leak in __wait_for_test().

- Limit FUSE_NOTIFY_RETRIEVE to uptodate folios.

- Reject fuse_notify() pagecache ops on directories.

- Clear JOBCTL_PENDING_MASK for caller in zap_other_threads().

- Fix failure to unlock in nfsd4_create_file().

- Fix pointer arithmetic in qnx6 directory iteration.

- Fix UAF due to unlocked ->mnt_ns read in may_decode_fh().

- Avoid potential null folio->mapping deref during iomap error reporting.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 8a220d1c312c66194f4a33dd52d1fba42bc2b341:

  cachefiles: Fix error return when vfs_mkdir() fails (2026-05-15 15:32:43 +0200)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc7.fixes

for you to fetch changes up to 2eea7f44b9c8b42fd7d3a1a87c06a7cd1b99c327:

  iomap: avoid potential null folio->mapping deref during error reporting (2026-06-04 10:02:56 +0200)

----------------------------------------------------------------
vfs-7.1-rc7.fixes

Please consider pulling these changes from the signed vfs-7.1-rc7.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
Aleksandr Nogikh (1):
      signal: clear JOBCTL_PENDING_MASK for caller in zap_other_threads()

Arpith Kalaginanavoor (1):
      fs/qnx6: fix pointer arithmetic in directory iteration

Christian Brauner (1):
      pidfd: refuse access to tasks that have started exiting harder

Geliang Tang (1):
      selftests: harness: fix pidfd leak in __wait_for_test

Jann Horn (3):
      fuse: limit FUSE_NOTIFY_RETRIEVE to uptodate folios
      fuse: reject fuse_notify() pagecache ops on directories
      fhandle: fix UAF due to unlocked ->mnt_ns read in may_decode_fh()

Joanne Koong (1):
      iomap: avoid potential null folio->mapping deref during error reporting

NeilBrown (1):
      VFS: fix possible failure to unlock in nfsd4_create_file()

Nirmoy Das (1):
      ovl: keep err zero after successful ovl_cache_get()

 fs/fhandle.c                                | 16 ++++++++++++++--
 fs/fuse/dev.c                               | 13 ++++++++++++-
 fs/iomap/buffered-io.c                      | 10 +++++-----
 fs/mount.h                                  | 10 +++++++++-
 fs/namei.c                                  | 10 ++++++++++
 fs/namespace.c                              |  6 +++---
 fs/overlayfs/readdir.c                      |  7 +++----
 fs/qnx6/dir.c                               |  8 ++++----
 kernel/pid.c                                |  8 +++++---
 kernel/signal.c                             |  1 +
 tools/testing/selftests/kselftest_harness.h |  1 +
 11 files changed, 67 insertions(+), 23 deletions(-)
