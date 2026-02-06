Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BE5364E83;
	Fri,  6 Feb 2026 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770396695; cv=none; b=hFZoIMx/o0IMqrgkHhto7g1+FtbHK/UFnIxXAMFpEO95xVXAwlC5yfKelREncINCdt3wN7XBPQr1eN6eU4J+V6+GxQpnGIGr4YzDyclI1kxpl45bvy7tcvFVAdnAhFvb4vCmnNxYubDPA1rTmHg91vfz33X6b+w0ynx51O5ldUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770396695; c=relaxed/simple;
	bh=TLYzkC+NaeIUfbeK9L18U6Dk3UIrgSL7K8ZjrX1nFEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTVg1/LDCT38zaxyJ3hMqrOOY1DcZjq1II+lGDGiILcoyOKfxNXYEOB9PYVvRwKh/trt8XbpXJsqGtjJPP/LD9yPtlQZWzeHVJgvVNPnwh66hOCVUYLdzWSfhY7i4WR69GYYTo9ejFyPA0Ido7DMXtdBxnTW9eQYhNPgaKjLnck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhnZXGv+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhnZXGv+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B16CC2BC86;
	Fri,  6 Feb 2026 16:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770396694;
	bh=TLYzkC+NaeIUfbeK9L18U6Dk3UIrgSL7K8ZjrX1nFEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UhnZXGv+wgurYA+GGnM+Fp1qF6+yQujKDtEHI+//XgNBfUdBmdMf5BKpIiYQW1imI
	 1likJyOdJFvRfTZ54zDfBOIaesYmSpA9UaHgvEpYarlZwEnfomye3I9CNlGCPARsou
	 yx2ntOfj7NOmyxeZiJf0KbgBOzUr+UKPAKNzqJRiyY+tQfHSjKaVqCfEm6DhQ+qI8j
	 DJFN6RHRBDxVHhwDNN3E1A9JYmB/mldALct0UKrKl0sf52fU/zsuvmpi0meIKcYk3q
	 KHZYzcGJgSYiypmDHvSKoczIJ3oBsImMVCfDPGx5ZQ+VOPNNmgwVg07emlMfGPxpHW
	 C0WCKAlr4KylQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 07/12 for v7.0] vfs minix
Date: Fri,  6 Feb 2026 17:50:03 +0100
Message-ID: <20260206-vfs-minix-v70-94555c213288@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206-vfs-v70-7df0b750d594@brauner>
References: <20260206-vfs-v70-7df0b750d594@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1633; i=brauner@kernel.org; h=from:subject:message-id; bh=TLYzkC+NaeIUfbeK9L18U6Dk3UIrgSL7K8ZjrX1nFEg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS2Se9KslfLur1n1xEttXqLU0cDTuer7J/xa/+7XeyT8 13YGetvdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyEdzfD/whLVVGDF5v1Fi07 szdl3eqTLvmvAyoZzZ9Fq+dNXPnGZTbD/6gezcIDztlx1tOUHnrZnj2ctYb197QN5784xgg4LLP VYAAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains minix changes for this cycle.

Add required sanity checking to minix_check_superblock() The minix
filesystem driver does not validate several superblock fields before
using them during mount, allowing a crafted filesystem image to trigger
out-of-bounds accesses (reported by syzbot).

Consolidate and strengthen superblock validation in
minix_check_superblock().

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

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.minix

for you to fetch changes up to 8c97a6ddc95690a938ded44b4e3202f03f15078c:

  minix: Add required sanity checking to minix_check_superblock() (2026-01-19 12:16:06 +0100)

----------------------------------------------------------------
vfs-7.0-rc1.minix

Please consider pulling these changes from the signed vfs-7.0-rc1.minix tag.

Thanks!
Christian

----------------------------------------------------------------
Jori Koolstra (1):
      minix: Add required sanity checking to minix_check_superblock()

 fs/minix/inode.c | 50 +++++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 21 deletions(-)
