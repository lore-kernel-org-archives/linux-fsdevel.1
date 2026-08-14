Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC38438FE4;
	Fri, 14 Aug 2026 13:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786713255; cv=none; b=n40jxaGz3WrZKhI1e42Wfjje6ai46+iyjoj7iaRB5qA82aYE6K/RRw0k/JrCtIWuGizXnXgSFIiMS4g3Ujk3Jk8LoSHvN18Xx+tQNfIC9Fu+EN/ERgI3bl3xpQe+0FJ4FQDrJdiFKnjD0tvwA2hB8sr+nYoeC7/JDdHt3aRMKOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786713255; c=relaxed/simple;
	bh=O/qe9TXTx3+qE5CR/OWD8eMU1n0o5vXLS2Juw+cs920=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RiDYGRDGE6iqV0z2JtCCx4lpqUB5EILuN+z2FMUqa7d+Ll+KTjssUEaLxehpFAtaAw1dabwAA2q/ANEazWPtnx59beOQTUu28fuwBx08g+jXekl0sbsKe87a4pm0oBkfgniZp/7zrTuVj1HSqc+qFerU6JodKnIJ1bi5uJcogY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJpKzMlM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJpKzMlM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689F61F000E9;
	Fri, 14 Aug 2026 13:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786713253;
	bh=ZOKa1XAPOXLbxa7CrvrJafcqKGBCfiigzbL8Z8cGzYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QJpKzMlMhB+zHsz8ldSMUjxTR8320ofTx8lNDplMGku8I2QVmkScwERaRCsJI8nQU
	 hrjIMFvgZbtbMu4dYfiPt84soIEKbNZ+HAWeQ4BycDPBaJtK0NPt2tfPHfDs5uI6lN
	 J9DFpLsunThEJfcfo6PLfUUt4CfwbiWP2Kh2Xa5zF5MS2uKiUjGmUqsvRPbH6sspCH
	 pC8Czz9wYJZ1xiWfZD3PcrJSvrdHbVT0FvA/tcIL48Qn4DQOBGNAfxvhRE8kwbSJJR
	 67mCXt5kTwq+mQ8+LFnI6GL0dRX/j2WZKuBtFKH5wgmP4Dmpl7YvmqG+n7fbxybGUj
	 tEAmyc9VzDS7A==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 14/18 for v7.3] vfs netfs
Date: Fri, 14 Aug 2026 15:14:05 +0200
Message-ID: <20260814-vfs-7.3-rc1.netfs-42f8f6e415b7@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814-vfs-v73-6e884cb31ac9@brauner>
References: <20260814-vfs-v73-6e884cb31ac9@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2343; i=brauner@kernel.org; h=from:subject:message-id; bh=O/qe9TXTx3+qE5CR/OWD8eMU1n0o5vXLS2Juw+cs920=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTViyyYdrh59e3IhI7zvI2FjoGTs1weLJ8+mcmGnUv87 KUjO6o0OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaSeIXhr1TeE2dbAdekpczn WG7zKV6adXOujd8iDZmNkzSqTlnfe8/IsCVCSULHVLVxn/ZsBXG9r1nPNjCuyWQMWZrN0CnHlir ICAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This sunsets cachefiles ondemand mode. It was an effort to make fscache
usable as a kernel cache for lazy pulling. EROFS over fscache was its
only in-tree user. fscache has since become netfslib-oriented while
EROFS never acts as a network filesystem and EROFS over fscache has been
removed. So this cleans up the netfs, fscache and cachefiles side as
well.

/* Testing */

No build failures or warnings were observed.

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

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.netfs

for you to fetch changes up to 949eb95d5bcc530e6ce74cc95897c1849c53ea89:

  cachefiles,netfs: sunset ondemand mode (2026-08-12 16:24:26 +0200)

----------------------------------------------------------------
vfs-7.3-rc1.netfs

Please consider pulling these changes from the signed vfs-7.3-rc1.netfs tag.

Thanks!
Christian

----------------------------------------------------------------
Gao Xiang (1):
      cachefiles,netfs: sunset ondemand mode

 Documentation/filesystems/caching/cachefiles.rst | 179 ------
 fs/cachefiles/Kconfig                            |  12 -
 fs/cachefiles/Makefile                           |   1 -
 fs/cachefiles/daemon.c                           |  96 +--
 fs/cachefiles/interface.c                        |   8 -
 fs/cachefiles/internal.h                         | 134 ----
 fs/cachefiles/io.c                               |  26 +-
 fs/cachefiles/namei.c                            |   8 -
 fs/cachefiles/ondemand.c                         | 761 -----------------------
 include/linux/netfs.h                            |   9 -
 include/trace/events/cachefiles.h                | 184 +-----
 include/uapi/linux/cachefiles.h                  |  68 --
 kernel/bpf/btf.c                                 |   7 -
 13 files changed, 9 insertions(+), 1484 deletions(-)
 delete mode 100644 fs/cachefiles/ondemand.c
 delete mode 100644 include/uapi/linux/cachefiles.h
