Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54B636494B;
	Fri, 12 Jun 2026 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781277246; cv=none; b=gfUV7NtoVxe8Zibn8DZrlivUlf1nnJr3mCeEg2noCfS0UXbQf76u9/aQZBqsKda2NWuwqYhzRh2K7Vg2HYwwcvqQdJI9YpAu4+q494PhM9DJKR82/6nDL5D4mLStD2IfNfMoLMzjKOL9vWAbSCdueVnMyZpjlsodc1ly2ldETnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781277246; c=relaxed/simple;
	bh=uHOmVsw9h5f7WFKdlxk0pH3MPAm566Cvhsx+Jx0FmgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZiNjjVMSceasWqgdmjXEIGtpy1ssrsiwvpkC/zlMHE8aU8Abe3tMplNmpq08nXCONcFyF326HBoYtyVmrfdHF77RLLM8i/DCl3C/xVqHhH9fbw6Q5TYuPT6UbivoX+Gs6z1hVa5SUDX/jNURJ0SFvlLk9ORqNA0kjzXUSKP1Mqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CD9kXGzc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CD9kXGzc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716DC1F000E9;
	Fri, 12 Jun 2026 15:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781277245;
	bh=i314j4OYLkZbCN/UBJcFURwuzq/JW7o4Fcuov1mQ8ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CD9kXGzc1LeEUzJ148pmeL4ffgCRPRAhYP+wPx8F4BlZVtX22KazvkYWIUr5atpqC
	 kkGbNcRl3cZes9u1IMjzWWo5M14+56YzNs319A8EEsMNM88mahQbbYd28BQdfsf78m
	 KKZ0h53EHY7J1Xo73r1zw39JCOmLB4qKdeiiLSOGtEtgZvjqbZAEen8LaC8bpO/sLn
	 xgeokTAl7AThj0ypOOz//DHaW1Lre/44z52vesxi69Hn1IaHxA6aqfxRu3gFylQF42
	 uMatyQkJnD1/XHelMzRDXcE+tspmQ9LXlNDsRTZN5YmkmGGzOTBzF48Gxl1iWG9XFR
	 NrbHz4cVppzkQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 09/16 for v7.2] vfs super
Date: Fri, 12 Jun 2026 17:14:00 +0200
Message-ID: <20260612-vfs-super-v72-18c8e2c8b9b2@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260612-vfs-v72-20facee87e19@brauner>
References: <20260612-vfs-v72-20facee87e19@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2103; i=brauner@kernel.org; h=from:subject:message-id; bh=uHOmVsw9h5f7WFKdlxk0pH3MPAm566Cvhsx+Jx0FmgQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTpKFlcna280+jv9LAf+z6sueeQ8rzDt6JhU4jT7aVlm x6LTmEX6ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIx+8M/zPfHNOe/qfHI0/3 tGOs9tr0OK7N7Hnz5K9/nZfAZu489yjDP5sry7ezdbPIGE5g/PG6olJe782qg53vumPZpnIqqv8 U5QIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This retires sget(). CIFS plus the two ext4 KUnit tests (extents-test,
mballoc-test) were the last in-tree callers, and all three convert
cleanly to sget_fc(). That lets sget() and its prototype come out,
taking ~60 lines that only existed to be kept in lockstep with
sget_fc() on every publish-path change.

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

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.super

for you to fetch changes up to 2c6f0c248a6b49a6fc8c301c84d367860c56ccd8:

  Merge patch series "super: retire sget()" (2026-06-03 09:09:57 +0200)

----------------------------------------------------------------
vfs-7.2-rc1.super

Please consider pulling these changes from the signed vfs-7.2-rc1.super tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (5):
      ext4: convert extents KUnit test to sget_fc()
      ext4: convert mballoc KUnit test to sget_fc()
      smb: client: convert cifs_smb3_do_mount() to sget_fc()
      fs: retire sget()
      Merge patch series "super: retire sget()"

 fs/btrfs/super.c           |  2 +-
 fs/ext4/extents-test.c     | 22 +++++++++++---
 fs/ext4/mballoc-test.c     | 17 +++++++++--
 fs/smb/client/cifsfs.c     | 43 +++++++++++++++++-----------
 fs/smb/client/cifsfs.h     |  3 +-
 fs/smb/client/cifsproto.h  |  3 +-
 fs/smb/client/connect.c    |  5 ++--
 fs/smb/client/fs_context.c |  2 +-
 fs/super.c                 | 71 ++++------------------------------------------
 include/linux/fs.h         |  4 ---
 10 files changed, 73 insertions(+), 99 deletions(-)
