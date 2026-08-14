Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C9D45C701;
	Fri, 14 Aug 2026 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786713270; cv=none; b=R2aTmsUKSB9zSOri4eUbLpkZ7yqtakIBtVJe1wWyeDjYWTl8pTRzkka0OJ8gGxVL71h22rrzFs9HtbgvfO5Ft3FoGxc/N4hvjATswDi9sAT8Zwwnzs7FpShDgImNDny+7StM8QkVGNe5ozr246buXsmcV9FRqrsmje+6/g3C3Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786713270; c=relaxed/simple;
	bh=UdIGUVj6/ieFTVccQY08c+PgXcOzfeAp2Em7T2UrWEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acopSsrxxMHb5r5X+5/XC9QnLYQsXL++PolhZYLlufzOP8Uxs7f3t5csbQn0QDuTmH5O+T/3+8ptlGZmfSbALzXs2Un6ODxZkFg+R9z3x2BiroVuRdvY22nF4jwa0OCmAexz2XVoxhu63LyvcyB7p0MH7Avp8Kh+/RsGq3NPDPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3BY6T5H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3BY6T5H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0851F00A3A;
	Fri, 14 Aug 2026 13:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786713267;
	bh=sk/gCX53xF1NyZ5JzJ+ZARBVBcxaSESoiJEGS5bp2JU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E3BY6T5HedmHf41h2xAaWH+B3yDvLlQlhkEWKsv/nLolzoKlipqZ4gsRH+GutE8GS
	 gNlYNxEvga3LNOH2zaTDtAe09WUWl+CCpNy5W5xoeKHG9PABrZCgoyMkm53uf+/Lsn
	 D1p/Q/Jh6OreaS/jCzEKhBdVkzctUx02y+94RQ5rtvFiB7KcYknlwdOb1ceelKPS7B
	 Zep3SyDiVVVgDd1GvznWuWkSq5bn677RY5qnMFnqTRHceVbvs/7esha1aoadFZiLud
	 ntdrFR3aA3URMzId/a8hnUId9F9NKnNqrpUmGJA+0AkGz8bfsN90A0pQ4j2pmPQmSC
	 uE4f6boHcixKg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 15/18 for v7.3] vfs nilfs2
Date: Fri, 14 Aug 2026 15:14:19 +0200
Message-ID: <20260814-vfs-7.3-rc1.nilfs2-f036b3577823@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814-vfs-v73-6e884cb31ac9@brauner>
References: <20260814-vfs-v73-6e884cb31ac9@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1698; i=brauner@kernel.org; h=from:subject:message-id; bh=UdIGUVj6/ieFTVccQY08c+PgXcOzfeAp2Em7T2UrWEg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTVi6zjVQwvO8rvGLtjod4D/w+SDnO0+vMerA8p6JnY9 pA18dDujlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIns2sjIsONUGNuiHc8/hC0w ZnmxU1JGIZzxpm/Pu9q2uEMmDdNy1Rj+WR3csLBorTRvyoIwMfcVHkcSpz1UYLqR++rVT1O3yuw 9TAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This converts nilfs2 O_DIRECT reads to iomap and removes its use of
blockdev_direct_IO().

/* Testing */

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 1590cf0329716306e948a8fc29f1d3ee87d3989f:

  Linux 7.2-rc4 (2026-07-19 13:54:41 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.nilfs2

for you to fetch changes up to d5c57d9bf03516d625521cd6cf5acfd93e3e63c7:

  Merge patch series "nilfs2: convert O_DIRECT reads to iomap" (2026-07-27 11:43:15 +0200)

----------------------------------------------------------------
vfs-7.3-rc1.nilfs2

Please consider pulling these changes from the signed vfs-7.3-rc1.nilfs2 tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "nilfs2: convert O_DIRECT reads to iomap"

Viacheslav Dubeyko (2):
      nilfs2: add iomap operations for direct I/O reads
      nilfs2: switch O_DIRECT reads to iomap

 fs/nilfs2/Kconfig  |  2 +-
 fs/nilfs2/Makefile |  2 +-
 fs/nilfs2/file.c   | 40 +++++++++++++++++++++++++++---
 fs/nilfs2/inode.c  | 13 ----------
 fs/nilfs2/iomap.c  | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nilfs2/iomap.h  | 13 ++++++++++
 6 files changed, 123 insertions(+), 18 deletions(-)
 create mode 100644 fs/nilfs2/iomap.c
 create mode 100644 fs/nilfs2/iomap.h
