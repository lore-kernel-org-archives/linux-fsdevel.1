Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769EC946A;
	Fri, 12 Jun 2026 15:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781277210; cv=none; b=qdlDWGk8+6xlU7w+b96gLCnB+BG2ih7sm0vFciSfGxPRV6FiQV/Fm/bqZ32H58Gn4bxl7zN9tLEFV3Qgkz61Mo+qlyYpa9HwfTQSG4aVge1PXJGa/QrG4Efb37AmgIxTUu5E3vflcAumFf6bvAr9vtBmCn4S3wRIjjwDDwutpBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781277210; c=relaxed/simple;
	bh=Z4IjH3AwX1UOe1WtFybKKBE2WmH48jBrcKUV644rTR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0RLtNkSnk5MqpvYHw6mdDnZveW6OYK1XqLqBsUzQn0fZDkWXis9TgtuQhEahMdmW1penR6d1UopFBZgjitQMXeN0x9JJw/Lg3q9bqBy3ZQE4CR89bXreKUmdewNSGumWrjZBkfLouYjEU0lacqJavq6vF/t1qsV4qTwsnnRaHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmchhA+0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmchhA+0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35CDD1F000E9;
	Fri, 12 Jun 2026 15:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781277209;
	bh=nofTIPmiDCJ5G99GeAiPJ/ziD7Vk+00EzgB5mBEID34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BmchhA+0gyiS5tGPFfpNWcyGdLKig2ZWNMKWsRaWum3tVD5U2Ul8bHXU3xfcyBi8Q
	 xWMataKmPZw2cWkMw3+iXlAliCUC4aIpgtxjS6tVyiIi76plbXL1/BGleqchNMyB5q
	 jJwPwkn/vy/c0Di6aI5/DM+cmI2bvQCWKR72iCW3wdA0P+V+gdw9OpG8deTx32sIrY
	 V9Qc0Bpw50xYcjeYp5QYAVXDmuRbHgD8jyALzZd9uYZXIugNUkjDVLYQhXHvzB9UHf
	 ryjHfLx1FxnRlUKT90AS595xlMdXS8jtXkQpPamWeBi/Cc25pEwjO45ygJmQpAZXpi
	 kxGa1C9tZafig==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 07/16 for v7.2] kernel misc
Date: Fri, 12 Jun 2026 17:13:19 +0200
Message-ID: <20260612-kernel-misc-v72-71c9604df6a6@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260612-vfs-v72-20facee87e19@brauner>
References: <20260612-vfs-v72-20facee87e19@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3304; i=brauner@kernel.org; h=from:subject:message-id; bh=Z4IjH3AwX1UOe1WtFybKKBE2WmH48jBrcKUV644rTR4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTpKAnufcl0/pJzTmvSVD2Vf5UL7x9L5d2y7JiPfl8Ct 6nEFv3FHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPhes/I8GEyk/PGZdlFe7Ye C+O8MTf+iqDAHHefdwd5j97JnnDAUI/hf5z/P+0VwVePVTnOOCEw3Ucv8cTqN48nTmtjDq4qZfG X4gMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

Fixes

- rhashtable: give each instance its own lockdep class

  syzbot reported a circular locking dependency between ht->mutex and
  fs_reclaim via the simple_xattrs rhashtable being torn down during
  inode eviction. The predicted deadlock cannot occur:
  rhashtable_free_and_destroy() cancels the deferred worker before
  taking ht->mutex and acquisitions on distinct rhashtables are on
  distinct mutexes. Lockdep flags a cycle anyway because every
  ht->mutex in the kernel shared the single static lockdep class from
  rhashtable_init_noprof(). The lockdep key is lifted to a
  per-call-site static key so every rhashtable instance gets its own
  class.

- selftests/clone3: fix misuse of the libcap library interface in the
  cap_checkpoint_restore test and remove unused variables

- selftests/pid_namespace: compute the pid_max test limits dynamically
  instead of hardcoding values below the kernel-enforced minimum of
  PIDS_PER_CPU_MIN * num_possible_cpus() which made the tests fail on
  machines with many possible CPUs

- selftests: fix the Makefile TARGETS entry for nsfs which wasn't
  adjusted when the tests moved under filesystems/

Cleanups

- ipc/sem.c: use unsigned int for nsops to match the declaration in
  syscalls.h

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

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/kernel-7.2-rc1.misc

for you to fetch changes up to ee8ab98f831226d69d43ccd93f53c50e6f19b389:

  Merge patch series "selftests/clone3: fix cap_checkpoint_restore test" (2026-05-27 14:11:47 +0200)

----------------------------------------------------------------
kernel-7.2-rc1.misc

Please consider pulling these changes from the signed kernel-7.2-rc1.misc tag.

Thanks!
Christian

----------------------------------------------------------------
Bjoern Doebel (1):
      selftests/pid_namespace: compute pid_max test limits dynamically

Christian Brauner (2):
      rhashtable: give each instance its own lockdep class
      Merge patch series "selftests/clone3: fix cap_checkpoint_restore test"

Eva Kurchatova (1):
      selftests/clone3: fix libcap interface usage

Florian Schmaus (1):
      selftests: Fix Makefile target for nsfs

Konstantin Khorenko (1):
      selftests/clone3: remove unused variables

Yi Xie (1):
      ipc/sem.c: use unsigned int for nsops

 include/linux/rhashtable-types.h                   |  22 ++-
 ipc/sem.c                                          |   6 +-
 lib/rhashtable.c                                   |  17 ++-
 tools/testing/selftests/Makefile                   |   2 +-
 .../clone3/clone3_cap_checkpoint_restore.c         |  24 +---
 tools/testing/selftests/pid_namespace/pid_max.c    | 156 ++++++++++++++++-----
 6 files changed, 161 insertions(+), 66 deletions(-)
