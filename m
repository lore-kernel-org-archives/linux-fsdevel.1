Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7588B21D590;
	Tue, 14 Apr 2026 12:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776170829; cv=none; b=emO3MBHjL0Ld7hci2YfcAI3eKJ4YLD7IkyP/B++Qe4L+3xQDuk1Bg6f6MWwtuGaskFMLo6O/3jAr48WB8RQnxO/Nbptneq2u3LHTlbL6EMS1vIYmxepuphxDk3KIGZ9ElWg7Pq3muYeP0KMeDTCMMYBWivmjU6tOMJ1iGXqtXro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776170829; c=relaxed/simple;
	bh=oavQCFlhBvhaXTjOq8I2CKUL1hZ7l8Gr2Qin7BB0+hY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCyB88KhEHhv5FOVtQ4kQqdsXQlscIYO7lFUIq6PYIqIrjBPLSz7ODI0wYO1lZ4NLqf0zWX1fUGtyCYOoIkoaWq0JjE1Wm1ltgyWydhZe7KwcdJz3ATMrVh3pQYCz0WHH+tj7AnfZvD5F2DRsr0MblaxWauIv2H5Sc1+2EJUxa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTW1jX/0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTW1jX/0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77EDC19425;
	Tue, 14 Apr 2026 12:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776170829;
	bh=oavQCFlhBvhaXTjOq8I2CKUL1hZ7l8Gr2Qin7BB0+hY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bTW1jX/0EMRkHfHH4RwpgVSXN7m/knvUt1Dh9S+EW2+1yQIDpqjPKdOP9ZRnDZqi9
	 vqPRKmm6TXeSfv984iBzoK9LoaP7R1AlGw4GO/BOFk8wSgENUCJ4WKgJUTil9QJkip
	 7YLZQbxn3O2X0uMZ3//mSDmK/WpqoRpyHnGr3HD3s4doGZ1vJ+4NVqCfXVzUpoZEm0
	 xW8F4ia/LU3faPsYshf/GICnOALp4VTlCG3wwwCNWwejhwEaRARWdcFVsZ6VcLoanI
	 oQrLFmnEi2XRVoWJfhhdLU5Y3qfiV8qgxIgQNxfC2ZpqVtM3k3TEPMBnLHNLJ6gphG
	 3cMCQbfbKY7zg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v7.1] kernel misc
Date: Tue, 14 Apr 2026 14:46:36 +0200
Message-ID: <20260414-kernel-misc-v71-d07943689d03@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260410-vfs-v71-b055f260060c@brauner>
References: <20260410-vfs-v71-b055f260060c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3201; i=brauner@kernel.org; h=from:subject:message-id; bh=oavQCFlhBvhaXTjOq8I2CKUL1hZ7l8Gr2Qin7BB0+hY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTeMzfsD71489nMWuuLrS09sez1cme8qtReO/+Weth6Y vUa69NWHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOZsJXhvw+fqWniEstNvCdn vTw649Keq9XlPporJr4K8zc4yXu/8DMjw+Lp1Vx3emuKgjv2diakWQS1HLsvNGEe85U6G+8szov JzAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

Features

- pid_namespace: make init creation more flexible

  Annotate ->child_reaper accesses with {READ,WRITE}_ONCE() to protect
  the unlocked readers from cpu/compiler reordering, and enforce that
  pid 1 in a pid namespace is always the first allocated pid (the
  set_tid path already required this).

  On top of that, allow opening pid_for_children before the pid
  namespace init has been created. This lets one process create the
  pid namespace and a different process create the init via setns(),
  which makes clone3(set_tid) usable in all cases evenly and is
  particularly useful to CRIU when restoring nested containers.

  A new selftest covers both the basic create-pidns-then-init flow and
  the cross-process variant, and a MAINTAINERS entry for the pid
  namespace code is added.

Cleanups

- signal: update outdated comment for the removed freezable_schedule()

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

No known conflicts.

The following changes since commit 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681:

  Linux 7.0-rc3 (2026-03-08 16:56:54 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/kernel-7.1-rc1.misc

for you to fetch changes up to 4c68d150246d7e1d826a807a82e6eb6b4669f42c:

  signal: update outdated comment for removed freezable_schedule() (2026-03-23 16:38:31 +0100)

----------------------------------------------------------------
kernel-7.1-rc1.misc

Please consider pulling these changes from the signed kernel-7.1-rc1.misc tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "pid_namespace: make init creation more flexible"

Kexin Sun (1):
      signal: update outdated comment for removed freezable_schedule()

Pavel Tikhomirov (5):
      pid_namespace: avoid optimization of accesses to ->child_reaper
      pid: check init is created first after idr alloc
      pid_namespace: allow opening pid_for_children before init was created
      selftests: Add tests for creating pidns init via setns
      MAINTAINERS: add a pid namespace entry

 MAINTAINERS                                        |  11 +-
 kernel/exit.c                                      |   3 +-
 kernel/fork.c                                      |   5 +-
 kernel/pid.c                                       |  19 +-
 kernel/pid_namespace.c                             |   9 -
 kernel/signal.c                                    |   5 +-
 tools/testing/selftests/pid_namespace/.gitignore   |   1 +
 tools/testing/selftests/pid_namespace/Makefile     |   2 +-
 .../selftests/pid_namespace/pidns_init_via_setns.c | 238 +++++++++++++++++++++
 9 files changed, 269 insertions(+), 24 deletions(-)
 create mode 100644 tools/testing/selftests/pid_namespace/pidns_init_via_setns.c
