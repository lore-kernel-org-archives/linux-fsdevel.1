Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F863E121D;
	Fri, 10 Apr 2026 15:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834353; cv=none; b=HauGHvhv80PDEyNq0ZYe5Aubx5pUoDUNGutmuLeKWHk/7ZYIF7DBovTw/wEAi1pL8UkpJW2D5EItznQV4SEsWYYsDq8XCx7vpJbYFaafJ/jdoUoGp+ui3gZKgBT4DURSAk7Q69Kh8zaEXMsyq5hgDO6+z3uzq4r5Wa+aGUrdqZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834353; c=relaxed/simple;
	bh=M+YVMOr5JUMFwqh3R+Pgt86GCRL+hlJY6mzvFNMIPZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROEBkRRe2wF7INl9Za0uwkoAhaObK2Y2svdiIf1VolmojfV3Z1DMkd9q14rUuxZ6vLgZzhlkoep7N3D1+b0sWZq59P2yHXIsw1QI2A3pQlChG5wbNK2Pas5RkpeevwoPXgkZ17EogsNlLFDJK02fjVnSYkp7RQFk6kvibeqSvmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nj1leYy0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nj1leYy0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719FBC2BCAF;
	Fri, 10 Apr 2026 15:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775834352;
	bh=M+YVMOr5JUMFwqh3R+Pgt86GCRL+hlJY6mzvFNMIPZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nj1leYy0ShE9MEj/fLTSM72chYSItMmZHpJ2XeLrDSQy42m983kAsq5Q0kBKcn3Po
	 6XfIF/o6S+B3ii4oKmB7QaH/Nwg/eF7U8VVynDA0Aqh0Sq3AlNvqU6bp0XH4+Asgby
	 aORRIhKz14xrvYYp0ZX3sAOviQe9hNrbhl3Bi0vM/DS08J5FOP+tqG88mSG+f9X9LH
	 Sz/jy3YAR+bFtFk9kDqz6KGoJ3/vzlX3EdQbfI+V6pgVuZp+Z3eb6tMdPY0kTgGJNb
	 aL9YR1TClsTRl1o+x9sAY29bobbcq9u3EK9F9z5S5xYGgpWIlZ1rBbkAYqoE2llC0y
	 NJanacaR/uezQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 07/12 for v7.1] vfs fat
Date: Fri, 10 Apr 2026 17:19:02 +0200
Message-ID: <20260410-vfs-fat-v71-5d175366d729@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260410-vfs-v71-b055f260060c@brauner>
References: <20260410-vfs-v71-b055f260060c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1380; i=brauner@kernel.org; h=from:subject:message-id; bh=M+YVMOr5JUMFwqh3R+Pgt86GCRL+hlJY6mzvFNMIPZw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTeFHnjkfWvVlJzWSdX578uVp+deRv7X7w4uzBpXsfbL 5lst7+86yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI8keGv4KH932t2vjphE// 1A1BaxRnpvbGbGD2CGT5ly/pVbXIwJ+R4eQXOUvOXtVK+aI/E4KMGFRSn7OuYVvyWd/88tMXMnt S2AE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains minor fixes for the fat filesystem.

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

The following changes since commit 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681:

  Linux 7.0-rc3 (2026-03-08 16:56:54 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.1-rc1.fat

for you to fetch changes up to 94505767bd32f8a240cf3590776b16a12d75d98e:

  fat: fix stack frame size warnings in KUnit tests (2026-03-26 14:36:03 +0100)

----------------------------------------------------------------
vfs-7.1-rc1.fat

Please consider pulling these changes from the signed vfs-7.1-rc1.fat tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (1):
      fat: fix stack frame size warnings in KUnit tests

avivdaum (1):
      fat: add KUnit tests for timestamp conversion helpers

 fs/fat/fat_test.c | 181 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 fs/fat/misc.c     |   2 +
 2 files changed, 175 insertions(+), 8 deletions(-)
