Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F7643F081;
	Fri, 16 Oct 2026 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145870; cv=none; b=nuPhsBFq+/lvi5+1AVo7ha9gvUg8UqVwvvkFAAVO9ilNJvQwhMDQO3jfuEqFqNQ+kjSDsYjKHCzpvz0hkR3XsTk7ECPrQVqx35EOoPllljRr+h+1kBMmYV4096UFiWkNAgvIFyNa45sMG60x1fX8HwpfrXe4QwBe277804Tv+2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145870; c=relaxed/simple;
	bh=DSV5U/CGTvXGddicdSkV8DgnBBuH5SeZkd7oku8KTEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCIbyKlSIYkUHQAelWp5sNa4C3YWH3LCQ9+Ap3xZEPWnoG+BsHm+27Wn8esUlbRXKA8z4kr6agVv2mRbzOFU68q0Rj6eG6S2mcqpOnh2I2075ILc2fUFXJiaExG1ueHWZXtX6tqNx5XgmKKPGttPrpRF6iK3v8FIVh7wMltfixk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjcAzAro; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjcAzAro"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EDE61F000C4;
	Fri, 16 Oct 2026 10:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792145868;
	bh=4GlZJfSFQCbt6wnR4CS/52kHNCF2Ud+mSKD+K+/hEN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XjcAzAroCTYAGVUB577eaCTlEzRQQ5Np0qAHLQXlS9UxXsNdsHdB1z+DyWkrV9pXe
	 RJxCUgJ/JjBjD/TSC3j8rjNSq4YSbpxWRt82cGL8CE5qSiEAbQtCy5PJOyh4mO84wl
	 cXbhtJkfzb2NEZx1otEjLO5IdYwmtyH2xnpyeojeUpDKs5ryI/1WoYqtJsy8rga/j4
	 oA6tv8i/4og8Xkx7q6xXWS/uv8NdUrm/ISXo/DPMH13GYAuS+I8Mg47k0qHMQ8dmz3
	 8Keb1V0z8oUjDTP41tsgPAdz1IjODo2DnG5FQp6nAhBNoEPlQeyxCOdxUokRI5tb+l
	 +RXeJY5T7KFWw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 07/19 for v7.4] vfs close_range
Date: Fri, 16 Oct 2026 12:17:24 +0200
Message-ID: <20261016-vfs-7.4-rc1.close_range-bfb6cb8d0f6a@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016-vfs-v74-41eaf6c4712c@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3497; i=brauner@kernel.org; h=from:subject:message-id; bh=DSV5U/CGTvXGddicdSkV8DgnBBuH5SeZkd7oku8KTEU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRd/Hmg3LD6iFjVUb0tq3t590stc+euEDzxTInR5WW3x DKWbH3tjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIncNWb477bK3/Oq/w0xzqvT W/7EpP7d/Pxn5cGsUo+5119Y11Y8vs7IcNQibdsaESPrbbdleu9fv8FR3+PhuFDh29TVj0T2Pkr jYQAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This adds two new close_range() flags.

CLOSE_RANGE_EXCEPT makes close_range() operate on all file descriptors
outside of [fd, max_fd] instead of the ones inside. Alone it closes
everything but the range. With CLOSE_RANGE_CLOEXEC it marks everything
but the range close-on-exec. With CLOSE_RANGE_UNSHARE dup_fd() never
takes a reference on what is dropped. So a task between
clone(CLONE_FILES | CLONE_VM | CLONE_VFORK) and execve() that has the
descriptors for the child in one window can shed the rest of the shared
table in one call and nothing outside of the window is referenced by
the child at any point.

CLOSE_RANGE_CLOEXEC_ONLY closes the close-on-exec descriptors in the
range and leaves everything else alone. Whatever the caller
deliberately passes down, stdio, LISTEN_FDS, an inherited pipe, stays
where it is. Combined with CLOSE_RANGE_EXCEPT it names the handful of
close-on-exec descriptors that have to survive, the executable or an
error pipe, and closes every other close-on-exec descriptor.

Along the way dup_fd() stops copying a range in the middle of the table
only to close it again. close_range(CLOSE_RANGE_UNSHARE) only avoided
the copy when the range sat at the end of the table. Descriptors in a
skipped range are never copied and no reference is taken on them, so
->flush() isn't called anymore for files from a table they were never
part of. The flags are turned into an enum and selftests cover the
window positions, the shared and the private table and the unshare
form.

/* Testing */

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit fd73f4a6659897191fa0d40695fe370925dd3780:

  Linux 7.3-rc3 (2026-09-13 14:38:02 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.close_range

for you to fetch changes up to c73c0e243836d5dfd1c617f73b6003b1ad40b2d1:

  Merge patch series "files,close_range: add CLOSE_RANGE_{CLOEXEC_ONLY,EXCEPT}" (2026-10-05 13:02:41 +0200)

----------------------------------------------------------------
vfs-7.4-rc1.close_range

Please consider pulling these changes from the signed vfs-7.4-rc1.close_range tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (11):
      file: let dup_fd() leave the punched hole behind
      selftests/core: test the hole CLOSE_RANGE_UNSHARE leaves behind
      file: rename dup_fd()'s punch_hole to range
      file: let dup_fd() drop everything outside of the range
      close_range: turn the flags into an enum
      file: add CLOSE_RANGE_EXCEPT
      selftests/core: test CLOSE_RANGE_EXCEPT
      file: let dup_fd() drop only close-on-exec descriptors
      file: add CLOSE_RANGE_CLOEXEC_ONLY
      selftests/core: test CLOSE_RANGE_CLOEXEC_ONLY
      Merge patch series "files,close_range: add CLOSE_RANGE_{CLOEXEC_ONLY,EXCEPT}"

 fs/file.c                                       | 200 ++++-
 include/linux/fdtable.h                         |   9 +
 include/uapi/linux/close_range.h                |  31 +-
 tools/testing/selftests/core/close_range_test.c | 951 ++++++++++++++++++++++++
 4 files changed, 1151 insertions(+), 40 deletions(-)
